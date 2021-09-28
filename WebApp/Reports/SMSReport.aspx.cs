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
using System.IO;
using Attune.Podium.PerformingNextAction;

public partial class Reports_SMSReport : BasePage 
{
     
    List<PatientPrescription> lstprescription = new List<PatientPrescription>();
    long PatientVisitID = 0;
    long result = 0;
    long PatientID = 0;
    Patient_BL patientBL;
    List<Patient> lstPatient = new List<Patient>();
    string SMSDAY = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }

    public void btnSubmit_Click(object sender ,EventArgs e)
    {
        DateTime FromDate = Convert.ToDateTime(txtFDate.Text);
        DateTime ToDate = Convert.ToDateTime(txtTDate.Text);
      
        Report_BL objBL = new Report_BL(base.ContextInfo);
        objBL.GetSMSAlertReport(FromDate, ToDate, OrgID, out lstprescription);
        if (lstprescription.Count() > 0)
        {
            btnsendSMS.Visible = true;
        }
        GvSMSReport.DataSource = lstprescription;
        GvSMSReport.DataBind();

    }

    protected void GvSMSReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                PatientPrescription t = (PatientPrescription)e.Row.DataItem;
                string strScript = "SelectRow('" + ((CheckBox)e.Row.Cells[0].FindControl("chkSelect")).ClientID + "','" +
                                                                t.DrugID + "','" +
                                                                t.Duration + "');";

                ((CheckBox)e.Row.Cells[0].FindControl("chkSelect")).Attributes.Add("onclick", strScript);
                hdnPatientID.Value =Convert.ToString( t.DrugID);
                SMSDAY = t.Duration;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {

                    if (t.Duration == Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString())
                    {
                        e.Row.BackColor = System.Drawing.Color.Beige;
                        e.Row.ToolTip = "You are sending a SMS to a Patient";
                       
                    }
                    else
                    {
                        e.Row.BackColor = System.Drawing.Color.BlanchedAlmond;

                    }

                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in GvSMSReport_RowDataBound CreditCardStmt", ex);
            }
        }
    }

  

    protected void GvSMSReport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);

                PatientVisitID = Convert.ToInt32(GvSMSReport.DataKeys[RowIndex][2]);
                hdnPatientVisitID.Value = PatientVisitID.ToString();
                //hdnPatientNumber.Value = Convert.ToString(GvSMSReport.DataKeys[RowIndex][1]);

              //  Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());     
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("There is some problem in Rowcommand event in SMSReport page", ex);
        }
    }


    protected void btnsendSMS_Click(object sender, EventArgs e)
    {
        try
        {
            String URL = string.Empty;
            ActionManager objActionManager = new ActionManager(base.ContextInfo);
            objActionManager.GetSMSConfig(OrgID, out URL);
            foreach (GridViewRow row in GvSMSReport.Rows)
            {

                CheckBox chkSelect = (CheckBox)row.FindControl("chkSelect");
              
                if (chkSelect.Checked==true)
                {
                   // PatientID = Convert .ToInt64(hdnPatientNumber.Value);
                   
                    PatientID = Convert.ToInt64(hdnPatientID.Value);

                    result = patientBL.GetPatientDemoandAddress(PatientID, out lstPatient);
                    Communication.SendSMS(URL, "Dear " + lstPatient[0].Name + ",\nYou ll come in pharmacy and get remaining quantity of drugs \n" + OrgName + " on " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", SMSDAY) + ". Thank you.", lstPatient[0].PatientAddress[0].MobileNumber.Trim());
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("There is some problem in SMSReport page", ex);
        }
    }

    public void PickPatientIDs()
    {
        long PatientID = 0;
        long PID = 0;
      
        foreach (GridViewRow row in GvSMSReport.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("chkSelect");
                HiddenField HdnPID = (HiddenField)row.FindControl("hdnPatientID");

                if (chkBox.Checked)
                {
                    PatientID =Convert.ToInt64(HdnPID.Value);
                }
                PID += PatientID;
            }
        }
        hdnPatientID.Value = Convert.ToString(PID);
    }

}

