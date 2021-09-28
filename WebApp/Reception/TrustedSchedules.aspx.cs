using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;

public partial class Reception_Home : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (ddlTrustedOrgs.SelectedValue != "")
            {
                int iOrgID = 0;
                Int32.TryParse(ddlTrustedOrgs.SelectedValue.Split('~')[0], out iOrgID);
                phySch.TempOrgID = iOrgID;

                int iLocationID = 0;
                Int32.TryParse(ddlTrustedOrgs.SelectedValue.Split('~')[1], out iLocationID);
                phySch.LocationID = iLocationID;
            }
            long PatientID = 0;
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            phySch.PatientID = PatientID;

            long ReferalID = 0;
            Int64.TryParse(Request.QueryString["rfid"], out ReferalID);
            phySch.ReferalID = ReferalID;
            phySch.PostDifferentPage = "Yes";
            
            //RecHome.Attributes.Add("onload", "pageLoad();");
            if (!IsPostBack)
            {
                
                LoadTrusted();
            }
        }
        catch (Exception ex)
        {            
            CLogger.LogError("Error in Reception Home:Page_Load", ex);
        }
    }

    private void LoadTrusted()
    {
        List<OrganizationAddress> lstorgs = new List<OrganizationAddress>();
        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        
        new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, "Clinical View", out lstTOD);
        new Schedule_BL(base.ContextInfo).getOrganizationAddress(out lstorgs);

            var trustedorg = (from p in lstorgs
                                join q in lstTOD
                                on p.OrgID
                                equals q.SharingOrgID
                                select new { p.Comments, p.Location }).Distinct();
        ddlTrustedOrgs.Items.Clear();
        
        ddlTrustedOrgs.DataSource = trustedorg;
        ddlTrustedOrgs.DataTextField = "Location";
        ddlTrustedOrgs.DataValueField = "Comments";
        ddlTrustedOrgs.DataBind();
        ddlTrustedOrgs.Items.Insert(0,new ListItem("--Select--", "0~0"));

        string sSelectedOrg = "";
        if (Request.QueryString["rorg"] != null)
        {
            sSelectedOrg = Request.QueryString["rorg"].ToString();
        }
        if (sSelectedOrg != "")
        {
            int indexitem =0;
            for (int i = 0; i < ddlTrustedOrgs.Items.Count; i++)
            {
                if (ddlTrustedOrgs.Items[i].Value.Split('~')[1] == sSelectedOrg)
                {
                    indexitem = i;
                }
            }
            ddlTrustedOrgs.Enabled = false;
            ddlTrustedOrgs.SelectedIndex = indexitem;
            //ddlTrustedOrgs.SelectedValue.Split('~')[1] = sSelectedOrg;
            object sender = null;
            EventArgs e = null;
            ddlTrustedOrgs_SelectedIndexChanged(sender, e);
        }
        else
        {
            ddlTrustedOrgs.Enabled = true;
        }
    }

    protected void ddlTrustedOrgs_SelectedIndexChanged(object sender, EventArgs e)
    {
        //phySch.BDifferentDB = true;
        int iOrgID = 0;
         int iLocationID = 0;
         if (ddlTrustedOrgs.SelectedValue != "")
         {
             Int32.TryParse(ddlTrustedOrgs.SelectedValue.Split('~')[0], out iOrgID);
             phySch.TempOrgID = iOrgID;

             Int32.TryParse(ddlTrustedOrgs.SelectedValue.Split('~')[1], out iLocationID);
             phySch.LocationID = iLocationID;
         }
        long PatientID = 0;
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
        phySch.PatientID = PatientID;

        long ReferalID = 0;
        Int64.TryParse(Request.QueryString["rfid"], out ReferalID);
        phySch.ReferalID = ReferalID;
        if (iOrgID > 0)
        {
           phySch.Visible = true;
           phySch.lNext_Click(sender, e);
        }
        else
        {
            phySch.Visible = false;
        }
    }



}
