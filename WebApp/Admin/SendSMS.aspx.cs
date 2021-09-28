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
using System.Linq;
using Attune.Podium.PerformingNextAction;

public partial class Admin_SendSMS : BasePage
{
    ActionManager objActionManager;
    ArrayList al = new ArrayList();
    string Filters = "Filters";
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    int currentPageNo = 1;
    int _pageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            loadOrganization();
            if (!IsPostBack)
            {
                LoadMetaData();
                if (ddlOrganization.Items.Count > 0)
                {

                    ddlOrganization.SelectedValue = "0";
                    //ddlRegisterDate.SelectedValue = "0";
                    //LoadLocations();
                    //LoadRecipientList();
                    LoadSMSTemplateList();
                    chkEnterMobileNo.Attributes.Add("onclick", "ShowMobileTextBox();");
                    txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
                    txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
                    //lblSMSTemplate.Text="Enter Comma ( , ) separated Mobile Numbers"+Environment.NewLine+" and Give 10 digit Number";
                }
            }
            #region Drop Down Date
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");


            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day



            hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

            #region lastmonth
            DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
            hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
            dtlm = dtlm.AddMonths(1);
            hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
            #endregion

            #region lastweek
            DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime LwkStDt = DateTime.MinValue;
            DateTime LwkEndDt = DateTime.MinValue;
            hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
            hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

            #endregion

            #region lastYear
            DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string tempyear = dt2.AddYears(-1).ToString();
            string[] tyear = new string[5];
            tyear = tempyear.Split('/', '-');
            tyear = tyear[2].Split(' ');
            hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
            hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
            #endregion
            //if (ViewState["SelectedPatients"] != null)
            //{
            //    al = (ArrayList)ViewState["SelectedPatients"];
            //}
            #endregion
            hdnOrgID.Value = Convert.ToString(OrgID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page_Load", ex);
        }
    }

    public void loadOrganization()
    {
        try
        {
            long Returncode = -1;
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrg = new List<Organization>();
            Returncode = objBl.pGetOrgLoction(out lstOrg);
            if (lstOrg.Count > 0)
            {
                ddlOrganization.DataSource = lstOrg;
                ddlOrganization.DataTextField = "Name";
                ddlOrganization.DataValueField = "OrgID";
                ddlOrganization.DataBind();
                ddlOrganization.SelectedValue = Convert.ToString(OrgID);
            }
            else
            {
                ddlOrganization.DataSource = null;
                ddlOrganization.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadOrganization", ex);
        }
    }
    //First Tab search
    private void LoadRecipientList(int currentPageNo, int PageSize)
    {
        hdntabs.Value = "Tab1";
        string bday = "N";
        if (chkbday.Checked)
        {
            bday = "Y";
        }
        long ReturnCode = -1;
        Patient_BL objBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstRecipients = new List<Patient>();
        string Types = "N";
        string strClientList = "N";
        string strPatientList = "N";
        DateTime FromDate = Convert.ToDateTime("01/01/1753 12:00:00");
        DateTime ToDate = DateTime.Now;
        if (txtFrom.Text != "")
        { 
         FromDate = Convert.ToDateTime(txtFrom.Text);
        }
        if (txtTo.Text != "")
        {
         ToDate = Convert.ToDateTime(txtTo.Text);
        }
        if (chkUserList.Checked)
        {
            Types = "U";
        }
        if (chkClientList.Checked)
        {
            Types = "C";
        }
        if (chkPatientList.Checked)
        {
            Types = "P";
        }
        if (chkHospital.Checked)
        {
            Types = "H";
        }
        if (chkdoctors.Checked)
        {
            Types = "D";
            divbday.Style.Add("display", "block");
        }
        if (chktests.Checked)
        {
            Types = "T";
        }
        if (chkvisitno.Checked)
        {
            Types = "V";
        }
        else
        {
            divbday.Style.Add("display", "none");
        }
        hdnPatientTypeSearch.Value = Types;

        ReturnCode = objBL.GetSMSRecipientsList(OrgID, txtsearchothers.Text, Types, txtsearchothers.Text, bday, out lstRecipients, currentPageNo, PageSize,FromDate ,ToDate, out totalRows);
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
        if (lstRecipients.Count > 0)
        {
            gvwNameList.DataSource = lstRecipients;
            gvwNameList.DataBind();
            lblNameList.Visible = true;
            //gvwNameList.Columns[5].Visible = false;
            divFooterNav.Visible = true;
            //trMobileNoList2.Attributes.Add("style", "display:block"); 
            //txtSubject.Visible = true;
            string str = drpnotification.SelectedValue;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumbe", "  javascript:DisplayTabMenu('PWS','" + str + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumberest", "  javascript:Checks();", true);
        }
        else
        {
            gvwNameList.DataSource = null;
            gvwNameList.DataBind();
            lblNameList.Visible = false;
            divFooterNav.Visible = false;
        }
    }
    protected void gvwNameList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            //AddToViewState();
            SaveCheckedValues();
            if (e.NewPageIndex != -1)
            {
                gvwNameList.PageIndex = e.NewPageIndex;
            }

            //LoadRecipientList();
            tabs(hdntabs.Value);
            PopulateCheckedValues();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in gvwNameList_PageIndexChanging()", ex);
        }
    }
    private void LoadSMSTemplateList()
    {
        long ReturnCode = -1;
        Patient_BL objBL = new Patient_BL(base.ContextInfo);
        List<ActionTemplate> lstSMSTemplates = new List<ActionTemplate>();
        ReturnCode = objBL.GetSMSTemplateList(out lstSMSTemplates);
        gvwSMSTemplate.DataSource = lstSMSTemplates;
        gvwSMSTemplate.DataBind();
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        try
        {
            objActionManager = new ActionManager(base.ContextInfo);
            string strMobileNos = string.Empty;
            string strSMSTemplate = string.Empty;
            string StrEmailIDs = string.Empty;
            List<NotificationAudit> lstNotifysms = new List<NotificationAudit>();
            List<NotificationAudit> lstNotifyEmail = new List<NotificationAudit>();
            NotificationAudit NotifySms;
            NotificationAudit NotifyEmail;
            if (!chkEnterMobileNo.Checked)
            {
                if (hdnmobileNos.Value != "")
                {
                    var sup = hdnmobileNos.Value.Split('^');
                    for (int i = 0; i < sup.Length; i++)
                    {

                        if (sup[i] != "")
                        {
                            var ps = sup[i].Split('~')[1];
                            var email = sup[i].Split('~')[2];
                            if (ps != "")
                            {
                                #region Notify SMS Information added to list
                                strMobileNos = strMobileNos + ',' + ps.Trim().ToString();
                                NotifySms = new NotificationAudit();
                                NotifySms.Message = txtSubject.Text.Trim();
                                NotifySms.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifySms.ContactInfo = sup[i].Split('~')[1];
                                NotifySms.NotificationTypes = "SMS";
                                NotifySms.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifySms.ReceiverType = "Patient Due";
                                }
                                lstNotifysms.Add(NotifySms);
                                #endregion
                            }
                            if (email != "")
                            {
                                #region Email Information Added to List
                                StrEmailIDs = StrEmailIDs + ',' + email.Trim().ToString();
                                NotifyEmail = new NotificationAudit();
                                NotifyEmail.Message = txtSubject.Text.Trim();
                                NotifyEmail.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifyEmail.ContactInfo = sup[i].Split('~')[2];
                                NotifyEmail.NotificationTypes = "EMail";
                                NotifyEmail.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifyEmail.ReceiverType = "Patient Due";
                                }
                                lstNotifyEmail.Add(NotifyEmail);
                                #endregion
                            }
                        }
                    }
                }
                if (hdnClientMobile.Value != "")
                {
                    var sup = hdnClientMobile.Value.Split('^');
                    for (int i = 0; i < sup.Length; i++)
                    {
                        if (sup[i] != "")
                        {
                            var ps = sup[i].Split('~')[1];
                            var email = sup[i].Split('~')[2];
                            if (ps != "")
                            {
                                #region Notify SMS Information added to list
                                strMobileNos = strMobileNos + ',' + ps.Trim().ToString();
                                NotifySms = new NotificationAudit();
                                NotifySms.Message = txtSubject.Text.Trim();
                                NotifySms.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifySms.ContactInfo = sup[i].Split('~')[1];
                                NotifySms.NotificationTypes = "SMS";
                                NotifySms.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifySms.ReceiverType = "Patient Due";
                                }
                                lstNotifysms.Add(NotifySms);
                                #endregion

                            }
                            if (email != "")
                            {
                                #region Email Information Added to List
                                StrEmailIDs = StrEmailIDs + ',' + email.Trim().ToString();
                                NotifyEmail = new NotificationAudit();
                                NotifyEmail.Message = txtSubject.Text.Trim();
                                NotifyEmail.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifyEmail.ContactInfo = sup[i].Split('~')[2];
                                NotifyEmail.NotificationTypes = "EMail";
                                NotifyEmail.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifyEmail.ReceiverType = "Patient Due";
                                }
                                lstNotifyEmail.Add(NotifyEmail);
                                #endregion
                            }
                        }
                    }
                }
                if (hdnRefDocMobile .Value != "")
                {
                    var sup = hdnRefDocMobile.Value.Split('^');
                    for (int i = 0; i < sup.Length; i++)
                    {
                        if (sup[i] != "")
                        {
                            var ps = sup[i].Split('~')[1];
                            var email = sup[i].Split('~')[2];
                            if (ps != "")
                            {
                                #region Notify SMS Information added to list
                                strMobileNos = strMobileNos + ',' + ps.Trim().ToString();
                                NotifySms = new NotificationAudit();
                                NotifySms.Message = txtSubject.Text.Trim();
                                NotifySms.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifySms.ContactInfo = sup[i].Split('~')[1];
                                NotifySms.NotificationTypes = "SMS";
                                NotifySms.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifySms.ReceiverType = "Patient Due";
                                }
                                lstNotifysms.Add(NotifySms);
                                #endregion

                            }
                            if (email != "")
                            {
                                #region Email Information Added to List
                                StrEmailIDs = StrEmailIDs + ',' + email.Trim().ToString();
                                NotifyEmail = new NotificationAudit();
                                NotifyEmail.Message = txtSubject.Text.Trim();
                                NotifyEmail.Id = Convert.ToInt64(sup[i].Split('~')[0]);
                                NotifyEmail.ContactInfo = sup[i].Split('~')[2];
                                NotifyEmail.NotificationTypes = "EMail";
                                NotifyEmail.ReceiverType = "Patient";
                                if (drpserviceType.SelectedValue == "Due")
                                {
                                    NotifyEmail.ReceiverType = "Patient Due";
                                }
                                lstNotifyEmail.Add(NotifyEmail);
                                #endregion
                            }
                        }
                    }
                }
            }
            else
            {
                #region Send BulkSMS in third Tab
                strMobileNos = txtMobileNo.Text.Trim();
                #endregion
            }

            #region Send SMS/Email based on Notification

            if (drpnotification.SelectedValue == "S")
            {

                String URL = string.Empty;
                
                objActionManager.GetSMSConfig(OrgID, out URL);
                long returnCode = -1;
                strSMSTemplate = txtSubject.Text.Trim();
                string strLocationTemp = LocationName.ToUpper();
                strSMSTemplate = strSMSTemplate.Replace("{OrgName}", OrgName);
                strSMSTemplate = strSMSTemplate.Replace("{OrgAddress}", strLocationTemp);
                if (hdnClientMobile.Value == "" && hdnmobileNos.Value == "")
                {
                    var mobno = strMobileNos.Split(',');
                    for (int i = 0; i < mobno.Count(); i++)
                    {
                        NotifySms = new NotificationAudit();
                        NotifySms.ContactInfo = mobno[i];
                        NotifySms.Message = strSMSTemplate;
                        NotifySms.ReceiverType = "Chat";
                        NotifySms.NotificationTypes = "SMS";
                        lstNotifysms.Add(NotifySms);
                    }
                }
                if (strMobileNos != "")
                {
                    var mobno1 = strMobileNos.Split(',');
                    for (int i = 0; i < mobno1.Count(); i++)
                    {
                        //NotifySms = new NotificationAudit();
                        //NotifySms.ContactInfo = mobno1[i];
                        //NotifySms.Message = strSMSTemplate;
                        //NotifySms.ReceiverType = "Chat";
                        //NotifySms.NotificationTypes = "SMS";
                        //lstNotifysms.Add(NotifySms);
                        Communication.SendSMS(URL, strSMSTemplate, (mobno1[i]));
                    }
                }
               // Communication.SendSMS(URL, strSMSTemplate, (strMobileNos.TrimStart(',')).TrimEnd(','));
                strMobileNos = "";
                Patient_BL Patsms = new Patient_BL(base.ContextInfo);
                
                returnCode = Patsms.insertNotificationAudit(OrgID, ILocationID, LID, lstNotifysms);
                if (returnCode >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Sendsms", "alert('SMS sent successfully');", true);

                }
            }
            else
            {
                List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
                MailAttachment objMailAttachment = new MailAttachment();
                MailConfig oMailConfig = new MailConfig();
                objActionManager.GetEMailConfig(OrgID, out oMailConfig);
                Communication.SendMail((StrEmailIDs.TrimStart(',')).TrimEnd(','), string.Empty, string.Empty, "Dear Client",
                                                                txtSubject.Text.Trim(), lstMailAttachment, oMailConfig);
                long returnCode = -1;
                Patient_BL Patsms = new Patient_BL(base.ContextInfo);
                returnCode = Patsms.insertNotificationAudit(OrgID, ILocationID, LID, lstNotifyEmail);
                               //returnCode = Patsms.insertNotificationAudit(OrgID, ILocationID, LID, lstNotifysms);
                if (returnCode >= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Sendsms", "alert('Email sent successfully');", true);
                }
            }
            #endregion

            chkEnterMobileNo.Checked = false;
            txtMobileNo.Text = "";
            txtSubject.Text = "";

            foreach (GridViewRow row2 in gvwNameList.Rows)
            {
                CheckBox chkSelNL2 = new CheckBox();
                chkSelNL2 = (CheckBox)row2.FindControl("chkSelect");
                chkSelNL2.Checked = false;
            }
            foreach (GridViewRow row3 in gvwSMSTemplate.Rows)
            {
                RadioButton rb2 = new RadioButton();
                rb2 = (RadioButton)row3.FindControl("rbSelectTL");
                rb2.Checked = false;
            }
            ViewState["SelectedPatients"] = "";
            hdnClientMobile.Value = "";
            hdnRefDocMobile.Value = "";
            hdnmobileNos.Value = "";
            ScriptManager.RegisterStartupScript(this, GetType(), "ClearAdvPatientserach", "ClearAdvPatientserach();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error btnSend_Click()", ex);
        }
    }


    protected void gvwNameList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string PatientID = string.Empty;
        string MobileNumber = string.Empty;
        try
        {
            if (hdnSearchType.Value == "PWS" || hdnSearchType.Value == "")
            {
                if (e.Row.RowType == DataControlRowType.Header)
                {
                    if (hdnPatientTypeSearch.Value == "C")
                    {
                        e.Row.Cells[2].Text = "Client Code";
                    }
                    else if (hdnPatientTypeSearch.Value == "U")
                    {
                        e.Row.Cells[2].Text = "User Id";
                    }
                    else if (hdnPatientTypeSearch.Value == "H")
                    {
                        e.Row.Cells[2].Text = "Ref Hospital Code";
                    }
                    else if (hdnPatientTypeSearch.Value == "D")
                    {
                        e.Row.Cells[2].Text = "Ref Doctor Code";
                    }
                     else if (hdnPatientTypeSearch.Value == "P")
                     {
                         e.Row.Cells[2].Text = "Visit Date";
                     }
                     else if (hdnPatientTypeSearch.Value == "T")
                     {
                         e.Row.Cells[2].Text = "Visit Date";
                         e.Row.Cells[3].Text = "Test Name";
                         e.Row.Cells[24].Text = "Name";
                     }
                }
                
                e.Row.Cells[7].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
                if (hdnPatientTypeSearch.Value == "P")
                {
                    e.Row.Cells[1].Visible = true;
                    
                }
                if (hdnPatientTypeSearch.Value == "T")
                {
                    e.Row.Cells[1].Visible = true;
                    e.Row.Cells[24].Visible = true;
                   

                }
                if (hdnPatientTypeSearch.Value != "P")
                {
                    if (hdnPatientTypeSearch.Value != "T")
                    {
                    e.Row.Cells[1].Visible = false;
                    e.Row.Cells[7].Visible = false;
                    e.Row.Cells[8].Visible = false;
                    e.Row.Cells[23].Visible = false;
                    }
                }
                if (hdnPatientTypeSearch.Value == "V" )
                {
                    e.Row.Cells[2].Visible = false;
                    e.Row.Cells[7].Visible = true;
                    e.Row.Cells[8].Visible = true;
                    e.Row.Cells[23].Visible = true;
                    //e.Row.Cells[24].Visible = true;
                    e.Row.Cells[24].Visible = true;
                    e.Row.Cells[25].Visible = true;
                    e.Row.Cells[1].Visible = true;

                }
                if (hdnPatientTypeSearch.Value != "V")
                {
                    if (hdnPatientTypeSearch.Value != "T")
                    {
                        e.Row.Cells[24].Visible = false;
                    }
                    e.Row.Cells[25].Visible = false;
                }
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[10].Visible = false;
                e.Row.Cells[11].Visible = false;
                e.Row.Cells[12].Visible = false;
                e.Row.Cells[9].Visible = false;
                e.Row.Cells[13].Visible = false;
                e.Row.Cells[14].Visible = false;
                e.Row.Cells[15].Visible = false;
                e.Row.Cells[16].Visible = false;
                e.Row.Cells[17].Visible = false;
                e.Row.Cells[18].Visible = false;
                e.Row.Cells[19].Visible = false;
                e.Row.Cells[21].Visible = false;
                e.Row.Cells[22].Visible = false;
                e.Row.Cells[20].Visible = false;
            }
            else if (hdnSearchType.Value == "DPS")//SS
            {
                if (drpserviceType.SelectedValue == "Due")
                {
                    e.Row.Cells[0].Visible = false;
                    e.Row.Cells[1].Visible = false;
                    e.Row.Cells[7].Visible = false;
                    e.Row.Cells[8].Visible = false;
                    e.Row.Cells[9].Visible = false;
                    e.Row.Cells[10].Visible = false;
                    e.Row.Cells[11].Visible = false;
                    e.Row.Cells[12].Visible = false;
                    e.Row.Cells[16].Visible = false;
                    e.Row.Cells[17].Visible = false;
                    e.Row.Cells[18].Visible = false;
                    e.Row.Cells[19].Visible = false;
                    e.Row.Cells[21].Visible = false;
                    e.Row.Cells[22].Visible = false;
                }
                else
                {
                    e.Row.Cells[0].Visible = false;
                    e.Row.Cells[1].Visible = false;
                    e.Row.Cells[5].Visible = false;
                    e.Row.Cells[9].Visible = false;
                    e.Row.Cells[13].Visible = false;
                    e.Row.Cells[14].Visible = false;
                    e.Row.Cells[15].Visible = false;
                }
            }
            else if (hdnSearchType.Value == "SS")//SS
            {
                e.Row.Cells[5].Visible = false;
                e.Row.Cells[6].Visible = false;
                e.Row.Cells[7].Visible = false;
                e.Row.Cells[8].Visible = false;
            }
            e.Row.Cells[6].Width = 260;
            e.Row.Cells[6].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            e.Row.Cells[11].Width = 260;
            e.Row.Cells[11].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            e.Row.Cells[19].Width = 260;
            e.Row.Cells[19].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            e.Row.Cells[4].Width = 180;
            e.Row.Cells[4].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            e.Row.Cells[12].Width = 180;
            e.Row.Cells[12].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            e.Row.Cells[18].Width = 180;
            e.Row.Cells[18].Attributes.Add("style", "word-break:break-all;word-wrap:break-word;");
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient obj = (Patient)e.Row.DataItem;
                HiddenField hdnSelect1 = (HiddenField)e.Row.FindControl("hdnSelect");
                CheckBox chkSelectNL1 = (CheckBox)e.Row.FindControl("chkSelect");
                if (hdnSelect1.Value == "-1000")
                {
                    chkSelectNL1.Visible = false;
                }
                chkSelectNL1.Attributes.Add("onclick", "javascript:validatesendsms('" + chkSelectNL1.ClientID + "','" + obj.PatientID + "','" + obj.MobileNumber + "','" + obj.EMail + "');");
                //chkSelectNL1.Attributes.Add("onclick", "javascript:alert();");

            }
            if (hdnSearchType.Value == "DPS")//SS
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    Patient obj = (Patient)e.Row.DataItem;
                    HiddenField hdnSelect2 = (HiddenField)e.Row.FindControl("hdnClientSelect");
                    //CheckBox chkSelectNL2 = (CheckBox)e.Row.FindControl("chkSelectClient");
                    HiddenField hdnSelect3 = (HiddenField)e.Row.FindControl("hdnRefDocSelect");
                    CheckBox chkSelectNL3 = (CheckBox)e.Row.FindControl("chkSelect");
                    //if (hdnSelect2.Value == "-1000")
                    //{
                    //    chkSelectNL2.Visible = false;
                    //}
                  
                   if (obj.ClientName.ToLower() == "general")
                    {
                        e.Row.Cells[11].Attributes.Add("style:display", "none");
                        e.Row.Cells[12].Attributes.Add("style:display", "none");
                        //chkSelectNL2.Enabled = false;
                    }
                    //chkSelectNL2.Attributes.Add("onclick", "javascript:validateclientsendsms('" + chkSelectNL2.ClientID + "','" + obj.ClientID + "','" + obj.ClientMobile + "','" + obj.ClientEmailId + "');");
                    chkSelectNL3.Attributes.Add("onclick", "javascript:validateRefDocsendsms('" + chkSelectNL3.ClientID + "','" + obj.RefDocCode + "','" + obj.RefDocMobile + "','" + obj.RefDocEmailId + "');");
                    //chkSelectNL1.Attributes.Add("onclick", "javascript:alert();");
                    e.Row.Cells[10].Text = obj.ClientName + " (" + obj.ClientCode + ")";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Admin_SendSMS gvwNameList_RowDataBound.", ex);
        }
    }
    protected void gvwSMSTemplate_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                RadioButton rbSelectTL1 = (RadioButton)e.Row.FindControl("rbSelectTL");
                Label lblSMSTemplate1 = (Label)e.Row.FindControl("lblSMSTemplate");

                rbSelectTL1.Attributes.Add("onclick", "javascript:CheckOnOff(" + rbSelectTL1.ClientID + ",'gvwSMSTemplate'," + lblSMSTemplate1.ClientID + ");");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Admin_SendSMS gvwSMSTemplate_RowDataBound.", ex);
        }
    }
    #region This method is used to populate the saved checkbox values
    private void PopulateCheckedValues()
    {
        long PatientID = -1;
        string MobileNumber = string.Empty;
        string strPatient = string.Empty;
        ArrayList userdetails = (ArrayList)ViewState["SelectedPatients"];
        if (userdetails != null && userdetails.Count > 0)
        {
            foreach (GridViewRow gvrow in gvwNameList.Rows)
            {
                PatientID = Convert.ToInt64(gvwNameList.DataKeys[gvrow.RowIndex][0].ToString());
                if (gvwNameList.DataKeys[gvrow.RowIndex][1] != "" && gvwNameList.DataKeys[gvrow.RowIndex][1] != null)
                {
                    MobileNumber = gvwNameList.DataKeys[gvrow.RowIndex][1].ToString();
                }

                if (userdetails.Contains(PatientID))
                {
                    CheckBox myCheckBox = (CheckBox)gvrow.FindControl("chkSelect");
                    myCheckBox.Checked = true;
                }
            }
        }
    }
    #endregion

    #region This method is used to save the checkedstate of values
    private void SaveCheckedValues()
    {
        long PatientID = -1;
        string MobileNumber = string.Empty;
        string strPatient = string.Empty;
        ArrayList userdetails = new ArrayList();


        foreach (GridViewRow gvrow in gvwNameList.Rows)
        {

            PatientID = Convert.ToInt64(gvwNameList.DataKeys[gvrow.RowIndex][0].ToString());
            if (gvwNameList.DataKeys[gvrow.RowIndex][1] != null && gvwNameList.DataKeys[gvrow.RowIndex][1] != "")
            {
                MobileNumber = gvwNameList.DataKeys[gvrow.RowIndex][1].ToString();
            }
            else
            {
                MobileNumber = string.Empty;
            }
            strPatient = PatientID.ToString() + "~" + MobileNumber;

            // Check in the Session
            if (ViewState["SelectedPatients"] != null)
                userdetails = (ArrayList)ViewState["SelectedPatients"];
            CheckBox chkBox = (CheckBox)gvrow.FindControl("chkSelect");
            if (chkBox.Checked)
            {
                if (!userdetails.Contains(PatientID))
                    userdetails.Add(PatientID);

            }
            else
                if (userdetails.Count > 0)
                {
                    if (!userdetails.Contains(PatientID))
                    {

                        //userdetails.Remove(PatientID);
                    }
                    else
                    {
                        userdetails.Remove(PatientID);
                    }
                }

        }
        //if (userdetails != null && userdetails.Count > 0)
        ViewState["SelectedPatients"] = userdetails;
    }
    #endregion

    protected void btn_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        ViewState["SelectedPatients"] = null;
        ViewState["hdnInvestValue"] = null;
        ViewState["Search"] = "searchbyfilter";
        if (drpserviceType.SelectedValue.ToLower() == "pro" || drpserviceType.SelectedValue.ToLower() == "due")
        {
            ViewState["hdnInvestValue"] = drpserviceType.SelectedValue;
        }

        else
        {
            ViewState["hdnInvestValue"] = hdnType.Value;
            hdnInvestValue.Value = hdnType.Value;
        }
        
        searchbyfilter(currentPageNo, PageSize);

    }
    public void tabs(string filter)
    {
        if (hdntabs.Value == "Filters")
        {
            searchbyfilter(currentPageNo, PageSize);
        }
        else
        {
            LoadRecipientList(currentPageNo, PageSize);
        }
    }

    #region Second Tab search condition Filter

    public void searchbyfilter(int currentPageNo, int PageSize)
    {
        hdntabs.Value = "Filters";
        string tempfrom;
        DateTime dtme = (DateTime.Today.Date);
        tempfrom=Convert.ToString(dtme.AddDays(-2));
        string fromDate, ToDate;
        int groupid = 0, packageid = 0;
        long investigationid = 0;
        string type = ViewState["hdnInvestValue"].ToString();
        string ResultType = drpresulttype.SelectedValue;
        string age1 = string.Empty;
        string age2 = string.Empty;
        string Protocolgrpname = String.Empty;
        string ClientName = String.Empty;
        string RefPhyName = String.Empty;
        string VisitNumber = String.Empty;
        Protocolgrpname = ddlProGrp.SelectedValue;
        if (txtClientName.Text.Trim() != "")
        {
            string[] Client = txtClientName.Text.Split(':');
            ClientName = Client[1].ToString().Trim();
        }
        else
        {
            ClientName = txtClientName.Text;
        }
        RefPhyName = txtRefPhyName.Text;
        VisitNumber = txtVisitNumber.Text;
        if (txtAge.Text != "")
        {
            var age = txtAge.Text.Split('-');
            if (age.Length > 0)
            {
                age1 = age[0].ToString();
                age2 = age[1].ToString();
            }
        }
        string patientno = txtPatientNo.Text.Trim() == "" ? "0" : Convert.ToString(txtPatientNo.Text);
        string billno = txtBillNo.Text.Trim() == "" ? "0" : Convert.ToString(txtBillNo.Text);

        if (type == "INV")
        {
            investigationid = Convert.ToInt64(hdnInvestigationID.Value);
        }
        else if (type == "GRP")
        {
            groupid = Convert.ToInt32(hdnInvestigationID.Value);

        }
        else if (type == "PKG")
        {
            packageid = Convert.ToInt32(hdnInvestigationID.Value);
        }
        if (ddlRegisterDate.SelectedItem.Text != "--Select--")
        {
            if (txtFromDate.Text != "" && txtToDate.Text != "")
            {
                fromDate = txtFromDate.Text;
                ToDate = txtToDate.Text;
            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                fromDate = txtFromPeriod.Text;
                ToDate = txtToPeriod.Text;
            }
            else if (ddlRegisterDate.SelectedItem.Text == "Today")
            {
                fromDate = OrgTimeZone;
                ToDate = OrgTimeZone;
            }
            else
            {
                fromDate = txtFromDate.Text;
                ToDate = txtToDate.Text;

            }
        }
        else
        {
            fromDate = tempfrom;
            ToDate = OrgTimeZone;

        }
        long returnCode = -1;
        Patient_BL objBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstRecipients = new List<Patient>();
        string str = drpnotification.SelectedValue;

        returnCode = objBL.SearchByFilterSendSMS(fromDate, ToDate, type, investigationid, groupid, packageid, ResultType, drpmartial.SelectedValue,
                                                     age1, age2, patientno, txtPatientName.Text, billno, OrgID, out lstRecipients, currentPageNo, PageSize,
                                                     Protocolgrpname, ClientName, RefPhyName, VisitNumber, out totalRows);
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
        if (lstRecipients.Count > 0)
        {
            divFooterNav.Visible = true;
            if (ViewState["hdnInvestValue"].ToString() == "Due")
            {
                gvwNameList.DataSource = lstRecipients.GroupBy(due => new { due.Name, due.PatientNumber, due.PatientID, due.MobileNumber, due.EMail,due.BillNo},
                                       (key, group) => new Patient { PatientID = key.PatientID, EMail = key.EMail, MobileNumber = key.MobileNumber, Name = key.Name, PatientNumber = key.PatientNumber, TotalDueAmt = group.Sum(t => t.TotalDueAmt), ReceivedAmount = group.Sum(t => t.ReceivedAmount), BillNo = key.BillNo, TPASettledAmt = group.Sum(t => t.TPASettledAmt) }).ToList<Patient>();

                gvwNameList.DataBind();
            }
            else
            {
                gvwNameList.DataSource = lstRecipients;
                gvwNameList.DataBind();
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumbe", "  javascript:DisplayTabMenu('DPS','" + str + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumberes", "  javascript:Checks();gettypes();", true);
        }

        else
        {
            divFooterNav.Visible = false;
            gvwNameList.DataSource = null;
            gvwNameList.DataBind();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumbet", "  javascript:DisplayTabMenu('DPS','" + str + "');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumberest", "  javascript:Checks();gettypes();", true);
        }
        if (ViewState["hdnInvestValue"].ToString() == "INV")
        {
            drpserviceType.SelectedValue = "INV";
        }
        else if (ViewState["hdnInvestValue"].ToString() == "GRP")
        {
            drpserviceType.SelectedValue = "INV";
        }
        else if (ViewState["hdnInvestValue"].ToString() == "PKG")
        {
            drpserviceType.SelectedValue = "INV";

        }
        else
        {
            drpserviceType.SelectedValue = ViewState["hdnInvestValue"].ToString();

        }
        gvwNameList.Columns[7].ItemStyle.Width = 60;
    }
    #endregion
    protected void btnsearchothers_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        ViewState["SelectedPatients"] = null;
        ViewState["Search"] = "LoadRecipientList";
        LoadRecipientList(currentPageNo, PageSize);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "MobileNumberest", "  javascript:Checks();Clears();", true);

    }
    protected void drpserviceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = OrgID + "~" + drpserviceType.SelectedValue.ToString();
        
    }
    public void LoadMetaData()
    {
        try
        {
            string domains = "SampleRejectedPeriod";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            long returncode;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                /* Dropdown loaded based on ProtocalGroup */
                var progrps = from child in lstmetadataOutput
                              where child.Domain == "ProtocalGroup_Based"
                              select child;

                ddlProGrp.DataSource = progrps;
                ddlProGrp.DataTextField = "DisplayText";
                ddlProGrp.DataValueField = "Code";
                ddlProGrp.DataBind();
                ddlProGrp.Items.Insert(0, "---Select---");
                ddlProGrp.Items[0].Value = "0";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status In Commoncontrol_AbberantQueue", ex);
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        try
        {
            SaveCheckedValues();
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
            if (ViewState["Search"].ToString() == "searchbyfilter")
            {
                searchbyfilter(currentPageNo, PageSize);
            }
            else
            {
                LoadRecipientList(currentPageNo, PageSize);
            }
            PopulateCheckedValues();
        }
        catch
        {
        }
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        try
        {
            SaveCheckedValues();
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
            if (ViewState["Search"].ToString() == "searchbyfilter")
            {
                searchbyfilter(currentPageNo, PageSize);
            }
            else
            {
                LoadRecipientList(currentPageNo, PageSize);
            }
            PopulateCheckedValues();
        }
        catch
        {
        }
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        try
        {
            tabs(hdntabs.Value);
            //if (ViewState["Search"].ToString() != "searchbyfilter")
            //{
            SaveCheckedValues();
            //}
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
                if (ViewState["Search"].ToString() == "searchbyfilter")
                {
                    searchbyfilter(Convert.ToInt32(txtpageNo.Text), PageSize);
                }
                else
                {
                    LoadRecipientList(Convert.ToInt32(txtpageNo.Text), PageSize);
                }
            }
            txtpageNo.Text = "";
            //AddToViewState();
            //SaveCheckedValues();
            PopulateCheckedValues();

        }
        catch
        {
        }
    }
}

