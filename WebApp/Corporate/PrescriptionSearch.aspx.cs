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
public partial class Corporate_PrescriptionSearch : BasePage
{
    public Corporate_PrescriptionSearch()

:base("Corporate\\PrescriptionSearch.aspx")

{

}
    int OP; long returnCode = -1;
    int orgAddressID = -1;
    int AgeLimit = 0;
    AdminReports_BL objBl;
    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
    List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
    List<PhysicianSchedule> lstPhysician = new List<PhysicianSchedule>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Patient> lstSimilarPatients = new List<Patient>();
    List<KnowledgeOfService> lstKnowledgeOfService = new List<KnowledgeOfService>();
    List<VisitKnowledgeMapping> lstVisitKnowledgeMapping = new List<VisitKnowledgeMapping>();
    List<KnowledgeOfServiceAttributes> lstKnowledgeOfServiceAttributes = new List<KnowledgeOfServiceAttributes>();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        objBl = new AdminReports_BL(base.ContextInfo);

        uctlPatientSearch.onSearchComplete += new EventHandler(uctlPatientSearch_onSearchComplete);
        string EmployeeTypeNumber = string.Empty;
        if (!IsPostBack)
        {

            OP = Convert.ToInt32(TaskHelper.SearchType.Corporate);
            if (Request.QueryString["EID"] != null)
            {
                EmployeeTypeNumber = Request.QueryString["EID"].ToString();
                uctlPatientSearch.EmployeeNo = EmployeeTypeNumber.ToString();
            }
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            if (IsTrustedOrg == "Y")
            {
                returnCode = nurseBL.GetActionsIsTrusterdOrg(RoleID, OP, out lstActionMaster);
            }
            else
            {
                returnCode = nurseBL.GetActions(RoleID,Convert.ToInt16(TaskHelper.SearchType.Corporate), out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }

            //lstActionsMaster = lstActionMaster.ToList();
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
                ddlAction.DataSource = lstActionMaster;
                ddlAction.DataTextField = "ActionName";
                ddlAction.DataValueField = "ActionCode";
                ddlAction.DataBind();
            }

            if (returnCode == 0)
            {
                LoadLocation(lstLocation);
            }
            if (uctlPatientSearch.HasResult)
            {
                trAction.Visible = true;
            }
            else
            {
                trAction.Visible = false;
            } 
        }
    }
    protected void uctlPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctlPatientSearch.HasResult)
        {
            trAction.Visible = true;

        }
        else
        {
            trAction.Visible = false;
        }
    }
    public void LoadLocation(List<OrganizationAddress> lstLocation)
    {

        if (lstLocation.Count > 0)
        {
            ddlLocatiopn.DataSource = lstLocation;
            ddlLocatiopn.DataTextField = "Location";
            ddlLocatiopn.DataValueField = "AddressID";
            ddlLocatiopn.DataBind();

            if (lstLocation.Count == 1)
            {
                ddlLocatiopn.Items.Insert(0, "------Select------");
                ddlLocatiopn.Items[1].Selected = true;
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocatiopn.Items.Insert(0, "------Select------");
            }

        }
        else
        {
            ddlLocatiopn.Items.Insert(0, "------Select------");
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        HiddenField hdnVisitID=(HiddenField)uctlPatientSearch.FindControl("hdnPatientVisitID");
        HiddenField hdnPatientID = (HiddenField)uctlPatientSearch.FindControl("hdnPatientID");
        HiddenField hdnTaskID = (HiddenField)uctlPatientSearch.FindControl("hdnTaskID");
        HiddenField hdnPhysicianID = (HiddenField)uctlPatientSearch.FindControl("hdnPhysicianID");
        HiddenField hdnPrescriptionNo = (HiddenField)uctlPatientSearch.FindControl("hdnPrescriptionNo");
        HiddenField hdnRefundStatus = (HiddenField)uctlPatientSearch.FindControl("hdnRefundStatus");
        HiddenField hdnStatus = (HiddenField)uctlPatientSearch.FindControl("hdnStatus");
        HiddenField hdnIssueQty = (HiddenField)uctlPatientSearch.FindControl("hdnIssueQty");
        //if (ddlAction.SelectedItem.Text.ToLower() == "view prescription")
        //{
        //    string popPath = "ViewPrescription.aspx?IsPopup=Y&VisitID=" + hdnVisitID.Value + "&PatientID=" + hdnPatientID.Value;
        //    ScriptManager.RegisterStartupScript(this.Page, GetType(), "print", "PrintDynamic('" + popPath + "');", true);
        //}
        //else if (ddlAction.SelectedItem.Text.ToLower() == "issue prescription")
        //{
        //    Response.Redirect("CorpInvBilling.aspx?vid=" + hdnVisitID.Value + "&pid=" + hdnPatientID.Value + "&phyID=" + hdnPhysicianID.Value + "&tid=" + hdnTaskID.Value);
        //}

        #region Get Redirect URL
        QueryMaster objQueryMaster = new QueryMaster();
        
        string RedirectURL = string.Empty;
        string QueryString = string.Empty;
        //if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
        //{
        //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
        //}
        #region View State Action List
        string ActCode = ddlAction.SelectedValue;
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
        objQueryMaster.PatientID = hdnPatientID.Value;
        objQueryMaster.PatientVisitID = hdnVisitID.Value.ToString();
        objQueryMaster.PhysicianID = hdnPhysicianID.Value;
        objQueryMaster.TaskID = hdnTaskID.Value;
        objQueryMaster.PrescriptionNo = hdnPrescriptionNo.Value;

        AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
        if (ddlAction.SelectedValue == "View_Prescription_Corporate_ViewPrescription")
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "print", "PrintDynamic('" + RedirectURL + "');", true);
        }
        else if (!String.IsNullOrEmpty(RedirectURL))
        {
            Response.Redirect(RedirectURL, true);
        }
        else
        {
            string sPath = "Corporate\\\\PrescriptionSearch.aspx.cs_1";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ShowAlertMsg('" + sPath + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
        }
        #endregion
    } 

}
