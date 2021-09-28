using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;
using System.Net;
using System.Xml;
public partial class Investigation_InvestigationReport : BasePage
{
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long returnCode = -1;
    long pVisitID = 0;
    int menuType, pCount;
    string patientNumber = string.Empty;
    string investigatgionID = "";

    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    string reportID = string.Empty;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<ImageServerDetails> imgServerdetails = new List<ImageServerDetails>();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage1.Text = string.Empty;
        //txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
        txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
        if ((IntegrationName != string.Empty))
        {
            if (!IsPostBack)
            {

                //lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

                returnCode = new IntegrationBL(base.ContextInfo).GetImageServerDetails(OrgID, ILocationID, out imgServerdetails);
                if (imgServerdetails.Count > 0)
                {
                    tblcontent.Visible = true;
                    if ((imgServerdetails[0].ExeFilePath == string.Empty) || (imgServerdetails[0].ExeFilePath == null))
                    {
                        lnkInstall.Visible = false;
                        imgInstallExe.Visible = false;
                    }
                    else
                    {
                        lnkInstall.NavigateUrl = imgServerdetails[0].ExeFilePath;
                        lnkInstall.Visible = true;
                        imgInstallExe.Visible = true;
                    }

                    if ((imgServerdetails[0].InstallationGuidePath == string.Empty) || (imgServerdetails[0].InstallationGuidePath == null))
                    {
                        lnkInsguide.Visible = false;
                        imgInsGuide.Visible = false;
                    }
                    else
                    {
                        hdnInstallationGuidePath.Value = imgServerdetails[0].InstallationGuidePath;
                        lnkInsguide.Visible = true;
                        imgInsGuide.Visible = true;

                    }

                    if ((imgServerdetails[0].UserGuidePath == string.Empty) || (imgServerdetails[0].UserGuidePath == null))
                    {
                        lnkUserGuide.Visible = false;
                        imgUserGuide.Visible = false;
                    }
                    else
                    {
                        hnUserGuidePath.Value = imgServerdetails[0].UserGuidePath;
                        lnkUserGuide.Visible = true;
                        imgUserGuide.Visible = true;
                    }
                    hdnIpaddress.Value = imgServerdetails[0].IpAddress;
                    hdnPath.Value = imgServerdetails[0].Path;
                    hdnPortNumber.Value = imgServerdetails[0].PortNumber;
                }
            }
        }

        if (Request.QueryString["vid"] != null)
        {
            rReportViewer.Visible = false;
            tblPatient.Visible = false;
            pVisitID = Convert.ToInt64(Request.QueryString["vid"]);

            if (!IsPostBack)
            {

                try
                {
                    long taskID = -1;
                    long refPhysicianID = -1;
                    Int64.TryParse(Request.QueryString["tid"], out taskID);

                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                    txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

                    if (Request.QueryString["vid"] != null)
                    {
                        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                        List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();
                        List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
                        returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(pVisitID, out pCount, out patientNumber, out lstOrderderd);

                        objPatientBL.GetReportTemplate(pVisitID, OrgID, "",out lstReport, out lstReportName, out lstDpts);
                        if (lstReport.Count() > 0)
                        {
                            grdResultTemp.DataSource = lstReportName;
                            grdResultTemp.DataBind();
                            lblMessage1.Visible = false;
                            //tblcontent.Visible = true;
                            bindCheckBox();
                        }
                        else
                        {
                            lblMessage1.Visible = true;
                            lblMessage1.Text = "No Matching Records Found";
                            // tblcontent.Visible = false;
                        }
                        //txtPatientNo.Text = patientNumber.Trim();
                    }
                    else
                    {

                    }


                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error while Loading SSRS", ex);
                }
            }
        }
        else
        {
            tblPatient.Visible = true;
        }
    }
    private void bindCheckBox()
    {
        DataList chldDataLst = new DataList();
        CheckBox chkbox = new CheckBox();

        foreach (DataListItem items in grdResultTemp.Items)
        {
            chkbox = (CheckBox)items.FindControl("chkSelectAll");
            //chldDataLst = (DataList)items.FindControl("grdResultDate");
        }
        //foreach (DataListItem items in chldDataLst.Items)
        //{
        //      chkbox = (CheckBox)items.FindControl("chkSelectAll");
        //}

        chkbox.Attributes.Add("onclick", "javascript:SelectAll('" + chkbox.ClientID + "')");

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            string pSearchType = "LAB";
            hdnVID.Value = string.Empty;
            rReportViewer.Visible = false;
            grdResultTemp.Visible = false;
            lblMessage1.Text = string.Empty;
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            //string ShareType = "Clinical View";
            //if (IsTrustedOrg == "Y")
            //{
            //    returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            //}
            //else
            //{
            //    TrustedOrgDetails TOD = new TrustedOrgDetails();
            //    TOD.SharingOrgID = OrgID;
            //    lstTOD.Add(TOD);
            //}
            string FrmDate, ToDate;
            if (txtTo.Text != "")
            {
                ToDate = Convert.ToDateTime(txtTo.Text).ToString();
            }
            else { ToDate = ""; }
            if (txtFrom.Text != "")
            {
                FrmDate = Convert.ToDateTime(txtFrom.Text).ToString();
            }
            else { FrmDate = ""; }

            returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, FrmDate, ToDate, OrgID, pSearchType, out lstPatientVisit, currentPageNo, PageSize, out totalRows);


            //lblPName.Text = lstPatientVisit[0].PatientName;

            grdResult.DataSource = lstPatientVisit;
            grdResult.DataBind();

            if (lstPatientVisit.Count > 0)
            {
                trSelectVisit.Visible = true;
                lblMessage.Text = "";

                menuType = Convert.ToInt32(TaskHelper.SearchType.Lab);

                List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, menuType, out lstVisitSearchAction);
                if (lstActionMaster.Count > 0)
                {
                    //lstActionsMaster = lstActionMaster.ToList();
                    #region Add View State ActionList
                    string temp = string.Empty;
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    ViewState.Add("ActionList", temp);
                    #endregion
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    //ddlVisitActionName.DataValueField = "PageURL";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();
                    ddlVisitActionName.Items.Insert(0, new ListItem("--Select--", "0"));
                    ddlVisitActionName.Visible = true;
                    btnGo.Visible = true;
                }
            }
            else
            {
                trSelectVisit.Visible = false;
                lblMessage.Text = "";
                lblMessage.Text = "No matching records found";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID,
            out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

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

    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            pVisitID = Convert.ToInt64(hdnVID.Value);
            ShowReport(reportPath, pVisitID, reportID, "");
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.PatientName + "', '" + pv.OrgID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in InvestigationReport.aspx", Ex);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        HdnCheckBoxId.Value = "";
        try
        {
            if (ddlVisitActionName.SelectedValue != "0")
            {
                long VisitID = Convert.ToInt64(hdnVID.Value);

                List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();

                if (ddlVisitActionName.SelectedItem.Text == "Show_Report_InvestigationReport")
                {
                    returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(Convert.ToInt64(hdnVID.Value), out pCount, out patientNumber, out lstOrderderd);
                    if (lstOrderderd.Count > 0)
                    {
                        //tblPayments.Visible = true;
                        //tblResults.Visible = false;

                        tblPayments.Visible = false;
                        tblResults.Visible = true;
                        List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
                        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                        objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value),"", out lstReport, out lstReportName, out lstDpts);
                        if (lstReport.Count() > 0)
                        {
                            grdResultTemp.Visible = true;
                            grdResultTemp.Visible = true;
                            grdResultTemp.DataSource = lstReportName;
                            grdResultTemp.DataBind();
                            bindCheckBox();
                            lblMessage1.Visible = false;
                            dReport.Style.Add("display", "block");
                            //if (RoleName == RoleHelper.ReferringPhysician)
                            //{
                            //    tblcontent.Visible = true;
                            //    lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

                            //}

                        }
                        else
                        {
                            grdResultTemp.Visible = false;
                            lblMessage1.Visible = true;
                            lblMessage1.Text = "No Matching Records Found";
                        }
                    }
                    else
                    {
                        tblPayments.Visible = false;
                        tblResults.Visible = true;
                        List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
                        Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                        objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(patOrgID.Value), "",out lstReport, out lstReportName, out lstDpts);
                        if (lstReport.Count() > 0)
                        {
                            grdResultTemp.Visible = true;
                            grdResultTemp.Visible = true;
                            grdResultTemp.DataSource = lstReportName;
                            grdResultTemp.DataBind();
                            bindCheckBox();
                            lblMessage1.Visible = false;
                            dReport.Style.Add("display", "block");
                            //if (RoleName == RoleHelper.ReferringPhysician)
                            //{
                            //    tblcontent.Visible = true;
                            //    lnkInstall.NavigateUrl = "~/DownloadSource/PellucidLiteViewerTaskMgr.zip";

                            //}
                        }
                        else
                        {
                            grdResultTemp.Visible = false;
                            lblMessage1.Visible = true;
                            lblMessage1.Text = "No Matching Records Found";
                        }
                    }
                }

                else
                {

                    //Response.Redirect(Request.ApplicationPath + ddlVisitActionName.SelectedValue + "?VID=" + VisitID, true);
                    #region Get Redirect URL
                    QueryMaster objQueryMaster = new QueryMaster();

                    string RedirectURL = string.Empty;
                    string QueryString = string.Empty;
                    //if (lstActionsMaster.Exists(p => p.ActionCode == ddlVisitActionName.SelectedValue))
                    //{
                    //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlVisitActionName.SelectedValue).QueryString;
                    //}
                    #region View State Action List
                    string ActCode = ddlVisitActionName.SelectedValue;
                    string ActionList = ViewState["ActionList"].ToString();
                    foreach (string CompareList in ActionList.Split('^'))
                    {
                        if (CompareList.Split('~')[0] == ActCode)
                        {
                            QueryString = CompareList.Split('~')[1];
                            break;
                        }
                    }
                    #endregion
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientVisitID = VisitID.ToString();
                    Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    #endregion

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }
    }

    #region Formtodb Date Conversion
    protected string FormtoDb(string val)
    {
        if (val != "")
        {
            string[] dd = val.Split('/');
            val = dd[1].Trim() + "/" + dd[0].Trim() + "/" + dd[2].Trim();
        }
        return val;
    }
    #endregion


    protected void grdResultDate_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");

            var ReportNames =
                from InvName in lstReport
                group InvName by
                        new
                        {
                            InvName.InvestigationName,
                            InvName.TemplateID,
                            InvName.CreatedAt,
                            InvName.PatientID
                        }
                    into grp
                    where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
                            && grp.ElementAt(0).CreatedAt == eInvReportMaster.CreatedAt
                    select grp;


            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                invRptMaster.AccessionNumber = lstgrp.ElementAt(0).AccessionNumber;
                invRptMaster.PatientID = lstgrp.ElementAt(0).PatientID;
                lstrptMaster.Add(invRptMaster);
            }



            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }

            foreach (DataListItem rpt in dtInvName.Items)
            {
                CheckBox chkbox = (CheckBox)rpt.FindControl("ChkBox");
                string clientid = chkbox.ClientID;

                //code added for select all checkbox - begins
                if (HdnCheckBoxId.Value == "")
                { HdnCheckBoxId.Value = chkbox.ClientID; }
                else { HdnCheckBoxId.Value += '~' + chkbox.ClientID; }
                //code added for select all checkbox - ends


            }


            if (eInvReportMaster.TemplateID == 4)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "4")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;

                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 5)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "5")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 6)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "6")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
            else if (eInvReportMaster.TemplateID == 1)
            {
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "1")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));


                        lnkshow.Text = "View Image";
                        lnkshow.CommandName = "ViewImage";
                        if (IntegrationName == EnumUtils.stringValueOf(IntegrationHelper.ViewerName.Matrixview))
                        {
                            Label lblPatID = ((Label)rpt.FindControl("lblPatientID"));
                            Label lblInvID = ((Label)rpt.FindControl("lblInvID"));
                            Label lblAccessionNo = ((Label)rpt.FindControl("lblAccessionNo"));
                            try
                            {
                                // MatrixViewService.mvisws ObjMV = new MatrixViewService.mvisws();
                                //string ImageCount = ObjMV.StudyImageCount(lblPatID.Text, lblInvID.Text, lblAccessionNo.Text);
                                //XmlDocument mvResultSet = new XmlDocument();
                                // mvResultSet.LoadXml(ImageCount);
                                //XmlNodeList xNode = mvResultSet.GetElementsByTagName("imagecount");
                                string value = "1";// xNode.Item(0).InnerText;
                                //patid, studyid, modality, imageserveripaddress, portnumber, loggedinusername
                                //Uri u = new Uri("http://122.165.25.103/mvisws-attune/mvisws.asmx");
                                //WebProxy w = new WebProxy((;
                                //w.Address = u;

                                if (value != "0")
                                {
                                    lnkshow.Visible = true;
                                    string portnumber = hdnPortNumber.Value;
                                    string ipaddress = hdnIpaddress.Value;
                                    lnkshow.Attributes.Add("onClick", "javascript:return launchexe_mv('" + lblPatID.Text + "','" + lblInvID.Text + "','" + lblAccessionNo.Text + "','" + ipaddress + "','" + portnumber + "','" + LoginName + "');");
                                }
                                else
                                {
                                    lnkshow.Visible = false;
                                }
                            }
                            catch (Exception ex)
                            {
                                CLogger.LogError("Connection not establish with Webserives", ex);
                            }
                        }
                        else if (IntegrationName != string.Empty)
                        {
                            lnkshow.Visible = true;
                        }
                    }
                }
            }
        }
    }


    protected void grdResultTemp_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("grdResultDate");

            //var ReportNames =
            //    from InvName in lstReport
            //    group InvName by
            //            new
            //            {
            //                //InvName.InvestigationName,
            //                InvName.TemplateID,
            //                InvName.CreatedAt
            //            }
            //        into grp
            //        where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
            //        select grp;

            var ReportNames =
               from InvName in lstReport
               group InvName by
             new
             {
                 //InvName.InvestigationName,
                 InvName.CreatedAt,
                 InvName.TemplateID
             } into grp
               where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
               select grp;




            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                //invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                //invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                lstrptMaster.Add(invRptMaster);
            }



            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }

        }
    }

    protected void grdResultTemp_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            if (e.CommandName == "ShowReport")
            {
                reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
                reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
                if (Request.QueryString["vid"] != null)
                {
                    pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                else
                {
                    pVisitID = Convert.ToInt64(hdnVID.Value);
                }
                DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
                foreach (DataListItem dt in ctr.Items)
                {
                    DataList ctr1 = (DataList)dt.FindControl("dlChildInvName");
                    foreach (DataListItem chk in ctr1.Items)
                    {
                        chkTemp = (CheckBox)chk.FindControl("ChkBox");
                        Label lbl = (Label)chk.FindControl("lblAccessionNo");
                        if (chkTemp.Checked)
                        {
                            strSelVal += lbl.Text + ",";
                        }

                    }
                    //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                }
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));
                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                ShowReport(reportPath, pVisitID, reportID, strSelVal);
                rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }

    protected void grdResultDate_ItemCommand(object source, DataListCommandEventArgs e)
    {
        //if (e.CommandName == "ShowReport")
        //{
        //    reportID = ((Label)e.Item.FindControl("lblDtReportID")).Text;
        //    reportPath = ((Label)e.Item.FindControl("lbldtReportname")).Text;
        //    if (Request.QueryString["vid"] != null)
        //    {
        //        pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
        //    }
        //    else
        //    {
        //        pVisitID = Convert.ToInt64(hdnVID.Value);
        //    }

        //    ShowReport(reportPath, pVisitID, reportID, "");
        //    Control ctr = e.Item.FindControl("dlChildInvName");
        //}
        try
        {
            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            if (e.CommandName == "ShowReport")
            {
                reportID = ((Label)e.Item.FindControl("lblDtReportID")).Text;
                reportPath = ((Label)e.Item.FindControl("lbldtReportname")).Text;
                if (Request.QueryString["vid"] != null)
                {
                    pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                else
                {
                    pVisitID = Convert.ToInt64(hdnVID.Value);
                }
                //DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
                //foreach (DataListItem dt in ctr.Items)
                //{
                DataList ctr1 = (DataList)e.Item.FindControl("dlChildInvName");
                foreach (DataListItem chk in ctr1.Items)
                {
                    chkTemp = (CheckBox)chk.FindControl("ChkBox");
                    Label lbl = (Label)chk.FindControl("lblAccessionNo");
                    if (chkTemp.Checked)
                    {
                        strSelVal += lbl.Text + ",";
                    }

                }
                //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                //}
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));
                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                ShowReport(reportPath, pVisitID, reportID, strSelVal);
                rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }


    public void ShowReport(string reportPath, long visitID, string templateID, string InvID)
    {
        try
        {
            rReportViewer.Visible = true;
            string strURL = string.Empty;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            rReportViewer.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            rReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
    }


    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = ((Label)e.Item.FindControl("lblInvID")).Text;
            if (Request.QueryString["vid"] != null)
            {
                pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                pVisitID = Convert.ToInt64(hdnVID.Value);
            }
            ShowReport(reportPath, pVisitID, reportID, investigatgionID);
            rptMdlPopup.Show();
        }
        else if (e.CommandName == "ViewImage")
        {
            try
            {
                string AccessionNumber = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
                string PatientID = ((Label)e.Item.FindControl("lblPatientID")).Text;

                if (IntegrationName == EnumUtils.stringValueOf(IntegrationHelper.ViewerName.Pellucid))
                {
                    string Path = hdnPath.Value + "/Investigation/ImageAccess.aspx?AccessionNumber=" + AccessionNumber;
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "page", "javascript:launchSessionUrl('" + Path + "');", true);
                }

            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
        }
    }



    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }

    private string ReturnExtension(string fileExtension)
    {
        switch (fileExtension)
        {
            case ".htm":
            case ".html":
            case ".log":
                return "text/HTML";
            case ".txt":
                return "text/plain";
            case ".doc":
                return "application/ms-word";
            case ".tiff":
            case ".tif":
                return "image/tiff";
            case ".asf":
                return "video/x-ms-asf";
            case ".avi":
                return "video/avi";
            case ".zip":
                return "application/zip";
            case ".xls":
            case ".csv":
                return "application/vnd.ms-excel";
            case ".gif":
                return "image/gif";
            case ".jpg":
            case "jpeg":
                return "image/jpeg";
            case ".bmp":
                return "image/bmp";
            case ".wav":
                return "audio/wav";
            case ".mp3":
                return "audio/mpeg3";
            case ".mpg":
            case "mpeg":
                return "video/mpeg";
            case ".rtf":
                return "application/rtf";
            case ".asp":
                return "text/asp";
            case ".pdf":
                return "application/pdf";
            case ".fdf":
                return "application/vnd.fdf";
            case ".ppt":
                return "application/mspowerpoint";
            case ".dwg":
                return "image/vnd.dwg";
            case ".msg":
                return "application/msoutlook";
            case ".xml":
            case ".sdxl":
                return "application/xml";
            case ".xdp":
                return "application/vnd.adobe.xdp+xml";
            default:
                return "application/octet-stream";
        }
    }
    protected void btnPayNow_Click(object sender, EventArgs e)
    {
        try
        {
            if (RoleName.ToLower() != "Receptionist")
            {
                Tasks task = new Tasks();
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                long patientVisitId = Convert.ToInt64(hdnVID.Value);
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                long taskID = 0;

                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
                    lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber.ToString(), lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = patientVisitId;
                task.PatientID = lstPatientVisitDetails[0].PatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //create task
                returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
                Response.Redirect("~/Lab/Home.aspx", true);
            }
            else
            {
                Response.Redirect("~/Reception/Home.aspx", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }
    }
    protected void lnkInsguide_Click(object sender, EventArgs e)
    {
        //string filepath = Server.MapPath("~/Downloadsource/Installation Guide for Referring Physician Access.pdf");
        string filepath = Server.MapPath(hdnInstallationGuidePath.Value);
        DownloadFile(filepath);

    }
    protected void lnkUserGuide_Click(object sender, EventArgs e)
    {
        //string filepath = Server.MapPath("~/Downloadsource/User Guide for Referring Physician Access.pdf");
        string filepath = Server.MapPath(hnUserGuidePath.Value);
        DownloadFile(filepath);

    }
    protected void DownloadFile(string filepath)
    {


        System.IO.FileInfo file = new System.IO.FileInfo(filepath);

        // Checking if file exists
        if (file.Exists)
        {
            // Clear the content of the response
            Response.ClearContent();

            // LINE1: Add the file name and attachment, which will force the open/cance/save dialog to show, to the header
            Response.AddHeader("Content-Disposition", "attachment; filename=" + file.Name);

            // Add the file size into the response header
            Response.AddHeader("Content-Length", file.Length.ToString());

            // Set the ContentType
            Response.ContentType = ReturnExtension(file.Extension.ToLower());

            // Write the file into the response (TransmitFile is for ASP.NET 2.0. In ASP.NET 1.1 you have to use WriteFile instead)
            Response.TransmitFile(file.FullName);

            // End the response
            Response.End();
        }
    }
}