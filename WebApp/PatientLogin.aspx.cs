using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections.Generic;

public partial class PatientLogin : System.Web.UI.Page
{
    public string sUserMessage_1 = Resources.AppMessages.Home_aspx_cs_1;
    public string sUserMessage_2 = Resources.AppMessages.Home_aspx_cs_2;
    public string sUserMessage_3 = Resources.AppMessages.Home_aspx_cs_3;
    public string sUserMessage_4 = Resources.AppMessages.Home_aspx_cs_4;
    public string sUserMessage_5 = Resources.AppMessages.Home_aspx_cs_5;
    public string sUserMessage_6 = Resources.AppMessages.Home_aspx_cs_6;
    static int loginFlag = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ContinueLogin();
    }
    private void ContinueLogin()
    {
        long returnCode = 0;
        string relPagePath = string.Empty;
        long loginID = 0;
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
        //************************* added by Ramki *************************************/
        Attune.Podium.BusinessEntities.LoggedInUsers loggedInUsers = new LoggedInUsers();
        //******************************************************************************/

        List<Role> userRoles = new List<Role>();
        GateWay gateWay = new GateWay();
        Patient patient = new Patient();
        List<Users> lstUsers = new List<Users>();
        PhysicianSchedule physician = new PhysicianSchedule();
        Nurse nurse = new Nurse();
        int phyID = 0;
        login.LoginName = txtUsername.Text;

        //login.Password = txtPassword.Text;

        string EncryptedString = string.Empty;
        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
        obj.Crypt(txtPassword.Text, out EncryptedString);
        login.Password = EncryptedString;

        try
        {
            int OrgID = -1;
            string IsLocked = "";
            string IsExpired = "";
            string IsBlocked = "";
            string BlockedTo = "";
            returnCode = gateWay.AuthenticateUser(login, Session.SessionID, out loggedIn, out OrgID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo);

            if (returnCode != -1)
            {
                if (IsExpired != "Y")
                {
                    if (IsBlocked != "Y" && BlockedTo == "" || BlockedTo != "")
                    {
                        if (IsBlocked != "Y" && BlockedTo != "" || IsBlocked == "")
                        {
                            if (IsLocked != "")
                            {

                                if (IsLocked == "N")
                                {
                                    if (returnCode == 0)
                                    {
                                        //Prasanna Changes Starts
                                        //imgGo.Enabled = false;
                                        //Prasanna Changes Ends
                                        returnCode = -1;
                                        returnCode = gateWay.GetRoles(loggedIn, out userRoles);
                                        if (returnCode == 0 && userRoles.Count > 0)
                                        {
                                            returnCode = -1;
                                            List<Config> lstConfig = new List<Config>();

                                            Session.Add("OrgID", userRoles[0].OrgID.ToString());
                                            Session.Add("OrgName", userRoles[0].OrgName);
                                            Session.Add("OrgTimeZone", userRoles[0].OrgTimeZone);
                                            if (userRoles[0].OrgDisplayName != null)
                                            {
                                                Session.Add("OrgDisplayName", userRoles[0].OrgDisplayName.ToString());
                                            }
                                            else
                                            {
                                                Session.Add("OrgDisplayName", "");
                                            }
                                            Session.Add("LID", loggedIn.LoginID.ToString());
                                            Session.Add("RoleName", userRoles[0].RoleName.ToString());
                                            Session.Add("RoleDescription", userRoles[0].Description.ToString());
                                            Session.Add("IntegrationName", Convert.ToString(userRoles[0].IntegrationName));
                                            Session.Add("ThemeID", loggedIn.ThemeID.ToString());
                                            Session.Add("IsFirstLogin", loggedIn.IsFirstLogin);


                                            if (userRoles.Count >= 1)
                                            {
                                                returnCode = -1;
                                                Session.Add("RoleID", userRoles[0].RoleID.ToString());
                                                if (userRoles[0].RoleName == "Patient")
                                                {
                                                    List<Patient> lstPatient = new List<Patient>();

                                                    returnCode = gateWay.GetPatientDetail(loggedIn.LoginID, out lstPatient);

                                                    Session.Add("UserName", lstPatient[0].Name);
                                                    Session.Add("LoginName", lstPatient[0].PatientNumber);
                                                    Session.Add("UID", lstPatient[0].PatientID);
                                                    Session.Add("Age", lstPatient[0].Age);
                                                    Session.Add("BloodGroup", lstPatient[0].BloodGroup);
                                                    Session.Add("URNo", lstPatient[0].URNO);



                                                    PatientVisit_BL patientBL = new PatientVisit_BL();
                                                    List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
                                                    returnCode = patientBL.GetLocation(userRoles[0].OrgID, loggedIn.LoginID, userRoles[0].RoleID, out lstLocation);
                                                    if ((lstLocation.Count > 1) || (userRoles.Count > 1))
                                                    {
                                                        string strAddrssID = string.Empty;
                                                        foreach (OrganizationAddress objAdd in lstLocation)
                                                        {
                                                            strAddrssID += objAdd.AddressID.ToString() + "*" + objAdd.CountryID.ToString() + "~" + objAdd.StateID.ToString() + "^";
                                                        }
                                                        Session.Add("AddressID", strAddrssID);
                                                        Response.Redirect("SelectRole.aspx", true);
                                                    }
                                                }
                                            }
                                        }

                                        else
                                        {

                                            long RtrnCode = -1;
                                            gateWay = new GateWay();
                                            string LogInAttempt = string.Empty;
                                            string noOfOrgAttmpts = string.Empty;
                                            string OrgHit = string.Empty;
                                            RtrnCode = gateWay.GetLoginAttemptFailureDetail(txtUsername.Text, out LogInAttempt, out OrgHit);
                                            if (OrgHit != "")
                                            {
                                                int RemaingHit = -1;
                                                RemaingHit = Convert.ToInt32(OrgHit) - Convert.ToInt32(LogInAttempt);
                                                if (RemaingHit > 0)
                                                {

                                                    CLogger.LogWarning("Login userroles returncode=" + returnCode.ToString() + "UserName:" + txtUsername.Text + "UserID");
                                                    // lblStatus.Text = RemaingHit + "  more login attempts remains...";

                                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_3").ToString();

                                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_003", "javascript:alert('" + sUserMessage_5 + "(" + RemaingHit.ToString() + sUserMessage_3 + ")' );", true);

                                                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_003", "javascript:alert('" + sUserMessage_5+ "'( '" + RemaingHit.ToString() + sUserMessage_3 + "')"');", true);
                                                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_003", "javascript:alert('" + RemaingHit.ToString() + sUserMessage_3 + "');", true);
                                                    //sUserMessage = "Home.aspx_3";
                                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                                }
                                                if (RemaingHit == 0)
                                                {

                                                    CLogger.LogWarning("Login userroles returncode=" + returnCode.ToString() + "UserName:" + txtUsername.Text + "UserID");
                                                    // lblStatus.Text = "The account you tried to login into, is now locked due to excessive failed login attempts. Please Contact Administrator..";
                                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_4").ToString();
                                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_004", "javascript:alert('" + sUserMessage_4 + "');", true);
                                                    // sUserMessage = "Home.aspx_4";
                                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);

                                                }
                                            }
                                            else
                                            {
                                                // loginFlag++;
                                                CLogger.LogWarning("Invalid Username/Password." + txtUsername.Text);
                                                // lblStatus.Text = "Invalid Username or Password";
                                                // sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + sUserMessage_5 + "');", true);
                                                //sUserMessage = "Home.aspx_5";
                                                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                            }


                                        }
                                        if (returnCode == 0 && userRoles.Count > 0)
                                        {
                                            Navigation navigation = new Navigation();
                                            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                                            if (returnCode == 0)
                                            {
                                                // Helper.PageRedirect(this, Helper.GetAppName() + relPagePath);
                                                Response.Redirect(Request.ApplicationPath + relPagePath, true);
                                                //imgGo.Enabled = false;
                                                //imgGo.Visible = false;
                                            }

                                        }

                                    }
                                    else
                                    {

                                        CLogger.LogWarning("Invalid Username/Password." + txtUsername.Text);
                                        //lblStatus.Text = "Invalid Username or Password";
                                        //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + sUserMessage_5 + "');", true);
                                        //sUserMessage = "Home.aspx_5";
                                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                    }
                                }
                                else
                                {
                                    CLogger.LogWarning("UserName is locked.Please contact administrator.." + txtUsername.Text);
                                    // lblStatus.Text = "UserName is Locked. Please Contact Administrator..";
                                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_6").ToString();
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_006", "javascript:alert('" + sUserMessage_6 + "');", true);
                                    //sUserMessage = "Home.aspx_6";
                                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                                }
                            }

                            else
                            {
                                CLogger.LogWarning("Invalid Username/Password." + txtUsername.Text);
                                // lblStatus.Text = "Invalid Username or Password";
                                //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + sUserMessage_5 + "');", true);
                                //sUserMessage = "Home.aspx_5";
                                // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                            }
                        }

                        else
                        {
                            CLogger.LogWarning("User Has Been Blocked." + txtUsername.Text);
                            // lblStatus.Text = "Invalid Username or Password";
                            //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + "Your login is blocked up to " + BlockedTo + "');", true);
                            // sUserMessage = "Home.aspx_5";
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);


                        }
                    }
                    else
                    {
                        CLogger.LogWarning("User Has Been Blocked." + txtUsername.Text);
                        // lblStatus.Text = "Invalid Username or Password";
                        //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                        //string Message= "Your login is blocked.Please contact administrator";
                        string ResMessage = Resources.AppMessages.Home_aspx_cs_Message;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + ResMessage + "');", true);
                        //sUserMessage = "Home.aspx_5";
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);

                    }
                }
                else
                {
                    CLogger.LogWarning("User Validity Date Expired." + txtUsername.Text);
                    // lblStatus.Text = "Invalid Username or Password";
                    //sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                    //string Message= "Your login is expired.please contact administrator";
                    string ResMessage2 = Resources.AppMessages.Home_aspx_cs_Message2;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + ResMessage2 + "');", true);
                    //sUserMessage = "Home.aspx_5";
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
                }
            }
            else
            {
                CLogger.LogWarning("Invalid Username/Password." + txtUsername.Text);
                // lblStatus.Text = "Invalid Username or Password";

                // sUserMessage = HttpContext.GetGlobalResourceObject("AppMessages", "Home.aspx_5").ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_005", "javascript:alert('" + sUserMessage_5 + "');", true);
                //sUserMessage = "Home.aspx_5";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_001", "ShowAlertMsg('" + sUserMessage + "');", true);
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

        //TODO: Authorization
    }
}
