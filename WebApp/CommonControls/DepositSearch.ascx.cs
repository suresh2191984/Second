using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;

public partial class CommonControls_DepositSearch : BaseControl 
{
    List<Patient> lstPatient;
    BillingEngine objBillingEng;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            #region for Date


            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");



            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day


            #region LastYear
            hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            #endregion

            #region lastmonth
            DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
            hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
            dtlm = dtlm.AddMonths(1);
            hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
            #endregion

            #region lastweek
            DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime LwkStDt = DateTime.MinValue;
            DateTime LwkEndDt = DateTime.MinValue;
            hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
            hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

            #endregion

            #region lastYear
            DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string tempyear = dt2.AddYears(-1).ToString();
            string[] tyear = new string[5];
            tyear = tempyear.Split('/', '-');
            tyear = tyear[2].Split(' ');
            hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
            hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
            #endregion
           
            #endregion
            PatientDepositDetails();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            PatientDepositDetails();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientDeposit Report, btnSearch_Click", ex);
        }
    }
    private void PatientDepositDetails()
    {
        string patientNo = string.Empty;
        string patientName = string.Empty;

        patientNo = txtPatientNo.Text;
        patientName = txtPatientName.Text;
        

        string tempfrom = "01/01/2001 00:00:00";
        DateTime fromDate, ToDate;
        if (ddlRegisterDate.SelectedItem.Text != "--Select--")
        {
            if (txtFromDate.Text != "" && txtToDate.Text != "") 
            {

                fromDate = Convert.ToDateTime(txtFromDate.Text);
                ToDate = Convert.ToDateTime(txtToDate.Text);

            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                fromDate = Convert.ToDateTime(txtFromPeriod.Text);
                ToDate = Convert.ToDateTime(txtToPeriod.Text);
            }
            else if (ddlRegisterDate.SelectedItem.Text == "Today")
            {
                fromDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy"));
                ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy"));
            }
            else
            {
                fromDate = Convert.ToDateTime(txtFromDate.Text);
                ToDate = Convert.ToDateTime(txtToDate.Text);

            }
        }
        else
        {
            fromDate = Convert.ToDateTime(tempfrom);
            ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());

        }
        lstPatient = new List<Patient>();
        objBillingEng = new BillingEngine(base.ContextInfo);
        objBillingEng.PatientDepositSearch(patientNo, patientName, fromDate, ToDate, OrgID, out lstPatient);
        if (lstPatient.Count > 0)
        {
            gvDeposit.DataSource = lstPatient;
            gvDeposit.DataBind();
        }
        else
        {
            lblResult.Text = "No Records Found";
            gvDeposit.DataSource = null;
            gvDeposit.DataBind();
        }
    }
    protected void gvDeposit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvDeposit.PageIndex = e.NewPageIndex;
                btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Patient Deposit Search, gvDeposit_PageIndexChanging", ex);
        }
    }
}
