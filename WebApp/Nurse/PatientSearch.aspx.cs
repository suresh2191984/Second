using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
public partial class Nurse_PatientSearch : BasePage
{

    public Nurse_PatientSearch()
        : base("Nurse\\PatientSearch.aspx")
    {
    }
    int OP;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        uctlPatientSearch.onSearchComplete += new EventHandler(uctlPatientSearch_onSearchComplete);
        if (!IsPostBack)
        {
            OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            returnCode = nurseBL.GetActions(RoleID, OP, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages);
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
                //lstActionsMaster = lstActionMaster.ToList();
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                //dList.DataValueField = "PageURL";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
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
        lblError.Text = error;
        return retval;
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = 0;
            pid = uctlPatientSearch.GetSelectedPatient();
            ////Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&type=U", true);
            //Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?pid=" + pid.ToString(), true);
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
                string sPath = "Nurse\\\\PatientSearch.aspx.cs_1";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+sPath +"');", true);
 
            }
            #endregion
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
}
