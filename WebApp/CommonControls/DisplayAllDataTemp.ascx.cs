using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Text;
using System.Security.Cryptography;

public partial class UserControl_DisplayAllDataTemp : BaseControl
{
    List<PaymentType> lstPaymentType = new List<PaymentType>();
   
    long retval = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptReference srf = new ScriptReference();

        this.Page.RegisterStartupScript("Paymentscrpt", "<script>CreatePaymentTablesDaD();</script>");
        if (!IsPostBack)
        {
             
             
        }
    }

    public List<PatientDueChart> GetConsNProDetails()//string feeType)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        //long tempAdd=0;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();

        PatientDueChart objBilling;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();
        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {
            objBilling = new PatientDueChart();
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
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;
                        case "OtherID":
                            objBilling.SpecialityID = Convert.ToInt32(colValue.Split('>')[0] == "" ? "0" : colValue.Split('>')[0]);
                            objBilling.UserID = colValue.Split('>').Length > 0 ? Convert.ToInt64((colValue.Split('>')[1] == "" ? "0" : colValue.Split('>')[1])) : Convert.ToInt64(colValue.Split('>')[0] == "" ? "0" : colValue.Split('>')[0]);
                            break;
                        case "Descrip":
                            objBilling.Description = colValue;
                            break;
                     
                           
                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Amount = Convert.ToDecimal(colValue);
                            break;
                        case "Quantity":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            if (colValue.ToUpper() == "LAB")
                            {
                                colValue = "INV";
                            }
                            objBilling.FeeType = colValue;
                            break;
                        case "DTime":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt") : colValue;
                            objBilling.FromDate = Convert.ToDateTime(colValue);
                            objBilling.ToDate = Convert.ToDateTime(colValue);
                            break;
                        case "IsReimbursable":
                            if (colValue == "Yes")
                            {
                                objBilling.IsReimbursable = "Y";
                            }
                            else
                            {
                                objBilling.IsReimbursable = "N";
                            }
                            
                            break;
                        case "DisorEnhpercent":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.DiscountPercent = Convert.ToDecimal(colValue);
                            break;
                        case "DisorEnhType":

                            objBilling.DiscOrEnhanceType = colValue;
                            break;
                        case "Remarks":
                          
                            objBilling.Remarks = colValue;
                            break;
                        case "refType":
                            objBilling.ReferenceType = colValue;
                            break;
                        case "refPhyID":
                            if (colValue != null && colValue != "")
                            {
                                objBilling.RefPhysicianID = Int64.Parse(colValue);
                            }
                            break;
                        case "refPhyName":
                            objBilling.RefPhyName = colValue;
                            break;
                    };
                    objBilling.Status = "Paid";
                }
                //if (tempAdd == 0)
                //{
                    lstPatientDueChart.Add(objBilling);
                //}
            }
        }
        return lstPatientDueChart;
    }

    public List<OrderedInvestigations> GetOrderedInvestigations(long visitID, out string gUID)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        gUID = Guid.NewGuid().ToString();

        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        //long tempAdd = 0;
        OrderedInvestigations PatientInves;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();

        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
         string sVal = GetConfigValue("SampleCollect", OrgID);
       
        foreach (string row in sNewDatas.Split('|'))
        {
            PatientInves = new OrderedInvestigations();
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

                    //"RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "";
                    colValue = colValue.Trim();

                    switch (colName)
                    {
                        case "FeeID":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.ID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            PatientInves.Name = colValue;
                            break;
                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.Rate = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            //if (colValue != "CON" && colValue != "PRO")
                            //{
                                //tempAdd = 0;
                            //}
                            //else
                            //{
                            //    tempAdd = 1;
                            //}
                            PatientInves.Type = colValue;
                            break;
                        case "refType":
                            PatientInves.ReferenceType = colValue;
                            break;
                        case "refPhyID":
                            if (colValue != null && colValue != "")
                            {
                                PatientInves.RefPhysicianID = Int64.Parse(colValue);
                            }
                            break;
                        case "refPhyName":
                            PatientInves.RefPhyName = colValue;
                            break;


                    };
                  
                }
                //if (tempAdd == 0)
                //{
                    PatientInves.UID = gUID;
                    PatientInves.StudyInstanceUId = CreateUniqueDecimalString();
                    PatientInves.VisitID = visitID;
                    PatientInves.OrgID = OrgID;
                    PatientInves.PaymentStatus = "Paid";
                    if (sVal.Trim() == "N")
                    {
                        PatientInves.Status = "Paid";
                    }
                    if (PatientInves.Type == "INV" || PatientInves.Type == "GRP" || PatientInves.Type == "PKG")
                    {
                        lstOrderedInvestigations.Add(PatientInves);
                    }
            }
        }
        return lstOrderedInvestigations;
    }

    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
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

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    public List<PatientDueChart> GetIPBillingDetails(string pStatus)//)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        //long tempAdd=0;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();

        PatientDueChart objBilling;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();
        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {
            objBilling = new PatientDueChart();
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
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;
                        case "OtherID":
                            objBilling.SpecialityID = Convert.ToInt32(colValue.Split('>')[0] == "" ? "0" : colValue.Split('>')[0]);
                            objBilling.UserID = colValue.Split('>').Length > 0 ? Convert.ToInt64((colValue.Split('>')[1] == "" ? "0" : colValue.Split('>')[1])) : Convert.ToInt64(colValue.Split('>')[0] == "" ? "0" : colValue.Split('>')[0]);
                            break;
                        case "Descrip":
                            objBilling.Description = colValue;
                            break;
                       
                            
                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Amount = Convert.ToDecimal(colValue);
                            break;
                        case "Quantity":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            if (colValue.ToUpper() == "LAB")
                            {
                                colValue = "INV";
                            }
                            objBilling.FeeType = colValue;
                            break;
                        case "DTime":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt") : colValue;
                            objBilling.FromDate = Convert.ToDateTime(colValue);
                            objBilling.ToDate = Convert.ToDateTime(colValue);
                            break;
                        case "IsReimbursable":
                            if (colValue == "Yes")
                            {
                                objBilling.IsReimbursable = "Y";
                            }
                            else
                            {
                                objBilling.IsReimbursable = "N";
                            }

                            break;
                        case "DisorEnhpercent":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.DiscountPercent =Convert.ToDecimal(colValue);
                            break;
                        case "DisorEnhType":
                            
                            objBilling.DiscOrEnhanceType = colValue;
                            break;
                        case "Remarks":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Remarks =colValue;
                            break;
                        case "ReimbursableAmount":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.ReimbursableAmount = Convert.ToDecimal(colValue);
                            break;
                        case "NonReimbursableAmount":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.NonReimbursableAmount = Convert.ToDecimal(colValue);
                            break;

                    };
                   
                }
                objBilling.Status = pStatus;
                //if (tempAdd == 0)
                //{
                lstPatientDueChart.Add(objBilling);
                //}
            }
        }
        return lstPatientDueChart;
    }

    public List<PatientReferringDetails> GetPatientReferringDetails()//string feeType)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        //long tempAdd=0;
        List<PatientReferringDetails> lstPatientReferringDetails = new List<PatientReferringDetails>();

        PatientReferringDetails objBilling;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();
        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {
            objBilling = new PatientReferringDetails();
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
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            objBilling.Description = colValue;
                           break;
                        case "Perphyname":
                            objBilling .Perphyname =colValue ;
                            break;
                         
                        case "PerphyID":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.PerphyID = Convert.ToInt64(colValue);
                            break;
                        case "Comments":
                            objBilling.Comments="0";
                            break;
                                              
                        case "FeeType":
                            if (colValue.ToUpper() == "LAB")
                            {
                                colValue = "INV";
                            }
                            objBilling.FeeType = colValue;
                            break;
                        case "refType":
                            objBilling.ReferenceType = colValue; ;
                            break;
                        case "refPhyName":
                            objBilling.RefPhyName = colValue;
                            break;
                        case "refPhyID":
                            objBilling.RefPhysicianID = Convert.ToInt64(colValue);
                            break;
                        
                    };
                }
                //if (tempAdd == 0)
                //{
                lstPatientReferringDetails.Add(objBilling);
                //}
            }
        }
        return lstPatientReferringDetails;
    }

   
    
}
