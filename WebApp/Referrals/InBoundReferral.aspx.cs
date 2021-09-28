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

public partial class Reception_InBoundReferral : BasePage
{
    Referrals_BL objReferrals_BL ;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    long returncode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        Referrals1.flag = "INBOUND";
        if (!IsPostBack)
        {
            //loadlocations();
            LoadReferrals();
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
            returnCode = objReferrals_BL.GetReferralStatus(RoleID, "In", out lstReferralActionOption);
            dList.DataSource = lstReferralActionOption;
            dList.DataTextField = "ActionName";
            dList.DataValueField = "Type";
            dList.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load the InBoundReferral Actions", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    //protected void loadlocations()
    //{
    //    try
    //    {
    //        if (lstLocation.Count == 0)
    //        {
    //            returncode = objReferrals_BL.GetALLLocation(OrgID, out lstLocation);
    //        }
    //        var tempLocation = from loc in lstLocation
    //                           where loc.OrgID != OrgID
    //                           select loc;

    //        ddlReferedOrg.DataSource = tempLocation;
    //        ddlReferedOrg.DataTextField = "Location";
    //        ddlReferedOrg.DataValueField = "Comments";
    //        ddlReferedOrg.DataBind();
    //        ddlReferedOrg.Items.Insert(0, "---Select---");
    //        ddlReferedOrg.Items[0].Value = "0~0";



    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in loading Org ", ex);
    //    }

    //}
    
    private void LoadReferrals()
    {
        long returnCode = -1;
        try
        {
            Referrals1.flag = "INBOUND";
            returnCode = Referrals1.GetReferalDetails();
            if (returnCode!=-1)
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
            CLogger.LogError("Error in Load the InBoundReferral", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        

        
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
            try
            {

                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pId.Value + "&Rid=" + pRefId.Value + "&vid=" + pVisitid.Value + "&Aid=" + dList.SelectedValue.Split('~')[1] + "&IsPan=" + pIspatient.Value, true);

                #region Redirect
                //switch (dList.SelectedItem.Text)
                //{

                //    case "Make Visit Entry":
                //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pId.Value + "&Rid=" + pRefId.Value, true);

                //        if (pURN.Value != "-1")
                //        {
                //            Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pId.Value + "&Rid=" + pRefId.Value, true);

                //           
                //            //if (pIspatient.Value == "Y")
                //            //{
                //            //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pId.Value + "&Rid="+pRefId.Value, true);
                //            //       //Response.Redirect(@"..\Reception\PatientVisit.aspx?PID=" + pId.Value + "&Rid="+pRefId.Value, true);

                //            //}
                //            //else
                //            //{
                //            //    //Response.Redirect(@"..\Reception\PatientRegistration.aspx?PID=" + pId.Value + "&Rid=" + pRefId.Value, true);
                //            //}
                //           
                //        }
                //        else
                //        {
                //            Response.Redirect(@"..\Reception\PatientRegistration.aspx?PID=" + pId.Value + "&Rid=" + pRefId.Value, true);
                //        }
                //        break;
                //    case "Reject Referral":
                //        returncode = objReferrals_BL.UpdateReferralStatus(Int64.Parse(pRefId.Value), "In", Int64.Parse(dList.SelectedValue), LID);

                //        #region Search
                //        Referrals1.ReferedDate = txtReferedDate.Text;
                //        Referrals1.ReferedOrg = ddlReferedOrg.SelectedValue.Split('~')[1];
                //        Referrals1.ReferedLoc = ddlReferedOrg.SelectedValue.Split('~')[0];
                //        Referrals1.PatientURN = txtURN.Text;
                //        Referrals1.Status = ddlStatus.SelectedItem.Text;
                //        returncode = Referrals1.BindOutBoundReferral();
                //        #endregion
                //        break;

                //    default:

                //        break;
                //}
                //LoadReferrals();
                #endregion
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string exp = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error In InBoundReferral Actions.", ex);
              //  ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            //Referrals1.ReferedDate = txtReferedDate.Text;
            //Referrals1.ReferedOrg = ddlReferedOrg.SelectedValue.Split('~')[1];
            //Referrals1.ReferedLoc = ddlReferedOrg.SelectedValue.Split('~')[0];
            //Referrals1.PatientURN = txtURN.Text;
            //Referrals1.Status = ddlStatus.SelectedItem.Text;
            returncode = Referrals1.BindInBoundReferral();
            if (returncode != -1)
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
