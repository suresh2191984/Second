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
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;



public partial class Admin_UserMaster : BasePage
{
    string UsrMsgseleNew = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_04 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_04;
    string UsrMsgselLoc = Resources.Admin_AppMsg.Admin_UserMaster_aspx_44 == null ? "--Select LocationType--" : Resources.Admin_AppMsg.Admin_UserMaster_aspx_44;
    public string Update_msg = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_03 == null ? "Changes have been Updated successfully." : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_03;
    public string Update_msg1 = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_15 == null ? "No Matching Records Found" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_15;
    public Admin_UserMaster()
        : base("Admin_UserMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);

    }
    int currentPageNo = 1;
    int PageSize = 0;
    int totalRows = 0;
    int totalpage = 0;
    SharedInventory_BL inventoryBL;
    AdminReports_BL AdminBL;
    LocationType objLocationType = new LocationType();
    List<LocationType> lstLocationType = new List<LocationType>();
    Locations objInvLocation = new Locations();
    List<Locations> lstInvLocation = new List<Locations>();
    List<ProductType> lstProductType = new List<ProductType>();
    DateTime DOB;
    DateTime wDOB;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    PhysicianSpeciality PhysSpl = new PhysicianSpeciality();
    List<Users> lstUsers = new List<Users>();
    List<Users> lstUsersForExcel = new List<Users>();
    string TransPass = string.Empty;
    string newtransPwd = string.Empty;
    string oldtransPassword = string.Empty;
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    DateTime TransationPasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    //UserControl_AddressControl ctrlAddresss = new UserControl_AddressControl();
    string AddressControlID = string.Empty;
    string ConfigValue = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        chkPreferedUser.Text = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_02 == null ? "Preferred User Name" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_02;
        inventoryBL = new SharedInventory_BL(base.ContextInfo);
        AdminBL = new AdminReports_BL(base.ContextInfo);
        roleBL = new Role_BL(base.ContextInfo);
        try
        {
            ConfigValue = GetConfigValue("DynamicAddressControl", OrgID);
            hdnorgid.Value = Convert.ToString(OrgID) ;


            var sval = OrgID + "~" + "users" + "~" + "A";
            AutoGname1.ContextKey = sval;

            if (ConfigValue == "")
            {
                ConfigValue = "N";
            }
            hdnDynamicConfig.Value = ConfigValue;
            Control ctrlPatientAddress = null;
            if (string.Compare(ConfigValue, "N") == 0)
            {
                ctrlPatientAddress = (UserControl_AddressControl)LoadControl("~/CommonControls/AddressControl.ascx");

            }
            else
            {
                ctrlPatientAddress = (CommonControls_PatientAddress)LoadControl("~/CommonControls/PatientAddress.ascx");

            }
            ctrlPatientAddress.ID = "ucPAdd";
            TableRow tr = new TableRow();
            TableCell tc = new TableCell();
            tc.Width = Unit.Percentage(100);
            tc.Controls.Add(ctrlPatientAddress);
            tr.Cells.Add(tc);
            tblPatientAddress.Rows.Add(tr);
            ViewState["AddressControlID"] = ctrlPatientAddress.ID;
            if (ViewState["AddressControlID"] != null)
            {
                AddressControlID = Convert.ToString(ViewState["AddressControlID"]);
                hdnControleID.Value = AddressControlID.ToString();
                if (ConfigValue == "N")
                {
                    UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(AddressControlID);
                }
                else
                {
                    CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(AddressControlID);
                }
            }

            TransPass = GetConfigValue("PasswordAuthentication", OrgID);
            AutoGname.ContextKey = OrgID.ToString();
            AutoGname1.ContextKey = OrgID.ToString() + "~" + "users"+"~"+"A";
            AutoCompleteExtender1.ContextKey = OrgID.ToString();
            txtName.Focus();
            lnkCreateNewUser.Visible = false;
            int pOrgID = OrgID;
            txtName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
            tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            weddingDate.Attributes.Add("onchange", "ExcedDate('" + weddingDate.ClientID.ToString() + "','" + tDOB.ClientID.ToString() + "',1,1);");
            //txtRelegion.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
            ddSalutation.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //ddSalutation.Attributes.Add("onchange", "setSexValue('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            ddlSex.Attributes.Add("onchange", "setSexValueopt('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");

            ddSalutation.Attributes.Add("onchange", "setSexValuemanageusers('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "','" + ddlMaritialStatus.ClientID.ToString() + "');");
            
            chkPreferedUser.Attributes.Add("onClick", "chec()");
            txtEmail.Attributes.Add("onBlur", "AddEmailAsLogIn()");
            imgView.Visible = false;
            long returncode = -1;
            returncode = roleBL.GetRoleName(pOrgID, out role);
            //hdnID.Value = String.Empty;

            ACX2responses2.Style.Add("display", "table-row");
            ACX2minus2.Style.Add("display", "block");
            ACX2plus2.Style.Add("display", "none");
            //Save.Visible = false;
            txtTo.Attributes.Add("onchange", "ValidDate('" + txtTo.ClientID.ToString() + "','',0,0);");
            txtBlockFrom.Attributes.Add("onchange", "ValidDate('" + txtBlockFrom.ClientID.ToString() + "','',0,0);");
            txtBlockTo.Attributes.Add("onchange", "BlockValidate('" + txtBlockFrom.ClientID.ToString() + "','" + txtBlockTo.ClientID.ToString() + "','" + txtTo.ClientID.ToString() + "',0,0);");



            if (!IsPostBack)
            {
                LoadReason();
                LoadReligion();
                LoadEmpRegName();
                LoadExpiryDate();
                GetPrinterNameAndPath();
                ACX2responsesEU.Style.Add("display", "none");
                ACX2minusEU.Style.Add("display", "none");
                ACX2plusEU.Style.Add("display", "block");
                GetUserDetails(e, currentPageNo, PageSize);
                if (role.Count > 0)
                {                    //Get RoleName
                    if (Request.QueryString["lid"] == null)
                    {

                        role.RemoveAll(p => p.RoleName == "Billing");
                        role.RemoveAll(p => p.RoleName == "Client");
                        role.RemoveAll(p => p.RoleName == "ReferringPhysician");
                        role.RemoveAll(p => p.RoleName == "TMCUsers");
                        chkUserType.DataSource = role;
                        chkUserType.DataTextField = "IntegrationName";
                        chkUserType.DataValueField = "Description";
                        chkUserType.DataBind();
                        hdnSpciality.Value = String.Empty;
                        hdnLocation.Value = String.Empty;
                        chkPreferedUser.Checked = false;

                    }

                }
                LoadTitle();
                Speciality1();
                BindInventoryLocation();
                BindProductType();
                BindorgAddress();
                LoadMetaData();
                //GetUserImage(loginID);
                //Button btnUpdate = (Button)(sender);
                //Button btnUpdate = (Button)mytable1.FindControl("btnUpdate");

                //btnUpdate.Attributes.Add("OnClientClick", "validationchkbx('" + hdnchkitems.Value + "');");                
                hdnchkitems1.Value = hdnchkitems.Value;
                BindLocationType();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading  Page", ex);
        }

    }

    public void GetPrinterNameAndPath()
    {

        long returnCode = -1;
        try
        {
            Users_BL user = new Users_BL(base.ContextInfo);
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            List<LocationPrintMap> lstLocationPrintMap = new List<LocationPrintMap>();
            //returnCode = obj.LoadPrinterNameAndPath(OrgID, Convert.ToInt64(ddlPrintLocation.SelectedValue), out lstLocationPrintMap);
            returnCode = user.LoadPrinterNameAndPath(OrgID, out lstLocationPrintMap);

            ddlPrinterName.DataSource = lstLocationPrintMap;
            ddlPrinterName.DataValueField = "AutoID";
            ddlPrinterName.DataTextField = "Name";
            ddlPrinterName.DataBind();
            ddlPrinterName.Items.Insert(0, "select");
            ddlPrinterName.Items[0].Value = "0";


            //ddlPrinterPath.DataSource = lstLocationPrintMap;
            //ddlPrinterPath.DataValueField = "Path";
            //ddlPrinterPath.DataTextField = "Path";
            //ddlPrinterPath.DataBind();
            //ddlPrinterPath.Items.Insert(0, select);

            //returnCode = obj.GetAddressType(out lstAddressType);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Despatch Mode", ex);
        }
    }
    public void LoadReason()
    {
        string UsrMsgseleNew = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_04 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_04;
        long ReturnCode = -1;
        Users_BL user = new Users_BL(base.ContextInfo);
        List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
        ReturnCode = user.GetReasonforblocking(OrgID, out lstmetavalue);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadlocation", "Javascript:dateshow();", true);
        if (lstmetavalue.Count > 0)
        {

            drpReason.DataSource = lstmetavalue;
            drpReason.DataTextField = "Value";
            drpReason.DataValueField = "Code";
            drpReason.DataBind();
            ListItem li = new ListItem();
            li.Text = UsrMsgseleNew;
            li.Value = "0";
            drpReason.Items.Add(li);
            //drpReason.Items.Insert(0, UsrMsgsele);
        }

        foreach (var item in lstmetavalue)
        {
            hdnReason.Value += item.Value + "~" + item.Code + "~" + item.Description + "^";

        }


    }

    public void LoadEmpRegName()
    {

        AutoCompleteExtender3.ContextKey = OrgID.ToString() + "~";

    }

    public void LoadExpiryDate()
    {
        long Returncode = -1;

        List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
        List<PasswordPolicy> Transpwdplcy = new List<PasswordPolicy>();
        Returncode = new Users_BL(base.ContextInfo).GetPasswordValidityPeriod(OrgID, out pwdplcy, out Transpwdplcy);

        if (pwdplcy.Count > 0)
        {
            if (pwdplcy[0].ValidityPeriodType == "Days")
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddDays(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == "Weeks")
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddDays((pwdplcy[0].ValidityPeriod) * 7);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == "Months")
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddMonths(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == "Year")
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime expiryDate = startdate.AddYears(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
        }
        if (Transpwdplcy.Count > 0)
        {
            if (Transpwdplcy[0].ValidityPeriodType == "Days")
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddDays(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Weeks")
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddDays((Transpwdplcy[0].ValidityPeriod) * 7);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();
            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Months")
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddMonths(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Year")
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime transexpiryDate = transstartdate.AddYears(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }

        }




    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }


    private void BindorgAddress()
    {
        List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
        AdminBL.pGetOrganizationLocation(OrgID, 0, 0, out lstOrgLocation);
        drpOrgAddress.DataSource = lstOrgLocation;
        drpOrgAddress.DataTextField = "Location";
        drpOrgAddress.DataValueField = "AddressID";
        drpOrgAddress.DataBind();
        ListItem li = new ListItem();
        li.Text = UsrMsgseleNew;
        li.Value = "0";
        drpOrgAddress.Items.Add(li);
        drpOrgAddress.SelectedValue = "0";


    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {

            long lresult = -1;
            Users_BL UserBL = new Users_BL(base.ContextInfo);
            Users User = new Users();
            List<UserAddress> pAddress = new List<UserAddress>();
            List<AdminInvestigationRate> lstInvRate = new List<AdminInvestigationRate>();
            List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
            List<Locations> lstInvLocation = new List<Locations>();

            long returnCode = -1;
            long logID = -1;
            string rName = string.Empty;



            int row = int.Parse(hdnID.Value);
            logID = Convert.ToInt64(grdResult.DataKeys[row][0]);
            rName = (grdResult.DataKeys[row][0]).ToString();
            DateTime BlockedFrom = DateTime.MinValue;
            DateTime BlockedTo = DateTime.MinValue;
            DateTime EndDTTM = DateTime.MinValue;
            string BlockReason = string.Empty;
            if (ChkBlocked.Checked == true)
            {
                long Returncode = -1;
                long UserLID = LID;
                Role_BL roleBL = new Role_BL(base.ContextInfo);
                Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
                long LoginID = logID;
                BlockedFrom = Convert.ToDateTime(txtBlockFrom.Text);

                if (txtBlockTo.Text != "" && txtBlockTo.Text != null)
                {
                    BlockedTo = Convert.ToDateTime(txtBlockTo.Text);
                }
                else
                {
                    BlockedTo = Convert.ToDateTime("1/1/1900 00:00:00");
                }
                if (drpReason.SelectedItem.Text != "Select")
                {
                    BlockReason = drpReason.SelectedValue.ToString();
                }
                if (txtTo.Text != "" && txtTo.Text != null)
                {
                    EndDTTM = Convert.ToDateTime(txtTo.Text);
                }
                else
                {
                    EndDTTM = Convert.ToDateTime("1/1/1900 00:00:00");

                }
                Returncode = roleBL.UpdateBlockUser(LoginID, BlockedFrom, BlockedTo, BlockReason, EndDTTM, UserLID);

            }
            else
            {
                long Returncode = -1;
                long UserLID = LID;
                Role_BL roleBL = new Role_BL(base.ContextInfo);
                Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
                long LoginID = logID;
                BlockedFrom = Convert.ToDateTime("1/1/1900 00:00:00");
                BlockedTo = Convert.ToDateTime("1/1/1900 00:00:00");
                if (txtTo.Text != "" && txtTo.Text != null)
                {
                    EndDTTM = Convert.ToDateTime(txtTo.Text);
                }
                else
                {
                    EndDTTM = Convert.ToDateTime("1/1/1900 00:00:00");

                }

                BlockReason = drpReason.SelectedValue.ToString();

                Returncode = roleBL.UpdateBlockUser(LoginID, BlockedFrom, BlockedTo, BlockReason, EndDTTM, UserLID);

            }


            UpdateDigitalSignature(logID);
            OrgUsers eUsers = new OrgUsers();
            eUsers.LoginID = logID;
            eUsers.OrgUID = Convert.ToInt64(hdnUserID.Value);
            eUsers.RoleName = rName.ToString();
            eUsers.TitleCode = ddSalutation.SelectedItem.Value;
            eUsers.Name = txtName.Text;
            eUsers.SEX = ddlSex.SelectedValue;
            eUsers.Email = txtEmail.Text;
            eUsers.PrinterPath = Convert.ToInt32(ddlPrinterName.SelectedValue);
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text, out DOB))
                    DOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DOB = new DateTime(1800, 1, 1);
            }
            //eUsers.DOB = tDOB.Text;
            eUsers.DOB = DOB.ToString();
            eUsers.Relegion = ddlReligion.SelectedValue;
            if (weddingDate.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(weddingDate.Text, out wDOB))
                    wDOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                wDOB = new DateTime(1800, 1, 1);
            }
            //eUsers.WeddingDt = weddingDate.Text;
            eUsers.WeddingDt = wDOB.ToString();
            eUsers.Qualification = txtQualification.Text;
            eUsers.MaritalStatus = ddlMaritialStatus.SelectedValue;
            string AddressControlID = string.Empty;
            if (ConfigValue == "N")
            {
                UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                ctrlAddresss.GetAddress(eUsers);
            }
            else
            {
                CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                ctrlAddresss.GetDynamicAddress(eUsers);
            }


            //TextBox txtAdd1 = (TextBox)ucPAdd.FindControl("txtAddress1");
            //eUsers.Add1 = txtAdd1.Text;

            //TextBox txtAdd2 = (TextBox)ucPAdd.FindControl("txtAddress2");
            //eUsers.Add2 = txtAdd2.Text;
            //TextBox txtAdd3 = (TextBox)ucPAdd.FindControl("txtAddress3");
            //eUsers.Add3 = txtAdd3.Text;
            //TextBox tCity = (TextBox)ucPAdd.FindControl("txtCity");
            //eUsers.City = tCity.Text;
            //DropDownList dCountry = (DropDownList)ucPAdd.FindControl("ddCountry");
            //eUsers.CountryID = Convert.ToInt16(dCountry.SelectedValue);
            //DropDownList dState = (DropDownList)ucPAdd.FindControl("ddState");
            //eUsers.StateID = Convert.ToInt16(dState.SelectedValue);
            //TextBox tPostal = (TextBox)ucPAdd.FindControl("txtPostalCode");
            //eUsers.PostalCode = tPostal.Text;
            //TextBox txtMob = (TextBox)ucPAdd.FindControl("txtMobile");
            //eUsers.MobileNumber = txtMob.Text;
            //TextBox txtLnd = (TextBox)ucPAdd.FindControl("txtLandLine");
            //eUsers.LandLineNumber = txtLnd.Text;
            //TextBox txttxtOtherCountry = (TextBox)ucPAdd.FindControl("txtOtherCountry");
            //eUsers.OtherCountryName = txttxtOtherCountry.Text;
            //TextBox txttxtOtherState = (TextBox)ucPAdd.FindControl("txtOtherState");
            //eUsers.OtherStateName = txttxtOtherState.Text;
            if (Chkactivated.Checked == true)
            {
                eUsers.Loginstatus = "A";
            }
            else
            {
                eUsers.Loginstatus = "D";
            }
            hdnlst.Value = String.Empty;
            long ModifiedBy = LID;
            foreach (ListItem li in chkUserType.Items)
            {
                string[] CheckListValue = li.Value.Split('?');               
                string GRoleName = CheckListValue[1];
                string Mode = "UPDATE";
                if (GRoleName == "Sample Collection Person") {
                    long objresult = -1;
                    Users_BL LoginCheckdetails = new Users_BL(base.ContextInfo);
                    objresult = LoginCheckdetails.GetCheckSamplePersonMobileNo(eUsers, Mode);
                    if (objresult == 0)
                    {
                        string Information1 = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04;
                        string sPath1 = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_04 == null ? "Preferred Mobile Number Already Exist" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_04;
                        string sPathmob = "Preferred Mobile Number Already Exist";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_003", "javascript:ValidationWindow('" + sPathmob + "','" + Information1 + "');", true);
                        return;
                    }
                }
            }
            returnCode = new AdminReports_BL(base.ContextInfo).UpdateUserDetails(eUsers, ModifiedBy);
            int pCount = -1;
            int pCountRole = -1;
            string PhyType = ddlConsultantType.SelectedItem.Value;

            #region Check Role
            foreach (ListItem li in chkUserType.Items)
            {
                string[] CheckListValue = li.Value.Split('?');
                long rollID = Convert.ToInt32(CheckListValue[0]);
                string GRoleName = CheckListValue[1];

                if (GRoleName == "Project Stockist" || GRoleName == "PI" || GRoleName == "Project Manager")
                {
                    GRoleName = "Inventory";
                }
                if (li.Selected)
                {
                    if (rollID.ToString() != hdnRID.Value)
                    {
                        // int rollID = Convert.ToInt32(li.Value);
                        if (GRoleName == "Nurse")
                        {
                            returnCode = new AdminReports_BL(base.ContextInfo).CountifUserDataExists(logID, rollID, GRoleName, out pCount, out pCountRole);
                            if (pCount == 0)
                            {
                                InsertNurse(logID);
                            }
                            if (pCount == 1)
                            {
                                string txt = GRoleName;
                                long oroleID = 0;
                                returnCode = new AdminReports_BL(base.ContextInfo).UpdateUserDetail(logID, OrgID, txt, rollID, ModifiedBy, PhyType);
                            }
                            if (pCountRole == 0)
                            {
                                InserLoginRole(rollID, logID);
                            }
                        }
                        else if (GRoleName == "Physician")
                        {
                            returnCode = new AdminReports_BL(base.ContextInfo).CountifUserDataExists(logID, rollID, GRoleName, out pCount, out pCountRole);
                            if (pCount == 0)
                            {
                                InsertPhysician(logID);
                            }
                            if (pCount == 1)
                            {
                                string txt = GRoleName;

                                long oroleID = 0;
                                returnCode = new AdminReports_BL(base.ContextInfo).UpdateUserDetail(logID, OrgID, txt, rollID, ModifiedBy, PhyType);
                                UpdateSpeciality();
                            }
                            if (pCountRole == 0)
                            {
                                InserLoginRole(rollID, logID);
                            }
                        }
                         
                        else
                        {
                            returnCode = new AdminReports_BL(base.ContextInfo).CountifUserDataExists(logID, rollID, GRoleName, out pCount, out pCountRole);
                            if (pCount == 0)
                            {
                                InsertUsers(logID);
                            }
                            if (pCount == 1)
                            {
                                string txt = GRoleName;
                                long oroleID = 0;
                                oroleID = rollID;
                                returnCode = new AdminReports_BL(base.ContextInfo).UpdateUserDetail(logID, OrgID, txt, oroleID, ModifiedBy, PhyType);
                            }

                            if (pCountRole == 0)
                            {
                                InserLoginRole(rollID, logID);
                            }
                            if (GRoleName == "Inventory")
                            {

                                User.Address = pAddress;
                                User.OrgID = OrgID;
                                User.CreatedBy = LID;
                                User.LoginID = logID;
                                User.AddressID = ILocationID;
                                InserInventoryUser(User);
                            }
                        }
                    }
                }

                else
                {
                    // int rollID = Convert.ToInt32(li.Value);
                    if (GRoleName == "Nurse")
                    {
                        returnCode = new AdminReports_BL(base.ContextInfo).CountifUserDataExists(logID, rollID, GRoleName, out pCount, out pCountRole);
                        if (pCount == 1)
                        {
                            string txt = GRoleName;
                            returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(logID, OrgID, txt, rollID, ModifiedBy);
                        }

                    }

                    if (GRoleName == "Physician")
                    {
                        returnCode = new AdminReports_BL(base.ContextInfo).CountifUserDataExists(logID, rollID, GRoleName, out pCount, out pCountRole);
                        if (pCount == 1)
                        {
                            string txt = GRoleName;
                            returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(logID, OrgID, txt, rollID, ModifiedBy);
                        }
                    }
                }

            }
            #endregion
            foreach (ListItem item in chkUserType.Items)
            {
                if (item.Selected)
                {
                    hdnlst.Value += item.Text + ',';
                }
            }
            foreach (string lsttxt in hdn.Value.Split(','))
            {
                if (hdnlst.Value.Trim().Contains(lsttxt.Trim()))
                {
                }
                else
                {
                    hdndelete.Value += lsttxt + ',';
                }
            }
            foreach (string txt in hdndelete.Value.Split(','))
            {
                string text = string.Empty;
                long orgUID = 0;
                long oroleID = 0;

                if (txt != "")
                {
                    string[] ckkitems = hdnchkitems1.Value.Split('#');
                    for (int i = 0; i <= ckkitems.Count(); i++)
                    {
                        string[] Orole = ckkitems[i].Split('$');
                        if (Orole[1].Trim() == txt.Trim())
                        {
                            text = Orole[0];
                            break;
                        }
                    }
                    if (text == "Physician")
                    {

                    }
                    else if (text == "Nurse")
                    {

                    }
                    else
                    {
                        returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(logID, OrgID, text, oroleID, ModifiedBy);
                    }
                }
            }
            if (returnCode == 0)
            {

            }
            TxtClear();
            txtName1.Text = "";
            grdResult.Visible = false;
            lblUserName.Visible = true;
            txtUserName.Visible = true;
            chkPreferedUser.Enabled = true;
            imgUserName.Visible = false;
            Save.Visible = true;
            btnUpdate.Visible = false;
            hdnLID.Value = "";
            hdnRName.Value = "";
            hdnRID.Value = "";
            hdnOrguserID.Value = "";
            hdnSpciality.Value = "";
            hdnLocation.Value = "";
            Speciality.Attributes.Add("Style", "Display:None");
            Location.Attributes.Add("style", "Display:None");
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "ValidationWindow('" + Update_msg + "');", true);
            string Information = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + Update_msg + "','" + Information + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "aa", "alert('Changes saved successfully.');", true);
            // GetUserDetails();
            //lblLoginName.Text = "Successfully Updated";            
            //Response.Redirect("UserMaster.aspx");
            //lblLoginName.Text = "<h3>Successfully Updated </h3>";
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showResponses('ACX2plusEU','ACX2minusEU','ACX2responsesEU',1);", true);
            //ACX2responsesEU.Style.Add("display", "block");
            //ACX2minusEU.Style.Add("display", "block");
            //ACX2plusEU.Style.Add("display", "none");
            Save.Visible = true;
            ACX2responses2.Style.Add("display", "none");
            ACX2minus2.Style.Add("display", "none");
            ACX2plus2.Style.Add("display", "block");


            ACX2responsesEU.Style.Add("display", "none");
            ACX2minusEU.Style.Add("display", "none");
            ACX2plusEU.Style.Add("display", "block");

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome", ex);
        }

    }

    protected void Save_Click(object sender, EventArgs e)
    {
        TransPass = GetConfigValue("PasswordAuthentication", OrgID);
        long lresult1 = -1;
        long lresult2 = -1;
        try
        {
            //string LoginName = txtName.Text;
            string LoginName = txtUserName.Text;
            Users_BL LoginCheckdetails = new Users_BL(base.ContextInfo);

            lresult1 = LoginCheckdetails.GetCheckLogindetails(LoginName);
            if (lresult1 == 0)
            {
                // string sPath = "Admin\\\\UserMaster.aspx.cs_30";
                string Information = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04;
                string sPath = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_04 == null ? "Preferred User Name Already Exist" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_04;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "ShowAlertMsg('" + sPath + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Prefered User Name Already Exist');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
                txtUserName.Focus();
                return;
            }

            foreach (ListItem li in chkUserType.Items)
            {
                string[] CheckListValue1 = li.Value.Split('?');
                string GRoleName1 = CheckListValue1[1];
                string Mode1 = "INSERT";
                if (GRoleName1 == "Sample Collection Person")
                {
                    long objresultmob = -1;
                    Users_BL LoginCheckdetailsmob = new Users_BL(base.ContextInfo);                 
                    OrgUsers Usermob = new OrgUsers();
                    List<UserAddress> pAddressmob = new List<UserAddress>();
                    UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                    ctrlAddresss.GetAddress(Usermob);
                    objresultmob = LoginCheckdetailsmob.GetCheckSamplePersonMobileNo(Usermob, Mode1);
                    if (objresultmob == 0)
                    {
                        string Informationmob = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04;
                          string sPathmob1 = "Preferred Mobile Number Already Exist";
                          ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_004", "javascript:ValidationWindow('" + sPathmob1 + "','" + Informationmob + "');", true);
                        return;
                    }
                }
            }
            //lresult1 = LoginCheckdetails.GetCheckLogindetails(LoginName);

            //if (lresult1 == 0)
            //{
            //    HtmlGenericControl dError = (HtmlGenericControl)this.FindControl("DivErrors");
            //    dError.Style.Value = "Block";
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "Login " + txtName.Text.ToString() + " Already Exist";

            //}            
            DateTime DOB1 = new DateTime();
            string FORENAME = txtName.Text;
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text, out DOB1))
                    DOB1 = new DateTime(1800, 1, 1);
            }
            else
            {

                DOB1 = new DateTime(1800, 1, 1);
            }
            DateTime DOB = DOB1;
            string Email = txtEmail.Text;
            Users_BL userCheckdetails = new Users_BL(base.ContextInfo);

            if (lresult1 != 0 && lresult2 != 0)
            {
                long LoginID = InsertLogin();
                //  InsertUsers(LoginID);
                int alreadyinserted = 0;

                for (int i = 0; i < chkUserType.Items.Count; i++)
                {
                    long RoleID = 0;
                    if (chkUserType.Items[i].Selected == true)
                    {
                        string[] CheckListValue = chkUserType.Items[i].Value.Split('?');
                        long rollID = Convert.ToInt64(CheckListValue[0]);
                        string GRoleName = CheckListValue[1];

                        if (GRoleName == "Physician")
                        {
                            RoleID = rollID;
                            InserLoginRole(RoleID, LoginID);
                            InsertPhysician(LoginID);
                        }
                        else if (GRoleName == "Nurse")
                        {
                            RoleID = rollID;
                            InserLoginRole(RoleID, LoginID);
                            InsertNurse(LoginID);
                        }
                        else
                        {
                            RoleID = rollID;
                            InserLoginRole(RoleID, LoginID);
                            //if (alreadyinserted == 0)
                            //{
                            //    InsertUsers(LoginID);
                            //    alreadyinserted++;
                            //}
                        }
                        if (alreadyinserted == 0)
                        {
                            InsertUsers(LoginID);
                            alreadyinserted++;
                        }
                    }
                }
                long Returncode = -1;
                string strPass = string.Empty;
                string TransPwrd = string.Empty;
                Returncode = LoginCheckdetails.GetLoginUserName(LoginID, out LoginName, out strPass, out TransPwrd);

                string DecryptedString = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                obj.Crypt(strPass, out DecryptedString);
                string strLogin=Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_001;
                string strPassword = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_002;
                string strTransPwd = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_003;
                if (TransPass == "Y")
                {
                    string DecryptedString1 = string.Empty;
                    Attune.Cryptography.CCryptography obj1 = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                    obj.Crypt(TransPwrd, out DecryptedString1);

                    lblLoginName.Text = "<h3>"+strLogin  + LoginName + strPassword + DecryptedString + strTransPwd + DecryptedString1 + " </h3>";
                }
                else
                {
                    lblLoginName.Text = "<h3>" + strLogin + LoginName + strPassword + DecryptedString + " </h3>";

                }

                /********************************************Moovendan**************************************
               // ShowPopUp(LoginID);
                 * ***************************************************************************************/
                //Save.Visible = false;
                TxtClear();
                hdnSpciality.Value = "";
                hdnLocation.Value = "";
                chkPreferedUser.Checked = false;
                txtUserName.Text = "";
                txtTo.Text = "";
                TxtEmpRegName.Text = "";

            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Save Page", ex);
        }
    }

    public void TxtClear()
    {
        chkUserType.SelectedIndex = -1;
        txtUserName.Text = string.Empty;
        txtName.Text = string.Empty;
        ddlSex.SelectedIndex = 0;
        tDOB.Text = string.Empty;
        txtEmail.Text = string.Empty;
        weddingDate.Text = string.Empty;
        //txtRelegion.Text = string.Empty;
        hdnSpciality.Value = string.Empty;
        hdnLocation.Value = string.Empty;
        txtQualification.Text = string.Empty;


        //added by sudha
        ChkBlocked.Visible = false;

        if (ConfigValue == "N")
        {
            UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
            TextBox txtAdd1 = (TextBox)ctrlAddresss.FindControl("txtAddress1");
            txtAdd1.Text = string.Empty;
            TextBox txtAdd2 = (TextBox)ctrlAddresss.FindControl("txtAddress2");
            txtAdd2.Text = string.Empty;
            TextBox txtAdd3 = (TextBox)ctrlAddresss.FindControl("txtAddress3");
            txtAdd3.Text = string.Empty;
            TextBox tCity = (TextBox)ctrlAddresss.FindControl("txtCity");

            if (tCity != null)
            {
                tCity.Text = string.Empty;
            }

            DropDownList dCountry = (DropDownList)ctrlAddresss.FindControl("ddCountry");
            //dCountry.SelectedIndex = 0;
            //dCountry.SelectedItem.Text = "India";
            TextBox tPostal = (TextBox)ctrlAddresss.FindControl("txtPostalCode");
            tPostal.Text = string.Empty;
            TextBox txtMob = (TextBox)ctrlAddresss.FindControl("txtMobile");
            txtMob.Text = string.Empty;
            TextBox txtLnd = (TextBox)ctrlAddresss.FindControl("txtLandLine");
            txtLnd.Text = string.Empty;
        }
        HtmlGenericControl dError = (HtmlGenericControl)this.FindControl("DivErrors");
        dError.Visible = false;
        txtRegNumber.Text = "";
        ddlConsultantType.SelectedItem.Value = "VIS";
        chkPreferedUser.Checked = false;
    }

    public void LoadTitle()
    {
        try
        {
            long returnCode = -1;
            Title_BL titleBL = new Title_BL(base.ContextInfo);
            List<Salutation> titles = new List<Salutation>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            returnCode = titleBL.GetTitle(OrgID, LanguageCode, out titles);
            Salutation selectedSalutation = new Salutation();
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();

                selectedSalutation = titles.Find(Findsalutation);
                ListItem li = new ListItem();
                li.Text = UsrMsgseleNew;
                li.Value = "-1";
                ddSalutation.Items.Add(li);
                ddSalutation.SelectedValue = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadTitle Page", ex);
        }
    }

    public void UpdateDigitalSignature(long lid)
    {
        long lresult = -1;
        Role_BL roleBL = new Role_BL(base.ContextInfo);
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        login.OrgID = OrgID;
        login.LoginID = lid;


        if (flUpload.HasFile)
        {
            if ((flUpload.PostedFile.ContentType.ToLower() == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/jpg")
                || (flUpload.PostedFile.ContentType == "image/pjpeg"))
            {

                login.ImageSource = flUpload.FileBytes;
                login.FilePath = flUpload.FileName;

            }
            lresult = roleBL.UpdateDigitalSignature(login);
        }
    }

    public long InsertLogin()
    {
        long lresult = -1;
        long LoginID = 0;
        Role_BL roleBL = new Role_BL(base.ContextInfo);
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        //login.LoginName = txtName.Text;
        login.LoginName = txtUserName.Text;
        login.OrgID = OrgID;
        login.CreatedBy = LID;
      //  login.PrinterPath = Convert.ToInt32(ddlPrinterName.SelectedItem.Value);
        login.PrinterPath = Convert.ToInt32(ddlPrinterName.SelectedValue);
        if (txtTo.Text != "" && txtTo.Text != null)
        {
            DateTime ValidTo = Convert.ToDateTime(txtTo.Text);
            login.EndDTTM = ValidTo;
        }
        else
        {

            login.EndDTTM = Convert.ToDateTime("1/1/1900 00:00:00");
        }

        if (flUpload.HasFile)
        {
            if ((flUpload.PostedFile.ContentType.ToLower() == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/jpg")
                || (flUpload.PostedFile.ContentType == "image/pjpeg"))
            {

                login.ImageSource = flUpload.FileBytes;
                login.FilePath = flUpload.FileName;

            }

        }

        string EncryptedString = string.Empty;
        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
        obj.Crypt(txtUserName.Text, out EncryptedString); //Added with new parameter in SP
        login.Password = EncryptedString;
        if (TransPass == "Y")
        {
            login.Transactionpasssword = EncryptedString;
        }

        if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
        {
            DateTime PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);

            login.LoginPwdExpDate = PasswordExpiryDate;

        }
        else
        {
            login.LoginPwdExpDate = PasswordExpiryDate;

        }

        if (hdntranspwdexpdate.Value != "" && hdntranspwdexpdate.Value != null)
        {
            DateTime TransationPasswordExpiryDate = Convert.ToDateTime(hdntranspwdexpdate.Value);
            login.TransPwdExpDate = TransationPasswordExpiryDate;

        }
        else
        {
            login.TransPwdExpDate = TransationPasswordExpiryDate;
        }
        if (Chkactivated.Checked == true)
        {
            login.Status = "A";
        }
        else
        {
            login.Status = "D";
        }

        lresult = roleBL.Savesysconfig(login, out LoginID);
        return LoginID;

    }

    public void InsertNurse(long LoginID)
    {
        try
        {
            long lresult = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            Nurse nurse = new Nurse();
            NurseAddress nurseAddress = new NurseAddress();
            List<NurseAddress> nAddress = new List<NurseAddress>();
            DateTime wDate = new DateTime();
            DateTime DOB = new DateTime();
            nurse.NurseName = txtName.Text;
            nurse.OrgID = OrgID;
            nurse.Email = txtEmail.Text;
            nurse.CreatedBy = LID;
            nurse.LoginID = LoginID;
            if (weddingDate.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(weddingDate.Text, out wDate))
                    wDate = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                wDate = new DateTime(1800, 1, 1);
            }
            nurse.WeddingDt = wDate;
            nurse.Sex = ddlSex.SelectedValue;
            nurse.TitleCode = ddSalutation.SelectedValue;
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text, out DOB))
                    DOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DOB = new DateTime(1800, 1, 1);
            }
            nurse.DOB = DOB;
            nurse.Relegion = ddlReligion.SelectedValue;
            nurse.MaritalStatus = ddlMaritialStatus.SelectedValue;
            nurse.Qualification = txtQualification.Text;

           
            if (ConfigValue == "N")
            {
                UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                nAddress.Add(ctrlAddresss.nurseAddress());
            }
            else
            {
                CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                nAddress.Add(ctrlAddresss.nurseAddress());
            }
            nurse.Address = nAddress;
            lresult = nurseBL.SaveNurseBL(nurse);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading InsertNurse Page", ex);
        }
    }

    public void InsertPhysician(long LoginID)
    {
        try
        {
            long lresult = -1;
            Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
            Physician physician = new Physician();
            PhysicianAddress physicianAddress = new PhysicianAddress();
            List<PhysicianAddress> phyAddress = new List<PhysicianAddress>();
            List<AdminInvestigationRate> lstInvRate = new List<AdminInvestigationRate>();
            DateTime wDate = new DateTime();
            DateTime DOB = new DateTime();
            physician.PhysicianName = txtName.Text;
            physician.Email = txtEmail.Text;
            physician.CreatedBy = LID;
            physician.ModifiedBy = LID;
            physician.Sex = ddlSex.SelectedValue;
            physician.LoginID = LoginID;

            if (weddingDate.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(weddingDate.Text, out wDate))
                    wDate = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                wDate = new DateTime(1800, 1, 1);
            }
            physician.WeddingDt = wDate;
            physician.TitleCode = ddSalutation.SelectedValue;
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text, out DOB))
                    DOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DOB = new DateTime(1800, 1, 1);
            }
            physician.DOB = DOB;
            physician.Relegion = ddlReligion.SelectedValue;
            physician.MaritalStatus = ddlMaritialStatus.SelectedValue;
            physician.Qualification = txtQualification.Text;
            physician.OrgID = OrgID;
            physician.PhysicianType = ddlConsultantType.SelectedItem.Value;
            physician.RegNumber = txtRegNumber.Text;

            if (ConfigValue == "N")
            {
                UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                phyAddress.Add(ctrlAddresss.physicianAddress());
            }
            else
            {
                CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                phyAddress.Add(ctrlAddresss.physicianAddress());
            }

            physician.Address = phyAddress;
            lstInvRate = getSpecialityDetails();
            lresult = physicianBL.SavePhysicians(physician, lstInvRate);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading InsertPhysician Page", ex);
        }
    }

    public void InserLoginRole(long RoleID, long LoginID)
    {
        try
        {
            long lresult = -1;
            Role_BL RoleBL = new Role_BL(base.ContextInfo);
            LoginRole LoginRole = new LoginRole();
            LoginRole.LoginID = LoginID;
            LoginRole.RoleID = RoleID;
            LoginRole.CreatedBy = LID;
            LoginRole.ModifiedBy = LID;
            LoginRole.Status = 'A'.ToString();
            lresult = RoleBL.SaveLoginRole(LoginRole);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading login Page", ex);
        }
    }

    public void InsertUsers(long LoginID)
    {
        try
        {
            long lresult = -1;
            Users_BL UserBL = new Users_BL(base.ContextInfo);
            Users User = new Users();
            UserAddress UserAddress = new UserAddress();
            List<UserAddress> pAddress = new List<UserAddress>();
            List<AdminInvestigationRate> lstInvRate = new List<AdminInvestigationRate>();
            DateTime wDate = new DateTime();
            DateTime DOB = new DateTime();
            User.Name = txtName.Text;
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text, out DOB))
                    DOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DOB = new DateTime(1800, 1, 1);
            }

            if (hdnEmpID.Value != "" && hdnEmpID.Value != null)
            {
                long EmpID = Convert.ToInt64(hdnEmpID.Value);
                User.EmpID = EmpID;
            }
            User.DOB = DOB;
            User.SEX = ddlSex.SelectedValue;
            User.Email = txtEmail.Text;
            User.TitleCode = ddSalutation.SelectedValue;
            User.Relegion = ddlReligion.SelectedValue;
            User.MaritalStatus = ddlMaritialStatus.SelectedValue;
            User.Qualification = txtQualification.Text;
            User.OrgID = OrgID;
            User.CreatedBy = LID;
            User.LoginID = LoginID;
            User.AddressID = ILocationID;

            if (weddingDate.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(weddingDate.Text, out wDate))
                    wDate = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                wDate = new DateTime(1800, 1, 1);
            }
            User.WeddingDt = wDate;
            if (ConfigValue == "N")
            {
                UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                pAddress.Add(ctrlAddresss.GetAddress1());
            }
            else
            {
                CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                pAddress.Add(ctrlAddresss.GetAddress1());
            }

            User.Address = pAddress;
            lresult = UserBL.SaveUsers(User);//1
            InserInventoryUser(User);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading User Page", ex);
        }
    }

    public void InsertNurseSpeciality(long LoginID, int SpecialityID)
    {
        try
        {
            long lresult = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            NurseSpeciality nurseSpeciality = new NurseSpeciality();
            nurseSpeciality.NurseID = Convert.ToInt32(LoginID);
            nurseSpeciality.SpecialityID = SpecialityID;
            nurseSpeciality.CreatedBy = Convert.ToString(LID);
            nurseSpeciality.ModifiedBy = Convert.ToString(LID);
            lresult = nurseBL.SaveNurseSpeciality(nurseSpeciality);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading NurseSpeciality Page", ex);
        }

    }

    public List<AdminInvestigationRate> getSpecialityDetails()
    {
        List<AdminInvestigationRate> lstSp = new List<AdminInvestigationRate>();
        string hidValue = hdnSpciality.Value;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    AdminInvestigationRate objSp = new AdminInvestigationRate();
                    objSp.ID = Convert.ToInt32(lineItems[0]);
                    objSp.Amount = 0;
                    objSp.DescriptionName = "";
                    objSp.ReferenceRange = "";
                    //objSp.Type = "";
                    lstSp.Add(objSp);
                }
            }
        }
        return lstSp;
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        //Response.Redirect(@"../Admin/UserMaster.aspx?lid=" + hdnLID.Value + "&rn=" + hdnRName.Value + "&rid=" + hdnRID.Value + "", true);

        long logID = -1;
        long pAddId = 1;
        long returncode = -1;
        string rName = string.Empty;
        List<Attune.Podium.BusinessEntities.Login> lstLLogin = new List<Attune.Podium.BusinessEntities.Login>();
        List<Role> lstLRole = new List<Role>();
        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        List<Physician> lstPhySpeciality = new List<Physician>();
        lblUserName.Visible = false;
        txtUserName.Visible = false;
        chkPreferedUser.Enabled = false;
        Save.Visible = false;
        btnUpdate.Visible = true;
        btnCancel.Visible = true;
        imgUserName.Visible = false;
        lblLoginName.Text = string.Empty;
        logID = Convert.ToInt64(hdnLID.Value);
        rName = hdnRName.Value;
        string[] tempRName;
        string tRName = string.Empty;
        tempRName = rName.Split(',');
        tRName = tempRName[0].ToString();
        returncode = new AdminReports_BL(base.ContextInfo).GetUserDetailtoManage(logID, tRName, pAddId, OrgID, out lstLLogin, out lstLRole, out lstOrgUsers, out lstPhySpeciality);
        string Orolename = string.Empty;
        for (int i = 0; i < lstLRole.Count; i++)
        {
            string[] Drolename = lstLRole[i].Description.Split('?');
            if (Drolename[1] == "Billing")
            {
                Orolename = lstLRole[i].RoleName;
                break;
            }
        }
        lstLRole.RemoveAll(p => p.RoleName == "Billing");
        chkUserType.DataSource = lstLRole;
        chkUserType.DataTextField = "IntegrationName";
        chkUserType.DataValueField = "Description";
        chkUserType.DataBind();
        if (lstOrgUsers.Count > 0)
        {
            hdnUserID.Value = lstOrgUsers[0].OrgUID.ToString();
            ddSalutation.SelectedValue = lstOrgUsers[0].TitleCode;
            txtName.Text = lstOrgUsers[0].Name;
            ddlSex.Text = lstOrgUsers[0].SEX;
            txtEmail.Text = lstOrgUsers[0].Email;
            if (lstOrgUsers[0].DOB != null)
            {
                if (lstOrgUsers[0].DOB != "01/01/1800")
                {
                    tDOB.Text = lstOrgUsers[0].DOB.ToString();
                }
            }
            else
            {

            }
            ddlReligion.SelectedValue = lstOrgUsers[0].Relegion;
            if (lstOrgUsers[0].WeddingDt != null)
            {
                if (lstOrgUsers[0].WeddingDt != "01/01/1800")
                {
                    weddingDate.Text = lstOrgUsers[0].WeddingDt.ToString();
                }
            }
            else
            {
            }
            txtQualification.Text = lstOrgUsers[0].Qualification;
            ddlMaritialStatus.SelectedValue = lstOrgUsers[0].MaritalStatus;
            if (ConfigValue == "N")
            {
                UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                ctrlAddresss.SetAddresstoEdit(lstOrgUsers);
            }
            else
            {
                CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                ctrlAddresss.SetAddresstoEdit(lstOrgUsers);
            }
            // ACX2minusEU.Style.Add("display", "none");
            // ACX2plusEU.Style.Add("display", "block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "showResponses('ACX2plus2','ACX2minus2','ACX2responses2',1);", true);
        }
    }

    protected void btnSearch1_Click(object sender, EventArgs e)
    {
        txtName1.Text = txtName.Text;
        btnSearch_Click(sender, e);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblUserName.Visible = true;
        txtUserName.Visible = true;
        chkPreferedUser.Enabled = true;
        Save.Visible = true;
        btnUpdate.Visible = false;
        btnCancel.Visible = false;
        imgUserName.Visible = true;

        try
        {
            GetUserDetails(e, currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin Users Manage Home", ex);
        }
        TxtClear();
        lblLoginName.Text = string.Empty;
    }

    private void GetUserDetails(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            long returnCode = -1;
           
            int chkValue;
            if (chkbxDelete.Checked == true)
            {
                hdnInclude.Value = "1";
                chkValue = int.Parse(hdnInclude.Value);
            }
            else
            {
                chkValue = int.Parse(hdnInclude.Value);
            }
		    string pCategory = string.Empty; ;
            if (rbtnUser.Checked == true) { pCategory = "Users"; }
            else if (rbtnPatient.Checked == true) { pCategory = "Patient"; }
            else if (rbtnOnline.Checked == true) { pCategory = "Online"; }
            returnCode = new AdminReports_BL(base.ContextInfo).GetUserstoManage(OrgID, txtName1.Text, chkValue, PageSize, currentPageNo, pCategory, out totalRows, out lstUsers, out lstUsersForExcel);
            if (lstUsers.Count > 0)
            {
               // loaddata(lstUsers);
                grdResult.Visible = true;
                lblMsg.Text = "";

                //grdResult.DataSource = lstUsers.FindAll(P=>P.Status.ToUpper()=="A").ToList();                
                grdResult.DataSource = lstUsers;
                grdResult.DataBind();

                //btnEdit.Visible = true;
                //btnDelete.Visible = true;
            }
            else
            {
                grdResult.Visible = false;
                lblMsg.Text = Update_msg1;
            }

            ACX2responses2.Style.Add("display", "none");
            ACX2minus2.Style.Add("display", "none");
            ACX2plus2.Style.Add("display", "block");
            //Save.Visible = false;

            ACX2responsesEU.Style.Add("display", "table-row");
            ACX2minusEU.Style.Add("display", "block");
            ACX2plusEU.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome", ex);
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string Msg2 = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_02 == null ? "Click here to edit details !!" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_02;
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblSym = (Label)e.Row.FindControl("lblSymbol");
                LinkButton lnkbtn = (LinkButton)e.Row.FindControl("lnkCreatePwd");
                if (rbtnOnline.Checked == true)
                {
                    lblSym.Visible = true;
                    lnkbtn.Visible = true;
                }
                //Users p = (Users)e.Row.DataItem;
                ////string strScript = "SelectUserName('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.LoginID + "', '" + p.RoleName + "', '" + p.RoleID + "', '" + p.OrgUserID + "');";
                //string strScript = "SelectUserName('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.LoginID + "', '" + p.RoleName + "');";
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //Label lbl = (Label)e.Row.FindControl("lbledit");
                //lbl.Text = "Edit";
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                Label lbl = (Label)e.Row.FindControl("lblStatus");
                LinkButton objBtn = ((LinkButton)e.Row.FindControl("lnkDelete"));
                e.Row.ToolTip = Msg2;
                if (lbl.Text == "A")
                {
                    objBtn.Enabled = true;
                    hdnLoginStatus.Value = lbl.Text;
                    //Commented by BabuMani on 1 Sept 2016 for issue 
                    //"While picking inactive user,it is displaying as active status" Raised by Santhosh on build no 3.0.3 Regr
                    //Chkactivated.Checked = false;  
                }
                else
                {
                    objBtn.Enabled = false;
                    hdnLoginStatus.Value = "";
                    //Commented by BabuMani on 1 Sept 2016 for issue 
                    //"While picking inactive user,it is displaying as active status" Raised by Santhosh on build no 3.0.3 Regr
                    //Chkactivated.Checked = false;  
                    
                }
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
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

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

       
        if (e.NewPageIndex >= 0)
        {
            grdResult.PageIndex = e.NewPageIndex;
           
        }
        GetUserDetails(e, currentPageNo, PageSize);
    }
   
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        

        try
        {
            grdResult.AllowPaging = false;
            grdResult.Columns[12].Visible = false;
            grdResult.Columns[13].Visible = false;
            GetUserDetails(e, currentPageNo, PageSize);

     
            if (lstUsers.Count > 0)
            {

              
                var lstUsersquery = lstUsers.FindAll(O => !O.RoleName.Contains("Patient"));
                




              // var user = lstUsersquery.OrderBy(c => c.Name);

                var user = lstUsersquery.OrderBy(c => c.Name);//.ThenBy(n => n.RoleName);
                grdResult.DataSource = user;
                grdResult.DataBind();                              
             
            }

            ExportToExcel();
            grdResult.AllowPaging = true;
            grdResult.Columns[12].Visible = true;
            grdResult.Columns[13].Visible = true;
            grdResult.DataSource = lstUsers;          

            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }


        
    }

    public void ExportToExcel()
    {
        ////export to excel
       
        string attachment = "attachment; filename=" + OrgTimeZone + "manage user.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        grdResult.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();

    }
    
   

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
  

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            long orgUID = 0;
            long oroleID = 0;
            long ModifiedBy = LID;
            returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(Convert.ToInt64(hdnLID.Value), orgUID, hdnRName.Value, oroleID, ModifiedBy);
            GetUserDetails(e, currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome.aspx", ex);
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("UserMaster.aspx");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome.aspx", ex);
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

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "GeneratePWD")
            {
                    long returnCode = -1;
                    string Name = grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][3].ToString();
                    string PWD = "9XJ/qqe45hc=";
                    string AlertMsg = string.Empty;

                    if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                    {
                        PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);
                    }
                    if (hdntranspwdexpdate.Value != "" && hdntranspwdexpdate.Value != null)
                    {
                        TransationPasswordExpiryDate = Convert.ToDateTime(hdntranspwdexpdate.Value);
                    }
                    if (TransPass == "Y")
                    {
                        returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "", oldtransPassword, PWD, PWD, PasswordExpiryDate, TransationPasswordExpiryDate);
                    }
                    else
                    {
                        DateTime Transpwdexpdate = Convert.ToDateTime("1/1/1753 12:00:00");
                        returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "", oldtransPassword, PWD, newtransPwd, PasswordExpiryDate, Transpwdexpdate);
                    }
                    if (returnCode != -1)
                    {
                        string DecryptedStringPWD = string.Empty;
                        Attune.Cryptography.CCryptography objDecryptor = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                        objDecryptor.Crypt(PWD, out DecryptedStringPWD);

                        if (TransPass == "Y")
                        {
                            lblLoginNam.Text = "<h4>" + "LoginName : " + Name + " &nbsp; Password :  " + DecryptedStringPWD + " Transaction Password : " + DecryptedStringPWD + "</h4>";
                            AlertMsg = "LoginName : " + Name + " Password :  " + DecryptedStringPWD + " Transaction Password : " + DecryptedStringPWD + ""; 
                        }
                        else
                        {
                            lblLoginNam.Text = "<h4>" + "LoginName : " + Name + " &nbsp; Password :  " + DecryptedStringPWD + "</h4>";
                            AlertMsg = "LoginName : " + Name + " Password :  " + DecryptedStringPWD + "";
                        }
                    }
                    GetUserDetails(e, currentPageNo, PageSize);
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert(' " + AlertMsg + " ');", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg1", "DisplayTab('EXIST');", true);
                }

            if (e.CommandName == "Reset")
            {
                long returnCode = -1;
                if (hdnRstPswd.Value == "1")
                {
                    //string Name = grdResult.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
                    string Name = grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][3].ToString();

                    string EncryptedString = string.Empty;
                    Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    obj.Crypt(Name, out EncryptedString);
                    Name = EncryptedString;

                    if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                    {
                        PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);



                    }
                    if (hdntranspwdexpdate.Value != "" && hdntranspwdexpdate.Value != null)
                    {
                        TransationPasswordExpiryDate = Convert.ToDateTime(hdntranspwdexpdate.Value);


                    }
                    if (TransPass == "Y")
                    {



                        returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "", oldtransPassword, Name, Name, PasswordExpiryDate, TransationPasswordExpiryDate);


                    }
                    else
                    {
                        DateTime Transpwdexpdate = Convert.ToDateTime("1/1/1753 12:00:00");
                        //returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "", Name);
                        returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "", oldtransPassword, Name, newtransPwd, PasswordExpiryDate, Transpwdexpdate);

                    }



                    if (returnCode != -1)
                    {
                        string DecryptedString = string.Empty;
                        Attune.Cryptography.CCryptography objDecryptor = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                        objDecryptor.Crypt(Name, out DecryptedString);
                        string LoginName = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_05;
                        string Passwor = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_06;
                        string TransPwd = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_07;
                        if (TransPass == "Y")
                        {

                            lblLoginNam.Text = "<h4>" + LoginName + DecryptedString + Passwor + DecryptedString + TransPwd + DecryptedString + "</h4>";
                        }
                        else
                        {
                            //lblLoginNam.Text = "<h4>" + "LoginName : " + Name + " &nbsp; Password :  " + Name + "</h4>";
                            lblLoginNam.Text = "<h4>" + LoginName + DecryptedString + Passwor + DecryptedString + "</h4>";
                        }
                    }
                    GetUserDetails(e, currentPageNo, PageSize);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg1", "DisplayTab('EXIST');", true);
                }
                else
                {
                    GetUserDetails(e, currentPageNo, PageSize);
                }
            }
            if (e.CommandName == "Select")
            {
                //ACX2responses2.Style.Add("display", "block");
                //ACX2minus2.Style.Add("display", "none");
                //ACX2plus2.Style.Add("display", "none");



                //Added by sudha for IsBlocked Visibility
                ChkBlocked.Visible = true;

                lnkCreateNewUser.Visible = true;
                hdnID.Value = String.Empty;
                hdn.Value = String.Empty;
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnID.Value = RowIndex.ToString();
                long logID = -1;
                long pAddId = 1;
                long returncode = -1;
                string tRName = string.Empty;
                string RName = string.Empty;
                int id;

                List<Attune.Podium.BusinessEntities.Login> lstLLogin = new List<Attune.Podium.BusinessEntities.Login>();
                List<Role> lstLRole = new List<Role>();
                List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
                List<Physician> lstPhySpeciality = new List<Physician>();
                List<LocationUserMap> lstLocationUserMap = new List<LocationUserMap>();

                lblUserName.Visible = false;
                txtUserName.Visible = false;
                chkPreferedUser.Checked = false;
                chkPreferedUser.Enabled = false;
                Save.Visible = false;
                btnUpdate.Visible = true;
                btnCancel.Visible = true;
                imgUserName.Visible = false;
                lblLoginName.Text = string.Empty;
                tdlEmp.Attributes.Add("Style", "Display:None");
                tdEmp.Attributes.Add("Style", "Display:None");
                logID = Convert.ToInt64(grdResult.DataKeys[RowIndex][0]);
                hdnlogID.Value = grdResult.DataKeys[RowIndex][0].ToString();
                // tRName = grdResult.DataKeys[RowIndex][1].ToString();
                tRName = grdResult.DataKeys[RowIndex][4].ToString();
                // RName = tRName.Split(',').ToString();
                hdn.Value = grdResult.DataKeys[RowIndex][1].ToString();
                id = Convert.ToInt16(grdResult.DataKeys[RowIndex][2]);
                txtTo.Text = Convert.ToDateTime(grdResult.DataKeys[RowIndex][6].ToString()).ToShortDateString();
                txtBlockFrom.Text = Convert.ToDateTime(grdResult.DataKeys[RowIndex][7].ToString()).ToShortDateString();
                txtBlockTo.Text = Convert.ToDateTime(grdResult.DataKeys[RowIndex][8].ToString()).ToShortDateString();

                //Added by BabuMani on 1 Sept 2016 for issue 
                //"While picking inactive user,it is displaying as active status" Raised by Santhosh on build no 3.0.3 Regr
                Label lbl = (Label)grdResult.Rows[RowIndex].FindControl("lblStatus");
                if (lbl.Text == "A")
                {
                    Chkactivated.Checked = true;
                }
                else
                {
                    Chkactivated.Checked = false;
                }

                if (grdResult.DataKeys[RowIndex][9] != null && grdResult.DataKeys[RowIndex][9] != "")
                {

                    if (grdResult.DataKeys[RowIndex][9].ToString() != "Select")
                    {
                        drpReason.SelectedValue = grdResult.DataKeys[RowIndex][9].ToString();
                    }
                    drpReason.Enabled = false;
                    tdlreason.Attributes.Add("Style", "Display:table-cell");
                    tdtreason.Attributes.Add("Style", "Display:table-cell");
                }



                if (txtTo.Text != "01/01/0001" && txtTo.Text != "01/01/1901" && txtTo.Text != "")
                {
                    trValid.Attributes.Add("Style", "Display:table-row");

                }
                else
                {
                    trValid.Attributes.Add("Style", "display:table-row");
                    txtTo.Text = "";
                }

                if (txtBlockFrom.Text == "01/01/0001" || txtBlockFrom.Text == "01/01/1901" || txtBlockFrom.Text == "")
                {
                    tdlreason.Attributes.Add("Style", "display:none");
                    tdtreason.Attributes.Add("Style", "display:none");
                    trBlockDate.Attributes.Add("Style", "display:none");
                    txtBlockFrom.Text = "";

                }
                else
                {
                    hdnIsBlock.Value = "Y";
                    trBlock.Attributes.Add("Style", "display:table-row");
                    trBlockDate.Attributes.Add("Style", "display:table-row");
                    ChkBlocked.Checked = true;


                }

                if (txtBlockTo.Text == "" || txtBlockTo.Text == "01/01/0001" || txtBlockTo.Text == "01/01/1901")
                {
                    txtBlockTo.Text = "";
                }

                Speciality.Attributes.Add("Style", "Display:None");
                trConType.Attributes.Add("Style", "Display:None");

                trBlock.Attributes.Add("Style", "display:table-row");

                GetUserImage(logID);
                returncode = new AdminReports_BL(base.ContextInfo).GetUserDetailtoManage(logID, tRName, pAddId, OrgID, out lstLLogin, out lstLRole, out lstOrgUsers, out lstPhySpeciality);
                string Orolename = string.Empty;
                for (int i = 0; i < lstLRole.Count; i++)
                {
                    string[] Drolename = lstLRole[i].Description.Split('?');
                    if (Drolename[1] == "Billing")
                    {
                        Orolename = lstLRole[i].RoleName;
                        break;
                    }
                }
                lstLRole.RemoveAll(p => p.RoleName == "Billing");
                chkUserType.DataSource = lstLRole;
                chkUserType.DataTextField = "IntegrationName";
                chkUserType.DataValueField = "Description";
                chkUserType.DataBind();
                hdnSpciality.Value = String.Empty;
                hdnLocation.Value = string.Empty;
                foreach (string txt in hdn.Value.Split(','))
                {
                    foreach (ListItem item in chkUserType.Items)
                    {

                        if (item.Text.Trim() == txt.Trim())
                        {
                            item.Selected = true;
                        }
                    }
                }
                foreach (ListItem item in chkUserType.Items)
                {
                    if (item.Selected == true)
                    {
                        string[] CheckListValue = item.Value.Split('?');
                        int rollID = Convert.ToInt32(CheckListValue[0]);
                        string GRoleName = CheckListValue[1];
                        if (GRoleName == "Project Stockist" || GRoleName == "PI" || GRoleName == "Project Manager")
                        {
                            GRoleName = "Inventory";
                        }
                        if (GRoleName == "Physician")
                        {
                            Speciality.Attributes.Add("Style", "Display:Block");
                            trConType.Style.Add("display", "table-row");
                            if (lstOrgUsers.Count > 0)
                            {
                                trConType.Attributes.Add("Style", "Display:table-row");
                                Speciality.Attributes.Add("Style", "Display:Block");

                                //speciality list
                                tblSpeciality.Attributes.Add("Style", "Display:table");
                                //selected speciality list
                                if (lstPhySpeciality.Count > 0)
                                {
                                    foreach (Physician ispe in lstPhySpeciality)
                                    {
                                        hdnSpciality.Value += ispe.SpecialityID.ToString() + "~" + ispe.SpecialityName + "^";
                                    }
                                    for (int i = 0; i < ddlConsultantType.Items.Count; i++)
                                    {
                                        if (ddlConsultantType.Items[i].Value.ToString() == lstPhySpeciality[0].PhysicianType.Trim())
                                        {
                                            ddlConsultantType.SelectedIndex = i;
                                            break;
                                        }
                                    }
                                    txtRegNumber.Text = lstPhySpeciality[0].RegNumber;

                                    string fvar = "Speciality";
                                    string svar = "testSpe();";
                                    string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Speciality", "testSpe();", true);
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + fvar + svar + "','" + Information + "');", true);

                                }

                            }

                        }
                        if (item.Selected == true)
                        {
                            if (GRoleName == "Inventory")
                            {
                                Location.Attributes.Add("Style", "Display:Block");
                                tblInv.Attributes.Add("Style", "Display:table");
                                Location.Attributes.Add("style", "Display:Block");
                                int OrgAddressID;
                                OrgAddressID = 0;
                                new GateWay(base.ContextInfo).GetLocationUserMap(logID, OrgID, OrgAddressID, out lstLocationUserMap);

                                if (lstLocationUserMap.Count > 0)
                                {
                                    hdnLocation.Value = string.Empty;
                                    foreach (LocationUserMap iloc in lstLocationUserMap)
                                    {
                                        hdnLocation.Value += iloc.LocationID.ToString() + "~" + iloc.LocationName + "~" + iloc.OrgAddressID + "^";
                                    }
                                    string fvarLoc = "Location";
                                    string SvarLoc = "testLoc();";
                                    string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Location", "testLoc();", true);
                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('"  + SvarLoc + "','" + Information + "');", true);


                                }
                            }
                        }
                    }
                }
                if (lstOrgUsers.Count > 0)
                {
                    hdnUserID.Value = lstOrgUsers[0].OrgUID.ToString();
                    ddSalutation.SelectedValue = lstOrgUsers[0].TitleCode;
                    txtName.Text = lstOrgUsers[0].Name;
                    ddlSex.Text = lstOrgUsers[0].SEX;
                    txtEmail.Text = lstOrgUsers[0].Email;
                    ddlConsultantType.SelectedItem.Value = lstOrgUsers[0].PhysicianType;
                    if (lstOrgUsers[0].DOB != null)
                    {
                        if (lstOrgUsers[0].DOB != "01/01/1800")
                        {
                            tDOB.Text = lstOrgUsers[0].DOB.ToString();
                        }
                    }
                    else
                    {

                    }
                    ddlReligion.SelectedValue = lstOrgUsers[0].Relegion;
                    if (lstOrgUsers[0].WeddingDt != null)
                    {
                        if (lstOrgUsers[0].WeddingDt != "01/01/1800")
                        {
                            weddingDate.Text = lstOrgUsers[0].WeddingDt.ToString();
                        }
                    }
                    else
                    {
                    }
                    txtQualification.Text = lstOrgUsers[0].Qualification;
                    ddlMaritialStatus.SelectedValue = lstOrgUsers[0].MaritalStatus;

                    ddlConsultantType.SelectedItem.Value = lstOrgUsers[0].PhysicianType;

                    ACX2responsesEU.Style.Add("display", "none");
                    ACX2minusEU.Style.Add("display", "none");
                    ACX2plusEU.Style.Add("display", "block");

                }
                if (ConfigValue == "N")
                {
                    UserControl_AddressControl ctrlAddresss = (UserControl_AddressControl)this.Page.FindControl(hdnControleID.Value);
                    ctrlAddresss.SetAddresstoEdit(lstOrgUsers);
                }
                else
                {
                    CommonControls_PatientAddress ctrlAddresss = (CommonControls_PatientAddress)this.Page.FindControl(hdnControleID.Value);
                    ctrlAddresss.SetAddresstoEdit(lstOrgUsers);
                }
                if (e.CommandName == "SUSPEND")
                {
                    //long logID = -1;
                    int RI = Convert.ToInt32(e.CommandArgument);
                    logID = Convert.ToInt64(grdResult.DataKeys[RI][0]);
                }
            }
            else if (e.CommandName == "History")
            {
                if (e.CommandArgument.ToString() != "")
                {
                    long ID = -1;
                    ID = Convert.ToInt64(e.CommandArgument);
                    if (ID != -1)
                    {
                        audit_History.ViewAudit_History(ID, OrgID, "USRMST");
                        ModelPopPatientSearch.Show();
                    }
                }
            }
            lnkLocationMap.Style.Add("display", "block");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin UserMasterHome.aspx", ex);
        }
    }
    protected void chkUserType_DataBound(object sender, EventArgs e)
    {
        string chklistitems = string.Empty;
        CheckBoxList chkUserType = (CheckBoxList)(sender);

        foreach (ListItem item in chkUserType.Items)
        {
            // string strScript = "onChaangeChk('" + ((CheckBox)e.Row.Cells[1].FindControl("rdSel")).ClientID + "');"; 
            string[] CheckListValue = item.Value.Split('?');
            String pRoleName = CheckListValue[1];
            // item.Attributes.Add("onclick", "hideSpeciality('" + pRoleName + "');");
            string chkitemnamesDes = item.Text;
            hdnchkitems.Value += pRoleName + '$' + chkitemnamesDes + '#';
        }

    }
    protected void grdResult_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        long returnCode = -1;
        try
        {
            string txt = grdResult.DataKeys[e.RowIndex].Values[4].ToString();
            // long orgUID = 0;
            long ModifiedBy = LID;
            long oroleID = 1;
            if (hdndeletepswd.Value == "1")
            {
                foreach (string value in txt.Split(','))
                {
                    returnCode = new AdminReports_BL(base.ContextInfo).DeleteUserDetail(Convert.ToInt64(grdResult.DataKeys[e.RowIndex].Values[0]), OrgID, value, oroleID, ModifiedBy);
                }
                GetUserDetails(e, currentPageNo, PageSize);
            }
            else
            {
                GetUserDetails(e, currentPageNo, PageSize);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Delete UserMasterHome.aspx", ex);
        }
    }

    private void InserInventoryUser(Users User)
    {
        long lresult = -1;
        List<Locations> lstLoc = new List<Locations>();
        Users_BL UserBL = new Users_BL(base.ContextInfo);
        foreach (ListItem li in chkUserType.Items)
        {
            if (li.Selected)
            {
                string[] CheckListValue = li.Value.Split('?');
                int rollID = Convert.ToInt32(CheckListValue[0]);
                string GRoleName = CheckListValue[1];
                if (GRoleName == "Project Stockist" || GRoleName == "PI" || GRoleName == "Project Manager")
                {
                    GRoleName = "Inventory";
                }
                if (li.Value != hdnRID.Value)
                {
                    //int rollID = Convert.ToInt32(li.Value);
                    if (GRoleName == "Inventory")
                    {
                        lstLoc = getLocationDetails();
                        lresult = new Users_BL(base.ContextInfo).SaveInvLocationUserMap(User, lstLoc);
                    }
                }
            }
        }
    }

    public void GetUserImage(long logID)
    {
        long returnCode = -1;
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        Role_BL roleBL = new Role_BL(base.ContextInfo);
        returnCode = roleBL.GetUserImage(OrgID, logID, out login);
        byte[] byteArray = login.ImageSource;
        if (byteArray != null && byteArray.Count() > 0)
        {
            imgView.Visible = true;
            imgView.Src = "UserImageHandler.ashx?OrgID=" + OrgID + "&LoginID=" + logID;
        }
        else
        {
            imgView.Visible = false;
        }
    }

    public void UpdateSpeciality()
    {
        long Lresult = -1;
        Physician_BL UpdatePhysicianSpecialityBL = new Physician_BL(base.ContextInfo);

        List<Speciality> PhySpeciality = new List<Speciality>();
        PhySpeciality = RetSpecialityDetails();
        int row = int.Parse(hdnID.Value);
        int PhID = Convert.ToInt32(grdResult.DataKeys[row][0]);
        Lresult = UpdatePhysicianSpecialityBL.UpdatePhysicianSpeciality(PhID, PhySpeciality);

        //int pPhysicianID = -1;
        //long Lresult = -1;
        //int row = int.Parse(hdnID.Value);
        //pPhysicianID = Convert.ToInt32(grdResult.DataKeys[row][0]);

        //Speciality_BL UpdatePhysicianSpecialityBL = new Speciality_BL(base.ContextInfo);
        //List<AdminInvestigationRate> SpecialityList = new List<AdminInvestigationRate>();
        //SpecialityList = getSpecialityDetails();
        //Lresult = UpdatePhysicianSpecialityBL.UpdatePhysicianSpeciality(SpecialityList, pPhysicianID);

    }

    public List<Speciality> RetSpecialityDetails()
    {
        List<Speciality> lstSp = new List<Speciality>();
        hdnSpciality.Visible = true;
        string hidValue = hdnSpciality.Value;
        //int row = int.Parse(hdnID.Value);
        //int PhID=Convert.ToInt32(grdResult.DataKeys[row][0]);
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    Speciality objSp = new Speciality();
                    objSp.SpecialityID = Convert.ToInt32(lineItems[0]);
                    //objSp.PhysicianID= PhID;
                    lstSp.Add(objSp);

                }
            }
        }
        return lstSp;

    }

    public List<Locations> getLocationDetails()
    {
        List<Locations> lstLoc = new List<Locations>();
        string hidValue = hdnLocation.Value;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                if (lineItems.Length > 0)
                {
                    Locations objLoc = new Locations();
                    objLoc.LocationID = Convert.ToInt32(lineItems[0]);
                    //===================jayamoorthi==========================
                    objLoc.OrgAddressID = Convert.ToInt32(lineItems[2]);
                    //=====================================================-==
                    //objSp.Type = "";
                    //objLoc.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    lstLoc.Add(objLoc);
                }
            }
        }
        return lstLoc;
    }

    public void Speciality1()
    {
        try
        {

            long lresult = -1;
            Speciality_BL SpecialityBL = new Speciality_BL(base.ContextInfo);
            List<Speciality> lstspeciality = new List<Speciality>();
            lresult = SpecialityBL.GetSpeciality(OrgID, out lstspeciality);
            if (lstspeciality.Count > 0)
            {
                lstBoxSpeciality.DataSource = lstspeciality;
                lstBoxSpeciality.DataTextField = "SpecialityName";
                lstBoxSpeciality.DataValueField = "SpecialityID";
                lstBoxSpeciality.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Speciality Page", ex);
        }
    }

    public void BindInventoryLocation()
    {
        try
        {
            long lresult = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

            int OrgAddid = ILocationID;
            //int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID,ILocationID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}

            OrgAddid = 0;
            SharedInventory_BL InventoryBL = new SharedInventory_BL(base.ContextInfo);
            List<Locations> lstInvLocation = new List<Locations>();
            lresult = InventoryBL.GetInvLocationDetail(OrgID, OrgAddid, out lstInvLocation);
            if (lstInvLocation.Count > 0)
            {
                tdInventoryLocation.Style.Add("display", "table-cell");
                ListBoxInv.DataSource = lstInvLocation;
                ListBoxInv.DataTextField = "OrgAddressName";
                ListBoxInv.DataValueField = "LocationID";
                ListBoxInv.DataBind();
                foreach (var item in lstInvLocation)
                {
                    hdnLocationList.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "~" + item.OrgAddressID + "^";

                }


            }
            else
            {

                tdInventoryLocation.Style.Add("display", "table-cell");

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Location Page", ex);
        }
    }

    protected void lnkCreateNewUser_Click(object sender, EventArgs e)
    {
        TxtClear();
        btnUpdate.Visible = false;
        Save.Visible = true;
        lblUserName.Visible = true;
        txtUserName.Visible = true;
        chkPreferedUser.Enabled = true;
    }


    #region LoadProductType
    private void BindLocationType()
    {
        SharedInventory_BL inventoryBL = new SharedInventory_BL(base.ContextInfo);
        List<LocationType> lstTempLocationType = new List<LocationType>();
        List<LocationType> lstLocationType = new List<LocationType>();
        try
        {
            inventoryBL.GetLocationType(out lstTempLocationType);
            foreach (LocationType item in lstTempLocationType)
            {
                item.LocationTypeCode = item.LocationTypeName + " (" + item.LocationTypeCode + ")";
                lstLocationType.Add(item);
            }
            ddlLocationType.DataSource = lstLocationType;
            ddlLocationType.DataTextField = "LocationTypeCode";
            ddlLocationType.DataValueField = "LocationTypeID";
            ddlLocationType.DataBind();
            ddlLocationType.Items.Insert(0, UsrMsgselLoc);
            ddlLocationType.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - UserMaster.aspx", ex);
           // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    #endregion

    private void BindProductType()
    {

        inventoryBL.GetProductType(OrgID, out lstProductType);
        chklistProductType.DataSource = lstProductType;
        chklistProductType.DataTextField = "TypeName";
        chklistProductType.DataValueField = "TypeID";
        chklistProductType.DataBind();
    }
    protected void btnOK_click(object sender, EventArgs e)
    {

        long returnCode = -1;
        //string protypeid = string.Empty;
        try
        {
            objInvLocation.OrgAddressID = ILocationID;
            objInvLocation.OrgID = OrgID;
            for (int i = 0; i < chklistProductType.Items.Count; i++)
            {
                Locations objInvLocation1 = new Locations();
                if (chklistProductType.Items[i].Selected == true)
                {

                    objInvLocation1.ProductTypeID = chklistProductType.Items[i].Value;

                }
                else objInvLocation1.ProductTypeID = "0";
                if (hdnLocationID.Value == "")
                {
                    hdnLocationID.Value = "0";
                }
                else
                {
                    objInvLocation1.LocationID = int.Parse(hdnLocationID.Value);
                }

                if (chkStatus.Checked == true)
                {
                    objInvLocation.IsActive = "Y";
                }
                else
                {
                    objInvLocation.IsActive = "N";
                }
                objInvLocation1.LocationName = txtLocation.Text;
                objInvLocation1.LocationTypeID = int.Parse(ddlLocationType.SelectedValue);
                objInvLocation1.OrgID = OrgID;
                objInvLocation1.CreatedBy = LID;
                objInvLocation1.OrgAddressID = int.Parse(drpOrgAddress.SelectedValue);
                objInvLocation1.IsActive = objInvLocation.IsActive;
                lstInvLocation.Add(objInvLocation1);
            }

            //for (int i = 0; i < chklistProductType.Items.Count; i++)
            //{
            //    if (chklistProductType.Items[i].Selected == true)
            //    {
            //         // Initialize a string to hold the comma-delimited data as empty
            //        if (protypeid.Length > 0)
            //        {
            //            protypeid += ", "; // Add a comma if data already exists
            //        }

            //        protypeid +=  chklistProductType.Items[i].Value;
            //       // protypeid = Convert.ToInt32(chklistProductType.Items[i].Value);
            //    }           
            //}
            returnCode = inventoryBL.SaveInvLocation(lstInvLocation);
            if (returnCode == 0)
            {

                //lblmsgloc.Text = "Location Updated sucessfully";
                lblmsgloc.Text = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_08 == null ? "Location Updated sucessfully" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_08;

                txtLocation.Text = "";
                ddlLocationType.SelectedValue = "0";
                for (int i = 0; i < chklistProductType.Items.Count; i++)
                {
                    chklistProductType.Items[i].Selected = false;
                }

            }
            else
            {
                //lblmsgloc.Text = "Location Updation Failed";

                lblmsgloc.Text = Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_09 == null ? "Location Updation Failed" : Resources.Admin_ClientDisplay.Admin_UserMaster_aspx_09;
            }
            lblmsgloc.Visible = true;
            chkStatus.Checked = false;

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Saving Inventory Location - InventoryLocation.aspx", Ex);
        //    ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        BindInventoryLocation();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Speciality", "testSpe();", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Location", "testLoc();", true);
        //chkUserType.SelectedIndex = -1;

    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,ConsultantType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
			
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ConsultantType"
                                 orderby child.DisplayText descending
                                 select child;
                ddlConsultantType.DataSource = childItems;
                ddlConsultantType.DataTextField = "DisplayText";
                ddlConsultantType.DataValueField = "Code";
                ddlConsultantType.DataBind();


                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  orderby child.Code descending
                                  select child;

                ddlSex.DataSource = childItems1;
                ddlSex.DataTextField = "DisplayText";
                ddlSex.DataValueField = "Code";
                ddlSex.DataBind();
                ddlSex.Items.Insert(0, UsrMsgseleNew);
                ddlSex.Items[0].Value = "0";
                ddlSex.SelectedValue = "M";

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "MaritalStatus"
                                  orderby child.MetaDataID ascending
                                  select child;

                ddlMaritialStatus.DataSource = childItems2;
                ddlMaritialStatus.DataTextField = "DisplayText";
                ddlMaritialStatus.DataValueField = "Code";
                ddlMaritialStatus.DataBind();

                ddlMaritialStatus.Items.Insert(0, UsrMsgseleNew);
                ddlMaritialStatus.Items[0].Value = "0";
                ddlMaritialStatus.SelectedValue = "0";



            }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void ShowPopUp(long LoginID)
    {
        List<Role> lstRoles = new List<Role>();
        foreach (ListItem lst in chkUserType.Items)
        {
            if (lst.Selected == true)
            {
                Role RL = new Role();
                RL.RoleID = Convert.ToInt64(lst.Value.Split('?')[0]);
                RL.RoleName = lst.Text;
                lstRoles.Add(RL);
            }
        }

        LocationUserMap.getUserLocation(OrgID, txtName.Text, LoginID, lstRoles);
        ModelPopLocationMap.Show();
    }

    protected void lnkLocationMap_Click(object sender, EventArgs e)
    {
        long LoginID = -1;
        if (hdnlogID.Value != "")
        {
            LoginID = Convert.ToInt64(hdnlogID.Value);
        }
        ShowPopUp(LoginID);
    }

    public void LoadReligion()
    {
        try
        {
            long returnCode = -1;
            List<Religion> lstReligion = new List<Religion>();
            returnCode = new Country_BL(base.ContextInfo).GetReligionList(out lstReligion);
            if (returnCode == 0)
            {
                ddlReligion.DataSource = lstReligion;
                ddlReligion.DataTextField = "ReligionName";
                ddlReligion.DataValueField = "ReligionID";
                ddlReligion.DataBind();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
           // ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }
}