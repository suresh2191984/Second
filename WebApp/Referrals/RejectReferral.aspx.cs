using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;
using System.Collections;
public partial class Referrals_RejectReferral :BasePage
{
    
    Investigation_BL invbl ;
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL PhysicianBL ;
    List<Organization> lstorgs = new List<Organization>();
    List<Referral> lstInvestigationFeesDetails = new List<Referral>();
    Referrals_BL objReferrals_BL ;
    PatientVisit_BL patientBL;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    long patientVisitID = 0;
    long patientID = 0;
    long Rid = 0;
    long invClientID = 0;
    decimal returnCode = 0;
    long Aid = -1;
    long taskID = -1;
    long ptaskID = -1;
    long createTaskID = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL ;
    BillingEngine billingBL;
    protected void Page_Load(object sender, EventArgs e)
    {
        billingBL = new BillingEngine(base.ContextInfo);
        invbl = new Investigation_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        patientBL = new PatientVisit_BL(base.ContextInfo);
        taskBL = new Tasks_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["Rid"], out Rid);
            LoadInvestigations(patientVisitID, Rid);
        }
    }

    public void LoadInvestigations(long patientVisitID, long Rid)
    {
        try
        {

            returnCode = new Referrals_BL(base.ContextInfo).GetReferralsINVDetails(patientVisitID, Rid, out lstInvestigationFeesDetails);


            if (lstInvestigationFeesDetails.Count > 0)
            {
                gvInvestigations.DataSource = lstInvestigationFeesDetails;
                gvInvestigations.DataBind();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Investigation Fee ", ex);
        }
    }


    protected void btnReject_Click(object sender, EventArgs e)
    {
        List<Referral> lstReferrals = new List<Referral>();
        List<OrderedInvestigations> lstUpdatePatientInvStatusHL = new List<OrderedInvestigations>();

        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["Rid"], out Rid);
            Int64.TryParse(Request.QueryString["Aid"], out Aid);
            returnCode = objReferrals_BL.UpdateReferralStatus(Rid, "In", Aid, LID);
            Response.Redirect(@"InBoundReferral.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception Ex)
        {

            throw;
        }

    }

    private List<OrderedInvestigations> GetPaidPatientInvestigation()
    {
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        List<OrderedInvestigations> GetPaidInvestigation = new List<OrderedInvestigations>();
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    TextBox txtAmount = (TextBox)row.FindControl("txtAmount");
                    Label lblDescription = (Label)row.FindControl("lblDescription");
                    HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                    HiddenField hdnIsGrup = (HiddenField)row.FindControl("hdnisGroup");
                    HiddenField hdnSNo = (HiddenField)row.FindControl("hdnSno");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                    if (ddlPerformingOrg.SelectedValue != "0~0")
                    {
                        OrderedInvestigations patientInvestigation = new OrderedInvestigations();
                        patientInvestigation.VisitID = patientVisitID;
                        patientInvestigation.ID = Convert.ToInt32(hdnID.Value);
                        patientInvestigation.CreatedBy = 0;
                        patientInvestigation.Status = "Refered";
                        patientInvestigation.ReferedToOrgID = Int32.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]);
                        patientInvestigation.ReferedToLocation = Int32.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0]);
                        GetPaidInvestigation.Add(patientInvestigation);
                    }

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return GetPaidInvestigation;
    }

    private List<Referral> GetReferralsInvestigation()
    {
        List<Referral> lstReferrals = new List<Referral>();
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        Referral objReferrals;
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                objReferrals = new Referral();
                if (((CheckBox)row.FindControl("chkTest")).Checked == true)
                {
                    HiddenField hdnReferralID = (HiddenField)row.FindControl("hdnReferralID");
                    HiddenField hdnReferralDetailsID = (HiddenField)row.FindControl("hdnReferralDetailsID");
                    DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                    HiddenField hdnPerforming = (HiddenField)row.FindControl("hdnPerforming");

                    if (ddlPerformingOrg.SelectedValue != hdnPerforming.Value && ddlPerformingOrg.SelectedValue != "0~0")
                    {
                        objReferrals.ReferedToOrgID = Int32.Parse(ddlPerformingOrg.SelectedValue.Split('~')[1]);
                        objReferrals.ReferedByOrgID = OrgID;
                        objReferrals.ReferedByVisitID = patientVisitID;
                        objReferrals.ReferralStatus = "Open";
                        objReferrals.ReferralVisitPurposeID = (int)TaskHelper.VisitPurpose.LabInvestigation;
                        objReferrals.ReferedToLocation = Int64.Parse(ddlPerformingOrg.SelectedValue.Split('~')[0]);
                        objReferrals.ReferedByLocation = ILocationID;
                        //objReferrals.ReferralID = Int64.Parse(hdnReferralID.Value);
                        //objReferrals.ReferralDetailsID = Int64.Parse(hdnReferralDetailsID.Value);
                        lstReferrals.Remove(lstReferrals.Find(p => p.ReferedToOrgID == objReferrals.ReferedToOrgID && p.ReferedToLocation == objReferrals.ReferedToLocation));
                        lstReferrals.Add(objReferrals);
                    }

                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving the Investigation Fee", ex);
        }
        return lstReferrals;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}
