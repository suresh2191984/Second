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

public partial class Reception_ChangePriority : BasePage
{
    string pBillID;
    decimal pPreviousDue = 0;
    string pDrName = string.Empty;
    string pHospitalName = string.Empty;
    string pCCName = string.Empty;
    string pPatientName = string.Empty;
    string PrintString = string.Empty;
    long pPatientID = -1;
    long pVisitID = -1;
    long result = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            pBillID=Request.QueryString["billNo"];
            string windowFeatures = "height=700,width=1024,left=150,top=250";
            string key = "window.open('PrintBill.aspx?billNo="+pBillID+"','demo','"+windowFeatures+"','');";
           // btnFinish.Attributes.Add("OnClick", key);
           
            hypLnkPrint.NavigateUrl = "PrintBill.aspx?billNo=" + pBillID;
            if (!IsPostBack)
            {
                LoadPriority();
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
                 PrintString += pBillID.ToString()+" ";
                 BillDate.Text = Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt");
                 PrintString += Convert.ToDateTime(billMaster[0].BillDate).ToString("dd/MM/yyyy h:mm tt") + "\n";
                 PatientName.Text = labVisitDetails[0].PatientName;
                 PrintString += labVisitDetails[0].PatientName + " ";
                 DrName.Text = labVisitDetails[0].ReferingPhysicianName;
                 PrintString += labVisitDetails[0].ReferingPhysicianName + "\n";

                pPatientID = billMaster[0].PatientID;
                pVisitID = billMaster[0].VisitID;
                hdnVisitID.Value = billMaster[0].VisitID.ToString();
                HospitalName.Text = labVisitDetails[0].HospitalName;
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
                        referenceIndicator.Style.Add("display", "block");
                        litReferenceIndicator.Text = billMaster[0].Comments;
                        hypLnkPrint.Visible = true;
                        lblBillType.Text = "Cancelled Bill";
                    }
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
            trPriority.Style.Add("display", "block");
            lblPriority.Text = "Priority : " + visitList[0].PriorityName;
           


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
                 if (labVisitDetails[0].PreviousDue != 0)
                 {
                     ColPreviousDue.Visible = true;
                     PreviousDue.Visible = true;
                     PrintString += "Previous Due ";
                     PreviousDue.Text = String.Format("{0:0.00}", Convert.ToDouble(labVisitDetails[0].PreviousDue));
                     PrintString += String.Format("{0:0.00}", Convert.ToDouble(labVisitDetails[0].PreviousDue)) + "\n";
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

    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode == 0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Priority Master Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnChangePriority_Click(object sender, EventArgs e)
    {
        try
        {
            long retCode = -1;
            int PriorityID = Convert.ToInt16(ddlPriority.SelectedItem.Value);
            pVisitID = Convert.ToInt64(hdnVisitID.Value);
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            retCode = patBL.ChangePriority(pVisitID, OrgID, LID,PriorityID);
            if(retCode==0)
            {
                LoadBillDetails();
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error While Changing Priority in ChangePriority.aspx Page.", ex);
        }
    }

    
}
