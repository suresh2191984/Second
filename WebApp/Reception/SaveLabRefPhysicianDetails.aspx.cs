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
using System.Web.Caching;
using System.Linq;
using Attune.Podium.PerformingNextAction;
using Attune.Podium.ExcelExportManager;
using System.IO;
using System.Xml;
using System.Drawing;

public partial class Reception_SaveLabRefPhysicianDetails : BasePage
{

    public Reception_SaveLabRefPhysicianDetails()
        : base("Reception_SaveLabRefPhysicianDetails_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string TransPass = string.Empty;
    string oldtransPassword = string.Empty;
    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL ;
    List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
    ReferingPhysician objReferingPhysician = new ReferingPhysician();
    AddressDetails objAddressDetails = new AddressDetails();
    string physicianName = string.Empty;
    Role_BL roleBL ;
    List<Role> role = new List<Role>();
    string RoleId = "";
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    DateTime TransationPasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");    
    protected void Page_Load(object sender, EventArgs e)
    {
        string strltHead = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_04 == null ? "Enter the details of new Physician" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_04;
        try
        {
            patientBL = new Patient_BL(base.ContextInfo);
            roleBL = new Role_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                LoadCountry();
                LoadMeatData();
                GetAddressType();
                LoadMetaCategory();
                LoadHospitalBranch();
                LoadTitle();
                LoadddlFeeCategory();
            }
            //lblStatus.Text = "";
            //ddlDOBDWMY.Style.Add("display", "none");
            lblLoginName.Text = "";
            chkUserLogin.Attributes.Add("onclick", "ShowLogin(this)");
            physicianName = txtSearchPhysicianName.Text;
            AutoRname.ContextKey = "N";                       
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
            }
            if (mode == 1)
            {
                Panel7.Visible = false;
                ltHead.Text = strltHead;
               // ltHead.Text = "Enter the details of new Physician";
                btnFinish.Visible = true;
            }
            else
            {
                TabNew.Style.Add("display", "none");
                btnFinish.Visible = false;
            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveLabRefPhysicianDetails.aspx:Page_Load", ex);
        }
    }
    private void LoadddlFeeCategory()
    {
        string strddlFeeCategory = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01 == null ? "----select-----" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01;
        try
        {
            long returncode = -1;
            List<ManageReferralPolicy> lisManageReferralPolicy = new List<ManageReferralPolicy>();
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            returncode = objMaster_BL.GetReferralCategory(out lisManageReferralPolicy);
            if (lisManageReferralPolicy.Count > 0)
            {
                var childItems = from C in lisManageReferralPolicy
                                 orderby C.Categoryid ascending
                                 select C;
                if (childItems.Count() > 0)
                {
                    ddlFeeCategory.DataSource = childItems;
                    ddlFeeCategory.DataTextField = "CategoryName";
                    ddlFeeCategory.DataValueField = "Categoryid";
                    ddlFeeCategory.DataBind();
                    ddlFeeCategory.Items.Insert(0, strddlFeeCategory);
                   // ddlFeeCategory.Items.Insert(0, "----select-----");
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load ddlFeeCategory  ", ex);

        }

    }
    public void GetAddressType()
    {
        long returnCode = -1;
        try
        {
            string strddlSelect  = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01 == null ? "----select-----" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01;
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
            returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
            string AddNewDepartment = string.Empty;
            if (!String.IsNullOrEmpty(ViewState["AddDepartment"].ToString()))
            {
                AddNewDepartment = ViewState["AddDepartment"].ToString();
            }
            if (lstEmpDeptMaster.Count > 0 || (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0))
            {
                if (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0)
                {
                    string[] Department = AddNewDepartment.Split('^');
                    for (int i = 0; i < Department.Length; i++)
                    {
                        if (!String.IsNullOrEmpty(Department[i]) && Department[i].Length > 0)
                        {
                            EmployerDeptMaster objEDM = new EmployerDeptMaster();
                            objEDM.EmpDeptName = Department[i].Split('~')[0];
                            objEDM.Code = Department[i].Split('~')[1];
                            lstEmpDeptMaster.Add(objEDM);
                        }
                    }
                }
                drplstPerson.DataSource = lstEmpDeptMaster;
                drplstPerson.DataValueField = "Code";
                drplstPerson.DataTextField = "EmpDeptName";
                drplstPerson.DataBind();
                drplstPerson.Items.Insert(0, strddlSelect);
                drplstPerson.Items[0].Value = "0";
            }
            //---Code End---
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Despatch Mode", ex);
        }
    }
    public void LoadMetaCategory()
    {
        string strddlCategory = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01 == null ? "----select-----" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_01;
        try
        {
            long returncode = -1;

            string domains = "TestClassification";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TestClassification"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlcategory.DataSource = childItems;
                    ddlcategory.DataTextField = "DisplayText";
                    ddlcategory.DataValueField = "Code";
                    ddlcategory.DataBind();

                    ddlcategory.Items.Insert(0, strddlCategory);
                    //ddlcategory.Items.Insert(0, "----select-----");
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
        }
    }
    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Branch = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, out RefOrg);
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            Branch = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 2; });
            if (retCode == 0)
            {
                chklstHsptl.DataSource = RefOrg;
                chklstHsptl.DataTextField = "RefOrgName";
                chklstHsptl.DataValueField = "LabRefOrgID";
                chklstHsptl.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_13 == null ? "Alert" : Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_13;
        string UsrMsgWin = Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_12 == null ? "New refering physician added successfully!" : Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_12;
        string strlthead = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02 == null ? "Search for existing Physician details or click on Add New Physician." : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02;
        int pRefPhyID = -1;
        try
        {
            if (chkUserLogin.Checked == true)
                SaveLoginDetails();
            btnFinish.Visible = false;
            objReferingPhysician.PhysicianName = txtDrName.Text.ToUpper();
            objReferingPhysician.PhysicianCode = txtPhysicianCode.Text;
            objReferingPhysician.Qualification = txtDrQualification.Text;
            objReferingPhysician.OrganizationName = txtDrOrganization.Text;
            objReferingPhysician.OrgID = OrgID;
            objReferingPhysician.Salutation = Convert.ToInt32(ddSalutation.SelectedValue);
            /* Added By GURUNATH S 26-SEP-2012 */
            objReferingPhysician.IsClient = chkIsClient.Checked ? "Y" : "N";
            objReferingPhysician.CreatedBy = LID;
            objReferingPhysician.IsActive = "Y";
            objReferingPhysician.Gender = hdnGender.Value;
            string Date = tDOB.Text.Trim() == "" ? "" : tDOB.Text.Trim();
            objReferingPhysician.DOB = tDOB.Text;
            objReferingPhysician.Age = txtDOBNos.Text == "" ? "" : txtDOBNos.Text.Trim();
            objReferingPhysician.Category = ddlcategory.SelectedItem.Text;
            ContextInfo.AdditionalInfo = txtPersonName.Text + ","+drplstPerson.SelectedValue;
            if (Txt_Rate.Text != "")
            {
                objReferingPhysician.Rate = Convert.ToDecimal(Txt_Rate.Text);
            }
            if (ddlFeeCategory.SelectedValue != "" && ddlFeeCategory.SelectedValue !="----select-----")
            {
                objReferingPhysician.RefFeeCategoryid = Convert.ToInt64(ddlFeeCategory.SelectedValue);
            }
            else
            {
                objReferingPhysician.RefFeeCategoryid = 0;
            }

            if (hdnEmpID.Value != null && hdnEmpID.Value != "")
            {
                objReferingPhysician.ContactPersonID = Convert.ToInt64(hdnEmpID.Value);
            }

            else
            { objReferingPhysician.ContactPersonID = -1; }
            
            /* Changes End */
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
            /* Added By GURUNATH.S 19-OCT-2012 */
            List<AddressDetails> lstRefPhyAddressDetails = new List<AddressDetails>();
            lstRefPhyAddressDetails = GetRefPhyAddressDetails();
            
            pomList = GetReferanceHptls();
            long PhysicianRoleId = 0;
            //syed
            decimal DiscountLimit = 0;
            String DiscountPeriod = string.Empty;
            DateTime DiscountValidFrom = DateTime.MaxValue;
            DateTime DiscountValidTo = DateTime.MaxValue;
            decimal.TryParse(txtDiscountLimit.Text, out DiscountLimit);
            if (DiscountLimit > 0)
            {
                DiscountPeriod = "Monthly";
            }

            //DateTime.TryParse(txtFromPeriod.Text, out DiscountValidFrom);
            //DateTime.TryParse(txtToPeriod.Text, out DiscountValidTo);
            objReferingPhysician.DiscountValidFrom = txtFromPeriod.Text == "" ? DateTime.MaxValue : Convert.ToDateTime(txtFromPeriod.Text);
            objReferingPhysician.DiscountValidFrom = txtToPeriod.Text == "" ? DateTime.MaxValue : Convert.ToDateTime(txtToPeriod.Text);
            objReferingPhysician.DiscountValidTo = DiscountValidTo;
            objReferingPhysician.DiscountLimit = DiscountLimit;
            objReferingPhysician.DiscountPeriod = DiscountPeriod; 

            returnCode = patientBL.SaveReferingPhysician(objReferingPhysician, lstRefPhyAddressDetails, pomList, Convert.ToInt16(LoginID), out pRefPhyID, out lstReferingPhysician, out PhysicianRoleId);
            try
            {
                //PageContextDetails.PatientID = Convert.ToInt64(patientID);
 				if ((objReferingPhysician.PhysicianCode).ToString() != "" || (objReferingPhysician.PhysicianCode).ToString() != "" != null)
                {
                    PageContextDetails.PatientVisitID = Convert.ToInt64(objReferingPhysician.PhysicianCode);
                }
                else
                {
                    PageContextDetails.PatientVisitID = pRefPhyID;
                }
                PageContextDetails.PageID = PageID;
                PageContextDetails.ActionType = "RP";
                PageContextDetails.RoleID = PhysicianRoleId;
                PageContextDetails.ButtonName = ((Button)sender).ID;
                PageContextDetails.ButtonValue = ((Button)sender).Text;
                ActionManager am = new ActionManager(base.ContextInfo);
                returnCode = am.PerformingNextStep(PageContextDetails);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Sending Email", ex);
            }
            if (returnCode == 0)
            {
                iconHid.Value = "";
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                txtPhysicianCode.Text = "";
                grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "New Refering Physician Added Successfully!";
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                Panel7.Visible = true;
                ddSex.SelectedValue = "0";
                ddSalutation.SelectedValue = "0";
                chkIsClient.Checked = false;
                chkActive.Checked = false;
                //ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                ltHead.Text = strlthead;
                LoadHospitalBranch();
                Session["HidDel"] = "";
                txtDiscountLimit.Text = "";
                txtToPeriod.Text = "";
                txtFromPeriod.Text = "";
                Txt_Rate.Text = "";
                ddlFeeCategory.SelectedIndex = 0;
                ddlcategory.SelectedIndex = 0;
                //ddlcategory.Items.Clear();
                ClearFunction();
 				LoadTitle();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('New refering physician added successfully!');", true);
             

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Refering Physician Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    List<PhysicianOrgMapping> pomCopy = new List<PhysicianOrgMapping>();
    string Deleted = "";//Change ThursDay May 27
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04 == null ? "Alert" : Resources.Reception_AppMsg.Reception_PatientTrackingDetails_aspx_04;
        string UsrMsgWin = Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_16 == null ? "Update Successfully" : Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_16;
        #region //Changes ThursDay May 27
        try
        {
            string strPass = string.Empty;
            string LoginName = "";
            long ModifiedBy = LID;
            Users_BL LoginCheckdetails = new Users_BL(base.ContextInfo);
            if (chkUserLogin.Checked == true)
            {
                Attune.Podium.BusinessEntities.Login objlogin = new Attune.Podium.BusinessEntities.Login();
                objlogin.LoginID = Convert.ToInt32(LogID.Value);
                objlogin.LoginName = txtUserName.Text;
                objlogin.OrgID = OrgID;
                if (LogID.Value == "0")
                    LoginID = InsertLogin();
                else
                    returnCode = new GateWay(base.ContextInfo).UpdateLoginDetails(objlogin);

                OrgUsers eUsers = new OrgUsers();


                /*e.LoginID, e.OrgUID, e.RoleName, int.Parse(e.TitleCode), e.Name, e.SEX, e.Email, e.DOB,
                e.Relegion, e.WeddingDt, e.Qualification, e.MaritalStatus, e.Add1, e.Add2, 
                e.Add3, e.City, e.CountryID, e.StateID, e.PostalCode, e.MobileNumber, e.LandLineNumber;*/
                if (hdnUserId.Value == "" || hdnUserId.Value == "0" && LoginID != 0)
                {
                    List<Role> Temprole = new List<Role>();
                    roleBL.GetRoleName(OrgID, out role);
                    Temprole = role.FindAll(delegate(Role R) { return R.RoleName == RoleHelper.ReferringPhysician; });

                    if (Temprole.Count == 1)
                        RoleId = Temprole[0].RoleID.ToString();
                    InserLoginRole(Convert.ToInt32(RoleId), LoginID);
                    InsertUsers(LoginID);


                    LoginCheckdetails.GetLoginUserName(LoginID, out LoginName, out strPass,out TransPass);
                    //lblStatus.Text = "<h5>Successfully Created For LoginName: " + LoginName + " & Password :" + strPass + " </h5>";
                    txtUserName.Text = "";
                    txtPassword.Text = "";
                    chkUserLogin.Checked = false;
                }
                else
                {
                    eUsers.OrgUID = Convert.ToInt32(hdnUserId.Value);
                    eUsers.LoginID = Convert.ToInt32(LogID.Value);
                    eUsers.Name = txtUserName.Text;
                    eUsers.SEX = ddSex.SelectedValue;
                    eUsers.DOB = OrgDateTimeZone;
                    eUsers.WeddingDt = OrgDateTimeZone;
                    eUsers.TitleCode = ddSalutation.SelectedValue;
                    new AdminReports_BL(base.ContextInfo).UpdateUserDetails(eUsers, ModifiedBy);

                    LoginCheckdetails.GetLoginUserName(Convert.ToInt32(LogID.Value), out LoginName, out strPass, out TransPass);
                    //lblStatus.Text = "<h5>Successfully Updated For LoginName: " + LoginName + " & Password :" + strPass + " </h5>";
                    txtUserName.Text = "";
                    txtPassword.Text = "";
                }
            }
            btnUpdate.Visible = false;
            List<PhysicianOrgMapping> pomList = new List<PhysicianOrgMapping>();
            objReferingPhysician.ReferingPhysicianID = Convert.ToInt32(hdnReferingPhysicianID.Value);
            objReferingPhysician.PhysicianName = txtDrName.Text;
            objReferingPhysician.Qualification = txtDrQualification.Text;
            objReferingPhysician.OrganizationName = txtDrOrganization.Text;
            objReferingPhysician.OrgID = OrgID;
            //objReferingPhysician.LoginID = LogID.Value == "0" ? Convert.ToInt32( LoginID): Convert.ToInt32(LogID.Value);
            objReferingPhysician.LoginID = LogID.Value == "0" ? Convert.ToInt32( LoginID): Convert.ToInt32(LogID.Value);
            objReferingPhysician.Salutation = Convert.ToInt32(ddSalutation.SelectedValue);
            objReferingPhysician.PhysicianCode = txtPhysicianCode.Text;
            /* Added By GURUNATH 26-SEP-12 */
            objReferingPhysician.IsClient = chkIsClient.Checked ? "Y" : "N";
            objReferingPhysician.IsActive = chkActive.Checked ? "Y" : "N";
            objReferingPhysician.ModifiedBy = LID;
            objReferingPhysician.Gender = hdnGender.Value;
            string Date = tDOB.Text.Trim() == "" ? "" : tDOB.Text.Trim();
            objReferingPhysician.DOB = tDOB.Text;
            objReferingPhysician.Age = txtDOBNos.Text == "" ? "" : txtDOBNos.Text.Trim();

            if (ddlFeeCategory.SelectedValue != "" && ddlFeeCategory.SelectedValue != "----select-----")
            {
                objReferingPhysician.RefFeeCategoryid = Convert.ToInt64(ddlFeeCategory.SelectedValue);
            }
            else
            {
                objReferingPhysician.RefFeeCategoryid = 0;
            }

           //objReferingPhysician.RefFeeCategoryid = Convert.ToInt64(ddlFeeCategory.SelectedValue);
            /* Code Ended */
           //pom= GetHptlsList(objReferingPhysician.ReferingPhysicianID);

            string HoID = HidDel.Value!=""?HidDel.Value: Session["HidDel"].ToString();
            if (HoID != "")
            {
                foreach (string ID in HoID.Split('^'))
                {
                    if (ID != "")   
                    {
                        if (Deleted == "")
                            Deleted += ID.ToString();
                        else
                            Deleted += "," + ID.ToString();
                    }
                }
            }
            pomList = GetReferanceHptls();
            List<AddressDetails> lstRefPhyAddresDetails = new List<AddressDetails>();
            lstRefPhyAddresDetails = GetRefPhyAddressDetails();
           //syed

            decimal DiscountLimit = 0;
            String DiscountPeriod = string.Empty;
            DateTime DiscountValidFrom = txtFromPeriod.Text == "" ? DateTime.MaxValue : Convert.ToDateTime(txtFromPeriod.Text);
            DateTime DiscountValidTo = txtToPeriod.Text == "" ? DateTime.MaxValue : Convert.ToDateTime(txtToPeriod.Text);
            decimal.TryParse(txtDiscountLimit.Text, out DiscountLimit);
            if (DiscountLimit > 0)
            {
                DiscountPeriod = "Monthly";
            }

         //   DateTime.TryParse(txtFromPeriod.Text, out DiscountValidFrom);
         //   DateTime.TryParse(txtToPeriod.Text, out DiscountValidTo);
            objReferingPhysician.DiscountValidFrom = DiscountValidFrom;
            objReferingPhysician.DiscountValidTo = DiscountValidTo;
            objReferingPhysician.DiscountLimit = DiscountLimit;
            objReferingPhysician.DiscountPeriod = DiscountPeriod;
            if (hdnEmpID.Value != null && hdnEmpID.Value != "")
            {
                objReferingPhysician.ContactPersonID = Convert.ToInt64(hdnEmpID.Value);
            }
        


            returnCode = patientBL.UpdateReferingPhysician(objReferingPhysician, lstRefPhyAddresDetails, pomList, Deleted);
           
            if (returnCode == 0)
            {
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                txtPhysicianCode.Text = "";
                grdResult.Visible = false;
                //lblStatus.Visible = true;
               // if (chkUserLogin.Checked == false)
                   // lblStatus.Text = "Refering Physician Changes Saved Successfully!";
                btnFinish.Visible = true;
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                Panel7.Visible = true;
                LoadHospitalBranch();
                Session["HidDel"] = "";
                HdnHospitalID.Value = "";
                iconHid.Value = "";
                ddSex.SelectedValue = "0";
                ddSalutation.SelectedValue = "0";
                chkUserLogin.Checked = false;
                Login.Style.Add("display", "none");
                chkIsClient.Checked = false;
                chkActive.Visible = false;
                chkActive.Checked = false;
                txtDiscountLimit.Text = "";
                txtToPeriod.Text = "";
                txtFromPeriod.Text = "";
                ddlFeeCategory.SelectedIndex = 0;
                ClearFunction();
                
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Updated successfully.');", true);//Change ThursDay May 27
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Refering Physician Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        #endregion
    }
   
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        string WinAlert = Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_13 == null ? "Alert" : Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_13;
        string UsrMsgWin = Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_14 == null ? "Removed successfully!" : Resources.Reception_AppMsg.Reception_SaveLabRefPhysicianDetails_aspx_14;
        string strlthead = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02 == null ? "Search for existing Physician details or click on Add New Physician." : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02;
        try
        {
            objReferingPhysician.ReferingPhysicianID = Convert.ToInt32(hdnReferingPhysicianID.Value);
            objReferingPhysician.Status = "D";
            objReferingPhysician.OrgID = OrgID;
            List<AddressDetails> lstRefPhyAddressDetails = new List<AddressDetails>();
            lstRefPhyAddressDetails = GetRefPhyAddressDetails();
            returnCode = patientBL.UpdateReferingPhysician(objReferingPhysician, lstRefPhyAddressDetails, pomCopy, Deleted);
            if (returnCode == 0)
            {
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                txtPhysicianCode.Text = "";
                grdResult.Visible = false;
                //lblStatus.Visible = true;
                //lblStatus.Text = "Refering Physician Removed Successfully!";
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                ltHead.Text = strlthead;
                //ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                Panel7.Visible = true;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Removed successfully!');", true);
                LoadHospitalBranch();
                txtDiscountLimit.Text = "";
                txtToPeriod.Text = "";
                txtFromPeriod.Text = "";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Removing Refering Physician Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("SaveLabRefPhysicianDetails.aspx?mode=0", true);
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

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            string[] ht = new string[5];
            string phyname;
            if (physicianName.Contains("."))
            {
                ht = physicianName.Split('.');
                phyname = ht[1].ToString();
            }
            else
            {
                phyname = physicianName;
            }
            grdResult.PageIndex = e.NewPageIndex;
            patientBL.GetReferingPhysician(OrgID, phyname, "", out lstReferingPhysician);
            grdResult.DataSource = lstReferingPhysician;
            grdResult.DataBind();
        }
    }
    protected void addNewPhysician_Click(object sender, EventArgs e)
    {
        Response.Redirect("SaveLabRefPhysicianDetails.aspx?mode=1",true);
    }
   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strlthead = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02 == null ? "Search for existing Physician details or click on Add New Physician." : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02;
        string[] ht = new string[5];
        string phyname;
        if (physicianName.Contains("."))
        {
            ht = physicianName.Split('.');
            phyname = ht[1].ToString();
        }
        else
        {
            phyname = physicianName;
        }
        patientBL.GetReferingPhysician(OrgID, phyname, "", out lstReferingPhysician);
        grdResult.Visible = true;
        grdResult.DataSource = lstReferingPhysician;
        grdResult.DataBind();
        ltHead.Text = strlthead;
        //ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
        Panel7.Visible = true;
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strlthead = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02 == null ? "Search for existing Physician details or click on Add New Physician." : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_02;  
        try
        {
            chkUserLogin.Checked = false;
            Login.Style.Add("display", "none");
            List<Attune.Podium.BusinessEntities.Login> lstLogin = new List<Attune.Podium.BusinessEntities.Login>();
            List<PhysicianOrgMapping> Pom = new List<PhysicianOrgMapping>();
            List<Role> lstLRole = new List<Role>();
            List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
            ltHead.Text = strlthead;
           // ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
            Panel7.Visible = true;

            if (e.CommandName == "Reset")
            {
                long returnCode = -1;
                //string Name = grdResult.Rows[Convert.ToInt32(e.CommandArgument)].Cells[4].Text;
                string Name = grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][4].ToString();

                string EncryptedString = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                obj.Crypt(Name, out EncryptedString);
                Name = EncryptedString;
                string newtransPwd = string.Empty;
                if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                {
                    PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);

                }
                returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "",oldtransPassword, Name,newtransPwd,PasswordExpiryDate,TransationPasswordExpiryDate);
                if (returnCode != -1)
                {
                    string DecryptedString = string.Empty;
                    Attune.Cryptography.CCryptography objDecryptor = new Attune.Cryptography.CCryptFactory().GetDecryptor( );
                    objDecryptor.Crypt(Name, out DecryptedString);

   					 Name = DecryptedString;
                    lblStatus.Visible = true;
                    lblStatus.Text = "LoginName : " + Name + " &nbsp; Password :  " + Name;
                    lblStatus.Font.Bold = true;//surya uncommanded
                    //lblStatus.Visible = true;
                    //lblStatus.Text = "LoginName : " + Name + " &nbsp; Password :  " + Name;
                    //lblStatus.Font.Bold = true;
                }
            }
            if (e.CommandName == "Select")
            {

                
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                Label lblId = (Label)grdResult.Rows[RowIndex].FindControl("lblLoginId");
                Label lblStn = (Label)grdResult.Rows[RowIndex].FindControl("lblSalutation");
                hdnReferingPhysicianID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                 LogID.Value =lblId.Text;
                 if (LogID.Value != "")
                     chkUserLogin.Enabled = false;
                 ddSalutation.SelectedValue = lblStn.Text;
                txtDrName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
                txtDrQualification.Text = Convert.ToString(grdResult.DataKeys[RowIndex][2]);
                txtDrOrganization.Text = Convert.ToString(grdResult.DataKeys[RowIndex][3]);
                txtPhysicianCode.Text = Convert.ToString(grdResult.DataKeys[RowIndex][5]);
                chkIsClient.Checked = Convert.ToString(grdResult.DataKeys[RowIndex][6]).Trim() == "Y" ? true : false;
                chkActive.Visible = true;
                chkActive.Checked = Convert.ToString(grdResult.DataKeys[RowIndex][7]).Trim() == "Y" ? true : false;                
                txtaddres1.Text = grdResult.DataKeys[RowIndex][9].ToString();
                txtciti.Text = grdResult.DataKeys[RowIndex][10].ToString();
                drpCountry.SelectedValue = grdResult.DataKeys[RowIndex][11].ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:loadState();", true);
                hdnStateID.Value = grdResult.DataKeys[RowIndex][12].ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:SetStateID();", true);
                txtEmailID.Text = grdResult.DataKeys[RowIndex][13].ToString();
                txtPhoneNumber.Text = grdResult.DataKeys[RowIndex][14].ToString();
                txtmobileno.Text = grdResult.DataKeys[RowIndex][15].ToString();
                txtfax.Text = grdResult.DataKeys[RowIndex][16].ToString();
                tDOB.Text = grdResult.DataKeys[RowIndex][17].ToString() == "" ? "" : grdResult.DataKeys[RowIndex][17].ToString();
                txtDOBNos.Text = grdResult.DataKeys[RowIndex][18].ToString();
                //syed
                txtDiscountLimit.Text = grdResult.DataKeys[RowIndex][19].ToString();
                if (((System.DateTime)(grdResult.DataKeys[RowIndex][21])).Year != 9999)
                {
                    txtFromPeriod.Text = grdResult.DataKeys[RowIndex][21].ToString() == "01/01/0001 00:00:00" ? "" : grdResult.DataKeys[RowIndex][21].ToString();
                    txtToPeriod.Text = grdResult.DataKeys[RowIndex][22].ToString() == "01/01/0001 00:00:00" ? "" : grdResult.DataKeys[RowIndex][22].ToString();
                }
                else
                {
                    txtFromPeriod.Text = "";
                    txtToPeriod.Text = "";
                }
                if (grdResult.DataKeys[RowIndex][24].ToString() != "")
                {
                    ddlcategory.SelectedItem.Text = grdResult.DataKeys[RowIndex][24].ToString();
                }
                if (grdResult.DataKeys[RowIndex][23].ToString() !="0")
                {
                    ddlFeeCategory.SelectedValue = Convert.ToString(grdResult.DataKeys[RowIndex][23].ToString());
                }


              hdnEmpID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][25]);
              txtPersonName.Text = "";
              if (grdResult.DataKeys[RowIndex][26] != null)
              {
                  txtPersonName.Text = grdResult.DataKeys[RowIndex][26].ToString();
              }
              if (grdResult.DataKeys[RowIndex][27].ToString() != null && grdResult.DataKeys[RowIndex][27].ToString() != "")
              {
                  drplstPerson.SelectedValue = grdResult.DataKeys[RowIndex][27].ToString();
                  AutoCompleteExtender3.ContextKey = grdResult.DataKeys[RowIndex][27].ToString();
              
              }
                
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                btnFinish.Visible = false;
                btnUpdate.Visible = true;
                btnDelete.Visible = true;
                List<Physician> lstphysician = new List<Physician>();
                new AdminReports_BL(base.ContextInfo).GetUserDetailtoManage(Convert.ToInt32(LogID.Value), "a", long.MinValue, OrgID, out lstLogin, out lstLRole, out lstOrgUsers, out lstphysician);
                if (lstOrgUsers.Count != 0)
                {
                    if (txtDrName.Text != "" || txtDrName.Text != null)
                    {
                        txtUserName.Text = txtDrName.Text;
                    }
                    else
                    {
                        txtUserName.Text = lstOrgUsers[0].Name;
                    }
                    if (lstOrgUsers[0].SEX != "")
                    {
                        ddSex.SelectedValue = lstOrgUsers[0].SEX;
                    }
                    else
                    {
                        ddSex.SelectedValue = "0";
                    }
                    hdnUserId.Value = lstOrgUsers[0].OrgUID.ToString();
                    txtUserName.Enabled = false;
                    txtPassword.Enabled = false;
                    chkUserLogin.Checked = true;
                    Login.Style.Add("display", "block");
                }
                else
                {
                    chkUserLogin.Checked = false;
                    Login.Style.Add("display", "none");
                    txtUserName.Text = txtDrName.Text;
                }
                patientBL.GetPhysicianOrgMapping(Convert.ToInt32(hdnReferingPhysicianID.Value), out Pom);
                Session["HidDel"] = "";
                HdnHospitalID.Value = "";
                iconHid.Value = "";
                LoadMeatData();
                ddSex.SelectedValue = Convert.ToString(grdResult.DataKeys[RowIndex][8]).Trim() == "" ? "0" : Convert.ToString(grdResult.DataKeys[RowIndex][8]);
                TabNew.Style.Add("display", "block");
                if (Pom.Count != 0)
                {

                    lblHeader.Attributes.Add("DISPLAY", "block");
                    //btnFinish.Visible = false;
                    BuildTable(Pom);
                    /*int Val = 0;
                    foreach (ListItem p in chklstHsptl.Items)
                    {
                        foreach (PhysicianOrgMapping item in Pom)
                        {
                            PhysicianOrgMapping pom = new PhysicianOrgMapping();//Change ThursDay May 27


                            if (Convert.ToInt32(p.Value) == item.HospitalID)
                            {
                                chklstHsptl.Items[Val].Selected = true;
                                HdnHospitalID.Value += item.HospitalID.ToString() + "^";
                            }
                        }
                        Val++;
                    }*/
                }
               
                    LoadHospitalBranch();
                

            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Physician Details to Change or Remove", ex);
        }
    }
    int count = 0;
    public void BuildTable(List<PhysicianOrgMapping> pom)
    {

        List<TableCell> cells = new List<TableCell>();
        
        // int colCount = 0;
        string rid = string.Empty;
        
        foreach (PhysicianOrgMapping p in pom)
        {
            
            HtmlTableRow row = new HtmlTableRow();
            HtmlTableCell cel = new HtmlTableCell();
            cel.InnerHtml = "<img id='" + p.HospitalID + "' style='cursor:pointer;' OnClick='ImgOnclick(" + p.HospitalID + ");' src='../Images/Delete.jpg' />";
            HtmlTableCell cel1 = new HtmlTableCell();
            cel1.InnerText = Convert.ToString(p.HospitalID);
            cel1.Style.Add("display", "none");
            HtmlTableCell cel2 = new HtmlTableCell();
            cel2.InnerText = p.RefOrgName;
            row.Cells.Add(cel);
            row.Cells.Add(cel1);
            row.Cells.Add(cel2);
            row.ID =p.HospitalID.ToString();
            tblOrederedInves.Rows.Add(row);
            HdnHospitalID.Value += p.HospitalID + "~" + p.RefOrgName + "|";
            HidDel.Value += p.HospitalID + "^";
            Session["HidDel"] = HidDel.Value;
           
        }
        tblOrederedInves.Visible = true;
        count++;

    }



    //private TableCell AddCell(string column, out string rid)
    //{
    //    string colName = column.Split('^')[0];
    //    string colValue = column.Split('^')[1];
    //    TableCell cell = new TableCell();
    //    cell.Attributes.Add("align", "center");

    //    rid = string.Empty;
    //    switch (colName)
    //    {

    //        case "RID":
    //            HyperLink hLnk = new HyperLink();
    //            hLnk.ImageUrl = "~/Images/delete.jpg";
    //            hLnk.NavigateUrl = "javascript:DeleteRow('" + colValue + "','" + did.ClientID + "');";
    //            cell.Width = Unit.Pixel(20);
    //            rid = colValue;
    //            cell.Controls.Add(hLnk);
    //            break;
    //        case "DNAME":
    //            cell.Text = colValue;
    //            break;
    //        case "DFRM":
    //            cell.Text = colValue;
    //            break;
    //        case "ROA":
    //            cell.Text = colValue;
    //            break;
    //        case "DDOSE":
    //            cell.Text = colValue;
    //            break;
    //        case "FRQ":
    //            cell.Text = colValue;
    //            break;
    //        case "DURA":
    //            cell.Text = colValue;
    //            break;
    //    };
    //    return cell;

    //}
    //protected override void Render(HtmlTextWriter writer)
    //{
    //    for (int i = 0; i < this.grdResult.Rows.Count; i++)
    //    {
    //        this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
    //    }
    //    base.Render(writer);
    //}
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
                Label lblName = (Label)e.Row.FindControl("lblLoginName");
                ReferingPhysician rp = (ReferingPhysician)e.Row.DataItem;
                if (rp.LoginName == null)
                {
                    //LinkButton lnkAccess = (LinkButton)e.Row.FindControl("lnkAccess");
                    LinkButton lnkReset = (LinkButton)e.Row.FindControl("lnkReset");
                    lnkReset.Enabled = false;
                    //lnkAccess.Enabled = false;
                }
                //if (lblName.Text == "")
                //{
                //    LinkButton lnkAccess = (LinkButton)e.Row.FindControl("lnkAccess");
                //    LinkButton lnkReset = (LinkButton)e.Row.FindControl("lnkReset");
                //    lnkReset.Enabled = false;
                //    lnkAccess.Enabled = false;
 
                //}
                //if (lblName.Text == "")
                //{
                //    LinkButton lnkAccess = (LinkButton)e.Row.FindControl("lnkAccess");
                //    LinkButton lnkReset = (LinkButton)e.Row.FindControl("lnkReset");
                //    lnkReset.Enabled = false;
                //    lnkAccess.Enabled = false;

                //}
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Physician Details to Change or Remove", ex);
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

    public List<AddressDetails> GetRefPhyAddressDetails()
    {
        List<AddressDetails> lstAddDetails = new List<AddressDetails>();
        AddressDetails objAddressDetails = new AddressDetails();
        objAddressDetails.ReferenceID = hdnReferingPhysicianID.Value == "" ? -1 : Convert.ToInt64(hdnReferingPhysicianID.Value);
        objAddressDetails.Address1 = txtaddres1.Text == "" ? "" : txtaddres1.Text;
        objAddressDetails.City = txtciti.Text == "" ? "" : txtciti.Text;
        objAddressDetails.CountryID = Convert.ToInt32(drpCountry.SelectedValue);
        objAddressDetails.StateID = Convert.ToInt32(hdnStateID.Value) == 0 ? Convert.ToInt32(drpState.SelectedValue) : Convert.ToInt32(hdnStateID.Value);
        objAddressDetails.EmailID = txtEmailID.Text == "" ? "" : txtEmailID.Text;
        objAddressDetails.Phone = txtPhoneNumber.Text == "" ? "" : txtPhoneNumber.Text;
        objAddressDetails.Mobile = txtmobileno.Text == "" ? "" : txtmobileno.Text;
        objAddressDetails.FaxNumber = txtfax.Text == "" ? "" : txtfax.Text;

        objAddressDetails.IsCommunication = chkActive.Checked ? "Y" : "N";
        //objAddressDetails.IsCommunication = hdnsms.Value;

       // objReferingPhysician.IsActive = chkActive.Checked ? "Y" : "N";
            
        lstAddDetails.Add(objAddressDetails);
        return lstAddDetails;
    }

    private void LoadTitle()
    {
        string strddSalutation = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_03 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_03;  
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

                ddSalutation.Items.Insert(0, strddSalutation);
                //ddSalutation.Items.Insert(0, "--Select--");
                ddSalutation.Items[0].Value = "0";

                selectedSalutation = titles.Find(Findsalutation);
                if (selectedSalutation != null)
                {
                    ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
                }
             //   ddSalutation.SelectedValue = "0";
                Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);

            }
            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
               // ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading Salutation in Patient Sample Registration.Message:", ex);
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (!String.IsNullOrEmpty(s.TitleName) )
        { 
            if (s.TitleName.ToUpper().Trim() == "DR.")
            {
                return true;
            }
        }
        return false;
    }
    long LoginID = 0;
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
                //ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Login " + txtUserName.Text.ToString() + " Already Exist";

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

    public void LoadMeatData()
    {
        string strddSex = Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_03 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_SaveLabRefPhysicianDetails_aspx_03;  
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,Department";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender" && child.Code !="B"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddSex.DataSource = childItems1;
                    ddSex.DataTextField = "DisplayText";
                    ddSex.DataValueField = "Code";
                    ddSex.DataBind();
                    ddSex.Items.Insert(0, strddSex);
                    //ddSex.Items.Insert(0, "--Select--");
                    ddSex.Items[0].Value = "0";                    
                }

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "Department"
                                  orderby child.MetaDataID ascending
                                  select child;
                string temp = string.Empty;
                foreach (var child in childItems2)
                {
                    temp += child.DisplayText + "~" + child.Code + "^";
                }
                if (!String.IsNullOrEmpty(temp) && temp.Length > 0)
                {
                    hdnAddDepart.Value = temp;
                    ViewState.Add("AddDepartment", temp);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading gender", ex);
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

    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        drpCountry.Items.Clear();
        int countryID = 0;
        try
        {
            //lblCountryCode
            returnCode = countryBL.GetCountryList(out countries);
            drpCountry.DataSource = countries;
            drpCountry.DataTextField = "CountryName";
            drpCountry.DataValueField = "CountryID";
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, "--Select--");
            #region Get the Country using isDefault
            selectedCountry = countries.Find(FindCountry);
            CountryID =Convert.ToInt16(selectedCountry.CountryID);
            drpCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(drpCountry.SelectedItem.Value, out countryID);
            #endregion
            #region Set the Country by location's country
            if (CountryID > 0)
            {
                drpCountry.SelectedValue = CountryID.ToString();
                countryID = CountryID;
            }

            #endregion
            LoadState(countryID);
            var childItems = (from n in countries
                              where n.IsDefault == "Y"
                              select new { n.CountryID, n.ISDCode }).ToList();
            if (childItems.Count() > 0)
            {
                hdnCountryID.Value = childItems[0].CountryID.ToString();                
                lblCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
            }
            

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }

    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        drpState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);

            foreach (State st in states)
            {
                drpState.Items.Add(new ListItem(st.StateName.ToUpper(), st.StateID.ToString()));
            }
            if (StateID > 0)
            {
                drpState.SelectedValue = StateID.ToString();
            }
            selectedState = states.Find(FindState);
            drpState.SelectedValue = selectedState.StateID.ToString();
            Int32.TryParse(drpState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }  

    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    public void ClearFunction()
    {
        txtaddres1.Text = "";
        txtciti.Text = "";
        txtEmailID.Text = "";
        txtmobileno.Text = "";
        txtPhoneNumber.Text = "";
        txtfax.Text = "";
        txtDrOrganization.Text = "";
        txtDOBNos.Text = "";
        tDOB.Text = "";
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
    protected void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            loaddgridForExcel();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }

    }



    public void loaddgridForExcel()
    {
        try
        {


            //string  = string.Empty;
            List<AddressDetails> lstRefPhyAddressDetails = new List<AddressDetails>();
            long PhysicianRoleId = -1;
            int pRefPhyID = -1;
            List<PhysicianOrgMapping> pomList = new List<PhysicianOrgMapping>();
            List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
            string[] ht = new string[5];
            string phyname;
            if (physicianName.Contains("."))
            {
                ht = physicianName.Split('.');
                phyname = ht[1].ToString();
            }
            else
            {
                phyname = physicianName;
            }

            //string OrgType = "COrg";
            ContextInfo.AdditionalInfo = "Y";

            returnCode = patientBL.GetReferingPhysician(OrgID, phyname, "", out lstReferingPhysician);
            //DataTable table = ConvertListToDataTable(lstReferingPhysician);
            //DataTable table = (DataTable)ViewState["excel"];
            //if (table.Rows.Count > 0)
            //{

            grdResult.DataSource = lstReferingPhysician;
            grdResult.AllowPaging = false;
            
            grdResult.DataBind();
                ExportToExcel2();
            //}
        }
        catch (Exception ee)
        {

            throw ee;
        }

    }
    //static DataTable ConvertListToDataTable(List<ReferingPhysician> lstReferingPhysician)
    //{
    //    DataTable dt = new DataTable();
    //    DataColumn dcol1 = new DataColumn("PhysicianName");
    //    DataColumn dcol2 = new DataColumn("Qualification");
    //    DataColumn dcol3 = new DataColumn("PhysicianCode");
    //    DataColumn dcol4 = new DataColumn("OrganizationName");
    //    DataColumn dcol5 = new DataColumn("LoginName");
    //    DataColumn dcol6 = new DataColumn("ReferingPhysicianID");
    //    DataColumn dcol7 = new DataColumn("IsClient");
    //    DataColumn dcol8 = new DataColumn("IsActive");
    //    DataColumn dcol9 = new DataColumn("Gender");
    //    DataColumn dco20 = new DataColumn("Address1");
    //    dt.Columns.Add(dcol1);
    //    dt.Columns.Add(dcol2);
    //    dt.Columns.Add(dcol3);
    //    dt.Columns.Add(dcol4);
    //    dt.Columns.Add(dcol5);
    //    dt.Columns.Add(dcol6);
    //    dt.Columns.Add(dcol7);
    //    dt.Columns.Add(dcol8);
    //    dt.Columns.Add(dcol9);
    //    dt.Columns.Add(dco20);
    //    foreach (var item in lstReferingPhysician)
    //    {
    //        var row = dt.NewRow();
    //        row["PhysicianName"] = item.PhysicianName;
    //        row["Qualification"] = item.Qualification;
    //        row["PhysicianCode"] = item.PhysicianCode;
    //        row["OrganizationName"] = item.OrganizationName;
    //        row["LoginName"] = item.LoginName;
    //        row["ReferingPhysicianID"] = item.ReferingPhysicianID;
    //        row["IsClient"] = item.IsClient;
    //        row["IsActive"] = item.IsActive;
    //        row["Gender"] = item.Gender;
    //        row["Gender"] = item.Address1;
    //        dt.Rows.Add(row);
    //    }

    //    return dt;
    //}


    public void ExportToExcel2()
    {

        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string attachment = "attachment; filename=" + "ManagePhysician" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            PrepareExcelSheet();
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdResult.Visible = true;
            grdResult.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();


        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }
    private void PrepareExcelSheet()
    {
        try
        {
            grdResult.HeaderRow.Cells[grdResult.Columns.Count - 1].Visible = false;
            for (int i = 0; i < grdResult.Rows.Count; i++)
            {
                grdResult.Rows[i].Cells[grdResult.Columns.Count - 1].Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }



}
