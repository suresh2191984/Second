using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Text;
using System.Data;
using System.Xml.Linq;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;

public partial class Reports_ExpensesReport : BasePage
{
    DataTable lstCashOutFlow = new DataTable();
    List<CashOutFlow> lstHead = new List<CashOutFlow>();
    ArrayList alist = new ArrayList();
    ArrayList al = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            trError.Visible = false;
            LoadCashExpense();
            LoadOrgan();
            BindListofUsers();
            LoadLocation();
            ddlLocation.SelectedValue = ILocationID.ToString();

        }
    }

    private void LoadLocation()
    {
        long returnCode = -1;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location

        returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        //  returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, "------SELECT------");
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, "------SELECT------");
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();



        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void BindListofUsers()
    {
        chklstusers.Items.Clear();
        List<Users> lstUserIDs = new List<Users>();
        if (ddlTrustedOrg.Items.Count > 0)
        {
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

        }
        long iOrgID = Int64.Parse(OrgID.ToString());
        long retval = -1;
        retval = new BillingEngine(base.ContextInfo).GetUserIDs(iOrgID, out lstUserIDs);
        if (lstUserIDs.Count > 0)
        {
            chklstusers.DataSource = lstUserIDs;
            chklstusers.DataTextField = "Name";
            chklstusers.DataValueField = "UserID";
            chklstusers.DataBind();
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alr", "javascript:checkAllLoad();", true);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        ExportToXL();
    }
    public void ExportToXL()
    {

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Expesnses Report.xls");

        Response.Charset = "";

        // If you want the option to open the Excel file without saving than

        // comment out the line below

        // Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        tblgrdDynamic.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());

        Response.End();
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        ExportToXL();
    }
    public void LoadCashExpense()
    {
        Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
        List<CashExpenseMaster> lstCashExpense = new List<CashExpenseMaster>();
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        PhysicianBL.GetCashExpenseByOrg(OrgID, out lstCashExpense);


        if (lstCashExpense.Count > 0)
        {
            chkPurpose.DataSource = lstCashExpense;
            chkPurpose.DataTextField = "HeadName";
            chkPurpose.DataValueField = "HeadDesc";
            chkPurpose.DataBind();

            //dPurpose.DataSource = lstCashExpense;
            //dPurpose.DataTextField = "HeadName";
            //dPurpose.DataValueField = "HeadDesc";
            //dPurpose.DataBind();
            //dPurpose.Items.Insert(0, "--Select--");
            //dPurpose.Items[0].Value = "0";
        }
    }

    public void LoadGrid()
    {
        long returnCode = -1;
        int locationId = 0;
        if (ddlLocation.Items.Count > 0)
        {
            locationId = Convert.ToInt32(ddlLocation.SelectedValue);
        }
        Report_BL reportBL = new Report_BL(base.ContextInfo);
        string ReceiverType = "";
        DateTime fromdate = Convert.ToDateTime(txtFDate.Text);
        DateTime todate = Convert.ToDateTime(txtTDate.Text);
        ArrayList al = new ArrayList();
        decimal sum = 0.0m;
        int flag = 0;
        foreach (ListItem item in chkPurpose.Items)
        {
            if (item.Selected == true)
            {
                if (flag == 0)
                {
                    ReceiverType = item.Value;
                    flag++;
                }
                else
                {
                    ReceiverType = ReceiverType + "," + item.Value;
                }
            }
        }

        decimal ptoalExpenses = 0;
        long lUserID = 0;
        DataTable dtUser = new DataTable();
        DataColumn dbCol1 = new DataColumn("LoginID");
        dtUser.Columns.Add(dbCol1);
        DataRow dr;
        string chkValue = string.Empty;
        int selectedUserCount = 0;
        foreach (ListItem chkitem in chklstusers.Items)
        {

            if (chkitem.Selected == true)
            {
                chkValue = chkitem.Value.ToString();
                selectedUserCount++;
                dr = dtUser.NewRow();
                dr["LoginID"] = Convert.ToInt64(chkValue);
                dtUser.Rows.Add(dr);

            }

        }

        if (selectedUserCount == 1)
        {
            lUserID = Convert.ToInt64(chkValue);
        }
        else
        {
            lUserID = 0;
        }
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

        returnCode = reportBL.GetDailyExpensesReportForDynamic(fromdate, todate, OrgID, ReceiverType,locationId, out lstCashOutFlow, out lstHead, dtUser, out ptoalExpenses);

        int totalColumn = lstCashOutFlow.Columns.Count;
        for (int i = 6; i < totalColumn; i++)
        {
            alist.Add(lstCashOutFlow.Columns[i].ColumnName);
        }

        string Sdisplay=Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_001==null ?"Total Expenses :":Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_001;
        string Sdisplay1=Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_002==null ? "From:" :Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_002;
        string Sdisplay2=Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_003==null ? "To :":Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_003;
        string Sdisplay3 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_004 == null ? "No Matching Records Found!" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_004;

        if (lstCashOutFlow.Rows.Count > 0)
        {
            trError.Visible = false;
            grdDynamic.Visible = true;
            grdDynamic.DataSource = lstCashOutFlow;
            grdDynamic.DataBind();
            hdnXLFlag.Value = "1";
            lblTotalExpense.Text = Sdisplay + "<b>" + Sdisplay1 + "</b>" + fromdate.ToShortDateString() + "<b>" + Sdisplay2 + "</b>" + todate.ToShortDateString() + ":- <b>" + ptoalExpenses.ToString("0.00") + "</b>";
        }
        else
        {
            trError.Visible = true;
            grdDynamic.Visible = false;
            lblResult.Text = Sdisplay3;// "No Matching Records Found!";
            hdnXLFlag.Value = "0";
        }
    }


    //protected void grdDynamic_DataBound(object sender, EventArgs e)
    //{



    //    decimal sum = 0.0m;
    //    for (int i = 0; i < alist.Count; i++)
    //    {
    //        for (int j = 0; j < lstCashOutFlow.Rows.Count; j++)
    //        {


    //            string obj = lstCashOutFlow.Rows[j][alist[i].ToString()].ToString();
    //            if (obj == "")
    //                obj = "0";

    //            sum = sum + Convert.ToDecimal(obj);
    //        }
    //        al.Add(sum);
    //        sum = 0;
    //    }
    //    //int count = 0;
    //    //for (int i = 0; i < lstCashOutFlow.Columns.Count; i++)
    //    //{
    //    //    for (int j = 0; j < lstHead.Count; j++)
    //    //    {

    //    //        if (lstCashOutFlow.Columns[i].ColumnName == lstHead[j].HeadName)
    //    //        {

    //    //            break;
    //    //        }
    //    //        count++;
    //    //    }
    //    //}


    //    grdDynamic.FooterRow.HorizontalAlign = HorizontalAlign.Right;
    //    grdDynamic.FooterRow.Style.Add("font-weight", "bold");
    //    GridViewRow grow = grdDynamic.FooterRow;
    //    if (grow != null)
    //    {
    //        grow.Cells[5].Text = "Total";
    //        grow.Cells[5].Font.Bold = true;
    //        for (int i = 0; i < lstHead.Count; i++)
    //        {
    //            grow.Cells[i].HorizontalAlign = HorizontalAlign.Right;
    //            grow.Cells[i + 6].Text = al[i].ToString();
    //        }
    //    }

    //}
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        LoadGrid();
        CollapsiblePanelExtender1.Collapsed = true;
        CollapsiblePanelExtender1.ClientState = "true";

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    protected void dPurpose_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadGrid();
    }
    protected void grdDynamic_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string SdispText1 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_005 == null ? "Voucher No" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_005;
        string SdispText2 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_006 == null ? "Receiver Name" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_006;
        string SdispText3 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_007 == null ? "Paid By" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_007;
        string SdispText4 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_008 == null ? "Date" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_008;
        string SdispText5 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_009 == null ? "Payment Type" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_009;
        string SdispText6 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_010 == null ? "Remarks" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_010;
        string SdispText7 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_011 == null ? "ExpenseType" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_011;
        string SdispText8 = Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_012 == null ? "Amount" : Resources.Reports_ClientDisplay.Reports_ExpensesReport_aspx_012;
        for (int i = 0; i <= 6; i++)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                if (e.Row.Cells[i].Text == SdispText1)
                {
                    e.Row.Cells[i].Text = SdispText1;
                }
                if (e.Row.Cells[i].Text == SdispText2)
                {
                    e.Row.Cells[i].Text = SdispText2;
                }
                if (e.Row.Cells[i].Text == SdispText3)
                {
                    e.Row.Cells[i].Text = SdispText3;
                }

                if (e.Row.Cells[i].Text == SdispText4)
                {
                    e.Row.Cells[i].Text = SdispText4;
                }

                if (e.Row.Cells[i].Text == SdispText5)
                {
                    e.Row.Cells[i].Text = SdispText5;
                }
                if (e.Row.Cells[i].Text == SdispText6)
                {
                    e.Row.Cells[i].Text = SdispText6;
                }
                if (e.Row.Cells[i].Text == SdispText7)
                {
                    e.Row.Cells[i].Text = SdispText7;
                }
                if (e.Row.Cells[i].Text == SdispText8)
                {
                    e.Row.Cells[i].Text = SdispText8;
                }
            }
        }
    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindListofUsers();
        LoadCashExpense();
         
    }

}
