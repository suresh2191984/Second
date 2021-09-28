using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Globalization;
using System.Web.Script.Serialization;
public partial class Investigation_NewWorkList : BasePage
{
    int pOrderedCount = -1;
    long vid = 0;
    long returnCode = -1;
    string fromVisit = string.Empty;
    string toVisit = string.Empty;
    long i = 0;
    int vtyp = -1;
    List<NewWorkList> lstWorkList = new List<NewWorkList>();
    Investigation_BL investigationBL;
    string intHistoryMode = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string defaultText = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        hdnOrgID.Value = OrgID.ToString();
        //txtFromFormat.HRef = "javascript:NewCssCal('txtFrom'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";
        //txtToFormat.HRef = "javascript:NewCssCal('txtTo'," + "'" + DateFormat + "'" + ",'arrow',true," + "'" + TimeFormat + "'" + ")";

        if (!IsPostBack)
        {
            List<InvDeptMaster> lDeptmaster = new List<InvDeptMaster>();
            returnCode = investigationBL.GetInvforDept(OrgID, out lDeptmaster);
            LoadInvestigationDepartment(lDeptmaster);
            LoadInvClientMaster();
            LoadLocation();
            LoadPriority();
            //txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            //txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");

            IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
            if (IsNeedExternalVisitIdWaterMark != "")
            {
                Watermark.WatermarkText = IsNeedExternalVisitIdWaterMark;
                Watermark1.WatermarkText = IsNeedExternalVisitIdWaterMark;
                if (IsNeedExternalVisitIdWaterMark.Replace(" ", String.Empty).ToLower() == "labnumber")
                {
                    txtFromVisit.MaxLength = 9;
                    txtToVisit.MaxLength = 9;
                }
            }
            else
            {
                Watermark.WatermarkText = "Visit Number";
                Watermark1.WatermarkText = "Visit Number";
            }
            // txtwatermark();
            //DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
            //DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
            //string a = dt.ToString(DateTimeFormat);
            //txtFrom.Text = a.Substring(0, 10) + " " + "00:00";
            //txtTo.Text = a.ToString();
            if (Request.QueryString["NSC"] != null && Request.QueryString["NSC"] != "")
            {
                if (Request.QueryString["NSC"] == "Y")
                {
                    hdnIsScan.Value = "N";
                    btnFinish.Value = "Get WorkList";
                    tdwrklst.Style.Add("display", "table-cell");
                    txtWorklistID.Style.Add("display", "block");
                }
                else
                {
                    hdnIsScan.Value = "Y";
                    btnFinish.Value = "Start Scaning";
                    tdwrklst.Style.Add("display", "none");
                    txtWorklistID.Style.Add("display", "none");
                }
            }
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

    public void LoadLocation()
    {
        try
        {
            long retCode = -1;
            List<OrganizationAddress> lOrgAdr = new List<OrganizationAddress>();
            retCode = new AdminReports_BL(base.ContextInfo).pGetOrganizationLocation(OrgID, ILocationID, 0, out lOrgAdr);
            //var q = from p in lstOrgLocation
            //       where p.OrgID ==Convert.ToInt64(ddlOrglocation.SelectedItem.Value)
            //       select p;
            ddlLocation.DataSource = lOrgAdr;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("-----Select-----", "-1"));
            //ddlLocation.Items[0].Value = "-1";

            ddlLocation.SelectedValue = "-1";

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }

    public void LoadInvClientMaster()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getInvClientMaster = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            retCode = patBL.GetInvClientMaster(OrgID, "Y", out getInvClientMaster);

            ddlClients.DataSource = getInvClientMaster;
            ddlClients.DataTextField = "ClientName";
            ddlClients.DataValueField = "ClientID";
            ddlClients.DataBind();
            ddlClients.Items.Insert(0, "-----Select-----");
            ddlClients.Items[0].Value = "0";
            ddlClients.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }

    public void LoadInvestigationDepartment(List<InvDeptMaster> lDeptmaster)
    {
        try
        {
            if (lDeptmaster.Count > 0)
            {
                var lstdpt = from lst in lDeptmaster
                             where lst.Display == "Y"
                             select lst;
                ddlDept.DataSource = lstdpt;
                ddlDept.DataTextField = "DeptName";
                ddlDept.DataValueField = "DeptID";
                ddlDept.DataBind();
            }
            ddlDept.Items.Insert(0, "All");
            ddlDept.Items[0].Value = "0";
            //ddlDept.Items.Insert(0, "-----Select-----");
            //ddlDept.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Department Details.", ex);
        }
    }

    public void LoadWorklistType()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvClientMaster> getWorklistType = new List<InvClientMaster>();
            //retCode = patBL.GetInvClientMaster(OrgID, out getInvClientMaster);
            //retCode = patBL.getWorklistType(OrgID, "Y", out getInvClientMaster);

            //ddlClients.DataSource = getInvClientMaster;
            //ddlClients.DataTextField = "ClientName";
            //ddlClients.DataValueField = "ClientID";
            //ddlClients.DataBind();
            //ddlClients.Items.Insert(0, "-----Select-----");
            //ddlClients.Items[0].Value = "0";
            //ddlClients.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Client Details.", ex);
        }
    }

    #region gvDataBound

    protected void gvUrinalysis_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvBloodGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvFecalysis_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void gvMicroSerology_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    #endregion

    //protected void btnFinish_Click(object sender, EventArgs e)
    //{
    //    LoadWorkList();
    //}
    public void GenerateWorkList()
    {
        long result = -1;
        long LocationID = Convert.ToInt64(ILocationID);
        string searchType = ddlCultureType.SelectedItem.Text;
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<NewWorkList> lstworklist = new List<NewWorkList>();
        //lstworklist = hdnLstGrp.Value.Split(
        string worklistID = string.Empty;
        if (hdnLstGrp.Value != "")
        {
            lstworklist = serializer1.Deserialize<List<NewWorkList>>(hdnLstGrp.Value);
        }
        Investigation_BL ibl = new Investigation_BL(base.ContextInfo);
        result = ibl.SaveWorkList(OrgID, lstworklist, LocationID, searchType, LID, out worklistID);
        if (worklistID != "")
        {
            lblPrintHeader.Text = searchType + " Work Sheet";
            lblPrintLocation.Text = LocationName.ToString();
            lblPrintGeneratedBy.Text = LoginName.ToString();
            DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
            DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
            string a = dt.ToString(DateTimeFormat);
            lblPrintDateTime.Text = a.ToString();
            lblPrintWorkListID.Text = worklistID.ToString();
            tabPrintButton.Style.Add("display", "block");
            tblPrint.Style.Add("display", "block");
            lblStatus.Visible = false;
        }
        txtWorklistID.Text = worklistID;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "LoadWorkList", "LoadWorkList('" + worklistID + "');", true);
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:LoadWorkList('0');", true);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GenerateWorkList();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        GenerateWorkList();
        //long result = -1;
        //long LocationID = Convert.ToInt64(ILocationID);
        //string searchType = ddlCultureType.SelectedItem.Text;
        //JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        //List<NewWorkList> lstworklist = new List<NewWorkList>();
        ////lstworklist = hdnLstGrp.Value.Split(
        //string worklistID = string.Empty;
        //if (hdnLstGrp.Value != "")
        //{
        //    lstworklist = serializer1.Deserialize<List<NewWorkList>>(hdnLstGrp.Value);
        //}
        //Investigation_BL ibl=new Investigation_BL(base.ContextInfo);
        //result = ibl.SaveWorkList(OrgID, lstworklist, LocationID, searchType, LID, out worklistID);
        //txtWorklistID.Text = worklistID;
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "LoadWorkList", "LoadWorkList('" + worklistID + "');", true);
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:LoadWorkList();", true);
    }

    //public void LoadWorkList()
    //{
    //    try
    //    {
    //        int deptID = 0;
    //        fromVisit = txtFromVisit.Text == "" ? "0" : txtFromVisit.Text;
    //        toVisit = txtToVisit.Text == "" ? "0" : txtToVisit.Text;
    //        //int Client = Convert.ToInt32(ddlClients.SelectedValue);
    //        int Client = 0;
    //        string gUID = string.Empty;
    //        string IsIncludevalues = "N";
    //        long WorklistId = 0;
    //        string fromdate = txtFrom.Text;
    //        string todate = txtTo.Text;

    //        if (ddlDept.SelectedValue != "0")
    //        {
    //            deptID = Convert.ToInt32(ddlDept.SelectedValue);
    //        }
    //        //if (chkIsIncludevalues.Checked == true)
    //        //{
    //        //    IsIncludevalues = "Y";
    //        //}
    //        //else
    //        //{
    //        //    IsIncludevalues = "N";
    //        //}
    //        deptID = 0;
    //        if (txtWorklistID.Text.Trim() != string.Empty && txtWorklistID.Text.Trim() != "")
    //        {
    //            WorklistId = Convert.ToInt64(txtWorklistID.Text);
    //        }
    //        string searchType = ddlCultureType.SelectedItem.Text;

    //        if ((fromVisit != string.Empty && toVisit != string.Empty) || (txtFrom.Text != string.Empty && txtTo.Text != string.Empty))
    //        {
    //            long LocationID = Convert.ToInt64(ILocationID);
    //            int PriorityID = 0;
    //            string InvName = txtInvName.Text;
    //            intHistoryMode = ddlMode.SelectedValue;
    //            long result = -1;
    //            result = investigationBL.GetNewWorkListFromVisitToVisit(fromVisit.ToString(), toVisit.ToString(), OrgID, deptID, ILocationID
    //                , Client, LocationID, searchType, InvName, PriorityID, out lstWorkList, Convert.ToInt32(ddlVisitType.SelectedItem.Value),
    //                fromdate, todate, Convert.ToInt32(intHistoryMode), "View", LID, IsIncludevalues, ddlPreference.SelectedItem.Value, WorklistId);

    //            if (lstWorkList.Count > 0)
    //            {
    //                lblPrintHeader.Text = searchType + " Work Sheet";
    //                lblPrintLocation.Text = LocationName.ToString();
    //                lblPrintGeneratedBy.Text = LoginName.ToString();
    //                //lblPrintDateTime.Text = OrgDateTimeZone;
    //                DateTimeFormatInfo info = new CultureInfo("en-GB").DateTimeFormat;
    //                DateTime dt = Convert.ToDateTime(OrgDateTimeZone, info);
    //                string a = dt.ToString(DateTimeFormat);
    //                lblPrintDateTime.Text = a.ToString();
    //                if (lstWorkList[0].WorkListID != 0 && lstWorkList[0].WorkListID != null)
    //                {
    //                    lblPrintWorkListID.Text = lstWorkList[0].WorkListID.ToString();
    //                }
    //                tabPrintButton.Style.Add("display", "block");
    //                tblPrint.Style.Add("display", "block");
    //                lblStatus.Visible = false;

    //                if (searchType == "Urinalysis")
    //                {
    //                    //gvUrinalysis.DataSource = lstWorkList;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = true;

    //                    //gvBloodGroup.DataSource = null;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = false;

    //                    gvFecalysis.DataSource = null;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = false;

    //                    gvMicroSerology.DataSource = null;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = false;

    //                    gvWidal.DataSource = null;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = false;

    //                    gvVDRL.DataSource = null;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = false;
    //                }
    //                else if (searchType == "Blood Group")
    //                {
    //                    //gvBloodGroup.DataSource = lstWorkList;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = true;

    //                    //gvUrinalysis.DataSource = null;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = false;

    //                    gvFecalysis.DataSource = null;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = false;

    //                    gvMicroSerology.DataSource = null;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = false;

    //                    gvWidal.DataSource = null;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = false;

    //                    gvVDRL.DataSource = null;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = false;
    //                }
    //                else if (searchType == "Fecalysis")
    //                {
    //                    gvFecalysis.DataSource = lstWorkList;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = true;

    //                    //gvBloodGroup.DataSource = null;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = false;

    //                    //gvUrinalysis.DataSource = null;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = false;

    //                    gvMicroSerology.DataSource = null;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = false;

    //                    gvWidal.DataSource = null;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = false;

    //                    gvVDRL.DataSource = null;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = false;
    //                }
    //                else if (searchType == "Micro Serology")
    //                {
    //                    gvMicroSerology.DataSource = lstWorkList;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = true;

    //                    //gvBloodGroup.DataSource = null;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = false;

    //                    //gvUrinalysis.DataSource = null;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = false;

    //                    gvFecalysis.DataSource = null;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = false;

    //                    gvWidal.DataSource = null;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = false;

    //                    gvVDRL.DataSource = null;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = false;
    //                }
    //                else if (searchType == "Widal & Weil Felix")
    //                {
    //                    gvWidal.DataSource = lstWorkList;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = true;

    //                    //gvBloodGroup.DataSource = null;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = false;

    //                    //gvUrinalysis.DataSource = null;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = false;

    //                    gvFecalysis.DataSource = null;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = false;

    //                    gvMicroSerology.DataSource = null;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = false;

    //                    gvVDRL.DataSource = null;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = false;
    //                }
    //                if (searchType == "VDRL (RPR)")
    //                {
    //                    //gvUrinalysis.DataSource = null;
    //                    //gvUrinalysis.DataBind();
    //                    //gvUrinalysis.Visible = false;

    //                    //gvBloodGroup.DataSource = null;
    //                    //gvBloodGroup.DataBind();
    //                    //gvBloodGroup.Visible = false;

    //                    gvFecalysis.DataSource = null;
    //                    gvFecalysis.DataBind();
    //                    gvFecalysis.Visible = false;

    //                    gvMicroSerology.DataSource = null;
    //                    gvMicroSerology.DataBind();
    //                    gvMicroSerology.Visible = false;

    //                    gvWidal.DataSource = null;
    //                    gvWidal.DataBind();
    //                    gvWidal.Visible = false;

    //                    gvVDRL.DataSource = lstWorkList;
    //                    gvVDRL.DataBind();
    //                    gvVDRL.Visible = true;
    //                }
    //                else
    //                {

    //                }
    //            }
    //            else
    //            {
    //                tabPrintButton.Style.Add("display", "none");
    //                tblPrint.Style.Add("display", "none");
    //                lblStatus.Visible = true;
    //                lbltxtSTR.Visible = false;

    //                //gvUrinalysis.DataSource = null;
    //                //gvUrinalysis.DataBind();
    //                //gvUrinalysis.Visible = false;

    //                gvMicroSerology.DataSource = null;
    //                gvMicroSerology.DataBind();
    //                gvMicroSerology.Visible = false;

    //                //gvBloodGroup.DataSource = null;
    //                //gvBloodGroup.DataBind();
    //                //gvBloodGroup.Visible = false;

    //                gvWidal.DataSource = null;
    //                gvWidal.DataBind();
    //                gvWidal.Visible = false;

    //                //gvBloodGroup.DataSource = null;
    //                //gvBloodGroup.DataBind();
    //                //gvBloodGroup.Visible = false;

    //                gvVDRL.DataSource = null;
    //                gvVDRL.DataBind();
    //                gvVDRL.Visible = false;
    //            }

    //        }
    //        else
    //        {
    //            tabPrintButton.Style.Add("display", "none");
    //            tblPrint.Style.Add("display", "none");
    //            lblStatus.Visible = true;
    //            lbltxtSTR.Visible = false;
    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //    }
    //}

    public void LoadPriority()
    {
        try
        {
            long returncode = -1;
            string domains = "Preference";
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


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {

                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Preference"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlPreference.DataSource = childItems;
                    ddlPreference.DataTextField = "DisplayText";
                    ddlPreference.DataValueField = "Code";
                    ddlPreference.DataBind();
                }

            }
            //}
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Despatch Status ", ex);
            //edisp.Visible = true;

        }

    }

    protected void btnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        //export to excel
        string attachment = "attachment; filename=Reports.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
        prnReport.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}