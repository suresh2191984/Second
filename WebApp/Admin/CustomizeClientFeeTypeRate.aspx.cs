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
using Attune.Podium.BillingEngine;

public partial class Admin_CustomizeClientFeeTypeRate : BasePage
{
    public Admin_CustomizeClientFeeTypeRate()
        : base("Admin\\CustomizeClientFeeTypeRate.aspx")
    {
    }
    private List<FeeTypeMaster> lstFeeDesc = new List<FeeTypeMaster>();
    private List<FeeTypeMaster> lstFeeType = new List<FeeTypeMaster>();
    private List<RoomType> lstRoomType = new List<RoomType>();
    private List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
    private List<TPAMaster> lstTPAMaster = new List<TPAMaster>();
    List<ClientFeeTypeRateCustomization> lstClientFeeTypeRateDetails = new List<ClientFeeTypeRateCustomization>();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                rdoClient.Checked = true;
                ClearDetailGrid();
                GetAllList();
                LoadClientFeeTypeRateDetails();
                LoadClientFeeTypeRateGroup();
                btnSave.Attributes.Add("OnClick", "return fnSaveValidate()");
                ddlRoomType.Attributes.Add("OnClick", "return fnChkExistingConfig()");
                hdnConfirmation.Value = "true";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in CustomizeClientFeeTypeRate_Page_Load()", ex);
        }
    }

    private void LoadClientFeeTypeRateDetails()
    {
        try
        {
                long returnCode = -1;
                Master_BL objBL = new Master_BL(base.ContextInfo);
                if (rdoClient.Checked && ddlClientTpa.SelectedItem.Value!="0" && ddlRoomType.SelectedItem.Value!="0")
                {
                    returnCode = objBL.GetClientFeeTypeRateDetails(Convert.ToInt64(ddlClientTpa.SelectedItem.Value), Convert.ToInt32(ddlRoomType.SelectedItem.Value), Convert.ToInt32(OrgID), out lstClientFeeTypeRateDetails);
                }
                if (rdoTPA.Checked && ddlTpaId.SelectedItem.Value!="0" && ddlRoomType.SelectedItem.Value!="0")
                {
                    returnCode = objBL.GetClientFeeTypeRateDetails(Convert.ToInt64(ddlTpaId.SelectedItem.Value), Convert.ToInt32(ddlRoomType.SelectedItem.Value), Convert.ToInt32(OrgID), out lstClientFeeTypeRateDetails);
                }
                if (lstClientFeeTypeRateDetails.Count > 0)
                {
                    grdResult.DataSource = lstClientFeeTypeRateDetails;
                    grdResult.DataBind();
                    hdnDiscountID.Value = GetDiscEnhanceType(lstClientFeeTypeRateDetails);
                    hdnApply.Value = GetPerValueType(lstClientFeeTypeRateDetails);
                    AssignDiscEnType();
                    hdnRowCount.Value = grdResult.Rows.Count.ToString();
                    rdoClient.Enabled = false;
                    rdoTPA.Enabled = false;
                    ddlClientTpa.Enabled = false;
                    ddlTpaId.Enabled = false;
                    ddlRoomType.Enabled = false;
                }
                else
                {
                    rdoClient.Enabled = true;
                    rdoTPA.Enabled = true;
                    ddlClientTpa.Enabled = true;
                    ddlTpaId.Enabled = true;
                    ddlRoomType.Enabled = true;
                    ClearDetailGrid();
                }
               // hdnEditClick.Value = "E";
            }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in LoadClientFeeTypeRateDetails()", ex);
        }
    }

    private void AssignDiscEnType()
    {
        try
        {
            int i = 0;
            foreach (string str in hdnDiscountID.Value.Split('~'))
            {
                if (i <= grdResult.Rows.Count - 1)
                {
                    DropDownList ddlSet = (DropDownList)grdResult.Rows[i].Cells[2].FindControl("ddlDiscEn");
                    ddlSet.SelectedValue = str.ToString();
                    i++;
                }

            }
            int j = 0;
            foreach (string str in hdnApply.Value.Split('~'))
            {
                if (j <= grdResult.Rows.Count -1)
                {
                    DropDownList ddlSet = (DropDownList)grdResult.Rows[j].Cells[3].FindControl("DdlAplyby");
                    ddlSet.SelectedValue = str.ToString();
                    j++;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in AssignDiscEnType()", ex);
        }
    }
    
    private string GetDiscEnhanceType(List<ClientFeeTypeRateCustomization> lstDiscEnhanceType)
    {
        string strDiscEnhanceType = string.Empty;
        try
        {
            if (lstDiscEnhanceType.Count > 0)
            {
                foreach (ClientFeeTypeRateCustomization lItem in lstDiscEnhanceType)
                {
                        strDiscEnhanceType += lItem.DiscOrEnhanceType + "~";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in GetDiscEnhanceType()", ex);
        }
        return strDiscEnhanceType;
    }
    private string GetPerValueType(List<ClientFeeTypeRateCustomization> lstDiscEnhanceType)
    {
        string strPerValueType = string.Empty;
        try
        {
            if (lstDiscEnhanceType.Count > 0)
            {
                foreach (ClientFeeTypeRateCustomization lItem in lstDiscEnhanceType)
                {
                    strPerValueType += lItem.Applyby + "~";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in GetDiscEnhanceType()", ex);
        }
        return strPerValueType;
    }

    private void LoadClientFeeTypeRateGroup()
    {
        try
        {
            long returnCode = -1;
            List<ClientFeeTypeRateCustomization> lstClientFeeTypeRateGroup = new List<ClientFeeTypeRateCustomization>();
            Master_BL objBL = new Master_BL(base.ContextInfo);
            returnCode = objBL.GetClientFeeTypeRateGroup(OrgID, out lstClientFeeTypeRateGroup);
            if (lstClientFeeTypeRateGroup.Count>0)
            {
                grdGroup.DataSource = lstClientFeeTypeRateGroup;
                grdGroup.DataBind();
            }
            if (grdGroup.Rows.Count == 0)
            {
                lblGroupHeader.Visible = false;
                hdnGRowCount.Value = "";
            }
            else
            {
                lblGroupHeader.Visible = true;
                hdnGRowCount.Value = grdGroup.Rows.Count.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in LoadClientFeeTypeRateGroup()", ex);
        }
    }

    private void GetAllList()
    {
        try
        {
            long returnCode = -1;
            Master_BL DiscMaster = new Master_BL(base.ContextInfo);
            returnCode = DiscMaster.GetclientTpaRoomFeeTypes(OrgID, out lstFeeDesc, out lstFeeType, out lstRoomType, out lstInvClientMaster, out lstTPAMaster);
            LoadCorporateDDL();
            LoadInsuranceDDL();
            LoadRoomTypeDDL();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in CustomizeClientFeeTypeRate_GetAllList()", ex);
        }
    }

    private void LoadCorporateDDL()
    {
        try
        {
            ddlClientTpa.Items.Clear();
            ddlClientTpa.DataTextField = "ClientName";
            ddlClientTpa.DataValueField = "ClientID";
            ddlClientTpa.DataSource = lstInvClientMaster;
            ddlClientTpa.DataBind();
            ddlClientTpa.Items.Insert(0, "----Select----");
            ddlClientTpa.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in CustomizeClientFeeTypeRate_loadcorporateDDL()", ex);
        }
    }

    private void LoadInsuranceDDL()
    {
        try
        {
            ddlTpaId.Items.Clear();
            ddlTpaId.DataTextField = "TPAName";
            ddlTpaId.DataValueField = "TPAID";
            ddlTpaId.DataSource = lstTPAMaster;
            ddlTpaId.DataBind();
            ddlTpaId.Items.Insert(0, "----Select----");
            ddlTpaId.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in CustomizeClientFeeTypeRate_LoadInsuranceDDL()", ex);
        }
    }

    private void LoadRoomTypeDDL()
    {
        try
        {
            ddlRoomType.Items.Clear();
            ddlRoomType.DataTextField = "RoomTypeName";
            ddlRoomType.DataValueField = "RoomTypeID";
            ddlRoomType.DataSource = lstRoomType;
            ddlRoomType.DataBind();
            ddlRoomType.Items.Insert(0, "----Select----");
            ddlRoomType.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in CustomizeClientFeeTypeRate_LoadRoomTypeDDL()", ex);
        }

    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtPercent = (TextBox)e.Row.FindControl("txtPercent");
                if (txtPercent.Text=="0")
                {
                    txtPercent.Text = "";
                    HiddenField hdnPer = (HiddenField)e.Row.FindControl("hdnPercentDummy");
                    hdnPer.Value = "";
                }
                HiddenField hdnDiscEnDummy = (HiddenField)e.Row.FindControl("hdnDiscEnDummy");
                if (hdnDiscEnDummy.Value == "")
                {
                    hdnDiscEnDummy.Value = "DISC";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error CustomizeFeeTypeRate_grdResult_RowDataBound", ex);
        }
    }

    protected void grdGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                LinkButton lnkEditBtn = (LinkButton)e.Row.FindControl("btnEdit");
                lnkEditBtn.Attributes.Add("onclick", "fnCheckEditing(this.id)");

                //strScript = "fnSetDeleteList(" + objClientFeeTypeRate.ClientID + "," + objClientFeeTypeRate.RoomTypeID + ")";
                //HtmlInputButton objDelBtn = ((HtmlInputButton)e.Row.FindControl("btnDelete"));
                //objDelBtn.Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error CustomizeFeeTypeRate_grdGroup_RowDataBound", ex);
        }

    }
    protected void ddlClientTpa_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rdoClient.Checked)
            {
                trTpaId.Style.Add("display", "none");
                trClient.Style.Add("display", "block");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ddlClientTpa_SelectedIndexChanged Event()", ex);
        }
    }
    protected void ddlTpaId_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (rdoTPA.Checked || (!rdoClient.Checked && !rdoTPA.Checked))
            {
                trTpaId.Style.Add("display", "block");
                trClient.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ddlTpaId_SelectedIndexChanged Event()", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            List<ClientFeeTypeRateCustomization> lstClientFeeTypeRateCust = new List<ClientFeeTypeRateCustomization>();
            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblServiceType = new Label();
                TextBox txtPercentage = new TextBox();
                DropDownList ddlPerType = new DropDownList();
                 DropDownList ObjDdlApply = new DropDownList();

                lblServiceType = (Label)row.FindControl("hdnFeeType");
                txtPercentage = (TextBox)row.FindControl("txtPercent");
                ddlPerType = (DropDownList)row.FindControl("ddlDiscEn");
                ObjDdlApply = (DropDownList)row.FindControl("DdlAplyby");

                if (txtPercentage.Text != "")
                {
                    ClientFeeTypeRateCustomization objNewRateDetails = new ClientFeeTypeRateCustomization();
                    if (rdoClient.Checked)
                    {
                        objNewRateDetails.ClientID = Convert.ToInt64(ddlClientTpa.SelectedItem.Value);
                        objNewRateDetails.ClientType = "CLIENT";
                    }
                    else
                    {
                        objNewRateDetails.ClientID = Convert.ToInt64(ddlTpaId.SelectedItem.Value);
                        objNewRateDetails.ClientType = "TPA";
                    }
                    objNewRateDetails.RoomTypeID = Convert.ToInt32(ddlRoomType.SelectedItem.Value);
                    objNewRateDetails.FeeType = lblServiceType.Text;
                    objNewRateDetails.DiscOrEnhancePercent = Convert.ToDecimal(txtPercentage.Text);
                    objNewRateDetails.DiscOrEnhanceType = ddlPerType.SelectedValue;
                    objNewRateDetails.Applyby = ObjDdlApply.SelectedValue;
                    lstClientFeeTypeRateCust.Add(objNewRateDetails);
                }
            }
            returnCode = new BillingEngine(base.ContextInfo).pInsUpdateClientFeeTypeRateCustomize(lstClientFeeTypeRateCust, OrgID);
            if (returnCode != -1)
            {
                string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_1";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('"+sPath+"');", true);
                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('Saved Successfully.');", true);
                LoadClientFeeTypeRateGroup();
                hdnEditClick.Value = "";
                EnableAllEdit();
                DisableNewEditBtn();
            }
            else
            {
                string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_2";
                ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('"+sPath+"');", true);
                //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('There was a problem while saving the details, Please contact system administrator.');", true);
                hdnEditClick.Value = "E";
            }
        }
        catch (SqlException sqlex)
        {
            string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_3";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('"+sPath+"');", true);
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('There was a problem while saving the details, Please contact system administrator.');", true);
            CLogger.LogError("Error btnSave_Click()", sqlex);
        }
        catch (Exception ex)
        {
            string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_4";
            ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('" + sPath + "');", true);
            //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('There was a problem while saving the details, Please contact system administrator.');", true);
            CLogger.LogError("Error btnSave_Click()", ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
            }
            LoadClientFeeTypeRateDetails();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in grdResult_PageIndexChanging()", ex);
        }
    }

    protected void grdGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
            }
            LoadClientFeeTypeRateGroup();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in grdGroup_PageIndexChanging()", ex);
        }
    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        try
        {
            ClearAll();
            EnableAllEdit();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in btnClear_Click()", ex);
        }
    }

    private void ClearAll()
    {
        try
        {
            rdoClient.Checked = true;
            rdoTPA.Checked = false;
            trTpaId.Style.Add("display", "none");
            trClient.Style.Add("display", "block");
            ClearDetailGrid();
            hdnDiscountID.Value = "";
            hdnApply.Value = "";
            hdnRowCount.Value = "";
            if (grdGroup.Rows.Count > 0)
            {
                hdnGRowCount.Value = grdGroup.Rows.Count.ToString();
            }
            else
            {
                hdnGRowCount.Value = "";
            }
            hdnEditClick.Value = "";
            rdoClient.Enabled = true;
            rdoTPA.Enabled = true;
            ddlClientTpa.Enabled = true;
            ddlTpaId.Enabled = true;
            ddlRoomType.Enabled = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in ClearAll() ", ex);
        }
    }

    private void ClearDetailGrid()
    {
        try
        {
            int i = 0;
            foreach (GridViewRow row in grdResult.Rows)
            {
                TextBox txtPercentage = new TextBox();
                DropDownList ddlPerType = new DropDownList();
                Label lblGridClean = new Label();
                HiddenField hdnFld1 = new HiddenField();

                if (i <= grdResult.Rows.Count - 1)
                {
                    txtPercentage = (TextBox)grdResult.Rows[i].Cells[1].FindControl("txtPercent");
                    txtPercentage.Text = "";
                    hdnFld1 = (HiddenField)grdResult.Rows[i].Cells[2].FindControl("hdnDiscEnDummy");
                    hdnFld1.Value = "";
                    hdnFld1 = (HiddenField)grdResult.Rows[i].Cells[2].FindControl("hdnPercentDummy");
                    hdnFld1.Value = "";
                    ddlPerType = (DropDownList)grdResult.Rows[i].Cells[2].FindControl("ddlDiscEn");
                    ddlPerType.SelectedValue = "DISC";
                    lblGridClean = (Label)grdResult.Rows[i].Cells[3].FindControl("hdnClientType");
                    lblGridClean.Text = "";
                    lblGridClean = (Label)grdResult.Rows[i].Cells[4].FindControl("hdnClientId");
                    lblGridClean.Text = "";
                    lblGridClean = (Label)grdResult.Rows[i].Cells[5].FindControl("hdnRoomTypeId");
                    lblGridClean.Text = "";
                    i++;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in ClearDetailGrid()", ex);
        }
    }

    private void EnableAllEdit()
    {
        try
        {
            int i = 0;
            foreach (GridViewRow row in grdGroup.Rows)
            {
                LinkButton lnkEditBtn = new LinkButton();

                if (i <= grdGroup.Rows.Count - 1)
                {
                    lnkEditBtn = (LinkButton)grdGroup.Rows[i].Cells[2].FindControl("btnEdit");
                    lnkEditBtn.Enabled = true;
                    i++;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in EnableAllEdit()", ex);
        }
    }

    private void DisableNewEditBtn()
    {
        try
        {
            Int64 intClientId=0;
            Int64 intRoomTypeId=0;
            intRoomTypeId = Convert.ToInt64(ddlRoomType.SelectedItem.Value);
            if (rdoClient.Checked)
            {
                intClientId = Convert.ToInt64(ddlClientTpa.SelectedItem.Value);
            }
            if (rdoTPA.Checked)
            {
                intClientId = Convert.ToInt64(ddlTpaId.SelectedItem.Value);
            }

            int i = 0;
            foreach (GridViewRow row in grdGroup.Rows)
            {
                HiddenField hdnClientId = (HiddenField)grdGroup.Rows[i].Cells[0].FindControl("hdnClientId");
                HiddenField hdnRoomTypeId = (HiddenField)grdGroup.Rows[i].Cells[0].FindControl("hdnRoomTypeId");
                LinkButton lnkEditBtn = new LinkButton();

                if (i <= grdGroup.Rows.Count - 1)
                {
                    if (Convert.ToInt64(hdnClientId.Value) == intClientId && Convert.ToInt64(hdnRoomTypeId.Value) == intRoomTypeId)
                    {
                        lnkEditBtn = (LinkButton)grdGroup.Rows[i].Cells[2].FindControl("btnEdit");
                        lnkEditBtn.Enabled = false;
                    }
                    i++;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in EnableAllEdit()", ex);
        }
    }

    protected void ddlRoomType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if (hdnConfirmation.Value == "true")
            {

                if (rdoClient.Checked && ddlClientTpa.SelectedItem.Value != "0" && ddlRoomType.SelectedItem.Value != "0"
                    || rdoTPA.Checked && ddlTpaId.SelectedItem.Value != "0" && ddlRoomType.SelectedItem.Value != "0")
                {
                    LoadClientFeeTypeRateDetails();
                }
                else
                {
                    if (rdoClient.Checked == true)
                    {
                        string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_5";
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('"+sPath+"');", true);
                        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('Select Corporate & Room Type');", true);
                    }
                    else
                    {
                        string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_6";
                        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:ShowAlertMsg('"+sPath+"');", true);
                        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), Guid.NewGuid().ToString(), "javascript:alert('Select Insurance/TPA & Room Type');", true);
                    }
                }
                if (rdoTPA.Checked || (!rdoClient.Checked && !rdoTPA.Checked))
                {
                    trTpaId.Style.Add("display", "block");
                    trClient.Style.Add("display", "none");
                }

                if (rdoClient.Checked)
                {
                    trTpaId.Style.Add("display", "none");
                    trClient.Style.Add("display", "block");
                }
            }
            else
            {
                ClearDetailGrid();
                if (grdResult.Rows.Count - 1 > 0)
                {
                    rdoClient.Enabled = false;
                    rdoTPA.Enabled = false;
                    ddlClientTpa.Enabled = false;
                    ddlTpaId.Enabled = false;
                    ddlRoomType.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnShow_Click Event()", ex);
        }
    }

    protected void grdGroup_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
         try
        {
            Label lblClientId = (Label)grdGroup.Rows[e.RowIndex].FindControl("hdnClientId");
            Label lblRoomTypeId = (Label)grdGroup.Rows[e.RowIndex].FindControl("hdnRoomTypeId");
            long returnCode = -1;
            returnCode = new Master_BL(base.ContextInfo).DeleteClientFeeTypeRate(Convert.ToInt64(lblClientId.Text), Convert.ToInt32(lblRoomTypeId.Text));
            if (returnCode > 0)
            {
                string sPath = "Admin\\\\CustomizeClientFeeTypeRate.aspx.cs_7";
                ClientScript.RegisterStartupScript(this.GetType(), "delete", "ShowAlertMsg('"+sPath+"');", true);
                //ClientScript.RegisterStartupScript(this.GetType(), "delete", "alert('Deleted successfully');", true);
            }
            LoadClientFeeTypeRateDetails();
            LoadClientFeeTypeRateGroup();
        }
         catch (Exception ex)
         {
             CLogger.LogError("Error in grdGroup_RowDeleting Event()", ex);
         }
    }

    protected void grdGroup_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdGroup.Rows[e.NewEditIndex];
            HiddenField hdnClientId = (HiddenField)gvr.Controls[0].FindControl("hdnClientId");
            HiddenField hdnRoomTypeId = (HiddenField)gvr.Controls[0].FindControl("hdnRoomTypeId");
            HiddenField hdnClientType = (HiddenField)gvr.Controls[0].FindControl("hdnClientType");

            EnableAllEdit();
            LinkButton lnkEdit = (LinkButton)gvr.Controls[0].FindControl("btnEdit");
            lnkEdit.Enabled = false;

            if (hdnClientType.Value == "CLIENT")
            {
                rdoClient.Checked = true;
                rdoTPA.Checked = false;
                ddlClientTpa.SelectedValue = hdnClientId.Value;
                trTpaId.Style.Add("display", "none");
                trClient.Style.Add("display", "block");
            }
            else
            {
                rdoTPA.Checked = true;
                rdoClient.Checked = false;
                ddlTpaId.SelectedValue = hdnClientId.Value;
                trTpaId.Style.Add("display", "block");
                trClient.Style.Add("display", "none");
            }
            ddlRoomType.SelectedValue = hdnRoomTypeId.Value;
            hdnEditClick.Value = "E";
            hdnConfirmation.Value = "true";
            LoadClientFeeTypeRateDetails();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdGroup_RowEditing Event()", ex);
        }
    }
}
