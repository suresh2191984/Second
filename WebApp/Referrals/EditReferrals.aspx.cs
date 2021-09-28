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

public partial class Referrals_EditReferrals : BasePage
{
    
    Investigation_BL invbl ;
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    List<Physician> lstPhysician = new List<Physician>();
    Physician_BL PhysicianBL ;
    List<Organization> lstorgs = new List<Organization>();
    List<Referral> lstInvestigationFeesDetails = new List<Referral>();
    Referrals_BL objReferrals_BL;
    PatientVisit_BL patientBL ;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    long patientVisitID = 0;
    long Rid = 0;
    long ActID = 0;
    long returnCode = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    Tasks_BL taskBL;
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
            try
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["Rid"], out Rid);
                LoadInvestigations(patientVisitID, Rid);
                //btnUpdate.Attributes.Add("OnClientClick", "javascript:alert('gfdfdsf');");

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Loading the EditReferrals.aspx", ex);
            }

           
        }
    }

    public void LoadInvestigations(long patientVisitID,long Rid)
    {
        try
        {

            returnCode = new Referrals_BL(base.ContextInfo).GetReferralsINVDetails(patientVisitID,Rid, out lstInvestigationFeesDetails);
            

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
   
    protected void gvInvestigations_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Referral inv = new Referral();
            inv = (Referral)e.Row.DataItem;
            DropDownList ddlPerformingOrg = (DropDownList)e.Row.FindControl("ddlPerformingOrg");
            HiddenField hdnPerforming = (HiddenField)e.Row.FindControl("hdnPerforming");
            Image imgPaid = (Image)e.Row.FindControl("imgPaid");
            HiddenField hdnType = (HiddenField)e.Row.FindControl("hdnType");

            loadlocations(ddlPerformingOrg);
            
            if (inv.ReferralStatus=="Picked")
            {
                ddlPerformingOrg.Enabled = false;
            }
            hdnType.Value = inv.OrderedInvStatus.Split('~')[1];
            if (inv.OrderedInvStatus.Split('~')[0]=="paid")
            {
                imgPaid.Visible = true;
                //ddlPerformingOrg.Enabled = false;
                divPaid.Visible = true;
                hdnStatus.Value = "paid";
            }
            ddlPerformingOrg.SelectedValue = inv.ReferedToLocation.ToString() + "~" + inv.ReferedToOrgID.ToString();
            hdnPerforming.Value = inv.ReferedToLocation.ToString() + "~" + inv.ReferedToOrgID.ToString();
        }
    }

    protected void loadlocations(DropDownList ddlLocation)
    {
        try
        {
            if (lstLocation.Count == 0)
            {
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
            }
                ddlLocation.DataSource = lstLocation;
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "Comments";
                ddlLocation.DataBind();
                ddlLocation.Items.Insert(0, "---Select---");
                ddlLocation.Items[0].Value = "0~0";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Org ", ex);
        }

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        List<Referral> lstReferrals = new List<Referral>();
        List<OrderedInvestigations> lstUpdatePatientInvStatusHL = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstReferralsInvestigation = new List<OrderedInvestigations>();


        try
        {
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
            Int64.TryParse(Request.QueryString["Rid"], out Rid);
            Int64.TryParse(Request.QueryString["ActID"], out ActID);
            lstUpdatePatientInvStatusHL = GetPaidPatientInvestigation();
            lstReferrals = GetReferralsInvestigation();
            returnCode = objReferrals_BL.CheckReferralsInvestigation(lstUpdatePatientInvStatusHL, out lstReferralsInvestigation);

            var temp = from inv in lstUpdatePatientInvStatusHL
                       join r in lstReferrals
                       on new { inv.ReferedToLocation } equals new { r.ReferedToLocation }
                      select inv;

            if (lstReferralsInvestigation.Count == 0)
            {
                if (lstReferrals.Count > 0)
                {
                    // Update patient investigation status
                    returnCode = objReferrals_BL.SaveReferrals(lstReferrals, lstUpdatePatientInvStatusHL, LID);

                    //returnCode = objReferrals_BL.UpdateReferrals(lstReferrals, LID);
                    int count = -1;
                    //Update  Paid InvestigationPayment AND Update Ordered Investigation to Refered Investigation 
                    returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvSampleCollected(lstUpdatePatientInvStatusHL, 0, out count);

                    if (lstUpdatePatientInvStatusHL.Count == temp.Count())
                    {
                        returnCode = objReferrals_BL.UpdateReferralStatus(Rid, "Out", ActID, LID);
                    }
                }
                Response.Redirect(@"ReferedInvestigation.aspx?vid=" + patientVisitID.ToString() + "&Rid=" + Rid.ToString(), true);

            }
            else
            {
                # region Referred to Org
                string tempINV = "The following Investigation are not performed in the corresponding Organizations </br></br> " +
                    "<table border='1' cellpadding='2' cellspacing='2' width='70%' style='margin-left:30px'><tr><td>";
                returnCode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
                int i = 1;
                ReferralsInvestigation(lstReferralsInvestigation);

                foreach (OrderedInvestigations item in lstReferralsInvestigation)
                {
                    List<OrganizationAddress> TempLocation = new List<OrganizationAddress>();
                    TempLocation = lstLocation;
                    OrganizationAddress obj = TempLocation.Find(p => p.Comments == item.ReferedToLocation.ToString() + "~" + item.ReferedToOrgID.ToString());
                    tempINV += i.ToString() + "</td><td>" + item.Name + "</td><td>" + obj.Location + "</td></tr><tr><td>";
                    i++;
                }
                lblReferrals.Text = tempINV + "</td></tr></table></br>";
                #endregion
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Updating Referrals Investigation", ex);
        }
       
    }

    public void ReferralsInvestigation(List<OrderedInvestigations> Investigations)
    {
        try
        {
            foreach (GridViewRow row in gvInvestigations.Rows)
            {
                HiddenField hdnID = (HiddenField)row.FindControl("hdnID");
                DropDownList ddlPerformingOrg = (DropDownList)row.FindControl("ddlPerformingOrg");
                List<OrderedInvestigations> obj = new List<OrderedInvestigations>();
                obj = Investigations.FindAll(p => p.ID == Convert.ToInt64(hdnID.Value) && p.ReferedToLocation.ToString() + "~" + p.ReferedToOrgID.ToString() == ddlPerformingOrg.SelectedValue);
                if (obj.Count > 0)
                {
                    if (obj[0].ID != 0)
                    {
                        row.BackColor = System.Drawing.Color.Tomato;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Updating Referrals Investigation", ex);
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
                    HiddenField hdnType = (HiddenField)row.FindControl("hdnType");
                    HiddenField hdnReferralStatus = (HiddenField)row.FindControl("hdnReferralStatus");

                    if (ddlPerformingOrg.SelectedValue != "0~0")
                    {
                        OrderedInvestigations patientInvestigation = new OrderedInvestigations();
                        patientInvestigation.VisitID = patientVisitID;
                        patientInvestigation.ID = Convert.ToInt32(hdnID.Value);
                        patientInvestigation.CreatedBy = 0;
                        patientInvestigation.Status = hdnReferralStatus.Value.Split('~')[0];
                        patientInvestigation.Type = hdnType.Value;
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

    private  List<Referral> GetReferralsInvestigation()
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
