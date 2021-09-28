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

public partial class Investigation_InvReports : BasePage
{
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long patientVisitID = 0;
    string reportID = string.Empty;
    long investigatgionID = 0;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        btnGo.Attributes.Add("onClick", "return validateVisitSampleNo()");
        if (!IsPostBack)
        {
            int j = 0;
            for (int i = 2009; i <= 2020; i++)
            {
                ddlSearchYear.Items.Insert(j, Convert.ToString(i));
                ddlSearchYear.Items[j].Value = Convert.ToString(i);
                j += 1;
            }
            ddlSearchYear.SelectedValue = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year.ToString();
        }
        if (Request.QueryString.Get("vid") != null)
        {
            txtVisitSampleNo.Text = Request.QueryString.Get("vid").ToString();
            pnlSerch.Visible = false;
            btnGo_Click(sender, e);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        patientVisitID=Convert.ToInt64(txtVisitSampleNo.Text);
        PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
        //Statement Added to change Search by BillID and VisitID
        string year = ddlSearchYear.SelectedValue;
        patientVisitBL.GetVisitIDByBillID(patientVisitID, OrgID, year, out patientVisitID);
        //end of statement
         List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();
         long returnCode = 0;
         int pCount = 0;
         string patientNumber = "";
         returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(Convert.ToInt64(patientVisitID), out pCount, out patientNumber, out lstOrderderd);
            if (lstOrderderd.Count > 0)
            {
                tblPayments.Visible = true;
                lblStatus.Visible = false;
                ReportViewer.Visible = false;
                grdResult.Visible = false;
            }
            else
            {
                tblPayments.Visible = false;
                ReportViewer.Visible = false;
                Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
                objPatientBL.GetReportTemplate(patientVisitID, OrgID, LanguageCode, out lstReport, out lstReportName, out lstDpts);
                if (lstReport.Count() > 0)
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = lstReportName;
                    grdResult.DataBind();
                    lblStatus.Visible = false;
                }
                else
                {
                    lblStatus.Visible = true;
                    grdResult.Visible = false;
                }
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
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
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

    public void ShowReport(string reportPath, long visitID, string templateID, long InvID)
    {
        try
        {
            ReportViewer.Visible = true;
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            ReportViewer.Attributes.Add("style", "width:100%");
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", OrgID);
            ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            ReportViewer.ServerReport.ReportPath = reportPath;
            ReportViewer.ShowParameterPrompts = false;
            ReportViewer.ShowPrintButton = true;
        
            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("TemplateID", templateID);
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("InvestigationID", Convert.ToString(InvID));
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            ReportViewer.ServerReport.SetParameters(reportParameterList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }
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
    
   
    protected void grdResult_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            List<InvReportMaster> lstrptMaster = new List<InvReportMaster>();
            InvReportMaster eInvReportMaster = (InvReportMaster)e.Item.DataItem;
            DataList dtInvName = (DataList)e.Item.FindControl("dlChildInvName");

            var ReportNames = 
                from InvName in lstReport
                group InvName by 
                        new {
                                InvName.InvestigationName,
                                InvName.TemplateID 
                            }
                                into grp
                                where grp.ElementAt(0).TemplateID == eInvReportMaster.TemplateID
                                select grp;
            
            //var customerOrderGroups =
            //    from c in customers
            //    select
            //        new
            //        {
            //            c.CompanyName,
            //            YearGroups =
            //                from o in c.Orders
            //                group o by o.OrderDate.Year into yg
            //                select
            //                    new
            //                    {
            //                        Year = yg.Key,
            //                        MonthGroups =
            //                            from o in yg
            //                            group o by o.OrderDate.Month into mg
            //                            select new { Month = mg.Key, Orders = mg }
            //                    }
            //        };

          
            foreach (var lstgrp in ReportNames)
            {
                InvReportMaster invRptMaster = new InvReportMaster();
                invRptMaster.InvestigationName = lstgrp.Key.InvestigationName;
                invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
                invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
                invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
                lstrptMaster.Add(invRptMaster);
            }

            //foreach (IGrouping<IEnumerable<string>, InvReportMaster> lstgrp in ReportNames)
            //{
            //    InvReportMaster invRptMaster = new InvReportMaster();
            //    invRptMaster.InvestigationName = lstgrp.Key;
            //    invRptMaster.InvestigationID = lstgrp.ElementAt(0).InvestigationID;
            //    invRptMaster.ReportTemplateName = lstgrp.ElementAt(0).ReportTemplateName;
            //    invRptMaster.TemplateID = lstgrp.ElementAt(0).TemplateID;
            //    lstrptMaster.Add(invRptMaster);
            //}

            if (lstrptMaster.Count() > 0)
            {
                dtInvName.DataSource = lstrptMaster;
                dtInvName.DataBind();
            }
            
            if (eInvReportMaster.TemplateID == 4)
            {
                foreach(DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "4")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));
                        lnkshow.Visible = true;
                        ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
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
                        ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
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
                        ((LinkButton)e.Item.FindControl("lnkShowReport")).Visible = false;
                    }
                }
            }
        }
    }

    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            patientVisitID= Convert.ToInt64(txtVisitSampleNo.Text);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            //Statement Added to change Search by BillID and VisitID
            string year = ddlSearchYear.SelectedValue;
            patientVisitBL.GetVisitIDByBillID(patientVisitID, OrgID, year, out patientVisitID);
            //end of statement
            ShowReport(reportPath, patientVisitID, reportID,0);
        }
    }

    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = Convert.ToInt64(((Label)e.Item.FindControl("lblInvID")).Text);
            patientVisitID = Convert.ToInt64(txtVisitSampleNo.Text);
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            //Statement Added to change Search by BillID and VisitID
            string year = ddlSearchYear.SelectedValue;
            patientVisitBL.GetVisitIDByBillID(patientVisitID, OrgID, year, out patientVisitID);
            //end of statement
            ShowReport(reportPath, patientVisitID, reportID, investigatgionID);
        }
    }

   
    protected void btnPayNow_Click(object sender, EventArgs e)
    {
        try
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            long patientVisitId = Convert.ToInt64(txtVisitSampleNo.Text.Trim());
            PatientVisit_BL patientVisitBL = new PatientVisit_BL(base.ContextInfo);
            //Statement Added to change Search by BillID and VisitID
            string year = ddlSearchYear.SelectedValue;
            patientVisitBL.GetVisitIDByBillID(patientVisitId, OrgID, year, out patientVisitId);
            //end of statement
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long taskID = 0;
            long returnCode = 0;
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitId, out lstPatientVisitDetails);
               
            if (RoleName.ToLower() != "Receptionist")
            {
                Tasks task = new Tasks();
                 returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), patientVisitId, 0,
                    lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber,"");
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
                Response.Redirect("~/Reception/SampleBillPrint.aspx?pid=" + lstPatientVisitDetails[0].PatientID, true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
        }
    }
}
