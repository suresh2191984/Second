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


public partial class UserControl_DisplayAllData : BaseControl
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
        string isc = Session["IsCorporateOrg"].ToString();
        if (isc == "N")
        {
           // dvTotal.Attributes.Add("display", "block");
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
                            objBilling.SpecialityID = Convert.ToInt32(colValue.Split('>')[0]);
                            if (colValue.Split('>').Length < 0)
                            {
                                objBilling.DetailsID = Convert.ToInt64(colValue);
                                //colValue.Split('>').Length > 0 ? Convert.ToInt64(colValue.Split('>')[1]) : Convert.ToInt64(colValue.Split('>')[0]);
                            }
                            //else
                            //{
                            //    objBilling.DetailsID = colValue.Split('>').Length > 0 ? Convert.ToInt64(colValue.Split('>')[1]) : Convert.ToInt64(colValue.Split('>')[0]);
                            //}
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
                            if (colValue != "CON" && colValue != "PRO")
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
                }
                if (tempAdd == 0)
                {
                    lstOrderedInvestigations.Add(PatientInves);
                }
            }
        }
        return lstOrderedInvestigations;
    }
}
