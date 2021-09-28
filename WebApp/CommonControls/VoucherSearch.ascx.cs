using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using System.Collections;

public partial class CommonControls_VoucherSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long returnCode = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','uctrlBillSearch_txtFromDate',1,1);");
        txtFromPeriod.Attributes.Add("onchange", "ExcedDate('" + txtFromPeriod.ClientID.ToString() + "','',0,0);");
        txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToPeriod.ClientID.ToString() + "','uctrlBillSearch_txtFromPeriod',1,1);");
        if (!IsPostBack)
        {
            //bindDropDown();
           // txtBillDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            btnSearch_Click(sender, e);
            
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
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
     
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string strBillNo = "";
        string strRecName = "";
         
        List<CashOutFlow> lstOutFlow = new List<CashOutFlow>();
        BillingEngine BillBL = new BillingEngine(base.ContextInfo);
        strRecName = txtPatientName.Text;
        string strBillFromDate = string.Empty;
        string strBillToDate = string.Empty;
        strBillNo = txtBillNo.Text;
         
        
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
                strBillFromDate = "";
                strBillToDate = "";
            }
        }
        
        else
        {
            strBillFromDate = "";
            strBillToDate = ""; 
        }
        try
        {
            returnCode = BillBL.SearchVoucherDetails(strBillNo, strBillFromDate, strBillToDate, strRecName, OrgID, out lstOutFlow);
            
        }
        catch
        {
        }
        if (returnCode == 0 && lstOutFlow.Count > 0)
        {
            
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstOutFlow;
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
                CashOutFlow bs = (CashOutFlow)e.Row.DataItem;
                //SelectedVoucherNo(dAmount, dDate, dVoucherNo, PNAME,dOutID) 
                string strScript = "SelectedVoucherNo('" + bs.AmountReceived
                    + "','" + bs.CreatedAt
                    + "','" + bs.VoucherNO
                    + "','" + bs.ReceiverName
                    + "','" + bs.OutFlowID
                    + "','" + bs.BilledBy
                    + "');return false;";
                ((HtmlInputButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            }
          
            
        }
        catch (Exception Ex)
        {
            //report error
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
            btnSearch_Click(sender, e);
        }
    }
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        List<Role> lstUserRole = new List<Role>();
    //        string path = string.Empty;
    //        Role role = new Role();
    //        role.RoleID = RoleID;
    //        lstUserRole.Add(role);
    //        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
    //        Response.Redirect(Request.ApplicationPath + path, true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //}

    //#region BindPhysicians
    //public void bindDropDown()
    //{

    //    Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
    //    List<Physician> lstPhysician = new List<Physician>();
    //    PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician,0);
    //    if (lstPhysician.Count > 0)
    //    {
    //        //ddlPhysician.DataSource = lstPhysician;
            
    //        //ddlPhysician.DataTextField = "PhysicianName";
    //        //ddlPhysician.DataValueField = "PhysicianID";
    //        //ddlPhysician.DataBind();
    //        //ddlPhysician.Items.Insert(0, new ListItem("--All--", "-1"));
    //    }
        
    //}
    //#endregion
}
