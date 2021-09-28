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
using Attune.Kernel.PlatForm.Base;


public partial class CommonControls_ViewCommunicationThread : BaseControl
{
    public CommonControls_ViewCommunicationThread()
        : base("CommonControls_ViewCommunicationThread_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        string sPath = Request.Url.AbsolutePath;
        int CID = 2;
        if (!sPath.Contains("PatientTrackingDetails.aspx"))
        {
            if (!IsPostBack)
            {
                tblDisplay.Style.Add("display", "block");
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
                ViewDetailCommunicationlist();
                ShowDetails();
                loadUserRole();
            }
            if (Session["ResponseMessage"].ToString() != "")
            {
                lblShowMessage.Text = Session["ResponseMessage"].ToString();
            }
        }
    }

    protected void grdViewDetailCommunication_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("View"))
        {
            int rowIndex = int.Parse(e.CommandArgument.ToString());
            long CommID = Convert.ToInt64(this.grdViewDetailCommunication.DataKeys[rowIndex]["CommID"]);
            long Role = Convert.ToInt64(this.grdViewDetailCommunication.DataKeys[rowIndex]["RoleID"]);
            long replyLID = Convert.ToInt64(this.grdViewDetailCommunication.DataKeys[rowIndex]["LoginID"]);


            Session["LCommID"] = CommID;
            Session["ReplyCommLoginID"] = replyLID;
            Session["ReplyCommRoleID"] = Role;
            ShowDetails();
            trNewCommunication.Visible = true;
            trNoticeBoard.Visible = true;
            lblShowMessage.Text = "";
            Session["ResponseMessage"] = "";
            string sPath = Request.Url.AbsolutePath;
            if (sPath.Contains("PatientTrackingDetails.aspx"))
            {
                btnNBOK.Visible = false;
                trACKOption.Visible = false;
                trRemarks.Visible = false;
                btnAck.Visible = false;
                btnBack.Visible = false;
            }
        }
    }

    protected void grdViewDetailCommunication_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            trNewCommunication.Visible = true;
            trNoticeBoard.Visible = true;
            int CommCategoryID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CommCategoryID"));
            Session["ReplyCommRoleID"] = Convert.ToInt64(DataBinder.Eval(e.Row.DataItem, "RoleID"));
            Session["ReplyCommLoginID"] = Convert.ToInt64(DataBinder.Eval(e.Row.DataItem, "LoginID"));
            long replyLID = Convert.ToInt64(DataBinder.Eval(e.Row.DataItem, "LoginID"));


            if (CommCategoryID == 0)
            {
                e.Row.BackColor = System.Drawing.Color.White;
            }
            int Commtype = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CommType"));
            Label lbl = (Label)e.Row.FindControl("lblTypeIndicator");
            Image ImgMsgStore = (Image)e.Row.FindControl("ImgMsgStore");
            string sPath = Request.Url.AbsolutePath;
            if (!sPath.Contains("PatientTrackingDetails.aspx"))
            {
                if (replyLID == LID)
                {
                    ImgMsgStore.ImageUrl = "~/Images/Inbox.jpg";
                }
                else
                {
                    ImgMsgStore.ImageUrl = "~/Images/SendItem.jpg";
                }
            }
            if (Commtype == 2)
            {
                string dNB = Resources.CommonControls_ClientDisplay.CommonControls_ViewCommunicationThread_ascx_01;


                lbl.Text = dNB;

                lbl.BackColor = System.Drawing.Color.Orange;
            }
            else
            {
                string dC = Resources.CommonControls_ClientDisplay.CommonControls_ViewCommunicationThread_ascx_02;
                lbl.Text = dC;

                lbl.BackColor = System.Drawing.Color.CadetBlue;
            }

        }
    }

    protected void highlightRow(object sender, GridViewRowEventArgs e)
    {
        int CommId = Convert.ToInt32(e.Row.Cells[1].Text);

    }

    protected void ViewDetailCommunicationlist()
    {
        long CommID = Convert.ToInt64(Session["VCommID"]);
        List<NBCommunicationMaster> lstViewComm = new List<NBCommunicationMaster>();
        Communication_BL InvBL = new Communication_BL(base.ContextInfo);
        lstViewComm = InvBL.ViewCommunication(CommID, OrgID, RoleID, LID);
        if (lstViewComm.Count > 0)
        {
            grdViewDetailCommunication.DataSource = lstViewComm;
            grdViewDetailCommunication.DataBind();
            if (lstViewComm[0].VisitNumber != 0)
            {
                tblVisitdetails.Visible = true;
                hdnVisitNum.Value = lstViewComm[0].VisitNumber.ToString();
                lblVisitNum.Text = lstViewComm[0].VisitNumber.ToString();
                // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "visitNumber", "javascript:GetVistDetails();", true);
                // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "all", "javascript:GetVistDetails();", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:GetVistDetails();", true);
            }
            else
            {
                tblVisitdetails.Visible = false;
                hdnVisitNum.Value = string.Empty;
            }
        }
        var itemMaxHeight = lstViewComm.Max(y => y.CommID);
        Session["LCommID"] = itemMaxHeight;
    }
    public void ViewDetailCommunicationPatientListlist(string strVisitNumber, string ExternalBarcode, out bool flag)
    {

        flag = true;
        NewCommunication.Visible = false;
        tdNewCommunication.Visible = false;
        CommunciationNote.Visible = false;
        NoticeBoard.Visible = false;
        btnNBOK.Visible = false;
        btnNBCancel.Visible = false;
        btnBack.Visible = false;
        tblDisplay.Style.Add("display", "block");

        long returnCode = 0;
        long CommID = Convert.ToInt64(Session["VCommID"]);
        List<NBCommunicationMaster> listCommunication = new List<NBCommunicationMaster>();
        Communication_BL comBL = new Communication_BL(base.ContextInfo);
        returnCode = comBL.GetCommuicationvisitDetails(strVisitNumber, ExternalBarcode, OrgID, out listCommunication);


        if (listCommunication.Count > 0)
        {
            grdViewDetailCommunication.DataSource = listCommunication;
            grdViewDetailCommunication.DataBind();
            var itemMaxHeight = listCommunication.Max(y => y.CommID);
            Session["LCommID"] = itemMaxHeight;
            Session["CommCode"] = "";
        }
        else
        {
            grdViewDetailCommunication.DataSource = null;
            grdViewDetailCommunication.DataBind();
            flag = false;
            Session["LCommID"] = "";
            Session["CommCode"] = "";
        }


    }

    protected void btnNBCancel_Click(object sender, EventArgs e)
    {
        trNoticeBoard.Visible = false;
        lblShowMessage.Text = "";
        Session["ResponseMessage"] = "";
    }

    protected void btnNBOK_Click(object sender, EventArgs e)
    {
        long CommID = Convert.ToInt64(Session["VCommID"]);
        string ACKRequired = Session["ACKRequired"].ToString();
        Communication_BL cb = new Communication_BL(base.ContextInfo);
        cb.UpdateNBCommunicationDetail(CommID, OrgID, LID, ACKRequired, RoleID, txtRemarks.Text);
        trNoticeBoard.Visible = false;
        Response.Redirect("~/Broadcast/ViewCommunication.aspx");
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Session["ResponseMessage"] = "";
        Response.Redirect("~/Broadcast/ViewCommunication.aspx");
    }


    protected void btnAck_Click(object sender, EventArgs e)
    {
        Session["ResponseMessage"] = "Acknowledged successfully!";
        long CommID = Convert.ToInt64(Session["VCommID"]);
        string ACKRequired = Session["ACKRequired"].ToString();
        Communication_BL cb = new Communication_BL(base.ContextInfo);
        cb.UpdateNBCommunicationDetail(CommID, OrgID, LID, ACKRequired, RoleID, txtRemarks.Text);
        ViewDetailCommunicationlist();
        NoticeBoard.Visible = false;
        Response.Redirect("~/Broadcast/ViewDetailCommunication.aspx");
    }

    protected void ShowDetails()
    {
        long CommID = Convert.ToInt64(Session["LCommID"]);
        int CommType = Convert.ToInt16(Session["CommType"]);

        if (CommType == 1)
        {
            NewCommunication.Visible = true;
            NoticeBoard.Visible = false;
        }
        else
        {
            string CommCode = Session["CommCode"].ToString();
            NoticeBoard.Visible = true;
            NewCommunication.Visible = false;
            string NBCode = CommCode;
            lblNBCode.Text = NBCode;
        }

        if (CommID > 0)
        {
            List<NBCommunicationMaster> lstcommunicationdetail = null;
            Communication_BL cb_BL = new Communication_BL();
            lstcommunicationdetail = cb_BL.GetNBCommunication(CommID, OrgID);
            string dFrom = Resources.CommonControls_ClientDisplay.CommonControls_ViewCommunicationThread_ascx_03;
            string dDateFormat = Resources.CommonControls_ClientDisplay.CommonControls_ViewCommunicationThread_ascx_04;

            for (int i = 0; i < lstcommunicationdetail.Count; i++)
            {
                lblSubject.Text = lstcommunicationdetail[i].Subject.ToString();
                lblMessage.Text = lstcommunicationdetail[i].CommContent.ToString();
                lblNBMsgFrom.Text = dFrom + lstcommunicationdetail[i].BroadcastedBy.ToString().ToLower();
                lblParentCommID.Text = lstcommunicationdetail[i].ParentCommID.ToString();
                string format = dDateFormat;
                lblNBSenton.Text = lstcommunicationdetail[i].CreatedAt.ToString(format);

                Label1.Text = lstcommunicationdetail[i].Subject.ToString();
                Label2.Text = lstcommunicationdetail[i].CommContent.ToString();
                lblSentOn.Text = lstcommunicationdetail[i].CreatedAt.ToString(format);
                lblCommMsgFrom.Text = dFrom + lstcommunicationdetail[i].BroadcastedBy.ToString().ToLower();
                if (lstcommunicationdetail[i].AckRequired.Trim().ToString().Equals("N"))
                {
                    btnNBOK.Visible = true;
                    trACKOption.Visible = false;
                    trRemarks.Visible = false;
                    lblNote.Visible = false;
                }
                else
                {
                    btnAck.Visible = true;
                    trACKOption.Visible = true;
                    trRemarks.Visible = true;
                }
            }
        }
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        long CommID = Convert.ToInt64(Session["LCommID"]);
        string ACKRequired = String.Empty;
        Communication_BL cb = new Communication_BL(base.ContextInfo);
        cb.UpdateNBCommunicationDetail(CommID, OrgID, LID, ACKRequired, RoleID, txtRemarks.Text);
        ViewDetailCommunicationlist();
        trNewCommunication.Visible = false;
        if (RoleHelper.Admin != RoleDescription)
        {
            Response.Redirect("~/Broadcast/ViewCommunication.aspx");
        }
        else
        {
            Response.Redirect("~/Broadcast/ViewDetailCommunication.aspx");
        }
    }

    protected void btnReply_Click(object sender, EventArgs e)
    {
        try
        {
            LoadBroadcastInfo();
        }
        catch (Exception ex)
        {
          //  CLogger.LogError("Error in Communication Detail page", ex);
          //  ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "Error while Message Reply, Please contact system administrator.";
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
            chkUsers.DataSource = role;
            chkUsers.DataTextField = "RoleName";
            chkUsers.DataValueField = "RoleID";
            chkUsers.DataBind();
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error in Communication Home page: ", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "Error while loading roles, Please contact system administrator.";
        }
    }

    private void LoadBroadcastInfo()
    {
        try
        {
            Session["ResponseMessage"] = "Reply posted Successfully!";
            //////////////////////////////////////////////////////////////////
            string BRoles = String.Empty;
            int Count = chkUsers.Items.Count;
            //BRoles = chkUsers.Items[1].Value;
            for (int i = 0; i < Count; i++)
            {
                if (chkUsers.Items[i].Value == Session["ReplyCommRoleID"].ToString())
                {
                    BRoles += chkUsers.Items[i].Text + ",";
                }
            }
            BRoles.TrimEnd(',');
            ///////////////////////////////////////////////////////////////////
            List<NBCommunicationDetails> lstCommDetails = new List<NBCommunicationDetails>();
            NBCommunicationDetails obj = new NBCommunicationDetails();
            obj.LoginID = Convert.ToInt64(Session["ReplyCommLoginID"].ToString());
            obj.RoleID = Convert.ToInt32(Session["ReplyCommRoleID"].ToString());
            lstCommDetails.Add(obj);
            NBCommunicationMaster cm = new NBCommunicationMaster();
            long refCommID = Convert.ToInt64(Session["LCommID"]);
            cm.RefCommID = refCommID;
            long parentCommID = Convert.ToInt64(lblParentCommID.Text);
            cm.ParentCommID = (parentCommID == 0) ? refCommID : parentCommID;
            long CommId = 0;
            string CommCode = String.Empty;
            cm.AckRequired = "";
            cm.SendSMS = "";
            cm.PriorityLevel = "";
            cm.CreatedBy = LID;
            cm.RoleID = RoleID;
            //cm.Validity = Convert.ToDateTime(txtFDate.Text);
            cm.BroadcastedBy = UserName.ToString();
            cm.Subject = Label1.Text;
            cm.CommContent = FCKeditor1.Value;
            cm.OrgID = OrgID;
            cm.CommType = 1;
            string ACKRequired = String.Empty;
            Communication_BL InvBL = new Communication_BL(base.ContextInfo);
            string flag = "R";
            InvBL.SaveCommunicationMasterEntry(lstCommDetails, cm, flag, lblVisitNum.Text.ToString(), out CommId, out CommCode);
            InvBL.UpdateNBCommunicationDetail(refCommID, OrgID, LID, ACKRequired, RoleID, "");
            Response.Redirect("~/Broadcast/ViewDetailCommunication.aspx");
        }
        catch (Exception ex)
        {
           //CLogger.LogError("Error in Communication Detail page", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "Error while Message Reply, Please contact system administrator.";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        trNewCommunication.Visible = false;
        lblShowMessage.Text = "";
        Session["ResponseMessage"] = "";
    }
}
