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

public partial class Admin_ManageInvMethod : BasePage
{
    public Admin_ManageInvMethod()
        : base("Admin_ManageInvMethod_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL;
    List<InvestigationMethod> lstInvMethod = new List<InvestigationMethod>();
    InvestigationMethod objInvMethod = new InvestigationMethod();
    string methodName = string.Empty;
    String Message = string.Empty;
    String BtnName = string.Empty;
    string strExit = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strEnter = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_01 == null ? "Enter the details of new Method" : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_01;
        strExit = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_02 == null ? "Search for existing Method details or click on Add New Method." : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_02;
        patientBL = new Patient_BL(base.ContextInfo);
        try
        {
            methodName = txtSearchMethodName.Text;
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
                //ltHead.Text = "Enter the details of new Method";
                ltHead.Text = strEnter;
            }
            if (!IsPostBack)
            {

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageInvMethod.aspx:Page_Load", ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string strMethod = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_03 == null ? "New Method Added Successfully" : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_03;
        long pMethodID = -1;
        try
        {
            objInvMethod.MethodName = txtMethodName.Text;
            objInvMethod.OrgID = OrgID;
            objInvMethod.CreatedBy = LID;
            returnCode = patientBL.SaveInvestigationMethod(objInvMethod, out pMethodID);
            if (returnCode == 0)
            {
                txtMethodName.Text = "";
                txtSearchMethodName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "New Method Added Successfully!";
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
                //Panel7.Visible = true;
                //ltHead.Text = "Search for existing Method details or click on Add New Method.";
                ltHead.Text = strExit;

                //Message = "New Method Added Successfully!";
                Message = strMethod;
                BtnName = "Sasve";
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Method Details.", ex);
            //  ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string strSaved = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_04 == null ? "Method Changes Saved Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_04;
        try
        {
            objInvMethod.MethodID = Convert.ToInt32(hdnMethodID.Value);
            objInvMethod.MethodName = txtMethodName.Text;
            objInvMethod.OrgID = OrgID;
            objInvMethod.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationMethod(objInvMethod);
            if (returnCode == 0)
            {
                txtMethodName.Text = "";
                txtSearchMethodName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "Method Changes Saved Successfully!";
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
                //ltHead.Text = "Search for existing Method details or click on Add New Method.";
                ltHead.Text = strExit;
                //Panel7.Visible = true;
                //Message = "Method Changes Saved Successfully!";
                Message = strSaved;
                BtnName = "Update";
                ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Method Details.", ex);
            //  ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string strRemove = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_05 == null ? "Method Removed Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_05;
        try
        {
            objInvMethod.MethodID = Convert.ToInt32(hdnMethodID.Value);
            objInvMethod.Status = "D";
            objInvMethod.OrgID = OrgID;
            objInvMethod.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationMethod(objInvMethod);
            if (returnCode == 0)
            {
                txtMethodName.Text = "";
                txtSearchMethodName.Text = "";
                //grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "Method Removed Successfully!";
                //btnUpdate.Visible = false;
                //btnDelete.Visible = false;
                //btnFinish.Visible = true;
                //ltHead.Text = "Search for existing Method details or click on Add New Method.";
                ltHead.Text = strExit;
                //Panel7.Visible = true;
                //Message = "Method Removed Successfully!";
                Message = strRemove;
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
            CLogger.LogError("Error While Removing Method Details.", ex);
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
            patientBL.GetInvestigationMethod(OrgID, methodName, "", out lstInvMethod);
            if (lstInvMethod.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstInvMethod;
                grdResult.DataBind();
            }
        }
    }
    //protected void addNewMethod_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("ManageInvMethod.aspx?mode=1",true);
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //patientBL.GetInvestigationMethod(OrgID, methodName, "", out lstInvMethod);
        //if (lstInvMethod.Count > 0)
        //{
        //    grdResult.Visible = true;
        //    grdResult.DataSource = lstInvMethod;
        //    grdResult.DataBind();
        //    lblStatus.Visible = false;
        //}
        //else
        //{
        //    lblStatus.Visible = true;
        //    grdResult.Visible = false;
        //    lblStatus.Text = "No Matching Records Found!";
        //}
        //ltHead.Text = "Search for existing Method details or click on Add New Method.";
        //Panel7.Visible = true;
        loadsearchgrid();
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            ltHead.Text = strExit;
            Panel7.Visible = true;
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnMethodID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                txtMethodName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
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
            CLogger.LogError("Error while loading Method Details to Change or Remove", ex);
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
            CLogger.LogError("Error while loading Method Details to Change or Remove", ex);
        }
    }
    private void loadsearchgrid()
    {
        string strNoRec = Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_06 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_ManageInvMethod_aspx_06;

        patientBL.GetInvestigationMethod(OrgID, methodName, "", out lstInvMethod);
        if (lstInvMethod.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lstInvMethod;
            grdResult.DataBind();
            lblStatus.Visible = false;
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.Visible = false;
            // lblStatus.Text = "No Matching Records Found!";    andrews

            lblStatus.Text = strNoRec;
        }
        //ltHead.Text = "Search for existing Method details or click on Add New Method.";
        ltHead.Text = strExit;
        Panel7.Visible = true;
        Message = "";
        BtnName = "Load";
        ScriptManager.RegisterStartupScript(this, GetType(), "Alert", "ShowSuccess('" + Message + "','" + BtnName + "');", true);
    }
}
