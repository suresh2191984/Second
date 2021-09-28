using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;

public partial class Corporate_RefundVoucher :BasePage 
{
    string pRefID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyName", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                lblHospitalName.InnerText = lstInventoryConfig[0].ConfigValue;

            }

            new GateWay(base.ContextInfo).GetInventoryConfigDetails("PharmacyAddress", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {

                lblHospitalAddress.Text = lstInventoryConfig[0].ConfigValue;
            }
            if (Request.QueryString["pBid"] != null)
            {
                pRefID=Request.QueryString["pBid"];

            }
            BillPrinting(pRefID);
        }
    }

    private void BillPrinting(string pRefID)
    {
        try
        {
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<Users> lstUsers = new List<Users>();
            SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
            List<Patient> lstPatientDetail = new List<Patient>();
            long VisitID = 0;
           
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out VisitID);
            }
            //inventoryBL.GetINVRefundBillPrinting(VisitID, out lstBillingDetail, out lstPatientDetail, pRefID,
            //                              OrgID, ILocationID);
            inventoryBL.GetListOfUsers(OrgID, out lstUsers);

            if (lstBillingDetail.Count > 0)
            {

                    divBilling.Visible = true;
                    gvBillingDetail.DataSource = lstBillingDetail;
                    gvBillingDetail.DataBind();
                    lblPrescriptionNumber.Text = lstBillingDetail[0].VersionNo.ToString();
             
            }
           if (lstPatientDetail.Count >0){
       
                lblName.Text = lstPatientDetail[0].Name;
                lblPatientNumber.Text = lstPatientDetail[0].PatientNumber;
           }
                if (lstBillingDetail[0].Status.Contains("Dr."))
                {
                    lblPhysician.Text = lstBillingDetail[0].Status;
                }
                else
                {
                    lblPhysician.Text = "Dr." + lstBillingDetail[0].Status;
                }
              

                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                lblInvoiceNo.Text = lstBillingDetail[0].BillNumber.ToString();

                new GateWay(base.ContextInfo).GetInventoryConfigDetails("ShowDate_WithTime_INVRefundvoucher", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigValue == "Y")
                {
                    lblInvoiceDate.Text = lstBillingDetail[0].CreatedAt.ToString("dd/MMM/yy hh:mm tt");
                }
                else
                {
                    lblInvoiceDate.Text = lstBillingDetail[0].CreatedAt.ToString("dd/MMM/yyyy");
                }
                lblReason.Visible = false;
                lblReasonForRefund.Visible = false;
                lblReason.Text = lstBillingDetail[0].ReasonforRefund.ToString();
                lblRefundBy.Text = "Refunded By " + lstUsers.Find(P => P.LoginID == lstBillingDetail[0].CreatedBy).Name;
                lblRefundNo.Text = lstBillingDetail[0].ReceiptInterimNo.ToString();
                NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Refund bill details for printing in Bill Printing page", ex);
        }
    }
}
