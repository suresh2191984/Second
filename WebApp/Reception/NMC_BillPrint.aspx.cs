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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Reception_NMC_BillPrint : BasePage
{

    string pBillID=string.Empty;
    int pOrgID;
    decimal pPreviousDue = 0;
    string pDrName = string.Empty;
    string pHospitalName = string.Empty;
    string pCCName = string.Empty;
    string pPatientName = string.Empty;
    string PrintString = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pBillID=Request.QueryString["billNo"].ToString();
            if (!IsPostBack)
            {
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void LoadBillDetails()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            List<BillMaster> billMaster = new List<BillMaster>();
            List<BillLineItems> billLineItems = new List<BillLineItems>();
            List<PatientVisit> labVisitDetails = new List<PatientVisit>();
            List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
            string pAge = string.Empty;
            string pSex = string.Empty;
            //imgBillLogo.ImageUrl ="D:/Apr23/Rev2087DDC/Solution/WebApp/Images/Logo/Es.PNG" ;// "~images/Logo/Es.png";
            patientVisitBL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
            // orgHeaderRD.InnerHtml = "<font style='font-size:16px;'><b>" + OrgName + "</b></font>  <br/> " + lstOrganizationAddress[0].Add1 + lstOrganizationAddress[0].Add2 + "<br/>" + lstOrganizationAddress[0].City + lstOrganizationAddress[0].PostalCode + "<br/>" + lstOrganizationAddress[0].LandLineNumber + " " + lstOrganizationAddress[0].MobileNumber;
            retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out labVisitDetails);
           lbBillNo.Text = pBillID.ToString();
            lbVisitno.Text = billMaster[0].VisitID.ToString();
            lblDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
           lblName.Text = labVisitDetails[0].PatientName;
           lblDRName.Text = labVisitDetails[0].ReferingPhysicianName;
            lbage.Text = labVisitDetails[0].PatientAge;
            lbsex.Text = labVisitDetails[0].Sex;
           lbHospitalName.Text = labVisitDetails[0].HospitalName;
           gvBillingDetail.DataSource = billLineItems;
           lblBillExName.Text = labVisitDetails[0].AccompaniedBy;
           gvBillingDetail.DataBind();
            if (labVisitDetails[0].CollectionCentreName != null)
            {
                trCC.Style.Add("Display", "block");
                lbCollectionCentre.Text = labVisitDetails[0].CollectionCentreName;
            }
            lblsignature1.Text = "<b>Authorised Signature(for NMC-SKY Imaging & Diagnostic Center)</b>";
            if (billMaster[0].IsCredit == "Y")
            {

                lblBillType.Text = "Credit Bill";
            }
            if (billMaster[0].Status != null)
            {
                if (billMaster[0].Status.Trim() == "C")
                {
                    referenceIndicator.Style.Add("display", "block");
                    lblReferenceIndicator.Text = billMaster[0].Comments;
                    lblBillType.Text = "Cancelled Bill";
                }
            }

            lblGrossAmount.Text = billMaster[0].GrossAmount.ToString();
            lblDiscount.Text = billMaster[0].Discount.ToString();
            lblTax.Text = billMaster[0].TaxPercent.ToString();
            if (labVisitDetails[0].PreviousDue != 0 && billMaster[0].Type != "DUE" && billMaster[0].Type != "COR")
            {
                trdueline.Visible = true;
                trPreviousDue.Visible = true;
                //PreviousDue.Visible = true;
                lblPreviousDue.Text = String.Format("{0:0.00}", Convert.ToDouble(labVisitDetails[0].PreviousDue));
            }

            lblNetValue.Text = billMaster[0].NetAmount.ToString();
            lblAmountRecieved.Text = billMaster[0].AmountReceived.ToString();
            if (billMaster[0].AmountDue != 0)
            {
                trdueline.Visible = true;
                trPreviousDue.Visible = true;
                lblPreviousDue.Text = billMaster[0].AmountDue.ToString();
            }
            
            if (billMaster[0].Comments != "")
            {
                referenceIndicator.Style.Add("display", "block");
                lblReferenceIndicator.Text = billMaster[0].Comments;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
}
