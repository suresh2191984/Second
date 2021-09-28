using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;

public partial class Billing_BillSearch : BasePage
{
    string type;
    long retval = -1;
    long returnCode = -1;
    long visitID = -1;
    long pvisitID = -1;
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
        if (!IsPostBack)
        {
            BindDropDownValues();
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
            //long returnCode = -1;
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            //List<SearchActions> pages = new List<SearchActions>();
            //type = "BillSearch";
            //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            //dList.DataSource = pages;
            //dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            //dList.DataBind();
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
        try
        {
            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;
            long vid = Convert.ToInt64(hdnVID.Value);
            long pid = Convert.ToInt64(hdnPID.Value);
            long FinalBillID = 0;
            Int64.TryParse(hdnBID.Value, out FinalBillID);

            string purpose = hdnVisitDetail.Value;
            
            pbl.pCheckPatientisIPorOP(vid, pid, OrgID, out patientType);

            if (patientType != "Admitted" || purpose !="Add Bill Items")
            {

                string pagename = string.Empty;

                if (hdnVisitDetail.Value == "Print Bill")
                    pagename = "?vid=" + hdnVID.Value + "&pagetype=BP&bid=" + FinalBillID + "";
                else if (hdnVisitDetail.Value == "Add Bill Items")
                    pagename = "?vid=" + hdnVID.Value + " &pid=" + hdnPID.Value + "&pagetype=ABI&bid=" + FinalBillID + "";
                else if (hdnVisitDetail.Value == "Refund to Patient")
                    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value+ "&bid=" + FinalBillID + "";

                Response.Redirect(Request.ApplicationPath + dList.SelectedItem.Value + pagename, true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
     
    protected void BindDropDownValues()
    {
        List<BillSearchActions> lstVisitSearchAction = new List<BillSearchActions>();
        retval = new BillingEngine(base.ContextInfo).GetBillSearchActions(RoleID, out lstVisitSearchAction);
        if (lstVisitSearchAction.Count > 0)
        {
            dList.DataSource = lstVisitSearchAction;
            dList.DataTextField = "ActionName";
            dList.DataValueField = "PageURL";
            dList.DataBind();
        }
    }
}
