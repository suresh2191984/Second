using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Data.SqlClient;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.IO;

public partial class ReportsLims_LabStatisticsReportLims : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    public ReportsLims_LabStatisticsReportLims()
        : base("ReportsLims_LabStatisticsReportLims_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");

        if (!IsPostBack)
        {
            LoadOrgan();
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;
            LoadMetaData();
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            if (Request.QueryString["status"] == "LabOP")
            {
                rblVisitType.SelectedValue = "0";
                btnSubmit_Click(sender, e);
            }
            if (Request.QueryString["status"] == "LabIP")
            {
                rblVisitType.SelectedValue = "1";
                btnSubmit_Click(sender, e);
            }
            if (Request.QueryString["status"] == "LabOPIP")
            {
                rblVisitType.SelectedValue = "-1";
                btnSubmit_Click(sender, e);
            }
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    protected void gvIPReport_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        try
        {
            string DispText = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_001 == null ? "Click Here To view " : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_001;
            string DispText1 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_002 == null ? " details" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_002;
            int totNoofTests = 0;
            string visitType = rblVisitType.SelectedItem.Text;
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Item.DataItem;
                var childItems = (from child in lstDWCR
                                  where child.VisitDate == RMaster.VisitDate
                                  select child).OrderByDescending(o => o.NoOfTests);

                totNoofTests = childItems.Sum(O => O.NoOfTests);
                ((Label)e.Item.FindControl("lblTot")).Text = totNoofTests.ToString();
                RMaster = (DayWiseCollectionReport)e.Item.DataItem;
                LinkButton lnkDwcr = (LinkButton)e.Item.FindControl("lnkDate");
                lnkDwcr.ToolTip = DispText + RMaster.VisitDate + DispText1;
                //lnkDwcr.ForeColor = System.Drawing.Color.Red;


                string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + 0 + "&vdt=" + RMaster.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                lnkDwcr.OnClientClick = "ReportPopUP('" + url + "');";
                GridView childGrid = (GridView)e.Item.FindControl("gvIPCreditMain");

                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            //else if(e.Item.ItemType == ListItemType.Footer)
            //{
            //    //DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Item.DataItem;
            //    //var childItems = from child in lstDWCR
            //    //                 where child.VisitDate == RMaster.VisitDate
            //    //                 select child;

            //   // int totNoofTests = childItems.Sum(O => O.TotalCounts);
            //    ((Label)e.Item.FindControl("lblTot")).Text = totNoofTests.ToString();
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }

    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string DispText = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_001 == null ? "Click Here To view " : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_001;
            string DispText1 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_002 == null ? " details" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_002;
           
            string visitType = rblVisitType.SelectedItem.Text;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport dwcr = new DayWiseCollectionReport();
                dwcr = (DayWiseCollectionReport)e.Row.DataItem;
                LinkButton lnkDept = (LinkButton)e.Row.FindControl("lnkDept");
                //if (dwcr.FeeType != "")
                //{
                if (dwcr.TotalCounts != 0)
                {
                    string fType = string.Empty;
                    lnkDept.ToolTip = DispText + dwcr.DeptName + DispText1;

                    string url = Request.ApplicationPath + @"/Reports/LabSplitDetails.aspx?isPopup=Y&dpt=" + dwcr.DeptName + "&vdt=" + dwcr.VisitDate.ToString("dd/MM/yyyy") + "&vtype=" + visitType;       //DPT Refers to Department ...... VDT Refers to Visit Date
                    lnkDept.OnClientClick = "ReportPopUP('" + url + "');";
                    //}
                }
                else
                {
                    lnkDept.ForeColor = System.Drawing.Color.Black;
                    e.Row.BackColor = System.Drawing.Color.Aqua;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPCreditMain_RowDataBound CollectionDeptwiseReport", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string DispText = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_003 == null ? "OP - Lab Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_003;
            string DispText1 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_004 == null ? "IP - Lab Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_004;
            string DispText2 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_005 == null ? "OP / IP - Lab Statistcs Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_005;
            string DispText3 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_006 == null ? "Lab Statistics Summary Report" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_006;
            string DispText4 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_007 == null ? "CommonMessages_20" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_007;
            string DispText5 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_008 == null ? "Total Number of Lab Tests Done (" : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_008;
            string DispText6 = Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_009 == null ? " To " : Resources.ReportsLims_ClientDisplay.ReportsLims_LabStatisticsReportLims_aspx_009;
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string pHeaderName = string.Empty;
            if (ddlType.SelectedItem.Text == "Detail")
            {
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                returnCode = new Report_BL(base.ContextInfo).GetLabStatisticsReportLim(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);

                var dwcr = (from dw in lstDWCR
                            select new { dw.VisitDate }).Distinct();


                List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
                foreach (var obj in dwcr)
                {
                    DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                    pdc.VisitDate = obj.VisitDate;
                    lstDayWiseRept.Add(pdc);
                }


                if (lstDWCR.Count > 0)
                {
                    divOPDWCR.Attributes.Add("style","display:block");
                    divPrint.Visible = true;
                    divSummary.Visible = false;
                    divSummPrint.Visible = false;
                    gvIPReport.DataSource = null;
                    gvIPReport.DataBind();
                    if (visitType == 0)
                    {
                        //gvOPReport.Visible = false;
                        gvIPReport.Visible = true;
                        //gvIPReport.Columns[0].HeaderText = "OP - Lab Statistcs Report";                      
                        lblHeader.Text = DispText;
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == 1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        lblHeader.Text = DispText1;
                        //gvIPReport.Columns[0].HeaderText = "IP - Lab Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                    else if (visitType == -1)
                    {
                        gvIPReport.Visible = true;
                        //gvOPReport.Visible = false;
                        lblHeader.Text = DispText2;
                        //gvIPReport.Columns[0].HeaderText = "OP / IP - Lab Statistcs Report";
                        gvIPReport.DataSource = lstDayWiseRept;
                        gvIPReport.DataBind();

                    }
                }
                else
                {
                    lblHeader.Text = DispText3;
                    divOPDWCR.Attributes.Add("style", "display:none");
                    divPrint.Visible = false;
                    string sPath = DispText4;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonMessages_20").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideDiv", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{


                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                    //}
                }
            }
            else if (ddlType.SelectedItem.Text == "Summary")
            {
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
                returnCode = new Report_BL(base.ContextInfo).GetLabStatisticsReportSummary(fDate, tDate, OrgID, visitType, pHeaderName, out lstDWCR);
                if (lstDWCR.Count > 0)
                {
                    gvIPReport.DataSource = null;
                    gvIPReport.DataBind();
                    divOPDWCR.Attributes.Add("style", "display:block");
                    divSummary.Visible = true;
                    divPrint.Visible = false;
                    divSummPrint.Visible = true;
                    gvIPSummary.DataSource = lstDWCR;
                    gvIPSummary.DataBind();
                    totTest.Text = DispText5 + txtFDate.Text + " "+DispText6+" "+ txtTDate.Text + ") :" + lstDWCR.Sum(O => O.TotalCounts).ToString();
                }
                else
                {
                    divSummary.Visible = false;
                    divOPDWCR.Attributes.Add("style", "display:none");
                    divPrint.Visible = false;
                    divSummPrint.Visible = false;
                    //string sPath = "CommonMessages_20";
                    string sPath = DispText4;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonMessages_20").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "hideDiv1", "alert('" + sUserMsg + "')", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv1", "javascript:alert('No Matching Records found for the selected dates');", true);
                    //}
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
   

    
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ReportFormat,VisitType";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

           // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ReportFormat"
                                     select child;
                    ddlType.DataSource = childItems;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "DisplayText";
                    ddlType.DataBind();

                }
                var childItems1 = from child in lstmetadataOutput
                                 where child.Domain == "VisitType"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    rblVisitType.DataSource = childItems1;
                    rblVisitType.DataTextField = "DisplayText";
                    rblVisitType.DataValueField = "Code";
                    rblVisitType.DataBind();

                }
           


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }
}
