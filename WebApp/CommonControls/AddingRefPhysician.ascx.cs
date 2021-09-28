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
public partial class CommonControls_AddingRefPhysician : BaseControl
{
    private DropDownList ddl = new DropDownList();
    private ListControl LC;
    GateWay gateWay;
    List<PhysicianOrgMapping> pomList = new List<PhysicianOrgMapping>();
    List<ReferingPhysician> lstPhysician = new List<ReferingPhysician>();
    long returncode = -1;
    long returnCode = -1;
    List<PhysicianOrgMapping> pomCopy = new List<PhysicianOrgMapping>();
    long LoginID = 0;
    string RoleId = "";
    Patient_BL patientBL;
    List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
    ReferingPhysician objReferingPhysician = new ReferingPhysician();
    string physicianName = string.Empty;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    Users_BL UserBL;
    Patient_BL patBL;
    public DropDownList  DDL
    {
        get
        {
            return ddl;
        }

        set
        {
            ddl = value;
        }
}
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            hdnReferringPhy.Value = "0";
            hdnReferrinCancel.Value = "0";
        }
        try
        {
            List<Config> lstConfig = new List<Config>();


            //Added By Ramki
            gateWay = new GateWay(base.ContextInfo);
            returnCode = gateWay.GetConfigDetails("Refering Physician", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                if (lstConfig[0].ConfigValue == "Y")
                {
                    Td1.Attributes.Add("Style", "display:Block");
                }
                else
                {
                    Td1.Attributes.Add("Style", "display:None");
                }
            }

            tdrefer.Attributes.Add("Style", "display:none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in d page load", ex);
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
    protected void btnCancel1_click(object sender, EventArgs e)
    {
        try
        {
            programmaticModalPopup.Hide();
            hdnReferrinCancel.Value = "1";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert1","hidepopupQuickBill()", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnCancel1_click", ex);
        }
    }
    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Branch = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, out RefOrg);
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            Branch = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 2; });
            if (retCode == 0)
            {           
                chklstHsptl.DataSource = Hospital;
                chklstHsptl.DataTextField = "RefOrgNameWithAddress";
                chklstHsptl.DataValueField = "LabRefOrgID";
                chklstHsptl.DataBind();                       
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
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
            Utilities obj = new Utilities();
            string select = obj.GetDefaultEntryForDropDownControl("Defaults", "Select");
            Salutation selectedSalutation = new Salutation();
            int titleID = 0;
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();
                ddSalutation.Items.Insert(0, select );
                ddSalutation.Items[0].Value = "0";
               
                //ddSalutation1.DataSource = titles;
                //ddSalutation1.DataTextField = "TitleName";
                //ddSalutation1.DataValueField = "TitleID";
                //ddSalutation1.DataBind();
                //ddSalutation1.Items.Insert(0, "--Select--");
                //ddSalutation1.Items[0].Value = "0";
                //selectedSalutation = titles.Find(Findsalutation);
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
    protected void lnkAddnew_Click(object sender, EventArgs e)
    {
        try
        {
            //returncode = new Investigation_BL(base.ContextInfo).getdept
            LoadTitle();
            txtPassword.Enabled = false;
            LoadHospitalBranch();
            programmaticModalPopup.Show();
            hdnReferringPhy.Value = "1";
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "showRefPhy()", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in lnkAddnew_Click", ex);
        }
    }
    public long InsertLogin()
    {
        long lresult = -1;
        long LoginID = 0;
        roleBL = new Role_BL(base.ContextInfo);
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
            roleBL = new Role_BL(base.ContextInfo);
            LoginRole LoginRole = new LoginRole();
            LoginRole.LoginID = LoginID;
            LoginRole.RoleID = RoleID;
            LoginRole.CreatedBy = LID;
            LoginRole.ModifiedBy = LID;
            lresult = roleBL.SaveLoginRole(LoginRole);
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
            UserBL = new Users_BL(base.ContextInfo);
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
    protected void SaveLoginDetails()
    {
        long lresult1 = -1;
        long lresult2 = -1;
        try
        {
            long returncode = -1;
            List<Role> Temprole = new List<Role>();
            roleBL = new Role_BL(base.ContextInfo);
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
                string TransPass = string.Empty;
                Returncode = LoginCheckdetails.GetLoginUserName(LoginID, out LoginName, out strPass,out TransPass);
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int pRefPhyID = -1;
        try
        {
            if (chkUserLogin.Checked == true)
                SaveLoginDetails();
            //btnFinish.Visible = false;
            objReferingPhysician.PhysicianName = txtDrName.Text;
            objReferingPhysician.Qualification = txtDrQualification.Text;
            objReferingPhysician.OrganizationName = txtDrOrganization.Text;
            objReferingPhysician.OrgID = OrgID;
            objReferingPhysician.Salutation = Convert.ToInt32(ddSalutation.SelectedValue);
            List<PhysicianOrgMapping> pomList = new List<PhysicianOrgMapping>();
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
            patientBL = new Patient_BL(base.ContextInfo);
            long PhysicianRoleId = 0;
            returnCode = patientBL.SaveReferingPhysician(objReferingPhysician, lstRefPhyAddressDetails, pomList, Convert.ToInt16(LoginID), out pRefPhyID, out lstPhysician, out PhysicianRoleId);
            if (returnCode == 0)
            {
                iconHid.Value = "";
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                lblStatus.Visible = true;
                lblStatus.Text = "New Refering Physician Added Successfully!";
               // btnFinish.Visible = true;
               // Panel7.Visible = true;
                ddl.DataSource = lstPhysician;
                ddl.DataTextField = "PhysicianName";
                ddl.DataValueField = "ReferingPhysicianID";
                ddl.DataBind();
                ddSex.SelectedValue = "0";
                ddSalutation.SelectedValue = "0";
                //ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Changes saved successfully.');", true);
                //LoadHospitalBranch();
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
}
