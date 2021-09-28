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
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.ExcelExportManager;
using System.Linq;

public partial class Admin_InvestigationCollectionReport : BasePage
{
    long returnCode = -1;
    DataSet ds = new DataSet();
    List<BillLineItems> resultItems = new List<BillLineItems>();
    List<BillLineItems> lstday = new List<BillLineItems>();
    List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>();
    List<PatientInvestigation> lstGroups = new List<PatientInvestigation>();
    List<PatientInvestigation> lstPackages = new List<PatientInvestigation>();
    List<LabConsumables> lstLabConsumables = new List<LabConsumables>();
    Investigation_BL investigationBL;
    string allobj = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_04 == null ? "-----All-----" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_04;
    string Norcrd = Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_08 == null ? "No Matching Records Found!" : Resources.Admin_ClientDisplay.Admin_LabAdminSummaryReports_aspx_08;
    public Admin_InvestigationCollectionReport() : base("Admin_InvestigationCollectionReport_aspx") { }
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
            txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
            if (!IsPostBack)
            {
                LoadOrgan();
                txtFDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                trlistINV.Style.Add("display", "none");
                trlistGRP.Style.Add("display", "none");
                trlistPKG.Style.Add("display", "none");
                tdSelectMesg.Style.Add("display", "none");

                loadlocations(RoleID, OrgID);

                LoadMeatData();
            }
            if (IsPostBack)
            {
                tdSelectMesg.Style.Add("display", "none");
                if (ddlINVSelection.SelectedIndex == 0)
                {
                    trlistINV.Style.Add("display", "none");
                    trlistGRP.Style.Add("display", "none");
                    trlistPKG.Style.Add("display", "none");
                    tdSelectMesg.Style.Add("display", "none");
                    trFilterINV.Style.Add("display", "none");
                }

                if (ddlINVSelection.SelectedIndex == 1)
                {
                    trlistINV.Style.Add("display", "block");
                    trlistGRP.Style.Add("display", "none");
                    trlistPKG.Style.Add("display", "none");
                    lblLists.InnerText = "Investigation(s)";
                    tdSelectMesg.Style.Add("display", "block");
                    trFilterINV.Style.Add("display", "block");
                }
                if (ddlINVSelection.SelectedIndex == 2)
                {
                    trlistINV.Style.Add("display", "none");
                    trlistGRP.Style.Add("display", "block");
                    trlistPKG.Style.Add("display", "none");
                    lblLists.InnerText = "Group(s)";
                    tdSelectMesg.Style.Add("display", "block");
                    trFilterINV.Style.Add("display", "block");
                }
                if (ddlINVSelection.SelectedIndex == 3)
                {
                    trlistINV.Style.Add("display", "none");
                    trlistGRP.Style.Add("display", "none");
                    trlistPKG.Style.Add("display", "block");
                    lblLists.InnerText = "Package(s)";
                    tdSelectMesg.Style.Add("display", "block");
                    trFilterINV.Style.Add("display", "block");
                }


            }
            investigationBL.GetInvestigationByClientID(OrgID, 0, "INV", out lstInvestigations);
            if (lstInvestigations.Count > 0)
            {
                listINV.DataSource = lstInvestigations;
                listINV.DataTextField = "InvestigationName";
                listINV.DataValueField = "InvestigationID";
                listINV.DataBind();
                listINV.Visible = true;
                //lblrdoINV.Visible = true;
            }
            investigationBL.GetInvestigationByClientID(OrgID, 0, "GRP", out lstGroups);
            if (lstGroups.Count > 0)
            {
                listGRP.DataSource = lstGroups;
                listGRP.DataTextField = "GroupName";
                listGRP.DataValueField = "GroupID";
                listGRP.DataBind();
                listGRP.Visible = true;
                //lblrdoGRP.Visible = true;
            }
            investigationBL.GetInvestigationByClientID(OrgID, 0, "PKG", out lstPackages);
            if (lstPackages.Count > 0)
            {
                listPKG.DataSource = lstPackages;
                listPKG.DataTextField = "GroupName";
                listPKG.DataValueField = "GroupID";
                listPKG.DataBind();
                listPKG.Visible = true;
                // lblrdoPKG.Visible = true;
            }
            //ddlINVSelection.Attributes.Add("onChange", "return setList();");

        }
        catch (Exception excep)
        {
            CLogger.LogError("Error while executing Page_Load in ItemWiseReport.aspx.", excep);
          //  ErrorDisplay1.ShowError = true;
          //  ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
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
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        DateTime strBillFromDate;
        DateTime strBillToDate;
        strBillFromDate = Convert.ToDateTime(txtFDate.Text);
        strBillToDate = Convert.ToDateTime(txtTDate.Text);
        List<OrderedInvestigations> orderedInves = GetOrderedList();
        List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

        string pLocationID = ddlLocation.SelectedValue.ToString();

        if (!String.IsNullOrEmpty(pLocationID))
        {
            ContextInfo.AdditionalInfo = pLocationID;
        }
        else
        {
            ContextInfo.AdditionalInfo = ILocationID.ToString();
        }

        foreach (OrderedInvestigations invs in orderedInves)
        {
            OrderedInvestigations objInvest = new OrderedInvestigations();
            objInvest.ID = invs.ID;
            objInvest.Name = invs.Name;
            objInvest.VisitID = 0;
            objInvest.Status = "";
            objInvest.CreatedBy = LID;
            objInvest.Type = invs.Type;
            objInvest.OrgID = OrgID;
            ordInves.Add(objInvest);
        }
        string Type = string.Empty;
        if (ddlINVSelection.SelectedIndex == 0)
        {
            Type = "ALL";
        }
        else
        {
            Type = ddlINVSelection.SelectedValue;
        }
        

        returnCode = new Report_BL(base.ContextInfo).GetInvestigationCollectionReport(ordInves, strBillFromDate, strBillToDate, OrgID, Type, out resultItems);
        decimal grandTotal = 0;
        decimal InvestigationTotal = 0;
        resultItems.ForEach(delegate(BillLineItems item) { grandTotal += item.Amount; InvestigationTotal += item.Quantity; });

        if (resultItems.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            grdResult.DataSource = resultItems;
            grdResult.DataBind();
            lblGrdTotal.Text = grandTotal.ToString();
            lblInvTotal.Text = InvestigationTotal.ToString();
            excelTab.Style.Add("display", "block");
            lstday = resultItems;

            tdExport.Style.Add("display", "block");
        }
        else
        {
            grdResult.Visible = false;
            lblResult.Visible = true;
            excelTab.Style.Add("display", "none");
            lblResult.Text = Norcrd;
            tdExport.Style.Add("display", "none");
        }

    }


    public List<OrderedInvestigations> GetOrderedList()
    {
        List<OrderedInvestigations> lstpatInves = new List<OrderedInvestigations>();
        OrderedInvestigations PatientInves;
        long id = 0;
        string hidValue = iconHid.Value;
        string strInvName = string.Empty;
        foreach (string splitString in hidValue.Split('^'))
        {
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');

                if (lineItems.Length > 2)
                {
                    PatientInves = new OrderedInvestigations();
                    id = Convert.ToInt64(lineItems[0]);
                    strInvName = lineItems[1];
                    string type = lineItems[2];
                    PatientInves.Type = type;
                    PatientInves.ID = id;
                    PatientInves.Name = strInvName;
                    lstpatInves.Add(PatientInves);
                }
            }
        }
        return lstpatInves;
    }

    protected void btnXL_Click(object sender, EventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TPA/Corp Outstanding Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    btnFinish_Click(sender, e);
                    grdResult.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
            ////string prefix = string.Empty;
            ////prefix = "Test_WiseCollection_Reports_";
            ////string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            ////DataSet dsrpt = (DataSet)ViewState["report"];
            ////if (dsrpt != null)
            ////{
            ////    ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            ////}
            ////else
            ////{
            ////    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            ////}
            // HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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

    protected void loadlocations(long uroleID, int intOrgID)
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        ddlLocation.DataSource = lstLocation;
        ddlLocation.DataTextField = "Location";
        ddlLocation.DataValueField = "AddressID";
        ddlLocation.DataBind();

        if (lstLocation.Count > 0)
        {
            //ddlLocation.Items.Insert(0, "------ALL------");
            ddlLocation.Items.Insert(0, allobj);
            ddlLocation.Items[0].Value = "0";
            ddlLocation.SelectedValue = ILocationID.ToString();
        }
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "invreport";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "invreport"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlINVSelection.DataSource = childItems;
                    ddlINVSelection.DataTextField = "DisplayText";
                    ddlINVSelection.DataValueField = "Code";
                    ddlINVSelection.DataBind();




                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
}
