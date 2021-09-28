using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data.SqlClient;
using System.Xml;

public partial class Admin_ReasonMaster : BasePage
{
    public Admin_ReasonMaster() : base("Admin_ReasonMaster_aspx") { }
    string success_message = Resources.Admin_AppMsg.Admin_ReasonMaster_Save_Message;
    string Succ_Mapping_messge = Resources.Admin_AppMsg.Admin_ReasonMaster_succ;
    string InActive = Resources.ClientSideDisplayTexts.Admin_ReasonMaster_InActive;
    string Active = Resources.ClientSideDisplayTexts.Admin_ReasonMaster_Active;
    string strAlert = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        strAlert = Resources.Admin_AppMsg.Admin_ReasonMaster_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_ReasonMaster_aspx_Alert;
        try
        {
           // gvwReasons.Visible = false;
            if (!IsPostBack)
            {
                LoadReasonCategory();
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ReasonMaster Page_Load()", ex);
        }
    }
    private void LoadReasonCategory()
    {
        try
        {
            long returncode = -1;
            string domains = "Reason Category,";
            string[] Tempdata = domains.Split(',');
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping (lstmetadataInput,OrgID ,LanguageCode , out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "Reason Category"
                                     orderby child.MetaDataID ascending
                                     select child;
                    ddlCategory.DataSource = childItems;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.SelectedValue = "0";
                    ddlCategory.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ReasonMaster LoadReasonCategory()", ex);
        }
gvwReasons.Visible = false;
    }
    private void LoadReasonType()
    {

        string strSelect = Resources.Admin_AppMsg.Admin_ReasonMaster_aspx_09 == null ? "--Select--" : Resources.Admin_AppMsg.Admin_ReasonMaster_aspx_09;
        try
        {
            long returnCode = -1;
            List<ReasonType> lstReasonType = new List<ReasonType>();
            Master_BL objReasonType = new Master_BL(base.ContextInfo);
            returnCode = objReasonType.GetReasonTypes(Convert.ToInt16(ddlCategory.SelectedItem.Value), out lstReasonType);
            ddlType.DataSource = lstReasonType;
            ddlType.DataValueField = "TypeID";
            ddlType.DataTextField = "DisplayText";
            ddlType.DataBind();

           // ddlType.Items.Insert(0, "---Select---");
           ddlType.Items.Insert(0,strSelect);

            ddlType.Items[0].Value = "-1";
            //hdnCouponID.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ReasonMaster LoadReasonType()", ex);
        }
    }
    private void LoadReasonList()
    {
        try
        {
            if (ddlCategory.SelectedItem.Value != "-1" && ddlType.SelectedItem.Value != "-1")
            {
                long returnCode = -1;
                string ReasonCode = string.Empty;
                List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
                Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
                returnCode = objReasonMaster.GetReasonMaster(Convert.ToInt16(ddlCategory.SelectedItem.Value), Convert.ToInt32(ddlType.SelectedItem.Value), ReasonCode, out lstReasonMaster);
                if (lstReasonMaster.Count > 0)
                {
                    for (int i = 0; i < lstReasonMaster.Count; i++)
                    {
                        if (lstReasonMaster[i].Status == "Active")
                        {
                            lstReasonMaster[i].Status = Active;
                        }
                        else if (lstReasonMaster[i].Status == "InActive")
                        {
                            lstReasonMaster[i].Status = InActive;
                        }
                    }
                }
                gvwReasons.DataSource = lstReasonMaster;
                gvwReasons.DataBind();
                if (lstReasonMaster.Count > 0)
                {
                    lblStatus.Visible = false;
                    gvwReasons.Visible = true;
                }
                else
                {
                    lblStatus.Visible = true;
                    gvwReasons.Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ReasonMaster LoadReasonList()", ex);
        }
    }
    private void SaveReason()
    {
        try
        {

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ReasonMaster SaveReason()", ex);
        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            //ddlType.SelectedItem.Value = 0;
            //txtReasonCode.Text = "";
            //txtReason.Text = "";
            gvwReasons.Visible = false;
            LoadReasonType();
                txtReasonCode.Text = "";
                txtReason.Text = "";
                ExtCmt.Text = "";
         
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ddlCategory_SelectedIndexChanged()", ex);
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedItem.Value != "-1" && ddlType.SelectedItem.Value != "-1")
            {
                LoadReasonList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_ddlType_SelectedIndexChanged()", ex);
        }
    }
    protected void btnShow_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlCategory.SelectedItem.Value != "-1" && ddlType.SelectedItem.Value != "-1")
            {
                LoadReasonList();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_btnShow_Click()", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            string strSaveUpdate = string.Empty;
            string strResult = "";

            if (hdnReasonID.Value == "")
            {
                strSaveUpdate = "S";
                returncode = objMaster_BL.SaveReasonMaster(-1, Convert.ToInt32(ddlType.SelectedItem.Value), txtReason.Text.ToString(), txtReasonCode.Text.ToString(), "A", LID, "S", out strResult, ExtCmt.Text.ToString());

                if (strResult.Trim() != "")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strResult + "','"+strAlert+"');", true);
                    txtReasonCode.Focus();
                    return;
                }
                
                if (ddlCategory.SelectedItem.Value != "-1" && ddlType.SelectedItem.Value != "-1")
                {
                    LoadReasonList();
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + success_message + "','" + strAlert + "');", true);
            }
            else
            {
                strSaveUpdate = "U";
                string strStatus = string.Empty;
                if (chkActive.Checked)
                {
                    strStatus = "A";
                }
                else
                {
                    strStatus = "D";
                }
                returncode = objMaster_BL.SaveReasonMaster(Convert.ToInt64(hdnReasonID.Value), Convert.ToInt32(ddlType.SelectedItem.Value), txtReason.Text.ToString(), txtReasonCode.Text.ToString(), strStatus, LID, "U", out strResult, ExtCmt.Text.ToString());
                if (ddlCategory.SelectedItem.Value != "-1" && ddlType.SelectedItem.Value != "-1")
                {
                    LoadReasonList();
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + success_message + "','"+strAlert+"');", true);
            }
            txtReasonCode.Text = "";
            txtReason.Text = "";
            chkActive.Checked = false;
            hdnReasonID.Value = "";
            ExtCmt.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Admin_btnSave_Click()", ex);
        }
        finally
        {
            gvwReasons.Visible = true;

        }
    }
    protected void gvwReasons_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvwReasons.PageIndex = e.NewPageIndex;
                btnShow_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while changing page index", ex);
        }
    }
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Admin_btnCancel_Click()", ex);
    //    }
    //}
    protected void gvwReasons_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<ReasonMaster> tempList = new List<ReasonMaster>();
                ReasonMaster IOM = (ReasonMaster)e.Row.DataItem;
                CheckBox chk = (CheckBox)e.Row.FindControl("Chkselect");
                chk.Attributes.Add("onclick", "javascript:onchangesData();");
                if (IOM.SequenceNo > 0)
                {
                    chk.Checked=true;
                }
                if (IOM.Status == InActive)
                {
                    chk.Enabled = false;
                }
                else
                {
                    chk.Enabled = true;
                 
                }
                if (chk.Checked)
                {
                    e.Row.CssClass = "grvcolor";    
                }
               
                e.Row.Attributes["onmouseover"] = "javascript:SetMouseOver(this)";
                e.Row.Attributes["onmouseout"] = "javascript:SetMouseOut(this)";
            } 
        }

        catch (Exception Ex)
        {

        }
    }
    protected void btnIsMapped_Click(object sender, EventArgs e)
    {


        Master_BL objbl = new Master_BL(base.ContextInfo); ;

        List<TaskActionOrgMapping> lsttaskorgmap = new List<TaskActionOrgMapping>();
        foreach (GridViewRow row2 in gvwReasons.Rows)
        {
            row2.CssClass = "";
            CheckBox chkSel = (CheckBox) row2.FindControl("Chkselect");
            if (chkSel.Checked)
            {
                HiddenField hdn = (HiddenField)row2.FindControl("hdnselect");
                row2.CssClass = "grvcolor";
                lsttaskorgmap.Add(new TaskActionOrgMapping()
                            {
                                OrgID = OrgID,
                                TaskActionID=Convert.ToInt32(ddlType.SelectedItem.Value),
                                RoleID=Convert.ToInt64(hdn.Value)
                            }  
                    );
            }
           
        }
        objbl.SaveAndDeleteReasonMapping("", lsttaskorgmap, OrgID, Convert.ToInt32(ddlType.SelectedItem.Value));
        
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + Succ_Mapping_messge + "','"+strAlert+"');", true);
      
        gvwReasons.Visible = false;
    }
}
