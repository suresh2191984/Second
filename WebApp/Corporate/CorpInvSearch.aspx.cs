using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Collections;
using Attune.Podium.BillingEngine;
using Attune.Utilitie.Helper;

public partial class Corporate_CorpInvSearch : BasePage
{
    int OP; long returnCode = -1;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadActions();
             
        }
    }
    protected void LoadActions()
    {
            OP = Convert.ToInt32(TaskHelper.SearchType.Corporate);
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            if (IsTrustedOrg == "Y")
            {
                returnCode = nurseBL.GetActionsIsTrusterdOrg(RoleID, OP, out lstActionMaster);
            }
            else
            {
                returnCode = nurseBL.GetActions(RoleID, OP, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }
            //lstActionsMaster = lstActionMaster.ToList();
//------------------------GURUNAT.S 
            if (lstActionMaster.Count > 0)
            {
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                //dList.DataValueField = "PageURL";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
//----------------------------------
             
    }
    
     
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long patientID = 0;
            patientID = uctlPatientSearch.GetSelectedPatient();

            if (dList.SelectedValue == "Make_Visit_Entry_CorpInvBilling")
            {
                long returnCode = -1;
                int otherID = -1;
                long visitID = -1;
                string feeType = string.Empty;
                string otherName = string.Empty;
                string PaymentLogic = string.Empty;
                int purpID = (int)TaskHelper.VisitPurpose.Pharmacy;
                int phyID = -1;
                long referOrgID = -1;
                string physicianName = String.Empty;
                string referrerName = string.Empty;
                
               
                try
                {
                    PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
                    PatientVisit pVisit = new PatientVisit();
                    Patient_BL pbl = new Patient_BL(base.ContextInfo);
                    string patientType = string.Empty;

                     
                    pVisit.PhysicianName = "";
                    pVisit.VisitPurposeID = purpID;
                    pVisit.PhysicianID = phyID;
                    pVisit.OrgID = OrgID;
                    pVisit.PatientID = patientID;
                    pVisit.OrgAddressID = ILocationID;
                    pVisit.SpecialityID = otherID;
                    pVisit.ReferOrgID = referOrgID;
                    
                    pVisit.CreatedBy = LID;
                    
                    pVisit.VisitType = 0;
                    long enteredPatientID = 0;
                    int iTokenNo = 0;
                    long lScheduleNo = 0;
                    long lResourceTemplateNo = 0;
                    string sPassedTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToLongTimeString().ToString();
                    DateTime dtFromTime = new DateTime();
                    DateTime dtToTime = new DateTime();


                    if (dtFromTime.ToString("dd/MM/yyyy") == "01/01/0001")
                    {
                        dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    }

                    if (dtToTime.ToString("dd/MM/yyyy") == "01/01/0001")
                    {
                        dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    }
                    string needIPNo = "N";
                    int iRetTokenNumber = 0;
                      List<VisitClientMapping>    lst = IPClientTpaInsurance1.GetClientValues();;
                    returnCode = pvisitBL.SaveVisit(pVisit, out visitID, enteredPatientID,
                                                    iTokenNo, lScheduleNo, lResourceTemplateNo,
                                                    sPassedTime, out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);
                    //Response.Redirect(Request.ApplicationPath + "/Corporate/CorpInvBilling.aspx" + "?PID=" + patientID.ToString() + "&VID=" + visitID.ToString() + "&vType=" + "OP" + "&RateID=" + CorporateID, true);
                    #region Get Redirect URL
                    QueryMaster objQueryMaster = new QueryMaster();
                    
                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;

                    //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
                    //{
                    //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
                    //}
                    #region View State Action List
                    string ActCode = dList.SelectedValue;
                    string ActionList = ViewState["ActionList"].ToString();
                    foreach (string CompareList in ActionList.Split('^'))
                    {
                        if (CompareList.Split('~')[0] == ActCode)
                        {
                            QueryString = CompareList.Split('~')[1];
                            break;
                        }
                    }
                    #endregion
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientID = patientID.ToString();
                    objQueryMaster.PatientVisitID = visitID.ToString();
                    objQueryMaster.ViewType = "OP";
                     
                    AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    #endregion
                }
                catch (Exception ex)
                {

                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
                    CLogger.LogError("Error while executing bsave_Click." + ErrorDisplay1.Status, ex);
                }
            }
            else
            {
                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.ToString() + "?PID=" + patientID.ToString());
            }
        }
        catch (Exception ex)
        {

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
            CLogger.LogError("Error while executing bsave_Click." + ErrorDisplay1.Status, ex);
        }
     
    }

}

