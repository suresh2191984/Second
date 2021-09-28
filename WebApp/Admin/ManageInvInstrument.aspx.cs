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

public partial class Admin_ManageInvInstrument : BasePage
{
    public Admin_ManageInvInstrument()
        : base("Admin_ManageInvInstrument_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL;
    List<InvInstrumentMaster> lstInvInstrumentMaster = new List<InvInstrumentMaster>();
    InvInstrumentMaster objInvInstrumentMaster = new InvInstrumentMaster();
    string instrumentName = string.Empty;
    string strSearch = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        string strInst = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_01 == null ? "Enter the details of new Instrument" : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_01;
         strSearch = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_03 == null ? "Search for existing Instrument details or click on Add New Instrument." : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_03;

        patientBL = new Patient_BL(base.ContextInfo);
        try
        {
            instrumentName = txtSearchInstrumentName.Text;
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
                //ltHead.Text = "Enter the details of new Instrument";
                ltHead.Text = strInst;
            }
            if (!IsPostBack)
            {

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageInvInstrument.aspx:Page_Load", ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string strAdd = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_02 == null ? "New Instrument Added Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_02;
        long pInstrumentID = -1;
        try
        {
            objInvInstrumentMaster.InstrumentName = txtInstrumentName.Text;
            objInvInstrumentMaster.OrgID = OrgID;
            objInvInstrumentMaster.QCData = txtQCData.Text;
            objInvInstrumentMaster.CreatedBy = LID;
            returnCode = patientBL.SaveInvestigationInstrument(objInvInstrumentMaster, out pInstrumentID);
            if (returnCode == 0)
            {
                txtInstrumentName.Text = "";
                txtSearchInstrumentName.Text = "";
                txtQCData.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                //lblStatus.Text = "New Instrument Added Successfully!";
                lblStatus.Text = strAdd;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                Panel7.Visible = true;
                //ltHead.Text = "Search for existing Instrument details or click on Add New Instrument.";
                ltHead.Text = strSearch;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Instrument Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string strChange = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_04 == null ? "Instrument Changes Saved Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_04;

        try
        {
            objInvInstrumentMaster.InstrumentID = Convert.ToInt32(hdnInstrumentID.Value);
            objInvInstrumentMaster.InstrumentName = txtInstrumentName.Text;
            objInvInstrumentMaster.QCData = txtQCData.Text;
            objInvInstrumentMaster.OrgID = OrgID;
            objInvInstrumentMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationInstrument(objInvInstrumentMaster);
            if (returnCode == 0)
            {
                txtInstrumentName.Text = "";
                txtSearchInstrumentName.Text = "";
                txtQCData.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                //lblStatus.Text = "Instrument Changes Saved Successfully!";
                lblStatus.Text = strChange;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                //ltHead.Text = "Search for existing Instrument details or click on Add New Instrument.";
                ltHead.Text = strSearch;
                Panel7.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Instrument Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string strRemove = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_05 == null ? "Instrument Removed Successfully!" : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_05;

        try
        {
            objInvInstrumentMaster.InstrumentID = Convert.ToInt32(hdnInstrumentID.Value);
            objInvInstrumentMaster.Status = "D";
            objInvInstrumentMaster.OrgID = OrgID;
            objInvInstrumentMaster.ModifiedBy = LID;
            returnCode = patientBL.UpdateInvestigationInstrument(objInvInstrumentMaster);
            if (returnCode == 0)
            {
                txtInstrumentName.Text = "";
                txtSearchInstrumentName.Text = "";
                txtQCData.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                //lblStatus.Text = "Instrument Removed Successfully!";
                lblStatus.Text = strRemove;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                //ltHead.Text = "Search for existing Instrument details or click on Add New Instrument.";
                ltHead.Text = strSearch;
                Panel7.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Removing Instrument Details.", ex);
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
            patientBL.GetInvestigationInstrument(OrgID, instrumentName, "", out lstInvInstrumentMaster);
            if (lstInvInstrumentMaster.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstInvInstrumentMaster;
                grdResult.DataBind();
            }
        }
    }
    protected void addNewInstrument_Click(object sender, EventArgs e)
    {
        Response.Redirect("ManageInvInstrument.aspx?mode=1", true);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strNoRecord = Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_06 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_ManageInvInstrument_aspx_06;

        patientBL.GetInvestigationInstrument(OrgID, instrumentName, "", out lstInvInstrumentMaster);
        if (lstInvInstrumentMaster.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = lstInvInstrumentMaster;
            grdResult.DataBind();
            lblStatus.Visible = false;
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.Visible = false;
           // lblStatus.Text = "No Matching Records Found!";
            lblStatus.Text = strNoRecord;
        }
        //ltHead.Text = "Search for existing Instrument details or click on Add New Instrument.";
        ltHead.Text =strSearch;
        Panel7.Visible = true;
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            //ltHead.Text = "Search for existing Instrument details or click on Add New Instrument.";
            ltHead.Text = strSearch;
            Panel7.Visible = true;
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnInstrumentID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                txtInstrumentName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
                txtQCData.Text = Convert.ToString(grdResult.DataKeys[RowIndex][2]);
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
            CLogger.LogError("Error while loading Instrument Details to Change or Remove", ex);
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
                //"this.style.cursor='pointer';this.style.color='#';");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                //"this.style.color='';");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Instrument Details to Change or Remove", ex);
        }
    }
}
