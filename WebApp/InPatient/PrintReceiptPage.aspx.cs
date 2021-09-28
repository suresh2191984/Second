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
        //string dAmount = "0";
        //if (Request.QueryString["Amount"] != null)
        //{
        //    dAmount = Request.QueryString["Amount"].ToString();
        //}
        string dDateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        //if (Request.QueryString["dDate"] != null)
        //{
        //    if (Request.QueryString["dDate"].ToString() != "")
        //    {
        //        dDateNow = Request.QueryString["dDate"].ToString();
        //        DateTime DTPaidDate = Convert.ToDateTime(dDateNow);
        //        dDateNow = DTPaidDate.ToString("dd/MM/yyyy hh:mm tt");
        //    }
        //    else
        //    {
        //        dDateNow = "";
        //    }
        //}

        //string pName = "";
        string patientNumber = string.Empty;
        if (Request.QueryString["PNO"] != null)
        {
            patientNumber =Convert.ToString(Request.QueryString["PNO"]);
        }
        //if (Request.QueryString["PNAME"] != null)
        //{
        //    pName = Request.QueryString["PNAME"].ToString();
        //}
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

        string LabNo=string.Empty;
        long patientID = 0;
        long visitID = 0;
        long interMedID = 0;
        string Duplicate = string.Empty;
        if (Request.QueryString["Duplicate"] != null)
        {
            Duplicate = Request.QueryString["Duplicate"].ToString();
        }
        
        string Page = string.Empty;
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        Int64.TryParse(Request.QueryString["VID"], out visitID);
        Int64.TryParse(Request.QueryString["pdid"], out interMedID);
        //LabNo=Request.QueryString["LabNo"].ToString();
        
        

        
        //ucPatientAdvance.Amount = dAmount;
        //ucPatientAdvance.PaidDate = dDateNow;
       // ucPatientAdvance.PatientName = pName;
        ucPatientAdvance.ReceiptNo = rcptNo;
        ucPatientAdvance.sType = sTypes;
       // ucPatientAdvance.Age=Page;
       
        ucPatientAdvance.patientNumberDue = patientNumber;
        ucPatientAdvance.PatientID = patientID;
        ucPatientAdvance.VisitID = visitID;
        ucPatientAdvance.InterMedID = interMedID;
        ucPatientAdvance.LabNo = LabNo;
        ucPatientAdvance.ReceiptModel = "";
        ucPatientAdvance.Duplicate = Duplicate;
        
        ucPatientAdvance.SetBillDetails();
        //tdPrint.InnerHtml=ucPatientAdvance.getprinter();
        if (Request.QueryString["usr"] == null)
        {
            if (ucPatientAdvance.Ippayments == false)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "ff", "javascript:fnPrintAdvance();", true);
            }
        }
    }

  
}