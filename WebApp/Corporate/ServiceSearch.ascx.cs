using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;

public partial class Corporate_ServiceSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long returnCode = 0;
    string strBillNo = "";
    string strPatientName = "";
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    string strPatientNumber = string.Empty;
    string strClientID = string.Empty;
    int iPhysicianID = -1;
    List<EmployeeSearch> billSearch = new List<EmployeeSearch>();
    Patient_BL patientBL ;
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);
        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "OrgID", "var OrgID= '" + OrgID + "';", true);

        //AutoCompleteProduct.ContextKey = "Y";
        btnGo.Attributes.Add("onclick", "return checkForValues();");
        txtPatientNumber.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','uctrlBillSearch_txtFromDate',1,1);");
        txtFromPeriod.Attributes.Add("onchange", "ExcedDate('" + txtFromPeriod.ClientID.ToString() + "','',0,0);");
        txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToPeriod.ClientID.ToString() + "','uctrlBillSearch_txtFromPeriod',1,1);");
        //txtHospitalName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");

        if (!IsPostBack)
        {

            #region currentWeek
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");
            #endregion

            #region currentMonth
            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day
            #endregion

            #region currentYear
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

            #region Today
            strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            try
            {
            }
            catch
            {
            }
            if (returnCode == 0 && billSearch.Count > 0)
            {
                grdResult.Visible = true;
                lblResult.Visible = false;
                lblResult.Text = "";
                grdResult.DataSource = billSearch;
                grdResult.DataBind();
                HasResult = true;
            }
            else
            {
                HasResult = false;
                grdResult.Visible = false;
                lblResult.Visible = true;
                lblResult.Text = "No Matching Records Found!";
            }
            onSearchComplete(this, e);

        }
            #endregion
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        hdnBillNumber.Value = "";
        LoadGrid(e, currentPageNo, PageSize);
    }

    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                EmployeeSearch bs = (EmployeeSearch)e.Row.DataItem;

                string strScript = "ServiceSelectBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.Name + "','" + bs.PatientNumber + "','" + bs.BillNumber + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //string strScript = "javascript:SelectedBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.Name + "','" + bs.PatientNumber + "','" + bs.BillID + "', '" + bs.Status + "','" + bs.BillNumber + "');javascript:SelectBillNo('" + bs.BillNumber + "', '" + bs.Refundstatus + "','" + bs.VisitType + "','" + bs.IsCreditBill + "','" + bs.VisitState + "','" + bs.CollectionType + "','" + bs.AmountReceived + "','" + Convert.ToDecimal(bs.ClientName) + "','" + Convert.ToDecimal(bs.Amount) + "');";
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                
            }
            //e.Row.Cells[4].Visible = false;
           // e.Row.Cells[5].Visible = false;
        }
        catch (Exception Ex)
        {
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
    }
    public long GetSelectedBill()
    {
        long BillID = -1;
        if (Request.Form["bid"] != null && Request.Form["bid"].ToString() != "")
        {
            BillID = Convert.ToInt32(Request.Form["bid"]);
        }
        return BillID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {

        long returnCode = -1;

        int iPhysicianID = -1;
        List<EmployeeSearch> billSearch = new List<EmployeeSearch>();

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strPatientName = txtPatientName.Text;
        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();

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
        }
        else
        {
            strBillFromDate = "";
            strBillToDate = "";
        }

        //strBillNo = txtBillNo.Text;
        //iPhysicianID = Int32.Parse(ddlPhysician.SelectedValue);
        strPatientNumber = txtPatientNumber.Text;
        //strClientID = ddlCorporate.SelectedItem.Value;
        if (strClientID == "0")
        {
            strClientID = "";
        }
        try
        {
            returnCode = patientBL.ServiceSearchDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, OrgID, strPatientNumber, out billSearch, PageSize, currentPageNo, out totalRows);
        }
        catch
        {
        }

        if (billSearch.Count > 0)
        {
            GrdFooter.Style.Add("display", "block");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();


            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;

            }

            else
            {
                btnPrevious.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
            GrdFooter.Style.Add("display", "none");

        if (returnCode == 0 && billSearch.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = billSearch;
            grdResult.DataBind();
            HasResult = true;
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No matching records found";
        }

        onSearchComplete(this, e);

    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

}
