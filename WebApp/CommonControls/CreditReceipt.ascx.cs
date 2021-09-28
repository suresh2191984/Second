using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class CommonControls_CreditReceipt :BaseControl
{
    List<BillingDetails> lstPatientBilling = new List<BillingDetails>();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected long _PatientID = 0;

    public long PatientID
    {
        get { return _PatientID; }
        set { _PatientID = value; }
    }
    protected long _VisitID = 0;

    public long VisitID
    {
        get { return _VisitID; }
        set { _VisitID = value; }
    }

    protected long _VisitCount = 0;

    public long VisitCount
    {
        get { return _VisitCount; }
        set { _VisitCount = value; }
    }

    protected string _Status = "";
    
    public void SetBillDetails()
    {
        PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);
     
        List<Patient> lstPatient = new List<Patient>();
        long retCode = -1;
        decimal pAmountReceived = 0;
        decimal pGrandTotal = 0;
        decimal pServiceCharge = 0;
        retCode = objPatientVisitBL.GetInPatientBills(PatientID, OrgID,
                                           VisitID,
                                           out lstPatientBilling,
                                           out lstPatient,
                                           out pAmountReceived, 
                                           out pGrandTotal,out pServiceCharge);
        var Billdetails = from BDetails in lstPatientBilling
                          where BDetails.IsCreditBill == "Y" 
                          select BDetails;
   
        gvBillingDetail.DataSource = Billdetails;
        gvBillingDetail.DataBind();

        VisitCount = gvBillingDetail.Rows.Count;
        decimal dgrandTotal = 0;
        decimal dTempAmount = 0;

        foreach (GridViewRow rows in gvBillingDetail.Rows)
        {
            Decimal.TryParse(rows.Cells[4].Text, out dTempAmount);
            dgrandTotal += dTempAmount;
        }

        lblGrandTotal.Text = dgrandTotal.ToString();
       // ViewState.Add("DK", lstPatientBilling);

        if (lstPatient.Count > 0)
        {
            lblName.Text = lstPatient[0].Name;
            lblPatientNumber.Text = lstPatient[0].PatientNumber;
            lblAge.Text = lstPatient[0].Age.ToString();

             
            if (lstPatient[0].SEX.ToString() == "M")
            {
                lblSex.Text = "Male";
            }
            else
            {
                lblSex.Text = "Female";
            }
            lblAdmission.Text = lstPatient[0].RegistrationDTTM.ToString("dd/MM/yyyy hh:mm tt");

            //lblGrandTotal.Text = pGrandTotal.ToString();

            lblInvoiceDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");

        }
    }


    public List<PatientDueChart> GetBillDetails()
    {
        List<PatientDueChart> lstPatientBillingDetails = new List<PatientDueChart>();
        // _PatientBillingDetails = (List<BillingDetails>)ViewState["DK"];
          
         foreach (GridViewRow row in gvBillingDetail.Rows)
         {
             PatientDueChart _PatientBillingDetails = new PatientDueChart();
             _PatientBillingDetails.DetailsID = Convert.ToInt64(row.Cells[0].Text);
             _PatientBillingDetails.Status = "Printed";
             _PatientBillingDetails.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
             _PatientBillingDetails.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
             lstPatientBillingDetails.Add(_PatientBillingDetails);
         }
         return lstPatientBillingDetails;
    }

    protected void gvBillingDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
    }
}
