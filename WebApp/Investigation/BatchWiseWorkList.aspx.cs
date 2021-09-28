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
using System.Web.Services;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;
using iTextSharp.tool.xml.html;
using iTextSharp.tool.xml.parser;
using iTextSharp.tool.xml.css;
using iTextSharp.tool.xml.pipeline.html;
using iTextSharp.tool.xml.pipeline.css;
using iTextSharp.tool.xml.pipeline.end;

using System.util;
using System.Net;
using System.Xml;





public partial class Investigation_BatchWiseWorkList : BasePage
{
    public Investigation_BatchWiseWorkList()
        : base("Investigation_BatchWiseWorkList_aspx")
    {
    }
    long returncode = -1;
    Investigation_BL InvBL;
    AdminReports_BL Admin_BL;
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    int pOrderedCount = -1;
    List<InvInstrumentMaster> lstInstrument = new List<InvInstrumentMaster>();
    List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
    Control myControl = null;
    int flag = 0;
    int flag1 = 0;
    string IsPotrait = string.Empty;
    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_01;
    string strAlert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        InvBL = new Investigation_BL(base.ContextInfo);
        hdnOrgID.Value = Convert.ToString(OrgID);
        AutoInvestigations.ContextKey = AutoWorkListID.ContextKey = AutoOrgGroups.ContextKey = OrgID.ToString();
        string checkFormat1 = GetConfigValue("WorkListFormatPrint", this.OrgID);
        hdnHistoFormat.Value = checkFormat1.ToString();
        if (!IsPostBack)
        {
            returncode = InvBL.GetOrgInstruments(OrgID, out lstInstrument);
            ddlInstrument.DataSource = lstInstrument;
            ddlInstrument.DataTextField = "InstrumentName";
            ddlInstrument.DataValueField = "InstrumentID";
            ddlInstrument.DataBind();
            returncode = InvBL.GetInvforDept(OrgID, out lstDpt);
            //LoadInternalExternal();
            if (lstDpt.Count > 0)
            {
                drpdepartment.DataSource = lstDpt;
                drpdepartment.DataTextField = "DeptName";
                drpdepartment.DataValueField = "DeptId";
                drpdepartment.DataBind();
                drpdepartment.Items.Insert(0, strSelect.Trim());
                drpdepartment.Items[0].Value = "0";
            }
            long returnCode = -1;
            Admin_BL = new AdminReports_BL(base.ContextInfo);
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvestigationSampleContainer> lstInvSampleContainer = new List<InvestigationSampleContainer>();
            returnCode = Admin_BL.GetSampleContainer(OrgID, out lstInvSampleMaster, out lstInvSampleContainer);
            if (lstInvSampleMaster.Count > 0)
            {
                ddlSample.DataSource = lstInvSampleMaster;
                ddlSample.DataTextField = "SampleDesc";
                ddlSample.DataValueField = "SampleCode";
                ddlSample.DataBind();
                ddlSample.Items.Insert(0, strSelect.Trim());
                ddlSample.Items[0].Value = "0";
            }
            LoadMetaData();
            LoadInvClientMaster();
            txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            txtSTATNotification.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
            txtRecheckNotification.BackColor = System.Drawing.Color.LightCoral;
            txtVIPNotification.BackColor = System.Drawing.Color.DimGray;
            txtRetestNotification.BackColor = System.Drawing.Color.Bisque;
            txtReflexNotification.BackColor = System.Drawing.Color.Orange;
            txtFrom.Text = OrgTimeZone + " 12:00:00 AM";
            txtTo.Text = OrgDateTimeZone;
        }
        ScriptManager1.RegisterPostBackControl(btnGrpPDF);
        ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
        scriptManager.RegisterPostBackControl(this.lnkExportXL);
        hdnIsWaters.Value = GetConfigValue("WatersMode", OrgID);
    }


    #endregion
    


    #region "Events"
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblResult.Text = "";
        string str1 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06 == null ? "S.No" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06;
        string str2 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_07 == null ? "WorkListID" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_07;
        string str3 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_08 == null ? "Registered.on" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_08;
        string str4 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_09 == null ? "VisitNumber" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_09;
        string str5 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_10 == null ? "Name" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_10;
        string str6 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_11 == null ? "BarcodeNo" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_11;

        string strCheckBoxValidation = Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_15 == null ? "Please select atleast one checkbox" : Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_15;
        DivVisit.Style.Add("display", "block");
        long SearchID = -1;
        long MinVid = -1;
        long MaxVid = -1;
        hdnTable.Value = string.Empty;
        string gUID = string.Empty;
        string WLMode = string.Empty;
        string fromdate = string.Empty, todate = string.Empty;
        string TestType = string.Empty;
        string VisitNumber = string.Empty;
        string chkpendingdayss = string.Empty;
        string Delaydays = string.Empty;

        long deptid = -1;

        if (txtVisitNumber.Text != "" && txtVisitNumber.Text != null)
        {
            ContextInfo.AdditionalInfo = txtVisitNumber.Text;
        }
        else
        {
            ContextInfo.AdditionalInfo = "";
        }


        try
        {
            lblWorkListBasedOn.Text = ddlWorkListType.SelectedItem.Text;
            if (ddlWorkListType.SelectedItem.Value == "0")
            {
                btnSearch.Style.Add("display", "none");
            }
            else
            {
                btnSearch.Style.Add("display", "block");
            }
            if (ddlWorkListType.SelectedItem.Value == "Analyzer_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                SearchID = Convert.ToInt64(ddlInstrument.SelectedValue);
                divAnalyzer.Style.Add("display", "block");
                divInves.Style.Add("display", "none");
                divDept.Style.Add("display", "none"); btnSearch.Style.Add("display", "block");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = ddlInstrument.SelectedItem.Text;
                lblGroupingWorkListtxt1.Text = ddlInstrument.SelectedItem.Text;
                grdresult.Columns[10].Visible = true;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                // Divday.Style.Add("display", "none");
            }
            else if (ddlWorkListType.SelectedItem.Value == "Investigation_Based")
            {
                //if (txtPendingDays.Text != "" && txtPendingDays.Text!="0")
                //{
                //    string Fromdate = string.Empty;
                //    string Todate = string.Empty;
                //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                //    int pendingdays = Convert.ToInt16(txtPendingDays.Text);
                // Calculating the Late's date (substracting days from current date.) 

                //    DateTime s = Convert.ToDateTime(txtFrom.Text.ToString());
                //    s = s.Date.AddDays(-pendingdays);
                //    Fromdate = s.ToString("dd-MM-yyyy 00:00:00");
                //    fromdate = Fromdate;

                //    DateTime s1 = Convert.ToDateTime(txtTo.Text.ToString());
                //    s1 = s1.Date.AddDays(-pendingdays);
                //    Todate = s1.ToString("dd-MM-yyyy 23:59:59");
                //    todate = Todate; 

                //}


                List<int> lstPendingDay = new List<int>();
                int[] PendingDay = { };
                for (int k = 0; k < Chkpendingdays.Items.Count; k++)
                {
                    if (Chkpendingdays.Items[k].Selected == true)
                    {
                        chkpendingdayss = chkpendingdayss + Chkpendingdays.Items[k].Text + "~";
                        lstPendingDay.Add(Convert.ToInt32(Chkpendingdays.Items[k].Text));
                    }
                }

                if (txtPendingDays.Text != "" && chkpendingdayss == "")
                {
                    int pendingdays = Convert.ToInt16(txtPendingDays.Text);
                    chkpendingdayss = chkpendingdayss + pendingdays.ToString() + "~";
                    lstPendingDay.Add(pendingdays);
                }
                else
                {
                    fromdate = txtFrom.Text;
                    todate = txtTo.Text;
                }
                int minDay = 0;
                int maxDay = 0;
                if (lstPendingDay.Count > 0)
                {
                    PendingDay = lstPendingDay.ToArray();
                    minDay = PendingDay.Min();
                    maxDay = PendingDay.Max();
                }
                if (chkdelay.Checked)
                {
                    chkpendingdayss = "DELAY";

                    if (lstPendingDay.Count > 0)
                    {
                        string Fromdate = string.Empty;
                        string Todate = string.Empty;
                        // int s = Convert.ToInt32(chkpendingdayss.Split('~')[0]);
                        int smin = minDay;
                        int smax = maxDay;
                        // DateTime ss = Convert.ToDateTime(txtFrom.Text.ToString());
                        // DateTime ssmin = Convert.ToDateTime(txtFrom.Text.ToString());

                        DateTime ssmin = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        ssmin = ssmin.Date.AddDays(-smin);
                        Todate = ssmin.ToString("dd-MM-yyyy 00:00:00");
                        todate = Todate;
                        int s1 = smax;
                        DateTime ss1 = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        ss1 = ss1.Date.AddDays(-s1 - 15);
                        Fromdate = ss1.ToString("dd-MM-yyyy 00:00:00");
                        fromdate = Fromdate;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "ValidationWindow('" + strCheckBoxValidation.Trim() + "','" + strAlert.Trim() + "');", true);
                    }
                }
                SearchID = Convert.ToInt64(hdnInvestigationID.Value);
                divInves.Style.Add("display", "block");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "block");
                if (ddlTestType.SelectedValue != "All")
                {
                    lblGroupingWorkListtxt.Text = txtInvestigationName.Text + "(" + ddlTestType.SelectedItem.Text + ")";
                    lblGroupingWorkListtxt1.Text = txtInvestigationName.Text + "(" + ddlTestType.SelectedItem.Text + ")";
                }
                else
                {
                    lblGroupingWorkListtxt.Text = txtInvestigationName.Text;
                    lblGroupingWorkListtxt1.Text = txtInvestigationName.Text;
                }
                grdresult.Columns[10].Visible = true;
                TestType = ddlTestType.SelectedValue;
            }
            else if (ddlWorkListType.SelectedItem.Value == "Dept_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                SearchID = Convert.ToInt64(drpdepartment.SelectedValue);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "block");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = drpdepartment.SelectedItem.Text;
                lblGroupingWorkListtxt1.Text = drpdepartment.SelectedItem.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "none");
            }
            else if (ddlWorkListType.SelectedItem.Value == "WorkListID_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                SearchID = Convert.ToInt64(txtWorkListID.Text);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divWorkListID.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = txtWorkListID.Text;
                lblGroupingWorkListtxt1.Text = txtWorkListID.Text;
                grdresult.Columns[10].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "none");
            }
            else if (ddlWorkListType.SelectedItem.Value == "Group_Based" || ddlWorkListType.SelectedItem.Value == "Interface_value")
            {

                List<int> lstPendingDay = new List<int>();
                int[] PendingDay = { };
                for (int k = 0; k < Chkpendingdays.Items.Count; k++)
                {
                    if (Chkpendingdays.Items[k].Selected == true)
                    {
                        chkpendingdayss = chkpendingdayss + Chkpendingdays.Items[k].Text + "~";
                        lstPendingDay.Add(Convert.ToInt32(Chkpendingdays.Items[k].Text));
                    }
                }
                //if (txtPendingDays.Text != "" && txtPendingDays.Text != "0")
                if (txtPendingDays.Text != "" && chkpendingdayss == "")
                {
                    //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    int pendingdays = Convert.ToInt16(txtPendingDays.Text);
                    chkpendingdayss = chkpendingdayss + pendingdays.ToString() + "~";

                    lstPendingDay.Add(pendingdays);


                }
                else
                {
                    fromdate = txtFrom.Text;
                    todate = txtTo.Text;
                }
                int minDay = 0;
                int maxDay = 0;
                if (lstPendingDay.Count > 0)
                {
                    PendingDay = lstPendingDay.ToArray();
                    minDay = PendingDay.Min();
                    maxDay = PendingDay.Max();
                }
                if (chkdelay.Checked)
                {
                    chkpendingdayss = "DELAY";
                    if (lstPendingDay.Count > 0)
                    {
                        string Fromdate = string.Empty;
                        string Todate = string.Empty;
                        // int s = Convert.ToInt32(chkpendingdayss.Split('~')[0]);
                        int smin = minDay;
                        int smax = maxDay;

                        // DateTime ss = Convert.ToDateTime(txtFrom.Text.ToString());
                        // DateTime ssmin = Convert.ToDateTime(txtFrom.Text.ToString());
                        DateTime ssmin = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        // DateTime ssmax = Convert.ToDateTime(txtFrom.Text.ToString());
                        // ss = ss.Date.AddDays(-s - 15);
                        ssmin = ssmin.Date.AddDays(-smin);
                        // ssmax = ss.Date.AddDays(-smax - 15);
                        Todate = ssmin.ToString("dd-MM-yyyy 00:00:00");
                        todate = Todate;

                        int s1 = smax;
                        DateTime ss1 = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        ss1 = ss1.Date.AddDays(-s1 - 15);
                        Fromdate = ss1.ToString("dd-MM-yyyy 00:00:00");
                        fromdate = Fromdate;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "ValidationWindow('" + strCheckBoxValidation.Trim() + "','" + strAlert.Trim() + "');", true);
                    }

                }
                SearchID = Convert.ToInt64(hdnGrpID.Value);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "block");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                //Divday.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = txtGrps.Text;
                lblGroupingWorkListtxt1.Text = txtGrps.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
            }
            else if (ddlWorkListType.SelectedItem.Value == "ProtocalGroup_Based")
            {
                List<int> lstPendingDay = new List<int>();
                int[] PendingDay = { };
                for (int k = 0; k < Chkpendingdays.Items.Count; k++)
                {
                    if (Chkpendingdays.Items[k].Selected == true)
                    {
                        chkpendingdayss = chkpendingdayss + Chkpendingdays.Items[k].Text + "~";
                        lstPendingDay.Add(Convert.ToInt32(Chkpendingdays.Items[k].Text));
                    }
                }
                if (txtPendingDays.Text != "" && chkpendingdayss == "")
                {
                    //sDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                    int pendingdays = Convert.ToInt16(txtPendingDays.Text);
                    chkpendingdayss = chkpendingdayss + pendingdays.ToString() + "~";
                    lstPendingDay.Add(pendingdays);
                }
                // Calculating the Late's date (substracting days from current date.) 

                //    DateTime s = Convert.ToDateTime(txtFrom.Text.ToString());
                //    s = s.Date.AddDays(-pendingdays);
                //    Fromdate = s.ToString("dd-MM-yyyy 00:00:00");
                //    fromdate = Fromdate;

                //    DateTime s1 = Convert.ToDateTime(txtTo.Text.ToString());
                //    s1 = s1.Date.AddDays(-pendingdays);
                //    Todate = s1.ToString("dd-MM-yyyy 23:59:59");
                //    todate = Todate;

                //}
                else
                {
                    fromdate = txtFrom.Text;
                    todate = txtTo.Text;
                }
                int minDay = 0;
                int maxDay = 0;
                if (lstPendingDay.Count > 0)
                {
                    PendingDay = lstPendingDay.ToArray();
                    minDay = PendingDay.Min();
                    maxDay = PendingDay.Max();
                }
                if (chkdelay.Checked)
                {
                    chkpendingdayss = "DELAY";
                    if (lstPendingDay.Count > 0)
                    {
                        string Fromdate = string.Empty;
                        string Todate = string.Empty;
                        // int s = Convert.ToInt32(chkpendingdayss.Split('~')[0]);
                        int smin = minDay;
                        int smax = maxDay;

                        // DateTime ss = Convert.ToDateTime(txtFrom.Text.ToString());
                        // DateTime ssmin = Convert.ToDateTime(txtFrom.Text.ToString());
                        DateTime ssmin = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        // DateTime ssmax = Convert.ToDateTime(txtFrom.Text.ToString());
                        // ss = ss.Date.AddDays(-s - 15);
                        ssmin = ssmin.Date.AddDays(-smin);
                        // ssmax = ss.Date.AddDays(-smax - 15);
                        Todate = ssmin.ToString("dd-MM-yyyy 00:00:00");
                        todate = Todate;

                        int s1 = smax;
                        DateTime ss1 = Convert.ToDateTime(DateTime.Today.ToLongTimeString());
                        ss1 = ss1.Date.AddDays(-s1 - 15);
                        Fromdate = ss1.ToString("dd-MM-yyyy 00:00:00");
                        fromdate = Fromdate;
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "ValidationWindow('" + strCheckBoxValidation.Trim() + "','" + strAlert.Trim() + "');", true);
                    }
                }
                SearchID = Convert.ToInt64(ddlProGrp.SelectedValue);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                divproGrp.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = ddlProGrp.SelectedItem.Text;
                lblGroupingWorkListtxt1.Text = ddlProGrp.SelectedItem.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "block");
            }

            else if (ddlWorkListType.SelectedItem.Value == "Special_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                deptid = Convert.ToInt64(drpdepartment.SelectedValue);
                SearchID = Convert.ToInt64(hdnGrpID.Value);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "block");//
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "none");
                lblGroupingWorkListtxt.Text = txtFrom.Text + " to " + txtTo.Text;
                lblGroupingWorkListtxt1.Text = txtFrom.Text + " to " + txtTo.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "none");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:block");
                pnlpendingdays.Style.Add("display", "none");
                trPrint.Attributes.Add("style", "display:none");
                dvgrdGroupResultWL11.Attributes.Add("style", "display:none");
                dvgrdGroupResultWL111.Attributes.Add("style", "display:none");
                tbGrdResult.Attributes.Add("style", "display:none");
                // Divday.Style.Add("display", "none");
            }

            else if (ddlWorkListType.SelectedItem.Value == "Date_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "none");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = txtFrom.Text + " to " + txtTo.Text;
                lblGroupingWorkListtxt1.Text = txtFrom.Text + " to " + txtTo.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                // Divday.Style.Add("display", "none");
            }
            else if (ddlWorkListType.SelectedItem.Value == "Visit_Level")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                MinVid = Convert.ToInt64(txtFromVist.Text);
                MaxVid = Convert.ToInt64(txtTovist.Text);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                divSample.Style.Add("display", "none");
                DivVist.Style.Add("display", "block");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = txtFromVist.Text + " to " + txtTovist.Text;
                lblGroupingWorkListtxt1.Text = txtFromVist.Text + " to " + txtTovist.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "none");

            }
            else if (ddlWorkListType.SelectedItem.Value == "Sample_Based")
            {
                fromdate = txtFrom.Text;
                todate = txtTo.Text;
                SearchID = Convert.ToInt64(ddlSample.SelectedValue);
                divInves.Style.Add("display", "none");
                divAnalyzer.Style.Add("display", "none");
                divDept.Style.Add("display", "none");
                divWorkListID.Style.Add("display", "none");
                divGrps.Style.Add("display", "none");
                DivDate.Style.Add("display", "block");
                DivVist.Style.Add("display", "none");
                divSample.Style.Add("display", "block");
                divVIP.Style.Add("display", "block");
                lblGroupingWorkListtxt.Text = ddlSample.SelectedItem.Text;
                lblGroupingWorkListtxt1.Text = ddlSample.SelectedItem.Text;
                grdresult.Columns[11].Visible = false;
                TestType = ddlTestType.SelectedValue;
                DivVisit.Style.Add("display", "block");
                divproGrp.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                //  Divday.Style.Add("display", "none");
            }
            if (chkIncludeGeneratedWL.Checked == true)
            {
                WLMode = "All";
                grdresult.Columns[1].Visible = true;
                tdWLIDSummery.Style.Add("display", "none");

            }
            else
            {
                WLMode = "New";
                grdresult.Columns[1].Visible = false;
                tdWLIDSummery.Style.Add("display", "block");
            }
            //returncode = InvBL.GetPatientMinNMaxVisitsForWorkList(OrgID, InstrumentID, out MinVid, out MaxVid);
            List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
            //InvBL.GetInvestigationDetailsForExternalVisitID(MinVid.ToString(), MaxVid.ToString(), OrgID, RoleID, "", ILocationID, "", "", out lstPatientInvestigation);
            foreach (PatientInvestigation patient in lstPatientInvestigation)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = patient.InvestigationID;
                objInvest.InvestigationName = patient.InvestigationName;
                objInvest.PatientVisitID = patient.PatientVisitID;
                objInvest.GroupID = patient.GroupID;
                objInvest.GroupName = patient.GroupName;
                objInvest.Status = patient.Status;
                objInvest.CollectedDateTime = patient.CreatedAt;
                objInvest.CreatedBy = LID;
                objInvest.Type = patient.Type;
                objInvest.OrgID = OrgID;
                objInvest.InvestigationMethodID = 0;
                objInvest.KitID = 0;
                objInvest.InstrumentID = 0;
                objInvest.UID = patient.UID;
                SaveInvestigation.Add(objInvest);
            }
            if (SaveInvestigation.Count > 0)
            {
                //returncode = InvBL.SavePatientInvestigationForWorkList(SaveInvestigation, OrgID, gUID, out pOrderedCount);
            }
            string strStatus = string.Empty;
            if (chkAll.Checked == true)
            {
                if (chkPending.Checked == true)
                    strStatus = "SampleReceived" + "~" + "Pending";
                if (chkPartiallyApproved.Checked == true)
                    strStatus += "~" + "PartiallyApproved";
            }
            else
            {
                if (chkPending.Checked == true)
                    strStatus = "SampleReceived" + "~" + "Pending";

                if (chkPartiallyApproved.Checked == true)
                    if (strStatus == "")
                    { strStatus += "PartiallyApproved"; }
                    else { strStatus += "~" + "PartiallyApproved"; }
            }
          //  CLogger.LogWarning("jeyakumar Step1");
            if (ddlWorkListType.SelectedItem.Value == "Special_Based")
            {
                returncode = InvBL.GetBatchWiseWorklistforspecialsamples(ddlWorkListType.SelectedItem.Value, SearchID,deptid, OrgID, WLMode, fromdate, todate, out lstPatientInvestigation);
            }
            else if (ddlWorkListType.SelectedItem.Value == "Interface_value")
            {
                string visitnumber = string.Empty;
                if (txtVisitNumber.Text != "" && txtVisitNumber.Text != null)
                {
                    visitnumber = txtVisitNumber.Text;
                }
                else
                {
                    visitnumber = "";
                }
                lblWLUser1.Visible=true;
                lblWLOn.Text = OrgDateTimeZone;
                lblWLIDtxt.Text = "";
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Script", "LoadInterfacedValue('" + ddlWorkListType.SelectedItem.Value + "','" + SearchID + "','" + TestType + "','" + OrgID + "','" + WLMode + "','" + fromdate + "', '" + todate + "', '"+MinVid+"','"+ MaxVid+"','"+visitnumber+"');", true);
            }
            else
            {
            returncode = InvBL.GetBatchWiseWorklist(Convert.ToInt32(ddlClients.SelectedValue), ddlWorkListType.SelectedItem.Value, SearchID, OrgID, WLMode, fromdate, todate, TestType,
                MinVid, MaxVid, chkpendingdayss, strStatus, out Delaydays, out lstPatientInvestigation);
            }
                //  CLogger.LogWarning("jeyakumar Step2");
            grdGroupResult.DataSource = null;
            grdGroupResult.DataBind();

            grdresult.DataSource = null;
            grdresult.DataBind();

            if (ddlWorkListType.SelectedItem.Value == "Group_Based" || ddlWorkListType.SelectedItem.Value == "Date_Based" || ddlWorkListType.SelectedItem.Value == "Visit_Level" || ddlWorkListType.SelectedItem.Value == "Interface_value")
            {
                List<PatientInvestigation> PDetailsLst = new List<PatientInvestigation>();
                PDetailsLst = (from S in lstPatientInvestigation
                               where S.Migrated_Visit_Number != null
                               group S by new { S.Migrated_Visit_Number, S.PatientVisitID, S.InvestigationValue, S.InvestigationName, S.Name, S.WorkListID, S.DeviceID, S.Age, S.IsAutoAuthorize } into g
                               select new PatientInvestigation
                               {
                                   Migrated_Visit_Number = g.Key.Migrated_Visit_Number,
                                   PatientVisitID = g.Key.PatientVisitID,
                                   InvestigationValue = g.Key.InvestigationValue,
                                   InvestigationName = g.Key.InvestigationName,
                                   Name = g.Key.Name,
                                   WorkListID = g.Key.WorkListID,
                                   DeviceID = g.Key.DeviceID,
                                   Age = g.Key.Age,
                                   IsAutoAuthorize = g.Key.IsAutoAuthorize
                                   //WorklistCreatedby = g.Key.WorklistCreatedby
                                   //Name = g.Key.Name,
                                   //Comments = g.Key.Comments
                               }).Distinct().ToList();
                long returncode1 = -1;
                JavaScriptSerializer oSerializer = new JavaScriptSerializer();
                hdnTable.Value = oSerializer.Serialize(PDetailsLst);
                int GroupId = Convert.ToInt32(SearchID);
                long patientvisit = -1;
                //long patientvisit = PDetailsLst[1].PatientVisitID; 
                List<DeviceImportData> LstDevice = new List<DeviceImportData>();
                returncode1 = new Investigation_BL(base.ContextInfo).GetInvestigationAbbCode(GroupId, patientvisit, out LstDevice);
                string ddl = Request.Params["ddlWLFormatType"];
                GroupTable.Rows.Clear();
                if (ddlWLFormatType.SelectedItem.Text == "Portrait Format")
                {
                    grdGroupResultWL2.DataSource = lstPatientInvestigation;
                    grdGroupResultWL2.DataBind();
                    trGrpBased1.Style.Add("display", "block");
                    tdGrpTable.Style.Add("display", "none");
                    trGrpBased.Style.Add("display", "none");
                    trInvBased.Style.Add("display", "none");
                    trInvBased1.Style.Add("display", "none");
                    divspec.Attributes.Add("style", "display:none");

                }
                else if (ddlWLFormatType.SelectedItem.Text == "Group Contents in Column")
                {
                    lnkExportXL.Visible = false;
                    grdGroupResult.Visible = false;
                    trGrpBased1.Style.Add("display", "none");
                    tdGrpTable.Style.Add("display", "block");
                    trInvBased.Style.Add("display", "none");
                    trGrpBased.Style.Add("display", "block");
                    divspec.Attributes.Add("style", "display:none");
                    TableRow row = new TableRow();
                    TableRow row1 = new TableRow();
                    int flag = 0;
                    if (PDetailsLst.Count > 0)
                    {
                        TableCell tc = new TableCell();
                        TableCell WL = new TableCell();
                        TableCell Rg = new TableCell();
                        TableCell tc1 = new TableCell();
                        TableCell Vst = new TableCell();
                        TableCell Pat = new TableCell();
                        tc.Text = "S.No";
                        WL.Text = "WorkListID";
                        Rg.Text = "Registered.on";
                        Vst.Text = "VisitNumber";
                        Pat.Text = "Name";
                        tc1.Text = "BarcodeNo";
                        Rg.BorderWidth = 1;
                        WL.BorderWidth = 1;
                        tc.BorderWidth = 1;
                        Vst.BorderWidth = 1;
                        Pat.BorderWidth = 1;
                        //tc.Style.Add("width", "50%");
                        tc1.BorderWidth = 1;
                        tc1.Attributes.Add("align", "left");
                        Vst.Attributes.Add("align", "left");
                        Pat.Attributes.Add("align", "left");
                        row.Cells.Add(tc);
                        row.Cells.Add(WL);
                        row.Cells.Add(Rg);
                        row.Cells.Add(Vst);
                        row.Cells.Add(Pat);
                        row.Cells.Add(tc1);
                        foreach (DeviceImportData lstpat in LstDevice)
                        {
                            TableCell cell = new TableCell();
                            TableCell cell1 = new TableCell();
                            cell.Text = lstpat.TestCode.ToString();
                            cell.BorderWidth = 1;
                            cell1.BorderWidth = 1;
                            cell.Style.Add("width", "7%");
                            row.Cells.Add(cell);
                            row1.Cells.Add(cell1);
                        }
                        TableCell tc2 = new TableCell();
                        //tc2.Text = "Generated By";
                        tc2.BorderWidth = 1;
                        //row.Cells.Add(tc2);
                        InvTable.Rows.Add(row);
                        int z = 1;
                        for (int i = 0; i < PDetailsLst.Count; i++)
                        {
                            TableRow tr = new TableRow();
                            TableCell td = new TableCell();
                            TableCell WL1 = new TableCell();
                            TableCell Rg1 = new TableCell();
                            TableCell td1 = new TableCell();
                            TableCell td2 = new TableCell();
                            TableCell Pat1 = new TableCell();
                            //if (lstPatientInvestigation[i].Migrated_Visit_Number.ToString() != "0")
                            //{
                            //    td1.Text = lstPatientInvestigation[i].Migrated_Visit_Number.ToString() + "-" + lstPatientInvestigation[i].Name.ToString();
                            //}
                            ////td1.Text = 
                            if (!String.IsNullOrEmpty(PDetailsLst[i].InvestigationValue))
                            {
                                td1.Text = PDetailsLst[i].InvestigationValue.ToString();
                            }
                            else
                            {
                                td1.Text = PDetailsLst[i].Migrated_Visit_Number.ToString();
                            }
                            if (!String.IsNullOrEmpty(PDetailsLst[i].Migrated_Visit_Number))
                            {
                                td2.Text = PDetailsLst[i].Migrated_Visit_Number.ToString();
                            }
                            if (!String.IsNullOrEmpty(PDetailsLst[i].Name))
                            {
                                Pat1.Text = PDetailsLst[i].Name.ToString();
                            }
                            if (!String.IsNullOrEmpty(PDetailsLst[i].WorkListID.ToString()))
                            {
                                WL1.Text = PDetailsLst[i].WorkListID.ToString();
                            }
                            if (!String.IsNullOrEmpty(PDetailsLst[i].DeviceID.ToString()))
                            {
                                Rg1.Text = PDetailsLst[i].DeviceID.ToString();
                            }
                            td.Text = (z++).ToString();
                            td1.Style.Add("width", "7%");
                            td2.Style.Add("width", "10%");
                            Pat1.Style.Add("width", "20%");
                            td1.Attributes.Add("align", "left");
                            td2.Attributes.Add("align", "left");
                            Pat1.Attributes.Add("align", "left");
                            td.BorderWidth = 1;
                            WL1.BorderWidth = 1;
                            td1.BorderWidth = 1;
                            Rg1.BorderWidth = 1;
                            td2.BorderWidth = 1;
                            Pat1.BorderWidth = 1;
                            tr.Cells.Add(td);
                            tr.Cells.Add(WL1);
                            tr.Cells.Add(Rg1);
                            tr.Cells.Add(td2);
                            tr.Cells.Add(Pat1);
                            tr.Cells.Add(td1);
                            foreach (DeviceImportData lstpat in LstDevice)
                            {
                                TableCell cell2 = new TableCell();
                                TableRow row2 = new TableRow();
                                cell2.Text = "";
                                cell2.BorderWidth = 1;
                                tr.Cells.Add(cell2);
                                flag++;
                            }
                            //TableCell td2 = new TableCell();
                            //if (!String.IsNullOrEmpty(PDetailsLst[i].WorklistCreatedby))
                            //{
                            //    td2.Text = PDetailsLst[i].WorklistCreatedby;
                            //}
                            //td2.BorderWidth = 1;
                            //tr.Cells.Add(td2);
                            InvTable.Rows.Add(tr);
                        }
                    }
                }
                else if (ddlWLFormatType.SelectedItem.Text == "3 Column Group Contents")
                {
                    grdGroupResult.Visible = false;
                    lnkExportXL.Visible = false;
                    tdGrpTable1.Style.Add("display", "block");
                    trGrpBased1.Style.Add("display", "none");
                    tdGrpTable.Style.Add("display", "none");
                    trInvBased.Style.Add("display", "none");
                    trGrpBased.Style.Add("display", "block");
                    divspec.Attributes.Add("style", "display:none");
                    GroupTable.Rows.Clear();
                    TableRow row = new TableRow();
                    TableRow row1 = new TableRow();
                    int flag = 0;
                    if (PDetailsLst.Count > 0)
                    {
                        TableRow row3 = new TableRow();
                        TableCell tcl = new TableCell();
                        TableCell tcl1 = new TableCell();
                        TableCell tcl12 = new TableCell();
                        TableCell tcl13 = new TableCell();
                        tcl.Text = str1.Trim();
                        //tcl1.Text = "GeneratedBy";
                        tcl12.Text = "PatientDetails";
                        tcl13.Text = "Code";
                        //tcl13.Attributes.Add("align", "left");
                        row3.Cells.Add(tcl);
                        //row3.Cells.Add(tcl1);
                        row3.Cells.Add(tcl12);
                        row3.Cells.Add(tcl13);
                        GroupTable.Rows.Add(row3);

                        TableCell tc = new TableCell();
                        tc.Text = str1.Trim();
                        tc.BorderWidth = 1;
                        row.Cells.Add(tc);
                        InvTable.Rows.Add(row);
                        int z = 1;
                        for (int i = 0; i < PDetailsLst.Count; i++)
                        {
                            TableRow row2 = new TableRow();
                            TableCell td = new TableCell();
                            td.Text = (z++).ToString();
                            row2.Cells.Add(td);
                            //TableCell td2 = new TableCell();
                            //if (!String.IsNullOrEmpty(PDetailsLst[i].WorklistCreatedby))
                            //{
                            //    td2.Text = PDetailsLst[i].WorklistCreatedby.ToString();
                            //}
                            //row2.Cells.Add(td2);
                            TableCell td1 = new TableCell();
                            td1.Attributes.Add("align", "center");
                            td1.Text = "Name :" + " " + PDetailsLst[i].Name.ToString() + "<br/>" + "Age :" + " " + PDetailsLst[i].Age.ToString() + "<br/>" + "VID :" + " " +
                                PDetailsLst[i].Migrated_Visit_Number.ToString() + "<br/>" + "SID :" + " " + PDetailsLst[i].InvestigationValue.ToString() + "</br>"
                            + "Receivedon :" + PDetailsLst[i].IsAutoAuthorize.ToString();
                            row2.Cells.Add(td1);

                            flag = 0;
                            TableCell Cell3 = new TableCell();
                            //Cell3.BorderWidth = 1;
                            foreach (DeviceImportData objWL in LstDevice)
                            {
                                Cell3 = new TableCell();
                                Cell3.Attributes.Add("align", "left");
                                //Cell3.BorderWidth=1;
                                if (flag >= 3)
                                {
                                    flag = 0;
                                    row2 = new TableRow();
                                    Cell3 = new TableCell();
                                    //Cell3.BorderWidth = 1;
                                    Cell3.Attributes.Add("align", "left");
                                    //TableCell Cell4 = new TableCell();
                                    //Cell4.Text = "";
                                    //Cell4.BorderWidth = 1;
                                    TableCell Cell5 = new TableCell();
                                    Cell5.Text = "";
                                    //Cell5.BorderWidth = 1;
                                    TableCell Cell6 = new TableCell();
                                    Cell6.Text = "";
                                    //Cell6.BorderWidth = 1;
                                    //row2.Cells.Add(Cell4);
                                    row2.Cells.Add(Cell5);
                                    row2.Cells.Add(Cell6);
                                }
                                Cell3.Text = objWL.TestCode.ToString() + "______";
                                flag++;
                                row2.Cells.Add(Cell3);
                                GroupTable.Rows.Add(row2);
                            }

                            GroupTable.Rows.Add(row2);
                        }
                    }
                }
                else
                {
                    grdGroupResult.DataSource = lstPatientInvestigation;
                    grdGroupResult.DataBind();
                    grdGroupResult.Visible = true;
                    tdGrpTable.Style.Add("display", "none");
                    trGrpBased.Style.Add("display", "block");
                    trGrpBased1.Style.Add("display", "none");
                    trInvBased1.Style.Add("display", "none");
                    trInvBased.Style.Add("display", "none");

                }
                //trGrpBased.Style.Add("display", "block");
                //}
            }
            else if (ddlWLFormatType.SelectedValue == "Special Format")
            {
                trPrint.Attributes.Add("style", "display:none");
                dvgrdGroupResultWL11.Attributes.Add("style", "display:none");
                dvgrdGroupResultWL111.Attributes.Add("style", "display:none");
                tbGrdResult.Attributes.Add("style", "display:none");
                
                List<PatientInvestigation> lst = new List<PatientInvestigation>();
                if (lstPatientInvestigation.Count > 0)
                {
                    grdGroupResult.DataSource = lstPatientInvestigation;
                    grdGroupResult.DataBind();
                    divspec.Attributes.Add("style", "display:block");
                    btnspecprint.Attributes.Add("style", "display:block");
                    DataTable dt = ConvertToPatientInvestigation(lstPatientInvestigation);

                    StringBuilder strHTMLBuilder = new StringBuilder();

                    if (GetConfigValue("LandScapeWorkList", this.OrgID) == "LandScapeWorkList")
                    {
                        foreach (PatientInvestigation myColumn in lstPatientInvestigation)
                        {

                            strHTMLBuilder.Append("<html >");
                            strHTMLBuilder.Append("<head>  ");
                            strHTMLBuilder.Append("</head>");
                            strHTMLBuilder.Append("<body>");
                            strHTMLBuilder.Append("</br>");
                            strHTMLBuilder.Append("<table  style='line-height: 10px;width: 100%;' border='0px' cellspacing='4' bgcolor='white' ;'>");

                            strHTMLBuilder.Append("<tr >");
                            strHTMLBuilder.Append("<td align='center' style='font-size:large;' colspan='5'>");
                            strHTMLBuilder.Append("<B>");
                            strHTMLBuilder.Append(" WORKLIST");
                            strHTMLBuilder.Append("</B>");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("</tr>");
                            strHTMLBuilder.Append("<tr>");
                            strHTMLBuilder.Append("<td colspan=5>");
                            strHTMLBuilder.Append("<table  style='line-height: 15px;width: 100%;font-family:Calibri;font-size:20px' border='0px' cellspacing='4' bgcolor='white' ;'>");


                            strHTMLBuilder.Append("<tr>");
                            strHTMLBuilder.Append("<td align='Left' style='width:10%' colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Patient Name: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style='width:20%'>");//font-size: 14;
                            strHTMLBuilder.Append(myColumn.Name);
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append(" <td align='left' style=' width:10%' colspan='1'>");//font - size: 18;
                            strHTMLBuilder.Append("WorkList No: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=' width:25%'>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.WorkListID);
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style='width:12%' colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("WorkList Generated by: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style='' >");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.WorklistCreatedby);
                            strHTMLBuilder.Append("</td>");
                           
                            strHTMLBuilder.Append("</tr>");
                            strHTMLBuilder.Append("<tr >");

                            strHTMLBuilder.Append("<td align='left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Age/Gender: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.Age);
                            strHTMLBuilder.Append("/");
                            strHTMLBuilder.Append(myColumn.Sex);
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("TestName: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''><b>");//font-size: 14;
                            strHTMLBuilder.Append(myColumn.GroupName);
                            strHTMLBuilder.Append("</b></td>");
                            strHTMLBuilder.Append("<td align='left' style='' colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("WorkList Generated On: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style='' >");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.KitName);
                            strHTMLBuilder.Append("</td>");
                          
                            strHTMLBuilder.Append("</tr>");
                            strHTMLBuilder.Append("<tr>");
                            strHTMLBuilder.Append("<td align='Left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Visit ID: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.VisitNumber);
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Client Name: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.ClientName);

                            strHTMLBuilder.Append("</td>");

                            strHTMLBuilder.Append("<td align='left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Date of Collection: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                            if ((myColumn.CollectedDateTime == Convert.ToDateTime("Jan 1 1900 12:00AM ")) || (myColumn.CollectedDateTime == Convert.ToDateTime("01/01/0001 00:00:00")) || (myColumn.CollectedDateTime == Convert.ToDateTime("1900-01-01 00:00:00.000")))//Convert.ToDateTime("01/01/0001 00:00:00"))
                            {
                                strHTMLBuilder.Append("");
                            }
                            else
                            {
                                strHTMLBuilder.Append(myColumn.CollectedDateTime.ToString("MMM d yyyy h:mmtt"));
                               
                            }

                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("</tr>");
                            strHTMLBuilder.Append("<tr>");
                            strHTMLBuilder.Append("<td align='left' style='' colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Sample ID: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                            //strHTMLBuilder.Append(ddlWorkListType.SelectedItem.Text);
                            strHTMLBuilder.Append(myColumn.BarcodeNumber);
                            strHTMLBuilder.Append("</td>");


                            strHTMLBuilder.Append("<td align='left' style='' >");//font-size: 18;
                            strHTMLBuilder.Append("Ref Doctor: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.PerformingPhysicainName);
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style='' >");//font-size: 18;
                            strHTMLBuilder.Append("Date of Received: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''>");//font-size: 18;
                            if ((myColumn.ReceivedDateTime == null))
                            {
                                strHTMLBuilder.Append("");
                            }
                            else
                            {
                                strHTMLBuilder.Append(myColumn.ReceivedDateTime);

                            }
                            strHTMLBuilder.Append("</td>");
                           
                            strHTMLBuilder.Append("</tr>");

                            strHTMLBuilder.Append("<tr >");
                            strHTMLBuilder.Append("<td align='left' style='' colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Sample Type: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                           // strHTMLBuilder.Append(ddlWorkListType.SelectedItem.Text);
                            strHTMLBuilder.Append(myColumn.LabNo);
                            strHTMLBuilder.Append("</td>");

                            strHTMLBuilder.Append("<td align='left' style=''colspan='1'>");//font-size: 18;
                            strHTMLBuilder.Append("Ward/Bed Details: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style=''>");//font-size: 18;
                            strHTMLBuilder.Append(myColumn.UID);

                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style='' >");//font-size: 18;
                            strHTMLBuilder.Append("Date of Reporting: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='Left' style=''>");//font-size: 18;
                            if ((myColumn.ApprovedAt == Convert.ToDateTime("01/01/1900 00:00:00")) || (myColumn.ApprovedAt == Convert.ToDateTime("01/01/0001 00:00:00")) || (myColumn.ApprovedAt == Convert.ToDateTime("31/12/9999 23:59:00")))
                            {
                                strHTMLBuilder.Append("");
                            }
                            else
                            {
                                strHTMLBuilder.Append(myColumn.ApprovedAt.ToString("MMM d yyyy hh:mmtt"));
                               
                            }
                            strHTMLBuilder.Append("</td>");

                            //strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'> ");
                            //strHTMLBuilder.Append("</td>");

                            //strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'> ");
                            //strHTMLBuilder.Append("</td>");
                        





                          



                            //strHTMLBuilder.Append("<td align='left' style='width: 159px; font-size: 16;' colspan='1'>");
                            //strHTMLBuilder.Append("Specimen: ");
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='left' style='font-size: 16;'>");
                            //strHTMLBuilder.Append(myColumn.LabNo);
                            //strHTMLBuilder.Append("</td>");
                            




                         
                           
                        

                            strHTMLBuilder.Append("</tr>");


                            //strHTMLBuilder.Append("<tr >");

                            //strHTMLBuilder.Append("<td align='Left'>");
                            //strHTMLBuilder.Append("Specimen: ");
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='Left'>");
                            //strHTMLBuilder.Append(myColumn.WorklistType);
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='Left'>");
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='left'>");
                            //strHTMLBuilder.Append("Age: ");
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='left'>");
                            //strHTMLBuilder.Append(myColumn.Age);
                            //strHTMLBuilder.Append("</td>");

                            //strHTMLBuilder.Append("</tr>");
                            //strHTMLBuilder.Append("<tr >");

                          

                          
                            //strHTMLBuilder.Append("<td align='left' style='font-size: 16;'>");
                            //if (myColumn.TATDateTime == "")
                            //{
                            //    strHTMLBuilder.Append("");
                            //}
                            //else
                            //{
                            //    strHTMLBuilder.Append(myColumn.TATDateTime);
                            //}
                            //strHTMLBuilder.Append("</td>");
                            //// strHTMLBuilder.Append(myColumn.RegisteredDate);
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='Left' style='font-size: 16;'colspan='1'>");
                            //strHTMLBuilder.Append("Test Code: ");
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("<td align='left' style='font-size: 16;'>");
                            //strHTMLBuilder.Append(myColumn.GroupComment);
                            //strHTMLBuilder.Append("</td>");
                            //strHTMLBuilder.Append("</tr>");



                            //strHTMLBuilder.Append("<tr >");

                          
                            //strHTMLBuilder.Append("<td align='Left' style='font-size: 16;'> ");
                            //strHTMLBuilder.Append("</td>");
                          
                            //strHTMLBuilder.Append("<td align='Left' style='font-size: 16;'> ");
                            //strHTMLBuilder.Append("</td>");
                          
                            //strHTMLBuilder.Append("</tr>");

                            strHTMLBuilder.Append("</table >");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("</tr >");

                            strHTMLBuilder.Append("<tr >");
                            strHTMLBuilder.Append("<td colspan='5'></td>");
                            strHTMLBuilder.Append("</tr >");                                                   
                            strHTMLBuilder.Append("<tr >");
                            strHTMLBuilder.Append("<td align='left' colspan='5'>");
                            strHTMLBuilder.Append("_____________________________________________________________________________________________________________________________________________________________________________________________________________________");
                            strHTMLBuilder.Append("<div style='min-height: 10px;'></td>");

                            strHTMLBuilder.Append("</tr>");

                            string checkFormat = GetConfigValue("WorkListFormatPrint", this.OrgID);
                            if (checkFormat == "Y")
                            {
                                string str12 = myColumn.InvestigationName.Replace("&lt;", "<")
                                                       .Replace("&amp;", "&")
                                                       .Replace("&gt;", ">")
                                                       .Replace("&quot;", "\"")
                                                       .Replace("&apos;", "'").ToString();
                                strHTMLBuilder.Append(str12.Replace("&aerobicspecimen",myColumn.LabNo));
                               
                            }
                           
                        }

                    }
                    else
                    {
                    foreach (PatientInvestigation myColumn in lstPatientInvestigation)
                    {

                        strHTMLBuilder.Append("<html >");
                        strHTMLBuilder.Append("<head>  ");
                        strHTMLBuilder.Append("</head>");
                        strHTMLBuilder.Append("<body>");
                        strHTMLBuilder.Append("</br>");
                        strHTMLBuilder.Append("<table class='w-100p' style='line-height: 25px;width: 100%;' border='0px' cellspacing='4' bgcolor='white';'>");

                        strHTMLBuilder.Append("<tr >");
                        strHTMLBuilder.Append("<td align='center' style='font-size:large;' colspan='4'>");
                        strHTMLBuilder.Append("<B>");
                        strHTMLBuilder.Append("WorkList");
                        strHTMLBuilder.Append("</B>");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("</tr>");
                        strHTMLBuilder.Append("<tr>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("WorkList No: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.WorkListID);
                        strHTMLBuilder.Append("</td>");
                        
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("WorkList Generated by: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;' >");
                        strHTMLBuilder.Append(myColumn.WorklistCreatedby);
                        strHTMLBuilder.Append("</td>");                                           
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");

                        strHTMLBuilder.Append("<tr >");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        if(drpdepartment.SelectedItem.Text=="Molecular Pathology")
                        {
                            strHTMLBuilder.Append("Lab ID: ");
                            strHTMLBuilder.Append("</td>");
                            strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                            strHTMLBuilder.Append(" ");
                            strHTMLBuilder.Append("</td>");
                        }
                        else{
                        strHTMLBuilder.Append("Protocol/Type: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(ddlWorkListType.SelectedItem.Text);
                        strHTMLBuilder.Append("</td>");
                       
                        }
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("WorkList Generated On: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;' >");
                        strHTMLBuilder.Append(myColumn.KitName);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");


                        strHTMLBuilder.Append("</tr>");

                        strHTMLBuilder.Append("<tr >");
                        strHTMLBuilder.Append("<td align='Left' style='width: 132px; font-size: 18;'>");
                        strHTMLBuilder.Append("Patient Name: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left'  style='width: 95%; font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.Name);
                        strHTMLBuilder.Append("</td>");
                       


                        strHTMLBuilder.Append("<td align='left' style='width: 159px; font-size: 18;'>");
                        strHTMLBuilder.Append("Specimen: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.LabNo);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");

                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Visitor ID: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.VisitNumber);
                        strHTMLBuilder.Append("</td>");
                        
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Gender: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.Sex);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");


                        //strHTMLBuilder.Append("<tr >");

                        //strHTMLBuilder.Append("<td align='Left'>");
                        //strHTMLBuilder.Append("Specimen: ");
                        //strHTMLBuilder.Append("</td>");
                        //strHTMLBuilder.Append("<td align='Left'>");
                        //strHTMLBuilder.Append(myColumn.WorklistType);
                        //strHTMLBuilder.Append("</td>");
                        //strHTMLBuilder.Append("<td align='Left'>");
                        //strHTMLBuilder.Append("</td>");
                        //strHTMLBuilder.Append("<td align='left'>");
                        //strHTMLBuilder.Append("Age: ");
                        //strHTMLBuilder.Append("</td>");
                        //strHTMLBuilder.Append("<td align='left'>");
                        //strHTMLBuilder.Append(myColumn.Age);
                        //strHTMLBuilder.Append("</td>");

                        //strHTMLBuilder.Append("</tr>");
                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Age: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.Age);
                        strHTMLBuilder.Append("</td>");
                        
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Date of Receipt: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.RegisteredDate);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");

                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Test Name: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.GroupName);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        
                        strHTMLBuilder.Append("Test Code: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.GroupComment);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");

                        strHTMLBuilder.Append("</tr>");

                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Date of collection: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        if (myColumn.CollectedDateTime == Convert.ToDateTime("01/01/0001 00:00:00"))
                        {
                            strHTMLBuilder.Append("");
                        }
                        else
                        {
                            strHTMLBuilder.Append(myColumn.CollectedDateTime);
                        }
                        strHTMLBuilder.Append("</td>");
                       
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Date of Reporting: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        if (myColumn.TATDateTime == "")
                        {
                            strHTMLBuilder.Append("");
                        }
                        else
                        {
                            strHTMLBuilder.Append(myColumn.TATDateTime);
                        }
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'> ");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");


                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Client Name: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.ClientName);
                        strHTMLBuilder.Append("</td>");
                        
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("Ref Doctor: ");
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='left' style='font-size: 18;'>");
                        strHTMLBuilder.Append(myColumn.PerformingPhysicainName);
                        strHTMLBuilder.Append("</td>");
                        strHTMLBuilder.Append("<td align='Left' style='font-size: 18;'>");
                        strHTMLBuilder.Append("</td>");

                        strHTMLBuilder.Append("</tr>");


                        strHTMLBuilder.Append("<tr >");
                        strHTMLBuilder.Append("<td colspan='5'></td>");
                        strHTMLBuilder.Append("</tr >");
                        strHTMLBuilder.Append("<tr >");

                        strHTMLBuilder.Append("<td align='left' colspan='5'>");
                        strHTMLBuilder.Append("_____________________________________________________________________________________________________________________________________________");
                        strHTMLBuilder.Append("<div style='min-height: 10px;'></td>");

                        strHTMLBuilder.Append("</tr>");

                        string checkFormat = GetConfigValue("WorkListFormatPrint", this.OrgID);
                        if (checkFormat == "Y")
                        {
                            string str12 = myColumn.InvestigationName.Replace("&lt;", "<")
                                                   .Replace("&amp;", "&")
                                                   .Replace("&gt;", ">")
                                                   .Replace("&quot;", "\"")
                                                   .Replace("&apos;", "'").ToString();
                            strHTMLBuilder.Append(str12);
                            if(drpdepartment.SelectedValue=="4"){
                                strHTMLBuilder.Append("<html >");
                                strHTMLBuilder.Append("<head>");
                                strHTMLBuilder.Append("</head>");
                                strHTMLBuilder.Append("<body>");
                                strHTMLBuilder.Append("</br>");
                                strHTMLBuilder.Append("<table class='w-100p' style='font-size: 18; line-height: 25px;width: 100%;' border='0px' cellspacing='4' bgcolor='white';'>");
                               
                                strHTMLBuilder.Append("<tr >");

                                strHTMLBuilder.Append("<td align='center' colspan='5' style='font-weight:bold'>");
                                strHTMLBuilder.Append("<u>CHROMOSOME ANALYSIS SHEET</u><div style='height:30px'></div>");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("</tr>");
                                strHTMLBuilder.Append("<br>");

                                strHTMLBuilder.Append("<tr >");
                                strHTMLBuilder.Append("<td  align='Left' style='width: 152px;'>");
                                strHTMLBuilder.Append("Patient Name: ");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td  align='Left' style='width: 152px;'> ");
                                strHTMLBuilder.Append(myColumn.Name);
                                strHTMLBuilder.Append("</td >");
                                strHTMLBuilder.Append("<td align='Left' style='width: 152px;'>");
                                strHTMLBuilder.Append("</td>");


                                strHTMLBuilder.Append("<td  align='left' style='width: 199px;'>");
                                strHTMLBuilder.Append("Visiter ID: ");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td align='left' style='width: 199px;'>");
                                strHTMLBuilder.Append(myColumn.VisitNumber);
                                strHTMLBuilder.Append("</td>");

                                strHTMLBuilder.Append("</tr>");

                                strHTMLBuilder.Append("<tr >");

                                strHTMLBuilder.Append("<td align='Left'>");
                                strHTMLBuilder.Append("Test Code: ");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td align='Left'>");
                                strHTMLBuilder.Append(myColumn.GroupComment);
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td align='Left'>");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td align='left' style='width: 199px;'>");
                                strHTMLBuilder.Append("Date : ");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td align='left' style='width: 199px;'>");
                                strHTMLBuilder.Append(myColumn.RegisteredDate);
                                strHTMLBuilder.Append("</td>");

                                strHTMLBuilder.Append("</tr>");

                                //
                                
                                strHTMLBuilder.Append("<tr>");
                                strHTMLBuilder.Append("<td align='left' colspan='4'><br>");
                                strHTMLBuilder.Append("<table border='1' style='border-collapse: collapse;' >");
                                strHTMLBuilder.Append("<tr style='height: 32.50pf;'>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 13.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 114.50pt; border: .5pt solid #000000;' colspan='2' width='146'>No. of cells analyzed</td>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 13.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 284.50pt; border: .5pt solid #000000;' colspan='2' width='286'>Co-ordinates</td>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 13.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 284.50pt; border: .5pt solid #000000;' colspan='2' width='286'>Result</td>");
                                strHTMLBuilder.Append("</tr>");
                                for(int i=1;i<=25;i++)
                                {
                                    strHTMLBuilder.Append("<tr style='height: 32.50pf;'>");
                                    strHTMLBuilder.Append("<td style='color: #000000; font-size: 11.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 114.50pt; border: .5pt solid #000000;' colspan='2' width='146'> </td>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 11.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 284.50pt; border: .5pt solid #000000;' colspan='2' width='286'></td>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 11.0pt; font-weight: 400; text-decoration: none; text-align: center; vertical-align: middle; height: 32.50pt; width: 284.50pt; border: .5pt solid #000000;' colspan='2' width='286'></td>");
                                strHTMLBuilder.Append("</tr>");
                                }

                                strHTMLBuilder.Append("</table>");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("</tr>");
                                strHTMLBuilder.Append("<tr><td><br><br></td></tr>");
                                strHTMLBuilder.Append("<tr>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 14.5pt; font-weight: 400; '>Analyzed By");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td colspan='3' align='center' style='color: #000000; font-size: 14.5pt; font-weight: 400; '>Checked By");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("<td style='color: #000000; font-size: 14.5pt; font-weight: 400; '>Approved By");
                                strHTMLBuilder.Append("</td>");
                                strHTMLBuilder.Append("</tr>");
                                //

                                strHTMLBuilder.Append("</table>");
                                strHTMLBuilder.Append("</body>");
                                strHTMLBuilder.Append("</html>");
                                strHTMLBuilder.Append("<p style='page-break-after: always;'></p>");
                            }
                        }
                        else
                        {
                            string[] invarr = myColumn.InvestigationName.Split(',');

                            foreach (string s in invarr)
                            {
                                // strHTMLBuilder.Append("</br></br></br>");
                                if (s == "Microscopy")
                                {
                                    strHTMLBuilder.Append("<tr >");

                                    strHTMLBuilder.Append("<td colspan='5' align='Left'><div style='min-height: 390px;'>");
                                    strHTMLBuilder.Append(s);
                                    strHTMLBuilder.Append("</div></td>");
                                    strHTMLBuilder.Append("</tr>");
                                }
                                else
                                {
                                    strHTMLBuilder.Append("<tr >");

                                    strHTMLBuilder.Append("<td colspan='5' align='Left'><div style='min-height: 150px;'>");
                                    strHTMLBuilder.Append(s);
                                    strHTMLBuilder.Append("</div></td>");
                                    strHTMLBuilder.Append("</tr>");
                                }
                            }



                            strHTMLBuilder.Append("<tr >");

                            strHTMLBuilder.Append("<td align='right' >");
                            strHTMLBuilder.Append(" Entered by");
                            strHTMLBuilder.Append("</td>");


                            strHTMLBuilder.Append("<td align='right' colspan='3'>");
                            strHTMLBuilder.Append("Signature");
                            strHTMLBuilder.Append("</td>");

                            strHTMLBuilder.Append("</tr>");


                            strHTMLBuilder.Append("<tr >");

                            strHTMLBuilder.Append("<td align='left' colspan='5'><div style='min-height: 50px;'>");
                            strHTMLBuilder.Append("");
                            strHTMLBuilder.Append("</td>");

                            strHTMLBuilder.Append("</tr>");



                            strHTMLBuilder.Append("<tr >");

                            strHTMLBuilder.Append("<td align='right' >");
                            strHTMLBuilder.Append(" Validated by");
                            strHTMLBuilder.Append("</td>");

                            strHTMLBuilder.Append("<td align='right' colspan='3'>");
                            strHTMLBuilder.Append("Approved by");
                            strHTMLBuilder.Append("</td>");


                            strHTMLBuilder.Append("</tr>");
                            //Close tags.  
                            strHTMLBuilder.Append("</table>");
                            strHTMLBuilder.Append("</body>");
                            strHTMLBuilder.Append("</html>");
                            strHTMLBuilder.Append("<p style='page-break-after: always;'></p>");
                            }

                        }

                    }



                    string Htmltext = strHTMLBuilder.ToString();

                    lblResult.Text = Htmltext;
                    strHTMLBuilder = null;


                }
                else
                {
                   
                    string strValdiate = Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17 == null ? "There is No WorkList Found For Corresponding Search" : Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + strValdiate.Trim() + "','" + strAlert.Trim() + "');", true);
                    divspec.Attributes.Add("style", "display:none");
                    btnspecprint.Attributes.Add("style", "display:none");
                    lblResult.Text="";

                }
            }
            else if (ddlWLFormatType.SelectedValue == "DefaultFormat")
            {
                if (lstPatientInvestigation.Count > 0)
                {

                    TableRow row = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();
                    TableCell cell7 = new TableCell();
                    listTab.Rows.Add(row);
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<u><B>Client Name</B></u>";
                    cell1.CssClass = "w-10p";
                    //cell1.Attributes.Add("padding", "5px 50px 5px 5px");
                   // cell1.Attributes.Add()
                  //cell1.CssClass = "aclass";
                  //       cell1.Attributes.Add("class", "aclass");
             
                    //cell1.BorderStyle = BorderStyle.Dotted;

                    cell2.Attributes.Add("align", "left");
                    cell2.Text = "<u><B>Test Name</B></u>";
                    cell2.CssClass = "w-10p";
                    //cell2.BorderStyle = BorderStyle.Dotted;

                    cell2.Attributes.Add("align", "left");

                    cell3.Attributes.Add("align", "left");
                    cell3.Text = "<u><B>Values</B></u>";
                    cell3.CssClass = "w-10p";

                    cell4.Attributes.Add("align", "left");
                    cell4.Text = "<u><B>Quotation Number</B></u>";
                    cell4.CssClass = "w-10p";


                    cell5.Attributes.Add("align", "left");
                    cell5.Text = "<u><B>Sample ID</B></u>";
                    cell5.CssClass = "w-10p";
                    

                    //cell3.Attributes.Add("align", "left");
                    //cell3.Text = "<u><B>Dummy</B></u>";
                    //cell4.BorderStyle = BorderStyle.Dotted;

                    //cell5.Attributes.Add("align", "left");
                    //cell5.Text = "<u><B>Dummy1</B></u>";
                    //cell5.BorderStyle = BorderStyle.Dotted;

                    //cell6.Attributes.Add("align", "left");
                    //cell6.Text = "<u><B>Dummy2</B></u>";
                    //cell6.BorderStyle = BorderStyle.Dotted;

                    //cell7.Attributes.Add("align", "left");
                    //cell7.Text = "<B>Ref.By</B>";
                    //cell7.BorderStyle = BorderStyle.Dotted;

                    row.Cells.Add(cell1);
                    row.Cells.Add(cell4);
                    row.Cells.Add(cell5);
                    row.Cells.Add(cell2);
                    row.Cells.Add(cell3);
                    
                    ////row.Cells.Add(cell4);
                    //row.Cells.Add(cell5);
                    //row.Cells.Add(cell6);
                    ////row.Cells.Add(cell7);
                    listTab.Rows.Add(row);

                    //row = new TableRow();
                    //cell1 = new TableCell();
                    //cell1.ColumnSpan = 7;
                    ////cell1.BorderStyle = BorderStyle.Solid ;
                    //row.Cells.Add(cell1);
                    //listTab.Rows.Add(row);

                    foreach (PatientInvestigation objWL in lstPatientInvestigation)
                    {
                        row = new TableRow();
                        cell1 = new TableCell();
                        cell2 = new TableCell();
                        cell3 = new TableCell();
                        cell4 = new TableCell();
                        cell5 = new TableCell();
                        cell6 = new TableCell();
                        //cell7 = new TableCell();

                        //cell1.Attributes.Add("align", "left");
                        ////cell1.Text = Convert.ToString(objWL.StrVisitID);
                        //cell2.Attributes.Add("align", "left");
                        if (objWL.Name != null && objWL.Age != null)
                        {
                            cell2.Text = objWL.Name;
                            cell2.Attributes.Add("align", "left");
                            cell2.CssClass = "w-10p";
                        }
                        //else { cell2.Text = ""; }
                        //cell4.Attributes.Add("align", "left");
                        //cell4.Text = objWL.Age;
                        //cell3.Attributes.Add("align", "left");
                        //if (objWL.Status == "Cancel")
                        //{
                        //    cell3.Text = "**" + objWL.InvestigationName;
                        //    // lbltxtSTR.Visible = true;
                        //}
                        //else if (objWL.Status == "NewlyAdded")
                        //{
                        //    cell3.Text = "*" + objWL.InvestigationName;
                        //    //lbltxtSTR.Visible = true;
                        //}
                        cell3.Text = objWL.InvestigationName;
                        cell3.CssClass = "w-10p";
                        cell3.Attributes.Add("align", "left");
                            cell4.Text =  "_____________________________________________________________________";
                            cell4.Attributes.Add("align", "left");
                            
                        
                        // == string.Empty ? "" : objWL.InvestigationName + "_____________________________________________________________________";

                        //cell5.Attributes.Add("align", "left");
                        //cell5.Text = objWL.InvestigationName;
                        //cell5.Attributes.Add("align", "left");
                        //cell5.Text = objWL.ReceivedOn;

                        //cell5.Attributes.Add("align", "left");
                        ////cell5.Text = objWL.ReceivedOn;

                        //cell6.Attributes.Add("align", "left");
                        ////cell6.Text = objWL.ReferingPhysicianName;

                        //row.Cells.Add(cell1);
                            cell5.Text = objWL.PrincipleName;
                            cell5.CssClass = "w-10p";
                            cell5.Attributes.Add("align", "left");
                            cell6.Text = objWL.Test;
                            cell6.CssClass = "w-10p";
                            cell6.Attributes.Add("align", "left");
                        row.Cells.Add(cell2);
                        row.Cells.Add(cell5);
                        row.Cells.Add(cell6);
                        row.Cells.Add(cell3);
                        row.Cells.Add(cell4);
                        //row.Cells.Add(cell5);
                        //row.Cells.Add(cell6);
                        //row.BorderWidth = Unit.Pixel(1);
                        row.Style.Add("font-size", "12px");
                        row.Style.Add("padding", "5px");
                        row.Font.Bold = false;
                        listTab.Rows.Add(row);
                    }
                    WatersDefault.DataSource = null;
                    WatersDefault.DataBind();
                    WatersDefault.DataSource = lstPatientInvestigation;
                    WatersDefault.DataBind();
                    divLegend.Visible = false;
                    divspec.Attributes.Add("style", "display:none");
                }

                else {

                    divspec.Attributes.Add("style", "display:none");
                    string strValdiate = Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17 == null ? "There is No WorkList Found For Corresponding Search" : Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + strValdiate.Trim() + "','" + strAlert.Trim() + "');", true);
                
                }

                }

                //if (ddlTestType.SelectedItem.Text == "STAT")
                //{
                //    var filteredlstPatientInvestigation = from c in lstPatientInvestigation
                //                                          where c.IsSTAT == "Y"
                //                                          select c;
                //    grdresult.DataSource = filteredlstPatientInvestigation;
                //    grdresult.DataBind();
                //    trInvBased.Style.Add("display", "block");
                //    trGrpBased.Style.Add("display", "none");

                //}
                //else
            else{


                if (ddlTestType.SelectedItem.Text == "VIP")
                {
                    var filteredlstPatientInvestigationVIP = from c in lstPatientInvestigation
                                                             where c.RefSuffixText == "VIP"
                                                             select c;
                    grdresult.DataSource = filteredlstPatientInvestigationVIP;
                    grdresult.DataBind();
                    trInvBased.Style.Add("display", "block");
                    trGrpBased.Style.Add("display", "none");
                }
                //else if (ddlTestType.SelectedItem.Text == "Recheck")
                //{
                //    var filteredlstPatientInvestigationRecheck = from c in lstPatientInvestigation
                //                                                 where c.Status == "Recheck"
                //                                                 select c;
                //    grdresult.DataSource = filteredlstPatientInvestigationRecheck;
                //    grdresult.DataBind();
                //    trInvBased.Style.Add("display", "block");
                //    trGrpBased.Style.Add("display", "none");
                //}
                else
                {
                    if (ddlWLFormatType.SelectedItem.Text == "Portrait Format")
                    {
                        grdGroupResultWL1.DataSource = lstPatientInvestigation;
                        grdGroupResultWL1.DataBind();
                        trInvBased.Style.Add("display", "block");
                        trGrpBased.Style.Add("display", "none");
                        trGrpBased1.Style.Add("display", "none");
                        trInvBased1.Style.Add("display", "none");
                        trInVBasedF2.Style.Add("display", "none");
                        divspec.Attributes.Add("style", "display:none");
                    }
                    else if (ddlWLFormatType.SelectedItem.Text == "Group Contents in Column")
                    {
                        //trInvBased.Style.Add("display", "none");
                        //trGrpBased.Style.Add("display", "none");
                        //trInvBased1.Style.Add("display", "none");
                        trInVBasedF2.Style.Add("display", "block");
                        divspec.Attributes.Add("style", "display:none");

                    }
                    else if (ddlWLFormatType.SelectedItem.Text == "DefaultFormat"){
                    
                    
                    Dummy.Attributes.Add("display", "block");
                        divspec.Attributes.Add("style", "display:none");
                    
                    
                    
                    }


                    else
                    {
                    List<PatientInvestigation>  listwithoutdup =new  List<PatientInvestigation>();
                               
                        var query = from S in lstPatientInvestigation
                                         where S.InvestigationName != null 
                                          select S;
                        listwithoutdup = query.ToList();

                        grdresult.DataSource = listwithoutdup;
                        grdresult.DataBind();
                        trInvBased1.Style.Add("display", "block");
                        trGrpBased.Style.Add("display", "none");
                        trGrpBased1.Style.Add("display", "none");
                        trInvBased.Style.Add("display", "none");
                        trInVBasedF2.Style.Add("display", "none");
                        divspec.Attributes.Add("style", "display:none");
                    }
                }
            }
            //if (grdresult.Rows.Count > 0 || grdGroupResult.Rows.Count > 0)
            if (grdresult.Rows.Count > 0 || grdGroupResultWL1.Rows.Count > 0 || grdGroupResult.Rows.Count > 0 || grdGroupResultWL2.Rows.Count > 0 || InvTable.Rows.Count > 0 || listTab.Rows.Count>0)
            {
                foreach (PatientInvestigation lstpatuser in lstPatientInvestigation)
                {
                    if (!String.IsNullOrEmpty(lstpatuser.WorklistCreatedby))
                    {
                        lblWLUser.Text = lstpatuser.WorklistCreatedby;
                        lblWLUser1.Text = lstpatuser.WorklistCreatedby;
                    }
                }
                //lblWLUser.Text = lstPatientInvestigation[0].WorklistCreatedby.ToString();
                //lblWLUser1.Text = lstPatientInvestigation[0].WorklistCreatedby.ToString();
                lblWLIDtxt.Text = "";
                lblWLIDtxt1.Text = "";
                if (ddlWLFormatType.SelectedItem.Value != "Special Format")
                {
                trPrint.Style.Add("display", "block");
                }
                if (hdnIsGrpBased.Value == "Y")
                {
                    btnPDF.Style.Add("display", "none");
                    btnGrpPDF.Style.Add("display", "block");
                    divLegend.Style.Add("display", "none");
                }
                else
                {
                    btnPDF.Style.Add("display", "block");
                    btnGrpPDF.Style.Add("display", "none");
                    divLegend.Style.Add("display", "block");
                }
                string strPortrait = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02 == null ? "Portrait Format" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02;
                if (ddlWLFormatType.SelectedItem.Text == strPortrait.Trim())
                {
                    //tbResultWL1.Style.Add("display", "block");
                    tbResult.Style.Add("display", "block");
                }
                else
                {
                    if (ddlWLFormatType.SelectedItem.Value != "Special Format")
                    {
                    tbResult.Style.Add("display", "block");
                    }
                    //tbResultWL1.Style.Add("display", "none");
                }
                if (ddlWLFormatType.SelectedItem.Value != "Special Format")
                {
                tbGrdResult.Style.Add("display", "block");
                }
                lblWLOn.Text = OrgDateTimeZone;
                lblWLOn1.Text = OrgDateTimeZone;
                lblProtocolNo.Text = "";
                //lblWLUser.Text = 

                var varWLquery = lstPatientInvestigation
                     .GroupBy(f => new { f.WorkListID })
                     .Select(group => new { WL = group.Key });
                int i = 0;
                string strWorlistId = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_03 == null ? "WorkList ID :" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_03;

                lblWLID.Text = strWorlistId.Trim();
                foreach (var q in varWLquery)
                {
                    if (q.WL.WorkListID != null && q.WL.WorkListID != 0)
                    {
                        lblWLIDtxt.Text += "[";
                        lblWLIDtxt.Text += q.WL.WorkListID.ToString();
                        lblWLIDtxt.Text += "]";
                        lblProtocolNo.Text += "[";
                        lblProtocolNo.Text += q.WL.WorkListID.ToString();
                        lblProtocolNo.Text += "]";

                        i = i + 1;
                    }
                }
                if (WLMode == "All")
                {
                    lblWLIDtxt.Text = "";
                    lblWLID.Text = "";
                }
            }
            else
            {
                trInVBasedF2.Style.Add("display", "block");
                trPrint.Style.Add("display", "none");
                tbResultWL1.Style.Add("display", "none");
                tbResult.Style.Add("display", "none");
                trInvBased1.Style.Add("display", "none");
                trGrpBased.Style.Add("display", "none");
                trGrpBased1.Style.Add("display", "none");
                trInvBased.Style.Add("display", "none");
                divVIP.Style.Add("display", "none");
                divspec.Attributes.Add("style", "display:none");
                ddlTestType.Visible = false;
                if (WLMode == "New")
                {
                    divspec.Attributes.Add("style", "display:none");
                    if (ddlWLFormatType.SelectedItem.Value == "Special Format")
                    {
                       
                        divspec.Attributes.Add("style", "display:block");
                    }
                    if (ddlWorkListType.SelectedItem.Value != "Interface_value")
                    {
                        string strValdiate = Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_16 == null ? "There is No Investigation Found For Generate New WorkList" : Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_16;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + strValdiate.Trim() + "','" + strAlert.Trim() + "');", true);
                    }
                }
                else if (ddlWLFormatType.SelectedItem.Value == "Special Format")
                {
                    divGrps.Attributes.Add("style", "display:none");
                    divspec.Attributes.Add("style", "display:block");
                }
                else
                {
                    divspec.Attributes.Add("style", "display:none");
                    if (ddlWorkListType.SelectedItem.Value != "Interface_value")
                    {
                        string strValdiate = Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17 == null ? "There is No WorkList Found For Corresponding Search" : Resources.Investigation_AppMsg.Investigation_BatchWiseWorkList_aspx_17;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + strValdiate.Trim() + "','" + strAlert.Trim() + "');", true);
                    }
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Executing Batch Work List Jayakumar", ex);
        }
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void btnPDF1_Click(object sender, ImageClickEventArgs e)
    {
        string attachment = "attachment; filename=Employee.pdf";

        Response.ClearContent();

        Response.AddHeader("content-disposition", attachment);

        Response.ContentType = "application/pdf";

        StringWriter stw = new StringWriter();

        HtmlTextWriter htextw = new HtmlTextWriter(stw);

        tbResult.RenderControl(htextw); grdGroupResult.RenderControl(htextw);

        Document document = new Document();

        PdfWriter.GetInstance(document, Response.OutputStream);

        document.Open();

        StringReader str = new StringReader(stw.ToString());

        HTMLWorker htmlworker = new HTMLWorker(document);

        htmlworker.Parse(str);

        document.Close();

        Response.Write(document);

        Response.End();


        //string str = hdnPDFContent.Value;

        //Document document = new Document();

        //PdfWriter.GetInstance(document, Response.OutputStream);// new FileStream(@"D:\Gttbak29-1-13\test.pdf", FileMode.Create));

        //document.Open();

        //Paragraph P = new Paragraph(str, FontFactory.GetFont("Arial", 10));

        //document.Add(P);

        //document.Close();
        //Response.Write(document);
        //Response.End();

        //string line = hdnPDFContent.Value;
        //Text2PDF(line);
    }
    protected void btnPDF_Click(object sender, ImageClickEventArgs e)
    {
        string strPortrait = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02 == null ? "Portrait Format" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02;
        string strGroup = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04 == null ? "Group Contents in Column" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04;
        if (ddlWLFormatType.SelectedItem.Text == strPortrait.Trim())
        {
            IsPotrait = "Y";
            PDF(grdGroupResultWL1, false);
        }
        else if (ddlWLFormatType.SelectedItem.Text == strGroup.Trim())
        {
            IsPotrait = "Y";
            PDF(grdGroupResultWL2, false);
        }
        else
        {
            if (hdnIsWaters.Value != "Y")
            {
                IsPotrait = "N";
                PDF(grdresult, false);
            }
            else {

                IsPotrait = "Y";
                PDF(WatersDefault, false);
            }
        }

    }
    protected void grdresult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[10].Text.Contains("~(PA)"))
            {
                string[] strInvestigationName = e.Row.Cells[10].Text.Split('~');
                if (strInvestigationName.Length > 0)
                {
                    string split = strInvestigationName[0] + "<span style='background-color:Yellow;'>" + strInvestigationName[1] + "</span>";
                    e.Row.Cells[10].Text = split;
                }

            }

            if (e.Row.Cells[8].Text == "Y")
            {
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#EEB4B4");
                flag = 1;
            }
            if (grdresult.DataKeys[e.Row.RowIndex][4] != null)
            {
                if (grdresult.DataKeys[e.Row.RowIndex][4].ToString() == "Recheck")
                {
                    e.Row.BackColor = System.Drawing.Color.LightCoral;
                }
                if (grdresult.DataKeys[e.Row.RowIndex][4].ToString() == "Retest")
                {
                    e.Row.BackColor = System.Drawing.Color.Bisque;
                }
                if (grdresult.DataKeys[e.Row.RowIndex][4].ToString() == "ReflexTest")
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }
            }
            if (grdresult.DataKeys[e.Row.RowIndex][3] != null)
            {
                if (grdresult.DataKeys[e.Row.RowIndex][3].ToString() == "VIP")
                {
                    e.Row.BackColor = System.Drawing.Color.DimGray;
                }
            }
            if (grdresult.DataKeys[e.Row.RowIndex][1] != null)
            {
                if (grdresult.DataKeys[e.Row.RowIndex][1].ToString() == "Y")
                {
                    //((Label)(e.Row.FindControl("lblIsDataChanged"))).Style.Add("display", "block");
                    //flag1 = 1;
                }
                else
                {
                    //((Label)(e.Row.FindControl("lblIsDataChanged"))).Style.Add("display", "none");
                }
            }
        }
        if (flag == 1)
        {
            tdStat.Style.Add("display", "block");
        }
        else
        {
            tdStat.Style.Add("display", "none");
        }
        if (flag1 == 1)
        {
            tdIsDataChanged.Style.Add("display", "block");
        }
        else
        {
            tdIsDataChanged.Style.Add("display", "none");
        }

        if (e.Row.RowType != DataControlRowType.EmptyDataRow)
        {
            // e.Row.Cells[8].Style.Add("display", "none");
        }
    }
    protected void grdGroupResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string Name = ddlWorkListType.SelectedItem.Text;
        tdStat.Style.Add("display", "none");
        tdIsDataChanged.Style.Add("display", "none");
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[10].Text.Contains("~(PA)"))
            {
                string[] strInvestigationName = e.Row.Cells[10].Text.Split('~');
                if (strInvestigationName.Length > 0)
                {
                    string split = strInvestigationName[0] + "<span style='background-color:Yellow;'>" + strInvestigationName[1] + "</span>";
                    e.Row.Cells[10].Text = split;
                }

            }
            if (e.Row.Cells[0].Text == "0")
            {
                e.Row.Cells[0].Text = "";
            }
            if (e.Row.Cells[5].Text == "0")
            {
                e.Row.Cells[5].Text = "";
            }
            //if (Name == "Group Based")
            //{
            //    grdGroupResult.Columns[10].Visible = false;
            //}
        }
    }
    protected void grdresult_PreRender(object sender, EventArgs e)
    {
        //GridDecorator.MergeRows(grdresult);
    }
    protected void btnGrpPDF_Click(object sender, ImageClickEventArgs e)
    {
        string strPortrait = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02 == null ? "Portrait Format" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02;
        string strGroup = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04 == null ? "Group Contents in Column" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04;
        string strCloumnGroup = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_05 == null ? "3 Column Group Contents" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_05;
        if (ddlWLFormatType.SelectedItem.Text == strPortrait.Trim())
        {
            IsPotrait = "Y";
            GroupPDF(grdGroupResultWL2, true);
        }
        else if (ddlWLFormatType.SelectedItem.Text == strGroup.Trim())
        {
            IsPotrait = "N";
            GrpPDFWL2(true);
        }
        else if (ddlWLFormatType.SelectedItem.Text == strCloumnGroup.Trim())
        {
            IsPotrait = "Y";
            GrpPDFWL3(true);
        }
        else
        {
            IsPotrait = "N";
            GroupPDF(grdGroupResult, true);
        }
        //GroupPDF(false);
    }
    protected void imgExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnIsGrpBased.Value == "Y")
            {
                ExportToExcelGroup();

            }
            else
            {
                ExportToExcel();

            }
            //currentPageNo = Int32.Parse(hdnCurrent.Value);
            //LoadGrid(currentPageNo, PageSize, "");

            //gvRatesMaster.DataSource = lstRates;
            //gvRatesMaster.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }
    #endregion
    
    
   

    #region "Methods"

    public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_01 == null ? "---Select---" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_01;



        try
        {
            string domains = "SampleRejectedPeriod,WorkListType,WorkListSubType,ProtocalGroup_Based,WL_Type,WL_TestType,Chk_pendingdays";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "WorkListType"
                                 select child;

                ddlWorkListType.DataSource = childItems;
                ddlWorkListType.DataTextField = "DisplayText";
                ddlWorkListType.DataValueField = "Code";
                ddlWorkListType.DataBind();
                ddlWorkListType.Items.Insert(0, new System.Web.UI.WebControls.ListItem(strSelect.Trim(), "0"));

                var TestType = from child in lstmetadataOutput
                               where child.Domain == "WorkListSubType"
                               select child;

                ddlTestType.DataSource = TestType;
                ddlTestType.DataTextField = "DisplayText";
                ddlTestType.DataValueField = "Code";
                ddlTestType.DataBind();

                /* Dropdown loaded based on ProtocalGroup */
                var progrps = from child in lstmetadataOutput
                              where child.Domain == "ProtocalGroup_Based"
                              select child;

                ddlProGrp.DataSource = progrps;
                ddlProGrp.DataTextField = "DisplayText";
                ddlProGrp.DataValueField = "Code";
                ddlProGrp.DataBind();
                ddlProGrp.Items.Insert(0, strSelect.Trim());
                ddlProGrp.Items[0].Value = "0";

                var childItems2 = from child in lstmetadataOutput
                                 where child.Domain == "WL_Type"
                                 select child;
                ddlWLFormatType.DataSource = childItems2;
                ddlWLFormatType.DataTextField = "DisplayText";
                ddlWLFormatType.DataValueField = "Code";
                ddlWLFormatType.DataBind();
                //ddlWLFormatType.Items.Insert(0, strSelect);
                ddlWLFormatType.SelectedValue = "Portrait Format";

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "WL_TestType"
                                  select child;

                ddlTestType.DataSource = childItems3;
                ddlTestType.DataTextField = "DisplayText";
                ddlTestType.DataValueField = "Code";
                ddlTestType.DataBind();
                ddlTestType.SelectedValue = "All";
                //ddlTestType.Items.Insert(0, strSelect);

                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "Chk_pendingdays"
                                  select child;
                Chkpendingdays.DataSource = childItems4;
                Chkpendingdays.DataTextField = "DisplayText";
                Chkpendingdays.DataValueField = "Code";
                Chkpendingdays.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status In Commoncontrol_AbberantQueue", ex);
        }
    }
    public void LoadInvClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL();
            Investigation_BL investigationBL = new Investigation_BL();
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            retCode = patBL.GetInvClientMaster(OrgID, "Y", out getInvClientMaster);

            //ddlClients.DataSource = getInvClientMaster;
            //ddlClients.DataTextField = "ClientName";
            //ddlClients.DataValueField = "ClientID";
            //ddlClients.DataBind();
            ddlClients.Items.Insert(0, strSelect.Trim());
            ddlClients.Items[0].Value = "0";
            ddlClients.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }
    protected void Text2PDF(string PDFText)
    {
        //HttpContext context = HttpContext.Current;
        StringReader reader = new StringReader(PDFText);

        //Create PDF document 
        Document document = new Document(PageSize.A4);
        HTMLWorker parser = new HTMLWorker(document);

        string PDF_FileName = "WorkList";
        PdfWriter.GetInstance(document, new FileStream(PDF_FileName, FileMode.Open));
        document.Open();

        try
        {
            parser.Parse(reader);
        }
        catch (Exception ex)
        {
            //Display parser errors in PDF. 
            Paragraph paragraph = new Paragraph("Error!" + ex.Message);
            Chunk text = paragraph.Chunks[0] as Chunk;
            if (text != null)
            {
                text.Font.Color = BaseColor.RED;
            }
            document.Add(paragraph);
        }
        finally
        {
            document.Close();
            DownLoadPdf(PDF_FileName);
        }
    }
    private void DownLoadPdf(string PDF_FileName)
    {
        WebClient client = new WebClient();
        Byte[] buffer = client.DownloadData(PDF_FileName);
        Response.ContentType = "application/pdf";
        Response.AddHeader("content-length", buffer.Length.ToString());
        Response.BinaryWrite(buffer);
    }
    protected void Print(object sender, ImageClickEventArgs e)
    {
        string strPortrait = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02 == null ? "Portrait Format" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_02;
        string strGroup = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04 == null ? "Group Contents in Column" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_04;
        string strCloumnGroup = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_05 == null ? "3 Column Group Contents" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_05;
        try
        {
            if (hdnIsGrpBased.Value == "Y")
            {
                if (ddlWLFormatType.SelectedItem.Text == strPortrait.Trim())
                {
                    IsPotrait = "Y";
                    GroupPDF(grdGroupResultWL2, true);
                }
                else if (ddlWLFormatType.SelectedItem.Text == strGroup.Trim())
                {
                    IsPotrait = "N";
                    GrpPDFWL2(true);
                }
                else if (ddlWLFormatType.SelectedItem.Text == strCloumnGroup.Trim())
                {
                    IsPotrait = "Y";
                    GrpPDFWL3(true);
                }
                else
                {
                    IsPotrait = "N";
                    GroupPDF(grdGroupResult, true);
                }

            }
            else
            {
                if (ddlWLFormatType.SelectedItem.Text == strPortrait.Trim())
                {
                    IsPotrait = "Y";
                    PDF(grdGroupResultWL1, true);
                }
                else
                {
                    if (hdnIsWaters.Value != "Y")
                    {

                        IsPotrait = "N";
                        PDF(grdresult, true);
                    }
                    else {

                        IsPotrait = "N";
                        PDF(WatersDefault, true);
                    }
                }
            }
            //if (hdnIsGrpBased.Value == "N")
            //{
            //    grdresult.UseAccessibleHeader = true;
            //    grdresult.HeaderRow.TableSection = TableRowSection.TableHeader;
            //    grdresult.FooterRow.TableSection = TableRowSection.TableFooter;
            //    grdresult.Attributes["style"] = "border-collapse:separate";
            //    foreach (GridViewRow row in grdresult.Rows)
            //    {
            //        if (row.RowIndex % 10 == 0 && row.RowIndex != 0)
            //        {
            //            row.Attributes["style"] = "page-break-after:always;";
            //        }
            //    }
            //    StringWriter sw = new StringWriter();
            //    HtmlTextWriter hw = new HtmlTextWriter(sw);
            //    //tbResult.RenderControl(hw);
            //    grdresult.RenderControl(hw);
            //    string gridHTML = sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, "");
            //    StringBuilder sb = new StringBuilder();
            //    //sb.Append("<script type = 'text/javascript'>");
            //    sb.Append("window.onload = new function(){");
            //    sb.Append("var printWin = window.open('', '', 'left=0");
            //    sb.Append(",top=0,width=1000,height=600,scrollbars=1,status=1,resizable=1');");
            //    sb.Append("printWin.document.write(\"");
            //    string style = "<style type = 'text/css'>thead {display:table-header-group;} tfoot{display:table-footer-group;}</style>";
            //    sb.Append(style + gridHTML);
            //    sb.Append("\");");
            //    sb.Append("printWin.document.close();");
            //    sb.Append("printWin.focus();");
            //    sb.Append("printWin.print();");
            //    //sb.Append("printWin.close();");
            //    sb.Append("};");
            //    //sb.Append("</script>");
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "GridPrint", sb.ToString(), true);
            //    //ClientScript.RegisterClientScriptBlock(this.GetType(), "GridPrint", "alert('a')");
            //    //grdresult.DataBind();
            //}
            //else
            //{
            //    grdGroupResult.UseAccessibleHeader = true;
            //    grdGroupResult.HeaderRow.TableSection = TableRowSection.TableHeader;
            //    grdGroupResult.FooterRow.TableSection = TableRowSection.TableFooter;
            //    grdGroupResult.Attributes["style"] = "border-collapse:separate";
            //    foreach (GridViewRow row in grdresult.Rows)
            //    {
            //        if (row.RowIndex % 10 == 0 && row.RowIndex != 0)
            //        {
            //            row.Attributes["style"] = "page-break-after:always;";
            //        }
            //    }
            //    StringWriter sw = new StringWriter();
            //    HtmlTextWriter hw = new HtmlTextWriter(sw);
            //    //tbResult.RenderControl(hw);
            //    grdGroupResult.RenderControl(hw);
            //    string gridHTML = sw.ToString().Replace("\"", "'").Replace(System.Environment.NewLine, "");
            //    StringBuilder sb = new StringBuilder();
            //    //sb.Append("<script type = 'text/javascript'>");
            //    sb.Append("window.onload = new function(){");
            //    sb.Append("var printWin = window.open('', '', 'left=0");
            //    sb.Append(",top=0,width=1000,height=600,scrollbars=1,status=1,resizable=1');");
            //    sb.Append("printWin.document.write(\"");
            //    string style = "<style type = 'text/css'>thead {display:table-header-group;} tfoot{display:table-footer-group;}</style>";
            //    sb.Append(style + gridHTML);
            //    sb.Append("\");");
            //    sb.Append("printWin.document.close();");
            //    sb.Append("printWin.focus();");
            //    sb.Append("printWin.print();");
            //    //sb.Append("printWin.close();");
            //    sb.Append("};");
            //    //sb.Append("</script>");
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "GridPrint", sb.ToString(), true);
            //    //ClientScript.RegisterClientScriptBlock(this.GetType(), "GridPrint", "alert('a')");
            //    //grdresult.DataBind();
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }
    public void PDF(GridView Grid, bool IsPrint)
    {
        try
        {
            string searchName = string.Empty;
            grdresult.Columns[6].Visible = false;
            grdresult.Columns[11].Visible = false;
            if (hdnIsWaters.Value == "Y")
            {
                WatersDefault.Columns[5].Visible = true;
            
            }
            int count = 0;
            Font labelFont = new Font(Font.FontFamily.TIMES_ROMAN, 13, Font.BOLD);
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
            Font TopHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font FooterFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 8);
            if (ddlWorkListType.SelectedItem.Value == "Analyzer_Based")
            {
                searchName = ddlInstrument.SelectedItem.Text;
            }
            if (ddlWorkListType.SelectedItem.Value == "Investigation_Based")
            {
                searchName = txtInvestigationName.Text;
            }

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=WorkList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            for (int x = 0; x < Grid.Columns.Count; x++)
            {
                if (Grid.Columns[x].Visible == true)
                {
                    count = count + 1;
                }
            }

            PdfPTable table = new PdfPTable(count);
            table.WidthPercentage = 100;
            table.DefaultCell.Padding = 2;
            table.DefaultCell.SpaceCharRatio = 2;



            //Set the column widths 

            int[] widths = new int[count];
            int tempCount = 0;

            for (int x = 0; x < Grid.Columns.Count; x++)
            {
                if (Grid.Columns[x].Visible == true)
                {
                    string cellText = Server.HtmlDecode(Grid.HeaderRow.Cells[x].Text);
                    PdfPCell pHcell = new PdfPCell(new Phrase(cellText, titleFont));
                    table.AddCell(pHcell);
                    widths[tempCount] = (int)Grid.Columns[x].ItemStyle.Width.Value;
                    tempCount += 1;
                }
            }

            table.SetWidths(widths);



            //Transfer rows from GridView to table

            for (int i = 0; i < Grid.Rows.Count; i++)
            {
                if (Grid.Rows[i].RowType == DataControlRowType.DataRow)
                {
                    for (int j = 0; j < Grid.Columns.Count; j++)
                    {
                        if (Grid.Columns[j].Visible == true)
                        {
                            PdfPCell pBcell = null;
                            string cellText = string.Empty;
                            if (j > 0)
                            {
                                cellText = Server.HtmlDecode(Grid.Rows[i].Cells[j].Text);
                            }
                            else
                            {
                                cellText = (i + 1).ToString();
                            }
                            pBcell = new PdfPCell(new Phrase(cellText, textFont));
                            //if (j==grdresult.Columns.Count-1)
                            //{
                            //    pBcell.VerticalAlignment =Element.ALIGN_BOTTOM;
                            //}
                            table.AddCell(pBcell);
                        }
                    }
                }
            }
            Document pdfDoc = new Document();
            if (IsPotrait == "Y")
            {
                pdfDoc = new Document(PageSize.A4, 7f, 7f, 7f, 0f);
            }
            else
            {
                pdfDoc = new Document(PageSize.A4.Rotate(), 0, 0, 15, 5);
            }
            pdfDoc.SetMargins(40f, 40f, 130f, 60f);
            //open our document


            PdfPTable HeaderTable = new PdfPTable(4);
            HeaderTable.WidthPercentage = 100;
            HeaderTable.DefaultCell.Padding = 2;
            int[] Headerwidths = new int[4] { 10, 12, 10, 12 };
            HeaderTable.SetWidths(Headerwidths);

            HeaderTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);


            PdfPCell TopHeaderCell = new PdfPCell(new Phrase(lblHeader.Text, TopHeaderFont));
            TopHeaderCell.Colspan = 4;
            TopHeaderCell.BorderWidth = 0;
            TopHeaderCell.HorizontalAlignment = Element.ALIGN_CENTER;
            HeaderTable.AddCell(TopHeaderCell);

            PdfPCell HWLTypeCell = new PdfPCell(new Phrase(Label1.Text, titleFont));
            PdfPCell HWLTypetxtCell = new PdfPCell(new Phrase(lblWorkListBasedOn.Text, titleFont));
            HWLTypeCell.BorderWidth = 0; HWLTypeCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWLTypeCell.NoWrap = true;
            HWLTypetxtCell.BorderWidth = 0; HWLTypetxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWLTypetxtCell.NoWrap = true;
            if (Label1.Text != "" && lblWorkListBasedOn.Text != "")
            {
                HeaderTable.AddCell(HWLTypeCell);
                HeaderTable.AddCell(HWLTypetxtCell);
            }

            PdfPCell HGroupedByCell = new PdfPCell(new Phrase(Label2.Text, titleFont));
            PdfPCell HGroupedBytxtCell = new PdfPCell(new Phrase(lblGroupingWorkListtxt.Text, titleFont));
            HGroupedByCell.BorderWidth = 0; HGroupedByCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGroupedByCell.NoWrap = true;
            HGroupedBytxtCell.BorderWidth = 0; HGroupedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGroupedBytxtCell.NoWrap = true;
            if (Label2.Text != "" && lblGroupingWorkListtxt.Text != "")
            {
                HeaderTable.AddCell(HGroupedByCell);
                HeaderTable.AddCell(HGroupedBytxtCell);
            }
            PdfPCell HWorkListIDCell = new PdfPCell(new Phrase(lblWLID.Text, titleFont));
            PdfPCell HWorkListIDtxtCell = new PdfPCell(new Phrase(lblWLIDtxt.Text, titleFont));
            HWorkListIDCell.BorderWidth = 0; HWorkListIDCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWorkListIDCell.NoWrap = true;
            HWorkListIDtxtCell.BorderWidth = 0; HWorkListIDtxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWorkListIDtxtCell.NoWrap = true;
            if (lblWLID.Text != "" && lblWLIDtxt.Text != "")
            {
                HeaderTable.AddCell(HWorkListIDCell);
                HeaderTable.AddCell(HWorkListIDtxtCell);
            }
            PdfPCell HGeneratedOnCell = new PdfPCell(new Phrase(lblWLOntxt.Text, titleFont));
            PdfPCell HGeneratedOntxtCell = new PdfPCell(new Phrase(lblWLOn.Text, titleFont));
            HGeneratedOnCell.BorderWidth = 0; HGeneratedOnCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedOnCell.NoWrap = true;
            HGeneratedOntxtCell.BorderWidth = 0; HGeneratedOntxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedOntxtCell.NoWrap = true;
            if (lblWLOntxt.Text != "" && lblWLOn.Text != "")
            {
                HeaderTable.AddCell(HGeneratedOnCell);
                HeaderTable.AddCell(HGeneratedOntxtCell);
            }
            PdfPCell HGeneratedByCell = new PdfPCell(new Phrase(Label3.Text, titleFont));
            PdfPCell HGeneratedBytxtCell = new PdfPCell(new Phrase(lblWLUser.Text, titleFont));
            HGeneratedByCell.BorderWidth = 0; HGeneratedByCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedByCell.NoWrap = true;
            HGeneratedBytxtCell.BorderWidth = 0; HGeneratedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedBytxtCell.NoWrap = true;
            if (Label3.Text != "" && lblWLUser.Text != "")
            {
                HeaderTable.AddCell(HGeneratedByCell);
                HeaderTable.AddCell(HGeneratedBytxtCell);
            }
            ///////////////////
            PdfPTable footerTable = new PdfPTable(3);
            footerTable.WidthPercentage = 100;
            footerTable.DefaultCell.Padding = 2;
            footerTable.DefaultCell.SpaceCharRatio = 2;

            footerTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);

            PdfPCell FCarriedoutCell = new PdfPCell(new Phrase("Carried out by", FooterFont));
            PdfPCell FValdatedbyCell = new PdfPCell(new Phrase("Validated by", FooterFont));
            PdfPCell FVerifiedbyCell = new PdfPCell(new Phrase("Verified by", FooterFont));
            FCarriedoutCell.BorderWidth = 0; FCarriedoutCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FVerifiedbyCell.BorderWidth = 0; FVerifiedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FValdatedbyCell.BorderWidth = 0; FValdatedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;

            footerTable.AddCell(FCarriedoutCell);
            footerTable.AddCell(FValdatedbyCell);
            footerTable.AddCell(FVerifiedbyCell);

            StringReader sr = new StringReader(sw.ToString());

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            writer.PageEvent = new PdfPageEvents(footerTable, HeaderTable);
            pdfDoc.Open();
            if (IsPrint == true)
            {
                PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                writer.AddJavaScript(jAction);
            }
            iTextSharp.text.html.simpleparser.HTMLWorker htmlworker = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Add(table);
            writer.CloseStream = false;
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }
    public void GrpPDFWL2(bool IsPrint)
    {
        try
        {
            lnkExportXL.Visible = false;
            long returncode1 = -1;
            long SearchID = Convert.ToInt64(hdnGrpID.Value);
            //string WLMode = "All";
            //string Fromdate = string.Empty;
            //string Todate = string.Empty;
            //string fromdate = string.Empty, todate = string.Empty;
            ////DateTime s = Convert.ToDateTime(txtFrom.Text.ToString());
            ////int pendingdays = Convert.ToInt16(txtPendingDays.Text);
            ////s = s.Date.AddDays(-pendingdays);
            ////Fromdate = s.ToString("dd-MM-yyyy 00:00:00");
            ////fromdate = Fromdate;

            ////DateTime s1 = Convert.ToDateTime(txtTo.Text.ToString());
            ////s1 = s1.Date.AddDays(-pendingdays);
            ////Todate = s1.ToString("dd-MM-yyyy 23:59:59");
            ////todate = Todate;
            //fromdate = txtFrom.Text;
            //todate = txtTo.Text;
            //string TestType = "All";
            //string VisitNumber = string.Empty;
            //long MinVid = -1;
            //long MaxVid = -1;
            //returncode = InvBL.GetBatchWiseWorklist(Convert.ToInt32(ddlClients.SelectedValue), ddlWorkListType.SelectedItem.Value, SearchID, OrgID, WLMode, fromdate, todate, TestType, MinVid, MaxVid, out lstPatientInvestigation);

            //List<PatientInvestigation> PDetailsLst = new List<PatientInvestigation>();
            //PDetailsLst = (from S in lstPatientInvestigation
            //               where S.Migrated_Visit_Number != null
            //               group S by new { S.Migrated_Visit_Number, S.PatientVisitID, S.Name, S.InvestigationName, S.WorklistCreatedby } into g
            //               select new PatientInvestigation
            //               {
            //                   Migrated_Visit_Number = g.Key.Migrated_Visit_Number,
            //                   PatientVisitID = g.Key.PatientVisitID,
            //                   Name = g.Key.Name,
            //                   InvestigationName = g.Key.InvestigationName,
            //                   WorklistCreatedby = g.Key.WorklistCreatedby
            //                   //Name = g.Key.Name,
            //                   //Comments = g.Key.Comments
            //               }).Distinct().ToList();
            List<PatientInvestigation> PDetailsLst = new List<PatientInvestigation>();
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            PDetailsLst = oSerializer.Deserialize<List<PatientInvestigation>>(hdnTable.Value);
            int GroupId = Convert.ToInt32(SearchID);
            long patientvisit = -1;
            List<DeviceImportData> LstDevice = new List<DeviceImportData>();
            returncode1 = new Investigation_BL(base.ContextInfo).GetInvestigationAbbCode(GroupId, patientvisit, out LstDevice);
            TableRow row = new TableRow();
            TableRow row1 = new TableRow();
            string str1 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06 == null ? "S.No" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06;
            string str2 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_07 == null ? "WorkListID" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_07;
            string str3 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_08 == null ? "Registered.on" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_08;
            string str4 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_09 == null ? "VisitNumber" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_09;
            string str5 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_10 == null ? "Name" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_10;
            string str6 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_11 == null ? "BarcodeNo" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_11;
            int flag = 0;
            if (PDetailsLst.Count > 0)
            {
                TableCell tc = new TableCell();
                TableCell WL = new TableCell();
                TableCell Rg = new TableCell();
                TableCell tc1 = new TableCell();
                TableCell Vst = new TableCell();
                TableCell Pat = new TableCell();
                tc.Text = str1.Trim();
                WL.Text = str2.Trim();
                Rg.Text = str3.Trim();
                Vst.Text = str4.Trim();
                Pat.Text = str5.Trim();
                tc1.Text = str6.Trim();
                Rg.BorderWidth = 1;
                WL.BorderWidth = 1;
                tc.BorderWidth = 1;
                Vst.BorderWidth = 1;
                Pat.BorderWidth = 1;
                //tc.Style.Add("width", "50%");
                tc1.BorderWidth = 1;
                tc1.Attributes.Add("align", "left");
                Vst.Attributes.Add("align", "left");
                Pat.Attributes.Add("align", "left");
                row.Cells.Add(tc);
                row.Cells.Add(WL);
                row.Cells.Add(Rg);
                row.Cells.Add(Vst);
                row.Cells.Add(Pat);
                row.Cells.Add(tc1);
                foreach (DeviceImportData lstpat in LstDevice)
                {
                    TableCell cell = new TableCell();
                    TableCell cell1 = new TableCell();
                    cell.Text = lstpat.TestCode.ToString();
                    cell.BorderWidth = 1;
                    cell1.BorderWidth = 1;
                    cell.Style.Add("width", "7%");
                    row.Cells.Add(cell);
                    row1.Cells.Add(cell1);
                }
                TableCell tc2 = new TableCell();
                //tc2.Text = "Generated By";
                tc2.BorderWidth = 1;
                //row.Cells.Add(tc2);
                InvTable.Rows.Add(row);
                int z = 1;
                for (int i = 0; i < PDetailsLst.Count; i++)
                {
                    TableRow tr = new TableRow();
                    TableCell td = new TableCell();
                    TableCell WL1 = new TableCell();
                    TableCell Rg1 = new TableCell();
                    TableCell td1 = new TableCell();
                    TableCell td2 = new TableCell();
                    TableCell Pat1 = new TableCell();
                    //if (lstPatientInvestigation[i].Migrated_Visit_Number.ToString() != "0")
                    //{
                    //    td1.Text = lstPatientInvestigation[i].Migrated_Visit_Number.ToString() + "-" + lstPatientInvestigation[i].Name.ToString();
                    //}
                    ////td1.Text = 
                    if (!String.IsNullOrEmpty(PDetailsLst[i].InvestigationValue))
                    {
                        td1.Text = PDetailsLst[i].InvestigationValue.ToString();
                    }
                    else
                    {
                        td1.Text = PDetailsLst[i].Migrated_Visit_Number.ToString();
                    }
                    if (!String.IsNullOrEmpty(PDetailsLst[i].Migrated_Visit_Number))
                    {
                        td2.Text = PDetailsLst[i].Migrated_Visit_Number.ToString();
                    }
                    if (!String.IsNullOrEmpty(PDetailsLst[i].Name))
                    {
                        Pat1.Text = PDetailsLst[i].Name.ToString();
                    }
                    if (!String.IsNullOrEmpty(PDetailsLst[i].WorkListID.ToString()))
                    {
                        WL1.Text = PDetailsLst[i].WorkListID.ToString();
                    }
                    if (!String.IsNullOrEmpty(PDetailsLst[i].DeviceID.ToString()))
                    {
                        Rg1.Text = PDetailsLst[i].DeviceID.ToString();
                    }
                    td.Text = (z++).ToString();
                    td1.Style.Add("width", "7%");
                    td2.Style.Add("width", "10%");
                    Pat1.Style.Add("width", "20%");
                    td1.Attributes.Add("align", "left");
                    td2.Attributes.Add("align", "left");
                    Pat1.Attributes.Add("align", "left");
                    td.BorderWidth = 1;
                    WL1.BorderWidth = 1;
                    td1.BorderWidth = 1;
                    Rg1.BorderWidth = 1;
                    td2.BorderWidth = 1;
                    Pat1.BorderWidth = 1;
                    tr.Cells.Add(td);
                    tr.Cells.Add(WL1);
                    tr.Cells.Add(Rg1);
                    tr.Cells.Add(td2);
                    tr.Cells.Add(Pat1);
                    tr.Cells.Add(td1);
                    foreach (DeviceImportData lstpat in LstDevice)
                    {
                        TableCell cell2 = new TableCell();
                        TableRow row2 = new TableRow();
                        cell2.Text = "";
                        cell2.BorderWidth = 1;
                        tr.Cells.Add(cell2);
                        flag++;
                    }
                    //TableCell td2 = new TableCell();
                    //if (!String.IsNullOrEmpty(PDetailsLst[i].WorklistCreatedby))
                    //{
                    //    td2.Text = PDetailsLst[i].WorklistCreatedby;
                    //}
                    //td2.BorderWidth = 1;
                    //tr.Cells.Add(td2);
                    InvTable.Rows.Add(tr);
                }
            }
            string searchName = string.Empty;
            int count = 0;
            Font labelFont = new Font(Font.FontFamily.TIMES_ROMAN, 13, Font.BOLD);
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
            Font TopHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font FooterFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 8);

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=WorkList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            HtmlForm frm = new HtmlForm();
            //TableRow row = new TableRow();
            //TableRow row1 = new TableRow();
            //TableCell cell1 = new TableCell();
            //TableCell cell2 = new TableCell();
            //TableCell cell3 = new TableCell();
            ////TableCell cell4 = new TableCell();
            //TableCell cell5 = new TableCell();
            //TableCell cell6 = new TableCell();
            //TableCell cell7 = new TableCell();

            //cell1.Attributes.Add("align", "left");
            //cell1.Text = "<u><B>VisitID</B></u>";
            //cell2.Attributes.Add("align", "left");
            //cell2.Text = "<u><B>Name</</u>";
            //cell3.Attributes.Add("align", "left");
            //cell3.Text = "<u><B>Details</B></u>";
            //row.Cells.Add(cell1);
            //row.Cells.Add(cell2);
            //row.Cells.Add(cell3);
            //GroupTable.Rows.Add(row);
            //string   TEXT = cell1.Text;

            for (int x = 0; x < InvTable.Rows[0].Cells.Count; x++)
            {
                //if (Grid.Columns[x].Visible == true)
                //{
                count = count + 1;
            }

            PdfPTable table = new PdfPTable(count);
            table.WidthPercentage = 100;
            table.DefaultCell.Padding = 2;
            table.DefaultCell.SpaceCharRatio = 2;



            //Set the column widths 

            int[] widths = new int[count];
            int tempCount = 0;

            for (int x = 0; x < InvTable.Rows[0].Cells.Count; x++)
            {
                //if (Grid.Columns[x].Visible == true)
                //{
                string cellText = string.Empty;
                cellText = Server.HtmlDecode(InvTable.Rows[0].Cells[x].Text);
                PdfPCell pHcell = new PdfPCell(new Phrase(cellText, titleFont));
                table.AddCell(pHcell);
                if (x == 0)
                {
                    widths[tempCount] = (int)4;
                }
                else if (x == 1)
                {
                    widths[tempCount] = (int)8;
                }
                else if (x == 4)
                {
                    widths[tempCount] = (int)25;
                }
                else
                {
                    widths[tempCount] = (int)10;
                }
                tempCount += 1;
                //}
            }
            table.SetWidths(widths);



            //Transfer rows from GridView to table

            for (int i = 1; i < InvTable.Rows.Count; i++)
            {
                //if (Grid.Rows[i].RowType == DataControlRowType.DataRow)
                //{
                //InvTable.Rows.Count
                for (int j = 0; j < InvTable.Rows[0].Cells.Count; j++)
                {
                    //if (Grid.Columns[j].Visible == true)
                    //{
                    PdfPCell pBcell = null;
                    string cellText = string.Empty;
                    if (j > 0)
                    {
                        cellText = Server.HtmlDecode(InvTable.Rows[i].Cells[j].Text);
                    }
                    else
                    {
                        cellText = (i + 0).ToString();
                    }
                    pBcell = new PdfPCell(new Phrase(cellText, textFont));
                    //if (j==grdresult.Columns.Count-1)
                    //{
                    //    pBcell.VerticalAlignment =Element.ALIGN_BOTTOM;
                    //}
                    table.AddCell(pBcell);
                    //}
                }
                //}
            }
            //table.AddCell(cell1);
            Document pdfDoc = new Document();
            if (IsPotrait == "Y")
            {
                pdfDoc = new Document(PageSize.A4, 7f, 7f, 7f, 0f);
            }
            else
            {
                pdfDoc = new Document(PageSize.A4.Rotate(), 0, 0, 15, 5);
            }
            pdfDoc.SetMargins(40f, 40f, 130f, 60f);
            //open our document


            PdfPTable HeaderTable = new PdfPTable(4);
            HeaderTable.WidthPercentage = 100;
            HeaderTable.DefaultCell.Padding = 2;
            int[] Headerwidths = new int[4] { 10, 12, 10, 12 };
            HeaderTable.SetWidths(Headerwidths);

            HeaderTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);


            PdfPCell TopHeaderCell = new PdfPCell(new Phrase(lblHeader.Text, TopHeaderFont));
            TopHeaderCell.Colspan = 4;
            TopHeaderCell.BorderWidth = 0;
            TopHeaderCell.HorizontalAlignment = Element.ALIGN_CENTER;

            HeaderTable.AddCell(TopHeaderCell);

            PdfPCell HWLTypeCell = new PdfPCell(new Phrase(Label1.Text, titleFont));
            PdfPCell HWLTypetxtCell = new PdfPCell(new Phrase(lblWorkListBasedOn.Text, titleFont));

            PdfPCell HGroupedByCell = new PdfPCell(new Phrase(Label2.Text, titleFont));
            PdfPCell HGroupedBytxtCell = new PdfPCell(new Phrase(lblGroupingWorkListtxt.Text, titleFont));

            PdfPCell HWorkListIDCell = new PdfPCell(new Phrase(lblWLID.Text, titleFont));
            PdfPCell HWorkListIDtxtCell = new PdfPCell(new Phrase(lblWLIDtxt.Text, titleFont));

            PdfPCell HGeneratedOnCell = new PdfPCell(new Phrase(lblWLOntxt.Text, titleFont));
            PdfPCell HGeneratedOntxtCell = new PdfPCell(new Phrase(lblWLOn.Text, titleFont));




            HWLTypeCell.BorderWidth = 0; HWLTypeCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWLTypeCell.NoWrap = true;
            HWLTypetxtCell.BorderWidth = 0; HWLTypetxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWLTypetxtCell.NoWrap = true;

            HGroupedByCell.BorderWidth = 0; HGroupedByCell.HorizontalAlignment = Element.ALIGN_RIGHT;
            HGroupedBytxtCell.BorderWidth = 0; HGroupedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT;

            HWorkListIDCell.BorderWidth = 0; HWorkListIDCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWorkListIDCell.NoWrap = true;
            HWorkListIDtxtCell.BorderWidth = 0; HWorkListIDtxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWorkListIDtxtCell.NoWrap = true;

            HGeneratedOnCell.BorderWidth = 0; HGeneratedOnCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedOnCell.NoWrap = true;
            HGeneratedOntxtCell.BorderWidth = 0; HGeneratedOntxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedOntxtCell.NoWrap = true;

            HeaderTable.AddCell(HWLTypeCell);
            HeaderTable.AddCell(HWLTypetxtCell);
            HeaderTable.AddCell(HGroupedByCell);
            HeaderTable.AddCell(HGroupedBytxtCell);
            HeaderTable.AddCell(HWorkListIDCell);
            HeaderTable.AddCell(HWorkListIDtxtCell);
            HeaderTable.AddCell(HGeneratedOnCell);
            HeaderTable.AddCell(HGeneratedOntxtCell);

            ///////////////////


            PdfPTable footerTable = new PdfPTable(3);
            footerTable.WidthPercentage = 100;
            footerTable.DefaultCell.Padding = 2;
            footerTable.DefaultCell.SpaceCharRatio = 2;

            footerTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);

            PdfPCell FCarriedoutCell = new PdfPCell(new Phrase("Carried out by", FooterFont));
            PdfPCell FVerifiedbyCell = new PdfPCell(new Phrase("Validated by", FooterFont));
            PdfPCell FValidatedbyCell = new PdfPCell(new Phrase("Verified by", FooterFont));
            FCarriedoutCell.BorderWidth = 0; FCarriedoutCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FVerifiedbyCell.BorderWidth = 0; FVerifiedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FValidatedbyCell.BorderWidth = 0; FValidatedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;

            footerTable.AddCell(FCarriedoutCell);
            footerTable.AddCell(FVerifiedbyCell);
            footerTable.AddCell(FValidatedbyCell);
            StringReader sr = new StringReader(sw.ToString());

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            writer.PageEvent = new PdfPageEvents(footerTable, HeaderTable);
            pdfDoc.Open();
            if (IsPrint == true)
            {
                PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                writer.AddJavaScript(jAction);
            }
            iTextSharp.text.html.simpleparser.HTMLWorker htmlworker = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Add(table);
            pdfDoc.HtmlStyleClass = "PageBreak";
            writer.CloseStream = false;
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records", ex);
        }

    }    
    public void GrpPDFWL3(bool IsPrint)
    {
        try
        {
            lnkExportXL.Visible = false;
            long SearchID = Convert.ToInt64(hdnGrpID.Value);
            //string WLMode = "All";
            //string Fromdate = string.Empty;
            //string Todate = string.Empty;
            //string fromdate = string.Empty, todate = string.Empty;
            //fromdate = txtFrom.Text;
            //todate = txtTo.Text;
            //string TestType = "All";
            //string VisitNumber = string.Empty;
            //long MinVid = -1;
            //long MaxVid = -1;
            //returncode = InvBL.GetBatchWiseWorklist(Convert.ToInt32(ddlClients.SelectedValue), ddlWorkListType.SelectedItem.Value, SearchID, OrgID, WLMode, fromdate, todate, TestType, MinVid, MaxVid, out lstPatientInvestigation);

            //List<PatientInvestigation> PDetailsLst = new List<PatientInvestigation>();
            //PDetailsLst = (from S in lstPatientInvestigation
            //               where S.Migrated_Visit_Number != null
            //               group S by new { S.Migrated_Visit_Number, S.PatientVisitID, S.InvestigationValue, S.InvestigationName, } into g
            //               select new PatientInvestigation
            //               {
            //                   Migrated_Visit_Number = g.Key.Migrated_Visit_Number,
            //                   PatientVisitID = g.Key.PatientVisitID,
            //                   InvestigationValue = g.Key.InvestigationValue,
            //                   InvestigationName = g.Key.InvestigationName
            //                   //WorklistCreatedby = g.Key.WorklistCreatedby
            //                   //Name = g.Key.Name,
            //                   //Comments = g.Key.Comments
            //               }).Distinct().ToList();
            long returncode1 = -1;
            List<PatientInvestigation> PDetailsLst = new List<PatientInvestigation>();
            JavaScriptSerializer oSerializer = new JavaScriptSerializer();
            PDetailsLst = oSerializer.Deserialize<List<PatientInvestigation>>(hdnTable.Value);
            int GroupId = Convert.ToInt32(SearchID);
            long patientvisit = -1;
            List<DeviceImportData> LstDevice = new List<DeviceImportData>();
            returncode1 = new Investigation_BL(base.ContextInfo).GetInvestigationAbbCode(GroupId, patientvisit, out LstDevice);
            TableRow row = new TableRow();
            TableRow row1 = new TableRow();
            int flag = 0;
            Table GroupTable1 = new Table();
            //Table temptable = Request.Form["GroupTable"];
            //Table temptable = (Table)Page.FindControl("GroupTable");
            //for (int g = 0; g < 3; g++)
            //{
            //    string text = temptable.Rows[0].Cells[g].Text;
            //}
            string str1 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06 == null ? "S.No" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_06;
            string str2 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_12 == null ? "Code" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_12;
            string str3 = Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_13 == null ? "PatientDetails" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseWorkList_aspx_13;
            if (PDetailsLst.Count > 0)
            {
                TableRow row3 = new TableRow();
                TableCell tcl = new TableCell();
                TableCell tcl1 = new TableCell();
                TableCell tcl12 = new TableCell();
                TableCell tcl13 = new TableCell();
                tcl.Text = str1.Trim();
                //tcl1.Text = "GeneratedBy";
                tcl12.Text = str2.Trim();
                tcl13.Text = str3.Trim();
                //tcl13.Attributes.Add("align", "left");
                row3.Cells.Add(tcl);
                //row3.Cells.Add(tcl1);
                row3.Cells.Add(tcl12);
                row3.Cells.Add(tcl13);
                GroupTable1.Rows.Add(row3);

                TableCell tc = new TableCell();
                tc.Text = str1.Trim();
                tc.BorderWidth = 1;
                row.Cells.Add(tc);
                InvTable.Rows.Add(row);
                int z = 1;
                for (int i = 0; i < PDetailsLst.Count; i++)
                {
                    TableRow row2 = new TableRow();
                    TableCell td = new TableCell();
                    td.Text = (z++).ToString();
                    row2.Cells.Add(td);
                    //TableCell td2 = new TableCell();
                    //if (!String.IsNullOrEmpty(PDetailsLst[i].WorklistCreatedby))
                    //{
                    //    td2.Text = PDetailsLst[i].WorklistCreatedby.ToString();
                    //}
                    //row2.Cells.Add(td2);
                    TableCell td1 = new TableCell();
                    td1.Attributes.Add("align", "center");
                    td1.Text = "Name :" + PDetailsLst[i].Name.ToString() + Environment.NewLine + "Age :" + PDetailsLst[i].Age.ToString() + Environment.NewLine + "VID :" + PDetailsLst[i].Migrated_Visit_Number.ToString() + Environment.NewLine + "SID :" + PDetailsLst[i].InvestigationValue.ToString() + Environment.NewLine
                    + "Receivedon :" + PDetailsLst[i].IsAutoAuthorize.ToString();
                    row2.Cells.Add(td1);

                    flag = 0;
                    TableCell Cell3 = new TableCell();
                    //Cell3.BorderWidth = 1;
                    foreach (DeviceImportData objWL in LstDevice)
                    {
                        Cell3 = new TableCell();
                        Cell3.Attributes.Add("align", "left");
                        //Cell3.BorderWidth=1;
                        if (flag >= 3)
                        {
                            flag = 0;
                            row2 = new TableRow();
                            Cell3 = new TableCell();
                            //Cell3.BorderWidth = 1;
                            Cell3.Attributes.Add("align", "left");
                            //TableCell Cell4 = new TableCell();
                            //Cell4.Text = "";
                            //Cell4.BorderWidth = 1;
                            TableCell Cell5 = new TableCell();
                            Cell5.Text = "";
                            //Cell5.BorderWidth = 1;
                            TableCell Cell6 = new TableCell();
                            Cell6.Text = "";
                            //Cell6.BorderWidth = 1;
                            //row2.Cells.Add(Cell4);
                            row2.Cells.Add(Cell5);
                            row2.Cells.Add(Cell6);
                        }
                        Cell3.Text = objWL.TestCode.ToString() + "___________";
                        flag++;
                        row2.Cells.Add(Cell3);
                        GroupTable1.Rows.Add(row2);
                    }

                    GroupTable1.Rows.Add(row2);
                }
            }
            string searchName = string.Empty;
            int count = 0;
            Font labelFont = new Font(Font.FontFamily.TIMES_ROMAN, 13, Font.BOLD);
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
            Font TopHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font FooterFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 12);

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=WorkList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            HtmlForm frm = new HtmlForm();

            for (int x = 0; x < GroupTable1.Rows[0].Cells.Count; x++)
            {
                //if (Grid.Columns[x].Visible == true)
                //{
                count = count + 1;
                //}
            }

            PdfPTable table = new PdfPTable(5);
            table.WidthPercentage = 100;
            table.DefaultCell.Padding = 2;
            table.DefaultCell.SpaceCharRatio = 2;
            int[] Headerwidths1 = new int[5] { 10, 34, 30, 30, 30 };
            table.SetWidths(Headerwidths1);



            //Set the column widths 

            //for (int x = 0; x < GroupTable1.Rows[0].Cells.Count; x++)
            //{
            //    //if (Grid.Columns[x].Visible == true)
            //    //{
            //    string cellText = Server.HtmlDecode(GroupTable1.Rows[0].Cells[x].Text);
            //    PdfPCell pHcell = new PdfPCell(new Phrase(cellText, titleFont));
            //    table.AddCell(pHcell);
            //    //widths[tempCount] = (int)Grid.Columns[x].ItemStyle.Width.Value;
            //    //tempCount += 1;
            //    //}
            //}

            //table.SetWidths(widths);



            //Transfer rows from GridView to table

            for (int i = 0; i < GroupTable1.Rows.Count; i++)
            {
                //for(int TCCount=0;TCCount<5;TCCount++)
                //{
                for (int j = 0; j < 5; j++)
                {
                    //if (Grid.Columns[j].Visible == true)
                    //{
                    PdfPCell pBcell = null;
                    string cellText = string.Empty;
                    //if (j > 0)
                    //{
                    if (GroupTable1.Rows[i].Cells.Count > j)
                    {
                        cellText = Server.HtmlDecode(GroupTable1.Rows[i].Cells[j].Text);
                    }
                    else
                    {
                        cellText = "";
                    }
                    pBcell = new PdfPCell(new Phrase(cellText, textFont));
                    pBcell.BorderWidth = 0;
                    //if (j==grdresult.Columns.Count-1)
                    //{
                    //    pBcell.VerticalAlignment =Element.ALIGN_BOTTOM;
                    //}
                    table.AddCell(pBcell);
                    //TCCount++;
                    //}
                }
                //    PdfPCell pBcell1 = null;
                //    string cellText1 = string.Empty;
                //    cellText1 = "";
                //    pBcell1 = new PdfPCell(new Phrase(cellText1, textFont));
                //    pBcell1.BorderWidth = 0;
                //    table.AddCell(pBcell1);
                //}    
            }
            //table.AddCell(cell1);
            Document pdfDoc = new Document();
            if (IsPotrait == "Y")
            {
                pdfDoc = new Document(PageSize.A4, 7f, 7f, 7f, 0f);
            }
            else
            {
                pdfDoc = new Document(PageSize.A4.Rotate(), 0, 0, 15, 5);
            }
            pdfDoc.SetMargins(40f, 40f, 130f, 60f);
            //open our document


            PdfPTable HeaderTable = new PdfPTable(4);
            HeaderTable.WidthPercentage = 100;
            HeaderTable.DefaultCell.Padding = 2;
            int[] Headerwidths = new int[4] { 10, 12, 10, 12 };
            HeaderTable.SetWidths(Headerwidths);

            HeaderTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);


            PdfPCell TopHeaderCell = new PdfPCell(new Phrase(lblHeader.Text, TopHeaderFont));
            TopHeaderCell.Colspan = 4;
            TopHeaderCell.BorderWidth = 0;
            TopHeaderCell.HorizontalAlignment = Element.ALIGN_CENTER;
            HeaderTable.AddCell(TopHeaderCell);

            PdfPCell HWLTypeCell = new PdfPCell(new Phrase(Label1.Text, titleFont));
            PdfPCell HWLTypetxtCell = new PdfPCell(new Phrase(lblWorkListBasedOn.Text, titleFont));

            PdfPCell HGroupedByCell = new PdfPCell(new Phrase(Label2.Text, titleFont));
            PdfPCell HGroupedBytxtCell = new PdfPCell(new Phrase(lblGroupingWorkListtxt.Text, titleFont));

            PdfPCell HWorkListIDCell = new PdfPCell(new Phrase(lblWLID.Text, titleFont));
            PdfPCell HWorkListIDtxtCell = new PdfPCell(new Phrase(lblWLIDtxt.Text, titleFont));

            PdfPCell HGeneratedOnCell = new PdfPCell(new Phrase(lblWLOntxt.Text, titleFont));
            PdfPCell HGeneratedOntxtCell = new PdfPCell(new Phrase(lblWLOn.Text, titleFont));




            HWLTypeCell.BorderWidth = 0; HWLTypeCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWLTypeCell.NoWrap = true;
            HWLTypetxtCell.BorderWidth = 0; HWLTypetxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWLTypetxtCell.NoWrap = true;

            HGroupedByCell.BorderWidth = 0; HGroupedByCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGroupedByCell.NoWrap = true;
            HGroupedBytxtCell.BorderWidth = 0; HGroupedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGroupedBytxtCell.NoWrap = true;

            HWorkListIDCell.BorderWidth = 0; HWorkListIDCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWorkListIDCell.NoWrap = true;
            HWorkListIDtxtCell.BorderWidth = 0; HWorkListIDtxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWorkListIDtxtCell.NoWrap = true;

            HGeneratedOnCell.BorderWidth = 0; HGeneratedOnCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedOnCell.NoWrap = true;
            HGeneratedOntxtCell.BorderWidth = 0; HGeneratedOntxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedOntxtCell.NoWrap = true;

            HeaderTable.AddCell(HWLTypeCell);
            HeaderTable.AddCell(HWLTypetxtCell);
            HeaderTable.AddCell(HGroupedByCell);
            HeaderTable.AddCell(HGroupedBytxtCell);
            HeaderTable.AddCell(HWorkListIDCell);
            HeaderTable.AddCell(HWorkListIDtxtCell);
            HeaderTable.AddCell(HGeneratedOnCell);
            HeaderTable.AddCell(HGeneratedOntxtCell);

            ///////////////////


            PdfPTable footerTable = new PdfPTable(3);
            footerTable.WidthPercentage = 100;
            footerTable.DefaultCell.Padding = 2;
            footerTable.DefaultCell.SpaceCharRatio = 2;

            footerTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);

            PdfPCell FCarriedoutCell = new PdfPCell(new Phrase("Carried out by", FooterFont));
            PdfPCell FVerifiedbyCell = new PdfPCell(new Phrase("Validated by", FooterFont));
            PdfPCell FValidatedbyCell = new PdfPCell(new Phrase("Verified by", FooterFont));
            FCarriedoutCell.BorderWidth = 0; FCarriedoutCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FVerifiedbyCell.BorderWidth = 0; FVerifiedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FValidatedbyCell.BorderWidth = 0; FValidatedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;

            footerTable.AddCell(FCarriedoutCell);
            footerTable.AddCell(FVerifiedbyCell);
            footerTable.AddCell(FValidatedbyCell);
            StringReader sr = new StringReader(sw.ToString());

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            writer.PageEvent = new PdfPageEvents(footerTable, HeaderTable);
            pdfDoc.Open();
            if (IsPrint == true)
            {
                PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                writer.AddJavaScript(jAction);
            }
            iTextSharp.text.html.simpleparser.HTMLWorker htmlworker = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Add(table);
            writer.CloseStream = false;
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records", ex);
        }

    }
    public void GroupPDF(GridView GrpGrid, bool IsPrint)
    {
        try
        {
            string searchName = string.Empty;
            int count = 0;
            Font labelFont = new Font(Font.FontFamily.TIMES_ROMAN, 13, Font.BOLD);
            Font titleFont = new Font(Font.FontFamily.TIMES_ROMAN, 9, Font.BOLD);
            Font TopHeaderFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font FooterFont = new Font(Font.FontFamily.TIMES_ROMAN, 14, Font.BOLD);
            Font textFont = new Font(Font.FontFamily.TIMES_ROMAN, 8);

            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=WorkList.pdf");
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            HtmlForm frm = new HtmlForm();
            for (int x = 0; x < GrpGrid.Columns.Count; x++)
            {
                if (GrpGrid.Columns[x].Visible == true)
                {
                    count = count + 1;
                }
            }

            PdfPTable table = new PdfPTable(count);
            table.WidthPercentage = 100;
            table.DefaultCell.Padding = 2;
            table.DefaultCell.SpaceCharRatio = 2;



            //Set the column widths 

            int[] widths = new int[count];
            int tempCount = 0;

            for (int x = 0; x < GrpGrid.Columns.Count; x++)
            {
                if (GrpGrid.Columns[x].Visible == true)
                {
                    string cellText = Server.HtmlDecode(GrpGrid.HeaderRow.Cells[x].Text);
                    //string cellText = grdGroupResult.HeaderRow.Cells[x].Text;
                    PdfPCell pHcell = new PdfPCell(new Phrase(cellText, titleFont));
                    table.AddCell(pHcell);
                    if (GrpGrid.Columns[x].ItemStyle.Width.Value == 0)
                    {
                        widths[tempCount] = 4;
                    }
                    else
                    {
                        widths[tempCount] = (int)GrpGrid.Columns[x].ItemStyle.Width.Value;
                    }
                    tempCount += 1;
                }
            }

            table.SetWidths(widths);



            //Transfer rows from GridView to table

            for (int i = 0; i < GrpGrid.Rows.Count; i++)
            {
                if (GrpGrid.Rows[i].RowType == DataControlRowType.DataRow)
                {
                    for (int j = 0; j < GrpGrid.Columns.Count; j++)
                    {
                        if (GrpGrid.Columns[j].Visible == true)
                        {
                            PdfPCell pBcell = null;
                            //string cellText = grdGroupResult.Rows[i].Cells[j].Text;
                            string cellText = string.Empty;
                            if (j > 0)
                            {
                                cellText = Server.HtmlDecode(GrpGrid.Rows[i].Cells[j].Text);
                            }
                            else
                            {
                                cellText = (i + 1).ToString();
                            }
                            pBcell = new PdfPCell(new Phrase(cellText, textFont));
                            table.AddCell(pBcell);
                        }
                    }
                }
            }


            Document pdfDoc = new Document();
            if (IsPotrait == "Y")
            {
                pdfDoc = new Document(PageSize.A4, 7f, 7f, 7f, 0f);
            }
            else
            {
                pdfDoc = new Document(PageSize.A4.Rotate(), 0, 0, 15, 5);
            }
            pdfDoc.SetMargins(40f, 40f, 130f, 60f);
            //open our document


            PdfPTable HeaderTable = new PdfPTable(4);
            HeaderTable.WidthPercentage = 100;
            HeaderTable.DefaultCell.Padding = 2;
            int[] Headerwidths = new int[4] { 10, 12, 10, 12 };
            HeaderTable.SetWidths(Headerwidths);

            HeaderTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);


            PdfPTable HeaderTable1 = new PdfPTable(4);
            HeaderTable1.WidthPercentage = 100;
            HeaderTable1.DefaultCell.Padding = 2;
            int[] Headerwidths1 = new int[4] { 10, 12, 10, 12 };
            HeaderTable1.SetWidths(Headerwidths1);

            HeaderTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);


            PdfPCell TopHeaderCell = new PdfPCell(new Phrase(lblHeader.Text, TopHeaderFont));
            TopHeaderCell.Colspan = 4;
            TopHeaderCell.BorderWidth = 0;
            TopHeaderCell.HorizontalAlignment = Element.ALIGN_CENTER;
            HeaderTable1.AddCell(TopHeaderCell);

            PdfPCell HWLTypeCell = new PdfPCell(new Phrase(Label1.Text, titleFont));
            PdfPCell HWLTypetxtCell = new PdfPCell(new Phrase(lblWorkListBasedOn.Text, titleFont));
            HWLTypeCell.BorderWidth = 0; HWLTypeCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWLTypeCell.NoWrap = true;
            HWLTypetxtCell.BorderWidth = 0; HWLTypetxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWLTypetxtCell.NoWrap = true;
            if (Label1.Text != "" && lblWorkListBasedOn.Text != "")
            {
                HeaderTable1.AddCell(HWLTypeCell);
                HeaderTable1.AddCell(HWLTypetxtCell);
            }

            PdfPCell HGroupedByCell = new PdfPCell(new Phrase(Label2.Text, titleFont));
            PdfPCell HGroupedBytxtCell = new PdfPCell(new Phrase(lblGroupingWorkListtxt.Text, titleFont));
            HGroupedByCell.BorderWidth = 0; HGroupedByCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGroupedByCell.NoWrap = true;
            HGroupedBytxtCell.BorderWidth = 0; HGroupedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGroupedBytxtCell.NoWrap = true;
            if (Label2.Text != "" && lblGroupingWorkListtxt.Text != "")
            {
                HeaderTable1.AddCell(HGroupedByCell);
                HeaderTable1.AddCell(HGroupedBytxtCell);
            }
            PdfPCell HWorkListIDCell = new PdfPCell(new Phrase(lblWLID.Text, titleFont));
            PdfPCell HWorkListIDtxtCell = new PdfPCell(new Phrase(lblWLIDtxt.Text, titleFont));
            HWorkListIDCell.BorderWidth = 0; HWorkListIDCell.HorizontalAlignment = Element.ALIGN_RIGHT; HWorkListIDCell.NoWrap = true;
            HWorkListIDtxtCell.BorderWidth = 0; HWorkListIDtxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HWorkListIDtxtCell.NoWrap = true;
            if (lblWLID.Text != "" && lblWLIDtxt.Text != "")
            {
                HeaderTable1.AddCell(HWorkListIDCell);
                HeaderTable1.AddCell(HWorkListIDtxtCell);
            }
            PdfPCell HGeneratedOnCell = new PdfPCell(new Phrase(lblWLOntxt.Text, titleFont));
            PdfPCell HGeneratedOntxtCell = new PdfPCell(new Phrase(lblWLOn.Text, titleFont));
            HGeneratedOnCell.BorderWidth = 0; HGeneratedOnCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedOnCell.NoWrap = true;
            HGeneratedOntxtCell.BorderWidth = 0; HGeneratedOntxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedOntxtCell.NoWrap = true;
            if (lblWLOntxt.Text != "" && lblWLOn.Text != "")
            {
                HeaderTable1.AddCell(HGeneratedOnCell);
                HeaderTable1.AddCell(HGeneratedOntxtCell);
            }
            PdfPCell HGeneratedByCell = new PdfPCell(new Phrase(Label3.Text, titleFont));
            PdfPCell HGeneratedBytxtCell = new PdfPCell(new Phrase(lblWLUser.Text, titleFont));
            HGeneratedByCell.BorderWidth = 0; HGeneratedByCell.HorizontalAlignment = Element.ALIGN_RIGHT; HGeneratedByCell.NoWrap = true;
            HGeneratedBytxtCell.BorderWidth = 0; HGeneratedBytxtCell.HorizontalAlignment = Element.ALIGN_LEFT; HGeneratedBytxtCell.NoWrap = true;
            if (Label3.Text != "" && lblWLUser.Text != "")
            {
                HeaderTable1.AddCell(HGeneratedByCell);
                HeaderTable1.AddCell(HGeneratedBytxtCell);
            }
            ///////////////////


            PdfPTable footerTable = new PdfPTable(3);
            footerTable.WidthPercentage = 100;
            footerTable.DefaultCell.Padding = 2;
            footerTable.DefaultCell.SpaceCharRatio = 2;

            footerTable.TotalWidth = pdfDoc.PageSize.Width - (pdfDoc.LeftMargin + pdfDoc.RightMargin);

            PdfPCell FCarriedoutCell = new PdfPCell(new Phrase("Carried out by", FooterFont));
            PdfPCell FVerifiedbyCell = new PdfPCell(new Phrase("Validated by", FooterFont));
            PdfPCell FValidatedbyCell = new PdfPCell(new Phrase("Verified by", FooterFont));
            FCarriedoutCell.BorderWidth = 0; FCarriedoutCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FVerifiedbyCell.BorderWidth = 0; FVerifiedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;
            FValidatedbyCell.BorderWidth = 0; FValidatedbyCell.HorizontalAlignment = Element.ALIGN_CENTER;

            footerTable.AddCell(FCarriedoutCell);
            footerTable.AddCell(FVerifiedbyCell);
            footerTable.AddCell(FValidatedbyCell);
            StringReader sr = new StringReader(sw.ToString());

            HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
            //PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
            writer.PageEvent = new PdfPageEvents(footerTable, HeaderTable);
            pdfDoc.Open();
            if (IsPrint == true)
            {
                PdfAction jAction = PdfAction.JavaScript("this.print(true);\r", writer);
                writer.AddJavaScript(jAction);
            }
            iTextSharp.text.html.simpleparser.HTMLWorker htmlworker = new HTMLWorker(pdfDoc);
            htmlparser.Parse(sr);
            pdfDoc.Add(table);
            writer.CloseStream = false;
            pdfDoc.Close();
            Response.Write(pdfDoc);
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Excel Export", ex);
        }
    }
    public void ExportToExcel()
    {
        try
        {
            ////export to excel
            string attachment = "attachment; filename=" + "WorkList - " + OrgTimeZone + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            if (hdnIsWaters.Value != "Y")
            {
                tbResult.RenderControl(oHtmlTextWriter);
                //grdresult.RenderControl(oHtmlTextWriter);
                grdGroupResultWL1.RenderControl(oHtmlTextWriter);
            }
            else { 
            dvgrdGroupResultWL111.RenderControl(oHtmlTextWriter);
            WatersDefault.RenderControl(oHtmlTextWriter);
            }
            //grdresult.RenderControl(oHtmlTextWriter);
            
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records", ex);
        }

    }
    public void ExportToExcelGroup()
    {
        try
        {
            //export to excel
            string attachment = "attachment; filename=" + "Group_WorkList- " + OrgTimeZone + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            tbResult.RenderControl(oHtmlTextWriter);
            //grdGroupResult.RenderControl(oHtmlTextWriter);
			grdGroupResultWL2.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records", ex);
        }

    }
    public static System.Data.DataTable ConvertToPatientInvestigation(List<PatientInvestigation> _lstCollection)
    {
        //lan
        System.Data.DataTable _datatable = new System.Data.DataTable();

        _datatable.Columns.Add("InvestigationName", typeof(System.String));
        _datatable.Columns.Add("InvestigationID", typeof(System.Int64));
        _datatable.Columns.Add("GroupID", typeof(System.Int32));
        _datatable.Columns.Add("GroupName", typeof(System.String));
        _datatable.Columns.Add("GroupComment", typeof(System.String));
        _datatable.Columns.Add("PatientVisitID", typeof(System.Int64));
        _datatable.Columns.Add("CreatedBy", typeof(System.Int64));
        _datatable.Columns.Add("CollectedDateTime", typeof(System.DateTime));
        _datatable.Columns.Add("Status", typeof(System.String));
        _datatable.Columns.Add("ComplaintID", typeof(System.Int32));
        _datatable.Columns.Add("Type", typeof(System.String));
        _datatable.Columns.Add("OrgID", typeof(System.Int32));
        _datatable.Columns.Add("InvestigationMethodID", typeof(System.Int64));
        _datatable.Columns.Add("MethodName", typeof(System.String));
        _datatable.Columns.Add("KitID", typeof(System.Int64));
        _datatable.Columns.Add("KitName", typeof(System.String));
        _datatable.Columns.Add("InstrumentID", typeof(System.Int64));
        _datatable.Columns.Add("InstrumentName", typeof(System.String));
        _datatable.Columns.Add("Interpretation", typeof(System.String));
        _datatable.Columns.Add("PrincipleID", typeof(System.Int64));
        _datatable.Columns.Add("PrincipleName", typeof(System.String));
        _datatable.Columns.Add("QCData", typeof(System.String));
        _datatable.Columns.Add("InvestigationSampleContainerID", typeof(System.Int32));
        _datatable.Columns.Add("PackageID", typeof(System.Int32));
        _datatable.Columns.Add("PackageName", typeof(System.String));
        _datatable.Columns.Add("Reason", typeof(System.String));
        _datatable.Columns.Add("ReportStatus", typeof(System.String));
        _datatable.Columns.Add("ReferenceRange", typeof(System.String));
        _datatable.Columns.Add("PerformingPhysicainName", typeof(System.String));
        _datatable.Columns.Add("ApprovedBy", typeof(System.Int64));
        _datatable.Columns.Add("GUID", typeof(System.String));
        _datatable.Columns.Add("IsAbnormal", typeof(System.String));
        _datatable.Columns.Add("AccessionNumber", typeof(System.Int64));
        _datatable.Columns.Add("AutoApproveLoginID", typeof(System.Int64));
        _datatable.Columns.Add("ValidatedBy", typeof(System.Int64));
        _datatable.Columns.Add("RemarksID", typeof(System.Int64));
        _datatable.Columns.Add("MedicalRemarks", typeof(System.String));
        _datatable.Columns.Add("GroupMedicalRemarks", typeof(System.String));
        _datatable.Columns.Add("InvSampleStatusID", typeof(System.Int32));
        _datatable.Columns.Add("AuthorizedBy", typeof(System.Int64));
        _datatable.Columns.Add("ConvReferenceRange", typeof(System.String));
        _datatable.Columns.Add("ManualAbnormal", typeof(System.String));
        _datatable.Columns.Add("IsAutoAuthorize", typeof(System.String));
        _datatable.Columns.Add("PrintableRange", typeof(System.String));
        _datatable.Columns.Add("IsAutoValidate", typeof(System.String));
        _datatable.Columns.Add("InvStatusReasonID", typeof(System.Int64));
        _datatable.Columns.Add("IsSensitive", typeof(System.String));
        DataRow _datarow;

        foreach (PatientInvestigation _list in _lstCollection)
        {
            _datarow = _datatable.NewRow();
            _datarow["InvestigationName"] = _list.InvestigationName;
            _datarow["InvestigationID"] = _list.InvestigationID;
            _datarow["GroupID"] = _list.GroupID;
            _datarow["GroupName"] = _list.GroupName;
            _datarow["GroupComment"] = _list.GroupComment;
            _datarow["PatientVisitID"] = _list.PatientVisitID;
            _datarow["CreatedBy"] = _list.CreatedBy;
            if (_list.CollectedDateTime != null && _list.CollectedDateTime.CompareTo(DateTime.MinValue) == 0)
            {
                _datarow["CollectedDateTime"] = DateTime.Now;
            }
            else
            {
                _datarow["CollectedDateTime"] = _list.CollectedDateTime;
            }
            _datarow["Status"] = _list.Status;
            _datarow["ComplaintID"] = _list.ComplaintId;
            _datarow["Type"] = _list.Type;
            _datarow["OrgID"] = _list.OrgID;
            _datarow["InvestigationMethodID"] = _list.InvestigationMethodID;
            _datarow["MethodName"] = _list.MethodName;
            _datarow["KitID"] = _list.KitID;
            _datarow["KitName"] = _list.KitName;
            _datarow["InstrumentID"] = _list.InstrumentID;
            _datarow["InstrumentName"] = _list.InstrumentName;
            _datarow["Interpretation"] = _list.Interpretation;
            _datarow["PrincipleID"] = _list.PrincipleID;
            _datarow["PrincipleName"] = _list.PrincipleName;
            _datarow["QCData"] = _list.QCData;
            _datarow["InvestigationSampleContainerID"] = _list.InvestigationSampleContainerID;
            _datarow["PackageID"] = _list.PackageID;
            _datarow["PackageName"] = _list.PackageName;
            _datarow["Reason"] = _list.Reason;
            _datarow["ReportStatus"] = _list.ReportStatus;
            _datarow["ReferenceRange"] = _list.ReferenceRange;
            _datarow["PerformingPhysicainName"] = _list.PerformingPhysicainName;
            _datarow["ApprovedBy"] = _list.ApprovedBy;
            _datarow["GUID"] = _list.UID;
            _datarow["IsAbnormal"] = _list.IsAbnormal;
            _datarow["AccessionNumber"] = _list.AccessionNumber;
            _datarow["AutoApproveLoginID"] = _list.AutoApproveLoginID;
            _datarow["ValidatedBy"] = _list.ValidatedBy;
            _datarow["RemarksID"] = _list.RemarksID;
            _datarow["MedicalRemarks"] = _list.MedicalRemarks;
            _datarow["GroupMedicalRemarks"] = _list.GroupMedicalRemarks;
            _datarow["InvSampleStatusID"] = _list.InvSampleStatusID;
            _datarow["AuthorizedBy"] = _list.AuthorizedBy;
            _datarow["ConvReferenceRange"] = _list.ConvReferenceRange;
            _datarow["ManualAbnormal"] = _list.ManualAbnormal;
            _datarow["IsAutoAuthorize"] = _list.IsAutoAuthorize;
            _datarow["PrintableRange"] = _list.PrintableRange;
            _datarow["IsAutoValidate"] = _list.IsAutoValidate;
            _datarow["InvStatusReasonID"] = _list.InvStatusReasonID;
            _datarow["IsSensitive"] = _list.IsSensitive;

            _datatable.Rows.Add(_datarow);
        }
        return _datatable;
        //Test
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    #endregion
}

internal class PdfPageEvents : IPdfPageEvent
{
    #region members

    private PdfContentByte _content;
    private PdfPTable _footerTable;
    private PdfPTable _headerTable;

    #endregion

    #region IPdfPageEvent Members

    public PdfPageEvents(PdfPTable footerTable, PdfPTable HeaderTable)
    {
        _footerTable = footerTable;
        _headerTable = HeaderTable;
    }

    public void OnOpenDocument(PdfWriter writer, Document document)
    {
        _content = writer.DirectContent;
    }

    public void OnStartPage(PdfWriter writer, Document document)
    {
    }

    public void OnEndPage(PdfWriter writer, Document document)
    {
        _headerTable.WriteSelectedRows(0, 3, document.LeftMargin, document.PageSize.Height - 40, writer.DirectContent);
        _footerTable.WriteSelectedRows(0, -1, document.LeftMargin, 50, writer.DirectContent);
    }

    public void OnCloseDocument(PdfWriter writer, Document document)
    {
    }

    public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
    {
    }

    public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
    {
    }

    public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnGenericTag(PdfWriter writer, Document document, Rectangle rect, string text)
    {
    }

    #endregion
}
internal class GridDecorator
{
    public static void MergeRows(GridView gridView)
    {
        for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = gridView.Rows[rowIndex];
            GridViewRow previousRow = gridView.Rows[rowIndex + 1];

            for (int i = 0; i < row.Cells.Count; i++)
            {
                if (row.Cells[i].Text == previousRow.Cells[i].Text)
                {
                    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                           previousRow.Cells[i].RowSpan + 1;
                    previousRow.Cells[i].Visible = false;
                }
            }
        }
    }
}

