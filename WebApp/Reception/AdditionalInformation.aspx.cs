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

public partial class Reception_AdditionalInformation : BasePage
{
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
    int pClientID = -1;
    int pCollectionCentreID = -1;
    long result = -1;
    BillMaster objBillMaster = new BillMaster();
    BillLineItems objBillLineItems = new BillLineItems();
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
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in DueCollection.aspx:Page_Load", ex);
        }
    }
   
    public void LoadBillDetails()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<BillMaster> billMaster = new List<BillMaster>();
            List<BillLineItems> billLineItems = new List<BillLineItems>();
            List<PatientVisit> labVisitDetails = new List<PatientVisit>();
            string pAge = string.Empty;
            string pSex = string.Empty;
            retCode = patBL.GetBillDetails(pBillID, OrgID, out billMaster, out billLineItems, out labVisitDetails);         
                BillNo.Text = pBillID.ToString();
                BillDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
                PatientName.Text = labVisitDetails[0].PatientName;
                DrName.Text = labVisitDetails[0].ReferingPhysicianName;
                pPatientID = billMaster[0].PatientID;
                pClientID = billMaster[0].ClientID;
                pCollectionCentreID = billMaster[0].CollectionCentreID;
                pVisitID = billMaster[0].VisitID;
                HospitalName.Text = labVisitDetails[0].HospitalName;
                hdnPatientID.Value = pPatientID.ToString();
                hdnClientID.Value = pClientID.ToString();
                hdnCCID.Value = pCollectionCentreID.ToString();
                hdnVisitID.Value = pVisitID.ToString();
                if (labVisitDetails[0].CollectionCentreName != null)
                {
                    trCC.Style.Add("Display", "block");
                    CollectionCentre.Text = labVisitDetails[0].CollectionCentreName;
                }
                if (billMaster[0].IsCredit == "Y")
                {
                    lblBillType.Text = "Credit Bill";
                }
                if (billMaster[0].Status!= null)
                {
                    if (billMaster[0].Status.Trim() == "C")
                    {
                        lblBillType.Text = "Cancelled Bill";
                        btnAdditionalInformation.Visible = false;
                        referenceIndicator.Style.Add("display", "block");
                        litReferenceIndicator.Text = billMaster[0].Comments;
                        commentsBlock.Style.Add("display", "none");
                        trAdditionalInformation.Style.Add("display", "none");
                    }
                }
                if (billMaster[0].Type == "DUE")
                {
                    btnAdditionalInformation.Visible = false;
                    referenceIndicator.Style.Add("display", "block");
                    litReferenceIndicator.Text = billMaster[0].Comments;
                    commentsBlock.Style.Add("display", "none");
                    trAdditionalInformation.Style.Add("display", "none");
                }
                if (billMaster[0].Type == "COR")
                {
                    btnAdditionalInformation.Visible = false;
                    referenceIndicator.Style.Add("display", "block");
                    litReferenceIndicator.Text = billMaster[0].Comments;
                    commentsBlock.Style.Add("display", "none");
                    trAdditionalInformation.Style.Add("display", "none");
                }

            /* Header Patient Details Display Block */
            lblPatientNo.Text = pPatientID.ToString();
            lblVisitNo.Text = pVisitID.ToString();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<PatientVisit> visitList = new List<PatientVisit>();
            result = patientBL.GetLabVisitDetails(pVisitID,OrgID, out visitList);
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
                lblPriority.Text = "Priority : " + visitList[0].PriorityName;
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
                // AmountReceived.Text = billMaster[0].AmountReceived.ToString();
                 //AmountDue.Text = billMaster[0].AmountDue.ToString();
                 //hdnAmountDue.Value = billMaster[0].AmountDue.ToString();
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
            Role role = new Role();
            role.RoleID = RoleID;
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

    protected void btnAdditionalInformation_Click(object sender, EventArgs e)
    {
        try
        {
            long retCode = -1;
            string pNewBillID = string.Empty;
            decimal quantity = 1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //objBillMaster.AmountDue = Convert.ToDecimal(hdnAmountDue.Value);
            objBillMaster.AmountDue = 0;
            objBillMaster.AmountReceived = Convert.ToDecimal(txtAmount.Value);
            objBillMaster.Comments = txtComments.Value + " (For Bill No: " + pBillID + ")";
            objBillMaster.CreatedBy = LID;
            objBillMaster.Discount = 0;
            objBillMaster.GrossAmount = Convert.ToDecimal(txtAmount.Value);
            objBillMaster.IsCredit = "N";
            objBillMaster.NetAmount = Convert.ToDecimal(txtAmount.Value);
            //objBillMaster.NetAmount = Convert.ToDecimal(hdnAmountDue.Value) + Convert.ToDecimal(txtAmount.Value);
            objBillMaster.OrgID = OrgID;
            objBillMaster.TaxPercent = 0;
            objBillMaster.Type = "COR";
            objBillMaster.BillID = 0;
            objBillMaster.PatientID = Convert.ToInt64(hdnPatientID.Value);
            objBillMaster.ClientID = Convert.ToInt32(hdnClientID.Value);
            objBillMaster.CollectionCentreID = Convert.ToInt32(hdnCCID.Value);
            objBillMaster.VisitID = Convert.ToInt64(hdnVisitID.Value);

            objBillLineItems.OrgID = OrgID;
            objBillLineItems.ItemName = txtItemName.Value;
            objBillLineItems.ItemType = "COR";
            objBillLineItems.Quantity = Convert.ToDecimal(txtQuantity.Value);
            objBillLineItems.Rate = Convert.ToDecimal(txtRate.Value);
            objBillLineItems.Amount = Convert.ToDecimal(txtAmount.Value);

            retCode = patBL.SaveDueCollection(objBillMaster, objBillLineItems, out pNewBillID);

            if(retCode==0)
            {
                Response.Redirect("ViewBill.aspx?billNo=" + pNewBillID, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Adding Additional Information to Bill AdditionalInformation.aspx Page.", ex);
        }
    }

    
}
