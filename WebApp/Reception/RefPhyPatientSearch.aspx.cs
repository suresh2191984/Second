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

public partial class Reception_RefPhyPatientSearch : BasePage
{
    int OP; long returnCode = -1; //List<SearchActions> pagesReload = new List<SearchActions>(); 
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {

        uctlPatientSearch.onSearchComplete += new EventHandler(uctlPatientSearch_onSearchComplete);
        TextBox txt = (TextBox)uctlPatientSearch.FindControl("txtDOB");
        txt.Attributes.Add("OnChange", "ExcedDate('" + txt.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {

            if (RoleID == 1)
            {
                PhyHeader1.Visible = true;
                UsrHeader1.Visible = false;
            }
            else
            {
                PhyHeader1.Visible = false;
                UsrHeader1.Visible = true;
            }
            OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
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
            if (lstActionMaster.Count != 0)
            {
                //lstActionsMaster = lstActionMaster.ToList();
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
            else
            {
                aRow.Style.Add("display", "none");
            }

        }
    }

    protected void uctlPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctlPatientSearch.HasResult)
        {
            aRow.Visible = true;

        }
        else
        {
            aRow.Visible = false;
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = uctlPatientSearch.GetSelectedPatient();
            if (validatePage(pid))
            {
                string strRedirect = string.Format("~/Nurse/PatientVitals.aspx?PatientID={0}&type={1}", pid.ToString(), 'U');
                Response.Redirect(strRedirect, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = uctlPatientSearch.GetSelectedPatient();
            if (validatePage(pid))
            {
                string strRedirect = string.Format("~/Nurse/PatientVitals.aspx?PatientID={0}&type={1}", pid.ToString(), 'I');
                Response.Redirect(strRedirect, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    private bool validatePage(long pid)
    {
        bool retval = true;
        string error = "";
        if (pid <= 0)
        {
            retval = false;
            error = "Please Select a Patient";
        }
        ErrorDisplay1.ShowError = true;
        ErrorDisplay1.Status = error;
        return retval;


    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = 0;
            int patOrgID = -1;

            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;

            pid = uctlPatientSearch.GetSelectedPatient();
            patOrgID = uctlPatientSearch.GetSelectedPatientOrgID();
            pbl.pCheckPatientisIPorOP(0, pid, OrgID, out patientType);

            //if (patientType != "Admitted")
            //{
            //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //}
            //else
            //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
            //}

            IP_BL pIP_BL = new IP_BL(base.ContextInfo);
            List<DischargeSummary> lstDischargeSummaryByPatientID = new List<DischargeSummary>();

            pIP_BL.GetPatientDischargeDetailByPatientID(pid, out lstDischargeSummaryByPatientID);

            #region Hardcode
            //if (IsTrustedOrg == "Y")
            //{
            //    long pRefOrgPID = -1; // After Inserting the Patient from Other Org
            //    if (patientType != "Admitted")
            //    {
            //        int pcount;
            //        long pageID = Convert.ToInt64(dList.SelectedValue.Split('~')[1]);
            //        returnCode = new TrustedOrg(base.ContextInfo).CheckPageAccess(pageID, OrgID, patOrgID, out pcount);

            //        //string NeedRegistration = dList.SelectedValue.Split('~')[1];
            //        if (pcount == 0)
            //        {
            //            //Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //            uctlPatientSearch.accessinPatientSearchPage(sender, e);
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action Cannot be Performed as Patient belongs to another Organization');", true);
            //        }
            //        else
            //        {
            //            string URNo = string.Empty;
            //            int pURNORGid = -1;
            //            new Patient_BL(base.ContextInfo).CheckURNoAvailablity(pid, out URNo, out pURNORGid);
            //            if ((URNo == "") && (pURNORGid == OrgID))
            //            {
            //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //            }
            //            else if ((URNo == "") && (pURNORGid != OrgID))
            //            {
            //                Response.Redirect(@"../Reception/PatientRegistration.aspx?PID=" + pid.ToString() + "&vType=OP" + "&TORG=Y", true);
            //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Urn not available');", true);
            //            }
            //            else if ((URNo != "") && (pURNORGid != OrgID))
            //            {
            //                returnCode = new Patient_BL(base.ContextInfo).InsertPatientFromReferredOrg(pid, OrgID, out pRefOrgPID);
            //                //Response.Redirect("PatientVisit.aspx?PID=" + pRefOrgPID.ToString(), true);
            //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pRefOrgPID.ToString() + "&vType=" + "OP", true);
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Move on to Registration & Visit');", true);
            //            }
            //            else if ((URNo != "") && (pURNORGid == OrgID))
            //            {
            //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //            }
            //        }
            //    }
            //    else
            //    {

            //        //if (dList.SelectedValue.ToString() == "/Physician/DischargeSummaryCaseSheet.aspx")
            //        //{
            //        if (dList.SelectedValue.ToString() == "/DischargeSummary/DischargeSummaryDynamic.aspx")
            //        {
            //            if (lstDischargeSummaryByPatientID.Count > 0)
            //            {
            //                string NeedRegistration = dList.SelectedValue.Split('~')[1];
            //                if (NeedRegistration == "N")
            //                {
            //                    Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?pid=" + pid.ToString() + "&vType=" + "OP", true);
            //                }
            //                else
            //                {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Patient registration is needed');", true);
            //                }
            //            }
            //            else
            //            {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for This patient');", true);

            //            }

            //        }

            //        else
            //        {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);

            //        }
            //    }
            //}
            //else
            //{
            //    if (dList.SelectedItem.Text == "Print Patient Registration Details")
            //    {
            //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&OP=Y", true);
            //    }
            //    //else if (dList.SelectedItem.Text == "Print Patient Admission Details")
            //    //{
            //    //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&IP=Y", true);
            //    //}
            //    //Commented due to Dynamic DichargeSummmary
            //    //else if (patientType != "Admitted" && dList.SelectedValue.ToString() != "/Physician/DischargeSummaryCaseSheet.aspx")
            //    //{
            //    //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //    //}
            //    else if (patientType != "Admitted" && dList.SelectedValue.ToString() != "/DischargeSummary/DischargeSummaryDynamic.aspx")
            //    {
            //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //    }

            //    else if (patientType == "Admitted" && dList.SelectedValue.ToString() == "/Reception/PatientRegistration.aspx")
            //    {
            //        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "IP", true);
            //    }

            //    //else if (patientType == "Admitted" && dList.SelectedValue.ToString() == "/Reception/VisitDetails.aspx")
            //    //{
            //    //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "IP", true);
            //    //}
            //    else
            //    {

            //        //if (dList.SelectedValue.ToString() == "/Physician/DischargeSummaryCaseSheet.aspx")
            //        //{
            //        if (dList.SelectedValue.ToString() == "/DischargeSummary/DischargeSummaryDynamic.aspx")
            //        {
            //            if (lstDischargeSummaryByPatientID.Count > 0)
            //            {
            //                Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?pid=" + pid.ToString() + "&vType=" + "OP", true);
            //            }
            //            else
            //            {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for This patient');", true);

            //            }

            //        }

            //        else
            //        {
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);

            //        }
            //    }
            //}
            #endregion

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
            objQueryMaster.PatientID = pid.ToString();
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                string sPath = "Reception\\\\RefPhyPatientSearch.aspx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"');", true);
            }
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
}
