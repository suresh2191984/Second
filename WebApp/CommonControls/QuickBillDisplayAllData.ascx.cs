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

public partial class CommonControls_QuickBillDisplayAllData : BaseControl
{
    List<PaymentType> lstPaymentType = new List<PaymentType>();
    long visitID = 0;

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
        if (hdfBillType.Value != null)
            prescription = hdfBillType.Value.ToString();

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

                    switch (colName)
                    {
                        case "FeeID":
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;
                        case "OtherID":
                            objBilling.DetailsID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            objBilling.Description = colValue;
                            break;
                        case "Amount":
                            objBilling.Amount = Convert.ToDecimal(colValue);
                            break;
                        case "Quantity":
                            objBilling.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            objBilling.FeeType = colValue;
                            break;
                        case "PhyLID":
                            objBilling.UserID = Convert.ToInt64(colValue);
                            break;
                        case "SpecID":
                            objBilling.SpecialityID = Convert.ToInt32(colValue);

                            //if (colValue == feeType)
                            //{
                            //    tempAdd = 0;
                            //}
                            //else
                            //{
                            //    tempAdd = 1;
                            //}
                            break;
                    };
                }
                //if (tempAdd == 0)
                //{
                objBilling.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objBilling.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objBilling.Status = "Paid";
                lstPatientDueChart.Add(objBilling);
                //}
            }
        }
        return lstPatientDueChart;
    }

    public List<OrderedInvestigations> GetOrderedInvestigations()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        long tempAdd = 0;
        OrderedInvestigations PatientInves;
        if (hdfBillType.Value != null)
            prescription = hdfBillType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
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

                    switch (colName)
                    {
                        case "FeeID":
                            PatientInves.ID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            PatientInves.Name = colValue;
                            break;
                        case "Amount":
                            PatientInves.Rate = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            if (colValue != "CON" && colValue != "PRO" && colValue != "PRM" && colValue != "GBI")
                            {
                                tempAdd = 0;
                            }
                            else
                            {
                                tempAdd = 1;
                            }
                            PatientInves.Type = colValue;
                            break;
                    };

                    PatientInves.Status = "Paid";
                    PatientInves.CreatedBy = LID;
                    PatientInves.PaymentStatus = "Paid";
                    PatientInves.VisitID = visitID;
                    PatientInves.OrgID = OrgID;
                    PatientInves.StudyInstanceUId = CreateUniqueDecimalString();
                }
                if (tempAdd == 0)
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
}
