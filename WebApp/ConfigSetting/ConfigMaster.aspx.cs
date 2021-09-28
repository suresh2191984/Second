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
using System.Xml;

public partial class ConfigSetting_ConfigMaster : BasePage
{
    public ConfigSetting_ConfigMaster()
        : base("ConfigSetting_ConfigMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    List<ConfigKeyMaster> lstConfigKeyMaster = new List<ConfigKeyMaster>();
    List<ConfigOrgMaster> lstConfigOrgMaster = new List<ConfigOrgMaster>();
    List<ConfigValueMaster> lstConfigValueMaster = new List<ConfigValueMaster>();
    List<Locations> lstLocations = new List<Locations>();
    List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblOrgTitle.Style.Add("display", "none");
            LoadMetaData();
        }
    }
    public void LoadMetaData()
    {
        string strddlConfigType = Resources.ConfigSettings_ClientDisplay.ConfigSetting_ConfigMaster_aspx_01 == null ? "--Select--" : Resources.ConfigSettings_ClientDisplay.ConfigSetting_ConfigMaster_aspx_01;
        try
        {
            long returncode = -1;
            string domains = "Config";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childDepartment = from child in lstmetadataOutput
                                          where child.Domain == "Config"
                                          orderby child.MetaDataID ascending
                                          select child;
                    if (childDepartment.Count() > 0)
                    {
                        ddlConfigType.DataSource = childDepartment;
                        ddlConfigType.DataTextField = "DisplayText";
                        ddlConfigType.DataValueField = "Code";
                        ddlConfigType.DataBind();
                    }
                    ddlConfigType.Items.Insert(0, "--Select--");
                    ddlConfigType.Items[0].Value = "select";
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);

        }
    }
    protected void ddlConfigType_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList objddlConfig = (DropDownList)FindControl("ddlConfigType");
        if (objddlConfig.SelectedValue != "0")
        {
            trConfig1.Style.Add("display", "table-row");
            trConfig2.Style.Add("display", "table-row");
            trBtnSave.Style.Add("display", "table-row");
            BindConfigMaster();
            lblOrgTitle.Style.Add("display", "block");
        }
        if (objddlConfig.SelectedValue == "0")
        {
            trConfig1.Style.Add("display", "none");
            trConfig2.Style.Add("display", "none");
            trBtnSave.Style.Add("display", "none");
        }
    }
    private void BindConfigMaster()
    {
        long retCode = -1;
        try
        {
            string ConfigType = ddlConfigType.SelectedValue;
            retCode = new GateWay(base.ContextInfo).GetConfigKeyDetails(OrgID, ConfigType, out lstConfigKeyMaster, out lstConfigOrgMaster, out lstConfigValueMaster, out lstLocations);

            new PatientVisit_BL(base.ContextInfo).GetLocation(OrgID, LID, 0, out lstOrganizationAddress);

            if (ConfigType == "PRM")
            {
                gvConfig.DataSource = lstConfigKeyMaster.FindAll(p => p.ConfigType.Trim() == "PRM" && p.IsAddressBased.Trim() == "N");
                gvConfig.DataBind();



                //gvSubConfig.DataSource = (from lst in lstLocations
                //                          group lst by new
                //                          {
                //                              lst.OrgAddressID,
                //                              lst.OrgAddressName,
                //                              lst.OrgID
                //                          } into g
                //                          select new Locations
                //                          {
                //                              OrgAddressID = g.Key.OrgAddressID,
                //                              OrgID = g.Key.OrgID,
                //                              OrgAddressName = g.Key.OrgAddressName
                //                          }).Distinct();


                gvSubConfig.DataSource = lstOrganizationAddress;
                gvSubConfig.DataBind();

            }
            if (ConfigType == "HOS")
            {
                gvConfig.DataSource = lstConfigKeyMaster.FindAll(p => p.ConfigType.Trim() == "HOS" && p.IsAddressBased.Trim() == "N");
                gvConfig.DataBind();

                gvSubConfig.DataSource = "";
                gvSubConfig.DataBind();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - Config.aspx", ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void gvConfig_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            long ConfigValueID = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                tdBtns.Style.Add("display", "table-cell");
                ConfigKeyMaster objkey = (ConfigKeyMaster)e.Row.DataItem;
                DropDownList objddl = (DropDownList)e.Row.FindControl("ddlConfigValue");
                HiddenField hdnConfigID = (HiddenField)e.Row.FindControl("hdnConfigID");
                TextBox objtxt = (TextBox)e.Row.FindControl("txtConfigValue");
                RadioButtonList objrdo = (RadioButtonList)e.Row.FindControl("rdoConfigValue");
                CheckBox objchk = (CheckBox)e.Row.FindControl("chkConfigValue");
                HiddenField hdnConfigKey = (HiddenField)e.Row.FindControl("hdnConfigKey");
                HiddenField hdnConfigValue = (HiddenField)e.Row.FindControl("hdnConfigValue");
                HiddenField hdnConfigKeyID = (HiddenField)e.Row.FindControl("hdnConfigKeyID");
                HiddenField hdnConfigType = (HiddenField)e.Row.FindControl("hdnConfigType");

                Label hdnchgrows = (Label)e.Row.FindControl("lblchangesrow");
                if (lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                {
                    ConfigValueID = lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigID;
                    hdnConfigKey.Value = lstConfigKeyMaster.Find(p => p.ConfigKeyID == objkey.ConfigKeyID).ConfigKey;
                    hdnConfigValue.Value = lstConfigKeyMaster.Find(p => p.ConfigKeyID == objkey.ConfigKeyID).ConfigValue;
                    hdnStatus.Value = "Y";
                }
                if (objkey.IsInternal == "Y")
                {
                    e.Row.Visible = false;
                }
                hdnConfigID.Value = ConfigValueID.ToString();
                BindControlValues(objddl, objtxt, objrdo, objchk, objkey, hdnConfigID, hdnConfigKeyID, hdnConfigType, hdnConfigKey, hdnAddId);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - PrescriptionBilling.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void BindControlValues(DropDownList objddl, TextBox objtxt, RadioButtonList rdolist, CheckBox objChk, ConfigKeyMaster objkey, HiddenField hdnConfigID, HiddenField hdnConfigKeyID, HiddenField hdnConfigType, HiddenField hdnConfigKey, HiddenField hdnAddID)
    {
        switch (objkey.ControlType)
        {
            case "RDO":
                if (lstConfigValueMaster.Count > 0 && lstConfigValueMaster.Exists(p => p.ConfigKeyID == objkey.ConfigKeyID))
                {
                    rdolist.DataSource = lstConfigValueMaster.FindAll(p => p.ConfigKeyID == objkey.ConfigKeyID);
                    rdolist.DataTextField = "ConfigValue";
                    rdolist.DataValueField = "ConfigValueID";
                    rdolist.DataBind();
                    {
                        if (lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                        {
                            if (rdolist.Items.FindByText(lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigValue) != null)
                            {
                                rdolist.Items.FindByText(lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigValue).Selected = true;
                            }
                        }
                        else
                        {
                            rdolist.Items[0].Selected = true;
                        }
                    }
                }
                rdolist.Attributes.Add("onClick", "GetModifiedValue('" + rdolist.ClientID + "','" + hdnConfigID.Value + "','" + hdnConfigKeyID.Value + "','" + objkey.ControlType + "','" + hdnConfigType.Value + "','" + hdnConfigKey.Value + "','" + hdnAddId.Value + "')");
                rdolist.Visible = true;
                break;

            case "TEXT":
                if (objkey.ValueType != "String")
                {
                    objtxt.Attributes.Add("onKeyDown", "return validatenumber(event);");
                }
                if (lstConfigOrgMaster.Count > 0 && lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                {
                    objtxt.Text = lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigValue;
                }
                objtxt.Attributes.Add("onBlur", "GetModifiedValue('" + objtxt.ClientID + "','" + hdnConfigID.Value + "','" + hdnConfigKeyID.Value + "','" + objkey.ControlType + "','" + hdnConfigType.Value + "','" + hdnConfigKey.Value + "','" + hdnAddId.Value + "')");
                objtxt.Visible = true;
                break;
            case "DDL":
                objddl.DataSource = "";
                if (lstConfigValueMaster.Count > 0 && lstConfigValueMaster.Exists(p => p.ConfigKeyID == objkey.ConfigKeyID && p.IsTableReference != null && p.IsTableReference.Trim() == "N"))
                {
                    objddl.DataSource = lstConfigValueMaster.FindAll(p => p.ConfigKeyID == objkey.ConfigKeyID && p.IsTableReference.Trim() == "N");
                    objddl.DataTextField = "ConfigValue";
                    objddl.DataValueField = "ConfigValue";
                    if (lstConfigOrgMaster.Count > 0 && lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                    {
                        objddl.SelectedValue = lstConfigOrgMaster.Find(p => p.ConfigKeyID == objkey.ConfigKeyID).ConfigValue.ToString();
                    }
                }
                if (lstConfigValueMaster.Count > 0 && lstConfigValueMaster.Exists(p => p.ConfigKeyID == objkey.ConfigKeyID && p.IsTableReference.Trim() == "Y" && p.ConfigValue.Trim() == "InventoryLocations"))
                {
                    objddl.DataSource = lstLocations.FindAll(p => p.OrgID == OrgID && p.OrgAddressID == Convert.ToInt32(hdnAddId.Value));
                    objddl.DataTextField = "LocationName";
                    objddl.DataValueField = "LocationID";
                    //if (lstConfigOrgMaster.Count > 0 && lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                    //{
                    //    objddl.SelectedValue = lstConfigOrgMaster.Find(p => p.ConfigKeyID == objkey.ConfigKeyID).ConfigValue.ToString();
                    //}
                    //hdnAddId.Value = "0";
                }
                objddl.Attributes.Add("onChange", "GetModifiedValue('" + objddl.ClientID + "','" + hdnConfigID.Value + "','" + hdnConfigKeyID.Value + "','" + objkey.ControlType + "','" + hdnConfigType.Value + "','" + hdnConfigKey.Value + "','" + hdnAddId.Value + "')");
                objddl.DataBind();
                objddl.Visible = true;
                break;
            case "CHB":

                objChk.Checked = false;

                if (lstConfigOrgMaster.Count > 0 && lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                {
                    string str = lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigValue;
                    if (str == "Y")
                    {
                        objChk.Checked = true;
                    }
                }
                objChk.Attributes.Add("onClick", "GetModifiedValue('" + objChk.ClientID + "','" + hdnConfigID.Value + "','" + hdnConfigKeyID.Value + "','" + objkey.ControlType + "','" + hdnConfigType.Value + "','" + hdnConfigKey.Value + "','" + hdnAddId.Value + "')");
                objChk.Visible = true;
                break;

            default:
                if (objkey.IsInternal == "Y")
                {
                    objtxt.Text = objkey.DisplayText;
                    if (lstConfigOrgMaster.Count > 0 && lstConfigOrgMaster.Exists(P => P.ConfigKeyID == objkey.ConfigKeyID))
                    {
                        objtxt.Text = lstConfigOrgMaster.Find(P => P.ConfigKeyID == objkey.ConfigKeyID).ConfigValue;
                    }
                }
                objtxt.Attributes.Add("onBlur", "GetModifiedValue('" + objtxt.ClientID + "','" + hdnConfigID.Value + "','" + hdnConfigKeyID.Value + "','" + objkey.ControlType + "','" + hdnConfigType.Value + "','" + hdnConfigKey.Value + "','" + hdnAddId.Value + "')");
                break;
        }
    }
    protected void gvSubConfig_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        e.Row.Visible = DataControlRowType.Header == e.Row.RowType ? false : true;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField AddID = (HiddenField)e.Row.FindControl("hdnAddressId");
            hdnAddId.Value = AddID.Value;
            GridView grdInner = (GridView)e.Row.FindControl("grdInner");
            OrganizationAddress objLoc = (OrganizationAddress)e.Row.DataItem;
            grdInner.DataSource = lstConfigKeyMaster.FindAll(p => p.ConfigType.Trim() == "PRM" && p.IsAddressBased.Trim() == "Y");
            grdInner.DataBind();

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //--Comment by Gurunath.S
        //long returnCode = -1;
        //GetConfigValueList();
        //returnCode = new GateWay(base.ContextInfo).SaveConfigMaster(lstConfigOrgMaster, OrgID, LID);

        //BindConfigMaster();
        //if (hdnStatus.Value == "Y")
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Ale", "javascript:alert('Changes saved successfully.');", true);
        //}
        //if (hdnStatus.Value == "N")
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Ale", "javascript:alert('Changes saved successfully.');", true);
        //}


        //----Added by Gurunath.S
        try
        {
            long returnCode = -1;
            List<ConfigOrgMaster> lstMDYConfigOrgMaster = new List<ConfigOrgMaster>();
            foreach (string strConfig in hdnModifiedValues.Value.Split('^'))
            {
                if (strConfig != null & strConfig != "")
                {
                    ConfigOrgMaster objCOM = new ConfigOrgMaster();
                    objCOM.ConfigID = Convert.ToInt64(strConfig.Split('~')[0]);
                    objCOM.ConfigKeyID = Convert.ToInt64(strConfig.Split('~')[1]);
                    objCOM.ConfigValue = strConfig.Split('~')[2];
                    objCOM.ConfigType = strConfig.Split('~')[3];
                    objCOM.ConfigKey = strConfig.Split('~')[4];
                    objCOM.OrgAddressId = Convert.ToInt64(strConfig.Split('~')[5]);
                    lstMDYConfigOrgMaster.Add(objCOM);
                }
            }
            returnCode = new GateWay(base.ContextInfo).SaveConfigMaster(lstMDYConfigOrgMaster, OrgID, LID);
            if (returnCode > 0)
            {
                string sPath = "ConfigSetting\\\\ConfigMaster.aspx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
                //                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:alert('Changes saved successfully.');", true);
            }
            BindConfigMaster();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving ConfigOrgMaster() in btnSave()", ex);
        }
    }

    #region Commented By Guruanth.S
    //private void GetConfigValueList()
    //{
    //    List<ConfigOrgMaster> lstorgmst = new List<ConfigOrgMaster>();
    //    var s = hdnchangesstat.Value.ToString();
    //    string[] p = hdnchangesstat.Value.Split('~');
    //    foreach (GridViewRow item in gvConfig.Rows)
    //    {



    //        HiddenField hdnConfigKeyID = (HiddenField)item.FindControl("hdnConfigKeyID");
    //        HiddenField hdnControlType = (HiddenField)item.FindControl("hdnControlType");
    //        DropDownList objddl = (DropDownList)item.FindControl("ddlConfigValue");
    //        TextBox objtxt = (TextBox)item.FindControl("txtConfigValue");
    //        RadioButtonList objrdo = (RadioButtonList)item.FindControl("rdoConfigValue");
    //        HiddenField hdnConfigID = (HiddenField)item.FindControl("hdnConfigID");
    //        CheckBox objchk = (CheckBox)item.FindControl("chkConfigValue");
    //        HiddenField hdnConfigType = (HiddenField)item.FindControl("hdnConfigType");
    //        HiddenField hdnConfigValue = (HiddenField)item.FindControl("hdnConfigValue");
    //        HiddenField hdnConfigKey = (HiddenField)item.FindControl("hdnConfigKey");
    //        HiddenField hdnSubAddressId = (HiddenField)item.FindControl("hdnSubAddressId");
    //        Label hdnchgrows = (Label)item.FindControl("lblchangesrow");
    //        for (int i = 0; i < s.Length; i++)
    //        {
    //            if (s[i].ToString() == hdnchgrows.Text)
    //            {

    //                ConfigOrgMaster objorgMapping = new ConfigOrgMaster();
    //                objorgMapping.ConfigKeyID = Int64.Parse(hdnConfigKeyID.Value);
    //                objorgMapping.ConfigID = Int64.Parse(hdnConfigID.Value);
    //                objorgMapping.ConfigType = hdnConfigType.Value;
    //                objorgMapping.ConfigKey = hdnConfigKey.Value;
    //                objorgMapping.ConfigValue = hdnConfigValue.Value;
    //                switch (hdnControlType.Value)
    //                {
    //                    case "RDO":
    //                        objorgMapping.ConfigValue = objrdo.SelectedItem.Text;
    //                        break;
    //                    case "TEXT":
    //                        objorgMapping.ConfigValue = objtxt.Text.Trim(); ;
    //                        break;
    //                    case "DDL":
    //                        objorgMapping.ConfigValue = objddl.SelectedItem.Text;
    //                        break;
    //                    case "CHB":
    //                        objorgMapping.ConfigValue = "N";
    //                        if (objchk.Checked)
    //                        {
    //                            objorgMapping.ConfigValue = "Y";
    //                        }
    //                        break;
    //                    default:
    //                        objorgMapping.ConfigValue = objtxt.Text.Trim(); ;
    //                        break;
    //                }

    //                lstorgmst.Add(objorgMapping);
    //            }
    //        }
    //    }
    //    //lstConfigOrgMaster = (from ss in lstorgmst
    //    //                      where ss.ConfigKeyID )
    //    //                      select ss).ToList();
    //    GetInnerConfigValueList();

    //}
    //private void GetInnerConfigValueList()
    //{
    //    GridView gvSubConfig = (GridView)FindControl("gvSubConfig");
    //    for (int i = 0; i < gvSubConfig.Rows.Count; i++)
    //    {
    //        if (gvSubConfig.Rows[i].RowType == DataControlRowType.DataRow)
    //        {
    //            GridView grdInner = (GridView)gvSubConfig.Rows[i].FindControl("grdInner");
    //            HiddenField hdnAddressId = (HiddenField)gvSubConfig.Rows[i].FindControl("hdnAddressId");
    //            foreach (GridViewRow item in grdInner.Rows)
    //            {

    //                DropDownList objddl = (DropDownList)item.FindControl("ddlConfigValue");
    //                TextBox objtxt = (TextBox)item.FindControl("txtConfigValue");
    //                RadioButtonList objrdo = (RadioButtonList)item.FindControl("rdoConfigValue");
    //                CheckBox objchk = (CheckBox)item.FindControl("chkConfigValue");

    //                HiddenField hdnConfigID = (HiddenField)item.FindControl("hdnConfigID");
    //                HiddenField hdnConfigKeyID = (HiddenField)item.FindControl("hdnConfigKeyID");
    //                HiddenField hdnControlType = (HiddenField)item.FindControl("hdnControlType");
    //                HiddenField hdnConfigType = (HiddenField)item.FindControl("hdnConfigType");
    //                HiddenField hdnConfigKey = (HiddenField)item.FindControl("hdnConfigKey");
    //                HiddenField hdnConfigValue = (HiddenField)item.FindControl("hdnConfigValue");

    //                ConfigOrgMaster objorgMapping1 = new ConfigOrgMaster();
    //                objorgMapping1.ConfigKeyID = Int64.Parse(hdnConfigKeyID.Value);
    //                objorgMapping1.ConfigID = Int64.Parse(hdnConfigID.Value);
    //                objorgMapping1.ConfigType = hdnConfigType.Value;
    //                objorgMapping1.ConfigValue = hdnConfigValue.Value;
    //                objorgMapping1.OrgAddressId = Int32.Parse(hdnAddressId.Value);
    //                objorgMapping1.ConfigKey = hdnConfigKey.Value;

    //                switch (hdnControlType.Value)
    //                {
    //                    case "RDO":
    //                        objorgMapping1.ConfigValue = objrdo.SelectedItem.Text;
    //                        break;
    //                    case "TEXT":
    //                        objorgMapping1.ConfigValue = objtxt.Text.Trim(); ;
    //                        break;
    //                    case "DDL":
    //                        objorgMapping1.ConfigValue = objddl.SelectedValue;
    //                        break;
    //                    case "CHB":
    //                        objorgMapping1.ConfigValue = "N";
    //                        if (objchk.Checked)
    //                        {
    //                            objorgMapping1.ConfigValue = "Y";
    //                        }
    //                        break;
    //                    default:
    //                        objorgMapping1.ConfigValue = objtxt.Text.Trim(); ;
    //                        break;
    //                }

    //                lstConfigOrgMaster.Add(objorgMapping1);
    //            }
    //        }
    //    }
    //}
    #endregion

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

}
