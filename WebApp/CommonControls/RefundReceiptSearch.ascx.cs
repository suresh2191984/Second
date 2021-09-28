using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.UI;
using System.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Podium.BillingEngine;

public partial class CommonControls_RefundReceiptSearch : BaseControl
{
    BillingEngine billingBL ;
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long returnCode = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucINPatientSearch_txtFromDate',1,1);");
            //txtRefundDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            //string date = txtRefundDate.Text == "" ? "01/01/2001" : txtRefundDate.Text;
            string refundNo = txtRefundNo.Text == "" ? "0" : txtRefundNo.Text;
            string patient = txtPatientName.Text.Trim() == "" ? "" : txtPatientName.Text;
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



            hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

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
             
        }
        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
               
            }

        }

    }

    protected void btnRefundSearch_Click(object sender, EventArgs e)
    {

        try
        {
            //string date = txtRefundDate.Text == "" ? "01/01/2001" : txtRefundDate.Text;
            string refundNo = txtRefundNo.Text == "" ? "0" : txtRefundNo.Text;
            string patientName = txtPatientName.Text.Trim() == "" ? "" : txtPatientName.Text;
            string PatientNo = txtPatientNo.Text.Trim() == "" ? "" : txtPatientNo.Text;
            List<BillingDetails> lstBillingDetail = new List<BillingDetails>();
            List<FinalBill> lstFinalBillDetail = new List<FinalBill>();
            string strBillFromDate, strBillToDate;
            
            if (ddlRegisterDate.SelectedItem.Text != "--Select--")
            {
                if ((txtFromDate.Text != "" && txtToDate.Text != ""))
                {

                    strBillFromDate = txtFromDate.Text;
                    strBillToDate = txtToDate.Text;

                }
                else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
                {
                    strBillFromDate = txtFromPeriod.Text;
                    strBillToDate = txtToPeriod.Text;
                }
                else if (ddlRegisterDate.SelectedItem.Text == "Today")
                {
                    strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                    strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                    
                }
                else
                {
                    strBillFromDate = hdnFirstDayMonth.Value.ToString();
                    strBillToDate = hdnLastDayWeek.Value.ToString();
                }
            }
            else
            {
                strBillFromDate = hdnFirstDayMonth.Value.ToString();
                strBillToDate = hdnLastDayWeek.Value.ToString();
            }
            billingBL = new BillingEngine(base.ContextInfo);
            billingBL.GetRefundReceiptSearch(patientName, refundNo, Convert.ToDateTime(strBillFromDate), Convert.ToDateTime(strBillToDate), OrgID, ILocationID,PatientNo, out lstFinalBillDetail);
            //inventoryBL.GetInvRefundDetails(patient, OrgID, ILocationID, Int64.Parse(refundNo), DateTime.Parse(date), out lstFinalBillDetail);
            grdResult.DataSource = lstFinalBillDetail;
            grdResult.DataBind();
            tablebilID.Visible = true;
             
             
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Refund Details", Ex);
        }


    }

   

     

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                FinalBill IOM = (FinalBill)e.Row.DataItem;
                
                string strScript = "getMessage('" + IOM.BillNumber
                    + "','" + IOM.VisitID
                    + "','" + IOM.Name
                    + "','" + IOM.NetValue
                    + "','" + IOM.ClientName
                    + "','" + IOM.CreatedAt
                    + "','" + IOM.BilledBy
                    + "','" + IOM.PatientAge
                    + "','" + IOM.PatientNo
                    + "');return false;";
                ((HtmlInputButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception Ex)
        {

        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnRefundSearch_Click(sender, e);
        }
    }

    




}
