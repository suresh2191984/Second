using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;



public partial class Reports_PatientWiseDepositReport : BasePage
{
    List<Patient> lstPatient;
    
    List<PatientDepositHistory> lstPatientDepHis;
    List<PatientDepositUsage> lstPatientDepUsage;
     
    long PatientID = 0;
    int OrgID = 0;

    protected void Page_Load(object sender, EventArgs e)
   {
        try
        {
            if (!IsPostBack)
            {
                Int64.TryParse(Request.QueryString["PID"], out PatientID);
                Int32.TryParse(Request.QueryString["ORGID"], out OrgID);
                if (Request.QueryString["PID"] != null)
                {
                   lstPatient = new List<Patient>();
                    new Report_BL(base.ContextInfo).GetPatientWiseDepositDetails(OrgID, PatientID, out lstPatient, out lstPatientDepHis, out lstPatientDepUsage);                    
                }
                if(lstPatient.Count>0)
                {                   
                    lblName.Text = lstPatient[0].Name;
                    lblPatientNumber.Text = lstPatient[0].PatientNumber;
                    lblAge.Text = lstPatient[0].Age;
                    lblSex.Text = lstPatient[0].SEX;
                    lblHospitalName.Text = lstPatient[0].Add1;
                    lblHoscity.Text = lstPatient[0].Add2;
                }
               
                if (lstPatientDepHis.Count > 0)
                {                    
                    prnDeposit.Attributes.Add("style", "block");
                    prnDeposit.Visible = true;
                    gvDepositRpt.DataSource = lstPatientDepHis;
                    gvDepositRpt.DataBind();
                }
                else
                {                    
                    prnDeposit.Attributes.Add("style", "none");
                    tdDeposit.Visible = false;
                    prnDeposit.Visible = false;
                    gvDepositRpt.DataSource = null;
                    gvDepositRpt.DataBind();
                }
                if (lstPatientDepUsage.Count > 0)
                {                    
                    prnDepositUsage.Attributes.Add("style", "block");
                    prnDepositUsage.Visible = true;
                    gvDepositUsageRpt.DataSource = lstPatientDepUsage;
                    gvDepositUsageRpt.DataBind();
                }
                else
                { 
                    prnDepositUsage.Attributes.Add("style", "none");
                    prnDepositUsage.Visible = false;
                    tdDepositUse.Visible = false;
                    gvDepositUsageRpt.DataSource = null;
                    gvDepositUsageRpt.DataBind();
                }
                if (lstPatientDepHis.Count == 0 && lstPatientDepUsage.Count == 0)
                {
                    tdprint.Visible = false;
                    lblnotfound.Visible = true;
                }               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientWiseDeposit Report", ex);
        }
    }    
}
