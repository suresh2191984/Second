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
public partial class LabPatientSearch : BasePage
{
    public LabPatientSearch()
        : base("Reception_LabPatientSearch_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
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
              //  PhyHeader1.Visible = true;
               // UsrHeader1.Visible = false;
            }
            else
            {
              //  PhyHeader1.Visible = false;
               // UsrHeader1.Visible = true;
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
            if (lstActionMaster.Count > 0)
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
            Session["LastPageUrl"] = Request.Url.AbsolutePath.ToString();
        }
    }
    //protected void Search_click(object sender,EventArgs )
    protected void uctlPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
       

        if (uctlPatientSearch.HasResult)
        {
            //aRow.Style.Add("display", "block");
            Row.Visible = true;
        }
        else
        {
            Row.Visible = false;
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
       // ErrorDisplay1.ShowError = true;
       // ErrorDisplay1.Status = error;
        return retval;


    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = 0;
            long PatientVisitID =-1;
            pid = uctlPatientSearch.GetSelectedPatient();
            string PatientName = string.Empty;
                PatientName = uctlPatientSearch.GetSelectedPatientName();

            if (pid == -1)
                return;
            PatientVisitID = uctlPatientSearch.GetSelectedVisit();
           // Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?pid=" + pid.ToString() , true);
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
            objQueryMaster.PatientVisitID = PatientVisitID.ToString();
            objQueryMaster.PatientName = PatientName.ToString();
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {

                string alert = Resources.Reception_AppMsg.Reception_PatientSearch_Alert == null ? "Alert" : Resources.Reception_AppMsg.Reception_PatientSearch_Alert;
                string url = Resources.Reception_AppMsg.Reception_VisitDetails_aspx_06 == null ? "URL Not Found" : Resources.Reception_AppMsg.Reception_VisitDetails_aspx_06;
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('" + url + "','" + alert + "');", true);

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
