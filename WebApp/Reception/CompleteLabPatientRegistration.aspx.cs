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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Text;
using Attune.Podium.Common;
using System.Web.Caching;
using Attune.Solution.DAL;
using System.Security.Cryptography;

public partial class Reception_CompleteLabPatientRegistration : BasePage
{
    public Reception_CompleteLabPatientRegistration()
        : base("Reception\\CompleteLabPatientRegistration.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {

        base.page_Init(sender, e);
    }
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    string TransPass = string.Empty;
    long LabRefOrgID = -1;
    long PPatientID = -1;
    int pPriorityID = -1;
    long returnCode = -1;
    int pCollectionCentreID = 0;
    int pAge = 0;
    Referrals_BL objReferrals_BL;
    string pPriorityName = string.Empty;
    List<KnowledgeOfService> lstKnowledgeOfService = new List<KnowledgeOfService>();
    List<VisitKnowledgeMapping> lstVisitKnowledgeMapping = new List<VisitKnowledgeMapping>();
    KnowledgeOfService_BL objKnowledgeOfService_BL;
    List<KnowledgeOfServiceAttributes> lstKnowledgeOfServiceAttributes = new List<KnowledgeOfServiceAttributes>();
    int mode = 0;
    long pLabRefOrgID = -1;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    List<PhysicianOrgMapping> pomCopy = new List<PhysicianOrgMapping>();
    long LoginID = 0;
    string RoleId = "";
    Patient_BL patientBL;
    List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
    ReferingPhysician objReferingPhysician = new ReferingPhysician();
    string physicianName = string.Empty;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    protected void Page_Load(object sender, EventArgs e)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        objKnowledgeOfService_BL = new KnowledgeOfService_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);
        roleBL = new Role_BL(base.ContextInfo);
        long result = -1;
        ddSalutation.Attributes.Add("onchange", "setSexValueBySting('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        //ddSex.Attributes.Add("onchange", "setSexValueBySting('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtPatientName.Attributes.Add("onkey5down", "return onKeyPressBlockNumbers(event);");
        txtName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtAge.Attributes.Add("onblur", "age();");
        txtAge.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
        tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
        chkUserLogin.Attributes.Add("onclick", "ShowLogin(this)");
        AutoRname.ContextKey = Convert.ToString(OrgID);
        AutoCompleteProduct.ContextKey = Convert.ToString("Y");
        AutoCompleteExtender1.ContextKey = OrgID.ToString();
        btnClinicSave.Attributes.Add("OnClientClick", "return validateLabRefOrgDetails();");

        //txtName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");

        if (ddCountry.Items.Count <= 0)
            LoadCountry();
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out PPatientID);

            txtMobile.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            if (IsPostBack)
            {

                if (rdoHospital.Checked)
                {
                    CTHospital.Style.Add("display", "block");
                    CTBranch.Style.Add("display", "none");
                    rdoHospital.Checked = true;
                    rdoBranch.Checked = false;
                }
                else if (rdoBranch.Checked)
                {
                    CTHospital.Style.Add("display", "none");
                    CTBranch.Style.Add("display", "block");
                    rdoHospital.Checked = false;
                    rdoBranch.Checked = true;
                }
                if (hdnID.Value != string.Empty)
                {
                    if (PPatientID == 0)
                    {
                        PPatientID = Convert.ToInt64(hdnID.Value);
                    }
                }

            }
            if (!IsPostBack)
            {
                loadrelation();
                LoadTitle();
                LoadPublishingMode();
                // LoadReferingPhysician();
                LoadNationality(); LoadTPAName();
                string RedirectMethod = GetConfigValue("HasPCCClientMapping", OrgID);

                if (RedirectMethod == "yes")
                {
                    LoadPCClient();
                }
                else
                {
                    LoadInvClientMaster();
                }
                loadRateType();
                LoadClientMaster();
                LoadTPAMaster();
                LoadReferringOrgType();

                URNControl1.LoadURNtype();
                LoadHospitalBranch();
                LoadPriority();
                LoadCollectionCentre();
                LoadPayerType();
                LoadDiscount();
                // Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                returnCode = objKnowledgeOfService_BL.GetKnowledgeOfserviceMasterAndChildByOrgID(OrgID, out lstKnowledgeOfService, out lstKnowledgeOfServiceAttributes);
                if (returnCode == 0)
                {
                    if (lstKnowledgeOfService.Count > 0)
                    {
                        gvKOS.DataSource = lstKnowledgeOfService;
                        gvKOS.DataBind();
                    }
                }
                //if (Request.QueryString["Rid"] != null)
                //{

                //}
                //else
                //{
                //    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "URN", "var URN= 'N';", true);

                //}
                List<Racemaster> Race = new List<Racemaster>();
                new Patient_BL(base.ContextInfo).getRaceDetails(out Race);
                ddRace.DataSource = Race;
                ddRace.DataTextField = "racename";
                ddRace.DataValueField = "racename";
                ddRace.DataBind();
                ddRace.Items.Insert(0, "-----Select-----");
                ddRace.Items[0].Value = "0";

                string CityState = GetConfigValue("CityState", OrgID);
                if (CityState != "")
                {
                    PatientAddress pAddress = new PatientAddress();
                    pAddress.City = CityState;
                    ucPAdd.SetAddress(pAddress);
                }

                if (PPatientID != 0)
                {
                    //Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    List<Patient> patientList = new List<Patient>();
                    URNTypes objURNTypes = new URNTypes();
                    result = patientBL.GetLabPatientDemoandAddress(PPatientID, out patientList);
                    if (patientList.Count > 0)
                    {
                        txtPatientName.Text = patientList[0].Name;
                        ddSalutation.SelectedValue = patientList[0].TITLECode.ToString();
                        ddSex.SelectedValue = patientList[0].SEX.ToString();
                        if (patientList[0].PatientAge != null)
                            txtAge.Text = patientList[0].PatientAge.Split(' ')[0];
                        if (patientList[0].DOB.ToString() != "01/01/1800 00:00:00")
                        {
                            tDOB.Text = patientList[0].DOB.ToString();
                        }
                        if (patientList[0].PatientAge != null)
                            ddlAgeUnit.SelectedValue = patientList[0].PatientAge.Split(' ')[1];
                        objURNTypes.URN = patientList[0].URNO;
                        objURNTypes.URNof = patientList[0].URNofId;
                        objURNTypes.URNTypeId = patientList[0].URNTypeId;
                        URNControl1.StrUrn = patientList[0].URNO;
                        URNControl1.SetURN(objURNTypes);
                        txtEmailID.Text = patientList[0].EMail;
                        ddRace.SelectedValue = patientList[0].Race;
                        //ddlNationality.SelectedItem.Text = patientList[0].Nationality;
                        ddlNationality.SelectedValue = patientList[0].Nationality.ToString();


                        PatientAddress pAddress = new PatientAddress();
                        if (patientList[0].PatientAddress[0].AddressType == "C")
                        {
                            pAddress = patientList[0].PatientAddress[1];
                        }
                        else
                        {
                            pAddress = patientList[0].PatientAddress[0];
                        }
                        ucPAdd.SetAddress(pAddress);
                    }

                }
            }
            //if (Request.QueryString["mode"] != null)
            //{
            //    Int32.TryParse(Request.QueryString["mode"], out mode);
            //    if (mode == 1) Panel7.Visible = false;
            //    ltHead.Text = "Enter the details of new Clinic";
            //}
            //if (!IsPostBack)
            //{
            //    LoadHospital();
            //}
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "URN", "var URN= 'Y';", true);
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "OrgID", "var OrgID= '" + OrgID + "';", true);
            payerTD.Visible = true;
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in SampleRegistration.aspx:Page_Load", ex);
        }
    }
    protected void lnkAddnew_Click(object sender, EventArgs e)
    {
        try
        {
            //returncode = new Investigation_BL(base.ContextInfo).getdept
            LoadTitle();
            txtPassword.Enabled = false;
            LoadHospitalBranch();
            programmaticModalPopup.Show();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lnkAddnew_Click", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int pRefPhyID = -1;
        try
        {
            if (chkUserLogin.Checked == true)
                SaveLoginDetails();
            btnFinish.Visible = false;
            objReferingPhysician.PhysicianName = txtDrName1.Text;
            objReferingPhysician.Qualification = txtDrQualification1.Text;
            objReferingPhysician.OrganizationName = txtDrOrganization1.Text;
            objReferingPhysician.OrgID = OrgID;
            objReferingPhysician.Salutation = Convert.ToInt32(ddSalutation1.SelectedValue);
            List<PhysicianOrgMapping> pomList = new List<PhysicianOrgMapping>();
            List<ReferingPhysician> lst = new List<ReferingPhysician>();
            /*foreach (ListItem item in chklstHsptl.Items)
            {
                PhysicianOrgMapping pom=new PhysicianOrgMapping();

                if (item.Selected)
                {
                    pom.HospitalID=Convert.ToInt32(item.Value);
                    pomList.Add(pom);
                }
            }*/
            pomList = GetReferanceHptls();
            List<AddressDetails> lstRefPhyAddressDetails = new List<AddressDetails>();
            long PhysicianRoleId = 0;
            returnCode = patientBL.SaveReferingPhysician(objReferingPhysician, lstRefPhyAddressDetails, pomList, Convert.ToInt16(LoginID), out pRefPhyID, out lst, out PhysicianRoleId);
            if (returnCode == 0)
            {
                iconHid.Value = "";
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName1.Text = "";
                txtDrOrganization1.Text = "";
                txtDrQualification1.Text = "";
                lblStatus.Visible = true;
                lblStatus.Text = "New Refering Physician Added Successfully!";
                btnFinish.Visible = true;
                Panel7.Visible = true;
                ddSex.SelectedValue = "0";
                ddSalutation.SelectedValue = "0";
                //ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Changes saved successfully.');", true);
                LoadHospitalBranch();
                Session["HidDel"] = "";
                programmaticModalPopup.Show();

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Refering Physician Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public List<PhysicianOrgMapping> GetReferanceHptls()
    {
        List<PhysicianOrgMapping> lstRef = new List<PhysicianOrgMapping>();
        PhysicianOrgMapping Ref;
        string hidValue = iconHid.Value != "" ? iconHid.Value : HdnHospitalID.Value;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('|'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                Ref = new PhysicianOrgMapping();
                Ref.HospitalID = Convert.ToInt32(lineItems[0]);
                lstRef.Add(Ref);
            }
        }
        iconHid.Value = "";
        return lstRef;
    }
    protected void SaveLoginDetails()
    {
        long lresult1 = -1;
        long lresult2 = -1;
        try
        {
            long returncode = -1;
            List<Role> Temprole = new List<Role>();
            returncode = roleBL.GetRoleName(OrgID, out role);
            Temprole = role.FindAll(delegate(Role R) { return R.RoleName == RoleHelper.ReferringPhysician; });

            if (Temprole.Count == 1)
                RoleId = Temprole[0].RoleID.ToString();
            //string LoginName = txtName.Text;
            string LoginName = txtUserName.Text;
            Users_BL LoginCheckdetails = new Users_BL(base.ContextInfo);
            lresult1 = LoginCheckdetails.GetCheckLogindetails(LoginName);

            if (lresult1 == 0)
            {
                HtmlGenericControl dError = (HtmlGenericControl)this.FindControl("DivErrors");
                dError.Style.Value = "Block";
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Login " + txtUserName.Text.ToString() + " Already Exist";

            }
            else
            {
                Users_BL userCheckdetails = new Users_BL(base.ContextInfo);
                LoginID = InsertLogin();
                if (lresult1 != 0)
                {

                    InserLoginRole(Convert.ToInt32(RoleId), LoginID);
                    InsertUsers(LoginID);


                }

                long Returncode = -1;
                string strPass = string.Empty;
                Returncode = LoginCheckdetails.GetLoginUserName(LoginID, out LoginName, out strPass, out TransPass);
                lblLoginName.Text = "<h5>Successfully Created For LoginName: " + LoginName + " & Password :" + strPass + " </h5>";
                txtUserName.Text = "";
                txtPassword.Text = "";
                chkUserLogin.Checked = false;
                //Save.Visible = false;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Save Page", ex);
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
        login.Password = txtPassword.Text;
        login.OrgID = OrgID;
        login.CreatedBy = LID;
        lresult = roleBL.Savesysconfig(login, out LoginID);
        return LoginID;

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
            DateTime wDate = new DateTime();

            User.Name = txtUserName.Text;


            User.SEX = ddSex.SelectedValue;

            User.TitleCode = ddSalutation.SelectedValue;

            User.DOB = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            User.WeddingDt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            User.Qualification = txtDrQualification.Text;
            User.OrgID = OrgID;
            User.CreatedBy = LID;
            User.LoginID = LoginID;
            User.Status = "A";
            //pAddress.Add(GetAddress1());
            User.Address = pAddress;

            lresult = UserBL.SaveUsers(User);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading User Page", ex);
        }
    }
    public UserAddress GetAddress1()
    {
        UserAddress useAddress = new UserAddress();
        //short CountryID;
        //short StateID;
        //if (txtAddressID.Text != "")
        //{
        //    useAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        //}

        useAddress.Add1 = null;
        useAddress.Add2 = null;
        useAddress.Add3 = null;
        useAddress.AddressType = iAddressType.ToString();
        useAddress.City = null;
        //Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        //Int16.TryParse(ddState.SelectedValue, out StateID);
        useAddress.CountryID = 0;
        useAddress.StateID = 0;
        useAddress.PostalCode = null;
        useAddress.MobileNumber = null;
        useAddress.LandLineNumber = null;
        useAddress.CreatedBy = LID;
        useAddress.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        useAddress.StartDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        return useAddress;
    }
    #region Properties
    eAddType iAddressType;
    public enum eAddType
    {
        CURRENT = 1, PERMANENT = 2, ALTERNATE = 3, OFFICE = 4
    }

    public eAddType AddressType
    {
        get
        {
            return iAddressType;
        }
        set
        {
            iAddressType = value;
        }
    }
    #endregion
    protected void btnCancel1_click(object sender, EventArgs e)
    {
        programmaticModalPopup.Hide();

        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Items", "javascript:LoadOrdItems();", true);
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
    private void LoadTitle()
    {
        try
        {
            long returnCode = -1;
            Title_BL titelBL = new Title_BL(base.ContextInfo);
            List<Salutation> titles = new List<Salutation>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            if (Cache["titles"] == null)
            {

                returnCode = titelBL.GetTitle(OrgID, LanguageCode, out titles);
                if (returnCode == 0)
                {
                    Cache.Add("titles", titles, null, Cache.NoAbsoluteExpiration, Cache.NoSlidingExpiration, CacheItemPriority.Normal, null);
                }
            }
            else
            {
                titles = (List<Salutation>)Cache["titles"];
                returnCode = 0;
            }
            returnCode = titelBL.GetTitle(OrgID, LanguageCode, out titles);
            Salutation selectedSalutation = new Salutation();
            int titleID = 0;
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();
                // ddSalutation.Items.RemoveAt(0);//(0, "--Select--"); 
                ddSalutation.Items.Insert(0, "--Select--");
                ddSalutation.Items[0].Value = "0";



                ddSalutation1.DataSource = titles;
                ddSalutation1.DataTextField = "TitleName";
                ddSalutation1.DataValueField = "TitleID";
                ddSalutation1.DataBind();
                ddSalutation1.Items.Insert(0, "--Select--");
                ddSalutation1.Items[0].Value = "0";
                selectedSalutation = titles.Find(Findsalutation);
                //ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
                ddSalutation.SelectedValue = "0";
                Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);

            }
            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading Salutation in Patient Sample Registration.Message:", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void LoadPublishingMode()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PublishingMode> getPublishingMode = new List<PublishingMode>();
            if (Cache["PublishMode"] == null)
            {
                retCode = patBL.GetPublishingMode(out getPublishingMode);
                Cache.Add("PublishMode", getPublishingMode, null, Cache.NoAbsoluteExpiration, new TimeSpan(12, 0, 0), CacheItemPriority.Normal, null);
            }
            else
            {
                //Cache.Remove("PublishMode");
                getPublishingMode = (List<PublishingMode>)Cache["PublishMode"];
            }

            if (getPublishingMode.Count > 0)
            {

                ddPublishingMode.DataSource = getPublishingMode;
                ddPublishingMode.DataTextField = "ModeName";
                ddPublishingMode.DataValueField = "ModeID";
                ddPublishingMode.DataBind();
                ddPublishingMode.Items.Insert(0, "-----Select-----");
                ddPublishingMode.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Publishing Mode Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode == 0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Priority Master Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void LoadInvClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            retCode = patBL.GetInvClientMaster(OrgID, "D", out getInvClientMaster);

            //ddlClients.DataSource = getInvClientMaster;
            //ddlClients.DataTextField = "ClientName";
            //ddlClients.DataValueField = "ClientID";
            //ddlClients.DataBind();
            //ddlClients.Items.Insert(0, "-----Select-----");
            //ddlClients.Items[0].Value = "0";
            //ddlClients.SelectedValue = "1";


            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            retCode = investigationBL.GetInvestigationByClientID(OrgID, 0, "INS", out lstInvestigation);
            if (retCode == 0)
            {


                ddlPkg.DataSource = lstInvestigation;
                ddlPkg.DataTextField = "GroupNameRate";
                ddlPkg.DataValueField = "GroupID";
                ddlPkg.DataBind();
                ddlPkg.Items.Insert(0, "-----Select-----");
                ddlPkg.Items[0].Value = "0";
            }
            if (lstInvestigation.Count == 0)
            {
                rdPackage.Style.Add("display", "none");
                lblPackage.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvClientMaster Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    void ddlPkg_DataBinding(object sender, EventArgs e)
    {

    }
    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Clinic = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Lab = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, out RefOrg);
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            Clinic = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 2; });
            Lab = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 3; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgNameWithAddress";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";

                ddlClinic.DataSource = Clinic;
                ddlClinic.DataTextField = "RefOrgNameWithAddress";
                ddlClinic.DataValueField = "LabRefOrgID";
                ddlClinic.DataBind();
                ddlClinic.Items.Insert(0, "-----Select-----");
                ddlClinic.Items[0].Value = "0";

                ddlLab.DataSource = Lab;
                ddlLab.DataTextField = "RefOrgNameWithAddress";
                ddlLab.DataValueField = "LabRefOrgID";
                ddlLab.DataBind();
                ddlLab.Items.Insert(0, "-----Select-----");
                ddlLab.Items[0].Value = "0";

                chklstHsptl.DataSource = Hospital;
                chklstHsptl.DataTextField = "RefOrgNameWithAddress";
                chklstHsptl.DataValueField = "LabRefOrgID";
                chklstHsptl.DataBind();
                if (Clinic.Count == 0)
                {
                    rdoBranch.Style.Add("display", "none");
                }
                foreach (ListItem lit in ddlHospital.Items)
                {
                    lit.Attributes.Add("Title", lit.Text);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
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
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        long returnCode = -1;
        long pVisitID = -1;
        long pPatientID = -1;
        int pClientID = -1;//Actully it is RateID
        int pRefPhyID = -1;
        int PayerTypeID = -1;
        string payerName = string.Empty;
        try
        {
            DateTime DOB = new DateTime();
            PatientVisit pVisit = new PatientVisit();
            PatientVisit PVisit = new PatientVisit();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            pPriorityID = Convert.ToInt32(ddlPriority.SelectedValue);
            pPriorityName = ddlPriority.SelectedItem.Text;
            PVisit.PriorityID = pPriorityID;
            //PVisit.PriorityID = 0;
            if (ddlCollectionCentre.SelectedValue != "0")
            {
                pCollectionCentreID = Convert.ToInt32(ddlCollectionCentre.SelectedValue);
            }
            string physicianName = string.Empty;
            physicianName = txtPhysician.Text;
            if (txtPhysician.Text != string.Empty && chkPhyOthers.Checked != true)
            {
                //PVisit.ReferingPhysicianID = Convert.ToInt32(physicianName.Split('~')[1]);
                PVisit.ReferingPhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
                //PVisit.ReferingPhysicianName = physicianName.Split('~')[0];
                PVisit.ReferingPhysicianName = txtPhysician.Text;
            }
            else if (txtPhysician.Text != string.Empty)
            {
                ReferingPhysician refPhy = new ReferingPhysician();
                refPhy.OrgID = OrgID;
                refPhy.PhysicianName = txtDrName.Text;
                refPhy.Qualification = txtDrQualification.Text;
                refPhy.OrganizationName = txtDrOrganization.Text;
                patientBL.SaveReferingPhysician(refPhy, out pRefPhyID);
                PVisit.ReferingPhysicianID = pRefPhyID;
                PVisit.ReferingPhysicianName = txtDrName.Text;
            }
            else
            {
                PVisit.ReferingPhysicianID = 0;
                PVisit.ReferingPhysicianName = txtDrName.Text;
            }
            if (ddlPatientCategory.SelectedValue == "1")
            {
                PVisit.WardNo = txtward.Text;
                PVisit.VisitType = Convert.ToInt32(ddlPatientCategory.SelectedValue);
            }
            else if (ddlPatientCategory.SelectedValue == "0")
            {
                PVisit.VisitType = Convert.ToInt32(ddlPatientCategory.SelectedValue);
            }
            ////Setting Hospital and Branch
            if (ddlCollectionCentre.SelectedValue != "0")
            {
                PVisit.CollectionCentreID = Convert.ToInt32(ddlCollectionCentre.SelectedValue);
                PVisit.CollectionCentreName = ddlCollectionCentre.SelectedItem.Text;
            }
            //if (rdoHospital.Checked)
            //{
            //    PVisit.HospitalID = Convert.ToInt32(ddlHospital.SelectedValue);
            //    PVisit.HospitalName = ddlHospital.SelectedItem.Text;
            //}
            //if (rdoBranch.Checked)
            //{
            //    PVisit.HospitalID = Convert.ToInt32(ddlClinic.SelectedValue);
            //    PVisit.HospitalName = ddlClinic.SelectedItem.Text;
            //}
            //if (rdoRLab.Checked)
            //{
            //    PVisit.HospitalID = Convert.ToInt32(ddlLab.SelectedValue);
            //    PVisit.HospitalName = ddlLab.SelectedItem.Text;
            //}

            if (rdPackage.Checked)
            {
                if (ddlPkg.SelectedItem.Text.Contains("-" + CurrencyName + ":"))
                {
                    int rIndex = ddlPkg.SelectedItem.Text.IndexOf("-" + CurrencyName + ":");
                    PVisit.ClientName = ddlPkg.SelectedItem.Text.Substring(0, rIndex);
                }
                PVisit.ClientMappingDetailsID = Convert.ToInt32(ddlPkg.SelectedValue);
                pClientID = Convert.ToInt32(ddlPkg.SelectedValue);
            }
            else if (rdClient.Checked)
            {

                //PVisit.ClientID = Convert.ToInt32(ddlClients.SelectedValue);
                //PVisit.ClientName = ddlClients.SelectedItem.Text;
                //pClientID = Convert.ToInt32(ddlClients.SelectedValue);
            }


            Patient patient = new Patient();
            PatientAddress pAddress = new PatientAddress();
            patient.Name = txtPatientName.Text;
            patient.PreviousKnownName = txtpreviousname.Text;
            patient.RelationName = txtRelationname.Text;
            patient.AliasName = TxtAliasname.Text;
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.SEX = ddSex.SelectedValue;
            patient.RelationTypeId = int.Parse(DrpRelationtype.SelectedValue);
            if (tDOB.Text.Trim().Length > 0)
            {
                if (!DateTime.TryParse(tDOB.Text.Trim(), out DOB))
                    DOB = new DateTime(1800, 1, 1);
            }
            else
            {
                // Min. default date.DateTime cannot be null and cannot be less that 1701
                DOB = new DateTime(1800, 1, 1);
            }
            patient.DOB = DOB;
            if (txtAge.Text != string.Empty)
            {
                patient.Age = txtAge.Text + " " + ddlAgeUnit.SelectedItem.Text;
                pAge = Convert.ToInt32(txtAge.Text);
            }



            patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);

            pAddress = ucPAdd.GetAddress();
            pAddress.AddressType = "P";
            URNTypes objURNTypes = URNControl1.GetURN();
            patient.URNO = objURNTypes.URN;
            patient.URNofId = objURNTypes.URNof;
            patient.URNTypeId = objURNTypes.URNTypeId;
            if (ddRace.SelectedValue != "0")
            {
                patient.Race = ddRace.SelectedValue;
            }
            if (ddlPayerType.SelectedValue != "0" && ddlPayerType.SelectedValue != "")
            {
                PayerTypeID = Convert.ToInt32(ddlPayerType.SelectedItem.Value);
                payerName = ddlPayerType.SelectedItem.Text;
            }
            //patient.Nationality = ddlNationality.SelectedItem.Text;;
            patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);




            patient.TypeName = "";
            if (hdnClientTypeID.Value == "1" || hdnClientTypeID.Value == "2" || hdnClientTypeID.Value == "3")
            {
                PVisit.HospitalID = Convert.ToInt32(hdnLabRefOrgID.Value);
                PVisit.HospitalName = hdnRefOrgName.Value;
            }

            //if (hdnClientTypeID.Value == "4")
            //{
            //    PVisit.TPAID = Convert.ToInt64(hdnLabRefOrgID.Value);
            //    PVisit.TPAName = hdnRefOrgName.Value;
            //    patient.TypeName = "TPA";
            //}
            //else
            //{
            //    PVisit.TPAID = 0;
            //    PVisit.TPAName = "";
            //}
            if (hdnClientTypeID.Value == "5")
            {

                PVisit.ClientMappingDetailsID = Convert.ToInt32(hdnLabRefOrgID.Value);
                PVisit.ClientName = hdnRefOrgName.Value;
                patient.TypeName = "COP";
            }
            else
            {
                PVisit.ClientMappingDetailsID = 0;
                PVisit.ClientName = "";
            }


            //pClientID = Convert.ToInt32(ddlRateType.SelectedValue);
            //PVisit.RateID = Convert.ToInt32(ddlRateType.SelectedValue);

            //if (hdnTPAClientAtttrbuteValue.Value != "")
            //{
            //    patient.TPAAttributes = hdnTPAClientAtttrbuteValue.Value;
            //}
            //else
            //{
            //    patient.TPAAttributes = "";
            //}
            if (PPatientID == 0)
            {

                returnCode = patientBL.SaveSampleRegistrationDetails(patient, pAddress, PVisit, out pVisitID, ILocationID, out pPatientID, pAge,
                    ddlAgeUnit.SelectedValue, PayerTypeID, payerName, lst);
            }

            else if (PPatientID > 0)
            {
                if (Request.QueryString["Rid"] != null)
                {
                    long Rid = 0;
                    string pIspatient = Request.QueryString["IsPan"];
                    Int64.TryParse(Request.QueryString["Rid"], out Rid);
                    patient.PatientID = PPatientID;
                    returnCode = patientBL.UpdateLabPatientDetails(patient, pAddress);
                    if (pIspatient == "N")
                    {
                        patient.PatientID = 0;
                        returnCode = patientBL.SaveSampleRegistrationDetails(patient, pAddress, PVisit, out pVisitID, ILocationID, out pPatientID, pAge,
                            ddlAgeUnit.SelectedValue, PayerTypeID, payerName, lst);
                        objReferrals_BL.UpdateReferralStatus(Rid, "In", 1, LID);
                    }
                    else
                    {
                        PVisit.PatientID = PPatientID;
                        pPatientID = PPatientID;
                        PVisit.OrgID = OrgID;
                        PVisit.OrgAddressID = ILocationID;
                        returnCode = patientBL.SaveLabVisitDetails(PVisit, out pVisitID);
                        objReferrals_BL.UpdateReferralStatus(Rid, "In", 1, LID);
                    }
                }
                else
                {
                    PVisit.PatientID = PPatientID;
                    pPatientID = PPatientID;
                    PVisit.OrgID = OrgID;
                    PVisit.OrgAddressID = ILocationID;
                    returnCode = patientBL.SaveLabVisitDetails(PVisit, out pVisitID);

                    if (Request.QueryString["HCDID"] != null)
                    {
                        long HCID = Convert.ToInt64(Request.QueryString["HCDID"]);
                        if (pVisitID > 0)
                        {
                            string status = string.Empty;
                            status = "Completed";
                            new Investigation_BL(base.ContextInfo).UpdateHomeCollectiondetails(HCID, pVisitID, status,-1);
                        }
                    }
                }
            }

            if (returnCode == 0)
            {
                foreach (GridViewRow rows in gvKOS.Rows)
                {
                    VisitKnowledgeMapping objVisitKnowledgeMapping = new VisitKnowledgeMapping();
                    CheckBox chk = (CheckBox)rows.FindControl("chk");
                    DropDownList ddlAttributes = (DropDownList)rows.FindControl("ddlAttributes");
                    Label lblKOS = (Label)rows.FindControl("lblKOS");
                    Label lblKOSID = (Label)rows.FindControl("lblKOSID");
                    TextBox txtOthers = (TextBox)rows.FindControl("txtOthers");

                    if (chk.Checked == true && lblKOS.Text == "Others")
                    {
                        objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                        if (txtOthers.Text != string.Empty)
                        {
                            objVisitKnowledgeMapping.Description = txtOthers.Text;
                        }
                        else
                        {
                            objVisitKnowledgeMapping.Description = lblKOS.Text;
                        }

                    }

                    if (chk.Checked == true && lblKOS.Text != "Others")
                    {
                        if (ddlAttributes.SelectedItem.Text != "Other")
                        {
                            objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                            objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                        }
                        else
                        {
                            objVisitKnowledgeMapping.KnowledgeOfServiceID = Convert.ToInt16(lblKOSID.Text);
                            objVisitKnowledgeMapping.AttributeID = Convert.ToInt64(ddlAttributes.SelectedValue);
                            if (txtOthers.Text != string.Empty)
                            {
                                objVisitKnowledgeMapping.Description = txtOthers.Text;
                            }
                            else
                            {
                                objVisitKnowledgeMapping.Description = ddlAttributes.SelectedItem.Text;
                            }
                        }

                    }

                    lstVisitKnowledgeMapping.Add(objVisitKnowledgeMapping);

                }

                if (lstVisitKnowledgeMapping.Count > 0)
                {
                    returnCode = patientBL.SaveKnowledgeOfServices(pVisitID, OrgID, LID, lstVisitKnowledgeMapping);
                }


                ResultPublishing resultPub = new ResultPublishing();
                PatientAddress sadd = shippingAddress.GetAddress();
                resultPub.PatientVisitID = pVisitID;
                resultPub.OrgID = OrgID;
                resultPub.CreatedBy = LID;
                if (txtEmailID.Text != string.Empty)
                {
                    resultPub.Value = txtEmailID.Text;
                    returnCode = patientBL.SaveSamplePublishingDetails(resultPub, sadd);
                }
                if (ddPublishingMode.SelectedValue != "0")
                {
                    resultPub.Value = txtName.Text;
                    resultPub.ModeID = Convert.ToInt32(ddPublishingMode.SelectedValue);
                    returnCode = patientBL.SaveSamplePublishingDetails(resultPub, sadd);
                }
                if (returnCode != 0)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Error while saving Sample Registration Details. Please try after some time.";
                }
                hdnPatientID.Value = Convert.ToString(pPatientID);
                hdnVisitID.Value = Convert.ToString(pVisitID);
                string BillNo = string.Empty;
                BillNo = SaveInvestigationAndBill();
                Response.Redirect("ViewBill.aspx?billNo=" + BillNo + "&ccid=" + pCollectionCentreID, true);

                //string sPage = "../Reception/PrintBill.aspx?billNo=" + BillNo;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:openPOPupQuick('" + sPage + "');", true);

                //Response.Redirect("CompleteLabPatientRegistration.aspx", true); 

                //if (rdPackage.Checked)
                //{
                //    Response.Redirect("SampleBillPrint.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&INS=1&ccid=" + pCollectionCentreID, true);
                //    //Response.Redirect("Billgeneration.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&INS=1", true);
                //}
                //else
                //{
                //    if (Request.QueryString["Rid"] != null)
                //    {
                //        string Rid = Request.QueryString["Rid"];
                //        Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&ccid=" + pCollectionCentreID + "&Rid=" + Rid, true);
                //    }
                //    else
                //    {
                //        Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID + "&ccid=" + pCollectionCentreID + "&PayID=" + PayerTypeID, true);

                //    }

                //    //Response.Redirect("Billgeneration.aspx?vid=" + pVisitID + "&pid=" + pPatientID + "&cid=" + pClientID, true);
                //}
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while saving Sample Registration Details. Please try after some time.";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Sample Registration Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        //Response.Redirect("PatientSampleRegistration.aspx", true);
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {

        LabRefOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
        GetLabRefOrgAddress(LabRefOrgID);
        //rdClient.Focus();
        //LoadPCPayer();
        ddlPayerType.Focus();
        //LoadPCClient();
        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "demo", "javascript:setFocusToPayer();", true);
    }
    protected void ddlClinic_SelectedIndexChanged(object sender, EventArgs e)
    {
        LabRefOrgID = Convert.ToInt64(ddlClinic.SelectedValue);
        GetLabRefOrgAddress(LabRefOrgID);
        // LoadPCPayer();
        ddlPayerType.Focus();
        //LoadPCClient();
        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "demo", "javascript:setFocusToPayer();", true);
    }
    protected void ddlLab_SelectedIndexChanged(object sender, EventArgs e)
    {
        LabRefOrgID = Convert.ToInt64(ddlClinic.SelectedValue);
        GetLabRefOrgAddress(LabRefOrgID);
        // LoadPCPayer();
        ddlPayerType.Focus();
        //LoadPCClient();
        //ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "demo", "javascript:setFocusToPayer();", true);
    }
    protected void ddlPayerType_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (ddlPayerType.SelectedValue == "3")
        {

            // ddlTPAMaster.Focus();
            ddlTPAnew.Focus();
        }
        else
        {

            //ddlClients.Focus();
            LoadPCClient();
            ddlRateType.Focus();
        }
    }
    protected void ddlTPA_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadPCClient();
        // ddlRateType.Focus();
        tdclient.Style.Add("display", "none");
        tdTPA.Style.Add("display", "block");
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Items", "javascript:PopUpAttributePage();", true);


    }
    protected void ddlClient_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadPCClient();
        ddlRateType.Focus();
        tdclient.Style.Add("display", "block");
        tdTPA.Style.Add("display", "none");
    }
    public void LoadPCPayer()
    {
        int refPhyID = -1;
        long refOrgID = -1;

        try
        {
            if (txtPhysician.Text != string.Empty && chkPhyOthers.Checked != true)
            {
                //refPhyID = Convert.ToInt32(txtPhysician.Text.Split('~')[1]);
                refPhyID = Convert.ToInt32(hdnPhysicianID.Value);
                refOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
            }
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PayerMaster> getPCPayer = new List<PayerMaster>();
            retCode = patBL.GetPCPayer(OrgID, refOrgID, refPhyID, out getPCPayer);
            if (retCode == 0)
            {
                ddlPayerType.DataSource = getPCPayer;
                ddlPayerType.DataTextField = "PayerName";
                ddlPayerType.DataValueField = "PayerID";
                ddlPayerType.DataBind();
                ddlPayerType.Items.Insert(0, "-----Select-----");
                ddlPayerType.Items[0].Value = "0";
                //if (getPCPayer.Count > 1)
                //{
                //    ddlPayerType.Items.Insert(0, "-----Select-----");
                //    ddlPayerType.Items[0].Value = "0";
                //}
                payerDiv.Style.Add("display", "block");
                payerTitleTD.Style.Add("display", "block");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PCPayer.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void loadRateType()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
            if (lstRateMaster.Count > 0)
            {
                ddlRateType.DataSource = lstRateMaster;
                ddlRateType.DataTextField = "RateName";
                ddlRateType.DataValueField = "RateId";
                ddlRateType.DataBind();
                ddlRateType.Items.Insert(0, "---Select---");
            }
            else
            {
                ddlRateType.DataSource = null;
                ddlRateType.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
    public void LoadClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            retCode = patBL.GetInvClientMaster(OrgID, "D", out getInvClientMaster);

            ddlClientnew.DataSource = getInvClientMaster;
            ddlClientnew.DataTextField = "ClientName";
            ddlClientnew.DataValueField = "ClientID";
            ddlClientnew.DataBind();
            ddlClientnew.Items.Insert(0, "-----Select-----");
            ddlClientnew.Items[0].Value = "0";
            ddlClientnew.SelectedValue = "1";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvClientMaster Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void loadrelation()
    {
        long returncode = -1;
        List<RelationshipMaster> lstrelation = new List<RelationshipMaster>();
        try
        {
            returncode = new Patient_BL(base.ContextInfo).GetRelationship(out lstrelation);
            if (lstrelation.Count > 0)
            {
                DrpRelationtype.DataSource = lstrelation;
                DrpRelationtype.DataTextField = "RelationshipName";
                DrpRelationtype.DataValueField = "RelationshipID";
                DrpRelationtype.DataBind();
                DrpRelationtype.Items.Insert(0, "-----Select-----");
                DrpRelationtype.Items[0].Value = "0";
            }


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadRelationtype", ex);
        }


    }
    public void LoadTPAMaster()
    {
        long returnCode = -1;
        List<TPAMaster> lstTPAMaster = new List<TPAMaster>();
        try
        {
            returnCode = new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lstTPAMaster);
            if (lstTPAMaster.Count > 0)
            {
                ddlTPAnew.DataSource = lstTPAMaster;
                ddlTPAnew.DataTextField = "TPAName";
                ddlTPAnew.DataValueField = "TPAID";
                ddlTPAnew.DataBind();
                ddlTPAnew.Items.Insert(0, "-----Select-----");
                ddlTPAnew.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTPAName", ex);
        }
    }
    public void LoadPCClient()
    {
        int refPhyID = -1;
        long refOrgID = -1;
        int payerID = -1;
        long TpaOrClientID = 0;
        string Type = string.Empty;

        try
        {
            if (txtPhysician.Text != string.Empty && chkPhyOthers.Checked != true)
            {
                refPhyID = Convert.ToInt32(hdnPhysicianID.Value);
                refOrgID = Convert.ToInt64(ddlHospital.SelectedValue);
                payerID = Convert.ToInt32(ddlPayerType.SelectedValue);
            }
            if (ddlPayerType.SelectedValue == "3")
            {
                if (rdoTpa.Checked == true)
                {
                    TpaOrClientID = Convert.ToInt64(ddlTPAnew.SelectedValue);
                    Type = "TPA";
                }
                if (rdoClient.Checked == true)
                {
                    TpaOrClientID = Convert.ToInt64(ddlClientnew.SelectedValue);
                    Type = "Client";
                }
            }
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> getPCClient = new List<InvClientMaster>();
            retCode = patBL.GetPCClient(OrgID, refOrgID, refPhyID, payerID, TpaOrClientID, Type, out getPCClient);
            if (retCode == 0)
            {

                //ddlClients.DataSource = getPCClient;
                //ddlClients.DataTextField = "ClientName";
                //ddlClients.DataValueField = "ClientID";
                //ddlClients.DataBind();
                //ddlClients.SelectedValue = "1";

                ddlRateType.DataSource = getPCClient;
                ddlRateType.DataTextField = "RateName";
                ddlRateType.DataValueField = "RateId";
                ddlRateType.DataBind();
                ddlRateType.SelectedValue = "1";
            }
            if (getPCClient.Count > 1)
            {
                //ddlClients.Items.Insert(0, "-----Select-----");
                //ddlClients.Items[0].Value = "0";

                ddlRateType.Items.Insert(0, "-----Select-----");
                ddlRateType.Items[0].Value = "0";
            }


            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<PatientInvestigation> lstInvestigation = new List<PatientInvestigation>();
            retCode = investigationBL.GetInvestigationByClientID(OrgID, 0, "INS", out lstInvestigation);

            if (retCode == 0)
            {


                ddlPkg.DataSource = lstInvestigation;
                ddlPkg.DataTextField = "GroupNameRate";
                ddlPkg.DataValueField = "GroupID";
                ddlPkg.DataBind();
                ddlPkg.Items.Insert(0, "-----Select-----");
                ddlPkg.Items[0].Value = "0";
            }
            if (lstInvestigation.Count == 0)
            {
                rdPackage.Style.Add("display", "none");
                lblPackage.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PCClient.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void GetLabRefOrgAddress(long LabRefOrgID)
    {
        try
        {
            //txtHospitalAddress.Text = string.Empty;
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabRefOrgAddress> getLabRefOrgAddress = new List<LabRefOrgAddress>();
            retCode = patBL.GetLabRefOrgAddress(LabRefOrgID, out getLabRefOrgAddress);
            if (retCode == 0)
            {
                foreach (LabRefOrgAddress labOrgAddress in getLabRefOrgAddress)
                {
                    txtHospitalAddress.Text = GetAddressFormat(labOrgAddress);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public string GetAddressFormat(LabRefOrgAddress labOrgAddress)
    {
        string address = string.Empty;
        StringBuilder addressSB = new StringBuilder("");

        if (labOrgAddress.Add1 != string.Empty && labOrgAddress.Add1 != null)
        {
            addressSB.Append(labOrgAddress.Add1 + ",\n");
        }
        if (labOrgAddress.Add2 != string.Empty && labOrgAddress.Add2 != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.Add2);
            }
            else
            {
                addressSB.Append(labOrgAddress.Add2 + ",\n");
            }
        }

        //addressSB.Append("\n");

        if (labOrgAddress.Add3 != string.Empty && labOrgAddress.Add3 != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.Add3);
            }
            else
            {
                addressSB.Append(labOrgAddress.Add3 + ",\n");
            }
        }
        if (labOrgAddress.City != string.Empty && labOrgAddress.City != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.City);
            }
            else
            {
                addressSB.Append(labOrgAddress.City);
                if (labOrgAddress.PostalCode != string.Empty && labOrgAddress.PostalCode != null)
                {
                    addressSB.Append("-" + labOrgAddress.PostalCode + ".\n");
                }
            }
        }
        //addressSB.Append("\n");
        if (labOrgAddress.MobileNumber != string.Empty && labOrgAddress.MobileNumber != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.MobileNumber);
            }
            else
            {
                addressSB.Append(labOrgAddress.MobileNumber + "\n");
            }
        }
        if (labOrgAddress.LandLineNumber != string.Empty && labOrgAddress.LandLineNumber != null)
        {
            if (addressSB.Length == 0)
            {
                addressSB.Append(labOrgAddress.LandLineNumber);
            }
            else
            {
                addressSB.Append(labOrgAddress.LandLineNumber + "\n");
            }
        }
        //addressSB.Append("\n");
        //if (labOrgAddress.PostalCode != string.Empty)
        //{
        //   addressSB.Append(labOrgAddress.PostalCode+".");
        //}
        address = addressSB.ToString();
        return address;
    }
    protected void lnkNewClinic_Click(object sender, EventArgs e)
    {
        // LoadHospital();
        //Response.Redirect("SaveLabRefOrgDetails.aspx", true);
        mpeNewClinic.Show();
    }
    protected void lnkChangeAddress_Click(object sender, EventArgs e)
    {
        int id = -1;
        if (rdoHospital.Checked)
        {
            id = Convert.ToInt32(ddlHospital.SelectedValue);
        }
        if (rdoBranch.Checked)
        {
            id = Convert.ToInt32(ddlClinic.SelectedValue);
        }
        Response.Redirect("SaveLabRefOrgDetails.aspx?id=" + id, true);
    }
    public void LoadCollectionCentre()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<CollectionCentreMaster> getCollectionCentre = new List<CollectionCentreMaster>();
            retCode = patBL.GetCollectionCentre(OrgID, out getCollectionCentre);
            if (retCode == 0)
            {
                ddlCollectionCentre.DataSource = getCollectionCentre;
                ddlCollectionCentre.DataTextField = "CollectionCentreName";
                ddlCollectionCentre.DataValueField = "CollectionCentreID";
                ddlCollectionCentre.DataBind();
                ddlCollectionCentre.Items.Insert(0, "-----Select-----");
                ddlCollectionCentre.Items[0].Value = "0";
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Collection Centre Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }
    public void LoadPayerType()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PayerMaster> getPayerType = new List<PayerMaster>();
            retCode = patBL.GetPayerType(OrgID, out getPayerType);
            if (retCode == 0)
            {
                ddlPayerType.DataSource = getPayerType;
                ddlPayerType.DataTextField = "PayerName";
                ddlPayerType.DataValueField = "PayerID";
                ddlPayerType.DataBind();
                ddlPayerType.Items.Insert(0, "-----Select-----");
                ddlPayerType.Items[0].Value = "0";
                // ddlPayerType.SelectedValue = "1";
            }
            if (getPayerType.Count > 0)
            {
                payerTD.Visible = true;
                payerDiv.Style.Add("display", "block");
                payerTitleTD.Style.Add("display", "block");
            }
            else
            {
                payerTD.Visible = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Payer Type Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void gvKOS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlAttributes = (DropDownList)e.Row.FindControl("ddlAttributes");
            Label lblKOS = (Label)e.Row.FindControl("lblKOS");
            Label lblKOSID = (Label)e.Row.FindControl("lblKOSID");
            TextBox txtOthers = (TextBox)e.Row.FindControl("txtOthers");



            int i = 0;
            foreach (KnowledgeOfServiceAttributes objChild in lstKnowledgeOfServiceAttributes)
            {

                if (lblKOS.Text != "Others" && lblKOSID.Text == objChild.KnowledgeOfServiceID.ToString())
                {
                    ddlAttributes.Items.Insert(i, objChild.AttributeName);
                    ddlAttributes.Items[i].Value = objChild.AttributeID.ToString();
                    i++;
                }
            }

            if (lblKOS.Text == "Others")
            {
                ddlAttributes.Visible = false;
                txtOthers.Style.Add("display", "block");
            }

            else
            {

                txtOthers.Style.Add("display", "none");
            }



        }
    }
    public void LoadNationality()
    {
        try
        {
            long returnCode = -1;
            List<Country> lstNationality = new List<Country>();
            Country selectednationality = new Country();
            returnCode = new Country_BL(base.ContextInfo).GetNationalityList(out lstNationality);
            if (returnCode == 0)
            {
                ddlNationality.DataSource = lstNationality;
                ddlNationality.DataTextField = "Nationality";
                ddlNationality.DataValueField = "NationalityID";
                ddlNationality.DataBind();
                selectednationality = lstNationality.Find(FindNationality);
                ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
            }
            else
            {
                CLogger.LogInfo("LoadNationality(): Some problem in fetching the list of Nationalities");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    static bool FindNationality(Country c)
    {
        //if (c.Nationality.ToUpper() == "Singaporean")
        //{
        //    return true;
        //}
        if (c.IsDefault != null && c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }
    public void LoadTPAName()
    {
        long returnCode = -1;
        List<TPAMaster> lstTPAMaster = new List<TPAMaster>();
        try
        {
            returnCode = new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lstTPAMaster);
            if (lstTPAMaster.Count > 0)
            {

                //ddlTPAMaster.DataSource = lstTPAMaster;
                //ddlTPAMaster.DataTextField = "TPAName";
                //ddlTPAMaster.DataValueField = "TPAID";
                //ddlTPAMaster.DataBind();
                //ddlTPAMaster.Items.Insert(0, "-----Select-----");
                //ddlTPAMaster.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTPAName", ex);
        }
    }
    protected void btnClinicSave_Click(object sender, EventArgs e)
    { //venkat
        long returnCode = -1;

        try
        {

            //if (ddlNewClinic.SelectedValue != "0")
            //{
            //    pLabRefOrgID = Convert.ToInt64(ddlNewClinic.SelectedValue);
            //}
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            LabReferenceOrg LabRefOrg = new LabReferenceOrg();
            LabRefOrgAddress LabRefOrgAddress = new LabRefOrgAddress();
            LabRefOrg.RefOrgName = txtNewClinicName.Text;
            LabRefOrg.OrgID = OrgID;
            //LabRefOrg.ClientTypeID = Convert.ToInt16(hdnRefOrgType.Value);
            LabRefOrg.ClientTypeID = Convert.ToInt16(ddlReferringOrgType.SelectedValue);
            LabRefOrgAddress = GetLabRefOrgAddress();
            if (pLabRefOrgID == -1)
            {
                LabRefOrgAddress.CreatedBy = LID;
                returnCode = patientBL.SaveLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
                lblClinic.Text = "New Reference Organization Added Successfully!";
                mpeNewClinic.Show();
                LoadHospitalBranch();
            }
            else
            {
                LabRefOrg.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.ModifiedBy = LID;
                returnCode = patientBL.UpdateLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
                lblClinic.Text = "Reference Organization Changes Saved Successfully!";
                btnDelete.Visible = false;
                mpeNewClinic.Show();
                LoadHospitalBranch();
            }

            if (returnCode != 0)
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while saving Lab Reference Organization Detail and Address. Please try after some time.";
            }
            if (returnCode == 0)
            {
                //LoadHospital();
                //ddlNewClinic.SelectedIndex = 0;
                txtNewClinicName.Text = "";
                clearAddress();
                lblClinic.Visible = true;
                ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
                //if (mode == 1) 
                //Panel9.Visible = true;

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Lab Reference Organization Detail and Address.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public void clearAddress()
    {
        LoadCountry();
        txtAddressID.Text = "";
        txtAddress1.Text = "";
        txtAddress2.Text = "";
        txtAddress3.Text = "";
        txtCity.Text = "";
        txtPostalCode.Text = "";
        txtMobile.Text = "";
        txtLandLine.Text = "";
        txtAltLandLine.Text = "";
        txtFax.Text = "";
        txtRefOrgMobile.Text = "";
    }
    //public void LoadHospital()
    //{
    //    try
    //    {
    //        long retCode = -1;
    //        Patient_BL patBL = new Patient_BL(base.ContextInfo);
    //        List<LabReferenceOrg> getHospital = new List<LabReferenceOrg>();
    //        retCode = patBL.GetLabRefOrg(OrgID, 1, "D", out getHospital);
    //        if (retCode == 0)
    //        {
    //            ddlNewClinic.DataSource = getHospital;
    //            ddlNewClinic.DataTextField = "RefOrgName";
    //            ddlNewClinic.DataValueField = "LabRefOrgID";
    //            ddlNewClinic.DataBind();
    //            ddlNewClinic.Items.Insert(0, "-----Select-----");
    //            ddlNewClinic.Items[0].Value = "0";
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Hospital Details.", ex);
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
    //    }
    //}
    public LabRefOrgAddress GetLabRefOrgAddress()
    {
        //LoadCountry();    
        LabRefOrgAddress objAddress = new LabRefOrgAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = Convert.ToString(eAddType.PERMANENT);
        objAddress.City = txtCity.Text;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        objAddress.CountryID = CountryID;
        objAddress.StateID = StateID;
        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtRefOrgMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.AltLandLineNumber = txtAltLandLine.Text;
        objAddress.Fax = txtFax.Text;

        return objAddress;

    }
    //protected void addNewHospital_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("SaveLabRefOrgDetails.aspx?mode=1", true);
    //}
    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        int countryID = 0;
        try
        {
            returnCode = countryBL.GetCountryList(out countries);
            ddCountry.DataSource = countries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            selectedCountry = countries.Find(FindCountry);
            ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    static bool FindCountry(Country c)
    {
        if (c.CountryName.ToUpper() == "SINGAPORE")
        {
            return true;
        }
        return false;
    }
    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);
            //Commanded By Shajahan:

            //ddState.DataSource = states;
            //ddState.DataTextField = "StateName";
            //ddState.DataValueField = "StateID";
            //ddState.DataBind();
            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName.ToUpper(), st.StateID.ToString()));
            }

            selectedState = states.Find(FindState);
            ddState.SelectedValue = selectedState.StateID.ToString();
            Int32.TryParse(ddState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    static bool FindState(State s)
    {
        if (s.StateName.ToUpper().Trim() == "SINGAPORE")
        {
            return true;
        }
        return false;
    }
    protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddCountry.SelectedIndex > 0)
        //{

        LoadState(Convert.ToInt32(ddCountry.SelectedValue));
        ViewState["Country"] = ddCountry.SelectedItem.Value.ToString();

        //}
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {

            //if (ddlNewClinic.SelectedValue != "0")
            //{
            //    pLabRefOrgID = Convert.ToInt64(ddlNewClinic.SelectedValue);
            //}
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            LabReferenceOrg LabRefOrg = new LabReferenceOrg();
            LabRefOrgAddress LabRefOrgAddress = new LabRefOrgAddress();
            LabRefOrg.RefOrgName = txtNewClinicName.Text;
            LabRefOrg.OrgID = OrgID;
            LabRefOrg.ClientTypeID = Convert.ToInt16(hdnRefOrgType.Value);
            //LabRefOrgAddress = RefOrgAddressCtrl.GetLabRefOrgAddress();
            if (pLabRefOrgID == -1)
            {
                LabRefOrgAddress.CreatedBy = LID;
                returnCode = patientBL.SaveLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
            }
            else
            {
                LabRefOrg.LabRefOrgID = pLabRefOrgID;
                LabRefOrg.Status = "D";
                LabRefOrgAddress.LabRefOrgID = pLabRefOrgID;
                LabRefOrgAddress.ModifiedBy = LID;
                returnCode = patientBL.UpdateLabRefOrgDetailandAddress(LabRefOrg, LabRefOrgAddress);
            }

            if (returnCode != 0)
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Error while Updating Lab Reference Organization Detail and Address. Please try after some time.";
            }
            if (returnCode == 0)
            {
                //LoadHospital();
                //ddlNewClinic.SelectedIndex = 0;
                txtNewClinicName.Text = "";
                //RefOrgAddressCtrl.clearAddress();
                lblStatus.Visible = true;
                ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
                if (mode == 1) Panel7.Visible = true;
                lblClinic.Text = "Reference Organization Removed Successfully!";
                btnDelete.Visible = false;
                mpeNewClinic.Show(); LoadHospitalBranch();

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Lab Reference Organization Detail and Address.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    //protected void ddlNewClinic_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    lblStatus.Visible = false;
    //    ltHead.Text = "Select a Clinic to edit the details or click on Add New Clinic.";
    //    Panel7.Visible = true;
    //    pLabRefOrgID = Convert.ToInt64(ddlNewClinic.SelectedValue);
    //    SetLabRefOrgAddress(pLabRefOrgID);
    //    mpeNewClinic.Show();
    //}
    //public void SetLabRefOrgAddress(long LabRefOrgID)
    //{
    //    try
    //    {
    //        long retCode = -1;
    //        Patient_BL patBL = new Patient_BL(base.ContextInfo);
    //        List<LabRefOrgAddress> getLabRefOrgAddress = new List<LabRefOrgAddress>();
    //        List<LabReferenceOrg> getLabRefOrg = new List<LabReferenceOrg>();
    //        retCode = patBL.GetLabRefOrgDetailandAddress(LabRefOrgID, out getLabRefOrg, out getLabRefOrgAddress);
    //        if (retCode == 0)
    //        {
    //            foreach (LabReferenceOrg labRefOrg in getLabRefOrg)
    //            {
    //                txtNewClinicName.Text = labRefOrg.RefOrgName;
    //                if (labRefOrg.ClientTypeID == 1)
    //                {
    //                    rdoHospital.Checked = true;
    //                    rdoClinic.Checked = false;
    //                    rdoLab.Checked = false;
    //                    hdnRefOrgType.Value = labRefOrg.ClientTypeID.ToString();
    //                }
    //                else if (labRefOrg.ClientTypeID == 2)
    //                {
    //                    rdoHospital.Checked = false;
    //                    rdoClinic.Checked = true;
    //                    rdoLab.Checked = false;
    //                    hdnRefOrgType.Value = labRefOrg.ClientTypeID.ToString();
    //                }
    //                else
    //                {
    //                    rdoHospital.Checked = false;
    //                    rdoClinic.Checked = false;
    //                    rdoLab.Checked = true;
    //                    hdnRefOrgType.Value = labRefOrg.ClientTypeID.ToString();
    //                }
    //            }
    //            foreach (LabRefOrgAddress labOrgAddress in getLabRefOrgAddress)
    //            {
    //                txtAddressID.Text = labOrgAddress.AddressID.ToString();
    //                txtAddress1.Text = labOrgAddress.Add1;
    //                txtAddress2.Text = labOrgAddress.Add2;
    //                txtAddress3.Text = labOrgAddress.Add3;
    //                txtCity.Text = labOrgAddress.City;
    //                ListItem Country = ddCountry.Items.FindByValue(labOrgAddress.CountryID.ToString());

    //                if (Country != null)
    //                {
    //                    ddCountry.SelectedValue = labOrgAddress.CountryID.ToString();
    //                }
    //                if (ddState.Items.FindByValue(labOrgAddress.StateID.ToString()) != null)
    //                {
    //                    ddState.SelectedValue = labOrgAddress.StateID.ToString();
    //                }
    //                txtPostalCode.Text = labOrgAddress.PostalCode;
    //                txtMobile.Text = labOrgAddress.MobileNumber;
    //                txtLandLine.Text = labOrgAddress.LandLineNumber;
    //                txtAltLandLine.Text = labOrgAddress.AltLandLineNumber;
    //                txtFax.Text = labOrgAddress.Fax;
    //            }
    //            btnDelete.Visible = true;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
    //    }
    //}
    //protected void lnkAddNewClinic_Click(object sender, EventArgs e)
    //{
    //    mpeNewClinic.Show();
    //    Panel9.Visible = false;
    //}


    #region Code for New CompletePage

    public string SaveInvestigationAndBill()
    {

        long returnCode = -1;
        long pVisitID = -1;
        long pPatientID = -1;
        long ptaskID = -1;
        string LabNo = string.Empty;
        string BillNo = string.Empty;
        pPatientID = Convert.ToInt64(hdnPatientID.Value);
        pVisitID = Convert.ToInt64(hdnVisitID.Value);
        List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
        List<OrderedInvestigations> ordInv = new List<OrderedInvestigations>();

        string GUID = System.Guid.NewGuid().ToString();
        //Save Order Investigation
        List<OrderedInvestigations> orderedInves = GetOrderedList(pVisitID, GUID);
        if (orderedInves.Count > 0)
        {
            returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(orderedInves, OrgID);
        }
        //Save Bill
        if (pVisitID != null)
        {
            foreach (OrderedInvestigations inv in orderedInves)
            {
                OrderedInvestigations objInves = new OrderedInvestigations();
                objInves.Type = inv.Type;
                ordInv.Add(objInves);
            }
            returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, ordInv, out LabNo);
        }
        BillMaster billMaster = new BillMaster();
        billMaster = Getillmaster(pPatientID, pVisitID);
        billMaster.Type = "";
        billMaster.VisitID = pVisitID;
        billMaster.BillID = Convert.ToInt32(LabNo);
        billMaster.CollectionCentreID = pCollectionCentreID;
        returnCode = GetBillItems(billMaster, pVisitID, pPatientID, out BillNo);
        //Create Task
        CreateTask(BillNo, LabNo, pVisitID, GUID);
        if (returnCode != 0)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<Tasks> lstTasks = new List<Tasks>();
        if (RoleName != RoleHelper.LabTech)
        {
            taskBL.GetTasks(RoleID, OrgID, UID, out lstTasks, RoleHelper.Inventory == RoleName ? InventoryLocationID : 0, currentPageNo, PageSize, out totalRows);
            foreach (Tasks objTasks in lstTasks)
            {
                ptaskID = objTasks.TaskID;
            }
            returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
        }
        ViewState["TotalLineItems"] = "";
        return BillNo;



    }

    public void LoadDiscount()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<DiscountMaster> getDiscount = new List<DiscountMaster>();
            retCode = patBL.GetLabDiscount(OrgID, out getDiscount);
            if (retCode == 0)
            {
                ddDiscountPercent.DataSource = getDiscount;
                ddDiscountPercent.DataTextField = "DiscountName";
                ddDiscountPercent.DataValueField = "Discount";
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Discount Details.", ex);
        }
    }

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }

    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }

    public List<OrderedInvestigations> GetOrderedList(long pVisitID, string GUID)
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = iconHid1.Value;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();

                    id = Convert.ToInt64(lineItems[0]);
                    strInvName = lineItems[1];
                    string type = lineItems[2];
                    decimal.TryParse(lineItems[4], out rate);
                    PatientInves.ID = id;
                    PatientInves.Name = strInvName;
                    PatientInves.Type = type;
                    PatientInves.Rate = rate;

                    PatientInves.VisitID = Convert.ToInt64(pVisitID);
                    PatientInves.Status = "Paid";
                    PatientInves.PaymentStatus = "Paid";
                    PatientInves.CreatedBy = LID;
                    PatientInves.OrgID = OrgID;
                    PatientInves.UID = GUID;
                    PatientInves.StudyInstanceUId = CreateUniqueDecimalString();

                    lstpatInves.Add(PatientInves);
                }
            }
        }
        return lstpatInves;
    }

    protected void btnBillShow_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long pVisitID = -1;
            long pPatientID = -1;
            long ptaskID = -1;
            string LabNo = string.Empty;
            string BillNo = string.Empty;
            pPatientID = Convert.ToInt64(hdnPatientID.Value);
            pVisitID = Convert.ToInt64(hdnVisitID.Value);
            List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
            List<OrderedInvestigations> ordInv = new List<OrderedInvestigations>();

            string GUID = System.Guid.NewGuid().ToString();
            //Save Order Investigation
            List<OrderedInvestigations> orderedInves = GetOrderedList(pVisitID, GUID);
            if (orderedInves.Count > 0)
            {
                returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigation(orderedInves, OrgID);
            }
            //Save Bill
            if (pVisitID != null)
            {
                foreach (OrderedInvestigations inv in orderedInves)
                {
                    OrderedInvestigations objInves = new OrderedInvestigations();
                    objInves.Type = inv.Type;
                    ordInv.Add(objInves);
                }
                returnCode = new Investigation_BL(base.ContextInfo).GetLabNo(OrgID, ordInv, out LabNo);
            }
            BillMaster billMaster = new BillMaster();
            billMaster = Getillmaster(pPatientID, pVisitID);
            billMaster.Type = "";
            billMaster.VisitID = pVisitID;
            billMaster.BillID = Convert.ToInt32(LabNo);
            billMaster.CollectionCentreID = pCollectionCentreID;
            returnCode = GetBillItems(billMaster, pVisitID, pPatientID, out BillNo);
            //Create Task
            CreateTask(BillNo, LabNo, pVisitID, GUID);
            if (returnCode != 0)
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            List<Tasks> lstTasks = new List<Tasks>();
            if (RoleName != RoleHelper.LabTech)
            {
                taskBL.GetTasks(RoleID, OrgID, UID, out lstTasks, RoleHelper.Inventory == RoleName ? InventoryLocationID : 0, currentPageNo, PageSize, out totalRows);
                foreach (Tasks objTasks in lstTasks)
                {
                    ptaskID = objTasks.TaskID;
                }
                returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
            }
            ViewState["TotalLineItems"] = "";
            Response.Redirect("ViewBill.aspx?billNo=" + BillNo + "&ccid=" + pCollectionCentreID, true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Generating Bill", ex);
        }
    }

    public BillMaster Getillmaster(long pPatientID, long pVisitID)
    {
        int pClientID = 0;
        long pTPAID = -1;

        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();
        new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit, out lstOrdered);
        if (lstPatientVisit.Count > 0)
        {
            pClientID = Convert.ToInt32(lstPatientVisit[0].ClientMappingDetailsID);
            pTPAID = lstPatientVisit[0].TPAID;
        }


        BillMaster billMaster = new BillMaster();
        BillLineItems billLineItems = new BillLineItems();
        billMaster.OrgID = OrgID;
        billMaster.VisitID = pVisitID;
        billMaster.PatientID = pPatientID;
        billMaster.ClientID = pClientID;
        billMaster.TPAID = pTPAID;
        billMaster.GrossAmount = Convert.ToDecimal(hdnFinalGross.Value);
        billMaster.Discount = Convert.ToDecimal(hdnFinalDiscount.Value);
        billMaster.TaxPercent = Convert.ToDecimal(hdnFinalTax.Value);
        billMaster.NetAmount = Convert.ToDecimal(hdnFinalGrandTotal.Value);
        billMaster.AmountReceived = Convert.ToDecimal(hdnFinalAmountRecieved.Value);
        billMaster.AmountDue = Convert.ToDecimal(hdnFinalDue.Value);
        billMaster.CreatedBy = LID;
        //if (txtComments.Value != "")
        //{
        //    billMaster.Comments = txtComments.Value;
        //}
        if (chkisCreditTransaction.Checked == true)
        {
            billMaster.IsCredit = "Y";
        }
        else
        {
            billMaster.IsCredit = "N";
        }
        return billMaster;
    }

    public long GetBillItems(BillMaster billMaster, long visitID, long patientID, out string billId)
    {
        int entry = -1;
        long rid = -1;
        long rtn = -1;
        string pBillID = string.Empty;
        billId = "";
        string temp;

        List<BillLineItems> LbillItems = new List<BillLineItems>();
        BillLineItems PbillItems1;
        long id = 0;
        string hidValue = iconHid1.Value;
        string strRate = string.Empty;
        string strInvName = string.Empty;
        decimal rate = 0;
        //"231~Platelet Rich Concentrate -Rs: 220.00~BLB^1008~Toxoplasma Virus - IgG -Rs: 0.00~INV^"
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PbillItems1 = new BillLineItems();
                    id = Convert.ToInt64(lineItems[0]);
                    strInvName = lineItems[1];
                    string type = lineItems[2];
                    decimal.TryParse(lineItems[4], out rate);
                    PbillItems1.ItemID = id;
                    PbillItems1.ItemName = strInvName;
                    PbillItems1.Quantity = 1;
                    PbillItems1.Rate = rate;
                    PbillItems1.ItemType = type;
                    PbillItems1.Amount = rate;
                    LbillItems.Add(PbillItems1);
                }
            }
        }
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
        dtAmountReceived = PaymentType.GetAmountReceivedDetails();
        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
        dServiceCharge = Convert.ToDecimal(txtServiceCharge.Text);
        rtn = patientBL.SaveBillDetails(billMaster, LbillItems, out pBillID, dtAmountReceived, dServiceCharge);
        billId = pBillID;
        return rtn;
    }

    public long CreateTask(string BillNo, string LabNo, long pVisitID, string GUID)
    {
        long PatientID = -1;
        long returnCode = -1;
        Tasks task = new Tasks();
        List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
        List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
        List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
        new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(pVisitID, OrgID, RoleID, GUID, out lstSampleDept1, out lstSampleDept2);

        //var lst = from lstSample in lstSampleDept1
        //          group lstSample by lstSample.Display


        if (lstSampleDept2.Count > 0)
        {
            //Int64.TryParse(Request.QueryString["pid"], out PatientID);
            PatientID = Convert.ToInt64(hdnPatientID.Value);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            //Create task               
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

        }
        foreach (var item in lstSampleDept1)
        {
            //if (item.Display == "Y")
            //{
            //Int64.TryParse(Request.QueryString["pid"], out PatientID);
            PatientID = Convert.ToInt64(hdnPatientID.Value);
            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                         pVisitID, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                         , out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, 0, GUID);
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = PatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = LabNo.ToString();
            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
        }
        returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(pVisitID, "SampleReceived", OrgID, lstInvResult);
        return returnCode;
    }
    public void LoadReferringOrgType()
    {
        long returnCode = -1;
        List<ReferringOrgType> lsRefOrgTypeMaster = new List<ReferringOrgType>();
        try
        {
            returnCode = new IP_BL(base.ContextInfo).GetReferringOrgType(OrgID, out lsRefOrgTypeMaster);
            if (lsRefOrgTypeMaster.Count > 0)
            {
                ddlReferringOrgType.DataSource = lsRefOrgTypeMaster;
                ddlReferringOrgType.DataTextField = "TYPE";
                ddlReferringOrgType.DataValueField = "ID";
                ddlReferringOrgType.DataBind();
                ddlReferringOrgType.Items.Insert(0, "-----Select-----");
                ddlReferringOrgType.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTPAName", ex);
        }
    }
    #endregion

}