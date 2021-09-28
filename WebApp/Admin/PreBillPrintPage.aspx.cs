using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using ReportBusinessLogic;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.NewInstanceCreation;
using Attune.Solution.BusinessLogic_Ledger;
using Attune.Solution.BusinessLogic_InvoiceLedger; 

public partial class Admin_PreBillPrintPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int BookingID = 0;
        int Orgid = 0;
        long returncode = -1;
        string fromPreQuotationPage = String.Empty;
        Int32.TryParse(Request.QueryString["bookingid"], out BookingID);
        Int32.TryParse(Request.QueryString["OrgID"], out Orgid);
        Investigation_BL BL = new Investigation_BL(new BaseClass().ContextInfo);
        List<Bookings> lstPatientDetailes = new List<Bookings>();
        List<BillingDetails> lstPreQuotationBilling = new List<BillingDetails>();
        returncode= BL.PreQuotationBilling(BookingID, Orgid, out lstPatientDetailes, out lstPreQuotationBilling);     
       
        string ConfigKey1 = Request.QueryString["Config"].ToString();
        if (ConfigKey1 == "Y")
        {
            Label1.Text = lstPatientDetailes[0].PatientName;
            Label2.Text = lstPatientDetailes[0].SEX;
            Label3.Text = Convert.ToString(lstPatientDetailes[0].DOB);
            Label7.Text = Convert.ToString(lstPatientDetailes[0].Age);
            
            Label5.Text = Convert.ToString(lstPatientDetailes[0].OrgID);

        }
        
        GridView1.DataSource = lstPreQuotationBilling;
        GridView1.DataBind();


        string ConfigKey = Request.QueryString["Config"].ToString();
        if (ConfigKey == "Y")
        {
            PatientName.Visible = true;
            Sex.Visible = true;
            DOB.Visible = true;
            Age.Visible = true;            
            OrgID.Visible = true;
            Label1.Visible = true;
            Label2.Visible = true;
            Label3.Visible = true;            
            Label5.Visible = true;
            Label7.Visible = true;
        }
        else
        {
            

            PatientName.Visible = false;
            Sex.Visible = false;
            DOB.Visible = false;
            Age.Visible = false;            
            OrgID.Visible = false;
            Label1.Visible = false;
            Label2.Visible = false;
            Label3.Visible = false;            
            Label5.Visible = false;
            Label7.Visible = false;
        }
    }
    
}
