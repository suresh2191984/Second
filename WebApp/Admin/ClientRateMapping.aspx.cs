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

public partial class Admin_ClientRateMapping : BasePage
{
    public Admin_ClientRateMapping()
        : base("Admin_ClientRateMapping_aspx")
    {
    }
    Patient_BL Patient_BL;
    List<InvClientType> lstInvClientType;
    List<InvClientMaster> lstInvClientMaster;
    List<InvClientMaster> lstInvClientRate;
    List<ReasonMaster> lstReasonMaster;
    Master_BL objReasonMaster;
    int ShowExpired = 0;
    string Reftypes = "CMR";
    string strSave = string.Empty;
    string Usrupdate = string.Empty;
    string UsrNotmapmsg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
         strSave = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_04 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_04;
         Usrupdate = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_05 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_05;
         UsrNotmapmsg = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_06 == null ? "Since the rate card's are not mapped for this client..!" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_06;
        Patient_BL = new Patient_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            ddlTrustedOrg.Focus();
            LoadTrustedOrgDetails();
            //GetClientType();
            GetGroupValues();
            chkSelectAll.Style.Add("display", "block");
            chkSelectAll.Checked = false;
            divChkList.Style.Add("display", "none");
            btnLoadGrid.Style.Add("display", "none");
            loadFromtime();
            loadTotime();
            ddlTrustedOrg_SelectedIndexChanged(sender, e);
            if (ddlTrustedOrg.Items.FindByValue(OrgID.ToString()) != null)
            {
                ddlTrustedOrg.SelectedValue = OrgID.ToString();
            }
            loadReasonDetails();
            LoadMetaData();
            txtValidFrom.Attributes.Add("readonly", "readonly");
            txtValidTo.Attributes.Add("readonly", "readonly");
        }
        txtValidFrom.Attributes.Add("onchange", "validateFrom('" + txtValidFrom.ClientID.ToString() + "','" + txtValidTo.ClientID.ToString() + "');");
        txtValidTo.Attributes.Add("onchange", "ValidDate('" + txtValidFrom.ClientID.ToString() + "','" + txtValidTo.ClientID.ToString() + "','txtValidFrom',0,0);");

        //   AutoCompleteExtender1.ContextKey = ddlClientType.SelectedValue;
    }

    void loadReasonDetails()
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01;

        long returnCode = -1;
        lstReasonMaster = new List<ReasonMaster>();
        objReasonMaster = new Master_BL(base.ContextInfo);
        returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);
       
        if (lstReasonMaster.Count > 0)
        {
            string setID = "0";
            ddlReason.DataSource = lstReasonMaster;
            ddlReason.DataTextField = "Reason";
            ddlReason.DataValueField = "Reason";
            ddlReason.DataBind();
            //ddlReason.Items.Insert(0, "--Select--");
            ddlReason.Items.Insert(0, strSelect);
            ddlReason.Items[0].Value = "0";
            ddlReason.SelectedValue = setID;
        }
    }
    public void loadFromtime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddlFrom.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }

    public void loadTotime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddlTo.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }
    public void LoadTrustedOrgDetails()
    {
        string strOrg = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_02 == null ? "---Select Organisation---" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_02;

        try
        {
            List<Organization> lstorgn = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstorgn);
            ddlTrustedOrg.DataSource = lstorgn;
            ddlTrustedOrg.DataTextField = "Name";
            ddlTrustedOrg.DataValueField = "OrgID";
            ddlTrustedOrg.DataBind();
            //ddlTrustedOrg.Items.Insert(0, "---Select Organisation---");
            ddlTrustedOrg.Items.Insert(0, strOrg);
            ddlTrustedOrg.Items[0].Value = "0";         

            
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    public void GetAllClients()
    {
        int cnt = 1;
        try
        {
            lstInvClientMaster = new List<InvClientMaster>();
            if (ddlClientType.SelectedValue != "0" && ddlTrustedOrg.SelectedValue != "0")
            {

                Master_BL Master_BL = new Master_BL(base.ContextInfo);
                Master_BL.GetClientList(int.Parse(ddlTrustedOrg.SelectedValue), "", int.Parse(ddlClientType.SelectedValue), out lstInvClientMaster);
            }
            chkClientList.DataSource = lstInvClientMaster.OrderBy(p => p.ClientCode);
            chkClientList.DataTextField = "ClientName";
            chkClientList.DataValueField = "ClientCode";
            chkClientList.DataBind();

            foreach (ListItem item in chkClientList.Items)
            {
                if (item.Value.ToUpper() == "GENERAL")
                {
                    item.Enabled = false;
                }
                item.Attributes.Add("onclick", "return fnCheckClients('" + lstInvClientMaster.Find(p => p.ClientID == int.Parse(item.Value)).ClientAttributes + "," + item.Value + "');");
            }
            if (chkClientList.Items.Count > 0)
            {
                cnt = chkClientList.Items.Count;
            }
            AdjustTableHeight(chkClientList.Items.Count);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get All Clients", ex);
        }
    }
    public void GetClientType()
    {
        string strMsel = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_03 == null ? "---------Select---------" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_03;

        long returnCode = -1;
        try
        {
            returnCode = Patient_BL.GetInvClientType(out lstInvClientType);
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType.FindAll(p => p.IsInternal == "N");
                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ListItem lstItem = new ListItem();
                //lstItem.Text = "---------Select---------";
                lstItem.Text = strMsel;
                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            EnableAllEdit();
            long returnCode = -1;
            InvClientMaster objInvClientMaster = new InvClientMaster();
            List<InvClientMaster> lstCMaster = new List<InvClientMaster>();
            int ClientID = Convert.ToInt32(hdnClientID.Value);
            int RateID = Convert.ToInt32(hdnRateID.Value);
            int ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            string Reason = "";
            DateTime FromDate = Convert.ToDateTime("01/01/1753");
            DateTime ToDate = Convert.ToDateTime("31/12/9999");
            DateTime FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
            DateTime ToTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
            if (hdnClientCode.Value.Trim().ToUpper() != "GENERAL" || hdnRateCode.Value.Trim().ToUpper() != "GENERAL")
            {
                if (txtValidFrom.Text.Trim() != "")
                {
                    FromDate = Convert.ToDateTime(txtValidFrom.Text + " " + TimeSpan.Parse(FromTime.ToShortTimeString()));
                }
                if (txtValidTo.Text.Trim() != "")
                {
                    ToDate = Convert.ToDateTime(txtValidTo.Text + " " + TimeSpan.Parse(ToTime.ToShortTimeString()));
                }
            }
            long ClientMappingDetailsID = 0;
            txtClientName.Enabled = true;
            //txtRateCard.Enabled = true;
            txtValidFrom.Enabled = true;
            if (chkSelectAll.Checked == false)
            {
                string Ratetype = string.Empty;
                returnCode = Patient_BL.GetClientRateMappingItems(OrgID, ClientID, RateID, ClientTypeID, FromDate, ToDate, out lstInvClientRate, out lstCMaster);
                if (lstInvClientRate.Count > 0)
                {
                    string Type = string.Empty;
                    if (hdnMappingDetailsID.Value != "0")
                    {
                        Type = lstInvClientRate.Find(p => p.ClientMappingDetailsID == Convert.ToInt64(hdnMappingDetailsID.Value)).Type;

                    }
                    lstInvClientRate.RemoveAll(p => p.ClientMappingDetailsID == Convert.ToInt64(hdnMappingDetailsID.Value));
                    if (lstInvClientRate.Count > 0)
                    {
                        ClientTypeID = lstInvClientRate[0].ClientTypeID;
                        ClientMappingDetailsID = Convert.ToInt64(hdnMappingDetailsID.Value);
                        objInvClientMaster = new InvClientMaster();
                        objInvClientMaster.TransferRate = ChkInvRateID.Checked ? "Y" : "N";
                        objInvClientMaster.BaseRate = ChkBaserate.Checked ? "Y" : "N";
                        objInvClientMaster.ClientName = txtClientName.Text;
                        objInvClientMaster.RateName = txtRateCard.Text;
                        objInvClientMaster.ValidFrom = hdnClientCode.Value.ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("01/01/1753") : FromDate;
                        objInvClientMaster.ValidTo = hdnClientCode.Value.ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("31/12/9999") : ToDate;
                        objInvClientMaster.ClientID = Convert.ToInt64(ClientID);
                        objInvClientMaster.RateId = RateID;
                        objInvClientMaster.Priority = Convert.ToInt32(hdnpriorityid.Value);
                        objInvClientMaster.ClientTypeID = ClientTypeID;
                        objInvClientMaster.ClientMappingDetailsID = ClientMappingDetailsID;
                        if (hdnMappingDetailsID.Value != "0")
                        {
                            objInvClientMaster.Type = Type;
                        }
                        else
                        {
                            objInvClientMaster.Type = lstInvClientRate[0].Type;
                        }
                        lstInvClientRate.Add(objInvClientMaster);
                        //gvReckon.DataSource = lstInvClientRate.OrderBy(p => p.ClientMappingDetailsID);
                        gvReckon.DataSource = lstInvClientRate.OrderBy(p => p.Priority);
                        gvReckon.DataBind();
                        loaddata(lstInvClientRate.OrderBy(p => p.ClientMappingDetailsID).ToList());
                        ModalPopupExtender1.Show();
                    }
                    else
                    {
                        GetMappedDetails();
                        //ddlClientType_SelectedIndexChanged(sender, e);
                        GetSelectedValues();
                    }
                }
                else
                {
                    GetMappedDetails();
                    //ddlClientType_SelectedIndexChanged(sender, e);
                    GetSelectedValues();
                }
            }
            else
            {
                lstInvClientMaster = new List<InvClientMaster>();
                objInvClientMaster = new InvClientMaster();
                int CTypeID = 0;
                objInvClientMaster.TransferRate = ChkInvRateID.Checked ? "Y" : "N";
                objInvClientMaster.BaseRate = ChkBaserate.Checked ? "Y" : "N";
                int CID = Convert.ToInt32(hdnClientID.Value);
                int RID = Convert.ToInt32(hdnRateID.Value);
                if (ddlClientType.SelectedValue != "0")
                {
                    CTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
                }
                DateTime FDate = Convert.ToDateTime("01/01/1753");
                DateTime TDate = Convert.ToDateTime("31/12/9999");
                if (hdnClientCode.Value.Trim().ToUpper() != "GENERAL" || hdnRateCode.Value.Trim().ToUpper() != "GENERAL")
                {
                    if (txtValidFrom.Text.Trim() != "")
                    {
                        FDate = Convert.ToDateTime(txtValidFrom.Text);
                    }
                    if (txtValidTo.Text.Trim() != "")
                    {
                        TDate = Convert.ToDateTime(txtValidTo.Text);
                    }
                }
                if (chkSelectAll.Checked)
                {
                    foreach (ListItem item in chkClientList.Items)
                    {
                        if (item.Selected)
                        {
                            objInvClientMaster = new InvClientMaster();
                            objInvClientMaster.TransferRate = ChkInvRateID.Checked ? "Y" : "N";
                            objInvClientMaster.BaseRate = ChkBaserate.Checked ? "Y" : "N";
                            objInvClientMaster.ClientName = item.Text;
                            objInvClientMaster.RateName = txtRateCard.Text;
                            objInvClientMaster.ValidFrom = item.Value.Trim().ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("01/01/1753") : FDate;
                            objInvClientMaster.ValidTo = item.Value.Trim().ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("31/12/9999") : TDate;
                            objInvClientMaster.ClientID = Convert.ToInt64(item.Value);
                            objInvClientMaster.RateId = RID;
                            objInvClientMaster.ClientTypeID = CTypeID;
                            objInvClientMaster.Interval = 1;
                            objInvClientMaster.ClientMappingDetailsID = 0;
                            FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
                            objInvClientMaster.ValidFromTime = TimeSpan.Parse(FromTime.ToShortTimeString());
                            ToTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
                            objInvClientMaster.ValidToTime = TimeSpan.Parse(ToTime.ToShortTimeString());
                            lstInvClientMaster.Add(objInvClientMaster);
                        }
                    }
                }
                if (ddlReason.SelectedValue != "0")
                {
                    Reason = ddlReason.SelectedItem.ToString();
                }
                ModalPopupExtender1.Hide();
                returnCode = Patient_BL.SaveClientRateMappingDetail(OrgID, ClientTypeID, ClientID, RateID, lstInvClientMaster, LID,Reason);
                //ddlClientType_SelectedIndexChanged(sender, e);
                GetSelectedValues();
                gvReckon.DataSource = null;
                gvReckon.DataBind();
                Clear();
                hdnClientID.Value = "0";
                btnAdd.Text = "Save";
                chkSelectAll.Style.Add("display", "block");
            }
            ddlratetype.SelectedValue = "0";
            ddlClientType_SelectedIndexChanged(sender,e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get ClientRateMappingItems", ex);
        }
    }
    public void GetMappedDetails()
    {
        long returnCode = -1;
        lstInvClientMaster = new List<InvClientMaster>();
        InvClientMaster objInvClientMaster = new InvClientMaster();
        string Reason = "";
        int CTypeID = 0;
        int CID = Convert.ToInt32(hdnClientID.Value);
        int RID = Convert.ToInt32(hdnRateID.Value);
        if (ddlClientType.SelectedValue != "0")
        {
            CTypeID = Convert.ToInt32(hdnClientTypeID.Value);
        }
        DateTime FDate = Convert.ToDateTime("01/01/1753");
        DateTime TDate = Convert.ToDateTime("31/12/9999");
        if (hdnClientCode.Value.Trim().ToUpper() != "GENERAL" || hdnRateCode.Value.Trim().ToUpper() != "GENERAL")
        {
            if (txtValidFrom.Text.Trim() != "")
            {
                FDate = Convert.ToDateTime(txtValidFrom.Text);
            }
            if (txtValidTo.Text.Trim() != "")
            {
                TDate = Convert.ToDateTime(txtValidTo.Text);
            }
        }
        objInvClientMaster.TransferRate = ChkInvRateID.Checked ? "Y" : "N";
        objInvClientMaster.BaseRate = ChkBaserate.Checked ? "Y" : "N";
        objInvClientMaster.ClientName = txtClientName.Text;
        objInvClientMaster.RateName = txtRateCard.Text;
        objInvClientMaster.ValidFrom = hdnClientCode.Value.ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("01/01/1753") : FDate;
        objInvClientMaster.ValidTo = hdnClientCode.Value.ToUpper() == "GENERAL" && hdnRateCode.Value.ToUpper() == "GENERAL" ? Convert.ToDateTime("31/12/9999") : TDate;
        objInvClientMaster.ClientID = Convert.ToInt64(CID);
        objInvClientMaster.RateId = RID;
        objInvClientMaster.ClientTypeID = CTypeID;
        objInvClientMaster.Interval = 1;
        objInvClientMaster.ClientMappingDetailsID = btnAdd.Text == strSave ? 0 : Convert.ToInt64(hdnMappingDetailsID.Value);
        DateTime FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
        objInvClientMaster.ValidFromTime = TimeSpan.Parse(FromTime.ToShortTimeString());
        DateTime ToTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
        objInvClientMaster.ValidToTime = TimeSpan.Parse(ToTime.ToShortTimeString());
        lstInvClientMaster.Add(objInvClientMaster);
        if (ddlReason.SelectedValue != "0")
        {
            Reason = ddlReason.SelectedItem.ToString();
        }
        returnCode = Patient_BL.SaveClientRateMappingDetail(OrgID, CTypeID, CID, RID, lstInvClientMaster, LID, Reason);
        gvReckon.DataSource = null;
        gvReckon.DataBind();
        Clear();
        //btnAdd.Text = "Save";
        btnAdd.Text = strSave;
        chkSelectAll.Style.Add("display", "block");
        ModalPopupExtender1.Hide();
    }
    protected void grdClientRateMapping_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdClientRateMapping.PageIndex = e.NewPageIndex;
            //ddlClientType_SelectedIndexChanged(sender, e);
            GetSelectedValues();
        }
    }
    protected void gvReckon_RowDataBound(object se, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='hover'");
                e.Row.Attributes.Add("onmouseout", "this.className='hout'");
                string strScript = "SelectInvSeqRowCommon('" + ((RadioButton)e.Row.FindControl("rdbcheck")).ClientID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdbcheck")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Client Master", ex);
        }
    }
    protected void gvReckon_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            DataTable dt = (DataTable)ViewState["Reckon"];
            int selRow = Convert.ToInt32(e.CommandArgument);
            int swapRow = 0;
            int rowindex = 0;
            int count = gvReckon.Rows.Count;
            if (dt != null && dt.Rows.Count > 0)
            {
                if (e.CommandName == "UP")
                {
                    if (selRow > 0)
                    {
                        swapRow = selRow - 1;
                        string strTempClientName = dt.Rows[selRow]["ClientName"].ToString();
                        string strTempRateName = dt.Rows[selRow]["RateName"].ToString();
                        string strValidFrom = Convert.ToDateTime(dt.Rows[selRow]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                        string strValidTo = Convert.ToDateTime(dt.Rows[selRow]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                        string strClientId = dt.Rows[selRow]["ClientId"].ToString();
                        string strRateId = dt.Rows[selRow]["RateId"].ToString();
                        string strClientTypeId = dt.Rows[selRow]["ClientTypeId"].ToString();
                        string strMappingDetailID = dt.Rows[selRow]["ClientMappingDetailsID"].ToString();
                        string strRateCode = dt.Rows[selRow]["RateCode"].ToString();
                        string strClientCode = dt.Rows[selRow]["ClientCode"].ToString();
                        string strInvRate = dt.Rows[selRow]["TransferRate"].ToString();
                        string strBaseRate = dt.Rows[selRow]["BaseRate"].ToString();
                        string strRateType = dt.Rows[selRow]["Type"].ToString();

                        dt.Rows[selRow]["ClientName"] = dt.Rows[swapRow]["ClientName"];
                        dt.Rows[selRow]["RateName"] = dt.Rows[swapRow]["RateName"];
                        dt.Rows[selRow]["ValidFrom"] = Convert.ToDateTime(dt.Rows[swapRow]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                        dt.Rows[selRow]["ValidTo"] = Convert.ToDateTime(dt.Rows[swapRow]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                        dt.Rows[selRow]["ClientId"] = dt.Rows[swapRow]["ClientId"];
                        dt.Rows[selRow]["RateId"] = dt.Rows[swapRow]["RateId"];
                        dt.Rows[selRow]["ClientTypeId"] = dt.Rows[swapRow]["ClientTypeId"];
                        dt.Rows[selRow]["ClientMappingDetailsID"] = dt.Rows[swapRow]["ClientMappingDetailsID"];
                        dt.Rows[selRow]["RateCode"] = dt.Rows[swapRow]["RateCode"];
                        dt.Rows[selRow]["ClientCode"] = dt.Rows[swapRow]["ClientCode"];
                        dt.Rows[selRow]["TransferRate"] = dt.Rows[swapRow]["TransferRate"];
                        dt.Rows[selRow]["BaseRate"] = dt.Rows[swapRow]["BaseRate"];
                        dt.Rows[selRow]["Type"] = dt.Rows[swapRow]["Type"];


                        dt.Rows[swapRow]["RateName"] = strTempRateName;
                        dt.Rows[swapRow]["ClientName"] = strTempClientName;
                        dt.Rows[swapRow]["ValidFrom"] = strValidFrom;
                        dt.Rows[swapRow]["ValidTo"] = strValidTo;
                        dt.Rows[swapRow]["ClientId"] = strClientId;
                        dt.Rows[swapRow]["RateId"] = strRateId;
                        dt.Rows[swapRow]["ClientTypeId"] = strClientTypeId;
                        dt.Rows[swapRow]["ClientMappingDetailsID"] = strMappingDetailID;
                        dt.Rows[swapRow]["RateCode"] = strRateCode;
                        dt.Rows[swapRow]["ClientCode"] = strClientCode;
                        dt.Rows[swapRow]["TransferRate"] = strInvRate;
                        dt.Rows[swapRow]["BaseRate"] = strBaseRate;
                        dt.Rows[swapRow]["Type"] = strRateType;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                }

                else if (e.CommandName == "DOWN")
                {
                    if (selRow < dt.Rows.Count - 1)
                    {
                        swapRow = selRow + 1;

                        string strTempClientName = dt.Rows[selRow]["ClientName"].ToString();
                        string strTempRateName = dt.Rows[selRow]["RateName"].ToString();
                        string strValidFrom = Convert.ToDateTime(dt.Rows[selRow]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                        string strValidTo = Convert.ToDateTime(dt.Rows[selRow]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                        string strClientId = dt.Rows[selRow]["ClientId"].ToString();
                        string strRateId = dt.Rows[selRow]["RateId"].ToString();
                        string strClientTypeId = dt.Rows[selRow]["ClientTypeId"].ToString();
                        string strMappingDetailID = dt.Rows[selRow]["ClientMappingDetailsID"].ToString();
                        string strRateCode = dt.Rows[selRow]["RateCode"].ToString();
                        string strClientCode = dt.Rows[selRow]["ClientCode"].ToString();
                        string strInvRate = dt.Rows[selRow]["TransferRate"].ToString();
                        string strBaseRate = dt.Rows[selRow]["BaseRate"].ToString();
                        string strRateType = dt.Rows[selRow]["Type"].ToString();


                        dt.Rows[selRow]["ClientName"] = dt.Rows[swapRow]["ClientName"];
                        dt.Rows[selRow]["RateName"] = dt.Rows[swapRow]["RateName"];
                        dt.Rows[selRow]["ValidFrom"] = Convert.ToDateTime(dt.Rows[swapRow]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                        dt.Rows[selRow]["ValidTo"] = Convert.ToDateTime(dt.Rows[swapRow]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                        dt.Rows[selRow]["ClientId"] = dt.Rows[swapRow]["ClientId"];
                        dt.Rows[selRow]["RateId"] = dt.Rows[swapRow]["RateId"];
                        dt.Rows[selRow]["ClientTypeId"] = dt.Rows[swapRow]["ClientTypeId"];
                        dt.Rows[selRow]["ClientMappingDetailsID"] = dt.Rows[swapRow]["ClientMappingDetailsID"];
                        dt.Rows[selRow]["RateCode"] = dt.Rows[swapRow]["RateCode"];
                        dt.Rows[selRow]["ClientCode"] = dt.Rows[swapRow]["ClientCode"];
                        dt.Rows[selRow]["TransferRate"] = dt.Rows[swapRow]["TransferRate"];
                        dt.Rows[selRow]["BaseRate"] = dt.Rows[swapRow]["BaseRate"];
                        dt.Rows[selRow]["Type"] = dt.Rows[swapRow]["Type"];

                        dt.Rows[swapRow]["RateName"] = strTempRateName;
                        dt.Rows[swapRow]["ClientName"] = strTempClientName;
                        dt.Rows[swapRow]["ValidFrom"] = strValidFrom;
                        dt.Rows[swapRow]["ValidTo"] = strValidTo;
                        dt.Rows[swapRow]["ClientId"] = strClientId;
                        dt.Rows[swapRow]["RateId"] = strRateId;
                        dt.Rows[swapRow]["ClientTypeId"] = strClientTypeId;
                        dt.Rows[swapRow]["ClientMappingDetailsID"] = strMappingDetailID;
                        dt.Rows[swapRow]["RateCode"] = strRateCode;
                        dt.Rows[swapRow]["ClientCode"] = strClientCode;
                        dt.Rows[swapRow]["TransferRate"] = strInvRate;
                        dt.Rows[swapRow]["BaseRate"] = strBaseRate;
                        dt.Rows[swapRow]["Type"] = strRateType;
                        gvReckon.DataSource = dt;
                        gvReckon.DataBind();
                    }
                }
                if (e.CommandName == "Move")
                {
                    foreach (GridViewRow GR in gvReckon.Rows)
                    {
                        RadioButton rdb = (RadioButton)GR.FindControl("rdbcheck");
                        if (rdb.Checked)
                        {
                            rowindex = GR.RowIndex;
                            if (rowindex > selRow)
                            {
                                for (int i = rowindex; i > selRow; i--)
                                {
                                    string strTempClientName = dt.Rows[i]["ClientName"].ToString();
                                    string strTempRateName = dt.Rows[i]["RateName"].ToString();
                                    string strValidFrom = Convert.ToDateTime(dt.Rows[i]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    string strValidTo = Convert.ToDateTime(dt.Rows[i]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    string strClientId = dt.Rows[i]["ClientId"].ToString();
                                    string strRateId = dt.Rows[i]["RateId"].ToString();
                                    string strClientTypeId = dt.Rows[i]["ClientTypeId"].ToString();
                                    string strMappingDetailID = dt.Rows[i]["ClientMappingDetailsID"].ToString();
                                    string strRateCode = dt.Rows[i]["RateCode"].ToString();
                                    string strClientCode = dt.Rows[i]["ClientCode"].ToString();
                                    string strInvRate = dt.Rows[i]["TransferRate"].ToString();
                                    string strBaseRate = dt.Rows[i]["BaseRate"].ToString();
                                    string Type = dt.Rows[i]["Type"].ToString();

                                    dt.Rows[i]["ClientName"] = dt.Rows[i - 1]["ClientName"];
                                    dt.Rows[i]["RateName"] = dt.Rows[i - 1]["RateName"];
                                    dt.Rows[i]["ValidFrom"] = Convert.ToDateTime(dt.Rows[i - 1]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    dt.Rows[i]["ValidTo"] = Convert.ToDateTime(dt.Rows[i - 1]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    dt.Rows[i]["ClientId"] = dt.Rows[i - 1]["ClientId"];
                                    dt.Rows[i]["RateId"] = dt.Rows[i - 1]["RateId"];
                                    dt.Rows[i]["ClientTypeId"] = dt.Rows[i - 1]["ClientTypeId"];
                                    dt.Rows[i]["ClientMappingDetailsID"] = dt.Rows[i - 1]["ClientMappingDetailsID"];
                                    dt.Rows[i]["RateCode"] = dt.Rows[i - 1]["RateCode"];
                                    dt.Rows[i]["ClientCode"] = dt.Rows[i - 1]["ClientCode"];
                                    dt.Rows[i]["TransferRate"] = dt.Rows[i - 1]["TransferRate"];
                                    dt.Rows[i]["BaseRate"] = dt.Rows[i - 1]["BaseRate"];
                                    dt.Rows[i]["Type"] = dt.Rows[i - 1]["Type"];


                                    dt.Rows[i - 1]["ClientName"] = strTempClientName;
                                    dt.Rows[i - 1]["RateName"] = strTempRateName;
                                    dt.Rows[i - 1]["ValidFrom"] = strValidFrom;
                                    dt.Rows[i - 1]["ValidTo"] = strValidTo;
                                    dt.Rows[i - 1]["ClientId"] = strClientId;
                                    dt.Rows[i - 1]["RateId"] = strRateId;
                                    dt.Rows[i - 1]["ClientTypeId"] = strClientTypeId;
                                    dt.Rows[i - 1]["ClientMappingDetailsID"] = strMappingDetailID;
                                    dt.Rows[i - 1]["RateCode"] = strRateCode;
                                    dt.Rows[i - 1]["ClientCode"] = strClientCode;
                                    dt.Rows[i - 1]["TransferRate"] = strInvRate;
                                    dt.Rows[i - 1]["BaseRate"] = strBaseRate;
                                    dt.Rows[i - 1]["Type"] = Type;

                                }
                            }
                            else if (rowindex < selRow)
                            {
                                for (int i = rowindex; i < selRow; i++)
                                {
                                    string strTempClientName = dt.Rows[i]["ClientName"].ToString();
                                    string strTempRateName = dt.Rows[i]["RateName"].ToString();
                                    string strValidFrom = Convert.ToDateTime(dt.Rows[i]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    string strValidTo = Convert.ToDateTime(dt.Rows[i]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    string strClientId = dt.Rows[i]["ClientId"].ToString();
                                    string strRateId = dt.Rows[i]["RateId"].ToString();
                                    string strClientTypeId = dt.Rows[i]["ClientTypeId"].ToString();
                                    string strMappingDetailID = dt.Rows[i]["ClientMappingDetailsID"].ToString();
                                    string strRateCode = dt.Rows[i]["RateCode"].ToString();
                                    string strClientCode = dt.Rows[i]["ClientCode"].ToString();
                                    string strInvRate = dt.Rows[i]["TransferRate"].ToString();
                                    string strBaseRate = dt.Rows[i]["BaseRate"].ToString();
                                    string Type = dt.Rows[i]["Type"].ToString();

                                    dt.Rows[i]["ClientName"] = dt.Rows[i + 1]["ClientName"];
                                    dt.Rows[i]["RateName"] = dt.Rows[i + 1]["RateName"];
                                    dt.Rows[i]["ValidFrom"] = Convert.ToDateTime(dt.Rows[i + 1]["ValidFrom"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    dt.Rows[i]["ValidTo"] = Convert.ToDateTime(dt.Rows[i + 1]["ValidTo"]).ToString("dd/MMM/yyyy hh:mm tt");
                                    dt.Rows[i]["ClientId"] = dt.Rows[i + 1]["ClientId"];
                                    dt.Rows[i]["RateId"] = dt.Rows[i + 1]["RateId"];
                                    dt.Rows[i]["ClientTypeId"] = dt.Rows[i + 1]["ClientTypeId"];
                                    dt.Rows[i]["ClientMappingDetailsID"] = dt.Rows[i + 1]["ClientMappingDetailsID"];
                                    dt.Rows[i]["RateCode"] = dt.Rows[i + 1]["RateCode"];
                                    dt.Rows[i]["ClientCode"] = dt.Rows[i + 1]["ClientCode"];
                                    dt.Rows[i]["TransferRate"] = dt.Rows[i + 1]["TransferRate"];
                                    dt.Rows[i]["BaseRate"] = dt.Rows[i + 1]["BaseRate"];
                                    dt.Rows[i]["Type"] = dt.Rows[i + 1]["Type"];

                                    dt.Rows[i + 1]["ClientName"] = strTempClientName;
                                    dt.Rows[i + 1]["RateName"] = strTempRateName;
                                    dt.Rows[i + 1]["ValidFrom"] = strValidFrom;
                                    dt.Rows[i + 1]["ValidTo"] = strValidTo;
                                    dt.Rows[i + 1]["ClientId"] = strClientId;
                                    dt.Rows[i + 1]["RateId"] = strRateId;
                                    dt.Rows[i + 1]["ClientTypeId"] = strClientTypeId;
                                    dt.Rows[i + 1]["ClientMappingDetailsID"] = strMappingDetailID;
                                    dt.Rows[i + 1]["RateCode"] = strRateCode;
                                    dt.Rows[i + 1]["ClientCode"] = strClientCode;
                                    dt.Rows[i + 1]["TransferRate"] = strInvRate;
                                    dt.Rows[i + 1]["BaseRate"] = strBaseRate;
                                    dt.Rows[i + 1]["Type"] = Type;
                                }
                            }
                            gvReckon.DataSource = dt;
                            gvReckon.DataBind();
                        }
                    }
                }
            }
            ViewState["Reckon"] = dt;
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Client Rate Mapping", ex);
        }
    }
    public void Clear()
    {
        txtClientName.Text = "";
        txtRateCard.Text = "";
        hdnRateID.Value = "0";
        //hdnClientID.Value = "0";
        txtValidFrom.Text = "";
        txtValidTo.Text = "";
        hdnMappingDetailsID.Value = "0";
        //btnAdd.Text = "Save";
        btnAdd.Text = strSave;
        ChkInvRateID.Checked = false;
        ChkBaserate.Checked = false;
    }
    protected void ddlClientType_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string val = ddlClientType.SelectedValue;
       // string OrgVal = ddlTrustedOrg.SelectedValue;
        //AutoCompleteExtender1.ContextKey = val + "^" + OrgVal;
        //GetSelectedValues();
        if (ddlClientType.SelectedIndex == 0)
        {
            txtClientName.Enabled = false;
            txtClientName.Text = "";
        }
        else
        {
            txtClientName.Enabled = true;
            int ClientTypeID = 0;
            int CustomerTypeID = Convert.ToInt32(ddlClientType.SelectedValue.ToString());
            AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + ClientTypeID.ToString() + "~" + CustomerTypeID.ToString();
            txtClientName.Focus();
            //txtClientName.Text = "";
        }
    }
    public void GetSelectedValues()
    {
        string val = ddlClientType.SelectedValue;
        string OrgVal = ddlTrustedOrg.SelectedValue;
        AutoCompleteExtender1.ContextKey = val + "^" + OrgVal;
        txtClientName.Enabled = true;
        txtValidFrom.Enabled = true;
        GetRateMappingDetail();
        GetAllClients();
        //btnAdd.Text = "Save";
        btnAdd.Text = strSave;
        chkSelectAll.Style.Add("display", "block");
        chkSelectAll.Checked = false;
        divChkList.Style.Add("display", "none");
    }
    public void GetRateMappingDetail()
    {
        try
        {           
            grdClientRateMapping.DataSource = null;
            grdClientRateMapping.DataBind();
            BindRatesinGridView();
            Clear();
            hdnClientID.Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get ClientRateMappingDetail", ex);
        }
    }

    public void BindRatesinGridView()
    {
        long returnCode = -1; 
        int ClientTypeID = 0;
        int pOrgID = 0;
        bool isGridEmpty = false;
        try
        {
            lstInvClientMaster = new List<InvClientMaster>();
            if (ddlClientType.SelectedValue != "-1" && ddlClientType.SelectedValue != "0")
            {
                ClientTypeID = Convert.ToInt32(hdnClientID.Value);
            }
            if (ddlTrustedOrg.SelectedValue != "-1" && ddlTrustedOrg.SelectedValue != "0")
            {
                pOrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            }
            returnCode = Patient_BL.GetClientRateMappingDetail(pOrgID, ClientTypeID, out lstInvClientMaster);
            if (!String.IsNullOrEmpty(hdnClientID.Value.ToString()) && hdnClientID.Value.ToString().Length > 0 && hdnClientID.Value.ToString() != "0")
            {
                if (lstInvClientMaster.Exists(p => p.ClientID == (Convert.ToInt64(hdnClientID.Value))))
                    lstInvClientMaster = lstInvClientMaster.FindAll(p => p.ClientID == (Convert.ToInt64(hdnClientID.Value))).ToList();
                else
                {
                    isGridEmpty = true;
                    grdClientRateMapping.EmptyDataText = UsrNotmapmsg;
                    grdClientRateMapping.DataSource = null;
                    grdClientRateMapping.DataBind();
                }
            }
            if (lstInvClientMaster.Count > 0 && isGridEmpty == false)
            {
                if (ShowExpired == 1)
                {
                    grdClientRateMapping.DataSource = lstInvClientMaster;
                    grdClientRateMapping.DataBind();
                    grdClientRateMapping.EmptyDataText = "";
                }
                else
                {
                    grdClientRateMapping.DataSource = lstInvClientMaster;
                    grdClientRateMapping.DataBind();
                    grdClientRateMapping.EmptyDataText = "";
                    if (hdnClientID.Value != "0")
                    {
                        int IsTransferRate = 0;
                        foreach (InvClientMaster obj in lstInvClientMaster)
                        {
                            if (obj.TransferRate.Trim() == "Y")
                            {
                                ChkInvRateID.Attributes.Add("onclick", "javascript:CheckTransferRate(this.id);");
                                IsTransferRate = 1;
                                break;
                            }
                        }
                        if (IsTransferRate == 0)
                        {
                            ChkInvRateID.Attributes.Add("onclick", "javascript:Duplicate(this.id);");
                        }
                    }

                }
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "enableTxt", "EnableTextBox();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while binding rate in gridview", ex);
        }
    }

    public void AdjustTableHeight(int numberOfRows)
    {
        string strKey = String.Format("width:400px; height:100px; overflow:scroll; z-index:55", 1 * 70);
        divChkList.Attributes.Add("style", strKey);
    }
    protected void loaddata(List<InvClientMaster> lstInvClientMaster)
    {
        try
        {
            if (lstInvClientMaster.Count > 0)
            {
                System.Data.DataTable dt = new DataTable();
                DataColumn dbCol1 = new DataColumn("ClientName");
                DataColumn dbCol2 = new DataColumn("RateName");
                DataColumn dbCol3 = new DataColumn("ValidFrom");
                DataColumn dbCol4 = new DataColumn("ValidTo");
                DataColumn dbCol5 = new DataColumn("ClientId");
                DataColumn dbCol6 = new DataColumn("RateId");
                DataColumn dbCol7 = new DataColumn("ClientTypeId");
                DataColumn dbCol8 = new DataColumn("ClientMappingDetailsID");
                DataColumn dbCol9 = new DataColumn("RateCode");
                DataColumn dbCol10 = new DataColumn("ClientCode");
                DataColumn dbCol11 = new DataColumn("TransferRate");
                DataColumn dbCol12 = new DataColumn("BaseRate");
                DataColumn dbCol13 = new DataColumn("Type");


                dt.Columns.Add(dbCol1);
                dt.Columns.Add(dbCol2);
                dt.Columns.Add(dbCol3);
                dt.Columns.Add(dbCol4);
                dt.Columns.Add(dbCol5);
                dt.Columns.Add(dbCol6);
                dt.Columns.Add(dbCol7);
                dt.Columns.Add(dbCol8);
                dt.Columns.Add(dbCol9);
                dt.Columns.Add(dbCol10);
                dt.Columns.Add(dbCol11);
                dt.Columns.Add(dbCol12);
                dt.Columns.Add(dbCol13);

                foreach (InvClientMaster org in lstInvClientMaster)
                {
                    DataRow dr = dt.NewRow();
                    dr["ClientName"] = org.ClientName;
                    dr["RateName"] = org.RateName;
                    dr["ValidFrom"] = String.Format("{0:dd/MMM/yyyy hh:mm tt}", org.ValidFrom);
                    dr["ValidTo"] = String.Format("{0:dd/MMM/yyyy hh:mm tt}", org.ValidTo);
                    dr["ClientId"] = org.ClientID;
                    dr["RateId"] = org.RateId;
                    dr["ClientTypeId"] = org.ClientTypeID;
                    dr["ClientMappingDetailsID"] = org.ClientMappingDetailsID;
                    dr["RateCode"] = org.RateCode;
                    dr["ClientCode"] = org.ClientCode;
                    dr["TransferRate"] = org.TransferRate;
                    dr["Type"] = org.Type;
                    dr["BaseRate"] = org.BaseRate;
                    dt.Rows.Add(dr);
                }
                ViewState["Reckon"] = dt;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Client Rate Mapping", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            int rowindex = 0;
            int Flag = 0;
            List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
            InvClientMaster objInvClientMaster;
            int ClientTypeID = 0;
            string Reason = "";
            int ClientID = Convert.ToInt32(hdnClientID.Value);
            int RateID = Convert.ToInt32(hdnRateID.Value);
            if (ddlClientType.SelectedValue != "0")
            {
                //ClientTypeID = Convert.ToInt32(ddlClientType.SelectedValue);
            }
            DateTime FromDate = Convert.ToDateTime("01/Jan/1753");
            DateTime ToDate = Convert.ToDateTime("31/Dec/9999");
            DateTime FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
            DateTime ToTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
            if (hdnClientCode.Value.Trim().ToUpper() != "GENERAL" || hdnRateCode.Value.Trim().ToUpper() != "GENERAL")
            {
                if (txtValidFrom.Text.Trim() != "")
                {
                    FromDate = Convert.ToDateTime(txtValidFrom.Text);
                }
                if (txtValidTo.Text.Trim() != "")
                {
                    ToDate = Convert.ToDateTime(txtValidTo.Text);
                }
            }


            foreach (GridViewRow GR in gvReckon.Rows)
            {
                if (GR.RowType == DataControlRowType.DataRow)
                {

                    rowindex = GR.RowIndex + 1;
                    objInvClientMaster = new InvClientMaster();
                    Label lblClient = (Label)GR.FindControl("lblClient");
                    Label lblRate = (Label)GR.FindControl("lblRate");
                    Label lblFromDate = (Label)GR.FindControl("lblFromDate");
                    Label lblInvRate = (Label)GR.FindControl("lblInvRate");
                    Label lblToDate = (Label)GR.FindControl("lblToDate");
                    Label lblClientId = (Label)GR.FindControl("lblClientId");
                    Label lblRateId = (Label)GR.FindControl("lblRateId");
                    Label lblClientCoce = (Label)GR.FindControl("lblClientCode");
                    Label lblRateCode = (Label)GR.FindControl("lblRateCode");
                    Label lblInvBaseRateCard = (Label)GR.FindControl("lblInvBaseRateCard");

                    if (!String.IsNullOrEmpty(lblInvBaseRateCard.Text) && lblInvBaseRateCard.Text.Length > 0)
                    {
                        if (lblInvBaseRateCard.Text == "Y")
                        {
                            Flag = Flag+ 1;
                        }
                    }
                    if (Flag > 1)
                    {
                        string strBaseRate = Resources.Admin_AppMsg.Admin_ClientRateMapping_aspx_15 == null ? "Base RateCard Already Mapped" : Resources.Admin_AppMsg.Admin_ClientRateMapping_aspx_15;
                        string strAlert = Resources.Admin_AppMsg.Admin_ClientRateMapping_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_ClientRateMapping_aspx_Alert;

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strBaseRate + "','" + strAlert + "');", true);                       
                        return;

                    }
                   

                    Label lblClientTypeId = (Label)GR.FindControl("lblClientTypeId");
                    Label lblMappingDetailsID = (Label)GR.FindControl("lblMappingDetailsID");

                    objInvClientMaster.ClientName = lblClient.Text;
                    objInvClientMaster.RateName = lblRate.Text;
                    objInvClientMaster.ValidFrom = lblRate.Text.ToUpper() == "GENERAL" && lblClient.Text.ToUpper() == "GENERAL" ? Convert.ToDateTime("01/Jan/1753") : Convert.ToDateTime(Convert.ToDateTime(lblFromDate.Text.ToString()).ToString("dd/MMM/yyyy"));
                    objInvClientMaster.ValidTo = lblRate.Text.ToUpper() == "GENERAL" && lblClient.Text.ToUpper() == "GENERAL" ? Convert.ToDateTime("31/Dec/9999") : Convert.ToDateTime(Convert.ToDateTime(lblToDate.Text.ToString()).ToString("dd/MMM/yyyy"));
                    objInvClientMaster.ClientID = Convert.ToInt64(lblClientId.Text);
                    objInvClientMaster.RateId = Convert.ToInt32(lblRateId.Text);
                    //objInvClientMaster.InvRateID = Convert.ToInt32(hiddeninvRateid.Value);
                    objInvClientMaster.TransferRate = lblInvRate.Text.ToString();
                    objInvClientMaster.BaseRate = lblInvBaseRateCard.Text.ToString();
                    objInvClientMaster.ClientTypeID = Convert.ToInt32(lblClientTypeId.Text);
                    objInvClientMaster.Interval = rowindex;
                    objInvClientMaster.ClientMappingDetailsID = Convert.ToInt32(lblMappingDetailsID.Text);
                    FromTime = lblRate.Text.ToUpper() == "GENERAL" && lblClient.Text.ToUpper() == "GENERAL" ? Convert.ToDateTime("01/Jan/1753") : Convert.ToDateTime(lblFromDate.Text);
                    objInvClientMaster.ValidFromTime = TimeSpan.Parse(FromTime.ToShortTimeString());
                    ToTime = lblRate.Text.ToUpper() == "GENERAL" && lblClient.Text.ToUpper() == "GENERAL" ? Convert.ToDateTime("31/Dec/9999") : Convert.ToDateTime(lblToDate.Text);
                    objInvClientMaster.ValidToTime = TimeSpan.Parse(ToTime.ToShortTimeString());
                    lstInvClientMaster.Add(objInvClientMaster);
                }
            }
            if (ddlReason.SelectedValue != "0")
            {
                Reason = ddlReason.SelectedItem.ToString();
            }
            returnCode = Patient_BL.SaveClientRateMappingDetail(OrgID, ClientTypeID, ClientID, RateID, lstInvClientMaster, LID,Reason);
            lstInvClientMaster.Clear();
            
            gvReckon.DataSource = null;
            gvReckon.DataBind();
            ViewState.Remove("Reckon");
            //ddlClientType_SelectedIndexChanged(sender, e);
            GetSelectedValues();
            ddlClientType_SelectedIndexChanged(sender, e);
            hdnClientID.Value = "0";
            if (Request.QueryString["ClientID"] != null && Request.QueryString["ClientCode"] != null && Request.QueryString["ClientName"] != null && Request.QueryString["OrgID"] != null && Request.QueryString["OrgAddressID"] != null)
            {
                string CltID = Request.QueryString["ClientID"];
                string CltCode = Request.QueryString["ClientCode"];
                string CltName = Request.QueryString["ClientName"];
                string CltOrgID = Request.QueryString["OrgID"];
                string OAddID = Request.QueryString["OrgAddressID"];
                Response.Redirect("~/Invoice/ClientManagement.aspx?ClientID=" + CltID + "&ClientCode=" + CltCode + "&ClientName=" + CltName + "&OrgID=" + CltOrgID + "&OrgAddressID=" + OAddID + "", true);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Save ClientRateMappingDetail", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
    }
    private void EnableAllEdit()
    {
        try
        {
            int i = 0;
            foreach (GridViewRow row in grdClientRateMapping.Rows)
            {
                LinkButton lnkEditBtn = new LinkButton();
                Label lblClientCode = new Label();
                Label lblRateCode = new Label();
                if (i <= grdClientRateMapping.Rows.Count - 1)
                {
                    lblClientCode = (Label)grdClientRateMapping.Rows[i].Cells[4].FindControl("lblClientCode");
                    lblRateCode = (Label)grdClientRateMapping.Rows[i].Cells[4].FindControl("lblRateCode");
                    if (lblClientCode.Text.Trim() == "GENERAL" && lblRateCode.Text.Trim() == "GENERAL")
                    {
                        lnkEditBtn = (LinkButton)grdClientRateMapping.Rows[i].Cells[2].FindControl("btnEdit");
                        lnkEditBtn.Enabled = false;
                    }
                    else
                    {
                        lnkEditBtn = (LinkButton)grdClientRateMapping.Rows[i].Cells[2].FindControl("btnEdit");
                        lnkEditBtn.Enabled = true;
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
    protected void grdClientRateMapping_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
            GridViewRow gvr = grdClientRateMapping.Rows[e.NewEditIndex];

            Label lblClient = (Label)gvr.Controls[0].FindControl("lblClient");
            Label lblRate = (Label)gvr.Controls[0].FindControl("lblRate");
            Label lblFromDate = (Label)gvr.Controls[0].FindControl("lblFromDate");
            Label lblToDate = (Label)gvr.Controls[0].FindControl("lblToDate");
            Label lblClientId = (Label)gvr.Controls[0].FindControl("lblClientId");
            Label lblClientCode = (Label)gvr.Controls[0].FindControl("lblClientCode");
            Label lblRateId = (Label)gvr.Controls[0].FindControl("lblRateId");
            Label lblRateCode = (Label)gvr.Controls[0].FindControl("lblRateCode");
            Label lblClientTypeId = (Label)gvr.Controls[0].FindControl("lblClientTypeId");
            Label lblMappingDetailsID = (Label)gvr.Controls[0].FindControl("lblMappingDetailsID");
            Label Priority = (Label)gvr.Controls[0].FindControl("lblPriority");

            Label lblInvRate1 = (Label)gvr.Controls[0].FindControl("lblInvRate1");
            Label lblRate12 = (Label)gvr.Controls[0].FindControl("lblRate12");
            Label lblInvBaseRate = (Label)gvr.Controls[0].FindControl("lblInvBaseRate");

            if (!String.IsNullOrEmpty(lblRate12.Text) && lblRate12.Text.Length > 0)
            {
                //ddlratetype.SelectedValue = lblRate12.Text.ToString();
                string ratetype=ddlratetype.Items.FindByText(lblRate12.Text.ToString()).Value;
                ddlratetype.SelectedValue = ratetype;
            }
            if (lblInvBaseRate.Text.Trim() == "Y")
            {
                ChkBaserate.Checked = true;
            }
            else
            {
                ChkBaserate.Checked = false;
            }

            if (lblInvRate1.Text.Trim() == "Y")
            {
                ChkInvRateID.Checked = true;
            }
            else
            {
                ChkInvRateID.Checked = false;
            }
            hdnpriorityid.Value = Priority.Text.ToString();
           // ddlClientType.SelectedValue = lblClientTypeId.Text;
            txtClientName.Text = lblClient.Text;
            hdnClientID.Value = lblClientId.Text;
            hdnClientCode.Value = lblClientCode.Text;
            hdnClientTypeID.Value = lblClientTypeId.Text;
            txtRateCard.Text = lblRate.Text;
            hdnRateID.Value = lblRateId.Text;
            hdnRateCode.Value = lblRateCode.Text;
            txtValidFrom.Text = (lblFromDate.Text == "" || lblFromDate.Text == "**") ? "" : String.Format("{0:dd/MMM/yyyy}", Convert.ToDateTime(lblFromDate.Text));
            txtValidTo.Text = (lblToDate.Text == "" || lblToDate.Text == "**") ? "" : String.Format("{0:dd/MMM/yyyy}", Convert.ToDateTime(lblToDate.Text));

            DateTime FromTime = Convert.ToDateTime(lblFromDate.Text);
            DateTime ToTime = Convert.ToDateTime(lblToDate.Text);
            ddlFrom.SelectedValue = FromTime.ToString("hh:mm tt");
            if (ToTime.ToString("hh:mm tt") == "11:59 PM")
            {
                ddlTo.SelectedValue = "12:00 AM";
            }
            else
            {
                ddlTo.SelectedValue = ToTime.ToString("hh:mm tt");
            }
            //    txtValidFrom.Text = String.Format("{0:dd/MMM/yyyy}", Convert.ToDateTime(lblFromDate.Text)); 11:59 PM


            //txtValidTo.Text = string.Format("{0:dd/MM/yyyy}", Convert.ToDateTime(lblToDate.Text));
            hdnMappingDetailsID.Value = lblMappingDetailsID.Text;

            EnableAllEdit();
            chkSelectAll.Checked = false;
            chkSelectAll.Style.Add("display", "none");
            LinkButton lnkEdit = (LinkButton)gvr.Controls[0].FindControl("btnEdit");
            lnkEdit.Enabled = false;
            btnAdd.Text = Usrupdate;
            txtClientName.Enabled = false;
            //txtValidFrom.Enabled = false;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdClientRateMapping_RowEditing Event()", ex);
        }
    }
    protected void grdClientRateMapping_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
            Label lblClientCode = (Label)e.Row.FindControl("lblClientCode");
            Label lblRateCode = (Label)e.Row.FindControl("lblRateCode");
            LinkButton btnEdit = (LinkButton)e.Row.FindControl("btnEdit");
            if (lblClientCode.Text.ToUpper() == "GENERAL" && lblRateCode.Text.ToUpper() == "GENERAL")
            {
                btnEdit.Enabled = false;
            }
            else
            {
                btnEdit.Enabled = true;
            }
            Label lblFromDate = (Label)e.Row.FindControl("lblFromDate");
            if (lblFromDate.Text == "01/Jan/1753")
            {
                lblFromDate.Text = "";
            }
            Label lblToDate = (Label)e.Row.FindControl("lblToDate");
            if (lblToDate.Text == "01/Jan/1753" || lblToDate.Text == "31/Dec/9999")
            {
                lblToDate.Text = "";
            }
        }
    }
    protected void chkShowAll_CheckedChanged(object sender, EventArgs e)
    {
        if (chkShowAll.Checked == true)
        {
            ShowExpired = 1;
        }
        else
        {
            ShowExpired = 0;
        }
        //ddlClientType_SelectedIndexChanged(sender, e);
        GetSelectedValues();
    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        string val = ddlClientType.SelectedValue;
        string OrgVal = ddlTrustedOrg.SelectedValue;
        AutoCompleteExtender1.ContextKey = val + "^" + OrgVal;
        //AutoCompleteExtender2.ContextKey = OrgVal;
        if (ddlTrustedOrg.SelectedValue == "0")
        {
            ddlClientType.SelectedValue = "0";
            txtClientName.Enabled = true;
            txtValidFrom.Enabled = true;
            Clear();
            hdnClientID.Value = "0";
            grdClientRateMapping.DataSource = null;
            grdClientRateMapping.DataBind();
        }
        else
        {
            //GetSelectedValues();
            ddlClientType.Focus();
        }
        //AutoCompleteExtender1.ContextKey = val + "^" + OrgVal;
        //AutoCompleteExtender2.ContextKey = ddlTrustedOrg.SelectedValue; 
    }
    protected void btnLoadGrid_Click(object sender, EventArgs e)
    {
        BindRatesinGridView();
        txtRateCard.Focus();
    }
    public void GetGroupValues()
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01;

        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstmetavalue.Count > 0)
            {
                string setID = "0";
                lstmetavalue.RemoveAll(p => p.Code != "BT");

                ddlClientType.DataSource = lstmetavalue;
                ddlClientType.DataTextField = "Value";
                ddlClientType.DataValueField = "MetaValueID";
                ddlClientType.DataBind();
                //ddlClientType.Items.Insert(0, "--Select--");
                ddlClientType.Items.Insert(0, strSelect);
                ddlClientType.Items[0].Value = "0";
                ddlClientType.SelectedValue = setID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    public void LoadMetaData()
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_ClientRateMapping_aspx_01;

        try
        {
            long returncode = -1;
            string domains = "Vendor Type";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Vendor Type" &&  child.ParentID==0
                                // orderby child.DisplayText ascending 
                                 select child;
               // var s = childItems(p => p.DisplayText == "Normal");
                ddlratetype.DataSource = childItems;
                ddlratetype.DataTextField = "DisplayText";
                ddlratetype.DataValueField = "Code";
                ddlratetype.DataBind();
                //ddlratetype.Items.Insert(0, "----Select----");
                ddlratetype.Items.Insert(0, strSelect);
                ddlratetype.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Vendor", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void ddlratetype_SelectedIndexChanged(object sender, EventArgs e)
    {
        //string val = ddlClientType.SelectedValue;
        //string OrgVal = ddlTrustedOrg.SelectedValue;
        //AutoCompleteExtender1.ContextKey = val + "^" + OrgVal;
        //GetSelectedValues();
        txtClientName.Enabled = true;
        int ClientTypeID = 0;
        string RateTypeID = ddlratetype.SelectedValue;
        AutoCompleteExtender2.ContextKey = RateTypeID;
        txtRateCard.Focus();
        BindRatesinGridView();
        //  txtClientName.Focus();
        //txtClientName.Text = "";
    }
}
