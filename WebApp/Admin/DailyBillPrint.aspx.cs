using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.IO;
using System.Linq;
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


public partial class Admin_DailyBillPrint : BasePage
{
    decimal totalAmount;
    long returnCode = -1;
    DateTime fDate;
    DateTime tDate;
    int loginID = 0;
    decimal cashAmount = 0;
    decimal creditAmount = 0;
    decimal dueReceivedAmount = 0;
    decimal pendingDueAmount = 0;
    decimal discountAmount = 0;
    int OrgID = 0;
    string concatenateDate = string.Empty;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    List<DailyReport> cashBillList = new List<DailyReport>();
    List<DailyReport> creditBillList = new List<DailyReport>();
    List<DailyReport> dueReceivedBillList = new List<DailyReport>();
    List<DailyReport> cancelledBillList = new List<DailyReport>();
    protected void Page_Load(object sender, EventArgs e)
    {

        patientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        DateTime.TryParse(Request.QueryString["fDate"], out fDate);
        DateTime.TryParse(Request.QueryString["tDate"], out tDate);
        int.TryParse(Request.QueryString["LID"], out loginID);
        int.TryParse(Request.QueryString["orgID"], out OrgID);
        patientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);

        if (fDate == tDate)
        {
            concatenateDate = fDate.ToString();
        }
        else
        {
            concatenateDate = " (" + fDate.ToString() + " - " + tDate.ToString() + ")";
        }


        orgHeaderTextForReport.InnerHtml = "<font style='font-size:15px;'>" + OrgName + "</font>  <br/> " + lstOrganizationAddress[0].Location;
        dateTextForReport.InnerHtml = "User Wise Collection Report for - " + concatenateDate;

        returnCode = new AdminReports_BL(base.ContextInfo).GetDailyReports(fDate, tDate, loginID, OrgID, out cashBillList, out creditBillList, out dueReceivedBillList, out cancelledBillList, out cashAmount, out creditAmount, out dueReceivedAmount, out pendingDueAmount, out discountAmount);

        if (cashBillList.Count > 0 || creditBillList.Count > 0 || dueReceivedBillList.Count > 0 || cancelledBillList.Count > 0)
        {
            grdResultCashBill.DataSource = cashBillList;
            grdResultCashBill.DataBind();
            if (creditBillList.Count > 0)
            {
                grdResultCreditBill.DataSource = creditBillList;
                grdResultCreditBill.DataBind();
                creditBillTab.Visible = true;
            }
            else
            {
                creditBillTab.Visible = false;
            }
            if (dueReceivedBillList.Count > 0)
            {
                grdResultDueReceivedBill.DataSource = dueReceivedBillList;
                grdResultDueReceivedBill.DataBind();
                dueAmountReceivedTab.Visible = true;
            }
            else
            {
                dueAmountReceivedTab.Visible = false;
            }
            if (cancelledBillList.Count > 0)
            {
                grdResultCancelledBill.DataSource = cancelledBillList;
                grdResultCancelledBill.DataBind();
                cancelledBillTab.Visible = true;
            }
            else
            {
                cancelledBillTab.Visible = false;
            }
            orgHeaderTab.Visible = true;

            tdCashAmount.InnerText = String.Format("{0:0.00}", cashAmount);
            tdCreditAmount.InnerText = String.Format("{0:0.00}", creditAmount);
            tdDueReceivedAmount.InnerText = String.Format("{0:0.00}", dueReceivedAmount);
            tdPendingDueAmount.InnerText = String.Format("{0:0.00}", pendingDueAmount);
            tdDiscountAmount.InnerText = String.Format("{0:0.00}", discountAmount);
            tdTotalAmount.InnerText = String.Format("{0:0.00}", (cashAmount + creditAmount + dueReceivedAmount + pendingDueAmount + discountAmount));
        }
        else
        {
            orgHeaderTab.Visible = false;
        }
        if (Request.QueryString["XL"] != null)
            ExportToExcel();

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








}
