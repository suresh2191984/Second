using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;


public partial class Billing_EditBill : BasePage
{


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            hdnfinaldetails.Value = "";
            ClearValue();
        }
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public string SaveEditedData(string pFinalBill)
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
       //Edit_Billing  oEdit_Billing= js.Deserialize<Edit_Billing>(pFinalBill);
       return "";

    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string getBillingdetails(string billRefNo)
    {
        billRefNo = billRefNo.Replace("Edit_", "");
        var cont = new BaseClass().ContextInfo;
        Patient_BL patientBL = new Patient_BL(new BaseClass().ContextInfo);
        List<FinalBill> fb = new List<FinalBill>();
        List<PatientDueChart> pd = new List<PatientDueChart>();


        long FinalBillId = -1;

        patientBL.GetBillingDetailsForEdit(FinalBillId, billRefNo, cont.OrgID, out fb, out pd);
        
        var obj = new Edit_Billing
           {
               finalBills =  fb.Select(c=> new Edit_finalbill(){
               AmountReceived=c.AmountReceived,
               FinalBillID=c.FinalBillID,
               BillNumber=c.BillNumber,
               GrossBillValue=c.GrossBillValue,
               DiscountAmount=c.DiscountAmount,
               Name=c.Name,
               NetValue=c.NetValue,
               PatientAge=c.PatientAge,
               VersionNo=c.VersionNo,
               Type=c.Type,
               Physician=c.BillDate.ToString("MM/dd/yyyy h:mm tt"),
               }).ToList(),
               billindDetails = pd.Select(c=>new Edit_BillingDetails(){
               Amount=c.Amount,
               Description=c.Description,
               DetailsID=c.DetailsID
               }).ToList(),
           };
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(obj);

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<FinalBill> fb = new List<FinalBill>();
        List<PatientDueChart> pd = new List<PatientDueChart>();
        long returncode = -1;
        string BillNo = string.Empty;
        long FinalBillId = -1;


        if (txtBillNo.Text != "")
        {
            BillNo = txtBillNo.Text.Trim();
        }
        returncode = patientBL.GetBillingDetailsForEdit(FinalBillId, BillNo, OrgID, out fb, out pd);

        if ((fb.Count > 0) && (pd.Count > 0))
        {
            lblPatientName.Text = fb[0].Name;
            lblAge.Text = fb[0].PatientAge;
            lblGender.Text = fb[0].Type;
            lblVisitNo.Text = fb[0].VersionNo;
            lblBillNo.Text = fb[0].BillNumber;
            lblBillDate.Text = fb[0].BillDate.ToString("dd/MMM/yyyy h:mm tt");


            lblGrossAmt.Text = Convert.ToString(fb[0].GrossBillValue);
            lblDiscountAmt.Text = Convert.ToString(fb[0].DiscountAmount);
            lblNetAmt.Text = Convert.ToString(fb[0].NetValue);
            lblRecAmt.Text = Convert.ToString(fb[0].AmountReceived);

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returncode = -1;

        JavaScriptSerializer js = new JavaScriptSerializer();
            Edit_Billing oEdit_Billing = js.Deserialize<Edit_Billing>(hdnfinaldetails.Value);

            var patientdue = oEdit_Billing.billindDetails.Select(c => new PatientDueChart()
            {
                Amount = c.Amount,
                Description = c.Description,
                DetailsID = c.DetailsID
            }).ToList();

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);

        returncode = patientBL.pEditPatientBillingByID(OrgID,oEdit_Billing.finalBills[0].FinalBillID,oEdit_Billing.finalBills[0].GrossBillValue,oEdit_Billing.finalBills[0].DiscountAmount, oEdit_Billing.finalBills[0].NetValue,
            oEdit_Billing.finalBills[0].AmountReceived,patientdue);

        ClearValue();

        
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearValue();
    }

    private void ClearValue()
    {
        lblPatientName.Text = string.Empty;
        lblAge.Text = string.Empty;
        lblGender.Text = string.Empty;
        lblVisitNo.Text = string.Empty;
        lblBillNo.Text = string.Empty;
        lblBillDate.Text = string.Empty;
        txtBillNo.Text = string.Empty;

        lblGrossAmt.Text = string.Empty;
        lblDiscountAmt.Text = string.Empty;
        lblNetAmt.Text = string.Empty;
        lblRecAmt.Text = string.Empty;



    }

 }
public class Edit_Billing
{
    public List<Edit_finalbill> finalBills { get; set; }
    public List<Edit_BillingDetails> billindDetails { get; set; }
}

public class Edit_finalbill
{
    public string Name { get; set; }
    public string PatientAge { get; set; }
    public string VersionNo { get; set; }
    public string BillNumber { get; set; }
    public string Physician { get; set; }
    public decimal  GrossBillValue { get; set; }
    public decimal  DiscountAmount { get; set; }
    public decimal  NetValue { get; set; }
    public decimal  AmountReceived { get; set; }
    public long FinalBillID { get; set; }
    public string Type { get; set; }
}

public class Edit_BillingDetails
{
    public string Description { get; set; }
    public decimal Amount { get; set; }
    public long DetailsID { get; set; }

}



