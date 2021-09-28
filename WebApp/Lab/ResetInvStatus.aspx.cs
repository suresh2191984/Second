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
public partial class Lab_ResetInvStatus : BasePage
{



    #region Initialization
    long pSCMID = -1;
   
    string fileName = string.Empty;
    string Formula = string.Empty;
    string FormulaINV = string.Empty;
    Control myControl = null;
    List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
    List<PatientInvestigation> lstdummyOrdered = new List<PatientInvestigation>();
    List<InvestigationStatus> header = new List<InvestigationStatus>();
    List<PatientInvestigation> lstInvFiles = new List<PatientInvestigation>();
    // bool Selected = false;
    long vid = 0;
    // long lresult = -1;
    // bool valid = false;

    List<InvestigationValues> lstHemat1 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat2 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat3 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat4 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat5 = new List<InvestigationValues>();
    List<InvestigationValues> lstHemat6 = new List<InvestigationValues>();
    List<InvestigationValues> lstFluid = new List<InvestigationValues>();
    List<InvestigationValues> lstWidel = new List<InvestigationValues>();
    List<InvestigationValues> lstCast = new List<InvestigationValues>();
    List<InvestigationValues> lstDiff = new List<InvestigationValues>();
    List<InvestigationValues> lstclinic12 = new List<InvestigationValues>();
    List<InvestigationValues> lstclinic13 = new List<InvestigationValues>();
    List<InvestigationValues> lstANA = new List<InvestigationValues>();

    List<InvestigationValues> lstMicBioPattern1 = new List<InvestigationValues>();
    List<InvestigationValues> lstFACellsPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAChemistryPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAImmunologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFACytologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFSmearPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstBodyFluid = new List<InvestigationValues>();
    List<InvestigationValues> lstSmearReport = new List<InvestigationValues>();
    List<InvestigationValues> lstSemenanalysisnew = new List<InvestigationValues>();
    ArrayList lstControl = new ArrayList();
    ArrayList lstpatternID = new ArrayList();
    Hashtable hFormulaCollection = new Hashtable();
    Hashtable hStatusCollection = new Hashtable();
    Hashtable hFormulaInvCollectionSet = new Hashtable();
    Hashtable hGroupFormulaCollection = new Hashtable();

    Hashtable hIFormulaCollection = new Hashtable();
    Hashtable hInvestigationFormulaCollection = new Hashtable();
    #endregion

    string reportName = string.Empty;
    string reportPath = string.Empty;
   
    string reportID = string.Empty;
   
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();

    Investigation_BL InvestigationBL;

    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
    Investigation_BL objInvBL;
    List<PatientInvestigation> lstpatinvestigation = new List<PatientInvestigation>();
    List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();
    string gUID = string.Empty;
    
    string AllowAutoApproveTask = string.Empty;
    long returncode = -1;
    WebService objWS = new WebService();

    //static int countOutOfRange = 0;
    
    System.Text.StringBuilder sJsFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsINVFuntion = new System.Text.StringBuilder();
    string LabNo = string.Empty;
    string strLabTechToEditMedRem = "";
    string VisitIDs = "0";
    string InvType = string.Empty;
    string InvName = string.Empty;
    long worklistid = 0;
    
    long deviceid = 0;
    string isAbnormalResult = "0";
    long headerID = 0;
    long protocalID = 0;
    int deptID = 0;
    string isMaster = "N";
    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
    protected void Page_Load(object sender, EventArgs e)
    {
        {
            InvestigationBL = new Investigation_BL(base.ContextInfo);
            objInvBL = new Investigation_BL(base.ContextInfo);

            try
            {

                GateWay gateWay = new GateWay(base.ContextInfo);

                List<Config> lstConfig = new List<Config>();


                strLabTechToEditMedRem = GetConfigValues("CanLabTechEditMedRem", OrgID);
                hdnstatuschange.Value = GetConfigValues("StatusChangeByOrg", OrgID);
                


                ClientScriptManager cs = Page.ClientScript;
                String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "ValidateUserResult", "", "ProcessCallBackError", false);
                String callBackScript = "function ValidateToXml(arg) {" + callBackReference + "; }";
                cs.RegisterClientScriptBlock(this.GetType(), "CallXmlValidation", callBackScript, true);
                sJsFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKGroupSum(id){ try { ");
                sJsINVFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKINVSum(){");

                hdnOrgID.Value = OrgID.ToString();


                List<Config> lstConfigs = new List<Config>();
                returncode = gateWay.GetConfigDetails("IsDeltaCheck", OrgID, out lstConfigs);

                if (lstConfigs != null && lstConfigs.Count > 0)
                {
                    foreach (string str in lstConfigs[0].ConfigValue.Split(','))
                    {
                        if (RoleName.Trim() == str.Trim())
                        {
                            hdnIsDeltaCheckWant.Value = "true";
                            break;
                        }
                    }
                }
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
                    returncode = objInvBL.GetBatchWiseDropDownValues(OrgID, oLoginDetail, out lstInstrumentMaster, out lstDeptMaster, out lstInvHeaderMaster, out lstProtocolGroupMaster);

                    ddlInstrument.DataSource = lstInstrumentMaster;
                    ddlInstrument.DataTextField = "InstrumentName";
                    ddlInstrument.DataValueField = "InstrumentID";
                    ddlInstrument.DataBind();
                    ddlInstrument.Items.Insert(0, "---Select---");
                    ddlInstrument.Items[0].Value = "0";

                    ddlDept.DataSource = lstDeptMaster;
                    ddlDept.DataTextField = "DeptName";
                    ddlDept.DataValueField = "DeptID";
                    ddlDept.DataBind();
                    ddlDept.Items.Insert(0, "---Select---");
                    ddlDept.Items[0].Value = "0";

                    ddlHeader.DataSource = lstInvHeaderMaster;
                    ddlHeader.DataTextField = "HeaderName";
                    ddlHeader.DataValueField = "HeaderID";
                    ddlHeader.DataBind();
                    ddlHeader.Items.Insert(0, "---Select---");
                    ddlHeader.Items[0].Value = "0";

                    ddlProtocol.DataSource = lstProtocolGroupMaster;
                    ddlProtocol.DataTextField = "DisplayText";
                    ddlProtocol.DataValueField = "MetadataID";
                    ddlProtocol.DataBind();
                    ddlProtocol.Items.Insert(0, "---Select---");
                    ddlProtocol.Items[0].Value = "0";
                }
                //else
                //{
                if (Request.QueryString["vids"] != null)
                {
                    VisitIDs = Request.QueryString["vids"];
                }
                if (Request.QueryString["InvName"] != null)
                {
                    InvName = Request.QueryString["InvName"];
                }
                if (Request.QueryString["InvType"] != null)
                {
                    InvType = Request.QueryString["InvType"];
                }
                if (Request.QueryString["worklistid"] != null)
                {
                    worklistid = Convert.ToInt64(Request.QueryString["worklistid"]);
                }
                if (Request.QueryString["deviceid"] != null)
                {
                    deviceid = Convert.ToInt64(Request.QueryString["deviceid"]);
                    if (ddlInstrument.Items.FindByValue(deviceid.ToString()) != null)
                    {
                        if (!IsPostBack)
                        {
                            ddlInstrument.SelectedValue = deviceid.ToString();
                        }
                    }
                }

                if (Request.QueryString["Action"] != null)
                {
                    hdnActionName.Value = Request.QueryString["Action"];
                }
                if (Request.QueryString["deptid"] != null)
                {
                    Int32.TryParse(Request.QueryString["deptid"], out deptID);
                    if (ddlDept.Items.FindByValue(deptID.ToString()) != null)
                    {
                        if (!IsPostBack)
                        {
                            ddlDept.SelectedValue = deptID.ToString();
                        }
                    }
                }
                if (Request.QueryString["headerid"] != null)
                {
                    Int64.TryParse(Request.QueryString["headerid"], out headerID);
                    if (ddlHeader.Items.FindByValue(headerID.ToString()) != null)
                    {
                        if (!IsPostBack)
                        {
                            ddlHeader.SelectedValue = headerID.ToString();
                        }
                    }
                }
                if (Request.QueryString["protocalid"] != null)
                {
                    Int64.TryParse(Request.QueryString["protocalid"], out protocalID);
                    if (ddlProtocol.Items.FindByValue(protocalID.ToString()) != null)
                    {
                        if (!IsPostBack)
                        {
                            ddlProtocol.SelectedValue = protocalID.ToString();
                        }
                    }
                }
                if (Request.QueryString["ismaster"] != null)
                {
                    isMaster = Request.QueryString["ismaster"];
                    if (!IsPostBack)
                    {
                        chkIsMaster.Checked = isMaster == "Y" ? true : false;
                    }
                }

                if (hdnActionName.Value == "Validate")
                {
                   
                    hdnDefaultDropDownStatus.Value = "Validate";
                }
                //if (!IsPostBack)
                // {
                LoadPatterns();
                //}
                //}
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
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
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {

        string FromVID = "0";
        string ToVID = "0";
        VisitIDs = "0";
        InvName = "";
        InvType = "";
        worklistid = 0;
        deviceid = 0;
        isAbnormalResult = "0";
        deptID = 0;
        headerID = 0;
        protocalID = 0;
        isMaster = "N";
        try
        {
            if (txtFromVisitID.Text.Trim() != "")
            {
                FromVID = txtFromVisitID.Text;
            }
            if (txtToVisitID.Text.Trim() != "")
            {
                ToVID = txtToVisitID.Text;
            }
            if (string.IsNullOrEmpty(txtInvestigationName.Text))
            {
                InvName = "";
                InvType = "";
                hdnTestName.Value = "";
                hdnTestType.Value = "";
            }
            if (hdnTestName.Value != "")
            {
                InvName = hdnTestName.Value;
                InvType = hdnTestType.Value;
            }
            if (txtWorkListID.Text.Trim() != "")
            {
                worklistid = Convert.ToInt64(txtWorkListID.Text);
            }
            if (FromVID != "0" && ToVID != "0")
            {
                if (ToVID == FromVID)
                {
                    VisitIDs = FromVID + "," + FromVID;
                }
                else
                {
                    VisitIDs = FromVID + "," + ToVID;
                }
            }
            else if (FromVID != "0")
            {
                VisitIDs = FromVID + "," + FromVID;
            }
            else if (ToVID != "0")
            {
                VisitIDs = ToVID + "," + FromVID;
            }
            else
            {
                VisitIDs = "0";
            }
            if (txtInvestigationName.Text != "" && txtInvestigationName.Text != null)
            {
                InvName = txtInvestigationName.Text;
                InvType = hdnTestType.Value;
            }
            Int64.TryParse(ddlInstrument.SelectedValue, out deviceid);

            Int32.TryParse(ddlDept.SelectedValue, out deptID);
            Int64.TryParse(ddlHeader.SelectedValue, out headerID);
            Int64.TryParse(ddlProtocol.SelectedValue, out protocalID);
            isMaster = chkIsMaster.Checked ? "Y" : "N";

            Response.Redirect(Request.ApplicationPath + "/Lab/ResetInvStatus.aspx?vids=" + VisitIDs + "&InvType=" + InvType + "&InvName=" + InvName + "&worklistid=" + worklistid + "&deviceid=" + deviceid + "&isabnormal=" + isAbnormalResult + "&Action=" + hdnActionName.Value + "&deptid=" + deptID + "&headerid=" + headerID + "&protocalid=" + protocalID + "&ismaster=" + isMaster, true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnBatchSearch_Click at BatchWiseEnterResult Page", ex);
        }

    }
    public void LoadPatterns()
    {

        LoginDetail objLoginDetail = new LoginDetail();
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        try
        {
            if ((VisitIDs != "0" && VisitIDs != "0,0") || InvName != "" || worklistid != 0 || deviceid != 0 || deptID != 0 || headerID != 0 || protocalID != 0)
            {
                btnsave.Visible = true;
                returncode = InvestigationBL.GetInvStatusLoad(VisitIDs, OrgID, RoleID, deptID, InvName, InvType, objLoginDetail, "N", worklistid, deviceid, isAbnormalResult, headerID, protocalID, hdnActionName.Value, isMaster, out lstOrdered);
                if (lstOrdered.Count <= 0)
                {
                    datalist.Visible = false;
                    btnsave.Visible = false;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Results found');", true);
                }
                else
                {
                    datalist.DataSource = lstOrdered;
                    datalist.DataBind();
                    hdnloadedvalues.Value = Convert.ToString(lstOrdered.Count());
                }

            }


        }




        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPatterns", ex);
        }
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string PatientInvdS = hdnvalues.Value;
            List<PatientInvestigation> lstPatientids = new List<PatientInvestigation>();

            lstPatientids = serializer.Deserialize<List<PatientInvestigation>>(hdnvalues.Value);
            Investigation_BL objInv = new Investigation_BL();
            returncode = objInv.UpdateInvStatus(lstPatientids, OrgID);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Unloaded Successfully');", true);
            LoadPatterns();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPatterns", ex);
        }

    }

}
