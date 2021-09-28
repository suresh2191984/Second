using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class InPatient_IPCashReceipt :BasePage
{
    string sSel = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }

            long patientID = 0;
            if (Request.QueryString["PID"] != null) 
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }

            PatientHeader.PatientID = patientID;
            PatientHeader.PatientVisitID = visitID;

            Cashreceipt.PatientID = patientID;
            Cashreceipt.VisitID = visitID;
            Cashreceipt.SetBillDetails();
            Cashreceipt.ReceiptNo = "";

            Creditreceipt.PatientID = 0;
            Creditreceipt.VisitID = visitID;
            Creditreceipt.SetBillDetails();

            if (Cashreceipt.VisitCount == 0)
            {
                Cashreceipt.Visible = false;
                divSecPage.Visible = false;
            }
            if (Creditreceipt.VisitCount == 0)
            {
                Creditreceipt.Visible = false;
                divSecPage.Visible = false;
            }

        }
        if (sSel == "Y")
        {
          
        }
    }

    protected void btnBillPrint_Click(object sender, EventArgs e)
    {
        long ReceiptNo = 0;
        List<PatientDueChart> lstDatas = new List<PatientDueChart>();// Cashreceipt.GetBillDetails();
        PatientVisit_BL objpVisitbl = new PatientVisit_BL(base.ContextInfo);
        //objpVisitbl.UpdatePatientBillingStatus(lstDatas, out ReceiptNo);
        //Cashreceipt.ReceiptNo = ReceiptNo.ToString();

        lstDatas = null;
        lstDatas = Creditreceipt.GetBillDetails();
        objpVisitbl.UpdatePatientBillingStatus(lstDatas, out ReceiptNo);

    }
}
