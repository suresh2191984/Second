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

public partial class Billing_PrintInterimBill : BasePage
{
    public Billing_PrintInterimBill(): base("Billing\\PrintInterimBill.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    string InterimBillNo;
    string sEditPage;
    protected void Page_Load(object sender, EventArgs e)
    {
        //pNumber=" + hdnFID.Value + "&pName=" + hdnpid.Value + "&iBillNo=" + hdnvid.Value + "&billdate=" + hdndate.Value;

        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        if (Request.QueryString["billdate"] != null)
        {
            if (Request.QueryString["billdate"].ToString() != "")
            {
                dDateNow = Request.QueryString["billdate"].ToString();
                DateTime DTPaidDate = Convert.ToDateTime(dDateNow);
                dDateNow = DTPaidDate.ToString("dd/MM/yyyy hh:mm tt");
            }
            else
            {
                dDateNow = "";
            }

            if (Request.QueryString["type"] != null)
            {
                btnBack.Visible = true;
            }
            else
            {
                btnBack.Visible = false;
            }
        }

        long patientID = 0;
        long visitID = 0;
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        InterimBillNo=Request.QueryString["ReferenceID"];
        string IsSurgeryBill = string.Empty;
        IsSurgeryBill = Request.QueryString["IsAddServices"];
      

        uctlDueRequest1.RaisedDate = dDateNow;
        uctlDueRequest1.InterimBillNo = InterimBillNo;
        uctlDueRequest1.PatientID = patientID;
        uctlDueRequest1.VisitID = visitID;
        uctlDueRequest1.IsSurgeryBill = IsSurgeryBill == null ? "N" : IsSurgeryBill;

        uctlDueRequest1.SetBillDetails();
        //uctlDueRequest1.IsSurgeryHideItems();

        string sPage = "../Inpatient/PrintDueRequestPage.aspx?ReferenceID="
                     + InterimBillNo.ToString() + "&dDate="
                     + Convert.ToDateTime(dDateNow).ToString("dd/MM/yyyy hh:mm tt")
                     + "&PID=" + patientID.ToString()
                     + "&VID=" + visitID.ToString()
                     + "&PNAME=" + "&IsPopup=y"
                     + "&IsAddServices=" + IsSurgeryBill;

        sEditPage = "../Billing/EditInterimBill.aspx?ReferenceID="
                     + InterimBillNo.ToString() + "&dDate="
                     + Convert.ToDateTime(dDateNow).ToString("dd/MM/yyyy hh:mm tt")
                     + "&PID=" + patientID.ToString()
                     + "&VID=" + visitID.ToString()
                     + "&PNAME=" + "&IsPopup=y"; 

        hdnFID.Value = sPage;
        if (uctlDueRequest1.isDynamicPrint)
        {
            pagetdPrint.InnerHtml = uctlDueRequest1.getprinter();
            btnDynamicPrint.Visible = true;
            btnBillSearch.Visible = false;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(sEditPage);
    }
}
