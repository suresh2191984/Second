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

public partial class CommonControls_AbberantQueue : BaseControl
{
    long returncode = -1;
    public CommonControls_AbberantQueue()
        : base("CommonControls_AbberantQueue_ascx")
    {
    }

   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadMetaData();
            if (RoleName == RoleHelper.LabTech || RoleName == RoleHelper.Phlebotomist || RoleName == RoleHelper.Accession || RoleName == RoleHelper.Labtypist || RoleName == RoleHelper.CustomerCare || RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.JuniorDoctor || RoleName == RoleHelper.Doctor || RoleName == "Client") //
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
            //if (returncode == 0)
            //{
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
            //}
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status In Commoncontrol_AbberantQueue", ex);
        }
    }

    
    protected void ddlInvSamplesStatus_OnSelectedIndexChanged(object sender, EventArgs e)
    {
        string InvSamplesStatusDate = string.Empty;
        InvSamplesStatusDate = ddlInvSamplesStatus.SelectedValue;
        LoadSample(InvSamplesStatusDate);
    }
    private void LoadSample(string DateType)
    {
        try
        {
            string FDate = string.Empty;
            string Tdate = string.Empty;
            if (DateType == "0")
            {
                FDate = DateTime.Today.AddDays(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
            }
            if (DateType == "1")
            {
                FDate = DateTime.Today.AddDays(-6).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
            }
            if (DateType == "2")
            {
                FDate = DateTime.Today.AddMonths(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
            }
            if (DateType == "3")
            {
                FDate = DateTime.Today.AddYears(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
                Tdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(1).ToString("dd-MM-yyyy hh:mm tt");
            }
            long pClientID = -1;
            if (CID > 0)
            {
                pClientID = CID;
            }
            List<AbberantQueue> lstAbberantQueue = new List<AbberantQueue>();
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);


            invbl.GetAbberantQueue(OrgID, FDate, Tdate, ILocationID, pClientID, out lstAbberantQueue);
                grdresult.DataSource = lstAbberantQueue;
                grdresult.DataBind();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowAberant", "javascript:ShowDivs();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading AbberantQueue", ex);
        }
    }
		  string strRetest = Resources.Phlebotomist_ClientDisplay.CommonControls_AbberantQueue_ascx_01 == null ? "Retest" : Resources.Phlebotomist_ClientDisplay.CommonControls_AbberantQueue_ascx_01;
    string strReflex = Resources.Phlebotomist_ClientDisplay.CommonControls_AbberantQueue_ascx_02 == null ? "Reflexwithnewsample" : Resources.Phlebotomist_ClientDisplay.CommonControls_AbberantQueue_ascx_02;


    protected void grdresult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                
                AbberantQueue aq = (AbberantQueue)e.Row.DataItem;
                LinkButton linkCL = (LinkButton)e.Row.FindControl("linkCL");
                LinkButton linkOL = (LinkButton)e.Row.FindControl("linkOL");
                Label lblstatus = (Label)e.Row.FindControl("lblstatus");
                string sampleCL = Request.ApplicationPath + @"/Lab/PendingSampleCollection.aspx?SStatus=" + aq.StatusID + "&FDate=" + aq.FromDate + "&Location=CL";
                string sampleOL = Request.ApplicationPath + @"/Lab/PendingSampleCollection.aspx?SStatus=" + aq.StatusID + "&FDate=" + aq.FromDate + "&Location=OL";
                string testCL = Request.ApplicationPath + @"/Lab/InvestigationQueue.aspx?Status=" + lblstatus.Text + "&FDate=" + aq.FromDate + "&Location=CL";
                string testOL = Request.ApplicationPath + @"/Lab/InvestigationQueue.aspx?Status=" + lblstatus.Text + "&FDate=" + aq.FromDate + "&Location=OL";
                linkCL.Width=e.Row.Cells[1].Width;
                linkOL.Width=e.Row.Cells[2].Width;
                if (lblstatus.Text == strRetest.Trim() || lblstatus.Text == strReflex.Trim())
                {
                    linkCL.PostBackUrl = testCL;
                    linkOL.PostBackUrl = testOL;
                }
                else
                {
                    linkCL.PostBackUrl = sampleCL;
                    linkOL.PostBackUrl = sampleOL;
                }
                if (linkCL.Text == "0")
                {
                    linkCL.Enabled = false;
                    linkCL.Font.Underline = false;
                }
                if (linkOL.Text == "0")
                {
                    linkOL.Enabled = false;
                    linkOL.Font.Underline = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdresult_RowDataBound AbberantQueue", ex);
        }
    }
    protected void grdresult_RowCreated1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.Cells[1].Attributes.Add("onmouseover", "this.style.backgroundColor='yellow';");
            //e.Row.Cells[2].Attributes.Add("onmouseover", "this.style.backgroundColor='yellow';");
            //e.Row.Cells[1].Attributes.Add("onmouseout", "this.style.backgroundColor='white';");
            //e.Row.Cells[2].Attributes.Add("onmouseout", "this.style.backgroundColor='white';");

            //e.Row.Cells[1].Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
            //e.Row.Cells[2].Style.Add(HtmlTextWriterStyle.Cursor, "Pointer");
        }

    }
    //protected void UpdateTimer_Tick(object sender, EventArgs e)
    //{
    //    LoadSample(ddlInvSamplesStatus.SelectedValue);
    //}

}
