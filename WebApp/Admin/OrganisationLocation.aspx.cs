﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using System.Web.Script.Serialization;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;
using System.Data.SqlClient;


public partial class Admin_OrganisationLocation : BasePage
{

    public Admin_OrganisationLocation()
        : base("Admin_OrganisationLocation_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    long Returncode = -1;
    AdminReports_BL objBl = new AdminReports_BL();
    List<Organization> lstOrg = new List<Organization>();
    List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
    List<Country> lstCountry = new List<Country>();
    List<Localities> LOC = new List<Localities>();
    List<InvClientMaster> lstClient = new List<InvClientMaster>();
    List<InvClientMaster> lstRemoveClient = new List<InvClientMaster>();
    List<ClientMaster> lstOrgLocationClient = new List<ClientMaster>();
    List<ClientMaster> lstDefLocationClient = new List<ClientMaster>();
    UserAddress useAddress = new UserAddress();
    int chid;
    long Addid;
    static long ADID;
    string AddressID;
    List<MetaValue_Common> lstMetavalue = new List<MetaValue_Common>();
    string select = Resources.Admin_AppMsg.Admin_drpSelect == null ? "--Select--" : Resources.Admin_AppMsg.Admin_drpSelect;
    string stralert = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_Alert;
    string strsave = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_13 == null ? "Saved Successfully!" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_13;
    string strUpdate = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_14 == null ? "Updated Successfully!" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_14;
    byte[] Logo1 = new byte[0];
    string strbtnsave = Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_08 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_08;
    string strbtnupdate = Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_09 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_OrganisationLocation_aspx_09;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "SIT";
            AutoCompleteExtender2.ContextKey = "TIS";
            AutoCompleteExtender3.ContextKey = "CIT";
            AutoCompleteExtender4.ContextKey = "TIC";
            AutoCompleteExtender5.ContextKey = "KIC";

        }
        try
        {
            if (!IsPostBack)
            {
                loadOrganization();
                ddlOrglocation_SelectedIndexChanged(sender, e);
                LoadMetaData();
                CenterType();
                loadHUB();
                loadZONE();
                loadROUTE();


                Label lbl =(Label)ucPAdd.FindControl("lblCutOffTime");
                lbl.Style.Add("display","block");
                TextBox txt = (TextBox)ucPAdd.FindControl("txtCOTValue");
                txt.Style.Add("display", "block");
                DropDownList drp = (DropDownList)ucPAdd.FindControl("ddlCOTType");
                drp.Style.Add("display", "block");

            }
            hdnsave.Value = strsave;
            loadLocationClient();
            AutoCompleteExtender6.ContextKey = "-1";
            AutoCompleteExtender7.ContextKey = "-2";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in OrganizationLocation Page Loading", ex);
        }
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "PackageStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL().LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "PackageStatus" //orderby child .MetaDataID
                                 select child;
                ddlstatus.DataSource = childItems;
                ddlstatus.DataTextField = "DisplayText";
                ddlstatus.DataValueField = "Code";
                ddlstatus.DataBind();
                ddlstatus.Items.Insert(0, select);
                ddlstatus.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }

    public void CenterType()
    {
        long returncode = 0;
        returncode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "CENT", out lstMetavalue);
        drpcentertype.DataSource = lstMetavalue;
        drpcentertype.DataTextField = "Value";
        drpcentertype.DataValueField = "Code";
        drpcentertype.DataBind();
        drpcentertype.Items.Insert(0, select);
        drpcentertype.Items[0].Value = "0";

    }
    public void loadOnlyMappedClients(Object sender, EventArgs e)
    {
        string strNoMatchRec = Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20 == null ? "No Matching Records Found" : Resources.Admin_AppMsg.Admin_OrganisationLocation_aspx_20;
        try
        {
            objBl = new AdminReports_BL(base.ContextInfo);
            CheckBox chck = (CheckBox)sender;
            if (chck.Checked == true)
            {
                objBl = new AdminReports_BL(base.ContextInfo);
                if (hdnAddressID.Value == "")
                {
                    hdnAddressID.Value = "0";
                }
                if (hdnAddressID.Value != "0")
                {
                    Returncode = objBl.GetMappedAndDefaultClient(Convert.ToInt64(ddlOrglocation.SelectedItem.Value), Convert.ToInt64(hdnAddressID.Value), out lstDefLocationClient);
                    grdResults.DataSource = lstDefLocationClient;
                    NewTbl.Width = "90%";
                   
                    if (lstDefLocationClient.Count == 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ValidationWindow('" + strNoMatchRec + "','" + stralert + "');", true);
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + strNoMatchRec + "','" + stralert + "');", true);
                    ChkselectMappedClient.Checked = false;
                }
            }
            else
            {
                Returncode = objBl.GetOrganizationLocationClient(Convert.ToInt64(ddlOrglocation.SelectedItem.Value), out lstOrgLocationClient);
                grdResults.DataSource = lstOrgLocationClient;
            }
            grdResults.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading loadOnlyMappedClients ", ex);
        }
    }
    public void loadOrganization()
    {
        try
        {
            objBl = new AdminReports_BL(base.ContextInfo);
            Returncode = objBl.pGetOrgLoction(out lstOrg);
          lstOrg= lstOrg.FindAll(p=>p.OrgID==OrgID);
           
            if (lstOrg.Count > 0)
            {
                ddlOrglocation.DataSource = lstOrg;
                ddlOrglocation.DataTextField = "Name";
                ddlOrglocation.DataValueField = "OrgID";
                ddlOrglocation.DataBind();
            }
            else
            {
                ddlOrglocation.DataSource = null;
                ddlOrglocation.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    public void loadOrganizationLocation()
    {
        try
        {
            chid = 0;
            Addid = 0;
            grdOrgLocation.Visible = true;
            hdnLocationCode.Value = "";
            objBl = new AdminReports_BL(base.ContextInfo);
            Returncode = objBl.pGetOrganizationLocation(Convert.ToInt64(ddlOrglocation.SelectedItem.Value), Addid, chid, out lstOrgLocation);
            lstOrgLocation = lstOrgLocation.FindAll(p => p.OrgID == OrgID);
            grdOrgLocation.DataSource = lstOrgLocation;
            grdOrgLocation.DataBind();
            hdnLocationCode.Value = "";
            foreach (var item in lstOrgLocation)
            {
                if (item.LocationCode.Trim() != "")
                {
                    hdnLocationCode.Value += item.LocationCode.Trim() + "~" + item.AddressID +"~"+item.CenterTypeCode+ "^";
                }
            }

            loadLocationClient();

            TgrdOrgLocation.Style.Add("display", "block");
            tOrglocation.Style.Add("display", "None");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    public void loadLocationClient()
    {
        objBl = new AdminReports_BL(base.ContextInfo);
        Returncode = objBl.GetOrganizationLocationClient(Convert.ToInt64(ddlOrglocation.SelectedItem.Value), out lstOrgLocationClient);
        grdResults.DataSource = lstOrgLocationClient;
        grdResults.DataBind();

    }
    protected void PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdResults.PageIndex = e.NewPageIndex;
        grdResults.DataBind();
    }
    protected void grdOrgLocation_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               //.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                //Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdOrgLocation, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading User Details to Change or Remove", ex);
        }
    }
    protected void grdOrgLocation_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
    }
    protected void grdOrgLocation_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            long ADDId = Convert.ToInt64(grdOrgLocation.DataKeys[e.RowIndex].Values[0].ToString());
            string txtcity = grdOrgLocation.DataKeys[e.RowIndex].Values[1].ToString();
            string txtlocation = grdOrgLocation.DataKeys[e.RowIndex].Values[2].ToString();
            long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
            Physician_BL perphy = new Physician_BL(base.ContextInfo);
            int IsScanInScanOut = ChkIsScanInScanOut.Checked ? 1 : 0;
            string CenterTypeCode = "";
            string isdefault = "";
            string ismappedclients = "";
            string status = "";
            byte[] Logo = null;
            useAddress = ucPAdd.GetAddress1();
            string type = "Delete";
            if (useAddress.Add1 == "")
            {
                useAddress.PostalCode = "0";
                useAddress.MobileNumber = "0";
                useAddress.LandLineNumber = "0";
            }
            objBl = new AdminReports_BL(base.ContextInfo);
            returnCode = objBl.IDUOrgLocation(orgID, useAddress, txtlocation, type, ADDId, txtcity, CenterTypeCode, isdefault, ismappedclients,status, "",Logo, lstClient, lstRemoveClient,IsScanInScanOut, out lstOrgLocation);
            loadOrganizationLocation();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
        }
        grdOrgLocation.EditIndex = -1;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetClientDetails();
        txtClientNameSrch.Text = "";
        txtClientCodeSrch.Text = "";
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        loadLocationClient();
        txtClientNameSrch.Text = "";
        txtClientCodeSrch.Text = "";
    }
    public void GetClientDetails()
    {
        try
        {
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<ClientReportTemplate> lstinvmasters = new List<ClientReportTemplate>();
            List<ClientMaster> lstborg = new List<ClientMaster>(); 
            lstinvmasters.Clear();
            long returncode = -1;
            long ClientID = 0;
            if ((txtClientNameSrch.Text.Trim() != "" && txtClientNameSrch.Text.Length > 2) || txtClientCodeSrch.Text.Trim() != "")
            {
                masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstborg);
            }
            grdResults.DataSource = lstborg;
            grdResults.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting client - Invoicemaster.aspx", ex);
        }
    }
    protected void grdOrgLocation_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ACTIVE")
        {
            long returnCode = -1;
            try
            {
                long ADDId = Convert.ToInt64(grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString());
                string txtcity = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
                string txtlocation = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
                long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
                Physician_BL perphy = new Physician_BL(base.ContextInfo);
                int IsScanInScanOut = ChkIsScanInScanOut.Checked ? 1 : 0;
                string CenterTypeCode = "";
                string isdefault = "";
                string ismappedclients = "";
                string status = "";
                byte[] Logo = null;
                useAddress = ucPAdd.GetAddress1();
                string type = "Active";
                if (useAddress.Add1 == "")
                {
                    useAddress.PostalCode = "0";
                    useAddress.MobileNumber = "0";
                    useAddress.LandLineNumber = "0";
                }
                objBl = new AdminReports_BL(base.ContextInfo);
                returnCode = objBl.IDUOrgLocation(orgID, useAddress, txtlocation, type, ADDId, txtcity, CenterTypeCode, isdefault, ismappedclients, status, "",Logo, lstClient, lstRemoveClient,IsScanInScanOut, out lstOrgLocation);
                loadOrganizationLocation();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
            }
        }

        if (e.CommandName == "UPDATE")
        {
            long returnCode = -1;
            try
            {
                chid = 1;
                btnSaveLocation.Text = strbtnupdate;
                hdnAddressID.Value = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
                long ADDId = Convert.ToInt64(grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString());
                string txtcity = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
                string txtlocation = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
                long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
                txtCode.Text = grdOrgLocation.DataKeys[Convert.ToInt32(e.CommandArgument)][4].ToString();
                objBl = new AdminReports_BL(base.ContextInfo);
                returnCode = objBl.pGetOrganizationLocation(Convert.ToInt64(ddlOrglocation.SelectedItem.Value), ADDId, chid, out lstOrgLocation);
                //drpcentertype.SelectedValue = lstOrgLocation[0].CenterTypeCode;
                chkisdefault.Checked = lstOrgLocation[0].IsDefault.Trim() == "Y" ? true : false;
                chkismappedclients.Checked = lstOrgLocation[0].IsMappedClients.Trim() == "Y" ? true : false;
                ChkIsScanInScanOut.Checked = lstOrgLocation[0].IsScanInScanOutRequired == true ? true : false;
                ddlstatus.SelectedValue = lstOrgLocation[0].Status.ToString() == "" ? "0" : lstOrgLocation[0].Status.ToString();
                drpcentertype.SelectedValue = lstOrgLocation[0].CenterTypeCode.ToString();
                if (lstOrgLocation.Count > 0)//count 
                {
                    if (lstOrgLocation[0].Logo != null)
                    {
                        hdnImagevalue.Value = Convert.ToBase64String(lstOrgLocation[0].Logo);
                        byte[] Logo = new byte[0];
                        Logo = lstOrgLocation[0].Logo;
                        if (lstOrgLocation[0].Logo != null && lstOrgLocation[0].Logo.Length > 0)
                        {
                            if (Logo.Length > 0)
                            {
                                imgProfile.ImageUrl = "ImageHandler.ashx?ddlOrglocation=" + ddlOrglocation.SelectedItem.Value.ToString() + "&ADDId=" + ADDId + "&chid=" + chid;
                                imgProfile.Visible = true;
                            }
                        }
                    }
                }
                // string status = ddlstatus.SelectedValue.ToString();
                txtOrgLocation.Text = lstOrgLocation[0].Location;
                ADID = Convert.ToInt64(lstOrgLocation[0].AddressID.ToString());
                hdnAddressID.Value =  lstOrgLocation[0].AddressID.ToString();
                ucPAdd.SetAddresstoEdit1(lstOrgLocation);
                 loadOrganizationLocation();
                ChkselectMappedClient.Checked = false;
                TgrdOrgLocation.Style.Add("display", "None");
                tOrglocation.Style.Add("display", "block");
                foreach (var item in lstOrgLocation)
                {
                    if (item.LocationCode.Trim() != "")
                    {
                        hdncenterTypeCode.Value += item.LocationCode.Trim() + "~" + item.AddressID + "~" + item.CenterTypeCode + "^";
                    }
                }
                loadLocationClient();

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Update OrganizationLocation", ex);
            }
        }
    }
    protected void grdOrgLocation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex == grdOrgLocation.PageCount)
        {
        }
        if (e.NewPageIndex >= 0)
        {
            grdOrgLocation.PageIndex = e.NewPageIndex;
            loadOrganizationLocation();
        }
    }
    protected void ddlOrglocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadOrganizationLocation();
    }
    protected void btnsave_Click1(object sender, EventArgs e)
    {
        DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00");
        if (btnSaveLocation.Text == strbtnsave)
        {
            useAddress = ucPAdd.GetAddress1();
            string LocationCode = txtCode.Text.Trim() != "" ? txtCode.Text.Trim().ToUpper() : string.Empty;
            string CenterTypeCode = drpcentertype.SelectedValue;
            string isdefault = chkisdefault.Checked ? "Y" : "N";
            int IsScanInScanOut = ChkIsScanInScanOut.Checked ? 1 : 0;
            if (CenterTypeCode == "PCS")
            {
                isdefault = "Y";
            }
            string ismappedclients = chkismappedclients.Checked ? "Y" : "N";
            string status = ddlstatus.SelectedValue.ToString();
            //if (ddlstatus.SelectedValue == "Active")
            //{
            //    status = "A";
            //}
            //else
            //{
            //    status = "D";
            //}
            long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
            string type = "Insert";
            string[] MapClientId = hdnMapClientId.Value.Split('^');
            string DefaultclientId = hdnIsDefaultClientId.Value;
            byte[] Logo = new byte[0];;
            
            if (FileUpload1.HasFile)
            {
                Logo = ConvertImageToByteArray(FileUpload1);
            }
            else
            {
                Logo = Convert.FromBase64String(hdnImagevalue.Value); ;
            }
            if (hdnMapClientId.Value != "")
            {
                string[] value = hdnMapClientId.Value.Split('^');
                int count = value.Length;
                for (int i = 0; i < count; i++)
                {
                    InvClientMaster objClient = new InvClientMaster();
                    objClient.ClientID = Convert.ToInt64(value[i]);
                    objClient.ValidFromTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidToTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidFrom = MinDate;
                    objClient.ValidTo = MinDate;
                    if (value[i] == DefaultclientId)
                    {
                        objClient.Type = "Y";
                    }
                    else
                    {
                        objClient.Type = "N";
                    }
                    lstClient.Add(objClient);
                    i++;
                }
            }
            if (hdnRemoveClientId.Value != "")
            {
                string[] value1 = hdnRemoveClientId.Value.Split('^');
                int count1 = value1.Length;
                for (int j = 0; j < count1; j++)
                {
                    InvClientMaster objClient = new InvClientMaster();
                    objClient.ClientID = Convert.ToInt64(value1[j]);
                    objClient.ValidFromTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidToTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidFrom = MinDate;
                    objClient.ValidTo = MinDate;
                    lstRemoveClient.Add(objClient);
                }
            }
            objBl = new AdminReports_BL(base.ContextInfo);
            Returncode = objBl.IDUOrgLocation(orgID, useAddress, txtOrgLocation.Text.Trim(), type, 0, LocationCode, CenterTypeCode, isdefault, ismappedclients, status, DefaultclientId,Logo,lstClient, lstRemoveClient,IsScanInScanOut, out lstOrgLocation);
            clear();
            loadOrganizationLocation();
            hdnMapClientId.Value = "";
            hdnRemoveClientId.Value = "";
        }
        if (btnSaveLocation.Text == strbtnupdate)
        {
            useAddress = ucPAdd.GetAddress1();
            string LocationCode = txtCode.Text.Trim() != "" ? txtCode.Text.Trim().ToUpper() : string.Empty;
            string loction = txtOrgLocation.Text;
            long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
            string isdefault = chkisdefault.Checked ? "Y" : "N";
            string ismappedclients = chkismappedclients.Checked ? "Y" : "N";
            int IsScanInScanOut = ChkIsScanInScanOut.Checked ? 1 : 0;
            string status = ddlstatus.SelectedValue.ToString();
            string CenterTypeCode = drpcentertype.SelectedValue;
            string DefaultclientId = hdnIsDefaultClientId.Value;
            byte[] Logo = new byte[0];
            if (hdnMapClientId.Value != "")
            {
                string[] value = hdnMapClientId.Value.Split('^');
                int count = value.Length - 1;
                for (int i = 0; i <= count; i++)
                {
                    InvClientMaster objClient = new InvClientMaster();
                    objClient.ClientID = Convert.ToInt64(value[i]);
                    objClient.ValidFromTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidToTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidFrom = MinDate;
                    objClient.ValidTo = MinDate;
                    if (value[i] == DefaultclientId)
                    {
                        objClient.Type = "Y";
                    }
                    else
                    {
                        objClient.Type = "N";
                    }
                    if (hdnRemoveClientId.Value != "")
                    {
                        objClient.ClientAttributes = hdnRemoveClientId.Value;
                    }
                    lstClient.Add(objClient);
                }
            }
            if (hdnRemoveClientId.Value != "")
            {
                string[] value1 = hdnRemoveClientId.Value.Split('^');
                int count1 = value1.Length;
                for (int j = 0; j < count1; j++)
                {
                    InvClientMaster objClient = new InvClientMaster();
                    objClient.ClientID = Convert.ToInt64(value1[j]);
                    objClient.ValidFromTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidToTime = TimeSpan.Parse(MinDate.ToShortTimeString()); ;
                    objClient.ValidFrom = MinDate;
                    objClient.ValidTo = MinDate;
                    lstRemoveClient.Add(objClient);
                }
            }

            if (FileUpload1.HasFile)
            {
                Logo = ConvertImageToByteArray(FileUpload1);
            }
            else
            {
                Logo = Convert.FromBase64String(hdnImagevalue.Value); ;
            }
            string type = "Update";
            objBl = new AdminReports_BL(base.ContextInfo);
            Returncode = objBl.IDUOrgLocation(orgID, useAddress, txtOrgLocation.Text, type, ADID, LocationCode, CenterTypeCode, isdefault, ismappedclients, status, DefaultclientId,Logo, lstClient, lstRemoveClient,IsScanInScanOut, out lstOrgLocation);
            loadOrganizationLocation();
            btnSaveLocation.Text = strbtnsave;
            hdnMapClientId.Value = "";
            hdnRemoveClientId.Value = "";
        }
    }
    protected void btnUpdate_Click1(object sender, EventArgs e)
    {
        useAddress = ucPAdd.GetAddress1();
        string LocationCode = txtCode.Text.Trim() != "" ? txtCode.Text.Trim().ToUpper() : string.Empty;
        string loction = txtOrgLocation.ToString();
        long orgID = Convert.ToInt64(ddlOrglocation.SelectedItem.Value);
        string isdefault = chkisdefault.Checked ? "Y" : "N";
        string ismappedclients = chkismappedclients.Checked ? "Y" : "N";
        int IsScanInScanOut = ChkIsScanInScanOut.Checked ? 1 : 0;
        string status = ddlstatus.SelectedValue.ToString();
        string CenterTypeCode = drpcentertype.SelectedValue;
        byte[] Logo = null;
        string type = "Update";
        objBl = new AdminReports_BL(base.ContextInfo);
        Returncode = objBl.IDUOrgLocation(orgID, useAddress, txtOrgLocation.Text, type,0, LocationCode, CenterTypeCode, isdefault, ismappedclients, status, "",Logo, lstClient, lstRemoveClient,IsScanInScanOut, out lstOrgLocation);
        clear();
    }
    protected void clear()
    {
        useAddress = ucPAdd.GetAddress1();
        txtOrgLocation.Text = "";
        ucPAdd.clearAddress();
        hdnMapClientId.Value = "";
        hdnRemoveClientId.Value = "";
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        TgrdOrgLocation.Style.Add("display", "None");
        tOrglocation.Style.Add("display", "block");
        txtOrgLocation.Text = "";
        txtCode.Text = "";
        ucPAdd.clearAddress();
        hdnAddressID.Value = "";
        btnSaveLocation.Text = strbtnsave;
        loadLocationClient();
    }

    protected void grdResults_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ClientMaster CM = (ClientMaster)e.Row.DataItem;
            string strScript = "SelectRow('" + ((RadioButton)e.Row.Cells[1].FindControl("rdioSel")).ClientID + "','" + CM.ClientID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdioSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdioSel")).Attributes.Add("onclick", strScript);

            string DespatchScript = "SelectClientRow('" + ((CheckBox)e.Row.Cells[1].FindControl("Chkselect")).ClientID + "','" + CM.ClientID + "');";
            ((CheckBox)e.Row.Cells[1].FindControl("Chkselect")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((CheckBox)e.Row.Cells[1].FindControl("Chkselect")).Attributes.Add("onclick", DespatchScript);

            objBl = new AdminReports_BL(base.ContextInfo);
            if (hdnAddressID.Value == "")
            {
                hdnAddressID.Value = "0";
            }
            Returncode = objBl.GetMappedAndDefaultClient(Convert.ToInt64(ddlOrglocation.SelectedItem.Value),Convert.ToInt64(hdnAddressID.Value), out lstDefLocationClient);
            if (hdnAddressID.Value != "0")
            {
            for (int j = 0; j <= (lstDefLocationClient.Count) - 1; j++)
            {
                if (lstDefLocationClient[j].ClientCode == CM.ClientCode)
                {
                    ((CheckBox)e.Row.Cells[1].FindControl("Chkselect")).Checked = true;
                    if (lstDefLocationClient[j].ApprovalRequired == "Y")
                    {
                        ((RadioButton)e.Row.Cells[0].FindControl("rdioSel")).Checked = true;
                        }
                    }
                }
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        TgrdOrgLocation.Style.Add("display", "block");
        tOrglocation.Style.Add("display", "None");
        clear();
        btnSaveLocation.Text = strbtnsave;
    }
    protected void btnaddhub_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Type = "HUB";
            LOCAL.Locality_Code = txthubcode.Text.Trim();
            LOCAL.Locality_Value = txthubname.Text.Trim();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (HdnhubID.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(HdnhubID.Value);
            }
            returncode = physicianBL.Inserthubname(LOCAL);
            clears();
            loadHUB();
            div01.Attributes.Add("Style", "display:block");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:none");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returncode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }
            hdnbtnsave.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnsave_Click1", ex);
        }
    }

    protected void loadHUB()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesHub(orgid, out LOC);
            grddiv01.DataSource = LOC;
            grddiv01.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadHUB", ex);
        }
    }

    protected void grddiv01_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grddiv01.PageIndex = e.NewPageIndex;
        }
        loadHUB();
        div01.Attributes.Add("Style", "display:block");
        div02.Attributes.Add("Style", "display:none");
        div03.Attributes.Add("Style", "display:none");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);

    }
    protected void grddiv01_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
    protected void clears()
    {
        txthubcode.Text = string.Empty;
        txthubname.Text = string.Empty;
        HdnhubID.Value = string.Empty;
        txtzonecode.Text = string.Empty;
        txtzonename.Text = string.Empty;
        txtmaphub.Text = string.Empty;
        hdnzoneid.Value = string.Empty;
        txtroutecode.Text = string.Empty;
        txtroutename.Text = string.Empty;
        txtmapzone.Text = string.Empty;
        hdnrouteid.Value = string.Empty;
        txtsearchhubcode.Text = string.Empty;
        txtzonecode1.Text = string.Empty;
        txtroutecode1.Text = string.Empty;
        hdnMapHubID.Value = "";
        hdnMapZoneID.Value = "";
    }
    protected void btnsearchhub_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string hubcode = txtsearchhubcode.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.GetsearchHub(Orgid, hubcode, out local);
            clears();
            if (returnCode == 0)
            {
                //grddiv01.Visible = false;
                //grdsearchhub.Visible = true;
                grddiv01.DataSource = local;
                grddiv01.DataBind();
                txtsearchhubcode.Text = string.Empty;

            }
            div01.Attributes.Add("Style", "display:block");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:none");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchHub", ex);
        }


    }
    protected void loadZONE()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesZone(orgid, out LOC);
            Gridaddzone.DataSource = LOC;
            Gridaddzone.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadZONE", ex);
        }
    }

    //protected void grdsearchhub_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdsearchhub.PageIndex = e.NewPageIndex;
    //    }
    //    loadHUB();
    //    div01.Attributes.Add("Style", "display:block");
    //    div02.Attributes.Add("Style", "display:none");
    //    div03.Attributes.Add("Style", "display:none");
    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    //}
    //protected void grdsearchhub_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Localities Local = (Localities)e.Row.DataItem;
    //        string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel15")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "');";
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel15")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel15")).Attributes.Add("onclick", strScript);
    //    }
    //}
    protected void btnaddzone_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Locality_Code = txtzonecode.Text.Trim();
            LOCAL.Locality_Value = txtzonename.Text.Trim();
            LOCAL.Type = "ZONE";
            string maphubvalue = txtmaphub.Text.Trim();
            if (hdnMapHubID.Value != "")
            {
                LOCAL.ParentID = Convert.ToInt32(hdnMapHubID.Value);
            }
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (hdnzoneid.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(hdnzoneid.Value);
            }
            returnCode = physicianBL.Insertzonename(maphubvalue, LOCAL);
            clears();
            loadZONE();
            div01.Attributes.Add("style", "display:none");
            div02.Attributes.Add("Style", "display:block");
            div03.Attributes.Add("Style", "display:none");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }

            hdnbtnsavezone.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnaddzone_Click", ex);
        }
    }

    protected void btnsearchzone_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string zonecode = txtzonecode1.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.Getsearchzone(Orgid, zonecode, out local);
            clears();
            if (returnCode == 0)
            {
                //Gridaddzone.Visible = false;
                //grdsearchzone.Visible = true;
                Gridaddzone.DataSource = local;
                Gridaddzone.DataBind();
                txtzonecode1.Text = string.Empty;
                txtzonecode.Text = string.Empty;
            }
            div01.Attributes.Add("style", "display:none");
            div02.Attributes.Add("Style", "display:block");
            div03.Attributes.Add("Style", "display:none");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchHub", ex);
        }

    }

    protected void Gridaddzone_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow1('" + ((RadioButton)e.Row.FindControl("rdSel1")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "','" + Local.ParentID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel1")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel1")).Attributes.Add("onclick", strScript);
        }
    }
    protected void Gridaddzone_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            Gridaddzone.PageIndex = e.NewPageIndex;
        }
        loadZONE();
        div01.Attributes.Add("style", "display:none");
        div02.Attributes.Add("Style", "display:block");
        div03.Attributes.Add("Style", "display:none");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    }
    //protected void grdsearchzone_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdsearchzone.PageIndex = e.NewPageIndex;
    //    }
    //    loadZONE();
    //    div01.Attributes.Add("style", "display:none");
    //    div02.Attributes.Add("Style", "display:block");
    //    div03.Attributes.Add("Style", "display:none");
    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    //}
    //protected void grdsearchzone_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Localities Local = (Localities)e.Row.DataItem;
    //        string strScript = "extractRow1('" + ((RadioButton)e.Row.FindControl("rdSel2")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "');";
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel2")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel2")).Attributes.Add("onclick", strScript);
    //    }
    //}
    protected void btnaddroute_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            Localities LOCAL = new Localities();
            LOCAL.OrgID = OrgID;
            LOCAL.Locality_ID = 0;
            LOCAL.Locality_Code = txtroutecode.Text.Trim();
            LOCAL.Locality_Value = txtroutename.Text.Trim();
            LOCAL.Type = "ROUTE";
            string mapzonevalue = txtmapzone.Text.Trim();
            if (hdnMapZoneID.Value != "")
            {
                LOCAL.ParentID = Convert.ToInt32(hdnMapZoneID.Value);
            }
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            if (hdnrouteid.Value != "")
            {
                LOCAL.Locality_ID = Convert.ToInt32(hdnrouteid.Value);
            }
            returnCode = physicianBL.Insertroutename(mapzonevalue, LOCAL);
            clears();
            loadROUTE();
            div01.Attributes.Add("Style", "display:none");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
            }
            hdnbtnsaveroute.Value = "";
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in btnaddzone_Click", ex);
        }
    }
    protected void loadROUTE()
    {
        try
        {
            long returnCode = -1;
            int orgid = OrgID;
            List<Localities> LOC = new List<Localities>();
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            returnCode = physicianBL.GetLocalitiesRoute(orgid, out LOC);
            grdaddroute.DataSource = LOC;
            grdaddroute.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadROUTE", ex);
        }
    }


    protected void grdaddroute_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Localities Local = (Localities)e.Row.DataItem;
            string strScript = "extractRow2('" + ((RadioButton)e.Row.FindControl("rdSel3")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "','" + Local.ParentID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onclick", strScript);
        }

    }
    protected void grdaddroute_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        if (e.NewPageIndex != -1)
        {
            grdaddroute.PageIndex = e.NewPageIndex;
        }
        loadROUTE();
        div01.Attributes.Add("Style", "display:none");
        div02.Attributes.Add("Style", "display:none");
        div03.Attributes.Add("Style", "display:block");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    }
    protected void btnsearchroute_OnClick(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            string routecode = txtroutecode1.Text;
            List<Localities> local = new List<Localities>();
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            int Orgid = OrgID;
            returnCode = PhysicianBL.Getsearchroute(Orgid, routecode, out local);
            clears();
            if (returnCode == 0)
            {
                //grdaddroute.Visible = false;
                //grdsearchroute.Visible = true;
                grdaddroute.DataSource = local;
                grdaddroute.DataBind();
                txtroutecode1.Text = string.Empty;
                txtroutecode.Text = string.Empty;
            }
            div01.Attributes.Add("Style", "display:none");
            div02.Attributes.Add("Style", "display:none");
            div03.Attributes.Add("Style", "display:block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SearchRoute", ex);
        }

    }

    //protected void grdsearchroute_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{

    //    if (e.NewPageIndex != -1)
    //    {
    //        grdsearchroute.PageIndex = e.NewPageIndex;
    //    }
    //    loadROUTE();
    //    div01.Attributes.Add("Style", "display:none");
    //    div02.Attributes.Add("Style", "display:none");
    //    div03.Attributes.Add("Style", "display:block");
    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:DisplayTab('CLI');", true);
    //}
    //protected void grdsearchroute_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    if (e.Row.RowType == DataControlRowType.DataRow)
    //    {
    //        Localities Local = (Localities)e.Row.DataItem;
    //        string strScript = "extractRow2('" + ((RadioButton)e.Row.FindControl("rdSel22")).ClientID + "','" + Local.Locality_ID + "','" + Local.Locality_Code + "','" + Local.Locality_Value + "','" + Local.ParentName + "');";
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel22")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
    //        ((RadioButton)e.Row.Cells[0].FindControl("rdSel22")).Attributes.Add("onclick", strScript);
    //    }

    //}

    protected void grddiv01_SelectedIndexChanged(object sender, EventArgs e)
    {
        loaddgrid();
    }
    static DataTable ConvertListToDataTable(List<OrganizationAddress> lstOrgLocation)
    //List<InvestigationMaster> lstInvestigation)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Location Code");
        DataColumn dcol2 = new DataColumn("Location ID");
        DataColumn dcol3 = new DataColumn("Location");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        foreach (var item in lstOrgLocation)
        {
            var row = dt.NewRow();
            row["Location Code"] = item.LocationCode;
            row["Location ID"] = item.AddressID;
            row["Location"] = item.Location;


            dt.Rows.Add(row);
        }
        return dt;
    }
   
   

    public void loaddgrid()
    {
        chid = 0;
        Addid = 0;
        grdOrgLocation.Visible = true;
        hdnLocationCode.Value = "";
        objBl = new AdminReports_BL(base.ContextInfo);

        Returncode = objBl.pGetOrganizationLocation(OrgID, Addid, chid, out lstOrgLocation);
     
        DataTable table = ConvertListToDataTable(lstOrgLocation);
        grdExport.DataSource = table;
        grdExport.DataBind();
        ExportToExcel();
    }
    public void ExportToExcel()
    {
        try
        {
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string attachment = "attachment; filename=" + "Location " + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdExport.Visible = true;
            grdExport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();




        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        loaddgrid();
    }

    //uploaded image and convert it in byte array
    private byte[] ConvertImageToByteArray(FileUpload fuImage)
    {
        byte[] ImageByteArray;
        try
        {
            MemoryStream ms = new MemoryStream(fuImage.FileBytes);
            ImageByteArray = ms.ToArray();
            return ImageByteArray;
        }
        catch (Exception ex)
        {
            return null;
        }
    }
    // btnUplaodImage to save browsed image in database

    protected void btnUploadImage_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            int imgId = 1;
            byte[] ImageByteArray = null;
            List<OrganizationAddress> primage=new List<OrganizationAddress>();
            AdminReports_BL masterbl = new AdminReports_BL(base.ContextInfo);
            ImageByteArray = ConvertImageToByteArray(FileUpload1);
            masterbl.pGetOrgLoction(out lstOrg);
             imgProfile.ImageUrl = "ImageHandler.ashx?imgid=" + imgId.ToString();
            imgProfile.Visible = true;
        }
    }
}
