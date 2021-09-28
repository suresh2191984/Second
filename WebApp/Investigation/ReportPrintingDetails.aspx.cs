using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.PerformingNextAction;
using System.Timers;

public partial class Investigation_ReportPrintingDetails : BasePage
{
    Report_BL reportprintingbl;
    long visitID = -1;
    int orgID = 0;
    string gUID = string.Empty;
    int ReadyReports = 0, NotReadyReports = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "" && Request.QueryString["orgid"] != null && Request.QueryString["orgid"] != "")
            {
                visitID = Convert.ToInt64(Request.QueryString["vid"]);
                orgID = int.Parse(Request.QueryString["orgid"]);
                PatientDetails(visitID, orgID);
                PatientTestDetails(visitID, orgID);
                if (ReadyReports != 0)
                {
                    btnPrint_Click(sender, e);
                    lblDueAmountStatus.Text = "Action : Report printed. Please take the report.";
                }
            }
        }
    }

    public void PatientDetails(long Visitid, int OrgID)
    {
        long returnCode = -1;
        try
        {
            List<ReportPrinting> lstReportPrinting = new List<ReportPrinting>();
            reportprintingbl = new Report_BL(base.ContextInfo);
            returnCode = reportprintingbl.GetpatientReportPrintDetails(Visitid, OrgID, out lstReportPrinting);
            if (lstReportPrinting.Count > 0)
            {
                foreach (ReportPrinting item in lstReportPrinting)
                {
                    lblVisitNumbner.Text = item.VisitNumber.ToString();
                    lblPatientName.Text = item.PatientName.ToString();
                    lblTitleCode.Text = item.TitleName.ToString();
                    lblAge.Text = item.Age.ToString();
                    lblGender.Text = item.Gender.ToString();
                    lblContactNo.Text = item.MobileNumber.ToString();
                    lblvisitDateTime.Text = item.VisitDate.ToString();
                    lblReferingDoctor.Text = item.ReferingPhysicianName.ToString();
                    hdnPrinterCode.Value = item.PrinterCode.ToString();

                    hdnPatientID.Value = item.PatientID.ToString();
                    hdnVisitID.Value = item.PatientVisitID.ToString();
                    hdnOrgID.Value = item.OrganizationID.ToString();

                    if (lblTitleCode.Text == "")
                    {
                        lbldot.Visible = false;
                    }

                }

            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    public void PatientTestDetails(long Visitid, int OrgID)
    {
        long returnCode = -1;
        try
        {
            List<ReportPrinting> lstReportPrinting = new List<ReportPrinting>();
            reportprintingbl = new Report_BL(base.ContextInfo);
            returnCode = reportprintingbl.GetpatientinvestigationforvisitNumber(Visitid, OrgID, gUID, out lstReportPrinting);
            if (lstReportPrinting.Count > 0)
            {
                grdResult.DataSource = lstReportPrinting;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        if (hdnPrintingStatus.Value == "Printed")
        {
            Response.Redirect("ReportPrinting.aspx", true);
        }
        else
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            PageContextkey PC = new PageContextkey();
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            try
            {

                PC.ID = Convert.ToInt64(hdnPrinterCode.Value);
                PC.PatientID = Convert.ToInt64(hdnPatientID.Value);
                PC.RoleID = Convert.ToInt64(RoleID);
                PC.OrgID = int.Parse(hdnOrgID.Value);
                PC.PatientVisitID = Convert.ToInt64(hdnVisitID.Value);
                PC.FinalBillID = 0;
                PC.BillNumber = "0";
                PC.PageID = Convert.ToInt64(726);
                PC.IDS = "FullReport";

                PC.ButtonName = "REPORTPRINTBTN";
                PC.ButtonValue = "REPORTPRINTBTN";

                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
                if (res > -1)
                {
                    //if (Session["RegKeyExists"] != null && Convert.ToString(Session["RegKeyExists"]) == "true")
                    //{
                    if (hdnVisitID.Value != null)
                    {
                        iframeBarcode.Attributes["src"] = "attunebarcode:" + hdnPrinterCode.Value;
                        //ScriptManager.RegisterStartupScript(this.Page, GetType(), "Redirection", "RedirectToHomePage();", true);
                    }
                    //}
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReportPrinting.aspx", true);
    }


    protected void DLInv_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblStatus = (Label)e.Item.FindControl("lblStatus");
                if (lblStatus.Text == "Report Ready")
                {
                    ReadyReports += 1;
                    hdnReadyReports.Value = ReadyReports.ToString();
                }
                else
                {
                    NotReadyReports += 1;
                    hdnNotReadyReports.Value = NotReadyReports.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                if (lblStatus.Text == "Report Ready")
                {
                    ReadyReports += 1;
                    hdnReadyReports.Value = ReadyReports.ToString();
                }
                else
                {
                    NotReadyReports += 1;
                    hdnNotReadyReports.Value = NotReadyReports.ToString();
                }
                Label lblDueStatus = (Label)e.Row.FindControl("lblDueStatus");
                if (lblDueStatus.Text != "Completed")
                {
                    lblDueAmountStatus.Visible = true;
                    btnPrint.Enabled = false;
                    ReadyReports = 0;
                }
            }
            //if (ReadyReports == 0)
            //{
            //    btnPrint.Enabled = false;
            //}
            //else
            //{
            //    btnPrint.Enabled = true;
            //}

        }
        catch (Exception Ex)
        {
            throw Ex;
        }
    }

}
