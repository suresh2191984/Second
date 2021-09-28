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

public partial class Admin_DailyBillReport : BasePage
{
   /* public Admin_DailyBillReport()
        : base("Admin\\DailyBillReport.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    */

    long returnCode = -1;
    int i = 0;
    int loginID = 0;
    decimal cashAmount = 0;
    decimal creditAmount = 0;
    decimal dueReceivedAmount = 0;
    decimal pendingDueAmount = 0;
    decimal discountAmount = 0;
    DateTime fDate;
    DateTime tDate;
    string key = string.Empty;
    string strevent = string.Empty;
    List<DailyReport> cashBillList = new List<DailyReport>();
    List<DailyReport> creditBillList = new List<DailyReport>();
    List<DailyReport> dueReceivedBillList = new List<DailyReport>();
    List<DailyReport> cancelledBillList = new List<DailyReport>();
    string concatenateDate = string.Empty;
    PatientVisit_BL patientVisit_BL;
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
    protected void Page_Load(object sender, EventArgs e)
    {

        patientVisit_BL = new PatientVisit_BL(base.ContextInfo);

        if (!IsPostBack)
        {
            try
            {
                LoadUserList();
                LoadMinutes();
                Loadtime();
                txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Loading DailyBillReport", ex);
            }
        }

        fDate = Convert.ToDateTime(txtFrom.Text + " " + ddlFrmtime.SelectedItem.Text + ":" + ddlFrmMinutes.SelectedItem.Text + ddlfrmSession.Text);
        tDate = Convert.ToDateTime(txtTo.Text + " " + ddlTotime.SelectedItem.Text + ":" + ddlToMinutes.SelectedItem.Text + ddlToSession.Text);

        if (fDate == tDate)
        {
            concatenateDate = fDate.ToString();
        }
        else
        {
            concatenateDate = " (" + fDate.ToString() + " - " + tDate.ToString() + ")";
        }


        loginID = Convert.ToInt32(ddlUsers.SelectedValue);



    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        fDate = Convert.ToDateTime(txtFrom.Text + " " + ddlFrmtime.SelectedItem.Text + ":" + ddlFrmMinutes.SelectedItem.Text + ddlfrmSession.Text);
        tDate = Convert.ToDateTime(txtTo.Text + " " + ddlTotime.SelectedItem.Text + ":" + ddlToMinutes.SelectedItem.Text + ddlToSession.Text);
        loginID = Convert.ToInt32(ddlUsers.SelectedValue);
        patientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
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

            dispLabel.Visible = true;
            hypLnkPrint.Visible = true;
            lblResult.Visible = false;
            dprint.Style.Add("display", "block");
            divT.Style.Add("display", "block");
            hypLnkPrint.NavigateUrl = "DailyBillPrint.aspx?fDate=" + fDate + "&tDate=" + tDate + "&LID=" + loginID + "&orgID=" + OrgID;
        }
        else
        {
            lblResult.Visible = true;
            orgHeaderTab.Visible = false;
            dispLabel.Visible = false;
            hypLnkPrint.Visible = false;
            lblResult.Text = "No Matching Records Found!";
            dprint.Style.Add("display", "none");
            divT.Style.Add("display", "none");
        }
    }
    public void Loadtime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (i = 1; i <= 12; i++)
        {
            //ddlFrmtime.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            ddlFrmtime.Items.Add(i.ToString());
            ddlTotime.Items.Add(i.ToString());
            dt = dt.AddMinutes(30);
        }
    }
    public void LoadMinutes()
    {
        DateTime dt = Convert.ToDateTime("00 am");
        //DateTime time = DateTime.MinValue;
        //DateTime value = DateTime.MinValue;
        for (i = 0; i < 12; i++)
        {
            ddlFrmMinutes.Items.Insert(i, dt.ToString("mm.FF"));
            ddlToMinutes.Items.Insert(i, dt.ToString("mm.FF"));
            dt = dt.AddMinutes(5);
        }
    }
    public void LoadUserList()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<Attune.Podium.BusinessEntities.Login> getUsersList = new List<Attune.Podium.BusinessEntities.Login>();
            retCode = patBL.LoadUserList(OrgID, out getUsersList);
            ddlUsers.DataSource = getUsersList;
            ddlUsers.DataTextField = "LoginName";
            ddlUsers.DataValueField = "LoginID";
            ddlUsers.DataBind();
            ddlUsers.Items.Insert(0, "All");
            ddlUsers.Items[0].Value = "0";
        }
        catch (Exception EX)
        {
            CLogger.LogError("Error while load User details in daily bill report", EX);
        }
    }



}
