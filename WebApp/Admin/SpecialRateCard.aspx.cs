using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Admin_SpecialRateCard : BasePage
{
    public Admin_SpecialRateCard() : base("Admin_SpecialRateCard_aspx") { }

    Master_BL objMasterBL;
    List<InvClientType> lstInvClientType;
    Patient_BL Patient_BL;
    string mType = string.Empty;
    string ClientID = string.Empty;
    string ClientTypeID = string.Empty;
    string strAlert = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_Alert;
    protected void Page_Load(object sender, EventArgs e)
    {
        objMasterBL = new Master_BL(base.ContextInfo);
        Patient_BL = new Patient_BL(base.ContextInfo);
        Loadphy();
        LoadMetaData();
        if (!IsPostBack)
        {
            if (Request.QueryString["MapType"] != "" && Request.QueryString["MapType"] != null)
            {
                mType = Request.QueryString["MapType"];
               // divBack.Style.Add("display", "block");
                //lblLnk.Style.Add("cursor", "pointer");
                ClientTypeID = Request.QueryString["cTypeID"];
                ClientID = Request.QueryString["ClientID"];
                if (ClientTypeID != "" && ClientID != "" && Request.QueryString["CName"] != null)
                {
                    hdnClientID.Value = ClientID;
                    txtClientName.Text = Request.QueryString["CName"];
                    ddlClientType.Enabled = false;
                    txtClientName.Enabled = false;
                    drpRefType.Enabled = true;
                    txtTestName.Enabled = true;
                    ddlClientType.SelectedValue = ClientTypeID;
                }
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:DisplayTab('" + mType + "');", true);
            }
            //GetClientType();
			GetGroupValues();
            GetSpecialRates();
        }
    }

    public void Loadphy()
    {
        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strSpc01 = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_11 == null ? "Special Rates saved sucessfully" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_11;
        string strSpc02 = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_12 == null ? "Special Rates Updated sucessfully" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_12;
        string strSpc03 = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_13 == null ? "Special Rates Deleted sucessfully" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_13;

        try
        {
            long returnCode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            string MappingType = "Special";
            foreach (string items in hdnAdditems.Value.Split('^'))
            {
                if (items != "")
                {
                    RateMaster objRateMaster = new RateMaster();
                    objRateMaster.InvestigationID = Convert.ToInt64(items.Split('~')[0]);
                    objRateMaster.InvestigationType = items.Split('~')[2].ToString();
                    objRateMaster.IpAmount = Convert.ToDecimal(items.Split('~')[3]);
                    lstRateMaster.Add(objRateMaster);
                }
            }
            if (lstRateMaster.Count > 0)
            {
                if (hdnUpdate.Value == "0")
                {
                    string RateName = txtRateName.Text;
                    returnCode = objMasterBL.SaveSpecialRateMaster(RateName, OrgID, LID, MappingType, lstRateMaster);
                    if (returnCode > 0)
                    {
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:alert('Special Rates saved sucessfully')", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:ValidationWindow('" + strSpc01 + "','" + strAlert + "')", true);
                    }
                }
                else if (hdnUpdate.Value == "1")
                {
                    long RateID = Convert.ToInt64(hdnRateID.Value);
                    returnCode = objMasterBL.UpdateSpecialRateMaster(OrgID, RateID, LID, lstRateMaster);
                    if (returnCode > 0)
                    {
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:alert('Special Rates Updated sucessfully')", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:ValidationWindow('" + strSpc02 + "','" + strAlert + "')", true);

                    }
                }
            }
            if (hdnUpdate.Value == "2")
            {
                long RateID = Convert.ToInt64(hdnRateID.Value);
                lstRateMaster.Clear();
                returnCode = objMasterBL.UpdateSpecialRateMaster(OrgID, RateID, LID, lstRateMaster);
                if (returnCode > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:ValidationWindow('" + strSpc03 + "','" + strAlert + "')", true);
                };
            }
            GetSpecialRates();
            ClearTempData();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save in btnSave_Click() in SpecialRateCard.aspx", ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Admin/SpecialRateCard.aspx");
    }

    public void ClearTempData()
    {
        txtRateName.Text = "";
        txtInvName.Text = "";
        txtAmount.Text = "";
        hdnAdditems.Value = "";
        hdnInvID.Value = "";
        hdnInvName.Value = "";
        hdnInvType.Value = "";
        hdnRateID.Value = "";
        hdnUpdate.Value = "0";
    }

    public void GetSpecialRates()
    {
        try
        {
            long returnCode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            returnCode = objMasterBL.GetSpecialRates(OrgID, out lstRateMaster);
            List<RateMaster> temp1 = new List<RateMaster>();
            temp1 = (from ex in lstRateMaster
                     group ex by new { ex.RateId, ex.RateName } into g
                     select new RateMaster
                     {
                         RateId = g.Key.RateId,
                         RateName = g.Key.RateName,
                     }).Distinct().ToList();
            grdSpecialRates.DataSource = temp1;
            grdSpecialRates.DataBind();
            hdnSpecialRate.Value = "";
            foreach (RateMaster objrate in lstRateMaster)
            {
                hdnSpecialRate.Value += objrate.RateId + "~" + objrate.InvestigationID + "~" + objrate.ClientName + "~" + objrate.InvestigationType + "~" + String.Format("{0:0.00}", objrate.OpAmount) + "#";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading GetSpecialRates()", ex);
        }
    }

    protected void grdSpecialRates_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Mapping")
            {
                string isactivestatus = Convert.ToString(e.CommandArgument);
                string[] arg = new string[2];
                arg = isactivestatus.Split(',');
                int ID = Convert.ToInt32(arg[0]);
                string Name = Convert.ToString(arg[1]);
                if (ID != -1)
                {
                    txtRateName.Text = "";
                    hdnAdditems.Value = "";
                    txtRateName.Text = Name;
                    ScriptManager.RegisterStartupScript(Page, GetType(), "Get", "javascript:GetSpecialRated(" + ID + ")", true);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading GetSpecialRates()", ex);
        }
    }
    protected void btnSaveClient_Click(object sender, EventArgs e)
    {
        string strSpc04 = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_14 == null ? "Client Map service saved sucessfully" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_14;
        string strSpc05 = Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_15 == null ? "Client Map service updated sucessfully" : Resources.Admin_AppMsg.Admin_SpecialRateCard_aspx_15;

        try
        {
            long returnCode = -1;
            string MappingType = "Client";
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            foreach (string items in hdnAddClient.Value.Split('^'))
            {
                if (items != "")
                {
                    RateMaster objRateMaster = new RateMaster();
                    objRateMaster.ClientID = Convert.ToInt64(hdnClientID.Value.Split('|')[0]);
                    objRateMaster.InvestigationID = Convert.ToInt64(items.Split('~')[0]);
                    objRateMaster.InvestigationType = items.Split('~')[2].ToString();
                    objRateMaster.ReferenceType = items.Split('~')[3];
                    if (items.Split('~')[5] == "undefined")
                    {
                        items.Split('~')[5] = string.Empty;
                    }
                    objRateMaster.SCode = items.Split('~')[5].ToUpper().ToString();
                    lstRateMaster.Add(objRateMaster);
                }
                else {
                    RateMaster objRateMaster = new RateMaster();
                    objRateMaster.ClientID = Convert.ToInt64(hdnClientID.Value.Split('|')[0]);
                    objRateMaster.InvestigationID = 0;
                    objRateMaster.InvestigationType = String.Empty;
                    objRateMaster.ReferenceType = String.Empty;
                    objRateMaster.SCode = String.Empty;
                    lstRateMaster.Add(objRateMaster);
                }
            }
            if (lstRateMaster.Count > 0)
            {
                string RateName = "";
                returnCode = objMasterBL.SaveSpecialRateMaster(RateName, OrgID, LID, MappingType, lstRateMaster);
                if (returnCode > 0)
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "DisplayTab", "javascript:DisplayTab('CLI')", true);
                    if (hdnAlertMsg.Value != "1")
                    {
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:alert('Client Map service saved sucessfully')", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:ValidationWindow('" + strSpc04 + "','" + strAlert + "')", true);
                    }
                    else
                    {
                        //ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:alert('Client Map service updated sucessfully')", true);
                        ScriptManager.RegisterStartupScript(Page, GetType(), "Alert", "javascript:ValidationWindow('" + strSpc05 + "','" + strAlert + "')", true);
                    }
                }
                ddlClientType.SelectedValue = "0";
                drpRefType.SelectedValue = "0";
                hdnAlertMsg.Value = "0";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Clear", "javascript:ClearFields1()", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "Clear", "javascript:ClearFields2()", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "Disable", "javascript:DisableFunc('F')", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Save in btnSave_Click() in SpecialRateCard.aspx", ex);
        }
    }

    public void GetClientType()
    {
        string strSelect = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01 == null ? "---Select---" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01;//and

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
               // lstItem.Text = "---------Select---------";
                lstItem.Text = strSelect;

                lstItem.Value = "0";
                ddlClientType.Items.Insert(0, lstItem);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
        }
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ReferenceType";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ReferenceType"
                                     orderby child.MetaDataID ascending
                                     select child;
                    drpRefType.DataSource = childItems;
                    drpRefType.DataTextField = "DisplayText";
                    drpRefType.DataValueField = "Code";
                    drpRefType.DataBind();
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);

        }
    }
 public void GetGroupValues()
    {

     string strSelect = Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01 == null ? "---Select---" : Resources.Admin_ClientDisplay.Admin_RatesUpdation_aspx_01;//and
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
                ddlClientType.Items.Insert(0, strSelect); // and
                ddlClientType.Items[0].Value = "0";
                ddlClientType.SelectedValue = setID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }

    protected void ddlClientType_SelectedIndexChanged(object sender, EventArgs e)
    {
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
            txtClientName.Text = "";
            txtTestName.Text = "";

        }
    }
}
