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

public partial class Admin_PrintReceiptPage : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        string pName = "";
        string rcptNo = "0";
        long OutFlowID = 0;
        string strReceiptNo = "0"; 
        string dAmount = "0"; 
        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        
        if (Request.QueryString["IFVNO"] != null && Request.QueryString["IFVNO"].ToString() != "")
        {
            strReceiptNo = Request.QueryString["IFVNO"].ToString();
            advanceReceipt.Style.Add("display", "none");
            ucReceiptDetails.ReceiptNo = strReceiptNo; 
            ucReceiptDetails.SetBillDetails();
        }
        else
        {
            if (Request.QueryString["dDate"] != null)
            {
                if (Request.QueryString["dDate"].ToString() != "")
                {
                    dDateNow = Request.QueryString["dDate"].ToString();
                    DateTime DTPaidDate = Convert.ToDateTime(dDateNow);
                    dDateNow = DTPaidDate.ToString("dd/MM/yyyy hh:mm tt");
                }
                else
                {
                    dDateNow = "";
                }
            } 
            if (Request.QueryString["Amount"] != null)
            {
                dAmount = Request.QueryString["Amount"].ToString();
            } 
            Int64.TryParse(Request.QueryString["OID"], out OutFlowID);
            if (Request.QueryString["RNAME"] != null)
            {
                pName = Request.QueryString["RNAME"].ToString();
            }
            if (Request.QueryString["VONO"] != null)
            {
                rcptNo = Request.QueryString["VONO"].ToString();
            } 
            divReceiptDetails.Style.Add("display", "none");
            ucPatientAdvance.Amount = dAmount;
            ucPatientAdvance.PaidDate = dDateNow;
            ucPatientAdvance.ReceiverName = pName;
            ucPatientAdvance.VoucherNo = rcptNo;
            ucPatientAdvance.OutFlowID = OutFlowID;
            ucPatientAdvance.SetBillDetails();
        }
    }
}