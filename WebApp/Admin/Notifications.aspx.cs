using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using Attune.Utilitie.Helper;
using System.Data;
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;
using System.Text;
using System.ComponentModel;
public partial class Admin_Notifications : BasePage
{
    public Admin_Notifications()
        : base("Admin\\Admin_Notifications.aspx")
    {
    }
    string AlertType = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
    string select = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_01 == null ? "----select-----" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_01;
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<Notifications> lstNotification = new List<Notifications>();
    List<ActionManagerType> lstTaskActions = new List<ActionManagerType>();
    List<NotificationMaster> lstNotificationMaster = new List<NotificationMaster>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<ImageServerDetails> imgServerdetails = new List<ImageServerDetails>();
    List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    Investigation_BL ObjInv;
    long returnCode = -1;
    long returnCd = -1;
    long returnCde = -1;
    int currentPageNo = 1;
    int pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    int menuType = 0;
    long pVisitID = 0;
    int  pCount;
    string patientNumber = string.Empty;
    string DispatchType = string.Empty;
    string investigatgionID = "";
    long Locationid = 0;
    int VisitType = 0;
    string WardName = string.Empty;
    string Status = string.Empty;

    string reportID = string.Empty;
    string reportName = string.Empty;
    string reportPath = string.Empty;	
    ActionManager ObjActionManager;


    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01;
       
    #endregion

    /// <summary>
    /// SSRS Reports
    /// </summary>
    class MyReportServerCredent : IReportServerCredentials
    {
        string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        

        try
        {
            hdnCurrent.Value = "";

            if (!IsPostBack)
            {
                AutoCompleteExtenderClientCorp.ContextKey = "0^0";
                AutoCompleteExtenderzone.ContextKey = "zone" + "~" + "-1";

                AutoCompleteExtenderRptCollectCenter.ContextKey = "0^0";
             
    
               //Location
                GetALLLocation();
                LoadActionType();
                //Notification Status
                LoadMetaData();
                NotificationGetReports(currentPageNo, pageSize);

                hdnActionGo.Value = "0";
                hdnClientID.Value = "";
                hdnReportClientID.Value = "";
                HdnNotoficationCheckBoxId.Value = "";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occur in Admin_Notifications_Page_Load", ex);
        }
    }

   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            HdnNotoficationCheckBoxId.Value = "";
            HdnNotificationDropDownId.Value  = "";
            HdnNotificationLableId.Value = "";
            NotificationGetReports(currentPageNo, pageSize);
            hdnActionGo.Value = "0";
            hdnClientID.Value = "";
            hdnReportClientID.Value = "";
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnSearch_Click Admin_Notification", ex);
        }
       
    }  
 
    /// <summary>
    /// Btn_Next_Click Event
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnCurrent.Value != "")
            {
                currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }
            else
            {
                currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }
            HdnNotoficationCheckBoxId.Value = "";
            NotificationGetReports(currentPageNo, pageSize);           
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CreateDespatchMode", ex);
        }
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        try
        {
            int ar = 0;
            hdnCurrent.Value = txtpageNo.Text;
            if (txtpageNo.Text != "")
            {
                ar = Convert.ToInt32(txtpageNo.Text);
            }
            else
            {
                return;
            }
            if (ar != 0)
            {
                HdnNotoficationCheckBoxId.Value = "";
                NotificationGetReports(Convert.ToInt32(txtpageNo.Text), pageSize);
                
            }
            txtpageNo.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnGo_Click1", ex);
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnCurrent.Value != "")
            {
                currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }
            else
            {
                currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }
            HdnNotoficationCheckBoxId.Value = "";
            NotificationGetReports(currentPageNo, pageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Btn_Previous_Click", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {

            hdnActionGo.Value = "1";

            if (ddlVisitActionName.SelectedItem.Text == "Edit Notification")
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("NotificationID");
                dt.Columns.Add("Status");

                foreach (GridViewRow row in grdResult.Rows)
                {

                    Label lblStatus = row.FindControl("lblStatusinGrid") as Label;
                    DropDownList ddlStatus = row.FindControl("ddlStatusinGrid") as DropDownList;
                    string Status = ddlStatus.SelectedItem.Text;

                    if (((row.Cells[0].FindControl("chkSel") as CheckBox).Checked) && ((row.Cells[0].FindControl("lblStatusinGrid") as Label).Text != "Completed"))
                    {
                        lblStatus.Visible = false;
                        ddlStatus.Visible = true;
                    }
                    else
                    {
                        lblStatus.Visible = true;
                        ddlStatus.Visible = false;
                    }
                }
            }
            if (ddlVisitActionName.SelectedItem.Text == "Update Notification")
            {
                List<Notifications> lstNotifiStatusUpdate = new List<Notifications>();
                DataTable dt = new DataTable();
                dt.Columns.Add("NotificationID");
                dt.Columns.Add("Status");

                foreach (GridViewRow row in grdResult.Rows)
                {

                    Label lblStatus = row.FindControl("lblStatusinGrid") as Label;
                    DropDownList ddlStatus = row.FindControl("ddlStatusinGrid") as DropDownList;
                    string Status = ddlStatus.SelectedItem.Text;

                    if (((row.Cells[0].FindControl("chkSel") as CheckBox).Checked) && ((row.Cells[0].FindControl("lblStatusinGrid") as Label).Text != "Completed"))
                    {
                        lblStatus.Visible = true;
                        ddlStatus.Visible = false;
                        DataRow dr = dt.NewRow();
                        dr["NotificationID"] = row.Cells[3].Text;
                        dr["Status"] = Status;
                        dt.Rows.Add(dr);

                    }
                }

                lstNotifiStatusUpdate = (from DataRow row in dt.Rows
                                         select new Notifications
                                         {
                                             NotificationID = Convert.ToInt32(row["NotificationID"]),
                                             Status = row["Status"].ToString()

                                         }).ToList();

                if (dt.Rows.Count > 0)
                {

                    //UpdateNotificationStatus
                    returnCode = new Master_BL(base.ContextInfo).UpdateNotificationStatus(lstNotifiStatusUpdate);
                    NotificationGetReports(currentPageNo, pageSize);
                   
                  //  ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "ClearSearchFields()", false);
                    Response.Redirect("../Admin/Notifications.aspx", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "<script>alert('Please Select a Notification')</script>", false);

                }
            }
            if (ddlVisitActionName.SelectedItem.Text == "Cancel Notification")
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "validate", "ClearSearchFields()", false);
                NotificationGetReports(currentPageNo, pageSize);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while btnGo_Click Admin_Notification", ex);
        }

    }
    protected void grdResult_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string lbldispstatusGrid = string.Empty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Find the DropDownList in the Row

                DropDownList ddlStatusinGrid = (e.Row.FindControl("ddlStatusinGrid") as DropDownList);
                Label lblStatusinGrid = (e.Row.FindControl("lblStatusinGrid") as Label);

                CheckBox chk = (CheckBox)e.Row.FindControl("chkSel");
                chk.Attributes["onclick"] = string.Format("EnableDisableDropDownList(this, '{0}','{1}');", ddlStatusinGrid.ClientID, lblStatusinGrid.ClientID);

                long returncode = -1;
                string domains = "NotificationStatus";
                string[] Tempdata = domains.Split(',');
                string LangCode = "en-GB";
                List<MetaData> lstmetadataInputs = new List<MetaData>();
                List<MetaData> lstmetadataOutputs = new List<MetaData>();
                MetaData objMeta;

                for (int i = 0; i < Tempdata.Length; i++)
                {
                    objMeta = new MetaData();
                    objMeta.Domain = Tempdata[i];
                    lstmetadataInputs.Add(objMeta);
                }
                returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
                if (lstmetadataOutputs.Count > 0)
                {
                    var childItems = from child in lstmetadataOutputs
                                     where child.Domain == "NotificationStatus"
                                     select child;
                    if (childItems.Count() > 0)
                    {
                        ddlStatusinGrid.DataSource = childItems;
                        ddlStatusinGrid.DataTextField = "DisplayText";
                        ddlStatusinGrid.DataValueField = "Code";
                        ddlStatusinGrid.DataBind();
                        ddlStatusinGrid.Items.Remove("Completed");
                    }
                }

                Label lblstatusGrid = (e.Row.FindControl("lblStatusinGrid") as Label);

                /*Added for Confidentiality Report based on Role*/
                Investigation_BL InvestigationBL = new Investigation_BL();
                string value = string.Empty;
                Label lblPatientVisitId = (e.Row.FindControl("lblPatientVisitId") as Label);
                string RoleConfidential = Session["Showconfidential"] != null ? Session["Showconfidential"].ToString() : "";
                value = InvestigationBL.PGetConfidential(Convert.ToInt64((lblPatientVisitId.Text)));



                lbldispstatusGrid = lblstatusGrid.Text;

                NotificationMaster objNotifications = (NotificationMaster)e.Row.DataItem;
                if (objNotifications.Status == "Completed" || objNotifications.Status == "Inactive")
                {
                    ((CheckBox)e.Row.Cells[0].FindControl("chkSel")).Enabled = false;
                    ((ImageButton)e.Row.Cells[0].FindControl("Image1")).Enabled = true;

                }

                if (HdnNotoficationCheckBoxId.Value == "")
                {
                    if (((CheckBox)e.Row.FindControl("chkSel")).Enabled == true)
                    {

                        HdnNotoficationCheckBoxId.Value = ((CheckBox)e.Row.FindControl("chkSel")).ClientID;

                        HdnNotificationDropDownId.Value = ((DropDownList)e.Row.FindControl("ddlStatusinGrid")).ClientID;
                        HdnNotificationLableId.Value = ((Label)e.Row.FindControl("lblStatusinGrid")).ClientID;
                    }
                }
                else
                {
                    if (((CheckBox)e.Row.FindControl("chkSel")).Enabled == true)
                    {
                        HdnNotoficationCheckBoxId.Value += '~' + ((CheckBox)e.Row.FindControl("chkSel")).ClientID;
                        HdnNotificationDropDownId.Value += '~' + ((DropDownList)e.Row.FindControl("ddlStatusinGrid")).ClientID;
                        HdnNotificationLableId.Value += '~' + ((Label)e.Row.FindControl("lblStatusinGrid")).ClientID;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while grdResult_OnRowDataBound Admin_Notification", ex);
        }

    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string fileExtension = string.Empty;
            if (e.CommandName == "ShowWithStationary" || e.CommandName == "ShowWithoutStationary")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                string visitid = grdResult.Rows[RowIndex].Cells[4].Text;
                long pVisitID = -1;
                long returnCode = -1;
                long PatientID = -1;
                string dPatientID = string.Empty;
                string lblPatientVisitId = (grdResult.Rows[RowIndex].FindControl("lblPatientVisitId") as Label).Text;

                pVisitID = Convert.ToInt64(lblPatientVisitId);

                /*Conf Patient*/
                Investigation_BL InvestigationBL = new Investigation_BL();
                string value = string.Empty;
                string RoleConfidential = Session["Showconfidential"] != null ? Session["Showconfidential"].ToString() : "";
                value = InvestigationBL.PGetConfidential(Convert.ToInt64((lblPatientVisitId).ToString()));
              //  if (Session["Showconfidential"].ToString() == "N" && value == "Y")
                if (RoleConfidential == "N" && value == "Y")
                {
                    string strMsg = "You are not allowed to view the patient report though it has been marked as Confidential";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strMsg + "','" + AlertType + "');", true);
                }
                else
                {
                    Int64.TryParse(dPatientID, out PatientID);
                    string ReportType = Convert.ToString(grdResult.DataKeys[RowIndex]["ReportType"]);
                    //Added by Radha - as part of Single Report functionality  -START
                    long NotificationID = Convert.ToInt64(grdResult.DataKeys[RowIndex]["NotificationID"]);

                    string lblActionType = (grdResult.Rows[RowIndex].FindControl("lblActionType") as Label).Text;
                    Boolean boolActionType = true;
                    if (lblActionType == "Without Stationary")
                    {
                        boolActionType = false;
                    }
                    //Added by Radha - END

                    Report_BL objReportBL = new Report_BL(base.ContextInfo);
                    Investigation_BL obj = new Investigation_BL(base.ContextInfo);

                    string strInvStatus = InvStatus.Approved;
                    List<string> lstInvStatus = new List<string>();
                    lstInvStatus.Add(strInvStatus);
                    List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
                    List<OrderedInvestigations> _PendingInvestigations = new List<OrderedInvestigations>();
                    string PDFPath = string.Empty;
                    string Status = string.Empty;
                    string AccessionNumber = string.Empty;

                    if (e.CommandName == "ShowWithStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshotNotifications(OrgID, NotificationID, ILocationID, pVisitID, boolActionType, ReportType, out lstReportSnapshot);
                    }
                    if (e.CommandName == "ShowWithoutStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshotNotifications(OrgID, NotificationID, ILocationID, pVisitID, false, ReportType, out lstReportSnapshot);
                    }


                    string strRepoartNotReady = Resources.Investigation_AppMsg.Investigation_InvestigationReport_aspx_32 == null ? "Report is not ready" : Resources.Investigation_AppMsg.Investigation_InvestigationReport_aspx_32;
                    if (lstReportSnapshot.Count > 0)
                    {
                        //Commented THe below Code - Information from Dhana
                        //if (!String.IsNullOrEmpty(lstReportSnapshot[0].AccessionNumber) && lstReportSnapshot[0].AccessionNumber.Length > 0)
                        //{

                        //    AccessionNumber = lstReportSnapshot[0].AccessionNumber;
                        //}

                        //returnCode = obj.GetOrderedInvStatus(pVisitID, OrgID, AccessionNumber, out lstOrderedInvestigations);
                        //_PendingInvestigations = (from IL in lstOrderedInvestigations
                        //                          where IL.Status != InvStatus.Approved && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.Completed
                        //                          select IL).Distinct().ToList();
                        //if (_PendingInvestigations.Count > 0)
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strRepoartNotReady + "','" + AlertType + "');", true);
                        //}
                        //else
                        if (lstReportSnapshot[0].ReportPath.Length > 0)
                        {

                            PDFPath = lstReportSnapshot[0].ReportPath;

                        }
                        //}
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strRepoartNotReady + "','" + AlertType + "');", true);
                        }
                    }

                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strRepoartNotReady + "','" + AlertType + "');", true);

                    }

                    if (!String.IsNullOrEmpty(PDFPath) && PDFPath.Length > 0)
                    {

                        string CurrentOrgID = OrgID.ToString();
                        string filePath = PDFPath;
                        string _ShowToolBar = "1";

                        if (e.CommandName == "ShowWithoutStationary")
                        {
                            modalPopUp.Show();
                            ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath + "#toolbar=" + _ShowToolBar);
                        }
                        else
                        {

                            modalPopUp.Show();
                            ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath + "#toolbar=" + _ShowToolBar);

                        }
                    }
                    else
                    {
                        modalPopUp.Hide();
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strRepoartNotReady + "','" + AlertType + "');", true);
                    }
                }
            }
            else
            {

                if (HdnID.Value != string.Empty)
                {
                    if (HdnID.Value != e.CommandArgument.ToString())
                    {
                        int rID = Convert.ToInt32(HdnID.Value);
                        HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                        ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                        imgBTN.ImageUrl = "~/Images/plus.png";
                        Div1.Style.Add("display", "none");
                    }
                }

                if (e.CommandArgument.ToString() != "")
                {
                    int A = 0;
                    ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
                    imgBTN.ImageUrl = "~/Images/minus.png";
                    TextBox visitid = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientvisitId");
                    HtmlControl Div = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
                    string[] str = (Div.Attributes["style"].ToString()).Split(';');
                    if (str[0] == "display:block")
                    {
                        Div.Style.Add("display", "none");
                        imgBTN.ImageUrl = "~/Images/plus.png";
                    }
                    else
                    {
                        Div.Style.Add("display", "block");
                        A = A + 2;
                    }

                }
                HdnID.Value = e.CommandArgument.ToString();
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
        }

    }
    /// <summary>
    /// 
    /// </summary>
    public void LoadMetaData()
    {
        try
        {

            long returncode = -1;
            string domains = "NotificationStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInputs.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "NotificationStatus"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddstatus.DataSource = childItems;
                    ddstatus.DataTextField = "DisplayText";
                    ddstatus.DataValueField = "Code";
                    ddstatus.DataBind();
                    ddstatus.Items.Insert(0, select);


                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Admin_Notifications", ex);

        }
    }

    /// <summary>
    /// NotificationGetReports
    /// </summary>
    /// <param name="currentPageNo"></param>
    /// <param name="PageSize"></param>
    public void NotificationGetReports(int currentPageNo, int PageSize)
    {
        try
        {

            string Name = null;
            string LabNumber = (string.IsNullOrEmpty(txtLabNo.Text) ? null : txtLabNo.Text);
            string ActionType = null;
            string Status = null;           
            string Location = null;
            string Reason = null;
            string ReportType = null;
            string ClientNames = hdnClientID.Value; //hdnClientID.Value;          
            string ReportingCenters = hdnReportClientID.Value; //hdnReportClientID.Value;
            string CreatedFromDate = (string.IsNullOrEmpty(TextBox2.Text) ? null : TextBox2.Text);
            string CreatedToDate = (string.IsNullOrEmpty(TextBox3.Text) ? null : TextBox3.Text);
            string Zone = (string.IsNullOrEmpty(txtzone.Text) ? null : txtzone.Text);
            string ClientName = (string.IsNullOrEmpty(ClientNames) ? null : ClientNames);
            string ReportingCenter = (string.IsNullOrEmpty(ReportingCenters) ? null : ReportingCenters);
           
            if (ddActionType.SelectedItem.Text != "----select-----")
            {
                ActionType = ddActionType.SelectedItem.Text;
            }

            if (ddstatus.SelectedItem.Text != "----select-----")
            {
                Status = ddstatus.SelectedItem.Text;
                if (Status=="Pending")
                {
                    Status = "";
                }
            }

            if (ddlocation.SelectedItem.Text != "----select-----")
            {
                Location = ddlocation.SelectedItem.Text;
            }

            returnCode = new Master_BL(base.ContextInfo).GetNotificationDetails(Name, LabNumber, ActionType, Status, Location, ClientName, Reason, CreatedFromDate, CreatedToDate, ReportingCenter, ReportType, Zone, currentPageNo, pageSize, out totalRows, out lstNotificationMaster);

            //Visibility
            if (lstNotificationMaster.Count > 0)
            {
                grdResult.DataSource = lstNotificationMaster;
                grdResult.DataBind();
                
                tblgrdview.Style.Add("display", "table");
                tblindv.Attributes.Add("style", "table");
                trFooter.Attributes.Add("style", "display:table-row;");
                divFooterNav.Attributes.Add("style", "display:block;");
                tblpage.Attributes.Add("style", "display:table-row;");                
                trSelectVisit.Attributes.Add("style", "display:table-row;");
                trSelectVisit.Visible = true;
            }
            else
            {
              DataTable dt=  ToDataTable(lstNotificationMaster);
                dt.Rows.Add(dt.NewRow());
                grdResult.DataSource = dt;
                grdResult.DataBind();
              
                int columncount = grdResult.Rows[0].Cells.Count;
                    grdResult.Rows[0].Cells.Clear();
                    grdResult.Rows[0].Cells.Add(new TableCell());
                    grdResult.Rows[0].Cells[0].ColumnSpan = columncount;
                    grdResult.Rows[0].Cells[0].Text = "No Records Found";


                trSelectVisit.Attributes.Add("style", "display:none;");
                trFooter.Attributes.Add("style", "display:none;");
                tblpage.Attributes.Add("style", "display:none;");
                divFooterNav.Attributes.Add("style", "display:none;");

            }

            GetNotificationActionItems();

            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentPageNo == 1)
            {
                Btn_Previous.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                {
                    Btn_Next.Enabled = false;
                }
            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while NotificationGetReports Admin_Notification", ex);
        }

    }

    public DataTable ToDataTable<T>(IList<T> data)// T is any generic type
    {
        PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));

        DataTable table = new DataTable();
        for (int i = 0; i < props.Count; i++)
        {
            PropertyDescriptor prop = props[i];
            table.Columns.Add(prop.Name, prop.PropertyType);
        }
        object[] values = new object[props.Count];
        foreach (T item in data)
        {
            for (int i = 0; i < values.Length; i++)
            {
                values[i] = props[i].GetValue(item);
            }
            table.Rows.Add(values);
        }
        return table;
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / pageSize);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }

   

    public void GetNotificationActionItems()
    {
        menuType = Convert.ToInt32(TaskHelper.SearchType.NotificationSearch);
        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
        returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, menuType, out lstVisitSearchAction);
        if (lstActionMaster.Count > 0)
        {
            ddlVisitActionName.DataSource = lstActionMaster;
            ddlVisitActionName.DataTextField = "ActionName";
            ddlVisitActionName.DataValueField = "ActionCode";
            ddlVisitActionName.DataBind();
            ddlVisitActionName.Items.Insert(0, select);
         
           
        }

    }

    /// <summary>
    /// Loading Action Type
    /// </summary>
    public void LoadActionType()
    {

        //Active Type                
        returnCde = new Master_BL(base.ContextInfo).GetActionType(RoleID, out lstTaskActions);
        ddActionType.DataSource = lstTaskActions;
        ddActionType.DataTextField = "ActionType";
        ddActionType.DataValueField = "ActionTypeID";
        ddActionType.DataBind();
        ddActionType.Items.Insert(0, select);

    }


    /// <summary>
    /// Get All Locations
    /// </summary>
    public void GetALLLocation()
    {

        returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
        // lAddress = lAddress.FindAll(p => p.AddressID == ILocationID);
        ddlocation.DataSource = lAddress;
        ddlocation.DataTextField = "City";
        ddlocation.DataValueField = "AddressID";
        ddlocation.DataBind();
        ddlocation.Items.Insert(0, select);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Admin/Notifications.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
   
}

