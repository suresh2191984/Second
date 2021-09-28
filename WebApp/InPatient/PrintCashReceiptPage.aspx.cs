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

public partial class Reception_PrintReceiptPage : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        long visitID = 0;
        // Comments added

        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string ReceiptNo = "0";
        if (Request.QueryString["RNO"] != null)
        {
            ReceiptNo = Request.QueryString["RNO"].ToString();//== "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string AmountReceived = "0";
        if (Request.QueryString["AMT"] != null)
        {
            AmountReceived = Request.QueryString["AMT"].ToString() == "" ? "0" : Request.QueryString["AMT"].ToString();
        }

        Cashreceipt.PatientID = patientID;
        Cashreceipt.VisitID = visitID;
        Cashreceipt.ReceiptNo = ReceiptNo;
        Cashreceipt.TempAmount = Decimal.Parse(AmountReceived);
        Cashreceipt.SetBillDetails();
       
    }
     
}