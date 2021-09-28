using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Web.UI.WebControls;
using Attune.Podium.PerformingNextAction;

public partial class ForgotPassword : System.Web.UI.Page
{
    string otp = string.Empty;
    DateTime PasswordExpiryDate = Convert.ToDateTime("1/1/1900 00:00:00");
    string Status = string.Empty;
    long LID = 0;
    long OrgID = 0;
    ActionManager objActionManager;
    string strSMSTemplate = string.Empty;
    string Template = string.Empty;
    string Value = string.Empty;
    string Subject = string.Empty;
    string OTPMode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        Loadpwdplcycount();
        LoadExpiryDate();
       
    }
    protected void lnkHome_Click(object sender, EventArgs e)
    {
       Response.Redirect("~/Home.aspx");
    }
    public void LoadTable(List<PasswordPolicy> lstpwdplcy)
    {
        try
        {
            long returncode = -1;
            returncode = new Users_BL().GetPasswordpolicy(67, out lstpwdplcy);

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
            CLogger.LogError("Error in LoadTable", ex);
        }
    }
    public void LoadExpiryDate()
    {
        try
        {
            long Returncode = -1;

            List<PasswordPolicy> pwdplcy = new List<PasswordPolicy>();
            List<PasswordPolicy> Transpwdplcy = new List<PasswordPolicy>();
            Returncode = new Users_BL().GetPasswordValidityPeriod(67, out pwdplcy, out Transpwdplcy);

            if (pwdplcy.Count > 0)
            {
                if (pwdplcy[0].ValidityPeriodType == "Days")
                {
                    DateTime startdate = DateTime.Now;

                    DateTime expiryDate = startdate.AddDays(pwdplcy[0].ValidityPeriod);
                    hdnpwdexpdate.Value = expiryDate.ToString();

                }
                else if (pwdplcy[0].ValidityPeriodType == "Weeks")
                {
                    DateTime startdate = DateTime.Now;

                    DateTime expiryDate = startdate.AddDays((pwdplcy[0].ValidityPeriod) * 7);
                    hdnpwdexpdate.Value = expiryDate.ToString();

                }
                else if (pwdplcy[0].ValidityPeriodType == "Months")
                {
                    DateTime startdate = DateTime.Now;

                    DateTime expiryDate = startdate.AddMonths(pwdplcy[0].ValidityPeriod);
                    hdnpwdexpdate.Value = expiryDate.ToString();

                }
                else if (pwdplcy[0].ValidityPeriodType == "Year")
                {
                    DateTime startdate = DateTime.Now;
                    DateTime expiryDate = startdate.AddYears(pwdplcy[0].ValidityPeriod);
                    hdnpwdexpdate.Value = expiryDate.ToString();

                }
            }
            if (hdnpwdexpdate.Value != "" && hdnpwdexpdate.Value != null)
            {
                PasswordExpiryDate = Convert.ToDateTime(hdnpwdexpdate.Value);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadExpiryDate", ex);
        }



    }
    public void Loadpwdplcycount()
    {
        try
        {
            long returncode = -1;
            int count = -1;
            int Tcount = -1;
            List<PasswordPolicy> lstpwdplcy = new List<PasswordPolicy>();
            returncode = new Users_BL().GetPasswordPolicytotalCount(67, out count, out Tcount);

            hdnpwdplcycount.Value = count.ToString();
            hdntranspwdplcycount.Value = Tcount.ToString();

            if (hdnpwdplcycount.Value != "0" && hdntranspwdplcycount.Value != "0")
            {

                LoadTable(lstpwdplcy);

            }
            else if (hdnpwdplcycount.Value != "0")
            {

                LoadTable(lstpwdplcy);
            }
            else if (hdntranspwdplcycount.Value != "0")
            {

                LoadTable(lstpwdplcy);

            }

            else
            {
                LoadTable(lstpwdplcy);


            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Loadpwdplcycount", ex);
        }

    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            long returnpwd = -1;
            long returncode = -1;

            string newPassword = string.Empty;
            string _status = string.Empty;
            newPassword = txtNewpassword.Text;
            LID = Convert.ToInt64(hdnLID.Value);
            OrgID = Convert.ToInt64(hdnOrgID.Value);

            string strEncNewPwd = string.Empty;
            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();

            obj.Crypt(newPassword, out strEncNewPwd);
            newPassword = strEncNewPwd;
            int result = -1;


            Users_BL UsersBL = new Users_BL();
            List<Login_HIST> LHist = new List<Login_HIST>();
            returnpwd = new Users_BL().Checkpreviouspassword(LID, OrgID, newPassword, out result);

            if (result != 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('Given Password Already Exist');", true);
            }
            returncode = new GateWay().UpdatePassword(LID, txtOTP.Text, newPassword, PasswordExpiryDate, out _status);
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('" + _status  + "');", true);

            if (_status == "Password Updated Successfully")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('" + _status + "');reloadPage();", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "login", "alert('" + _status + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnUpdate_Click", ex);
        }
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Home.aspx");
    }
    protected void btnGenerateOTP_Click(object sender, EventArgs e)
    {
        try
        {
            OTP objOtp = new OTP();
            string userId = DateTime.Now.ToString();
            otp = OTP.GetOTP(userId);
            GateWay gateWay = new GateWay();

            hdnLoginname.Value = txtLoginName.Text;
             OTPMode = !string.IsNullOrEmpty(rdoOTPlst.SelectedItem.Value) ? rdoOTPlst.SelectedItem.Value : "";
             gateWay.SaveOTPDetails(hdnLoginname.Value, otp, OTPMode, "", "GenerateOTP", out Status, out LID, out OrgID, out Value, out Template, out Subject);
            int _OrgID = Convert.ToInt32(OrgID);
       
            hdnLID.Value = LID.ToString();
            hdnOrgID.Value = OrgID.ToString();
            string alertMsg = Status;


            if (alertMsg == "OTP has been sent to your Registered Mobile Number" || alertMsg == "OTP has been sent to your Registered Email ID")
            {
                long OTPStatus = CommunicationNotification(OTPMode, Value, _OrgID, LID, Template, Subject);
                if (OTPStatus >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('" + alertMsg.ToString() + "');", true);
                    divUpdatePassword.Attributes.Add("style", "display:inline-block");
                    divUpdatePassword.Attributes.Add("style", "width:100%");
                    divforgetPassword.Attributes.Add("style", "display:none");
                    divUpdatePassword.Attributes.Add("style", "margin-left:20%");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('SMS / Email Failed');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('" + alertMsg.ToString() + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnGenerateOTP_Click", ex);
        }
    }
    protected void btnsend_Click(object sender, EventArgs e)
    {
        try
        {
            OTP objOtp = new OTP();
            string userId = DateTime.Now.ToString();
            GateWay gateWay = new GateWay();
            otp = OTP.GetOTP(userId);
            string OTPMode = rdopoplst.SelectedItem.Value;
            
          
            gateWay.SaveOTPDetails(hdnLoginname.Value, otp, OTPMode , "", "ResendOTP", out Status, out LID, out OrgID,out Value,out Template,out Subject );
            int _OrgID = Convert.ToInt32(OrgID);
           
            hdnLID.Value = LID.ToString();
            hdnOrgID.Value = OrgID.ToString();


            if (Status == "OTP has been sent to your Registered Mobile Number" || Status == "OTP has been sent to your Registered Email ID")
            {
                long OTPStatus = CommunicationNotification(OTPMode, Value, _OrgID, LID, Template, Subject);
                if (OTPStatus >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('" + Status.ToString() + "');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('SMS / Email Failed');", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('" + Status.ToString() + "');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnsend_Click", ex);
        }
        
    }
    public long CommunicationNotification(string OTPMode , string Value,int OrgID,long LID ,string Template, string Subject )
    {
        long returnCode = -1;
        #region Send SMS/Email based on Notification
            if (OTPMode == "SMS" && Value != "")
            {   
                List<NotificationAudit> lstNotifysms = new List<NotificationAudit>();
                String URL = string.Empty;
                NotificationAudit NotifySms;
                objActionManager = new ActionManager();
                objActionManager.GetSMSConfig(OrgID, out URL);
             
                strSMSTemplate = ""; 
                
                        NotifySms = new NotificationAudit();
                        NotifySms.ContactInfo = Value;
                        NotifySms.Message = Template;
                        NotifySms.ReceiverType = "PWD_RST_OTP";
                        NotifySms.NotificationTypes = "SMS";
                        lstNotifysms.Add(NotifySms);
 
 
                        Communication.SendSMS(URL, Template, Value.Trim());
                
                Patient_BL Patsms = new Patient_BL();

                returnCode = Patsms.insertNotificationAudit(OrgID, 0, LID, lstNotifysms);
                
            }
            else if (OTPMode == "Email" && Value != "")
            {
                List<NotificationAudit> lstNotifyEmail = new List<NotificationAudit>();
                NotificationAudit NotifyEmail;
                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                MailConfig oMailConfig = new MailConfig();
                objActionManager = new ActionManager();
                objActionManager.GetEMailConfig(OrgID, out oMailConfig);
                returnCode = Communication.SendMail(Value.Trim(), string.Empty, string.Empty, Subject,
                                                                Template.Trim(), lstMailAttachment, oMailConfig);
                NotifyEmail = new NotificationAudit();
                NotifyEmail.Message = Template.Trim();
               // NotifyEmail.Id = Convert.ToInt64(sup[i].Split('~')[0]);
               // NotifyEmail.ContactInfo = sup[i].Split('~')[2];
                NotifyEmail.NotificationTypes = "EMail";
                NotifyEmail.ReceiverType = "PWD_RST_OTP";
               
                lstNotifyEmail.Add(NotifyEmail);
                Patient_BL Patsms = new Patient_BL();
                Patsms.insertNotificationAudit(OrgID, -1, LID, lstNotifyEmail);
                //returnCode = Patsms.insertNotificationAudit(OrgID, ILocationID, LID, lstNotifysms);
                
            }
            #endregion
            return returnCode;
    }
}
