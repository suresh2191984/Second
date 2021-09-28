using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Admin_DueSearch : BasePage
{
    long returnCode = 0;
    decimal grandTotal = 0;
    string concatenateDate = string.Empty;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    protected void Page_Load(object sender, EventArgs e)
    {
        patientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        if (txtFrom.Text == txtTo.Text)
        {
            concatenateDate = txtFrom.Text;
        }
        else
        {
            concatenateDate = " (" + txtFrom.Text + " - " + txtTo.Text + ")";
        }

        if (!IsPostBack)
        {
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        DateTime strBillFromDate;
        strBillFromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime strBillToDate;
        strBillToDate = Convert.ToDateTime(txtTo.Text);
        long returnCode = -1;
        string pType = ddlType.SelectedValue;
        List<DailyReport> dueSearch = new List<DailyReport>();
        List<DailyReport> withDue = new List<DailyReport>();
        AdminReports_BL AdminBL = new AdminReports_BL(base.ContextInfo);
        try
        {

            patientVisit_BL.GetLocation(OrgID,LID,0, out lstOrganizationAddress);
            orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
            dateTextForReport.InnerHtml = ddlType.SelectedItem.Text+" for - " + concatenateDate;
            returnCode = AdminBL.SearchDueBills(strBillFromDate, strBillToDate, OrgID, pType, out dueSearch);
            foreach (DailyReport obj in dueSearch)
            {
                grandTotal += obj.AmountDue;
            }
            withDue = dueSearch.FindAll(delegate(DailyReport h) { return h.AmountDue>0 ; });
            if (withDue != null && returnCode == 0 && withDue.Count() > 0)
            {
                grdResult.Visible = true;
                orgHeaderTab.Visible = true;
                lblResult.Visible = false;
                tabGranTotal1.Visible = true;
                hypLnkPrint.Visible = true;
                dispLabel.Visible = true;
                lblResult.Text = "";
                lblGrandTotal.InnerText = grandTotal.ToString();
                grdResult.DataSource = withDue;
                grdResult.DataBind();
                hypLnkPrint.NavigateUrl = "DueReportPrint.aspx?fromDate=" + strBillFromDate + "&toDate=" + strBillToDate + "&pType=" + pType;
            }
            else
            {
                grdResult.Visible = false;
                lblResult.Visible = true;
                orgHeaderTab.Visible = false;
                tabGranTotal1.Visible = false;
                dispLabel.Visible = false;
                hypLnkPrint.Visible = false;
               
                lblResult.Text = "No Matching Records Found!";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DueReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
       
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
            }

            

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DueReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
        
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

}
