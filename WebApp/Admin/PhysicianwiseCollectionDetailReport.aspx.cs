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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Admin_PhysicianwiseCollectionDetailReport : BasePage
{
    long returnCode = -1;
    AdminReports_BL arBL ;
    List<CashFlowSummary> lstCashFlowSummary = new List<CashFlowSummary>();
    List<CashFlowSummary> lstCashFlowSummary1 = new List<CashFlowSummary>();
    List<CashFlowSummary> lstCashFlowSummary2 = new List<CashFlowSummary>();
    Physician_BL PhysicianBL ;
    List<Physician> lstPhysician = new List<Physician>();
    decimal totalCollectionAmount = 0;
    decimal totalDiscountAmount = 0;
    decimal totalRefundAmount = 0;
    decimal totalOrganisationAmount = 0;
    decimal totalPhysicianAmount = 0;
    int PagewisePatientCount = 0;
    long physicianID = 0;
    DateTime dFromDate;
    DateTime dToDate;
    string type = string.Empty; string feetype = string.Empty; string isCreditBill = string.Empty;
    string physicianName = string.Empty;
    decimal net = decimal.Zero;
    protected void Page_Load(object sender, EventArgs e)
    {
        arBL = new AdminReports_BL(base.ContextInfo);
        PhysicianBL = new Physician_BL(base.ContextInfo);
        try
        {
            Int64.TryParse(Request.QueryString["physicianID"], out physicianID);
            DateTime.TryParse(Request.QueryString["fromDate"], out dFromDate);
            DateTime.TryParse(Request.QueryString["toDate"], out dToDate);
            type = Request.QueryString["type"]; feetype = Request.QueryString["ftype"]; isCreditBill = Request.QueryString["creditBill"];
            physicianName = Request.QueryString["PhyName"];
            if (!IsPostBack)
            {
                arBL.GetPhysicianWiseCollectionDetail(OrgID, physicianID, dFromDate, dToDate,type, feetype, isCreditBill, out lstCashFlowSummary);
                divPrint.Attributes.Add("style", "block");
                grdResult.DataSource = lstCashFlowSummary;
                grdResult.DataBind();
                tdPhysicianName.InnerText = " "+physicianName +" [ Visit Type - "+type+" ]";
                tdCollectionAmount.InnerText = totalCollectionAmount.ToString("0.00");
                tdDiscountAmount.InnerText = totalDiscountAmount.ToString("0.00");
                tdRefundAmount.InnerText = totalRefundAmount.ToString("0.00");
                tdOrganisationAmount.InnerText = totalOrganisationAmount.ToString("0.00");
                tdPhysicianAmount.InnerText = totalPhysicianAmount.ToString("0.00");
                lblTPC.Text = "( " + PagewisePatientCount.ToString() + " Patient )";
                if (OrgID == 131)
                {
                    tdscalc.Visible = true;
                    lbltdsamt.Text = Convert.ToString(totalPhysicianAmount * 10 / 100);
                    net = Convert.ToDecimal(totalPhysicianAmount) - Convert.ToDecimal(lbltdsamt.Text);
                    lblnettotal.Text = Convert.ToString(net);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PhysicianwiseCollectionDetailReport.aspx:Page_Load", ex);
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CashFlowSummary BMaster = (CashFlowSummary)e.Row.DataItem;
                 totalCollectionAmount += BMaster.Amount;
                 totalDiscountAmount += BMaster.DiscountAmount;
                 totalRefundAmount += BMaster.RefundAmount;
                 totalOrganisationAmount += BMaster.AmountToHostingOrg;
                 totalPhysicianAmount += BMaster.PhysicianAmount;

                 PagewisePatientCount = PagewisePatientCount + 1;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianWiseCollectionReports Details.", ex);
        }
    }
}
