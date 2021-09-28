using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;

public partial class Reception_VisitStateChangedScreen : BasePage
{
    AdminReports_BL arBL;
    List<Patient> lstPatientBillDetails = new List<Patient>();
    long returnCode = -1;
    string billNo = string.Empty;
    long approvedBy = 0;
    string reason = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
          arBL = new AdminReports_BL(base.ContextInfo);
        AutoGname1.ContextKey = OrgID.ToString();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
        string[] lineItems = txtApprovedBy.Text.Split('~');
        billNo = Convert.ToString(txtBillNo.Text);
        approvedBy = Convert.ToInt64(lineItems[1]);
        reason = txtReason.Text;
        hdnBillNo.Value = billNo.ToString();
        hdnApprovedBy.Value = approvedBy.ToString();
        hdnReason.Value = reason.ToString();

        returnCode = arBL.GetBillNoDetails(billNo, OrgID, out lstPatientBillDetails);
        if (returnCode >= 0)
        {
            lblPatientNameText.Text = lstPatientBillDetails[0].Name;
            lblPatientNoText.Text = lstPatientBillDetails[0].PatientNumber;
            lblBillNoText.Text = lstPatientBillDetails[0].BillNumber.ToString();
            lblDischargDateText.Text = lstPatientBillDetails[0].DischargedDT.ToString("dd/MM/yyyy");
            hdnIsDayCareBill.Value = lstPatientBillDetails[0].IsConfidential.ToString();

            mpeOthers.Show();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('Patient Not Discharged or Patient not IP ');ResetValue();", true);
        }
        
        
            

    }
    protected void btnOK_Click(object sender, EventArgs e)
    {
        long returnC = -1;
        returnC = arBL.InsertVisitStateChanged(Convert.ToString(hdnBillNo.Value), OrgID, Convert.ToInt64(hdnApprovedBy.Value), hdnReason.Value, LID, hdnIsDayCareBill.Value);     
        if (returnC >= 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('Patient Admitted');ResetValue();", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "ResetValue();", true);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Reception/VisitStateChangedScreen.aspx");
    }

}
