using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using System.Web.Script.Serialization;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;

public partial class Admin_LocalityMaster : BasePage
{
    public Admin_LocalityMaster()
        : base("Admin\\LocalityMaster.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    long Returncode = -1;
    AdminReports_BL objBl;
    List<Organization> lstOrg = new List<Organization>();
    List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
    List<Country> lstCountry = new List<Country>();
    List<Localities> LOC = new List<Localities>();
    List<InvClientMaster> lstClient = new List<InvClientMaster>();
    List<InvClientMaster> lstRemoveClient = new List<InvClientMaster>();
    List<ClientMaster> lstOrgLocationClient = new List<ClientMaster>();
    List<ClientMaster> lstDefLocationClient = new List<ClientMaster>();
    UserAddress useAddress = new UserAddress();
    int chid;
    long Addid;
    static long ADID;
    string AddressID;
    List<MetaValue_Common> lstMetavalue = new List<MetaValue_Common>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "SIT";
            AutoCompleteExtender2.ContextKey = "TIS";
            AutoCompleteExtender3.ContextKey = "CIT";
            AutoCompleteExtender4.ContextKey = "TIC";
            AutoCompleteExtender5.ContextKey = "KIC";

        }
        try
        {
            if (!IsPostBack)
            {
                //loadOrganization();
              //  ddlOrglocation_SelectedIndexChanged(sender, e);
                LoadMetaData();
               // CenterType();
                loadHUB();
                loadZONE();
                loadROUTE();


                //Label lbl =(Label)ucPAdd.FindControl("lblCutOffTime");
                //lbl.Style.Add("display","block");
                //TextBox txt = (TextBox)ucPAdd.FindControl("txtCOTValue");
                //txt.Style.Add("display", "block");
                //DropDownList drp = (DropDownList)ucPAdd.FindControl("ddlCOTType");
                //drp.Style.Add("display", "block");

            }

            //loadLocationClient();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OrganizationLocation Page Loading", ex);
        }
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "PackageStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL().LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "PackageStatus" //orderby child .MetaDataID
                                 select child;
                //ddlstatus.DataSource = childItems;
                //ddlstatus.DataTextField = "DisplayText";
                //ddlstatus.DataValueField = "Code";
                //ddlstatus.DataBind();
                //ddlstatus.Items.Insert(0, "--Select--");
                //ddlstatus.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }

    
    
    protected void btnaddhub_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Type = "HUB";
            LOCAL.Locality_Code = txthubcode.Text.Trim();
            LOCAL.Locality_Value = txthubname.Text.Trim();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (HdnhubID.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(HdnhubID.Value);
            }
            returncode = physicianBL.Inserthubname(LOCAL);
            clears();
            loadHUB();
            div01.Attributes.Add("Style", "display:block");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:none");
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returncode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }
            hdnbtnsave.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnsave_Click1", ex);
        }
    }

    protected void loadHUB()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesHub(orgid, out LOC);
            grddiv01.DataSource = LOC;
            grddiv01.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadHUB", ex);
        }
    }

    protected void grddiv01_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grddiv01.PageIndex = e.NewPageIndex;
        }
        loadHUB();
        div01.Attributes.Add("Style", "display:block");
        div02.Attributes.Add("Style", "display:none");
        div03.Attributes.Add("Style", "display:none");
       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);

    }
    protected void grddiv01_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
    protected void clears()
    {
        txthubcode.Text = string.Empty;
        txthubname.Text = string.Empty;
        HdnhubID.Value = string.Empty;
        txtzonecode.Text = string.Empty;
        txtzonename.Text = string.Empty;
        txtmaphub.Text = string.Empty;
        hdnzoneid.Value = string.Empty;
        txtroutecode.Text = string.Empty;
        txtroutename.Text = string.Empty;
        txtmapzone.Text = string.Empty;
        hdnrouteid.Value = string.Empty;
        txtsearchhubcode.Text = string.Empty;
        txtzonecode1.Text = string.Empty;
        txtroutecode1.Text = string.Empty;
        hdnMapHubID.Value = "";
        hdnMapZoneID.Value = "";
    }
    protected void btnsearchhub_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string hubcode = txtsearchhubcode.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.GetsearchHub(Orgid, hubcode, out local);
            clears();
            if (returnCode == 0)
            {
                //grddiv01.Visible = false;
                //grdsearchhub.Visible = true;
                grddiv01.DataSource = local;
                grddiv01.DataBind();
                txtsearchhubcode.Text = string.Empty;

            }
            div01.Attributes.Add("Style", "display:block");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:none");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchHub", ex);
        }


    }
    protected void loadZONE()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesZone(orgid, out LOC);
            Gridaddzone.DataSource = LOC;
            Gridaddzone.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadZONE", ex);
        }
    }

    protected void btnaddzone_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Locality_Code = txtzonecode.Text.Trim();
            LOCAL.Locality_Value = txtzonename.Text.Trim();
            LOCAL.Type = "ZONE";
            string maphubvalue = txtmaphub.Text.Trim();
            if (hdnMapHubID.Value != "")
            {
                LOCAL.ParentID = Convert.ToInt32(hdnMapHubID.Value);
            }
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (hdnzoneid.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(hdnzoneid.Value);
            }
            returnCode = physicianBL.Insertzonename(maphubvalue, LOCAL);
            clears();
            loadZONE();
            div01.Attributes.Add("style", "display:none");
            div02.Attributes.Add("Style", "display:block");
            div03.Attributes.Add("Style", "display:none");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }

            hdnbtnsavezone.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnaddzone_Click", ex);
        }
    }

    protected void btnsearchzone_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string zonecode = txtzonecode1.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.Getsearchzone(Orgid, zonecode, out local);
            clears();
            if (returnCode == 0)
            {
                //Gridaddzone.Visible = false;
                //grdsearchzone.Visible = true;
                Gridaddzone.DataSource = local;
                Gridaddzone.DataBind();
                txtzonecode1.Text = string.Empty;
                txtzonecode.Text = string.Empty;
            }
            div01.Attributes.Add("style", "display:none");
            div02.Attributes.Add("Style", "display:block");
            div03.Attributes.Add("Style", "display:none");
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchHub", ex);
        }

    }

    protected void Gridaddzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow1('" + ((RadioButton)e.Row.FindControl("rdSel1")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "','" + Local.ParentID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel1")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel1")).Attributes.Add("onclick", strScript);
        }
    }
    protected void Gridaddzone_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            Gridaddzone.PageIndex = e.NewPageIndex;
        }
        loadZONE();
        div01.Attributes.Add("style", "display:none");
        div02.Attributes.Add("Style", "display:block");
        div03.Attributes.Add("Style", "display:none");
       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    }
    protected void btnaddroute_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Locality_Code = txtroutecode.Text.Trim();
            LOCAL.Locality_Value = txtroutename.Text.Trim();
            LOCAL.Type = "ROUTE";
            string mapzonevalue = txtmapzone.Text.Trim();
            if (hdnMapZoneID.Value != "")
            {
                LOCAL.ParentID = Convert.ToInt32(hdnMapZoneID.Value);
            }
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (hdnrouteid.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(hdnrouteid.Value);
            }
            returnCode = physicianBL.Insertroutename(mapzonevalue, LOCAL);
            clears();
            loadROUTE();
            div01.Attributes.Add("Style", "display:none");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:block");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }
            hdnbtnsaveroute.Value = "";
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in btnaddzone_Click", ex);
        }
    }
    protected void loadROUTE()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesRoute(orgid, out LOC);
            grdaddroute.DataSource = LOC;
            grdaddroute.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadROUTE", ex);
        }
    }


    protected void grdaddroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow2('" + ((RadioButton)e.Row.FindControl("rdSel3")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "','" + Local.ParentID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onclick", strScript);
        }

    }
    protected void grdaddroute_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex != -1)
        {
            grdaddroute.PageIndex = e.NewPageIndex;
        }
        loadROUTE();
        div01.Attributes.Add("Style", "display:none");
        div02.Attributes.Add("Style", "display:none");
        div03.Attributes.Add("Style", "display:block");
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    }
    protected void btnsearchroute_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string routecode = txtroutecode1.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.Getsearchroute(Orgid, routecode, out local);
            clears();
            if (returnCode == 0)
            {
                //grdaddroute.Visible = false;
                //grdsearchroute.Visible = true;
                grdaddroute.DataSource = local;
                grdaddroute.DataBind();
                txtroutecode1.Text = string.Empty;
                txtroutecode.Text = string.Empty;
            }
            div01.Attributes.Add("Style", "display:none");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:block");
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchRoute", ex);
        }

    }
   }
