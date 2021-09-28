using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
//using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Xml.Linq;
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
using ReportBusinessLogic;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Podium.NewInstanceCreation;
using Attune.Solution.BusinessLogic_Ledger;
using Attune.Solution.BusinessLogic_InvoiceLedger;
using System.Data.OleDb;
using Attune.Podium.FileUpload;
using System.Globalization;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
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
    int AutoAuthorCheck = 0;

    static bool TryParseXml(string xml)
    {
        try
        {
            XElement xe = XElement.Parse(xml);
            return true;
        }
        catch (XmlException e)
        {
            return false;
            throw e;
        }
    }

    #region Drugs

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDrugList(string prefixText, int count)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();

        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;

        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        //  , OrgAddressID, pharmacyLocationID);
        lresutl = PrescriptionBL.GetPrescription(DrugName, 1, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);
        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].BrandName;
            }
        }

        return drugNameArray;

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPrescription(string prefixText, int count)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);


        lresutl = PrescriptionBL.GetPrescription(DrugName, 2, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);

        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].Formulation + "," + lstPrescription[i].Dose + "," + lstPrescription[i].ROA;

            }
        }

        return drugNameArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] loadDrug(string value)
    {
        string[] ss = new string[] { "ss", "gg" };
        return ss;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] loadFormulation(string prefixText, int count)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);


        //  , OrgAddressID, pharmacyLocationID);
        lresutl = PrescriptionBL.GetPrescription(DrugName, 3, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);
        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {


                drugNameArray[i] = lstPrescription[i].Formulation;
            }
        }

        return drugNameArray;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] loadDose(string prefixText, int count)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        //  , OrgAddressID, pharmacyLocationID);
        lresutl = PrescriptionBL.GetPrescription(DrugName, 4, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);

        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].Dose;
            }
        }

        return drugNameArray;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] loadROA(string prefixText, int count)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        //  , OrgAddressID, pharmacyLocationID);
        lresutl = PrescriptionBL.GetPrescription(DrugName, 5, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);

        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].ROA;
            }
        }

        return drugNameArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDose1(string Formulation)
    {

        PatientPrescription_BL PPBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = Formulation;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        lresutl = PPBL.GetPrescription(DrugName, 6, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);
        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].Dose + "," + lstPrescription[i].ROA;
            }
        }

        return drugNameArray;
    }

    #endregion


    #region InventoryDrugs

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getInvDrugList(string prefixText, int count, string contextKey)
    {
        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();

        DrugName = prefixText;
        string[] drugNameArray = null;
        long lresutl = -1;
        int locationid = 0;

        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);
        //Int64.TryParse(contextKey, out PatientVisitID);
        string[] key = contextKey.Split('~');
        PatientVisitID = Convert.ToInt64(key[0].ToString());
        locationid = Convert.ToInt32(key[1].ToString());


        lresutl = PrescriptionBL.GetPrescription(DrugName, 7, orgID, out lstPrescription, OrgAddressID, locationid, PatientVisitID);
        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].BrandName;

            }
        }

        return drugNameArray;

    }

    #endregion

    #region OldMethods

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public string[] GetDrugName(string drugName, int count)
    {

        PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = drugName;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        //, OrgAddressID, InventoryLocationID);
        lresutl = PrescriptionBL.GetPrescription(DrugName, 1, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);
        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].BrandName;
            }
        }

        return drugNameArray;

    }


    [WebMethod(EnableSession = true)]
    public string[] getDrugs(string drugName)
    {

        PatientPrescription_BL PPBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = drugName;
        string[] drugNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out OrgAddressID);
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);

        lresutl = PPBL.GetPrescription(DrugName, 2, orgID, out lstPrescription, OrgAddressID, InventoryLocationID, PatientVisitID);

        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].Formulation + "," + lstPrescription[i].Dose + "," + lstPrescription[i].ROA;
            }
        }

        return drugNameArray;
    }

    [WebMethod(EnableSession = true)]

    public string[] getDose(string Formulation, string brandName)
    {

        PatientPrescription_BL PPBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        DrugName = Formulation;
        string drug = brandName;

        string[] drugNameArray = null;
        long lresutl = -1;
        //DrugName = Formulation;
        //lresutl = PPBL.GetPrescription(DrugName, 6, out lstPrescription);
        lresutl = PPBL.GetDose(DrugName, brandName, out lstPrescription);


        if (lstPrescription.Count > 0)
        {
            drugNameArray = new string[lstPrescription.Count];
            for (int i = 0; i < lstPrescription.Count; i++)
            {
                drugNameArray[i] = lstPrescription[i].Dose + "," + lstPrescription[i].ROA;
            }
        }

        return drugNameArray;
    }
    #endregion

    #region Used in DHEBAdder

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getExamination(string prefixText, int count)
    {

        Uri_BL UBL = new Uri_BL(new BaseClass().ContextInfo);
        List<Examination> lstExamination = new List<Examination>();
        sExaminationName = prefixText;
        string[] examinationArray = null;
        long lresutl = -1;
        lresutl = UBL.GetExamination(sExaminationName, out lstExamination);
        if (lstExamination.Count > 0)
        {
            examinationArray = new string[lstExamination.Count];
            for (int i = 0; i < lstExamination.Count; i++)
            {
                examinationArray[i] = lstExamination[i].ExaminationName;
            }
        }

        return examinationArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDiagnosis(string prefixText, int count)
    {

        Uri_BL UBL = new Uri_BL(new BaseClass().ContextInfo);
        List<Complaint> lstComplaint = new List<Complaint>();
        sComplaintName = prefixText;
        string[] complainArray = null;
        long lresutl = -1;
        lresutl = UBL.GetComplaint(sComplaintName, out lstComplaint);
        if (lstComplaint.Count > 0)
        {
            complainArray = new string[lstComplaint.Count];
            for (int i = 0; i < lstComplaint.Count; i++)
            {
                complainArray[i] = lstComplaint[i].ComplaintName;
            }
        }

        return complainArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDiagnosisID(string prefixText, int count)
    {

        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<Complaint> lstComplaint = new List<Complaint>();
        sComplaintName = prefixText;
        string[] complainArray = null;
        long lresutl = -1;
        lresutl = oPatient_BL.GetComplaint(sComplaintName, out lstComplaint);
        if (lstComplaint.Count > 0)
        {
            complainArray = new string[lstComplaint.Count];
            for (int i = 0; i < lstComplaint.Count; i++)
            {
                //complainArray[i] = lstComplaint[i].ComplaintName + "~" + lstComplaint[i].ComplaintId.ToString() + "~" + lstComplaint[i].ICDCode + "~" + lstComplaint[i].ICDDescription;
                // complainArray[i] = lstComplaint[i].ComplaintName + "~" + lstComplaint[i].ICDCode + "~" + lstComplaint[i].ICDDescription;
                complainArray[i] = lstComplaint[i].ComplaintName + "~" + lstComplaint[i].ICDCode + "~" + lstComplaint[i].ICDDescription + "~" + lstComplaint[i].ComplaintId;

            }
        }

        return complainArray;
    }





    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getHistory(string prefixText, int count)
    {

        Uri_BL UBL = new Uri_BL(new BaseClass().ContextInfo);
        List<History> lstHistory = new List<History>();
        sHistoryName = prefixText;
        string[] examinationArray = null;
        long lresutl = -1;
        lresutl = UBL.GetHistory(sHistoryName, out lstHistory);
        if (lstHistory.Count > 0)
        {
            examinationArray = new string[lstHistory.Count];
            for (int i = 0; i < lstHistory.Count; i++)
            {
                examinationArray[i] = lstHistory[i].HistoryName;
            }
        }

        return examinationArray;
    }

    #endregion

    #region grpInvNames
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getgrpInvList(string prefixText, int count)
    {
        OrgId = count;

        Investigation_BL invBL = new Investigation_BL(new BaseClass().ContextInfo);
        List<InvGroupMaster> lstInvGroupMaster = new List<InvGroupMaster>();

        groupInv = prefixText;
        string[] groupNameArray = null;
        long lresutl = -1;
        lresutl = invBL.GetGrpInvList(groupInv, OrgId, 1, out lstInvGroupMaster);
        if (lstInvGroupMaster.Count > 0)
        {
            groupNameArray = new string[lstInvGroupMaster.Count];
            for (int i = 0; i < lstInvGroupMaster.Count; i++)
            {
                groupNameArray[i] = lstInvGroupMaster[i].GroupName;
            }
        }

        return groupNameArray;

    }
    #endregion

    #region IndInvNames
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getIndInvList(string prefixText, int count)
    {
        // OrgId = count;

        Investigation_BL invBL = new Investigation_BL(new BaseClass().ContextInfo);
        List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();

        IndInv = prefixText;
        string[] InvNameArray = null;
        long lresutl = -1;
        lresutl = invBL.GetIndInvList(IndInv, OrgId, 1, out lstInvestigationMaster);
        if (lstInvestigationMaster.Count > 0)
        {
            InvNameArray = new string[lstInvestigationMaster.Count];
            for (int i = 0; i < lstInvestigationMaster.Count; i++)
            {
                InvNameArray[i] = lstInvestigationMaster[i].InvestigationName;
            }
        }

        return InvNameArray;

    }
    #endregion
    /* #region ProductList
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getProductInvList(string prefixText, int count)
    {

        Inventory_BL invBL = new Inventory_BL(new BaseClass().ContextInfo);
        List<Products> lstProductList = new List<Products>();
        ProductInv = prefixText;
        string[] InvProductArray = null;
        long lresultl = -1;
        List<string> items = new List<string>();
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        lresultl = invBL.GetProductInvList(ProductInv, orgID, out lstProductList);
        if (lstProductList.Count > 0)
        {
            InvProductArray = new string[lstProductList.Count];
            for (int i = 0; i < lstProductList.Count; i++)
            {
                InvProductArray[i] = lstProductList[i].ProductName;
                string str = lstProductList[i].ProductName + "~" + lstProductList[i].Description;
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(lstProductList[i].ProductName, str));
            }
        }
        return items.ToArray();


    }
    #endregion

    #region Inventory Name list
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInventoryList(string prefixText, int count, string contextKey)
    {

        Inventory_BL invBL = new Inventory_BL(new BaseClass().ContextInfo);
        List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();
        Iname = prefixText;
        string[] InvProductArray = null;
        long lresultl = -1;
        List<string> items = new List<string>();
        int orgID = 0;
        string deviceid = Convert.ToString(contextKey);
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        lresultl = invBL.GetInventoryList(Iname, orgID, deviceid, out lstInvestigationMaster);
        if (lstInvestigationMaster.Count > 0)
        {
            InvProductArray = new string[lstInvestigationMaster.Count];
            for (int i = 0; i < lstInvestigationMaster.Count; i++)
            {
                InvProductArray[i] = lstInvestigationMaster[i].InvestigationName;
                string str = lstInvestigationMaster[i].InvestigationName + "~" + lstInvestigationMaster[i].Display;
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(lstInvestigationMaster[i].InvestigationName, str));
            }
        }
        return items.ToArray();


    }
    #endregion*/
    //#region Get Org based User Names

    //[WebMethod(EnableSession = true)]
    ////[System.Web.Script.Services.ScriptMethod()]
    //public string[] getUserNames(string prefixText, string contextKey)
    //{
    //    int orgID = Convert.ToInt32(contextKey);
    //    //Int32.TryParse(Session["OrgID"].ToString(), out orgID);

    //    AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
    //    List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
    //    long returnCode = -1;
    //    orgUserName = prefixText;
    //    string[] strUserNames = null;
    //    returnCode = arBL.GetUserNames(orgUserName, orgID, out lstOrgUsers);
    //    if (lstOrgUsers.Count > 0)
    //    {
    //        strUserNames = new string[lstOrgUsers.Count];
    //        for (int i = 0; i < lstOrgUsers.Count; i++)
    //        {
    //            strUserNames[i] = lstOrgUsers[i].Name;
    //        }
    //    }
    //    return strUserNames;
    //}


    //#endregion

    //#region InventoryDrugs

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public string[] getInvDrugList(string prefixText, int count)
    //{
    //    PatientPrescription_BL PrescriptionBL = new PatientPrescription_BL(new BaseClass().ContextInfo);
    //    List<PatientPrescription> lstPrescription = new List<PatientPrescription>();

    //    DrugName = prefixText;
    //    string[] drugNameArray = null;
    //    long lresutl = -1;

    //    int orgID = 0;
    //    Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);

    //    lresutl = PrescriptionBL.GetPrescription(DrugName, 7, orgID, out lstPrescription);
    //    if (lstPrescription.Count > 0)
    //    {
    //        drugNameArray = new string[lstPrescription.Count];
    //        for (int i = 0; i < lstPrescription.Count; i++)
    //        {
    //            drugNameArray[i] = lstPrescription[i].BrandName;
    //        }
    //    }

    //    return drugNameArray;

    //}

    //#endregion

    //#region GetModalityWorkList

    //[WebMethod(EnableSession = true)]
    //public void GetModalityWorkList(string modalityName, DateTime date, int orgID, out List<ModalityWorkList> modalityWorkList, out List<ModalityWorkList> CompletionList)
    //{
    //    modalityWorkList = new List<ModalityWorkList>();
    //    CompletionList = new List<ModalityWorkList>();
    //    new Investigation_BL(new BaseClass().ContextInfo).GetModalityWorkList(modalityName, date, orgID, out modalityWorkList, out CompletionList);
    //}

    //#endregion

    #region GetPhysician

    [WebMethod(EnableSession = true)]
    public string[] GetPhysician(string prefixText, int count, string contextKey)
    {

        string[] phyName = null;
        long retCode = -1;
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<ReferingPhysician> getReferingPhysician = new List<ReferingPhysician>();

        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        retCode = patBL.GetReferingPhysician(prefixText, orgID, out getReferingPhysician);
        if (getReferingPhysician.Count > 0)
        {
            phyName = new string[getReferingPhysician.Count];
            if (contextKey == "N")
            {
                for (int i = 0; i < getReferingPhysician.Count; i++)
                {
                    phyName[i] = getReferingPhysician[i].PhysicianName;// +"~" + getReferingPhysician[i].ReferingPhysicianID;
                }
            }
            else
            {
                for (int i = 0; i < getReferingPhysician.Count; i++)
                {
                    phyName[i] = getReferingPhysician[i].PhysicianName + "~" + getReferingPhysician[i].ReferingPhysicianID;
                }

            }
        }

        return phyName;
    }

    #endregion

    #region Get Visiting Consultant

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getVisitingConsultant(string prefixText, int count)
    {
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();

        phyName = prefixText;
        string[] phyNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        string pType = "VIS";

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        //  , OrgAddressID, pharmacyLocationID);
        lresutl = patBL.GetPhysicianByType(phyName, orgID, pType, out lstPhysician);
        if (lstPhysician.Count > 0)
        {
            phyNameArray = new string[lstPhysician.Count];
            for (int i = 0; i < lstPhysician.Count; i++)
            {
                phyNameArray[i] = lstPhysician[i].PhysicianName;
            }
        }

        return phyNameArray;

    }



    #endregion

    #region Get Surgeon name

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getSurgeon(string prefixText, int count)
    {
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();

        phyName = prefixText;
        string[] phyNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        string pType = "VIS";

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        //  , OrgAddressID, pharmacyLocationID);
        lresutl = patBL.GetPhysicianByType(phyName, orgID, pType, out lstPhysician);
        if (lstPhysician.Count > 0)
        {
            phyNameArray = new string[lstPhysician.Count];
            for (int i = 0; i < lstPhysician.Count; i++)
            {
                phyNameArray[i] = lstPhysician[i].PhysicianName;
            }
        }

        return phyNameArray;

    }



    #endregion

    #region Get Duty offices

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDutyOffices(string prefixText, int count)
    {
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();

        phyName = prefixText;
        string[] phyNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        string pType = "VIS";

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        //  , OrgAddressID, pharmacyLocationID);
        lresutl = patBL.GetPhysicianByType(phyName, orgID, pType, out lstPhysician);
        if (lstPhysician.Count > 0)
        {
            phyNameArray = new string[lstPhysician.Count];
            for (int i = 0; i < lstPhysician.Count; i++)
            {
                phyNameArray[i] = lstPhysician[i].PhysicianName;
            }
        }

        return phyNameArray;

    }



    #endregion

    #region surgery



    //BasePage bp = new BasePage();

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getSurgeryName(string prefixText, int count)
    {
        IP_BL IPBL = new IP_BL(new BaseClass().ContextInfo);
        List<IPTreatmentPlan> lstSurgeryName = new List<IPTreatmentPlan>();

        SurgeryName = prefixText;
        string[] SurgeryNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["DrugOrgID"].ToString(), out orgID);

        lresutl = IPBL.getSurgeryName(SurgeryName, orgID, out lstSurgeryName);
        if (lstSurgeryName.Count > 0)
        {
            SurgeryNameArray = new string[lstSurgeryName.Count];
            for (int i = 0; i < lstSurgeryName.Count; i++)
            {
                SurgeryNameArray[i] = lstSurgeryName[i].IPTreatmentPlanName;
            }
        }

        return SurgeryNameArray;

    }


    #endregion


    [WebMethod(EnableSession = true)]

    public List<LabReferenceOrg> GetReferingHospital(long PhysicianID, int OrgID)
    {
        List<LabReferenceOrg> lRefOrg = new List<LabReferenceOrg>();
        //LabReferenceOrg r = new LabReferenceOrg();
        //r.RefOrgName = "asa";
        //org.Add(r);
        long returnCode = -1;
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetMappedOrganisation(OrgID, PhysicianID, out lRefOrg);
        return lRefOrg;
    }
    [WebMethod(EnableSession = true)]
    public List<Patient> GetPatientDetails(long PPatientID, int OrgID)
    {
        long returnCode = -1;
        List<Patient> patientList = new List<Patient>();
        URNTypes objURNTypes = new URNTypes();
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetLabPatientDemoandAddress(PPatientID, out patientList);
        return patientList;
    }
    //Add By Syed
    [WebMethod(EnableSession = true)]
    public decimal GetPreviousDue(long pPatientID, int OrgID)
    {
        long returnCode = -1;
        List<Patient> patientList = new List<Patient>();
        decimal pPreviousDue = 0;
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetPreviousDue(pPatientID, OrgID, out pPreviousDue);
        return pPreviousDue;
    }
    [WebMethod(EnableSession = true)]
    public string[] GetReferringOrganization(string prefixText, string contextKey)
    {
        long retCode = -1;
        int orgID = 0;
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
        //  Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        Int32.TryParse(contextKey.ToString(), out orgID);
        retCode = patBL.GetLabAllRefOrg(prefixText, orgID, out RefOrg);
        string[] drugNameArray = null;

        if (RefOrg.Count > 0)
        {
            drugNameArray = new string[RefOrg.Count];
            for (int i = 0; i < RefOrg.Count; i++)
            {
                drugNameArray[i] = RefOrg[i].RefOrgName;

            }
            foreach (LabReferenceOrg item in RefOrg)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RefOrgName, Convert.ToString(item.LabRefOrgID + "^" + item.ClientTypeID + "^" + item.RateId + "^" + item.Name)));
            }
        }

        //return drugNameArray;
        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    public string[] GetInternalExternalPhysician(string prefixText, string contextKey)
    {
        long retCode = -1;
        int orgID = 0;
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<Physician> lstLabPhy = new List<Physician>();
        //  Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        Int32.TryParse(contextKey.ToString(), out orgID);
        retCode = patBL.GetQuickInternalExternalPhysician(prefixText, orgID, out lstLabPhy);
        string[] RefPhyNameArray = null;

        if (lstLabPhy.Count > 0)
        {
            RefPhyNameArray = new string[lstLabPhy.Count];
            for (int i = 0; i < lstLabPhy.Count; i++)
            {
                RefPhyNameArray[i] = lstLabPhy[i].PhysicianName;

            }
            foreach (Physician item in lstLabPhy)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.TitleCode, Convert.ToString(item.PhysicianID + "^" + item.PhysicianName + "^" + item.PhysicianType)));
            }
        }

        //return drugNameArray;
        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    public List<URNTypes> GetURN(int URnTypeId, string URnNo)
    {
        long returnCode = -1;
        List<URNTypes> URNList = new List<URNTypes>();
        URNTypes objURNTypes = new URNTypes();
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetURN(URnTypeId, URnNo, out URNList);
        return URNList;
    }
    #region Get Complaint For ICD Code
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getDiagnosisDtl(string prefixText, int count)
    {



        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<Complaint> lstComplaint = new List<Complaint>();
        sComplaintName = prefixText;

        long lresutl = -1;
        lresutl = oPatient_BL.GetComplaint(sComplaintName, out lstComplaint);
        List<string> items = new List<string>();


        if (lstComplaint.Count > 0)
        {

            foreach (Complaint item in lstComplaint)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ComplaintName, item.ComplaintId.ToString()));
            }
        }
        else
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(prefixText, "0"));

        }

        return items.ToArray();
    }
    #endregion



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getICDCODE(string prefixText, int count)
    {

        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<ICDCodes> lstICDCodes = new List<ICDCodes>();

        string[] ICDArray = null;
        long lresutl = -1;
        lresutl = oPatient_BL.GetICDCODE(prefixText, out lstICDCodes);
        if (lstICDCodes.Count > 0)
        {
            ICDArray = new string[lstICDCodes.Count];
            for (int i = 0; i < lstICDCodes.Count; i++)
            {
                //ICDArray[i] = lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ComplaintName; 
                ICDArray[i] = lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ComplaintName + "~" + lstICDCodes[1].ComplaintId;
            }
        }

        return ICDArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getICDName(string prefixText, int count)
    {

        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<ICDCodes> lstICDCodes = new List<ICDCodes>();

        string[] ICDArray = null;
        long lresutl = -1;
        lresutl = oPatient_BL.GetICDCODEDESC(prefixText, out lstICDCodes);
        if (lstICDCodes.Count > 0)
        {
            ICDArray = new string[lstICDCodes.Count];
            for (int i = 0; i < lstICDCodes.Count; i++)
            {
                //ICDArray[i] = lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ComplaintName;
                ICDArray[i] = lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ComplaintName + "~" + lstICDCodes[i].ComplaintId;
            }
        }

        return ICDArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getComplaintName(string prefixText, int count)
    {
        int StrLen = prefixText.Length;
        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<Complaint> lstCName = new List<Complaint>();
        string[] ICDArray = null;
        long lresutl = -1;
        if (2 == StrLen)
        {
            lresutl = oPatient_BL.GetComplaintNameDESC(prefixText, out lstCName);
            if (lstCName.Count > 0)
            {
                ICDArray = new string[lstCName.Count];
                for (int i = 0; i < lstCName.Count; i++)
                {
                    ICDArray[i] = lstCName[i].ComplaintName + "~" + lstCName[i].ICDCode + "~" + lstCName[i].ComplaintName;
                }
            }

        }
        return ICDArray;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetRoomName(string RoomName)
    {
        long returnCode = -1;
        RoomBooking_BL rtBL = new RoomBooking_BL(new BaseClass().ContextInfo);
        RoomDetails RD = new RoomDetails();
        List<BedMaster> lstBed = new List<BedMaster>();
        List<RoomDetails> lstRoom = new List<RoomDetails>();
        List<RoomDetails> RoomDtls = new List<RoomDetails>();
        RD.RoomName = RoomName;
        //returnCode = rtBL.GetRoomsDetails(Convert.ToInt32(Session["OrgID"].ToString()),Convert.ToInt32(Session["LocationID"].ToString()), RD, 1, out RoomDtls, out lstRoom, out lstBed,out RoomDtls);
        string retStr = "";
        foreach (RoomDetails Rtls in lstRoom)
        {
            retStr += Rtls.RoomName + "|";
        }
        return retStr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string getRoomFeeDetails(int pOrgID, int pOrgAddressID)
    {
        List<RoomDetails> lstroomfeeDet = new List<RoomDetails>();
        List<RoomDetails> lstroomfee = new List<RoomDetails>();
        string retStr = "";
        RoomBooking_BL rtBL = new RoomBooking_BL(new BaseClass().ContextInfo);
        long returnCode = rtBL.GetRoomsFeesType(pOrgID, pOrgAddressID, out lstroomfeeDet, out lstroomfee);
        foreach (RoomDetails Rdls in lstroomfeeDet)
        {
            retStr += Rdls.RoomTypeID.ToString() + "~" + Rdls.FeeID.ToString() + "~" + Rdls.Description + "~" + Rdls.Amount.ToString() + "~" + Rdls.ISVariable + "~" + Rdls.ISOptional + "~" + Rdls.RoomTypeFeeMappingID + "|";
        }
        return retStr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string LoadRoomType(int OrgID, int OrgAddId, int RoomTypeID, string RoomTypeName)
    {
        long returnCode = -1;
        RoomBooking_BL rtBL = new RoomBooking_BL(new BaseClass().ContextInfo);
        RoomType RT = new RoomType();
        List<RoomType> roomtype = new List<RoomType>();
        string retStr = "";
        returnCode = rtBL.GetRoomsType(OrgID, OrgAddId, RoomTypeID, RoomTypeName, out roomtype);

        foreach (RoomType Rtls in roomtype)
        {
            retStr += Rtls.RoomTypeID + "~" + Rtls.RoomTypeName + "|";
        }
        return retStr;
    }





    #region Get Schedules for Booking
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Bookings> loadWebScheduleDetail(long orgID, long patientID, long patientVisitID)
    {
        List<Bookings> lstScheduleDetail = new List<Bookings>();
        string VisitType = "";
        long finalBillID = 0;
        FinalBill fb = new FinalBill();
        //fb.FinalBillID
        //fb.BillNumber
        //fb.Due
        //fb.DiscountAmount
        //fb.NetValue
        //fb.Type
        //fb.CreatedAt
        BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
        //billingEngineBL.GetDueDetails(orgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out VisitType);
        return lstScheduleDetail;
    }
    #endregion
    #region GetConsultantName


    [WebMethod(EnableSession = true)]
    public string[] GetConsultantName(string prefixText, int count, string contextKey)
    {
        long retCode = -1;
        RoomBooking_BL roomFilterBL = new RoomBooking_BL(new BaseClass().ContextInfo);
        List<string> phyName = new List<string>();
        List<Physician> lstConsultant = new List<Physician>();

        int orgID = 0;
        Int32.TryParse(contextKey.ToString(), out orgID);

        retCode = roomFilterBL.GetConsultantName(prefixText, orgID, out lstConsultant);

        if (lstConsultant.Count > 0)
        {
            foreach (Physician item in lstConsultant)
            {
                phyName.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.PhysicianName, item.PhysicianID.ToString()));
            }
        }
        return phyName.ToArray();

    }

    #endregion

    #region GetBedPatientName
    [WebMethod(EnableSession = true)]
    public string[] GetBedPatientName(string prefixText, int count, string contextKey)
    {
        long retCode = -1;
        RoomBooking_BL roomFilterBL = new RoomBooking_BL(new BaseClass().ContextInfo);
        List<string> patName = new List<string>();
        List<Patient> lstPatient = new List<Patient>();

        int orgID = 0;
        Int32.TryParse(contextKey.ToString(), out orgID);

        retCode = roomFilterBL.GetBedPatientName(prefixText, orgID, out lstPatient);

        if (lstPatient.Count > 0)
        {
            foreach (Patient item in lstPatient)
            {
                patName.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.PatientID.ToString()));
            }
        }
        return patName.ToArray();

    }
    #endregion

    #region Get NonReimbursable Items

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetNonReimbursableItems(string prefixText, int count, string contextKey)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<BillingFeeDetails> lstBFD = new List<BillingFeeDetails>();

        string desc = prefixText;
        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(contextKey.Split('~')[1], out orgID);


        string feeType = string.Empty;
        feeType = contextKey.Split('~')[0].ToUpper();


        lresutl = be.GetNonReimbursableItems(orgID, feeType, desc, out lstBFD);
        List<string> items = new List<string>();
        if (lstBFD.Count > 0)
        {
            foreach (BillingFeeDetails item in lstBFD)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
            }
        }

        return items.ToArray();
    }

    #endregion


    #region Get Org based User Names With LoginID

    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public string[] getUserNamesWithLoginID(string prefixText, string contextKey)
    {
        int orgID = 0;
        string strAuthTypeName = "";
        // string[] strValue = contextKey.Split('~');
        Int32.TryParse(contextKey, out orgID);
        //if (strValue[1] != "")
        // strAuthTypeName = strValue[1];

        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = arBL.GetUserNameWithLoginID(orgUserName, orgID, strAuthTypeName, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            strUserNames = new string[lstOrgUsers.Count];
            for (int i = 0; i < lstOrgUsers.Count; i++)
            {
                strUserNames[i] = lstOrgUsers[i].Name;
            }
        }
        return strUserNames;
    }


    #endregion
    #region Drug List for Culture Sensitivity Investigation
    [WebMethod(EnableSession = true)]
    public List<InvestigationDrugBrand> FetchDrugList(string drug, int Orgid)
    {
        List<InvestigationDrugBrand> lstInvDrugBrand = new List<InvestigationDrugBrand>();
        long returnCode = -1;
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetInvestigationDrugBrand(Orgid, "", out lstInvDrugBrand);

        var fetchDrug = from m in lstInvDrugBrand
                     .Where(m => m.BrandName.ToLower().StartsWith(drug.ToLower()))
                        select m;
        return fetchDrug.ToList();
    }
    #endregion

    #region Get Investigaton Status MouseOver
    [WebMethod(EnableSession = true)]
    public List<OrderedInvestigations> FetchInvestigationStatus(long visitid, int Orgid)
    {
        List<OrderedInvestigations> lstInvStatus = new List<OrderedInvestigations>();
        long returnCode = -1;
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).pGetpatientInvestigationForVisit(visitid, Orgid, 0, "", out lstInvStatus);

        var fetchStatus = from m in lstInvStatus
                          select m;

        return fetchStatus.ToList();
    }
    #endregion
    [WebMethod(EnableSession = true)]
    public List<InvDeptMaster> loaddropdown(string OrgID)
    {
        long returnCode = -1;
        List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvforDept(Convert.ToInt32(OrgID), out lstDpt);
        return lstDpt;
    }

    [WebMethod(EnableSession = true)]
    public List<InvestigationOrgMapping> getDeptData(int deptID, string OrgID)
    {
        List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
        long returnCode = -1;
        if (deptID > 0)
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).pGetInvDeptData(Convert.ToInt32(OrgID), deptID, out lstIOM);

            //if (lstInvOrg.Count > 0)
            //{
            //    gvReckon.DataSource = lstInvOrg;
            //    gvReckon.DataBind();
            //    loaddata(lstInvOrg);
            //    gv.Attributes.Add("style", "display:block");
            //    tprint.Attributes.Add("style", "display:block");
            //}
            //else//the data for the department is empty. Clear the bind list
            //{
            //    gvReckon.DataSource = null;
            //    gvReckon.DataBind();
            //}
        }
        return lstIOM;

    }
    [WebMethod(EnableSession = true)]
    public void SaveSequence(string data, int deptID, string OrgID)
    {
        long returnCode = -1;

        InvestigationOrgMapping Inv = new InvestigationOrgMapping();
        List<InvestigationOrgMapping> lstInvOrg = new List<InvestigationOrgMapping>();
        Investigation_BL objInv = new Investigation_BL(new BaseClass().ContextInfo);
        System.Data.DataTable dt = new System.Data.DataTable();
        System.Data.DataColumn dbCol1 = new System.Data.DataColumn("InvestigationID");
        System.Data.DataColumn dbCol2 = new System.Data.DataColumn("InvestigationName");
        System.Data.DataColumn dbCol3 = new System.Data.DataColumn("OrgId");
        System.Data.DataColumn dbCol4 = new System.Data.DataColumn("DeptId");
        System.Data.DataColumn dbCol5 = new System.Data.DataColumn("HeaderID");
        System.Data.DataColumn dbCol6 = new System.Data.DataColumn("Display");
        System.Data.DataColumn dbCol7 = new System.Data.DataColumn("DisplayText");
        System.Data.DataColumn dbCol8 = new System.Data.DataColumn("ReferenceRange");
        System.Data.DataColumn dbCol9 = new System.Data.DataColumn("SequenceNo");
        System.Data.DataColumn dbCol10 = new System.Data.DataColumn("SampleCode");
        System.Data.DataColumn dbCol11 = new System.Data.DataColumn("MethodID");
        System.Data.DataColumn dbCol12 = new System.Data.DataColumn("PrincipleID");
        System.Data.DataColumn dbCol13 = new System.Data.DataColumn("KitID");
        System.Data.DataColumn dbCol14 = new System.Data.DataColumn("InstrumentID");
        System.Data.DataColumn dbCol15 = new System.Data.DataColumn("QCData");
        System.Data.DataColumn dbCol16 = new System.Data.DataColumn("Interpretation");
        System.Data.DataColumn dbCol17 = new System.Data.DataColumn("SampleContainerID");
        System.Data.DataColumn dbCol18 = new System.Data.DataColumn("UOMID");
        System.Data.DataColumn dbCol19 = new System.Data.DataColumn("UOMCode");
        System.Data.DataColumn dbCol20 = new System.Data.DataColumn("LoginID");
        System.Data.DataColumn dbCol21 = new System.Data.DataColumn("PanicRange");
        System.Data.DataColumn dbCol22 = new System.Data.DataColumn("AutoApproveLoginID");
        System.Data.DataColumn dbCol23 = new System.Data.DataColumn("ReferenceRangeString");
        System.Data.DataColumn dbCol24 = new System.Data.DataColumn("PrintSeparately");
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        dt.Columns.Add(dbCol5);
        dt.Columns.Add(dbCol6);
        dt.Columns.Add(dbCol7);
        dt.Columns.Add(dbCol8);
        dt.Columns.Add(dbCol9);
        dt.Columns.Add(dbCol10);
        dt.Columns.Add(dbCol11);
        dt.Columns.Add(dbCol12);
        dt.Columns.Add(dbCol13);
        dt.Columns.Add(dbCol14);
        dt.Columns.Add(dbCol15);
        dt.Columns.Add(dbCol16);
        dt.Columns.Add(dbCol17);
        dt.Columns.Add(dbCol18);
        dt.Columns.Add(dbCol19);
        dt.Columns.Add(dbCol20);
        dt.Columns.Add(dbCol21);
        dt.Columns.Add(dbCol22);
        dt.Columns.Add(dbCol23);
        dt.Columns.Add(dbCol24);

        System.Data.DataRow dr;
        int i, j, l;
        string[] data1 = data.Split('~');
        string[] data2;
        l = data1.Length;
        for (i = 0; i < (l - 1); i++)
        {
            data2 = data1[i].Split('^');
            dr = dt.NewRow();
            dr["InvestigationID"] = data2[2];
            dr["OrgID"] = OrgID;
            dr["DeptID"] = "";
            dr["HeaderID"] = "";
            dr["InvestigationName"] = data2[0];
            dr["Display"] = "";
            dr["DisplayText"] = "";
            dr["ReferenceRange"] = "";
            dr["SequenceNo"] = data2[1];
            dr["SampleCode"] = "";
            dr["MethodID"] = "";
            dr["PrincipleID"] = "";
            dr["KitID"] = "";
            dr["InstrumentID"] = "";
            dr["QCData"] = "";
            dr["Interpretation"] = "";
            dr["SampleContainerID"] = "";
            dr["UOMID"] = "";
            dr["UOMCode"] = "";
            dr["LoginID"] = "";
            dr["PanicRange"] = "";
            dr["AutoApproveLoginID"] = "";
            dr["ReferenceRangeString"] = "";
            dr["PrintSeparately"] = "";

            dt.Rows.Add(dr);
        }
        returnCode = objInv.pUpdateInvSequence(dt, Convert.ToInt32(OrgID), deptID);
        if (returnCode == 0)
        {
            //filldata();
            //HdnCount.Value = "0";
            // this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('Changes saved successfully.'); </script>");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "m", "alert('Changes saved successfully.');", true);
        }
    }

    [WebMethod(EnableSession = true)]
    public List<InvClientMaster> GetPCClient(int orgID, long refOrgID, int refPhyID, int payerID, long TpaOrClientID, string Type)
    {
        //This WebMethod is using in the Lab-Reg page, Created by Syed
        long returnCode = -1;
        List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
        lstInvClientMaster = new List<InvClientMaster>();
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetPCClient(orgID, refOrgID, refPhyID, payerID, TpaOrClientID, Type, out lstInvClientMaster);
        return lstInvClientMaster;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAllergyHistory(string prefixText, int count)
    {
        List<PatientHistoryAttribute> lstPatientHistory = new List<PatientHistoryAttribute>();
        long retCode = -1;
        string ComplaintName = prefixText;
        string[] HistoryArray = null;
        string strDesc = "ALLERGIC HISTORY";
        List<string> items = new List<string>(lstPatientHistory.Count);
        retCode = new SmartAccessor().GetAllergyHistory(strDesc, prefixText, out lstPatientHistory);
        if (lstPatientHistory.Count > 0)
        {
            HistoryArray = new string[lstPatientHistory.Count];
            //for (int i = 0; i < lstPatientHistory.Count; i++)
            //{
            //    items[i] = lstPatientHistory[i].AttributeValueName + "~" + lstPatientHistory[i].HistoryID;
            //}
            for (int i = 0; i < lstPatientHistory.Count; i++)
            {
                string KeyVal = lstPatientHistory[i].AttributeValueName;
                string value = lstPatientHistory[i].AttributeValueName + "~" + Convert.ToString(lstPatientHistory[i].HistoryID);
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
            }
        }
        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientHistoryAttribute> GetAllergyHistoryDet(long lngHistoryID)
    {

        List<PatientHistoryAttribute> lstPatientHistory = new List<PatientHistoryAttribute>();
        long retCode = -1;
        retCode = new SmartAccessor().GetAllergyHistoryDet(lngHistoryID, out lstPatientHistory);
        return lstPatientHistory;
    }

    #region Get Login DropDown Contents
    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetOrganizations(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
        try
        {
            long loginID = -1;
            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            if (Session["LID"] != null)
            {
                Int64.TryParse(Session["LID"].ToString(), out loginID);
                Login objLogin = new Login();
                objLogin.LoginID = loginID;
                List<Role> lstResult = new List<Role>();
                gateWay.GetRoles(objLogin, out lstResult);
                lstResult = lstResult.OrderBy(r => r.OrgName).ToList();

                values = (from lst in lstResult
                          group lst by
                          new
                          {
                              lst.OrgID,
                              lst.OrgName,
                              lst.IsDefault
                          } into grp
                          select new CascadingDropDownNameValue
                         {
                             name = grp.Key.OrgName,
                             value = grp.Key.OrgID.ToString(),
                             isDefaultValue = grp.Key.IsDefault
                         }).OrderBy(p => p.name).ToList();

                if (values.Count > 0)
                {
                    List<CascadingDropDownNameValue> isDefaultExist = values.Where(v => v.isDefaultValue == true).ToList();
                    if (isDefaultExist.Count == 0)
                        values[0].isDefaultValue = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations:GetOrganizations() ", ex);
        }
        return values.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetRolesForOrg(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
        try
        {
            StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            long orgId;
            if (!kv.ContainsKey("Org") || !Int64.TryParse(kv["Org"], out orgId))
            {
                return null;
            }
            long loginID = -1;
            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            if (Session["LID"] != null)
            {
                Int64.TryParse(Session["LID"].ToString(), out loginID);
                Login objLogin = new Login();
                objLogin.LoginID = loginID;
                List<Role> lstResult = new List<Role>();
                gateWay.GetRoles(objLogin, out lstResult);
                List<Role> lstRole = (from child in lstResult where child.OrgID == orgId orderby child.RoleName select child).ToList();

                values = (from lst in lstRole
                          group lst by
                          new
                          {
                              lst.RoleID,
                              lst.RoleName,
                              lst.Description,
                              lst.IsDefault
                          } into grp
                          select new CascadingDropDownNameValue
                          {
                              name = grp.Key.Description.Trim(),
                              value = grp.Key.RoleID.ToString() + "~" + grp.Key.RoleName,
                              isDefaultValue = grp.Key.IsDefault
                          }).OrderBy(p => p.name).ToList();
                if (values.Count > 0)
                {
                    List<CascadingDropDownNameValue> isDefaultExist = values.Where(v => v.isDefaultValue == true).ToList();
                    if (isDefaultExist.Count == 0)
                        values[0].isDefaultValue = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations:GetRolesForOrg() ", ex);
        }
        return values.ToArray();
    }

    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetLocationsForOrg(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
        try
        {
            StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            long orgId;
            long returnCode = -1;
            long loginID = -1;
            long roleID = -1;
            if (!kv.ContainsKey("Org") || !Int64.TryParse(kv["Org"], out orgId))
            {
                return null;
            }
            if (!kv.ContainsKey("Role") || !Int64.TryParse(kv["Role"].Split('~')[0], out roleID))
            {
                return null;
            }
            if (Session["LID"] != null)
            {
                Int64.TryParse(Session["LID"].ToString(), out loginID);
                Login objLogin = new Login();
                objLogin.LoginID = loginID;
                PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
                List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                returnCode = patientBL.GetLocation(orgId, loginID, roleID, out lstLocation);

                values = (from lst in lstLocation
                          group lst by
                          new
                          {
                              lst.AddressID,
                              lst.Location
                          } into grp
                          select new CascadingDropDownNameValue
                          {
                              name = grp.Key.Location.Trim(),
                              value = grp.Key.AddressID.ToString()
                          }).OrderBy(p => p.name).ToList();

                if (values.Count > 0)
                {
                    values[0].isDefaultValue = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations:GetLocationsForOrg() ", ex);
        }
        return values.ToArray();
    }
    #endregion

    #region Get Investigaton Name For Org (Ordered Investigation)
    [WebMethod(EnableSession = true)]
    public List<OrderedInvestigations> FetchInvestigationName(string Name, int Orgid)
    {
        List<OrderedInvestigations> lstInvName = new List<OrderedInvestigations>();
        long returnCode = -1;
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvestigationNameForOrg(Name, Orgid, out lstInvName);



        var fetchName = from m in lstInvName
                        select m;

        return fetchName.ToList();
    }
    #endregion

    #region Get Investigaton Name For Org used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchInvestigationNameForOrg(string prefixText, int count, string contextKey)
    {
        List<OrderedInvestigations> lstInvName = new List<OrderedInvestigations>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvestigationNameForOrg(prefixText, Orgid, out lstInvName);
        if (lstInvName.Count > 0)
        {
            foreach (OrderedInvestigations item in lstInvName)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Name + "~" + item.ID + "~" + item.Type));
            }
        }
        return items.ToArray();
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInvestigationNameFromOrgMapping(string prefixText, int count, string contextKey)
    {
        List<InvestigationOrgMapping> lstInvName = new List<InvestigationOrgMapping>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvestigationNameFromOrgMapping(prefixText, Orgid, out lstInvName);
        if (lstInvName.Count > 0)
        {
            foreach (InvestigationOrgMapping item in lstInvName)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.DisplayText, item.DisplayText + "~" + item.InvestigationID));
            }
        }
        return items.ToArray();
    }

    #region Get Refering Physician Name For Org used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchRefPhysicianNameForOrg(string prefixText, int count, string contextKey)
    {
        List<ReferingPhysician> lstInvName = new List<ReferingPhysician>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Patient_BL(new BaseClass().ContextInfo).GetTrustedOrgReferingPhysician(prefixText, Orgid, out lstInvName);
        if (lstInvName.Count > 0)
        {
            foreach (ReferingPhysician item in lstInvName)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.PhysicianName, item.PhysicianName + "~" + item.ReferingPhysicianID + "~" + item.OrgID));
            }
        }
        return items.ToArray();
    }


    #endregion


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] BillingAuthorisedBy(string prefixText, int count, string contextKey)
    {
        List<BillingAuthorisedBy> lstAuthorisedBy = new List<BillingAuthorisedBy>();
        BillingEngine lstAuthorise = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstAuthorisedBy.Count);
        try
        {
            long retCode = -1;
            int orgID = Convert.ToInt32(contextKey);
            string searchType = "";
            string[] PatientList = null;
            searchType = (contextKey);
            retCode = new BillingEngine(new BaseClass().ContextInfo).BillingAuthorisedBy(prefixText, orgID, "", out lstAuthorisedBy);
            items.Clear();
            if (lstAuthorisedBy.Count > 0)
            {
                PatientList = new string[lstAuthorisedBy.Count];
                foreach (BillingAuthorisedBy item in lstAuthorisedBy)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.AuthorisedName, item.AuthorisedID.ToString()));
                }

            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }
        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvestigationValues> GetPatientInvestigationValuesHisiory(long patientVisitID, int OrgID, long PatternID, long InvID)
    {
        //This WebMethod is using in the InvestigationApprovel page, Created by Syed      
        long result = -1;
        List<InvestigationValues> lstPendingValue = new List<InvestigationValues>();

        Investigation_BL Delta_BL = new Investigation_BL(new BaseClass().ContextInfo);
        result = Delta_BL.GetPatientInvestigationValuesHisiory(patientVisitID, OrgID, PatternID, InvID, out lstPendingValue);

        return lstPendingValue;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long InvSaveDefProcCentre(string ColCentreList, string ProcCentreList, string InvestigationID, string strAllInvestigations)
    {
        long result = -1;
        long lngInvestigationID = Convert.ToInt64(InvestigationID);
        Investigation_BL InvBL = new Investigation_BL(new BaseClass().ContextInfo);
        result = InvBL.InvSaveDefProcCentre(ColCentreList, ProcCentreList, lngInvestigationID, strAllInvestigations);

        return result;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long GetCheckCode(string CodeType, string Code)
    {
        long returnCode = -1;
        int Count = -1;
        Referrals_BL referralBL = new Referrals_BL(new BaseClass().ContextInfo);
        int OrgID = -1;
        List<DiscountPolicy> lstDisCountPolicy = null;
        int ExecuteType = 0;
        returnCode = referralBL.GetCheckCode(CodeType, Code, ExecuteType, out Count, OrgID, out lstDisCountPolicy);
        return Count;
    }

    #region GetAllClientListforSchedule [ClientMaster]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientListforSchedule(string prefixText, int count, string contextKey)
    {
        Schedule_BL scheduleBL = new Schedule_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        int orgID = 0;
        string type = string.Empty;
        long PCid = 0;
        if (contextKey.Contains("^"))
        {
            var Obj = contextKey.Split('^');
            type = Obj[0].Trim();
            PCid = string.IsNullOrEmpty(Obj[1].Trim()) == true ? -1 : Convert.ToInt64(Obj[1].Trim());
        }
        else
        {
            type = contextKey;
        }
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        scheduleBL.GetClientList(orgID, prefixText, out lstClientMaster);
        if (lstClientMaster.Count > 0)
        {
            if (type == "CHILDCLIENT")
            {
                lstClientMaster = lstClientMaster.FindAll(P => P.Reason.ToString() == type);
                if (lstClientMaster.Count > 0)
                {
                    foreach (ClientMaster item in lstClientMaster)
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, (item.ClientID.ToString() + "^" + item.ChildAttribute)));
                    }
                }
            }
            else if (type == "STY" || type == "LOC")
            {
                lstClientMaster = lstClientMaster.FindAll(P => P.Reason.ToString() == type);
                if (lstClientMaster.Count > 0)
                {
                    foreach (ClientMaster item in lstClientMaster)
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, (item.ClientID.ToString() + "^" + item.ChildAttribute + "^" + item.ParentAttribute + "^" + item.ClientCode + "^" + item.BlockedClient + "^" + item.CustomerType)));
                    }
                }
            }
            else if (type == "SIT" || type == "RPH")
            {
                if (PCid == 0)
                {
                    lstClientMaster = lstClientMaster.FindAll(P => P.Reason.ToString() == type);
                }
                else
                {
                    lstClientMaster = lstClientMaster.FindAll(P => P.Reason.ToString() == type && P.ParentClientID == PCid);
                }

                if (lstClientMaster.Count > 0)
                {
                    foreach (ClientMaster item in lstClientMaster)
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
                    }
                }
            }
            else
            {
                foreach (ClientMaster item in lstClientMaster)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
                }
            }
        }
        return items.ToArray();

    }
    #endregion





    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetExternalDetails(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        long retCode = -1;
        int orgID = 0;
        //string[] PatientList = null;
        List<string> items = new List<string>();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        retCode = PatBL.GetExternalDetails(prefixText, prefixText, orgID, out lstPatient);
        if (lstPatient.Count > 0)
        {
            foreach (Patient item in lstPatient.Take(30))
            {
                try
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Comments));
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error GetEMPPatientListForRegis", ex);
                }
            }

        }

        return items.ToArray();
    }

    #region GetAllClientList [ClientRateMapping]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientList(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
        int orgID = 0;
        int typeid = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        int ClientTypeID = -1;
        string[] GetContextKey = contextKey.Split('^');
        typeid = Convert.ToInt32(GetContextKey[0]);
        if (typeid > 0)
        {
            if (!String.IsNullOrEmpty(contextKey.Split('^')[1]) && (contextKey.Split('^')[1]).Length > 0)
            {
                orgID = Convert.ToInt32(GetContextKey[1]);
            }
        }
        List<string> items = new List<string>();
        Master_BL.GetClientList(orgID, prefixText, typeid, out lstInvClientMaster);
        if (lstInvClientMaster.Count > 0)
        {
            if (typeid < 0)
            {
                if (GetContextKey.Count() > 0)
                {
                    ClientTypeID = Convert.ToInt32(contextKey.Split('^')[1]);
                }
                if (ClientTypeID > 0)
                {
                    if (lstInvClientMaster.Exists(p => p.ClientTypeID == ClientTypeID))
                        lstInvClientMaster = lstInvClientMaster.FindAll(p => p.ClientTypeID == ClientTypeID).ToList();
                    else
                        lstInvClientMaster.Clear();
                }
                foreach (InvClientMaster objitem in lstInvClientMaster)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(objitem.ClientName, objitem.ClientAttributes));
                }
            }
            else
            {
                foreach (InvClientMaster item in lstInvClientMaster)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString() + "|" + item.ClientCode));
                }
            }
        }
        return items.ToArray();

    }
    #endregion

    #region Get Client RateCard [ClientRateMapping]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientRateCard(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<RateMaster> lstRateMaster = new List<RateMaster>();
        int orgID = 0;
        string Value = contextKey;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetClientRateCard(orgID, prefixText, contextKey, out lstRateMaster);
        if (lstRateMaster.Count > 0)
        {
            foreach (RateMaster item in lstRateMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RateName, item.RateId.ToString() + "|" + item.RateCode));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region Get Existing MappedClient[ClientRateMapping]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvClientMaster> GetMappedClient(int ClientID, int RateID, int ClientTypeID)
    {
        long returnCode = -1;
        Patient_BL Patient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<InvClientMaster> lstCMaster = new List<InvClientMaster>();
        lstCMaster = new List<InvClientMaster>();
        List<InvClientMaster> lstInvClientRate = new List<InvClientMaster>();
        lstInvClientRate = new List<InvClientMaster>();
        int orgID = 0;
        DateTime Fromdt = DateTime.Now;
        DateTime Todt = DateTime.Now;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        try
        {
            returnCode = new Patient_BL(new BaseClass().ContextInfo).GetClientRateMappingItems(orgID, ClientID, RateID, ClientTypeID, Fromdt, Todt, out lstInvClientRate, out lstCMaster);
        }
        //Master_BL.GetClientRateCard(orgID, prefixText, out lstRateMaster);
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetMappedClient Message:", ex);
        }
        return lstCMaster;

    }
    #endregion

    [WebMethod(EnableSession = true)]
    public string[] GetQuickBillRefOrg(string prefixText, string contextKey)
    {
        long retCode = -1;
        int orgID = 0;
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
        //  Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        //Int32.TryParse(contextKey.ToString(), out orgID);
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        retCode = patBL.GetQuickBillRefOrg(prefixText, orgID, 0, "D", contextKey, out RefOrg);
        string[] drugNameArray = null;

        if (RefOrg.Count > 0)
        {
            drugNameArray = new string[RefOrg.Count];
            for (int i = 0; i < RefOrg.Count; i++)
            {
                drugNameArray[i] = RefOrg[i].RefOrgName;

            }
            foreach (LabReferenceOrg item in RefOrg)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RefOrgName, Convert.ToString(item.LabRefOrgID)));
            }
        }

        //return drugNameArray;
        return items.ToArray();
    }
    #region Get Org based User Names With loginname and LoginID

    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public string[] getUserNamesWithNameandLoginID(string prefixText, string contextKey)
    //{
    //    int orgID = Convert.ToInt32(contextKey);
    //    //Int32.TryParse(Session["OrgID"].ToString(), out orgID);
    //    List<string> items = new List<string>();
    //    AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
    //    List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
    //    long returnCode = -1;
    //    orgUserName = prefixText;
    //    string[] strUserNames = null;
    //    returnCode = arBL.GetUserNameWithLoginID(orgUserName, orgID, out lstOrgUsers);
    //    if (lstOrgUsers.Count > 0)
    //    {
    //        strUserNames = new string[lstOrgUsers.Count];
    //        for (int i = 0; i < lstOrgUsers.Count; i++)
    //        {
    //            strUserNames[i] = lstOrgUsers[i].Name;
    //        }
    //        foreach (OrgUsers item in lstOrgUsers)
    //        {
    //            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name.ToString().Split('~')[0], item.Name.ToString().Split('~')[1]));
    //        }
    //    }
    //    return items.ToArray();
    //}
    public string[] getUserNamesWithNameandID(string prefixText, string contextKey)
    {
        int orgID = 0;
        string strAuthTypeName = "";
        //string[] strValue = contextKey.Split('~');
        Int32.TryParse(contextKey, out orgID);
        //if (strValue[1] != "")
        // strAuthTypeName = strValue[1];
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsers2 = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsers1 = new List<OrgUsers>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = arBL.GetUserNameWithLoginID(orgUserName, orgID, strAuthTypeName, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            lstOrgUsers1 = lstOrgUsers.FindAll(p => p.RoleName == "LabReception" || p.RoleName == "DEO B2B");

            lstOrgUsers2 = (from S in lstOrgUsers1
                            group S by new { S.SpecialityName, S.LoginID } into g
                            select new OrgUsers
                            {
                                SpecialityName = g.Key.SpecialityName,
                                LoginID = g.Key.LoginID,


                            }).Distinct().ToList();

            strUserNames = new string[lstOrgUsers2.Count];
            for (int i = 0; i < lstOrgUsers2.Count; i++)
            {
                strUserNames[i] = lstOrgUsers2[i].SpecialityName + "~" + lstOrgUsers2[i].LoginID.ToString();


            }
            foreach (OrgUsers item in lstOrgUsers2)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.SpecialityName, item.LoginID.ToString()));
            }
        }
        return items.ToArray();
    }


    #endregion

    #region
    [WebMethod(EnableSession = true)]
    public List<OrgUsers> getauthrisorsWithNameandID(string prefixText, string contextKey)
    {
        int orgID = 0;
        string strAuthTypeName = "";
        string[] strValue1 = contextKey.Split('~');
        Int32.TryParse(strValue1[0], out orgID);
        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUserdetails = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsersdetail1 = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsers2 = new List<OrgUsers>();
        List<string> items = new List<string>();
        long returnCode = -1;
        orgUserName = prefixText;
        
            returnCode = arBL.GetUserNameWithLoginID(orgUserName, orgID, strAuthTypeName, out lstOrgUserdetails);
            lstOrgUsersdetail1 = lstOrgUserdetails.FindAll(p => p.RoleName == "Accounts" || p.RoleName == "Centre Manager" || p.RoleName == "Super Administrator" || p.RoleName == "STAR ADMIN" || p.RoleName == "Administrator" || p.RoleName == "Doctor" || p.RoleName == "Junior Doctor");
            lstOrgUsers2 = (from S in lstOrgUsersdetail1
                            group S by new { S.SpecialityName, S.LoginID } into g
                            select new OrgUsers
                            {
                                SpecialityName = g.Key.SpecialityName,
                                LoginID = g.Key.LoginID,


                            }).Distinct().ToList();

            return lstOrgUsers2;

    }
    #endregion
    #region
    [WebMethod(EnableSession = true)]
    public string[] getUserNamesWithNameandLoginID(string prefixText, string contextKey)
    {
        int orgID = 0;
        string strAuthTypeName = "";
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        //if(orgID==70)
        if (strValue.Count() > 1)
        {
            if (strValue[1] != "")
                strAuthTypeName = strValue[1];
        }
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsers2 = new List<OrgUsers>();
        List<OrgUsers> lstOrgUsers1 = new List<OrgUsers>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = arBL.GetUserNameWithLoginID(orgUserName, orgID, strAuthTypeName, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            lstOrgUsers1 = lstOrgUsers.FindAll(p => p.RoleName == "Accounts" || p.RoleName == "Centre Manager" || p.RoleName == "Super Administrator" || p.RoleName == "STAR ADMIN" || p.RoleName == "Administrator" || p.RoleName == "Doctor" || p.RoleName == "Junior Doctor");

            lstOrgUsers2 = (from S in lstOrgUsers1
                            group S by new { S.SpecialityName, S.LoginID } into g
                            select new OrgUsers
                            {
                                SpecialityName = g.Key.SpecialityName,
                                LoginID = g.Key.LoginID,


                            }).Distinct().ToList();

            strUserNames = new string[lstOrgUsers2.Count];
            for (int i = 0; i < lstOrgUsers2.Count; i++)
            {
                strUserNames[i] = lstOrgUsers2[i].SpecialityName + "~" + lstOrgUsers2[i].LoginID.ToString();


            }
            foreach (OrgUsers item in lstOrgUsers2)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.SpecialityName, item.LoginID.ToString()));
            }
        }
        return items.ToArray();
    }


    #endregion

    #region Get Bed Booked Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<RoomBookingDetails> loadBedBookedDetail(int orgID, int ILocationID, int BedID, string FromDate, string ToDate)
    {
        List<RoomBookingDetails> lstBedBookingDetail = new List<RoomBookingDetails>();
        try
        {
            RoomBooking_BL objRoomBookingBLL = new RoomBooking_BL(new BaseClass().ContextInfo);
            objRoomBookingBLL.GetBedBookedDetails(orgID, ILocationID, BedID, FromDate, ToDate, out lstBedBookingDetail);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lstDueDetail Message:", ex);
        }
        return lstBedBookingDetail;
    }
    #endregion

    #region Get Available Bed Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<RoomBookingDetails> GetAvailableBedsByTime(int orgID, int ILocationID, string FromDate, string ToDate, int BedID)
    {
        List<RoomBookingDetails> lstAvailableBedsByTime = new List<RoomBookingDetails>();
        try
        {
            RoomBooking_BL objRoomBookingBLL = new RoomBooking_BL(new BaseClass().ContextInfo);
            objRoomBookingBLL.GetAvailableBedsByTime(orgID, ILocationID, FromDate, ToDate, BedID, out lstAvailableBedsByTime);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetAvailableBedsByTime Message:", ex);
        }
        return lstAvailableBedsByTime;
    }
    #endregion


    #region GetAllOrgInvestigationsGroupandPKG
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetOrgInvestigationsGroupandPKG(string prefixText, string contextKey)
    {
        Schedule_BL scheduleBL = new Schedule_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBFD = new List<BillingFeeDetails>();
        string desc = prefixText;
        int orgID = 0;
        int locationid = 0;
        string ItemsType = string.Empty;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        ItemsType = strValue[1] == "" ? "" : strValue[1];
        scheduleBL.GetOrgInvestigationsGroupandPKG(orgID, locationid, desc, ItemsType, out lstBFD);
        if (lstBFD.Count > 0)
        {
            foreach (BillingFeeDetails item in lstBFD)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetAllPhysicianName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAllPhysicianName(string prefixText, string contextKey)
    {
        Physician_BL PhysicianBL = new Physician_BL(new BaseClass().ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        PhysicianBL.GetPhysicianNameByOrg(orgID, prefixText, out lstPhysician, 0);
        if (lstPhysician.Count > 0)
        {
            foreach (Physician item in lstPhysician)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.PhysicianName, item.PhysicianID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetClientNamebyClientType
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientNamebyClientType(string prefixText, string contextKey)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstclient = new List<ClientMaster>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        int ClientTypeId = 0;
        int CustomerTypeId = 0;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        Int32.TryParse(strValue[1], out ClientTypeId);
        Int32.TryParse(strValue[2], out CustomerTypeId);
        PatientBL.GetClientNamebyClientType(orgID, prefixText, ClientTypeId, CustomerTypeId, out lstclient);
        if (lstclient.Count > 0)
        {
            foreach (ClientMaster item in lstclient)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region DeltaCheckChart

    [WebMethod(EnableSession = true)]
    public String DrawChart(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
    {

        RuntimeChart runChart = new RuntimeChart();
        Chart m_chart = runChart.makeChart(VisitID, OrgID, PatternID, InvID);

        String tempFileName = String.Format("TempChartImage/Chart_{0}.png", System.Guid.NewGuid().ToString());
        //String tempFileName = "TempChartImage/Chart_1.png";

        tempFileName = Context.Server.MapPath(tempFileName);

        m_chart.SaveImage(tempFileName);

        String strImageSrc = @"TempChartImage/" + Path.GetFileName(tempFileName);

        ChartImageDestructor cid = new ChartImageDestructor(tempFileName);
        System.Web.Caching.CacheItemRemovedCallback onRemove = new System.Web.Caching.CacheItemRemovedCallback(cid.RemovedCallback);

        HttpContext.Current.Cache.Add(tempFileName, cid, null,
              DateTime.Now.AddMinutes(1),
              System.Web.Caching.Cache.NoSlidingExpiration,
              System.Web.Caching.CacheItemPriority.NotRemovable,
              onRemove);
        return strImageSrc;
    }

    [WebMethod(EnableSession = true)]
    public String CreateChart(Int64 VisitID, Int32 OrgID, Int64 PatternID, Int64 InvID)
    {
        String strImageSrc = string.Empty;
        try
        {
            RuntimeChart runChart = new RuntimeChart();
            Chart m_chart = runChart.CreateChart(VisitID, OrgID, PatternID, InvID);

            String tempFileName = String.Format("TempChartImage/Chart_{0}.png", System.Guid.NewGuid().ToString());

            tempFileName = Context.Server.MapPath(tempFileName);

            m_chart.SaveImage(tempFileName);

            strImageSrc = @"TempChartImage/" + Path.GetFileName(tempFileName);

            ChartImageDestructor cid = new ChartImageDestructor(tempFileName);
            System.Web.Caching.CacheItemRemovedCallback onRemove = new System.Web.Caching.CacheItemRemovedCallback(cid.RemovedCallback);

            HttpContext.Current.Cache.Add(tempFileName, cid, null,
                  DateTime.Now.AddMinutes(1),
                  System.Web.Caching.Cache.NoSlidingExpiration,
                  System.Web.Caching.CacheItemPriority.NotRemovable,
                  onRemove);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while generating past trend chart ", ex);
        }
        return strImageSrc;
    }
    #endregion

    #region GetGroupMasterDetails [GetGroupMasterDetails]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetGroupMasterDetails(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        //List<MetaValue_Common> lstmetavalues = new List<MetaValue_Common>();
        if (contextKey != "")
        {
            int orgID = 0;
            string Code = string.Empty;
            //Code = contextKey.ToString();
            int HubID = 0;
            string[] GEtContext = contextKey.Split('~');
            Code = GEtContext[0].ToString();
            HubID = Convert.ToInt32(GEtContext[1].ToString());
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);

            Master_BL.GetZoneDetails(orgID, Code, prefixText, HubID, out lstLocalities);
            if (lstLocalities.Count > 0)
            {
                foreach (Localities item in lstLocalities)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, item.Locality_ID.ToString()));
                }
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetSalesManname [GetSalesManname]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetSalesManname(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<EmployeeRegMaster> lstemployee = new List<EmployeeRegMaster>();
        int orgID = 0;
        string Designation = string.Empty;
        Designation = contextKey.ToString();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetSalesManname(orgID, Designation, prefixText, out lstemployee);
        if (lstemployee.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstemployee)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.EmpID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetCollectionCentreMaster [GetCollectionCentreMaster]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetCollectionCentreMaster(string prefixText, int count)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<OrganizationAddress> lstorgaddress = new List<OrganizationAddress>();
        int orgID = 0;
        string Designation = string.Empty;

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetCollectionCentreMaster(orgID, prefixText, out lstorgaddress);
        if (lstorgaddress.Count > 0)
        {
            foreach (OrganizationAddress item in lstorgaddress)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Location, item.AddressID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetGroupName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetGroupName(string prefixText, string contextKey)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<MetaType_Common> lstgroup = new List<MetaType_Common>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        int TypeID = 0;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);

        PatientBL.GetMetaName(orgID, prefixText, TypeID, out lstgroup);
        if (lstgroup.Count > 0)
        {
            foreach (MetaType_Common item in lstgroup)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.TypeName, item.MetaTypeId.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetGroupValueNameandID
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetGroupValueNameandID(string prefixText, string contextKey)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<MetaValue_Common> lstgroup = new List<MetaValue_Common>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        long TypeId = 0;
        long ValueID = 0;
        string Typedetails = string.Empty;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        PatientBL.GetMetaValuebyName(orgID, TypeId, ValueID, prefixText, Typedetails, out lstgroup);
        if (lstgroup.Count > 0)
        {
            foreach (MetaValue_Common item in lstgroup)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Value, item.MetaValueID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetGroupValuebyName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetGroupValuebyName(string prefixText, string contextKey)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<MetaValue_Common> lstgroup = new List<MetaValue_Common>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        long Typeid = 0;
        long Valueid = 0;

        string Typedetails = string.Empty;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        Int64.TryParse(strValue[1], out Typeid);
        PatientBL.GetMetaValuebyName(orgID, Typeid, Valueid, prefixText, Typedetails, out lstgroup);
        if (lstgroup.Count > 0)
        {
            foreach (MetaValue_Common item in lstgroup)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Value, item.MetaValueID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetAllClientListForDiscountMaster [DiscountMaster]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientforDiscount(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
        int orgID = 0;
        int typeid = 0;
        typeid = Convert.ToInt32(contextKey);
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetClientforDiscount(orgID, prefixText, typeid, out lstInvClientMaster);
        if (lstInvClientMaster.Count > 0)
        {
            foreach (InvClientMaster item in lstInvClientMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    #region GetIdentifyingValue
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetIdentifyingValue(string prefixText, string contextKey)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<EmployeeRegMaster> lstERM = new List<EmployeeRegMaster>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        string GroupName = string.Empty;
        string Typedetails = string.Empty;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        GroupName = strValue[1].ToString();
        PatientBL.GetIdentifyingValue(orgID, GroupName, prefixText, out lstERM);
        if (lstERM.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstERM)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.EmpID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion
    #region GETSurgeryName from ipTreatmentplanmaster
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getProcedureNames(string prefixText, string contextKey)
    {
        long orgID = Convert.ToInt64(contextKey);
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        IP_BL IPBL = new IP_BL(new BaseClass().ContextInfo);
        List<SurgeryPackageMaster> lstTreatementPlannamess = new List<SurgeryPackageMaster>();
        long returnCode = -1;
        List<string> lstTreatementPlannames = new List<string>();
        // lstTreatementPlannames =Convert.ToString(prefixText);
        string[] strtreatmentplanNames = null;
        returnCode = IPBL.GetTreatmentPlanNames(prefixText, orgID, out lstTreatementPlannamess);
        if (lstTreatementPlannamess.Count > 0)
        {
            strtreatmentplanNames = new string[lstTreatementPlannamess.Count];
            for (int i = 0; i < lstTreatementPlannamess.Count; i++)
            {
                strtreatmentplanNames[i] = lstTreatementPlannamess[i].PackageID + "/" + lstTreatementPlannamess[i].PackageName + "/" + lstTreatementPlannamess[i].Amount;
            }
        }
        return strtreatmentplanNames;
    }



    #endregion


    #region GetAllAnesthesiastName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAnesthesiastNames(string prefixText, string contextKey)
    {
        int orgID = Convert.ToInt32(contextKey);
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        IP_BL IPBL = new IP_BL(new BaseClass().ContextInfo);
        List<Physician> lstOrgUsers = new List<Physician>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = IPBL.GetAnesthesiastNames(orgID, orgUserName, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            strUserNames = new string[lstOrgUsers.Count];
            for (int i = 0; i < lstOrgUsers.Count; i++)
            {
                strUserNames[i] = lstOrgUsers[i].PhysicianName;
            }
        }
        return strUserNames;
    }
    #endregion

    #region GetPackagesName

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPackageNames(int OrgID, string contextKey)
    {
        int orgID = Convert.ToInt32(contextKey);
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        IP_BL IPBL = new IP_BL(new BaseClass().ContextInfo);
        List<SurgeryPackageMaster> lstPackages = new List<SurgeryPackageMaster>();
        long returnCode = -1;

        string[] strPackageNames = null;
        returnCode = IPBL.GetSurgeryPackageNames(orgID, out lstPackages);
        if (lstPackages.Count > 0)
        {
            strPackageNames = new string[lstPackages.Count];
            for (int i = 0; i < lstPackages.Count; i++)
            {
                strPackageNames[i] = lstPackages[i].PackageName;
            }
        }
        return strPackageNames;
    }
    #endregion


    /*  #region GetAllProductsfrominventory
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetProsthesis(string prefixText, int count)
    {
        Inventory_BL inventoryBL = new Inventory_BL(new BaseClass().ContextInfo);
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        int LocationID = 0;
        Int32.TryParse(Session["LocationID"].ToString(), out LocationID);
        int InventoryLocationID = 0;
        Int32.TryParse(Session["InventoryLocationID"].ToString(), out InventoryLocationID);
        List<string> items = new List<string>();
        List<InventoryItemsBasket> lstProducts = new List<InventoryItemsBasket>();
        new Inventory_BL(new BaseClass().ContextInfo).GetAllProducts(orgID, LocationID, 0, prefixText, InventoryLocationID, out lstProducts);
        if (lstProducts.Count > 0)
        {
            foreach (InventoryItemsBasket item in lstProducts.Take(lstProducts.Count))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ProductName, item.Description + '~' + item.ProductID + '~' + item.LSUnit + '~' + item.ParentProductID + '~' + item.Attributes + '~' + item.Type));
            }
        }
        return items.ToArray();
    }
    #endregion*/

    #region GetAllEmployeeName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAllEmployeeName(string prefixText, string contextKey)
    {
        Users_BL UsersBL = new Users_BL(new BaseClass().ContextInfo);
        List<EmployeeRegMaster> lstEmpReg = new List<EmployeeRegMaster>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        UsersBL.GetEmpRegName(orgID, prefixText, out lstEmpReg);
        if (lstEmpReg.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstEmpReg)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.EmpID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion


    //Added By Gurunath S
    #region GetHubDetails [GetHubDetails]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetHubDetails(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        //List<MetaValue_Common> lstmetavalues = new List<MetaValue_Common>();
        int orgID = 0;
        string Code = string.Empty;
        Code = contextKey.ToString();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetGroupMasterDetails(orgID, Code, prefixText, out lstLocalities);
        if (lstLocalities.Count > 0)
        {
            foreach (Localities item in lstLocalities)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetSpecifiedDeptEmployee [GetSpecifiedDeptEmployee]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetSpecifiedDeptEmployee(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        int orgID = 0;
        string DeptCode = string.Empty;
        if (!String.IsNullOrEmpty(contextKey) && contextKey.Length > 0)
        {
            DeptCode = contextKey;
        }
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        Master_BL.GetSpecifiedDeptEmployee(orgID, DeptCode, prefixText, out lstEmployeeRegMaster);
        if (lstEmployeeRegMaster.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstEmployeeRegMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.EmpID.ToString() + "~" + item.MobileNo + "~" + item.LandlineNo + "~" + item.EMail));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region InvSummaryReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInvSuggested(string prefixText, int count, string contextKey)
    {
        List<InvestigationMaster> lstInvMaster = new List<InvestigationMaster>();
        List<string> items = new List<string>();
        try
        {
            Int32 orgID = contextKey != null ? Convert.ToInt32(contextKey) : 0;
            new Investigation_BL(new BaseClass().ContextInfo).GetInvSuggested(orgID, prefixText, out lstInvMaster);
            if (lstInvMaster.Count > 0)
            {
                foreach (InvestigationMaster item in lstInvMaster)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.InvestigationName, item.InvestigationID.ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInvSuggested: ", ex);
        }
        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetComplaints(string prefixText, int count, string contextKey)
    {
        List<Complaint> lstComplaint = new List<Complaint>();
        List<string> items = new List<string>();
        try
        {
            Int32 orgID = contextKey != null ? Convert.ToInt32(contextKey) : 0;
            new Investigation_BL(new BaseClass().ContextInfo).GetComplaints(orgID, prefixText, out lstComplaint);
            if (lstComplaint.Count > 0)
            {
                foreach (Complaint item in lstComplaint)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ComplaintName, item.ComplaintId.ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetComplaints: ", ex);
        }
        return items.ToArray();
    }
    #endregion

    #region GetHospAndRefPhy [GetHospAndRefPhy]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetHospAndRefPhy(string prefixText, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        List<string> items = new List<string>();
        int orgID = 0;
        if (contextKey != "")
        {
            int ClientTypeID = Convert.ToInt32(contextKey);
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            Master_BL.GetHospAndRefPhy(orgID, prefixText, ClientTypeID, out lstClientMaster);
            if (lstClientMaster.Count > 0)
            {
                foreach (ClientMaster item in lstClientMaster)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
                }
            }
        }
        return items.ToArray();


    }
    #endregion

    #region GetSummaryReportTemplate [GetSummaryReportTemplate]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetSummaryReportTemplate(string prefixText, int count, string contextKey)
    {
        List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();




        List<string> items = new List<string>();
        try
        {
            string[] param = contextKey.Split('~');
            Int32 orgID = param[0] != null ? Convert.ToInt32(param[0]) : 0;
            String templateType = param[1] != null ? param[1] : string.Empty;
            new Investigation_BL(new BaseClass().ContextInfo).GetSummaryReportTemplate(orgID, templateType, prefixText, out lstInvResultTemplate);
            if (lstInvResultTemplate.Count > 0)
            {
                foreach (InvResultTemplate item in lstInvResultTemplate)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ResultName, item.ResultValues));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetComplaints: ", ex);
        }
        return items.ToArray();

    }
    #endregion

    #region GetTODCodeAndID [GetTODCodeAndID]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTODCodeAndID(string prefixText, string contextKey)
    {
        Referrals_BL objReferral = new Referrals_BL(new BaseClass().ContextInfo);
        List<DiscountPolicy> lstDiscountPolicy = new List<DiscountPolicy>();
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        int count = 0;
        int ExecuteType = 0;
        if (contextKey == "TOD" || contextKey == "TAX" || contextKey == "DCP" || contextKey == "TOV")
            ExecuteType = 1;
        objReferral.GetCheckCode(contextKey, prefixText, ExecuteType, out count, orgID, out lstDiscountPolicy);
        if (lstDiscountPolicy.Count > 0)
        {
            foreach (DiscountPolicy item in lstDiscountPolicy)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Code, item.TODID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetTrustedOrgPolicy [GetTrustedOrgPolicy]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTrustedOrgPolicy(string prefixText, string contextKey)
    {
        Referrals_BL objReferral = new Referrals_BL(new BaseClass().ContextInfo);
        List<DiscountPolicy> lstDiscountPolicy = new List<DiscountPolicy>();
        List<string> items = new List<string>();
        int orgID = 0;
        int count = 0;
        int ExecuteType = 1;
        string getType = "";
        string[] sType = contextKey.Split('~');
        if (!String.IsNullOrEmpty(sType[1]) && sType[1].Length > 0)
            orgID = Convert.ToInt32(sType[1]);
        if (!String.IsNullOrEmpty(sType[0]) && sType[0].Length > 0)
            getType = sType[0];
        objReferral.GetCheckCode(getType, prefixText, ExecuteType, out count, orgID, out lstDiscountPolicy);
        if (lstDiscountPolicy.Count > 0)
        {
            foreach (DiscountPolicy item in lstDiscountPolicy)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Code, item.TODID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetTODCode
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTODCode(string prefixText, string contextKey)
    {
        Master_BL MasterBL = new Master_BL(new BaseClass().ContextInfo);
        List<DiscountPolicy> lstTOD = new List<DiscountPolicy>();
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        MasterBL.GetTODCode(orgID, prefixText, out lstTOD);
        if (lstTOD.Count > 0)
        {
            foreach (DiscountPolicy item in lstTOD)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Code, item.TODID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetClientMappingService(string CidAndRefID)
    {
        long returnCode = -1;
        long Client = -1;
        int OrgID = 0;
        string refType = "";
        string serviceDetails = "";
        try
        {
            string[] strValue = CidAndRefID.Split('~');
            if (strValue.Length > 0)
            {
                Client = Convert.ToInt64(strValue[0].Split('|')[0]);
                refType = strValue[1];
            }

            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            Master_BL objMasterBL = new Master_BL(new BaseClass().ContextInfo);
            List<ClientMappingService> lstClientMappingService = new List<ClientMappingService>();
            returnCode = objMasterBL.GetClientMappingService(OrgID, Client, refType, out lstClientMappingService);
            foreach (ClientMappingService obj in lstClientMappingService)
            {
                serviceDetails += obj.ClientServiceDetails + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting ClientMappingService ", ex);
        }




        return serviceDetails;
    }

    //InvRemarks
    #region Get Investigation Remarks used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInvRemarks(string prefixText, int count, string contextKey)
    {
        List<Remarks> lstRemarks = new List<Remarks>();
        List<string> items = new List<string>();
        long returnCode = -1;

        string[] strArray1 = contextKey.Split('~');
        long lngInvID = Convert.ToInt64(strArray1[0]);
        string strType = strArray1[1];
        int intOrgID = Convert.ToInt32(strArray1[2]);
        long lngRoleID = Convert.ToInt64(strArray1[3]);

        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvRemarks(lngInvID, intOrgID, strType, prefixText, lngRoleID, "T", out lstRemarks);

        if (lstRemarks.Count > 0)
        {
            if (strType == "INV")
            {
                foreach (Remarks item in lstRemarks)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RemarksText, item.RemarksID.ToString()));
                }
            }
            if (strType == "GRP")
            {
                foreach (Remarks item in lstRemarks)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RemarksText, lngInvID.ToString() + "~" + item.RemarksID.ToString() + "~" + item.RemarksText));
                }
            }
        }
        return items.ToArray();
    }
    #endregion

    //Medical Remarks
    #region Get Investigation Remarks used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInvMedicalRemarks(string prefixText, int count, string contextKey)
    {
        List<Remarks> lstRemarks = new List<Remarks>();
        List<string> items = new List<string>();
        long returnCode = -1;

        string[] strArray1 = contextKey.Split('~');
        long lngInvID = Convert.ToInt64(strArray1[0]);
        string strType = strArray1[1];
        int intOrgID = Convert.ToInt32(strArray1[2]);
        long lngRoleID = Convert.ToInt64(strArray1[3]);

        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvRemarks(lngInvID, intOrgID, strType, prefixText, lngRoleID, "M", out lstRemarks);

        if (lstRemarks.Count > 0)
        {
            if (strType == "INV")
            {
                foreach (Remarks item in lstRemarks)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RemarksText, item.RemarksID.ToString()));
                }
            }
            if (strType == "GRP")
            {
                foreach (Remarks item in lstRemarks)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RemarksText, lngInvID.ToString() + "~" + item.RemarksID.ToString() + "~" + item.RemarksText));
                }
            }
        }
        return items.ToArray();
    }
    #endregion
    //InvRemarks

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool GetPrintPolicy(Int32 patOrgID, Int64 VisitID, String PrintReport, String PrintType)
    {
        bool isExceeded = false;
        try
        {
            long returnCode = -1;
            Int32 pOrgID = 0;
            Int32 OrgID = 0;
            Int64 RoleID = 0;
            Int64 ILocationID = 0;
            if (Session["OrgID"] != null)
            {
                Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            }
            if (Session["RoleID"] != null)
            {
                Int64.TryParse(Session["RoleID"].ToString(), out RoleID);
            }
            if (Session["LocationID"] != null)
            {
                Int64.TryParse(Session["LocationID"].ToString(), out ILocationID);
            }
            if (patOrgID != OrgID)
            {
                pOrgID = patOrgID;
            }
            else
            {
                pOrgID = OrgID;
            }

            Master_BL oMaster_BL = new Master_BL(new BaseClass().ContextInfo);
            List<PrintPolicy> lstPrintPolicy = new List<PrintPolicy>();
            returnCode = oMaster_BL.GetPrintPolicy(pOrgID, RoleID, ILocationID, out lstPrintPolicy);

            if (lstPrintPolicy.Count > 0)
            {
                PrintPolicy oPrintPolicy = lstPrintPolicy[0];
                if (oPrintPolicy != null)
                {
                    Int32 printPolicyCount = 0;
                    Int32.TryParse(oPrintPolicy.Value, out printPolicyCount);
                    Int32 printCount = 0;

                    List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                    if (PrintType == "batch")
                    {
                        List<InvReportMaster> lstReport = new List<InvReportMaster>();
                        List<InvReportMaster> lstReportName = new List<InvReportMaster>();
                        List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();

                        Patient_BL objPatientBL = new Patient_BL(new BaseClass().ContextInfo);
                        objPatientBL.GetReportTemplate(VisitID, pOrgID, "", out lstReport, out lstReportName, out lstDpts);

                        if (lstReport.Count > 0)
                        {
                            List<InvReportMaster> lstSelectedReports = new List<InvReportMaster>();
                            lstSelectedReports = (from child in lstReport
                                                  where child.Status == InvStatus.Approved
                                                  select child).ToList();
                            if (lstSelectedReports != null && lstSelectedReports.Count > 0)
                            {
                                lstReportPrintHistory = (from SR in lstSelectedReports
                                                         select new ReportPrintHistory { AccessionNumber = SR.AccessionNumber, InvestigationID = SR.InvestigationID, Status = SR.Status }).Distinct().ToList();
                            }
                        }
                    }
                    else
                    {
                        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                        lstReportPrintHistory = oJavaScriptSerializer.Deserialize<List<ReportPrintHistory>>(PrintReport);
                    }

                    Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);

                    List<ReportPrintHistory> lstReportPrintCount = new List<ReportPrintHistory>();
                    returnCode = objReportBL.GetReportPrintHistory(pOrgID, VisitID, AuditManager.AuditTypeCode.Print, out lstReportPrintCount);
                    //List<ReportPrintHistory> lstResult = new List<ReportPrintHistory>();
                    //if (lstReportPrintCount.Count > 0)
                    //{
                    //    lstResult = lstReportPrintCount.Where(RPC => RPC.OrgID == pOrgID).ToList();
                    //    if (!String.IsNullOrEmpty(oPrintPolicy.RoleName))
                    //    {
                    //        lstResult = lstResult.Where(RPC => RPC.RoleID == RoleID).ToList();
                    //    }
                    //    if (!String.IsNullOrEmpty(oPrintPolicy.LocationName))
                    //    {
                    //        lstResult = lstResult.Where(RPC => RPC.OrgAddressID == ILocationID).ToList();
                    //    }
                    //    if (lstResult == null || lstResult.Count <= 0)
                    //    {
                    //        lstResult = lstReportPrintCount.Where(RPC => RPC.OrgID == pOrgID).ToList();
                    //    }
                    //}
                    if (lstReportPrintHistory != null)
                    {
                        foreach (ReportPrintHistory oReportPrintHistory in lstReportPrintHistory)
                        {
                            printCount = lstReportPrintCount.Where(RPC => RPC.AccessionNumber == oReportPrintHistory.AccessionNumber).Distinct().Count();
                            if (printCount >= printPolicyCount)
                            {
                                isExceeded = true;
                                break;
                            }
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting print policy ", ex);
        }
        return isExceeded;
    }

    #region getServiceNames
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getServiceNames(string prefixText, string contextKey)
    {

        string[] values = contextKey.Split('~');
        Int32 orgID = values[0] != null ? Convert.ToInt32(values[0]) : 0;
        string ServiceType = values[1] != "" ? Convert.ToString(values[1]) : "";
        //Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        Master_BL objBL = new Master_BL(new BaseClass().ContextInfo);
        List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();

        long returnCode = -1;

        List<string> lstTreatementPlannames = new List<string>();
        // lstTreatementPlannames =Convert.ToString(prefixText);
        string[] strtreatmentplanNames = null;
        returnCode = objBL.GetServiceNames(orgID, ServiceType, prefixText, out lstDetails);


        if (lstDetails.Count > 0)
        {
            strtreatmentplanNames = new string[lstDetails.Count];
            for (int i = 0; i < lstDetails.Count; i++)
            {
                strtreatmentplanNames[i] = lstDetails[i].ID + "/" + lstDetails[i].Descrip;
            }
        }

        return strtreatmentplanNames;
    }
    #endregion
    [WebMethod(EnableSession = true)]
    public string GetNextBarcode()
    {
        string BarCode = string.Empty;
        long returnCode = -1;
        long pOrgAddressID = -1;
        long RefID = -1; string RefType = "";
        try
        {
            if (Session["OrgID"] != null)
            {
                Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
                Investigation_BL InvBL = new Investigation_BL(new BaseClass().ContextInfo);
                if ((Session["LocationID"]) != null)
                {
                    Int64.TryParse(Session["LocationID"].ToString(), out pOrgAddressID);
                }
                returnCode = InvBL.GetNextBarcode(OrgID, pOrgAddressID, "BCODE", out BarCode, RefID, RefType);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting next barcode", ex);
        }
        return BarCode;
    }
    #region GetReceptionistsms
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetSMSRecipientsList(string prefixText, string contextKey)
    {
        List<Patient> lstRecipients = new List<Patient>();
        Patient_BL PBL = new Patient_BL(new BaseClass().ContextInfo);
        DateTime FromDate= Convert.ToDateTime("01/01/1753 12:00:00"),ToDate=DateTime.MaxValue;
        List<string> items = new List<string>();
        string desc = prefixText;
        int orgID = 0;
        string[] strValue = contextKey.Split('~');
        int OrgID = Convert.ToInt32(contextKey.Split('~')[0]);
        string Types = contextKey.Split('~')[1];
        string bday = contextKey.Split('~')[2];
        if (contextKey.Split('~')[3] != "")
            FromDate = Convert.ToDateTime(contextKey.Split('~')[3]);
        if (contextKey.Split('~')[4] != "")
            ToDate = Convert.ToDateTime(contextKey.Split('~')[4]);


        Int32.TryParse(strValue[0], out orgID);
        PBL.GetSMSRecipientsList(OrgID,prefixText, Types, prefixText, bday, out lstRecipients, currentPageNo, PageSize,FromDate,ToDate, out  totalRows);
        if (lstRecipients.Count > 0)
        {
            foreach (Patient item in lstRecipients)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.PatientID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion
    #region TestMaster
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetTestCodingScheme(string prefixText, int count, string contextKey)
    {
        List<CodingScheme> lstCodeMapper = new List<CodingScheme>();
        List<string> items = new List<string>();
        try
        {
            string[] param = contextKey.Split('~');
            Int32 orgID = param[0] != null ? Convert.ToInt32(param[0]) : 0;
            String pType = param[1] != null ? param[1] : string.Empty;
            new Master_BL(new BaseClass().ContextInfo).GetTestCodingScheme(orgID, pType, prefixText, out lstCodeMapper);
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
    [ScriptMethod()]
    public string[] GetRemarkDetails(string prefixText, int count, string contextKey)
    {
        List<Remarks> lstRemarks = new List<Remarks>();
        List<string> items = new List<string>();
        try
        {
            String pRemarksType = string.Empty;
            if (!String.IsNullOrEmpty(contextKey))
                pRemarksType = contextKey + ",B";
            new Master_BL(new BaseClass().ContextInfo).GetRemarkDetails(pRemarksType, prefixText, out lstRemarks);
            if (lstRemarks.Count > 0)
            {
                foreach (Remarks item in lstRemarks)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RemarksText, item.RemarksID.ToString() + "~" + item.RemarksCode));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetRemarkDetails: ", ex);
        }
        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrganizationAddress> GetTestProcessingLocation(Int32 OrgID, Int32 LocationID, String SubCategory)
    {
        long returnCode = -1;
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.GetTestProcessingLocation(OrgID, SubCategory, out lstLocation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting location ", ex);
        }
        return lstLocation;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Users> GetAutoAuthorizeUser(int OrgID, long RoleID)
    {
        long returnCode = -1;
        List<Users> lstUsers = new List<Users>();
        try
        {
            Users_BL oUsersBL = new Users_BL(new BaseClass().ContextInfo);
            returnCode = oUsersBL.GetAutoAuthorizeUser(OrgID, RoleID, out lstUsers);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting auto authorize user ", ex);
        }
        return lstUsers;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public string[] ConvertReferenceRangeXml(string rawData)
    {
        string[] lstContent = new string[3];
        string xmlContent = string.Empty;
        string xmlValue = string.Empty;
        string xmlString = string.Empty;
        string Tempxml = string.Empty;
        try
        {
            LabUtil oLabUtil = new LabUtil();
            oLabUtil.ConvertXmlToExtend(rawData, out xmlContent, out xmlValue, out xmlString, Tempxml);
            lstContent[0] = xmlContent;
            lstContent[1] = xmlValue;
            lstContent[2] = xmlString;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting reference range xml content ", ex);
        }
        return lstContent;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteInvOrgRefMapping(long InvRefMappingID, long DeviceMappingID, long InvID, int OrgID)
    {
        long returnCode = -1;
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.DeleteInvOrgRefMapping(InvRefMappingID, DeviceMappingID, InvID, OrgID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting InvOrgRefMapping details ", ex);
        }
    }
    #endregion

    #region GetGeneralPattern
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<TabularPatternConfigurationMaster> GetGeneralPattern(long Pinvid, int OrgID)
    {
        long result = -1;
        List<TabularPatternConfigurationMaster> lstGeneralPattern = new List<TabularPatternConfigurationMaster>();
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        result = Inv_BL.GetGeneralPattern(Pinvid, out lstGeneralPattern, OrgID);
        return lstGeneralPattern;
    }
    #endregion
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvGroupMaster> GetGroupPackageName(string DiscName, string OrgID, string Type)
    {
        //This WebMethod is using in the InvestigationApprovel page, Created by Syed      
        long result = -1;
        int Orgid = Convert.ToInt32(OrgID);
        List<InvGroupMaster> lstInvestigationMaster = new List<InvGroupMaster>();
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        result = Inv_BL.SearchInvGrpName(DiscName, Orgid, Type, out lstInvestigationMaster);

        return lstInvestigationMaster;
    }

    #region Get Episode Visit Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<EpisodeVisitDetails> GetEpisodeVisitDetails(string pOrgID, string pEpiosdeID, string pClientID, string pRateID)
    {
        int OrgID = 0;
        long ClientID = -1;
        long EpiosdeID = -1;
        int RateID = 0;
        OrgID = Convert.ToInt32(pOrgID);
        EpiosdeID = Convert.ToInt64(pEpiosdeID);
        ClientID = Convert.ToInt64(pClientID);
        RateID = Convert.ToInt32(pRateID);
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        new BillingEngine(new BaseClass().ContextInfo).GetEpisodeVisitDetails(OrgID, ClientID, EpiosdeID, RateID, out lstEpisodeVisitDetails);
        return lstEpisodeVisitDetails;
    }
    #endregion
    #region Get Episode Visit Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientInvSample> GetDeptToTrackSamplesWithID(string pOrgID, string pInvID, string pType)
    {
        int OrgID = 0;
        long ClientID = -1;
        long InvID = -1;
        OrgID = Convert.ToInt32(pOrgID);
        InvID = Convert.ToInt64(pInvID);
        string Type = pType.ToString();
        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();

        //vignesh............

        ////new Investigation_BL(new BaseClass().ContextInfo).GetDeptToTrackSamplesWithID(InvID, Type, OrgID, out lstPatientInvSample);
        return lstPatientInvSample;
    }
    #endregion

    #region GetDiscountPolicyMapping
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<DiscountPolicyMapping> GetDiscountPolicyMapping(int OrgID, long PolicyID)
    {
        long returnCode = -1;
        List<DiscountPolicyMapping> lstDiscountPolicyMapping = new List<DiscountPolicyMapping>();
        try
        {
            Master_BL objMaster = new Master_BL(new BaseClass().ContextInfo);
            returnCode = objMaster.GetDiscountPolicyMapping(OrgID, PolicyID, out lstDiscountPolicyMapping);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetDiscountPolicyMapping", ex);
        }
        return lstDiscountPolicyMapping;
    }
    #endregion

    #region GetRateTypeMaster
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<RateMaster> GetRateTypeMaster(int OrgID, string OrgType)
    {
        long returnCode = -1;
        List<RateMaster> lstRateMaster = new List<RateMaster>();
        try
        {
            AdminReports_BL objBl = new AdminReports_BL(new BaseClass().ContextInfo);
            returnCode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetRateTypeMaster", ex);
        }
        return lstRateMaster;
    }
    #endregion

    #region pSaveRateOrgMapping
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long pSaveRateOrgMapping(int RateID, int TrustedOrgID, long PolicyID, long CreatedBy)
    {
        long returnCode = -1;
        try
        {
            AdminReports_BL objAdminReports = new AdminReports_BL(new BaseClass().ContextInfo);
            string RateName = "";
            int UserID = -1;
            returnCode = objAdminReports.SaveRateOrgMap(RateName, RateID, TrustedOrgID, UserID, PolicyID, "UPD", CreatedBy);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving RatepSaveRateOrgMapping", ex);
        }
        return returnCode;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetMergePhysicianPatient(string prefixText, int count, string contextKey)
    {
        List<DayWiseCollectionReport> lstCollections = new List<DayWiseCollectionReport>();
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        long retCode = -1;
        int OrgID = 0;
        List<string> items = new List<string>();
        try
        {
            //string[] PatientList = null;
            string pType = string.Empty, FromDate = string.Empty, ToDate = string.Empty, FindPosition = String.Empty, ContactNumber = string.Empty, MergeType = string.Empty;
            string[] key = contextKey.Split('~');
            OrgID = Convert.ToInt16(key[0]);
            pType = key[1];
            FromDate = key[2];
            ToDate = key[3];
            FindPosition = key[4];
            ContactNumber = key[5];
            MergeType = key[6];
            retCode = be.GetMergePhysicianPatient(prefixText, OrgID, pType, FromDate, ToDate, FindPosition, ContactNumber, MergeType, out lstCollections);
            if (lstCollections.Count > 0)
            {
                foreach (DayWiseCollectionReport item in lstCollections.Take(30))
                {
                    try
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.PhysicianName, item.Description));
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error GetMergePhysicianPatient", ex);
                    }
                }

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetMergePhysicianPatient in WebService.cs", ex);
        }
        return items.ToArray();

    }

    #region Get Episode Visit Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Organization> GetOrgDetailsWithTypeLevel(string pID, string pTypeLevel)
    {
        List<Organization> lstOrganization = new List<Organization>();
        int OrgID = 0;
        long ClientID = -1;
        string TypeLevel = string.Empty;
        Int64.TryParse(pID, out ClientID);
        TypeLevel = pTypeLevel;
        new ClinicalTrail_BL(new BaseClass().ContextInfo).GetOrgDetailsWithTypeLevel(ClientID, TypeLevel, out lstOrganization);
        return lstOrganization;
    }
    #endregion

    #region Get ConsignmentNo Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<EpiContainerTracking> GetConsignmentNoDetails(string pEpisodeID, string pSiteID, string pOrgID, string pType, string pConsignmentNo)
    {
        List<Organization> lstOrganization = new List<Organization>();
        int OrgID = 0;
        long EpisodeID = -1;
        long SiteID = -1;
        string Type = string.Empty;
        string ConsignmentNo = string.Empty;
        Int32.TryParse(pOrgID, out OrgID);
        Int64.TryParse(pEpisodeID, out EpisodeID);
        Int64.TryParse(pSiteID, out SiteID);
        Type = pType;
        ConsignmentNo = pConsignmentNo;

        List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();

        new BillingEngine(new BaseClass().ContextInfo).GetConsignmentNo(EpisodeID, SiteID, OrgID, pType, ConsignmentNo, out lstEpiContainerTracking);

        return lstEpiContainerTracking;
    }
    #endregion
    #region Get WorkListID
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetWorkListID(string prefixText, int count, string contextKey)
    {
        List<PatientInvestigation> lstWorkListId = new List<PatientInvestigation>();
        List<string> items = new List<string>();
        try
        {
            int OrgID = 0;
            string WLID = string.Empty;
            OrgID = Convert.ToInt32(contextKey);
            WLID = prefixText;

            new Investigation_BL(new BaseClass().ContextInfo).GetWorkListIds(WLID, OrgID, out lstWorkListId);
            if (lstWorkListId.Count > 0)
            {
                foreach (PatientInvestigation item in lstWorkListId)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.WorkListID.ToString(), item.WorkListID.ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetRemarkDetails: ", ex);
        }
        return items.ToArray();
    }
    #endregion

    #region Culture & Sensitivity Pattern 2
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetInvestigationBulkData(string prefixText, int count, string contextKey)
    {
        List<InvestigationBulkData> lstInvBulkData = new List<InvestigationBulkData>();
        List<string> items = new List<string>();
        try
        {
            string[] param = contextKey.Split('~');
            Int64 invID = param[0] != null ? Convert.ToInt32(param[0]) : 0;
            String pName = param[1] != null ? param[1] : string.Empty;
            Investigation_BL IBL = new Investigation_BL(new BaseClass().ContextInfo);
            IBL.GetInvestigationBulkData(invID, pName, prefixText, out lstInvBulkData);
            if (lstInvBulkData.Count > 0)
            {
                foreach (InvestigationBulkData item in lstInvBulkData)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Value, item.Value));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInvestigationBulkData: ", ex);
        }
        return items.ToArray();
    }
    #endregion
    #region GetChequeDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<AmountReceivedDetails> GetChequeDeatails(string BankName, string ChequeorCardNumber, int OrgID)
    {
        long returnCode = -1;
        List<AmountReceivedDetails> lstAmountReceivedDetails = new List<AmountReceivedDetails>();
        try
        {
            Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
            returnCode = PatientBL.SearchBankcheckNo(BankName, ChequeorCardNumber, OrgID, out lstAmountReceivedDetails);
            // new Patient_BL(new BaseClass().ContextInfo).SearchBankcheckNo(BankName, ChequeorCardNumber, OrgID, out lstAmountReceivedDetails); 

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting lstAmountReceivedDetails ", ex);
        }
        return lstAmountReceivedDetails;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long GetBillApprovalDetails(string PatientDetails, string AmountDetails)
    {
        int GetBADId = 0;
        long returnCode = -1;

        try
        {
            string PatientId = string.Empty, PatientName = string.Empty, PatientAge = string.Empty, VisitPurposeID = string.Empty, ApprovalType = string.Empty, PaymentAmount = String.Empty, BankName = string.Empty, PaymentCardNo = string.Empty, CheckDate = string.Empty,
                CardHolderName = string.Empty, Discount = string.Empty, NetAmount = string.Empty, FeeDescription = string.Empty, Comments = string.Empty;
            if (PatientDetails != "")
            {
                string[] key = PatientDetails.Split('~');
                PatientId = key[0];
                PatientName = key[1];
                PatientAge = key[2];
                VisitPurposeID = key[3];
                ApprovalType = key[5];
                PaymentAmount = key[6];
                BankName = key[7];
                PaymentCardNo = key[8];
                //  CheckDate = key[7];
                CheckDate = "";
                CardHolderName = key[10];
                Discount = key[11];
                NetAmount = key[12];
                Comments = key[13];
            }
            AmountApprovalDetails AmountApprovalDetails = new AmountApprovalDetails();
            AmountApprovalDetails.PatientId = Convert.ToInt16(PatientId);
            AmountApprovalDetails.PatientName = PatientName;
            AmountApprovalDetails.Age = PatientAge;
            AmountApprovalDetails.VisitPurposeID = Convert.ToInt16(VisitPurposeID);
            AmountApprovalDetails.ApprovalType = ApprovalType;
            AmountApprovalDetails.PaymentAmount = Convert.ToDecimal(PaymentAmount);
            AmountApprovalDetails.BankName = BankName;
            AmountApprovalDetails.PaymentCardNo = PaymentCardNo;
            if (CheckDate != "")
                AmountApprovalDetails.ChequeValidDate = Convert.ToDateTime(CheckDate);
            else
                AmountApprovalDetails.ChequeValidDate = DateTime.Now;
            AmountApprovalDetails.CardHolderName = CardHolderName;
            AmountApprovalDetails.Discount = Convert.ToDecimal(Discount);
            AmountApprovalDetails.NetAmount = Convert.ToDecimal(NetAmount);
            AmountApprovalDetails.Comments = Comments;
            string strXml = string.Empty;

            XmlDocument xmlDoc = new XmlDocument();
            if (AmountDetails != "")
            {
                xmlDoc.LoadXml("<AmountDetails></AmountDetails>");
                XmlNode xmlNode;
                XmlElement xmlElement = xmlDoc.CreateElement("AmountDetail");
                //XmlNode declaration = xmlDoc.CreateNode(XmlNodeType.XmlDeclaration, null, null);
                //xmlDoc.AppendChild(declaration);
                //XmlElement root;
                //root = xmlDoc.CreateElement("AmountDetails");
                //xmlDoc.AppendChild(root);

                //string[] prescription = AmountDetails;
                string newPrescription = string.Empty;
                string dtoRemove = string.Empty;
                string sNewDatas = "";
                sNewDatas = AmountDetails;
                foreach (string row in sNewDatas.Split('|'))
                {
                    //  XmlElement Attribute = xmlDoc.CreateElement("AmountDetail");
                    // root.AppendChild(Attribute);
                    if (row.Trim().Length != 0)
                    {
                        foreach (string column in row.Split('~'))
                        {
                            string[] colNameValue;
                            string colName = string.Empty;
                            string colValue = string.Empty;
                            colNameValue = column.Split('^');
                            colName = colNameValue[0];
                            if (colNameValue.Length > 1)
                                colValue = colNameValue[1];
                            colValue = colValue.Trim();
                            switch (colName)
                            {
                                case "FeeID":
                                    colValue = colValue == "" ? "0" : colValue;

                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "FeeID", "");
                                    xmlNode.InnerText = colValue;
                                    xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                                    //XmlAttribute FeeID = xmlDoc.CreateAttribute("FeeID");
                                    //FeeID.Value = colValue;
                                    //Attribute.Attributes.Append(FeeID);

                                    break;

                                case "Descrip":
                                    //XmlAttribute Descrip = xmlDoc.CreateAttribute("Descrip");
                                    //Descrip.Value = colValue;
                                    //Attribute.Attributes.Append(Descrip);
                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Descrip", "");
                                    xmlNode.InnerText = colValue;
                                    xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                                    break;
                                case "Amount":
                                    colValue = colValue == "" ? "0" : colValue;
                                    //XmlAttribute Amount = xmlDoc.CreateAttribute("Amount");
                                    //Amount.Value = colValue;
                                    //Attribute.Attributes.Append(Amount);
                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Amount", "");
                                    xmlNode.InnerText = colValue;
                                    xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                                    break;
                                case "Quantity":
                                    colValue = colValue == "" ? "0" : colValue;
                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Quantity", "");
                                    xmlNode.InnerText = colValue;
                                    xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                                    //XmlAttribute Quantity = xmlDoc.CreateAttribute("Quantity");
                                    //Quantity.Value = colValue;
                                    //Attribute.Attributes.Append(Quantity);
                                    break;
                                case "FeeType":
                                    if (colValue.ToUpper() == "LAB")
                                    {
                                        colValue = "INV";
                                    }
                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "FeeType", "");
                                    xmlNode.InnerText = colValue;
                                    xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                                    //XmlAttribute FeeType = xmlDoc.CreateAttribute("FeeType");
                                    //FeeType.Value = colValue;
                                    //Attribute.Attributes.Append(FeeType);
                                    break;
                            };

                        }
                    }
                }

            }
            strXml = xmlDoc.InnerXml;
            AmountApprovalDetails.FeeDescription = strXml;
            if (Session["OrgID"] != null)
            {
                Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
                Int32 RoleID = Convert.ToInt32(Session["RoleID"]);
                Int32 CreateBy = Convert.ToInt32(Session["LID"]);
                Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
                returnCode = PatientBL.InsertAmountApprovalDetails(AmountApprovalDetails, OrgID, RoleID, CreateBy, out  GetBADId);
                if (GetBADId > 0)
                {
                    long returncode = -1;
                    Tasks task = new Tasks();
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    string EpisodeName = AmountApprovalDetails.PatientName;


                    long createTaskID = -1;
                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.AmountApproval), GetBADId, EpisodeName, "AAD", ApprovalType
                                 , out dText, out urlVal);
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.AmountApproval);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = GetBADId;
                    task.PatientID = GetBADId;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = CreateBy;
                    task.RefernceID = "";
                    task.Type = "AAD";
                    //Create task               
                    returncode = new Tasks_BL(new BaseClass().ContextInfo).CreateTask(task, out createTaskID);
                    string display = string.Empty;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting GetBillApprovalDetails", ex);
        }
        return GetBADId;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetUpdateAmountApprovalStatus(string ID, string RefType, string comments, string ApprovalStatus)
    {
        string GetStatus = "";
        long returnCode = -1;
        int AmountApprovalID = Convert.ToInt32(ID);
        List<AmountApprovalDetails> AmountApprovalDetails = new List<AmountApprovalDetails>();
        try
        {

            Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
            Int32 RoleID = Convert.ToInt32(Session["RoleID"]);
            Int32 CreateBy = Convert.ToInt32(Session["LID"]);
            Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
            returnCode = PatientBL.GetUpdateAmountApprovalDetails(AmountApprovalID, RefType, comments, ApprovalStatus, OrgID, out  GetStatus);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetUpdateAmountApprovalDetails: ", ex);
        }
        return GetStatus;
    }


    #region GetSampleNameInAutoComplet
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchSampleNameForOrg(string prefixText, int count, string contextKey)
    {
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvSampleMasterTransfer(prefixText, Orgid, out lstInvSampleMaster);
        if (lstInvSampleMaster.Count > 0)
        {
            foreach (InvSampleMaster item in lstInvSampleMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.SampleDesc, item.SampleDesc + "~" + item.SampleCode));
            }
        }
        return items.ToArray();
    }
    #endregion
    #region GetClientNameInAutoComplet
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchClientNameForOrg(string prefixText, int count, string contextKey)
    {
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvClient(prefixText, Orgid, out lstClientMaster);
        if (lstClientMaster.Count > 0)
        {
            foreach (ClientMaster item in lstClientMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientName + "~" + item.ClientID));
            }
        }
        return items.ToArray();
    }
    #endregion

    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<ApprovedReports> GetApprovedReportList(int InstanceId, string approvetime, string service)
    //{
    //    long result = -1;
    //    List<ApprovedReports> AppReport = new List<ApprovedReports>();
    //    List<ApprovedReports> lstApproveReports = new List<ApprovedReports>();
    //    List<ApprovedReports> lstAppRptsPath = new List<ApprovedReports>();
    //    Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
    //    List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
    //    ReportUtil reportutill = new ReportUtil();
    //    DataTable dt3 = new DataTable();
    //    byte[] byte1 = new byte[byte.MaxValue];
    //    try
    //    {
    //        result = Inv_BL.GetOrgApprovedReport(InstanceId, approvetime, service, out AppReport);
    //        string VisitID = string.Empty;
    //        string AccessionNumber = string.Empty;
    //        string XMLStr = string.Empty;
    //        long ClientID = 0;
    //        string FromDate = string.Empty;
    //        string ToDate = string.Empty;
    //        string reportPath = string.Empty;
    //        XmlDocument Doc = new XmlDocument();
    //        long InvoiceID = 0;
    //        byte[] results = new byte[byte.MaxValue];
    //        string strInvStatus = InvStatus.Approved;
    //        List<string> lstInvStatus = new List<string>();
    //        lstInvStatus.Add(strInvStatus);
    //        XmlNodeList objXmlNodeListVisit;
    //        XmlNodeList objXmlNodeListAccNum;
    //        DataTable dtMail = createDynamicTablr();
    //        for (int i = 0; i < AppReport.Count; i++)
    //        {
    //            XMLStr = AppReport[i].AdditionalContext.ToString();
    //            if (!string.IsNullOrEmpty(XMLStr))
    //            {
    //                Doc.LoadXml(XMLStr);
    //                if (AppReport[i].Category.ToLower() == "report")
    //                {
    //                    objXmlNodeListVisit = Doc.GetElementsByTagName("VisitID");
    //                    if (objXmlNodeListVisit != null && objXmlNodeListVisit.Count > 0)
    //                    {
    //                        VisitID = objXmlNodeListVisit[0].InnerText;
    //                    }
    //                    objXmlNodeListAccNum = Doc.GetElementsByTagName("AccessionNumber");
    //                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
    //                    {
    //                        AccessionNumber = objXmlNodeListAccNum[0].InnerText;
    //                    }
    //                }
    //                else
    //                {
    //                    objXmlNodeListVisit = Doc.GetElementsByTagName("InvoiceID");
    //                    if (objXmlNodeListVisit != null && objXmlNodeListVisit.Count > 0)
    //                    {
    //                        if (service.ToLower().Trim() == "email")
    //                        {
    //                            InvoiceID = Convert.ToInt64(objXmlNodeListVisit[0].InnerText);
    //                            AppReport[i].InvoiceID = InvoiceID;

    //                        }
    //                        else
    //                        {
    //                            ClientID = Convert.ToInt64(objXmlNodeListVisit[0].InnerText);
    //                        }
    //                    }
    //                    objXmlNodeListAccNum = Doc.GetElementsByTagName("FromDate");
    //                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
    //                    {
    //                        FromDate = objXmlNodeListAccNum[0].InnerText;
    //                    }
    //                    objXmlNodeListAccNum = Doc.GetElementsByTagName("ToDate");
    //                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
    //                    {
    //                        ToDate = objXmlNodeListAccNum[0].InnerText;
    //                    }
    //                }
    //            }
    //            if (service.ToLower() != "sms" && service.ToLower() != "email" && AppReport[i].Category.ToLower() == "report")
    //            {
    //                reportutill.GetReports(Convert.ToInt64(VisitID), Convert.ToInt32(AppReport[i].OrgID), Convert.ToInt64(AppReport[i].RoleID), Convert.ToInt32(AppReport[i].OrgAddressID), lstInvStatus, Convert.ToInt64(AppReport[i].CreatedBy), true, "printreport", out lstReportSnapshot);
    //                if (lstReportSnapshot.Count > 0)
    //                {
    //                    results = lstReportSnapshot[0].Content;
    //                    AppReport[i].Content = results;

    //                }
    //                else
    //                {
    //                    //AppReport.RemoveAt(i);
    //                }
    //            }
    //            if (service.ToLower() != "sms" && service.ToLower() != "email" && AppReport[i].Category.ToLower() == "invoice")
    //            {
    //                BillingEngine bill = new BillingEngine();
    //                long returnCode = bill.SaveInvoiceBillByService(AppReport[i].CreatedBy, ClientID, AppReport[i].OrgID, Convert.ToInt32(AppReport[i].OrgAddressID), Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), AppReport[i].AdditionalContext, out InvoiceID, out InvoiceID);
    //                string Type = string.Empty;
    //                long ReportTemplateID = 0;
    //                Type = "Invoice";
    //                List<BillingDetails> lstReportPath = new List<BillingDetails>();
    //                returnCode = bill.GetInvoiceReportPath(AppReport[i].OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
    //                if (lstReportPath.Count > 0)
    //                {
    //                    reportPath = lstReportPath[0].RefPhyName.ToString();
    //                }
    //                reportutill.ShowReportByservice(reportPath, InvoiceID, AppReport[i].OrgID, AppReport[i].OrgAddressID, AppReport[i].CreatedBy, out results);

    //                //if(results)
    //                //{
    //                AppReport[i].Content = results;
    //                AppReport[i].InvoiceID = InvoiceID;
    //                //}
    //                //else
    //                //{
    //                //       AppReport.RemoveAt(i);
    //                //}
    //            }
    //            if (!string.IsNullOrEmpty(VisitID))
    //            {
    //                AppReport[i].VisitID = Convert.ToInt64(VisitID);
    //            }
    //            else
    //            {
    //                AppReport[i].VisitID = 0;
    //            }
    //            if (!string.IsNullOrEmpty(AccessionNumber))
    //            {
    //                AppReport[i].AccessionNumber = AccessionNumber;
    //            }
    //            else
    //            {
    //                AppReport[i].AccessionNumber = "";
    //            }

    //            if (service.ToLower() == "email")
    //            {
    //                DataRow dr;
    //                dr = dtMail.NewRow();
    //                dr["Content"] = byte1;
    //                dr["Status"] = service;
    //                dr["NotificationID"] = Convert.ToInt64(AppReport[i].NotificationID);
    //                dr["ClientID"] = VisitID; //dr["ClientID"] as dr["VisitID"]
    //                dr["InvoiceID"] = InvoiceID;
    //                dr["Category"] = AppReport[i].Category.ToString();
    //                dr["FromDate"] = AppReport[i].FromDate.ToString();
    //                dr["TODate"] = AppReport[i].TODate.ToString();
    //                dr["ReportPath"] = AppReport[i].ReportPath.ToString();
    //                dr["OrgID"] = AppReport[i].OrgID.ToString();
    //                dr["OrgAddressID"] = AppReport[i].OrgAddressID.ToString();
    //                dtMail.Rows.Add(dr);
    //            }
    //        }
    //        if (service.ToLower() == "email")
    //        {
    //            long returnCode = -1;
    //            Report_BL objReportBL = new Report_BL();
    //            if (AppReport.Count > 0)
    //            {
    //                returnCode = objReportBL.pGetReportPathByVisitID(dtMail, out lstAppRptsPath);
    //                for (int i = 0; i < lstAppRptsPath.Count; i++)
    //                {
    //                    for (int j = 0; j < AppReport.Count; j++)
    //                    {
    //                        if (AppReport[j].Category.ToLower().Trim() == "report")
    //                        {
    //                            if (lstAppRptsPath[i].VisitID == AppReport[j].VisitID && lstAppRptsPath[i].AccessionNumber.Trim() == AppReport[j].AccessionNumber.Trim())
    //                            {
    //                                AppReport[j].ReportPath = lstAppRptsPath.Find(p => p.VisitID == AppReport[j].VisitID).ReportPath;
    //                            }
    //                        }
    //                        if (AppReport[j].Category.ToLower().Trim() == "invoice")
    //                        {
    //                            if (lstAppRptsPath[i].InvoiceID == AppReport[j].InvoiceID)
    //                            {
    //                                AppReport[j].ReportPath = lstAppRptsPath.Find(p => p.InvoiceID == AppReport[j].InvoiceID).ReportPath;
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in GetApprovedReportList:", ex);
    //    }
    //    return AppReport;
    //}
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ApprovedReports> GetApprovedReportNotification(int InstanceId, string approvetime, string service)
    {
        long result = -1;
        List<ApprovedReports> AppReport = new List<ApprovedReports>();
        Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.GetOrgApprovedReport(InstanceId, approvetime, service, out AppReport);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetApprovedReportList:", ex);
        }
        return AppReport;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ApprovedReports> GeneratePdfByVisitID(string PatientVisitID, string AdditionalContext, string Category, int OrgID, long RoleID, int OrgAddressID, long CreatedBy, string service, string status, string template, string attachmentName, string ReportType, string Language)
    {
        long result = -1;
        List<ApprovedReports> AppReport = new List<ApprovedReports>();
        List<ApprovedReports> lstApproveReports = new List<ApprovedReports>();
        List<ApprovedReports> lstAppRptsPath = new List<ApprovedReports>();
        Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        ReportUtil reportutill = new ReportUtil(new BaseClass().ContextInfo);
        DataTable dt3 = new DataTable();
        byte[] byte1 = new byte[byte.MaxValue];
        try
        {
            string VisitID = PatientVisitID;
            string AccessionNumber = string.Empty;
            string FinallBillID = string.Empty;
            string BillNumber = string.Empty;
            string XMLStr = string.Empty;
            long ClientID = 0;
            string FromDate = string.Empty;
            string ToDate = string.Empty;
            string reportPath = string.Empty;
            string IsServiceRequest = "Y";
            XmlDocument Doc = new XmlDocument();
            long InvoiceID = 0;
            string InvoiceNumber = "0";
            byte[] results = new byte[byte.MaxValue];
            string strInvStatus = InvStatus.Approved;
            List<string> lstInvStatus = new List<string>();
            lstInvStatus.Add(strInvStatus);
            lstInvStatus.Add(InvStatus.PartialyApproved);
            lstInvStatus.Add(InvStatus.Rejected);
            lstInvStatus.Add(InvStatus.WithHeld);
            lstInvStatus.Add(InvStatus.Completed);
            lstInvStatus.Add(InvStatus.Validate);
            lstInvStatus.Add(InvStatus.PartiallyValidated);
            XmlNodeList objXmlNodeListVisit;
            XmlNodeList objXmlNodeListAccNum;
            XmlNodeList objXmlNodeListClientID;
            XmlNodeList objXmlNodeListBillNumber;
            DataTable dtMail = createDynamicTablr();
            XMLStr = AdditionalContext;
            if (!string.IsNullOrEmpty(XMLStr))
            {
                Doc.LoadXml(XMLStr);
                if (Category.ToLower() == "report")
                {
                    objXmlNodeListVisit = Doc.GetElementsByTagName("VisitID");
                    if (objXmlNodeListVisit != null && objXmlNodeListVisit.Count > 0)
                    {
                        VisitID = objXmlNodeListVisit[0].InnerText;
                    }
                    objXmlNodeListAccNum = Doc.GetElementsByTagName("AccessionNumber");
                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
                    {
                        AccessionNumber = objXmlNodeListAccNum[0].InnerText;
                    }
                }
                else if (Category.ToLower() == "bill")
                {
                    objXmlNodeListVisit = Doc.GetElementsByTagName("VisitID");
                    if (objXmlNodeListVisit != null && objXmlNodeListVisit.Count > 0)
                    {
                        VisitID = objXmlNodeListVisit[0].InnerText;
                    }
                    objXmlNodeListAccNum = Doc.GetElementsByTagName("FinallBillID");
                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
                    {
                        FinallBillID = objXmlNodeListAccNum[0].InnerText;
                    }
                    objXmlNodeListBillNumber = Doc.GetElementsByTagName("BillNumber");
                    if (objXmlNodeListBillNumber != null && objXmlNodeListBillNumber.Count > 0)
                    {
                        BillNumber = objXmlNodeListBillNumber[0].InnerText;
                    }

                }
                else
                {
                    objXmlNodeListVisit = Doc.GetElementsByTagName("InvoiceID");
                    objXmlNodeListClientID = Doc.GetElementsByTagName("ClientID");
                    if (objXmlNodeListVisit != null && objXmlNodeListVisit.Count > 0)
                    {
                        if (status.ToLower() == "error")
                        {
                            InvoiceID = Convert.ToInt64(objXmlNodeListVisit[0].InnerText);
                        }
                    }
                    if (objXmlNodeListClientID != null && objXmlNodeListClientID.Count > 0)
                    {
                        ClientID = Convert.ToInt64(objXmlNodeListClientID[0].InnerText);
                    }
                    objXmlNodeListAccNum = Doc.GetElementsByTagName("FromDate");
                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
                    {
                        FromDate = objXmlNodeListAccNum[0].InnerText;
                    }
                    objXmlNodeListAccNum = Doc.GetElementsByTagName("ToDate");
                    if (objXmlNodeListAccNum != null && objXmlNodeListAccNum.Count > 0)
                    {
                        ToDate = objXmlNodeListAccNum[0].InnerText;
                    }
                }
            }
            if (Category.ToLower() == "report")
            {
                Language = (string.IsNullOrEmpty(Language)) ? "en-GB" : Language;
                if (service.ToLower() == "confidpdf" || service.ToLower() == "confidroundbpdf")
                {
                    reportutill.GetReports(Convert.ToInt64(VisitID), OrgID, RoleID, OrgAddressID, lstInvStatus, CreatedBy, true, service, "", -1, IsServiceRequest, ReportType, out lstReportSnapshot, Language);
                }
                else if (service.ToLower() == "clientblindchildpdf" || service.ToLower() == "clientblindchildroundbpdf")
                {
                    reportutill.GetReports(Convert.ToInt64(VisitID), OrgID, RoleID, OrgAddressID, lstInvStatus, CreatedBy, true, service, "", -1, IsServiceRequest, ReportType, out lstReportSnapshot, Language);
                }
                else if (service.ToLower() == "clientblindparentpdf" || service.ToLower() == "clientblindparentroundbpdf")
                {
                    reportutill.GetReports(Convert.ToInt64(VisitID), OrgID, RoleID, OrgAddressID, lstInvStatus, CreatedBy, true, service, "", -1, IsServiceRequest, ReportType, out lstReportSnapshot, Language);
                }
                else if (service.ToUpper() == "ISSTATPDF" || service.ToUpper() == "ROUNDBPDF" || service.ToUpper() == "PDF")
                {
                    reportutill.GetReports(Convert.ToInt64(VisitID), OrgID, RoleID, OrgAddressID, lstInvStatus, CreatedBy, true, service, "", -1, IsServiceRequest, ReportType, out lstReportSnapshot, Language);
                }
                else
                {
                    reportutill.GetReports(Convert.ToInt64(VisitID), OrgID, RoleID, OrgAddressID, lstInvStatus, CreatedBy, true, "printreport", "", -1, IsServiceRequest, ReportType, out lstReportSnapshot, Language);
                }
                if (lstReportSnapshot.Count > 0)
                {
                    results = lstReportSnapshot[0].Content;
                    if (result != null && results.Length > 255)
                    {
                        ApprovedReports objAppReports = new ApprovedReports();
                        objAppReports.Content = results;
                        objAppReports.VisitID = Convert.ToInt64(VisitID);
                        if (service.ToUpper() == "ISSTATPDF" || service.ToUpper() == "ROUNDBPDF")
                        {
                            objAppReports.AccessionNumber = lstReportSnapshot[0].AccessionNumber;
                        }
                        else
                        {
                            objAppReports.AccessionNumber = AccessionNumber;
                        }
                        objAppReports.Template = template;
                        objAppReports.AttachmentName = attachmentName;
                        AppReport.Add(objAppReports);
                    }

                }
            }
            else if (Category.ToLower() == "invoice")
            {
                long returnCode = 0;
                BillingEngine bill = new BillingEngine();
                if (status.ToLower() != "error")
                {
                    returnCode = bill.SaveInvoiceBillByService(CreatedBy, ClientID, OrgID, OrgAddressID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), AdditionalContext, out InvoiceID, out InvoiceNumber);
                }
                string Type = string.Empty;
                long ReportTemplateID = 0;
                Type = "Invoice";
                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                returnCode = bill.GetInvoiceReportPath(OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                }
                if (InvoiceID > 0)
                {
                    reportutill.ShowReportByservice(reportPath, InvoiceID, OrgID, OrgAddressID, CreatedBy, out results);
                }
                if (results.Length > 255)
                {
                    ApprovedReports objAppReports = new ApprovedReports();
                    objAppReports.Content = results;
                    objAppReports.InvoiceID = InvoiceID;
                    objAppReports.Template = template;
                    objAppReports.AttachmentName = attachmentName.Replace("{InvoiceNumber}", InvoiceNumber.ToString());
                    AppReport.Add(objAppReports);
                }
            }
            else
            {
                BillingEngine bill = new BillingEngine();
                string Type = string.Empty;
                string PhysicianName = string.Empty;
                string SpliStatus = string.Empty;
                long FinalBillId = Convert.ToInt64(FinallBillID);
                long ReportTemplateID = 0;
                Type = "BillReceipt";
                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                long returnCode = bill.GetInvoiceReportPath(OrgID, Type, FinalBillId, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                    //RefPhyName as ReportTemplateName
                }
                reportutill.GenerateBillReceiptByservice(reportPath, Convert.ToInt64(VisitID), PhysicianName, FinalBillId, SpliStatus, OrgID, 0, 0, out results);
                if (results.Length > 255)
                {
                    ApprovedReports objAppReports = new ApprovedReports();
                    objAppReports.Content = results;
                    objAppReports.InvoiceID = Convert.ToInt64(BillNumber);
                    objAppReports.BillNumber = BillNumber;
                    objAppReports.FinallBillID = FinalBillId;
                    objAppReports.Template = template;
                    objAppReports.AttachmentName = attachmentName;
                    AppReport.Add(objAppReports);
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetApprovedReportList:", ex);
        }
        return AppReport;
    }

    //***********Added by prabak for silent Printing Service*********************//
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ApprovedReports> GetPdfByVisitID(string PatientVisitID, string AdditionalContext, string Category, int OrgID, long RoleID, int OrgAddressID, long CreatedBy, string service, string status, string template, string attachmentName, string Reportpath)
    {
        List<ApprovedReports> AppReport = new List<ApprovedReports>();
        try
        {
            string VisitID = PatientVisitID;
            string AccessionNumber = string.Empty;
            byte[] results = new byte[byte.MaxValue];
            //  if (Category.ToLower() == "report")
            // {
            if (System.IO.File.Exists(Reportpath))
            {
                FileStream fs = new FileStream(Reportpath, FileMode.Open, FileAccess.Read);
                byte[] buffer = new byte[Convert.ToInt32(fs.Length)];
                int j = 0;
                j = fs.Read(buffer, 0, Convert.ToInt32(fs.Length));
                MemoryStream MemoryStream = new MemoryStream(buffer);
                results = buffer;
                if (results != null && results.Length > 255)
                {
                    ApprovedReports objAppReports = new ApprovedReports();
                    objAppReports.Content = results;
                    objAppReports.VisitID = Convert.ToInt64(VisitID);
                    objAppReports.Template = template;
                    objAppReports.AttachmentName = attachmentName;
                    objAppReports.BillNumber = VisitID;//VisitID as BillNumber
                    AppReport.Add(objAppReports);
                }
            }
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetApprovedReportList:", ex);
        }
        return AppReport;
    }

    //***************************************End**********************************//


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ApprovedReports> GetPdfByVisitIDForPrinting(string PatientVisitID, string AdditionalContext, string Category, int OrgID, long RoleID, int OrgAddressID, long CreatedBy, string service, string status, string template, string attachmentName, string Reportpath, bool Flag,string ReportType)
    {
        List<ApprovedReports> AppReport = new List<ApprovedReports>();
        try
        {
            string VisitID = PatientVisitID;
            string AccessionNumber = string.Empty;
            byte[] results = new byte[byte.MaxValue];
            byte[] destByte = new byte[byte.MaxValue];
            //  if (Category.ToLower() == "report")
            //string Reportpath1 = Reportpath + template + attachmentName;
            // {
            List<ReprintMergeRDLSize> lstRDLSise = new List<ReprintMergeRDLSize>();
            Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
            PatBL.GetReprintRDLSize(OrgID, out lstRDLSise);
            if (System.IO.File.Exists(Reportpath))
            {
                FileStream fs = new FileStream(Reportpath, FileMode.Open, FileAccess.Read);
                byte[] buffer = new byte[Convert.ToInt32(fs.Length)];
                int j = 0;
                j = fs.Read(buffer, 0, Convert.ToInt32(fs.Length));
                MemoryStream MemoryStream = new MemoryStream(buffer);
                destByte = Attune.PdfMerger.ReprintMergeFiles(buffer,Flag,lstRDLSise[0].MoveX,lstRDLSise[0].MoveY,lstRDLSise[0].LineX,lstRDLSise[0].LineY,lstRDLSise[0].FontSize,ReportType);
                results = destByte;
                if (results != null && results.Length > 255)
                {
                    ApprovedReports objAppReports = new ApprovedReports();
                    objAppReports.Content = destByte;
                    objAppReports.VisitID = Convert.ToInt64(VisitID);
                    objAppReports.Template = template;
                    objAppReports.AttachmentName = attachmentName;
                    objAppReports.BillNumber = VisitID;//VisitID as BillNumber
                    AppReport.Add(objAppReports);
                }
            }
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetApprovedReportList:", ex);
        }
        return AppReport;
    }
    //----------------------end-------------------------------//
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void SaveReportSnapshot(List<ApprovedReports> AppReport1, String Method)
    {
        List<ApprovedReports> AppReport = new List<ApprovedReports>();
        AppReport = AppReport1;
        try
        {
            byte[] byte1 = new byte[byte.MaxValue];
            System.Data.DataTable dt = new DataTable();
            DataColumn dbCol1 = new DataColumn("Content");
            DataColumn dbCol2 = new DataColumn("TemplateID");
            DataColumn dbCol3 = new DataColumn("Status");
            DataColumn dbCol4 = new DataColumn("ReportPath");
            DataColumn dbCol5 = new DataColumn("AccessionNumber");
            DataColumn dbCol6 = new DataColumn("NotificationID");
            DataColumn dbCol7 = new DataColumn("VisitID");
            DataColumn dbCol8 = new DataColumn("Seq_Num");
            DataColumn dbCol9 = new DataColumn("OrgID");
            DataColumn dbCol10 = new DataColumn("OrgAddressID");
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
            dt.Columns.Add(dbCol10);
            DataRow dr;

            System.Data.DataTable dt1 = new DataTable();
            DataColumn Col1 = new DataColumn("Content");
            DataColumn col2 = new DataColumn("Status");
            DataColumn Col3 = new DataColumn("NotificationID");
            DataColumn Col4 = new DataColumn("ClientID");
            DataColumn Col5 = new DataColumn("InvoiceID");
            DataColumn Col6 = new DataColumn("Seq_Num");
            DataColumn Col7 = new DataColumn("Category");
            DataColumn Col8 = new DataColumn("FromDate");
            DataColumn Col9 = new DataColumn("TODate");
            DataColumn Col10 = new DataColumn("ReportPath");
            DataColumn Col11 = new DataColumn("OrgID");
            DataColumn Col12 = new DataColumn("OrgAddressID");
            //add columns
            dt1.Columns.Add(Col1);
            dt1.Columns.Add(col2);
            dt1.Columns.Add(Col3);
            dt1.Columns.Add(Col4);
            dt1.Columns.Add(Col5);
            dt1.Columns.Add(Col6);
            dt1.Columns.Add(Col7);
            dt1.Columns.Add(Col8);
            dt1.Columns.Add(Col9);
            dt1.Columns.Add(Col10);
            dt1.Columns.Add(Col11);
            dt1.Columns.Add(Col12);
            for (int i = 0; i < AppReport.Count; i++)
            {
                if (AppReport[i].Category.ToLower() == "report" || AppReport[i].Category.ToLower() == "notify")
                {
                    dr = dt.NewRow();
                    dr["Content"] = byte1;
                    dr["TemplateID"] = 0;
                    dr["Status"] = Method;
                    dr["ReportPath"] = AppReport[i].ReportPath.ToString();
                    dr["AccessionNumber"] = AppReport[i].AccessionNumber.ToString();
                    dr["NotificationID"] = Convert.ToInt64(AppReport[i].NotificationID);
                    dr["VisitID"] = AppReport[i].VisitID.ToString();
                    dr["Seq_Num"] = AppReport[i].Seq_Num.ToString();
                    dr["OrgID"] = AppReport[i].OrgID.ToString();
                    dr["OrgAddressID"] = AppReport[i].OrgAddressID.ToString();
                    dt.Rows.Add(dr);
                }
                if (AppReport[i].Category.ToLower() == "invoice" || AppReport[i].Category.ToLower() == "bill")
                {
                    dr = dt1.NewRow();
                    dr["Content"] = byte1;
                    dr["Status"] = Method;
                    dr["NotificationID"] = Convert.ToInt64(AppReport[i].NotificationID);
                    dr["ClientID"] = AppReport[i].ClientID;
                    dr["InvoiceID"] = AppReport[i].InvoiceID.ToString();
                    dr["Seq_Num"] = AppReport[i].Seq_Num.ToString();
                    dr["Category"] = AppReport[i].Category.ToString();
                    dr["FromDate"] = DateTime.Now;
                    dr["TODate"] = DateTime.Now;
                    dr["ReportPath"] = AppReport[i].ReportPath.ToString();
                    dr["OrgID"] = AppReport[i].OrgID.ToString();
                    dr["OrgAddressID"] = AppReport[i].OrgAddressID.ToString();
                    dt1.Rows.Add(dr);
                }
            }
            long returnCode = -1;
            Report_BL objReportBL = new Report_BL();
            if (AppReport.Count > 0)
            {
                returnCode = objReportBL.SaveReportSnapshot(dt, dt1, 0, 0, 0, 0);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveDispatchInvestigationStatus:", ex);
        }
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<CommunicationConfig> GetCommunicationConfig(int OrgId, string pType)
    {
        long result = -1;
        List<CommunicationConfig> lstCommunicationConfig = new List<CommunicationConfig>();
        try
        {
            Master_BL Inv_BL = new Master_BL(new BaseClass().ContextInfo);
            result = Inv_BL.GetCommunicationConfig(OrgId, pType, out lstCommunicationConfig);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetCommunicationConfig:", ex);
        }
        return lstCommunicationConfig;
    }

    #region GetHubName [ClientMaster]
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetHubName(string prefixText, int count, string contextKey)
    {
        Schedule_BL scheduleBL = new Schedule_BL();
        List<Localities> lstLOCAL = new List<Localities>();
        List<string> items = new List<string>();
        Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
        scheduleBL.GetHubName(OrgID, prefixText, out lstLOCAL);
        if (lstLOCAL.Count > 0)
        {
            foreach (Localities item in lstLOCAL)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, "~" + item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion


    #region GetZoneName [ClientMaster]
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetZoneName(string prefixText, int count, string contextKey)
    {
        Schedule_BL scheduleBL = new Schedule_BL();
        List<Localities> lstLOCAL = new List<Localities>();
        List<string> items = new List<string>();
        Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
        scheduleBL.GetZoneName(OrgID, prefixText, out lstLOCAL);
        if (lstLOCAL.Count > 0)
        {
            foreach (Localities item in lstLOCAL)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, "~" + item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion


    #region GetHubCode [ClientMaster]
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetHubCode(string prefixText, int count, string contextKey)
    {
        int orgID = 0;
        Schedule_BL scheduleBL = new Schedule_BL();
        List<Localities> lstLOCAL = new List<Localities>();
        List<string> items = new List<string>();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        scheduleBL.GetHubCode(orgID, prefixText, out lstLOCAL);
        if (lstLOCAL.Count > 0)
        {
            foreach (Localities item in lstLOCAL)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Code, "~" + item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    #region GetZoneCode [ClientMaster]
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetZoneCode(string prefixText, int count, string contextKey)
    {
        int orgID = 0;
        Schedule_BL scheduleBL = new Schedule_BL();
        List<Localities> lstLOCAL = new List<Localities>();
        List<string> items = new List<string>();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        scheduleBL.GetZoneCode(orgID, prefixText, out lstLOCAL);
        if (lstLOCAL.Count > 0)
        {
            foreach (Localities item in lstLOCAL)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Code, "~" + item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    #region GetRouteCode [ClientMaster]
    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetRouteCode(string prefixText, int count, string contextKey)
    {
        int orgID = 0;
        Schedule_BL scheduleBL = new Schedule_BL();
        List<Localities> lstLOCAL = new List<Localities>();
        List<string> items = new List<string>();
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        scheduleBL.GetRouteCode(orgID, prefixText, out lstLOCAL);
        if (lstLOCAL.Count > 0)
        {
            foreach (Localities item in lstLOCAL)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Code, "~" + item.Locality_ID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion
    #region GetCollectionCenterClientNames [GetCollectionCenterClientNames]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetCollectionCenterClientNames(string prefixText, int count)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientNames = new List<ClientMaster>();
        int orgID = 0;
        string Designation = string.Empty;
        int LocationID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        Int32.TryParse(Session["LocationID"].ToString(), out LocationID);

        List<string> items = new List<string>();
        Master_BL.GetCollectionCentreClients(orgID, LocationID, prefixText, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            foreach (ClientMaster item in lstClientNames)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
            }
        }
        return items.ToArray();

    }
    #endregion

    #region GetSampleContainerNameInAutoComplet
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchSampleContainerForOrg(string prefixText, int count, string contextKey)
    {
        List<InvestigationSampleContainer> lstInvestigationSampleContainer = new List<InvestigationSampleContainer>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetSampleContainerName(prefixText, Orgid, out lstInvestigationSampleContainer);
        if (lstInvestigationSampleContainer.Count > 0)
        {
            foreach (InvestigationSampleContainer item in lstInvestigationSampleContainer)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ContainerName, item.ContainerName + "~" + item.SampleContainerID));
            }
        }
        return items.ToArray();
    }
    #endregion


    #region Get Investigaton Name For ResultEntry used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchInvestigationNameForResult(string prefixText, int count, string contextKey)
    {
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvestigationNameForResult(prefixText, Orgid, out lstPatientInvestigation);
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation item in lstPatientInvestigation)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.InvestigationName, item.InvestigationName + "~" + item.InvestigationID + "~" + item.MethodName));
            }
        }
        return items.ToArray();
    }
    #endregion


    #region Get Department Name For ResultEntry used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchDepartmentNameForResult(string prefixText, int count, string contextKey)
    {
        List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
        List<string> items = new List<string>();
        long returnCode = -1;
        long RoleID = -1;
        long LoginID = -1;
        RoleID = new BaseClass().ContextInfo.RoleID;
        LoginID = new BaseClass().ContextInfo.LoginID;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetDepartmentNameForResult(prefixText, RoleID, LoginID, Orgid, out lstInvDeptMaster);
        if (lstInvDeptMaster.Count > 0)
        {
            foreach (InvDeptMaster item in lstInvDeptMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.DeptName, item.DeptName + "~" + item.DeptID));
            }
        }
        return items.ToArray();
    }
    #endregion
    #region GetExtraSampleList
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientInvSample> GetExtraSampleList(long patienid, long SampleCode, int OrgID)
    {
        long result = -1;
        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
        List<PatientInvSample> lstPatientInvSampleGrouped = new List<PatientInvSample>();
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        result = Inv_BL.GetExtraSampleList(patienid, SampleCode, OrgID, out lstPatientInvSample);
        return lstPatientInvSample;
    }
    #endregion








    #region GetCodingSchemeMaster
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    //[ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CodingSchemeMaster> GetCodingSchemeMaster(string CodingSchemeName, int OrgID)
    {
        long returnCode = -1;
        List<CodingSchemeMaster> lstCodingSchemeMaster = new List<CodingSchemeMaster>();
        try
        {
            Master_BL master_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = master_BL.GetCodingSchemeMaster(CodingSchemeName, OrgID, out lstCodingSchemeMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting lstCodingSchemeMaster ", ex);
        }
        return lstCodingSchemeMaster;
    }
    #endregion
    #region GetRouteNames [GetRouteNames]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetRouteNames(string prefixText, int count, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        if (contextKey != "")
        {
            int orgID = 0;
            string Code = string.Empty;
            int ZoneID = 0;
            string[] GEtContext = contextKey.Split('~');
            Code = GEtContext[0].ToString();
            ZoneID = Convert.ToInt32(GEtContext[1].ToString());
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);

            Master_BL.GetRouteNames(orgID, Code, prefixText, ZoneID, out lstLocalities);
            if (lstLocalities.Count > 0)
            {
                foreach (Localities item in lstLocalities)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, item.Locality_ID.ToString()));
                }
            }
        }
        return items.ToArray();

    }
    #endregion


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] getUserNamesWithID(string prefixText, string contextKey)
    {
        int orgID = Convert.ToInt32(contextKey);
        List<string> items = new List<string>();
        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = arBL.GetUserNamewithID(orgUserName, orgID, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            foreach (OrgUsers item in lstOrgUsers)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.LoginID.ToString()));
            }
        }
        return items.ToArray();
    }

    #region Get Phlebotomist Name For ResultEntry used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchPhlebotomistName(string prefixText, int count, string contextKey)
    {
        List<Users> lstUsers = new List<Users>();
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        long returnCode = -1;
        string Type = string.Empty;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        long Zoneid = 0;
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, "PHLEBOTOMIST", Zoneid, out lstUsers,

           out lstEmployeeRegMaster, out lstInvClientMaster, out lstLocalities);
        if (lstUsers.Count > 0)
        {
            foreach (Users item in lstUsers)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Name + "~" + item.OrgUserID + "~" + item.OrgUserID));
            }
        }

        return items.ToArray();
    }
    #endregion



    #region Get LogisticsName Name For ResultEntry used in Ajax AutoComplete
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchLogisticsName(string prefixText, int count, string contextKey)
    {
        List<Users> lstUsers = new List<Users>();
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        List<InvClientMaster> lstinvClientMaster = new List<InvClientMaster>();
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        string Type = string.Empty;
        long returnCode = -1;
        int Orgid = 0;
        long ZoneID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out Orgid);
        string[] Key = contextKey.Split('~');
        Orgid = Convert.ToInt32(Key[0].ToString());
        Type = Key[1].ToString();
        ZoneID = Convert.ToInt64(Key[2].ToString());
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, Type, ZoneID,
            out lstUsers, out lstEmployeeRegMaster, out lstinvClientMaster, out lstLocalities);
        if (lstEmployeeRegMaster.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstEmployeeRegMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Name + "~" + item.EmpID + "~" + item.EmpID));
            }
        }

        return items.ToArray();
    }
    #endregion
    public DataTable createDynamicTablr()
    {
        DataTable dt = new DataTable();
        try
        {
            byte[] byte1 = new byte[byte.MaxValue];
            DataColumn dbCol1 = new DataColumn("Content");
            DataColumn dbCol2 = new DataColumn("Status");
            DataColumn dbCol3 = new DataColumn("NotificationID");
            DataColumn dbCol4 = new DataColumn("ClientID");
            DataColumn dbCol5 = new DataColumn("InvoiceID");
            DataColumn dbCol6 = new DataColumn("Category");
            DataColumn dbCol7 = new DataColumn("FromDate");
            DataColumn dbCol8 = new DataColumn("TODate");
            DataColumn dbCol9 = new DataColumn("ReportPath");
            DataColumn dbCol10 = new DataColumn("OrgID");
            DataColumn dbCol11 = new DataColumn("OrgAddressID");
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
            dt.Columns.Add(dbCol10);
            dt.Columns.Add(dbCol11);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in createDynamicTablr:", ex);
        }
        return dt;
    }

    #region DeleteInvCoAuth

    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteInvCoAuth(long ID, long InvID, int OrgID)
    {
        long returnCode = -1;
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.DeleteInvCoAuth(ID, InvID, OrgID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting InvCoAuth details ", ex);
        }
    }

    #endregion



    #region GetDeviceValue [GetDeviceValue]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvestigationValues> GetDeviceValue(int OrgId, int VisitId, long InvestigationID)
    {
        string Guid = string.Empty;
        string strObj = string.Empty;
        Investigation_BL invesBL = new Investigation_BL(new BaseClass().ContextInfo);
        List<InvestigationValues> lstDeviceValue = new List<InvestigationValues>();
        invesBL.GetDeviceValue(OrgId, VisitId, InvestigationID, Guid, out lstDeviceValue);
        return lstDeviceValue;
    }
    #endregion
    #region DeleteProbeImageDeatils
    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteProbeImageDeatils(long PVisitId, long Pinvid, int OrgID, long ImageId)
    {
        long returnCode = -1;
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.DeleteProbeImageDeatils(PVisitId, Pinvid, OrgID, ImageId);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting DeleteProbeImageDeatils details ", ex);
        }
    }

    #endregion


    //----------------------Enter Result---------------------------
    #region EnterResult
    [WebMethod(EnableSession = true)]
    public string validateAllRange(string rawDatas, string JsonStringData)
    {

        string returnValue = string.Empty;

        try
        {

            string txtAbnormalId = string.Empty;
            string txtControl = string.Empty;
            string txtctrlOut = string.Empty;
            string txtColor = string.Empty;
            string textColor = string.Empty;
            string RangeCode = string.Empty;
            string IsExcludeAutoApproval = string.Empty;
            string outOfRangeField = string.Empty;
            int OrgID = 0;
            bool isOutOfRange = false;
            string[] controlArryMain = rawDatas.Split('^');
            ArrayList testNamearr = new ArrayList();
            string IsSensitive = string.Empty;

            string[] CatagoryxmlMain = rawDatas.Split('|');
            txtControl = CatagoryxmlMain[2];
            txtAbnormalId = CatagoryxmlMain[6];
            IsExcludeAutoApproval = CatagoryxmlMain[11];
            Int32.TryParse(CatagoryxmlMain[12], out OrgID);
            string agedays = string.Empty;
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            List<ReferenceRangeType> lstReferenceRangeType = oJavaScriptSerializer.Deserialize<List<ReferenceRangeType>>(JsonStringData);
            if (TryParseXml(CatagoryxmlMain[0]))
            {
                ValidateUserResult(rawDatas, IsExcludeAutoApproval, OrgID, agedays, out textColor, out txtControl, out RangeCode, out IsSensitive, lstReferenceRangeType);
                outOfRangeField = CatagoryxmlMain[9] + " : " + CatagoryxmlMain[3] + " " + CatagoryxmlMain[10] + "<br>";
                if (textColor != "Alert" && RangeCode == "A" || RangeCode == "L" || RangeCode == "P" || RangeCode == "AutoA" || RangeCode == "AutoP" || RangeCode == "AutoL")
                {
                    isOutOfRange = true;
                }
                if (textColor == "Alert")
                {
                    RangeCode = "Alert";
                    txtColor = "white";
                }
            }

            Dictionary<string, string> oDict = new Dictionary<string, string>();
            oDict["controlId"] = txtControl;
            oDict["color"] = textColor;
            oDict["isOutOfRange"] = isOutOfRange.ToString();
            oDict["fieldDetails"] = outOfRangeField;
            oDict["txtIsAbnormalId"] = txtAbnormalId;
            oDict["rangeCode"] = RangeCode;
            oDict["ddlControlId"] = txtAbnormalId.Replace("txtIsAbnormal", "ddlData");
            oDict["IsSensitive"] = IsSensitive;
            returnValue = oJavaScriptSerializer.Serialize(oDict);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while validating reference range with entered result value: ", ex);
        }
        return returnValue;
    }


    public void ValidateUserResult(string xmlData, string IsExcludeAutoApproval, int OrgID, string Agedays, out string textColor, out string textControl, out string RangeCode, out string IsSensitive, List<ReferenceRangeType> lstReferenceRangeType)
    {
        textColor = "white";
        textControl = "";
        RangeCode = "white";
        IsSensitive = "N";
        LabUtil objlabutil = new LabUtil();

        string[] CatagoryAgeMain = xmlData.Split('|');



        Array userarr = CatagoryAgeMain[1].Split('~');
        string pGender = userarr.GetValue(0).ToString();
        string pAge = userarr.GetValue(1).ToString();
        string pAgetype = userarr.GetValue(2).ToString();
        string txtControl = CatagoryAgeMain[2].ToString();
        textControl = txtControl;
        int autocount = Convert.ToInt32(Session["AutoAuthorCheck"]);
        try
        {

            // objlabutil.ValidateResultold(xmlData, IsExcludeAutoApproval, OrgID, out textColor, out RangeCode);
            objlabutil.ValidateResult(xmlData, IsExcludeAutoApproval, OrgID, Agedays, out textColor, out RangeCode, out IsSensitive, autocount, lstReferenceRangeType);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while parsing reference range", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    public string ValidateInterpretationRange(string ReferenceRange, string Value, string Gender, string Age)
    {
        string output = string.Empty;
        try
        {
            LabUtil oLabUtil = new LabUtil();
            string result = string.Empty;
            string resultType = string.Empty;
            decimal resultValue = 0;
            bool isNumericValue = false;
            resultValue = oLabUtil.ConvertResultValue(Value, out isNumericValue);
            if (isNumericValue)
            {
                oLabUtil.ValidateInterpretationRange(ReferenceRange, Gender, Age, resultValue, string.Empty, out result, out resultType);
                if (result != string.Empty)
                {
                    output = resultType + "~" + result;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while parsing interpretation range", ex);
        }
        return output;
    }
    #endregion
    #region Get Client Name For Billing based Zone
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchClientNameForBilling(string prefixText, int count, string contextKey)
    {
        List<Users> lstUsers = new List<Users>();
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();

        List<InvClientMaster> lstinvClientMaster = new List<InvClientMaster>();
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        string Type = string.Empty;
        long returnCode = -1;
        int Orgid = 0;
        long ZoneID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out Orgid);
        string[] Key = contextKey.Split('~');
        Orgid = Convert.ToInt32(Key[0].ToString());
        Type = Key[1].ToString();
        ZoneID = Convert.ToInt64(Key[2].ToString());
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, Type, ZoneID,
            out lstUsers, out lstEmployeeRegMaster, out lstinvClientMaster, out lstLocalities);
        if (lstinvClientMaster.Count > 0)
        {
            foreach (InvClientMaster item in lstinvClientMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.Value.ToString()));
            }
        }

        return items.ToArray();
    }
    #endregion

    #region Get Client Name For Billing based Zone
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchLogidticsNameForBilling(string prefixText, int count, string contextKey)
    {
        List<Users> lstUsers = new List<Users>();
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();

        List<InvClientMaster> lstinvClientMaster = new List<InvClientMaster>();
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        string Type = string.Empty;
        long returnCode = -1;
        int Orgid = 0;
        long ZoneID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out Orgid);
        string[] Key = contextKey.Split('~');
        Orgid = Convert.ToInt32(Key[0].ToString());
        Type = Key[1].ToString();
        ZoneID = Convert.ToInt64(Key[2].ToString());
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, Type, ZoneID,
            out lstUsers, out lstEmployeeRegMaster, out lstinvClientMaster, out lstLocalities);
        if (lstEmployeeRegMaster.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstEmployeeRegMaster)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Name + "~" + item.EmpID + "~" + item.EmpID));
            }
        }

        return items.ToArray();
    }
    #endregion


    #region Get Client Name For Billing based Zone
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchZoneForBilling(string prefixText, int count, string contextKey)
    {
        List<Users> lstUsers = new List<Users>();
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();

        List<InvClientMaster> lstinvClientMaster = new List<InvClientMaster>();
        List<Localities> lstLocalities = new List<Localities>();
        List<string> items = new List<string>();
        string Type = string.Empty;
        long returnCode = -1;
        int Orgid = 0;
        long ZoneID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out Orgid);
        string[] Key = contextKey.Split('~');
        Orgid = Convert.ToInt32(Key[0].ToString());
        Type = Key[1].ToString();
        ZoneID = Convert.ToInt64(Key[2].ToString());
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, Type, ZoneID,
            out lstUsers, out lstEmployeeRegMaster, out lstinvClientMaster, out lstLocalities);
        if (lstLocalities.Count > 0)
        {
            foreach (Localities item in lstLocalities)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, item.Locality_Value + "~" + item.Locality_ID + "~" + item.Locality_ID));
            }
        }

        return items.ToArray();
    }
    #endregion
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<EmployeeRegMaster> LoadDefautlogistics(string prefixText, int count, string contextKey)
    {
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        try
        {
            List<Users> lstUsers = new List<Users>();
            List<InvClientMaster> lstinvClientMaster = new List<InvClientMaster>();
            List<Localities> lstLocalities = new List<Localities>();
            List<string> items = new List<string>();
            string Type = string.Empty;
            long returnCode = -1;
            int Orgid = 0;
            long ZoneID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out Orgid);
            string[] Key = contextKey.Split('~');
            Orgid = Convert.ToInt32(Key[0].ToString());
            Type = Key[1].ToString();
            ZoneID = Convert.ToInt64(Key[2].ToString());
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetPhlebotomistName(prefixText, Orgid, Type, ZoneID,
                out lstUsers, out lstEmployeeRegMaster, out lstinvClientMaster, out lstLocalities);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While loading Default Logistics", ex);
        }
        return lstEmployeeRegMaster;

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientVisit> GetDuplicateValidationonEntry(int pOrgID, string Name, string Age, long ClientID, string registerdDate, long ID, string type)
    {
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        long result = -1;

        try
        {
            BillingEngine BE = new BillingEngine(new BaseClass().ContextInfo);
            result = BE.GetDuplicateValidationonEntry(pOrgID, Name, Age, ClientID, registerdDate, ID, type, out lstPatientVisit);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while GetDuplicateValidationonEntry", ex);
        }
        //long lngInvestigationID = Convert.ToInt64(InvestigationID);


        return lstPatientVisit;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetInvBulkDataAuto(string prefixText, int count, string contextKey)
    {
        List<InvestigationBulkData> lstBulkData = new List<InvestigationBulkData>();
        List<InvestigationBulkData> lstBulkData1 = new List<InvestigationBulkData>();
        List<string> items = new List<string>();
        long returnCode = -1;

        string[] strArray1 = contextKey.Split('~');
        long InvID = Convert.ToInt64(strArray1[0]);
        long GrpID = Convert.ToInt64(strArray1[1]);
        int OrgID = Convert.ToInt32(strArray1[2]);
        string KeyName = strArray1[3];


        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvBulkDataAuto(InvID, GrpID, OrgID, KeyName, out lstBulkData);

        if (lstBulkData.Count > 0)
        {
            var BulkData = from m in lstBulkData
                 .Where(m => m.Value.ToLower().StartsWith(prefixText.ToLower()))
                           select m;
            lstBulkData1 = BulkData.ToList();
            foreach (InvestigationBulkData item in lstBulkData1)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Value.ToString(), item.ResultID.ToString()));
            }
        }
        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void UpdateCurrentTask(long taskID)
    {
        try
        {
            long returncode = -1;
            BaseClass oBaseClass = new BaseClass();
            returncode = new Tasks_BL(oBaseClass.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, oBaseClass.LID, "ReleaseTask");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while updating current task", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GenerateReportBarcode(int Width, int Height, string BarcodeNumber, bool IncludeLabel, bool IsVertical)
    {
        string barcode = string.Empty;
        byte[] byteArray = new byte[0];
        try
        {
            byteArray = new BarcodeHelper().GetBarCodeImage(Width, Height, BarcodeNumber, IncludeLabel, IsVertical);
            barcode = System.Convert.ToBase64String(byteArray);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While generating report barcode", ex);
        }
        return barcode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string ReplaceNumberWithCommas(string resultValue)
    {
        string returnValue = resultValue;
        try
        {
            LabUtil oLabUtil = new LabUtil();
            returnValue = oLabUtil.ReplaceNumberWithCommas(resultValue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While replacing number with comma", ex);
        }
        return returnValue;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvOrganismDrugMapping> GetOrganismDrugDetails(long invID, long organismID, string organismCode, string type)
    {
        long returnCode = -1;
        List<InvOrganismDrugMapping> lstOrganismDrugDetails = new List<InvOrganismDrugMapping>();
        try
        {
            BaseClass oBaseClass = new BaseClass();
            returnCode = new Investigation_BL(oBaseClass.ContextInfo).GetOrganismDrugDetails(invID, organismID, organismCode, type, out lstOrganismDrugDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting organism drug details", ex);
        }
        return lstOrganismDrugDetails;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvestigationDrugBrand> GetOtherOrganismDrugDetails()
    {
        long returnCode = -1;
        List<InvestigationDrugBrand> lstInvDrugBrand = new List<InvestigationDrugBrand>();
        try
        {
            BaseClass oBaseClass = new BaseClass();
            returnCode = new Patient_BL(oBaseClass.ContextInfo).GetInvestigationDrugBrand(oBaseClass.OrgID, string.Empty, out lstInvDrugBrand);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting other organism drug details", ex);
        }
        return lstInvDrugBrand;
    }

    #region GetClientAndRefPhyAndLocation [GetClientAndRefPhyAndLocation]
    [WebMethod(EnableSession = true)]
    public string[] GetClientAndRefPhyAndLocation(string prefixText, string contextKey)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        List<OrganizationAddress> lstorgaddress = new List<OrganizationAddress>();
        List<string> items = new List<string>();
        int searchTypeID = 0;
        int orgID = 0;
        string KeyValue = string.Empty;
        Utilities objUtilities = new Utilities();
        objUtilities.GetApplicationValue("PatientRegistrationListCount", out KeyValue);
        if (contextKey != "")
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            searchTypeID = Convert.ToInt16(contextKey);
            Master_BL.GetClientAndRefPhyAndLocation(searchTypeID, prefixText, orgID, out lstClientMaster);
            if (lstClientMaster.Count > 0)
            {

                foreach (ClientMaster item in lstClientMaster.Take(Convert.ToInt32(KeyValue)))
                {
                    if (contextKey == "1")
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName + "(" + item.ClientCode + ")", item.ClientName + ":" + item.ClientID.ToString() + ":" + item.Status));
                    else
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientName + ":" + item.ClientID.ToString() + ":" + item.Status));

                }
            }


        }

        return items.ToArray();

    }
    #endregion
    #region Get BatchSheet No
    /* ----------------Prasanna.S - Batch sheet-----------------------*/
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetBatchSheet(string prefixText, string contextKey)
    {
        Investigation_BL Inv_BL = new Investigation_BL();
        List<BatchSheet> lstBatchSheet = new List<BatchSheet>();
        long returnCode = -1;
        int OrgID = -1;
        DateTime FromDate = DateTime.MinValue;
        DateTime ToDate = DateTime.MinValue;
        int SourceLocationID = -1;
        int ProcessingLocationID = -1;
        int IsExists = -1;
        string pType = string.Empty;
        if (contextKey.Contains('~'))
        {
            string[] listItems = contextKey.Split('~');
            Int32.TryParse(listItems[0], out OrgID);
            DateTime.TryParse(listItems[1], out FromDate);
            DateTime.TryParse(listItems[2], out ToDate);
            if (FromDate.ToString("dd/MM/yyyy 00:00:00") == "01/01/0001 00:00:00")
                FromDate = DateTime.Now;
            if (ToDate.ToString("dd/MM/yyyy 00:00:00") == "01/01/0001 00:00:00")
                ToDate = DateTime.Now;
            Int32.TryParse(listItems[3], out SourceLocationID);
            Int32.TryParse(listItems[4], out ProcessingLocationID);
            pType = listItems[5];
        }
        returnCode = Inv_BL.GetORCheckGeneratedBatch(OrgID, FromDate, ToDate, SourceLocationID, ProcessingLocationID, out IsExists, pType, out lstBatchSheet, prefixText);
        List<string> items = new List<string>();
        if (pType == "CHECK")
        {
            if (IsExists == 1)
                items.Add("Y");
            else
                items.Add("N");

        }
        else
        {
            if (lstBatchSheet.Count > 0)
            {
                foreach (BatchSheet item in lstBatchSheet)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.BatchNo.Split('~')[0], item.BatchID.ToString() + '~' + item.ProcessingLocationID.ToString() + '~' + item.BatchNo.Split('~')[1]));
                }
            }
        }

        return items.ToArray();
    }
    /* ----------------Prasanna.S - Batch sheet-----------------------*/
    #endregion


    /*/----------Sathish.E-------------/*/
    #region GetSamplesForBatch
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetSamplesForBatch(int Orgid, string BatchNo)
    {
        //List<List<SampleBatchTrackerDetails>> lstlstSampleBatchTrackerDetails = new List<List<SampleBatchTrackerDetails>>();
        List<SampleBatchTrackerDetails> lstSampleBatchTrackerDetails = new List<SampleBatchTrackerDetails>();
        List<SampleBatchTrackerConflictDetails> lstSampleBatchTrackerConflictDetails = new List<SampleBatchTrackerConflictDetails>();
        ArrayList a = new ArrayList();

        try
        {
            long returnCode = -1;
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetSamplesForBatch(Orgid, BatchNo, out lstSampleBatchTrackerDetails, out lstSampleBatchTrackerConflictDetails);
            a.Add(lstSampleBatchTrackerDetails);
            a.Add(lstSampleBatchTrackerConflictDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetSamplesForBatch Message:", ex);
        }
        return a;
    }
    #endregion

    /*/-----------Sathish.E-------------------/*/

    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteReflexTest(List<InvValueRangeMaster> lstInvValueRangeMaster)
    {

        long returnCode = -1;
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.DeleteReflexTest(lstInvValueRangeMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting InvOrgRefMapping details ", ex);
        }
    }

    #region GetAuditTrailReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<AuditTrailReport> GetAuditTrailReport(string ExternalVisitID, string ExternalBarcode, int Orgid)
    {
        long result = -1;

        List<AuditTrailReport> lstAuditTrailReport = new List<AuditTrailReport>();
        try
        {
            NewReports_BL ReportBL = new NewReports_BL(new BaseClass().ContextInfo);
            result = ReportBL.GetAuditTrailReport(ExternalVisitID, ExternalBarcode, Orgid, out lstAuditTrailReport);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        //return json;
        return lstAuditTrailReport;

    }
    #endregion


    #region GetDiscountSlab
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> GetDiscountSlab(int DiscountId)
    {
        List<DiscountMaster> lstDiscountMaster = new List<DiscountMaster>();
        List<DiscountMaster> lstDiscountReasonMaster = new List<DiscountMaster>();
        List<InvReasonOrgMapping> lstDisocuntReason = new List<InvReasonOrgMapping>();
        var list = new List<object>();
        try
        {
            long returnCode = -1;
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetDiscountSlab(DiscountId, out  lstDiscountMaster, out lstDisocuntReason);
            list.Add(lstDiscountMaster);
            list.Add(lstDisocuntReason);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting Discountslab  details:", ex);
        }
        return list;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod()]
    public string[] GetTestCodingDetails(string prefixText, int count, string contextKey)
    {
        List<CodingScheme> lstCodeMapper = new List<CodingScheme>();
        List<string> items = new List<string>();
        try
        {
            Int32 orgID = String.IsNullOrEmpty(contextKey) ? 0 : Convert.ToInt32(contextKey);
            new Master_BL(new BaseClass().ContextInfo).GetTestCodingDetails(orgID, prefixText, out lstCodeMapper);
            if (lstCodeMapper.Count > 0)
            {
                foreach (CodingScheme item in lstCodeMapper)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.CodeName, item.IdentifyingID + "~" + item.IdentifyingType));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetTestCodingDetails: ", ex);
        }
        return items.ToArray();
    }

    #endregion
    #region chkRecollectCount

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvestigationQueue> chkRecollectCount(long VisitId, long ID, int pOrgID)
    {
        List<InvestigationQueue> lstInvestigationQueue = new List<InvestigationQueue>();
        long result = -1;

        try
        {
            Investigation_BL InvBL = new Investigation_BL(new BaseClass().ContextInfo);
            result = InvBL.GetRecollectCount(VisitId, ID, pOrgID, out lstInvestigationQueue);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while GetDuplicateValidationonEntry", ex);
        }
        //long lngInvestigationID = Convert.ToInt64(InvestigationID);


        return lstInvestigationQueue;
    }
    #endregion
    #region GetVisitNumber
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<CommVisitNumberDetails> GetVisitNumber(string VisitNumber)
    {
        List<CommVisitNumberDetails> lstCommVisitDetails = new List<CommVisitNumberDetails>();
        try
        {
            Communication_BL communication_BL = new Communication_BL(new BaseClass().ContextInfo);
            lstCommVisitDetails = communication_BL.PGetVisitNumber(VisitNumber);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in nutrition Web Service GetFoodList Message:", ex);
        }
        return lstCommVisitDetails;
    }

    #endregion

    #region GetMemberDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientMembershipCardMapping> GetMemberDetails(string MemberCardNo, string CardType, string Type)
    {
        List<PatientMembershipCardMapping> lstPatientCardMap = new List<PatientMembershipCardMapping>();
        try
        {
            long returnCode = -1;
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetMemberDetails(MemberCardNo, CardType, Type, out  lstPatientCardMap);
            if (lstPatientCardMap.Count > 0)
                lstPatientCardMap[0].HasHealthCard = lstPatientCardMap[0].CreatedAt.ToString("dd/MM/yyyy hh:mm tt");
            // lstPatientCardMap[0].HasHealthCard = Convert.ToString(lstPatientCardMap[0].CreatedAt.GetDateTimeFormats()[25]);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting Discountslab  details:", ex);
        }

        return lstPatientCardMap;
    }
    #endregion

    #region CreateOTP
    public static readonly DateTime utc = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
    public static string GenerateOTP(string userId, long iterationNumber)
    {
        int digits = 6;
        byte[] iterationNumberByte = BitConverter.GetBytes(iterationNumber);
        if (BitConverter.IsLittleEndian) Array.Reverse(iterationNumberByte);

        byte[] userIdByte = Encoding.ASCII.GetBytes(userId);
        HMACSHA1 userIdHMAC = new HMACSHA1(userIdByte, true);
        byte[] hash = userIdHMAC.ComputeHash(iterationNumberByte);

        int offset = hash[hash.Length - 1] & 0xf;
        int binary =
            ((hash[offset] & 0x7f) << 24)
            | ((hash[offset + 1] & 0xff) << 16)
            | ((hash[offset + 2] & 0xff) << 8)
            | (hash[offset + 3] & 0xff);

        int password = binary % (int)Math.Pow(10, digits);
        return password.ToString(new string('0', digits));
    }
    #endregion

    #region GetOTP
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetOTP(long MembershipCardMappingId)
    {
        List<PatientMembershipCardMapping> lstPatientCardMap = new List<PatientMembershipCardMapping>();
        PageContextkey PC = new PageContextkey();
        string OTP = string.Empty;
        try
        {
            long returnCode = -1;
            long PatientID = -1;
            long OrgId = -1;
            long iteration = (long)(DateTime.UtcNow - utc).TotalSeconds;
            OTP = GenerateOTP(MembershipCardMappingId.ToString(), iteration);
            if (OTP != "")
            {
                PC.ButtonName = "btnGenerateOTP";
                PC.ButtonValue = "GenerateOTP";
                PC.PageID = 460;
                PC.RoleID = 1856;
                PC.FinalBillID = 0;
                //PageContextDetails.ButtonName = "btnGenerateOTP";
                //PageContextDetails.ButtonValue = "GenerateOTP";
                //PageContextDetails.ID = LID;// Assign OrgAdressID
                returnCode = new Investigation_BL(new BaseClass().ContextInfo).SaveMemberShipCardOTP(MembershipCardMappingId, OTP, out lstPatientCardMap);
                ActionManager objActionManager = new ActionManager(new BaseClass().ContextInfo);
                if (lstPatientCardMap.Count > 0)
                {
                    foreach (var lstPatientDetails in lstPatientCardMap)
                    {
                        PC.PatientID = lstPatientDetails.PatientID;
                        PC.OrgID = lstPatientDetails.OrgId;
                    }
                }
                // PC.PatientID = 39;
                // PC.OrgID = 67;
                // objActionManager.PerformingNextStep(PageContextDetails);
                objActionManager.PerformingNextStepNotification(PC, "", "");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generating OTP:", ex);
        }
        return OTP;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrganizationAddress> GetProcessingOrgLocation(Int32 OrgID, string OrgName, string Type)
    {
        long returnCode = -1;
        List<OrganizationAddress> lstProcessLocation = new List<OrganizationAddress>();
        try
        {
            returnCode = new Master_BL(new BaseClass().ContextInfo).GetProcessingOrgLocation(OrgID, OrgName, Type, out lstProcessLocation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting from GetProcessing Loction in webserivices.cs", ex);
        }
        return lstProcessLocation;

    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Organization> GetTestProcessingOrgName(int OrgID, string SubCategory)
    {
        long returnCode = -1;
        List<Organization> lstOrgName = new List<Organization>();
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.GetTestProcessingOrgName(OrgID, SubCategory, out lstOrgName);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting location ", ex);
        }
        return lstOrgName;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteInvLocationMapping(long ID, long InvID, int OrgID)
    {
        long returnCode = -1;
        try
        {
            Investigation_BL oInvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            returnCode = oInvestigationBL.DeleteInvLocationMapping(ID, InvID, OrgID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting DeleteInvLocationMapping details ", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrderedInvestigations> GetPatientdetailsForInvestigation(int visitid)
    {
        long returnCode = -1;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
        try
        {
            BaseClass ContextInfo = new BaseClass();
            returnCode = new Patient_BL(new BaseClass().ContextInfo).GetPatientDetailsForInvestigation(visitid, ContextInfo.OrgID, out lstOrderedInv);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting location ", ex);
        }
        return lstOrderedInv;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetPatientdetailsForInvestigationPrint(int pVisitID, int ILocationID, int OrgID, string inputType)
    {
        long returnCode = 0;
        Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
        string strInvStatus = InvStatus.Approved;
        List<string> lstInvStatus = new List<string>();
        lstInvStatus.Add(strInvStatus);
        List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        List<OrderedInvestigations> _PendingInvestigations = new List<OrderedInvestigations>();
        Investigation_BL ObjInv = new Investigation_BL(new BaseClass().ContextInfo);
        string PDFPath = string.Empty;
        string Status = string.Empty;
        //string IsDuePending = string.Empty;
        //returnCode = objReportBL.GetCheckDueAmount(PatientID, pVisitID, OrgID, ILocationID, "P", out IsDuePending);
        if (inputType == "WithStationary")
        {
            returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, true,"", out lstReportSnapshot);
        }
        if (inputType == "WithoutStationary")
        {
            returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, false,"", out lstReportSnapshot);
        }

        //if (IsDuePending == "N")
        //{
        if (lstReportSnapshot.Count > 0)
        {
            //if (IsDuePending == "N")
            //{

            returnCode = ObjInv.GetOrderedInvStatus(pVisitID, OrgID, lstReportSnapshot[0].AccessionNumber, out lstOrderedInvestigations);
            _PendingInvestigations = (from IL in lstOrderedInvestigations
                                      where IL.Status != InvStatus.Approved && IL.Status != InvStatus.PartialyApproved
                                      select IL).Distinct().ToList();
            if (_PendingInvestigations.Count > 0)
            {
                return "Report is not ready";
            }
            else if (lstReportSnapshot[0].ReportPath.Length > 0)
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready2');", true);
                PDFPath = lstReportSnapshot[0].ReportPath;
                return PDFPath;

            }
            //}
            else
            {
                return "Report is not ready";
            }
        }

        else
        {
            return "Report is not ready";

        }
    }

    #region For SampleWorkflow
    #region ShowSamplesforBarcode
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvSampleMaster> ShowSamplesforBarcode(string BarcodeNumber)
    {
        //List<List<SampleBatchTrackerDetails>> lstlstSampleBatchTrackerDetails = new List<List<SampleBatchTrackerDetails>>();
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();


        try
        {
            long returnCode = -1;
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).ShowSamplesforBarcode(BarcodeNumber, out lstInvSampleMaster);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service ShowSamplesforBarcode Message:", ex);
        }
        return lstInvSampleMaster;
    }
    #endregion
    #region Added for NewWorklist
    #region GetNewWorkListFromVisitToVisit
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<NewWorkList> GetNewWorkListFromVisitToVisit(string fromVisit, string toVisit, int OrgID, int deptID, int orgadd, int clientid,
             long LocationID, string searchType, string InvestigationName, int PriorityID,
            int intVisitType, string FromDate, string Todate, int pHistoryMode,
            string pPageMode, long pLoginId, string IsIncludevalues, string Preference, long WorklistID)
    {
        long result = -1;
        Investigation_BL InvestigationBL;
        List<NewWorkList> lstWorkList = new List<NewWorkList>();
        try
        {

            InvestigationBL = new Investigation_BL();
            InvestigationBL.GetNewWorkListFromVisitToVisit(fromVisit.ToString(), toVisit.ToString(), OrgID, deptID, orgadd
                , clientid, LocationID, searchType, InvestigationName, PriorityID, out lstWorkList, intVisitType,
                FromDate, Todate, pHistoryMode, "View", pLoginId, IsIncludevalues, Preference, WorklistID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetNewWorkListFromVisitToVisit in WebService", ex);
        }
        return lstWorkList;
    }
    #endregion
    #endregion

    #region Batchwise Enter Result
    #region GetBatchWiseInvestigationResultsCaptureFormat
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<PatientInvestigation> GetBatchWiseInvestigationResultsCaptureFormat(string VisitIDs, int OrgID, int RoleID, int deptID, string InvName, string InvType, long worklistid, long deviceid, string isAbnormalResult,
        long headerID, long protocalID, string ActionName, string isMaster, string workListType, long LID)
    {
        Investigation_BL InvestigationBL;
        LoginDetail objLoginDetail = new LoginDetail();
        List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
        List<InvestigationStatus> lstheaders = new List<InvestigationStatus>();
        List<RoleDeptMap> lRoleDeptMap = new List<RoleDeptMap>();
        try
        {
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            InvestigationBL = new Investigation_BL();
            InvestigationBL.GetBatchWiseInvestigationResultsCaptureFormat(VisitIDs, OrgID, RoleID, deptID, InvName, InvType, objLoginDetail, "N", worklistid, deviceid, isAbnormalResult,
                headerID, protocalID, ActionName, isMaster, workListType, out lstOrdered);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetBatchWiseInvestigationResultsCaptureFormat in WebService", ex);
        }
        return lstOrdered;
    }
    #region GetInvBulkData
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetInvBulkData(string guid, long InvestigationID, long patientVisitID, int orgID, int GroupID, string strlstInvPackageMapping)
    {
        List<InvestigationValues> lstBulkData = new List<InvestigationValues>();
        List<InvestigationValues> lstPendingValue = new List<InvestigationValues>();
        List<InvestigationStatus> header = new List<InvestigationStatus>();
        List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        List<InvPackageMapping> lstInvPackageMapping = new List<InvPackageMapping>();
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        lstInvPackageMapping = serializer.Deserialize<List<InvPackageMapping>>(strlstInvPackageMapping);
        ArrayList a = new ArrayList();

        try
        {
            long returnCode = -1;
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvBulkData(guid, InvestigationID, patientVisitID, orgID, GroupID, lstInvPackageMapping, out lstBulkData, out lstPendingValue, out header, out  lstiom);
            a.Add(lstBulkData);
            a.Add(lstPendingValue);
            a.Add(header);
            a.Add(lstiom);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetInvBulkData Message:", ex);
        }
        return a;
    }
    #region ConvertXmlToString
    [WebMethod(EnableSession = true)]
    public string ConvertXmlToString(string xmlData, string uom, string Gender, string Age, string AgeDays)
    {
        string ReferenceRange = string.Empty;
        string OtherReferenceRange = string.Empty;
        try
        {
            LabUtil oLabUtil = new LabUtil();
            oLabUtil.ConvertXmlToString(xmlData, uom, Gender, Age, AgeDays, out ReferenceRange, out OtherReferenceRange);
            ReferenceRange = !String.IsNullOrEmpty(ReferenceRange) ? ReferenceRange.Trim().Replace("<br>", "\n") : string.Empty;
        }
        catch (Exception ex)
        {
            ReferenceRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
        return ReferenceRange;
    }
    #region ValidateResultValue
    [WebMethod(EnableSession = true)]
    public string ValidateResultValue(string xmlData,string JsonStringData)
    {
        string returnValue = string.Empty;
        string textColor;
        string textControl;
        string RangeCode;
        string IsSensitive;
        textColor = "white";
        textControl = "";
        RangeCode = "white";
        IsSensitive = "N";
        int autocount = 0;
         autocount = Convert.ToInt32(Session["AutoAuthorCheck"]);//added by jegan
        LabUtil objlabutil = new LabUtil();
        int OrgID;
        string[] CatagoryxmlMain = xmlData.Split('|');
        string IsExcludeAutoApproval = CatagoryxmlMain[11];
        Int32.TryParse(CatagoryxmlMain[12], out OrgID);
        string Agedays = CatagoryxmlMain[13];
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        List<ReferenceRangeType> lstReferenceRangeType = oJavaScriptSerializer.Deserialize<List<ReferenceRangeType>>(JsonStringData);
        try
        {
            objlabutil.ValidateResult(xmlData, IsExcludeAutoApproval, OrgID, Agedays, out textColor, out RangeCode, out IsSensitive, autocount,lstReferenceRangeType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while parsing reference range", ex);
        }

        Dictionary<string, string> oDict = new Dictionary<string, string>();
        oDict["color"] = textColor;
        oDict["rangeCode"] = RangeCode;
        oDict["IsSensitive"] = IsSensitive;
        returnValue = oJavaScriptSerializer.Serialize(oDict);
        return returnValue;
    }
    #region sample Archival Master
    #region Get Sample SubType
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvSampleMaster> GetSampleSubType(int OrgID, long GroupTypeID)
    {
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        try
        {
            long returnCode = -1;
            returnCode = new Master_BL(new BaseClass().ContextInfo).GetSampleSubType(OrgID, GroupTypeID, out lstInvSampleMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetSampleSubType Message:", ex);
        }
        return lstInvSampleMaster;
    }
    #endregion
    #endregion
    #endregion
    #endregion
    #endregion
    #endregion
    #endregion


    #endregion

    #region GetpatientInvestigationForVisit
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrderedInvestigations> GetpatientInvestigationForVisit(long visitID, int orgID, int LocationID, string gUID)
    {
        string json = string.Empty;
        List<OrderedInvestigations> lstPatientInvestigation = new List<OrderedInvestigations>();
        var s = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            Investigation_BL DemoBL = new Investigation_BL(new BaseClass().ContextInfo);
            DemoBL.pGetpatientInvestigationForVisit(visitID, Convert.ToInt32(orgID), LocationID, gUID, out lstPatientInvestigation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetTestStatReport in WebService", ex);
        }
        return lstPatientInvestigation;
    }
    #endregion

    #region GetInvestigatonResultsCapture
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<PatientInvestigation> GetInvestigatonResultsCapture(long VID, int OrgID, long RoleID, string gUID, long DeptID, string InvIDs, int LocationID,
                                                long taskID, string IsTrustedDetails, string status, long LID)
    {
        Investigation_BL InvestigationBL;
        LoginDetail objLoginDetail = new LoginDetail();
        List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
        List<InvestigationStatus> lstheaders = new List<InvestigationStatus>();
        List<RoleDeptMap> lRoleDeptMap = new List<RoleDeptMap>();
        List<MedicalRemarksRuleMaster> lstmedRemarksRule = new List<MedicalRemarksRuleMaster>();
        try
        {
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            InvestigationBL = new Investigation_BL();
            InvestigationBL.GetInvestigatonResultsCapture(VID, OrgID, RoleID, gUID, DeptID, InvIDs, LocationID, objLoginDetail,
            taskID, IsTrustedDetails, status, out lstOrdered, out lstheaders, out lRoleDeptMap, out lstmedRemarksRule);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetInvestigatonResultsCapture in WebService", ex);
        }
        return lstOrdered;
    }
    #endregion

    #region InsertRemarks
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public Int64 InsertRemarks(string RemarkType, string RemarkCode, string Remark)
    {
        long returnCode = -1;
        returnCode = new Master_BL(new BaseClass().ContextInfo).InsertRemarks(RemarkType, RemarkCode, Remark, out returnCode);
        //return lstInvBulk ;
        return returnCode;
    }
    #endregion

    #region UpdateRemarks
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public Int64 UpdateRemarks(string RemarkType, int RemarkID, string Remarktext, string RemarkCode)
    {
        long returnCode = -1;
        returnCode = new Master_BL(new BaseClass().ContextInfo).UpdateRemarks(RemarkType, RemarkID, Remarktext, RemarkCode, out returnCode);
        //return lstInvBulk ;
        return returnCode;
    }
    #endregion

    #region GetInvestigationValuesReport
    [WebMethod(EnableSession = true)]
    public List<InvestigationsValueReport> GetInvestigationValuesReport(string FromDate, string ToDate, long ClientID)
    {
        long result = -1;
        List<InvestigationsValueReport> lstInvestigationValuesReport = new List<InvestigationsValueReport>();
        try
        {

            ReportBusinessLogic.ReportExcel_BL objReportExcel = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
            result = objReportExcel.GetInvestigationValuesReport(FromDate, ToDate, ClientID, out lstInvestigationValuesReport);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetInvestigationValuesReport in WebService", ex);
        }

        return lstInvestigationValuesReport;

    }
    #endregion
    #region GetTATAnalysisReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<TATAnalysis> GetTATAnalysisReport(DateTime FromDate, DateTime ToDate, int Routine, int LocationID, long ClientID, string FromStatus, string ToStatus)
    {
        long result = -1;
        string json = string.Empty;
        ArrayList NewArray = new ArrayList();
        DataSet DtlstTATAnalysis = new DataSet();
        List<TATAnalysis> lstTATAnalysis = new List<TATAnalysis>();
        var s = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            ReportBusinessLogic.ReportExcel_BL NBL = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
            result = NBL.GetTATAnalysisReport(FromDate, ToDate, Routine, LocationID, ClientID, FromStatus, ToStatus, out DtlstTATAnalysis);
            NewArray.Add(DtlstTATAnalysis);
            result = Utilities.ConvertTo(DtlstTATAnalysis.Tables[0], out lstTATAnalysis);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetTATAnalysisReport in WebService", ex);
        }
        return lstTATAnalysis;

    }
    #endregion
    #region GetPatientStatusDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Patient> GetPatientStatusDetails(DateTime pFromDate, DateTime pToDate, long pUserId, int pLocationId, string pLabNumber, string pStatus)
    {
        string json = string.Empty;
        List<Patient> listPatient = new List<Patient>();
        var s = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            string temptodate = string.Empty;
            temptodate = Convert.ToString(pToDate);
            string temp = temptodate.Split()[0] + " 23:59:59";
            pToDate = Convert.ToDateTime(temp);
            ReportBusinessLogic.ReportExcel_BL objReportExcelBL = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
            objReportExcelBL.GetPatientStatusDetails(pFromDate, pToDate, pUserId, pLocationId, pLabNumber, pStatus, out listPatient);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetPatientStatusDetails in WebService", ex);
        }

        return listPatient;
    }
    #endregion
    #region GetTestStatReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<TestStatistics> GetTestStatReport(DateTime FromDate, DateTime ToDate, int LocationId, int Routine, long ClientID)
    {
        long result = -1;
        string json = string.Empty;
        ArrayList NewArray = new ArrayList();
        DataSet DtTestStatistics = new DataSet();
        List<TestStatistics> lstTestStatistics = new List<TestStatistics>();
        var s = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            ReportBusinessLogic.ReportExcel_BL MBL = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
            result = MBL.GetTestStatReport(FromDate, ToDate, LocationId, Routine, ClientID, out DtTestStatistics);
            //string jsonData = GetJson(DtTestStatistics.Tables[0]);
            //return jsonData;
            NewArray.Add(DtTestStatistics);
            result = Utilities.ConvertTo(DtTestStatistics.Tables[0], out lstTestStatistics);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetTestStatReport in WebService", ex);
        }
        //return json;
        return lstTestStatistics;

    }
    #endregion

    #region Fish Pattern
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAutoComments(string prefixText, string contextKey)
    {

        List<InvestigationBulkData> lstBulkData = new List<InvestigationBulkData>();
        List<string> items = new List<string>();
        long returnCode = -1;

        string[] strArray1 = contextKey.Split('~');
        long InvID = Convert.ToInt64(strArray1[0]);
        long GrpID = Convert.ToInt64(strArray1[1]);
        int OrgID = Convert.ToInt32(strArray1[2]);
        string KeyName = strArray1[3];
        //Regex regexItem = new Regex("-");
        //if (regexItem.IsMatch(prefixText))
        //{
        //   string[] txt = prefixText.Split('-');
        //    prefixText = txt[1];
        //}
        returnCode = new Master_BL(new BaseClass().ContextInfo).GetAutoComments(InvID, prefixText, out lstBulkData);
        if (lstBulkData.Count > 0)
        {
            //var BulkData = from m in lstBulkData
            //     .Where(m => m.Value.ToLower().StartsWith(prefixText.ToLower()))
            //               select m;

            //lstBulkData1 = BulkData.ToList();
            foreach (InvestigationBulkData item in lstBulkData)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Value.ToString(), item.ResultID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion
    #region GetAllOrgInvestigations
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetOrgInvestigations(string prefixText, string contextKey)
    {
        Schedule_BL scheduleBL = new Schedule_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBFD = new List<BillingFeeDetails>();
        string desc = prefixText;
        int orgID = 0;
        int locationid = 0;
        string ItemsType = string.Empty;
        string[] strValue = contextKey.Split('~');
        Int32.TryParse(strValue[0], out orgID);
        ItemsType = strValue[1] == "" ? "" : strValue[1];
        scheduleBL.GetOrgInvestigations(orgID, locationid, desc, ItemsType, out lstBFD);
        if (lstBFD.Count > 0)
        {
            foreach (BillingFeeDetails item in lstBFD)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
            }
        }
        return items.ToArray();

    }
    #endregion
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Role> BindRole(int orgID)
    {
        long returnCode = -1;
        GateWay gateway = new GateWay(new BaseClass().ContextInfo);
        List<Role> userRoles = new List<Role>();
        Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        loggedIn.LoginID = Convert.ToInt64(Session["LID"]);
        returnCode = gateway.GetRoles(loggedIn, out userRoles);
        List<Role> lstRoles = new List<Role>();
        lstRoles = (from child in userRoles
                    where child.OrgID == orgID
                    orderby child.Description
                    select new Role { RoleName = child.RoleID + "~" + child.RoleName + "~" + child.Description, Description = child.Description, OrgID = child.OrgID, OrgName = child.OrgName }).Distinct().ToList();
        return lstRoles;
    }
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrganizationAddress> BindLocation(int orgID, long RoleID)
    {
        long returnCode = -1;
        Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        loggedIn.LoginID = Convert.ToInt64(Session["LID"]);
        PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(orgID, Convert.ToInt64(Session["LID"]), RoleID, out lstLocation);
        return lstLocation;
    }
    /*-----------Added by Arivalagn.k-------------*/
    #region Get CountryWise ClientNames
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetCountryWiseClientNames(string prefixText, string contextKey)
    {
        ReportBusinessLogic.ReportExcel_BL rptExcel_BL = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstcl = new List<ClientMaster>();
        List<string> items = new List<string>();
        long lresutl = -1;
        int orgID = 0;
        int countryid = 0;
        if (contextKey.Contains("^"))
        {
            string[] GetContextKey = contextKey.Split('^');
            Int32.TryParse(GetContextKey[0].ToString(), out orgID);
            Int32.TryParse(GetContextKey[1].ToString(), out countryid);


        }
        else
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        }


        lresutl = rptExcel_BL.GetCountryWiseClientNames(prefixText, orgID, countryid, out lstcl);
        if (lstcl.Count > 0)
        {
            foreach (ClientMaster item in lstcl)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.ClientID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion
    /*-----------Added by Arivalagn.k-------------*/
    #region Get Org based User Names

    [WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    public string[] getUserNames(string prefixText, string contextKey)
    {


        string[] strValue = contextKey.Split('~');
        int orgID = (strValue[0] != null) ? Convert.ToInt32(strValue[0]) : 0;
        string pCategory = (strValue[1] != null) ? strValue[1] : string.Empty;
        string pStatus = (strValue[2] != null) ? strValue[2] : string.Empty;
        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;

        returnCode = arBL.GetUserNames(orgUserName, orgID, pCategory, pStatus, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)
        {
            strUserNames = new string[lstOrgUsers.Count];
            for (int i = 0; i < lstOrgUsers.Count; i++)
            {
                strUserNames[i] = lstOrgUsers[i].Name;
            }
        }
        return strUserNames;
    }


    #endregion
    #region Delete RoundMaster Client

    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteRoundMasterClient(int ID, long roundID)
    {
        long returnCode = -1;
        try
        {
            Master_BL oMasterBL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = oMasterBL.DeleteRoundMasterClient(ID, roundID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting DeleteRoundMasterClient details ", ex);
        }
    }

    #endregion
    #region Check RoundName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList CheckRoundName(string prefixText)
    {
        Master_BL oMasterBL = new Master_BL(new BaseClass().ContextInfo);
        ArrayList a = new ArrayList();
        long lresutl = -1;
        int Id = 0;
        int orgID = 0;

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        try
        {
            lresutl = oMasterBL.CheckRoundName(prefixText, orgID, out Id);
            a.Add(Id);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service CheckRoundName Message:", ex);
        }
        return a;
    }
    #endregion
    /*-----------End by Arivalagn.k-------------*/

    /*/----------------premanand-----------------/*/
    #region CheckExistingBarcode
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientInvSample> CheckExistingBarcode(int OrgID, string Barcodenumber)
    {
        long returnCode = -1;
        List<PatientInvSample> lstBarcode = new List<PatientInvSample>();
        try
        {
            Master_BL objMaster = new Master_BL(new BaseClass().ContextInfo);
            returnCode = objMaster.CheckExistingBarcode(OrgID, Barcodenumber, out lstBarcode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading CheckExistingBarcode", ex);
        }
        return lstBarcode;
    }
    #endregion
    /*/-----------------------------------------/*/
    #region GetBloodGroupCard
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]

    public List<BloodGroupCard> GetBloodGrpCard(int OrgID, DateTime fromdate, DateTime todate, int Addressid, int RoundID)
    {
        long returnCode = -1;
        string json = string.Empty;
        List<BloodGroupCard> lstbldgrpcrd = new List<BloodGroupCard>();
        try
        {
            ReportBusinessLogic.ReportExcel_BL objReportBL = new ReportBusinessLogic.ReportExcel_BL();
            returnCode = objReportBL.getBloodGrpCard(OrgID, fromdate, todate, Addressid, RoundID, out lstbldgrpcrd);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetBloodGroupCard in WebService", ex);
        }
        return lstbldgrpcrd;
    }
    #endregion
    ///Karthick/////////////


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<TNPReport> GetTNPReport(DateTime FromDate, DateTime ToDate, int orgid)
    {
        long result = -1;
        string json = string.Empty;
        ArrayList NewArray = new ArrayList();
        DataSet DtlstTNPReport = new DataSet();

        List<TNPReport> lstTNPReport = new List<TNPReport>();
        var s = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            Attune.Solution.BusinessComponent.ReportExcel_BL NBL = new Attune.Solution.BusinessComponent.ReportExcel_BL(new BaseClass().ContextInfo);
            result = NBL.GetTNPReport(FromDate, ToDate, orgid, out DtlstTNPReport);
            NewArray.Add(DtlstTNPReport);
            result = Utilities.ConvertTo(DtlstTNPReport.Tables[0], out lstTNPReport);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetTRPReport in WebService", ex);
        }
        return lstTNPReport;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPatientListWithDetails(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        long retCode = -1;
        int orgID = 0;
        string IsCorporateOrg = string.Empty;
        Utilities objUtilities = new Utilities();
        string KeyValue = string.Empty;
        objUtilities.GetApplicationValue("PatientRegistrationListCount", out KeyValue);
        //string[] PatientList = null;
        List<string> items = new List<string>();
        if (Session["RoleName"].ToString() != "Referring Physician")
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            IsCorporateOrg = Session["IsCorporateOrg"].ToString();
            if (IsCorporateOrg == "N")
            {
                retCode = PatBL.GetPatientListForRegis(prefixText, "", orgID, out lstPatient);
            }
            if (lstPatient.Count > 0)
            {
                foreach (Patient item in lstPatient.Take(Convert.ToInt32(KeyValue)))
                {
                    string SmartCardNo = item.SmartCardNumber != null ? item.SmartCardNumber.ToString() : "";

                    if (contextKey == "N")
                    {
                        string status = string.Empty;
                        string[] arr = new string[10];
                        if (item.Comments != "" && item.Comments != null)
                        {
                            arr = item.Comments.Split('~');
                            status = arr[4].ToString();
                        }
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name +
                        "-(Urn NO :" + item.URNO.ToString() + "-" + item.OrgName + ")", status));
                    }
                    else if (contextKey == "Y")
                    {

                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name +
                            "-(Urn NO :" + item.URNO.ToString() + ")~" + item.PatientID.ToString() + "~" + SmartCardNo, item.Add1 + "~" + item.Add2 + "~" + item.Add3 + "~" + item.City + "~" + item.StateName + "~" + item.CountryName + "~" + item.Age + "~" + item.SEX + "~" + item.MobileNumber + "~" + item.Name));
                    }
                    else if (contextKey == "NameOnly")
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.PatientID.ToString()));
                    }
                    else
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name +
                        "(Patient No :" + item.PatientNumber.ToString() + ")", item.PatientID.ToString()));
                    }

                }

            }
        }
        return items.ToArray();
    }

    /*-----------Added by Arivalagn.k-------------*/
    #region Get Visit Wise Search MIS Report
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<VisitWiseSearchMISReport> GetVisitWiseSearchMISReport(
        long Orgid, long Location, long VisitType, string VisitStatus, long PatientId, string VisitNo, string ReferenceNo, long MobileNumber, long ClientID,
         long RefPhyID, string FromDate, string ToDate
        )
    {
        long result = -1;
        List<VisitWiseSearchMISReport> lstVisitWiseSearchMISReport = new List<VisitWiseSearchMISReport>();
        try
        {
            ReportBusinessLogic.ReportExcel_BL ReportBL = new ReportBusinessLogic.ReportExcel_BL(new BaseClass().ContextInfo);

            result = ReportBL.GetVisitWiseSearchMISReport(Orgid, Location, VisitType, VisitStatus, PatientId, VisitNo, ReferenceNo, MobileNumber,
                ClientID, RefPhyID, FromDate, ToDate, out lstVisitWiseSearchMISReport);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        //return json;
        return lstVisitWiseSearchMISReport;

    }
    #endregion
    #region Insert Notification Manual
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public void InsertNotificationManual(long OrgId, long Locationid, long Visitid, string Type, string Emailaddress)
    {
        long result = -1;
        try
        {
            Report_BL ReportBL = new Report_BL(new BaseClass().ContextInfo);

            result = ReportBL.InsertNotificationManual(OrgId, Locationid, Visitid, Type, Emailaddress);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        //return json;
    }
    #endregion
    /*-----------End by Arivalagn.k-------------*/
    #region Textual Pattern upgrade - Multiple templates need to be load in single parameter and Template value
    [WebMethod(EnableSession = true)]

    public List<InvResultTemplate> GetInvestigationResultTemplateByID(int POrgid, int ResultID, string ResultName)
    {
        long returnCode = -1;

        List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
        returnCode = new Investigation_BL(new BaseClass().ContextInfo)
            .GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), ResultID, ResultName, "TextReport", out lResultTemplate);


        List<InvResultTemplate> Addvalue = new List<InvResultTemplate>();
        // lResultTemplate
        foreach (var s in lResultTemplate)
        {
            Addvalue.Add(new InvResultTemplate
            {
                DeptID = s.DeptID,
                OrgID = s.OrgID,
                ResultID = s.ResultID,
                ResultName = s.ResultName,
                ResultTemplateType = s.ResultTemplateType,
                ResultValues = s.ResultValues
            });
        }



        return lResultTemplate;
    }

    #endregion
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public void ReleaseCurrentTask(long vid)
    {
        try
        {
            long returncode = -1;
            BaseClass oBaseClass = new BaseClass();
            returncode = new Investigation_BL(oBaseClass.ContextInfo).UpdateTaskPickedByDetails("1", vid, oBaseClass.LID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while releasing current task", ex);
        }
    }
    //GetEnterResultTask
    #region GetEnterResultTask
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<EnterResult> GetEnterResultTask(int OrgAddID, int OrgID, long RoleID, int currentPageNo, int PageSize, int PatientId, string PatientName, int intVisitType, long lngSourceId,
                                                      string wardno, string status, string invname, string fdate, string tdate, int priority, string VisitNumber, string PatNumber, string Type, long DeptID, string pTaskAction, int pRefPhyID, long pLocationID, string IsTimed, long ProtocalGroupID, string BarcodeNumber, string tasks, string SampleID)
    {

        Investigation_BL InvestigationBL;
        List<EnterResult> lstDetails = new List<EnterResult>();
        LoginDetail objLoginDetail = new LoginDetail();
        //long LID;
        try
        {
            //objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            InvestigationBL = new Investigation_BL();
            InvestigationBL.GetLabInvestigationPatientSearch(OrgAddID, OrgID, RoleID, currentPageNo, PageSize, PatientId, PatientName, out lstDetails, out totalRows, intVisitType,
                //  Convert.ToInt64(ddlSourceName.SelectedItem.Value.ToString())
                                                   -1, wardno, status, invname,
                                                   fdate, tdate, priority, VisitNumber, PatNumber, Type, DeptID, "EnterResult", 0, 0,
                                                   objLoginDetail, IsTimed, ProtocalGroupID, BarcodeNumber, tasks, SampleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetInvestigatonResultsCapture in WebService", ex);
        }
        return lstDetails;
    }
    #endregion
    //GetInvestigationshowincollecttasks
    #region GetInvestigationshowincollecttasks
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrderedInvestigations> GetInvestigationshowincollecttasks(long visitID, int orgID, int LocationID, string Labno)
    {
        Investigation_BL InvestigationBL;
        List<OrderedInvestigations> lstOrderDetails = new List<OrderedInvestigations>(); ;
        LoginDetail objLoginDetail = new LoginDetail();
        //long LID;
        try
        {
            orgID = Convert.ToInt32(Session["OrgID"]);
            LocationID = Convert.ToInt32(Session["LocationID"]);
            objLoginDetail.LoginID = Convert.ToInt32(Session["LID"]);
            objLoginDetail.RoleID = Convert.ToInt32(Session["RoleID"]);
            objLoginDetail.Orgid = Convert.ToInt32(Session["OrgID"]);
            InvestigationBL = new Investigation_BL();
            InvestigationBL.GetInvestigationshowincollecttasks(visitID, orgID, LocationID, Labno, objLoginDetail, out lstOrderDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetInvestigatonResultsCapture in WebService", ex);
        }
        return lstOrderDetails;
    }
    #endregion
    // ----------Added by vijayalakshmi.M-----------------//
    #region
    [WebMethod(EnableSession = true)]
    public string GetBarcodeNo(long VisitId, int SampleCode, string BarcodeNumber)
    {
        List<PatientInvSample> lstbarcode = new List<PatientInvSample>();
        string Barcode = string.Empty;
        long returnCode = -1;
        try
        {
            if (Session["OrgID"] != null)
            {
                Int32 OrgID = Convert.ToInt32(Session["OrgID"]);
                Investigation_BL InvBL = new Investigation_BL(new BaseClass().ContextInfo);

                returnCode = InvBL.GetBarcodeNo(OrgID, SampleCode, VisitId, BarcodeNumber, out Barcode);


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting next barcode", ex);
        }
        return Barcode;
    }
    #endregion
    #region
    [WebMethod(EnableSession = true)]
    public List<NewInstanceCreationTracker> CreateatedOrgInstanceDetail(long ReturnStatus, long OrgID)
    {
        long returnCode = -1;
        List<NewInstanceCreationTracker> lstNICT = new List<NewInstanceCreationTracker>();
        List<NewInstanceCreationTracker> lstNICT1 = new List<NewInstanceCreationTracker>();
        try
        {
            if (Session["OrgID"] != null)
            {
                Int32 OrgId = Convert.ToInt32(Session["OrgID"]);
                NewInstance InstanceBL = new NewInstance(new BaseClass().ContextInfo);
                returnCode = InstanceBL.CreateatedOrgInstanceDetail(out lstNICT, out ReturnStatus);
                lstNICT1 = lstNICT;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting next barcode", ex);
        }
        return lstNICT1;
    }
    #endregion
    #region
    [WebMethod(EnableSession = true)]
    public List<NewInstanceWaitingCustomers> Getmyloc(int InstacneID)
    {
        long returnCode = -1;
        List<NewInstanceWaitingCustomers> lstLoc = new List<NewInstanceWaitingCustomers>();
        try
        {
            AdminReports_BL AdminBL = new AdminReports_BL(new BaseClass().ContextInfo);
            returnCode = AdminBL.pgetmyloc(InstacneID, out lstLoc);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting next barcode", ex);
        }
        return lstLoc;
    }
    #endregion
    #region
    [WebMethod(EnableSession = true)]
    public List<State> LoadState(int CountryId)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(new BaseClass().ContextInfo);
        long returnCode = -1;
        try
        {
            returnCode = stateBL.GetStateByCountry(CountryId, out states);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
        return states;
    }
    #endregion
    #region Jquery DataTable
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<PatientInvestigation> GetPendingList(int OrgID, long RoleID, long InvID, string InvType, long LoginId,
                  string IsTrustedDetails, long deviceid, long protocalID, String fromdate, String todate, string pStatus, string IsStat, long pDeptid, string pGroupLevel)
    {
        List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
        try
        {
            Investigation_BL InvestigationBL;
            InvestigationBL = new Investigation_BL(new BaseClass().ContextInfo);
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LoginId;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            DateTime Fdate;
            DateTime Tdate;
            Fdate = Convert.ToDateTime(fromdate);
            Tdate = Convert.ToDateTime(todate);
            InvestigationBL.GetPendingList(OrgID, RoleID, InvID, InvType, objLoginDetail, IsTrustedDetails, deviceid,
                           protocalID, Fdate, Tdate, pStatus, IsStat, pDeptid,pGroupLevel, out lstOrdered);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetPendingList in WebService", ex);
        }

        return lstOrdered;
    }
    #endregion
    #region AB Code for Rolling Advance
    /**/
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<ClientMaster> GetRollingAdvanceClients()
    {
        List<ClientMaster> lstAttributesDetails = new List<ClientMaster>();
        try
        {
            Master_BL MasterBL = new Master_BL(new BaseClass().ContextInfo);
            MasterBL.GetRollingAdvanceClients(out lstAttributesDetails);

        }
        catch (Exception ex)
        {
            ex.ToString();

        }

        return lstAttributesDetails;
    }
    #endregion

    #region NewHCUser
    public class HCUserList
    {
        public string UserName { get; set; }
        public long LoginID { get; set; }

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<HCUserList> getUserNamesWithLoginID_HomeCollection(string prefixText, string contextKey)
    {
        int OrgID = 0;
        string strAuthTypeName = "Phlebotomist";
        if (Session["OrgID"] != null)
        {
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
        }
        //Int32.TryParse(contextKey, out OrgID);


        AdminReports_BL arBL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        List<HCUserList> lsthcUserName = new List<HCUserList>();
        List<string> items = new List<string>();
        long returnCode = -1;
        orgUserName = prefixText;
        string[] strUserNames = null;
        returnCode = arBL.GetUserNameWithLoginID(orgUserName, OrgID, strAuthTypeName, out lstOrgUsers);
        if (lstOrgUsers.Count > 0)

            foreach (OrgUsers OrgUsers in lstOrgUsers)
            {
                string Name = OrgUsers.Name.ToString() != null ? OrgUsers.Name.ToString() : "";
                long LoginID = OrgUsers.LoginID != null ? OrgUsers.LoginID : 0;

                if (contextKey == "Y")
                {
                    HCUserList hcUserName = new HCUserList();
                    hcUserName.UserName = Name;
                    hcUserName.LoginID = LoginID;
                    lsthcUserName.Add(hcUserName);
                    // items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(Name, Name + "~" + LoginID));

                }

            }

        return lsthcUserName;
    }

    #endregion


    //...............Ledger Start Here......................................................//
    #region GetCreditDebitStatus [GetCreditDebitStatus]

    [WebMethod(EnableSession = true)]
    public List<ClientCreditDebit> GetCreditDebitStatus(string orgid, string Clientcode, string fromdate, string todate, string FilterType, string ddlFilter)
    {
        int Orgid = Convert.ToInt32(orgid);
        DateTime from = Convert.ToDateTime(fromdate);
        DateTime to = Convert.ToDateTime(todate);
        ClientLedger_BL ObjClientStatus = new ClientLedger_BL();
        List<ClientCreditDebit> lstClientStatus = new List<ClientCreditDebit>();
        List<string> items = new List<string>();
        try
        {
            ObjClientStatus.GetCreditDebitStatus(Orgid, FilterType, Clientcode, ddlFilter, from, to, out lstClientStatus);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetCreditDebitStatus in WebService", ex);
        }
        return lstClientStatus;
    }
    #endregion

    #region GetCreditHistory [GetCreditHistory]
    [WebMethod(EnableSession = true)]

    public List<ClientCredit> GetCreditHistory(string clientcode, string orgid)
    {
        int orgID = Convert.ToInt32(orgid);
        List<ClientCredit> lstCreditHistory = new List<ClientCredit>();
        try
        {

            ClientLedger_BL ObjCreditHistory = new ClientLedger_BL();
            ObjCreditHistory.GetCreditOutstandingHistory(orgID, clientcode, out lstCreditHistory);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetCreditHistory in WebService", ex);
        }
        return lstCreditHistory;

    }
    #endregion
    #region GetDebitHistory [GetDebitHistory]
    [WebMethod(EnableSession = true)]

    public List<ClientDebit> GetDebitHistory(string clientcode, string orgid)
    {
        int orgID = Convert.ToInt32(orgid);
        List<ClientDebit> lstDebitHistory = new List<ClientDebit>();
        try
        {

            ClientLedger_BL ObjCreditHistory = new ClientLedger_BL();
            ObjCreditHistory.GetDebitOutstandingHistory(orgID, clientcode, out lstDebitHistory);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetDebitHistory in WebService", ex);
        }
        return lstDebitHistory;

    }
    #endregion
    #region GetBillsHistory [GetBillsHistory]
    [WebMethod(EnableSession = true)]

    public List<ClientBill> GetBillsHistory(string clientcode, string orgid)
    {
        int orgID = Convert.ToInt32(orgid);
        List<ClientBill> lstBillsHistory = new List<ClientBill>();
        try
        {

            ClientLedger_BL ObjCreditHistory = new ClientLedger_BL();
            ObjCreditHistory.GetBillOutstandingHistory(orgID, clientcode, out lstBillsHistory);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetBillsHistory in WebService", ex);
        }
        return lstBillsHistory;

    }
    #endregion
    #region GetReceiptHistory [GetReceiptHistory]
    [WebMethod(EnableSession = true)]

    public List<ClientReceipt> GetReceiptHistory(string clientcode, string orgid)
    {
        int orgID = Convert.ToInt32(orgid);
        List<ClientReceipt> lstReceiptHistory = new List<ClientReceipt>();
        try
        {

            ClientLedger_BL ObjCreditHistory = new ClientLedger_BL();
            ObjCreditHistory.GetReceiptOutstandingHistory(orgID, clientcode, out lstReceiptHistory);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetReceiptHistory in WebService", ex);
        }
        return lstReceiptHistory;

    }
    #endregion
    #region Get TSP Outstanding Details
    [WebMethod(EnableSession = true)]
    public List<ClientOutStanding> GetClientOutstanding(int OrgID, string ClientCode)
    {
        long returncode = -1;
        ClientLedger_BL ObjClientoutstand = new ClientLedger_BL();
        List<ClientOutStanding> lstOustanding = new List<ClientOutStanding>();
        try
        {
            returncode = ObjClientoutstand.GetClientOutstanding(OrgID, ClientCode, out lstOustanding);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Client OutStanding Details in Web Service", ex);
        }
        return lstOustanding;

    }
    #endregion

    #region SaveClientCredit
    [WebMethod(EnableSession = true)]

    public string SaveClientCredit(string lstClientCredit)
    {
        string retuencode = "0";
        long successcode = 0;
        List<ClientCredit> lstClientCreditList = new List<ClientCredit>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        try
        {
            if (lstClientCredit != "")
            {
                lstClientCreditList = serializer1.Deserialize<List<ClientCredit>>(lstClientCredit);
            }
            if (lstClientCreditList.Count > 0)
            {
                ClientLedger_BL Objoutstanding_BL = new ClientLedger_BL(new BaseClass().ContextInfo);
                ClientCredit objClientCredit = new ClientCredit();
                objClientCredit.OrgID = lstClientCreditList[0].OrgID;
                objClientCredit.Narration = lstClientCreditList[0].Narration;
                objClientCredit.SourceCode = lstClientCreditList[0].SourceCode;
                objClientCredit.CreatedBy = lstClientCreditList[0].CreatedBy;
                objClientCredit.BarCode = lstClientCreditList[0].BarCode;
                objClientCredit.Amount = lstClientCreditList[0].Amount;
                objClientCredit.Category = lstClientCreditList[0].Category;
                objClientCredit.Remarks = lstClientCreditList[0].Remarks;
                Objoutstanding_BL.SaveClientCredit(objClientCredit, out  successcode);
                retuencode = successcode.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientCredit in WebService", ex);
        }
        return retuencode;

    }
    #endregion
    #region SaveClientDebit
    [WebMethod(EnableSession = true)]

    public string SaveClientDebit(string lstClientDebit)
    {
        string retuencode = "0";
        long successcode = 0;

        //int orgID = Convert.ToInt32(orgid);
        List<ClientDebit> lstClientDebitList = new List<ClientDebit>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        try
        {
            if (lstClientDebit != "")
            {
                lstClientDebitList = serializer1.Deserialize<List<ClientDebit>>(lstClientDebit);
            }
            if (lstClientDebitList.Count > 0)
            {
                ClientLedger_BL Objoutstanding_BL = new ClientLedger_BL(new BaseClass().ContextInfo);
                ClientDebit objClientDebit = new ClientDebit();
                objClientDebit.OrgID = lstClientDebitList[0].OrgID;
                objClientDebit.Narration = lstClientDebitList[0].Narration;
                objClientDebit.SourceCode = lstClientDebitList[0].SourceCode;
                //objClientCredit.CreatedAt = lstClientCreditList[0].CreatedAt;
                objClientDebit.CreatedBy = lstClientDebitList[0].CreatedBy;
                objClientDebit.BarCode = lstClientDebitList[0].BarCode;
                objClientDebit.Amount = lstClientDebitList[0].Amount;
                objClientDebit.Category = lstClientDebitList[0].Category;
                objClientDebit.Remarks = lstClientDebitList[0].Remarks;
                Objoutstanding_BL.SaveClientDebit(objClientDebit, out  successcode);
                retuencode = successcode.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientDebit in WebService", ex);
        }
        return retuencode;

    }
    #endregion

    # region Ledger Credit/Debit Narration
    [WebMethod(EnableSession = true)]
    public List<CreditDebitNarration> GetCreditDebitNarrationList(string Type)
    {
        List<CreditDebitNarration> lstClientNarattion = new List<CreditDebitNarration>();
        try
        {
            ClientLedger_BL ObjClientNar = new ClientLedger_BL(new BaseClass().ContextInfo);
            string typeval = Type;
            ObjClientNar.GetNarrationList(typeval, out lstClientNarattion);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading Client Narrration List ", ex);
        }
        return lstClientNarattion;
    }
    # endregion

    #region Create TSP Outstanding Payment Session Details
    [WebMethod(EnableSession = true)]
    public string CreateClientOutstandingPayLinkSession(string ClientCode, string Amount)
    {
        string lstOustanding = "";
        decimal creditlimit = 0;
        try
        {
            if (ClientCode != "" && Amount != "")
            {
                Session["PaymentClientCode"] = ClientCode;
                Session["ClientPaymentAmount"] = Amount;
                lstOustanding = "Success";
                if (creditlimit == 0)
                {
                    Session["ZeroCreditLimitAmount"] = 0;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Create Client OutStanding Payment Session Details in Web Service", ex);
        }
        return lstOustanding;

    }
    #endregion

    #region Load TSP Session Default Details BasedOnOrgLocation
    [WebMethod(EnableSession = true)]
    public List<InvClientMaster> LoadDefaultClientNameBasedOnOrgLocation(string pType, long OrgID, long refhospid)
    {
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        try
        {
            lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading LoadDefaultClientNameBasedOnOrgLocation in page ClientOutstandingPayment.aspx :" + ex.ToString() + " Inner Exception-", ex.InnerException);
        }
        return lstClientNames;
    }
    #endregion













    #region SaveClientReceipt
    [WebMethod(EnableSession = true)]

    public string SaveClientReceipt(string lstClientReceipt, string Address)
    {
        string retuencode = "0";
        long SuccessCode = 0;
        string filepath = Address.Replace("|", @"\");//replace the symbol | to \
        List<ClientReceipt> lstClientReceiptList = new List<ClientReceipt>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        //var routes_list = (IDictionary<string, object>)serializer1.DeserializeObject(lstClientReceipt);
        try
        {
            if (lstClientReceipt != "")
            {
                lstClientReceiptList = serializer1.Deserialize<List<ClientReceipt>>(lstClientReceipt);
                lstClientReceiptList[0].UploadedImages = filepath.ToString();
            }
            if (lstClientReceiptList.Count > 0)
            {
                ClientLedger_BL Objoutstanding_BL = new ClientLedger_BL(new BaseClass().ContextInfo);

                // commented by rajasuba for client ledger not needed 

                // Objoutstanding_BL.SaveClientReceipt(lstClientReceiptList, out SuccessCode);
                retuencode = SuccessCode.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientReceipt in WebService", ex);
        }
        return retuencode;

    }
    #endregion


    //Kamaraj 




    #region GetReceiptStatus [GetReceiptStatus]

    [WebMethod(EnableSession = true)]
    public List<ClientReceiptDetail> GetReceiptStatus(string orgid, string Clientcode, string FilterType, string fromdate, string todate)
    {
        int Orgid = Convert.ToInt32(orgid);
        DateTime from = Convert.ToDateTime(fromdate);
        DateTime to = Convert.ToDateTime(todate);
        ClientLedger_BL ObjClientStatus = new ClientLedger_BL();
        List<ClientReceiptDetail> lstClientReceiptDetail = new List<ClientReceiptDetail>();
        List<string> items = new List<string>();
        try
        {
            ObjClientStatus.GetReceiptStatus(Orgid, Clientcode, FilterType, from, to, out lstClientReceiptDetail);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetReceiptStatus in webservice", ex);
        }
        return lstClientReceiptDetail;
    }
    #endregion
    #region TSP Recommend List Details
    [WebMethod(EnableSession = true)]
    public List<ClientCreditDebit> GetTSPCreditDebitRecommend(int OrgID, string Status, string Type, string ClientCode)
    {
        long lresutl = -1;
        ClientLedger_BL ObjCreditDebitRecommend = new ClientLedger_BL(new BaseClass().ContextInfo);
        List<ClientCreditDebit> lstClientCreditDebit = new List<ClientCreditDebit>();
        try
        {
            lresutl = ObjCreditDebitRecommend.GetCreditDebitRecommend(OrgID, Status, Type, ClientCode, out lstClientCreditDebit);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetTSPCreditDebitRecommend in webservice :" + ex.ToString() + " Inner Exception-", ex.InnerException);
        }
        return lstClientCreditDebit;
    }
    #endregion

    #region Selected TSP CreditDebit Details
    [WebMethod(EnableSession = true)]
    public List<ClientCreditDebit> GetSelectedTSPCreditDebit(long Id, int OrgId, string Type)
    {
        ClientLedger_BL objcredit_BL = new ClientLedger_BL(new BaseClass().ContextInfo);
        List<TSPClientDetails> lstTSPClientDetails = new List<TSPClientDetails>();
        List<ClientCreditDebit> lstClientCreditDebit = new List<ClientCreditDebit>();
        try
        {
            objcredit_BL.GetSelectedTSPCreditDebit(OrgId, Type, Id, out lstTSPClientDetails, out lstClientCreditDebit);
            if (lstTSPClientDetails.Count > 0)
            {
                string name = lstTSPClientDetails[0].ClientName;
                lstClientCreditDebit = lstClientCreditDebit.Select(e => { e.Address2 = name; return e; }).ToList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Create Client OutStanding Payment Session Details in Web Service", ex);
        }
        return lstClientCreditDebit;
    }
    #endregion

    #region Selected TSP CreditDebit Details
    [WebMethod(EnableSession = true)]
    public void SaveCreditDebitRecommentation(string lstClientCredit)
    {
        JavaScriptSerializer serilize = new JavaScriptSerializer();
        ClientLedger_BL objcredit_BL = new ClientLedger_BL(new BaseClass().ContextInfo);
        ClientCreditDebit objClientCreditDebit = new ClientCreditDebit();
        List<ClientCreditDebit> lstClientCreditDebit = new List<ClientCreditDebit>();
        try
        {
            if (lstClientCredit != "")
            {
                lstClientCreditDebit = serilize.Deserialize<List<ClientCreditDebit>>(lstClientCredit);
                if (lstClientCreditDebit.Count > 0)
                {
                    lstClientCreditDebit = lstClientCreditDebit.Select(e => { e.ModifiedAt = DateTime.Now; e.ModifiedBy = 0; return e; }).ToList();
                    objcredit_BL.UpdateRecommendationStatus(lstClientCreditDebit);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Recommendation of Credit/Debit notes in Web Service", ex);
        }
    }
    #endregion

    #region TSP Receipt Recommend List Details
    [WebMethod(EnableSession = true)]
    public List<ClientReceiptDetail> GetTSPReceiptRecommend(int OrgID, string Status, string ClientCode)
    {
        long lresutl = -1;
        ClientLedger_BL ObjCreditDebitRecommend = new ClientLedger_BL(new BaseClass().ContextInfo);
        List<ClientReceiptDetail> lstReceiptDetail = new List<ClientReceiptDetail>();
        try
        {
            lresutl = ObjCreditDebitRecommend.getReceiptRecommendation(OrgID, Status, ClientCode, out lstReceiptDetail);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading grdRecommendList in web service :" + ex.ToString() + " Inner Exception-", ex.InnerException);
        }
        return lstReceiptDetail;
    }
    #endregion



    #region SaveReceiptRecommentation
    [WebMethod(EnableSession = true)]
    public void SaveReceiptRecommentation(string lstClientReceipt)
    {
        JavaScriptSerializer serilize = new JavaScriptSerializer();
        ClientLedger_BL objcredit_BL = new ClientLedger_BL(new BaseClass().ContextInfo);
        ClientReceiptDetail objClientCreditDebit = new ClientReceiptDetail();
        List<ClientReceiptDetail> lstClientReceiptDetails = new List<ClientReceiptDetail>();
        try
        {
            if (lstClientReceipt != "")
            {
                lstClientReceiptDetails = serilize.Deserialize<List<ClientReceiptDetail>>(lstClientReceipt);
                if (lstClientReceiptDetails.Count > 0)
                {
                    lstClientReceiptDetails = lstClientReceiptDetails.Select(e => { e.ModifiedAt = DateTime.Now; e.ModifiedBy = 0; return e; }).ToList();
                    objcredit_BL.UpdateClientReceiptRecommendationStatus(lstClientReceiptDetails);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Recommendation of Receipt notes in Web Service", ex);
        }
    }
    #endregion

    #region GetClientClosingMonth [GetClientClosingMonth]

    [WebMethod(EnableSession = true)]
    public List<ClientOutStanding> GetClientClosingMonth(int OrgID, string ClientCode, string from, string to)
    {
        // int Orgid = Convert.ToInt32(OrgID);
        DateTime From = Convert.ToDateTime(from);
        DateTime To = Convert.ToDateTime(to);
        ClientLedger_BL ObjClientStatus = new ClientLedger_BL();
        List<ClientOutStanding> lstClientOutStanding = new List<ClientOutStanding>();
        List<string> items = new List<string>();
        try
        {
            ObjClientStatus.GetClientClosingMonth(OrgID, ClientCode, From, To, out lstClientOutStanding);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GetClientClosingMonth in webservice", ex);
        }
        return lstClientOutStanding;
    }
    #endregion
    #region Create Credimax Outstanding Payment Session Details
    [WebMethod(EnableSession = true)]
    public string CreateClientOutstandingOnlineOfflinePayLinkSession(string Amount, string ClientID, string InvoiceID, string InvoiceDetailsID, string mode, string PaymentType, string orgid)
    {
        InvoiceLedger_BL objInoiceLedger = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstCurrencyType = new List<LedgerInvoiceDetails>();

        string paymentmode = "";
        decimal creditlimit = 0;
        try
        {
            if (Amount != "" && ClientID != "" && InvoiceID != "" && InvoiceDetailsID != "")
            {
                objInoiceLedger.GetInvoiceLedgerClientCurrencyType(Convert.ToInt64(ClientID), Convert.ToInt64(orgid), out lstCurrencyType);
                if (lstCurrencyType.Count > 0)
                {

                    Session["PaymentClientCode"] = lstCurrencyType[0].ClientCode;
                    Session["ClientPaymentAmount"] = Amount;
                    Session["ClientID"] = ClientID;
                    Session["PaymentInvoiceID"] = InvoiceID;
                    Session["SelectedBillID"] = InvoiceDetailsID;
                    Session["BillPaymentType"] = PaymentType;
                    Session["BillWiseCurrencyCode"] = lstCurrencyType[0].CurrencyCode;
                }
                paymentmode = mode;

                if (creditlimit == 0)
                {
                    Session["ZeroCreditLimitAmount"] = 0;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Create Client Credimax OutStanding Payment Session Details in Web Service", ex);
        }
        return paymentmode;

    }
    #endregion
    #region SaveInvoiceOfflineReceipt
    [WebMethod(EnableSession = true)]

    public string SaveInvoiceOfflineReceipt(string lstClientReceipt, string Address, string Orgid)
    {
        string retuencode = "0";
        long SuccessCode = 0;
        long InvoiceID = 0;
        long ClientID = 0;
        long OrgID = 0;
        OrgID = Convert.ToInt64(Orgid);
        string curencycode = string.Empty;
        curencycode = Session["BillWiseCurrencyCode"].ToString();
        string filepath = Address.Replace("|", @"\");//replace the symbol | to \
        string IsAdvanceUsed = string.Empty;
        string AdvanceAmount = string.Empty;
        List<ClientReceipt> lstClientReceiptList = new List<ClientReceipt>();
        List<LedgerInvoiceDetails> lstClientReceiptDetail = new List<LedgerInvoiceDetails>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        //var routes_list = (IDictionary<string, object>)serializer1.DeserializeObject(lstClientReceipt);
        try
        {


            if (lstClientReceipt != "")
            {
                lstClientReceiptList = serializer1.Deserialize<List<ClientReceipt>>(lstClientReceipt);
                lstClientReceiptList[0].UploadedImages = filepath.ToString();
            }
            InvoiceID = Convert.ToInt64(Session["PaymentInvoiceID"].ToString());
            ClientID = Convert.ToInt64(Session["ClientID"].ToString());
            string[] items = Session["SelectedBillID"].ToString().Split('^');
            int count = items.Length;
            for (int i = 0; i < count; i++)
            {
                LedgerInvoiceDetails objledger = new LedgerInvoiceDetails();
                objledger.InvoiceDetailsID = Convert.ToInt64(items[i]);
                objledger.ClientId = ClientID;
                objledger.InvoiceId = InvoiceID;
                objledger.CurrencyCode = curencycode;
                objledger.PaymentMode = "BILLWISE";
                objledger.OrgID = OrgID;
                objledger.UsedAdvanceAmount = 0;
                objledger.RemainingAdvanceAmount = 0;
                objledger.IsSucceedTransaction = "Y";
                objledger.IsAdvanceUsed = "N";
                lstClientReceiptDetail.Add(objledger);
            }
            if (lstClientReceiptList.Count > 0)
            {
                InvoiceLedger_BL Objoutstanding_BL = new InvoiceLedger_BL(new BaseClass().ContextInfo);
                Objoutstanding_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientReceiptList, lstClientReceiptDetail, out SuccessCode);
                Session["PaymentInvoiceID"] = null;
                Session["ClientID"] = null;
                Session["SelectedBillID"] = null;
                Session["ClientPayingAmount"] = null;
                Session["IsAdvanceUsed"] = null;
                Session["AdvanceRedeemed"] = null;

                retuencode = SuccessCode.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientReceipt in WebService", ex);
        }
        return retuencode;

    }
    #endregion
    #region Get Invoice Client Outstanding Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> InvoiceClientOutstanding(long OrgID, long ClientID)
    {
        long returncode = -1;
        //long OrgId = Convert.ToInt64(OrgID);
        InvoiceLedger_BL ObjClientoutstand = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
        try
        {
            returncode = ObjClientoutstand.GetInvoiceClientOutStanding(ClientID, OrgID, out lstLedgerInvoiceDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Invoice Client Outstanding Details", ex);
        }
        return lstLedgerInvoiceDetails;

    }
    #endregion

    #region Get Ledger InvoiceOutstandingInvList Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> GetLedgerInvoiceOutstandingInvList(long ClientID, int From, int To, long OrgID)
    {
        long returncode = -1;
        //long OrgId = Convert.ToInt64(OrgID);
        InvoiceLedger_BL ObjClientoutstand = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstlstLedgerInvoice = new List<LedgerInvoiceDetails>();
        try
        {

            returncode = ObjClientoutstand.GetLedgerInvoiceOutstandingInvList(ClientID, From, To, OrgID, out lstlstLedgerInvoice);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Invoice Client Outstanding Details", ex);
        }
        return lstlstLedgerInvoice;

    }
    #endregion

    #region Get Ledger InvoiceOutstandingBill Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> GetLedgerInvoiceOutstandingBills(long ClientID, long InvoiveId, long OrgID)
    {
        long returncode = -1;
        //long OrgId = Convert.ToInt64(OrgID);
        InvoiceLedger_BL ObjClientoutstand = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstlstLedgerInvoice = new List<LedgerInvoiceDetails>();
        try
        {

            returncode = ObjClientoutstand.GetInvoiceClientBills(ClientID, InvoiveId, OrgID, out lstlstLedgerInvoice);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Invoice Client Outstanding Details", ex);
        }
        return lstlstLedgerInvoice;

    }
    #endregion


    #region Create MultipleInvoice  Payment Session Details
    [WebMethod(EnableSession = true)]
    public string CreatePayLinkSessionForMultiplePayment(string Amount, string ClientID, string InvoiceID, string mode, string PaymentType, string orgid)
    {
        InvoiceLedger_BL objInoiceLedger = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstCurrencyType = new List<LedgerInvoiceDetails>();
        string paymentmode = "";
        decimal creditlimit = 0;
        try
        {
            if (Amount != "" && ClientID != "" && InvoiceID != "")
            {
                objInoiceLedger.GetInvoiceLedgerClientCurrencyType(Convert.ToInt64(ClientID), Convert.ToInt64(orgid), out lstCurrencyType);
                if (lstCurrencyType.Count > 0)
                {
                    Session["MultiplePaymentClientCode"] = lstCurrencyType[0].ClientCode;
                    Session["MultipleInvoicePaymentAmount"] = Amount;
                    Session["MultipleInvoiceClientID"] = ClientID;
                    Session["MultiplePaymentInvoiceID"] = InvoiceID;
                    Session["InvoicePaymentType"] = PaymentType;
                    Session["InvoiceWiseCurrencyCode"] = lstCurrencyType[0].CurrencyCode;
                }
                paymentmode = mode;
                if (creditlimit == 0)
                {
                    Session["ZeroCreditLimitAmount"] = 0;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Create Session Details for MultipleInvoice Payment in Web Service", ex);
        }
        return paymentmode;

    }
    #endregion

    #region SaveMultipleInvoiceOfflineReceipt
    [WebMethod(EnableSession = true)]

    public string SaveMultipleInvoiceOfflineReceipt(string lstClientReceipt, string Address, string Orgid, string UsedPaymentType)
    {
        string retuencode = "0";
        long SuccessCode = 0;
        long InvoiceID = 0;
        long ClientID = 0;
        long OrgID = 0;
        OrgID = Convert.ToInt64(Orgid);
        string filepath = Address.Replace("|", @"\");//replace the symbol | to \
        List<ClientReceipt> lstClientReceiptList = new List<ClientReceipt>();
        List<ClientReceipt> lstClientReceipPayDetails = new List<ClientReceipt>();
        List<LedgerInvoiceDetails> lstClientReceiptDetail = new List<LedgerInvoiceDetails>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        string CurrencyCode = string.Empty;
        string IsAdvanceUsed = string.Empty;
        string AdvanceAmount = string.Empty;
        //var routes_list = (IDictionary<string, object>)serializer1.DeserializeObject(lstClientReceipt);
        try
        {

            if (lstClientReceipt != "")
            {
                lstClientReceiptList = serializer1.Deserialize<List<ClientReceipt>>(lstClientReceipt);
                lstClientReceiptList[0].UploadedImages = filepath.ToString();
            }
            string items = Session["MultiplePaymentInvoiceID"].ToString();
            CurrencyCode = Session["InvoiceWiseCurrencyCode"].ToString();
            if (items != "")
            {
                lstClientReceiptDetail = serializer1.Deserialize<List<LedgerInvoiceDetails>>(items);
                if (lstClientReceiptDetail.Count > 0)
                {
                    lstClientReceiptDetail = lstClientReceiptDetail.Select(ee =>
                    {

                        ee.CurrencyCode = CurrencyCode;
                        ee.UsedAdvanceAmount = 0;
                        ee.RemainingAdvanceAmount = 0;
                        ee.IsSucceedTransaction = "Y"; ee.IsAdvanceUsed = "N"; return ee;

                    }).ToList();
                }
                // ClientID = Convert.ToInt64(Session["MultipleInvoiceClientID"].ToString());
                foreach (var itms in lstClientReceiptDetail)
                {
                    ClientReceipt objClientReceipt = new ClientReceipt();
                    objClientReceipt.ReceiptID = Convert.ToInt64(itms.InvoiceId);
                    objClientReceipt.OrgID = lstClientReceiptList[0].OrgID;
                    objClientReceipt.SourceCode = lstClientReceiptList[0].SourceCode;
                    objClientReceipt.Mode = lstClientReceiptList[0].Mode;
                    objClientReceipt.PaymentType = lstClientReceiptList[0].PaymentType;
                    objClientReceipt.PaymentReceiptNo = lstClientReceiptList[0].PaymentReceiptNo;
                    objClientReceipt.Amount = lstClientReceiptList[0].Amount;
                    objClientReceipt.ResponseCode = lstClientReceiptList[0].ResponseCode;
                    objClientReceipt.Remarks = lstClientReceiptList[0].Remarks;
                    objClientReceipt.ManualRemarks = lstClientReceiptList[0].ManualRemarks;
                    objClientReceipt.CreatedBy = lstClientReceiptList[0].CreatedBy;
                    objClientReceipt.ReceiptDate = lstClientReceiptList[0].ReceiptDate;
                    objClientReceipt.UploadedImages = lstClientReceiptList[0].UploadedImages;
                    lstClientReceipPayDetails.Add(objClientReceipt);
                }
                if (lstClientReceipPayDetails.Count > 0 && lstClientReceiptDetail.Count > 0)
                {
                    InvoiceLedger_BL Objoutstanding_BL = new InvoiceLedger_BL(new BaseClass().ContextInfo);
                    Objoutstanding_BL.SaveCrediMaxOnlinveClientReceipt(OrgID, lstClientReceipPayDetails, lstClientReceiptDetail, out SuccessCode);
                    Session["MultipleInvoiceClientID"] = null;
                    Session["MultiplePaymentInvoiceID"] = null;
                    Session["MultipleInvoicePaymentAmount"] = null;
                    Session["InvoiceWiseCurrencyCode"] = null;
                    Session["IsAdvanceUsed"] = null;
                    Session["AdvanceRedeemed"] = null;

                    retuencode = SuccessCode.ToString();
                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientReceipt in WebService", ex);
        }
        return retuencode;

    }
    #endregion

    //.................Ledger End Here.....................................................//

    #region GetPaymentClients
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> GetPaymentClients(long ClientID, long orgID)
    {
        List<LedgerInvoiceDetails> lstLedgerClient = new List<LedgerInvoiceDetails>();
        List<LedgerInvoiceDetails> lstLedgerInvoice = new List<LedgerInvoiceDetails>();
        List<LedgerInvoiceDetails> lstLedgerInvoiceCredits = new List<LedgerInvoiceDetails>();
        List<LedgerInvoiceDetails> lstLedgerInvoiceDebits = new List<LedgerInvoiceDetails>();
        List<LedgerInvoiceDetails> lstLedgerInvoiceBills = new List<LedgerInvoiceDetails>();
        try
        {

            string ClientCode = "";
            InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL();
            objInvoiceLedger_BL.GetClientInvoiceDetails(ClientCode, ClientID, orgID,
                out lstLedgerClient, out lstLedgerInvoice, out lstLedgerInvoiceCredits,
                out lstLedgerInvoiceDebits, out lstLedgerInvoiceBills);
            if (lstLedgerClient.Count > 0)
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DAL GetClientInvoice", ex);
        }
        return lstLedgerClient;
    }
    #endregion
    #region Get Invoice Ledger Closing Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> InvoiceLedgerClosing(long OrgID, long ClientID)
    {
        long returncode = -1;
        InvoiceLedger_BL ObjClientoutstand = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
        try
        {
            returncode = ObjClientoutstand.GetInvoiceClientLedgerClosing(ClientID, OrgID, out lstLedgerInvoiceDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Invoice Client Outstanding Details", ex);
        }
        return lstLedgerInvoiceDetails;

    }
    #endregion
    #region Get Ledger Invoice Outstanding Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> GetInvoiceOutstandingDetails(long ClientID, string MonthID, long OrgID)
    {
        long returncode = -1;
        //long OrgId = Convert.ToInt64(OrgID);
        InvoiceLedger_BL ObjClientoutstand = new InvoiceLedger_BL();
        List<LedgerInvoiceDetails> lstlstLedgerInvoice = new List<LedgerInvoiceDetails>();
        try
        {

            returncode = ObjClientoutstand.GetLedgerInvoiceOutstandingDetails(ClientID, MonthID, OrgID, out lstlstLedgerInvoice);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Invoice Client Outstanding Details", ex);
        }
        return lstlstLedgerInvoice;

    }
    #endregion
    #region SaveAdvancePayment
    [WebMethod(EnableSession = true)]
    public string SaveAdvancePayment(string lstAdvancePayment, string Address, string Orgid)
    {
        string retuencode = "0";
        long SuccessCode = 0;
        long OrgID = 0;
        OrgID = Convert.ToInt64(Orgid);
        string curencycode = string.Empty;
        string filepath = Address.Replace("|", @"\");//replace the symbol | to \
        //List<ClientReceipt> lstClientReceiptList = new List<ClientReceipt>();
        List<LedgerInvoiceDetails> lstAdvancePaymentDetail = new List<LedgerInvoiceDetails>();
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        //var routes_list = (IDictionary<string, object>)serializer1.DeserializeObject(lstClientReceipt);
        try
        {
            if (lstAdvancePayment != "")
            {
                lstAdvancePaymentDetail = serializer1.Deserialize<List<LedgerInvoiceDetails>>(lstAdvancePayment);
                lstAdvancePaymentDetail[0].Name = filepath.ToString();
                //lstClientReceiptList[0].UploadedImages = filepath.ToString();
            }
            if (lstAdvancePaymentDetail.Count > 0)
            {
                InvoiceLedger_BL Objoutstanding_BL = new InvoiceLedger_BL(new BaseClass().ContextInfo);
                Objoutstanding_BL.SaveAdvancePayment(OrgID, lstAdvancePaymentDetail, out SuccessCode);
                retuencode = SuccessCode.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While SaveClientReceipt in WebService", ex);
        }
        return retuencode;

    }
    #endregion
    #region Advance Recommend List Details
    [WebMethod(EnableSession = true)]
    public List<LedgerInvoiceDetails> GetAdvanceRecommendList(int OrgID, string Status, int ClientID)
    {
        long lresutl = -1;
        long Clientid = Convert.ToInt64(ClientID);
        InvoiceLedger_BL ObjInvoiceLedger_BL = new InvoiceLedger_BL(new BaseClass().ContextInfo);
        List<LedgerInvoiceDetails> lstLedgerInvoiceDetails = new List<LedgerInvoiceDetails>();
        try
        {
            lresutl = ObjInvoiceLedger_BL.getAdvancePaymentRecommendation(OrgID, Status, ClientID, out lstLedgerInvoiceDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading lstLedgerInvoiceDetails in web service :" + ex.ToString() + " Inner Exception-", ex.InnerException);
        }
        return lstLedgerInvoiceDetails;
    }
    #endregion
    #region SaveAdvanceRecommentation
    [WebMethod(EnableSession = true)]
    public void SaveAdvanceRecommentation(string lstLedgerInvoiceDetails)
    {
        JavaScriptSerializer serilize = new JavaScriptSerializer();
        InvoiceLedger_BL objInvoiceLedger_BL = new InvoiceLedger_BL(new BaseClass().ContextInfo);
        LedgerInvoiceDetails objLedgerInvoiceDetails = new LedgerInvoiceDetails();
        List<LedgerInvoiceDetails> lstInvoiceDetails = new List<LedgerInvoiceDetails>();
        try
        {
            if (lstLedgerInvoiceDetails != "")
            {
                lstInvoiceDetails = serilize.Deserialize<List<LedgerInvoiceDetails>>(lstLedgerInvoiceDetails);
                if (lstInvoiceDetails.Count > 0)
                {
                    lstInvoiceDetails = lstInvoiceDetails.Select(e => { e.ModifiedAt = DateTime.Now; e.ModifiedBy = 0; return e; }).ToList();
                    objInvoiceLedger_BL.UpdateAdvanceRecommendation(lstInvoiceDetails);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveAdvance Recommentation notes in Web Service", ex);
        }
    }
    #endregion
    //--------------------ColletApproveAndReceivedDate------------------//
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetVisitNumber_ColletApproveAndReceivedDate(string prefixText, int count, string contextKey)//, string contextKey
    {
        List<string> items = new List<string>();
        List<PendingInvestigation> lstVisitNumber = new List<PendingInvestigation>();
        //Investigation_BL objInvestigation_BL =new Investigation_BL();
        long retCode = -1; int orgID;
        orgID = !string.IsNullOrEmpty(contextKey) == true ? Convert.ToInt32(contextKey) : 0;
        try
        {
            retCode = new Investigation_BL(new BaseClass().ContextInfo).GetColletApproveAndReceivedDate_BL(prefixText, orgID, out lstVisitNumber);
            if (lstVisitNumber.Count > 0)
            {

                for (int j = 0; j < lstVisitNumber.Count; j++)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(lstVisitNumber[j].VisitNumber, lstVisitNumber[j].Value));
                }
            }
            else
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem("No records found", "-1~N~N~N"));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetVisitNumber_ColletApproveAndReceivedDate Message:", ex);
        }

        return items.ToArray();
    }

    //-----------------------Capture patient history start-----------------------------//


    #region [GetEditPatientHistory]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CapturePatientHistory> GetEditPatientHistory(int OrgID, long VisitID)
    {
        Patient_BL BL = new Patient_BL(new BaseClass().ContextInfo);
        List<CapturePatientHistory> lsPatientHistory = new List<CapturePatientHistory>();
        try
        {
            List<string> items = new List<string>();
            BL.GetEditPatientHistory(OrgID, VisitID, out lsPatientHistory);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetEditPatientHistory in WebService", ex);
        }
        return lsPatientHistory;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetCapturePatientHistoryPatten(string strInvestigationID, string OrgID, string Type)
    {
        string returnValue = "N";
        List<string> items = new List<string>();
        List<CapturePatientHistory> lstCPH = new List<CapturePatientHistory>();

        long retCode = -1; int orgID;
        long InvestigationID = !string.IsNullOrEmpty(strInvestigationID) == true ? Convert.ToInt32(strInvestigationID) : 0;
        orgID = !string.IsNullOrEmpty(OrgID) == true ? Convert.ToInt32(OrgID) : 0;
        try
        {
            retCode = new Patient_BL(new BaseClass().ContextInfo).LoadAndCheckCapturePatientHistory(orgID, InvestigationID, Type, out lstCPH);
            if (lstCPH.Count > 0)
            {

                returnValue = lstCPH[0].HistoryName;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetVisitNumber_ColletApproveAndReceivedDate Message:", ex);
        }

        return returnValue;
    }
    #endregion

    //--------------------------Update patient history---------------------//
    #region UpdatePatientHistory
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CapturePatientHistory> UpdatePatientHistoryService(string lstUpdateHistory)
    {

        Patient_BL ObjBL = new Patient_BL(new BaseClass().ContextInfo);
        List<CapturePatientHistory> lsthistory = new List<CapturePatientHistory>();

        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        lsthistory = JSserializer.Deserialize<List<CapturePatientHistory>>(lstUpdateHistory);
        try
        {
            lsthistory = JSserializer.Deserialize<List<CapturePatientHistory>>(lstUpdateHistory);

            ObjBL.UpdatePatientHistory(lsthistory);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While UpdatePatientHistory in WebService", ex);
        }
        return lsthistory;
    }
    #endregion

    //-----------------------Capture patient history start-----------------------------//
    #region DeleteMultiUploadFiles

    [WebMethod(EnableSession = true)]
    [ScriptMethod]
    public void DeleteMultiUploadFiles(int ID, int OrgID)
    {
        long returnCode = -1;
        try
        {
            Master_BL MBL = new Master_BL(new BaseClass().ContextInfo);


            List<TRFfilemanager> TRFfiles = new List<TRFfilemanager>();
            TRFfiles.Add(new TRFfilemanager { FileID = ID, FileUrl = "", PatientID = 0, VisitID = 0, IdentifyingType = "Document", OrgID = OrgID });
            returnCode = MBL.DeleteOutsourceDocDetails(TRFfiles);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while deleting InvCoAuth details ", ex);
        }
    }

    #endregion
    #region QMS integration

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> ChangeLocationMenuClick(int LoginID, int OrgAddressID, int OrgID, int RoleID, string LocationName)
    {
        List<object> objLst = new List<object>();
        long returnCode = 1;
        try
        {
            Role loginrole = new Role();
            Session.Add("LocationID", OrgAddressID);
            Session.Add("LocationName", LocationName);

            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();
            returnCode = gateWay.GetLocationUserMap(LoginID, OrgID, OrgAddressID, out lstLocationUserMap);
            if (lstLocationUserMap.Count > 0)
            {
                if (lstLocationUserMap.Exists(P => P.IsDefault == "Y"))
                {
                    Session.Add("InventoryLocationID", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationID);
                    Session.Add("DepartmentName", lstLocationUserMap.Find(P => P.IsDefault == "Y").LocationName);
                }
                else
                {
                    Session.Add("InventoryLocationID", "-1");
                }

            }
            else
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                returnCode = gateWay.GetInventoryConfigDetails("InventoryLocationID", OrgID, OrgAddressID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    Session.Add("InventoryLocationID", lstInventoryConfig[0].ConfigValue);
                }
                else
                {
                    Session.Add("InventoryLocationID", "-1");
                }
            }

            // List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();

            //Changed By Dhana Reference Given to Attune.Podium.TrustedOrg After Consulting with Karthik.p
            returnCode = new Attune.Podium.TrustedOrg.TrustedOrg(new BaseClass().ContextInfo).GetTrustedOrgList(OrgId, RoleID, "", out lstTOD);
            if (lstTOD.Count > 0)
            {
                Session.Add("IsTrustedOrg", "Y");
            }
            else
            {
                Session.Add("IsTrustedOrg", "N");
            }

            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;

            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            objLst.Add(returnCode);

            objLst.Add(relPagePath);
            //if (returnCode == 0)
            //{
            //    //Response.Redirect(Request.ApplicationPath + relPagePath, true);
            //}

        }
        catch { }

        return objLst;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<OrganizationAddress> GetChangeLocationMenu(long LocationID, int OrgID, int LoginID, int RoleID)
    {
        long returnCode = -1;
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        try
        {
            PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL(new BaseClass().ContextInfo);

            returnCode = objPatientVisit_BL.GetLocation(OrgID, LoginID, RoleID, out lstLocation);

            if (lstLocation.Count > 0)
            {
                OrganizationAddress oAddress = lstLocation.Find(P => P.AddressID == LocationID);
                if (oAddress != null)
                {
                    Session["HasHealthCard"] = oAddress.IsRemote;
                    Session["CountryID"] = oAddress.CountryID.ToString();
                    Session["StateID"] = oAddress.StateID.ToString();
                }
            }
            if (lstLocation.Count > 1)
            {
                // leftDiv.Visible = true;
                lstLocation.RemoveAll(P => P.AddressID == LocationID);
            }
        }
        catch { }
        return lstLocation;
    }

    [WebMethod(EnableSession = true)]
    public List<Localities> QMS_Loadcountrydetails()
    {
        long returncode = -1;
        List<Localities> obj = new List<Localities>();
        try
        {
            //By Dhana Due to Ambiquity Reference 
            Attune.Solution.BusinessComponent.Country_BL countryBL = new Attune.Solution.BusinessComponent.Country_BL(new BaseClass().ContextInfo);
            returncode = countryBL.GetLocalities(0, out obj);
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
            Attune.Solution.BusinessComponent.Country_BL countryBL = new Attune.Solution.BusinessComponent.Country_BL(new BaseClass().ContextInfo);
            returncode = countryBL.GetLocalities(CountryID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in QMS_Loadlocalitiesdetails", e);

        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    public List<OrganizationAddress> GetLocationsForOrgDashboard(long OrgID)
    {

        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        try
        {
            //StringDictionary kv = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            long orgId;
            long returnCode = -1;
            long loginID = -1;
            long roleID = -1;

            if (Session["LID"] != null)
            {
                Int64.TryParse(Session["LID"].ToString(), out loginID);
                Login objLogin = new Login();
                objLogin.LoginID = loginID;
                PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);

                BaseClass bc = new BaseClass();
                orgId = bc.ContextInfo.OrgID;
                roleID = bc.ContextInfo.RoleID;

                returnCode = patientBL.GetLocation(orgId, loginID, roleID, out lstLocation);

                lstLocation = (from lst in lstLocation
                               group lst by
                               new
                               {
                                   lst.AddressID,
                                   lst.Location
                               } into grp
                               select new OrganizationAddress
                               {
                                   Location = grp.Key.Location.Trim(),
                                   AddressID = grp.Key.AddressID
                               }).OrderBy(p => p.Location).ToList();


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations:GetLocationsForOrg() ", ex);
        }
        return lstLocation;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Role> GetOrganizationsDashboard()
    {
        List<CascadingDropDownNameValue> values = new List<CascadingDropDownNameValue>();
        List<Role> lstResult = new List<Role>();
        long rcode = -1;
        try
        {
            long loginID = -1;

            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            if (Session["LID"] != null)
            {
                Int64.TryParse(Session["LID"].ToString(), out loginID);
                Login objLogin = new Login();
                objLogin.LoginID = loginID;

                gateWay.GetRoles(objLogin, out lstResult);
                string[] orglist = lstResult.Select(o => o.OrgName).Distinct().ToArray();

                lstResult = (from lst in lstResult
                             group lst by
                             new
                             {
                                 lst.OrgID,
                                 lst.OrgName,
                                 lst.IsDefault
                             } into grp
                             select new Role
                             {
                                 OrgName = grp.Key.OrgName,
                                 OrgID = grp.Key.OrgID,
                                 IsDefault = grp.Key.IsDefault
                             }).OrderBy(p => p.OrgName).ToList();
            }
        }
        catch
        { }
        return lstResult;
    }
    #region Added By Arivalagan.kk For QMS Load Drop Downs
    //********************Added By Arivalagan.kk For QMS Analyte Master*****************// 

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList LoadQMSDropDown(int Orgid)
    {
        ArrayList AaList = new ArrayList();
        try
        {
            long returncode = -1;
            List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
            List<InvSampleMaster> lstSample = new List<InvSampleMaster>();
            List<InvestigationSampleContainer> lstAdditive = new List<InvestigationSampleContainer>();
            List<InvestigationMethod> lstMethod = new List<InvestigationMethod>();
            List<InvPrincipleMaster> lstPrinciple = new List<InvPrincipleMaster>();
            List<MetaValue_Common> lstResultValue = new List<MetaValue_Common>();
            List<MetaValue_Common> lstSubCategory = new List<MetaValue_Common>();
            List<Role> lstRoles = new List<Role>();
            List<InvInstrumentMaster> lstInstrument = new List<InvInstrumentMaster>();
            List<Products> lstKit = new List<Products>();
            List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
            List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
            List<MetaValue_Common> lstCategory = new List<MetaValue_Common>();
            List<InvestigationHeader> lstHeader = new List<InvestigationHeader>();
            List<ShippingConditionMaster> lstSampleCondition = new List<ShippingConditionMaster>();

            returncode = new Master_BL(new BaseClass().ContextInfo).GetTestMasterDropDownValues(Orgid, out lstDept,
                out lstSample, out lstAdditive, out lstMethod, out lstPrinciple, out lstResultValue, out lstSubCategory,
                out lstRoles, out lstInstrument, out lstKit, out lstInvClientMaster, out lstReasonMaster,
                out lstCategory, out lstHeader, out lstSampleCondition);


            MetaData oMetaData = new MetaData();
            oMetaData.Domain = "TestClassification";
            string LangCode = "en-GB";
            List<MetaData> lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            List<MetaData> lstClassify = new List<MetaData>();
            returncode = new MetaData_BL(new BaseClass().ContextInfo).LoadMetaDataOrgMapping(lstDomain, Orgid, LangCode, out lstClassify);
            oMetaData = new MetaData();
            oMetaData.Domain = "CutOffTimeType";
            lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            List<MetaData> lstMetaData = new List<MetaData>();
            returncode = new MetaData_BL(new BaseClass().ContextInfo).LoadMetaDataOrgMapping(lstDomain, Orgid, LangCode, out lstMetaData);
            //ddlDepartment
            AaList.Add(lstDept);
            //ddlAdditive
            AaList.Add(lstAdditive);
            //ddlResultValue
            AaList.Add(lstResultValue);
            //ddlSampleType
            AaList.Add(lstSample);
            //ddlMethod
            AaList.Add(lstMethod);
            //ddlPrinciple
            AaList.Add(lstPrinciple);
            //ddlClassification
            if (lstClassify.Count > 0)
            {
                List<MetaData> lstClassification = ((from child in lstClassify
                                                     where child.Domain == "TestClassification"
                                                     select child).Distinct()).ToList();
                if (lstClassification != null && lstClassification.Count > 0)
                {
                    AaList.Add(lstClassification);
                }
            }
            //ddlHours
            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstCutOffTimeType = ((from child in lstMetaData
                                                     where child.Domain == "CutOffTimeType"
                                                     select child).Distinct()).ToList();
                if (lstCutOffTimeType != null && lstCutOffTimeType.Count > 0)
                {
                    AaList.Add(lstCutOffTimeType);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading QMS DDLS ", ex);
        }
        return AaList;
    }

    #region GetOrgDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Role> GetOrgDetails()
    {
        List<Role> userRoles = new List<Role>();
        try
        {
            long loginID = -1;
            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            Int64.TryParse(Session["LID"].ToString(), out loginID);

            long returnCode = -1;
            Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
            Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
            loggedIn.LoginID = loginID;
            returnCode = gateWay.GetRoles(loggedIn, out userRoles);
        }
        catch
        {
        }
        return userRoles;
    }
    #endregion
    //********************End Added By Arivalagan.kk*************************************// 
    #endregion
    #endregion

    //--------------------------Trend Analysis-----------------------------//
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<TrendAnalysis> GetPatientComparisonReport(string pPatientIds, string strInvID, string IsRerun, long pPageID)
    {
        long result = -1;
        //long PatientIDloc = 0;
        List<TrendAnalysis> lstGetPatientComparisonResult = new List<TrendAnalysis>();
        List<InvestigationMaster> lstInvID = new List<InvestigationMaster>();
        JavaScriptSerializer o = new JavaScriptSerializer();
        try
        {
            lstInvID = o.Deserialize<List<InvestigationMaster>>(strInvID);
            // Int64.TryParse(PatientID, out PatientIDloc);
            Investigation_BL invbl = new Investigation_BL(new BaseClass().ContextInfo);
            result = invbl.GetPatientComparisonReport(pPatientIds, lstInvID, IsRerun, pPageID, out lstGetPatientComparisonResult);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting GetPatientComparisonReport in WebService", ex);
        }
        //return json;
        return lstGetPatientComparisonResult;
    }
    #region Sample
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList GetPatientTestLevelResult(string VisitNumber, string PatientNumber, long pPageID)
    {
        long result = -1;
        // long PatientIDloc = 0;
        ArrayList Obj = new ArrayList();
        Array Obj1;//= new Array();
        Array Obj2;
        List<Patient> lstPatientDetails = new List<Patient>();
        List<TrendAnalysis> lstGetPatientTestLevelResult = new List<TrendAnalysis>();
        try
        {
            //Int64.TryParse(PatientID, out PatientIDloc);
            Investigation_BL invbl = new Investigation_BL(new BaseClass().ContextInfo);
            result = invbl.GetPatientTestLevelResult(VisitNumber, PatientNumber, pPageID, out lstPatientDetails, out lstGetPatientTestLevelResult);
            Obj1 = lstPatientDetails.ToArray();
            Obj2 = lstGetPatientTestLevelResult.ToArray();
            Obj.Add(Obj1);
            Obj.Add(Obj2);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Getting PatientTestLevelResult in WebService", ex);
        }
        //return json;
        return Obj;
    }
    ////////////////////////////////// End Trend Analysis///////////////////////////////////////
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long pUpdateInvoicePayment(List<InvoiceReceipts> lstInvoices)
    {
        long returnCode = -1;
        BillingEngine bill = new BillingEngine(new BaseClass().ContextInfo);


        try
        {
            string ReceiptNo = "";
            long ReceiptID = 0;
            returnCode = bill.InsertInvoiceReceipts(lstInvoices, out ReceiptNo, out ReceiptID);



        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in SaveHistoSpecimenDetailsEntry", ex);
        }
        return returnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long InsertCreditDebitSummary(List<CreditDebitSummary> lstCreditSummary)
    {
        long returnCode = -1;
        Master_BL MBL = new Master_BL(new BaseClass().ContextInfo);
        try
        {
            string ReceiptNo = "";
            long ReceiptID = 0;
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            returnCode = MBL.InsertCreditDebitSummary(lstCreditSummary, orgID, out ReceiptID);

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in SaveHistoSpecimenDetailsEntry", ex);
        }
        return returnCode;
    }
    //-----------------------TAT report-----------------------------//
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<LabTestTATReport> GetTATMISReport(string pFromDate, string pToDate, int pOrgID, long LocationID, long DeptID)
    {
        long result = -1;
        List<LabTestTATReport> lstLabTestTATReport = new List<LabTestTATReport>();
        try
        {
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);

            result = objReportBL.GetTATReport(Convert.ToDateTime(pFromDate), Convert.ToDateTime(pToDate), pOrgID, LocationID, DeptID, out lstLabTestTATReport);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        //return json;
        return lstLabTestTATReport;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CampDetails> SaveBulkRegistrationDetails(string list, string Testlist)
    {
        long returncode = -1;
        List<CampDetails> lstinsertCampDetail = new List<CampDetails>();
        // List<TestDetails> lstTestCamp = new List<TestDetails>();
        CampDetails entlstTestCamp;
        List<CampDetails> lstresult = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        try
        {
            // lstCamp = oSerializer.Deserialize<List<CampDetails>>(list);
            CampDetails[] lstCamp = oSerializer.Deserialize<CampDetails[]>(list);
            TestDetails[] lstTestCamp = oSerializer.Deserialize<TestDetails[]>(Testlist);
            if (lstCamp.Length > 0 && lstTestCamp.Length > 0)
            {
                foreach (var lst in lstCamp)
                {
                    foreach (var item in lstTestCamp)
                    {
                        if (lst.Id == item.Id)
                        {
                            entlstTestCamp = new CampDetails();
                            entlstTestCamp.Id = lst.Id;

                            entlstTestCamp.OrgName = lst.OrgName;
                            entlstTestCamp.SlNo = lst.SlNo;
                            entlstTestCamp.PDate = lst.PDate;
                            entlstTestCamp.SDate = lst.SDate;
                            entlstTestCamp.SCollectedBy = lst.SCollectedBy;
                            entlstTestCamp.PatId = lst.PatId;// Convert.ToString(from lc in lstCamp select lc.PatId);
                            entlstTestCamp.Title = lst.Title;// Convert.ToString(from lc in lstCamp select lc.Title);
                            entlstTestCamp.Name = lst.Name;// Convert.ToString(from lc in lstCamp select lc.Name);
                            entlstTestCamp.DOB = lst.DOB;
                            entlstTestCamp.Age = lst.Age;
                            entlstTestCamp.AgeType = lst.AgeType;// Convert.ToString(from lc in lstCamp select lc.AgeType);
                            entlstTestCamp.Sex = lst.Sex;// Convert.ToString(from lc in lstCamp select lc.Sex);
                            entlstTestCamp.Location = lst.Location; //Convert.ToString(from lc in lstCamp select lc.Location);
                            entlstTestCamp.Doctor = lst.Doctor;// Convert.ToString(from lc in lstCamp select lc.Doctor);
                            entlstTestCamp.RefHospital = lst.RefHospital;// Convert.ToString(from lc in lstCamp select lc.RefHospital);
                            entlstTestCamp.Priority = lst.Priority;// Convert.ToString(from lc in lstCamp select lc.Priority);
                            entlstTestCamp.DispatchMode = lst.DispatchMode;// Convert.ToString(from lc in lstCamp select lc.DispatchMode);
                            entlstTestCamp.AmountPaid = lst.AmountPaid;// Convert.ToDecimal(from lc in lstCamp select lc.AmountPaid);
                            entlstTestCamp.AmountDiscount = lst.AmountDiscount;// Convert.ToDecimal(from lc in lstCamp select lc.AmountDiscount);
                            entlstTestCamp.DiscountReason = lst.DiscountReason;// Convert.ToString(from lc in lstCamp select lc.DiscountReason);
                            entlstTestCamp.DiscountAuthorisedBy = lst.DiscountAuthorisedBy;// Convert.ToString(from lc in lstCamp select lc.DiscountAuthorisedBy);
                            entlstTestCamp.History = lst.History;// Convert.ToString(from lc in lstCamp select lc.History);
                            entlstTestCamp.Remarks = lst.Remarks;// Convert.ToString(from lc in lstCamp select lc.Remarks);
                            entlstTestCamp.MobileNo = lst.MobileNo;// Convert.ToString(from lc in lstCamp select lc.MobileNo);
                            entlstTestCamp.CreatedBy = lst.CreatedBy;// Convert.ToString(from lc in lstCamp select lc.CreatedBy);
                            entlstTestCamp.ClientCode = lst.ClientCode;// Convert.ToString(from lc in lstCamp select lc.ClientCode);
                            entlstTestCamp.EmailId = lst.EmailId;// Convert.ToString(from lc in lstCamp select lc.EmailId);
                            if (lst.PatientNumber != "--")
                            {
                                entlstTestCamp.PatientNumber = lst.PatientNumber;
                            }
                            else
                            {
                                entlstTestCamp.PatientNumber = "--";
                            }
                            entlstTestCamp.ErrorStatus = lst.ErrorStatus;// Convert.ToBoolean(from lc in lstCamp select lc.ErrorStatus);
                            entlstTestCamp.ClientID = lst.ClientID;// Convert.ToInt64(from lc in lstCamp select lc.ClientID);
                            entlstTestCamp.LocationID = lst.LocationID;// Convert.ToInt64(from lc in lstCamp select lc.LocationID);
                            entlstTestCamp.TitleID = lst.TitleID;// Convert.ToInt64(from lc in lstCamp select lc.TitleID);
                            entlstTestCamp.DoctorID = lst.DoctorID;// Convert.ToInt64(from lc in lstCamp select lc.DoctorID);
                            entlstTestCamp.RefHospitalID = lst.RefHospitalID;// Convert.ToInt64(from lc in lstCamp select lc.RefHospitalID);
                            entlstTestCamp.SCollectedByID = lst.SCollectedByID;// Convert.ToInt64(from lc in lstCamp select lc.SCollectedByID);
                            entlstTestCamp.PriorityID = lst.PriorityID;// Convert.ToInt32(from lc in lstCamp select lc.PriorityID);
                            entlstTestCamp.IsClientPatient = lst.IsClientPatient;// Convert.ToString(from lc in lstCamp select lc.IsClientPatient);
                            entlstTestCamp.CreatedbyId = lst.CreatedbyId;// Convert.ToInt64(from lc in lstCamp select lc.CreatedbyId);
                            entlstTestCamp.IsDiscountable = item.IsDiscountable;// Convert.ToString(from lc in lstCamp select lc.IsDiscountable);
                            entlstTestCamp.DueAmount = lst.DueAmount;// Convert.ToDecimal(from lc in lstCamp select lc.DueAmount);
                            entlstTestCamp.OrgId = lst.OrgId;// Convert.ToInt32(from lc in lstCamp select lc.OrgId);
                            entlstTestCamp.DiscountAuthorisedByID = lst.DiscountAuthorisedByID;// Convert.ToInt64(from lc in lstCamp select lc.DiscountAuthorisedByID);
                            entlstTestCamp.HasHealthCoupon = lst.HasHealthCoupon;// Convert.ToString(from lc in lstCamp select lc.HasHealthCoupon);
                            entlstTestCamp.MyCardActiveDays = lst.MyCardActiveDays;// Convert.ToString(from lc in lstCamp select lc.MyCardActiveDays);
                            entlstTestCamp.IsCreditBill = lst.IsCreditBill;//Convert.ToString(from lc in lstCamp select lc.IsCreditBill);
                            entlstTestCamp.TestRequested = item.TestRequested;
                            entlstTestCamp.Charged = item.Charged;
                            entlstTestCamp.ErrorDesc = item.ErrorDesc;
                            entlstTestCamp.TestCode = item.TestCode;
                            entlstTestCamp.RateId = item.RateId;
                            entlstTestCamp.TestType = item.TestType;
                            entlstTestCamp.FeeId = item.FeeId;
                            entlstTestCamp.CampId = item.CampId;
							entlstTestCamp.HealthHubID = lst.HealthHubID;
                            entlstTestCamp.EmployeeID = lst.EmployeeID;
                            entlstTestCamp.SourceType = lst.SourceType;
                            entlstTestCamp.SRFID = lst.SRFID;
                            entlstTestCamp.TRFID = lst.TRFID;
                            lstinsertCampDetail.Add(entlstTestCamp);
                        }
                    }

                }
            }

            returncode = new FileUploadManager(new BaseClass().ContextInfo).SavePatientDetails(lstinsertCampDetail, out lstresult);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SaveBulkRegistrationDetails", ex);
        }
        finally
        {
        }
        return lstresult;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList ValidateBulkRegistrationDetails(string list)
    {
        long returncode = -1;
        ArrayList ValBulkReg = new ArrayList();
        List<CampDetails> brd = new List<CampDetails>();
        List<CampDetails> lstCamp = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        int count = 0;
        try
        {
            brd = oSerializer.Deserialize<List<CampDetails>>(list);
            returncode = new FileUploadManager(new BaseClass().ContextInfo).ValidateBulkRegistrationDetails(brd, out lstCamp);
            count = lstCamp.Count;
            lstCamp.ForEach(x =>
            {
                x.PDate = Convert.ToDateTime(x.PDate).ToString("dd/MM/yyyy hh:mm tt");
                x.SDate = Convert.ToDateTime(x.SDate).ToString("dd/MM/yyyy hh:mm tt");
                x.DOB = Convert.ToDateTime(x.DOB).ToString("dd/MM/yyyy");
            });
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
    public ArrayList BulkRegistration(string fulupload, int Fromdata, int ToData)
    {
        ArrayList fileUpload = new ArrayList();
        //fulupload = "C:\\Users\\Thiyagu\\Desktop\\Reg.xls";


        string Conne = "";
        List<string> objSheet = new List<string>();
        List<BulkRegistrationDetails> brd = new List<BulkRegistrationDetails>();
        BulkRegistrationDetails BulkReg;
        OleDbConnection con;
        DataTable objStockReceived;
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
                    if (item == "ARegistrations$")
                    {
                        try
                        {
                            objStockReceived = new DataTable();
                            con = new OleDbConnection(Conne);
                            con.Open();
                            adp = new OleDbDataAdapter("select * from [" + item + "] where SlNo>" + Fromdata + " and SlNo<=" + ToData + "", con); //where Sl. No>" + Fromdata + " and Sl. No<=" + ToData + "
                            adp.Fill(objStockReceived);
                            cmd = new OleDbCommand("Select count(1) from [" + item + "]", con);
                            tmpcount = (int)cmd.ExecuteScalar();
                            int pat = 1;
                            con.Close();
                            if (objStockReceived.Rows.Count == 0)
                            {
                                int a = -1;
                                fileUpload.Add(a);
                            }
                            if (objStockReceived.Columns.Count == 29)
                            {
                                foreach (DataRow dr in objStockReceived.Rows)
                                {
                                    //if (Convert.ToString(dr[0]) == "")
                                    //    break;
                                    // if (Convert.ToString(dr[2]) == "")
                                    //     BulkReg.PDate = "01-01-1900";

                                    //  if (Convert.ToString(dr[3]) == "")
                                    //     BulkReg.SDate = "01-01-1900";
                                    BulkReg = new BulkRegistrationDetails();
                                    BulkReg.SlNo = Convert.ToInt32(dr[0]);

                                    BulkReg.OrgName = Convert.ToString(dr[1]);
                                    BulkReg.Location = Convert.ToString(dr[2]);
                                    string pdate = Convert.ToString(dr[3]);
                                    if (pdate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.PDate = pdate;
                                    pdate = Convert.ToString(dr[4]);
                                    if (pdate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.SDate = pdate;
                                    BulkReg.PatientNumber = Convert.ToString(dr[5]);
                                    BulkReg.HealthHubID = Convert.ToString(dr[6]);
                                    BulkReg.EmployeeID = Convert.ToString(dr[7]);
                                    BulkReg.SourceType = Convert.ToString(dr[8]);
                                    BulkReg.Title = Convert.ToString(dr[9]);
                                    BulkReg.Name = Convert.ToString(dr[10]);
                                    BulkReg.DOB = Convert.ToString(dr[11]);
                                    BulkReg.Age = Convert.ToString(dr[12]);
                                    BulkReg.AgeType = Convert.ToString(dr[13]);
                                    BulkReg.Sex = Convert.ToString(dr[14]);
                                    BulkReg.TestRequested = Convert.ToString(dr[15]);
                                    if (Convert.ToString(dr[16]) == "")
                                        BulkReg.AmountPaid = 0;
                                    else
                                        BulkReg.AmountPaid = Convert.ToDecimal(dr[16]);

                                    if (Convert.ToString(dr[17]) == "")
                                        BulkReg.AmountDiscount = 0;
                                    else
                                        BulkReg.AmountDiscount = Convert.ToDecimal(dr[17]);

                                    BulkReg.ClientCode = Convert.ToString(dr[18]);
                                    BulkReg.SCollectedBy = Convert.ToString(dr[19]);
                                    BulkReg.MobileNo = Convert.ToString(dr[20]);
                                    BulkReg.EmailId = Convert.ToString(dr[21]);
                                    BulkReg.DispatchMode = Convert.ToString(dr[22]);
                                    BulkReg.Doctor = Convert.ToString(dr[23]);
                                    BulkReg.RefHospital = Convert.ToString(dr[24]);
                                    BulkReg.History = Convert.ToString(dr[25]);
                                    BulkReg.Remarks = Convert.ToString(dr[26]);

                                    BulkReg.PatId = Convert.ToString(pat);
                                    BulkReg.Priority = "Normal";
                                    BulkReg.Charged = 0;
                                    BulkReg.DiscountReason = "";
                                    BulkReg.DiscountAuthorisedBy = "";
                                    BulkReg.CreatedBy = "";
                                    BulkReg.SRFID=Convert.ToString(dr[27]);
                                    BulkReg.TRFID=Convert.ToString(dr[28]);
                                    BulkReg.ValidateData = "";
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

                //var myFile = File.Create(ful);(":","_").
                //myFile.Close();
                DateTime CurrentDateTime = DateTime.Now;
                // string c = Convert.ToString(CurrentDateTime).Replace("/","_").Replace(":","_").Replace(" ","_");




                string fileName = System.IO.Path.GetFileName(ful);
                string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(ful);
                string extension = System.IO.Path.GetExtension(fileName);
                if ((extension == ".xls" || extension == ".xlsx"))
                {
                    String rootPath = Server.MapPath("~/ExcelTest/");
                    filename = rootPath + fileName;
                    //if (File.Exists(rootPath + fileName))
                    //{
                    //    File.Delete(rootPath+fileName);
                    //}

                    // System.IO.File.Copy(ful, rootPath + fileName, true);
                    newfilepath = ful;
                    if (extension == ".xls")
                    {                       
                      // changes by arun - when using excel download from 'Download Bulk Registration can't upload in covidbulkregistration screen 
                       // Conne = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + newfilepath + ";Extended Properties=Excel 12.0;";
                        //Conne = "Provider=Microsoft.ACE.OLEDB.12.0;data source=" + newfilepath + ";Extended Properties=Excel 12.0;";
                        //Conne = "Provider=Microsoft.Jet.OLEDB.4.0;data source=" + newfilepath + ";Extended Properties=Excel 8.0;HDR=YES;IMEX=1;";
                        //Conne = "Provider=Microsoft.Jet.OleDb.4.0;data source=" + newfilepath + ";Extended Properties=Excel 8.0;";
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
    public string ClientAttributesFieldDetails(long ReferenceID, string ReferenceType)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<FieldAttributeDetails> lstFields = new List<FieldAttributeDetails>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            BillingEngine billeng = new BillingEngine(new BaseClass().ContextInfo);
            resultCode = billeng.ClientAttributesFieldDetails(ReferenceID, ReferenceType, out lstFields);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstFields);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        return JsonOut;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string TestHistoryFieldDetails(long ReferenceID, string ReferenceType, string TestType)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<FieldAttributeDetails> lstFields = new List<FieldAttributeDetails>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

        try
        {
            BillingEngine billeng = new BillingEngine(new BaseClass().ContextInfo);
            resultCode = billeng.TestHistoryFieldDetails(ReferenceID, ReferenceType, TestType, out lstFields);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstFields);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While TestHistoryFieldDetails in WebService", ex);
        }
        return JsonOut;
    }
    [WebMethod(EnableSession = true)]
    public string GetDueReasonMaster(Int16 pReasonCategoryID, int pReasonTypeID, string ReasonCode)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<ReasonMaster> lstDueReasonMaster = new List<ReasonMaster>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

        try
        {
            Master_BL objDueReason = new Master_BL(new BaseClass().ContextInfo);
            resultCode = objDueReason.GetReasonMaster(pReasonCategoryID, pReasonTypeID, ReasonCode, out lstDueReasonMaster);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstDueReasonMaster);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While TestHistoryFieldDetails in WebService", ex);
        }
        return JsonOut;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string PatientTestHistoryValues(int OrgID, long PatientVisitID)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<ClientAttributesKeyFields> lstFields = new List<ClientAttributesKeyFields>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            Patient_BL ObjBL = new Patient_BL(new BaseClass().ContextInfo);
            resultCode = ObjBL.PatientTestHistoryValues(OrgID, PatientVisitID, out lstFields);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstFields);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        return JsonOut;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string DeleteTestHistoryFieldDetails(string JsonData, int FeeID, string FeeType)
    {

        string JsonOut = "";
if(JsonData !="")
{
        List<ClientAttributesKeyFields> lsttempTestHistory = new List<ClientAttributesKeyFields>();

        List<ClientAttributesKeyFields> lstdeleteTestHistory = new List<ClientAttributesKeyFields>();
        JavaScriptSerializer JSonTestHsitory = new JavaScriptSerializer();
        lsttempTestHistory = JSonTestHsitory.Deserialize<List<ClientAttributesKeyFields>>(JsonData);
        var VardeleteTestHistory = from child in lsttempTestHistory
                                   where child.TestType != FeeType && child.ReferenceID != FeeID
                                   select child;

        lstdeleteTestHistory = VardeleteTestHistory.ToList();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstdeleteTestHistory);
}
        return JsonOut;

    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public String LoadMetaDataDropDownValues(int OrgID, String Domain)
    {
        string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;
        long returncode = -1;
        String jsonstr = "";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        MetaData_BL objmeta = new MetaData_BL(new BaseClass().ContextInfo);
        try
        {
            string domains = Domain;
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = objmeta.LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            jsonstr = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstmetadataOutput);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data in OPIP Billing ", ex);

        }
        return jsonstr;

    }

    //////////added for QMS////////////////////////
    #region QMS
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Role> GetQCRolesbyNames(string Roles, long orgID)
    {
        long returncode = -1;
        List<Role> obj = new List<Role>();
        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returncode = Obj_BL.GetRolesbyName(Roles, orgID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in GetRolesbyName ", e);
        }
        return obj;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Login> pGetLoginNamesbyRole(long RoleID, long orgID)
    {
        long returnCode = -1;
        List<Login> lstlogin = new List<Login>();
        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = Obj_BL.pGetLoginNamesbyRole(RoleID, orgID, out lstlogin);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetLoginNamesbyRole", ex);
        }
        return lstlogin;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Widgetmaster_Custom> pGetWidgetNames(long RoleID)
    {
        long returnCode = -1;
        List<Widgetmaster_Custom> lst = new List<Widgetmaster_Custom>();
        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = Obj_BL.pGetWidgetNames(RoleID, out lst);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetWidgetNames", ex);
        }
        return lst;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] pGetWidgetsbyRoleandUser(long RoleID, long LoginID, long orgID)
    {
        object[] arr = new object[2];
        long returnCode = -1;
        List<Widgetmaster_Custom> obj = new List<Widgetmaster_Custom>();
        List<Widgetmaster_Custom> lst = new List<Widgetmaster_Custom>();
        List<WidgetGroupingDetails> lst1 = new List<WidgetGroupingDetails>();
        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = Obj_BL.pGetWidgetsbyRoleandUser(RoleID, LoginID, orgID, out obj);
            lst = obj.GroupBy(p => p.WID).Select(g => g.First()).ToList();
            arr[0] = lst;
            arr[1] = obj;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetLoginNamesbyRole", ex);
        }
        return arr;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<WidgetUserDetails> pGetWidgetsuserdetails(long RoleID, long LoginID, long orgID)
    {

        long returnCode = -1;
        List<WidgetUserDetails> obj = new List<WidgetUserDetails>();
        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = Obj_BL.pGetWidgetsuserdetails(RoleID, LoginID, orgID, out obj);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetLoginNamesbyRole", ex);
        }
        return obj;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long pSaveWidgetsbyroleanduser(long RoleID, long OrgID, string[] LoginID, string[] WID)
    {
        long returncode = -1;

        List<WidgetRoleMapping_Custom> wrm = new List<WidgetRoleMapping_Custom>();


        try
        {
            List<string> userlist = LoginID.ToList();
            List<string> widgetlist = WID.ToList();

            foreach (string item in userlist)
            {
                foreach (string item1 in widgetlist)
                {
                    WidgetRoleMapping_Custom wdlst = new WidgetRoleMapping_Custom();
                    if (!String.IsNullOrEmpty(item1) && item1.Length > 0)
                    {
                        wdlst.WID = Convert.ToInt64(item1);
                    }
                    else
                    {
                        wdlst.WID = 0;
                    }
                    wdlst.RoleID = RoleID;
                    wdlst.OrgID = OrgID;
                    if (!String.IsNullOrEmpty(item) && item.Length > 0)
                    {
                        wdlst.LoginID = Convert.ToInt64(item);
                    }
                    else
                    {
                        wdlst.LoginID = 0;
                    }
                    wrm.Add(wdlst);
                }

            }

            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returncode = Obj_BL.pSaveWidgetsbyroleanduser(wrm);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing in pSaveWidgetsbyroleanduser", e);
        }
        return returncode;
    }


    //added by sudhakar 2017-03-06
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object pGetMISReport(int OrgID, int LocationID, int DepartmentID, string fromDate, string toDate, int checkDiff, string WCode, string WGCode)
    {


        DataSet ds = new DataSet();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        object[] arr = new object[2];
        long returncode = -1;

        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            ds = Obj_BL.pGetMISReport(OrgID, LocationID, DepartmentID, Convert.ToDateTime(fromDate), Convert.ToDateTime(toDate), checkDiff, WCode, WGCode);

            if (ds.Tables.Count > 0)
            {

                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
            }
            //arr[0] = rows;
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while loading in pgetGeneralStatistics_DAL", e);
        }
        return rows;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string pGetWidgetmisreport(long OrgID, long LocationID, long DeptID, string FromDate, string ToDate, long RoleID)
    {
        object[] arr = new object[3];
        long returnCode = -1;
        DataTable billing = new DataTable();
        DataTable TestDetails = new DataTable();
        DataTable analyserdetails = new DataTable();
        DataTable sampledetails = new DataTable();
        DataTable NearingTatDetails = new DataTable();
        DataTable DelayedTATDetails = new DataTable();
        DataSet dsCountDetails = new DataSet();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;


        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            returnCode = Obj_BL.pGetWidgetcountmis(OrgID, LocationID, DeptID, Convert.ToDateTime(FromDate), Convert.ToDateTime(ToDate), RoleID, out billing, out TestDetails, out analyserdetails, out sampledetails, out  NearingTatDetails, out  DelayedTATDetails, out dsCountDetails);

            foreach (DataRow dr in billing.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in billing.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

            foreach (DataRow dr in TestDetails.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in TestDetails.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

            foreach (DataRow dr in analyserdetails.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in analyserdetails.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

            foreach (DataRow dr in sampledetails.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in sampledetails.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

            int j = 1;
            if (NearingTatDetails.Rows.Count >= j)
            {
                row = new Dictionary<string, object>();
                foreach (DataRow dr in NearingTatDetails.Rows)
                {


                    row.Add(NearingTatDetails.Columns[0].ColumnName + "_" + j, Convert.ToString(dr[0]));
                    j++;

                }
                rows.Add(row);
            }

            int i = 1;
            if (DelayedTATDetails.Rows.Count >= i)
            {
                row = new Dictionary<string, object>();
                foreach (DataRow dr in DelayedTATDetails.Rows)
                {

                    row.Add(DelayedTATDetails.Columns[0].ColumnName + "_" + i, Convert.ToString(dr[0]));
                    i++;

                }
                rows.Add(row);
            }

            if (dsCountDetails.Tables.Count > 5)
            {
                foreach (DataRow dr in dsCountDetails.Tables[6].Rows)
                {
                    row = new Dictionary<string, object>();
                    foreach (DataColumn col in dsCountDetails.Tables[6].Columns)
                    {
                        row.Add(col.ColumnName, dr[col]);
                    }
                    rows.Add(row);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetWidgetcountmis", ex);
        }
        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(rows);
    }

    #endregion
    ////////////////////////end////////////////////
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string WorkLoadMISReport(long OrgID, long LocationID, int DepartmentID, string fromDate, string toDate, string WorkloadCode)
    {


        DataSet ds = new DataSet();
        List<Dictionary<string, string>> rows = new List<Dictionary<string, string>>();
        Dictionary<string, string> row;


        try
        {
            Master_BL Obj_BL = new Master_BL(new BaseClass().ContextInfo);
            ds = Obj_BL.pGetWorkLoadMISReport(OrgID, LocationID, DepartmentID, Convert.ToDateTime(fromDate), Convert.ToDateTime(toDate), WorkloadCode);

            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {

                    foreach (DataColumn col in ds.Tables[0].Columns)
                    {
                        row = new Dictionary<string, string>();
                        if (WorkloadCode == "DWB" || WorkloadCode == "DWB-01" || WorkloadCode == "DWB-02")
                        {

                            row.Add("label", col.ColumnName);
                            row.Add("value", dr[col].ToString());
                        }
                        else
                        {
                            row.Add("X", col.ColumnName);
                            row.Add("Y", dr[col].ToString());
                        }
                        rows.Add(row);

                    }

                }
            }
            //{ y: '2011 Q1', X: 2666, item2: 2666 }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while loading in pGetWorkLoadMISReport", e);
        }
        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BlockSlideBarcodePreparation> GetBlockSlidePreparationDetails(long VisitNumber, string BarCode)
    {
        long returnCode = -1;
        List<BlockSlideBarcodePreparation> lstBarcodeDetails;
        try
        {
            Investigation_BL invBl = new Investigation_BL(new BaseClass().ContextInfo);
            lstBarcodeDetails = new List<BlockSlideBarcodePreparation>();
            returnCode = invBl.getBlockSlidePreparation(VisitNumber, BarCode, out lstBarcodeDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading in GetBlockSlidePreparationDetails", ex);
            throw;
        }
        return lstBarcodeDetails;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long UpdateBlockSlideDetails(string PrimaryBarcode, string BarcodeNumber, string BlockType, string SlideName, string StainType, string SlideComments,long Orgid)
    {
        long returnCode = -1;
        List<BlockSlideBarcodePreparation> lstBarcodeDetails;
        try
        {
            Investigation_BL invBl = new Investigation_BL();
            lstBarcodeDetails = new List<BlockSlideBarcodePreparation>();
            returnCode = invBl.pUpdateBlockSlideDetails(PrimaryBarcode, BarcodeNumber, BlockType, SlideName, StainType, SlideComments, Orgid);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading in UpdateBlockSlideDetails", ex);
            throw;
        }
        return returnCode;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetHistoSampleSearch(string VisitNumber, string PatientNumber, string HistoNumber, string PatientName, long InvID, string SampleContainerID, int SampleCode, string BarcodeNumber, string frmDate, string toDate)
    {
        long returnCode = -1;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        DataTable dt = new DataTable();

        try
        {
            DateTime FromDate;
            DateTime ToDate;
            if (frmDate == "")
            {
                FromDate = Convert.ToDateTime("1/1/1753");
            }
            else
            {
                FromDate = Convert.ToDateTime(frmDate);
            }
            if (toDate == "")
            {
                ToDate = DateTime.MaxValue;
            }
            else
            {
                ToDate = Convert.ToDateTime(toDate);
            }

            Histopathology_BL invBl = new Histopathology_BL(new BaseClass().ContextInfo);

            returnCode = invBl.PgetHistoSampleSearch(VisitNumber, PatientNumber, HistoNumber, PatientName, InvID, SampleContainerID, SampleCode, BarcodeNumber, FromDate, ToDate, out dt);
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading in UpdateBlockSlideDetails", ex);

        }
        serializer.MaxJsonLength = Int32.MaxValue;
        return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long pSaveEnterTissueType(List<PatientInvSample> lstPatSamp)
    {
        long ReturnCode = -1;
        Histopathology_BL Hbl = new Histopathology_BL(new BaseClass().ContextInfo);
        try
        {
            ReturnCode = Hbl.pSaveEnterTissueType(lstPatSamp);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in pSaveEnterTissueType", ex);
        }
        return ReturnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DropDownValueCode> GetINVandSampleandContainerDetails(string Name, string SampleName, string ContainerName, string DoctorName)
    {
        long ReturnCode = -1;
        Histopathology_BL Hbl = new Histopathology_BL(new BaseClass().ContextInfo);
        List<DropDownValueCode> lstDrp = new List<DropDownValueCode>();

        try
        {
            ReturnCode = Hbl.pGetINVandSampleandContainerDetails(Name, SampleName, ContainerName, DoctorName, out lstDrp);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in GetINVandSampleandContainerDetails", ex);
        }
        return lstDrp;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DropDownValueCode> GetDropDownHistoStatus(string ActinType)
    {
        long ReturnCode = -1;
        Histopathology_BL Hbl = new Histopathology_BL(new BaseClass().ContextInfo);
        List<DropDownValueCode> lstDrp = new List<DropDownValueCode>();

        try
        {
            ReturnCode = Hbl.GETDropDownHistoStatus(ActinType, out lstDrp);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in GETDropDownHistoStatus", ex);
        }
        return lstDrp;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetHistopathSpecimenDetailsEntrySearch(PatientHistoStatusDetails lstPatHisto, string ActionType)
    {
        long ReturnCode = -1;
        long returnCode = -1;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;

        try
        {


            DataTable dt = new DataTable();
            //DateTime  frmDate;
            //DateTime  toDate;
            string FromDate = lstPatHisto.FromDate;
            string ToDate = lstPatHisto.ToDate;
            if (FromDate == "")
            {
                lstPatHisto.FromDate = "1/1/1753";
            }
            else
            {
                lstPatHisto.FromDate = FromDate;
            }
            if (ToDate == "")
            {
                lstPatHisto.ToDate = "31/12/9999";
            }
            else
            {
                lstPatHisto.ToDate = ToDate;
            }

            Histopathology_BL invBl = new Histopathology_BL(new BaseClass().ContextInfo);
            ReturnCode = invBl.GetHistopathSpecimenDetailsEntrySearch(lstPatHisto, ActionType, out dt);
            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in GetHistopathSpecimenDetailsEntrySearch", ex);
        }
        serializer.MaxJsonLength = Int32.MaxValue;
        return serializer.Serialize(rows);
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveHistoSpecimenDetailsEntry(List<PatientHistoStatusDetails> lstPatientHistoStatusDetails, String ActionType)
    {
        long ReturnCode = -1;
        // lstPatientHistoStatusDetails = new List<PatientHistoStatusDetails>();
        try
        {
            Histopathology_BL HisBl = new Histopathology_BL(new BaseClass().ContextInfo);
            ReturnCode = HisBl.SaveHistoSpecimenDetailsEntry(lstPatientHistoStatusDetails, ActionType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading in SaveHistoSpecimenDetailsEntry", ex);

        }
        return ReturnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetMISDoctorWiseReportHisto(System.DateTime FromDate, System.DateTime ToDate, string HistoNo, long ApprovedBy)
    {
        long returnCode = -1;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            DataTable dt = new DataTable();
            Histopathology_BL hbl = new Histopathology_BL(new BaseClass().ContextInfo);
            returnCode = hbl.GetMISDoctorWiseReportHisto(FromDate, ToDate, HistoNo, ApprovedBy, out dt);

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in SaveHistoSpecimenDetailsEntry", ex);
        }
        serializer.MaxJsonLength = Int32.MaxValue;
        return serializer.Serialize(rows);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string GetCashOutFlowPaymentReport(int LocationID, String PayableType, String FromDate, String ToDate)
    {
        long returnCode = -1;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        try
        {
            DataTable dt = new DataTable();
            Report_BL hbl = new Report_BL(new BaseClass().ContextInfo);
            returnCode = hbl.PgetCashOutFlowPaymentReport(LocationID, PayableType, FromDate, ToDate, out dt);

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading in GetCashOutFlowPaymentReport OPIPBILLING Services", ex);
        }
        serializer.MaxJsonLength = Int32.MaxValue;
        return serializer.Serialize(rows);
    }

    /*******Alex Starts****************/
    //added by sudha fetchPageType1
    [WebMethod(EnableSession = true)]
    public List<MetaData> fetchPageType()
    {
        List<MetaData> lstMetaData = new List<MetaData>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.GetPageType(orgID, out lstMetaData);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPagenames Web Service Message:", ex);
        }
        return lstMetaData;
    }



    //added by sudha new -1  PageType 
    [WebMethod(EnableSession = true)]
    public List<LanguageMaster> GetPageLang()
    {



        // List<MetaData> lstMetaData = new List<MetaData>();
        List<LanguageMaster> lstLanguageMaster = new List<LanguageMaster>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.GetPageLang(out lstLanguageMaster);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPagenames Web Service Message:", ex);
        }
        return lstLanguageMaster;
    }





    //added by sudha fetchPageStatus2
    [WebMethod(EnableSession = true)]
    public List<InvSampleStatusmaster> fetchPageStatus()
    {
        List<InvSampleStatusmaster> lstInvSampleStatusmaster = new List<InvSampleStatusmaster>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.GetPageStatus(orgID, out lstInvSampleStatusmaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPagenames Web Service Message:", ex);
        }
        return lstInvSampleStatusmaster;
    }


    //Added by sudha for Gridview bind in pageload3
    [WebMethod(EnableSession = true)]
    public List<InvStatusOrgPageMapping> fetchGridData()
    {
        List<InvStatusOrgPageMapping> lstInvStatusOrgPageMapping = new List<InvStatusOrgPageMapping>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.GetIInvStatusOrgPageMapping(orgID, out lstInvStatusOrgPageMapping);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPagenames Web Service Message:", ex);
        }
        return lstInvStatusOrgPageMapping;
    }





    //Added by sudha for Insert data pageload 4
    // pInsertInvStatusOrgPageMapping
    //# region for InvStatusOrgPageMapping
    ////added by sudha
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public long InsertInvStatusOrgPageMapping(string PageType, string Isdefault, string DisplayText, int statusId,string Langcode )
    {
        long retCode = -1;
        Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
        Int32 orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        InvStatusOrgPageMapping objInvStatusOrgPageMapping = new InvStatusOrgPageMapping();
        objInvStatusOrgPageMapping.OrgID = orgID;
        objInvStatusOrgPageMapping.PageType = PageType;
        objInvStatusOrgPageMapping.IsDefault = Isdefault;
        objInvStatusOrgPageMapping.Displaytext = DisplayText;
        objInvStatusOrgPageMapping.StatusID = statusId;
        objInvStatusOrgPageMapping.LangCode = Langcode;

        retCode = masterbl.InsertInvStatusOrgPageMapping(objInvStatusOrgPageMapping, out retCode);
        return retCode;

    }


    // added bu sudha for NewUpdate button 5-

    //NewUpdateInvStatusOrgPageMapping
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public long NewUpdateInvStatusOrgPageMapping(string InvStatusOrgPageMappingID, string PageType, string Isdefault, string DisplayText, int statusId, string LangCode)
    {
        int InvMappingid = Convert.ToInt32(InvStatusOrgPageMappingID);
        long retCode = -1;
        Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
        Int32 orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        InvStatusOrgPageMapping objInvStatusOrgPageMapping = new InvStatusOrgPageMapping();
        objInvStatusOrgPageMapping.OrgID = orgID;
        objInvStatusOrgPageMapping.PageType = PageType;
        objInvStatusOrgPageMapping.IsDefault = Isdefault;
        objInvStatusOrgPageMapping.Displaytext = DisplayText;
        objInvStatusOrgPageMapping.StatusID = statusId;
        objInvStatusOrgPageMapping.LangCode = LangCode;
        objInvStatusOrgPageMapping.InvStatusOrgPageMappingID = InvMappingid;
        retCode = masterbl.NewUpdateInvStatusOrgPageMapping(objInvStatusOrgPageMapping, out retCode);
        return retCode;

    }

    //Ended by sudha for NewUpdate button














    //added by sudha for delete 6

    //DeleteInvStatusOrgPageMapping
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public long DeleteInvStatusOrgPageMapping(int refid)
    {
        long retCode = -1;
        Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);


        retCode = masterbl.DeleteInvStatusOrgPageMapping(refid, out retCode);
        return retCode;

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool AddDeviceErrorInfo(string JsonStringData)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<DeviceErrorFlags> errorFlagInfo = o.Deserialize<List<DeviceErrorFlags>>(JsonStringData);
            if (errorFlagInfo.Count > 0)
            {
                var addedItem = errorFlagInfo[0];
                addedItem.operationType = ErrFlgOperationType.Add;

                AddOrEditErrorFlagInfo(addedItem);
            }
            else
            {
                return false;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Add Error Flag Map Info:", ex);
        }
        return true;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool EditDeviceErrorInfo(string JsonStringData, string edit_EquipID, string edit_ErrorCode)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<DeviceErrorFlags> errorFlagInfo = o.Deserialize<List<DeviceErrorFlags>>(JsonStringData);
            if (errorFlagInfo.Count > 0)
            {
                var modifiedItem = errorFlagInfo[0];
                return EditDeviceErrorInfo(modifiedItem, edit_EquipID, edit_ErrorCode);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Edit ErrorFlag Map Info Message:", ex);
            return false;
        }

        return false;
    }

    internal bool EditDeviceErrorInfo(DeviceErrorFlags modifiedItem, string edit_EquipID, string edit_ErrorCode)
    {
        try
        {
            if (modifiedItem != null)
            {
                modifiedItem.operationType = ErrFlgOperationType.Modify;

                Dictionary<long, Dictionary<string, DeviceErrorFlags>> allEerrFlgMpDic = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session["ErrorFlagMappingInfo"];
                if (allEerrFlgMpDic == null)
                    allEerrFlgMpDic = new Dictionary<long, Dictionary<string, DeviceErrorFlags>>();

                //string key = DeviceErrorFlag.GetDeviceErrorFlagId(modifiedItem.InstrumentID.ToString(), modifiedItem.ErrorCode);

                if (modifiedItem.operationType == ErrFlgOperationType.Modify)
                {
                    #region Edit

                    //if(allEerrFlgMpDic.ContainsKey(modifiedItem.InstrumentID)) 
                    //    if(allEerrFlgMpDic[modifiedItem.InstrumentID].ContainsKey( modifiedItem.
                    #region To Remove existing item - if change error codeinstrument Id

                    long old_iId;
                    long.TryParse(edit_EquipID, out old_iId);
                    string old_errorCode = edit_ErrorCode;

                    //modified in newly added item.. This doesnt save in DB
                    if (allEerrFlgMpDic[old_iId][old_errorCode].operationType == ErrFlgOperationType.Add)
                        modifiedItem.operationType = ErrFlgOperationType.Add;

                    //To update, if errorCode or instrument info modified
                    if (old_iId != modifiedItem.InstrumentID || old_errorCode != modifiedItem.ErrorCode)
                    {
                        allEerrFlgMpDic[old_iId][old_errorCode].operationType = ErrFlgOperationType.Delete;
                        //allEerrFlgMpDic[old_iId].Remove(old_errorCode);
                        Session["ErrorFlagMappingInfo"] = allEerrFlgMpDic;

                        modifiedItem.operationType = ErrFlgOperationType.Add;

                        //modifiedItem.operationType = ErrFlgOperationType.Add;
                    }
                    #endregion remove existing item

                    //if (!EditedItemSymbols.ContainsKey(key))
                    //{
                    //    EditedItemSymbols.Add(key, errorFlagInfo.ErrorCode);
                    //    ViewState[cnstSsnEditedErrorMapInfo] = EditedItemSymbols;
                    //}
                    AddOrEditErrorFlagInfo(modifiedItem);

                    #endregion Edit
                }
            }
            else
                return false;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Edit ErrorFlag Map Info Message:", ex);
            return false;
        }

        return true;
    }

    private void AddOrEditErrorFlagInfo(DeviceErrorFlags errorFlagInfo)
    {
        #region Add/Edit

        if (errorFlagInfo.ProductName == "")
        {
            Dictionary<long, InstrumentInfoErrorFlag> InstrumnetInfo = (Dictionary<long, InstrumentInfoErrorFlag>)Session["InstrumentInfo"];
            if (InstrumnetInfo.ContainsKey(errorFlagInfo.InstrumentID))
            {
                errorFlagInfo.ProductName = InstrumnetInfo[errorFlagInfo.InstrumentID].InstrumentName;
                errorFlagInfo.DeviceCode = InstrumnetInfo[errorFlagInfo.InstrumentID].ProductCode;
            }
        }

        Dictionary<long, Dictionary<string, DeviceErrorFlags>> allEerrFlgMpDic = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session["ErrorFlagMappingInfo"];
        if (allEerrFlgMpDic == null)
            allEerrFlgMpDic = new Dictionary<long, Dictionary<string, DeviceErrorFlags>>();


        #region Add/Modify
        if (allEerrFlgMpDic.ContainsKey(errorFlagInfo.InstrumentID))
        {
            if (!allEerrFlgMpDic[errorFlagInfo.InstrumentID].ContainsKey(errorFlagInfo.ErrorCode))
                allEerrFlgMpDic[errorFlagInfo.InstrumentID].Add(errorFlagInfo.ErrorCode, errorFlagInfo);
            else
                allEerrFlgMpDic[errorFlagInfo.InstrumentID][errorFlagInfo.ErrorCode] = errorFlagInfo;
        }
        else
        {
            allEerrFlgMpDic.Add(errorFlagInfo.InstrumentID, new Dictionary<string, DeviceErrorFlags>() { { errorFlagInfo.ErrorCode, errorFlagInfo } });
        }
        #endregion Add/Modify

        Session["ErrorFlagMappingInfo"] = allEerrFlgMpDic;
        #endregion Add/Edit
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool ImportDeviceErrorInfo(string jsonItems)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<DeviceErrorFlags> importItems = o.Deserialize<List<DeviceErrorFlags>>(jsonItems);
            if (importItems.Count > 0)
            {
                for (int i = 0; i < importItems.Count; i++)
                {
                    var addedItem = importItems[i];
                    addedItem.operationType = ErrFlgOperationType.Add;

                    AddOrEditErrorFlagInfo(addedItem);
                }
            }
            return true;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Import Error Flag Map Info:", ex);
        }
        return false;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool DeleteDeviceErrorInfo(string equipId, string errorCode)
    {
        try
        {
            Dictionary<long, Dictionary<string, DeviceErrorFlags>> errFlgMpDic = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session["ErrorFlagMappingInfo"];
            if (errFlgMpDic != null)
            {
                //bool isNeedDeleteModeAlso = false;
                for (int i = 0; i < errFlgMpDic.Count; i++)
                {
                    var pKey = errFlgMpDic.ElementAt(i).Key;

                    foreach (KeyValuePair<string, DeviceErrorFlags> Pair in errFlgMpDic[pKey])
                    {
                        var obj = Pair.Value;
                        //ErrorMappintInfo.Add(errorFlagInfo.InstrumentID, new Dictionary<string, DeviceErrorFlag>() { { errorFlagInfo.ErrorCode, errorFlagInfo } });
                        if (obj.operationType != ErrFlgOperationType.Delete && obj.InstrumentID.ToString() == equipId && obj.ErrorCode == errorCode)
                        {
                            Pair.Value.operationType = ErrFlgOperationType.Delete;
                            Session["ErrorFlagMappingInfo"] = errFlgMpDic;
                            return true;
                        }
                    }
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Delete Device errorMaping Info", ex);
        }
        return false;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool DeviceErrorInfoActivateOrNot(string equipId, string errorCode)
    {

        try
        {
            Dictionary<long, Dictionary<string, DeviceErrorFlags>> errFlgMpDic = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session["ErrorFlagMappingInfo"];
            if (errFlgMpDic != null)
            {
                //bool isNeedDeleteModeAlso = false;
                for (int i = 0; i < errFlgMpDic.Count; i++)
                {
                    var pKey = errFlgMpDic.ElementAt(i).Key;

                    foreach (KeyValuePair<string, DeviceErrorFlags> Pair in errFlgMpDic[pKey])
                    {
                        var obj = Pair.Value;

                        if (obj.operationType != ErrFlgOperationType.Delete && obj.InstrumentID.ToString() == equipId && obj.ErrorCode == errorCode)
                        {
                            //ErrorMappintInfo.Add(errorFlagInfo.InstrumentID, new Dictionary<string, DeviceErrorFlag>() { { errorFlagInfo.ErrorCode, errorFlagInfo } });
                            if (obj.IsActive == 1)
                                obj.IsActive = 0;
                            else
                                obj.IsActive = 1;
                            if (obj.operationType == ErrFlgOperationType.Add)
                                AddOrEditErrorFlagInfo(obj);
                            else
                                EditDeviceErrorInfo(obj, obj.InstrumentID.ToString(), obj.ErrorCode);

                            return true;
                        }

                    }
                }
            }

            return false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Activate/Deactivate Device errorMaping Info", ex);
        }
        return false;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<DeviceErrorFlags> GetErrorMapInfo()
    {
        List<DeviceErrorFlags> errFlgMpLst = new List<DeviceErrorFlags>();
        try
        {
            Dictionary<long, Dictionary<string, DeviceErrorFlags>> errFlgMpDic = (Dictionary<long, Dictionary<string, DeviceErrorFlags>>)Session["ErrorFlagMappingInfo"];
            if (errFlgMpDic != null)
            {
                int sno = 0;
                bool isNeedDeleteModeAlso = false;
                for (int i = 0; i < errFlgMpDic.Count; i++)
                {
                    var pKey = errFlgMpDic.ElementAt(i).Key;
                    foreach (KeyValuePair<string, DeviceErrorFlags> Pair in errFlgMpDic[pKey])
                    {
                        if (!isNeedDeleteModeAlso && Pair.Value.operationType == ErrFlgOperationType.Delete)
                            continue;

                        sno++;
                        Pair.Value.SNO = sno;
                        errFlgMpLst.Add(Pair.Value);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Get all Device errorMaping Info", ex);
        }
        return errFlgMpLst;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAllInstrumentInfo(string prefixText, string contextKey)
    {

        List<InstrumentInfoErrorFlag> filteredItems = new List<InstrumentInfoErrorFlag>();
        Dictionary<long, InstrumentInfoErrorFlag> instruments = (Dictionary<long, InstrumentInfoErrorFlag>)Session["InstrumentInfo"];

        List<string> selectedItmsStrArray = new List<string>();
        if (instruments != null)
        {
            var searchKey = prefixText.ToUpper();

            Dictionary<string, string> tmpArray = new Dictionary<string, string>();

            foreach (KeyValuePair<long, InstrumentInfoErrorFlag> pair in instruments)
            {
                var item = pair.Value;
                bool isInstrumentName = false;
                bool isProductCode = false;

                if (item.InstrumentName.ToUpper().StartsWith(searchKey))
                    isInstrumentName = true;
                else if (item.ProductCode.ToUpper().StartsWith(searchKey))
                    isProductCode = true;

                if (isInstrumentName || isProductCode)
                {
                    string key = item.ProductCode + "~" + item.InstrumentName;
                    if (!tmpArray.ContainsKey(key))
                    {
                        string val = item.InstrumentID.ToString() + "~";
                        if (isInstrumentName)
                            val += item.InstrumentName;
                        else
                            val += item.ProductCode;

                        selectedItmsStrArray.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(key, val));
                        tmpArray.Add(key, val);
                    }
                }
            }
        }
        return selectedItmsStrArray.ToArray();
    }

    #region PageContext Master
    [WebMethod(EnableSession = true)]
    public List<PageContext> GetPagenames()
    {
        List<PageContext> lstPagecontext = new List<PageContext>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.FetchPageNames(orgID, out lstPagecontext);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPagenames Web Service Message:", ex);
        }
        return lstPagecontext;
    }

    [WebMethod(EnableSession = true)]
    public List<PageContext> GetPageContext()
    {
        List<PageContext> lstPagecontext = new List<PageContext>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.FetchPageContext(orgID, out lstPagecontext);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPageContext Web Service Message:", ex);
        }
        return lstPagecontext;
    }

    [WebMethod(EnableSession = true)]
    public int InsertPageContext(PageContext pagecontext)
    {
        int ReturnValue = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.InsertPageContext(orgID, pagecontext);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertPageContext Web Service Message:", ex);
        }
        return ReturnValue;
    }

    [WebMethod(EnableSession = true)]
    public int DeletePageContextbyId(int val)
    {
        int ReturnValue = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            Int32 orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            masterbl.DeletePageContextbyId(val);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchPageContextbyId Web Service Message:", ex);
        }
        return ReturnValue;
    }

    [WebMethod(EnableSession = true)]
    public List<ActionManagerType> FetchActionManagerType()
    {
        List<ActionManagerType> lstActionManagerType = new List<ActionManagerType>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            masterbl.FetchActionManagerType(out lstActionManagerType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchActionManagerType Web Service Message:", ex);
        }
        return lstActionManagerType;
    }

    [WebMethod(EnableSession = true)]
    public long SaveActionManagerType(ActionManagerType actionmanager)
    {
        long returncode = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            returncode = masterbl.InsertActionManagerType(actionmanager);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveActionManagerType Web Service Message:", ex);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    public long DeletActionManagerType(int Id)
    {
        long returncode = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            returncode = masterbl.DeleteActionManagerType(Id);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DeletActionManagerType Web Service Message:", ex);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    public List<ActionTemplateType> FetchActionTemplateType()
    {
        List<ActionTemplateType> templatetype = new List<ActionTemplateType>();
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.FetchActionTemplateType(out templatetype);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchActionTemplateType Web Service Message:", ex);
        }
        return templatetype;
    }

    [WebMethod(EnableSession = true)]
    public int InsertActionTemplateType(ActionTemplateType actionTemplateType)
    {
        int returnvalue = 0;
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.InsertActionTemplateType(actionTemplateType, out returnvalue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertActionTemplateType Web Service Message:", ex);
        }
        return returnvalue;
    }

    [WebMethod(EnableSession = true)]
    public long DeletActionTemplateType(int Id)
    {
        long returncode = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            returncode = masterbl.DeleteActionTemplateType(Id);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DeletActionTemplateType Web Service Message:", ex);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    public List<LanguageMaster> FetchLanguage()
    {
        List<LanguageMaster> lstLanguage = new List<LanguageMaster>();
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            masterbl.FetchLanguageMaster(out lstLanguage);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchLanguage Web Service Message:", ex);
        }
        return lstLanguage;
    }

    [WebMethod(EnableSession = true)]
    public List<ActionTemplate> FetchActionTemplate()
    {
        List<ActionTemplate> templatetype = new List<ActionTemplate>();
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.FetchActionTemplate(out templatetype);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchActionTemplate Web Service Message:", ex);
        }
        return templatetype;
    }

    [WebMethod(EnableSession = true)]
    public int InsertActionTemplate(ActionTemplate actionTemplate)
    {
        int returnvalue = 0;
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.InsertActionTemplate(actionTemplate, out returnvalue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertActionTemplate Web Service Message:", ex);
        }
        return returnvalue;
    }

    [WebMethod(EnableSession = true)]
    public long DeletActionTemplate(int Id)
    {
        long returncode = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            returncode = masterbl.DeleteActionTemplate(Id);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DeletActionTemplate Web Service Message:", ex);
        }
        return returncode;
    }

    [WebMethod(EnableSession = true)]
    public List<PageContextActionMapping> FetchPageContextActionMapping()
    {
        List<PageContextActionMapping> actionmapping = new List<PageContextActionMapping>();
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.FetchPageContextActionMapping(out actionmapping);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in FetchPageContextActionMapping Web Service Message:", ex);
        }
        return actionmapping;
    }

    [WebMethod(EnableSession = true)]
    public int InsertPageContextActionMapping(PageContextActionMapping actionmapping)
    {
        int returnvalue = 0;
        try
        {
            Master_BL templatetypebl = new Master_BL(new BaseClass().ContextInfo);
            templatetypebl.InsertPagecontextActionMapping(actionmapping, out returnvalue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertPageContextActionMapping Web Service Message:", ex);
        }
        return returnvalue;
    }

    [WebMethod(EnableSession = true)]
    public long DeletPageContextActionMapping(int Id)
    {
        long returncode = 0;
        try
        {
            Master_BL masterbl = new Master_BL(new BaseClass().ContextInfo);
            returncode = masterbl.DeletePagecontextActionMapping(Id);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DeletPageContextActionMapping Web Service Message:", ex);
        }
        return returncode;
    }

    #endregion PageContext Master
    /*******Alex End****************/


    //added by jegan MetaData insert start

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public long pInsertMetaData(MetaData objMetaData)
    {
        long returnCode = -1;
        MetaData_BL metaBL = new MetaData_BL(new BaseClass().ContextInfo);
        returnCode = metaBL.pInsertMetaData(objMetaData, out  returnCode);
        if (returnCode != 2)
            HttpContext.Current.Cache.Remove("MetaDataCacheFile");
        return returnCode;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public object[] GetMetaData()
    {
        object[] arr = new object[2];
        // System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        MetaData_BL metaBL = new MetaData_BL(new BaseClass().ContextInfo);
        List<MetaData> lsMetaData = new List<MetaData>();
        List<LanguageMaster> lstLanguageMaster = new List<LanguageMaster>();
        try
        {
            List<string> items = new List<string>();
            metaBL.LoadMetaData(out lsMetaData, out lstLanguageMaster);
            arr[0] = lsMetaData;
            arr[1] = lstLanguageMaster;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetMetaData in WebService", ex);
        }

        return arr;
    }

    //End
    //Added by Jegan
    #region Clinical History Master
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<History> GetAllHistoryMasterItems(int Orgid)
    {
        List<History> historyMasterLst = new List<History>();
        try
        {
            Master_BL oBL = new Master_BL(new BaseClass().ContextInfo = new ContextDetails());
            historyMasterLst = oBL.GetAllClinicalHistoryItems_BL(Orgid);
            //return historyMasterLst;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetAllHistoryMasterItems Message:", ex);
            //return false;
        }
        return historyMasterLst;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<History> GetAllActiveHistoryMasterItems(int Orgid)
    {
        List<History> historyMasterLst = new List<History>();
        try
        {
            Master_BL oBL = new Master_BL(new BaseClass().ContextInfo = new ContextDetails());
            var tmpHistoryMasterLst = oBL.GetAllClinicalHistoryItems_BL(Orgid);
            if (tmpHistoryMasterLst != null)
            {
                historyMasterLst = tmpHistoryMasterLst.FindAll(H => H.IsActive == "Y");
            }
            //return historyMasterLst;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetAllHistoryMasterItems Message:", ex);
            //return false;
        }
        return historyMasterLst;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool SaveClinicalHistoryMaster(string JsonStringData)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<History> historyMasterLst = o.Deserialize<List<History>>(JsonStringData);
            if (historyMasterLst.Count > 0)
            {
                Master_BL oBL = new Master_BL(new BaseClass().ContextInfo = new ContextDetails());
                long resultCode = oBL.SaveClinicalHistoryMaster(historyMasterLst);

                if (resultCode != -1)
                    return true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save Clinical History Master Info Message:", ex);
            return false;
        }

        return false;
    }

    #endregion Clinical History Master

    #region  Clinical History Mapping
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<InvMedicalDetailsMapping> GetAllHistoryMappingItems(int Orgid)
    {
        List<InvMedicalDetailsMapping> historyMappingLst = new List<InvMedicalDetailsMapping>();

        Master_BL oBL = new Master_BL(new BaseClass().ContextInfo = new ContextDetails());
        historyMappingLst = oBL.GetAllHistoryMappingItems(Orgid);

        List<InvMedicalDetailsMapping> historyMappingOrderedLst = new List<InvMedicalDetailsMapping>();
        if (historyMappingLst != null)
        {
            try
            {
                historyMappingOrderedLst = historyMappingLst.OrderBy(HM => HM.InvID).ThenBy(H => H.HistorySequence).ToList();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Get all Clinical History Mapping Info", ex);
            }
        }

        return historyMappingOrderedLst;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAllHistoryMasterInfos(string prefixText, string contextKey)
    {
        List<string> selectedItmsStrArray = new List<string>();

        string[] strValue = contextKey.Split('~');
        var orgidStr = strValue[0];
        int orgId;
        if (int.TryParse(orgidStr, out orgId))
        {
            List<History> historyMstrLst = GetAllHistoryMasterItems(orgId);

            if (historyMstrLst != null)
            {
                var searchKey = prefixText.ToUpper();

                Dictionary<string, string> tmpArray = new Dictionary<string, string>();

                foreach (History item in historyMstrLst)
                {
                    if (item.IsActive != "Y")
                        continue;

                    bool isHistoryName = false;
                    bool isHistoryCode = false;

                    if (item.HistoryName.ToUpper().StartsWith(searchKey))
                        isHistoryName = true;
                    else if (item.HistoryCode.ToUpper().StartsWith(searchKey))
                        isHistoryCode = true;

                    if (isHistoryName || isHistoryCode)
                    {
                        string key = item.HistoryCode + "~" + item.HistoryName;
                        if (!tmpArray.ContainsKey(key))
                        {
                            string val = item.HistoryID.ToString() + "~";
                            if (isHistoryName)
                                val += item.HistoryName;
                            else
                                val += item.HistoryCode;

                            selectedItmsStrArray.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(key, val));
                            tmpArray.Add(key, val);
                        }
                    }
                }
            }
        }
        return selectedItmsStrArray.ToArray();

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool SaveClinicalHistoryMapping(string JsonStringData)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<InvMedicalDetailsMapping> historyMappingLst = o.Deserialize<List<InvMedicalDetailsMapping>>(JsonStringData);
            if (historyMappingLst.Count > 0)
            {
                Master_BL oBL = new Master_BL(new BaseClass().ContextInfo = new ContextDetails());
                long resultCode = oBL.SaveClinicalHistoryMapping(historyMappingLst);

                if (resultCode != -1)
                    return true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Save Clinical History Mapping Info Message:", ex);
            return false;
        }

        return false;
    }
    #endregion  Clinical History Mapping
    //End
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public int GetAutoAuthorizationStatus(long VisitID, int OrgID, int AutoAuthorizationCount, long InvID)
    {
        long result = -1;
        int ReturnCode = 0;
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        result = Inv_BL.GetIsAutoAuthorization(VisitID, OrgID, AutoAuthorizationCount, InvID, out ReturnCode);
        Session["AutoAuthorCheck"] = ReturnCode;
        return ReturnCode;
    }
	[WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> GetProductsIsNotActive(int OrgID)
    {
        long returnCode = -1;
        List<InvInstrumentMaster> lstInvInstrumentMaster = new List<InvInstrumentMaster>();
        try
        {
            Master_BL objbl = new Master_BL();
            //returnCode = objMas_BL.GetProductsIsNotActive(OrgId);
            //returncode = new masterbl(new BaseClass().ContextInfo).GetProductsIsNotActive(OrgId);
            returnCode = objbl.GetProductsIsNotActive(OrgID, out lstInvInstrumentMaster);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL GetProductsIsNotActive", ex);
        }
        return lstInvInstrumentMaster;
    }

 [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvInstrumentMaster> GetProductsIsActive(int OrgID)
    {
        long returnCode = -1;
        List<InvInstrumentMaster> lstInvInstrumentMaster = new List<InvInstrumentMaster>();
        try
        {
            SharedInventory_BL objbl = new SharedInventory_BL();
            returnCode = objbl.GetProducts(OrgID, out lstInvInstrumentMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL GetProductsIsNotActive", ex);
        }
        return lstInvInstrumentMaster;
    }

 [WebMethod(EnableSession = true)]
 [System.Web.Script.Services.ScriptMethod()]
	public long SaveQuestionaryTemplate(long TemplateID,string TemplateName,string TemplateText,long InvestigationID,string Invtype)
    {
        long rcode = -1;
        try { 
            Master_BL mbl = new Master_BL(new BaseClass().ContextInfo);
            rcode = mbl.SaveQuestionaryTemplate(TemplateID,TemplateName, TemplateText, InvestigationID, Invtype);
        }
        catch(Exception ec)
        {
        
        }
        return rcode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public object[] GetAllQuestionaryTemplates(long TemplateID, long InvestigationID, string Invtype, string SType)
    {
        object[] arr = new object[2];
       List<QuestionayTemplateDetails> lstTemplate = new List<QuestionayTemplateDetails>();
       List<QuestionayTemplateDetails> lstTemplateMap = new List<QuestionayTemplateDetails>(); 
        long rcode = -1;
        try
        {
            Master_BL mbl = new Master_BL(new BaseClass().ContextInfo);
            rcode = mbl.GetAllQuestionaryTemplates(TemplateID,InvestigationID, Invtype,SType,out lstTemplate,out lstTemplateMap);
            arr[0] = lstTemplate;
            arr[1] = lstTemplateMap;
        }
        catch (Exception ec)
        {

        }
        return arr;
    }

#region DepartmentSequenceNumber

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Users> pGetLoginNames(long Deptid, long Locid, int Orgid)
    {
        long returnCode = -1;
        List<Users> lstlogin = new List<Users>();
        try
        {
            Master_BL objMas_BL = new Master_BL();
            returnCode = objMas_BL.GetLogID(Deptid, Locid, Orgid, out lstlogin);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BL pGetLoginName", ex);
        }
        return lstlogin;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<UserSigLocBasedDept> GetDeptSigSeqMapLog(int Orgid, int Deptid, int Addressid)
    {
        long returnCode = -1;
        List<UserSigLocBasedDept> stUsLoDep = new List<UserSigLocBasedDept>();
        try
        {
            returnCode = new Master_BL().GetDeptSigSeqMapLog(Orgid, Deptid, Addressid, out stUsLoDep);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading get Department ", ex);
        }
        return stUsLoDep;
    }
 [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string ClientAttributesFieldValues(long ReferenceID, string ReferenceType, long PatientVisitID)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<ClientAttributesKeyFields> lstFields = new List<ClientAttributesKeyFields>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            BillingEngine billeng = new BillingEngine(new BaseClass().ContextInfo);
            resultCode = billeng.ClientAttributesFieldValues(ReferenceID, ReferenceType,PatientVisitID, out lstFields);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstFields);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While GetAuditTrailReport in WebService", ex);
        }
        return JsonOut;
    }
	
	
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<OrderedInvestigations> GetPatientVisitInvestigation(long VisitID, int OrgID)
    {
        long tatResult = 0;
        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        Patient_BL ObjInv = new Patient_BL(new BaseClass().ContextInfo);
        try
        {
            ObjInv = new Patient_BL(new BaseClass().ContextInfo);




            tatResult = ObjInv.GetPatientVisitInvestigation(VisitID, OrgID, out lstOrderedInvestigations);


            if (lstOrderedInvestigations.Count > 0)
            {
                int totCount = lstOrderedInvestigations.Count;
                int totApproveCount = 0;
                var childItems = from child in lstOrderedInvestigations
                                 where child.Status == "Approve"
                                 //orderby child.MetaDataID ascending
                                 select child;

                totApproveCount = childItems.Count();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientVisitInvestigation Web Service Message:", ex);
        }
        return lstOrderedInvestigations;
    }


    #endregion

 #region CheckIsValidtoTransferNew
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string CheckIsValidtoTransferNew(string lstajaxsample)
    {
        long returncode = -1;

        DateTime TransDate = DateTime.MaxValue;

        string Message = string.Empty;
        JavaScriptSerializer o = new JavaScriptSerializer();


        List<CollectedSample> lstpinvsampleVisits = new List<CollectedSample>();
        List<PatientInvSample> lstpinvsample = new List<PatientInvSample>();
        PatientInvSample pinvs = new PatientInvSample();
        lstpinvsample = o.Deserialize<List<PatientInvSample>>(lstajaxsample);
        try
        {

            returncode = new Investigation_BL(new BaseClass().ContextInfo).CheckIsValidtoTransferNew(lstpinvsample, out lstpinvsampleVisits);

            if (lstpinvsampleVisits.Count > 0)
            {

                foreach (CollectedSample collectSample in lstpinvsampleVisits)
                {
                    if (Message == string.Empty)
                    {
                        Message = "We encounter following problems in sample transfer\n\n";
                    }
                    Message += "VID -- " + collectSample.VisitNumber + "\n";
                    Message += "Test Name -- " + collectSample.InvestigationName + "\n";
                    Message += "Reason -- " + collectSample.Reason + "\n\n";
                }
                Message = Message.Replace("'", "");
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "AlertBlock", "javascript:alert('" + errorMessage + "');", true);
            }
            if (lstpinvsampleVisits.Count == 0)
            {
                returncode = new Investigation_BL(new BaseClass().ContextInfo).UpdateSampleTransferNew(lstpinvsample);
                Message = "Sample Transferred Sucesfully";
                // ScriptManager.RegisterStartupScript(Page, this.GetType(), "select1", "javascript:alert('Sample Transferred Successfully!');", true);
                // dInves.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While CheckIsValidtoTransfer in WebService", ex);
        }
        return Message;


    }
    #endregion

    #region GetInvSamplesTransferStatusNew
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CollectedSample> GetInvSamplesTransferStatusNew(string pageno, int Orgid, string textfrom, string textto, int intSampleStatus, int locid, string visitid, string patientname, int visittype, int priority, string sourcename, string InvestigationName, string InvestigationID, string InvestigationType, string refPhyName, string refPhyID, string refPhyOrg, string SmID, int droptype, int smpleID, int ProcessedLocID, int outsourceID, string BarcodeNo, int ContainerID, int PlocationID)
    {
        long result = -1;
        long investigationidloc = -1;
        long refPhyIDloc = -1;
        long refPhyOrgloc = -1;
        long SmIDloc = -1;
        int pageSize = 10;
        int startRowIndex = 1;
        int totalRows = 0;

        List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();
        //ArrayList samples = new ArrayList();
        try
        {
            Int32.TryParse(pageno, out startRowIndex);
            Int64.TryParse(InvestigationID, out investigationidloc);
            Int64.TryParse(refPhyID, out refPhyIDloc);
            Int64.TryParse(refPhyOrg, out refPhyOrgloc);
            Int64.TryParse(SmID, out SmIDloc);
            //Investigation_BL invbl1 = new Investigation_BL(base.ContextInfo);
            Investigation_BL invbl1 = new Investigation_BL(new BaseClass().ContextInfo);
            // NewReports_BL ReportBL = new NewReports_BL(new BaseClass().ContextInfo);
            result = invbl1.GetInvSamplesTransferStatusNew(Orgid, textfrom, textto, intSampleStatus, locid, "", visitid, patientname,
            visittype, priority, sourcename, InvestigationName, investigationidloc, InvestigationType, refPhyName, refPhyIDloc, refPhyOrgloc,
           SmIDloc, droptype, out lstInvestigationSamples, pageSize, startRowIndex, out totalRows, smpleID, ProcessedLocID, outsourceID, BarcodeNo, ContainerID, PlocationID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetInvSamplesTransferStatus in WebService", ex);
        }
        //return json;
        //samples.Add(lstInvestigationSamples);
        //samples.Add(totalRows);
        return lstInvestigationSamples;

    }
    #endregion
    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<DrugLevelMapping> GetOrganismDrugLevelMapDetails(long DrugID)
    {
        long returnCode = -1;
        List<DrugLevelMapping> lstDrugLevelMapping = new List<DrugLevelMapping>();
        try
        {
            BaseClass oBaseClass = new BaseClass();
            returnCode = new Investigation_BL(oBaseClass.ContextInfo).GetOrganismDrugLevelMapDetails(DrugID, out lstDrugLevelMapping);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetOrganismDrugLevelMapDetails in WS", ex);
        }
        return lstDrugLevelMapping;
    }
    /* END | sabari | 20181129 | Dev | Culture Report */

    /* Begin | Surya | ICD Code Master */
     public string[] getICDCODEMaster(string prefixText, int count)
    {

        Patient_BL oPatient_BL = new Patient_BL(new BaseClass().ContextInfo);
        List<ICDCodes> lstICDCodes = new List<ICDCodes>();

        string[] ICDArray = null;
        long lresutl = -1;
        lresutl = oPatient_BL.GetICDCODE(prefixText, out lstICDCodes);
        if (lstICDCodes.Count > 0)
        {
            ICDArray = new string[lstICDCodes.Count];
            for (int i = 0; i < lstICDCodes.Count; i++)
            {
                //ICDArray[i] = lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ComplaintName; 
                //ICDArray[i] = lstICDCodes[i].ICDCode + "~" + lstICDCodes[i].ICDDescription + "~" + lstICDCodes[i].ComplaintName + "~" + lstICDCodes[1].ComplaintId;
                ICDArray[i] =  lstICDCodes[i].ICDCode;
            }
        }

        return ICDArray;
    }
     /* End | Surya | ICD Code Master */

     [WebMethod(EnableSession = true)]
     [System.Web.Script.Services.ScriptMethod()]
     public SmartReport GetSmartReportNotification(long NotificationID)
     {
         long result = -1;

         string Paths = "";
         SmartReport lstSmartRep = new SmartReport();
         Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
         try
         {
             lstSmartRep = Inv_BL.GetSmartReportNotification(NotificationID, out Paths);

             //  pds = lstSmartRep.pds.FirstOrDefault();



             //lstSmartRep.trends = lstSmartReports.trends;
             //lstSmartRep.summaryNormal = lstSmartReports.summaryNormal;
             //lstSmartRep.summaryAbNormal = lstSmartReports.summaryAbNormal;
             //lstSmartRep.labResults = lstSmartReports.labResults;

         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in GetSmartReportNotification:", ex);
         }
         return lstSmartRep;
     }

     [WebMethod(EnableSession = true)]
     [System.Web.Script.Services.ScriptMethod()]
     public long UpdateSmartReportNotificationAPI(long NotificationID, long PatientVisitid, long OrgID)
     {
         long result = -1;

         Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
         try
         {
             result = Inv_BL.UpdateSmartReportNotificationAPI(NotificationID, PatientVisitid, OrgID,"");

         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in GetSmartReportNotification:", ex);
         }
         return result;
     }
     [WebMethod(EnableSession = true)]
     [System.Web.Script.Services.ScriptMethod()]
     public List<ApprovedReports> GetEmailReportNotification(int InstanceId, string approvetime, string service, string category)
     {
         long result = -1;
         List<ApprovedReports> AppReport = new List<ApprovedReports>();
         Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
         try
         {
             result = Inv_BL.GetOrgApprovedReport(InstanceId, approvetime, service, out AppReport);
         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in GetApprovedReportList:", ex);
         }
         return AppReport;
     }

    #region TAT_Integration

    /*BEGIN | Bug ID[NA] | TAT |  | A |  TAT Integration  */
    #region ["SaveManageSchedule"]

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string SaveManageSchedule(string Schedulecode, string Schedulename, string Reportedon, int Tatcalculationbase, int Processinghours, int Processingmins, string Earlyreporttime, int Tatprocesstype, int Tatmode, string tableJson, int Orgid, string Scheduleid, int Flag, string lstHolidaymaster, string tableJson2, string strlstScheduledayValues, string strlstScheduleWeekValues)
    {
        BaseClass ContextInfo = new BaseClass();
        TATSchedule tATschedule;
        JavaScriptSerializer js = new JavaScriptSerializer();
        string outMessage = string.Empty;
        string Result = string.Empty;

        int ScheduleID1 = 0;
        Int32.TryParse(Scheduleid, out ScheduleID1);

        List<TATSchedule> lstTATSchedule = new List<TATSchedule>();
        List<Holidaymaster> lstHoliday = new List<Holidaymaster>();
        try
        {
            if (lstHolidaymaster != "")
            {
                lstHoliday = js.Deserialize<List<Holidaymaster>>(lstHolidaymaster);//passing valuein
            }
            if (tableJson != "" && tableJson2 != "" && strlstScheduledayValues == "" && strlstScheduleWeekValues == "")
            {
                SlotConfig[] dataItem = js.Deserialize<SlotConfig[]>(tableJson);


                if (dataItem.Length > 0)
                {
                    foreach (var item in dataItem)
                    {

                        tATschedule = new TATSchedule();
                        tATschedule.Scheduleid = ScheduleID1;
                        tATschedule.Schedulecode = Schedulecode;
                        tATschedule.Schedulename = Schedulename;
                        tATschedule.Reportedon = Reportedon;
                        tATschedule.Tatcalculationbase = Tatcalculationbase;
                        tATschedule.Processinghours = Processinghours;
                        tATschedule.Processingmins = Processingmins;
                        tATschedule.Earlyreporttime = Earlyreporttime;
                        tATschedule.Tatprocesstype = Tatprocesstype;
                        tATschedule.Tatmode = Tatmode;
                        tATschedule.Batchstarttime = item.Batchstarttime;
                        tATschedule.Cutofftime = item.Cutofftime;
                        tATschedule.Orgid = Orgid;
                        tATschedule.Flag = Flag;
                        tATschedule.Scheduleday = tableJson2;
                        lstTATSchedule.Add(tATschedule);


                    }
                }
            }
            else if (tableJson != "" && tableJson2 == "" && strlstScheduledayValues != "")
            {
                SlotConfig[] dataItem = js.Deserialize<SlotConfig[]>(tableJson);

                if (dataItem.Length > 0)
                {
                    foreach (var item in dataItem)
                    {

                        tATschedule = new TATSchedule();
                        tATschedule.Scheduleid = ScheduleID1;
                        tATschedule.Schedulecode = Schedulecode;
                        tATschedule.Schedulename = Schedulename;
                        tATschedule.Reportedon = Reportedon;
                        tATschedule.Tatcalculationbase = Tatcalculationbase;
                        tATschedule.Processinghours = Processinghours;
                        tATschedule.Processingmins = Processingmins;
                        tATschedule.Earlyreporttime = Earlyreporttime;
                        tATschedule.Tatprocesstype = Tatprocesstype;
                        tATschedule.Tatmode = Tatmode;
                        tATschedule.Batchstarttime = item.Batchstarttime;
                        tATschedule.Cutofftime = item.Cutofftime;
                        tATschedule.Orgid = Orgid;
                        tATschedule.Flag = Flag;
                        tATschedule.Scheduleday = strlstScheduledayValues;
                        lstTATSchedule.Add(tATschedule);


                    }
                }

            }
            else if (tableJson != "" && tableJson2 == "" && strlstScheduledayValues == "" && strlstScheduleWeekValues != "")
            {
                SlotConfig[] dataItem = js.Deserialize<SlotConfig[]>(tableJson);

                if (dataItem.Length > 0)
                {
                    foreach (var item in dataItem)
                    {

                        tATschedule = new TATSchedule();
                        tATschedule.Scheduleid = ScheduleID1;
                        tATschedule.Schedulecode = Schedulecode;
                        tATschedule.Schedulename = Schedulename;
                        tATschedule.Reportedon = Reportedon;
                        tATschedule.Tatcalculationbase = Tatcalculationbase;
                        tATschedule.Processinghours = Processinghours;
                        tATschedule.Processingmins = Processingmins;
                        tATschedule.Earlyreporttime = Earlyreporttime;
                        tATschedule.Tatprocesstype = Tatprocesstype;
                        tATschedule.Tatmode = Tatmode;
                        tATschedule.Batchstarttime = item.Batchstarttime;
                        tATschedule.Cutofftime = item.Cutofftime;
                        tATschedule.Orgid = Orgid;
                        tATschedule.Flag = Flag;
                        tATschedule.Scheduleday = strlstScheduleWeekValues;
                        lstTATSchedule.Add(tATschedule);


                    }
                }

            }
            AdminReports_BL adminbl = new AdminReports_BL(new BaseClass().ContextInfo);
            adminbl.SaveManageSchedule(lstTATSchedule, lstHoliday, out outMessage);
            Result = (outMessage);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveManageSchedule in webservice.cs", ex);
        }
        return Result;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<object> GetManageSchedule(int pagesize, int pageindex, string search)
    {
        BaseClass ContextInfo = new BaseClass();
        List<TATSchedule> lstTATSchedule = new List<TATSchedule>();
        List<Holidaymaster> lstHolidaymaster = new List<Holidaymaster>();
        var list = new List<object>();
        try
        {
            long returncode = -1;
            returncode = new AdminReports_BL(new BaseClass().ContextInfo).GetManageSchedule(pagesize, pageindex, search, out lstTATSchedule, out lstHolidaymaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetManageSchedule in webservice.cs", ex);
        }
        list.Add(lstTATSchedule);
        list.Add(lstHolidaymaster);
        return list;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Holidaymaster> GetHolidayMaster(int pOrgID)
    {
        BaseClass ContextInfo = new BaseClass();

        List<Holidaymaster> lstHolidaymaster = new List<Holidaymaster>();

        try
        {
            long returncode = -1;
            returncode = new AdminReports_BL(new BaseClass().ContextInfo).GetHolidayMaster(pOrgID, out lstHolidaymaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetManageSchedule in webservice.cs", ex);
        }
        return lstHolidaymaster;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<CodingScheme> GetScheduleDay(int OrgID)
    {
        BaseClass ContextInfo = new BaseClass();

        List<CodingScheme> lstScheduleday = new List<CodingScheme>();

        try
        {
            long returncode = -1;
            returncode = new AdminReports_BL(new BaseClass().ContextInfo).GetScheduleDay(OrgID, out lstScheduleday);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetScheduleDay in webservice.cs", ex);
        }
        return lstScheduleday;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<object> EditManageSchedule(int Scheduleid)
    {
        BaseClass ContextInfo = new BaseClass();
        List<TATSchedule> lstTATSchedule = new List<TATSchedule>();
        List<Holidaymaster> lstHolidaymaster = new List<Holidaymaster>();
        var list = new List<object>();
        try
        {
            long returncode = -1;
            returncode = new AdminReports_BL(new BaseClass().ContextInfo).EditManageSchedule(Scheduleid, out lstTATSchedule, out lstHolidaymaster);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading EditManageSchedule ", ex);
        }
        list.Add(lstTATSchedule);
        list.Add(lstHolidaymaster);
        return list;
    }


    #endregion




    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTATSchedulecode(string prefixText)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<TATSchedule> lstTATSchedulecode = new List<TATSchedule>();
        List<string> items = new List<string>();
        int orgID = 0;
        //if (contextKey != "")
        //{
        // int ClientTypeID = Convert.ToInt32(contextKey);
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        Master_BL.GetTATSchedulecode(orgID, prefixText, out lstTATSchedulecode);
        if (lstTATSchedulecode.Count > 0)
        {
            foreach (TATSchedule item in lstTATSchedulecode)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Schedulecode, item.Scheduleday));
                // items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Schedulecode, item.Scheduleid.ToString()));
            }
        }
        //}
        return items.ToArray();


    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTATSchedulecategoryItemAutoComplete(string prefixText, string contextKey)
    {
        TAT_BL TAT_BL = new TAT_BL(new BaseClass().ContextInfo);
        List<TATCodingScheme> lstTATSchedulecategoryItem = new List<TATCodingScheme>();
        List<string> items = new List<string>();
        int orgID = 0;
        string SearchType = contextKey;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        TAT_BL.GetTATSchedulecategoryItem(orgID, prefixText, SearchType, out lstTATSchedulecategoryItem);

        if (lstTATSchedulecategoryItem.Count > 0)
        {
            foreach (TATCodingScheme item in lstTATSchedulecategoryItem)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.CodeName, item.IdentifyingID.ToString()));
            }
        }

        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<TATCodingScheme> LoadCategoryTestname(string prefixText, string SearchType, int ItemID, int ConfigID)
    {
        TAT_BL TBL = new TAT_BL(new BaseClass().ContextInfo);
        List<TATCodingScheme> lstCategoryTestname = new List<TATCodingScheme>();
        try
        {
            List<string> items = new List<string>();
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            TBL.getCategoryTestname(orgID, prefixText, SearchType, ItemID, ConfigID, out lstCategoryTestname);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadCategoryTestname in WebService", ex);
        }
        return lstCategoryTestname;
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveDeleteTAT(string lstReportRelease, string lstReportDelete)
    {
        long ReturnCode = -1;
        TAT_BL TAT_BL = new TAT_BL(new BaseClass().ContextInfo);
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<Tatschedulemapping> lstTATAdded = new List<Tatschedulemapping>();

        if (lstReportRelease != "")
        {
            lstTATAdded = serializer1.Deserialize<List<Tatschedulemapping>>(lstReportRelease);//passing valuein
        }
        List<Tatschedulemapping> lstTATDelete = new List<Tatschedulemapping>();
        if (lstReportDelete != "")
        {
            lstTATDelete = serializer1.Deserialize<List<Tatschedulemapping>>(lstReportDelete);//passing valuein
        }


        if (lstTATAdded.Count > 0)
        {
            ReturnCode = TAT_BL.SaveTestforTAT(lstTATAdded);

        }
        if (lstTATDelete.Count > 0)
        {
            ReturnCode = TAT_BL.DeleteTestforTAT(lstTATDelete);

        }


        return ReturnCode;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<TATCodingScheme> LoadtatTestname(int TatID)
    {
        TAT_BL TAT_BL = new TAT_BL(new BaseClass().ContextInfo);
        List<TATCodingScheme> lstCategoryTestname = new List<TATCodingScheme>();
        try
        {
            List<string> items = new List<string>();
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            TAT_BL.LoadtatTestname(orgID, TatID, out lstCategoryTestname);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadCategoryTestname in WebService", ex);
        }
        return lstCategoryTestname;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<TATCodingScheme> LoadClienttatTestname(int TatID, int ClientID)
    {
        TAT_BL TBL = new TAT_BL(new BaseClass().ContextInfo);
        List<TATCodingScheme> lstCategoryTestname = new List<TATCodingScheme>();
        try
        {
            List<string> items = new List<string>();
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            TBL.LoadtatClientTestname(orgID, TatID, ClientID, out lstCategoryTestname);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadCategoryTestname in WebService", ex);
        }
        return lstCategoryTestname;
    }

    #region TATMANAGELOGISTICS [TATMANAGELOGISTICS]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Tatlogisticdetails> GetOrgLocationDetails(int OrgId, long OrgAddressId)
    {
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        List<Tatlogisticdetails> lstTatlogisticdetails = new List<Tatlogisticdetails>();
        try
        {

            Master_BL.GetOrgLocationDetails(OrgId, OrgAddressId, out lstTatlogisticdetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadCategoryTestname in WebService", ex);
        }
        return lstTatlogisticdetails;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Organization> GetOrgLoction()
    {

        AdminReports_BL AdminReports_BL = new AdminReports_BL(new BaseClass().ContextInfo);
        List<Organization> lstOrg = new List<Organization>();
        try
        {


            AdminReports_BL.pGetOrgLoction(out lstOrg);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetOrgLoction in WebService", ex);
        }
        return lstOrg;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Tatlogisticdetails> LoadTATLogisticsDetails(int OrgId, long OrgAddressId)
    {
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        List<Tatlogisticdetails> lstTatlogisticdetails = new List<Tatlogisticdetails>();
        try
        {

            Master_BL.LoadTATLogisticsDetails(OrgId, OrgAddressId, out lstTatlogisticdetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadTATLogisticsDetails in WebService", ex);
        }
        return lstTatlogisticdetails;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveTATLogisticsDetails(string lstSave)
    {
        long ReturnCode = -1;
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<Tatlogisticdetails> lstTATLogisticsDetails = new List<Tatlogisticdetails>();

        if (lstSave != "")
        {
            lstTATLogisticsDetails = serializer1.Deserialize<List<Tatlogisticdetails>>(lstSave);//passing valuein
        }



        if (lstTATLogisticsDetails.Count > 0)
        {
            ReturnCode = Master_BL.SaveTATLogisticsDetails(lstTATLogisticsDetails);

        }



        return ReturnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Tatlogisticdetails> EditTATLogisticsDetails(int Logisticdetailsid)
    {
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        List<Tatlogisticdetails> lstTatlogisticdetails = new List<Tatlogisticdetails>();
        try
        {

            Master_BL.EditTATLogisticsDetails(Logisticdetailsid, out lstTatlogisticdetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadTATLogisticsDetails in WebService", ex);
        }
        return lstTatlogisticdetails;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long UpdateTATLogisticsDetails(string lstUpdate)
    {
        long ReturnCode = -1;
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<Tatlogisticdetails> lstTATLogisticsDetails = new List<Tatlogisticdetails>();

        if (lstUpdate != "")
        {
            lstTATLogisticsDetails = serializer1.Deserialize<List<Tatlogisticdetails>>(lstUpdate);//passing valuein
        }



        if (lstTATLogisticsDetails.Count > 0)
        {
            ReturnCode = Master_BL.UpdateTATLogisticsDetails(lstTATLogisticsDetails);

        }



        return ReturnCode;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long DeleteTATLogisticsDetails(string lstDelete)
    {
        long ReturnCode = -1;
        TAT_BL Master_BL = new TAT_BL(new BaseClass().ContextInfo);
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<Tatlogisticdetails> lstTATLogisticsDetails = new List<Tatlogisticdetails>();

        if (lstDelete != "")
        {
            lstTATLogisticsDetails = serializer1.Deserialize<List<Tatlogisticdetails>>(lstDelete);//passing valuein
        }



        if (lstTATLogisticsDetails.Count > 0)
        {
            ReturnCode = Master_BL.DeleteTATLogisticsDetails(lstTATLogisticsDetails);

        }



        return ReturnCode;
    }

    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveLocationWorkingHoursDetail(int OrgID, int OrgAddressId, DateTime Labstart, DateTime Labend, string FrequencyDays, int ID)
    {

        long returnCode = -1;
        try
        {
            TAT_BL patientBL = new TAT_BL(new BaseClass().ContextInfo);
            returnCode = patientBL.SaveLocationWorkingHoursDetail(OrgID, OrgAddressId, Labstart, Labend, FrequencyDays, ID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving SaveLocationWorkingHoursDetail", ex);
        }
        return returnCode;
    }

    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<TATLocationworkinghours> BindLocationWorkingHoursDetail(int orgID, long RoleID, long LocationID)
    {
        long returnCode = -1;
        Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        loggedIn.LoginID = Convert.ToInt64(Session["LID"]);
        TAT_BL patientBL = new TAT_BL(new BaseClass().ContextInfo);
        List<TATLocationworkinghours> lstTATLocationWorkingHours = new List<TATLocationworkinghours>();
        returnCode = patientBL.GetLocationWorkingHoursDetail(orgID, Convert.ToInt64(Session["LID"]), RoleID, LocationID, out lstTATLocationWorkingHours);
        return lstTATLocationWorkingHours;
    }



    /*BEGIN | Bug ID[NA] | TAT |  | A |  TAT Integration  */

    #endregion 
	
	 #region RenderingReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList CustomizedReport(long ReportID, DateTime Fdate, DateTime Tdate, long ClientID, int VisitType, string TestDetail, int DeptID)
    {
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        ArrayList OutArray = new ArrayList();
        DataSet lstOutDataSet = new DataSet();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();

        try
        {
            lstOutDataSet = new Report_BL(new BaseClass().ContextInfo).CustomizedReport(ReportID, Fdate, Tdate, ClientID, VisitType,TestDetail,DeptID);
            dt = lstOutDataSet.Tables[0];
            //dt.Columns.Remove("Rowid");
            Dictionary<string, object> row;
            
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            Dictionary<string, object> row1;

            List<Dictionary<string, object>> rows1 = new List<Dictionary<string, object>>();
            if (lstOutDataSet.Tables.Count > 1)
            {
                dt1 = lstOutDataSet.Tables[1];
                
                foreach (DataRow dr in dt1.Rows)
            {
                row1 = new Dictionary<string, object>();
                foreach (DataColumn col in dt1.Columns)
                {
                    row1.Add(col.ColumnName, dr[col]);
                }
                rows1.Add(row1);
            }
            }
            OutArray.Add(oJavaScriptSerializer.Serialize(rows));
            OutArray.Add(oJavaScriptSerializer.Serialize(rows1));
            OutArray.Add(totalRows);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService RenderingReport Message:", ex);
        }
        return OutArray;
    }
    #endregion

 #region InterfacedWorklist
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList InterfacedWorklist(string worklistType, long SearchID, string Testtype, int orgid, string WLMode, string fromdate, string todate, long minvid, long maxvid,string visitnumber)
    {
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        ArrayList OutArray = new ArrayList();
        DataSet lstOutDataSet = new DataSet();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();

        try
        {
            lstOutDataSet = new Investigation_BL(new BaseClass().ContextInfo).InterfacedValueWorklist(worklistType, SearchID, Testtype, orgid, WLMode, fromdate, todate, minvid, maxvid,visitnumber);
            dt = lstOutDataSet.Tables[0];
            //dt.Columns.Remove("Rowid");
            Dictionary<string, object> row;

            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            Dictionary<string, object> row1;

            List<Dictionary<string, object>> rows1 = new List<Dictionary<string, object>>();
            if (lstOutDataSet.Tables.Count > 1)
            {
                dt1 = lstOutDataSet.Tables[1];

                foreach (DataRow dr in dt1.Rows)
                {
                    row1 = new Dictionary<string, object>();
                    foreach (DataColumn col in dt1.Columns)
                    {
                        row1.Add(col.ColumnName, dr[col]);
                    }
                    rows1.Add(row1);
                }
            }
            OutArray.Add(oJavaScriptSerializer.Serialize(rows));
            OutArray.Add(oJavaScriptSerializer.Serialize(rows1));
            OutArray.Add(totalRows);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService RenderingReport Message:", ex);
        }
        return OutArray;
    }
    #endregion
 [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingDetails> pGetBillingTestItemsSV(int OrgID, int FeeID, string FeeType)
    {

        Investigation_BL BL = new Investigation_BL(new BaseClass().ContextInfo);
        List<BillingDetails> pGetBillingTestItemsSV = new List<BillingDetails>();
        try
        {
            List<string> items = new List<string>();
            BL.pGetBillingTestItemsSV(OrgID, FeeID, FeeType, out pGetBillingTestItemsSV);
        }
        catch (Exception sd)
        {
        }
        return pGetBillingTestItemsSV;
    }
 [WebMethod(EnableSession = true)]
 [System.Web.Script.Services.ScriptMethod()]
 public List<OrganismMaster> GetOrganismNames(string OrgID)
 {
     long invID = Convert.ToInt64(OrgID);
     Investigation_BL inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
     List<OrganismMaster> lstOrganismMaster = new List<OrganismMaster>();

     try
     {
         inv_BL.GetOrganismList(invID, out lstOrganismMaster);
     }
     catch (Exception ex)
     { 
         CLogger.LogError("Error While GetEditPatientHistory in WebService", ex);
     }
     return lstOrganismMaster;
 }
 [WebMethod(EnableSession = true)]
 [System.Web.Script.Services.ScriptMethod()]
 public long SaveOrganismRangeValues(List<InvOrganismDrugMapping> lstOrganismDrugsRangeValues)
 {
     long returnCode = -1; 
     try
     {
         BaseClass oBaseClass = new BaseClass();
         returnCode = new Investigation_BL(oBaseClass.ContextInfo).SaveOrganismRangeValues(lstOrganismDrugsRangeValues);
     }
     catch (Exception ex)
     {
         CLogger.LogError("Error while SaveOrganismRangeValues Web Method", ex);
     }
     return returnCode;
 }
  #region ["GetInvReasons"]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<InvReasonMasters> GetInvReasons( int OrgID)
    {

        long returncode = -1;
        Investigation_BL BL = new Investigation_BL(new BaseClass().ContextInfo);
        List<InvReasonMasters> lstSampleReasons = new List<InvReasonMasters>();

        try
        {
            List<string> items = new List<string>();
            returncode = BL.GetInvReasons( OrgID, out  lstSampleReasons);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  pGetInvReasons_new", ex);
        }
        
        return lstSampleReasons;

    }
    #endregion



    #region ["GetUserListByRole"]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<Users> GetUserListByRole(int pOrgID, int pRoleID)
    {

        long returncode = -1;
        Users_BL BAL = new Users_BL(new BaseClass().ContextInfo);
        List<Users> lstUsers = new List<Users>();

        try
        {
            List<string> items = new List<string>();
            returncode = BAL.GetUserListByRole(pOrgID, pRoleID, out  lstUsers);
            //returnCode = new Users_DAL(globalContextDetails).GetUserListByRole(pOrgID, pRoleID, out lstUsers);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  GetUserListByRole", ex);
        }

        return lstUsers;

    }

    #endregion
    #region GetVisitNumbersByPID [GetVisitNumbersByPID]

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientVisit> GetVisitNumbersByPID(string pPatientNumber, long pPageID)
    {
        Patient_BL BL = new Patient_BL(new BaseClass().ContextInfo);
        List<PatientVisit> lstVisitNumbers = new List<PatientVisit>();
        try
        {
            List<string> items = new List<string>();
            BL.GetVisitNumberbyPID(pPatientNumber, pPageID, out lstVisitNumbers);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While GetVisitNumbersByPID in WebService", ex);
        }
        return lstVisitNumbers;
    }


    #endregion
     [WebMethod(EnableSession = true)]
     [System.Web.Script.Services.ScriptMethod()]
     public List<ApprovedReports> GetSmartReportMailNotification(long PatientVisitid, int OrgID)
     {
         long result = -1;
         List<ApprovedReports> lstReport = new List<ApprovedReports>();
         Report_BL Inv_BL = new Report_BL(new BaseClass().ContextInfo);
         try
         {
             result = Inv_BL.GetSmartReportMailNotification(PatientVisitid, OrgID, out lstReport);
         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in GetApprovedReportList:", ex);
         }
         return lstReport;
     }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string GetInvestigationInstruction(long PatientVisitID, int OrgID, int FeeID, string FeeType)
    {
        long resultCode = -1;
        string JsonOut = "";
        List<OrderedInvestigations> lstFields = new List<OrderedInvestigations>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        try
        {
            Investigation_BL ObjBL = new Investigation_BL(new BaseClass().ContextInfo);
            resultCode = ObjBL.GetInvestigationInstruction(PatientVisitID, OrgID, FeeID, FeeType, out lstFields);
            JsonOut = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstFields);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While GetInvestigationInstruction in WebService", ex);
        }
        return JsonOut;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BulkRegIntegration> GetBulkRegIntegrationNotifications(int InstanceID)
    {
        long result = -1;
        List<BulkRegIntegration> lstBulkRegIntegrations = new List<BulkRegIntegration>();
        List<BulkRegIntegration> lstBulkRegIntegrationsnew = new List<BulkRegIntegration>(); 
        List<BulkRegFileDetails> lstfile = new List<BulkRegFileDetails>();
        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.GetBulkRegIntegrationNotifications(InstanceID, out lstBulkRegIntegrations,out lstfile);
            foreach (BulkRegIntegration obj in lstBulkRegIntegrations)
            {
                BulkRegIntegration objres = new BulkRegIntegration();
                objres.firstName = obj.firstName;
                objres.gender = obj.gender;
                objres.healthHubId = obj.healthHubId;
                objres.lastName = obj.lastName;
                objres.location = obj.location;
                objres.NotificationID = obj.NotificationID;
                objres.phoneNumber = obj.phoneNumber;
                objres.Status = obj.Status;
                objres.dob = obj.dob;
                objres.emailid = obj.emailid;
                objres.AttachmentName = obj.AttachmentName;
                objres.externalPatientId = obj.externalPatientId;
                objres.Template = obj.Template;
                objres.visitDate = obj.visitDate;
                objres.visitId = obj.visitId;
                objres.lstFile = lstfile;
                objres.BookingNo = obj.BookingNo;
                objres.labAddress = obj.labAddress;
                objres.OrgCode = obj.OrgCode;
                lstBulkRegIntegrationsnew.Add(objres);
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetFeedbackNotifications:", ex);
        }
        return lstBulkRegIntegrationsnew;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BulkRegIntegrationResultValue> GetBulkRegIntegrationResultValue(long NotificationID,int typeID)
    {
        long result = -1;
        List<BulkRegIntegrationResultValue> lstBulkRegIntegrationResultValue = new List<BulkRegIntegrationResultValue>();
		ContextDetails obj = new ContextDetails();
        obj.OrgID = typeID;
        Investigation_BL Inv_BL = new Investigation_BL(obj);
        try
        {
            result = Inv_BL.GetBulkRegIntegrationResultValue(NotificationID, out lstBulkRegIntegrationResultValue);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in GetFeedbackNotifications:", ex);
        }
        return lstBulkRegIntegrationResultValue;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long UpdateBulkRegIntegrationNotifications(int InstanceID, List<BulkRegIntegration> lstBulkRegIntegrations)
    {
        long result = -1;
        // lstFeedbackNotifications = new List<FeedbackNotifications>();

        Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
        try
        {
            result = Inv_BL.UpdateBulkRegIntegrationNotifications(InstanceID, lstBulkRegIntegrations);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in UpdateFeedbackNotifications:", ex);
        }
        return result;
    }
   #region InvRulemaster
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList SaveInvRulemaster(string StrInvRuleMaster, string StrPatientAgeGenderRule, string StrTestResultsRule, string StrMachineErrorRule, int orgID, int RemarksId)
    {
        //    List<InvestigationValues> lstBulkData = new List<InvestigationValues>();
        //    List<InvestigationValues> lstPendingValue = new List<InvestigationValues>();
        //    List<InvestigationStatus> header = new List<InvestigationStatus>();
        //    List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        long returnCode = -1;
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
        lstInvRuleMaster = serializer.Deserialize<List<InvRuleMaster>>(StrInvRuleMaster);
        List<PatientAgeGenderRule> lstPatientAgeGenderRule = new List<PatientAgeGenderRule>();
        lstPatientAgeGenderRule = serializer.Deserialize<List<PatientAgeGenderRule>>(StrPatientAgeGenderRule);
        List<TestResultsRule> lstTestResultsRule = new List<TestResultsRule>();
        lstTestResultsRule = serializer.Deserialize<List<TestResultsRule>>(StrTestResultsRule);
        List<MachineErrorRule> lstMachineErrorRule = new List<MachineErrorRule>();
        lstMachineErrorRule = serializer.Deserialize<List<MachineErrorRule>>(StrMachineErrorRule);
        ArrayList a = new ArrayList();
        List<InvRuleMaster> lstOutInvRuleMaster = new List<InvRuleMaster>();
        
        try
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).SaveInvRulemaster(lstInvRuleMaster, lstPatientAgeGenderRule, lstTestResultsRule, lstMachineErrorRule, orgID,RemarksId, out lstOutInvRuleMaster);
            a.Add(lstOutInvRuleMaster);
            //a.Add(lstPendingValue);
            //a.Add(header);
            //a.Add(lstiom);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service SaveInvRulemaster Message:", ex);
        }
        return a;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetInvRulemaster(int RuleTypeid, long investigationid, int orgID,int RemarksId)
    {
        List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
        List<PatientAgeGenderRule> lstPatientAgeGenderRule = new List<PatientAgeGenderRule>();
        List<TestResultsRule> lstTestResultsRule = new List<TestResultsRule>();
        List<MachineErrorRule> lstMachineErrorRule = new List<MachineErrorRule>();
        long returnCode = -1;
        ArrayList a = new ArrayList();

        try
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvRulemaster(RuleTypeid, investigationid, orgID,RemarksId, out lstInvRuleMaster, out lstPatientAgeGenderRule, out lstTestResultsRule, out  lstMachineErrorRule);
            a.Add(lstInvRuleMaster);
            a.Add(lstPatientAgeGenderRule);
            a.Add(lstTestResultsRule);
            a.Add(lstMachineErrorRule);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetInvRulemaster Message:", ex);
        }
        return a;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetInvRulemasterCondition(int RuleTypeid, long investigationid, int orgID ,string InvType)
    {
        List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();
        
        long returnCode = -1;
        ArrayList a = new ArrayList();

        try
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvRulemasterCondition(RuleTypeid, investigationid, orgID,InvType, out lstInvRuleMaster);
            a.Add(lstInvRuleMaster);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetInvRulemaster Message:", ex);
        }
        return a;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<InvRuleMaster> GetAllRulemasterCondition(int RuleTypeid, long investigationid, int orgID, string InvType)
    {
        List<InvRuleMaster> lstInvRuleMaster = new List<InvRuleMaster>();

        long returnCode = -1;

        try
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetInvRulemasterCondition(RuleTypeid, investigationid, orgID, InvType, out lstInvRuleMaster);
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetInvRulemaster Message:", ex);
        }
        return lstInvRuleMaster;
    }
    
         [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long deleteRuleMaster(int RuleMasterId, int RuleTypeid, long investigationid, int orgID, int RemarksId)
    {
        long returnCode = -1;

        try
        {
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).deleteRuleMaster(RuleMasterId, RuleTypeid, investigationid, orgID, RemarksId);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  Web Service GetInvRulemaster Message:", ex);
        }
        return returnCode;
    }

    #endregion

         /* BEGIN | Velmurugan | 20201130 | Dev | Active Directory */
         #region Active Directory Logins
         [WebMethod(EnableSession = true)]
         [System.Web.Script.Services.ScriptMethod()]
         public long SaveActiveDirectoryUsers(string OrgCode, string personalTitle, string SAMAccountName, string mobile, string mail, string street, string postalAddress, string postalCode, string c, string st, string title, string department, string userName)
         {
             string TransPass = string.Empty;

             long lresult1 = -1;
             long lresult2 = -1;
             long rcode = -1;
             long returnCode = -1;
             List<IntegrationHistory> lstValue = new List<IntegrationHistory>();
             int OrgID = 0;
             int VisitType = 0;
             int LocationID = 0;
             long ClientID = 0;
             byte titlecode = 0x00;
             IntegrationBL objIntBL = new IntegrationBL(new BaseClass().ContextInfo);
             returnCode = objIntBL.SaveIntegrationData(lstValue, OrgCode, "", "", "", out  OrgID, out  LocationID, out  VisitType, out ClientID, out titlecode);

             TransPass = GetConfigValue("PasswordAuthentication", OrgID);
             try
             {
                 Users_BL LoginCheckdetails = new Users_BL(new BaseClass().ContextInfo);
                 lresult1 = LoginCheckdetails.GetCheckLogindetails(SAMAccountName);
                 if (lresult1 != 0)
                 {
                     DateTime DOB1 = new DateTime();
                     DOB1 = new DateTime(1800, 1, 1);
                     DateTime DOB = DOB1;
                     string Email = mail;

                     Users_BL userCheckdetails = new Users_BL(new BaseClass().ContextInfo);

                     if (lresult1 != 0 && lresult2 != 0)
                     {
                         long lresult = -1;
                         long LoginID = 0;
                         Role_BL roleBL = new Role_BL(new BaseClass().ContextInfo);
                         Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
                         //login.LoginName = txtName.Text;
                         login.LoginName = SAMAccountName;
                         login.OrgID = OrgID;
                         login.CreatedBy = 0;
                         //  login.PrinterPath = Convert.ToInt32(ddlPrinterName.SelectedItem.Value);
                         login.PrinterPath = 0;

                         login.EndDTTM = Convert.ToDateTime("1/1/1900 00:00:00");

                         string EncryptedString = string.Empty;
                         Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                         obj.Crypt(SAMAccountName, out EncryptedString); //Added with new parameter in SP
                         login.Password = EncryptedString;
                         if (TransPass == "Y")
                         {
                             login.Transactionpasssword = EncryptedString;
                         }


                         login.Status = "A";

                         lresult = roleBL.Savesysconfig(login, out LoginID);
                         // return LoginID;

                         if (LoginID > 0)
                         {
                             int alreadyinserted = 0;

                             long lresult_user = -1;
                             Users_BL UserBL = new Users_BL(new BaseClass().ContextInfo);
                             Users User = new Users();
                             UserAddress UserAddress = new UserAddress();
                             List<UserAddress> pAddress = new List<UserAddress>();
                             List<AdminInvestigationRate> lstInvRate = new List<AdminInvestigationRate>();
                             DateTime wDate = new DateTime();

                             //User.Name = SAMAccountName;
                             User.Name = userName;

                             // Min. default date.DateTime cannot be null and cannot be less that 1701
                             DOB = new DateTime(1800, 1, 1);

                             User.EmpID = 0;

                             User.DOB = DOB;
                             //User.SEX = ddlSex.SelectedValue;
                             User.SEX = "M";
                             User.Email = mail;
                             //User.TitleCode = personalTitle;
                             User.TitleCode = "0";
                             //User.Relegion = ddlReligion.SelectedValue;
                             User.Relegion = "";
                             //User.MaritalStatus = ddlMaritialStatus.SelectedValue;
                             User.MaritalStatus = "0";
                             User.Qualification = "";
                             User.OrgID = OrgID;
                             User.CreatedBy = 0;
                             User.LoginID = LoginID;
                             User.AddressID = 0;

                             // Min. default date.DateTime cannot be null and cannot be less that 1701
                             wDate = new DateTime(1800, 1, 1);

                             User.WeddingDt = wDate;

                             UserAddress.Add2 = postalAddress;
                             UserAddress.City = street;
                             UserAddress.PostalCode = postalCode;
                             UserAddress.MobileNumber = mobile;
                             UserAddress.StateID = 0;
                             UserAddress.CountryID = 0;
                             pAddress.Add(UserAddress);

                             User.Address = pAddress;
                             lresult_user = UserBL.SaveUsers(User);//1
                             //InserInventoryUser(User);
                         }
                     }
                 }
             }
             catch (Exception ec)
             {
                 CLogger.LogError("Error While SaveActiveDirectoryUsers in WebService", ec);
             }
             return rcode;
         }

         public string GetConfigValue(string configKey, int orgID)
         {
             string configValue = string.Empty;
             long returncode = -1;
             GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
             List<Config> lstConfig = new List<Config>();

             returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
             if (lstConfig.Count > 0)
                 configValue = lstConfig[0].ConfigValue;

             return configValue;
         }

         #endregion
    /* END | Velmurugan | 20201130 | Dev | Active Directory */
	
	    #region DynamicInvValues
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList DynamicInvValues(DateTime Fdate, DateTime Tdate, string VisitNo,long GroupID, string Param1, string Param2, string Param3, string Param4, long Param5)
    {
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        ArrayList OutArray = new ArrayList();
        DataSet lstOutDataSet = new DataSet();
        DataTable dt = new DataTable();
        DataTable dt1 = new DataTable();

        try
        {
            lstOutDataSet = new Investigation_BL(new BaseClass().ContextInfo).DynamicInvValues(Fdate, Tdate, VisitNo,GroupID, Param1, Param2, Param3, Param4, Param5);
            dt = lstOutDataSet.Tables[0];
            //dt.Columns.Remove("Rowid");
            Dictionary<string, object> row;

            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            Dictionary<string, object> row1;

            List<Dictionary<string, object>> rows1 = new List<Dictionary<string, object>>();
            if (lstOutDataSet.Tables.Count > 1)
            {
                dt1 = lstOutDataSet.Tables[1];

                foreach (DataRow dr in dt1.Rows)
                {
                    row1 = new Dictionary<string, object>();
                    foreach (DataColumn col in dt1.Columns)
                    {
                        row1.Add(col.ColumnName, dr[col]);
                    }
                    rows1.Add(row1);
                }
            }
            OutArray.Add(oJavaScriptSerializer.Serialize(rows));
            OutArray.Add(oJavaScriptSerializer.Serialize(rows1));
            OutArray.Add(totalRows);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService RenderingReport Message:", ex);
        }
        return OutArray;
    }
    #endregion

     [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public bool SaveInvValuesCovidReport(string JsonStringData,long GroupID, string Param1,string Param2,string Param3,string Param4,long Param5)
    {
        try
        {
            JavaScriptSerializer o = new JavaScriptSerializer();
            List<InvValuesforCovidReport> historyMappingLst = o.Deserialize<List<InvValuesforCovidReport>>(JsonStringData);
            if (historyMappingLst.Count > 0)
            {
                //Investigation_BL oBL = new Investigation_BL(new BaseClass().ContextInfo = new ContextDetails());
                long resultCode = new Investigation_BL(new BaseClass().ContextInfo).SaveInvValuesforCovidReport(historyMappingLst,GroupID, Param1, Param2, Param3, Param4, Param5);

                if (resultCode != -1)
                    return true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveInvValuesCovidReport:", ex);
            return false;
        }

        return false;
    }
    //arun changes
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList CovidBulkSRFIDUpload(string fulupload, int Fromdata, int ToData)
    {
        ArrayList fileUpload = new ArrayList();
        //fulupload = "C:\\Users\\Thiyagu\\Desktop\\Reg.xls";


        string Conne = "";
        List<string> objSheet = new List<string>();
        List<BulkRegistrationDetails> brd = new List<BulkRegistrationDetails>();
        BulkRegistrationDetails BulkReg;
        OleDbConnection con;
        DataTable objStockReceived;
        OleDbDataAdapter adp;
        OleDbCommand cmd;
        int count = 0, tmpcount = 0;

        string filename = "";
        Conne = GetConnection(fulupload, out objSheet, out filename);

        try
        {
            if (Conne != "")
            {
				 string item =objSheet != null ? objSheet[0]: "";
                // foreach (string item in objSheet)
                // {
                    try
                    {
                        objStockReceived = new DataTable();
                        con = new OleDbConnection(Conne);
                        con.Open();
                       // adp = new OleDbDataAdapter("select * from [" + item + "] where SlNo>" + Fromdata + " and SlNo<=" + ToData + "", con); //where Sl. No>" + Fromdata + " and Sl. No<=" + ToData + "
					   adp = new OleDbDataAdapter("select * from [" + item + "] ", con);
                        adp.Fill(objStockReceived);
                        cmd = new OleDbCommand("Select count(1) from [" + item + "]", con);
                        tmpcount = (int)cmd.ExecuteScalar();
                        int pat = 1;
                        con.Close();
                        if (objStockReceived.Rows.Count == 0)
                        {
                            int a = -1;
                            fileUpload.Add(a);
                        }
                        if (objStockReceived.Columns.Count > 0)
                        {
                            int serialno = 1;
                            foreach (DataRow dr in objStockReceived.Rows)
                            {
								//if any empty row is present means it should not consider
								if (!(dr[6] == DBNull.Value) && !(string.IsNullOrEmpty(dr[6].ToString().Trim())))
                                {
									BulkReg = new BulkRegistrationDetails();
									BulkReg.SlNo = Convert.ToInt32(serialno);
									serialno = serialno + 1;

									BulkReg.Name = Convert.ToString(dr[1]);
									BulkReg.Sex = Convert.ToString(dr[2]);
									//                                     BulkReg.DOB = Convert.ToString(dr[4]);
									BulkReg.Age = Convert.ToString(dr[3]);
									BulkReg.MobileNo = Convert.ToString(dr[4]);
									BulkReg.EmployeeID = Convert.ToString(dr[5]);//MRN Number
									BulkReg.PatientNumber = Convert.ToString(dr[6]);//Visit number
									string pdate = Convert.ToString(dr[7]);//visit date
									if (pdate != "")
									{
										DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
										pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
									}
									BulkReg.PDate = pdate;
									BulkReg.SourceType = Convert.ToString(dr[8]);//srfid (y/n)
									BulkReg.HealthHubID = Convert.ToString(dr[9]);//srfid
									brd.Add(BulkReg);
									pat++;
								}
                            }
                            count = tmpcount + count;


                        }
                    }
                    catch (Exception ex)
                    {
                        CLogger.LogError("Error while importing CovidBulkSRFIDUpload excel", ex);
                    }

                    //                     }

                //}

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generat CovidBulkSRFIDUpload XLS Sheet ", ex);
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
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList ValidateBulkSRFIDUpload(string list)
    {
        long returncode = -1;
        ArrayList ValBulkReg = new ArrayList();
        List<CampDetails> brd = new List<CampDetails>();
        List<CampDetails> lstCamp = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        int count = 0;
        try
        {
            brd = oSerializer.Deserialize<List<CampDetails>>(list);
            if (brd != null && brd.Count > 0)
            {
                foreach (var item in brd)
                {
                    var agetype = "";
                    var ages = item.Age.Split(' ').ToList();
                    if (ages != null && ages.Count > 0)
                    {
                        item.Age = ages[0];
                        item.AgeType = ages[1];
                    }
                    else
                    {
                        item.Age = "";
                        item.AgeType = "";
                    }
                    item.DispatchMode = "ValidateBulkSRFIDUpload";
                    item.SDate = item.PDate;
                    item.DOB = item.PDate;
                }
            }
            returncode = new FileUploadManager(new BaseClass().ContextInfo).ValidateCovidBulkRegistrationDetails(brd, out lstCamp);
            count = lstCamp.Count;
            lstCamp.ForEach(x =>
            {
                x.PDate = Convert.ToDateTime(x.PDate).ToString("dd/MM/yyyy hh:mm tt");
                x.SDate = Convert.ToDateTime(x.SDate).ToString("dd/MM/yyyy hh:mm tt");
                x.DOB = Convert.ToDateTime(x.DOB).ToString("dd/MM/yyyy");
            });
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while importing ValidateBulkSRFIDUpload excel", ex);
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
    public List<CampDetails> SaveBulkSRFIDUpload(string list)
    {
        long returncode = -1;
        List<CampDetails> lstinsertCampDetail = new List<CampDetails>();        
        CampDetails entlstTestCamp;
        List<CampDetails> lstresult = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        try
        {            
            CampDetails[] lstCamp = oSerializer.Deserialize<CampDetails[]>(list);
            if (lstCamp.Length > 0)
            {
                foreach (var lst in lstCamp)
                {
                    entlstTestCamp = new CampDetails();
                    entlstTestCamp.Id = lst.Id;                    
                    entlstTestCamp.SlNo = lst.SlNo;
                    entlstTestCamp.PDate = lst.PDate;
                    entlstTestCamp.SDate = lst.PDate;
                    entlstTestCamp.Name = lst.Name;
                    entlstTestCamp.DOB = lst.PDate;
                    entlstTestCamp.Age = lst.Age;
                    entlstTestCamp.AgeType = lst.AgeType;
                    entlstTestCamp.Sex = lst.Sex;
                    entlstTestCamp.DispatchMode = "SaveBulkSRFIDUpload";
                    entlstTestCamp.MobileNo = lst.MobileNo;
                    if (lst.PatientNumber != "--")
                    {
                        entlstTestCamp.PatientNumber = lst.PatientNumber;
                    }
                    else
                    {
                        entlstTestCamp.PatientNumber = "--";
                    }
                    entlstTestCamp.ErrorStatus = lst.ErrorStatus;
                    entlstTestCamp.HealthHubID = lst.HealthHubID;
                    entlstTestCamp.EmployeeID = lst.EmployeeID;
                    entlstTestCamp.SourceType = lst.SourceType;                    
                    lstinsertCampDetail.Add(entlstTestCamp);
                }
            }
            returncode = new FileUploadManager(new BaseClass().ContextInfo).SaveCovidPatientDetails(lstinsertCampDetail, out lstresult);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SaveBulkSRFIDUpload", ex);
        }
        finally
        {
        }
        return lstresult;
    }
    //arun changes
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList CovidBulkRegistration(string fulupload, int Fromdata, int ToData)
    {
        ArrayList fileUpload = new ArrayList();
        //fulupload = "C:\\Users\\Thiyagu\\Desktop\\Reg.xls";


        string Conne = "";
        List<string> objSheet = new List<string>();
        List<BulkRegistrationDetails> brd = new List<BulkRegistrationDetails>();
        BulkRegistrationDetails BulkReg;
        OleDbConnection con;
        DataTable objStockReceived;
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
                    if (item == "ARegistrations$")
                    {
                        try
                        {
                            objStockReceived = new DataTable();
                            con = new OleDbConnection(Conne);
                            con.Open();
                            adp = new OleDbDataAdapter("select * from [" + item + "] where SlNo>" + Fromdata + " and SlNo<=" + ToData + "", con); //where Sl. No>" + Fromdata + " and Sl. No<=" + ToData + "
                            adp.Fill(objStockReceived);
                            cmd = new OleDbCommand("Select count(1) from [" + item + "]", con);
                            tmpcount = (int)cmd.ExecuteScalar();
                            int pat = 1;
                            con.Close();
                            if (objStockReceived.Rows.Count == 0)
                            {
                                int a = -1;
                                fileUpload.Add(a);
                            }
                            if (objStockReceived.Columns.Count == 30)
                            {
                                foreach (DataRow dr in objStockReceived.Rows)
                                {
                                    //if (Convert.ToString(dr[0]) == "")
                                    //    break;
                                    // if (Convert.ToString(dr[2]) == "")
                                    //     BulkReg.PDate = "01-01-1900";

                                    //  if (Convert.ToString(dr[3]) == "")
                                    //     BulkReg.SDate = "01-01-1900";
                                    BulkReg = new BulkRegistrationDetails();
                                    BulkReg.SlNo = Convert.ToInt32(dr[0]);

                                    BulkReg.OrgName = Convert.ToString(dr[1]);
                                    BulkReg.Location = Convert.ToString(dr[2]);
                                    string pdate = Convert.ToString(dr[3]);
                                    if (pdate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.PDate = pdate;
                                    pdate = Convert.ToString(dr[4]);
                                    if (pdate != "")
                                    {
                                        DateTime dtime = DateTime.ParseExact(pdate, "dd/MM/yyyy HH:mm:ss", CultureInfo.CurrentCulture);
                                        pdate = dtime.ToString("dd/MM/yyyy hh:mm tt");
                                    }
                                    BulkReg.SDate = pdate;
                                    BulkReg.PatientNumber = Convert.ToString(dr[5]);
                                    BulkReg.HealthHubID = Convert.ToString(dr[6]);
                                    BulkReg.EmployeeID = Convert.ToString(dr[7]);
                                    BulkReg.SourceType = Convert.ToString(dr[8]);
                                    BulkReg.Title = Convert.ToString(dr[9]);
                                    BulkReg.Name = Convert.ToString(dr[10]);
                                    BulkReg.DOB = Convert.ToString(dr[11]);
                                    BulkReg.Age = Convert.ToInt32(Math.Round(Convert.ToDecimal(dr[12]), 0, MidpointRounding.ToEven)).ToString();
                                    //BulkReg.Age = Convert.ToString(dr[12]);
                                    BulkReg.AgeType = Convert.ToString(dr[13]);
                                    BulkReg.Sex = Convert.ToString(dr[14]);
                                    BulkReg.TestRequested = Convert.ToString(dr[15]);
                                    if (Convert.ToString(dr[16]) == "")
                                        BulkReg.AmountPaid = 0;
                                    else
                                        BulkReg.AmountPaid = Convert.ToDecimal(dr[16]);

                                    if (Convert.ToString(dr[17]) == "")
                                        BulkReg.AmountDiscount = 0;
                                    else
                                        BulkReg.AmountDiscount = Convert.ToDecimal(dr[17]);

                                    BulkReg.ClientCode = Convert.ToString(dr[18]);
                                    BulkReg.SCollectedBy = Convert.ToString(dr[19]);
                                    BulkReg.MobileNo = Convert.ToString(dr[20]);
                                    BulkReg.EmailId = Convert.ToString(dr[21]);
                                    BulkReg.DispatchMode = Convert.ToString(dr[22]);
                                    BulkReg.Doctor = Convert.ToString(dr[23]);
                                    BulkReg.RefHospital = Convert.ToString(dr[24]);
                                    BulkReg.History = Convert.ToString(dr[25]);
                                    BulkReg.Remarks = Convert.ToString(dr[26]);
                                    BulkReg.BookingID = Convert.ToString(dr[27]);
                                    BulkReg.ExternalRefNo = Convert.ToString(dr[28]);
                                    BulkReg.SampleNumber = Convert.ToString(dr[29]);

                                    BulkReg.PatId = Convert.ToString(pat);
                                    BulkReg.Priority = "Normal";
                                    BulkReg.Charged = 0;
                                    BulkReg.DiscountReason = "";
                                    BulkReg.DiscountAuthorisedBy = "";
                                    BulkReg.CreatedBy = "";

                                    BulkReg.ValidateData = "";
                                    brd.Add(BulkReg);
                                    pat++;
                                }
                                count = tmpcount + count;


                            }
                        }
                        catch (Exception ex)
                        {
                            CLogger.LogError("Error while importing CovidBulkRegistration excel", ex);
                        }

                    }

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generat CovidBulkRegistration XLS Sheet ", ex);
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
	    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public ArrayList ValidateCovidBulkRegistrationDetails(string list)
    {
        long returncode = -1;
        ArrayList ValBulkReg = new ArrayList();
        List<CampDetails> brd = new List<CampDetails>();
        List<CampDetails> lstCamp = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        int count = 0;
        try
        {
            brd = oSerializer.Deserialize<List<CampDetails>>(list);
            returncode = new FileUploadManager(new BaseClass().ContextInfo).ValidateCovidBulkRegistrationDetails(brd, out lstCamp);
            count = lstCamp.Count;
            lstCamp.ForEach(x =>
            {
                x.PDate = Convert.ToDateTime(x.PDate).ToString("dd/MM/yyyy hh:mm tt");
                x.SDate = Convert.ToDateTime(x.SDate).ToString("dd/MM/yyyy hh:mm tt");
                x.DOB = Convert.ToDateTime(x.DOB).ToString("dd/MM/yyyy");
            });
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while importing ValidateCovidBulkRegistrationDetails excel", ex);
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
    public List<CampDetails> SaveCovidBulkRegistrationDetails(string list, string Testlist)
    {
        long returncode = -1;
        List<CampDetails> lstinsertCampDetail = new List<CampDetails>();
        // List<TestDetails> lstTestCamp = new List<TestDetails>();
        CampDetails entlstTestCamp;
        List<CampDetails> lstresult = new List<CampDetails>();
        string RegList = string.Empty;
        JavaScriptSerializer oSerializer = new JavaScriptSerializer();
        try
        {
            // lstCamp = oSerializer.Deserialize<List<CampDetails>>(list);
            CampDetails[] lstCamp = oSerializer.Deserialize<CampDetails[]>(list);
            TestDetails[] lstTestCamp = oSerializer.Deserialize<TestDetails[]>(Testlist);
            if (lstCamp.Length > 0 && lstTestCamp.Length > 0)
            {
                foreach (var lst in lstCamp)
                {
                    foreach (var item in lstTestCamp)
                    {
                        if (lst.Id == item.Id)
                        {
                            entlstTestCamp = new CampDetails();
                            entlstTestCamp.Id = lst.Id;

                            entlstTestCamp.OrgName = lst.OrgName;
                            entlstTestCamp.SlNo = lst.SlNo;
                            entlstTestCamp.PDate = lst.PDate;
                            entlstTestCamp.SDate = lst.SDate;
                            entlstTestCamp.SCollectedBy = lst.SCollectedBy;
                            entlstTestCamp.PatId = lst.PatId;// Convert.ToString(from lc in lstCamp select lc.PatId);
                            entlstTestCamp.Title = lst.Title;// Convert.ToString(from lc in lstCamp select lc.Title);
                            entlstTestCamp.Name = lst.Name;// Convert.ToString(from lc in lstCamp select lc.Name);
                            entlstTestCamp.DOB = lst.DOB;
                            entlstTestCamp.Age = lst.Age;
                            entlstTestCamp.AgeType = lst.AgeType;// Convert.ToString(from lc in lstCamp select lc.AgeType);
                            entlstTestCamp.Sex = lst.Sex;// Convert.ToString(from lc in lstCamp select lc.Sex);
                            entlstTestCamp.Location = lst.Location; //Convert.ToString(from lc in lstCamp select lc.Location);
                            entlstTestCamp.Doctor = lst.Doctor;// Convert.ToString(from lc in lstCamp select lc.Doctor);
                            entlstTestCamp.RefHospital = lst.RefHospital;// Convert.ToString(from lc in lstCamp select lc.RefHospital);
                            entlstTestCamp.Priority = lst.Priority;// Convert.ToString(from lc in lstCamp select lc.Priority);
                            entlstTestCamp.DispatchMode = lst.DispatchMode;// Convert.ToString(from lc in lstCamp select lc.DispatchMode);
                            entlstTestCamp.AmountPaid = lst.AmountPaid;// Convert.ToDecimal(from lc in lstCamp select lc.AmountPaid);
                            entlstTestCamp.AmountDiscount = lst.AmountDiscount;// Convert.ToDecimal(from lc in lstCamp select lc.AmountDiscount);
                            entlstTestCamp.DiscountReason = lst.DiscountReason;// Convert.ToString(from lc in lstCamp select lc.DiscountReason);
                            entlstTestCamp.DiscountAuthorisedBy = lst.DiscountAuthorisedBy;// Convert.ToString(from lc in lstCamp select lc.DiscountAuthorisedBy);
                            entlstTestCamp.History = lst.History;// Convert.ToString(from lc in lstCamp select lc.History);
                            entlstTestCamp.Remarks = lst.Remarks;// Convert.ToString(from lc in lstCamp select lc.Remarks);
                            entlstTestCamp.MobileNo = lst.MobileNo;// Convert.ToString(from lc in lstCamp select lc.MobileNo);
                            entlstTestCamp.CreatedBy = lst.CreatedBy;// Convert.ToString(from lc in lstCamp select lc.CreatedBy);
                            entlstTestCamp.ClientCode = lst.ClientCode;// Convert.ToString(from lc in lstCamp select lc.ClientCode);
                            entlstTestCamp.EmailId = lst.EmailId;// Convert.ToString(from lc in lstCamp select lc.EmailId);
                            if (lst.PatientNumber != "--")
                            {
                                entlstTestCamp.PatientNumber = lst.PatientNumber;
                            }
                            else
                            {
                                entlstTestCamp.PatientNumber = "--";
                            }
                            entlstTestCamp.ErrorStatus = lst.ErrorStatus;// Convert.ToBoolean(from lc in lstCamp select lc.ErrorStatus);
                            entlstTestCamp.ClientID = lst.ClientID;// Convert.ToInt64(from lc in lstCamp select lc.ClientID);
                            entlstTestCamp.LocationID = lst.LocationID;// Convert.ToInt64(from lc in lstCamp select lc.LocationID);
                            entlstTestCamp.TitleID = lst.TitleID;// Convert.ToInt64(from lc in lstCamp select lc.TitleID);
                            entlstTestCamp.DoctorID = lst.DoctorID;// Convert.ToInt64(from lc in lstCamp select lc.DoctorID);
                            entlstTestCamp.RefHospitalID = lst.RefHospitalID;// Convert.ToInt64(from lc in lstCamp select lc.RefHospitalID);
                            entlstTestCamp.SCollectedByID = lst.SCollectedByID;// Convert.ToInt64(from lc in lstCamp select lc.SCollectedByID);
                            entlstTestCamp.PriorityID = lst.PriorityID;// Convert.ToInt32(from lc in lstCamp select lc.PriorityID);
                            entlstTestCamp.IsClientPatient = lst.IsClientPatient;// Convert.ToString(from lc in lstCamp select lc.IsClientPatient);
                            entlstTestCamp.CreatedbyId = lst.CreatedbyId;// Convert.ToInt64(from lc in lstCamp select lc.CreatedbyId);
                            entlstTestCamp.IsDiscountable = item.IsDiscountable;// Convert.ToString(from lc in lstCamp select lc.IsDiscountable);
                            entlstTestCamp.DueAmount = lst.DueAmount;// Convert.ToDecimal(from lc in lstCamp select lc.DueAmount);
                            entlstTestCamp.OrgId = lst.OrgId;// Convert.ToInt32(from lc in lstCamp select lc.OrgId);
                            entlstTestCamp.DiscountAuthorisedByID = lst.DiscountAuthorisedByID;// Convert.ToInt64(from lc in lstCamp select lc.DiscountAuthorisedByID);
                            entlstTestCamp.HasHealthCoupon = lst.HasHealthCoupon;// Convert.ToString(from lc in lstCamp select lc.HasHealthCoupon);
                            entlstTestCamp.MyCardActiveDays = lst.MyCardActiveDays;// Convert.ToString(from lc in lstCamp select lc.MyCardActiveDays);
                            entlstTestCamp.IsCreditBill = lst.IsCreditBill;//Convert.ToString(from lc in lstCamp select lc.IsCreditBill);
                            entlstTestCamp.TestRequested = item.TestRequested;
                            entlstTestCamp.Charged = item.Charged;
                            entlstTestCamp.ErrorDesc = item.ErrorDesc;
                            entlstTestCamp.TestCode = item.TestCode;
                            entlstTestCamp.RateId = item.RateId;
                            entlstTestCamp.TestType = item.TestType;
                            entlstTestCamp.FeeId = item.FeeId;
                            entlstTestCamp.CampId = item.CampId;
                            entlstTestCamp.HealthHubID = lst.HealthHubID;
                            entlstTestCamp.EmployeeID = lst.EmployeeID;
                            entlstTestCamp.SourceType = lst.SourceType;
                            entlstTestCamp.BookingID = lst.BookingID;
                            entlstTestCamp.ExternalRefNo = lst.ExternalRefNo;
                            entlstTestCamp.SampleNumber = lst.SampleNumber;
                            lstinsertCampDetail.Add(entlstTestCamp);
                        }
                    }

                }
            }

            returncode = new FileUploadManager(new BaseClass().ContextInfo).SaveCovidPatientDetails(lstinsertCampDetail, out lstresult);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SaveCovidBulkRegistrationDetails", ex);
        }
        finally
        {
        }
        return lstresult;
    }
   
}
