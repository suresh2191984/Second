using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;

public partial class Reception_OutBoundReferral : BasePage
{
    Referrals_BL objReferrals_BL ;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        Referrals1.flag = "OUTBOUND";
        if (!IsPostBack)
        {
            loadlocations();
            LoadActions();
        }
    }

    private void LoadActions()
    {
        long returnCode = -1;
        Patient_BL patBL = new Patient_BL(base.ContextInfo);
        List<ReferralActionOption> lstReferralActionOption = new List<ReferralActionOption>();
        dList.Items.Clear();
        try
        {
            returnCode = objReferrals_BL.GetReferralStatus(RoleID, "Out", out lstReferralActionOption);
            dList.DataSource = lstReferralActionOption;
            dList.DataTextField = "ActionName";
            dList.DataValueField = "Type";
            dList.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the OutBoundReferral Actions", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    protected void loadlocations()
    {
        try
        {
            if (lstLocation.Count == 0)
            {
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
            }
            var tempLocation = from loc in lstLocation
                               where loc.OrgID != OrgID
                               select loc;

            ddlReferedOrg.DataSource = tempLocation;
            ddlReferedOrg.DataTextField = "Location";
            ddlReferedOrg.DataValueField = "Comments";
            ddlReferedOrg.DataBind();
            ddlReferedOrg.Items.Insert(0, "---Select---");
            ddlReferedOrg.Items[0].Value = "0~0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }

    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        Patient patient = new Patient();
        try
        {
            switch (dList.SelectedItem.Text)
            {
                case "Cancel Referral":
                    returncode = objReferrals_BL.UpdateReferralStatus(Int64.Parse(pRefId.Value), "Out", Int64.Parse(dList.SelectedValue.Split('~')[1]), LID);
                    Referrals1.ReferedDate = txtReferedDate.Text;
                    Referrals1.ReferedOrg = ddlReferedOrg.SelectedValue.Split('~')[1];
                    Referrals1.ReferedLoc = ddlReferedOrg.SelectedValue.Split('~')[0];
                    Referrals1.PatientURN = txtURN.Text;
                    Referrals1.Status = ddlStatus.SelectedItem.Text;
                    returnCode = Referrals1.BindOutBoundReferral();
                    break;
                case "Print Referral":
                    Response.Redirect(@"ReferedInvestigation.aspx?vid=" + pVisitid.Value + "&Rid=" + pRefId.Value, true);
                    break;
                case "Edit Referral":
                    Response.Redirect(@"EditReferrals.aspx?vid=" + pVisitid.Value + "&Rid=" + pRefId.Value + "&ActID=" + dList.SelectedValue.Split('~')[1], true);
                    break;
                case "Book Slots":
                    Response.Redirect("~"+dList.SelectedValue.Split('~')[0] + "?pid=" + pId.Value + "&rorg=" + pReferToOrg.Value + "&rfid=" + pRefId.Value);
                    break;
                default:

                    break;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error In OutBoundReferral Actions.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Referrals1.ReferedDate = txtReferedDate.Text;
            Referrals1.ReferedOrg = ddlReferedOrg.SelectedValue.Split('~')[1];
            Referrals1.ReferedLoc = ddlReferedOrg.SelectedValue.Split('~')[0];
            Referrals1.PatientURN = txtURN.Text;
            Referrals1.Status = ddlStatus.SelectedItem.Text;
            returnCode = Referrals1.BindOutBoundReferral();
            pStatus.Value = ddlStatus.SelectedItem.Text;
            if (returnCode != -1)
            {
                divAction.Visible = true;
            }
            else
            {
                divAction.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Search Out Bound Referral  ", ex);
        }
    }
}
