using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;

using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Common;
public partial class PMS_Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        long returnCode = 0;
        try
        {
            GateWay gateWay = new GateWay();

            Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
            Attune.Podium.BusinessEntities.Login loggedIn = new Attune.Podium.BusinessEntities.Login();
            login.LoginName = txtUserName.Text;
            string EncryptedString = string.Empty;
            Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
            obj.Crypt(txtPassword.Text, out EncryptedString);
            login.Password = EncryptedString;

            int organizationID = -1;
            int OrgID = -1;
            string IsLocked = "";
            string IsExpired = "";
            string IsBlocked = "";
            string BlockedTo = "";
            
            List<EmployerDeptMaster> lstDeptarment = new List<EmployerDeptMaster>();
            //returnCode = new Attune.Kernel.PlatForm.BL.GateWay().AuthenticateUser(login, Session.SessionID, "", out loggedIn, out OrgID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo, out LoginTime, out lstDeptarment);
            returnCode = gateWay.AuthenticateUser(login, Session.SessionID, out loggedIn, out organizationID, out IsLocked, out IsExpired, out IsBlocked, out BlockedTo);

            if (returnCode != -1 && loggedIn.LoginID > 0)
            {
                if (IsExpired != "Y" && IsLocked != "Y" && IsBlocked!="Y")
                {
                    Session.Add("PMSLoginID", loggedIn.LoginID.ToString());
                    Response.Redirect("Home.aspx?FldID=0");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}
