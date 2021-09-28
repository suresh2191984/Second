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
using System.Collections.Specialized;
using Attune.Utilitie.Helper;

public partial class Reception_PrintBill : BasePage
{
    public Reception_PrintBill()
        : base("Reception\\PrintBill.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

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
                LoadBillConfigMetadata(OrgID, ILocationID);
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {
           
        }
    }
    public void LoadBillDetails()
    {

        string strAmount = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_01 == null ? "This amount is subject to " : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_01;
        string gst = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_02 == null ? "% GST" : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_02;
        string strAuthorised = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_03 == null ? "<b>Authorised Signature(for" : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_03;
        string strBr = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_04 == null ? ")</b>" : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_04;
        string strCreditBill = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_05 == null ? "Credit Bill" : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_05;
        string StrCancelledBill = Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_06 == null ? "Cancelled Bill" : Resources.Reception_ClientDisplay.Reception_PrintBill_aspx_06;
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
           // patientVisitBL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
            //orgHeaderRD.InnerHtml = "<font style='font-size:16px;'><b>" + OrgName + "</b></font>  <br/> " + lstOrganizationAddress[0].Add1 + lstOrganizationAddress[0].Add2 +"<br/>"+ lstOrganizationAddress[0].City + lstOrganizationAddress[0].PostalCode + "<br/>"+lstOrganizationAddress[0].LandLineNumber +" "+ lstOrganizationAddress[0].MobileNumber;
                 retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out labVisitDetails);
                string IsBillWithBarcode = GetConfigValue("PrintBillBarcode", OrgID);
                if (IsBillWithBarcode == "Y")
                {
                    tbrBarCode.Visible = true;
                    imbbarcode.ImageUrl = "../admin/userImageHandler.ashx?isBarCode=Y&key=" + " " + "&val=" + Convert.ToString(pBillID) + "&showCodeString=" + false;
                }
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
                 string IsTaxdisclaimer = string.Empty;
                 IsTaxdisclaimer = GetConfigValue("Taxdisclaimer", OrgID);
                 if (!String.IsNullOrEmpty(IsTaxdisclaimer))
                 {
                     if (IsTaxdisclaimer == "Y")
                     {
                         if (labVisitDetails[0].PayerID == 1)
                         {
                             // trTaxDetails.Attributes.Add("display", "block");
                             lblTaxDetails.Visible = true;
                            // lblTaxDetails.Text = "This amount is subject to " + String.Format("{0:0.00}", labVisitDetails[0].Remarks) + "% GST";
                             lblTaxDetails.Text = strAmount + String.Format("{0:0.00}", labVisitDetails[0].Remarks) + gst;

                         }
                     }
                 }
            
                 //ltSignature.Text = "<b>Authorised Signature(for "+OrgName+")</b>";
                 ltSignature.Text = strAuthorised + OrgName + strBr;

                 if (billMaster[0].IsCredit == "Y")
                 {
                    
                     //lblBillType.Text = "Credit Bill";
                     lblBillType.Text = strCreditBill;

                 }
                 if (billMaster[0].Status != null)
                 {
                     if (billMaster[0].Status.Trim() == "C")
                     {
                         referenceIndicator.Style.Add("display", "block");
                         litReferenceIndicator.Text = billMaster[0].Comments;
                       //  lblBillType.Text = "Cancelled Bill";
                           lblBillType.Text = StrCancelledBill;

                     }
                 }
                 #region TPAAttribute
                 string TPAAttributes = (labVisitDetails[0].TPAAttributes == null) ? "" : labVisitDetails[0].TPAAttributes;

                 //if (TPAAttributes != "" || labVisitDetails[0].TPAName != "")
                 if (labVisitDetails[0].TPAName != "")
                 {
                     FinalBillHeader1.SetAttribute(labVisitDetails[0].TPAAttributes, labVisitDetails[0].TPAName);
                 }
                 #endregion
           
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

                 List<Config> lstConfig = new List<Config>();
                 int iBillGroupID = 0;
                 iBillGroupID = (int)ReportType.OPBill;
                 new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, ILocationID, out lstConfig);
                 if (lstConfig.Count > 0)
                 {
                     //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                     imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                     if (lstConfig[0].ConfigValue.Trim() != "")
                     {
                         imgBillLogo.Visible = true;
                     }
                     else
                     {
                         imgBillLogo.Visible = false;
                     }
                 }
                 else
                 {
                     imgBillLogo.Visible = false;
                 }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
    #region LoadBillConfigMetadata
    public void LoadBillConfigMetadata(int OrgID, long OrgAddressID)
    {
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;
        new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "", OrgID, OrgAddressID, out lstConfig);
        int nConfigElements = lstConfig.Count;
        string[] sTempConfigElements;
        NameValueCollection oNV = new NameValueCollection();
        for (int nCnt = 0; nCnt < nConfigElements; nCnt++)
        {
            sTempConfigElements = lstConfig[nCnt].ConfigValue.Split('^');
            if (sTempConfigElements != null && sTempConfigElements.Length == 2)
            {
                oNV.Add(sTempConfigElements[0], sTempConfigElements[1]);
            }
        }
        for (int nCnt = 0; nCnt < oNV.Count; nCnt++)
        {
            switch (oNV.GetKey(nCnt))
            {
                case "Header Logo":
                    imgBillLogo.ImageUrl = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                    break;
                case "Header Font":
                    lblHospitalName.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Font Size":
                    lblHospitalName.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Header Content":
                    lblHospitalName.InnerHtml = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                case "Contents Font":
                    tblBillPrint.Style.Add("font-family", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Contents Font Size":
                    tblBillPrint.Style.Add("font-size", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Style":
                    tblBillPrint.Style.Add("border-style", oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt]);
                    break;
                case "Border Width":
                    tblBillPrint.Width = oNV[nCnt] == "NA" ? string.Empty : oNV[nCnt];
                    break;
                default:
                    break;
            }
        }
    }
    #endregion
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
}
