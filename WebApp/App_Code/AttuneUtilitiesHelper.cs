using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;
using Attune.Podium.BusinessEntities;

/// <summary>
/// Summary description for AttuneUtilitiesHelper
/// </summary>
/// 
/// 

namespace Attune.Utilitie.Helper
{
    public static class AttuneUtilitieHelper
    {
        public static void GetRedirectURL(QueryMaster objQueryMster, out string StrQueryString)
        {
            StrQueryString = "";
            string QueryString = "";
            Hashtable QueryValue = new Hashtable();
            QueryString = objQueryMster.Querystring;
            if (!String.IsNullOrEmpty(QueryString))
            {
                QueryValue.Add("PatientID", objQueryMster.PatientID);
                QueryValue.Add("PatientVisitID", objQueryMster.PatientVisitID);
                QueryValue.Add("ViewType", objQueryMster.ViewType);
                QueryValue.Add("PatientName", objQueryMster.PatientName);
                QueryValue.Add("SPatientName", objQueryMster.SPatientName);
                QueryValue.Add("DateOfBirth", objQueryMster.DateOfBirth);
                QueryValue.Add("InPatientNo", objQueryMster.InPatientNo);
                QueryValue.Add("CellNo", objQueryMster.CellNo);
                QueryValue.Add("Purpose", objQueryMster.Purpose);
                QueryValue.Add("ADMCancelStatus", objQueryMster.ADMCancelStatus);
                QueryValue.Add("RateValue", objQueryMster.RateValue);
                QueryValue.Add("FinalBillID", objQueryMster.FinalBillID);
                QueryValue.Add("BillingDate", objQueryMster.BillingDate);
                QueryValue.Add("StatusValue", objQueryMster.StatusValue);
                QueryValue.Add("ServiceValue", objQueryMster.Servicevalue);
                QueryValue.Add("specialityID", objQueryMster.SpecialityID);
                QueryValue.Add("ReferID", objQueryMster.ReferID);
                QueryValue.Add("ReferringType", objQueryMster.ReferringType);
                QueryValue.Add("PatientNumber", objQueryMster.PatientNumber);
                QueryValue.Add("RoomNo", objQueryMster.RoomNo);
                QueryValue.Add("IPBPValue", objQueryMster.IPBPValue);
                QueryValue.Add("DDLvalue", objQueryMster.DDLvalue);
                QueryValue.Add("PatNumber", objQueryMster.PatNumber);
                QueryValue.Add("BillNumber", objQueryMster.BillNumber);
                QueryValue.Add("CreditValue", objQueryMster.CreditValue);
                QueryValue.Add("Surgery", objQueryMster.Surgery);
                QueryValue.Add("BillTypeValue", objQueryMster.BillTypeValue);
                QueryValue.Add("PODValue", objQueryMster.PODValue);
                QueryValue.Add("IntendID", objQueryMster.IntendID);
                QueryValue.Add("LocID", objQueryMster.LocID);
                QueryValue.Add("RecvOrgID", objQueryMster.RecvOrgID);
                QueryValue.Add("IdentityValue", objQueryMster.IdentityValue);
                QueryValue.Add("GridViewValue", objQueryMster.GridViewValue);
                QueryValue.Add("SupplierValue", objQueryMster.SupplierValue);
                QueryValue.Add("QuotationValue", objQueryMster.QuotationValue);
                QueryValue.Add("PPatientVisitID", objQueryMster.PPatientVisitID);
                QueryValue.Add("CountValue", objQueryMster.CountValue);
                QueryValue.Add("SecuredCode", objQueryMster.SecuredCode);
                QueryValue.Add("ProcedureID", objQueryMster.ProcedureID);
                QueryValue.Add("EmployeeNo", objQueryMster.EmployeeNo);
                QueryValue.Add("PhysicianID", objQueryMster.PhysicianID);
                QueryValue.Add("TaskID", objQueryMster.TaskID);
                QueryValue.Add("KitIdentity", objQueryMster.KitIdentity);
                QueryValue.Add("MasterIdentity", objQueryMster.MasterIdentity);
                QueryValue.Add("KitBatchNumber", objQueryMster.KitBatchNumber);
                QueryValue.Add("LoginID", objQueryMster.LoginID);
                QueryValue.Add("PORequestID", objQueryMster.PORequestID);
                QueryValue.Add("PrescriptionNo", objQueryMster.PrescriptionNo);
                QueryValue.Add("ActionCode", objQueryMster.actionCode);
                QueryValue.Add("SearchTypeID", objQueryMster.searchtype);
                QueryValue.Add("GuId", objQueryMster.GuId);
                QueryValue.Add("SampleCollectAgain", objQueryMster.SampleCollectAgain);
                QueryValue.Add("SampleID", objQueryMster.SampleID);
                QueryValue.Add("OrgID", objQueryMster.OrgID);
                QueryValue.Add("PrintAgain", objQueryMster.PrintAgain);
                QueryValue.Add("CategoryCode", objQueryMster.CategoryCode);
                QueryValue.Add("InvoiceID", objQueryMster.InvoiceID);
                QueryValue.Add("InvoiceNO", objQueryMster.InvoiceNO);
                QueryValue.Add("ClientID", objQueryMster.ClientID);
                QueryValue.Add("CName", objQueryMster.CName);
                QueryValue.Add("FrmDate", objQueryMster.FrmDate);
                QueryValue.Add("ToDate", objQueryMster.ToDate);
                QueryValue.Add("PageID", objQueryMster.PageID);
                QueryValue.Add("TaskActionID", objQueryMster.TaskActionID);
                QueryValue.Add("AccessionNumber", objQueryMster.AccessionNumber);
                QueryValue.Add("TestID", objQueryMster.TestID);
                QueryValue.Add("Invid", objQueryMster.Invid);
                QueryValue.Add("Status", objQueryMster.Status);

                foreach (string key in QueryValue.Keys)
                {
                    if (QueryString.Contains("{" + key + "}"))
                    {
                        QueryString = QueryString.Replace("{" + key + "}", (QueryValue[key] == null ? string.Empty : Convert.ToString(QueryValue[key])));
                    }
                }
                StrQueryString = QueryString;
            }
            
        }


        public static string ToWordWrap(this string strWordWarp, int WordLength, out int strLineCount)
        {

            strLineCount = 0;
            int strTotalCount = WordLength;
            int strStratCount = 0;

            int strLength = strWordWarp.Length;

            string strReturnValue = "";
            while (strTotalCount < strLength)
            {
                while (strWordWarp[strTotalCount] != ' ' && strTotalCount > strStratCount)
                {
                    strTotalCount = strTotalCount - 1;
                }
                if (strTotalCount == strStratCount)
                {
                    strTotalCount = strStratCount + WordLength;
                }
                strReturnValue += strWordWarp.Substring(strStratCount, strTotalCount - strStratCount) + "</br>";
                strLineCount += 1;
                strStratCount = strTotalCount + 1;
                strTotalCount = strStratCount + WordLength;
            }
            if (strStratCount < strLength)
            {
                strReturnValue += strWordWarp.Substring(strStratCount);
                strLineCount += 1;
            }
            return strReturnValue;
        }
    }
}
