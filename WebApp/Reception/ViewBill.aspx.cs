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

public partial class Reception_ViewBill : BasePage
{
    public Reception_ViewBill()
        : base("Reception_ViewBill_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    string pBillID=string.Empty;
    decimal pPreviousDue = 0;
    string pDrName = string.Empty;
    string pHospitalName = string.Empty;
    string pCCName = string.Empty;
    string pPatientName = string.Empty;
    string PrintString = string.Empty;
    int pCancelBill = -1;
    long pPatientID = -1;
    long pVisitID = -1;
    long result = -1;
    string labno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            ColItem.Text = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_09;
            ColQuantity.Text = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_10;
            ColRate.Text = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_11;
            ColAmount.Text = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_12;

            pBillID=Request.QueryString["billNo"];
            Int32.TryParse(Request.QueryString["CancelBill"], out pCancelBill);
            if(Request.QueryString["LabNo"]!=null)
            labno = Request.QueryString["LabNo"];
            string windowFeatures = "height=700,width=1024,left=150,top=250";

            string RedirectPage = GetConfigValue("BillPage", OrgID);
            string key=string.Empty;
            if (RedirectPage != string.Empty)
            {
                key = "window.open('" + RedirectPage + "?billNo=" + pBillID + "','demo','" + windowFeatures + "','');";
            }
            else
            {
                key = "window.open('PrintBill.aspx?billNo=" + pBillID + "','demo','" + windowFeatures + "','');";
            }
           // btnFinish.Attributes.Add("OnClick", key);
            if (pCancelBill == 1)
            {
                btnBillCancel.Visible = true;
                commentsBlock.Style.Add("Display","Block");
            }
            else
            {
                hypLnkPrint.Visible = true;
            }
            if (RedirectPage != string.Empty)
            {
                hypLnkPrint.NavigateUrl = RedirectPage + "?billNo=" + pBillID;
            }
            else{
                hypLnkPrint.NavigateUrl = "PrintBill.aspx?billNo=" + pBillID;
            }
            if (!IsPostBack)
            {
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in ViewBill.aspx:Page_Load", ex);
        }
    }

    public void LoadBillDetails()
    {


        string vAmunt = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_15 == null ? "This amount is subject to " : Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_15;
        string vGst = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_16 == null ? "% GST" : Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_16;
        string vCancelbill = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_17 == null ? "Cancelled Bill" : Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_17;
        string vPriority = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_18 == null ? "Priority :" : Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_18;
        string vCreditBill = Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_19 == null ? "Credit Bill" : Resources.Reception_ClientDisplay.Reception_ViewBill_aspx_19;
        
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<BillMaster> billMaster = new List<BillMaster>();
            List<BillLineItems> billLineItems = new List<BillLineItems>();
            List<PatientVisit> pVisitDetails = new List<PatientVisit>();
            string pAge = string.Empty;
            string pSex = string.Empty;
            retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out pVisitDetails);
            string IsBillWithBarcode = GetConfigValue("PrintBillBarcode", OrgID);
            if (IsBillWithBarcode == "Y")
            {
                tbrBarCode.Visible = true;
                imbbarcode.ImageUrl = "../admin/userImageHandler.ashx?isBarCode=Y&key=" + pVisitDetails[0].PatientName + "&val=" + Convert.ToString(pBillID) + "&showCodeString=" + true;
            }
                 BillNo.Text = pBillID.ToString();
                 PrintString += pBillID.ToString()+" ";
                 BillDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
                 PrintString += Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt") + "\n";
                 if (pVisitDetails.Count > 0)
                 {
                     PatientName.Text = pVisitDetails[0].PatientName;
                     PrintString += pVisitDetails[0].PatientName + " ";
                     DrName.Text = pVisitDetails[0].ReferingPhysicianName;
                     PrintString += pVisitDetails[0].ReferingPhysicianName + "\n";
                     HospitalName.Text = pVisitDetails[0].HospitalName;
                     if (pVisitDetails[0].CollectionCentreName != null)
                     {
                         trCC.Style.Add("Display", "block");
                         CollectionCentre.Text = pVisitDetails[0].CollectionCentreName;
                     }
                     string IsTaxdisclaimer = string.Empty;
                     IsTaxdisclaimer = GetConfigValue("Taxdisclaimer", OrgID);
                     if (!String.IsNullOrEmpty(IsTaxdisclaimer))
                     {
                         if (IsTaxdisclaimer == "Y")
                         {
                             if (pVisitDetails[0].PayerID == 1)
                             {
                                 // trTaxDetails.Attributes.Add("display", "block");
                                 lblTaxDetails.Visible = true;
                                // lblTaxDetails.Text = "This amount is subject to " + String.Format("{0:0.00}", pVisitDetails[0].Remarks) + "% GST";
                                 lblTaxDetails.Text = vAmunt + String.Format("{0:0.00}", pVisitDetails[0].Remarks) + vGst;

                             }
                         }
                     }

                 }

                pPatientID = billMaster[0].PatientID;
                pVisitID = billMaster[0].VisitID;

                
               
                if (billMaster[0].IsCredit == "Y")
                {
                   
                   // lblBillType.Text = "Credit Bill";
                    lblBillType.Text = vCreditBill;

                }
                if (billMaster[0].Status!= null)
                {
                    if (billMaster[0].Status.Trim() == "C")
                    {
                        referenceIndicator.Style.Add("display", "block");
                        litReferenceIndicator.Text = billMaster[0].Comments;
                        btnBillCancel.Visible = false;
                        commentsBlock.Style.Add("Display", "none");
                        hypLnkPrint.Visible = true;
                        //lblBillType.Text = "Cancelled Bill";
                        lblBillType.Text = vCancelbill;

                       
                    }
                }
            /* Header Patient Details Display Block */

 
            lblVisitNo.Text = pVisitID.ToString();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<PatientVisit> visitList = new List<PatientVisit>();
            result = patientBL.GetLabVisitDetails(pVisitID,OrgID, out visitList);
            lblPatientNo.Text = visitList[0].PatientNumber.ToString();
            lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            if (visitList[0].Sex == "M")
            {
                lblGender.Text = "[Male]";
            }
            else
            {
                lblGender.Text = "[Female]";
            }
            lblAge.Text = visitList[0].PatientAge.ToString();
            if (visitList[0].PriorityName != "Normal")
            {
                trPriority.Style.Add("display", "block");
               // lblPriority.Text = "Priority : " + visitList[0].PriorityName;
                lblPriority.Text = vPriority  + visitList[0].PriorityName;

            }


            /* Block Ends */





            foreach (BillLineItems items in billLineItems)
            {
                TableRow row = new TableRow();
                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = items.ItemName;
                PrintString += items.ItemName + " ";
                cell2.Attributes.Add("align", "right");
                cell2.Text = items.Quantity.ToString();
                PrintString += items.Quantity.ToString() + " ";
                cell3.Attributes.Add("align", "right");
                cell3.Text = items.Rate.ToString();
                PrintString += items.Rate.ToString() + " ";
                cell4.Attributes.Add("align", "right");
                cell4.Text = items.Amount.ToString();
                PrintString += items.Amount.ToString() + "\n";
                row.Cells.Add(cell1);
                row.Cells.Add(cell2);
                row.Cells.Add(cell3);
                row.Cells.Add(cell4);
                billItemsTab.Rows.Add(row);
                
            }
             
                 
                 
                 PrintString += "Gross Amount ";
                 GrossAmount.Text = billMaster[0].GrossAmount.ToString();
                 PrintString += billMaster[0].GrossAmount.ToString()+"\n";
                 PrintString += "Discount ";
                 Discount.Text = billMaster[0].Discount.ToString();
                 PrintString += billMaster[0].Discount.ToString() + "\n";
                 PrintString += "Tax % ";
                 TaxPercent.Text = billMaster[0].TaxPercent.ToString();
                 PrintString += billMaster[0].TaxPercent.ToString()+"\n";
                 if (pVisitDetails.Count>0 && pVisitDetails[0].PreviousDue != 0 && billMaster[0].Type != "DUE" && billMaster[0].Type != "COR")
                 {
                     ColPreviousDue.Visible = true;
                     PreviousDue.Visible = true;
                     PrintString += "Previous Due ";
                     PreviousDue.Text = String.Format("{0:0.00}", Convert.ToDouble(pVisitDetails[0].PreviousDue));
                     PrintString += String.Format("{0:0.00}", Convert.ToDouble(pVisitDetails[0].PreviousDue)) + "\n";
                 }
                 PrintString += "Net Amount ";
                 NetAmount.Text = billMaster[0].NetAmount.ToString();
                 PrintString += billMaster[0].NetAmount.ToString()+"\n";
                 PrintString += "Amount Received ";
                 AmountReceived.Text = billMaster[0].AmountReceived.ToString();
                 PrintString += billMaster[0].AmountReceived.ToString()+"\n";
                 PrintString += "Amount Due ";
                 AmountDue.Text = billMaster[0].AmountDue.ToString();
                 PrintString += billMaster[0].AmountDue.ToString()+"\n";
            
                 PrintArea.Text = PrintString;

                 if (billMaster[0].Comments!="")
                 {
                     referenceIndicator.Style.Add("display", "block");
                     litReferenceIndicator.Text = billMaster[0].Comments;
                 }
                 if (billMaster[0].ParentBillID > 0 && pBillID!= billMaster[0].ParentBillID.ToString())
                 {
                     string RedirectPage = GetConfigValue("BillPage", OrgID);
                     if (RedirectPage != string.Empty)
                     {
                         hypLnkParentPrint.NavigateUrl = RedirectPage + "?billNo=" + billMaster[0].ParentBillID;
                     }
                     else
                     {
                         hypLnkParentPrint.NavigateUrl = "PrintBill.aspx?billNo=" + billMaster[0].ParentBillID;
                     }
                     hypLnkParentPrint.Visible = true;
                 }
                 #region TPAAttribute
                 string TPAAttributes = (pVisitDetails[0].TPAAttributes == null) ? "" : pVisitDetails[0].TPAAttributes;

                 //if (TPAAttributes != "" || pVisitDetails[0].TPAName != "")
                 if (pVisitDetails[0].ClientName != "")
                 {
                     FinalBillHeader1.SetAttribute(pVisitDetails[0].TPAAttributes, pVisitDetails[0].ClientName);
                 }
                 #endregion
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Loading Billing Details.", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role=new Role();
            role.RoleID=RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }

    }

    protected void btnBillCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long retCode = -1;
            string comments = string.Empty;
            comments = txtComments.Value;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            retCode = patBL.CancelBillDetails(pBillID, OrgID, LID, comments);

            if(retCode==0)
            {
                btnBillCancel.Visible = false;
                commentsBlock.Style.Add("Display", "none");
                hypLnkPrint.Visible = true;
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Cancelling Bill in ViewBill Page.", ex);
        }
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
    
}
