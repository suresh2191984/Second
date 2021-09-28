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
public partial class BillSearch : BasePage
{
    int searchtype;

    public BillSearch()
        : base("Reception_BillSearch_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();

    string alert = Resources.Reception_ClientDisplay.Reception_BillSearch_aspx_02 == null ? "Alert" : Resources.Reception_ClientDisplay.Reception_BillSearch_aspx_02;
    string msg = Resources.Reception_ClientDisplay.Reception_BillSearch_aspx_01 == null ? "Alert" : Resources.Reception_ClientDisplay.Reception_BillSearch_aspx_01;

    protected void Page_Load(object sender, EventArgs e)
    {
        
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
        if (!IsPostBack)
        {
            if (RoleID == 1)
            {
                physicianHeader.Visible = true;
                userHeader.Visible = false;
            }
            else
            {
                physicianHeader.Visible = false;
                userHeader.Visible = true;
            }
            long returnCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>();
            searchtype = Convert.ToInt32(TaskHelper.SearchType.BillSearch);
            if (IsTrustedOrg == "Y")
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActionsIsTrusterdOrg(RoleID, searchtype, out lstActionMaster);
            }
            else
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, searchtype, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            }
            //foreach (ActionMaster src in lstActionMaster)
            //{
            //    dList.Items.Add(new ListItem(src.ActionName, src.PageURL+"~"+src.ActionID));
            //}
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
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
        }
    }
    protected void uctrlBillSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctrlBillSearch.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }
    private bool validatePage(long bid)
    {
        bool retval = true;
        string error = "";
        if (bid <= 0)
        {
            retval = false;
            error = "Please Select a Bill";
        }
        ErrorDisplay1.ShowError = true;
        ErrorDisplay1.Status = error;
        return retval;
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        string queryString = string.Empty;
        try
        {
            string billNo = string.Empty;
            billNo = uctrlBillSearch.GetSelectedBill();
            //string[] listValue = dList.SelectedValue.Split('~');
            //if (dList.SelectedItem.Text == "View & Cancel Bill")
            //{
            //    queryString+=listValue[0]+"?CancelBill=1&billNo=" + billNo.ToString();
            //}
            //else
            //{
            //    queryString += listValue[0] + "?billNo=" + billNo.ToString();
            //}
            
            //Response.Redirect(Request.ApplicationPath + queryString, true);
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
            objQueryMaster.BillNumber = billNo.ToString();
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
              //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ValidationWindow('"+ msg +"','"+ alert +"');", true);
            }
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    
}
