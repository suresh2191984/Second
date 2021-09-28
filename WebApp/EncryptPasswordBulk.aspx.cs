using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Kernel.PlatForm.Utility;

using Attune.Kernel.PlatForm.Base;

public partial class EncryptPasswordBulk : Attune_BasePage
{
    public EncryptPasswordBulk()
        : base("EncryptPasswordBulk_aspx")
    {}
    SqlConnection conLogin = new SqlConnection();
    DataSet dsLogin = new DataSet();
    SqlDataAdapter daLogin = new SqlDataAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
            lblWarning.Text = " ";
    }
    
    protected void btnEncryptData_Click(object sender, EventArgs e)
    {
        try
        {
            dsLogin.Clear();
            lblWarning.Text = "";
            conLogin.ConnectionString = Utilities.GetConnectionString();
            SqlCommand cmdLogin = conLogin.CreateCommand();
            cmdLogin.CommandText = "SELECT loginID,Password,OrgID FROM Login";
            daLogin.SelectCommand = cmdLogin;
            conLogin.Open();
            int numberOfRows = daLogin.Fill(dsLogin, "login_");

            DataTable dtLogin = dsLogin.Tables["login_"];

            //foreach (DataRow drLogin in dtLogin.Rows)
            //{
            //    string EncryptedString = string.Empty;
            //    if (rbEncrypt.Checked)
            //    {
            //        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
            //        obj.Crypt(Convert.ToString(drLogin["Password"]), out EncryptedString);
            //    }
            //    else
            //    {
            //        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
            //        obj.Crypt(Convert.ToString(drLogin["Password"]), out EncryptedString);
            //    }
            //    SqlCommand cmdUpdate = conLogin.CreateCommand();
            //    cmdUpdate.Connection = conLogin;
            //    cmdUpdate.CommandText = "UPDATE Login SET Password='" + EncryptedString + "' WHERE loginID=" + drLogin["loginID"] + " AND OrgID=" + drLogin["OrgID"];
            //    cmdUpdate.ExecuteNonQuery();
            //}
            if (rbEncrypt.Checked)
            {
                foreach (DataRow drLogin in dtLogin.Rows)
                {
                    string EncryptedString = string.Empty;
                    Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
                    obj.Crypt(Convert.ToString(drLogin["Password"]), out EncryptedString);
                    SqlCommand cmdUpdate = conLogin.CreateCommand();
                    cmdUpdate.Connection = conLogin;
                    cmdUpdate.CommandText = "UPDATE Login SET Password='" + EncryptedString + "' WHERE loginID=" + drLogin["loginID"] + " AND OrgID=" + drLogin["OrgID"];
                    cmdUpdate.ExecuteNonQuery();
                }
            }
            else
            {
                foreach (DataRow drLogin in dtLogin.Rows)
                {
                    string DecryptedString = string.Empty;
                    Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetDecryptor();
                    obj.Crypt(Convert.ToString(drLogin["Password"]), out DecryptedString);
                    SqlCommand cmdUpdate = conLogin.CreateCommand();
                    cmdUpdate.Connection = conLogin;
                    cmdUpdate.CommandText = "UPDATE Login SET Password='" + DecryptedString + "' WHERE loginID=" + drLogin["loginID"] + " AND OrgID=" + drLogin["OrgID"];
                    cmdUpdate.ExecuteNonQuery();
                }
            }
            conLogin.Close();
            if (rbEncrypt.Checked)
            {
                string sPath = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_03;
                string Information = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_02;
                if (Information == null)
                {
                    Information = "Information";
                }
                if (sPath == null)
                {
                    sPath = "Login Password Encrypted Successfully.";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "key", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
            }
            else
            {
                string sPath = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_04;
                string Information = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_02;
                if (Information == null)
                {
                    Information = "Information";
                }
                if (sPath == null)
                {
                    sPath = "Login Password Decrypted Successfully.";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "key", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
            }
            daLogin.Dispose();
            dsLogin.Clear();
            dsLogin.Dispose();
            daLogin.Dispose();
            conLogin.Close();
            conLogin.Dispose();
        }
        catch (Exception ex)
        {
            lblWarning.Text = "Warning !! " + ex.Message;
            if (rbEncrypt.Checked)
            {
                string sPath = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_05;
                string ErrorMsg = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_01;
                if (ErrorMsg == null)
                {
                    ErrorMsg = "Error";
                }
                if (sPath == null)
                {
                    sPath = "There was a problem while Encrypting Login Password.";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "key", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
            }
            else
            {
                string sPath = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_06;
                string ErrorMsg = Resources.EncryptPasswordBulk_AppMsg._EncryptPasswordBulk_aspx_01;
                if (ErrorMsg == null)
                {
                    ErrorMsg = "Error";
                }
                if (sPath == null)
                {
                    sPath = "There was a problem while Decrypting Login Password (or) Password may be already Decrypted.";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "key", "javascript:ValidationWindow('" + sPath + "','" + ErrorMsg + "');", true);
            }
            daLogin.Dispose();
            dsLogin.Clear();
            dsLogin.Dispose();
            daLogin.Dispose();
            conLogin.Close();
            conLogin.Dispose();
        }
    }
}
