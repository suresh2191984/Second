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

public partial class CommonControls_ExpectantSampleQueue : BaseControl
{
    long returncode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                LoadMetaData();
                loadOrganization();
                LoadInvSampleMaster();
                if (RoleName == RoleHelper.LabTech || RoleName == RoleHelper.Phlebotomist ||RoleName==RoleHelper.SrLabTech || RoleName==RoleHelper.Accession)
                {
                    LoadSample("0");
                }



            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Page_Load() method In CommonControls_ExpectantSampleQueue", ex);
        }
    }
    public void RefereshRecievedSampleCount()
    {
        try
        {
            LoadSample("0");

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Recieved Sample count", ex);
        }
    }
    public void LoadInvSampleMaster()
    {
        try
        {
            long returnCode = -1;
            Investigation_BL objInvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            returnCode = objInvestigationBL.GetInvSampleMaster(OrgID, out lstInvSampleMaster);
            if (lstInvSampleMaster.Count > 0)
            {
                ddlSample.DataSource = lstInvSampleMaster;
                ddlSample.DataTextField = "SampleDesc";
                ddlSample.DataValueField = "SampleCode";
                ddlSample.DataBind();
                ddlSample.Items.Insert(0, "------SELECT------");
                ddlSample.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadInvSampleMaster in PendingSampleCollection_aspx_cs ", e);
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
            CLogger.LogError("Error while loading Meta Data like Date In CommonControls_ExpectantSampleQueue", ex);
        }
    }
    protected void ddlInvSamplesStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string InvSamplesStatusDate = string.Empty;
        InvSamplesStatusDate = ddlInvSamplesStatus.SelectedValue;
        //ddlOrganization.SelectedValue = ILocationID.ToString();
        LoadSample(InvSamplesStatusDate);
    }
    protected void grdSample_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (chkdelay.Checked == true)
            {
                Label lblDelayTime = (Label)e.Row.FindControl("lblDelayTime");
                e.Row.Visible = lblDelayTime.Text == "0Hour(s)" ? false : true;
            }
        }
    }
    private void LoadSample(string DateType)
    {
        try
        {
            string FDate = string.Empty;
            string Tdate = string.Empty;

            if (DateType == "0")
            {
                FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd/MM/yyyy");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd/MM/yyyy");
            }
            if (DateType == "1")
            {
                FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd/MM/yyyy");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd/MM/yyyy");
            }
            if (DateType == "2")
            {
                FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd/MM/yyyy");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd/MM/yyyy");
            }
            if (DateType == "3")
            {
                FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd/MM/yyyy");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd/MM/yyyy");
            }

            List<AbberantQueue> lstExpectantQueue = new List<AbberantQueue>();
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);

            // invbl.GetExpectantSampleQueue(OrgID, RoleID, ILocationID, FDate, Tdate, out lstExpectantQueue);
            //lblCount.Text = lstExpectantQueue[0].CLCount.ToString().Trim();
            int locationid = 0;
            locationid = Convert.ToInt32(ddlOrganization.SelectedValue);
            List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();

            invbl.GetInvExpectedSamplesForStatus(OrgID, FDate, Tdate, -1, ILocationID, "",
                                               "", "", -1, -1, "", "", -1, "", "", -1, -1, -1, 1, out lstInvestigationSamples);

            lblCount.Text = lstInvestigationSamples.Count.ToString().Trim();
            if (lblCount.Text == "0")
            {
                lblCount.Enabled = false;
            }
            else
            {
                lblCount.Enabled = true;
            }

            //if (lstExpectantQueue.Count > 0)
            //{
            //    string sampleCL = Helper.GetAppName() + @"/Lab/PendingSampleCollection.aspx?SamCollection=" + lstExpectantQueue[0].StatusID + "&FDate=" + FDate + "&Location=CL" + "&TDate=" + Tdate;
            //    lblCount.PostBackUrl = sampleCL;
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading CommonControls_ExpectantSampleQueue", ex);
        }
    }
    //protected void UpdateTimer_Tick(object sender, EventArgs e)
    //{
    //    LoadSample(ddlInvSamplesStatus.SelectedValue);
    //}



    protected void grdSample_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdSample.PageIndex = e.NewPageIndex;
            }
            LoadSamples();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in PendingSampleCollection grdSample_PageIndexChanging()", ex);
        }
    }
    protected void lnkbtn_Click(object sender, EventArgs e)
    {
        ddlOrganization.SelectedValue = ILocationID.ToString();
        ddlSample.SelectedValue = "-1";
        LoadSamples();

    }

    public void LoadSamples()
    {
        string FDate = string.Empty;
        string TDate = string.Empty;
        string DateType = ddlInvSamplesStatus.SelectedValue;
        long sampleid = Convert.ToInt64(ddlSample.SelectedValue);

        int locationid = 0;
        locationid = Convert.ToInt32(ddlOrganization.SelectedValue);
        if (DateType == "0")
        {
            FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd-MM-yyyy");
            TDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
        }
        if (DateType == "1")
        {
            FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd-MM-yyyy");
            TDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
        }
        if (DateType == "2")
        {
            FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd-MM-yyyy");
            TDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
        }
        if (DateType == "3")
        {
            FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd-MM-yyyy");
            TDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy");
        }

        List<CollectedSample> lstInvestigationSamples = new List<CollectedSample>();
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        invbl.GetInvExpectedSamplesForStatus(OrgID, FDate, TDate, -1, locationid, "",
            "", "", -1, -1, "", "", -1, "", "", -1, -1, sampleid, 1, out lstInvestigationSamples);
        if (lstInvestigationSamples.Count > 0)
        {
            grdSample.DataSource = lstInvestigationSamples;
            grdSample.DataBind();
            mpePatternSelection.Show();
        }
        else
        {
            grdSample.DataSource = null;
            grdSample.DataBind();
            mpePatternSelection.Show();

        }

        if (chkdelay.Checked == true)
        {

           
            var childItems = from child in lstInvestigationSamples

                             where child.DelayTime == "0Hour(s)" || child.DelayTime == "0Day(s)"

                             select child;
            var total = lstInvestigationSamples.Count - childItems.ToList().Count;
            lblsanplecount.Text = "No.of Samples : " + total.ToString();
            
        }
        else
        {
            lblsanplecount.Text = "No.of Samples : " + lstInvestigationSamples.Count.ToString();
        }



    }
    protected void ddlOrganization_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSamples();
    }
    public void loadOrganization()
    {
        try
        {
            long Returncode = -1;
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrg = new List<Organization>();
            Returncode = objBl.GetTrustedOrganizationAddress(OrgID, out lstOrg);
            if (lstOrg.Count > 0)
            {
                ddlOrganization.DataSource = lstOrg;
                ddlOrganization.DataTextField = "Name";
                ddlOrganization.DataValueField = "AddressID";
                ddlOrganization.DataBind();
                ddlOrganization.Items.Insert(0, "------SELECT------");
                ddlOrganization.Items[0].Value = "-1";
            }
            else
            {
                ddlOrganization.DataSource = null;
                ddlOrganization.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadOrganization", ex);
        }
    }
    protected void ddlSample_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSamples();
    }
    protected void chkdelay_CheckedChanged(object sender, EventArgs e)
    {
        
        LoadSamples();
   
    }
}
