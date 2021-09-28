using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;

public partial class CommonControls_SurgeryAdvance : BaseControl
{

    long _lVisitID = 0;
    long _lPatientID = 0;
    public long lVisitID
    {
        get
        {
            return _lVisitID;
        }
        set
        {
            _lVisitID = value;
        }
    }
    public long lPatientID
    {
        get
        {
            return _lPatientID;
        }
        set
        {
            _lPatientID = value;
        }
    }
    
    List<PaymentType> lstPaymentType = new List<PaymentType>();
    BillingEngine objBillingEngine ;
    long retval = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        ScriptReference srf = new ScriptReference();

        this.Page.RegisterStartupScript("Paymentscrpt", "<script>CreatePaymentTables();</script>");
        if (!IsPostBack)
        {
            ddlPaymentType.Items.Clear();
//            retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
            if (lstPaymentType.Count > 0)
            {
                ddlPaymentType.DataSource = lstPaymentType;
                ddlPaymentType.DataTextField = "PaymentName";
                ddlPaymentType.DataValueField = "PaymentTypeID";
                ddlPaymentType.DataBind();
            }
            ddlPaymentType.Items.Insert(0, new ListItem("-- Select --", "0"));
        }
    }

    public DataTable GetAmountReceivedDetails()
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;

        System.Data.DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("AmtReceived");
        DataColumn dbCol2 = new DataColumn("TypeID");
        DataColumn dbCol3 = new DataColumn("ChequeorCardNumber");
        DataColumn dbCol4 = new DataColumn("BankNameorCardType");
        DataColumn dbCol5 = new DataColumn("Remarks");
        DataColumn dbCol6 = new DataColumn("AdvanceTypeID");
        DataColumn dbCol7 = new DataColumn("AdvanceType");
        DataColumn dbCol8 = new DataColumn("ServiceCharge");
              

        //add columns
        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);
        dt.Columns.Add(dbCol4);
        dt.Columns.Add(dbCol5);
        dt.Columns.Add(dbCol6);
        dt.Columns.Add(dbCol7);
        dt.Columns.Add(dbCol8);

        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;
        DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                AmountReceivedDetails amtReceived = new AmountReceivedDetails();
                dr = dt.NewRow();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    //"RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "";
                
                    switch (colName)
                    {
                        case "TotalAmount":
                            dr["AmtReceived"] = Convert.ToDecimal(colValue); ;
                            break;
                        case "PaymentTypeID":
                            dr["TypeID"] = Convert.ToInt32(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            dr["ChequeorCardNumber"] = (colValue);
                            break;
                        case "PaymentBank":
                            dr["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            dr["Remarks"] = colValue;
                            break;
                        case "SurgeryDetailID":
                            dr["AdvanceTypeID"] = Convert.ToInt32(colValue);
                            dr["AdvanceType"] = "SOI";
                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            dr["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                                              
                    };
                }
                dt.Rows.Add(dr);
            }
        }
        return dt;
    }
    public void BindSurgeryDetailForAdvanceByVisitID()
    {
        IP_BL ipBL = new IP_BL(base.ContextInfo);
        List<PatientDueChart> lstSurgeryDetailForAdvance = new List<PatientDueChart>();
        ipBL.BindSurgeryDetailForAdvanceByVisitID(lVisitID, out lstSurgeryDetailForAdvance);
        if (lstSurgeryDetailForAdvance.Count > 0)
        {
            tbAdvance.Style.Add("display", "block");
            gvTreatment.DataSource = lstSurgeryDetailForAdvance;
            gvTreatment.DataBind();
        }
    }

    protected void gvTreatment_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            PatientDueChart o = (PatientDueChart)e.Row.DataItem;
            string strScript = "SelectRdoValues('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + o.FeeID + "~" + o.Description + "');";           
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);


        }
    }

    public void ClearControls()
    {
        hdfPaymentType.Value = "";
    }

    
}
