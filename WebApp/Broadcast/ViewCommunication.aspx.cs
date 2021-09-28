using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Web.Script.Serialization;
using Attune.Podium.Common;

public partial class Broadcast_ViewCommunication : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session["lblOutputMessage"] = "";
            Session["ResponseMessage"] = "";
            trNewNBComm.Visible = false;
            loadManager(OrgID, RoleID);
            loadUserRole();
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");
            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            FCKeditor1.BasePath = sPath;
            FCKeditor1.ToolbarSet = "SummaryReport";
            FCKeditor1.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            FCKeditor1.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor1", String.Format("var lblFCKeditor1=\"{0}\";", FCKeditor1.ClientID), true);
            ScriptManager.RegisterOnSubmitStatement(this, FCKeditor1.GetType(), FCKeditor1.ClientID + "editor1", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "').UpdateLinkedField();}}");
            FCKeditor2.BasePath = sPath;
            FCKeditor2.ToolbarSet = "SummaryReport";
            FCKeditor2.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            FCKeditor2.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor2", String.Format("var lblFCKeditor2=\"{0}\";", FCKeditor2.ClientID), true);
            ScriptManager.RegisterOnSubmitStatement(this, FCKeditor2.GetType(), FCKeditor1.ClientID + "editor1", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "').UpdateLinkedField();}}");
            trNewNBComm.Visible = true;
            chkVisitNum.Checked = false;
            txtVisitNum.Text = string.Empty;
            chkNBVisitNum.Checked = false;
            txtNBVisitNum.Text = string.Empty;
        }
    }

    protected void btnBroadcastSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            LoadBroadcastInfo();
            DivTwoClear();
            ViewComm1.ViewCommunicationlist();
            chkVisitNum.Checked = false;
            txtVisitNum.Text = string.Empty;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting in Communication, Please contact system administrator.";
        }
    }

    private void DivTwoClear()
    {
        try
        {
            FCKeditor1.Value = "";
            txtFDate1.Text = "";
            txtSubject.Text = "";
            chkBroadcastTo.ClearSelection();
            ddlBroadcastedby.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while clearing Communication details, Please contact system administrator.";
        }
    }
    private void LoadBroadcastInfo()
    {
        try
        {
            List<NBCommunicationDetails> lstCommDetails = new List<NBCommunicationDetails>();
            string[] recipientComm = hdnRecipientListComm.Value.Split('|');
            foreach (string str in recipientComm)
            {
                if (str != "")
                {
                    string[] lst = str.Split('~');
                    int i = lst.Length;
                    NBCommunicationDetails obj = new NBCommunicationDetails();
                    obj.LoginID = Convert.ToInt64(lst[1].ToString().Trim());
                    obj.RoleID = Convert.ToInt32(lst[2].ToString().Trim());
                    lstCommDetails.Add(obj);
                }
            }


            //////////////////////////////////////////////////
            string BRoles = String.Empty;
            int Count = chkBroadcastTo.Items.Count;
            for (int i = 0; i < Count; i++)
            {
                if (chkBroadcastTo.Items[i].Selected)
                {
                    BRoles += chkBroadcastTo.Items[i].Value + ",";
                }
            }
            BRoles.TrimEnd(',');
            /////////////////////////////////////////////////////
            NBCommunicationMaster cm = new NBCommunicationMaster();
            long CommId = 0;
            string CommCode = String.Empty;
            cm.RefCommID = 0;
            cm.ParentCommID = 0;
            cm.AckRequired = "";
            cm.SendSMS = "";
            cm.PriorityLevel = "";
            cm.Validity = Convert.ToDateTime(txtFDate1.Text);
            //cm.BroadcastedBy = ddlBroadcastedby.SelectedValue.ToString();
            cm.BroadcastedBy = Session["UserName"].ToString();
            cm.Subject = txtSubject.Text;
            cm.CommContent = FCKeditor1.Value;
            cm.OrgID = OrgID;
            cm.CreatedBy = LID;
            cm.RoleID = RoleID;
            cm.CommType = 1;
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            string Flag = "O";
            Session["lblOutputMessage"] = "Message posted successfully!";
            InvBL.SaveCommunicationMasterEntry(lstCommDetails, cm, Flag, txtVisitNum.Text.ToString(), out CommId, out CommCode);
            if (Session["lblOutputMessage"].ToString() != "")
            {
                lblShowMessage.Text = Session["lblOutputMessage"].ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting in Communication, Please contact system administrator.";
        }
    }

    protected void btnNBSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            LoadNoticeBoardInfo();
            DivOneClear();
            ViewComm1.ViewCommunicationlist();
            chkNBVisitNum.Checked = false;
            txtNBVisitNum.Text = string.Empty;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting Notice Board, Please contact system administrator.";
        }

    }

    private void LoadNoticeBoardInfo()
    {
        try
        {
            long ReturnCode = -1;
            string NBRoles = String.Empty;

            List<NBCommunicationDetails> lstNBDetails = new List<NBCommunicationDetails>();
            string[] recipientNB = hdnRecipientListNB.Value.Split('|');
            foreach (string str in recipientNB)
            {
                if (str != "")
                {
                    string[] lst = str.Split('~');
                    NBCommunicationDetails obj = new NBCommunicationDetails();
                    obj.LoginID = Convert.ToInt64(lst[1].ToString().Trim());
                    obj.RoleID = Convert.ToInt32(lst[2].ToString().Trim());
                    lstNBDetails.Add(obj);
                }
            }
            //////////////////////////////////////////////////
            int Count = chkDomain.Items.Count;
            for (int i = 0; i < Count; i++)
            {
                if (chkDomain.Items[i].Selected)
                {
                    NBRoles += chkDomain.Items[i].Value + ",";
                }
            }
            NBRoles.TrimEnd(',');
            ///////////////////////////////////////////////////

            NBCommunicationMaster cm = new NBCommunicationMaster();
            long CommId = 0;
            string CommCode = String.Empty;
            if (rbYes.Checked)
            {
                cm.SendSMS = "Y";
            }
            else
            {
                cm.SendSMS = "N";
            }

            cm.PriorityLevel = ddlPriorityList.SelectedItem.Value;
            cm.Subject = txtNBSubject.Text;
            cm.BroadcastedBy = RoleName;
            //cm.BroadcastedBy = Session["UserName"].ToString();
            cm.CreatedBy = LID;
            cm.CommContent = FCKeditor2.Value;
            cm.Validity = Convert.ToDateTime(txtFDate.Text);
            cm.RoleID = RoleID;
            if (rbACKYes.Checked)
            {
                cm.AckRequired = "Y";
            }
            else
            {
                cm.AckRequired = "N";
            }
            cm.CommType = 2;
            cm.OrgID = OrgID;
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            string Flag = "O";
            ReturnCode = InvBL.SaveCommunicationMasterEntry(lstNBDetails, cm, Flag, txtNBVisitNum.Text, out CommId, out CommCode);
            Session["lblOutputMessage"] = "Notice posted successfully. Code - " + CommCode;
            if (Session["lblOutputMessage"].ToString() != "")
            {
                lblShowMessage.Text = Session["lblOutputMessage"].ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting Notice Board, Please contact system administrator.";
        }
    }

    private void DivOneClear()
    {
        try
        {
            FCKeditor1.Value = "";
            txtFDate.Text = "";
            txtNBSubject.Text = "";
            rbACKYes.Checked = true;
            chkDomain.ClearSelection();
            ddlPriorityList.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while clearing Notice board details, Please contact system administrator.";
        }
    }

    public void loadManager(int OrgID, int RoleID)
    {
        try
        {
            List<Users> lstuserroles = new List<Users>();
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            lstuserroles = InvBL.RetrieveManager(OrgID, RoleID);
            ddlBroadcastedby.DataSource = lstuserroles;
            ddlBroadcastedby.DataTextField = "Name";
            ddlBroadcastedby.DataBind();
            ddlBroadcastedby.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading user names, Please contact system administrator.";
        }

    }
    protected void ddlRolesComm_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            loadUserComm();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showCommDIV", "javascript:showNCdiv();", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "reloadRecipientList", "javascript:clearLoadRecipientList();", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "rolesFocus", "javascript:rolesFocus('" + ddlRolesComm.ClientID + "');", true);
            if (chkVisitNum.Checked)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "GetVistDetails", "javascript:GetVistDetails();", true);

            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading Roles Users for Communication, Please contact system administrator.";
        }
    }
    protected void ddlRolesNB_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            loadUserNB();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "showNBDIV", "javascript:showNBdiv();", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "reloadRecipientList", "javascript:clearLoadRecipientListNB();", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "rolesFocus", "javascript:rolesFocus('" + ddlRolesNB.ClientID + "');", true);
            if (chkNBVisitNum.Checked)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "NBGetVistDetails", "javascript:NBGetVistDetails();", true);

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading Roles Users for Notice Board, Please contact system administrator.";
        }
    }
    public void loadUserNB()
    {
        try
        {
            long returncode = -1;
            if (ddlRolesNB.SelectedItem.Text == "FRANCHISEE")
            {
                List<ClientMaster> lstClientNB = new List<ClientMaster>();
                Communication_BL comBL = new Communication_BL(base.ContextInfo);
                lstClientNB = comBL.GetClientForCommunication(OrgID);
                if (lstClientNB.Count > 0)
                {
                    lstBXUsersNB.DataSource = lstClientNB;
                    lstBXUsersNB.DataTextField = "ClientName";
                    lstBXUsersNB.DataValueField = "ClientID";
                    lstBXUsersNB.DataBind();
                }
            }
            else
            {

                List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
                returncode = new Role_BL(base.ContextInfo).GetUsersAgainstRole(Convert.ToInt64(ddlRolesNB.SelectedValue), out lstOrgUsers);

                if (lstOrgUsers.Count > 0)
                {
                    lstBXUsersNB.DataSource = lstOrgUsers;
                    lstBXUsersNB.DataTextField = "Name";
                    lstBXUsersNB.DataValueField = "LoginID";
                    lstBXUsersNB.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading Roles Users for Notice Board, Please contact system administrator.";
        }
    }
    public void loadUserComm()
    {
        try
        {
            long returncode = -1;
            if (ddlRolesComm.SelectedItem.Text == "FRANCHISEE")
            {
                List<ClientMaster> lstClientComm = new List<ClientMaster>();
                Communication_BL comBL = new Communication_BL(base.ContextInfo);
                lstClientComm = comBL.GetClientForCommunication(OrgID);
                if (lstClientComm.Count > 0)
                {
                    lstBXUsersComm.DataSource = lstClientComm;
                    lstBXUsersComm.DataTextField = "ClientName";
                    lstBXUsersComm.DataValueField = "ClientID";
                    lstBXUsersComm.DataBind();
                }
            }
            else
            {

                List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
                returncode = new Role_BL(base.ContextInfo).GetUsersAgainstRole(Convert.ToInt64(ddlRolesComm.SelectedValue), out lstOrgUsers);

                if (lstOrgUsers.Count > 0)
                {
                    lstBXUsersComm.DataSource = lstOrgUsers;
                    lstBXUsersComm.DataTextField = "Name";
                    lstBXUsersComm.DataValueField = "LoginID";
                    lstBXUsersComm.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading Roles Users for Communication, Please contact system administrator.";
        }
    }

    public void loadUserRole()
    {
        try
        {
            int pOrgID = OrgID;
            List<Role> role = new List<Role>();
            Role_BL roleBL = new Role_BL(base.ContextInfo);
            long returncode = -1;
            returncode = roleBL.GetRoleName(pOrgID, out role);
            role.RemoveAll(p => p.RoleName.Equals("Billing"));
            ////////////////////////////////////////////////////////
            ddlRolesComm.DataSource = role;
            ddlRolesComm.DataTextField = "IntegrationName";
            ddlRolesComm.DataValueField = "RoleID";
            ddlRolesComm.DataBind();
            //ddlRolesComm.Items.Insert(0, new ListItem("--All--", "0"));


            ddlRolesNB.DataSource = role;
            ddlRolesNB.DataTextField = "IntegrationName";
            ddlRolesNB.DataValueField = "RoleID";
            ddlRolesNB.DataBind();
            //ddlRolesNB.Items.Insert(0, new ListItem("--All--", "0"));
            //////////////////////////////////////////////////////

            chkBroadcastTo.DataSource = role;
            chkBroadcastTo.DataTextField = "IntegrationName";
            chkBroadcastTo.DataValueField = "RoleName";
            chkBroadcastTo.DataBind();
            chkDomain.DataSource = role;
            chkDomain.DataTextField = "IntegrationName";
            chkDomain.DataValueField = "RoleName";
            chkDomain.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading roles, Please contact system administrator.";
        }
    }
}
