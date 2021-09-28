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

public partial class Admin_ManageInvKit : BasePage
{
    public Admin_ManageInvKit()
        : base("Admin_ManageInvKit_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL;
    List<InvKitMaster> lstInvKitMaster = new List<InvKitMaster>();
    InvKitMaster objInvKitMaster = new InvKitMaster();
    string kitName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string Kit = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_01 == null ? "Enter the details of new Kit" : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_01;
        patientBL = new Patient_BL(base.ContextInfo);
        try
        {
            kitName = txtSearchKitName.Text;
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
               // ltHead.Text = "Enter the details of new Kit";
                ltHead.Text = Kit;
            }
            if (!IsPostBack)
            {
               
            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageInvKit.aspx:Page_Load", ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string succ = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_02 == null ? "New Kit Added Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_02;
        string NewKit = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_03 == null ? "Search for existing Kit details or click on Add New Kit." : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_03;
        long pKitID = -1;
        try
        {
            objInvKitMaster.KitName = txtKitName.Text;
            objInvKitMaster.OrgID = OrgID;
            objInvKitMaster.CreatedBy = LID;
            returnCode = patientBL.SaveInvestigationKit(objInvKitMaster, out pKitID);
            if (returnCode == 0)
            {
                txtKitName.Text = "";
                txtSearchKitName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
               // lblStatus.Text = "New Kit Added Successfully!";  
                lblStatus.Text = succ;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                Panel7.Visible = true;
                //ltHead.Text = "Search for existing Kit details or click on Add New Kit.";
                ltHead.Text = NewKit;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Kit Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string save = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_04 == null ? "Kit Changes Saved Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_04;
        string search = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_05 == null ? "Search for existing Kit details or click on Add New Kit." : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_05;
        try
        {
            objInvKitMaster.KitID = Convert.ToInt32(hdnKitID.Value);
            objInvKitMaster.KitName = txtKitName.Text;
            objInvKitMaster.OrgID = OrgID;
            objInvKitMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationKit(objInvKitMaster);
            if (returnCode == 0)
            {
                txtKitName.Text = "";
                txtSearchKitName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
               // lblStatus.Text = "Kit Changes Saved Successfully!";
                lblStatus.Text = save;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
               // ltHead.Text = "Search for existing Kit details or click on Add New Kit.";
                ltHead.Text = search;
                Panel7.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Kit Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string suc = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_06 == null ? "Kit Removed Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_06;
        string sec = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_07 == null ? "Search for existing Kit details or click on Add New Kit." : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_07;
        try
        {
            objInvKitMaster.KitID = Convert.ToInt32(hdnKitID.Value);
            objInvKitMaster.Status = "D";
            objInvKitMaster.OrgID = OrgID;
            objInvKitMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationKit(objInvKitMaster);
            if (returnCode == 0)
            {
                txtKitName.Text = "";
                txtSearchKitName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                //lblStatus.Text = "Kit Removed Successfully!";
                lblStatus.Text = suc;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
              //  ltHead.Text = "Search for existing Kit details or click on Add New Kit.";
                ltHead.Text = sec;
                Panel7.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Removing Kit Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            patientBL.GetInvestigationKit(OrgID, kitName, "", out lstInvKitMaster);
            if (lstInvKitMaster.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstInvKitMaster;
                grdResult.DataBind();
            }
        }
    }
    protected void addNewKit_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageInvKit.aspx?mode=1",true);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string no = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_08 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_08;
        string kit = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_09 == null ? "Search for existing Kit details or click on Add New Kit." : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_09;
        patientBL.GetInvestigationKit(OrgID, kitName, "", out lstInvKitMaster);
        if (lstInvKitMaster.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lstInvKitMaster;
            grdResult.DataBind();
            lblStatus.Visible = false;
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.Visible = false;
           // lblStatus.Text = "No Matching Records Found!";
            lblStatus.Text = no;
        }
       // ltHead.Text = "Search for existing Kit details or click on Add New Kit.";
        ltHead.Text = kit;
        Panel7.Visible = true;
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string kit = Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_09 == null ? "Search for existing Kit details or click on Add New Kit." : Resources.Admin_ClientDisplay.Admin_ManageInvKit_aspx_09;
        try
        {
            //ltHead.Text = "Search for existing Kit details or click on Add New Kit.";
            ltHead.Text = kit;
            Panel7.Visible = true;
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnKitID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                txtKitName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                btnFinish.Visible = false;
                btnUpdate.Visible = true;
                btnDelete.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Kit Details to Change or Remove", ex);
        }
    }
    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdResult.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Kit Details to Change or Remove", ex);
        }
    }
}
