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

public partial class Broadcast_BroadcastHome : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");
                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath;
                sPath = sPath + "/fckeditor/";
                loadManager(OrgID, RoleID);
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
                ScriptManager.RegisterOnSubmitStatement(this, FCKeditor2.GetType(), FCKeditor2.ClientID + "editor1", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "').UpdateLinkedField();}}");

                LoadCommType();
                loadUserRole();
                trlblDisplay.Visible = false;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading page, Please contact system administrator.";
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
            chkDomain.DataSource = role;
            chkDomain.DataTextField = "RoleName";
            chkDomain.DataValueField = "RoleName";
            chkDomain.DataBind();
            chkBroadcastTo.DataSource = role;
            chkBroadcastTo.DataTextField = "RoleName";
            chkBroadcastTo.DataValueField = "RoleName";
            chkBroadcastTo.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading roles, Please contact system administrator.";
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

    private void LoadCommType()
    {
        try
        {
            List<CommTypeMaster> lstCommType = new List<CommTypeMaster>();
            Communication_BL cb = new Communication_BL(base.ContextInfo);
            lstCommType = cb.GetCommType();
            ddlCommType.DataSource = lstCommType;
            ddlCommType.DataTextField = "CommType";
            ddlCommType.DataValueField = "CommTypeID";
            ddlCommType.DataBind();
            ddlCommType.Items.Insert(0, new ListItem("--Select--", "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while loading Communication type, Please contact system administrator.";
        }
    }

    protected void btnNBSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            LoadNoticeBoardInfo();
            DivOneClear();
            trddlCommType.Visible = false;
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
            ddlCommType.SelectedValue = "0";
            ddlPriorityList.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while clearing Notice board details, Please contact system administrator.";
        }
    }
    private void DivTwoClear()
    {
        try
        {
            FCKeditor2.Value = "";
            txtFDate1.Text = "";
            txtSubject.Text = "";
            chkBroadcastTo.ClearSelection();
            ddlBroadcastedby.SelectedValue = "0";
            ddlCommType.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while clearing Communication details, Please contact system administrator.";
        }

    }


    private void LoadNoticeBoardInfo()
    {
        try
        {
            long ReturnCode = -1;
            string NBRoles = String.Empty;
            int Count = chkDomain.Items.Count;
            for (int i = 0; i < Count; i++)
            {
                if (chkDomain.Items[i].Selected)
                {
                    NBRoles += chkDomain.Items[i].Value + ",";
                }
            }
            NBRoles.TrimEnd(',');
            List<NBCommunicationDetails> lstCommDetails = new List<NBCommunicationDetails>();
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
            cm.CreatedBy = LID;
            cm.CommContent = FCKeditor1.Value;
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
            cm.CommType = Convert.ToInt16(ddlCommType.SelectedItem.Value);
            cm.OrgID = OrgID;
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            string Flag = "O";
            ReturnCode = InvBL.SaveCommunicationMasterEntry(lstCommDetails, cm, Flag, "", out CommId, out CommCode);
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Message posted successfully. NBCode: " + CommCode + "');", true);
            trlblDisplay.Visible = true;
            lblDisplay.Text = "Message posted successfully! NBCode: " + CommCode;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting Notice Board, Please contact system administrator.";
        }

    }

    protected void btnBroadcastSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            LoadBroadcastInfo();
            DivTwoClear();
            trddlCommType.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting in Communication, Please contact system administrator.";
        }

    }
    private void LoadBroadcastInfo()
    {
        try
        {
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
            List<NBCommunicationDetails> lstCommDetails = new List<NBCommunicationDetails>();
            NBCommunicationMaster cm = new NBCommunicationMaster();
            long CommId = 0;
            string CommCode = String.Empty;
            cm.RefCommID = 0;
            cm.ParentCommID = 0;
            cm.AckRequired = "";
            cm.SendSMS = "";
            cm.PriorityLevel = "";
            cm.Validity = Convert.ToDateTime(txtFDate1.Text);
            cm.BroadcastedBy = ddlBroadcastedby.SelectedValue.ToString();
            cm.Subject = txtSubject.Text;
            cm.CommContent = FCKeditor2.Value;
            cm.OrgID = OrgID;
            cm.CreatedBy = LID;
            cm.RoleID = RoleID;
            cm.CommType = Convert.ToInt16(ddlCommType.SelectedItem.Value);
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            string Flag = "O";
            InvBL.SaveCommunicationMasterEntry(lstCommDetails, cm, Flag, "", out CommId, out CommCode);
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", "alert('Message posted successfully!');", true);
            trlblDisplay.Visible = true;
            lblDisplay.Text = "Message posted successfully!";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Communication Home page: ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Error while posting in Communication, Please contact system administrator.";
        }
    }
    protected void lnkBroadcast_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Broadcast/BroadcastHome.aspx");
        trlblDisplay.Visible = false;
    }
}