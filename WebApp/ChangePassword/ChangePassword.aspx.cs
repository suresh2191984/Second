using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.DAL;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Kernel.PlatForm.Base;


public partial class ChangePassword : BasePage //System.Web.UI.Page
{

    public ChangePassword()
        : base("ChangePassword_ChangePassword_aspx")
    {
    }
    // protected void page_Init(object sender, EventArgs e)
    // {
    //     base.page_Init(sender, e);
    // }
    List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
    List<Login_HIST> LHist = new List<Login_HIST>();
    string TransPass = string.Empty;
    string newTransPassword = string.Empty;
    string URL = string.Empty;
    string RedirectURL = string.Empty;
    string AccessPwd = string.Empty;
    string oldtransPassword = string.Empty;
    long returnCode = -1;
    int count = 0;
    int failcount = 0;
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    DateTime TransationPasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    protected void Page_Load(object sender, EventArgs e)
    {
       // ErrorDisplay3.ShowError = false;
        TransPass = GetConfigValue("PasswordAuthentication", OrgID);
        //btnChange.Attributes.Add("onclick", "TextboxValidation()");
        Loadpwdplcycount();
        LoadExpiryDate();
        if (!IsPostBack)
        {
            ModalPopupExtender2.Hide();
            ViewState["PreviousPage"] = Request.UrlReferrer;

            if (Request.QueryString["URL"] != null && Request.QueryString.Count > 0)
            {
                ModalPopupExtender1.Show();
                divAccess.Style.Add("display", "block");
                divTpwd.Style.Add("display", "none");
                DivLpwd.Style.Add("display", "none");
                btnChange.Style.Add("display", "none");
                btnCancel.Style.Add("display", "none");
                btnupdate.Style.Add("display", "none");
                btnclose.Style.Add("display", "none");
                txtAccesspwd.Focus();
            }

            else
            {

                if (!String.IsNullOrEmpty(TransPass) && TransPass.Length > 0)
                {
                    if (TransPass == "Y")
                    {
                        ModalPopupExtender1.Hide();
                        divTpwd.Style.Add("display", "block");
                        DivLpwd.Style.Add("display", "block");
                        btnChange.Style.Add("display", "none");
                        btnCancel.Style.Add("display", "none");
                    }
                    else
                    {
                        ModalPopupExtender1.Hide();
                        //divTpwd.Style.Add("display", "block");
                        DivLpwd.Style.Add("display", "block");
                        btnChange.Style.Add("display", "block");
                        btnCancel.Style.Add("display", "block");
                        btnupdate.Style.Add("display", "none");
                        btnclose.Style.Add("display", "none");
                    }
                }
                else
                {
                    ModalPopupExtender1.Hide();
                    DivLpwd.Style.Add("display", "block");
                    divTpwd.Style.Add("display", "none");
                    btnChange.Style.Add("display", "block");
                    btnCancel.Style.Add("display", "block");
                    btnupdate.Style.Add("display", "none");
                    btnclose.Style.Add("display", "none");

                }
            }
            txtOldpassword.Focus();
           // ErrorDisplay1.Status = "";
          //  ErrorDisplay2.Status = "";
          //ErrorDisplay3.Status = "";
            //imgLogo.Src = LogoPath.Split('/')[1] + "/" + LogoPath.Split('/')[2] + "/" + LogoPath.Split('/')[3];
            string Cdisplayname = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_01;
            //if (RoleName == "Physician")
            if (RoleName == Cdisplayname)
            {
                //phyHeader.Visible = true;
               // Header1.Visible = false;
                //PatientHeader1.Visible = false;
            }
            else if (RoleName != RoleHelper.Physician && RoleName != RoleHelper.Patient)
            {
               // Header1.Visible = true;
               // phyHeader.Visible = false;
              //  PatientHeader1.Visible = false;
            }
            else if (RoleName == RoleHelper.Patient)
            {
                //Header1.Visible = false;
                //phyHeader.Visible = false;
            }

           // ErrorDisplay1.ShowError = false;
            if (Request.QueryString["ILF"] != null)
            {
                string lblmsg = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_06;
                string str = lblmsg;
                lblMsg.Visible = true;
                lblMsg.Text = str;

            }
        }
        else
        {
            ModalPopupExtender1.Show();
        }
    }

    #region gettotaldays
    //TimeSpan timespan = Convert.ToDateTime("2012-06-27").Subtract(Convert.ToDateTime("2012-05-01"));
    //int result = timespan.Days;
    #endregion


    public void Loadpwdplcycount()
    {
        long returncode = -1;
        int count = -1;
        int Tcount = -1;
        List<PasswordPolicy> lstpwdplcy = new List<PasswordPolicy>();
        returncode = new Users_BL(base.ContextInfo).GetPasswordPolicytotalCount(OrgID, out count, out Tcount);

        hdnpwdplcycount.Value = count.ToString();
        hdntranspwdplcycount.Value = Tcount.ToString();

        if (hdnpwdplcycount.Value != "0" && hdntranspwdplcycount.Value != "0")
        {
            trplcy.Style.Add("display", "table-row");
            transplcy.Style.Add("display", "table-row");
            LoadTable(lstpwdplcy);

        }
        else if (hdnpwdplcycount.Value != "0")
        {
            trplcy.Style.Add("display", "table-row");
            transplcy.Style.Add("display", "none");
            LoadTable(lstpwdplcy);
        }
        else if (hdntranspwdplcycount.Value != "0")
        {
            trplcy.Style.Add("display", "none");
            transplcy.Style.Add("display", "table-row");
            LoadTable(lstpwdplcy);

        }

        else
        {
            LoadTable(lstpwdplcy);
            trplcy.Style.Add("display", "none");
            transplcy.Style.Add("display", "none");

        }



    }

    public void LoadExpiryDate()
    {
        long Returncode = -1;

        List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
        List<PasswordPolicy> Transpwdplcy = new List<PasswordPolicy>();
        Returncode = new Users_BL(base.ContextInfo).GetPasswordValidityPeriod(OrgID, out pwdplcy, out Transpwdplcy);
        string CdisplayDays = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_02;
        string Cdisplayweeks = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_03;
        string CdisplayMonths = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_04;
        string CdisplayYears = Resources.ChangePassword_ClientDisplay.ChangePassword_aspx_05;
        if (pwdplcy.Count > 0)
        {
          
//            if (pwdplcy[0].ValidityPeriodType == "Days")
            if (pwdplcy[0].ValidityPeriodType == CdisplayDays)
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddDays(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == Cdisplayweeks)
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddDays((pwdplcy[0].ValidityPeriod) * 7);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == CdisplayMonths)
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime expiryDate = startdate.AddMonths(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (pwdplcy[0].ValidityPeriodType == CdisplayYears)
            {
                DateTime startdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime expiryDate = startdate.AddYears(pwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
        }
        if (Transpwdplcy.Count > 0)
        {
            if (Transpwdplcy[0].ValidityPeriodType == CdisplayDays)
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddDays(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == Cdisplayweeks)
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddDays((Transpwdplcy[0].ValidityPeriod) * 7);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();
            }
            else if (Transpwdplcy[0].ValidityPeriodType == CdisplayMonths)
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime transexpiryDate = transstartdate.AddMonths(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == CdisplayYears)
            {
                DateTime transstartdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime transexpiryDate = transstartdate.AddYears(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }

        }




    }

    public void LoadTable(List<PasswordPolicy> lstpwdplcy)
    {
        try
        {
            long returncode = -1;
            returncode = new Users_BL(base.ContextInfo).GetPasswordpolicy(OrgID, out lstpwdplcy);

            if (lstpwdplcy.Count > 0)
            {
                foreach (PasswordPolicy objPP in lstpwdplcy)
                {
                    hdnRecords.Value += objPP.Type + "~" + objPP.PasswordLength + "~" + objPP.Splcharlen + "~" + objPP.Numcharlen + "~" + objPP.ValidityPeriodType + "~" + objPP.ValidityPeriod + "~" + objPP.PreviousPwdcount + "~" + objPP.Id + "^";
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "IsDefault", "binddata();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPasswordPolicy", ex);
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
    protected void btnChange_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnpwdplcycount.Value != "0")
            {
                long returnpwd = -1;
                long returncode = -1;
                string oldPassword = string.Empty;
                string newPassword = string.Empty;
                oldPassword = txtOldpassword.Text;
                newPassword = txtNewpassword.Text;

                string strEncOldPwd = string.Empty;
                string strEncNewPwd = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (oldPassword != "")
                {
                    obj.Crypt(oldPassword, out strEncOldPwd);
                }
                oldPassword = strEncOldPwd;
                obj.Crypt(newPassword, out strEncNewPwd);
                newPassword = strEncNewPwd;
                int result = -1;


                Users_BL UsersBL = new Users_BL(base.ContextInfo);
                List<Login_HIST> LHist = new List<Login_HIST>();
                returnpwd = new Users_BL(base.ContextInfo).Checkpreviouspassword(LID, OrgID, newPassword, out result);

                if (result != 0)
                {
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();

                    string sPath = Resources.ChangePassword_AppMsg.ChangePassword_aspx_001 == null ? "Given Password Already Exist" : Resources.ChangePassword_AppMsg.ChangePassword_aspx_001;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Password Already Exist');", true);
                    txtOldpassword.Focus();
                    return;

                }

                if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                {
                    PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);



                }



                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);

                if (returncode >= 0)
                {
                    //ErrorDisplay1.ShowError = false;
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();




                }
                else
                {
                    //ErrorDisplay1.ShowError = true;
                   // ErrorDisplay1.Status = "Password Updation Failed";
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();

                }

            }
            else
            {
                long returncode = -1;
                string oldPassword = string.Empty;
                string newPassword = string.Empty;
                oldPassword = txtOldpassword.Text;
                newPassword = txtNewpassword.Text;

                string strEncOldPwd = string.Empty;
                string strEncNewPwd = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (oldPassword != "")
                {
                    obj.Crypt(oldPassword, out strEncOldPwd);
                }
                oldPassword = strEncOldPwd;
                obj.Crypt(newPassword, out strEncNewPwd);
                newPassword = strEncNewPwd;

                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);

                if (returncode >= 0)
                {
                  //  ErrorDisplay1.ShowError = false;
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();
                    btnpopClose.Attributes.Add("autofocus", "");
                    btnpopClose.TabIndex = 0;
                        
                  
                }
                else
                {
                  //  ErrorDisplay1.ShowError = true;
                   // ErrorDisplay1.Status = "Password Updation Failed";
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                }

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Update Password", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
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

    protected void btnupdate_Click(object sender, EventArgs e)
    {

        try
        {
            if (hdnpwdplcycount.Value != "0")
            {
                long returnpwd = -1;
                long returncode = -1;
                int result = -1;
                string oldPassword = string.Empty;
                string newPassword = string.Empty;
                oldPassword = txtOldpassword.Text;
                newPassword = txtNewpassword.Text;

                string strEncOldPwd = string.Empty;
                string strEncNewPwd = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (oldPassword != "")
                {
                    obj.Crypt(oldPassword, out strEncOldPwd);
                }
                oldPassword = strEncOldPwd;
                Attune.Cryptography.CCryptography obj2 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (newPassword != "")
                {
                    obj2.Crypt(newPassword, out strEncNewPwd);
                }
                newPassword = strEncNewPwd;

                Users_BL UsersBL = new Users_BL(base.ContextInfo);
                List<Login_HIST> LHist = new List<Login_HIST>();
                returnpwd = new Users_BL(base.ContextInfo).Checkpreviouspassword(LID, OrgID, newPassword, out result);

                if (result != 0)
                {
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    string sPath = "ChangePassword\\\\ChangePassword.aspx_3";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Password Already Exist');", true);
                    txtOldpassword.Focus();
                    return;

                }



                if (TransPass == "Y")
                {

                    string strEncNewTransPwd = string.Empty;
                    oldtransPassword = Txtoldtranspwd.Text;
                    newTransPassword = TxtNewtranspwd.Text;
                    string strEncOldtransPwd = string.Empty;
                    Attune.Cryptography.CCryptography obj1 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    if (oldtransPassword != "")
                    {
                        obj1.Crypt(oldtransPassword, out strEncOldtransPwd);
                    }
                    oldtransPassword = strEncOldtransPwd;
                    Attune.Cryptography.CCryptography obj4 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    if (newTransPassword != "")
                    {
                        obj4.Crypt(newTransPassword, out strEncNewTransPwd);
                        newTransPassword = strEncNewTransPwd;
                    }
                    if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                    {
                        PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);



                    }
                    if (hdntranspwdexpdate.Value != "" && hdntranspwdexpdate.Value != null)
                    {
                        TransationPasswordExpiryDate = Convert.ToDateTime(hdntranspwdexpdate.Value);


                    }
                    long transreturnpwd = -1;
                    int transresult = -1;
                    transreturnpwd = new Users_BL(base.ContextInfo).Checkprevioustransactionpassword(LID, OrgID, newTransPassword, out transresult);

                    if (transresult != 0)
                    {
                        ModalPopupExtender1.Hide();
                        ModalPopupExtender2.Hide();

                        string sPath = "ChangePassword\\\\ChangePassword.aspx_4";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "ShowAlertMsg('" + sPath + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Transaction Password Already Exist');", true);

                        txtOldpassword.Focus();
                        return;

                    }


                }



                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);
                ModalPopupExtender1.Hide();
                if (returncode >= 0)
                {
                    //ErrorDisplay1.ShowError = false;
                  //  ErrorDisplay2.ShowError = false;
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();


                }
                else
                {
                   // ErrorDisplay1.ShowError = true;
                   // ErrorDisplay1.Status = "Password Updation Failed";
                   // ErrorDisplay2.ShowError = true;
                  //  ErrorDisplay2.Status = "Transaction Password Updation Failed";
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                }

                ModalPopupExtender1.Hide();
                ModalPopupExtender2.Hide();
            }
            else
            {
                long returncode = -1;
                string oldPassword = string.Empty;
                string newPassword = string.Empty;
                oldPassword = txtOldpassword.Text;
                newPassword = txtNewpassword.Text;

                string strEncOldPwd = string.Empty;
                string strEncNewPwd = string.Empty;
                Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (oldPassword != "")
                {
                    obj.Crypt(oldPassword, out strEncOldPwd);
                }
                oldPassword = strEncOldPwd;
                Attune.Cryptography.CCryptography obj2 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                if (newPassword != "")
                {
                    obj2.Crypt(newPassword, out strEncNewPwd);
                }
                newPassword = strEncNewPwd;

                if (TransPass == "Y")
                {

                    string strEncNewTransPwd = string.Empty;
                    oldtransPassword = Txtoldtranspwd.Text;
                    newTransPassword = TxtNewtranspwd.Text;
                    string strEncOldtransPwd = string.Empty;
                    Attune.Cryptography.CCryptography obj1 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    if (oldtransPassword != "")
                    {
                        obj1.Crypt(oldtransPassword, out strEncOldtransPwd);
                    }
                    oldtransPassword = strEncOldtransPwd;
                    Attune.Cryptography.CCryptography obj4 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    if (newTransPassword != "")
                    {
                        obj4.Crypt(newTransPassword, out strEncNewTransPwd);
                        newTransPassword = strEncNewTransPwd;
                    }



                }

                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);

                if (returncode >= 0)
                {
                   // ErrorDisplay1.ShowError = false;
                   // ErrorDisplay2.ShowError = false;
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();
                }
                else
                {
                   // ErrorDisplay1.ShowError = true;
                   // ErrorDisplay1.Status = "Password Updation Failed";
                    //ErrorDisplay2.ShowError = true;
                   // ErrorDisplay2.Status = "Transaction Password Updation Failed";
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Update Password", ex);
        }
    }
    protected void btnclose_Click(object sender, EventArgs e)
    {
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
    protected void btngo_Click(object sender, EventArgs e)
    {
        ModalPopupExtender2.Hide();
        long ReturnCode = -1;
        AccessPwd = txtAccesspwd.Text;
        string AccessPwdOutput = string.Empty;
        string strEncAccessPwd = string.Empty;
        Attune.Cryptography.CCryptography obj2 = new Attune.Cryptography.CCryptFactory().GetEncryptor();
        if (AccessPwd != "")
        {
            obj2.Crypt(AccessPwd, out strEncAccessPwd);
            AccessPwd = strEncAccessPwd;

            ReturnCode = new GateWay(base.ContextInfo).CheckTransPassword(LID, AccessPwd, out AccessPwdOutput);


            if (AccessPwd == AccessPwdOutput)
            {
                URL = Request.QueryString["URL"];
                RedirectURL = URL.Replace("'", "").Replace("^", "&");
                Response.Redirect(RedirectURL);

            }
            else
            {
                ModalPopupExtender1.Show();
                ModalPopupExtender2.Hide();

                //ErrorDisplay3.ShowError = true;
               // ErrorDisplay3.Status = "Transaction Password Incorrect";

            }



        }





    }

    protected void btncancelclose_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(ViewState["PreviousPage"].ToString());
    }

    protected void btnpopClose_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
        try
        {
            //ErrorDisplay1.ShowError = false;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            string RedirectPath = Request.ApplicationPath + path;
            Response.Redirect(RedirectPath);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

}
