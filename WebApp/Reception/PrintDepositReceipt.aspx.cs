using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;

public partial class Reception_PrintDepositReceipt : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //string dAmount = "0";
        //if (Request.QueryString["Amount"] != null)
        //{
        //    dAmount = Request.QueryString["Amount"].ToString();
        //}
        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        string ClientName = "";
        long ClientID = 0;
        string CrcptNo = "0";
        string CollectionType = "";
        string DDate = "";

        if (Request.QueryString["rcptno"] != null)
        {
            CrcptNo = Request.QueryString["rcptno"].ToString();
        }
        if (Request.QueryString["ClientID"] != null)
        {
            ClientID = Convert.ToInt32(Request.QueryString["ClientID"].ToString());
        }
        if (Request.QueryString["ClientName"] != null)
        {
            ClientName = Request.QueryString["ClientName"].ToString();
        }
        if (Request.QueryString["CollectionType"] != null)
        {
            CollectionType = Request.QueryString["CollectionType"].ToString();
        }
        if (Request.QueryString["DDate"] != null)
        {
            DDate = Request.QueryString["DDate"].ToString();
        }
        if (ClientName != null || ClientID != 0)
        {
            tblpatient.Visible = false;
            tblclients.Visible = true;
            Int64.TryParse(Request.QueryString["ClientID"], out ClientID);           
            UCClientAdvance.ReceiptNo = CrcptNo;
            UCClientAdvance.ReceiptType = CollectionType;
            UCClientAdvance.ClientID = ClientID;
            UCClientAdvance.ClientName = ClientName;
            UCClientAdvance.PaidDate = DDate;
            ucPatientAdvance.ReceiptModel = "Deposit Receipt";
            UCClientAdvance.SetBillDetails();



        }
        else
        {
            tblclients.Visible = false;
            tblpatient.Visible = true;
            string rcptNo = "0";
            if (Request.QueryString["rcptno"] != null)
            {
                rcptNo = Request.QueryString["rcptno"].ToString();
            }

        string sTypes = "";
        if (Request.QueryString["pDet"] != null)
        {
            sTypes = Request.QueryString["pDet"].ToString();
        }
        string page = "";
        
        if (Request.QueryString["Age"] != null)
        {
            page = Request.QueryString["Age"].ToString();
        }
        long patientID = 0;
        long visitID = 0;
        long interMedID = 0;
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        Int64.TryParse(Request.QueryString["VID"], out visitID);
        Int64.TryParse(Request.QueryString["pdid"], out interMedID);

        //ucPatientAdvance.Amount = dAmount;
        //ucPatientAdvance.PaidDate = dDateNow;
       // ucPatientAdvance.PatientName = pName;
        ucPatientAdvance.ReceiptNo = rcptNo;
        ucPatientAdvance.sType = sTypes;
        ucPatientAdvance.ReceiptType = "Deposit";
        ucPatientAdvance.PatientID = patientID;
        ucPatientAdvance.VisitID = visitID;
        ucPatientAdvance.InterMedID = interMedID;
        ucPatientAdvance.ReceiptModel = "Deposit Receipt";
        //ucPatientAdvance.Age = page;
       
        ucPatientAdvance.SetBillDetails();
        }
    }

  
}