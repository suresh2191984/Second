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
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Linq;
using Attune.Podium.Common;

public partial class Investigation_ContainerMaster : BasePage
{
    public Investigation_ContainerMaster() :
        base("Investigation_ContainerMaster_ascx")

    { }
    AdminReports_BL Admin_BL;
    List<InvSampleMaster> lstInvSampleMaster;
    List<InvestigationSampleContainer> lstInvSampleContainer;
    
    #region "Common Resource Property"

    string Alert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;

    #endregion
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadSampleContainer();
        }
    }
    #endregion

    #region "Events"
    protected void btnSaveSample_Click(object sender, EventArgs e)
    {
        string strSampleName = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_001 == null ? "SampleName Added Successfully" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_001;
        long returnCode = -1;
        string SampleName = txtSampleName.Text.Trim() == "" ? string.Empty : txtSampleName.Text.Trim();
        string SampleCode = txtSampleCode.Text.Trim() == "" ? string.Empty : txtSampleCode.Text.Trim();
        string SampleDesc = string.Empty;
        string SampleType = "SAMPLE";
        string Status = "Y";
        long SampleID = 0;
        string IsSpecialSample = string.Empty;
        if (chkBox2.Checked)
        {
            ContextInfo.AdditionalInfo = "Y";
        }
        else
        {
            ContextInfo.AdditionalInfo = "N";
        }
        if (btnSaveSample.Text == "Update")
        {
            SampleID = Convert.ToInt64(hdnSampleID.Value);
        }

        Admin_BL = new AdminReports_BL(base.ContextInfo);

        returnCode = Admin_BL.SaveSampleContainer(OrgID, SampleName, SampleCode, SampleDesc, SampleID, SampleType, Status);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "InsertAlert", "ValidationWindow('" + strSampleName.Trim() + "','" + Alert.Trim() + "');", true);
        LoadSampleContainer();
        Clear(SampleType);

    }
    protected void grdSample_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdSample.EditIndex = e.NewEditIndex;
        LoadSampleContainer();
    }
    protected void grdSampleContainer_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdSampleContainer.EditIndex = e.NewEditIndex;
        LoadSampleContainer();
    }
    protected void grdSample_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grdSample.EditIndex = -1;
        LoadSampleContainer();
    }
    protected void grdSampleContainer_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grdSampleContainer.EditIndex = -1;
        LoadSampleContainer();
    }
    protected void grdSampleContainer_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string strContainerName = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_05 == null ? "Container Name should not be Empty" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_05;
        string strContainerMin = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_06 == null ? "Container Code should be minimum of 5" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_06;
        string strChanges = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_07 == null ? "Changes updated successfully." : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_07;
        string strContainerAlready = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_08 == null ? "Container Name Already Exists!!! ." : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_08;
        long returnCode = -1;
        string SampleType = "CNTR";
        long SampleID = 0;
        Int64.TryParse(((Label)grdSampleContainer.Rows[e.RowIndex].FindControl("lblContainerID")).Text, out SampleID);

        string SampleName = ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtContainerName")).Text.Trim();
        if (SampleName == "" || SampleName == null)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow('" + strContainerName.Trim() + "','" + Alert.Trim() + "');", true);
            ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtContainerName")).Focus();
        }
        else
        {
            string SampleCode = ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtContainerCode")).Text;
            string SampleDesc = ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtDescription")).Text;
            string Status = (((CheckBox)grdSampleContainer.Rows[e.RowIndex].FindControl("chkbox")).Checked ? "Y" : "N");

            Admin_BL = new AdminReports_BL(base.ContextInfo);
            if (SampleCode.Length > 5)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow('" + strContainerMin + "','" + Alert + "');", true);
                // ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtContainerCode")).Text = string.Empty;
                ((TextBox)grdSampleContainer.Rows[e.RowIndex].FindControl("txtContainerCode")).Focus();
            }
            else
            {
                returnCode = Admin_BL.SaveSampleContainer(OrgID, SampleName, SampleCode, SampleDesc, SampleID, SampleType, Status);
                if (returnCode >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlertC", "ValidationWindow('" + strChanges + "','" + Alert + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlertC", "ValidationWindow('" + strContainerAlready + "','" + Alert + "');", true);
                }
                grdSampleContainer.EditIndex = -1;
                LoadSampleContainer();
                Clear(SampleType);
            }
        }


    }
    protected void grdSample_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        string strSampleCode = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_09 == null ? "Sample Code should be minimum of 5" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_09;
        string strChanges = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_10 == null ? "Changes updated successfully." : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_10;
        string strSampleName = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_11 == null ? "SampleName Already Exists!!!." : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_11;
        long returnCode = -1;
        string SampleType = "SAMPLE";
        long SampleID = 0;

        Int64.TryParse(((Label)grdSample.Rows[e.RowIndex].FindControl("lblSampleID")).Text, out SampleID);
        string SampleName = ((TextBox)grdSample.Rows[e.RowIndex].FindControl("TxtSample")).Text;
        string SampleCode = ((TextBox)grdSample.Rows[e.RowIndex].FindControl("TxtCode")).Text;

        string Status = (((CheckBox)grdSample.Rows[e.RowIndex].FindControl("chkbox")).Checked ? "Y" : "N");
        ContextInfo.AdditionalInfo = (((CheckBox)grdSample.Rows[e.RowIndex].FindControl("chkbox1")).Checked ? "Y" : "N");
        string SampleDesc = string.Empty;
        Admin_BL = new AdminReports_BL(base.ContextInfo);
        if (SampleCode.Length > 5)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow(" + strSampleCode.Trim() + "," + Alert.Trim() + ");", true);
            //((TextBox)grdSample.Rows[e.RowIndex].FindControl("TxtCode")).Text = string.Empty;
            ((TextBox)grdSample.Rows[e.RowIndex].FindControl("TxtCode")).Focus();
        }
        else
        {
            returnCode = Admin_BL.SaveSampleContainer(OrgID, SampleName, SampleCode, SampleDesc, SampleID, SampleType, Status);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow('" + strChanges.Trim() + "','" + Alert.Trim() + "');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow('" + strSampleName.Trim() + "','" + Alert.Trim() + "');", true);
            }

            LoadSampleContainer();
            Clear(SampleType);
            grdSample.EditIndex = -1;
            LoadSampleContainer();
            Clear(SampleType);
        }
    }
    protected void btnSaveContainer_Click(object sender, EventArgs e)
    {
        string strContainerMin = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_06 == null ? "Container Code should be minimum of 5" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_06;
        string strInvestigationSampleContainer = Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_12 == null ? "InvestigationSampleContainer Added Successfully" : Resources.Investigation_AppMsg.Investigation_ContainerMaster_ascx_12;
        long returnCode = -1;
        string SampleName = txtContainer.Text.Trim() == "" ? string.Empty : txtContainer.Text.Trim();
        string SampleDesc = txtContainerDesc.Text.Trim() == "" ? string.Empty : txtContainerDesc.Text.Trim();
        string SampleCode = txtContainerCode.Text.Trim() == "" ? string.Empty : txtContainerCode.Text.Trim();
        long SampleID = 0;
        if (btnSaveContainer.Text == "Update")
        {
            SampleID = Convert.ToInt64(hdnContainerID.Value);
        }
        string SampleType = "CNTR";
        string Status = "Y";
        Admin_BL = new AdminReports_BL(base.ContextInfo);
        if (SampleCode.Length > 5)
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "UpdateAlert", "ValidationWindow('" + strContainerMin.Trim() + "','" + Alert.Trim() + "');", true);
            txtContainerCode.Focus();
            txtContainerCode.Text = string.Empty;
        }
        else
        {
            returnCode = Admin_BL.SaveSampleContainer(OrgID, SampleName, SampleCode, SampleDesc, SampleID, SampleType, Status);
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "InsertAlert", "ValidationWindow(" + strInvestigationSampleContainer + "," + Alert.Trim() + ");", true);
            LoadSampleContainer();
            Clear(SampleType);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(),"InsertAlert","hi" , true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "InsertAlert", "ValidationWindow('" + strInvestigationSampleContainer + "','" + Alert.Trim() + "');", true);
        }
    }
    protected void grdSample_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void grdSampleContainer_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strUpdate = Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_02 == null ? "Update" : Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_02;
        
        if (e.CommandName.ToString() == "Row_Edit")
        {
            Button lnkEdit = (Button)grdSampleContainer.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lnkEdit");
            Label lblContainerID = (Label)grdSampleContainer.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblContainerID");
            Label lblContainerName = (Label)grdSampleContainer.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblContainerName");
            Label lblContainerCode = (Label)grdSampleContainer.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblContainerCode");
            Label lblDescription = (Label)grdSampleContainer.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("lblDescription");
            hdnContainerID.Value = lblContainerID.Text.Trim();
            txtContainer.Text = lblContainerName.Text.Trim();
            txtContainerDesc.Text = lblDescription.Text.Trim();
            txtContainerCode.Text = lblContainerCode.Text.Trim();
            btnSaveContainer.Text = strUpdate.Trim();
        }
    }
    #endregion

    #region "Methods"
    public void LoadSampleContainer()
    {
        long returnCode = -1;
        Admin_BL = new AdminReports_BL(base.ContextInfo);
        lstInvSampleMaster = new List<InvSampleMaster>();
        lstInvSampleContainer = new List<InvestigationSampleContainer>();
        returnCode = Admin_BL.GetSampleContainer(OrgID, out lstInvSampleMaster, out lstInvSampleContainer);
        if (lstInvSampleMaster.Count() > 0)
        {
            grdSample.DataSource = lstInvSampleMaster;
            grdSample.DataBind();
            //for (int i = 0; i < lstInvSampleMaster.Count(); i++)
            //{
            //    if (lstInvSampleMaster[i].Code.Trim() != "")
            //    {
            //        hdnSapmleCode.Value += lstInvSampleMaster[i].Code.Trim() + "~" + lstInvSampleMaster[i].SampleCode + "^";
            //    }
            //}
        }
        if (lstInvSampleContainer.Count() > 0)
        {
            grdSampleContainer.DataSource = lstInvSampleContainer;
            grdSampleContainer.DataBind();
            //for (int i = 0; i < lstInvSampleContainer.Count(); i++)
            //{
            //    if (lstInvSampleContainer[i].Code.Trim() != "")
            //    {
            //        hdnContainerCode.Value += lstInvSampleContainer[i].Code.Trim() + "~" + lstInvSampleContainer[i].SampleContainerID + "^";
            //    }
            //}
        }
    }
    public void Clear(string obj)
    {
        string strSave = Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_03 == null ? "Save" : Resources.Investigation_ClientDisplay.Investigation_ContainerMaster_aspx_03;
        
        if (obj.Split('~')[0] == "CNTR")
        {
            txtContainer.Text = "";
            txtContainerDesc.Text = "";
            txtContainerCode.Text = "";
            hdnContainerID.Value = "0";
            btnSaveContainer.Text = strSave.Trim();
        }
        else
        {
            txtSampleName.Text = "";
            txtSampleCode.Text = "";
            hdnSampleID.Value = "0";
            btnSaveSample.Text = strSave.Trim();
            chkBox2.Checked = false;
        }
    }
    #endregion
}
