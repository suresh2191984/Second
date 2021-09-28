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

public partial class Admin_DueReportPrint : BasePage
{
    long returnCode = -1;
    int clientID = -1;
    int collectionCentreID = -1;
    DateTime strBillFromDate;
    int ReferingPhysicianID = -1;
    long HospitalID = -1;
    int InsuranceID = -1;
    DateTime strBillToDate;
    int flag = -1;
    string pType = string.Empty;
    decimal grandTotal = 0;
    string concatenateDate = string.Empty;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        try
        {
            patientVisit_BL = new PatientVisit_BL(base.ContextInfo);
            DateTime.TryParse(Request.QueryString["fromDate"], out strBillFromDate);
            DateTime.TryParse(Request.QueryString["toDate"], out strBillToDate);
            if (strBillFromDate == strBillToDate)
            {
                concatenateDate = strBillFromDate.ToString();
            }
            else
            {
                concatenateDate = " (" + strBillFromDate.ToString("dd/MM/yyyy") + " - " + strBillToDate.ToString("dd/MM/yyyy") + ")";
            }

            
            pType = Request.QueryString["pType"].ToString();
            List<DailyReport> dueSearch = new List<DailyReport>();
            List<DailyReport> withDue = new List<DailyReport>();
            AdminReports_BL patientBL = new AdminReports_BL(base.ContextInfo);
          
            patientVisit_BL.GetLocation(OrgID,LID,0, out lstOrganizationAddress);
            orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
            dateTextForReport.InnerHtml = pType + " Dues for - " + concatenateDate;
          
            returnCode = patientBL.SearchDueBills(strBillFromDate, strBillToDate, OrgID, pType, out dueSearch);
            foreach (DailyReport obj in dueSearch)
            {
                grandTotal += obj.AmountDue;
            }
            withDue = dueSearch.FindAll(delegate(DailyReport h) { return h.AmountDue > 0; });
            if (withDue != null && returnCode == 0 && withDue.Count() > 0)
            {
                grdResult.Visible = true;
                orgHeaderTab.Visible = true;
                lblResult.Visible = false;
                tabGranTotal1.Visible = true;
                lblResult.Text = "";
                grdResult.DataSource = withDue;
                grdResult.DataBind();
                lblGrandTotal.InnerText = grandTotal.ToString();
            }
            else
            {
                grdResult.Visible = false;
                orgHeaderTab.Visible = false;
                lblResult.Visible = true;
                tabGranTotal1.Visible = false;
                lblResult.Text = "No Matching Records Found!";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DueReportsPrint Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        //export to excel
        string attachment = "attachment; filename=Reports.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        resultTab.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading DueReportsPrint Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
    }
   
   }
