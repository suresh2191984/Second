using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;

public partial class ReportsLims_DiscountReportLims : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    DataSet ds1 = new DataSet();
    decimal pTotalDiscountAmt = -1;
    public ReportsLims_DiscountReportLims()
        : base("ReportsLims_DiscountReportLims_aspx")
    {
    }

    string visit = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_05 == null ? "VisitDate" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_05;
    string pacount = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_06 == null ? "Patient Count" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_06;
    string strdis = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_07 == null ? "Discount" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_07;
    string strname = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_08 == null ? "PatientName" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_08;
    string struser = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_09 == null ? "UserName" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_09;
    string strnet = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_10 == null ? "UserName" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_10;
    string strvisitno = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_11 == null ? "Visit Number" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_11;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        AuthoUser.Style.Add("Display", "none");
        if (!IsPostBack)
        {
		 LoadMeatData();
            LoadOrgan();
            LoadLocation();
            ddlLocation.SelectedValue = ILocationID.ToString();
            LoadUsersAndAuthorizedBy();
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = OrgTimeZone;
            txtTDate.Text = OrgTimeZone;
        }
    }
    #region  Added from Jagatheeshkumar

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "ReportFormat";
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
                                 where child.Domain == "ReportFormat" orderby child.DisplayText
                                 select child;
                if (childItems.Count() > 0)
                {
                    rblReportType.DataSource = childItems;
                    rblReportType.DataTextField = "DisplayText";
                    rblReportType.DataValueField = "Code";
                    rblReportType.DataBind();
                    rblReportType.SelectedValue = "0";

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
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

    private void LoadLocation()
    {
        string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
       
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location

        returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
      //  returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
                ddlLocation.Items.Insert(0, DispSelect);
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, DispSelect);
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();
            

           
        }
    }
    private void LoadUsersAndAuthorizedBy()
    {
        Report_BL reportBL = new Report_BL(base.ContextInfo);
        List<Users> Users = new List<Users>();
        List<OrgUsers> OrgUsers = new List<OrgUsers>();
        string DispSelect = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04 == null ? "------SELECT------" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_04;
        returnCode = reportBL.GetUserwiseAuthorisedBy(OrgID,out Users, out OrgUsers);

        if (Users.Count > 0)
        {

            UserwiseDropDown.DataSource = Users;
            UserwiseDropDown.DataTextField = "Name";
            //UserwiseDropDown.DataValueField = "AddressID";
            UserwiseDropDown.DataBind();

            if (Users.Count == 1)
            {
                UserwiseDropDown.Items.Insert(0, DispSelect);
                UserwiseDropDown.Items[0].Value = "-1";
            }
            else if (Users.Count == 0 || Users.Count > 1)
            {
                UserwiseDropDown.Items.Insert(0, DispSelect);
                UserwiseDropDown.Items[0].Value = "-1";
            }
        }
        if (OrgUsers.Count > 0)
        {
            AuthoDropDown.DataSource = OrgUsers;
            AuthoDropDown.DataTextField = "Name";
           // AuthoDropDown.DataValueField = "AddressID";
            AuthoDropDown.DataBind();

            if (OrgUsers.Count == 1)
            {
                AuthoDropDown.Items.Insert(0, DispSelect);
                AuthoDropDown.Items[0].Value = "-1";
            }
            else if (OrgUsers.Count == 0 || OrgUsers.Count > 1)
            {
                AuthoDropDown.Items.Insert(0, DispSelect);
                AuthoDropDown.Items[0].Value = "-1";
            }
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
    }

    public DataTable loadSumdata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn(visit);
        DataColumn dcol2 = new DataColumn(pacount);
        DataColumn dcol3 = new DataColumn(strdis);
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr[visit] = item.VisitDate;
            dr[pacount] = item.PatientCount;
            dr[strdis] = item.Discount;
            dt.Rows.Add(dr);
        }
        return dt;
    }
    public DataTable loadDetaileddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("VisitDate");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("VisitNumber");
        DataColumn dcol4 = new DataColumn("UserName");
        DataColumn dcol5 = new DataColumn("TotalAmount");
        DataColumn dcol6 = new DataColumn("NetValue");
        DataColumn dcol7 = new DataColumn("Discount");
        DataColumn dcol8 = new DataColumn("ReferredBy");
        DataColumn dcol9 = new DataColumn("Category");
        DataColumn dcol10 = new DataColumn("WardName");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
	dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["VisitDate"] = item.VisitDate;
            dr["PatientName"] = item.PatientName;
            dr["VisitNumber"] = item.VisitNumber;
            dr["UserName"] = item.UserName;
            dr["NetValue"] = item.NetValue;
            dr["Discount"] = item.Discount;
            dr["ReferredBy"] = item.ReferredBy;
            dr["Category"] = item.Category;
            dr["WardName"] = item.WardName;
            dr["TotalAmount"] = item.TotalAmount;
            dt.Rows.Add(dr);
	}
        return dt;
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string UserDispWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_01 == null ? "No Matching Records found for the selected dates" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_01;
            string AlrtHdrWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt;
           // int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            int reporttype = Convert.ToInt32(rblReportType.SelectedValue);
            
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetDueandDiscountLims(fDate, tDate, OrgID,Convert.ToString(UserwiseDropDown.SelectedValue),Convert.ToString(AuthoDropDown.SelectedValue), 0, reporttype, "DISCOUNT", "", "", Convert.ToInt32(ddlLocation.SelectedValue), 0, 0, out lstDWCR, out pTotalDiscountAmt);

            if (lstDWCR.Count > 0)
            {
                divPrint.Attributes.Add("style", "block");
                divPrint.Visible = true;
                tabGranTotal1.Visible = true;
                lblDiscountTotal.InnerText = String.Format("{0:0.00}", (lstDWCR.Sum(Item => Item.Discount)));

                if (reporttype == 1)
                {
                    AuthoUser.Style.Add("Display", "block");
                    divOPDWCR.Attributes.Add("style", "block");
                    divOPDWCR.Visible = true;
                    gvIPCreditMain.Visible = true;
                    GvSum.Visible = false ;
                    gvIPCreditMain.DataSource = lstDWCR;
                    gvIPCreditMain.DataBind();
                    DataTable dt = loadDetaileddata(lstDWCR);
                    ds.Tables.Add(dt);
                    ViewState["Detailreport"] = ds;
                }
                else if (reporttype == 2 || reporttype == 0)
                {
                    AuthoUser.Style.Add("Display", "none");
                    divSum.Attributes.Add("style", "block");                    
                    divSum.Visible = true;
                    GvSum.Visible = true;
                    gvIPCreditMain.Visible = false;
                    GvSum.DataSource = lstDWCR;
                    GvSum.DataBind();
                    DataTable dt1 = loadSumdata(lstDWCR);
                    ds1.Tables.Add(dt1);
                    ViewState["Sumreport"] = ds1;
                }
            }

            else
            {
                if (reporttype == 1)
                {
                    AuthoUser.Style.Add("Display", "table-row");
                    divOPDWCR.Attributes.Add("style", "block");
                }
                else if (reporttype == 0)
                {
                    AuthoUser.Style.Add("Display", "none");
                    divSum.Attributes.Add("style", "block");
                }
                divSum.Attributes.Add("style", "none");
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                GvSum.Visible = false;
                gvIPCreditMain.Visible = false;
                tabGranTotal1.Visible = false;
                //CalculationPanelNone();
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + UserDispWin + "','" + AlrtHdrWin + "');", true);
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

    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;

        lblDiscountTotal.InnerText = String.Format("{0:0.00}", (pTotalDiscountAmt));
    }

    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string UserDispWin1 = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_03 == null ? "First click the get report" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_03;
            string AlrtHdrWin = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt == null ? "Alert" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_Alrt;
           
            string TextDisp = Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_02 == null ? "Discount_ReportsDPTOPIP_" : Resources.ReportsLims_ClientDisplay.ReportsLims_DiscountReportLims_aspx_02;
            int reporttype = Convert.ToInt32(rblReportType.SelectedValue);
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TPA/Corp Discount Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            string prefix = string.Empty;
           // prefix = "Discount_ReportsDPTOPIP_";
            prefix = TextDisp;
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = new DataSet();
            btnSubmit_Click(sender, e);
            if (reporttype == 1)
            {
                 dsrpt = (DataSet)ViewState["Detailreport"];
            }
            else if (reporttype == 0)
            {
                dsrpt = (DataSet)ViewState["Sumreport"];
            }
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + UserDispWin1 + "','" + AlrtHdrWin + "');", true);
            }
            //using (StringWriter sw = new StringWriter())
            //{
            //    using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            //    {
            //        btnSubmit_Click(sender, e);
            //        //gvIPReport.RenderControl(htw);

            //        HttpContext.Current.Response.Write(sw.ToString());
            //        HttpContext.Current.Response.End();


            //    }
            //}
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
