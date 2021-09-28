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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;


public partial class CommonControls_DespatchQueue : BaseControl
{
    public CommonControls_DespatchQueue()
        : base("CommonControls_DespatchQueue_aspx")
    {
    }

    long returncode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMetaData();
            if (RoleName == RoleHelper.DispatchController)
            {
                LoadSample("0");
            }
        }
    }
    public void LoadMetaData()
    {
        try
        {
            string domains = "SampleRejectedPeriod";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "SampleRejectedPeriod"
                                 select child;

                ddlInvSamplesStatus.DataSource = childItems;
                ddlInvSamplesStatus.DataTextField = "DisplayText";
                ddlInvSamplesStatus.DataValueField = "Code";
                ddlInvSamplesStatus.DataBind();

            }

        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status In Commoncontrol_Despatch queue", ex);
        }
    }
    protected void ddlInvSamplesStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string InvSamplesStatusDate = string.Empty;
        InvSamplesStatusDate = ddlInvSamplesStatus.SelectedValue;
        if (RoleName == RoleHelper.DispatchController)
        {
            LoadSample(InvSamplesStatusDate);
        }
    }
    string FDate = string.Empty;
    string Tdate = string.Empty;
    private void LoadSample(string DateType)
    {
        try
        {

            if (DateType == "0")
            {
                FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd-MM-yyyy");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
            }
            if (DateType == "1")
            {
                DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime wkStDt = DateTime.MinValue;
                DateTime wkEndDt = DateTime.MinValue;
                wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
                wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
                FDate = wkStDt.ToString("dd-MM-yyyy");
                Tdate = wkEndDt.ToString("dd-MM-yyyy");

                //FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd-MM-yyyy");
                //Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
            }
            if (DateType == "2")
            {
                DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
                FDate = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
                dateNow = dateNow.AddMonths(1);
                Tdate = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day
                //FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd-MM-yyyy");
                //Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
            }
            if (DateType == "3")
            {
                FDate = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                Tdate = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                //FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd-MM-yyyy");
                //Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
            }

            hdnfromdate.Value = FDate;
            hdntodate.Value = Tdate;
            List<AbberantQueue> lstAbberantQueue = new List<AbberantQueue>();
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            long roleid = RoleID;
            //grdresult.DataSource = null;
            invbl.GetDispatchReports(OrgID, FDate, Tdate, ILocationID, roleid, out lstAbberantQueue);
            grdresult.DataSource = lstAbberantQueue;
            grdresult.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowAberant", "javascript:ShowDivs();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Despatch queue", ex);
        }
    }
    protected void grdresult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                AbberantQueue aq = (AbberantQueue)e.Row.DataItem;
                LinkButton linkCL = (LinkButton)e.Row.FindControl("linkCL");
                string sampleCL = Request.ApplicationPath + @"/Investigation/InvestigationReport.aspx?SStatus=" + aq.OLCount + "&FDate=" + aq.FromDate + "&TDate=" + aq.ToDate + "&hdnonoroff=N";
                if (aq.StatusID == 0)
                {
                    linkCL.Enabled = false;
                    linkCL.Font.Underline = false;
                }
                if (linkCL.Text == "0")
                {
                    linkCL.Enabled = false;
                    linkCL.Font.Underline = false;
                }
                else
                {
                    linkCL.PostBackUrl = sampleCL;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdresult_RowDataBound AbberantQueue", ex);
        }
    }
    protected void grdSample_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                PatientVisit Master = (PatientVisit)e.Row.DataItem;
                var childItems = from lst in lstpatientvisit
                                 where lst.PatientVisitId == Master.PatientVisitId
                                 select lst;

                GridView childGrid = (GridView)e.Row.FindControl("gvDescription");
                childGrid.DataSource = childItems;
                childGrid.DataBind();


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading dispatch queue", ex);
        }
    }
    protected void grdSample_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdSample.PageIndex = e.NewPageIndex;
            string statuis = hdnstatusid.Value;
            LoadDespatchModeinv(statuis, hdnfromdate.Value, hdntodate.Value);
            //mpeReport.Show();

        }

    }
    string statuid = string.Empty;
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        string strGuid = string.Empty;
        string strInvestigationID = string.Empty;
        try
        {
            if (e.CommandName == "ShowReports")
            {
                hdnstatusid.Value = "2";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading dispatch queue", ex);
        }

    }
    List<PatientVisit> lstpatientvisit = new List<PatientVisit>();
    List<PatientVisit> lstpatvisit = new List<PatientVisit>();
    public void LoadDespatchModeinv(string statusid, string FromDate, string ToDate)
    {

        int statusids = Convert.ToInt32(statusid);
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        try
        {
            invbl.GetDespatchPatientReport(statusids, FromDate, ToDate, OrgID, out lstpatientvisit);
            if (lstpatientvisit.Count > 0)
            {
                lstpatvisit = (from lst in lstpatientvisit
                               group lst by new
                               {
                                   lst.PatientVisitId,
                                   lst.PatientAge,
                                   lst.PatientName
                               } into g
                               select new PatientVisit
                               {
                                   PatientVisitId = g.Key.PatientVisitId,
                                   PatientAge = g.Key.PatientAge,
                                   PatientName = g.Key.PatientName
                               }
                               ).Distinct().ToList();

                if (lstpatvisit.Count > 0)
                {
                    grdSample.DataSource = lstpatvisit;
                    grdSample.DataBind();
                    mpeReport.Show();

                }


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetDespatchPatientReport common control Dispatchqueue.ascx", ex);
        }
    }
    //protected void UpdateTimer_Tick(object sender, EventArgs e)
    //{
    //    LoadSample(ddlInvSamplesStatus.SelectedValue);
    //}
    //Added By Prabakaran
    public void RefereshDespatchCount()
    {
        try
        {
            string DateType = string.Empty;
            DateType = ddlInvSamplesStatus.SelectedValue;
            if (!String.IsNullOrEmpty(DateType) && DateType.Length > 0)
                LoadSample(DateType);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading despatch count", ex);
        }
    }
    //Added By Prabakaran
}
