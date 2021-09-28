using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Text;
using Attune.Utilitie.Helper;


public partial class Billing_InterimSearch : BasePage
{

    public Billing_InterimSearch()
        : base(" Billing\\InterimSearch.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    string PatientNumber = string.Empty;
    string PatientName = string.Empty;
    string InterimBillNo = string.Empty;
    string FeeType = string.Empty;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtBillDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

            //string date = txtBillDate.Text == "" ? "01/01/2001" : txtBillDate.Text;
            InterimBillNo = txtInterimBillNo.Text == "" ? "0" : txtInterimBillNo.Text;
            PatientName = txtPatientName.Text.Trim() == "" ? "" : txtPatientName.Text;
            PatientNumber = txtPatientNumber.Text == "" ? "0" : txtPatientNumber.Text;
            FeeType = "PRM";
            strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd- MM-yyyy");
            strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd- MM-yyyy");
            //BindBilldatas(PatientNumber, patientName, InterimBillNo, strBillFromDate, strBillToDate);            //BindBilldatas(patient, date, billNo);
            loadActionList();


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

        }

    }

    protected void btnBillSearch_Click(object sender, EventArgs e)
    {

        try
        {

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
            if (RoleName == "Inventory" )
            {
                FeeType = "PRM";

            }
            else
            {
                FeeType = "";
            }

            InterimBillNo = txtInterimBillNo.Text == "" ? "" : txtInterimBillNo.Text;
            PatientName = txtPatientName.Text.Trim() == "" ? "" : txtPatientName.Text;
            PatientNumber = txtPatientNumber.Text == "" ? "" : txtPatientNumber.Text;
           
            BindBilldatas(PatientNumber, PatientName, InterimBillNo, strBillFromDate, strBillToDate,FeeType );
            loadActionList();
           
           
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Billig Details", Ex);
        }


    }

    private void BindBilldatas(string pNumber, string pName, string InterimBillNo, string strBillFromDate, string strBillToDate,string FeeType)
    {

        List<PatientDueChart> lstPDueChart = new List<PatientDueChart>();
        //BillingEngine b = new BillingEngine(base.ContextInfo);
        InterimBillNo = InterimBillNo == "" ? "" : InterimBillNo;
       
       
        new BillingEngine(base.ContextInfo).GetInterimBillDetails(pNumber, pName,InterimBillNo, strBillFromDate, strBillToDate, OrgID,FeeType, out lstPDueChart);
        grdResult.DataSource = lstPDueChart;
        grdResult.DataBind();
        tablebilID.Visible = true;



    }

    protected void loadActionList()
    {
        try
        {
            long returnCode = -1;
            List<ActionMaster> lstActionMaster = new List<ActionMaster>();

            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, (int)TaskHelper.SearchType.InterimBill, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            ddlAction.Items.Clear();

            if (RoleName == "Inventory" )
            {
                FeeType = "PRM";

            }
            else
            {
                FeeType = "";
            }

            #region Load Action Menu to Drop Down List
            if (lstActionMaster.Count > 0)
            {
                #region Add View State ActionList
                    string temp = string.Empty;
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    ViewState.Add("ActionList", temp);
                #endregion
                //lstActionsMaster = lstActionMaster.ToList();
                ddlAction.DataSource = lstActionMaster;
                ddlAction.DataTextField = "ActionName";
                ddlAction.DataValueField = "ActionCode";
                ddlAction.DataBind();
            }
            #endregion

            //foreach (ActionMaster src in lstActionMaster)
            //{
            //    ddlAction.Items.Add(new ListItem(src.ActionName, src.PageURL + "~" + src.ActionID));
            //}

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionList", ex);

        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientDueChart pdC = (PatientDueChart)e.Row.DataItem;
                ((Label)e.Row.FindControl("lblBillID")).Text = pdC.PatientNumber.ToString();


                string strScript = "InterRowCommon('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + pdC.PatientID + "','" + pdC.VisitID + "','" + pdC.InterimBillNo + "','" + pdC.CreatedAt + "','" + pdC.FinalBillID + "','" + pdC.Status + "','" + pdC.Remarks + "');";
                ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.FindControl("rdSel")).Attributes.Add("onclick", strScript);
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
            btnBillSearch_Click(sender, e);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnpopUp.Value = "N";
        hidselection.Value = "";





        List<FinalBill> lstfinalBill = new List<FinalBill>();

        //try
        //{
        //    string queryString = string.Empty;
        //    string id = string.Empty;
        //    string strUrl = string.Empty;
        //    string[] listValue = ddlAction.SelectedValue.Split('~');

        //    queryString = listValue[0] + "?ReferenceID=" + hdnFID.Value + "&pid=" + hdnpid.Value + "&vid=" + hdnvid.Value + "&billdate=" + hdndate.Value;
        //    Response.Redirect(Request.ApplicationPath  + queryString, true);


        //}
        //catch (System.Threading.ThreadAbortException tae)
        //{
        //    string thread = tae.ToString();
        //}

        //string purpose = hdnVisitDetail.Value;


        try
        {
            //Commented By Guruanth.S  
            #region Hardcoded Action Mapping  
                ////    string page;


                //string queryString = string.Empty;
                //string id = string.Empty;
                //string strUrl = string.Empty;
                //string[] listValue = ddlAction.SelectedValue.Split('~');
                ////page = ddlAction.SelectedItem.Text.ToString();
                //if (ddlAction.SelectedItem.Text == "View interim Bill")
                //{
                //    hidselection.Value = ddlAction.SelectedItem.Text.ToString();
                //    queryString = listValue[0] + "?ReferenceID=" + hdnFID.Value + "&pid=" + hdnpid.Value + "&vid=" + hdnvid.Value + "&billdate=" + hdndate.Value + "&IsAddServices=" + hdnBillType.Value;
                //    Response.Redirect(Request.ApplicationPath  + queryString, true);
                //}
                //else if (ddlAction.SelectedItem.Text == "Return From Patient")
                //{
                //    hidselection.Value = ddlAction.SelectedItem.Text.ToString();
                //    queryString = listValue[0] + "?ReferenceID=" + hdnFID.Value + "&pid=" + hdnpid.Value + "&vid=" + hdnvid.Value + "&billdate=" + hdndate.Value + "&BID=" + hdnFinalBillID.Value + "&RefTyp=IBN";
                //    Response.Redirect(Request.ApplicationPath  + queryString, true);

                //}
                //else if (ddlAction.SelectedItem.Text.ToUpper() == "EDIT DUECHART")
                //{
                //    hidselection.Value = ddlAction.SelectedItem.Text.ToString();
                //    queryString = listValue[0] + "?ReferenceID=" + hdnFID.Value + "&pid=" + hdnpid.Value + "&vid=" + hdnvid.Value + "&billdate=" + hdndate.Value + "&Status=" + hdnStatus.Value; // + "&BID=" + hdnFinalBillID.Value + "&RefTyp=IBN";
                //    Response.Redirect(Request.ApplicationPath  + queryString, true);
                //}
            #endregion            
            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
             
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            //if (lstActionsMaster.Exists(p => p.ActionCode == ddlAction.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlAction.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = ddlAction.SelectedValue;
            string ActionList = ViewState["ActionList"].ToString();
            foreach (string CompareList in ActionList.Split('^'))
            {
                if (CompareList.Split('~')[0] == ActCode)
                {
                    QueryString = CompareList.Split('~')[1];
                    break;
                }
            }
            #endregion
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = hdnpid.Value;
            objQueryMaster.PatientVisitID = hdnvid.Value;
            objQueryMaster.BillingDate = hdndate.Value;
            objQueryMaster.StatusValue = hdnStatus.Value;
            objQueryMaster.Servicevalue = hdnBillType.Value;
            objQueryMaster.ReferID = hdnFID.Value;
            AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                string sPath = "Billing\\\\InterimSearch.aspx_5";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ShowAlertMsg('" + sPath + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
            }
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    

}
