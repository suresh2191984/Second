using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;
using ReportingService;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Text;

public partial class Lab_Pendinglist : BasePage
{
    List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();

    Investigation_BL InvestigationBL;
    long returncode = -1;
    String JqueryTable = String.Empty;
    String ConfigOrg = String.Empty;
    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
    /* Resources Added By Venkatesh S*/
    string strSelect = Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_15 == null ? "---Select---" : Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_15;
    string strresult = Resources.Lab_AppMsg.Lab_Pendinglist_aspx_result == null ? "No Results found" : Resources.Lab_AppMsg.Lab_Pendinglist_aspx_result;
    string AlertType = Resources.Lab_AppMsg.Lab_Pendinglist_aspx_01 == null ? "Alert" : Resources.Lab_AppMsg.Lab_Pendinglist_aspx_01;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072 == null ? "M" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073 == null ? "F" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073;
    public Lab_Pendinglist()
        : base("Lab_Pendinglist_aspx")
    {

    }
    int checkOrgid;
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        {
            InvestigationBL = new Investigation_BL(base.ContextInfo);
            JqueryTable = GetConfigValue("JqueryDataTable", OrgID);
            ConfigOrg = GetConfigValue("ConfigOrgId", OrgID);

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "CheckAllCheckbox", "CheckAllCheckbox();", true);
            try
            {
                if (!IsPostBack)
                {
                    AutoInvestigations.ContextKey = OrgID.ToString();
                    List<InvInstrumentMaster> lstInstrumentMaster = new List<InvInstrumentMaster>();
                    List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
                    List<InvestigationHeader> lstInvHeaderMaster = new List<InvestigationHeader>();
                    List<MetaDataOrgMapping> lstProtocolGroupMaster = new List<MetaDataOrgMapping>();
                    LoginDetail oLoginDetail = new LoginDetail();
                    oLoginDetail.LoginID = LID;
                    oLoginDetail.RoleID = RoleID;
                    oLoginDetail.Orgid = OrgID;

                    returncode = InvestigationBL.GetBatchWiseDropDownValues(OrgID, oLoginDetail, out lstInstrumentMaster, out lstDeptMaster, out lstInvHeaderMaster, out lstProtocolGroupMaster);

                    ddlInstrument.DataSource = lstInstrumentMaster;
                    ddlInstrument.DataTextField = "InstrumentName";
                    ddlInstrument.DataValueField = "InstrumentID";
                    ddlInstrument.DataBind();
                    ddlInstrument.Items.Insert(0, strSelect.Trim());
                    ddlInstrument.Items[0].Value = "0";

                    ddlProtocol.DataSource = lstProtocolGroupMaster;
                    ddlProtocol.DataTextField = "DisplayText";
                    ddlProtocol.DataValueField = "MetadataID";
                    ddlProtocol.DataBind();
                    ddlProtocol.Items.Insert(0, strSelect.Trim());
                    ddlProtocol.Items[0].Value = "0";

                    hdnSelectedValue.Value = "SampleReceived,SampleLoaded,Pending";
                    txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
                    txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");

                    txtFrom.Text = OrgTimeZone + " 12:00:00 AM";
                    txtTo.Text = OrgDateTimeZone;
                    BindDepartName();
                    LoadMeatData();
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
            }
        }
    }
    #endregion
    #region "Events"
    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LoadPatterns();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnBatchSearch_Click at ResetInvStatus Page", ex);
        }

    }
    protected void grdresult_PreRender(object sender, EventArgs e)
    {

    }
    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            ExportToExcel();
        }
        catch (Exception ex)
        {
        }
    }
    protected void grdresult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (ConfigOrg == "Y")//Orgid=98 is Y others N  Anderson Diagnostics & Labs. 
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[9].Text = "Test Details";
            }
            e.Row.Cells[7].Attributes.Add("style", "display:none");
            if (e.Row.Cells.Count > 1)
            {

            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblWLID = (Label)e.Row.FindControl("lblWLID");
                if (lblWLID.Text == "0")
                {
                    lblWLID.Text = "-";
                }
            }
        }
        else
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[9].Text = "Group / Package Name";
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Cells[10].Style.Add("display", "none");//e.Row.Cells[10].Visible = false;
                Label lblWLID = (Label)e.Row.FindControl("lblWLID");
                if (lblWLID.Text == "0")
                {
                    lblWLID.Text = "-";
                }
            }
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            ExportToExcel();
        }
        catch (Exception ex)
        {
        }
    }

    #endregion
    #region "Methods"
    public void LoadPatterns()
    {

        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        string pStatus = hdnSelectedValue.Value;
        long InvID = 0;
        string InvType = string.Empty;
        long protocalID = 0;
        long deviceid = 0;
        long pDeptid = 0;
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            if (hdnTestID.Value != "")
            {
                Int64.TryParse(hdnTestID.Value, out InvID);
                InvType = hdnTestType.Value;
            }
            else
            {
                InvID = 0;
                InvType = "";
                hdnTestID.Value = "";
                hdnTestType.Value = "";
            }
            if (hdnSelectedValue.Value != "")
            {
                pStatus = hdnSelectedValue.Value;
            }

            Int64.TryParse(ddlProtocol.SelectedValue, out protocalID);
            Int64.TryParse(ddlInstrument.SelectedValue, out deviceid);
            Int64.TryParse(ddldepartment.SelectedValue, out pDeptid);
            if (InvID != 0 || deviceid != 0 || protocalID != 0 || txtFrom.Text != "" || txtTo.Text != "" || pDeptid != 0)
            {
                DateTime fromdate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime todate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                if (txtFrom.Text != "")
                {
                    fromdate = Convert.ToDateTime(txtFrom.Text);
                }
                if (txtTo.Text != "")
                {
                    string temptodate = string.Empty;
                    temptodate = txtTo.Text;
                    todate = Convert.ToDateTime(temptodate);
                }
                string IsStat = "0";
                if (ChkISSTAT.Checked)
                {
                    IsStat = "Y";
                }
                string IsGroupLeave = "0";
                if (chkGroup.Checked)
                {
                    IsGroupLeave = "Y";
                }
                else
                {
                    IsGroupLeave = "N";
                }
                if (JqueryTable == "Y")
                {

                    ScriptManager.RegisterClientScriptBlock(this.Page, GetType(), "LoadPendingList", "fnGetPendingList('"
                        + OrgID + "','" + RoleID + "','" + InvID + "','" + InvType + "','" + LID + "','"
                        + "N" + "','" + deviceid + "','" + protocalID + "','" + fromdate + "','" + todate + "','" + pStatus + "','"
                        + IsStat + "','" + pDeptid + "','" + IsGroupLeave + "');", true);
                    grdresult.Visible = false;
                    pnlDept.Visible = true;
                    if (ddlProtocol.SelectedValue != "0")
                    {
                        lblprotocalvalue.Text = ddlProtocol.SelectedItem.Text;
                    }
                    else
                    {
                        lblprotocalvalue.Text = "-";
                    }
                    if (ddlInstrument.SelectedValue != "0")
                    {
                        lblAnalyzerName.Text = ddlInstrument.SelectedItem.Text;
                    }
                    else
                    {
                        lblAnalyzerName.Text = "-";
                    }
                    if (txtFrom.Text != "" && txtTo.Text != "")
                    {
                        lblFromNTodateValue.Text = txtFrom.Text + " & " + txtTo.Text;
                    }

                }
                else
                {

                    returncode = InvestigationBL.GetPendingList(OrgID, RoleID, InvID, InvType, objLoginDetail, "N", deviceid,
                        protocalID, fromdate, todate, pStatus, IsStat, pDeptid, IsGroupLeave, out lstOrdered);

                    if (lstOrdered.Count > 0)
                    {
                        for (int i = 0; i < lstOrdered.Count; i++)
                        {
                            if (!String.IsNullOrEmpty(lstOrdered[i].Age) && lstOrdered[i].Age.Length > 0)
                            {
                                string str = lstOrdered[i].Age;
                                string[] strage = str.Split('/');
                                string[] strage1 = strage[0].Split(' ');
                                if (strage1[1] == "Year(s)")
                                {
                                    lstOrdered[i].Age = strage1[0] + " " + strYear + " / " + strage[1];
                                }
                                else if (strage1[1] == "Month(s)")
                                {
                                    lstOrdered[i].Age = strage1[0] + " " + strMonth + " / " + strage[1];
                                }
                                else if (strage1[1] == "Day(s)")
                                {
                                    lstOrdered[i].Age = strage1[0] + " " + strDay + " / " + strage[1];
                                }
                                else if (strage1[1] == "Week(s)")
                                {
                                    lstOrdered[i].Age = strage1[0] + " " + strWeek + " / " + strage[1];
                                }
                                else
                                {
                                    lstOrdered[i].Age = strage1[0] + " " + strYear + " / " + strage[1];
                                }
                            }
                        }
                    }
                    if (lstOrdered.Count <= 0)
                    {
                        grdresult.Visible = false;
                        pnlDept.Visible = false;
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Results found');", true);
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + strresult + "','" + AlertType + "');", true);

                    }
                    else
                    {
                        lbldate.Text = OrgDateTimeZone;
                        pnlDept.Visible = true;
                        grdresult.Visible = true;
                        grdresult.DataSource = lstOrdered;
                        grdresult.DataBind();
                        lblg.Text = lstOrdered[0].Loginname;
                        if (ddlProtocol.SelectedValue != "0")
                        {
                            lblprotocalvalue.Text = ddlProtocol.SelectedItem.Text;
                        }
                        else
                        {
                            lblprotocalvalue.Text = "-";
                        }
                        if (ddlInstrument.SelectedValue != "0")
                        {
                            lblAnalyzerName.Text = ddlInstrument.SelectedItem.Text;
                        }
                        else
                        {
                            lblAnalyzerName.Text = "-";
                        }
                        if (txtFrom.Text != "" && txtTo.Text != "")
                        {
                            lblFromNTodateValue.Text = txtFrom.Text + " & " + txtTo.Text;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPatterns", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    public void ExportToExcel()
    {
        try
        {
            if (grdresult.Rows.Count > 0)
            {
                Response.ClearContent();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "PendingList" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("ddMMyyyyHHMMss") + ".xls"));
                Response.ContentType = "application/ms-excel";
                StringWriter sw = new StringWriter();
                HtmlTextWriter htw = new HtmlTextWriter(sw);

                //Change the Header Row back to white color
                grdresult.HeaderRow.Style.Add("background-color", "#FFFFFF");
                //Applying stlye to gridview header cells
                for (int i = 0; i < grdresult.HeaderRow.Cells.Count; i++)
                {
                    grdresult.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
                }
                Listddetails.RenderControl(htw);
                grdresult.RenderControl(htw);
                Response.Write(sw.ToString());
                Response.End();
            }
        }
        catch (Exception ex)
        {
        }
    }
    public void BindDepartName()
    {
        try
        {
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
            ObjInv.getOrgDepartName(OrgID, out ObjInvDep);
            ddldepartment.DataSource = ObjInvDep;
            ddldepartment.DataTextField = "DeptName";
            ddldepartment.DataValueField = "DeptID";
            ddldepartment.DataBind();
            ddldepartment.Items.Insert(0, strSelect.Trim());
            ddldepartment.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Department", ex);
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
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "Pendinglist";
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
                                 where child.Domain == "Pendinglist"
                                 select child;
                if (childItems.Count() > 0)
                {
                    chkStatus.DataSource = childItems;
                    chkStatus.DataTextField = "DisplayText";
                    chkStatus.DataValueField = "Code";
                    chkStatus.DataBind();
                    chkStatus.Items.Remove((chkStatus.Items.FindByText("Recollect"))); /*added by jagatheesh*/
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    #endregion
}
