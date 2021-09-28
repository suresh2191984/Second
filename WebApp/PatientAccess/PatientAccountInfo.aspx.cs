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

public partial class PatientAccess_PatientAccountInfo : BasePage
{

   
    long returnCode = -1;
    public PatientAccess_PatientAccountInfo()
        : base("PatientAccess\\PatientAccountInfo.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnChange_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Attune.Podium.BusinessEntities.Login objlogin = new Attune.Podium.BusinessEntities.Login();
            if (txtConfirmpassword.Text.Trim() == txtNewpassword.Text.Trim())
            {
                objlogin.LoginID = LID;
                objlogin.Password = txtNewpassword.Text.Trim();
                objlogin.SecretAnswer = txtSecretAnswer.Text;
                if (ddlSecretQuestion.SelectedValue != "Userquestion")
                {
                    objlogin.SecretQuestion = ddlSecretQuestion.SelectedValue;
                }
                else
                {
                    objlogin.SecretQuestion = txtSecretQuestion.Text;
                }
                objlogin.HasUserChangedPassword = txtOldpassword.Text.Trim();
                returncode = new GateWay(base.ContextInfo).UpdateLoginDetails(objlogin);
                if (returncode == 1)
                {
                    txtOldpassword.Text = string.Empty;
                    txtNewpassword.Text = string.Empty;
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Successfully Updated";
                }
                else
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Updation Failed";
                }
            }

            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Updation Failed";
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
}
