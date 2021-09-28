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

public partial class Corporate_CorporatePatientSearch : BasePage
{
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
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        objBl = new AdminReports_BL(base.ContextInfo);
        //uctlPatientSearch.onSearchComplete += new EventHandler(uctlPatientSearch_onSearchComplete);
        //TextBox txt = (TextBox)uctlPatientSearch.FindControl("txtDOB");
        //txt.Attributes.Add("OnChange", "ExcedDate('" + txt.ClientID.ToString() + "','',0,0);");
        string EmployeeTypeNumber = string.Empty;
        if (!IsPostBack)
        {
            
            //---------------------------------AgeLimit Configuration
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("AgeLimitForDependents", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                AgeLimit =Convert.ToInt32(lstConfig[0].ConfigValue.Trim());
            hdnPatientAgeLimit.Value = AgeLimit.ToString();

            if (RoleHelper.Physician == RoleName)
                tdSelect.Attributes.Add("style", "block");

            //--------------------------------------------------------
            
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
                returnCode = nurseBL.GetActions(RoleID, OP, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }
            if (lstActionMaster.Count > 0)
            {
                aRow.Attributes.Add("style", "block");
                dList.DataSource = lstActionMaster;
                lstActionsMaster = lstActionMaster.ToList();
                dList.DataTextField = "ActionName";
                //dList.DataValueField = "PageURL";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            List<Patient> patientList = new List<Patient>();
            List<Bookings> lstBookings = new List<Bookings>();
            List<Complaint> lstSchedules = new List<Complaint>();
            List<Bookings> lstFullSchedules = new List<Bookings>();
            List<Attune.Podium.BusinessEntities.Login> lstLoginDetails = new List<Attune.Podium.BusinessEntities.Login>();
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo); List<PriorityMaster> lstPriorityMaster = new List<PriorityMaster>();
            string sPatientName = string.Empty;
            returnCode = patientVisitBL.GetVisitEntryPageData(OrgID, sPatientName, out lstPatientCondition,
                                                                out lstLocation, out lstPhysician, out lstVisitPurpose,
                                                                out lstSimilarPatients, out lstBookings, out lstSchedules,
                                                                out lstFullSchedules, out lstPriorityMaster, ILocationID);

            if (returnCode == 0)
            {
                LoadLocation(lstLocation);
            }
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
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long patientID = 0;
            string EmpNo = string.Empty;
            int RateID = 0;
            patientID = uctlPatientSearch.GetSelectedPatient();
            HiddenField hdnEmpNo=(HiddenField)uctlPatientSearch.FindControl("hdnEmpNo");
            EmpNo = hdnEmpNo.Value.ToString();

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
            
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            if (dList.SelectedValue == "View_Consoldate_Sheet_PhysiotherapyNotes")
            {
                GetPreviousPhysioVisit(patientID);
               
            }
            else
            {
                if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
                {
                    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
                }
                objQueryMaster.Querystring = QueryString;
                objQueryMaster.PatientID = patientID.ToString();
                if (dList.SelectedValue == "Make_Visit_Entry_CorporateQuickBilling")
                {
                    List<RateMaster> lstRateType = new List<RateMaster>();
                    AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
                    RateMaster obja = new RateMaster();
                    long retCode = -1;
                    string OrgType = "COrg";
                    retCode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
                    if (lstRateType.Count > 0)
                    {
                        RateID = lstRateType.Find(p => p.RateCode == "GENERAL").RateId;
                        objQueryMaster.RateValue = RateID.ToString();
                    }
                    objQueryMaster.ViewType = "OP";
                    objQueryMaster.EmployeeNo = EmpNo.ToString();
                }
                AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);

                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    Response.Redirect(RedirectURL, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                }
            }
            #endregion

            #region HardCode
            //if (dList.SelectedItem.Text.ToLower() == "make visit entry")
            
            //{
            //    List<RateMaster> lstRateType = new List<RateMaster>();
            //    AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            //    RateMaster obja = new RateMaster();
            //    int RateID = 0;
            //    long retCode = -1;
            //    retCode = objBl.pGetRateTypeMaster(OrgID, out lstRateType);
            //    if (lstRateType.Count > 0)
            //    {
            //        RateID = lstRateType.Find(p => p.RateName == "GENERAL").RateId;
            //    }
            //    Response.Redirect(Request.ApplicationPath + "/Corporate/CorporateQuickBilling.aspx" + "?EmpNo=" + EmpNo.ToString() +"&PID=" + patientID.ToString() + "&vType=" + "OP" + "&RateID=" + RateID, true);
            //}
            //else
            //{
            //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue.ToString() + "?PID=" + patientID.ToString());
            //}
            #endregion
        }
        catch (Exception ex)
        {

            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem while making visit entry. Please try after some time.";
            CLogger.LogError("Error while executing bsave_Click." + ErrorDisplay1.Status, ex);
        }
        //pbl.pCheckPatientisIPorOP(0, pid, OrgID, out patientType);
        //Corporate/CorporateBilling.aspx?&pid=26492&vid=60029
    }

    public void GetPreviousPhysioVisit(long PatientID)
    {

        try
        {
            string VisitDate = string.Empty;
            List<PatientPhysioDetails> lsPatientPhysioDetails = new List<PatientPhysioDetails>();
            List<PhysioCompliant> lstPhysioCompliant = new List<PhysioCompliant>();
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.GetPreviousPhysioVisitDt(PatientID, VisitDate, out lsPatientPhysioDetails, out lstPhysioCompliant);

            gvPrevVisitDetail.Visible = true;
            gvPrevVisitDetail.DataSource = lsPatientPhysioDetails;
            gvPrevVisitDetail.DataBind();
            
            gvPrevDiagnose.Visible = true;
            gvPrevDiagnose.DataSource = lstPhysioCompliant;
            gvPrevDiagnose.DataBind();
            ModelPopPatient.Show();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error Wile binding  GetPreviousPhysioVisit ", ex);
        }
    }

    protected void gvPrevVisitDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientPhysioDetails PPD = (PatientPhysioDetails)e.Row.DataItem;
                Label lblRemarks = (Label)e.Row.FindControl("lblPhysioNote");
                lblRemarks.Text = PPD.Remarks.Split('|')[0];
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Wile binding GetPreviousPhysioVisit ", ex);
        }
    }
  
}
