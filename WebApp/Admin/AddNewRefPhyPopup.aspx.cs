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

public partial class Admin_AddNewRefPhyPopup : BasePage
{
    long returnCode = -1;
    int mode = 0;
    Patient_BL patientBL;
    List<ReferingPhysician> lstReferingPhysician = new List<ReferingPhysician>();
    ReferingPhysician objReferingPhysician = new ReferingPhysician();
    string physicianName = string.Empty;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    string RoleId = "";
    string TransPass = string.Empty;
    string oldtransPassword = string.Empty;
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    DateTime TransationPasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            roleBL = new Role_BL(base.ContextInfo);
            patientBL = new Patient_BL(base.ContextInfo);
            lblStatus.Text = "";
            lblLoginName.Text = "";
            chkUserLogin.Attributes.Add("onclick", "ShowLogin(this)");
            physicianName = txtSearchPhysicianName.Text;
            AutoRname.ContextKey = "N";
            LoadExpiryDate();
            if (Request.QueryString["mode"] != null)
            {
                Int32.TryParse(Request.QueryString["mode"], out mode);
                if (mode == 1) Panel7.Visible = false;
                ltHead.Text = "Enter the details of new Physician";
                btnFinish.Visible = true;
                btnpnCancel.Visible = false;

            }
            else
            {
                TabNew.Style.Add("display", "none");
                btnFinish.Visible = false;
            }
            if (!IsPostBack)
            {
                LoadHospitalBranch();
                LoadTitle();
                LoadReferingPhysician();
               
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in SaveLabRefPhysicianDetails.aspx:Page_Load", ex);
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
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        int pRefPhyID = -1;
        try
        {
            if (chkUserLogin.Checked == true)
                SaveLoginDetails();
            btnFinish.Visible = false;
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
            long PhysicianRoleId = 0;
            returnCode = patientBL.SaveReferingPhysician(objReferingPhysician, lstRefPhyAddressDetails, pomList, Convert.ToInt16(LoginID), out pRefPhyID, out lstReferingPhysician, out PhysicianRoleId);
            if (returnCode == 0)
            {
                LoadReferingPhysician();
                iconHid.Value = "";
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                lblStatus.Text = "New Refering Physician Added Successfully!";
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                Panel7.Visible = true;
                ddSex.SelectedValue = "0";
                ddSalutation.SelectedValue = "0";
                ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Changes saved successfully.');", true);
                LoadHospitalBranch();
                Session["HidDel"] = "";

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

    public void LoadReferingPhysician()
    {
        hdnSetRefValues.Value = "0~-----Select-----^";
        List<Physician> lstPhysician = new List<Physician>();
        new PatientVisit_BL(base.ContextInfo).GetInternalExternalPhysician(OrgID, out lstPhysician, out lstReferingPhysician);
        foreach (ReferingPhysician items in lstReferingPhysician)
        {
            hdnSetRefValues.Value += items.ReferingPhysicianID + "~" + items.PhysicianName + "^";
        }
    }


    List<PhysicianOrgMapping> pomCopy = new List<PhysicianOrgMapping>();
    string Deleted = "";//Change ThursDay May 27
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
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
                    lblStatus.Text = "<h5>Successfully Created For LoginName: " + LoginName + " & Password :" + strPass + " </h5>";
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
                    eUsers.DOB = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                    eUsers.WeddingDt = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
                    eUsers.TitleCode = ddSalutation.SelectedValue;
                    new AdminReports_BL(base.ContextInfo).UpdateUserDetails(eUsers, ModifiedBy);

                    LoginCheckdetails.GetLoginUserName(Convert.ToInt32(LogID.Value), out LoginName, out strPass, out TransPass);
                    lblStatus.Text = "<h5>Successfully Updated For LoginName: " + LoginName + " & Password :" + strPass + " </h5>";
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
            objReferingPhysician.LoginID = LogID.Value == "0" ? Convert.ToInt32(LoginID) : Convert.ToInt32(LogID.Value);
            objReferingPhysician.Salutation = Convert.ToInt32(ddSalutation.SelectedValue);
            //pom= GetHptlsList(objReferingPhysician.ReferingPhysicianID);

            string HoID = HidDel.Value != "" ? HidDel.Value : Session["HidDel"].ToString();
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
            returnCode = patientBL.UpdateReferingPhysician(objReferingPhysician, lstRefPhyAddresDetails, pomList, Deleted);

            if (returnCode == 0)
            {
                HdnHospitalID.Value = "";//Change ThursDay May 27
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                // if (chkUserLogin.Checked == false)
                // lblStatus.Text = "Refering Physician Changes Saved Successfully!";
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = false;
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
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Changes saved successfully.');", true);//Change ThursDay May 27
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Refering Physician Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        LoadReferingPhysician();
        #endregion
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            objReferingPhysician.ReferingPhysicianID = Convert.ToInt32(hdnReferingPhysicianID.Value);
            objReferingPhysician.Status = "D";
            objReferingPhysician.OrgID = OrgID;
            List<AddressDetails> lstRefPhyAddresDetails = new List<AddressDetails>();
            returnCode = patientBL.UpdateReferingPhysician(objReferingPhysician, lstRefPhyAddresDetails, pomCopy, Deleted);
            if (returnCode == 0)
            {
                txtDrName.Text = "";
                txtDrOrganization.Text = "";
                txtDrQualification.Text = "";
                txtSearchPhysicianName.Text = "";
                grdResult.Visible = false;
                lblStatus.Visible = true;
                lblStatus.Text = "Refering Physician Removed Successfully!";
                btnUpdate.Visible = false;
                btnDelete.Visible = false;
                btnFinish.Visible = true;
                ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
                Panel7.Visible = true;
                LoadHospitalBranch();
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Removing Refering Physician Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
        LoadReferingPhysician();
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            
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
            grdResult.PageIndex = e.NewPageIndex;
            patientBL.GetReferingPhysician(OrgID, physicianName, "", out lstReferingPhysician);
            if (lstReferingPhysician.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstReferingPhysician;
                grdResult.DataBind();

            }
        }
    }
    
    protected void addNewPhysician_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.RawUrl+ "&mode=1", true);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
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
        patientBL.GetReferingPhysician(OrgID, phyname, "", out lstReferingPhysician);
        //patientBL.GetReferingPhysician(OrgID, physicianName, "", out lstReferingPhysician);
        if (lstReferingPhysician.Count > 0)
        {
            TabNew.Style.Add("display", "none");
            grdResult.Visible = true;
            grdResult.DataSource = lstReferingPhysician;
            grdResult.DataBind();
            lblStatus.Visible = false;
        }
        else
        {
            lblStatus.Visible = true;
            grdResult.Visible = false;
            lblStatus.Text = "No Matching Records Found!";
        }
        ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
        Panel7.Visible = true;
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            chkUserLogin.Checked = false;
            Login.Style.Add("display", "none");
            List<Attune.Podium.BusinessEntities.Login> lstLogin = new List<Attune.Podium.BusinessEntities.Login>();
            List<PhysicianOrgMapping> Pom = new List<PhysicianOrgMapping>();
            List<Role> lstLRole = new List<Role>();
            List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
            ltHead.Text = "Search for existing Physician details or click on Add New Physician.";
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
                returnCode = new GateWay(base.ContextInfo).ChangePassword(Convert.ToInt64(grdResult.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString()), "",oldtransPassword, Name, newtransPwd,PasswordExpiryDate,TransationPasswordExpiryDate);
                if (returnCode != -1)
                {
                    string DecryptedString = string.Empty;
                    Attune.Cryptography.CCryptography objDecryptor = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                    objDecryptor.Crypt(Name, out DecryptedString);

                    lblStatus.Visible = true;
                    lblStatus.Text = "LoginName : " + Name + " &nbsp; Password :  " + Name;
                    lblStatus.Font.Bold = true;
                }
            }
            if (e.CommandName == "Select")
            {


                int RowIndex = Convert.ToInt32(e.CommandArgument);
                Label lblId = (Label)grdResult.Rows[RowIndex].FindControl("lblLoginId");
                Label lblStn = (Label)grdResult.Rows[RowIndex].FindControl("lblSalutation");
                hdnReferingPhysicianID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                LogID.Value = lblId.Text;
                if (LogID.Value != "")
                    chkUserLogin.Enabled = false;
                ddSalutation.SelectedValue = lblStn.Text;
                txtDrName.Text = Convert.ToString(grdResult.DataKeys[RowIndex][1]);
                txtDrQualification.Text = Convert.ToString(grdResult.DataKeys[RowIndex][2]);
                txtDrOrganization.Text = Convert.ToString(grdResult.DataKeys[RowIndex][3]);
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                btnFinish.Visible = false;
                btnUpdate.Visible = true;
                btnDelete.Visible = true;
                List<Physician> lstphysician = new List<Physician>();
                new AdminReports_BL(base.ContextInfo).GetUserDetailtoManage(Convert.ToInt32(LogID.Value), "a", long.MinValue, OrgID, out lstLogin, out lstLRole, out lstOrgUsers, out lstphysician);
                if (lstOrgUsers.Count != 0)
                {
                    txtUserName.Text = lstOrgUsers[0].Name;
                    ddSex.SelectedValue = lstOrgUsers[0].SEX;
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
            row.ID = p.HospitalID.ToString();
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
                ddSalutation.Items.Insert(0, "--Select--");
                ddSalutation.Items[0].Value = "0";

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
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
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

}
