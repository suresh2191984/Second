
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
using System.Web.Script.Serialization;



public partial class Waters_ReportTracking : BasePage
{

    public Waters_ReportTracking()
        : base("Waters_ReportTracking_aspx")
    {
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadVisitType();
            
            ddShowReport.Visible = false;
            WaterstxtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
            WaterstxtTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
        }
        hdnOrgID.Value = OrgID.ToString();
        patOrgID.Value = OrgID.ToString();
        hdnRoleID.Value = Convert.ToString(RoleID);

    }
    string AlertType = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    string reportID = string.Empty;
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long pVisitID = 0;
    string investigatgionID = "";
    int PageSize = 10;
    int Currentpageno = 1;

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
    


    public void LoadVisitType()
    {


        int menuType = 0;

        long returncode = -1;


        menuType = Convert.ToInt32(TaskHelper.SearchType.Lab);

        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
        returncode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, menuType, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, menuType, out lstVisitSearchAction);
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
            ddlVisitActionName.Items.Insert(0, new ListItem(strSelect, "0"));
            ddlVisitActionName.Visible = true;

            ddlVisitActionName.Items.FindByText("Show Report").Selected = true;
        }

    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Waters_BL Water = new Waters_BL();
            long returnCode = -1;
            string SampleID = "";
            string VisitNumber = "";
            string ClientName = "";
            int CurrentPageNo = 0;

            int PatOrgID = Convert.ToInt32(hdnOrgID.Value);

            List<WatersQuotationMaster> list = new List<WatersQuotationMaster>();


            if (hdnCurrent.Value == "")
            {

                hdnCurrent.Value ="1";
            
            }


            CurrentPageNo = Convert.ToInt32(hdnCurrent.Value);


            string QuotationNo = "";
            if (txtQuotationNo.Text != "")
            {
                QuotationNo = txtQuotationNo.Text;
            }


            DateTime FromDate = (WaterstxtFrom.Text.Trim().ToLower() == "dd/mm/yyyy" || WaterstxtFrom.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(WaterstxtFrom.Text.Trim());

            DateTime ToDate = (WaterstxtTo.Text.Trim().ToLower() == "dd/mm/yyyy" || WaterstxtTo.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(WaterstxtTo.Text.Trim());

            if (txtSampleID.Text != "")
            {

                SampleID = txtSampleID.Text;

            }


            if (txtWatersVisitNo.Text != "")
            {

                VisitNumber = txtWatersVisitNo.Text;

            }

            if (WaterstxtClientName.Text != "")
            {

                ClientName = WaterstxtClientName.Text;

            }

            returnCode = Water.GetReporttrackingDetails(PatOrgID, QuotationNo, FromDate, ToDate, SampleID, VisitNumber, ClientName, Currentpageno,PageSize, out list);

            if (list.Count > 0)
            {
                grdResult.DataSource = list;
                grdResult.DataBind();
                ddShowReport.Visible = true;
            }
            else {
                grdResult.DataSource = null;
                grdResult.DataBind();
                ddShowReport.Visible = false;
            
            }

        }

        catch (Exception Ex)
        {
            CLogger.LogError("Error in BtnSearch_onclick on Reporttracking ", Ex);
        }



    }
    protected void btnGo_Click(object Sender, EventArgs e)
    {

        ShowTemplate();
        CollapsiblePanelExtender1.Collapsed = false;
        CollapsiblePanelExtender1.ClientState = "false";
        rReportViewer.Reset();
        

       
    }

    public void ShowTemplate()
    {

        long returncode = -1;
        int PatOrgID = 0;
        Int32.TryParse(patOrgID.Value, out PatOrgID);
        if (hdnVisitID.Value != "")
        {
            long VisitID = Convert.ToInt64(hdnVisitID.Value);
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            string invStatus = "all";
            returncode = objPatientBL.GetReportTemplate(VisitID, OrgID,"", out lstReport, out lstReportName, out lstDpt);
            var firstElement = lstReport.First().Status;
            if (firstElement != "SampleReceived")
            {
                if (lstReport.Count() > 0)
                {

                    grdResultTemp.Visible = true;
                    grdResultTemp.Visible = true;
                    grdResultTemp.DataSource = lstReportName;
                    grdResultTemp.DataBind();
                    bindCheckBox();

                }
                ModalPopupExtender1.Show();
            }
            else
            {
                
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Report is not ready');", true);
                
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Kindly select any Quotation to see the report');", true);
        }

         
        // btnGo.Attributes.Add("onclick", "ShowReportPreview('" + VisitID + "','" + RoleID + "','" + invStatus + "');return true;");
      // ScriptManager.RegisterStartupScript(this, this.GetType(), "CollectSample", "ShowReportPreview();", true);
        //   btnGo.Attributes.Add("onclick", "ShowReportPreview('" + VisitID + "','" + RoleID + "','" + invStatus + "');return false;");






    }


    string strScript = string.Empty;

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            int sno = 0;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                WatersQuotationMaster WQM = (WatersQuotationMaster)e.Row.DataItem;
                
                strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("RdoSelect")).ClientID + "','" + WQM.QuotationID + "','" + WQM.QuotationNo + "','" + WQM.ClientName + "','" + WQM.ClientID + "','" + WQM.Others + "','" + WQM.Branch + "','" + WQM.SalesPerson + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("RdoSelect")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("RdoSelect")).Attributes.Add("onclick", strScript);
                ((RadioButton)e.Row.Cells[0].FindControl("RdoSelect")).Attributes.Add("checked", "false");
               
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound on Reporttracking ", Ex);
        }

    }

    protected void btnClear_Click(object Sender, EventArgs e)
    {
        try
        {

            grdResult.DataSource = null;
            grdResult.DataBind();
            txtQuotationNo.Text = "";
            txtSampleID.Text = "";
            txtWatersVisitNo.Text = "";
            WaterstxtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
            WaterstxtTo.Text = DateTime.Today.ToString("dd/MM/yyyy");
            WaterstxtClientName.Text = "";
            ddShowReport.Visible = false;
            hdnVisitID.Value = "";


        }

        catch (Exception Ex)
        {

            CLogger.LogError("Error in btnClear_Click on Reporttracking ", Ex);
        
        }
    





    }


    //Investigation Report part

    protected void grdResultTemp_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("grdResultDate");
            Label lblReportname = (Label)e.Item.FindControl("lblReport");
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
                 //InvName.CreatedAt,
                 InvName.ReportTemplateName,
                 InvName.TemplateID,
                 InvName.Type
             } into grp
               where grp.ElementAt(0).ReportTemplateName == eInvReportMaster.ReportTemplateName && grp.ElementAt(0).Type == eInvReportMaster.Type 
               select grp;

            string strCytometry = Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_08 == null ? "Flow Cytometry Graph" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_08;


            foreach (var lstgrp in ReportNames)
            {
                if (lstgrp.ElementAt(0).ReportTemplateName == "PDF")
                {
                    lblReportname.Text = strCytometry.Trim();
                }
                InvReportMaster invRptMaster = new InvReportMaster();
                //invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                //invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                invRptMaster.CreatedAt = lstgrp.ElementAt(0).CreatedAt;
                invRptMaster.Type = lstgrp.Key.Type;
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
            int PatOrgID = 0;
            Int32.TryParse(patOrgID.Value, out PatOrgID);
            string strSelVal = string.Empty;
            CheckBox chkTemp = new CheckBox();
            if (e.CommandName == "ShowReport")
            {
                reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
                reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
                HiddenField TempalteName = (HiddenField)e.Item.FindControl("HdnTemplatename");
                hdnTemplateId.Value = reportID;
                if (Request.QueryString["vid"] != null)
                {
                    pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
                }
                else
                {
                    pVisitID = Convert.ToInt64(hdnVID.Value);
                }

                DataList ctr = (DataList)e.Item.FindControl("grdResultDate");
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;
                foreach (DataListItem dt in ctr.Items)
                {
                    DataList ctr1 = (DataList)dt.FindControl("dlChildInvName");
                    foreach (DataListItem chk in ctr1.Items)
                    {
                        chkTemp = (CheckBox)chk.FindControl("ChkBox");
                        if (chkTemp.Checked)
                        {
                            lblInvID = (Label)chk.FindControl("lblInvID");
                            lblAccessionNo = (Label)chk.FindControl("lblAccessionNo");
                            lblStatus = (Label)chk.FindControl("lblStatus");
                            strSelVal += lblAccessionNo.Text + ",";

                            objReportPrintHistory = new ReportPrintHistory();
                            objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                            objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                            objReportPrintHistory.Status = lblStatus.Text;
                            lstReportPrintHistory.Add(objReportPrintHistory);
                        }

                    }
                    //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                }
                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));

                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                hdnHideReportTemplate.Value = "1";
                HdnReportParameter.Value = "";
                if (PatOrgID != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, PatOrgID, TempalteName.Value);

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, OrgID, TempalteName.Value);
                }
                
                HdnReportParameter.Value = reportPath + "~" + reportID + "~" + strSelVal;
                //ShowTemplate();
                //ModalPopupExtender1.Show();
                CollapsiblePanelExtender1.Collapsed = true;
                CollapsiblePanelExtender1.ClientState = "true";
               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }

    protected void grdResultDate_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
                InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
                DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");
                //string deptids = string.Empty;

                //foreach (ListItem item in chkDept.Items)
                //{
                //    if (item.Selected)
                //    {
                //        if (item.Text != "-----Select All-----")
                //        {

                //            deptids += item.Value.ToString() + ",";
                //        }

                //    }
                //}

                var ReportNames =
                    from InvName in lstReport
                    group InvName by
                            new
                            {InvName.Type,
                                InvName.InvestigationName,
                               // InvName.TemplateID,
                                InvName.CreatedAt,
                                //InvName.PatientID,
                                //InvName.DeptID,
                                InvName.Status,
                                InvName.PrintCount,
                                //InvName.ReportTemplateName,
                                InvName.PkgName,
                                InvName.AccessionNumber
                                

                            }
                        into grp
                        where grp.ElementAt(0).ReportTemplateName == eInvReportMaster.ReportTemplateName
                                && grp.ElementAt(0).CreatedAt == eInvReportMaster.CreatedAt && grp.Key.Type == eInvReportMaster.Type 
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
                    invRptMaster.DeptID = lstgrp.ElementAt(0).DeptID;
                    invRptMaster.Status = lstgrp.ElementAt(0).Status;
                    invRptMaster.PrintCount = lstgrp.ElementAt(0).PrintCount;
                    invRptMaster.PkgName = lstgrp.ElementAt(0).PkgName;
                    invRptMaster.Type = lstgrp.Key.Type;
                    lstrptMaster.Add(invRptMaster);
                }

                if (lstrptMaster.Count() > 0)
                {
                    dtInvName.DataSource = lstrptMaster;
                    dtInvName.DataBind();
                }

                // hdndeptid.Value = "";

                foreach (DataListItem rpt in dtInvName.Items)
                {
                    CheckBox chkbox = (CheckBox)rpt.FindControl("ChkBox");
                    Label lblDeptID = (Label)rpt.FindControl("lbldeptid");
                    Label lblStatus = (Label)rpt.FindControl("lblStatus");

                    Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
                    InvReportMaster oPINV = (InvReportMaster)e.Item.DataItem;
                    if (oPINV.PkgName != null && oPINV.PkgName.Length > 0)
                    {
                        lblPackageName.Text = String.IsNullOrEmpty(oPINV.PkgName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PkgName + ")</span>";
                    }

                    Label lblcount = (Label)rpt.FindControl("lblPrintCount");

                    int count = 0;
                    if (lblcount.Text.Trim() != "")
                    {
                        count = Convert.ToInt32(lblcount.Text);
                        if (Hdndisablebox.Value == "")
                        { Hdndisablebox.Value = lblcount.Text; }
                        else { Hdndisablebox.Value += '~' + lblcount.Text; }
                    }

                    if (lblStatus != null && lblStatus.Text == "Paid" || lblStatus.Text == "SampleReceived" || lblStatus.Text == "SampleCollected" || lblStatus.Text == "With Held")
                    {
                        chkbox.Enabled = false;
                    }
                    string clientid = chkbox.ClientID;


                    //code added for select all checkbox - begins
                    if (HdnCheckBoxId.Value == "")
                    { HdnCheckBoxId.Value = chkbox.ClientID; }
                    else { HdnCheckBoxId.Value += '~' + chkbox.ClientID; }

                    //code added for select all checkbox - ends
                    hdndeptid.Value += chkbox.ClientID + '~' + lblDeptID.Text + '^';



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
                else if (eInvReportMaster.TemplateID == 7)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "7")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
                            //((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                            ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                        }
                    }
                }
                else if (eInvReportMaster.TemplateID == 10)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "10")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
                            ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                        }
                    }
                }
                else if (eInvReportMaster.TemplateID == 11)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "11")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
                            ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                        }
                    }
                }
                else if (eInvReportMaster.TemplateID == 13)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "13")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
                            ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
                        }
                    }
                }
                else if (eInvReportMaster.TemplateID == 24)
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        Label lbl = ((Label)rpt.FindControl("lblReportID"));
                        if (lbl.Text == "24")
                        {
                            LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                            lnkshow.Visible = true;
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
                else if (eInvReportMaster.TemplateName == "T62")
                {
                    foreach (DataListItem rpt in dtInvName.Items)
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.Parent.NamingContainer.FindControl("lnkShowReport")).Visible = false;
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

                            string strViewImg = Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_07 == null ? "View Image" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_07;

                            lnkshow.Text = strViewImg.Trim();
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading GridItemCommand", ex);
        }
    }
    protected void grdResultDate_ItemCommand(object source, DataListCommandEventArgs e)
    {
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

            //ShowReport(reportPath, pVisitID, reportID, "","","");
            Control ctr = e.Item.FindControl("dlChildInvName");
        }
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
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;
                foreach (DataListItem chk in ctr1.Items)
                {
                    chkTemp = (CheckBox)chk.FindControl("ChkBox");
                    if (chkTemp.Checked)
                    {
                        lblInvID = (Label)chk.FindControl("lblInvID");
                        lblAccessionNo = (Label)chk.FindControl("lblAccessionNo");
                        lblStatus = (Label)chk.FindControl("lblStatus");
                        strSelVal += lblAccessionNo.Text + ",";

                        objReportPrintHistory = new ReportPrintHistory();
                        objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                        objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                        objReportPrintHistory.Status = lblStatus.Text;
                        lstReportPrintHistory.Add(objReportPrintHistory);
                    }

                }
                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }
                //strSelVal += chkTemp.Checked==true? chkTemp.ID: "";
                //}
                //DataList ctr1 =(DataList) ctr.FindControl("dlChildInvName");
                strSelVal = strSelVal.Substring(0, (strSelVal.Length - 1));
                //dReport.Style.Add("display", "none");
                //imgClick.Style.Add("display", "block");
                hdnHideReportTemplate.Value = "1";
                HdnReportParameter.Value = "";
                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, Convert.ToInt32(patOrgID.Value), "");

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, strSelVal, OrgID, "");
                }
                //rptMdlPopup.Show();
                HdnReportParameter.Value = reportPath + "~" + reportID + "~" + strSelVal;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
        }
    }

    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = ((Label)e.Item.FindControl("lblAccessionNo")).Text;
            if (Request.QueryString["vid"] != null)
            {
                pVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                pVisitID = Convert.ToInt64(hdnVID.Value);
            }

            if (reportID == "10")
            {
                investigatgionID = ((Label)e.Item.FindControl("lblInvID")).Text;
                //FckEdit1.LoadPatientDemography(OrgID, pVisitID);
                //FckEdit1.loadText("Notes Report");
                //FckEdit1.loadText(OrgID, Convert.ToInt64(pVisitID), Convert.ToInt32(reportID), Convert.ToInt64(investigatgionID));
                //rptMdlPopup2.Show();


            }
            else
            {
                Label lblInvID, lblAccessionNo, lblStatus;
                List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
                ReportPrintHistory objReportPrintHistory;

                lblInvID = (Label)e.Item.FindControl("lblInvID");
                lblAccessionNo = (Label)e.Item.FindControl("lblAccessionNo");
                lblStatus = (Label)e.Item.FindControl("lblStatus");

                objReportPrintHistory = new ReportPrintHistory();
                objReportPrintHistory.AccessionNumber = Convert.ToInt64(lblAccessionNo.Text);
                objReportPrintHistory.InvestigationID = Convert.ToInt64(lblInvID.Text);
                objReportPrintHistory.Status = lblStatus.Text;
                lstReportPrintHistory.Add(objReportPrintHistory);

                if (lstReportPrintHistory.Count > 0)
                {
                    JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                    hdnlstInvSelected.Value = oSerializer.Serialize(lstReportPrintHistory);
                }

                if (Convert.ToInt32(patOrgID.Value) != OrgID)
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, Convert.ToInt32(patOrgID.Value), "");

                }
                else
                {
                    ShowReport(reportPath, pVisitID, reportID, investigatgionID, OrgID, "");
                }
                //rptMdlPopup.Show();
            }
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

    protected void dlChildInvName_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lblPackageName = (Label)e.Item.FindControl("lblPackageName");
                InvReportMaster oPINV = (InvReportMaster)e.Item.DataItem;
                lblPackageName.Text = String.IsNullOrEmpty(oPINV.PkgName) ? string.Empty : "<br/><span style='padding-left:25px;font-size:9px;'>(" + oPINV.PkgName + ")</span>";
               
                //if (e.Row.RowType == DataControlRowType.DataRow)
                //{
                    //PatientVisit Pv = (PatientVisit)e.Item.DataItem;
                strScript = "ChkIfSelected('" + ((CheckBox)e.Item.FindControl("ChkBox")).ClientID + "','" + oPINV.AccessionNumber + "');";
                //    ((RadioButton)e.Row.Cells[0].FindControl("RdoSelect")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((CheckBox)e.Item.FindControl("ChkBox")).Attributes.Add("onclick", strScript);

                //}

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error packge name ", ex);
        }
    }

    private void bindCheckBox()
    {
        try
        {
            DataList chldDataLst = new DataList();
            CheckBox chkbox = new CheckBox();
            CheckBox chkbox1 = new CheckBox();
            foreach (DataListItem items in grdResultTemp.Items)
            {
                chkbox = (CheckBox)items.FindControl("chkSelectAll");
                chkbox.Attributes.Add("onclick", "javascript:SelectAll('" + chkbox.ClientID + "')");

                chkbox1 = (CheckBox)items.FindControl("chkEnableAll");
                chkbox1.Attributes.Add("onclick", "javascript:EnableAll('" + chkbox1.ClientID + "')");
               ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "javascript:EnableAll('" + chkbox1.ClientID + "');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while bindCheckBox", ex);
        }

    }

    public void ShowReport(string reportPath, long visitID, string templateID, string InvID, int pOrgid, string TemplateName)
    {
        try
        {
           
            
            
            rReportViewer.Visible = false;
            int PatientId = -1;
            List<ReportPrintHistory> lstReportPrintHistory = new List<ReportPrintHistory>();
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
           // lstReportPrintHistory = oSerializer.Deserialize<List<ReportPrintHistory>>(hdnlstInvSelected.Value);

        //    bool isOutsourceExists = lstReportPrintHistory.Exists(P => P.Status == "OutSource");

        //    if (isOutsourceExists)
        //    {
        //        pnlOutDoc.Style.Add("display", "block");
        //        PatientId = Convert.ToInt32(hdnPID.Value);
        //        loadOutSourceDoc(PatientId, Convert.ToInt32(visitID), lstReportPrintHistory[0].InvestigationID);

        //    }
        //    else if (TemplateName == "PDF")
        //    {
        //        Panelpdfupload.Style.Add("display", "block");
        //        PatientId = Convert.ToInt32(hdnPID.Value);
        //        loadOutSourceDoc(PatientId, Convert.ToInt32(visitID), lstReportPrintHistory[0].InvestigationID);
        //    }
        //    else
        //    {
            hdnHideReportTemplate.Value = "1";
           // hdnShowReport.Value = "true";
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            //if (hdnPrintbtnInReportViewer.Value == "Y")
            //{
            //    rReportViewer.ShowPrintButton = false;
            //}
            //else
            {
                rReportViewer.ShowPrintButton = true;
            }

           
            
            connectionString = Utilities.GetConnectionString();

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[8];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(pOrgid));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString); 
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportHeader", "Y");
            reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("ShowReportFooter", "Y");
            reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("IsServiceRequest", "N");
            ReportParameterInfoCollection lstReportParameterCollection = rReportViewer.ServerReport.GetParameters();

            List<Microsoft.Reporting.WebForms.ReportParameter> lstParameter = (from RPC in lstReportParameterCollection
                                                                               join RP in reportParameterList on RPC.Name equals RP.Name
                                                                               select RP).ToList();
            rReportViewer.ServerReport.SetParameters(lstParameter);
            //rReportViewer.ServerReport.SetParameters(reportParameterList);
            
            rReportViewer.ServerReport.Refresh();
            dReport.Style.Add("display", "block");
            //rReportViewer.Show();
            
        
        //        if (hdnPrintbtnInReportViewer.Value == "Y")
        //        {
        //            btnPrint.Enabled = true;
        //            btnSendMail.Enabled = false;
        //        }
        //    }
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


        protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                ///////////////////////
                string fileExtension = string.Empty;
                if (e.CommandName == "ShowWithStationary" || e.CommandName == "ShowWithoutStationary")
                {
                    //TextBox visitid = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientvisitId");
                   //int RowIndex = Convert.ToInt32(e.CommandArgument);
                   //int index = Convert.ToInt32(e.CommandArgument);
                    long pVisitID = -1;
                    long returnCode = -1;
                    long PatientID = -1;
                    string dPatientID = string.Empty;
                    //   dPatientID = Convert.ToString(grdPatientView.DataKeys[RowIndex][0]);
                    //  pVisitID = Convert.ToInt64(grdPatientView.DataKeys[RowIndex][1]);
                    pVisitID = Convert.ToInt64(e.CommandArgument);
                    Int64.TryParse(dPatientID, out PatientID);

                    Report_BL objReportBL = new Report_BL(base.ContextInfo);
                    string strInvStatus = InvStatus.Approved;
                    List<string> lstInvStatus = new List<string>();
                    lstInvStatus.Add(strInvStatus);
                    List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
                    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
                    List<OrderedInvestigations> _PendingInvestigations = new List<OrderedInvestigations>();
                    Investigation_BL ObjInv = new Investigation_BL();
                    string PDFPath = string.Empty;
                    string Status = string.Empty;
                    //string IsDuePending = string.Empty;
                    //returnCode = objReportBL.GetCheckDueAmount(PatientID, pVisitID, OrgID, ILocationID, "P", out IsDuePending);
                    if (e.CommandName == "ShowWithStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID,true,"", out lstReportSnapshot);
                    }
                    if (e.CommandName == "ShowWithoutStationary")
                    {
                        returnCode = objReportBL.GetReportSnapshot(OrgID, ILocationID, pVisitID, false,"",out lstReportSnapshot);
                    }
                    string strRepoartNotReady = Resources.Investigation_AppMsg.Investigation_InvestigationReport_aspx_32 == null ? "Report is not ready" : Resources.Investigation_AppMsg.Investigation_InvestigationReport_aspx_32;

                    if (lstReportSnapshot[0].ReportPath.Length > 0)
                    {
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Report is not ready2');", true);
                        PDFPath = lstReportSnapshot[0].ReportPath;

                    }
                    else {

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strRepoartNotReady + "','" + AlertType + "');", true);
                    
                    }

                    string CurrentOrgID = OrgID.ToString();
                    string filePath = PDFPath;

                    if (e.CommandName == "ShowWithoutStationary")
                    {
                        modalPopUp.Show();
                        ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath);
                       

                    }
                    else
                    {
                       
                        modalPopUp.Show();
                        ifPDF.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=" + filePath);
                       
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Load Child Grid", ex);
            }
        }
}

