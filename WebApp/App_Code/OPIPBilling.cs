using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
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
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Podium.PerformingNextAction;
using Microsoft.Reporting.WebForms;
/// <summary>
/// Summary description for OPIPBilling
/// </summary>
/// 
[WebService(Namespace = "http://Attunelive.Com/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class OPIPBilling : System.Web.Services.WebService
{
    string RemarksValue = string.Empty;

    public OPIPBilling()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    #region Quick Bill Patient Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuickBillPatientList(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1;
            int orgID = 0;
            string pVisitType = "";
            string Episode = "";
            int searchType = -1;
            string[] PatientList = null;
            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            Episode = contextKey.Split('~')[1];
            //pVisitType = contextKey.Split('~')[1] == "OP" ? "0" : "1";
            pVisitType = contextKey.Split('~')[1] == "OP" ? "0" : contextKey.Split('~')[1] == "IP" ? "1" : "2";
            searchType = Convert.ToInt32(contextKey.Split('~')[2]);
            items.Clear();
            if (searchType == 0 || searchType == 2)
            {
                if (prefixText.Length > 2)
                {
                    items = AutoCompleteMethod(prefixText, pVisitType, orgID, searchType, Episode);

                }
            }

            else
            {
                items = AutoCompleteMethod(prefixText, pVisitType, orgID, searchType, Episode);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }

    public List<string> AutoCompleteMethod(string prefixText, string pVisitType, int OrgID, int searchType, string Episode)
    {
        long retCode = -1;
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        string[] PatientList = null;
        List<string> items = new List<string>(lstPatient.Count);
        if (Episode != "DayCare")
        {
            retCode = PatBL.GetPatientListForQuickBill(prefixText, pVisitType, OrgID, searchType, out lstPatient);
            if (lstPatient.Count > 0)
            {
                PatientList = new string[lstPatient.Count];
                for (int i = 0; i < lstPatient.Count; i++)
                {
                    string KeyVal = lstPatient[i].Name;
                    string value = lstPatient[i].Comments;
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));

                }

            }

        }

        else
        {

            retCode = PatBL.GetPatientListForQuickBill(prefixText, pVisitType, OrgID, searchType, out lstPatient);
            List<Patient> lstTempPatients = (from S in lstPatient
                                             group S by new { S.PatientID, S.Name, S.Comments } into g
                                             select new Patient
                                             {
                                                 PatientID = g.Key.PatientID,
                                                 Name = g.Key.Name,
                                                 Comments = g.Key.Comments
                                             }).Distinct().ToList();

            string episodes = "";
            for (int i = 0; i < lstTempPatients.Count; i++)
            {
                string KeyVal = lstTempPatients[i].Name;
                string values = lstTempPatients[i].Comments;
                episodes = getProductValues(lstPatient.FindAll(P => P.PatientID == lstTempPatients[i].PatientID));
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, values + '|' + episodes));

            }

        }

        return items.ToList<string>();

    }


    public string getProductValues(List<Patient> iim)
    {
        string val = "";
        //iim.OrderBy(p => p.ExpiryDate);
        foreach (Patient item in iim)
        {
            val += item.AliasName + "^";
        }

        return val;
    }


    #endregion


    #region Get Quick Bill Items

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuickBillItems(string prefixText, int count, string contextKey)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBFD = new List<BillingFeeDetails>();
        try
        {
            string desc = prefixText;
            long lresutl = -1;
            int orgID = 0;
            long RateID = 0;
            long VisitID = 0;
            string feeType = string.Empty;
            string vType = string.Empty;
            string IsMappedItem = string.Empty;
            string BillPage = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(strValue[1], out orgID);
            Int64.TryParse(strValue[2], out RateID);
            Int64.TryParse(strValue[4], out VisitID);
            feeType = strValue[0].ToUpper();
            vType = strValue[3].ToUpper();
            IsMappedItem = strValue[5].ToUpper();
            BillPage = strValue[6].ToUpper();
            lresutl = be.GetQuickBillItems(orgID, feeType, desc, 1, out lstBFD, RateID, vType, VisitID, IsMappedItem, BillPage);
            if (lstBFD.Count > 0)
            {
                if (BillPage == "MGRATES")
                {
                    foreach (BillingFeeDetails item in lstBFD)
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ID.ToString()));
                    }
                }
                else
                {
                    foreach (BillingFeeDetails item in lstBFD)
                    {
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return items.ToArray();
    }

    #endregion

    #region Get Procedure Status

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetProcedureStatus(int OrgID, long PatientID, string contextKey)
    {
        Patient_BL objPat = new Patient_BL(new BaseClass().ContextInfo);
        string strStatus = string.Empty;
        List<Patient> lstPatient = new List<Patient>();
        try
        {
            long ProcedureID = -1;
            long retCode = -1;
            string[] strValue = contextKey.Split('~');
            Int64.TryParse(strValue[0], out ProcedureID);
            retCode = objPat.GetProcedureStatus(OrgID, PatientID, ProcedureID, out lstPatient);
            if (lstPatient.Count > 0)
            {
                strStatus = lstPatient[0].Status.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }
        return strStatus;
    }

    #endregion

    #region Advance Paid Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<AdvancePaidDetails> loadPatientAdvanceDetails(long patientVisitID, long patientID, long orgID)
    {
        List<AdvancePaidDetails> lstAdvancePaidDetails = new List<AdvancePaidDetails>();
        try
        {

            AdvancePaid_BL objPaidBl = new AdvancePaid_BL(new BaseClass().ContextInfo);
            decimal dAmount = 0;
            objPaidBl.GetAdvancePaidDetails(patientVisitID, out lstAdvancePaidDetails, out dAmount);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetAdvancePaidDetails Message:", ex);
        }
        return lstAdvancePaidDetails;

    }
    #endregion


    #region Get Due Details For Inpatient
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientDueDetails> InpatientDueDetails(long PatientID, long visitID, int OrgID)
    {
        List<PatientDueDetails> lstDueDetail = new List<PatientDueDetails>();

        try
        {

            BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
            billingEngineBL.GetInpatientDueDetails(PatientID, visitID, OrgID, out lstDueDetail);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InpatientDueDetails Message:", ex);
        }
        return lstDueDetail;
    }
    #endregion

    #region Get snapShot for billDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<FinalBill> GetBillSnapShot(long PatientID, long visitID, int OrgID)
    {
        List<FinalBill> lstDueDetail = new List<FinalBill>();

        try
        {

            BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
            billingEngineBL.GetBillSnapShot(PatientID, visitID, OrgID, out lstDueDetail);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InpatientDueDetails Message:", ex);
        }
        return lstDueDetail;
    }
    #endregion


    #region Get Due Details For Users
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<FinalBill> loadWebDueDetail(long orgID, long patientID, long patientVisitID)
    {
        List<FinalBill> lstDueDetail = new List<FinalBill>();
        try
        {

            string VisitType = "";
            long finalBillID = 0;
            FinalBill fb = new FinalBill();
            BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
            billingEngineBL.GetDueDetails(orgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out VisitType);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lstDueDetail Message:", ex);
        }
        return lstDueDetail;
    }
    #endregion

    #region Get Surgery Advance
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientDueChart> LoadSurgeryDetailForAdvance(long patientVisitID)
    {
        List<PatientDueChart> lstSurgeryDetailForAdvance = new List<PatientDueChart>();
        try
        {
            IP_BL ipBL = new IP_BL(new BaseClass().ContextInfo);
            ipBL.BindSurgeryDetailForAdvanceByVisitID(patientVisitID, out lstSurgeryDetailForAdvance);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSurgeryDetailForAdvance Message:", ex);
        }
        return lstSurgeryDetailForAdvance;

    }
    #endregion


    #region Get Patient Payment Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<FinalBill> LoadPatientPaymentDetails(long patientVisitID, long patientID, int orgID)
    {
        List<FinalBill> lstPatientPaymentDetails = new List<FinalBill>();
        try
        {
            BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
            be.GetPatientPaymentDetails(patientVisitID, patientID, orgID, out lstPatientPaymentDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lstPatientPaymentDetails Message:", ex);
        }
        return lstPatientPaymentDetails;

    }
    #endregion

    #region Quick Bill Patient Search (SmartCard)
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuickBillPatientListSmartCard(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL PatBL = new Patient_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1;
            int orgID = 0;
            string pVisitType = "";

            string[] PatientList = null;
            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            pVisitType = contextKey.Split('~')[1] == "OP" ? "0" : "1";
            retCode = PatBL.GetPatientListForQuickBillSmartCard(prefixText, orgID, out lstPatient);

            items.Clear();
            if (lstPatient.Count > 0)
            {
                PatientList = new string[lstPatient.Count];
                for (int i = 0; i < lstPatient.Count; i++)
                {
                    string KeyVal = lstPatient[i].Name;
                    string value = lstPatient[i].Comments;
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }




    #endregion

    #region Deposit Usage
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientDepositHistory> GetPatientDepositDetails(long pPatientID, int OrgID)
    {
        List<PatientDepositHistory> lstPDH = new List<PatientDepositHistory>();
        try
        {
            AdvancePaid_BL objapdBL = new AdvancePaid_BL(new BaseClass().ContextInfo);

            decimal TotalDepositAmount = 0;
            decimal TotalDepositUsed = 0;
            decimal TotalRefundAmount = 0;
            objapdBL.GetPatientDepositDetails(pPatientID, OrgID, out lstPDH, out TotalDepositAmount, out TotalDepositUsed, out TotalRefundAmount);
            PatientDepositHistory obj = new PatientDepositHistory();
            obj.AmountDeposited = TotalDepositAmount;
            obj.PaidCurrencyAmount = TotalDepositUsed;
            lstPDH.Add(obj);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientDepositDetails Message:", ex);
        }

        return lstPDH;
    }




    #endregion


    #region Performing Physician Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPerformingPhysicianList(string prefixText, int count, string contextKey)
    {
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        List<string> items = new List<string>();
        // string[] phyNameArray = null;
        long lresutl = -1;

        int orgID = 0;
        string pType = "PER";

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        //  , OrgAddressID, pharmacyLocationID);
        lresutl = patBL.GetPhysicianByType(prefixText, orgID, pType, out lstPhysician);
        if (lstPhysician.Count > 0)
        {
            foreach (Physician item in lstPhysician)
            {
                item.PhysicianID = Convert.ToInt32(item.PhysicianName.Split('~')[0]);
                item.PhysicianName = item.PhysicianName.Split('~')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.PhysicianName, item.PhysicianID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion



    //#region GetDispenseDrug
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<BillingDetails> GetDispenseDrug(long PatientID)
    //{
    //    List<BillingDetails> lstDrugDetails = new List<BillingDetails>();
    //    try
    //    {
    //        long returncode = -1;

    //        returncode = new Inventory_BL(new BaseClass().ContextInfo).GetDispenseDrug(PatientID, DateTime.Now, DateTime.Now, out lstDrugDetails);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in GetDispenseDrug Message:", ex);
    //    }
    //    return lstDrugDetails;
    //}
    //#endregion

    #region Get RateCard For Billing
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetRateCardForBilling(string prefixText, string contextKey)
    {
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstInvs = new List<InvClientMaster>();
        List<string> items = new List<string>();
        long lresutl = -1;
        int orgID = 0;
        int refhospid = 0;
        string pType = string.Empty;
        if (contextKey.Contains("^"))
        {
            string[] GetContextKey = contextKey.Split('^');
            pType = GetContextKey[0];
            Int32.TryParse(GetContextKey[1].ToString(), out orgID);
            Int32.TryParse(GetContextKey[2].ToString(), out refhospid);


        }
        else
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            pType = contextKey;
        }


        lresutl = BillingBl.GetRateCardForBilling(prefixText, orgID, pType, refhospid, out lstInvs);
        if (lstInvs.Count > 0)
        {
            foreach (InvClientMaster item in lstInvs)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ClientName, item.Value.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion

    #region Get Disount Limit
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<FinalBill> GetDiscountLimit(string ReferType, string ReferID, int orgID)
    {
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        try
        {
            long returnCode = -1;
            long pReferID = -1;
            pReferID = Convert.ToInt64(ReferID);
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetDiscountLimit(ReferType, pReferID, orgID, out lstFinalBill);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetDiscountLimit Message:", ex);
        }
        return lstFinalBill;
    }
    //syed
    #endregion

    #region Lab Quick Bill Patient Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetLabQuickBillPatientList(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;
            if (contextKey != null && contextKey != "")
            {
                Int32.TryParse(contextKey.Split('~')[0], out orgID);
                Int64.TryParse(contextKey.Split('~')[1], out PatientID);
                Int32.TryParse(contextKey.Split('~')[2], out searchType);
                pVisitType = "0";
                items.Clear();
                retCode = bbl.GetLabQuickBillPatientList(prefixText, pVisitType, orgID, searchType, PatientID, out lstPatient);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }

    //Lab Quick Bill Patient Search for quantum
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetLabQuickBillPatientList_Quantum(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        ContextDetails Con = new ContextDetails();
        Con = new BaseClass().ContextInfo;
        if (contextKey.Split('~').Count() > 4)
        {
            Con.AdditionalInfo = contextKey.Split('~')[4];

        }

        BillingEngine bbl = new BillingEngine(Con);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;
            string ExtVisitID = string.Empty;
            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            Int64.TryParse(contextKey.Split('~')[1], out PatientID);
            Int32.TryParse(contextKey.Split('~')[2], out searchType);
            if ((contextKey.Split('~').Length > 3) && (!string.IsNullOrEmpty(contextKey.Split('~')[3])))
            {
                ExtVisitID = contextKey.Split('~')[3];
            }
            pVisitType = "0";
            items.Clear();
            retCode = bbl.GetLabQuickBillPatientList_Quantum(prefixText, pVisitType, orgID, searchType, PatientID, ExtVisitID, out lstPatient);
            if (lstPatient.Count > 0)
            {
                PatientList = new string[lstPatient.Count];
                for (int i = 0; i < lstPatient.Count; i++)
                {
                    string[] name = lstPatient[i].Name.Split(':');
                    string[] comments = lstPatient[i].Comments.Split('~');
                    string KeyVal = name[0];
                    string value = lstPatient[i].Comments;
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
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
    public string[] GetQuickPatientSearch(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            //string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;
            long pClientID = 0;
            //if (!String.IsNullOrEmpty(PatientClientID) && Convert.ToInt64(PatientClientID) > 0)
            //{
            //    pClientID = Convert.ToInt64(PatientClientID);
            //}
            if (contextKey != null && contextKey != "")
            {
                Int32.TryParse(contextKey.Split('~')[0], out orgID);
                Int64.TryParse(contextKey.Split('~')[1], out PatientID);
                Int32.TryParse(contextKey.Split('~')[2], out searchType);
                //pVisitType = "0";
                items.Clear();
                //  retCode = bbl.GetLabQuickBillPatientList(prefixText, pVisitType, orgID, searchType, PatientID, out lstPatient);
                retCode = bbl.GetQuickPatientSearch(searchType, prefixText, orgID, pClientID, out lstPatient);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }



    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Patient> GetQuickPatientSearchClient(string prefixText, int count, string contextKey, string PatientClientID)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            //string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;
            long pClientID=0;
            if (!String.IsNullOrEmpty(PatientClientID) && Convert.ToInt64(PatientClientID) > 0)
            {
                pClientID = Convert.ToInt64(PatientClientID);
            }
            if (contextKey != null && contextKey != "")
            {
                Int32.TryParse(contextKey.Split('~')[0], out orgID);
                Int64.TryParse(contextKey.Split('~')[1], out PatientID);
                Int32.TryParse(contextKey.Split('~')[2], out searchType);
                //pVisitType = "0";
                items.Clear();
                //  retCode = bbl.GetLabQuickBillPatientList(prefixText, pVisitType, orgID, searchType, PatientID, out lstPatient);
                retCode = bbl.GetQuickPatientSearch(searchType, prefixText, orgID, pClientID, out lstPatient);
                //if (lstPatient.Count > 0)
                //{
                //    PatientList = new string[lstPatient.Count];
                //    for (int i = 0; i < lstPatient.Count; i++)
                //    {
                //        string[] name = lstPatient[i].Name.Split('~');
                //        string KeyVal = name[0];
                //        string value = lstPatient[i].Comments;
                //        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return lstPatient;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuickPatientSearchDetails(long PatientID, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1;
            int orgID = 0;
            int searchType = 0;
            long PatientVisitID = 0;
            long HealthiAPIBookingID = 0;
            string[] PatientList = null;
            if (contextKey != null && contextKey != "")
            {
                Int32.TryParse(contextKey.Split(':')[0], out orgID);
                Int64.TryParse(contextKey.Split(':')[1], out PatientID);
                Int32.TryParse(contextKey.Split(':')[2], out searchType);
                Int64.TryParse(contextKey.Split(':')[3], out PatientVisitID);

                if (contextKey.Split(':').Count()>4)
                {
                    Int64.TryParse(contextKey.Split(':')[4], out HealthiAPIBookingID);
                }
				
                //retCode = bbl.GetQuickPatientSearchDetails(PatientID, orgID, searchType, out lstPatient);
                retCode = bbl.GetQuickPatientSearchDetails(PatientID, PatientVisitID, orgID, searchType, HealthiAPIBookingID, out lstPatient);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }
    #region RegistrationRepush
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<RegistrationRepush> RegistrationRepush(int OrgId)
    {
        List<RegistrationRepush> lstRegistrationRepush = new List<RegistrationRepush>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstRegistrationRepush.Count);
        try
        {
            long retCode = -1;
            retCode = bbl.RegistrationRepush(OrgId, out lstRegistrationRepush);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Registration-Repush Message:", ex);
        }

        return lstRegistrationRepush;
    }
    # endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] Getpatientsearch(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;

            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            if (contextKey.Contains('~'))
            {
                Int64.TryParse(contextKey.Split('~')[1], out PatientID);
                Int32.TryParse(contextKey.Split('~')[2], out searchType);
            }
            pVisitType = "0";
            items.Clear();
            retCode = bbl.GetLabQuickBillPatientList(prefixText, pVisitType, orgID, searchType, PatientID, out lstPatient);
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
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetLabQuickBillPatientListdetails(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        List<PhysioCompliant> lstPhysioCompliant = new List<PhysioCompliant>();
        List<PatientPreferences> lstPatientPreference = new List<PatientPreferences>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientID = -1;
            int orgID = 0;
            string pVisitType = "";
            int searchType = 0;
            string[] PatientList = null;
            string PatientPreference = string.Empty;
            var ICDValue = "";
            var ICDPreference = "";
            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            Int64.TryParse(contextKey.Split('~')[1], out PatientID);
            Int32.TryParse(contextKey.Split('~')[2], out searchType);
            pVisitType = "0";
            string KeyVal = "";
            string[] name = null;
            items.Clear();
            retCode = bbl.GetLabQuickBillPatientList(prefixText, pVisitType, orgID, searchType, PatientID, out lstPatient);

            if (lstPatient.Count > 0)
            {
                PatientList = new string[lstPatient.Count];
                for (int j = 0; j < lstPatient.Count; j++)
                {
                    if (lstPatient[j].Name.Contains('~'))
                    {
                        name = lstPatient[j].Name.Split('~');
                        KeyVal = name[0];
                        PatientID = Convert.ToInt32(name[1]);
                    }
                    else
                    {
                        KeyVal = lstPatient[j].Name;
                    }
                    string value = lstPatient[j].Comments;

                    new Patient_BL(new BaseClass().ContextInfo).GetPatientEMRDetails(PatientID, out lstPhysioCompliant, out lstPatientPreference);
                    int i = 110;
                    foreach (PhysioCompliant objPC in lstPhysioCompliant)
                    {
                        ICDValue += i + "~" + objPC.ComplaintName + "~" + objPC.ComplaintID + "~" + objPC.ICDCode + "~" + objPC.ICDDescription + "^";
                        i += 1;
                    }
                    foreach (PatientPreferences objPP in lstPatientPreference)
                    {
                        ICDPreference += objPP.PatientPreference + "~";
                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value + '|' + ICDValue + '|' + ICDPreference));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }
    #endregion


    #region Getsearchbatchid
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<ClientBatchMaster> Getsearchbatchid(int orgID,int Clientid, string batchid)
    {
        List<ClientBatchMaster> lstinvmasters = new List<ClientBatchMaster>();
        // int orgID = 0;
        // Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        try
        {
            long returncode = -1;

            returncode = new Master_BL(new BaseClass().ContextInfo).Getsearchbatchid(orgID, Clientid, batchid, out lstinvmasters);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstinvmasters;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<ClientBatchMaster> Insertpushingordereddetails(int orgID, string batchid)
    {
        List<ClientBatchMaster> lstinvmasters = new List<ClientBatchMaster>();
        


        try
        {
            long returncode = -1;

            returncode = new Master_BL(new BaseClass().ContextInfo).Insertpushingordereddetails(orgID, batchid,"", out lstinvmasters);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstinvmasters;
    }


    #region Getsearchclientbatchmaster
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<ClientBatchMasterDetails> Getsearchclientbatchmaster(int orgID, int Clientid, string clientcode, string batchid, string Fromdateb, string Todateb,string Status)
    {
        List<ClientBatchMasterDetails> lstinvmasters = new List<ClientBatchMasterDetails>();
       // int orgID = 0;
       // Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        DateTime Fromdate;
        DateTime Todate;
        if (Fromdateb != "")
        {
            DateTime.TryParse(Fromdateb, out Fromdate);
        }
        else
        {
            Fromdate = DateTime.Today.AddDays(-120); 
        }
        if (Todateb != "")
        {
            DateTime.TryParse(Todateb, out Todate);
        }
        else
        {
            Todate=DateTime.Today.AddDays(120);
        }


        try
        {
            long returncode = -1;

            returncode = new Master_BL(new BaseClass().ContextInfo).Getsearchclientbatchmaster(orgID, Clientid, clientcode, batchid,Fromdate,Todate, Status,out lstinvmasters);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstinvmasters;
    }
    #endregion

    #region GetStateByCountry
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<State> GetStateByCountry(int CountryID)
    {
        List<State> lstStates = new List<State>();
        try
        {
            long returncode = -1;

            returncode = new State_BL(new BaseClass().ContextInfo).GetStateByCountry(CountryID, out lstStates);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstStates;
    }
    #endregion


    #region GetPreviousVisitBilling
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Array> GetPreviousVisitBilling(long PatientID, long VisitID, string Type)
    {
        List<Array> Obj = new List<Array>();
        Array Obj1;//= new Array();
        Array Obj2;//= new Array();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetPreviousVisitBilling(PatientID,
            VisitID, Type, out lstBillingDetails, out lstPatientInvSample);
            Obj1 = lstBillingDetails.ToArray();
            Obj2 = lstPatientInvSample.ToArray();
            Obj.Add(Obj1);
            Obj.Add(Obj2);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return Obj;
    }
    #endregion

    #region Patient Already Registered
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public int CheckPatientforDuplicate(string patientName, string mobileNo, string llNo, int orgID, string patientNumber)
    {
        int Count = 0;
        new Patient_BL(new BaseClass().ContextInfo).CheckPatientforDuplicate(patientName, mobileNo, llNo, orgID, patientNumber, out Count);
        return Count;
    }
    #endregion
    #region Get Client Episode
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientEpisode(string prefixText, string contextKey)
    {
        List<string> str = new List<string>();
        string[] pvalue;
        pvalue = contextKey.Split('~');
        int OrgID = 0;
        long ClientID = 0;
        Int32.TryParse(pvalue[0], out OrgID);
        Int64.TryParse(pvalue[1], out ClientID);
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        new BillingEngine(new BaseClass().ContextInfo).GetClientEpisode(OrgID, ClientID, prefixText, out lstEpisodeVisitDetails);
        foreach (EpisodeVisitDetails item in lstEpisodeVisitDetails)
        {
            str.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.EpisodeName, item.Description));
        }
        return str.ToArray();
    }
    #endregion

    #region Get Patient Episode VisitDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<EpisodeVisitDetails> GetPatientEpisodeVisitDetails(long PatientID, long EpisodeID)
    {
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        new BillingEngine(new BaseClass().ContextInfo).GetPatientEpisodeVisitDetails(orgID, PatientID, EpisodeID, "", out lstEpisodeVisitDetails);
        return lstEpisodeVisitDetails;
    }
    #endregion


    #region GetClientChildDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientChildDetails(string prefixText, string contextKey)
    {
        List<string> str = new List<string>();
        string[] pvalue;
        pvalue = contextKey.Split('~');
        int OrgID = 0;
        long ClientID = 0;
        Int32.TryParse(pvalue[0], out OrgID);
        Int64.TryParse(pvalue[1], out ClientID);
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        new BillingEngine(new BaseClass().ContextInfo).GetClientChildDetails(OrgID, ClientID, prefixText, "", out lstEpisodeVisitDetails);
        foreach (EpisodeVisitDetails item in lstEpisodeVisitDetails)
        {
            str.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.EpisodeName, item.Description.ToString()));
        }
        return str.ToArray();
    }
    #endregion

    #region CheckClientCreditLimit
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string CheckClientCreditLimit(string CID)
    {
        string ClientStatusAndAmount = "";
        try
        {
            long returncode = -1;
            int OrgID = -1;
            long ClientID = Convert.ToInt64(CID);
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            string CreditStatus = "";
            Decimal BalanceAmount = -1;
            returncode = new Master_BL(new BaseClass().ContextInfo).CheckClientCreditLimit(ClientID, OrgID, out CreditStatus, out BalanceAmount);
            ClientStatusAndAmount = CreditStatus + '~' + BalanceAmount.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return ClientStatusAndAmount;
    }
    #endregion

    #region GetConsignmentNo
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetConsignmentNo(string prefixText, string contextKey)
    {
        List<string> str = new List<string>();
        string[] pvalue;
        pvalue = contextKey.Split('~');
        long EpisodeID = 0;
        long SiteID = 0;
        int OrgID = 0;
        string pType = "";
        string ConsignmentNo = prefixText;
        Int64.TryParse(pvalue[0], out EpisodeID);
        Int64.TryParse(pvalue[1], out SiteID);
        Int32.TryParse(pvalue[2], out OrgID);
        List<EpiContainerTracking> lstEpiContainerTracking = new List<EpiContainerTracking>();

        new BillingEngine(new BaseClass().ContextInfo).GetConsignmentNo(EpisodeID, SiteID, OrgID, pType, ConsignmentNo, out lstEpiContainerTracking);
        foreach (EpiContainerTracking item in lstEpiContainerTracking)
        {
            str.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.ConsignmentNo, item.AdditionalInfo + '^' + item.ClientName));
        }
        return str.ToArray();
    }
    #endregion

    #region GetInvestigationInfo
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvestigationValues> GetInvestigationInfo(long ID, string Type)
    {
        List<InvestigationValues> lstinvestigation = new List<InvestigationValues>();
        try
        {
            long returnCode = -1;
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetInvestigationInfo(ID, Type, orgID, out lstinvestigation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstinvestigation;
    }
    #endregion
    #region GetGroupInfo
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PatientInvestigation> GetGroupInfo(int pkgid, string Type)
    {
        List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
        try
        {
            long returnCode = -1;
            int OrgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            string GroupName = string.Empty;
            List<InvPackageMapping> lstPackageMapping = new List<InvPackageMapping>();
            List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
            // List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
            List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
            returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetHealthPackageDataSearch(OrgID, Type, pkgid, out  lstPackages, out  lstPackageMapping, out lstPackageContents, out  lstGeneralHealthCheckUpMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstPackageContents;
    }
    #endregion

    #region Get Billing Items

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetBillingItems(string prefixText, string contextKey)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            long lresutl = -1;
            int OrgID = 0;
            long ClientID = 0;

            string FeeType = string.Empty, Description = prefixText, IsMappedItem = string.Empty, Remarks = string.Empty;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            FeeType = strValue[0];

            Int64.TryParse(strValue[1], out ClientID);
            IsMappedItem = strValue[2].ToUpper();
            Remarks = strValue[3].ToUpper();
            Gender = strValue[4];

            lresutl = be.GetBillingItems(OrgID, FeeType, Description, ClientID, IsMappedItem, Remarks, Gender, out lstBillingFeeDetails);
            if (lstBillingFeeDetails.Count > 0)
            {
                foreach (BillingFeeDetails item in lstBillingFeeDetails)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return items.ToArray();
    }

    #endregion

    #region Get Billing Items Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetBillingItemsDetails(int OrgID, int FeeID, string FeeType, string Description, long ClientID, 
        long VisitID, string Remarks, string IsCollected, string CollectedDatetime, string locationName, long BookingID)
    {
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            DateTime pCollectDatetime = Convert.ToDateTime(CollectedDatetime);
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetBillingItemsDetails(OrgID, FeeID, FeeType, Description, ClientID, VisitID, 
                Remarks, IsCollected, pCollectDatetime, locationName, BookingID, out lstBillingFeeDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetBillingItemsDetails Message:", ex);
        }
        return lstBillingFeeDetails;
    }
    #endregion
    #region Get Billing Items Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetBillingItemsDetails_Quantum(int OrgID, int FeeID, string FeeType, string Description, long ClientID, long VisitID, string Remarks, string IsCollected, string CollectedDatetime, string locationName, string OrderedItem, string ExtVisitNumber, string BilledDate, long BillNo)
    {
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {

            JavaScriptSerializer JSserializer = new JavaScriptSerializer();
            List<OrderedInvestigations> lstOrderedItems = new List<OrderedInvestigations>();

            if (!string.IsNullOrEmpty(OrderedItem))
            {
                lstOrderedItems = JSserializer.Deserialize<List<OrderedInvestigations>>(OrderedItem);
            }

            DateTime pCollectDatetime = Convert.ToDateTime(CollectedDatetime);
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetBillingItemsDetails_Quantum(OrgID, FeeID, FeeType, Description, ClientID, VisitID, Remarks, IsCollected, pCollectDatetime, locationName, lstOrderedItems, ExtVisitNumber, BilledDate, BillNo, out lstBillingFeeDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetBillingItemsDetails Message:", ex);
        }
        return lstBillingFeeDetails;
    }
    #endregion

    #region Get Billing Items Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetHospitalBillingItemsDetails(int OrgID, int FeeID, string FeeType, string Description, long ClientID, long VisitID, string Remarks, long RateID, string VisitType)
    {
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetHospitalBillingItemsDetails(OrgID, FeeID, FeeType, Description, ClientID, VisitID, Remarks, RateID, VisitType, out lstBillingFeeDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetHospitalBillingItemsDetails Message:", ex);
        }
        return lstBillingFeeDetails;
    }
    #endregion

    #region Get OrderedInvestigation Status
    [WebMethod(EnableSession = true)]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<FinalBill> GetOrderedInvestigationStatus(long PatientID, long VisitID, long FinallBillID, int OrgID)
    {
        List<FinalBill> lstFinalBill = new List<FinalBill>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetOrderedInvestigationStatus(PatientID, VisitID, FinallBillID, OrgID, out lstFinalBill);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetOrderedInvestigationStatus Message:", ex);
        }
        return lstFinalBill;
    }
    #endregion
    #region Get Investigaton Name For Org (Patient Investigation)
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchOrderedPatientInvestigations(string prefixText, int count, string contextKey)
    {
        List<PatientInvestigation> lstInvName = new List<PatientInvestigation>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetOrderedPatientInvestigations(prefixText, Orgid, out lstInvName);
        if (lstInvName.Count > 0)
        {
            foreach (PatientInvestigation item in lstInvName)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.InvestigationName, item.InvestigationID.ToString()));
            }
        }

        //var fetchName = from m in lstInvName
        //                select m;

        return items.ToArray();
    }
    #endregion



    //--------------Babu 18-12-2012-------------------
    #region Performing Driver Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetPerformingDriverName(string prefixText, string contextKey)
    {

        Master_BL patBL = new Master_BL(new BaseClass().ContextInfo);
        List<EmployeeRegMaster> lstDriverName = new List<EmployeeRegMaster>();
        List<string> items = new List<string>();

        long lresutl = -1;

        int orgID = 0;

        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        lresutl = patBL.GetDriverUser(prefixText, orgID, out lstDriverName);
        if (lstDriverName.Count > 0)
        {
            foreach (EmployeeRegMaster item in lstDriverName)
            {
                item.EmployerID = Convert.ToInt32(item.Name.Split('$')[0]);
                item.Name = item.Name.Split('$')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.EmployerID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion


    #region Performing AMBULANCE Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetAmbulanceNo(string prefixText, string contextKey)
    {

        Master_BL patBL = new Master_BL(new BaseClass().ContextInfo);
        List<Ambulance> lstAmbulance = new List<Ambulance>();
        List<string> items = new List<string>();

        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        lresutl = patBL.GetAmbulanceDetails(prefixText, orgID, out lstAmbulance);

        if (lstAmbulance.Count > 0)
        {
            foreach (Ambulance item in lstAmbulance)
            {
                item.AmbulanceID = Convert.ToInt32(item.Workpermitno.Split('$')[0]);
                item.Workpermitno = item.Workpermitno.Split('$')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Workpermitno, item.AmbulanceID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion


    #region Performing Location Search
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string[] GetLocation(string prefixText, string contextKey)
    {
        Master_BL patBL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocation = new List<Localities>();
        List<string> items = new List<string>();

        long lresutl = -1;


        lresutl = patBL.GetAMBLocation(prefixText, out lstLocation);

        if (lstLocation.Count > 0)
        {
            foreach (Localities item in lstLocation)
            {
                item.Locality_ID = Convert.ToInt32(item.Locality_Value.Split('$')[0]);
                item.Locality_Value = item.Locality_Value.Split('$')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Locality_Value, item.Locality_ID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion

    #region Localities

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Localities> Localities(int CodeID)
    {
        Country_BL countryBL = new Country_BL(new BaseClass().ContextInfo);
        List<Localities> lstStates = new List<Localities>();
        try
        {
            long returncode = -1;
            returncode = countryBL.GetLocalities(CodeID, out lstStates);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service Localities Message:", ex);





        }

        return lstStates;

    }
    #endregion

    #region FeeTypeAttributes
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string[] GetFeeTypeAttributes(string prefixText, string contextKey)
    {
        Master_BL patBL = new Master_BL(new BaseClass().ContextInfo);
        List<FeeTypeAttributes> lstFeeTypeAttributes = new List<FeeTypeAttributes>();
        List<string> items = new List<string>();

        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        lresutl = patBL.GetFeeTypeAttributes(prefixText, contextKey, orgID, out lstFeeTypeAttributes);

        if (lstFeeTypeAttributes.Count > 0)
        {
            foreach (FeeTypeAttributes item in lstFeeTypeAttributes)
            {
                item.FeeTypeAttributesID = Convert.ToInt32(item.Desc.Split('$')[0]);
                item.Desc = item.Desc.Split('$')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Desc, item.FeeTypeAttributesID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion

    #region Get Speciality Items
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] SearchSpeciality(string prefixText, int count, string contextKey)
    {
        Speciality_BL Speciality_BL = new Speciality_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        try
        {
            long lresutl = -1;
            int pOrgID = 0;
            Int32.TryParse(contextKey, out pOrgID);
            lresutl = Speciality_BL.SearchSpeciality(pOrgID, prefixText, out lstSpeciality);
            if (lstSpeciality.Count > 0)
            {
                foreach (Speciality item in lstSpeciality)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.SpecialityName, item.SpecialityID.ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchSpeciality Message:", ex);
        }
        return items.ToArray();
    }
    #endregion

    #region GetInvestigation History Mapping Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvHistoryAttributes> GetInvestigationHistoryMapping(int orgID, long VisitID, long PatientID, long InvID, string InvestigationList)
    {
        long returnCode = -1;
        List<InvHistoryAttributes> lstInvHistoryAttributes = new List<InvHistoryAttributes>();
        lstInvHistoryAttributes = new List<InvHistoryAttributes>();
        try
        {

            returnCode = new Physician_BL(new BaseClass().ContextInfo).GetInvestigationHistoryMapping(orgID, VisitID, PatientID, InvID, InvestigationList, out lstInvHistoryAttributes);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetInvestigationHistoryMapping Message:", ex);
        }
        return lstInvHistoryAttributes;
    }


    #endregion

    #region MRDType
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string[] GetMRDType(string prefixText, string contextKey)
    {
        Patient_BL patBL = new Patient_BL(new BaseClass().ContextInfo);
        List<PatientMRDDetails> lstMRDDetais = new List<PatientMRDDetails>();
        List<string> items = new List<string>();

        long lresutl = -1;

        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);

        lresutl = patBL.GetMRDType(contextKey, prefixText, orgID, out lstMRDDetais);

        if (lstMRDDetais.Count > 0)
        {
            foreach (PatientMRDDetails item in lstMRDDetais)
            {
                item.PatientID = Convert.ToInt64(item.SpecialityName.Split('$')[0]);
                item.SpecialityName = item.SpecialityName.Split('$')[1];
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.SpecialityName, item.PatientID.ToString()));
            }
        }

        return items.ToArray();

    }
    #endregion
    #region GetQualification
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<MetaValue_Common> GetQualification(string type, string orgID)
    {
        List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
        try
        {
            long returnCode = -1;
            Master_BL obj = new Master_BL(new BaseClass().ContextInfo);
            returnCode = obj.GetGroupValues(int.Parse(orgID), type, out lstmetavalue);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetQualification Message:", ex);
        }
        return lstmetavalue;

    }
    #endregion

    /*#region GetOrderServiceDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<TransBillingDetails> GetOrderServiceDetails(long VisitID, long ServiceNumber, string Type)
    {
        List<TransBillingDetails> lstTransBillingDetails = new List<TransBillingDetails>();
        List<Patient> lstPatient = new List<Patient>();
        long returnCode = -1;
        try
        {
            Inventory_BL objInventory_BL = new Inventory_BL(new BaseClass().ContextInfo);
            returnCode = objInventory_BL.GetOrderServiceDetails(VisitID, ServiceNumber, new BaseClass().OrgID, Type, out lstTransBillingDetails, out lstPatient);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in OPIP Billing Web Service GetOrderServiceDetails Message:", ex);
        }
        return lstTransBillingDetails;
    }
    #endregion*/
    #region GetVisitClientMappingDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<VisitClientMapping> GetVisitClientMappingDetails(string pVisitID, string orgID)
    {
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        try
        {
            long returnCode = -1;
            PatientVisit_BL obj = new PatientVisit_BL(new BaseClass().ContextInfo);
            returnCode = obj.GetVisitClientMappingDetails(Int32.Parse(orgID), Int64.Parse(pVisitID), out lstVisitClientMapping);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetVisitClientMappingDetails:", ex);
        }
        return lstVisitClientMapping;

    }
    #endregion

    #region Get GroupName For Org
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] FetchOrgGroups(string prefixText, int count, string contextKey)
    {
        List<InvOrgGroup> lstGroups = new List<InvOrgGroup>();
        List<string> items = new List<string>();
        long returnCode = -1;
        int Orgid = 0;
        Orgid = Convert.ToInt32(contextKey);
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetOrgGroups(prefixText, Orgid, out lstGroups);
        if (lstGroups.Count > 0)
        {
            foreach (InvOrgGroup item in lstGroups)
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.DisplayText, item.OrgGroupID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion
    #region Get Blood Components

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetBloodComponent(string prefixText, string contextKey)
    {

        //string[] pvalue;
        //pvalue = contextKey.Split('~');
        long ComponentID = Convert.ToInt64(contextKey.ToString());

        BloodBank_BL objBloodBank = new BloodBank_BL(new BaseClass().ContextInfo);
        List<Products> lstBloodComponentnames = new List<Products>();
        long returnCode = -1;


        string[] Componentnames = null;
        returnCode = objBloodBank.GetBloodComponent(prefixText, ComponentID, out lstBloodComponentnames);
        if (lstBloodComponentnames.Count > 0)
        {
            Componentnames = new string[lstBloodComponentnames.Count];
            for (int i = 0; i < lstBloodComponentnames.Count; i++)
            {
                Componentnames[i] = lstBloodComponentnames[i].ProductID + "^" + lstBloodComponentnames[i].ProductName;
            }
        }
        return Componentnames;
    }

    #endregion



    #region Get Surgical Fee Splitups

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<SOIRateDetails> GetSurgicalFeeSplitUps(long TreatmentPlanID)
    {

        //string[] pvalue;
        //pvalue = contextKey.Split('~');
        long TreatementPlanID = TreatmentPlanID;

        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<SOIRateDetails> lstFees = new List<SOIRateDetails>();
        long returnCode = -1;


        //string[] fees = null;
        returnCode = be.GetSurgicalFeeSplitUps(TreatementPlanID, out lstFees);
        //if (lstFees.Count > 0)
        //{
        //    fees = new string[lstFees.Count];
        //    for (int i = 0; i < lstFees.Count; i++)
        //    {
        //        fees[i] = lstFees[i].FeeDescription+ "^" + lstFees[i].Amount;
        //    }
        //}
        return lstFees;
    }

    #endregion


    #region Get Blood Bag Numbers

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BloodSeparationDetails> GetBloodBags(long ProductID)
    {
        long PID = ProductID;
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<BloodSeparationDetails> lstBags = new List<BloodSeparationDetails>();

        long returnCode = -1;
        returnCode = be.GetBloodBags(PID, out lstBags);
        return lstBags;
    }

    #endregion

    #region Fee Type Role Mapping Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<FeeTypeMaster> GetFeeType(int orgID, string visitType)
    {
        List<FeeTypeMaster> lstFeeTypeMaster = new List<FeeTypeMaster>();
        try
        {

            BillingEngine objBl = new BillingEngine(new BaseClass().ContextInfo);
            objBl.GetFeeType(orgID, visitType, out lstFeeTypeMaster);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetFeeType in OPIPBilling.cs Webservice Message:", ex);
        }
        return lstFeeTypeMaster;
    }
    #endregion

    #region Get BillingDetails By RateType For OP
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public decimal GetBillingDetailsByRateTypeForOP(long VisitID, long BilledRateID, decimal BilledRateCardAmount, long SelectedRateID, int OrgID, string Type)
    {
        List<BillingDetails> lstDetails = new List<BillingDetails>();
        decimal BilledandSelectedRateCardDifference = -1;
        try
        {

            BillingEngine objBE = new BillingEngine(new BaseClass().ContextInfo);
            objBE.GetBillingDetailsByRateTypeForOP(VisitID, BilledRateID, BilledRateCardAmount, SelectedRateID, out BilledandSelectedRateCardDifference, OrgID, Type, out lstDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBillingDetailsByRateTypeForOP in OPIPBilling.cs Message:", ex);
        }
        return BilledandSelectedRateCardDifference;

    }
    #endregion

    //#region GetUserName
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<Users> GetUserName(int OrgId, int RoleID)
    //{
    //    List<Users> lstUsers = new List<Users>();
    //    try
    //    {
    //        long returncode = -1;

    //        returncode = new Role_BL(new BaseClass().ContextInfo).GetUserName(OrgId, RoleID, out lstUsers);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
    //    }
    //    return lstUsers;
    //}
    //#endregion

    //#region GetRoleName
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<Role> GetRoleName(int OrgId)
    //{
    //    List<Role> role = new List<Role>();
    //    try
    //    {
    //        long returncode = -1;

    //        returncode = new Role_BL(new BaseClass().ContextInfo).GetRoleName(OrgId, out role);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
    //    }
    //    return role;
    //}
    //#endregion

    //#region GetLocationName
    //[WebMethod(EnableSession = true)]
    //[System.Web.Script.Services.ScriptMethod()]
    //public List<OrganizationAddress> GetLocationName(int OrgId)
    //{
    //    PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
    //    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    //    try
    //    {
    //        long returncode = -1;
    //        long pLID = 0;
    //        long pRID = 0;
    //        returncode = patientBL.GetLocation(OrgId, pLID, pRID, out lstLocation);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
    //    }
    //    return lstLocation;
    //}
    //#endregion

    #region GetOrganizations
    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetOrganizations(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = null;
        try
        {
            long loginID = -1;
            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Login objLogin = new Login();
            objLogin.LoginID = loginID;
            List<Role> lstResult = new List<Role>();
            gateWay.GetRoles(objLogin, out lstResult);
            values = new List<CascadingDropDownNameValue>();
            List<CascadingDropDownNameValue> orgExist;
            lstResult = lstResult.OrderBy(r => r.OrgName).ToList();
            string orgName = string.Empty;
            foreach (Role objRole in lstResult)
            {
                orgName = String.IsNullOrEmpty(objRole.OrgName) ? objRole.OrgName : objRole.OrgName.Trim();
                orgExist = values.Where(v => v.name == orgName).ToList();
                if (orgExist.Count == 0)
                    values.Add(new CascadingDropDownNameValue(orgName, Convert.ToString(objRole.OrgID), objRole.IsDefault));
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
    #endregion

    #region GetLocationName
    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetLocationName(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = null;
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
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Login objLogin = new Login();
            objLogin.LoginID = loginID;
            PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(orgId, loginID, roleID, out lstLocation);
            values = new List<CascadingDropDownNameValue>();
            List<CascadingDropDownNameValue> orgExist;
            string location = string.Empty;
            foreach (OrganizationAddress objOrgAddress in lstLocation)
            {
                location = String.IsNullOrEmpty(objOrgAddress.Location) ? objOrgAddress.Location : objOrgAddress.Location.Trim();
                orgExist = values.Where(v => v.name == location).ToList();
                if (orgExist.Count == 0)
                    values.Add(new CascadingDropDownNameValue(location, Convert.ToString(objOrgAddress.AddressID)));
            }
            if (values.Count > 0)
            {
                values[0].isDefaultValue = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations: ", ex);
        }
        return values.ToArray();
    }
    #endregion




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
                    values[0].isDefaultValue = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetOrganizations: ", ex);
        }
        return values.ToArray();
    }


    #region GetDeptName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvDeptMaster> GetDeptName(int OrgId, int roleID)
    {
        List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
        try
        {
            long returncode = -1;

            returncode = new Master_BL(new BaseClass().ContextInfo).GetDeptName(OrgId, roleID, out lstDept);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstDept;
    }
    #endregion

    #region GetDoctorName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvOrgAuthorization> GetDoctorName(int OrgId, int deptID, int roleID)
    {
        List<InvOrgAuthorization> lstPhysician = new List<InvOrgAuthorization>();
        try
        {
            long returncode = -1;

            returncode = new Master_BL(new BaseClass().ContextInfo).GetDoctorName(OrgId, deptID, roleID, out lstPhysician);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetStateByCountry Message:", ex);
        }
        return lstPhysician;
    }
    #endregion


    #region GetEditBilling
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<List<BillingDetails>> GetBillingItemsDetailsForEdit(int OrgID, string BillNo, long VisitID, long PatientID, long ClientID)
    {
        List<List<BillingDetails>> lstBillingDetails = new List<List<BillingDetails>>();
        List<BillingDetails> lstBillingDetails1 = new List<BillingDetails>();
        List<BillingDetails> lstBillingDetails2 = new List<BillingDetails>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetBillingItemsDetailsForEdit(OrgID, BillNo, VisitID, PatientID, ClientID, out lstBillingDetails1, out lstBillingDetails2);
            lstBillingDetails.Add(lstBillingDetails1);
            lstBillingDetails.Add(lstBillingDetails2);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstBillingDetails;
    }
    #endregion

    #region GetClientValidation
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<CreditDebitSummary> ClientValidation(int WClientID, string WClientType, string WReferenceID, string WType, int WPatientID)
    {
        long result = -1;
        long InvoiceID = 0;
        List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
        Master_BL MBL = new Master_BL(new BaseClass().ContextInfo);
        result = MBL.GetClientValidation(WClientID, WClientType, WReferenceID, WType, WPatientID, out lstCreditDebit);
        return lstCreditDebit;

    }
    #endregion

    #region GetBookingOrderDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Bookings> GetBookingOrderDetails(long BookingId, int OrgId, int LocationId)
    {
        List<Bookings> lstBookingOrder = new List<Bookings>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetBookingOrderDetails(BookingId, OrgId, LocationId, out lstBookingOrder);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetBookingOrderDetails Message:", ex);
        }
        return lstBookingOrder;
    }
    #endregion
    #region GetQuickPatientListForClientBilling
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetLabQuickBillPatientListForClientBilling(string prefixText, int count, string contextKey)
    {
        List<Patient> lstPatient = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstPatient.Count);
        try
        {
            long retCode = -1, PatientVisitID = -1, pClientID = -1;
            int orgID = 0;
            string pVisitType = "";
            //int searchType = 0;
            string[] PatientList = null;
            Int32.TryParse(contextKey.Split('~')[0], out orgID);
            Int64.TryParse(contextKey.Split('~')[1], out PatientVisitID);
            // Int32.TryParse(contextKey.Split('~')[2], out searchType);
            Int64.TryParse(contextKey.Split('~')[3], out pClientID);
            if (pClientID > 0)
            {
                pVisitType = "CLP";
                PatientVisitID = pClientID;
            }
            else
            {
                pVisitType = "0";
            }
            items.Clear();
            retCode = bbl.GetLabQuickBillPatientListForClientBilling(prefixText, pVisitType, orgID, PatientVisitID, out lstPatient);
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
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }

        return items.ToArray();
    }
    #endregion

    #region Get PatientOrderedInvestigation List
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Array> GetPatientOrderedInvestigation(string prefixText, string contextKey)
    {
        List<Array> Obj = new List<Array>();
        Array Obj1;//= new Array();
        Array Obj2;//= new Array();
        Array Obj3;//= new Array();
        Investigation_BL Delta_BL = new Investigation_BL(new BaseClass().ContextInfo);
        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstMasterReflex = new List<OrderedInvestigations>();
        ArrayList a = new ArrayList();
        string type = string.Empty;
        long lresutl = -1;
        int orgID = 0;
        long vid = -1;
        long invId = -1;
        long accNo = -1;
        string parentType = string.Empty;

        if (contextKey.Contains("~"))
        {
            string[] GetContextKey = contextKey.Split('~');
            type = GetContextKey[0];
            Int64.TryParse(GetContextKey[1].ToString(), out vid);
            Int64.TryParse(GetContextKey[2].ToString(), out invId);
            Int64.TryParse(GetContextKey[3].ToString(), out accNo);
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            parentType = GetContextKey[4].ToString();
        }
        else
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            type = contextKey;
        }

        try
        {
            lresutl = Delta_BL.GetPatientOrderedInvestigation(vid, orgID, invId, type, accNo, parentType, out lstOrderedInvestigations, out lstMasterReflex);
            Obj1 = (from lists in lstOrderedInvestigations
                    where lists.ID == invId && lists.AccessionNumber == accNo
                    select lists).ToArray();
            // Obj1 = lstOrderedInvestigations.ToArray();
            Obj2 = lstMasterReflex.ToArray();
            Obj3 = lstOrderedInvestigations.ToArray();
            Obj.Add(Obj1);
            Obj.Add(Obj2);
            Obj.Add(Obj3);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  OP/IP Billing Service GetConsumableMasterList Message:", ex);
        }
        return Obj;
    }
    #endregion
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

    #region GetLocationDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<OrganizationAddress> GetLocationDetails(int iOrgID, long RoleID)
    {
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();

        try
        {
            long returnCode = -1;
            long loginID = -1;
            long roleID = -1;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);

            returnCode = patientBL.GetLocation(iOrgID, loginID, RoleID, out lstLocation);
        }
        catch
        {
        }
        return lstLocation;
    }
    #endregion
    #region Modified Lab Quick Billig//Karhik
    #region Get Client RefPhy Hos for Code
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetClientRefPhyHosforCode(string prefixText, string contextKey)
    {
        List<string> items = new List<string>();
        try
        {
            BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
            List<ClientCodeMapping> lstClientCodeMapping = new List<ClientCodeMapping>();

            long lresutl = -1;
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            lresutl = BillingBl.GetClientRefPhyHosforCode(prefixText, orgID, out lstClientCodeMapping);
            if (lstClientCodeMapping.Count > 0)
            {
                foreach (ClientCodeMapping item in lstClientCodeMapping)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Code, item.Value.ToString()));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetClientRefPhyHosforCode method in OPIPBilling.CS", ex);
        }

        return items.ToArray();
    }
    #endregion

    #endregion
    #region GetMedicalComments
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string GetMedicalComments(long Invid, string TxtValue, int OrgID, string Gender, string Age)
    {
        string RemarksValue = string.Empty;
        RemarksValue = string.Empty;
        try
        {
            long result = -1;
            List<InvRemarks> lstInvRemarks = new List<InvRemarks>();
            Master_BL MBL = new Master_BL(new BaseClass().ContextInfo);
            result = MBL.GetMedicalComments(Invid, TxtValue, OrgID, out lstInvRemarks);
            string pGender = string.Empty;
            pGender = Gender == "F" ? "Female" : "Male";
            string[] lstAge = Age.Split(' ');
            string pAge = string.Empty;
            string pAgetype = string.Empty;
            if (lstAge != null && lstAge.Count() > 0)
            {
                pAge = lstAge[0];
                pAgetype = lstAge[1].Replace("(", "").Replace(")", "");
            }

            double patientAgeInDays = ConvertToDays(Convert.ToDouble(pAge), pAgetype);

            foreach (InvRemarks GetRemarks in lstInvRemarks)
            {
                if (!(string.IsNullOrEmpty(GetRemarks.Comments)))
                {
                    bool RemarkFlag = true;
                    string Xmldata = GetRemarks.Comments.Replace("\r\n", "");
                    XElement xelement = XElement.Parse(Xmldata);

                    var ageValueRange = from age in xelement.Elements("Remarks").Elements("property")
                                        where (string)age.Attribute("type") == "age" &&
                                        ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                        ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                        select age;

                    var ageRange = from age in xelement.Elements("Remarks").Elements("property")
                                   where (string)age.Attribute("type") == "age" &&
                                   ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                   ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                   select age;

                    var ageValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                            where (string)age.Attribute("type") == "age" &&
                                            ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                            ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                            select age;

                    var ageRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                       where (string)age.Attribute("type") == "age" &&
                                       ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                       ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                       select age;


                    var commonValueRange = from age in xelement.Elements("Remarks").Elements("property")
                                           where (string)age.Attribute("type") == "common" &&
                                           ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                           ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                           select age;

                    var commonRange = from age in xelement.Elements("Remarks").Elements("property")
                                      where (string)age.Attribute("type") == "common" &&
                                      ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                      ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                      select age;

                    var commonValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                               where (string)age.Attribute("type") == "common" &&
                                               ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                               ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                               select age;

                    var commonRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                          where (string)age.Attribute("type") == "common" &&
                                          ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                          ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                          select age;

                    //var otherValueRange = from age in xelement.Elements("Remarks").Elements("property")
                    //                      where (string)age.Attribute("type") == "other" &&
                    //                      ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                    //                      ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                    //                      select age;

                    //var otherRange = from age in xelement.Elements("Remarks").Elements("property")
                    //                 where (string)age.Attribute("type") == "other" &&
                    //                 ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                    //                 ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                    //                 select age;

                    //var otherValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                    //                          where (string)age.Attribute("type") == "other" &&
                    //                          ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                    //                          ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                    //                          select age;

                    //var otherRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                    //                     where (string)age.Attribute("type") == "other" &&
                    //                     ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                    //                     ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                    //                     select age;



                    if (ageValueRange != null && ageValueRange.ToList().Count > 0)
                    {
                        RemarksValue = fnagevaluerange(ageValueRange, patientAgeInDays, GetRemarks, TxtValue);
                    }
                    if (ageValueRangeBoth != null && ageValueRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fnagevaluerange(ageValueRangeBoth, patientAgeInDays, GetRemarks, TxtValue);
                    }
                    if (ageRange != null && ageRange.ToList().Count > 0)
                    {
                        RemarksValue = fnagerange(ageRange, patientAgeInDays, GetRemarks);
                    }
                    if (ageRangeBoth != null && ageRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fnagerange(ageRangeBoth, patientAgeInDays, GetRemarks);
                    }
                    if (commonRange != null && commonRange.ToList().Count > 0)
                    {
                        RemarksValue += GetRemarks.RemarksText;
                    }
                    if (commonRangeBoth != null && commonRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue += GetRemarks.RemarksText;
                    }
                    if (commonValueRange != null && commonValueRange.ToList().Count > 0)
                    {
                        RemarksValue = fncommonvaluerange(commonValueRange, GetRemarks, TxtValue);
                    }
                    if (commonValueRangeBoth != null && commonValueRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fncommonvaluerange(commonValueRangeBoth, GetRemarks, TxtValue);
                    }
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in GetMedicalRemarks: ", Ex);
        }
        return RemarksValue;
    }
    #endregion

    #region CalculateMedicalComments
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string CalculateMedicalComments(long Invid, string TxtValue, int OrgID, string Gender, string Age, int RemarksID, string RemarksText, string Comments)
    {
        string RemarksValue = string.Empty;
        RemarksValue = string.Empty;
        try
        {
            long result = -1;
            List<InvRemarks> lstInvRemarks = new List<InvRemarks>();

            // Master_BL MBL = new Master_BL(new BaseClass().ContextInfo);
            // result = MBL.GetMedicalComments(Invid, TxtValue, OrgID, out lstInvRemarks);
            InvRemarks RemarksInv = new InvRemarks();
            RemarksInv.Comments = Comments;
            RemarksInv.RemarksID = RemarksID;
            RemarksInv.RemarksText = RemarksText;
            lstInvRemarks.Add(RemarksInv);

            string pGender = string.Empty;
            pGender = Gender == "F" ? "Female" : "Male";
            string[] lstAge = Age.Split(' ');
            string pAge = string.Empty;
            string pAgetype = string.Empty;
            if (lstAge != null && lstAge.Count() > 0)
            {
                pAge = lstAge[0];
                pAgetype = lstAge[1].Replace("(", "").Replace(")", "");
            }

            double patientAgeInDays = ConvertToDays(Convert.ToDouble(pAge), pAgetype);

            foreach (InvRemarks GetRemarks in lstInvRemarks)
            {
                if (!(string.IsNullOrEmpty(GetRemarks.Comments)))
                {
                    bool RemarkFlag = true;
                    string Xmldata = GetRemarks.Comments.Replace("\r\n", "");
                    XElement xelement = XElement.Parse(Xmldata);

                    var ageValueRange = from age in xelement.Elements("Remarks").Elements("property")
                                        where (string)age.Attribute("type") == "age" &&
                                        ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                        ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                        select age;

                    var ageRange = from age in xelement.Elements("Remarks").Elements("property")
                                   where (string)age.Attribute("type") == "age" &&
                                   ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                   ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                   select age;

                    var ageValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                            where (string)age.Attribute("type") == "age" &&
                                            ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                            ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                            select age;

                    var ageRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                       where (string)age.Attribute("type") == "age" &&
                                       ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                       ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                       select age;


                    var commonValueRange = from age in xelement.Elements("Remarks").Elements("property")
                                           where (string)age.Attribute("type") == "common" &&
                                           ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                           ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                           select age;

                    var commonRange = from age in xelement.Elements("Remarks").Elements("property")
                                      where (string)age.Attribute("type") == "common" &&
                                      ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                      ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                                      select age;

                    var commonValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                               where (string)age.Attribute("type") == "common" &&
                                               ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                                               ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                               select age;

                    var commonRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                                          where (string)age.Attribute("type") == "common" &&
                                          ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                                          ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                                          select age;

                    //var otherValueRange = from age in xelement.Elements("Remarks").Elements("property")
                    //                      where (string)age.Attribute("type") == "other" &&
                    //                      ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                    //                      ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                    //                      select age;

                    //var otherRange = from age in xelement.Elements("Remarks").Elements("property")
                    //                 where (string)age.Attribute("type") == "other" &&
                    //                 ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                    //                 ((string)age.Attribute("gender")).ToLower() == pGender.ToLower()
                    //                 select age;

                    //var otherValueRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                    //                          where (string)age.Attribute("type") == "other" &&
                    //                          ((string)age.Attribute("value")).ToLower() == "opr".ToLower() &&
                    //                          ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                    //                          select age;

                    //var otherRangeBoth = from age in xelement.Elements("Remarks").Elements("property")
                    //                     where (string)age.Attribute("type") == "other" &&
                    //                     ((string)age.Attribute("value")).ToLower() == "no".ToLower() &&
                    //                     ((string)age.Attribute("gender")).ToLower() == "Both".ToLower()
                    //                     select age;



                    if (ageValueRange != null && ageValueRange.ToList().Count > 0)
                    {
                        RemarksValue = fnagevaluerange_AutoComments(ageValueRange, patientAgeInDays, GetRemarks, TxtValue);
                    }
                    if (ageValueRangeBoth != null && ageValueRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fnagevaluerange_AutoComments(ageValueRangeBoth, patientAgeInDays, GetRemarks, TxtValue);
                    }
                    if (ageRange != null && ageRange.ToList().Count > 0)
                    {
                        RemarksValue = fnagerange_AutoComments(ageRange, patientAgeInDays, GetRemarks);
                    }
                    if (ageRangeBoth != null && ageRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fnagerange_AutoComments(ageRangeBoth, patientAgeInDays, GetRemarks);
                    }
                    if (commonRange != null && commonRange.ToList().Count > 0)
                    {
                        RemarksValue += GetRemarks.RemarksText;
                    }
                    if (commonRangeBoth != null && commonRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue += GetRemarks.RemarksText;
                    }
                    if (commonValueRange != null && commonValueRange.ToList().Count > 0)
                    {
                        RemarksValue = fncommonvaluerange_AutoComments(commonValueRange, GetRemarks, TxtValue);
                    }
                    if (commonValueRangeBoth != null && commonValueRangeBoth.ToList().Count > 0)
                    {
                        RemarksValue = fncommonvaluerange_AutoComments(commonValueRangeBoth, GetRemarks, TxtValue);
                    }
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in GetMedicalRemarks: ", Ex);
        }
        return RemarksValue;
    }
    #endregion

    double ConvertToDays(double age, string agetype)
    {
        double ageInDays = 0;

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
    public string fnagevaluerange(IEnumerable<XElement> ageValueRange, double patientAgeInDays, InvRemarks GetRemarks, string TxtValue)
    {
        //string RemarksValue = string.Empty;
        try
        {
            foreach (var lst in ageValueRange)
            {
                if (lst.Element("lst") != null)
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "lst", TxtValue);
                    }
                }
                if (lst.Element("lsq") != null)
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "lsq", TxtValue);
                    }
                }
                if (lst.Element("eql") != null)
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "eql", TxtValue);
                    }
                }
                if (lst.Element("grt") != null)
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "grt", TxtValue);
                    }
                }
                if (lst.Element("grq") != null)
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "grq", TxtValue);
                    }
                }
                if (lst.Element("btw") != null)
                {
                    string[] between = lst.Element("btw").Value.Split('-');
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem(lst, GetRemarks, "btw", TxtValue);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }

public string fnagerange_AutoComments(IEnumerable<XElement> ageRange, double patientAgeInDays, InvRemarks GetRemarks)
    {
        RemarksValue = string.Empty;
        try
        {
            if (ageRange != null)
            {
                foreach (var lst in ageRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("lsq") != null)
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }
    public string fnagevaluerange_AutoComments(IEnumerable<XElement> ageValueRange, double patientAgeInDays, InvRemarks GetRemarks, string TxtValue)
    {
        RemarksValue = string.Empty;
        try
        {
            foreach (var lst in ageValueRange)
            {
                if (lst.Element("lst") != null)
                {
                    if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "lst", TxtValue);
                    }
                }
                if (lst.Element("lsq") != null)
                {
                    if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "lsq", TxtValue);
                    }
                }
                if (lst.Element("eql") != null)
                {
                    if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "eql", TxtValue);
                    }
                }
                if (lst.Element("grt") != null)
                {
                    if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "grt", TxtValue);
                    }
                }
                if (lst.Element("grq") != null)
                {
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "grq", TxtValue);
                    }
                }
                if (lst.Element("btw") != null)
                {
                    string[] between = lst.Element("btw").Value.Split('-');
                    if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                    {
                        RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "btw", TxtValue);
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }

    
    
    public string fncommonvaluerange_AutoComments(IEnumerable<XElement> commonRange, InvRemarks GetRemarks, string TxtValue)
    {
        RemarksValue = string.Empty;
        try
        {
            foreach (var lst in commonRange)
            {
                if (lst.Element("lst") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "lst", TxtValue);
                }
                if (lst.Element("lsq") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "lsq", TxtValue);
                }
                if (lst.Element("eql") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "eql", TxtValue);
                }
                if (lst.Element("grt") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "grt", TxtValue);
                }
                if (lst.Element("grq") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "grq", TxtValue);
                }
                if (lst.Element("btw") != null)
                {
                    RemarksValue = fnmedrem_AutoComments(lst, GetRemarks, "btw", TxtValue);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }
    public string fnmedrem_AutoComments(XElement xe, InvRemarks GetRemarks, string opr, string TxtValue)
    {
        //string RemarksValue = string.Empty;
        bool RemarkFlag = true;
        try
        {
            var Remarksbtw = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "btw"
                             select id;
            var Remarkslst = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "lst"
                             select id;
            var Remarksgt = from id in xe.Elements(opr)
                            where (string)id.Attribute("mode") == "grt"
                            select id;
            var Remarkseql = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "eql"
                             select id;
            var Remarkslsq = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "lsq"
                             select id;
            var Remarksgrq = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "grq"
                             select id;

            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksbtw)
                {
                    string[] between = lst.Attribute("value").Value.Split('-');

                    if ((Convert.ToDouble(TxtValue)) >= ((Convert.ToDouble(between[0]))) && (Convert.ToDouble(TxtValue)) <= ((Convert.ToDouble(between[1]))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkslst)
                {
                    if ((Convert.ToDouble(TxtValue)) < ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksgt)
                {

                    if ((Convert.ToDouble(TxtValue)) > ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkseql)
                {
                    if (TxtValue.ToLower() == lst.Attribute("value").Value.ToLower())
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkslsq)
                {
                    if ((Convert.ToDouble(TxtValue)) <= ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksgrq)
                {
                    if ((Convert.ToDouble(TxtValue)) >= ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }
    public string fnagerange(IEnumerable<XElement> ageRange, double patientAgeInDays, InvRemarks GetRemarks)
    {
        //string RemarksValue = string.Empty;
        try
        {
            if (ageRange != null)
            {
                foreach (var lst in ageRange)
                {
                    if (lst.Element("lst") != null)
                    {
                        if (patientAgeInDays < ConvertToDays(Convert.ToDouble(lst.Element("lst").Value), lst.Element("lst").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("lsq") != null)
                    {
                        if (patientAgeInDays <= ConvertToDays(Convert.ToDouble(lst.Element("lsq").Value), lst.Element("lsq").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("eql") != null)
                    {
                        if (patientAgeInDays == ConvertToDays(Convert.ToDouble(lst.Element("eql").Value), lst.Element("eql").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("grt") != null)
                    {
                        if (patientAgeInDays > ConvertToDays(Convert.ToDouble(lst.Element("grt").Value), lst.Element("grt").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("grq") != null)
                    {
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(lst.Element("grq").Value), lst.Element("grq").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                    if (lst.Element("btw") != null)
                    {
                        string[] between = lst.Element("btw").Value.Split('-');
                        if (patientAgeInDays >= ConvertToDays(Convert.ToDouble(between[0]), lst.Element("btw").Attribute("agetype").Value) && patientAgeInDays <= ConvertToDays(Convert.ToDouble(between[1]), lst.Element("btw").Attribute("agetype").Value))
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }

    public string fncommonvaluerange(IEnumerable<XElement> commonRange, InvRemarks GetRemarks, string TxtValue)
    {
        //string RemarksValue = string.Empty;
        try
        {
            foreach (var lst in commonRange)
            {
                if (lst.Element("lst") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "lst", TxtValue);
                }
                if (lst.Element("lsq") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "lsq", TxtValue);
                }
                if (lst.Element("eql") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "eql", TxtValue);
                }
                if (lst.Element("grt") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "grt", TxtValue);
                }
                if (lst.Element("grq") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "grq", TxtValue);
                }
                if (lst.Element("btw") != null)
                {
                    RemarksValue = fnmedrem(lst, GetRemarks, "btw", TxtValue);
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }
    public string fnmedrem(XElement xe, InvRemarks GetRemarks, string opr, string TxtValue)
    {
        //string RemarksValue = string.Empty;
        bool RemarkFlag = true;
        try
        {
            var Remarksbtw = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "btw"
                             select id;
            var Remarkslst = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "lst"
                             select id;
            var Remarksgt = from id in xe.Elements(opr)
                            where (string)id.Attribute("mode") == "grt"
                            select id;
            var Remarkseql = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "eql"
                             select id;
            var Remarkslsq = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "lsq"
                             select id;
            var Remarksgrq = from id in xe.Elements(opr)
                             where (string)id.Attribute("mode") == "grq"
                             select id;

            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksbtw)
                {
                    string[] between = lst.Attribute("value").Value.Split('-');

                    if ((Convert.ToDouble(TxtValue)) >= ((Convert.ToDouble(between[0]))) && (Convert.ToDouble(TxtValue)) <= ((Convert.ToDouble(between[1]))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkslst)
                {
                    if ((Convert.ToDouble(TxtValue)) < ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksgt)
                {

                    if ((Convert.ToDouble(TxtValue)) > ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkseql)
                {
                    if (TxtValue.ToLower() == lst.Attribute("value").Value.ToLower())
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarkslsq)
                {
                    if ((Convert.ToDouble(TxtValue)) <= ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
            if (RemarkFlag == true)
            {
                foreach (var lst in Remarksgrq)
                {
                    if ((Convert.ToDouble(TxtValue)) >= ((Convert.ToDouble(lst.Attribute("value").Value))))
                    {
                        if (RemarksValue != "" && RemarksValue != null)
                        {
                            RemarksValue += GetRemarks.RemarksText + ",";
                        }
                        else
                        {
                            RemarksValue += GetRemarks.RemarksText;
                        }
                        RemarkFlag = false;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return RemarksValue;
    }
    #region Get Rates For STAT Test
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetRateForSTAT(int OrgID, int FeeID, string FeeType, long ClientID, string BillNo, string BillstartTime)
    {
        List<BillingFeeDetails> lstGeneralBillingItems = new List<BillingFeeDetails>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetRateForSTAT(OrgID, FeeID, FeeType, ClientID, BillNo, BillstartTime, out lstGeneralBillingItems);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetRateForSTAT Message:", ex);
        }
        return lstGeneralBillingItems;
    }
    #endregion

    /****************Added By Arivalagan K**********************/

    #region Get RoundName List
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetRoundNameList(string prefixText, string contextKey)
    {
        Master_BL oMasterBL = new Master_BL(new BaseClass().ContextInfo);
        List<RoundMaster> lstRound = new List<RoundMaster>();

        List<string> items = new List<string>();
        long lresutl = -1;
        int orgID = 0;
        string searchType = string.Empty;
        if (contextKey.Contains("~"))
        {
            string[] GetContextKey = contextKey.Split('~');
            searchType = GetContextKey[0];
            //Int64.TryParse(GetContextKey[1].ToString(), out roundId);
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        }
        else
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            searchType = contextKey;
        }

        if (searchType == "Round")
        {
            lresutl = oMasterBL.GetRoundNameList(prefixText, orgID, searchType, out lstRound);
            if (lstRound.Count > 0)
            {
                foreach (RoundMaster item in lstRound)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.RoundName, item.Value.ToString()));
                }
            }
        }

        return items.ToArray();

    }
    #endregion

    #region GetRound Name Attributes
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetRoundNameAttributes(string prefixText, string contextKey)
    {
        Master_BL oMasterBL = new Master_BL(new BaseClass().ContextInfo);
        List<RoundMasterAttributes> lstRoundAttributes = new List<RoundMasterAttributes>();
        ArrayList a = new ArrayList();
        string searchType = string.Empty;
        long lresutl = -1;
        int orgID = 0;
        long roundId = -1;
        if (contextKey.Contains("~"))
        {
            string[] GetContextKey = contextKey.Split('~');
            searchType = GetContextKey[0];
            Int64.TryParse(GetContextKey[1].ToString(), out roundId);
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        }
        else
        {
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            searchType = contextKey;
        }

        try
        {
            if (searchType == "Attributes")
            {
                lresutl = oMasterBL.GetRoundNameAttributes(prefixText, orgID, searchType, roundId, out lstRoundAttributes);
                a.Add(lstRoundAttributes);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  OP/IP Billing Service GetRoundNameAttributes Message:", ex);
        }
        return a;
    }
    #endregion

    #region GetAdvanceAmountDetails

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<CollectionsMaster> GetAdvanceAmountDetails(long collectionID)
    {
        Patient_BL PatientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<CollectionsMaster> AdvDepositdetails = new List<CollectionsMaster>();

        long returnCode = -1;
        returnCode = PatientBL.GetAdvanceAmountDetails(collectionID, new BaseClass().ContextInfo.OrgID, out AdvDepositdetails);
        return AdvDepositdetails;
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuotationClientName(string prefixText, int count, string contextKey)
    {
        List<Patient> lstClient = new List<Patient>();
        BillingEngine Clst = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstClient.Count);
        try
        {
            long retCode = -1;
            int Orgid = 0;

            string[] Clientlist = null;
            if (contextKey != null && contextKey != "")
            {
                items.Clear();
                Int32.TryParse(contextKey.Split('~')[0], out Orgid);
                retCode = Clst.GetQuotationClientName(prefixText, Orgid, out lstClient);
                if (lstClient.Count > 0)
                {
                    Clientlist = new string[lstClient.Count];
                    for (int i = 0; i < lstClient.Count; i++)
                    {
                        string[] all = lstClient[i].Name.Split('~');
                        string name = all[0];
                        string details = lstClient[i].Name;
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(name, details));

                    }



                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetClientList in Quotation Master Message:", ex);
        }

        return items.ToArray();
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuotationClientNameDetails(string ClientID, int Orgid)
    {
        long retCode = -1;
        List<Patient> lstClients = new List<Patient>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        string[] PatientList = null;
        try
        {


            if (ClientID != null && ClientID != "")
            {

                
                retCode = bbl.GetQuotationClientNameDetails(ClientID, Orgid, out lstClients);

                if (lstClients.Count > 0)
                {
                    PatientList = new string[lstClients.Count];
                    for (int i = 0; i < lstClients.Count; i++)
                    {
                        string[] name = lstClients[i].Name.Split('~');
                        string KeyVal = name[0];
                        string value = lstClients[i].Name;
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(KeyVal, value));
                    }
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
    public string[] GetQuotationNumber(string prefixText, int count, string contextKey)
    {
        List<Patient> lstQuotationNo = new List<Patient>();
        BillingEngine Clst = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstQuotationNo.Count);
        try
        {
            long retCode = -1;
            int Orgid = 0;
            string type = "";

            string[] Clientlist = null;
            if (contextKey != null && contextKey != "")
            {
                items.Clear();
                Int32.TryParse(contextKey.Split('~')[0], out Orgid);
                type = contextKey.Split('~')[1];
                retCode = Clst.GetQuotationNumber(prefixText, Orgid,type ,out lstQuotationNo);
                if (lstQuotationNo.Count > 0)
                {
                    Clientlist = new string[lstQuotationNo.Count];
                    for (int i = 0; i < lstQuotationNo.Count; i++)
                    {
                        string[] all = lstQuotationNo[i].Name.Split('~');
                        string name = all[0];
                        string details = lstQuotationNo[i].Name;
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(name, details));

                    }



                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetClientList in Quotation Master Message:", ex);
        }

        return items.ToArray();
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetQuotationNumberDetails(string QuotationID, string ClientID, int Orgid, string Type, string SampleType)
     {
        long retCode = -1;
        List<Patient> lstClients = new List<Patient>();
        List<QuotationBill> lstvalues = new List<QuotationBill>();
        List<PreQuotationInvestigations> lstTest = new List<PreQuotationInvestigations>();
        List<WatersQuotationMaster> lstWaters = new List<WatersQuotationMaster>();
        List<QuotationAddressDetails> TempAddrs = new List<QuotationAddressDetails>();
        BillingEngine bbl = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        string[] PatientList = null;
        string name = null;

        string Test = null;
        string Values = null;
        string first = null;
        string Waters = null;
        string Temp = null;

        try
        {


            if (ClientID != null && ClientID != "")
            {


                retCode = bbl.GetQuotationNumberDetails(QuotationID, ClientID, Orgid, Type, SampleType, out lstClients, out lstTest, out lstvalues, out lstWaters, out TempAddrs);

                if (lstClients.Count > 0)
                {
                    PatientList = new string[lstClients.Count];
                    for (int i = 0; i < lstClients.Count; i++)
                    {
                        string[] all = lstClients[i].Name.Split('~');
                        first = all[0];
                        name = name + lstClients[i].Name + "|";

                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(first, name));

                }
                if (lstTest.Count > 0)
                {
                    PatientList = new string[lstTest.Count];
                    for (int i = 0; i < lstTest.Count; i++)
                    {

                        Test = Test + lstTest[i].InvestigationsType + "|";

                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(first, Test));

                }
                if (lstvalues.Count > 0)
                {
                    PatientList = new string[lstvalues.Count];
                    for (int i = 0; i < lstvalues.Count; i++)
                    {

                        Values = Values + lstvalues[i].FOCRemarks + "|";

                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(first, Values));

                }
                if (lstWaters.Count > 0)
                {
                    PatientList = new string[lstWaters.Count];
                    for (int i = 0; i < lstWaters.Count; i++)
                    {

                        Waters = Waters + lstWaters[i].ClientName + "|";

                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(first, Waters));

                }
                if (TempAddrs.Count > 0)
                {
                    PatientList = new string[TempAddrs.Count];
                    for (int i = 0; i < TempAddrs.Count; i++)
                    {

                        Temp = Temp + TempAddrs[i].ReferenceType + "|";

                    }
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(first, Temp));

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }
        return items.ToArray();

    }

    #endregion
    /*************************END*******************************/


    #region Get Test code Items  Added By Jagatheesh

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetTestCodeItems(string prefixText, string contextKey)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<TestWiseAnalyzerReport> lstTestCodeDetails = new List<TestWiseAnalyzerReport>();
        try
        {
            long lresutl = -1;
            int OrgID = 0;
            string Description = prefixText;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            string[] Clientlist = null;
            lresutl = be.GetTestCodeItems(OrgID, Description, out lstTestCodeDetails);
            if (lstTestCodeDetails.Count > 0)
            {
                Clientlist = new string[lstTestCodeDetails.Count];
                for (int i = 0; i < lstTestCodeDetails.Count; i++)
                {
                    string[] all = lstTestCodeDetails[i].Testname.Split('~');
                    string name = all[0];
                    string details = lstTestCodeDetails[i].Testname;
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(name, details));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetTestCodeList For MIS Test Wise Analyzer Report:", ex);
        }
        return items.ToArray();
    }
    #endregion
	
	
    //By Dhana
     [WebMethod(EnableSession = true)]
     [System.Web.Script.Services.ScriptMethod()]
     public object[] GetCollectorNameAutoComp(string Prefix)
     {
         long retCode = -1;
         List<Users> lstCollectors = new List<Users>();
          Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);

         int Orgid = 0;
         List<string> items = new List<string>();
         string[] PatientList = null;
         try
         {


             retCode = ObjBL.GetSampleCollectors(Prefix, Orgid, out lstCollectors);


             return  lstCollectors.ToArray();


             
         }
         catch (Exception ex)
         {
             CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
         }
         return items.ToArray();

     }


	  [WebMethod(EnableSession = true)]
	      [System.Web.Script.Services.ScriptMethod()]

    public List<InvestigationValues> GetPKGQuotationDetails(long ID, string Type)
    {
        List<InvestigationValues> lstinvestigation = new List<InvestigationValues>();
        try
        {
            long returnCode = -1;
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetPKGQuotationDetails(ID, Type, orgID, out lstinvestigation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstinvestigation;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<InvestigationValues> GetPKGQuotationMasterDetails(long ID, string Type)
    {
        List<InvestigationValues> lstinvestigation = new List<InvestigationValues>();
        try
        {
            long returnCode = -1;
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetPKGQuotationMasterDetails(ID, Type, orgID, out lstinvestigation);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstinvestigation;
    }



//By Dhanaselvam
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] GetSampleCollectionHist(int RowID)
    {
        long retCode = -1;
        List<SampleSchedule> lstSampleHist = new List<SampleSchedule>();
        Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);

        int Orgid = 0;
        List<string> items = new List<string>();
        string[] PatientList = null;
        try
        {


            retCode = ObjBL.GetSampleCollectionHist(RowID, out lstSampleHist);
            return lstSampleHist.ToArray();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetSampleCollectionHist Message:", ex);
        }
        return items.ToArray();

    }






    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] pGetListForAutoComp(string prefixText, int count, string contextKey)
    {
        List<Patient> lstQuotationNo = new List<Patient>();
        Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>(lstQuotationNo.Count);
        try
        {
            long retCode = -1;
            int Orgid = 0;
            string Ctrl = "";

            string[] Clientlist = null;
            if (contextKey != null && contextKey != "")
            {
                items.Clear();
                Int32.TryParse(contextKey.Split('~')[0], out Orgid);
                Ctrl = contextKey.Split('~')[1];

                retCode = ObjBL.pGetListForAutoComp(Orgid, prefixText, Ctrl, out lstQuotationNo);
                if (lstQuotationNo.Count > 0)
                {
                    Clientlist = new string[lstQuotationNo.Count];
                    for (int i = 0; i < lstQuotationNo.Count; i++)
                    {
                        string[] all = lstQuotationNo[i].Name.Split('~');
                        string name = all[0];
                        string details = lstQuotationNo[i].Name;
                        items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(name, details));

                    }



                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in pGetListForAutoComp in Op/IpBilling WS:", ex);
        }

        return items.ToArray();
    }
	
        [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<QuotationSampleScheduling> GetpkgSampleDetails(long QuotationID, long InvestigationID, string Type)
    {
        List<QuotationSampleScheduling> lstPkgSample = new List<QuotationSampleScheduling>();
        long returnCode = -1;
        try
        {


            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetpkgSampleDetails(QuotationID, InvestigationID, Type, out lstPkgSample);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreviousVisitBilling Message:", ex);
        }
        return lstPkgSample;
    }

	
   //Added By Gowtham Raj
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
  
    public object[] GetVisitPageGeneration(int OrgID, long ClientID, long CollectedBy,string fdate,string tdate,string VisitNo )
    {
        long retuenCOde = -1;
        Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);
        List<VisitDetailsQuotation> VisitDetailsQuotationlst=new List<VisitDetailsQuotation>();
        List<VisitSheetDetailsQuotation> lstVisitSheetDetailsQuotation=new List<VisitSheetDetailsQuotation>();
        List<VisitSheetDetailsQuotation> lstVisitSheetDetailsTestDeatils = new List<VisitSheetDetailsQuotation>();
        List<object> GetlstDetail = new List<object>();
        try
        {

            retuenCOde = ObjBL.GetVisitPageGeneration(OrgID, Convert.ToDateTime(fdate = fdate == "" ? Convert.ToString((DateTime)System.Data.SqlTypes.SqlDateTime.MinValue) : fdate), Convert.ToDateTime(tdate = tdate == "" ? Convert.ToString(DateTime.Now) : tdate), ClientID, CollectedBy, VisitNo, out VisitDetailsQuotationlst, out lstVisitSheetDetailsQuotation, out lstVisitSheetDetailsTestDeatils);
        }
        catch (Exception ex)
        {
            
            CLogger.LogError("Error in GetVisitPageGeneration(OPIPBilling.asmx.cs) Message:", ex);
        }


        GetlstDetail.Add(VisitDetailsQuotationlst);
        GetlstDetail.Add(lstVisitSheetDetailsQuotation);
        GetlstDetail.Add(lstVisitSheetDetailsTestDeatils);

        return GetlstDetail.ToArray();
    }


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public object[] CreateVisitNoGeneration(List<VisitSheetDetailsQuotation> LstVisitSheetDetailsQuotation, string OrgID)
    {
        long retuenCOde = -1;
        Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);
        List<VisitDetailsQuotation> VisitDetailsQuotationlst=new List<VisitDetailsQuotation>();
        List<VisitSheetDetailsQuotation> lstVisitSheetDetailsQuotation=new List<VisitSheetDetailsQuotation>();
        List<VisitSheetDetailsQuotation> lstVisitSheetListTestPara = new List<VisitSheetDetailsQuotation>();
        string GetVisitNumber = string.Empty;
        List<object> GetlstDetail = new List<object>();
        try
        {
            retuenCOde = ObjBL.CreateVisitPageGeneration(LstVisitSheetDetailsQuotation, out VisitDetailsQuotationlst, out lstVisitSheetDetailsQuotation,out lstVisitSheetListTestPara,  out  GetVisitNumber);
            if (GetVisitNumber!="" && GetVisitNumber!=null)
            {
                new BarcodeHelper().SaveWatersReportBarcode(GetVisitNumber, Convert.ToInt32(OrgID), GetVisitNumber, "WPVN");
            }
            
            //retuenCOde = ObjBL.GetVisitPageGeneration(OrgID, Convert.ToDateTime(fdate = fdate == "" ? DateTime.Now.ToString() : fdate), Convert.ToDateTime(tdate = tdate == "" ? DateTime.Now.Date.ToString() : tdate), ClientID, CollectedBy, out VisitDetailsQuotationlst, out lstVisitSheetDetailsQuotation);
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in CreateVisitNoGeneration(OPIPBilling.asmx.cs) Message:", ex);
        }
        GetlstDetail.Add(VisitDetailsQuotationlst);
        GetlstDetail.Add(lstVisitSheetDetailsQuotation);
        GetlstDetail.Add(GetVisitNumber);
        GetlstDetail.Add(lstVisitSheetListTestPara);
        
        return GetlstDetail.ToArray();


    
    }

   
   
   [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetCollectorNameAutoCompVisit(string prefixText, int count, string contextKey)
    {
        long retCode = -1;
        List<Users> lstCollectors = new List<Users>();
        Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);

        int Orgid = 0;
        List<string> items = new List<string>();
        string[] PatientList = null;
        try
        {


            //  Int32.TryParse(ContextKey.Split('~')[0], out Orgid);

            //retCode = bbl.GetQuickPatientSearchDetails(PatientID, orgID, searchType, out lstPatient);
            retCode = ObjBL.GetSampleCollectors(prefixText, Convert.ToInt32(contextKey), out lstCollectors);    
            if (lstCollectors.Count > 0)
            {
                
                for (int i = 0; i < lstCollectors.Count; i++)
                {

                    string name = lstCollectors[i].Name;
                    string details = Convert.ToString(lstCollectors[i].UserID);
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(name, details));

                }



            }

            return items.ToArray();



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPatientListForQuickBill Message:", ex);
        }
        return items.ToArray();

    }



    //Added by Sree krishna For Waters

   [WebMethod(EnableSession = true)]
   [System.Web.Script.Services.ScriptMethod()]

   public List<PreQuotationInvestigations> GetRegistrationSampleCollect(long QuotationID, int OrgID, long VisitID)
   {
       List<PreQuotationInvestigations> lstinvestigations = new List<PreQuotationInvestigations>();
       long returnCode = -1;
       try
       {


           returnCode = new BillingEngine(new BaseClass().ContextInfo).GetRegistrationSampleCollect(QuotationID, OrgID, VisitID, out lstinvestigations);
       }
       catch (Exception ex)
       {
           CLogger.LogError("Error in OPIP Billing Web Service GetRegistrationSampleCollect Message:", ex);
       }
       return lstinvestigations;
   }




   [WebMethod(EnableSession = true)]
   [System.Web.Script.Services.ScriptMethod()]

   public List<MetaData> LoadQuotationDropDownValues(int OrgID)
   {
       string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;
       long returncode = -1;
       List<MetaData> lstmetadataInput = new List<MetaData>();
       List<MetaData> lstmetadataOutput = new List<MetaData>();
       try
       {
           string domains = "SampleStatus";
           string[] Tempdata = domains.Split(',');
           string LangCode = "en-GB";
           MetaData objMeta;

           for (int i = 0; i < Tempdata.Length; i++)
           {
               objMeta = new MetaData();
               objMeta.Domain = Tempdata[i];
               lstmetadataInput.Add(objMeta);

           }

           returncode = new MetaData_BL(new BaseClass().ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

           
       }
       catch (Exception ex)
       {
           CLogger.LogError("Error while loading Meta Data in OPIP Billing ", ex);
           
       }
       return lstmetadataOutput;

   }





    //END

   [WebMethod(EnableSession = true)]
   [System.Web.Script.Services.ScriptMethod()]
   public long EmailPdfSend(string OrgID, string VisitNo, string Email, string InHtmlBody, string MailDetails)
   {
       long returnCode = -1;
       try
       {
           //ActionManager AM = new ActionManager(new BaseClass().ContextInfo);
           //List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
           //PageContextkey PC = new PageContextkey();
           //PC.RoleID = Convert.ToInt64(RoleID);
           //PC.OrgID = Convert.ToInt32(OrgID);
           //PC.PageID = Convert.ToInt64(PageID);
           //PC.ButtonName = "SendVIDMail";
           //PC.ButtonValue = "SendVIDMail";
           //PC.PatientVisitID = Convert.ToInt64(VisitNo);
           //lstpagecontextkeys.Add(PC);
           //long res = -1;
           //res = AM.PerformingNextStepNotification(PC, "", "");
           string[] DetailsList = null;
           DetailsList = MailDetails.Split('~');
           byte[] ReportByteArr;
           string deviceInfo = null;
           ReportUtil RePdf = new ReportUtil();
           ReportParameter[] reportParameterList = new ReportParameter[3];
           string connectionString = Attune.Podium.Common.Utilities.GetConnectionString();
           reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", OrgID);
           reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("VisitNumber", VisitNo);
           reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
           returnCode = RePdf.RenderReport(reportParameterList, Convert.ToInt32(OrgID), DetailsList[0], "PDF", deviceInfo, out ReportByteArr);

           if (returnCode == 0)
           {               
               List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
               MailAttachment objMailAttachment = new MailAttachment();
               objMailAttachment.ContentStream = new MemoryStream(ReportByteArr);
               objMailAttachment.FileName = DetailsList[3] + ".pdf";
               lstMailAttachment.Add(objMailAttachment);
               MailConfig oMailConfig = new MailConfig();
               ActionManager ObjActionManager = new ActionManager();
               ObjActionManager.GetEMailConfig(Convert.ToInt32(OrgID), out oMailConfig);
               returnCode = Communication.SendMail(Email, string.Empty, string.Empty, DetailsList[1], DetailsList[2], lstMailAttachment, oMailConfig);
           }
           else
           {
               returnCode = -1;

           }       }
       catch (Exception ex)
       {
           CLogger.LogError("Error while Send SendMail", ex);
       }
       return returnCode;
   }
   
    [WebMethod(EnableSession = true)]
   [System.Web.Script.Services.ScriptMethod()]

   public void UpdatepkgSampleDetails(List<VisitSheetDetailsQuotation> LstQuotationSampleScheduling, long QuotationID, int OrgID)
   {
       long returnCode = -1;
       Waters_BL ObjBL = new Waters_BL(new BaseClass().ContextInfo);
    try
       {
           returnCode = ObjBL.UpdatepkgSampleDetails(LstQuotationSampleScheduling, QuotationID, OrgID);

           
       }
       catch (Exception ex)
       {

           CLogger.LogError("Error in UpdatepkgSampleDetails(OPIPBilling.asmx.cs) Message:", ex);
       }
       

   }

 #region GetPreRegistrationDiscountRedeemDetails
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<PreRegistrationDiscountRedeemDetails> GetPreRegistrationDiscountRedeemDetails(long bookingID)
    {
        List<PreRegistrationDiscountRedeemDetails> lstDiscountRedeemDetails = new List<PreRegistrationDiscountRedeemDetails>();
        try
        {
            long returnCode = -1;

            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetPreRegistrationDiscountRedeemDetails(bookingID, out lstDiscountRedeemDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetPreRegistrationDiscountRedeemDetails Message:", ex);
        }
        return lstDiscountRedeemDetails;
    }
    #endregion

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public string GetInvoicePayments(List<Invoice> lstInvID ,string Type)
    {
        long returnCode = -1;
        string json="";
        BillingEngine ObjBL = new BillingEngine(new BaseClass().ContextInfo);
        List<Invoice> lstInvoicepayments = new List<Invoice>();
        List<InvoiceReceipts> lstInvrecipt = new List<InvoiceReceipts>();
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;

        try
        {
            int orgID = 0;
            Int32.TryParse(Session["OrgID"].ToString(), out orgID);
            returnCode = ObjBL.GetInvoicePayments(lstInvID, orgID,Type, out lstInvoicepayments, out lstInvrecipt);
             json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(lstInvoicepayments);
           
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in UpdatepkgSampleDetails(OPIPBilling.asmx.cs) Message:", ex);
        }

        return json;
    }
	
	[WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public object[] GetOrderedItemsForBillEdit(long FinalBillID, long visitID)
    {
        object[] arr = new object[2];
        try
        {
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            List<FinalBill> lstFinalBill = new List<FinalBill>();
            BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
            billingEngineBL.GetOrderedItemsForBillEdit(visitID, out lstBillingDetails, out lstFinalBill, FinalBillID);
            arr[0] = lstBillingDetails;
            arr[1] = lstFinalBill;
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in GetBiilingItemsForEdit(OPIPBilling.asmx.cs) Message:", ex);
        }
        return arr;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetBillingItemsForBillEdit(string prefixText, string contextKey, List<OrderedInvestigations> lstOrderedInvestigations)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            long lresutl = -1;
            int OrgID = 0;
            long ClientID = 0;

            string FeeType = string.Empty, Description = prefixText, IsMappedItem = string.Empty, Remarks = string.Empty;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            FeeType = strValue[0];
            Int64.TryParse(strValue[1], out ClientID);
            IsMappedItem = strValue[2].ToUpper();
            Remarks = strValue[3].ToUpper();
            Gender = strValue[4];

            lresutl = be.GetBillingItemsForBillEdit(OrgID, FeeType, Description, ClientID, IsMappedItem, Remarks, Gender, lstOrderedInvestigations, out lstBillingFeeDetails);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return lstBillingFeeDetails;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetBillingItemsForClientBatch(string prefixText, string contextKey)
    {
        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            long lresutl = -1;
            int OrgID = 0;
            long ClientID = 0;

            string FeeType = string.Empty, Description = prefixText, IsMappedItem = string.Empty, Remarks = string.Empty;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            FeeType = strValue[0];
            Int64.TryParse(strValue[1], out ClientID);
            IsMappedItem = strValue[2].ToUpper();
            Remarks = strValue[3].ToUpper();
            Gender = strValue[4];

            lresutl = be.GetBillingItemsForBillEdit(OrgID, FeeType, Description, ClientID, IsMappedItem, Remarks, Gender, lstOrderedInvestigations, out lstBillingFeeDetails);
            
            if (lstBillingFeeDetails.Count > 0)
            {
                foreach (BillingFeeDetails item in lstBillingFeeDetails)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Descrip, item.ProcedureName));
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return items.ToArray();;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetBillingItemsForTemplate(string prefixText, string contextKey, List<OrderedInvestigations> lstOrderedInvestigations)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<BillingFeeDetails> lstBillingFeeDetails = new List<BillingFeeDetails>();
        try
        {
            long lresutl = -1;
            int OrgID = 0;
            long ClientID = 0;

            string FeeType = string.Empty, Description = prefixText, IsMappedItem = string.Empty, Remarks = string.Empty;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            FeeType = strValue[0];
            Int64.TryParse(strValue[1], out ClientID);
            IsMappedItem = strValue[2].ToUpper();
            Remarks = strValue[3].ToUpper();
            Gender = strValue[4];

            lresutl = be.GetBillingItemsForBillEdit(OrgID, FeeType, Description, ClientID, IsMappedItem, Remarks, Gender, lstOrderedInvestigations, out lstBillingFeeDetails);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return lstBillingFeeDetails;
    }
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public long SaveBillEditDetails(long pOrgID,decimal pGrossBillValue, decimal pDiscountAmount, decimal pNetValue, long pVisitID, long pClientID, long pBillID, List<PatientDueChart> lstPatientDueChart)
    {
        BillingEngine be = new BillingEngine(new BaseClass().ContextInfo);
        long lresutl = -1;
        try
        {


            lresutl = be.SaveBillEditDetails(pOrgID, pGrossBillValue, pDiscountAmount, pNetValue, pVisitID, pClientID, pBillID, lstPatientDueChart);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetBillingItemsForBillEdit Message:", ex);
        }


        return lresutl;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]

    public List<InvSampleMaster> LoadSpecialSamples(String prefixText)
    {
        long returncode = -1;
        List<InvSampleMaster> obj = new List<InvSampleMaster>();
        try
        {
            returncode = new BillingEngine(new BaseClass().ContextInfo).LoadSpecialSamples(prefixText, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in LoadSpecialSamples ", e);

        }
        return obj;
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<InvDeptMaster> GetHistoDeptTestNames(int DeptID)
    {
        long returncode = -1;
        List<InvDeptMaster> obj = new List<InvDeptMaster>();
        try
        {
            returncode = new Investigation_BL(new BaseClass().ContextInfo).GetHistoDeptTestNames(DeptID, out obj);
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while Executing in GetHistoDeptTestNames ", e);

        }
        return obj;
    }
	
    /*BEGIN | Bug ID[NA] | TAT |  | A |  TAT Integration  */
    #region Get Billing Test Items Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingTestFeeDetails> GetBillingTestItemsDetails(int OrgID, int FeeID, string FeeType, string Description, long ClientID, long VisitID, string Remarks, string IsCollected, string CollectedDatetime, string locationName)
    {
        List<BillingTestFeeDetails> lstBillingFeeDetails = new List<BillingTestFeeDetails>();
        try
        {
            DateTime pCollectDatetime = Convert.ToDateTime(CollectedDatetime);
            long returnCode = -1;
            returnCode = new TAT_BL(new BaseClass().ContextInfo).GetBillingTestItemsDetails(OrgID, FeeID, FeeType, Description, ClientID, VisitID, Remarks, IsCollected, pCollectDatetime, locationName, out lstBillingFeeDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetBillingItemsDetails Message:", ex);
        }
        return lstBillingFeeDetails;
    }
    #endregion

    /*END | Bug ID[NA] | TAT |  | A |  TAT Integration  */

 #region SaveHistoSpecimen
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod]
    public long InsertHistoSpecimenDetails(long OrgID, long OrgAddressID, List<HistoSpecimenDetails> lstspec)
    {
        long rcode = -1;
        rcode = new Patient_BL().InsertHistoSpecimenDetails(OrgID, OrgAddressID, lstspec);
        return rcode;
    }

    #endregion



    #region GETHistoSpecimen
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public List<HistoSpecimenDetails> GetHistoSpecimenDetails(long OrgID, long PatientVisitID, long TestID, string Type)
    {
        long rcode = -1;
        List<HistoSpecimenDetails> lHistoSpecimenDetails = new List<HistoSpecimenDetails>();
        rcode = new Patient_BL().GetHistoSpecimenDetails(OrgID, PatientVisitID, TestID, Type, out lHistoSpecimenDetails);
        return lHistoSpecimenDetails;
    }

    #endregion
	
	
	#region Get HCPayment Details
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetHCPaymentDetails(int OrgID, long BookingID)
    {
        List<BillingFeeDetails> lstHCPaymentDetails = new List<BillingFeeDetails>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetHCPayments(OrgID,BookingID, out lstHCPaymentDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service GetHCPaymentDetails Message:", ex);
        }
        return lstHCPaymentDetails;
    }
    #endregion

    #region Get HCTRF file
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<BillingFeeDetails> GetHCTRFfile(long BookingID)
    {
        List<BillingFeeDetails> lstHCTRFfiles = new List<BillingFeeDetails>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetHCTRFfile(BookingID, out lstHCTRFfiles);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service Get a HCTRF file Message : ", ex);
        }
        return lstHCTRFfiles;
    }
    #endregion

    #region Validate HealthHubID
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Patient> ValidateHealthHubID(int OrgID, long BookingID, string HealthHubID, string Name, string DOB, string Gender, 
                                             string Mob, string Email)
    {
        List<Patient> lstHealthHubId = new List<Patient>();
        try
        {
            long returnCode = -1;
            returnCode = new BillingEngine(new BaseClass().ContextInfo).ValidateHealthHubID(OrgID, BookingID, HealthHubID, Name, DOB, Gender, Mob, Email, 
                out lstHealthHubId);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OPIP Billing Web Service ValidateHealthHubID Message : ", ex);
        }
        return lstHealthHubId;
    }
    #endregion
#region GetOrganizations
    [WebMethod(EnableSession = true)]
    public CascadingDropDownNameValue[] GetOrganizationsHome(string knownCategoryValues, string category)
    {
        List<CascadingDropDownNameValue> values = null;
        try
        {
            long loginID = -1;int OrgID =0;
            GateWay gateWay = new GateWay(new BaseClass().ContextInfo);
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            Login objLogin = new Login();
            objLogin.LoginID = loginID;
            List<Role> lstResult = new List<Role>();
            gateWay.GetRoles(objLogin, out lstResult);
            values = new List<CascadingDropDownNameValue>();
            List<CascadingDropDownNameValue> orgExist;
            lstResult = lstResult.FindAll(r=>r.OrgID==OrgID).ToList();//.OrderBy(r => r.OrgName).ToList();
            string orgName = string.Empty;
            foreach (Role objRole in lstResult)
            {
                orgName = String.IsNullOrEmpty(objRole.OrgName) ? objRole.OrgName : objRole.OrgName.Trim();
                orgExist = values.Where(v => v.name == orgName).ToList();
                if (orgExist.Count == 0)
                    values.Add(new CascadingDropDownNameValue(orgName, Convert.ToString(objRole.OrgID), objRole.IsDefault));
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
    #endregion
}

  
