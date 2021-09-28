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

public partial class Admin_PrintBill : BasePage
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
            pBillID=Convert.ToString(Request.QueryString["billNo"]);
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
            patientVisitBL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
            orgHeaderRD.InnerHtml = "<font style='font-size:16px;'><b>" + OrgName + "</b></font>  <br/> " + lstOrganizationAddress[0].Add1 + lstOrganizationAddress[0].Add2 + "<br/>" + lstOrganizationAddress[0].City + lstOrganizationAddress[0].PostalCode + "<br/>" + lstOrganizationAddress[0].LandLineNumber + " " + lstOrganizationAddress[0].MobileNumber;
                 retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out labVisitDetails);         
                 BillNo.Text = pBillID.ToString();
                 VisitNo.Text = billMaster[0].VisitID.ToString();
                 BillDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
                 PatientName.Text = labVisitDetails[0].PatientName;
                 DrName.Text = labVisitDetails[0].ReferingPhysicianName;
                 ltAge.Text = labVisitDetails[0].PatientAge;
                 ltSex.Text = labVisitDetails[0].Sex;
                 HospitalName.Text = labVisitDetails[0].HospitalName;
                 if (labVisitDetails[0].CollectionCentreName != null)
                 {
                     trCC.Style.Add("Display", "block");
                     CollectionCentre.Text = labVisitDetails[0].CollectionCentreName;
                 }
                 ltSignature.Text = "<b>Authorised Signature(for "+OrgName+")</b>";
                 if (billMaster[0].IsCredit == "Y")
                 {
                    
                     lblBillType.Text = "Credit Bill";
                 }
                 if (billMaster[0].Status != null)
                 {
                     if (billMaster[0].Status.Trim() == "C")
                     {
                         referenceIndicator.Style.Add("display", "block");
                         litReferenceIndicator.Text = billMaster[0].Comments;
                         lblBillType.Text = "Cancelled Bill";
                     }
                 }
           
            foreach (BillLineItems items in billLineItems)
            {
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = items.ItemName;
                cell2.Attributes.Add("align", "right");
                cell2.Text = items.Quantity.ToString();
                cell3.Attributes.Add("align", "right");
                cell3.Text = items.Rate.ToString();
                cell4.Attributes.Add("align", "right");
                cell4.Text = items.Amount.ToString();
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                row.Cells.Add(cell4);
                billItemsTab.Rows.Add(row);
            }
           
                
                 GrossAmount.Text = billMaster[0].GrossAmount.ToString();
                 Discount.Text = billMaster[0].Discount.ToString();
                 TaxPercent.Text = billMaster[0].TaxPercent.ToString();
                 if (labVisitDetails[0].PreviousDue != 0 && billMaster[0].Type != "DUE" && billMaster[0].Type != "COR")
                 {
                     ColPreviousDue.Visible = true;
                     PreviousDue.Visible = true;
                     PreviousDue.Text = String.Format("{0:0.00}", Convert.ToDouble(labVisitDetails[0].PreviousDue));
                 }

                 NetAmount.Text = billMaster[0].NetAmount.ToString();
                 AmountReceived.Text = billMaster[0].AmountReceived.ToString();
                 AmountDue.Text = billMaster[0].AmountDue.ToString();
                 if (billMaster[0].Comments != "")
                 {
                     referenceIndicator.Style.Add("display", "block");
                     litReferenceIndicator.Text = billMaster[0].Comments;
                 }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
  
}
