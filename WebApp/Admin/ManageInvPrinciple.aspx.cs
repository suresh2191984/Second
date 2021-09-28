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

public partial class Admin_ManageInvPrinciple : BasePage
{
    public Admin_ManageInvPrinciple()
        : base("Admin_ManageInvPrinciple_aspx")
    {

    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL;
    List<InvPrincipleMaster> lstInvPrincipleMaster = new List<InvPrincipleMaster>();
    InvPrincipleMaster objInvPrincipleMaster = new InvPrincipleMaster();
    string principleName = string.Empty;
    String Message = string.Empty;
    String BtnName = string.Empty;
    string strAspx04 = string.Empty;
    string strAspx03 = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strAspx01 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_01 == null ? "Enter the details of new Principle" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_01;
         strAspx04 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_04 == null ? "Search for existing Principle details or click on Add New Principle." : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_04;
          strAspx03 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_03 == null ? "Principle Name Already Exists!" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_03;

        patientBL = new Patient_BL(base.ContextInfo);
        try
        {
            principleName = txtSearchPrincipleName.Text;
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
                //ltHead.Text = "Enter the details of new Principle";
                ltHead.Text = strAspx01;
            }
            if (!IsPostBack)
            {

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageInvPrinciple.aspx:Page_Load", ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string strAspx02 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_02 == null ? "New Principle Added Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_02;
        
        long pPrincipleID = -1;
        try
        {
            objInvPrincipleMaster.PrincipleName = txtPrincipleName.Text;
            objInvPrincipleMaster.OrgID = OrgID;
            objInvPrincipleMaster.CreatedBy = LID;
            returnCode = patientBL.SaveInvestigationPrinciple(objInvPrincipleMaster, out pPrincipleID);
            if (returnCode >= 0)
            {
                //lblStatus.Text = "New Principle Added Successfully!";
                //Message="New Principle Added Successfully!";
                Message = strAspx02;
            }
            else
            {
                //Message="Principle Name Already Exists!";
                Message = strAspx03;
                //lblStatus.Text = "Principle Name Already Exists!";
            }
                txtPrincipleName.Text = "";
                txtSearchPrincipleName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
                //Panel7.Visible = true;
                //ltHead.Text = "Search for existing Principle details or click on Add New Principle.";
                ltHead.Text = strAspx04;
                BtnName = "Sasve";
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Principle Details.", ex);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string strSaved = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_07 == null ? "Principle Changes Saved Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_07;

        try
        {
            objInvPrincipleMaster.PrincipleID = Convert.ToInt32(hdnPrincipleID.Value);
            objInvPrincipleMaster.PrincipleName = txtPrincipleName.Text;
            objInvPrincipleMaster.OrgID = OrgID;
            objInvPrincipleMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationPrinciple(objInvPrincipleMaster);
            if (returnCode >= 0)
            {
                //Message = "Principle Changes Saved Successfully!";
                Message = strSaved;
                //lblStatus.Text = "Principle Changes Saved Successfully!";
            }
            else
            {
               // Message = "Principle Name Already Exists!";
                Message = strAspx03;
                //lblStatus.Text = "Principle Name Already Exists!";
            }
                txtPrincipleName.Text = "";
                txtSearchPrincipleName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
               // ltHead.Text = "Search for existing Principle details or click on Add New Principle.";
                ltHead.Text = strAspx04;
                //Panel7.Visible = true;
                BtnName = "Update";
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Principle Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string strAspx05 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_05 == null ? "Principle Removed Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_05;

        try
        {
            objInvPrincipleMaster.PrincipleID = Convert.ToInt32(hdnPrincipleID.Value);
            objInvPrincipleMaster.Status = "D";
            objInvPrincipleMaster.OrgID = OrgID;
            objInvPrincipleMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationPrinciple(objInvPrincipleMaster);
            if (returnCode == 0)
            {
                txtPrincipleName.Text = "";
                txtSearchPrincipleName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "Principle Removed Successfully!";
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
                //ltHead.Text = "Search for existing Principle details or click on Add New Principle.";
                ltHead.Text = strAspx04;
                //Message = "Principle Removed Successfully!";
                Message = strAspx05;
                //Panel7.Visible = true;
                BtnName = "Remove";
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Removing Principle Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Navigation navigation = new Navigation();
    //        Role role = new Role();
    //        role.RoleID = RoleID;
    //        List<Role> userRoles = new List<Role>();
    //        userRoles.Add(role);
    //        string relPagePath = string.Empty;
    //        long returnCode = -1;
    //        returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

    //        if (returnCode == 0)
    //        {
    //            Response.Redirect(Request.ApplicationPath + relPagePath, true);
    //        }
    //    }
    //    catch (System.Threading.ThreadAbortException tex)
    //    {
    //        string te = tex.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
    //    }
    //}

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            patientBL.GetInvestigationPrinciple(OrgID, principleName, "", out lstInvPrincipleMaster);
            if (lstInvPrincipleMaster.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstInvPrincipleMaster;
                grdResult.DataBind();
            }
        }
    }
    //protected void addNewPrinciple_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("ManageInvPrinciple.aspx?mode=1", true);
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //patientBL.GetInvestigationPrinciple(OrgID, principleName, "", out lstInvPrincipleMaster);
        //if (lstInvPrincipleMaster.Count > 0)
        //{
        //    grdResult.Visible = true;
        //    grdResult.DataSource = lstInvPrincipleMaster;
        //    grdResult.DataBind();
        //    lblStatus.Visible = false;
        //}
        //else
        //{
        //    lblStatus.Visible = true;
        //    grdResult.Visible = false;
        //    lblStatus.Text = "No Matching Records Found!";
        //}
        //ltHead.Text = "Search for existing Principle details or click on Add New Principle.";
        //Panel7.Visible = true;
        LoadSearchGrid();
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            //ltHead.Text = "Search for existing Principle details or click on Add New Principle.";
            ltHead.Text = strAspx04;
            Panel7.Visible = true;
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnPrincipleID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                txtPrincipleName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
                txtPrincipleName.ReadOnly = false;
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                //btnFinish.Visible = false;
                btnFinish.Attributes.Add("style", "display:none");
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
            CLogger.LogError("Error while loading Principle Details to Change or Remove", ex);
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
            CLogger.LogError("Error while loading Principle Details to Change or Remove", ex);
        }
    }
    private void LoadSearchGrid() {
        string strAspx06 = Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_06 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_ManageInvPrinciple_aspx_06;

        patientBL.GetInvestigationPrinciple(OrgID, principleName, "", out lstInvPrincipleMaster);
        if (lstInvPrincipleMaster.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lstInvPrincipleMaster;
            grdResult.DataBind();
            lblStatus.Visible = false;
            txtPrincipleName.ReadOnly = true;
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.Visible = false;
            txtPrincipleName.ReadOnly = false;
            lblStatus.Text = strAspx06;
        }
        ltHead.Text = strAspx04;
        Panel7.Visible = true;
        Message = "";
        BtnName = "Load";
        ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
    }
}
