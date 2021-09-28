using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.FuzzyString;

public partial class ChangePassword : Attune_BasePage
{

    public ChangePassword()
        : base("UserSettings_ChangePassword_aspx")
    {
    }
    // protected void page_Init(object sender, EventArgs e)
    // {
    //     base.page_Init(sender, e);
    // }
    List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
    //List<Login_HIST> LHist = new List<Login_HIST>();
    string TransPass = string.Empty;
    string newTransPassword = string.Empty;
    string URL = string.Empty;
    string RedirectURL = string.Empty;
    string AccessPwd = string.Empty;
    string oldtransPassword = string.Empty;
    long returnCode = -1;
    //    int count = 0;
    //    int failcount = 0;
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    DateTime TransationPasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    protected void Page_Load(object sender, EventArgs e)
    {

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
                divAccess.Attributes.Add("class", "show");
                divTpwd.Attributes.Add("class", "hide");
                DivLpwd.Attributes.Add("class", "hide");
                btnChange.Attributes.Add("class", "hide");
                btnCancel.Attributes.Add("class", "hide");
                btnupdate.Attributes.Add("class", "hide");
                btnclose.Attributes.Add("class", "hide");
                txtAccesspwd.Focus();
            }

            else
            {

                if (!String.IsNullOrEmpty(TransPass) && TransPass.Length > 0)
                {
                    if (TransPass == "Y")
                    {
                        ModalPopupExtender1.Hide();
                        divTpwd.Attributes.Add("class", "show");
                        DivLpwd.Attributes.Add("class", "show w-30p marginauto card-Bg-Grey padding20");
                        btnChange.Attributes.Add("class", "hide");
                        btnCancel.Attributes.Add("class", "hide");
                    }
                    else
                    {
                        ModalPopupExtender1.Hide();
                        //divTpwd.Attributes .Add("class", "show");
                        DivLpwd.Attributes.Add("class", "show w-30p marginauto card-Bg-Grey padding20");
                        btnChange.Attributes.Add("class", "btn show");
                        btnCancel.Attributes.Add("class", "show");
                        btnupdate.Attributes.Add("class", "hide");
                        btnclose.Attributes.Add("class", "hide");
                    }
                }
                else
                {
                    ModalPopupExtender1.Hide();
                    DivLpwd.Attributes.Add("class", "show w-30p marginauto card-Bg-Grey padding20");
                    divTpwd.Attributes.Add("class", "hide");
                    btnChange.Attributes.Add("class", "btn show");
                    btnCancel.Attributes.Add("class", "show");
                    btnupdate.Attributes.Add("class", "hide");
                    btnclose.Attributes.Add("class", "hide");

                }
            }
            txtOldpassword.Focus();

            if (Request.QueryString["ILF"] != null)
            {
                string lblmsg = Resources.UserSettings_ClientDisplay.UserSettings_ChangePassword_aspx_01;
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
        //List<PasswordPolicy> lstpwdplcy = new List<PasswordPolicy>();
        returncode = new GateWay(base.ContextInfo).GetPasswordPolicyCount(OrgID, out count, out Tcount);

        hdnpwdplcycount.Value = Convert.ToString(count == 0 ? 1 : count);
        hdntranspwdplcycount.Value = Tcount.ToString();

       
    }

    public void LoadExpiryDate()
    {
        long Returncode = -1;

        List<PasswordPolicy> lstpwdplcy = null;
        List<PasswordPolicy> Transpwdplcy = null;
        Returncode = new GateWay(base.ContextInfo).GetPasswordValidityPeriod(OrgID, out lstpwdplcy, out Transpwdplcy);


        if (lstpwdplcy!=null && lstpwdplcy.Count > 0)
        {
            if (hdnpwdplcycount.Value != "0" && hdntranspwdplcycount.Value != "0")
            {
                trplcy.Attributes.Add("class", "show");
                transplcy.Attributes.Add("class", "show");
                LoadTable(lstpwdplcy);

            }
            else if (hdnpwdplcycount.Value != "0")
            {
                trplcy.Attributes.Add("class", "show");
                transplcy.Attributes.Add("class", "hide");
                LoadTable(lstpwdplcy);
            }
            else if (hdntranspwdplcycount.Value != "0")
            {
                trplcy.Attributes.Add("class", "hide");
                transplcy.Attributes.Add("class", "show");
                LoadTable(lstpwdplcy);
            }
            else
            {
                LoadTable(lstpwdplcy);
                trplcy.Attributes.Add("class", "hide");
                transplcy.Attributes.Add("class", "hide");
            }
        }
        if (lstpwdplcy!=null && lstpwdplcy.Count > 0)
        {
            if (lstpwdplcy[0].ValidityPeriodType == "Days")
            {
                DateTime startdate = DateTimeUtility.GetServerDate();

                DateTime expiryDate = startdate.AddDays(lstpwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (lstpwdplcy[0].ValidityPeriodType == "Weeks")
            {
                DateTime startdate = DateTimeUtility.GetServerDate();

                DateTime expiryDate = startdate.AddDays((lstpwdplcy[0].ValidityPeriod) * 7);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (lstpwdplcy[0].ValidityPeriodType == "Months")
            {
                DateTime startdate = DateTimeUtility.GetServerDate();

                DateTime expiryDate = startdate.AddMonths(lstpwdplcy[0].ValidityPeriod);
                hdnpwdexpdate.Value = expiryDate.ToString();

            }
            else if (lstpwdplcy[0].ValidityPeriodType == "Year")
            {
                DateTime startdate = DateTimeUtility.GetServerDate();
				if(pwdplcy!=null && pwdplcy.Count>0)
				{
					DateTime expiryDate = startdate.AddYears(pwdplcy[0].ValidityPeriod);
					hdnpwdexpdate.Value = expiryDate.ToString();
				}

            }
            hdnprevpwdcount.Value = lstpwdplcy[0].PreviousPwdcount == 0 ? "6" : Convert.ToString(lstpwdplcy[0].PreviousPwdcount);
        }
        else
        {
            hdnprevpwdcount.Value = "6";
            hdnpwdexpdate.Value = Convert.ToString(DateTimeNow.AddDays(30));
        }
        if (Transpwdplcy.Count > 0)
        {
            if (Transpwdplcy[0].ValidityPeriodType == "Days")
            {
                DateTime transstartdate = DateTimeUtility.GetServerDate();

                DateTime transexpiryDate = transstartdate.AddDays(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Weeks")
            {
                DateTime transstartdate = DateTimeUtility.GetServerDate();

                DateTime transexpiryDate = transstartdate.AddDays((Transpwdplcy[0].ValidityPeriod) * 7);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();
            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Months")
            {
                DateTime transstartdate = DateTimeUtility.GetServerDate();

                DateTime transexpiryDate = transstartdate.AddMonths(Transpwdplcy[0].ValidityPeriod);
                hdntranspwdexpdate.Value = transexpiryDate.ToString();

            }
            else if (Transpwdplcy[0].ValidityPeriodType == "Year")
            {
                DateTime transstartdate = DateTimeUtility.GetServerDate();
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
            returncode = new GateWay(base.ContextInfo).GetPasswordpolicy(OrgID, out lstpwdplcy);

            if (lstpwdplcy!=null && lstpwdplcy.Count > 0)
            {
                foreach (PasswordPolicy objPP in lstpwdplcy)
                {
                    long minLength = objPP.MinPassLength == 0 ? 3 : objPP.MinPassLength;
                    hdnRecords.Value += objPP.Type + "~" + objPP.PasswordLength + "~" + objPP.Splcharlen + "~" + objPP.Numcharlen + "~" + objPP.ValidityPeriodType + "~" + objPP.ValidityPeriod + "~" + objPP.PreviousPwdcount + "~" + objPP.Id + "~" + minLength + "^";
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

        returncode = new Configuration_BL(base.ContextInfo).GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void btnChange_Click(object sender, EventArgs e)
    {
        try
        {
            #region HIPPA PartialString Comparision
            List<FuzzyStringComparisonOptions> options = new List<FuzzyStringComparisonOptions>();
            options.Add(FuzzyStringComparisonOptions.UseJaccardDistance);
            //options.Add(FuzzyStringComparisonOptions.UseNormalizedLevenshteinDistance);
            options.Add(FuzzyStringComparisonOptions.UseOverlapCoefficient);
            options.Add(FuzzyStringComparisonOptions.UseLongestCommonSubsequence);
            options.Add(FuzzyStringComparisonOptions.CaseSensitive);
            if (UserName.ApproximatelyEquals(txtNewpassword.Text, FuzzyStringComparisonTolerance.Weak, options.ToArray()))
            {
                string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                
                string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_10;
                if (sPath == null)
                {
                    sPath ="You are not allowed to use your partial username in passwords";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                ModalPopupExtender1.Hide();
                ModalPopupExtender2.Hide();
                return;
            }
            if (OrgName.ApproximatelyEquals(txtNewpassword.Text, FuzzyStringComparisonTolerance.Weak, options.ToArray()))
            {
                string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;

                string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_11;
                if (sPath==null)
                {
                    sPath = "You are not allowed to use your partial organization name in passwords";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
                ModalPopupExtender1.Hide();
                ModalPopupExtender2.Hide();

                return;
            }
            #endregion
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


                //List<Login_HIST> LHist = new List<Login_HIST>();
                returnpwd = new GateWay(base.ContextInfo).Checkpreviouspassword(LID, OrgID, newPassword, out result);

                if (result != 0)
                {
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_05;
                    string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }
                    if (sPath == null)
                    {
                        sPath = "Your are not allowed to use your {0} old passwords.";
                    }
                    sPath = string.Format(sPath, hdnprevpwdcount.Value);
                    //string sPath = "ChangePassword\\\\ChangePassword.aspx_5";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "','ValidationWindow');", true);
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    return;

                }

                if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
                {
                    PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);
                }
                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);
                if (returncode >= 0)
                {
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();
                }
                else
                {
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_09;
                    string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }
                    if (sPath == null)
                    {
                        sPath = "Incorrect old password.";
                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "','txtOldpassword');", true);
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    return;
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

                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();


                }
                else
                {
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_09;
                    string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }
                    if (sPath == null)
                    {
                        sPath = "Incorrect old password.";
                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "','txtOldpassword');", true);
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    return;
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
            returnCode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
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

                //List<Login_HIST> LHist = new List<Login_HIST>();
                returnpwd = new GateWay(base.ContextInfo).Checkpreviouspassword(LID, OrgID, newPassword, out result);

                if (result != 0)
                {
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Hide();
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_05;
                    string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                    if (ErrorMsg == null)
                    {
                        ErrorMsg = "Error";
                    }
                    if (sPath == null)
                    {
                        sPath = "Your are not allowed to use your {0} old passwords.";
                    }
                    sPath = string.Format(sPath, hdnprevpwdcount.Value);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "','txtOldpassword');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Password Already Exist');", true);
                    //  txtOldpassword.Focus();
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
                    transreturnpwd = new GateWay(base.ContextInfo).Checkprevioustransactionpassword(LID, OrgID, newTransPassword, out transresult);

                    if (transresult != 0)
                    {
                        ModalPopupExtender1.Hide();
                        ModalPopupExtender2.Hide();
                        string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_07;
                        string ErrorMsg = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_01;
                        if (ErrorMsg == null)
                        {
                            ErrorMsg = "Error";
                        }
                        if (sPath == null)
                        {
                            sPath = "Given Transaction Password Already Exist";
                        }
                        //string sPath = "ChangePassword\\\\ChangePassword.aspx_4";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "','txtOldpassword');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Transaction Password Already Exist');", true);

                        //txtOldpassword.Focus();
                        return;

                    }


                }



                returncode = new GateWay(base.ContextInfo).ChangePassword(LID, oldPassword, oldtransPassword, newPassword, newTransPassword, PasswordExpiryDate, TransationPasswordExpiryDate);
                ModalPopupExtender1.Hide();
                if (returncode >= 0)
                {

                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();


                }
                else
                {
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_06;
                    if (sPath == null)
                    {
                        sPath = "Password Updation Failed";
                    }
                    Attuneheader.LoadErrorMsg(sPath);

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

                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    Session.Add("IsFirstLogin", "Y");
                    ModalPopupExtender1.Hide();
                    ModalPopupExtender2.Show();
                }
                else
                {
                    string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_06;
                    if (sPath == null)
                    {
                        sPath = "Password Updation Failed";
                    }
                    Attuneheader.LoadErrorMsg(sPath);

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
            returnCode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
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

                string sPath = Resources.UserSettings_AppMsg.UserSettings_ChangePassword_aspx_08;
                if (sPath == null)
                {
                    sPath = "Transaction Password Incorrect";
                }
                Attuneheader.LoadErrorMsg(sPath);

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
           
                List<Role> lstUserRole = new List<Role>();
                string path = string.Empty;
                Role role = new Role();
                role.RoleID = RoleID;
                lstUserRole.Add(role);
                returnCode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
                string RedirectPath = Request.ApplicationPath + path;
                Response.Redirect(RedirectPath);
				        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

}
