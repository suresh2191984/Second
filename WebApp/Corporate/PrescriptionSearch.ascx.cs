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
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;

public partial class Corporate_PrescriptionSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();

    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    int OP;
    int IP;
    int currentPageNo = 1;
    int PageSize = 10;
    string isWardNo = string.Empty;
    string employeeNo = string.Empty;
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    List<Config> lstconfig = new List<Config>();
    public string EmployeeNo
    {
        get { return employeeNo; }
        set { employeeNo = value; }
    }

    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
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
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            new GateWay(base.ContextInfo).GetConfigDetails("IsCorporateOrg", OrgID, out lstconfig);
            if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "Y")
            {
                string lblnumber = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblnumber;
                string lblname = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblname;
                lblNumber.Text = lblnumber;
                lblName.Text = lblname;
                lblDependent.Visible = true;
                ddlPatientType.Visible = true;
            }
            else
            {
                string lblpatientnumber = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblpatientnumber;
                string lblpatientname = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblpatientname;
                lblNumber.Text =lblpatientnumber;
                lblName.Text = lblpatientname;
                lblDependent.Visible = false;
                ddlPatientType.Visible = false;
            }
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
            #endregion

        }
            
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect("../Reception/Home.aspx", true);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadGrid(e, currentPageNo, PageSize);
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        try
        {
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            long returnCode = -1;
            int totalRows = 0;
            int totalpage = 0;
            string IsConfig = string.Empty;
            string Status = string.Empty;
            string FromDate = txtFromDate.Text.ToString(), ToDate = txtToDate.Text.ToString();

            string deps = string.Empty;
            if (ddlPatientType.SelectedItem.Text == "Employee")
                deps = "A";
            else if (ddlPatientType.SelectedItem.Text == "Extended")
                deps = "E";
            else if (ddlPatientType.SelectedItem.Text == "Dependent")
                deps = "D";
            else
                deps = "";

            if (ddlPatientType.Visible == true)
                IsConfig = "Y";
            else IsConfig = "N";


            if (Convert.ToInt32(ddlStatus.SelectedValue) == 2)
                Status = "Closed";
            else
                if (Convert.ToInt32(ddlStatus.SelectedValue) == 1)
                    Status = "Open";
                else
                    Status = ddlStatus.SelectedItem.Text;

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
                returnCode = patientBL.SearchpGetCorporatePrescription(txtPrescriptionNo.Text.ToString(), strBillFromDate, strBillToDate, txtName.Text.ToString(), OrgID, txtNumber.Text.ToString(), deps, IsConfig, PageSize, currentPageNo, out totalRows, out lstPrescription, Status);
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error in InPatientSearch.ascx.cs", ex);
        }

        if ( lstPrescription.Count > 0)
        {

            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstPrescription;
            grdResult.DataBind();
            HasResult = true;
            

        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            string lblresult = Resources.ClientSideDisplayTexts.Corporate_PrescriptionSearch_ascx_cs_lblresult;
            lblResult.Text = lblresult;
        }

        onSearchComplete(this, e);
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Header )
        {
            if (ddlPatientType.Visible == true)
            {
                e.Row.Cells[2].Visible = true;
                e.Row.Cells[3].Visible = true;
                e.Row.Cells[4].Visible = false;
                e.Row.Cells[5].Visible = false;
            }
            else
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                e.Row.Cells[4].Visible = true;
                e.Row.Cells[5].Visible = true;
            }
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientPrescription IOM = (PatientPrescription)e.Row.DataItem;
            string strScript = "SelectRow('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + IOM.PatientVisitID + "','" + IOM.PrescriptionID + "','" + IOM.TaskID + "','" + IOM.PhysicianID + "','" + IOM.DrugStatus + "','" + IOM.PrescriptionNumber + "','" + IOM.Instruction + "','" + IOM.IssuedQty  + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
       
}
