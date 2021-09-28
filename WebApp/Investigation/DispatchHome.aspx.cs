using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Data;
using System.Collections;

public partial class Investigation_DispatchHome :BasePage
{

    public Investigation_DispatchHome()
        : base("Investigation\\DispatchHome.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteProduct.ContextKey = "NameOnly";
        if (!IsPostBack)
        {
            loadactionmaster();
             
        }
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
    protected void gvName_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
    }
    protected void gvName_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    public void GetApprovedInvestigation()
    {
        try
        {
            string tempfrom = "01/01/2001 00:00:00";
            string fromDate, ToDate;
            if (ddlRegisterDate.SelectedItem.Text != "--Select--")
            {
                if (txtFromDate.Text != "" && txtToDate.Text != "")
                {

                    fromDate = txtFromDate.Text;
                    ToDate = txtToDate.Text;

                }
                else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
                {
                    fromDate = txtFromPeriod.Text;
                    ToDate = txtToPeriod.Text;
                }
                else if (ddlRegisterDate.SelectedItem.Text == "Today")
                {
                    fromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                    ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                }
                else
                {
                    fromDate = txtFromDate.Text;
                    ToDate = txtToDate.Text;

                }
            }
            else
            {
                fromDate = tempfrom;
                ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();

            }

            long returnCode = -1;
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            long visitid = txtVisitNo.Text == "" ? 0 : Convert.ToInt64(txtVisitNo.Text);
            
            
            returnCode = new Patient_BL(base.ContextInfo).GetApprovedInvestigationPatient(visitid, txtPatientNo.Text.ToString(), txtName.Text.ToString(), fromDate, ToDate, OrgID, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                gvName.DataSource = lstPatientVisit;
                gvName.DataBind();
                trSelectVisit.Visible = true;
            }
            else
            {
                gvName.DataSource = null;
                gvName.DataBind();
                trSelectVisit.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Get Approvedinvestigation from DispatchHome .aspx", ex);
        }
            
             
    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        GetApprovedInvestigation();
    }
    public void loadactionmaster()
    {
        long returnCode = -1;
        int menuType = Convert.ToInt32(TaskHelper.SearchType.PublishReport);

        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
        returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, menuType, out lstVisitSearchAction);
        if (lstActionMaster.Count > 0)
        {
            //lstActionsMaster = lstActionMaster.ToList();
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
            ddlVisitActionName.DataSource = lstActionMaster;
            ddlVisitActionName.DataTextField = "ActionName";
            //ddlVisitActionName.DataValueField = "PageURL";
            ddlVisitActionName.DataValueField = "ActionCode";
            ddlVisitActionName.DataBind();
            ddlVisitActionName.Items.Insert(0, new ListItem("--Select--", "0"));
            ddlVisitActionName.Visible = true;
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            if (ddlVisitActionName.SelectedValue == "Publish_Report_InvestigationReport")
            {
                System.Data.DataTable dt = new DataTable();
                DataColumn dbCol1 = new DataColumn("PatientVisitID");
                DataColumn dbCol2 = new DataColumn("BarcodeNumber");
                DataColumn dbCol3 = new DataColumn("SampleCode");
                DataColumn dbCol4 = new DataColumn("SampleDesc");
                DataColumn dbCol5 = new DataColumn("IPInvSampleCollectionMasterID");

                //add columns
                dt.Columns.Add(dbCol1);
                dt.Columns.Add(dbCol2);
                dt.Columns.Add(dbCol3);
                dt.Columns.Add(dbCol4);
                dt.Columns.Add(dbCol5);
                DataRow dr;

                foreach (GridViewRow row in gvName.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        CheckBox chkBox = (CheckBox)row.FindControl("chkSelectNL");
                        //HiddenField hdnrequestid = (HiddenField)row.FindControl("hdnRequestID");
                        HiddenField lbldespatchstatus = (HiddenField)row.FindControl("hdnreportstatus");
                        HiddenField visitid = (HiddenField)row.FindControl("hdnPatientvisitid");
                        if (chkBox.Checked)
                        {
                            dr = dt.NewRow();
                            dr["PatientVisitID"] = Convert.ToInt64(visitid.Value);
                            dr["BarcodeNumber"] = "";
                            dr["SampleCode"] = 0;
                            dr["SampleDesc"] = lbldespatchstatus.Value;
                            dr["IPInvSampleCollectionMasterID"] = 0;
                            dt.Rows.Add(dr);
                        }
                    }
                }
                if (dt.Rows.Count > 0)
                {
                    Patient_BL objpatietnbal = new Patient_BL(base.ContextInfo);
                    returnCode =objpatietnbal.insertpublishvisitInvestigation(dt, LID, OrgID);
                    if (returnCode >= 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "Dispatchstatus", "UnselectedDatas();", true);
                    }

                }
                GetApprovedInvestigation();

            }
        }



        catch (Exception ex)
        {
            CLogger.LogError("Go Button Method Dispatchhome.aspx", ex);
        }
    }
}
