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
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.IO;
using ReportingService;
using System.Security.Cryptography;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using Attune.Podium.BillingEngine;
using Attune.Podium.PerformingNextAction;
using System.Web.Script.Serialization;
using System.Web.Services;
using FredCK.FCKeditorV2;

public partial class Investigation_InvestigationApprovelOrHoldNew : BasePage, System.Web.UI.ICallbackEventHandler
{
    public Investigation_InvestigationApprovelOrHoldNew()
        : base("Investigation_Investigation_InvestigationApprovelOrHoldNew_aspx")
    {
    }




    #region Initialization

    //  UserControl BioControl = null;
    //Control HematControl = null;
    // int PatternID = 0;
    string fileName = string.Empty;

    Control myControl = null;
    List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
    List<InvestigationStatus> header = new List<InvestigationStatus>();
    List<InvestigationStatus> header1 = new List<InvestigationStatus>();
    List<PatientInvestigation> lstInvFiles = new List<PatientInvestigation>();
    List<InvestigationValues> DemoBulk, lstPendingValue, lstPendingval = new List<InvestigationValues>();
    List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    List<PatientInvestigation> lstPatientInvestigation3 = new List<PatientInvestigation>();
    // bool Selected = false;
    long vid = 0;
    string LabNo = string.Empty;
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
    List<InvestigationValues> lstBodyFluidAnalysisPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstSmearPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstSemenAnalysisNewPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAChemistryPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFAImmunologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFACytologyPattern = new List<InvestigationValues>();
    List<InvestigationValues> lstFSmearPattern = new List<InvestigationValues>();
    Investigation_BL DemoBL;
    List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
    List<OrderedInvestigations> lstorderInvforVisit = new List<OrderedInvestigations>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    ArrayList lstControl = new ArrayList();
    ArrayList lstpatternID = new ArrayList();

    #endregion
    int PageSize = 1;
    int totalRows = 0;
    int totalpage = 0;
    int totrowno = 0;
    long pSCMID = -1;
    bool BtnSavePreview = false;
    string reportName = string.Empty;
    string reportPath = string.Empty;
    long patientVisitID = 0;
    string reportID = string.Empty;
    string investigatgionID = string.Empty;
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();
    List<InvDeptMaster> lstDpts = new List<InvDeptMaster>();
    Investigation_BL InvestigationBL;
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
    List<PerformingPhysician> lPerformingPhysicain = new List<PerformingPhysician>();
    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
    List<PatientVisit> visitList = new List<PatientVisit>();
    List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    List<Users> lstSecondOpinionUser = new List<Users>();
    List<long> lstCoauthorizeUser = new List<long>();
    List<long> lstSelectedOpinionUser = new List<long>();
    List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();
    bool isValidate = false;
    bool isCoauthorize = false;
    bool isReceivedOpinion = false;
    bool isWithholdValidation = false;
    bool isWithholdApproval = false;

    Patient_BL patientBL;
    string chktempStatus = string.Empty;
    string chkNextStatus = string.Empty;
    string gUID = string.Empty;
    string gUIDTemp = string.Empty;
    string chkStatus = string.Empty;
    string RId = string.Empty;
    bool isCompleted = false;
    string InvIDs = "";
    long pVisitID = 0;
    long pid = -1;
    long returnCode = -1;
    int AutoApproveQueueCount = 0;
    int NormalApproveTestCount = 0;
    public int IsAutoAuthRecollect = 0;
    Hashtable hFormulaCollection = new Hashtable();
    Hashtable hIFormulaCollection = new Hashtable();
    System.Text.StringBuilder sJsFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsINVFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntionEmptyValue = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntion = new System.Text.StringBuilder();
    string Formula = string.Empty;
    //string GUID = Guid.NewGuid().ToString();
    //string rawData, textColor, panicTextColor, AutoAuthorizColor;
    string rawData, textColor, RangeCode;
    string AllowAutoApproveTask = string.Empty;
    string FormulaINV = string.Empty;
    string strLabTechToEditMedRem = "";
    string strSingleReferenceRange = "";
    string Appvalue = string.Empty;
    long Apptaskid = -1;
    string accessionnumber = string.Empty;
    Array pAgeRaw;
    string AgeDays = "0";
    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
    List<PatientInvestigation> lstInvestigationValuesforAlert = new List<PatientInvestigation>();
    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    #endregion
string FilePath = string.Empty;
    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        string strName = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_22 == null ? "Name :" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_22;
        string strAge = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_23 == null ? "Age :" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_23;
        string strPatientNo = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_24 == null ? "Patient No :" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_24;
        string strSex = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_25 == null ? "Sex :" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_25;
        string strMale = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_26 == null ? "Male" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_26;
        string strFemale = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_27 == null ? "Female" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_27;
        DemoBL = new Investigation_BL(base.ContextInfo);
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        patientBL = new Patient_BL(base.ContextInfo);
        int TaskID = 0;
        try
        {
            if (Request.QueryString["tid"] != null)
            {
                Int32.TryParse(Request.QueryString["tid"].ToString(), out TaskID);
            }
            if (TaskID == 0)
            {
                btsaveandnext.Style.Add("display", "inline");
                btnbtmsavennext.Style.Add("display", "inline");
				 if (RoleName == "Physician Assistant")
                {
                    btsaveandnext.Style.Add("display", "none");
                    btnbtmsavennext.Style.Add("display", "none");
                }
            }
            else
            {
                btsaveandnext.Style.Add("display", "none");
                btnbtmsavennext.Style.Add("display", "none");
            }
            string DisableContinueButton = GetConfigValues("DisableResultCaptureContinueButton", OrgID);
            string showslides = GetConfigValues("showslides", OrgID);
            string showSavePreviewBtn = GetConfigValues("NeedSavePreviewbtn", OrgID);
            if (showslides == "Y")
            {
                lnkslide.Visible = true;

            }
            else
            {
                lnkslide.Visible = false;

            }

            FilePath = GetConfigValues("TabularPattern_FilePath", OrgID);

            if (!string.IsNullOrEmpty(FilePath))
            {
                if (!Directory.Exists(FilePath))
                {
                    Directory.CreateDirectory(FilePath);
                }
            }

            if (showSavePreviewBtn == "Y" && RoleName == "Doctor" || RoleName == RoleHelper.Pathologist)
            {
                btnSavePreview.Visible = true;
                btnSavePreview1.Visible = true;
            }
            //DataTable dt = new DataTable();
            //dt.Columns.AddRange(new DataColumn[] { new DataColumn("Date"), new DataColumn("Investigation Name"), new DataColumn("Value"), new DataColumn("Reference Range"), new DataColumn("Comments"), new DataColumn("Investigation Status") });
            //grdBetaCheckUp.DataSource = dt;
            //grdBetaCheckUp.DataBind();
            //////////////////////////////////string DisableContinueButton = GetConfigValues("DisableResultCaptureContinueButton", OrgID);
            LoadRangeColor();
            if (Request.QueryString["RNo"] != null)
            {
                RId = Request.QueryString["RNo"].ToString();
            }

            if (Request.QueryString["POrgID"] != null)
            {
                int orgid = 0;
                Int32.TryParse(Request.QueryString["POrgID"].ToString(), out orgid);
                hdnOrgID.Value = orgid.ToString();

            }
            else
            {
                hdnOrgID.Value = OrgID.ToString();
            }
            if (Request.QueryString["apptype"] != null)
            {
                Appvalue = Request.QueryString["apptype"].ToString();
                if (Appvalue == "Yes")
                {
                    trsaveorg.Style.Add("display", "none");
                    trbottom.Style.Add("display", "none");

                }
                else
                {
                    trsaveorg.Style.Add("display", "table-row");
                    trbottom.Style.Add("display", "table-row");

                    if (!String.IsNullOrEmpty(DisableContinueButton) && DisableContinueButton == "Y")
                    {
                        trsavecontinue.Visible = false;
                        trbottomsavecontinue.Visible = false;
                    }

                }
            }
            else
            {

                if (!String.IsNullOrEmpty(DisableContinueButton) && DisableContinueButton == "Y")
                {
                    trsavecontinue.Visible = false;
                    trbottomsavecontinue.Visible = false;
                }
            }
            if (!IsPostBack)
            {
                String ShowLabReportPreview = GetConfigValues("ShowLabReportPreview", OrgID);
                if (ShowLabReportPreview == "Y")
                {
                    tblPDFReportViewer.Style.Add("display", "table");
                    tblSSRSReportPreview.Style.Add("display", "none");
                }
                else
                {
                    tblPDFReportViewer.Style.Add("display", "none");
                    tblSSRSReportPreview.Style.Add("display", "table");
                }
            }
            long returnCode;
            GateWay gateWay = new GateWay(base.ContextInfo);
            //List<Config> lstConfig = new List<Config>();
            //returnCode = gateWay.GetConfigDetails("IsDeltaCheck", Convert.ToInt32(hdnOrgID.Value), out lstConfig);

            //if (lstConfig != null && lstConfig.Count > 0)
            //{
            //    foreach (string str in lstConfig[0].ConfigValue.Split(','))
            //    {
            //        if (RoleName.Trim() == str.Trim())
            //        {
            ViewTRF.Attributes.Add("style", "display:block");
            tblViewPreviewTRF.Style.Add("display", "table");
            hdnIsDeltaCheckWant.Value = "true";
            //            break;
            //        }
            //    }
            //}

            strLabTechToEditMedRem = GetConfigValues("CanLabTechEditMedRem", OrgID);
            hdnstatuschange.Value = GetConfigValues("StatusChangeByOrg", OrgID);
            hdnIscommonValidation.Value = GetConfigValues("EnterResultCommonValidation", OrgID);
            if (strLabTechToEditMedRem == "N" && RoleName == "Lab Technician")
            {
                txtGrpCommentMed.ReadOnly = true;
            }
            else
            {
                txtGrpCommentMed.ReadOnly = false;
            }

            //To check whether to take reference range values are taken from Ref.Range Mgmt (or) Test Master - Start
            strSingleReferenceRange = GetConfigValues("SingleReferenceRange", OrgID);
            //-End

            if ((Request.QueryString["LNo"] != null) && (Request.QueryString["LNO"] != ""))
            {
                LabNo = Request.QueryString["LNo"].ToString();
            }
            ClientScriptManager cs = Page.ClientScript;
            String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "TaskOpenJs", "", "ProcessCallBackError", false);
            String callBackScript = "function ValidateUserExit(arg) {" + callBackReference + "; }";
            cs.RegisterClientScriptBlock(this.GetType(), "CallUserNavigateValidation", callBackScript, true);
            sJsFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKGroupSum(id){");
            sJsINVFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKINVSum(){");
            sJsSaveValidationFuntion.Append("<script language ='javascript' type ='text/javascript'>function CheckSaveValidationFuntion(){ try { ");

            ClientScriptManager cs1 = Page.ClientScript;
            String callBackReference1 = cs1.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "ValidateUserResult", "", "ProcessCallBackError", false);
            String callBackScript1 = "function ValidateToXml(arg) {" + callBackReference1 + "; }";
            cs1.RegisterClientScriptBlock(this.GetType(), "CallXmlValidation", callBackScript1, true);

            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
                // Int32.TryParse(Request.QueryString["dID"].ToString(), out deptID);
                hdnVID.Value = vid.ToString();
                pnlSerch.Visible = false;
                hdnPatientVisitID.Value = vid.ToString();
                string invStatus = "all";// InvStatus.Pending.ToLower() + "," + InvStatus.Completed.ToLower() + "," + InvStatus.Validate.ToLower() + "," + InvStatus.Approved.ToLower() + "," + InvStatus.SecondOpinion.ToLower() + "," + InvStatus.ReceivedOpinion.ToLower() + ",Co-authorize";
                lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + vid + "','" + RoleID + "','" + invStatus + "');return false;");
            }
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
                gUIDTemp = Request.QueryString["gUID"].ToString();
            }
            if (Request.QueryString["pid"] != null)
            {
                Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
            }

            if (txtSearchTxt.Text != string.Empty)
            {
                hdnVID.Value = txtSearchTxt.Text;
            }
            if (vid != 0)
            {
                vid = Convert.ToInt64(hdnVID.Value);
                // patientHeader.PatientVisitID = vid;
                patientVisitID = Convert.ToInt64(vid);
                ReportViewer.Visible = false;
                Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                objPatientBL.GetReportTemplate(patientVisitID, Convert.ToInt32(hdnOrgID.Value), LanguageCode, out lstReport, out lstReportName, out lstDpts);
                if (lstReport.Count() > 0)
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = lstReportName;
                    grdResult.DataBind();
                }
                else
                {
                    grdResult.Visible = false;
                }
            }
            hdnVID.Value = vid.ToString();
            //patientHeader.PatientVisitID = vid;
            List<RoleDeptMap> lRoleDeptMap = new List<RoleDeptMap>();
            List<InvReportMaster> lShowInvValues = new List<InvReportMaster>();
            long DeptID = -1;
            if (Session["DeptID"] != null && Session["DeptID"].ToString() != "")
            {
                DeptID = Convert.ToInt64(Session["DeptID"].ToString());
            }
            else if (Request.QueryString["DeptID"] != null)
            {
                Int64.TryParse(Request.QueryString["deptId"], out DeptID);
            }
            if (Request.QueryString["QADeptId"] != null)
            {
                Int64.TryParse(Request.QueryString["QADeptId"], out DeptID);
            }
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            string IsTrustedDetails = string.Empty;
            if (Convert.ToInt32(hdnOrgID.Value) != OrgID)
            {
                IsTrustedDetails = "Y";
            }
            else
            {
                IsTrustedDetails = "N";
            }
            long taskID = -1;
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                hdnTaskID.Value = taskID.ToString();
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                if (!IsPostBack)
                {
                    tbl.isTaskAlreadyPicked(taskID, TaskHelper.TaskStatus.Pending, TaskHelper.TaskStatus.InProgress, LID);
                }
            }
            //InvestigationBL.GetInvResultsCaptureForApprovel(vid, Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, DeptID, objLoginDetail, taskID, out lstOrdered, out header, out lRoleDeptMap, out lShowInvValues, IsTrustedDetails);
            // InvestigationBL.GetInvestigatonResultsCapture(vid,  Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, InvIDs, ILocationID, objLoginDetail, out lstOrdered, out header, out lRoleDeptMap);
            string status = "Approve";
            List<InvestigationStatus> lstheaders = new List<InvestigationStatus>();
            /* BEGIN | NA | Sabari | 20181202 | Created | HOLD */
            if (Request.QueryString["IsHold"] != null && Request.QueryString["IsHold"] == "Y")
            {
                InvestigationBL.GetInvestigationResultsCaptureForUnHold(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, objLoginDetail, taskID, IsTrustedDetails, status, out lstOrdered, out lstheaders, out lRoleDeptMap);
            }
            /* END | NA | Sabari | 20181202 | Created | HOLD */
            else
            {
                //InvestigationBL.GetInvestigatonResultsCapture(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, objLoginDetail, taskID, IsTrustedDetails, status, out lstOrdered, out lstheaders, out lRoleDeptMap);
                InvestigationBL.GetInvestigatonResultsCaptureToHold(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, objLoginDetail, taskID, IsTrustedDetails, status, out lstOrdered, out lstheaders, out lRoleDeptMap);
            }
            if (lRoleDeptMap.Count > 0)
            {
                hdnDept.Value = Convert.ToString(lRoleDeptMap[0].DeptID);
            }
            List<InvPackageMapping> lstInvPackageMapping = new List<InvPackageMapping>();
            foreach (PatientInvestigation P in lstOrdered)
            {
                InvPackageMapping IPM = new InvPackageMapping();
                IPM.ID = P.InvestigationID;
                IPM.PackageID = P.GroupID;
                IPM.Type = "";
                lstInvPackageMapping.Add(IPM);
            }
            //header = new List<InvestigationStatus>();

            //InvestigationBL.GetDrawPatternInvBulkData(gUID, lstInvPackageMapping, vid, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom);
            InvestigationBL.GetDrawPatternInvBulkData(gUID, lstInvPackageMapping, vid, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom, out lPerformingPhysicain);
            if (header != null && header.Count > 0)
            {
                if (header.Exists(p => p.Status == "Completed") && header.Exists(p => p.Status == "Approve"))
                {
                    hdnDefaultDropDownStatus.Value = "Approve";
                }
                else if (header.Exists(p => p.Status == "Completed"))
                {
                    hdnDefaultDropDownStatus.Value = "Validate";
                }
                else if (header.Exists(p => p.Status == "Validate"))
                {
                    hdnDefaultDropDownStatus.Value = "Approve";
                }
                //*************Added By Arivalagan.kk *For One step Approve*************//
                else if (header.Exists(p => p.Status == "Approve"))
                {
                    hdnDefaultDropDownStatus.Value = "Approve";
                }
                //*************End By Arivalagan.kk *For One step Approve*************//
            }
            /* BEGIN | NA | Sabari | 20181202 | Created | HOLD */
            if (header != null && header.Count > 0 && Request.QueryString["IsHold"] == null && Request.QueryString["IsHold"] != "Y")
            {
                try
                {
                    long returncode = -1;
                    string domains = "InvestigationApprovelOrHold_Status";
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
                        var newList = (
                                        from x in header
                                        select new { InvestigationID = x.InvestigationID, InvestigationStatusID = x.InvestigationStatusID }
                                        ).Distinct().ToList();

                        /*ON HOLD PROCESS*/
                        List<InvestigationStatus> lstheaderInvestigationOnHold_Status = new List<InvestigationStatus>();
                        if (newList != null && newList.Count > 0)
                        {
                            foreach (var md in lstmetadataOutput)
                            {
                                if (md.Code == "On Hold_998")
                                {
                                    foreach (var s in newList)
                                    {
                                        if (s.InvestigationID != null)
                                        {
                                            InvestigationStatus objInvsts = new InvestigationStatus();
                                            objInvsts.StatuswithID = md.Code;
                                            objInvsts.Status = md.DisplayText;
                                            objInvsts.DisplayText = md.DisplayText;
                                            objInvsts.InvestigationStatusID = s.InvestigationStatusID;
                                            objInvsts.InvestigationID = s.InvestigationID;
                                            lstheaderInvestigationOnHold_Status.Add(objInvsts);

                                        }
                                    }
                                }
                                if (md.Code == "On Hold & Approve_999")
                                {
                                    foreach (var s in newList)
                                    {
                                        if (s.InvestigationID != null)
                                        {
                                            InvestigationStatus objInvsts = new InvestigationStatus();
                                            objInvsts.StatuswithID = md.Code;
                                            objInvsts.Status = md.DisplayText;
                                            objInvsts.DisplayText = md.DisplayText;
                                            objInvsts.InvestigationStatusID = s.InvestigationStatusID;
                                            objInvsts.InvestigationID = s.InvestigationID;
                                            lstheaderInvestigationOnHold_Status.Add(objInvsts);

                                        }
                                    }
                                }

                            }

                        }

                        if (lstheaderInvestigationOnHold_Status != null && lstheaderInvestigationOnHold_Status.Count > 0)
                        {
                            header.AddRange(lstheaderInvestigationOnHold_Status);
                        }
                        /*ON HOLD PROCESS END*/
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error while  loading LoadTransitTimeType() Method in TAT Manage Logistics", ex);

                }
            }
            if (header != null && header.Count > 0 && Request.QueryString["IsHold"] != null && Request.QueryString["IsHold"] == "Y")
            {
                try
                {
                    long returncode = -1;
                    string domains = "InvestigationUnHold_Status";
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
                        var newList = (
                                        from x in header
                                        select new { InvestigationID = x.InvestigationID, InvestigationStatusID = x.InvestigationStatusID }
                                        ).Distinct().ToList();

                        /*ON HOLD PROCESS*/
                        List<InvestigationStatus> lstheaderInvestigationUnHold_Status = new List<InvestigationStatus>();
                        if (newList != null && newList.Count > 0)
                        {
                            foreach (var md in lstmetadataOutput)
                            {
                                if (md.Code == "UnHold_1")
                                {
                                    foreach (var s in newList)
                                    {
                                        if (s.InvestigationID != null)
                                        {
                                            InvestigationStatus objInvsts = new InvestigationStatus();
                                            objInvsts.StatuswithID = md.Code;
                                            objInvsts.Status = md.DisplayText;
                                            objInvsts.DisplayText = md.DisplayText;
                                            objInvsts.InvestigationStatusID = s.InvestigationStatusID;
                                            objInvsts.InvestigationID = s.InvestigationID;
                                            lstheaderInvestigationUnHold_Status.Add(objInvsts);

                                        }
                                    }
                                }
                            }

                        }

                        if (lstheaderInvestigationUnHold_Status != null && lstheaderInvestigationUnHold_Status.Count > 0)
                        {
                            header.AddRange(lstheaderInvestigationUnHold_Status);

                            header.RemoveAll(r => r.Status != "UnHold");
                        }
                        /*ON HOLD PROCESS END*/
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error while  loading InvestigationUnHold_Status", ex);

                }
            }
            /* END | NA | Sabari | 20181202 | Created | HOLD */
            if (RoleName == "Sonologist" || RoleName == "Radiologist" || RoleName == "Physician" || RoleName == "Medical Services")
            {
                foreach (InvestigationStatus Obj in header.FindAll(p => p.Status == "Validate"))
                {
                    Obj.Status = "Approve";
                }
            }
            hdnDept.Value = Convert.ToString(lRoleDeptMap[0].DeptID);
            if (!IsPostBack)
            {
                DemoBL = new Investigation_BL(base.ContextInfo);
                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation3);

                AutoApproveQueueCount = (from IL in lstPatientInvestigation3
                                         where IL.IsAutoApproveQueue == "Y"
                                         select IL).Count();
                hdnAutoApproveQueueCount.Value = AutoApproveQueueCount.ToString();

                IsAutoAuthRecollect = (from IL in lstPatientInvestigation3
                                       where IL.ReferredType == "Retest"
                                       select IL).Count();
                hdnIsAutoAuthRecollect.Value = IsAutoAuthRecollect.ToString();

                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                {
                    hdnAutoApproveQueueCount.Value = "1";
                }
                else
                {
                    hdnAutoApproveQueueCount.Value = AutoApproveQueueCount.ToString();
                }

            }
            //header1 = header;
            // InvestigationBL.GetPatientInvSample(vid, Convert.ToInt32(hdnOrgID.Value), out lstPatientInvSample, out lstSampleAttributes, out lPerformingPhysicain);
            List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
            List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
            List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
            new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(vid, Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
            //suresh
            returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            JavaScriptSerializer reasonserializer = new JavaScriptSerializer();
            hdnlstreasons.Value = reasonserializer.Serialize(lstInvReasonMaster);
            //InvestigationBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);


            patientBL.GetLabVisitDetails(vid, Convert.ToInt32(hdnOrgID.Value), out visitList);
            if (visitList.Count > 0)
            {
                string str = visitList[0].PatientAge;
                string[] strnewage = str.Split(' ');
                if (strnewage.Length > 1)
                {
                if (strnewage[1] == "Year(s)")
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strYear;
                }
                else if (strnewage[1] == "Month(s)")
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strMonth;
                }
                else if (strnewage[1] == "Day(s)")
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strDay;
                }
                else if (strnewage[1] == "Week(s)")
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strWeek;
                }
				else if (strnewage[1] == "UnKnown")
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strUnknownF;
                }
                else
                {
                    visitList[0].PatientAge = strnewage[0] + " " + strYear;
                    }
                }
                lblPName.Text = "<b>" + strName.Trim() + "</b>" + " " + visitList[0].TitleName + " " + visitList[0].PatientName;
                lblPAge.Text = "<b>" + strAge.Trim() + "</b>" + " " + visitList[0].PatientAge.ToString();
                lblVisitNo.Text = "<b>" + strPatientNo.Trim() + "</b>" + " " + Convert.ToString(visitList[0].PatientNumber);
                if (visitList[0].Sex == "M")
                {
                    lblSex.Text = "<b>" + strSex + "</b>" + " " + "" + strMale + "";
                }
                else if (visitList[0].Sex == "F")
                {
                    lblSex.Text = "<b>" + strSex + "</b>" + " " + "" + strFemale + "";
                }
                else if (visitList[0].Sex == "U")
                {
                    lblSex.Text = "<b>" + strSex + "</b>" + " " + "" + strUnknownF + "";
                }

                lblPName1.Text = "<b>" + strName.Trim() + "</b>" + " " + visitList[0].TitleName + " " + visitList[0].PatientName;
                lblPAge1.Text = "<b>" + strAge.Trim() + "</b>" + " " + visitList[0].PatientAge.ToString();
                lblVisitNo1.Text = "<b>" + strPatientNo.Trim() + "</b>" + " " + Convert.ToString(visitList[0].PatientNumber);
                if (visitList[0].Sex == "M")
                {
                    lblSex1.Text = "<b>" + strSex + "</b>" + " " + "" + strMale + "";
                }
                else if(visitList[0].Sex == "F")
                {
                    lblSex1.Text = "<b>" + strSex + "</b>" + " " + "" + strFemale + "";
                }
                else if (visitList[0].Sex == "U")
                {
                    lblSex1.Text = "<b>" + strSex + "</b>" + " " + "" + strUnknownF + "";
                }
                //------------Sathish.E------------//
                hdnPatientGender.Value = visitList[0].Sex.ToString();
                pAgeRaw = visitList[0].PatientAge.Split(' ');
                hdnpagearraw.Value = visitList[0].PatientAge.ToString();
                AgeDays = visitList[0].AgeDays;
                //------------End----------------//
            }

            //if (visitList.Count > 0)
            //{
            //    if (visitList[0].ExternalVisitID != null)
            //    {
            //        lblVisitNo.Text = visitList[0].ExternalVisitID.ToString();
            //    }
            //    else
            //    {
            //        lblVisitNo.Text = vid.ToString();
            //    }
            //    lblPatientName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;
            //    lblPatientNo.Text = Convert.ToString(visitList[0].PatientNumber);
            //    lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy"));

            //    if (visitList[0].Sex == "M")
            //    {
            //        lblGender.Text = "[Male]";
            //    }
            //    else
            //    {
            //        lblGender.Text = "[Female]";
            //    }
            //    lblAge.Text = visitList[0].PatientAge.ToString();

            //}

            //DemoBL.GetInvestigationSamplesCollect(vid, Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
            //DemoBL.GetInvestigationForVisit(vid, OrgID, ILocationID, out lstorderInv);
            DemoBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out lstorderInvforVisit);
            //DemoBL.pGetpatientInvestigationForVisit(vid, OrgID, ILocationID, out lstorderInvforVisit);


            if (lstorderInvforVisit.Count > 0)
            {

                GrdInv.DataSource = lstorderInvforVisit;
                GrdInv.DataBind();
                CheakInv.Style.Add("display", "table");

            }

            //if (lstSampleDept2.Count > 0)
            //{
            //    hdnHeaderName.Value = "";
            //}
            //if (lstSampleDept1.Count > 0)
            //{
            //    foreach (var item in lstSampleDept1)
            //    {
            //        if (item.Display == "Y")
            //        {
            //            hdnHeaderName.Value = "";
            //            break;
            //        }
            //        else
            //        {
            //            hdnHeaderName.Value = "Imaging";
            //        }
            //    }
            //}

            if (lstOrdered.Count > 0)
            {
                List<PatientInvestigation> lstCoAuthorizedInv = lstOrdered.FindAll(P => P.IsCoAuthorized == "Y").ToList();
                if (lstCoAuthorizedInv != null && lstCoAuthorizedInv.Count > 0)
                {
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    hdnIsCoAuthList.Value = serializer.Serialize(lstCoAuthorizedInv);
                }
                //    hdnHeaderName.Value = lstOrdered[0].HeaderName;

                //    if (lstPatientInvSample.Count > 0)
                //    {
                //        if (hdnHeaderName.Value != "Imaging")
                //        {
                //            ucSC.Visible = true;
                //            //ucSC.LoadPatientInvSample(lstPatientInvSample, lstSampleAttributes);
                //            //ucSC.GetPatientInvestigationSampleResults(vid, lRoleDeptMap[0].DeptID);
                //        }
                //        else
                //        {
                //            ucSC.Visible = false;
                //        }
                //    }
                //    else
                //    {
                //        ucSC.Visible = false;
                //    }
                drawNewPatternMethod();

                ucSCTab.Style.Add("display", "table");
                lblResult.Visible = false;
                ucReflexTest.VisitID = vid;
                ucReflexTest.GUID = gUID;
                ucReflexTest.LabNo = LabNo;
                ucReflexTest.POrgid = OrgID;
                hdnRoleName.Value = RoleName;

            }
            else
            {
                lblResult.Visible = true;
                ucSCTab.Style.Add("display", "none");
            }
            dvSampleCctrl.Style.Add("display", "none");
            lstQualitativeMaster.Attributes.Add("OnClick", "DisplaySelectedItem('" + lstQualitativeMaster.ClientID + "','" + sourceNameTXT.ClientID + "')");
            lstQualitativeMaster.Attributes.Add("onDblclick", "addSourceName();");
            if (!IsPostBack)
            {
                ShowReportPattern();
                this.Page.RegisterStartupScript("strKyhidePreview", "<script type='text/javascript'> showResponses('ACX2plus211','ACX2minus211','" + ACX2responses2111.ClientID + "',0); </script>");
                //Page.RegisterClientScriptBlock("skey12", "<script>showResponses('ACX2plus211','ACX2minus211','ACX2responses2111',0);</script>");
                hdnOutofrangeCount.Value = "0";
                mpeAttributeLocation.Hide();
                loadQualitativeResultMaster();
            }
            string url = Request.ApplicationPath + @"/Investigation/MethodKitPreview.aspx?isPopup=Y&vid=" + vid + "&gUID=" + gUID + "&pid=" + pid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&Invid=" + InvIDs + "&RNo=" + RId;       //DPT Refers to Department ...... VDT Refers to Visit Date
            linkbutton.OnClientClick = "ReportPopUP('" + url + "');";
            linkbuttonCl.Attributes.Add("onclick", "ReportPopUP('" + url + "');");
            linkbuttonCl.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
            linkbuttonCl.Attributes.Add("onmouseout", "this.style.color='Black';");
            //linkbutton.PostBackUrl= "~/Investigation/MethodKitCapture.aspx?isPopup=Y&vid=" + vid + "&gUID=" + gUID + "&pid=" + pid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&Invid=" + InvIDs;       //DPT Refers to Department ...... VDT Refers to Visit Date
            //try
            //{
            //    if (!String.IsNullOrEmpty(hdnUnCheckedAbnormalControl.Value))
            //    {
            //        string[] valUnCheckedAbnormalControl = hdnUnCheckedAbnormalControl.Value.Split('^');
            //        for (int iii = 0; iii < valUnCheckedAbnormalControl.Length - 1; iii++)
            //        {
            //            string[] unCheckedCtrl = valUnCheckedAbnormalControl[iii].Split('_');
            //            if (unCheckedCtrl.Length > 1)
            //            {
            //                Control txtctl = (Control)Page.FindControl(unCheckedCtrl[0]);
            //                TextBox ttl = null;
            //                DropDownList ddl = null;
            //                if (txtctl != null)
            //                {
            //                    if (!unCheckedCtrl[1].Contains("ddlData"))
            //                    {
            //                        ttl = (TextBox)txtctl.FindControl(unCheckedCtrl[1]);
            //                    }
            //                    ddl = (DropDownList)txtctl.FindControl("ddlData");

            //                    if (ttl != null)
            //                    {
            //                        //ttl.BackColor = System.Drawing.Color.White;
            //                        ttl.Attributes.Add("style", "background-color:white;");
            //                    }
            //                    if (ddl != null)
            //                    {
            //                        //ddl.BackColor = System.Drawing.Color.White;
            //                        ddl.Attributes.Add("style", "background-color:white;");
            //                    }
            //                }
            //            }
            //        }
            //    }
            //}
            //catch (Exception ex)
            //{
            //    CLogger.LogError("Error in abnormal settings", ex);
            //}
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            Users_BL oUserBL = new Users_BL(base.ContextInfo);
            oUserBL.GetUserListByRole(OrgID, RoleID, out lstSecondOpinionUser);
            if (lstSecondOpinionUser != null && lstSecondOpinionUser.Count > 0)
            {
                lstSecondOpinionUser = (from lou in lstSecondOpinionUser
                                        where lou.LoginID != LID
                                        select lou).ToList<Users>();
                hdnLstCoAuthorizeUser.Value = oJavaScriptSerializer.Serialize(lstSecondOpinionUser);
            }
            string Coauthorize = GetConfigValues("Coauthorize", OrgID);
            hdnConfigValue.Value = Coauthorize;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation result capture on page_load", ex);
        }
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    #endregion


    #region "Events"

    protected void GrdInv_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        string strRR = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_28 == null ? "RR" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_28;
        string strRC = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_29 == null ? "RC" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_29;
        string strRF = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_30 == null ? "RF" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_30;
        string strRecheck = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_31 == null ? "Recheck" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_31;
        string strRetest = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_32 == null ? "Retest" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_32;
        string strReflexTest = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_33 == null ? "ReflexTest" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_33;
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            Label lblStatus = (Label)e.Item.FindControl("lblStatus");

            if (lblStatus.Text == strRecheck.Trim())
            {
                lblStatus.Text = strRR;
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == strRetest.Trim())
            {
                lblStatus.Text = strRC;
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else if (lblStatus.Text == strReflexTest.Trim())
            {
                lblStatus.Text = strRF;
                lblStatus.BackColor = System.Drawing.Color.Yellow;
                lblStatus.ForeColor = System.Drawing.Color.Black;
            }
            else
            {
                lblStatus.Visible = false;
            }
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        Investigation_MultipleFileUpload MultipleUpload;
        MultipleUpload = (Investigation_MultipleFileUpload)LoadControl("MultipleFileUpload.ascx");
        long PatientID = 0;
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        long Returncode = MultipleUpload.CommonUpload(PatientID, patientVisitID, Request.Files, OrgID);
        SaveContinue();
    }
    protected void btnSavePreview_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        BtnSavePreview = true;
        SaveContinue();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        hdnClickCheck.Value = "True";
        try
        {
            if (Appvalue == "Yes")
            {
                Int64.TryParse(Request.QueryString["taskid"].ToString(), out Apptaskid);
                Response.Redirect("~/Investigation/InvestigationQuickApprovel.aspx?taskid=" + Apptaskid);
            }
            else
            {
                TaskOpen();
                //CLogger.LogWarning("Task Open Cancel");
                //Response.Redirect("~/Phlebotomist/Home.aspx");
                string path = string.Empty;
                List<Attune.Podium.BusinessEntities.Role> role = new List<Attune.Podium.BusinessEntities.Role>();
                Attune.Podium.BusinessEntities.Role roleid = new Attune.Podium.BusinessEntities.Role();
                roleid.RoleID = RoleID;
                role.Add(roleid);
                new Navigation().GetLandingPage(role, out path);
                if (path != string.Empty)
                {
                    string tskCnt = string.Empty;
                    if ((Request.QueryString["TkCnt"] != null) && (Request.QueryString["TkCnt"] != ""))
                    {
                        tskCnt = Request.QueryString["TkCnt"].ToString();
                    }
                    Response.Redirect(Request.ApplicationPath + path + "?TkCnt=" + tskCnt);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        //Page_Load(sender, e);
        //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        //List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        //List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
        //List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
        //List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
        //List<InvDeptMaster> deptList = new List<InvDeptMaster>();

        //long returnCode = -1;
        //if (txtSearchTxt.Text != "")
        //{
        //    ViewState["PatternID"] = null;
        //    ViewState["ControlID"] = null;
        //    hdnVID.Value = txtSearchTxt.Text;
        //    vid = Convert.ToInt64(hdnVID.Value);
        //    patientHeader.PatientVisitID=vid;
        //    List<PatientInvestigation> listOfInvestigations = new List<PatientInvestigation>();
        //    //InvestigationBL.GetInvestigatonCapture(vid, OrgID, RoleID, out lstOrdered, out header, out lstiom);
        //    InvestigationBL.GetInvestigationForVisit(vid, OrgID,out listOfInvestigations);

        //    if (pnBio.Visible)
        //    {
        //        divSave.Visible = true;
        //    }
        //    //Check wether
        //    if (listOfInvestigations.Count() == 0)
        //    {
        //        List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
        //        //Save investigations into patient Investigstion table
        //        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        //        invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList);

        //        foreach (PatientInvestigation patient in lstPatientInvestigation)
        //        {
        //            PatientInvestigation objInvest = new PatientInvestigation();
        //            objInvest.InvestigationID = patient.InvestigationID;
        //            objInvest.InvestigationName = patient.InvestigationName;
        //            objInvest.PatientVisitID = patient.PatientVisitID;
        //            objInvest.GroupID = patient.GroupID;
        //            objInvest.GroupName = patient.GroupName;
        //            //objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        //            objInvest.Status = patient.Status;
        //            objInvest.CreatedBy = LID;
        //            objInvest.Type = patient.Type;
        //            objInvest.OrgID = OrgID;
        //            SaveInvestigation.Add(objInvest);
        //        }
        //        returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation, OrgID);
        //    }
        //    //Get investion list for Capture
        //    InvestigationBL.GetInvestigatonResultsCapture(vid, OrgID, RoleID, out lstOrdered, out header, out lstiom);

        //    InvestigationBL.GetPatientInvSample(vid,OrgID, out lstPatientInvSample, out lstSampleAttributes);

        //    if (lstPatientInvSample.Count > 0 )//&& lstOrdered.Count > 0)
        //    {

        //        ucSC.LoadPatientInvSample(lstPatientInvSample, lstSampleAttributes);
        //        patientHeader.PatientVisitID = vid;
        //        patientHeader.ShowVitalsDetails();
        //        ShowInvestigation();
        //        ucSCTab.Style.Add("display", "block");
        //        lblResult.Visible = false;

        //        pnlSerch.Visible = false;
        //    }
        //    else
        //    {
        //        ucSCTab.Style.Add("display", "none");
        //        lblResult.Visible = true;
        //        pnlSerch.Visible = true; ;
        //    }

        //}
    }
    protected void tmrPostback_Tick(object sender, EventArgs e)
    {
        AutoSave();
        //Page_Load(sender, e);
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
                        new
                        {
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
                foreach (DataListItem rpt in dtInvName.Items)
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
        }
    }
    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            if (Request.QueryString["vid"] != null)
            {
                patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                patientVisitID = Convert.ToInt64(hdnVID.Value);
            }
            ShowReport(reportPath, patientVisitID, reportID, "");
        }
    }
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
                string strViewImg = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_34 == null ? "View Image" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_34;
                foreach (DataListItem rpt in dtInvName.Items)
                {
                    Label lbl = ((Label)rpt.FindControl("lblReportID"));
                    if (lbl.Text == "1")
                    {
                        LinkButton lnkshow = ((LinkButton)rpt.FindControl("lnkShow"));


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
                ShowReportPreview(reportPath, pVisitID, reportID, strSelVal);
                rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
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
                ShowReportPreview(reportPath, pVisitID, reportID, strSelVal);
                rptMdlPopup.Show();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("SSrs error in InvesReport", ex);
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
    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = ((Label)e.Item.FindControl("lblInvID")).Text;
            if (Request.QueryString["vid"] != null)
            {
                patientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
            }
            else
            {
                patientVisitID = Convert.ToInt64(hdnVID.Value);
            }
            ShowReport(reportPath, patientVisitID, reportID, investigatgionID);
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
    protected void linkbutton_Click(object sender, EventArgs e)
    {

        string url = Request.ApplicationPath + @"/Investigation/MethodKitPreview.aspx?isPopup=Y&vid=" + vid + "&gUID=" + gUID + "&pid=" + pid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&Invid=" + InvIDs + "&RNo=" + RId;       //DPT Refers to Department ...... VDT Refers to Visit Date
        linkbutton.OnClientClick = "ReportPopUP('" + url + "');";

    }
    #endregion
    public void LoadRangeColor()
    {
        long returnCode;
        List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();
        returnCode = new Investigation_BL().getReferencerangetype(OrgID, LanguageCode, out lstReferenceRangeType);
        if (lstReferenceRangeType.Count > 0)
        {
            txtAuto.Attributes.Add("style", "background-color:" + lstReferenceRangeType[1].Color + ";");
            txtPanic.Attributes.Add("style", "background-color:" + lstReferenceRangeType[2].Color + ";");
            txtReference.Attributes.Add("style", "background-color:white;");
            txtLower.Attributes.Add("style", "background-color:" + lstReferenceRangeType[3].Color + ";");
            txtHigher.Attributes.Add("style", "background-color:" + lstReferenceRangeType[4].Color + ";");
            txtDeviceError.Attributes.Add("style", "background-color:#faa603;");
        }
    }
    private void SaveContinue()
    {
        if (Request.QueryString["pid"] != null)
        {
            PageContextDetails.PatientID = Convert.ToInt64(Request.QueryString["pid"]);
        }
        if (Request.QueryString["vid"] != null)
        {
            PageContextDetails.PatientVisitID = Convert.ToInt64(Request.QueryString["vid"]);
        }
        hdnClickCheck.Value = "True";
        try
        {
            long returncode = AutoSave();
            if (hdnSynopticTestFlag.Value == "")
            {
                if (BtnSavePreview == false)
                {
                    if (returncode == 0)
                    {
                        Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
                        long taskID = -1;
                        Int64.TryParse(Request.QueryString["tid"], out taskID);

                        List<OrderedInvestigations> _InvestigationList = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> _NonapprovedInvestigations = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> lstCoauthorizeInvestigations = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> lstSecondOpinionInvestigations = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> SecondOpinionInvestigations = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> WithholdValidationInvestigations = new List<OrderedInvestigations>();
                        List<OrderedInvestigations> ValidatableInvestigations = new List<OrderedInvestigations>();
                        ////List<PatientInvestigation> lstPatientInvestigation3 = new List<PatientInvestigation>();
                        List<OrderedInvestigations> FilteredInvestigations = new List<OrderedInvestigations>();


                        DemoBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out _InvestigationList);

                        /**Exclude VID Lock for Org to Org Transfered Tests ***/
                        FilteredInvestigations = _InvestigationList.FindAll(P => P.ExcludeVIDlock == "N");


                        string tempstatus = string.Empty;
                        string secondOpinionStatus = string.Empty;
                        int taskActionID = 0;
                        List<Tasks> lstTasks = new List<Tasks>();
                        oTasksBL.GetTaskID(taskID, out lstTasks);
                        if (lstTasks != null && lstTasks.Count > 0)
                        {
                            taskActionID = lstTasks[0].TaskActionID;
                        }
                        int nonValidatedCount = 0;
                        int nonCompleteCount = 0;
                        nonValidatedCount = (from IL in FilteredInvestigations
                                             where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                             && IL.Status != InvStatus.SecondOpinion && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Cancel
                                             && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                             && IL.Status != InvStatus.WithholdValidation && IL.Status != InvStatus.WithholdApproval && IL.Status != "ReflexTest"
                                             && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive" && IL.Status != InvStatus.Notgiven
                                             select IL).Count();
                        int nonAutoautherizedCount = 0;
                        nonAutoautherizedCount = (from IL in FilteredInvestigations
                                                  where (IL.Status == InvStatus.Validate || IL.Status == "PartiallyValidated") && IL.IsAutoAuthorize == "N"
                                                  select IL).Count();
                        int WithholdValidationInvestigationsCount = 0;
                        WithholdValidationInvestigationsCount = (from IL in FilteredInvestigations
                                                                 where IL.Status == InvStatus.WithholdValidation
                                                                 select IL).Count();

                        nonCompleteCount = (from IL in FilteredInvestigations
                                            where IL.Status == InvStatus.Completed
                                            select IL).Count();

                        returnCode = DemoBL.GetPatientInvestigationStatus(vid, Convert.ToInt32(hdnOrgID.Value), out lstPatientInvestigation3);
                        AutoApproveQueueCount = (from IL in lstPatientInvestigation3
                                                 where IL.IsAutoApproveQueue == "Y"
                                                 select IL).Count();
                        hdnAutoApproveQueueCount.Value = AutoApproveQueueCount.ToString();
                        NormalApproveTestCount = (from IL in lstPatientInvestigation3
                                                  where IL.AutoApproveLoginID == 0
                                                  select IL).Count();
                        IsAutoAuthRecollect = (from IL in lstPatientInvestigation3
                                               where IL.ReferredType == "Retest"
                                               select IL).Count();
                        hdnIsAutoAuthRecollect.Value = IsAutoAuthRecollect.ToString();
                        if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                        {
                            hdnAutoApproveQueueCount.Value = "1";
                        }
                        else
                        {
                            hdnAutoApproveQueueCount.Value = AutoApproveQueueCount.ToString();
                        }
                        if (nonValidatedCount > 0)
                        {
                            List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
                            returnCode = DemoBL.GetSampleNotGiven(OrgID, vid, out lstSampleTracker);
                            if (lstSampleTracker.Count > 0)
                            {
                                List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
                                int validatedCount = 0;
                                validatedCount = (from IL in lstPatientInvestigation
                                                  where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                                  && IL.Status != InvStatus.SecondOpinion && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Cancel
                                                  && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                                  && IL.Status != InvStatus.Notgiven && IL.Status != InvStatus.WithholdValidation && IL.Status != "ReflexTest"
                                                  && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive"
                                                  select IL).Count();
                                if (validatedCount <= 0)
                                {
                                    nonValidatedCount = 0;
                                }
                            }
                        }
                        if (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SectionHeadsLab)
                        {
                            tempstatus = InvStatus.Completed;
                        }
                        else if (chkStatus == InvStatus.Coauthorize)
                        {
                            tempstatus = InvStatus.Coauthorize;
                            lstCoauthorizeInvestigations = FilteredInvestigations.FindAll(o => o.Status == tempstatus);

                            secondOpinionStatus = InvStatus.SecondOpinion;
                            lstSecondOpinionInvestigations = FilteredInvestigations.FindAll(o => o.Status == secondOpinionStatus);
                        }
                        else if (chkStatus == InvStatus.OpinionGiven)
                        {
                            tempstatus = InvStatus.OpinionGiven;
                            SecondOpinionInvestigations = FilteredInvestigations.FindAll(o => o.Status == InvStatus.SecondOpinion);
                        }
                        else if (chkStatus == InvStatus.WithholdValidation)
                        {
                            tempstatus = InvStatus.WithholdValidation;
                            ValidatableInvestigations = (from IL in FilteredInvestigations
                                                         where IL.Status == InvStatus.Completed || IL.Status == "PartiallyCompleted"
                                                         select IL).ToList();
                        }
                        else if (RoleName == RoleHelper.Doctor || RoleName == RoleHelper.Pathologist || RoleName == RoleHelper.SeniorDoctor || RoleName == RoleHelper.JuniorDoctor)
                        {
                            tempstatus = InvStatus.Validate;
                        }
                        //if (tempstatus != InvStatus.Coauthorize)
                        //{
                        //    _NonapprovedInvestigations = _InvestigationList.FindAll(o => o.Status == tempstatus);
                        //}
                        _NonapprovedInvestigations = (from IL in FilteredInvestigations
                                                      where IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.OpinionGiven
                                                       && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.ReflexWithNewSample && IL.Status != InvStatus.ReflexWithSameSample && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld && IL.Status != "PartiallyValidated" && IL.Status != InvStatus.Retest
                                                       && IL.Status != InvStatus.WithholdValidation && IL.Status != InvStatus.WithholdApproval && IL.Status != "ReflexTest"
                                                      select IL).Distinct().ToList();
                        if (lstSecondOpinionInvestigations.Count > 0 || lstCoauthorizeInvestigations.Count > 0)
                        {
                            if (lstSecondOpinionInvestigations.Count > 0)
                            {
                                if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.SecondOpinion))
                                {
                                    oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                                }
                            }
                            if (lstCoauthorizeInvestigations.Count > 0)
                            {
                                if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Coauthorize) && (_NonapprovedInvestigations.Count == 0))
                                {
                                    oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                                }
                            }
                        }
                        else if (chkStatus == InvStatus.OpinionGiven)
                        {
                            if (SecondOpinionInvestigations.Count == 0)
                            {
                                oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.SecondOpinion));
                            }
                        }
                        else if (chkStatus == InvStatus.ReflexWithNewSample || chkStatus == InvStatus.ReflexWithSameSample)
                        {
                            if (_NonapprovedInvestigations.Count > 0)
                            {
                                //oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                                Int64.TryParse(Request.QueryString["tid"], out taskID);
                                returncode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, "ReflexTest");
                            }
                        }
                        else
                        {
                            _NonapprovedInvestigations = _InvestigationList.FindAll(o => o.Status == tempstatus);
                            if (_NonapprovedInvestigations.Count == 0)
                            {
                                oTasksBL.UpdateTaskForaVisit(vid, Convert.ToInt32(hdnOrgID.Value), LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
                            }
                        }
                        List<PatientInvestigation> pattasks = new List<PatientInvestigation>();
                        string STATUS = string.Empty;
                        string TASKSTATUS = string.Empty;
                        STATUS = GetConfigValues("SampleStatusAllValidate", OrgID);
                        TASKSTATUS = GetConfigValues("DeptwiseLoginRole", OrgID);
                        if (chkStatus != InvStatus.Pending)
                        {

                            long refPhysicianID = -1;

                            long PatientID = -1;
                            Tasks task = new Tasks();
                            Hashtable dText = new Hashtable();
                            Hashtable urlVal = new Hashtable();

                            Int64.TryParse(Request.QueryString["pid"], out PatientID);
                            long createTaskID = -1;
                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                            returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
                            if (chkStatus == InvStatus.Validate && nonAutoautherizedCount == 0 && nonValidatedCount == 0)
                            {
                                if (AutoApproveQueueCount > 0)
                                {
                                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.AutoApproval),
                                                   vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                   lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                   , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                   gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.AutoApproval);
                                    task.DispTextFiller = dText;
                                    task.URLFiller = urlVal;
                                    task.RoleID = RoleID;
                                    task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                    task.PatientVisitID = vid;
                                    task.PatientID = PatientID;
                                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                    task.CreatedBy = LID;
                                    task.RefernceID = RId;
                                    //Create task               
                                    returncode = oTasksBL.CreateTask(task, out createTaskID);
                                }
                                else
                                {
                                    int returnStatus = -1;
                                    returncode = DemoBL.ApprovePatientInvestigationStatus(lstPatientInvestigation3, gUID, out returnStatus);
                                    if (returnStatus > 0)
                                    {
                                        ActionManager AM = new ActionManager(base.ContextInfo);
                                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                        PageContextkey PC = new PageContextkey();
                                        PC.ID = Convert.ToInt64(ILocationID);
                                        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                                        PC.RoleID = Convert.ToInt64(RoleID);
                                        PC.OrgID = OrgID;
                                        PC.PatientVisitID = vid;
                                        PC.PageID = Convert.ToInt64(PageID);
                                        PC.ButtonName = PageContextDetails.ButtonName;
                                        PC.ButtonValue = PageContextDetails.ButtonValue;
                                        lstpagecontextkeys.Add(PC);
                                        long res = -1;
                                        res = AM.PerformingNextStepNotification(PC, "", "");
                                    }
                                }
                            }
                            else
                            {

                                if (!string.IsNullOrEmpty(STATUS) && STATUS == "Y")
                                {


                                    if (Request.QueryString["gUID"] != null)
                                    {
                                        gUID = Request.QueryString["gUID"].ToString();
                                    }
                                    if (chkStatus == InvStatus.Validate && nonValidatedCount == 0 && (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SectionHeadsLab))
                                    {
                                        returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                                vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                                        task.DispTextFiller = dText;
                                        task.URLFiller = urlVal;
                                        task.RoleID = RoleID;
                                        task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                        task.PatientVisitID = vid;
                                        task.PatientID = PatientID;
                                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        task.CreatedBy = LID;
                                        task.RefernceID = RId;
                                        //Create task 
                                        if (Patinvestasks.Count > 0)
                                        {

                                            Patinvestasks.Select(e => new { e.AccessionNumber }).Distinct().ToList();

                                            DemoBL.GetGrouplevelvalidation(vid, task.TaskActionID, Patinvestasks, OrgID, 0, out pattasks);

                                        }
                                        if (pattasks.Count > 0)
                                        {
                                            returncode = oTasksBL.CreateTask(task, out createTaskID);
                                        }
                                    }
                                }
                                else
                                {
                                    if (Request.QueryString["gUID"] != null)
                                    {
                                        gUID = Request.QueryString["gUID"].ToString();
                                    }
                                    if (chkStatus == InvStatus.Validate && nonValidatedCount == 0 && (RoleName == RoleHelper.SrLabTech || RoleName == RoleHelper.SectionHeadsLab))
                                    {
                                        returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                                vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                                        task.DispTextFiller = dText;
                                        task.URLFiller = urlVal;
                                        task.RoleID = RoleID;
                                        task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                        task.PatientVisitID = vid;
                                        task.PatientID = PatientID;
                                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        task.CreatedBy = LID;
                                        task.RefernceID = RId;
                                        //Create task               
                                        returncode = oTasksBL.CreateTask(task, out createTaskID);
                                    }
                                }
                                if (chkStatus == InvStatus.Coauthorize)
                                {
                                    if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Coauthorize))
                                    {
                                        List<Tasks> lstGroupTask = new List<Tasks>();
                                        foreach (long oLoginID in lstCoauthorizeUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Coauthorize),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Coauthorize);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }
                                        foreach (long oLoginID in lstSelectedOpinionUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.SecondOpinion),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.SecondOpinion);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }
                                        if (lstGroupTask != null && lstGroupTask.Count > 0)
                                        {
                                            //Create task               
                                            returncode = oTasksBL.CreateGroupTask(lstGroupTask, out createTaskID);
                                            if (returncode == 0)
                                            {
                                                isCompleted = false;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        isCompleted = true;
                                    }
                                }
                                else if (chkStatus == InvStatus.OpinionGiven)
                                {
                                    BillingEngine oBillingEngine = new BillingEngine(base.ContextInfo);
                                    List<TaskDetails> lstTaskDetails = new List<TaskDetails>();
                                    List<TaskDetails> lstCompletedApproveTaskDetails = new List<TaskDetails>();
                                    oBillingEngine.PgetTaskDetailsforvisit(vid, Convert.ToInt32(hdnOrgID.Value), out lstTaskDetails);
                                    bool isApproveTaskOpen = false;
                                    bool isApproveTaskCompleted = false;
                                    List<int> lstTaskStatus = new List<int>();
                                    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Pending));
                                    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.InProgress));
                                    List<int> lstCompletedApproveTaskStatus = new List<int>();
                                    lstCompletedApproveTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Completed));
                                    if (lstTaskDetails != null && lstTaskDetails.Count > 0)
                                    {
                                        lstCompletedApproveTaskDetails = (from TD in lstTaskDetails
                                                                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Validate) && lstCompletedApproveTaskStatus.Contains(TD.TaskStatusID)
                                                                          select TD).ToList<TaskDetails>();

                                        lstTaskDetails = (from TD in lstTaskDetails
                                                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Validate) && lstTaskStatus.Contains(TD.TaskStatusID)
                                                          select TD).ToList<TaskDetails>();

                                        if (lstCompletedApproveTaskDetails != null && lstCompletedApproveTaskDetails.Count > 0)
                                        {
                                            isApproveTaskCompleted = true;
                                        }
                                        if (lstTaskDetails != null && lstTaskDetails.Count > 0 && !isApproveTaskCompleted)
                                        {
                                            isApproveTaskOpen = true;
                                        }
                                    }
                                    if (SecondOpinionInvestigations.Count == 0)
                                    {
                                        if (!isApproveTaskOpen)
                                        {
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;
                                            //Create task               
                                            returncode = oTasksBL.CreateTask(task, out createTaskID);
                                        }
                                        isCompleted = false;
                                    }
                                    else
                                    {
                                        isCompleted = true;
                                    }
                                }
                                else if (chkStatus == InvStatus.WithholdValidation)
                                {
                                    if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.WithholdValidation))
                                    {
                                        List<Tasks> lstGroupTask = new List<Tasks>();
                                        returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.WithholdValidation),
                                                       vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                       lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                       , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                       gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.WithholdValidation);
                                        task.DispTextFiller = dText;
                                        task.URLFiller = urlVal;
                                        task.RoleID = RoleID;
                                        task.OrgID = OrgID;
                                        task.PatientVisitID = vid;
                                        task.PatientID = PatientID;
                                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        task.CreatedBy = LID;
                                        task.RefernceID = LabNo;
                                        lstGroupTask.Add(task);

                                        foreach (long oLoginID in lstCoauthorizeUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.WithholdValidation),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Coauthorize);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }
                                        foreach (long oLoginID in lstSelectedOpinionUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.SecondOpinion),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.SecondOpinion);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }

                                        if (lstGroupTask != null && lstGroupTask.Count > 0)
                                        {
                                            //Create task               
                                            returncode = oTasksBL.CreateGroupTask(lstGroupTask, out createTaskID);

                                        }
                                    }
                                }
                                else if (chkStatus == InvStatus.WithholdApproval)
                                {
                                    if (taskActionID != Convert.ToInt16(TaskHelper.TaskAction.WithholdApprovel))
                                    {
                                        List<Tasks> lstGroupTask = new List<Tasks>();
                                        returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.WithholdApprovel),
                                                       vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                       lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                       , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                       gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.WithholdApprovel);
                                        task.DispTextFiller = dText;
                                        task.URLFiller = urlVal;
                                        task.RoleID = RoleID;
                                        task.OrgID = OrgID;
                                        task.PatientVisitID = vid;
                                        task.PatientID = PatientID;
                                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        task.CreatedBy = LID;
                                        task.RefernceID = LabNo;
                                        lstGroupTask.Add(task);

                                        foreach (long oLoginID in lstCoauthorizeUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.WithholdValidation),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Coauthorize);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }
                                        foreach (long oLoginID in lstSelectedOpinionUser)
                                        {
                                            task = new Tasks();
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.SecondOpinion),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.SecondOpinion);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = oLoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;

                                            lstGroupTask.Add(task);
                                        }

                                        if (lstGroupTask != null && lstGroupTask.Count > 0)
                                        {
                                            //Create task               
                                            returncode = oTasksBL.CreateGroupTask(lstGroupTask, out createTaskID);

                                        }
                                    }
                                }
                                else
                                {
                                    if (lstPatientVisitDetails.Count > 0)
                                    {
                                        refPhysicianID = lstPatientVisitDetails[0].ReferingPhysicianID;
                                    }
                                    List<ReferingPhysician> lstRefPhy = new List<ReferingPhysician>();
                                    returncode = new PatientVisit_BL(base.ContextInfo).GetRefPhyDetails(refPhysicianID, Convert.ToInt32(hdnOrgID.Value), out lstRefPhy);
                                    if (lstRefPhy.Count > 0)
                                    {
                                        if (lstRefPhy[0].LoginID != 0)
                                        {
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ViewInvestigationResult),
                                                         vid, lstRefPhy[0].LoginID, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                         , out dText, out urlVal, 0, "", 0, gUID);
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ViewInvestigationResult);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.AssignedTo = lstRefPhy[0].LoginID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            //Create task               
                                            returncode = oTasksBL.CreateTask(task, out createTaskID);
                                        }
                                    }
                                }

                                if (chkStatus == InvStatus.Completed && TASKSTATUS == "Y" && nonCompleteCount > 0)
                                {
                                    BillingEngine oBillingEngine = new BillingEngine(base.ContextInfo);
                                    List<TaskDetails> lstTaskDetails = new List<TaskDetails>();
                                    List<TaskDetails> lstCompletedApproveTaskDetails = new List<TaskDetails>();
                                    oBillingEngine.PgetTaskDetailsforvisit(vid, Convert.ToInt32(hdnOrgID.Value), out lstTaskDetails);
                                    bool isApproveTaskOpen = false;
                                    bool isApproveTaskCompleted = false;
                                    List<int> lstTaskStatus = new List<int>();
                                    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Pending));
                                    lstTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.InProgress));
                                    List<int> lstCompletedApproveTaskStatus = new List<int>();
                                    lstCompletedApproveTaskStatus.Add(Convert.ToInt32(TaskHelper.TaskStatus.Completed));
                                    if (lstTaskDetails != null && lstTaskDetails.Count > 0)
                                    {
                                        lstCompletedApproveTaskDetails = (from TD in lstTaskDetails
                                                                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Validate) && lstCompletedApproveTaskStatus.Contains(TD.TaskStatusID)
                                                                          select TD).ToList<TaskDetails>();

                                        lstTaskDetails = (from TD in lstTaskDetails
                                                          where TD.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.Approval) && lstTaskStatus.Contains(TD.TaskStatusID)
                                                          select TD).ToList<TaskDetails>();

                                        if (lstCompletedApproveTaskDetails != null && lstCompletedApproveTaskDetails.Count > 0)
                                        {
                                            isApproveTaskCompleted = true;
                                        }
                                        if (lstTaskDetails != null && lstTaskDetails.Count > 0 && !isApproveTaskCompleted)
                                        {
                                            isApproveTaskOpen = true;
                                        }
                                    }
                                    if (SecondOpinionInvestigations.Count == 0)
                                    {
                                        if (!isApproveTaskOpen)
                                        {
                                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Approval),
                                                    vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                                    lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                                    , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                                    gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber,"");
                                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                                            task.DispTextFiller = dText;
                                            task.URLFiller = urlVal;
                                            task.RoleID = RoleID;
                                            task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                            task.PatientVisitID = vid;
                                            task.PatientID = PatientID;
                                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                            task.CreatedBy = LID;
                                            task.RefernceID = RId;
                                            //Create task               
                                            returncode = oTasksBL.CreateTask(task, out createTaskID);
                                        }
                                        isCompleted = true;
                                    }
                                    else
                                    {
                                        isCompleted = true;
                                    }
                                    nonCompleteCount--;
                                }



                                //if (isValidate)
                                //{
                                //    isCompleted = true;
                                //}
                                bool isTaskCompleted = true;
                                if (isCompleted == true)
                                {
                                    isTaskCompleted = false;
                                }
                                else if ((_NonapprovedInvestigations.Count > 0 && taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Coauthorize) && taskActionID != Convert.ToInt16(TaskHelper.TaskAction.Approval)) ||
                                    _NonapprovedInvestigations.Count > 0 && taskActionID == Convert.ToInt16(TaskHelper.TaskAction.Approval))
                                {
                                    isTaskCompleted = false;
                                }
                                if (chkStatus == InvStatus.WithholdValidation && taskActionID == Convert.ToInt16(TaskHelper.TaskAction.Approval))
                                {
                                    if (ValidatableInvestigations.Count == 0)
                                    {
                                        isTaskCompleted = true;
                                    }
                                }
                                if (chkStatus == InvStatus.WithholdApproval)
                                {
                                    if (_NonapprovedInvestigations.Count == 0)
                                    {
                                        isTaskCompleted = true;
                                    }
                                }
                                //if (taskActionID==Convert.ToInt16(TaskHelper.TaskAction.Approval))
                                // {
                                //     List<PatientInvestigation> lstCompleted = lstPatientInvestigation.FindAll(P => P.Status == InvStatus.Completed);

                                //     if (lstCompleted.Count() <= 0)
                                //     {
                                //         isTaskCompleted = true;
                                //     }
                                //     else 
                                //     {
                                //         isTaskCompleted = false;
                                //     }

                                // }
                                if (isTaskCompleted)
                                {
                                    oTasksBL.UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);
                                }
                                //For Picked by issue

                                    //Sur
                                else
                                {
                                    long returncode1 = -1;
                                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                                    returncode1 = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");

                                    //if (SecondOpinionInvestigations.Count == 0)
                                    //{
                                      //  returncode1 = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, "ReflexTest");
                                    //}
                                    //else
                                    //{
                                      //  returncode1 = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");
                                    //}
                                }
                            }


                            String StoreReportSnapshot = GetConfigValues("StoreReportSnapshot", OrgID);
                            if (StoreReportSnapshot == "Y")
                            {
                                List<string> lstInvStatus = new List<string>();
                                lstInvStatus.Add(InvStatus.Approved);
                                ReportUtil objReportUtil = new ReportUtil();
                                objReportUtil.SaveReportSnapshot(Convert.ToInt32(hdnOrgID.Value), ILocationID, vid, LID, lstInvStatus, true);
                            }
                            if (Appvalue == "Yes")
                            {
                                Response.Redirect("~/Investigation/InvestigationQuickApprovel.aspx");
                            }
                            else
                            {
                                string TkCnt = string.Empty;
                                if (chkStatus != InvStatus.Pending)
                                {
                                    if (hdnSaveandNext.Value == "Y")
                                    {
                                        LoginDetail objLoginDetail = new LoginDetail();
                                        objLoginDetail.LoginID = LID;
                                        objLoginDetail.RoleID = RoleID;
                                        objLoginDetail.Orgid = OrgID;
                                        Investigation_BL callBL = new Investigation_BL(base.ContextInfo);
                                        List<EnterResult> lstDetails = new List<EnterResult>();
                                        string Visitnumber = string.Empty;
                                        long PatientId = 0;
                                        string patientName = string.Empty;
                                        long clientId = -1;
                                        int pRefPhyID = 0;
                                        long pLocationID = 0;
                                        int currentPageNo = 1;
                                        string InvID = string.Empty;
                                        string Patnumber = string.Empty;
                                        string Type = string.Empty;
                                        long deptID = -1;
                                        string IsTimed = string.Empty;
                                        string tasks = "N";

                                        int TotalRowNos = 0;
                                        int RowIndex = 0;

                                        IsTimed = "N";
                                        if (Request.QueryString["TkCnt"] != null)
                                        {
                                            TkCnt = Request.QueryString["TkCnt"].ToString();
                                        }
                                        if (Request.QueryString["TotRows"] != null)
                                        {
                                            Int32.TryParse(Request.QueryString["TotRows"], out TotalRowNos);
                                        }
                                        if (Request.QueryString["RowIndex"] != null)
                                        {
                                            Int32.TryParse(Request.QueryString["RowIndex"], out RowIndex);
                                            if (RowIndex == TotalRowNos || RowIndex > TotalRowNos)
                                            {
                                                currentPageNo = 1;
                                            }
                                            else
                                            {
                                                if (Convert.ToInt32(TkCnt) == 1)
                                                {
                                                    currentPageNo = RowIndex + 2 + (Convert.ToInt32(TkCnt) - 1) * 10;
                                                }
                                                else
                                                {
                                                    currentPageNo = RowIndex + 1 + (Convert.ToInt32(TkCnt) - 1) * 10;
                                                }
                                            }
                                        }
                                        else
                                        {
                                            currentPageNo = 1;
                                        }

                                        callBL.GetLabInvestigationPatientSearch(ILocationID, OrgID, RoleID, currentPageNo, PageSize, PatientId, patientName, out lstDetails, out totalRows, 0,
                                                    clientId, string.Empty, "-1", InvID,
                                                    "", "", 0, Visitnumber, Patnumber, Type, deptID, "SelectiveAuthorization", pRefPhyID, pLocationID, objLoginDetail, IsTimed, 0,"", tasks,"");
                                        //    //Response.Redirect("~/Investigation/InvestigationApprovel.aspx?pid=" + pid + "&vid=" + vid + "&gUID=" +gUID + "&tid="
                                        //    //    + taskActionID + "&LNo=" + labNumber + "&RNo=" +RNo);
                                        //}
                                        if (lstDetails.Count > 0)
                                        {
                                            Response.Redirect("~/Investigation/InvestigationApprovel.aspx?pid=" + lstDetails[0].PatientID + "&vid=" + lstDetails[0].PatientVisitId + "&gUID=" + lstDetails[0].UID + "&tid=" + taskActionID + "&RNo=" + lstDetails[0].Labno + "&TkCnt=" + TkCnt + "&RowIndex=" + currentPageNo + "&TotRows=" + TotalRowNos);

                                        }
                                        else
                                        {
                                            Response.Redirect("~/Phlebotomist/Home.aspx?TkCnt=" + TkCnt + "");
                                            /*Sabari added*/
                                           // Response.Redirect("~/Lab/InvestigationOrgChangeNew.aspx");
                                            
                                        }
                                    }
                                    if (hdnSaveToDispatch.Value == "1")
                                    {
                                        long rtncode = -1;
                                        //List<ClientBatchMaster> lstinvmasters = new List<ClientBatchMaster>();
                                        //rtncode = new Master_BL(new BaseClass().ContextInfo).Insertpushingordereddetails(OrgID, vid.ToString(), "Wellness", out lstinvmasters);
                                        string path = string.Empty;
                                        List<Attune.Podium.BusinessEntities.Role> role = new List<Attune.Podium.BusinessEntities.Role>();
                                        Attune.Podium.BusinessEntities.Role roleid = new Attune.Podium.BusinessEntities.Role();
                                        roleid.RoleID = RoleID;
                                        role.Add(roleid);
                                        new Navigation().GetLandingPage(role, out path);
                                        if (path != string.Empty)
                                        {
                                            //sabari commented
                                            //Response.Redirect(Request.ApplicationPath + path);
                                            Response.Redirect(Request.ApplicationPath + "/Lab/HoldAndUnholdReports.aspx");
                                            //sabari added end
                                        }
                                    }
                                    else
                                    {
                                        if (Request.QueryString["pid"] != null)
                                        {
                                            Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
                                        }
                                        String ShowSummaryReport = GetConfigValues("ShowSummaryReport", OrgID);
                                        if (ShowSummaryReport == "Y")
                                        {
                                            Response.Redirect("~/Investigation/SummaryReport.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUIDTemp + "&Invid=" + InvIDs + "&ShwBtn=N" + "&RNo=" + RId + "&pid=" + pid);
                                        }
                                        else
                                        {
                                            Response.Redirect("~/Investigation/InvReportsForApproval.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUIDTemp + "&Invid=" + InvIDs + "&ShwBtn=N" + "&RNo=" + RId + "&pid=" + pid,false);
                                        }
                                    }
                                }
                                else
                                {
                                    string path = string.Empty;
                                    List<Attune.Podium.BusinessEntities.Role> role = new List<Attune.Podium.BusinessEntities.Role>();
                                    Attune.Podium.BusinessEntities.Role roleid = new Attune.Podium.BusinessEntities.Role();
                                    roleid.RoleID = RoleID;
                                    role.Add(roleid);
                                    new Navigation().GetLandingPage(role, out path);
                                    if (path != string.Empty)
                                    {
                                        Response.Redirect(Request.ApplicationPath + path);
                                        string tskCnt = string.Empty;
                                        if ((Request.QueryString["TkCnt"] != null) && (Request.QueryString["TkCnt"] != ""))
                                        {
                                            tskCnt = Request.QueryString["TkCnt"].ToString();
                                        }
                                        Response.Redirect(Request.ApplicationPath + path + "?TkCnt=" + tskCnt);
                                    }

                                }
                            }
                        }

                    }
                    //sabari
                    else if (Request.QueryString["IsHold"] == "Y" && Request.QueryString["IsHold"] != null && returncode > 0)
                    {
                        /*Sabari added*/
                        //Response.Redirect("~/Lab/InvestigationOrgChangeNew.aspx");
                        Response.Redirect(Request.ApplicationPath + "/Lab/HoldAndUnholdReports.aspx");
                    }
                    /* Here Hold Test's Not Peformed enter result only status change means then reload that basepage */
                    else if (returncode > 0)
                    {

                        Response.Redirect(Request.ApplicationPath + "/Lab/HoldAndUnholdReports.aspx");
                    }
                }
                else
                {
                    if (Request.QueryString["pid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["pid"].ToString(), out pid);
                    }
                    string invStatus = "all";
                    //THE BELOW LINE COMMENDED BY RAMKUMAR.S due to show the value in Pop up page instead of Next page redirectin
                    //Response.Redirect("~/Investigation/InvReportsForApproval.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUIDTemp + "&Invid=" + InvIDs + "&ShwBtn=N" + "&RNo=" + RId + "&pid=" + pid);
                    mpReportPreview.Show();
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "page", "javascript:ShowReportPreviewonReport('" + vid + "','" + RoleID + "','" + invStatus + "');", true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            string str = ex.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSave_Click Event", ex);
        }
        hdnSaveandNext.Value = "N";
    }
    public void ShowReportPreview(string reportPath, long visitID, string templateID, string InvID)
    {
        try
        {
            rReportViewer.Visible = true;
            string strURL = string.Empty;
            ReportViewer.Attributes.Add("style", "width:100%; height:484%");
            string connectionString = string.Empty;
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", Convert.ToInt32(hdnOrgID.Value));
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            rReportViewer.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(Convert.ToInt32(hdnOrgID.Value)));
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
    private void ShowReportPattern()
    {
        int menuType, pCount;
        string patientNumber = string.Empty;
        HdnCheckBoxId.Value = "";

        try
        {
            long returnCode = -1;
            long VisitID = Convert.ToInt64(hdnVID.Value);

            List<OrderedInvestigations> lstOrderderd = new List<OrderedInvestigations>();

            if (true)
            {
                returnCode = new Investigation_BL(base.ContextInfo).pCheckInvValuesbyVID(Convert.ToInt64(hdnVID.Value), out pCount, out patientNumber, out lstOrderderd);
                if (lstOrderderd.Count > 0)
                {
                    //tblPayments.Visible = true;
                    //tblResults.Visible = false;

                    //tblPayments.Visible = false;
                    tblResults.Visible = true;

                    Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                    objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(hdnOrgID.Value),LanguageCode, out lstReport, out lstReportName, out lstDpts);
                    if (lstReport.Count() > 0)
                    {
                        grdResultTemp.Visible = true;
                        grdResultTemp.Visible = true;
                        grdResultTemp.DataSource = lstReportName;
                        grdResultTemp.DataBind();
                        bindCheckBox();
                        //lblMessage1.Visible = false;
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
                        //lblMessage1.Visible = true;
                        //lblMessage1.Text = "No Matching Records Found";
                    }
                }
                else
                {
                    //tblPayments.Visible = false;
                    tblResults.Visible = true;

                    Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
                    objPatientBL.GetReportTemplate(VisitID, Convert.ToInt32(hdnOrgID.Value),LanguageCode, out lstReport, out lstReportName, out lstDpts);
                    if (lstReport.Count() > 0)
                    {
                        grdResultTemp.Visible = true;
                        grdResultTemp.Visible = true;
                        grdResultTemp.DataSource = lstReportName;
                        grdResultTemp.DataBind();
                        bindCheckBox();
                        //lblMessage1.Visible = false;
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
                        //lblMessage1.Visible = true;
                        //lblMessage1.Text = "No Matching Records Found";
                    }
                }
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationReport", ex);
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
    public Boolean fnValidateResulValue(string resultValue, List<InvValueRangeMaster> lstInvValueRangeMaster, out List<PatientInvestigation> lstReflexPatientInvestigation)
    {
        Boolean result = false;
        lstReflexPatientInvestigation = new List<PatientInvestigation>();
        try
        {
            LabUtil obj = new LabUtil();
            Boolean ISNumericResultValue = false;
            Decimal ResultValueS = 0;
            ResultValueS = obj.ConvertResultValue(resultValue, out ISNumericResultValue);
            foreach (var item in lstInvValueRangeMaster)
            {
                PatientInvestigation objpinv = new PatientInvestigation();
                switch (item.Range)
                {
                    case "EQ":
                        if (resultValue.ToLower().Trim() == item.ValueRange.ToLower().Trim())
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "NEQ":
                        if (resultValue.ToLower().Trim() != item.ValueRange.ToLower().Trim())
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "LT":
                        if (Convert.ToDecimal(ResultValueS) < Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "GT":
                        if (Convert.ToDecimal(ResultValueS) > Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "LTEQ":
                        if (Convert.ToDecimal(ResultValueS) <= Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "GTEQ":
                        if (Convert.ToDecimal(ResultValueS) >= Convert.ToDecimal(item.ValueRange))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    case "BTW":
                        string[] resultval = item.ValueRange.Split('-');
                        if ((Convert.ToDecimal(resultval[0]) <= Convert.ToDecimal(ResultValueS)) && (Convert.ToDecimal(ResultValueS) <= Convert.ToDecimal(resultval[1])))
                        {
                            objpinv.InvestigationID = item.ReflexInvestigationID;
                            result = true;
                        }
                        break;
                    default:
                        //result = false;
                        result = result == true ? true : false;
                        break;
                }
                lstReflexPatientInvestigation.Add(objpinv);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }
    public void SetTasksFilter(List<OrganizationAddress> lstLocation, List<Speciality> lstSpeciality,
    List<TaskActions> lstCategory,
    TaskProfile taskProfile, List<InvDeptMaster> lstDept)
    {
        try
        {
            /* DEFAULT DATE*/
            if (taskProfile.TaskDate != "" && taskProfile.TaskDate == "ToDay")
            {
                hdnTaskDate.Value = OrgTimeZone;
            }
            else if (taskProfile.TaskDate != "" && taskProfile.TaskDate == "ALL")
            {
                hdnTaskDate.Value = "-1";
            }
            else if (taskProfile.TaskDate != "")
            {
                hdnTaskDate.Value = taskProfile.TaskDate;
            }
            else
            {
                hdnTaskDate.Value = "-1";
            }
            /*DEFAULT CATEGORY*/
            if (taskProfile.Category != "0")
            {
                hdncategory.Value = taskProfile.Category;
            }
            else
            {
                hdncategory.Value = "-1";
            }
            /*DEFAULT SPECALITY*/
            if (taskProfile.SpecialityID != 0)
            {
                hdnspecId.Value = taskProfile.SpecialityID.ToString();
            }
            else
            {
                hdnspecId.Value = "-1";
            }
            /*DEFAULT LOCATION*/
            if (taskProfile.Location != "0")
            {
                //Int32.TryParse(taskProfile.Location, out InvLocationID);
                hdnInvLocationID.Value = taskProfile.Location;
            }
            else
            {
                hdnInvLocationID.Value = "-1";
            }
            /*DEFAULT DEPRTMENT*/

            if (taskProfile.DeptID != 0)
            {
                hdnDeptID.Value = taskProfile.DeptID.ToString();
            }
            else
            {
                hdnDeptID.Value = "-1";
            }

        }
        catch (Exception e)
        {
            CLogger.LogError("Error in QuickApproval Load Default Task Items", e);
        }
    }
    public void ConvertXmlToString(string xmlData, string uom, out string ReferenceRange, out string OtherReferenceRange)
    {
        ReferenceRange = string.Empty;
        OtherReferenceRange = string.Empty;
        try
        {
            long patientVisitID = 0;
            long patientID = 0;
            uom = uom == "" ? "" : uom;

            if ((Request.QueryString["vid"] != null) || (Request.QueryString["pid"] != null))
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
            }
            else
            {
                Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out patientVisitID);
                Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
            }

            LabUtil oLabUtil = new LabUtil();
            oLabUtil.ConvertXmlToString(xmlData, uom, hdnPatientGender.Value, hdnpagearraw.Value, AgeDays, out ReferenceRange, out OtherReferenceRange);
            ReferenceRange = !String.IsNullOrEmpty(ReferenceRange) ? ReferenceRange.Trim().Replace("<br>", "\n") : string.Empty;
        }
        catch (Exception ex)
        {
            ReferenceRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }
    public void ShowReport(string reportPath, long visitID, string templateID, string InvID)
    {
        try
        {
            ReportViewer.Visible = true;
            string strURL = string.Empty;
            string connectionString = string.Empty;
            connectionString = GetConnectionString();
            ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
            strURL = GetConfigValues("ReportServerURL", Convert.ToInt32(hdnOrgID.Value));
            ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            ReportViewer.ServerReport.ReportPath = reportPath;
            ReportViewer.ShowParameterPrompts = false;
            ReportViewer.ShowPrintButton = true;

            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[5];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pVisitID", Convert.ToString(visitID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("OrgID", Convert.ToString(Convert.ToInt32(hdnOrgID.Value)));
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
    public string GetConnectionString()
    {
        return System.Configuration.ConfigurationManager.ConnectionStrings["AttHealth"].ConnectionString;
    }
    private long AutoSave()
    {
        List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
        lstPatientInvSampleResults = ucSC.GetPInvSampleResults(vid);
        lstPatientInvSampleMapping = ucSC.GetSampleInvMapping();
        ArrayList result = new ArrayList();
        int returnStatus = -1;
        long returnCode = -1;

        List<InvestigationValues> lstBio1 = null;
        List<InvestigationValues> lstFishpattern1 = null;
        List<InvestigationValues> lstFishpattern2 = null;
        List<InvestigationValues> lstMultiAddControl = null;
        List<InvestigationValues> lstResultFishpattern = null;
        List<InvestigationValues> lstResultFishpattern1 = null;
        List<InvestigationValues> lstMolBio = null;
        List<InvestigationValues> lstBRCA = null;
        List<InvestigationValues> lstBRCA1 = null;
        List<InvestigationValues> lstOrgDrugPattern = null;
        List<InvestigationValues> lstMicroStainPattern = null;
        List<InvestigationValues> lstHEMATOLOGYPattern = null;
        List<InvestigationValues> lstMicroBiopattern1 = null;
        List<InvestigationValues> lstBio2 = new List<InvestigationValues>();
        List<InvestigationValues> lstBio3 = new List<InvestigationValues>();
        List<InvestigationValues> lstBio4 = new List<InvestigationValues>();
        List<InvestigationValues> lstBio5 = new List<InvestigationValues>();
        List<InvestigationValues> lstImage = new List<InvestigationValues>();

        List<InvestigationValues> lstPDF = new List<InvestigationValues>();
        List<InvestigationValues> lstMicroVal = new List<InvestigationValues>();
        List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
        List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
        List<InvestigationValues> lstHPP = new List<InvestigationValues>();
        List<InvestigationValues> lstABMethod = new List<InvestigationValues>();
        List<InvestigationValues> lstABQualitative = new List<InvestigationValues>();
        List<InvestigationValues> lstSemenanalysis = new List<InvestigationValues>();
        List<InvestigationValues> lstImaging = new List<InvestigationValues>();
        List<InvestigationValues> lstphsmear = new List<InvestigationValues>();
        List<InvestigationValues> lstBleedingtime = new List<InvestigationValues>();
        List<InvestigationValues> lTxtpattern = new List<InvestigationValues>();
        List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
        List<InvestigationValues> lstGeneralPattern = null;
        List<InvestigationValues> lstTablepatternautopopulate = null;
        List<InvestigationValues> lstRichTextPattern = null;
        List<InvestigationValues> lstHistoImageDescriptionPattern = null;
        List<InvestigationValues> lstImageDescriptionpattern = null;
        bool Flag = true;
        try
        {

            result = (ArrayList)ViewState["ControlID"];
            lstpatternID = (ArrayList)ViewState["PatternID"];

            for (int i = 0; i < result.Count; i++)
            {
                switch (Convert.ToInt32(lstpatternID[i]))
                {

                    //Load Comman Pattern for unmapping investigation

                    case (Int32)TaskHelper.Pattern.Commanpattern:
                        Investigation_CommanPattern commanPattern;
                        //InvestigationValues iVal = commanPattern.GetResult(vid);
                        commanPattern = (Investigation_CommanPattern)this.Page.FindControl(result[i].ToString());
                        List<InvestigationValues> lstcomman = new List<InvestigationValues>();
                        if (commanPattern.IsEditPattern())
                        {
                            lstcomman = commanPattern.GetResult(vid);
                            LstOfBio.Add(lstcomman);
                        }
                        PatientInvestigation PINVComman = commanPattern.GetInvestigations(vid);
                        //PINVComman.GroupName = commanPattern.GroupName;
                        PINVComman.GroupID = commanPattern.GroupID;
                        lstPatientInv.Add(PINVComman);
                        break;


                    case (Int32)TaskHelper.Pattern.BioPattern1:
                        Investigation_checkInvest checkInvest;
                        checkInvest = (Investigation_checkInvest)this.Page.FindControl(result[i].ToString());
                        if (checkInvest.IsEditPattern())
                        {
                            InvestigationValues iVal = checkInvest.GetResult(vid);
                            lstBio1 = new List<InvestigationValues>();
                            //Commented  by Arivalagan kk to save Empty also 
                            //if (iVal.Value != "")
                            //{
                            if (iVal.Value != "")
                            {
                                lstBio1.Add(iVal);
                            }
                            //End
                            LstOfBio.Add(lstBio1);
                        }
                        //if (checkInvest.IsEdit == "True")
                        //{
                        //    InvestigationValues iVal = checkInvest.GetResult(vid);
                        //    lstBio1 = new List<InvestigationValues>();
                        //    if (iVal.Value != "")
                        //    {
                        //        lstBio1.Add(iVal);
                        //    }
                        //    LstOfBio.Add(lstBio1);
                        // }

                        PatientInvestigation PINV1 = checkInvest.GetInvestigations(vid);
                        PINV1.GroupName = checkInvest.GroupName.Replace(":", "");
                        PINV1.GroupID = checkInvest.GroupID;
                        PINV1.AccessionNumber = checkInvest.AccessionNumber;
                        PINV1.IsSensitive = checkInvest.IsSensitive;
                        lstPatientInv.Add(PINV1);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern2:
                        Investigation_BioPattern2 BioPatten2;
                        BioPatten2 = (Investigation_BioPattern2)this.Page.FindControl(result[i].ToString());
                        if (BioPatten2.IsEditPattern())
                        {
                            lstBio2 = BioPatten2.GetResult(vid);
                            LstOfBio.Add(lstBio2);
                        }
                        //if (BioPatten2.IsEdit == "True")
                        //{
                        //    lstBio2 = BioPatten2.GetResult(vid);
                        //    LstOfBio.Add(lstBio2);
                        //}
                        PatientInvestigation PINV2 = BioPatten2.GetInvestigations(vid);
                        PINV2.AccessionNumber = BioPatten2.AccessionNumber;
                        PINV2.GroupName = BioPatten2.GroupName.Replace(":", "");
                        PINV2.GroupID = BioPatten2.GroupID;
                        lstPatientInv.Add(PINV2);
                        break;

                    case (Int32)TaskHelper.Pattern.GTTContentPattern:
                        Investigation_GTTContentPattern GTTContentPattern;
                        GTTContentPattern = (Investigation_GTTContentPattern)this.Page.FindControl(result[i].ToString());
                        if (GTTContentPattern.IsEditPattern())
                        {
                            lstBio2 = GTTContentPattern.GetResult(vid);
                            LstOfBio.Add(lstBio2);
                        }
                        PatientInvestigation GTTPINV = GTTContentPattern.GetInvestigations(vid);
                        GTTPINV.AccessionNumber = GTTContentPattern.AccessionNumber;
                        GTTPINV.GroupName = GTTContentPattern.GroupName.Replace(":", "");
                        GTTPINV.GroupID = GTTContentPattern.GroupID;
                        lstPatientInv.Add(GTTPINV);
                        break;
                    case (Int32)TaskHelper.Pattern.BioPattern3:
                        Investigation_BioPattern3 BioPatten3;
                        BioPatten3 = (Investigation_BioPattern3)this.Page.FindControl(result[i].ToString());
                        if (BioPatten3.IsEditPattern())
                        {
                            lstBio3 = BioPatten3.GetResult(vid);
                            LstOfBio.Add(lstBio3);
                        }
                        PatientInvestigation PINV3 = BioPatten3.GetInvestigations(vid);
                        PINV3.GroupName = BioPatten3.GroupName.Replace(":", "");
                        PINV3.GroupID = BioPatten3.GroupID;
                        PINV3.IsSensitive = BioPatten3.IsSensitive;
                        lstPatientInv.Add(PINV3);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern4:
                        Investigation_BioPattern4 BioPatten4;
                        BioPatten4 = (Investigation_BioPattern4)this.Page.FindControl(result[i].ToString());
                        if (BioPatten4.IsEditPattern())
                        {
                            lstBio4 = BioPatten4.GetResult(vid);
                            LstOfBio.Add(lstBio4);
                        }
                        PatientInvestigation PINV4 = BioPatten4.GetInvestigations(vid);
                        PINV4.GroupName = BioPatten4.GroupName.Replace(":", "");
                        PINV4.GroupID = BioPatten4.GroupID;
                        lstPatientInv.Add(PINV4);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern5:
                        Investigation_BioPattern5 BioPatten5;
                        BioPatten5 = (Investigation_BioPattern5)this.Page.FindControl(result[i].ToString());
                        lstBio5 = BioPatten5.GetResult(vid);
                        LstOfBio.Add(lstBio5);

                        break;

                    case (Int32)TaskHelper.Pattern.FishPattern1:
                        Investigation_FishPattern1 Fishpatten;
                        Fishpatten = (Investigation_FishPattern1)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValFishpattern1 = Fishpatten.GetResult(vid);
                        lstFishpattern1 = new List<InvestigationValues>();
                        //Commented  by Arivalagan kk to save Empty also 
                        //if (iValFishpattern1.Value != "")
                        //{
                        lstFishpattern1.Add(iValFishpattern1);
                        //}
                        LstOfBio.Add(lstFishpattern1);
                        PatientInvestigation PINVFishPattern1 = Fishpatten.GetInvestigations(vid);
                        PINVFishPattern1.AccessionNumber = Fishpatten.AccessionNumber;
                        lstPatientInv.Add(PINVFishPattern1);
                        break;
                    case (Int32)TaskHelper.Pattern.FishPattern2:
                        Investigation_Fishpattern2 Fishpatten3;
                        Fishpatten3 = (Investigation_Fishpattern2)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValFishpattern2 = Fishpatten3.GetResult(vid);
                        lstFishpattern2 = new List<InvestigationValues>();
                        //Commented  by Arivalagan kk to save Empty also 
                        //if (iValFishpattern2.Value != "")
                        //{
                        lstFishpattern2.Add(iValFishpattern2);
                        //}
                        //Ends
                        LstOfBio.Add(lstFishpattern2);
                        PatientInvestigation PINVFishPattern2 = Fishpatten3.GetInvestigations(vid);
                        PINVFishPattern2.AccessionNumber = Fishpatten3.AccessionNumber;
                        lstPatientInv.Add(PINVFishPattern2);
                        break;

                    case (Int32)TaskHelper.Pattern.MultiAddControl:
                        Investigation_MultiAddControl Multiadd;
                        Multiadd = (Investigation_MultiAddControl)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValMultiadd = Multiadd.GetResult(vid);
                        lstMultiAddControl = new List<InvestigationValues>();
                        if (iValMultiadd.Value != "")
                        {
                            lstMultiAddControl.Add(iValMultiadd);
                        }
                        LstOfBio.Add(lstMultiAddControl);
                        PatientInvestigation PINVMultiPattern = Multiadd.GetInvestigations(vid);
                        PINVMultiPattern.AccessionNumber = Multiadd.AccessionNumber;
                        lstPatientInv.Add(PINVMultiPattern);
                        break;

                    case (Int32)TaskHelper.Pattern.ResultFishPattern:
                        Investigation_FishResultPattern ResultFishpatten;
                        ResultFishpatten = (Investigation_FishResultPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValResultFishpattern = ResultFishpatten.GetResult(vid);
                        lstResultFishpattern = new List<InvestigationValues>();
                        if (iValResultFishpattern.Value != "")
                        {
                            lstResultFishpattern.Add(iValResultFishpattern);
                        }
                        LstOfBio.Add(lstResultFishpattern);
                        PatientInvestigation PINVResultFishPattern1 = ResultFishpatten.GetInvestigations(vid);
                        PINVResultFishPattern1.AccessionNumber = ResultFishpatten.AccessionNumber;

                        List<PatientInvestigationFiles> PtFilesProbe = new List<PatientInvestigationFiles>();
                        PtFilesProbe = ResultFishpatten.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesProbe)
                        {
                            PatientInvestigationFiles pFilesProbes = new PatientInvestigationFiles();
                            pFilesProbes.PatientVisitID = ObjP.PatientVisitID;
                            pFilesProbes.ImageSource = ObjP.ImageSource;
                            pFilesProbes.FilePath = ObjP.FilePath;
                            pFilesProbes.CreatedBy = LID;
                            pFilesProbes.OrgID = OrgID;
                            pFilesProbes.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFilesProbes);
                        }


                        lstPatientInv.Add(PINVResultFishPattern1);
                        break;
                    case (Int32)TaskHelper.Pattern.ResultFishPattern1:
                        Investigation_FishResultPattern1 ResultFishPattern1;
                        ResultFishPattern1 = (Investigation_FishResultPattern1)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValResultFishpattern1 = ResultFishPattern1.GetResult(vid);
                        lstResultFishpattern1 = new List<InvestigationValues>();
                        if (iValResultFishpattern1.Value != "")
                        {
                            lstResultFishpattern1.Add(iValResultFishpattern1);
                        }
                        LstOfBio.Add(lstResultFishpattern1);
                        PatientInvestigation PINVResultFishPattern11 = ResultFishPattern1.GetInvestigations(vid);
                        PINVResultFishPattern11.AccessionNumber = ResultFishPattern1.AccessionNumber;

                        List<PatientInvestigationFiles> PtFilesProbe1 = new List<PatientInvestigationFiles>();
                        PtFilesProbe1 = ResultFishPattern1.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesProbe1)
                        {
                            PatientInvestigationFiles pFilesProbes = new PatientInvestigationFiles();
                            pFilesProbes.PatientVisitID = ObjP.PatientVisitID;
                            pFilesProbes.ImageSource = ObjP.ImageSource;
                            pFilesProbes.FilePath = ObjP.FilePath;
                            pFilesProbes.CreatedBy = LID;
                            pFilesProbes.OrgID = OrgID;
                            pFilesProbes.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFilesProbes);
                        }
                        lstPatientInv.Add(PINVResultFishPattern11);
                        break;
                    case (Int32)TaskHelper.Pattern.BRCAPattern:
                        Investigation_BRCAPattern BRCAPattern1;
                        BRCAPattern1 = (Investigation_BRCAPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValBRCA = BRCAPattern1.GetResult(vid);
                        lstBRCA = new List<InvestigationValues>();
                        if (iValBRCA.Value != "")
                        {
                            lstBRCA.Add(iValBRCA);
                        }
                        LstOfBio.Add(lstBRCA);
                        PatientInvestigation PINVBRCA = BRCAPattern1.GetInvestigations(vid);
                        PINVBRCA.AccessionNumber = BRCAPattern1.AccessionNumber;
                        lstPatientInv.Add(PINVBRCA);
                        break;

                    case (Int32)TaskHelper.Pattern.BRCAPattern1:
                        Investigation_BRCAPattern1 BRCAPattern2;
                        BRCAPattern2 = (Investigation_BRCAPattern1)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValBRCA1 = BRCAPattern2.GetResult(vid);
                        lstBRCA1 = new List<InvestigationValues>();
                        if (iValBRCA1.Value != "")
                        {
                            lstBRCA1.Add(iValBRCA1);
                        }
                        LstOfBio.Add(lstBRCA1);
                        PatientInvestigation PINVBRCA1 = BRCAPattern2.GetInvestigations(vid);
                        PINVBRCA1.AccessionNumber = BRCAPattern2.AccessionNumber;
                        lstPatientInv.Add(PINVBRCA1);
                        break;
                    case (Int32)TaskHelper.Pattern.MicroBio1:
                        Investigation_MicroBio1 MicroBioPattern2;
                        MicroBioPattern2 = (Investigation_MicroBio1)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValMicroBiopattern1 = MicroBioPattern2.GetResult(vid);
                        lstMicroBiopattern1 = new List<InvestigationValues>();
                        if (iValMicroBiopattern1.Value != "")
                        {
                            lstMicroBiopattern1.Add(iValMicroBiopattern1);
                        }
                        LstOfBio.Add(lstMicroBiopattern1);
                        PatientInvestigation PINVMicroBioPattern2 = MicroBioPattern2.GetInvestigations(vid);
                        PINVMicroBioPattern2.AccessionNumber = MicroBioPattern2.AccessionNumber;
                        lstPatientInv.Add(PINVMicroBioPattern2);
                        break;

                    case (Int32)TaskHelper.Pattern.MolBioPattern:
                        Investigation_HBVDRUG MolBioPattern1;
                        MolBioPattern1 = (Investigation_HBVDRUG)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValMolBio = MolBioPattern1.GetResult(vid);
                        lstMolBio = new List<InvestigationValues>();
                        if (iValMolBio.Value != "")
                        {
                            lstMolBio.Add(iValMolBio);
                        }
                        LstOfBio.Add(lstMolBio);
                        PatientInvestigation PINVMolBio = MolBioPattern1.GetInvestigations(vid);
                        PINVMolBio.AccessionNumber = MolBioPattern1.AccessionNumber;
                        lstPatientInv.Add(PINVMolBio);
                        break;


                    case (Int32)TaskHelper.Pattern.ImagePattern:
                        Investigation_ImageUploadpattern ImagePattern;
                        ImagePattern = (Investigation_ImageUploadpattern)this.Page.FindControl(result[i].ToString());
                        lstImage = ImagePattern.GetResult(vid);
                        LstOfBio.Add(lstImage);

                        PatientInvestigation PINV = ImagePattern.GetInvestigations(vid);
                        //PINV3.AccessionNumber = BioPatten3.AccessionNumber;               
                        List<PatientInvestigationFiles> PtFiles12 = new List<PatientInvestigationFiles>();
                        PtFiles12 = ImagePattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFiles12)
                        {
                            PatientInvestigationFiles pFiles1 = new PatientInvestigationFiles();
                            pFiles1.PatientVisitID = ObjP.PatientVisitID;
                            pFiles1.ImageSource = ObjP.ImageSource;
                            pFiles1.FilePath = ObjP.FilePath;
                            pFiles1.CreatedBy = LID;
                            pFiles1.OrgID = OrgID;
                            pFiles1.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFiles1);
                        }

                        lstPatientInv.Add(PINV);
                        //SaveTRFPicture();
                        break;

                    case (Int32)TaskHelper.Pattern.MicroPattern:
                        Investigation_MicroPattern MicroPattern;
                        MicroPattern = (Investigation_MicroPattern)this.Page.FindControl(result[i].ToString());
                        if (MicroPattern.IsEditPattern())
                        {
                            lstMicroVal = MicroPattern.GetResult(vid);
                            LstOfBio.Add(lstMicroVal);
                        }
                        PatientInvestigation PINV6 = MicroPattern.GetInvestigations(vid);
                        PINV6.GroupName = MicroPattern.GroupName;
                        PINV6.GroupID = MicroPattern.GroupID;
                        lstPatientInv.Add(PINV6);
                        break;
                    case (Int32)TaskHelper.Pattern.TablepatternautopopulateV2:

                        Investigation_TablePatternV2 TablepatternautopopulateV2;
                        TablepatternautopopulateV2 = (Investigation_TablePatternV2)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValTablepatternautopopulateV2 = TablepatternautopopulateV2.GetResult(vid);
                        lstTablepatternautopopulate = new List<InvestigationValues>();
                        if (iValTablepatternautopopulateV2.Value != "")
                        {
                            lstTablepatternautopopulate.Add(iValTablepatternautopopulateV2);
                        }
                        LstOfBio.Add(lstTablepatternautopopulate);
                        PatientInvestigation PINVTablepatternautopopulateV2 = TablepatternautopopulateV2.GetInvestigations(vid);
                        PINVTablepatternautopopulateV2.AccessionNumber = TablepatternautopopulateV2.AccessionNumber;

                        List<PatientInvestigationFiles> PtFilesTablepatternautopopulateV2 = new List<PatientInvestigationFiles>();
                        PtFilesTablepatternautopopulateV2 = TablepatternautopopulateV2.GetInvestigationFiles(vid, FilePath, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesTablepatternautopopulateV2)
                        {
                            PatientInvestigationFiles pFilesTablepatternautopopulateV2 = new PatientInvestigationFiles();
                            pFilesTablepatternautopopulateV2.PatientVisitID = ObjP.PatientVisitID;
                            pFilesTablepatternautopopulateV2.ImageSource = ObjP.ImageSource;
                            pFilesTablepatternautopopulateV2.FilePath = ObjP.FilePath;
                            pFilesTablepatternautopopulateV2.ServerFilePath = ObjP.ServerFilePath;
                            pFilesTablepatternautopopulateV2.Description = ObjP.ServerFilePath;
                            pFilesTablepatternautopopulateV2.CreatedBy = LID;
                            pFilesTablepatternautopopulateV2.OrgID = OrgID;
                            pFilesTablepatternautopopulateV2.ImageID = ObjP.ImageID;
                            pFilesTablepatternautopopulateV2.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFilesTablepatternautopopulateV2);
                        }


                        lstPatientInv.Add(PINVTablepatternautopopulateV2);
                        break;

                    //case (Int32)TaskHelper.Pattern.HematPattern6:
                    //    Investigation_HematPattern6 HematPattern6;
                    //    HematPattern6 = (Investigation_HematPattern6)this.Page.FindControl(result[i].ToString());
                    //    if (HematPattern6.IsEditPattern())
                    //    {
                    //        lstHemat1 = HematPattern6.GetResult(vid);
                    //        LstOfBio.Add(lstHemat1);
                    //    }
                    //    PatientInvestigation PINV7 = HematPattern6.GetInvestigations(vid);
                    //    PINV7.GroupName = HematPattern6.GroupName;
                    //    PINV7.GroupID = HematPattern6.GroupID;
                    //    lstPatientInv.Add(PINV7);
                    //    break;

                    //case (Int32)TaskHelper.Pattern.HematPattern7:
                    //    Investigation_HematPattern7 HematPattern7;
                    //    HematPattern7 = (Investigation_HematPattern7)this.Page.FindControl(result[i].ToString());
                    //    if (HematPattern7.IsEditPattern())
                    //    {
                    //        lstHemat2 = HematPattern7.GetResult(vid);
                    //        LstOfBio.Add(lstHemat2);
                    //    }
                    //    PatientInvestigation PINV8 = HematPattern7.GetInvestigations(vid);
                    //    PINV8.GroupName = HematPattern7.GroupName;
                    //    PINV8.GroupID = HematPattern7.GroupID;
                    //    lstPatientInv.Add(PINV8);
                    //    break;


                    //case (Int32)TaskHelper.Pattern.HematPattern8:
                    //    Investigation_HematPattern8 HematPattern8;
                    //    HematPattern8 = (Investigation_HematPattern8)this.Page.FindControl(result[i].ToString());
                    //    if (HematPattern8.IsEditPattern())
                    //    {
                    //        lstHemat3 = HematPattern8.GetResult(vid);
                    //        LstOfBio.Add(lstHemat3);
                    //    }
                    //    PatientInvestigation PINV9 = HematPattern8.GetInvestigations(vid);
                    //    PINV9.GroupName = HematPattern8.GroupName;
                    //    PINV9.GroupID = HematPattern8.GroupID;
                    //    lstPatientInv.Add(PINV9);
                    //    break;

                    //case (Int32)TaskHelper.Pattern.HematPattern9:
                    //    Investigation_HematPattern9 HematPattern9;
                    //    HematPattern9 = (Investigation_HematPattern9)this.Page.FindControl(result[i].ToString());

                    //    lstHemat4 = HematPattern9.GetResult(vid);
                    //    LstOfBio.Add(lstHemat4);

                    //    break;

                    //case (Int32)TaskHelper.Pattern.HematPattern10:
                    //    Investigation_HematPattern10 HematPattern10;
                    //    HematPattern10 = (Investigation_HematPattern10)this.Page.FindControl(result[i].ToString());
                    //    if (HematPattern10.IsEditPattern())
                    //    {
                    //        lstHemat5 = HematPattern10.GetResult(vid);
                    //        LstOfBio.Add(lstHemat5);
                    //    }
                    //    PatientInvestigation PINV11 = HematPattern10.GetInvestigations(vid);
                    //    PINV11.GroupName = HematPattern10.GroupName;
                    //    PINV11.GroupID = HematPattern10.GroupID;
                    //    lstPatientInv.Add(PINV11);
                    //    break;


                    //case (Int32)TaskHelper.Pattern.HematPattern11:
                    //    Investigation_HematPattern11 HematPattern11;
                    //    HematPattern11 = (Investigation_HematPattern11)this.Page.FindControl(result[i].ToString());
                    //    if (HematPattern11.IsEditPattern())
                    //    {
                    //        lstHemat6 = HematPattern11.GetResult(vid);
                    //        LstOfBio.Add(lstHemat6);
                    //    }
                    //    PatientInvestigation PINV12 = HematPattern11.GetInvestigations(vid);
                    //    PINV12.GroupName = HematPattern11.GroupName;
                    //    PINV12.GroupID = HematPattern11.GroupID;
                    //    lstPatientInv.Add(PINV12);
                    //    break;

                    //case (Int32)TaskHelper.Pattern.CastPattern:
                    //    Investigation_CastPattern castPattern;
                    //    castPattern = (Investigation_CastPattern)this.Page.FindControl(result[i].ToString());
                    //    if (castPattern.IsEditPattern())
                    //    {
                    //        lstCast = castPattern.GetResult(vid);
                    //        LstOfBio.Add(lstCast);
                    //    }
                    //    PatientInvestigation PINV13 = castPattern.GetInvestigations(vid);
                    //    PINV13.GroupName = castPattern.GroupName;
                    //    PINV13.GroupID = castPattern.GroupID;
                    //    lstPatientInv.Add(PINV13);

                    //    break;


                    //case (Int32)TaskHelper.Pattern.DifferentialPattern:
                    //    Investigation_DifferentialPattern DifferPattern;
                    //    DifferPattern = (Investigation_DifferentialPattern)this.Page.FindControl(result[i].ToString());
                    //    if (DifferPattern.IsEditPattern())
                    //    {
                    //        lstHemat6 = DifferPattern.GetResult(vid);
                    //        LstOfBio.Add(lstHemat6);
                    //    }
                    //    PatientInvestigation PINV14 = DifferPattern.GetInvestigations(vid);
                    //    PINV14.GroupName = DifferPattern.GroupName;
                    //    PINV14.GroupID = DifferPattern.GroupID;
                    //    lstPatientInv.Add(PINV14);
                    //    break;


                    case (Int32)TaskHelper.Pattern.ClinicalPattern12:
                        Investigation_ClinicalPattern12 Clinical12;
                        Clinical12 = (Investigation_ClinicalPattern12)this.Page.FindControl(result[i].ToString());
                        if (Clinical12.IsEditPattern())
                        {
                            lstclinic12 = Clinical12.GetResult(vid);
                            LstOfBio.Add(lstclinic12);
                        }
                        PatientInvestigation PINV15 = Clinical12.GetInvestigations(vid);
                        PINV15.GroupName = Clinical12.GroupName.Replace(":", "");
                        PINV15.GroupID = Clinical12.GroupID;
                        lstPatientInv.Add(PINV15);
                        break;


                    case (Int32)TaskHelper.Pattern.ClinicalPattern13:
                        Investigation_ClinicalPattern13 Clinical13;
                        Clinical13 = (Investigation_ClinicalPattern13)this.Page.FindControl(result[i].ToString());
                        if (Clinical13.IsEditPattern())
                        {
                            lstclinic13 = Clinical13.GetResult(vid);
                            LstOfBio.Add(lstclinic13);
                        }
                        PatientInvestigation PINV16 = Clinical13.GetInvestigations(vid);
                        PINV16.GroupName = Clinical13.GroupName.Replace(":", "");
                        PINV16.GroupID = Clinical13.GroupID;
                        lstPatientInv.Add(PINV16);
                        break;

                    //case (Int32)TaskHelper.Pattern.ANAPattern:
                    //    Investigation_ANAPattern ANAPattern;
                    //    ANAPattern = (Investigation_ANAPattern)this.Page.FindControl(result[i].ToString());
                    //    if (ANAPattern.IsEditPattern())
                    //    {
                    //        lstANA = ANAPattern.GetResult(vid);
                    //        LstOfBio.Add(lstANA);
                    //    }
                    //    PatientInvestigation PINV17 = ANAPattern.GetInvestigations(vid);
                    //    PINV17.GroupName = ANAPattern.GroupName;
                    //    PINV17.GroupID = ANAPattern.GroupID;
                    //    lstPatientInv.Add(PINV17);
                    //    break;

                    //case (Int32)TaskHelper.Pattern.WidelPattern:
                    //    Investigation_WidelPattern Widelpattern;
                    //    Widelpattern = (Investigation_WidelPattern)this.Page.FindControl(result[i].ToString());
                    //    if (Widelpattern.IsEditPattern())
                    //    {
                    //        lstWidel = Widelpattern.GetResult(vid);
                    //        LstOfBio.Add(lstWidel);
                    //    }
                    //    PatientInvestigation PINV18 = Widelpattern.GetInvestigations(vid);
                    //    PINV18.GroupName = Widelpattern.GroupName;
                    //    PINV18.GroupID = Widelpattern.GroupID;
                    //    lstPatientInv.Add(PINV18);
                    //    break;


                    case (Int32)TaskHelper.Pattern.FluidPattern:
                        Investigation_FluidPattern fluidpattern;
                        fluidpattern = (Investigation_FluidPattern)this.Page.FindControl(result[i].ToString());
                        if (fluidpattern.IsEditPattern())
                        {
                            lstFluid = fluidpattern.GetResult(vid);
                            LstOfBio.Add(lstFluid);
                        }
                        PatientInvestigation PINV19 = fluidpattern.GetInvestigations(vid);
                        PINV19.GroupName = fluidpattern.GroupName.Replace(":", "");
                        PINV19.GroupID = fluidpattern.GroupID;
                        lstPatientInv.Add(PINV19);
                        break;

                    case (Int32)TaskHelper.Pattern.hpPattern:
                        Investigation_HistoPathologyPattern histpathologypattern;
                        histpathologypattern = (Investigation_HistoPathologyPattern)this.Page.FindControl(result[i].ToString());

                        lstHPP = histpathologypattern.GetResult(vid);
                        LstOfBio.Add(lstHPP);

                        PatientInvestigation PINV20 = histpathologypattern.GetInvestigations(vid);
                        lPFiles = histpathologypattern.GetInvestigationFiles(vid, out Flag);
                        PINV20.GroupName = histpathologypattern.GroupName.Replace(":", "");
                        PINV20.GroupID = histpathologypattern.GroupID;
                        lstPatientInv.Add(PINV20);
                        break;

                    case (Int32)TaskHelper.Pattern.hpPatternQuantum:
                        Investigation_HistoPathologyPatternQuantum histpathologypatternQuantum;
                        histpathologypatternQuantum = (Investigation_HistoPathologyPatternQuantum)this.Page.FindControl(result[i].ToString());

                        lstHPP = histpathologypatternQuantum.GetResult(vid);
                        LstOfBio.Add(lstHPP);

                        PatientInvestigation PINVhisto = histpathologypatternQuantum.GetInvestigations(vid);
                        lPFiles = histpathologypatternQuantum.GetInvestigationFiles(vid, out Flag);
                        PINVhisto.GroupName = histpathologypatternQuantum.GroupName;
                        PINVhisto.GroupID = histpathologypatternQuantum.GroupID;
                        lstPatientInv.Add(PINVhisto);
                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivity:
                        Investigation_CultureandSensitivityReport culture;
                        culture = (Investigation_CultureandSensitivityReport)this.Page.FindControl(result[i].ToString());
                        if (culture.IsEditPattern())
                        {
                            lstHPP = culture.GetResult(vid);
                            LstOfBio.Add(lstHPP);
                        }
                        PatientInvestigation CultureTest = culture.GetInvestigations(vid);
                        CultureTest.GroupName = culture.GroupName.Replace(":", "");
                        CultureTest.GroupID = culture.GroupID;
                        lstPatientInv.Add(CultureTest);
                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivityV1:
                        Investigation_CultureandSensitivityReportV1 cultureV1;
                        cultureV1 = (Investigation_CultureandSensitivityReportV1)this.Page.FindControl(result[i].ToString());
                        if (cultureV1.IsEditPattern())
                        {
                            lstHPP = cultureV1.GetResult(vid);
                            LstOfBio.Add(lstHPP);
                        }
                        PatientInvestigation CultureTestV1 = cultureV1.GetInvestigations(vid);
                        CultureTestV1.GroupName = cultureV1.GroupName.Replace(":", "");
                        CultureTestV1.GroupID = cultureV1.GroupID;
                        lstPatientInv.Add(CultureTestV1);
                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivityV2:
                        Investigation_CultureandSensitivityReportV2 cultureV2;
                        cultureV2 = (Investigation_CultureandSensitivityReportV2)this.Page.FindControl(result[i].ToString());
                        lstHPP = cultureV2.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation CultureTestV2 = cultureV2.GetInvestigations(vid);
                        lstPatientInv.Add(CultureTestV2);
                        break;

                    case (Int32)TaskHelper.Pattern.StoneAnalysis:
                        Investigation_StoneAnalysis stoneAnalysis;
                        stoneAnalysis = (Investigation_StoneAnalysis)this.Page.FindControl(result[i].ToString());
                        if (stoneAnalysis.IsEditPattern())
                        {
                            lstHPP = stoneAnalysis.GetResult(vid);
                            LstOfBio.Add(lstHPP);
                        }
                        PatientInvestigation lstStoneAnalysis = stoneAnalysis.GetInvestigations(vid);
                        lstStoneAnalysis.GroupName = stoneAnalysis.GroupName.Replace(":", "");
                        lstStoneAnalysis.GroupID = stoneAnalysis.GroupID;
                        lstPatientInv.Add(lstStoneAnalysis);
                        break;

                    case (Int32)TaskHelper.Pattern.microbiopattern:
                        Investigation_MicroBioPattern1 microbiopattern1;
                        microbiopattern1 = (Investigation_MicroBioPattern1)this.Page.FindControl(result[i].ToString());
                        if (microbiopattern1.IsEditPattern())
                        {
                            lstMicBioPattern1 = microbiopattern1.GetResult(vid);
                            LstOfBio.Add(lstMicBioPattern1);
                        }
                        PatientInvestigation PINV22 = microbiopattern1.GetInvestigations(vid);
                        PINV22.GroupName = microbiopattern1.GroupName.Replace(":", "");
                        PINV22.GroupID = microbiopattern1.GroupID;
                        lstPatientInv.Add(PINV22);
                        break;

                    case (Int32)TaskHelper.Pattern.faCellsPattern:
                        Investigation_FluidAnalysisCellsPattern facp;
                        facp = (Investigation_FluidAnalysisCellsPattern)this.Page.FindControl(result[i].ToString());
                        if (facp.IsEditPattern())
                        {
                            lstFACellsPattern = facp.GetResult(vid);
                            LstOfBio.Add(lstFACellsPattern);
                        }
                        PatientInvestigation PINV23 = facp.GetInvestigations(vid);
                        PINV23.GroupName = facp.GroupName.Replace(":", "");
                        PINV23.GroupID = facp.GroupID;
                        lstPatientInv.Add(PINV23);
                        break;

                    case (Int32)TaskHelper.Pattern.BodyFluidAnalysis:
                        Investigation_Body_Fluid_Analysis BFA;
                        BFA = (Investigation_Body_Fluid_Analysis)this.Page.FindControl(result[i].ToString());
                        if (BFA.IsEditPattern())
                        {
                            lstBodyFluidAnalysisPattern = BFA.GetResult(vid);
                            LstOfBio.Add(lstBodyFluidAnalysisPattern);
                        }
                        PatientInvestigation PINVBFA = BFA.GetInvestigations(vid);
                        PINVBFA.GroupName = BFA.GroupName.Replace(":", "");
                        PINVBFA.GroupID = BFA.GroupID;
                        lstPatientInv.Add(PINVBFA);
                        break;

                    case (Int32)TaskHelper.Pattern.SMEAR:
                        Investigation_SmearAnalysis smear;
                        smear = (Investigation_SmearAnalysis)this.Page.FindControl(result[i].ToString());
                        if (smear.IsEditPattern())
                        {
                            lstSmearPattern = smear.GetResult(vid);
                            LstOfBio.Add(lstSmearPattern);
                        }
                        PatientInvestigation PINVsmear = smear.GetInvestigations(vid);
                        PINVsmear.GroupName = smear.GroupName.Replace(":", "");
                        PINVsmear.GroupID = smear.GroupID;
                        lstPatientInv.Add(PINVsmear);
                        break;

                    case (Int32)TaskHelper.Pattern.SemenAnalysisNewPattern:
                        Investigation_SemenAnalysisNewPattern SANP;
                        SANP = (Investigation_SemenAnalysisNewPattern)this.Page.FindControl(result[i].ToString());
                        if (SANP.IsEditPattern())
                        {
                            lstSemenAnalysisNewPattern = SANP.GetResult(vid);
                            LstOfBio.Add(lstSemenAnalysisNewPattern);
                        }
                        PatientInvestigation PINVSANP = SANP.GetInvestigations(vid);
                        PINVSANP.GroupName = SANP.GroupName.Replace(":", "");
                        PINVSANP.GroupID = SANP.GroupID;
                        lstPatientInv.Add(PINVSANP);
                        break;

                    case (Int32)TaskHelper.Pattern.faChemistryPattern:
                        Investigation_FluidAnalysisChemistryPattern fachp;
                        fachp = (Investigation_FluidAnalysisChemistryPattern)this.Page.FindControl(result[i].ToString());
                        if (fachp.IsEditPattern())
                        {
                            lstFAChemistryPattern = fachp.GetResult(vid);
                            LstOfBio.Add(lstFAChemistryPattern);
                        }
                        PatientInvestigation PINV24 = fachp.GetInvestigations(vid);
                        PINV24.GroupName = fachp.GroupName.Replace(":", "");
                        PINV24.GroupID = fachp.GroupID;
                        lstPatientInv.Add(PINV24);
                        break;

                    case (Int32)TaskHelper.Pattern.faCytologyPattern:
                        Investigation_FluidAnalysisCytologyPattern facyp;
                        facyp = (Investigation_FluidAnalysisCytologyPattern)this.Page.FindControl(result[i].ToString());
                        if (facyp.IsEditPattern())
                        {
                            lstFACytologyPattern = facyp.GetResult(vid);
                            LstOfBio.Add(lstFACytologyPattern);
                        }
                        PatientInvestigation PINV25 = facyp.GetInvestigations(vid);
                        PINV25.GroupName = facyp.GroupName.Replace(":", "");
                        PINV25.GroupID = facyp.GroupID;
                        lstPatientInv.Add(PINV25);
                        break;

                    case (Int32)TaskHelper.Pattern.faImmunologyPattern:
                        Investigation_FluidAnalysisImmunolgyPattern faimp;
                        faimp = (Investigation_FluidAnalysisImmunolgyPattern)this.Page.FindControl(result[i].ToString());
                        if (faimp.IsEditPattern())
                        {
                            lstFAImmunologyPattern = faimp.GetResult(vid);
                            LstOfBio.Add(lstFAImmunologyPattern);
                        }
                        PatientInvestigation PINV26 = faimp.GetInvestigations(vid);
                        PINV26.GroupName = faimp.GroupName.Replace(":", "");
                        PINV26.GroupID = faimp.GroupID;
                        lstPatientInv.Add(PINV26);
                        break;

                    case (Int32)TaskHelper.Pattern.FungalSmearPattern:
                        Investigation_FungalSmearPattern fsp;
                        fsp = (Investigation_FungalSmearPattern)this.Page.FindControl(result[i].ToString());
                        if (fsp.IsEditPattern())
                        {
                            lstFSmearPattern = fsp.GetResult(vid);
                            LstOfBio.Add(lstFSmearPattern);
                        }
                        PatientInvestigation PINV28 = fsp.GetInvestigations(vid);
                        PINV28.GroupName = fsp.GroupName.Replace(":", "");
                        PINV28.GroupID = fsp.GroupID;
                        lstPatientInv.Add(PINV28);
                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyWithMethod:
                        Investigation_AntibodyWithMethod ABMethod;
                        ABMethod = (Investigation_AntibodyWithMethod)this.Page.FindControl(result[i].ToString());
                        if (ABMethod.IsEditPattern())
                        {
                            lstABMethod = ABMethod.GetResult(vid);
                            LstOfBio.Add(lstABMethod);
                        }
                        PatientInvestigation PINV29 = ABMethod.GetInvestigations(vid);
                        PINV29.GroupName = ABMethod.GroupName.Replace(":", "");
                        PINV29.GroupID = ABMethod.GroupID;
                        lstPatientInv.Add(PINV29);
                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyQualitative:
                        Investigation_AntibodyQualitative Qualitative;
                        Qualitative = (Investigation_AntibodyQualitative)this.Page.FindControl(result[i].ToString());
                        if (Qualitative.IsEditPattern())
                        {
                            lstABQualitative = Qualitative.GetResult(vid);
                            LstOfBio.Add(lstABQualitative);
                        }
                        PatientInvestigation PINV30 = Qualitative.GetInvestigations(vid);
                        PINV30.GroupName = Qualitative.GroupName.Replace(":", "");
                        PINV30.GroupID = Qualitative.GroupID;
                        lstPatientInv.Add(PINV30);
                        break;

                    case (Int32)TaskHelper.Pattern.Semenanalysis:
                        Investigation_SemenAnalysis Semenanalysis;
                        Semenanalysis = (Investigation_SemenAnalysis)this.Page.FindControl(result[i].ToString());
                        if (Semenanalysis.IsEditPattern())
                        {
                            lstSemenanalysis = Semenanalysis.GetResult(vid);
                            LstOfBio.Add(lstSemenanalysis);
                        }
                        PatientInvestigation PINV31 = Semenanalysis.GetInvestigations(vid);
                        PINV31.GroupName = Semenanalysis.GroupName.Replace(":", "");
                        PINV31.GroupID = Semenanalysis.GroupID;
                        lstPatientInv.Add(PINV31);
                        break;


                    case (Int32)TaskHelper.Pattern.Imaging:
                        Investigation_ImagingWithFCKEditor Imaging;
                        Imaging = (Investigation_ImagingWithFCKEditor)this.Page.FindControl(result[i].ToString());

                        lstImaging = Imaging.GetResult(vid, out Flag);
                        if (lstImaging.Count > 0)
                        {
                            LstOfBio.Add(lstImaging);
                        }
                        PatientInvestigation PINV32 = Imaging.GetInvestigations(vid);
                        PINV32.GroupName = Imaging.GroupName.Replace(":", "");
                        PINV32.GroupID = Imaging.GroupID;
                        if (PINV32 != null)
                        {
                            lstPatientInv.Add(PINV32);
                        }
                        break;

                    case (Int32)TaskHelper.Pattern.PheripheralSmear:
                        Investigation_PeripheralSmear phSmear;
                        phSmear = (Investigation_PeripheralSmear)this.Page.FindControl(result[i].ToString());
                        if (phSmear.IsEditPattern())
                        {
                            lstphsmear = phSmear.GetResult(vid);
                            LstOfBio.Add(lstphsmear);
                        }
                        PatientInvestigation PINV33 = phSmear.GetInvestigations(vid);
                        PINV33.GroupName = phSmear.GroupName.Replace(":", "");
                        PINV33.GroupID = phSmear.GroupID;
                        lstPatientInv.Add(PINV33);
                        break;

                    case (Int32)TaskHelper.Pattern.BleedingTime:
                        Investigation_BleedingTime bleedingtime;
                        bleedingtime = (Investigation_BleedingTime)this.Page.FindControl(result[i].ToString());
                        if (bleedingtime.IsEditPattern())
                        {
                            lstBleedingtime = bleedingtime.GetResult(vid);
                            LstOfBio.Add(lstBleedingtime);
                        }
                        PatientInvestigation PINVbleedingtime = bleedingtime.GetInvestigations(vid);
                        PINVbleedingtime.GroupName = bleedingtime.GroupName.Replace(":", "");
                        PINVbleedingtime.GroupID = bleedingtime.GroupID;
                        lstPatientInv.Add(PINVbleedingtime);
                        break;

                    case (Int32)TaskHelper.Pattern.TextualPattern:
                        Investigation_TextualPattern TxtPattern;
                        TxtPattern = (Investigation_TextualPattern)this.Page.FindControl(result[i].ToString());
                        if (TxtPattern.IsEditPattern())
                        {
                            lTxtpattern = TxtPattern.GetResult(vid);
                            LstOfBio.Add(lTxtpattern);
                        }
                        PatientInvestigation PINVTxtPattern = TxtPattern.GetInvestigations(vid);
                        PINVTxtPattern.GroupName = TxtPattern.GroupName.Replace(":", "");
                        PINVTxtPattern.GroupID = TxtPattern.GroupID;
                        lstPatientInv.Add(PINVTxtPattern);
                        break;

                    case (Int32)TaskHelper.Pattern.GTT:
                        Investigation_GTT Gtt;
                        Gtt = (Investigation_GTT)this.Page.FindControl(result[i].ToString());
                        if (Gtt.IsEditPattern())
                        {
                            lTxtpattern = Gtt.GetResult(vid);
                            LstOfBio.Add(lTxtpattern);
                        }
                        PatientInvestigation PINVGtt = Gtt.GetInvestigations(vid);
                        PINVGtt.GroupName = Gtt.GroupName.Replace(":", "");
                        PINVGtt.GroupID = Gtt.GroupID;
                        lstPatientInv.Add(PINVGtt);
                        break;
                    case (Int32)TaskHelper.Pattern.OrganismDrugPattern:
                        Investigation_OrganismDrugPattern OrgDrugPattern;
                        OrgDrugPattern = (Investigation_OrganismDrugPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValOrgDrugPattern = OrgDrugPattern.GetResult(vid);
                        lstOrgDrugPattern = new List<InvestigationValues>();
                        if (iValOrgDrugPattern.Value != "")
                        {
                            lstOrgDrugPattern.Add(iValOrgDrugPattern);
                        }
                        LstOfBio.Add(lstOrgDrugPattern);
                        PatientInvestigation PINVOrgDrugPattern = OrgDrugPattern.GetInvestigations(vid);
                        PINVOrgDrugPattern.AccessionNumber = OrgDrugPattern.AccessionNumber;
                        lstPatientInv.Add(PINVOrgDrugPattern);
                        break;
                    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
                    case (Int32)TaskHelper.Pattern.OrganismDrugPatternWithLevel:
                        Investigation_OrganismDrugPatternWithLevel OrganismDrugPatternWithLevel;
                        OrganismDrugPatternWithLevel = (Investigation_OrganismDrugPatternWithLevel)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValOrgDrugPatternWithLevel = OrganismDrugPatternWithLevel.GetResult(vid);
                        lstOrgDrugPattern = new List<InvestigationValues>();
                        if (iValOrgDrugPatternWithLevel.Value != "")
                        {
                            lstOrgDrugPattern.Add(iValOrgDrugPatternWithLevel);
                        }
                        LstOfBio.Add(lstOrgDrugPattern);
                        PatientInvestigation PINVOrgDrugPatternWithLevel = OrganismDrugPatternWithLevel.GetInvestigations(vid);
                        PINVOrgDrugPatternWithLevel.AccessionNumber = OrganismDrugPatternWithLevel.AccessionNumber;
                        lstPatientInv.Add(PINVOrgDrugPatternWithLevel);
                        break;

                    /* END | sabari | 20181129 | Dev | Culture Report */
                    case (Int32)TaskHelper.Pattern.MicroStainPattern:
                        Investigation_MicroStainPattern MicroStainPattern;
                        MicroStainPattern = (Investigation_MicroStainPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValMicroStainPattern = MicroStainPattern.GetResult(vid);
                        lstMicroStainPattern = new List<InvestigationValues>();
                        if (iValMicroStainPattern.Value != "")
                        {
                            lstMicroStainPattern.Add(iValMicroStainPattern);
                        }
                        LstOfBio.Add(lstMicroStainPattern);
                        PatientInvestigation PINVMicroStainPattern = MicroStainPattern.GetInvestigations(vid);
                        PINVMicroStainPattern.AccessionNumber = MicroStainPattern.AccessionNumber;
                        lstPatientInv.Add(PINVMicroStainPattern);
                        break;
                    case (Int32)TaskHelper.Pattern.HEMATOLOGY:
                        Investigation_HEMATOLOGY HEMATOLOGY;
                        HEMATOLOGY = (Investigation_HEMATOLOGY)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValHEMATOLOGY = HEMATOLOGY.GetResult(vid);
                        lstHEMATOLOGYPattern = new List<InvestigationValues>();
                        if (iValHEMATOLOGY.Value != "")
                        {
                            lstHEMATOLOGYPattern.Add(iValHEMATOLOGY);
                        }
                        LstOfBio.Add(lstHEMATOLOGYPattern);
                        PatientInvestigation PINVHEMATOLOGYPattern = HEMATOLOGY.GetInvestigations(vid);
                        PINVHEMATOLOGYPattern.AccessionNumber = HEMATOLOGY.AccessionNumber;
                        lstPatientInv.Add(PINVHEMATOLOGYPattern);
                        break;

                    case (Int32)TaskHelper.Pattern.GeneralPattern:
                        Investigation_GeneralPattern GeneralPattern;
                        GeneralPattern = (Investigation_GeneralPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValGeneralPattern = GeneralPattern.GetResult(vid);
                        lstGeneralPattern = new List<InvestigationValues>();
                        if (iValGeneralPattern.Value != "")
                        {
                            lstGeneralPattern.Add(iValGeneralPattern);
                        }
                        LstOfBio.Add(lstGeneralPattern);
                        PatientInvestigation PINVGeneralPattern = GeneralPattern.GetInvestigations(vid);
                        PINVGeneralPattern.AccessionNumber = GeneralPattern.AccessionNumber;

                        List<PatientInvestigationFiles> PtFilesGeneralPattern = new List<PatientInvestigationFiles>();
                        PtFilesGeneralPattern = GeneralPattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesGeneralPattern)
                        {
                            PatientInvestigationFiles pFilesGeneralPattern = new PatientInvestigationFiles();
                            pFilesGeneralPattern.PatientVisitID = ObjP.PatientVisitID;
                            pFilesGeneralPattern.ImageSource = ObjP.ImageSource;
                            pFilesGeneralPattern.FilePath = ObjP.FilePath;
                            pFilesGeneralPattern.CreatedBy = LID;
                            pFilesGeneralPattern.OrgID = OrgID;
                            pFilesGeneralPattern.ImageID = ObjP.ImageID;
                            pFilesGeneralPattern.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFilesGeneralPattern);
                        }


                        lstPatientInv.Add(PINVGeneralPattern);
                        break;

                    case (Int32)TaskHelper.Pattern.Tablepatternautopopulate:
                        Investigation_Tablepatternautopopulate Tablepatternautopopulate;
                        Tablepatternautopopulate = (Investigation_Tablepatternautopopulate)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValTablepatternautopopulate = Tablepatternautopopulate.GetResult(vid);
                        lstTablepatternautopopulate = new List<InvestigationValues>();
                        if (iValTablepatternautopopulate.Value != "")
                        {
                            lstTablepatternautopopulate.Add(iValTablepatternautopopulate);
                        }
                        LstOfBio.Add(lstTablepatternautopopulate);
                        PatientInvestigation PINVTablepatternautopopulate = Tablepatternautopopulate.GetInvestigations(vid);
                        PINVTablepatternautopopulate.AccessionNumber = Tablepatternautopopulate.AccessionNumber;

                        List<PatientInvestigationFiles> PtFilesTablepatternautopopulate = new List<PatientInvestigationFiles>();
                        PtFilesTablepatternautopopulate = Tablepatternautopopulate.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesTablepatternautopopulate)
                        {
                            PatientInvestigationFiles pFilesTablepatternautopopulate = new PatientInvestigationFiles();
                            pFilesTablepatternautopopulate.PatientVisitID = ObjP.PatientVisitID;
                            pFilesTablepatternautopopulate.ImageSource = ObjP.ImageSource;
                            pFilesTablepatternautopopulate.FilePath = ObjP.FilePath;
                            pFilesTablepatternautopopulate.CreatedBy = LID;
                            pFilesTablepatternautopopulate.OrgID = OrgID;
                            pFilesTablepatternautopopulate.ImageID = ObjP.ImageID;
                            pFilesTablepatternautopopulate.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFilesTablepatternautopopulate);
                        }


                        lstPatientInv.Add(PINVTablepatternautopopulate);
                        break;

                    case (Int32)TaskHelper.Pattern.RichTextPattern:
                        Investigation_RichTextPattern RichTextPattern;
                        RichTextPattern = (Investigation_RichTextPattern)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValRichTextPattern = RichTextPattern.GetResult(vid);
                        lstRichTextPattern = new List<InvestigationValues>();
                        if (iValRichTextPattern.Value != "")
                        {
                            lstRichTextPattern.Add(iValRichTextPattern);
                        }
                        LstOfBio.Add(lstRichTextPattern);
                        PatientInvestigation PINVRichTextPattern = RichTextPattern.GetInvestigations(vid);
                        PINVRichTextPattern.AccessionNumber = RichTextPattern.AccessionNumber;
                        lstPatientInv.Add(PINVRichTextPattern);
                        break;
                    case (Int32)TaskHelper.Pattern.PDFUploadpattern:
                        Investigation_PDFUploadpattern PDFUpload;
                        PDFUpload = (Investigation_PDFUploadpattern)this.Page.FindControl(result[i].ToString());
                        lstPDF = PDFUpload.GetResult(vid);
                        LstOfBio.Add(lstPDF);

                        PatientInvestigation PatientInvest = PDFUpload.GetInvestigations(vid);
                        //PINV3.AccessionNumber = BioPatten3.AccessionNumber;               
                        List<PatientInvestigationFiles> PatientFiles12 = new List<PatientInvestigationFiles>();
                        PatientFiles12 = PDFUpload.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PatientFiles12)
                        {
                            PatientInvestigationFiles pFiles1 = new PatientInvestigationFiles();
                            pFiles1.PatientVisitID = ObjP.PatientVisitID;
                            pFiles1.ImageSource = ObjP.ImageSource;
                            pFiles1.FilePath = ObjP.FilePath;
                            pFiles1.CreatedBy = LID;
                            pFiles1.OrgID = OrgID;
                            pFiles1.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFiles1);

                        }

                        lstPatientInv.Add(PatientInvest);
                        break;
                    case (Int32)TaskHelper.Pattern.HistoImageDescriptionPattern:
                        Investigation_HistoImageDescriptionPattern HistoImageDescriptionPattern;
                        HistoImageDescriptionPattern = (Investigation_HistoImageDescriptionPattern)this.Page.FindControl(result[i].ToString());
                        lstHistoImageDescriptionPattern = HistoImageDescriptionPattern.GetResult(vid);
                        LstOfBio.Add(lstHistoImageDescriptionPattern);
                        PatientInvestigation PtHistoFiles1 = HistoImageDescriptionPattern.GetInvestigations(vid);
                        lPFiles = HistoImageDescriptionPattern.GetInvestigationFiles(vid, out Flag);
                        PtHistoFiles1.GroupName = HistoImageDescriptionPattern.GroupName;
                        PtHistoFiles1.GroupID = HistoImageDescriptionPattern.GroupID;
                        lstPatientInv.Add(PtHistoFiles1);
                        break;


                    case (Int32)TaskHelper.Pattern.ImageDescriptionpattern:
                        Investigation_ImageDescriptionpattern ImageDescriptionpattern;
                        ImageDescriptionpattern = (Investigation_ImageDescriptionpattern)this.Page.FindControl(result[i].ToString());
                        lstImageDescriptionpattern = ImageDescriptionpattern.GetResult(vid);
                        LstOfBio.Add(lstImageDescriptionpattern);

                        PatientInvestigation ptdes1 = ImageDescriptionpattern.GetInvestigations(vid);
                        //PINV3.AccessionNumber = BioPatten3.AccessionNumber;               
                        List<PatientInvestigationFiles> ptdes2 = new List<PatientInvestigationFiles>();
                        ptdes2 = ImageDescriptionpattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in ptdes2)
                        {
                            PatientInvestigationFiles ptdes3 = new PatientInvestigationFiles();
                            ptdes3.PatientVisitID = ObjP.PatientVisitID;
                            ptdes3.ImageSource = ObjP.ImageSource;
                            ptdes3.FilePath = ObjP.FilePath;
                            ptdes3.CreatedBy = LID;
                            ptdes3.OrgID = OrgID;
                            ptdes3.InvestigationID = ObjP.InvestigationID;
                            ptdes3.Description = ObjP.Description;
                            lPFiles.Add(ptdes3);
                        }

                        lstPatientInv.Add(ptdes1);
                        break;
                }
            }
            /* BEGIN | NA | Sabari | 20181202 | Created | HOLD */
            ///Added This code blog region UNHOLDTASK for skip Enter Result to perform UnHold and Regenerate Report Based IsReportable flag ///
            #region UNHOLDTASK
            if (Request.QueryString["IsHold"] != null && Request.QueryString["IsHold"] == "Y")
            {
                Investigation_BL objinvbl = new Investigation_BL(base.ContextInfo);
                returnCode = objinvbl.SaveUnHoldDetails(lstPatientInv);


                /* Notification Insert Start */
                if (lstPatientInv.Count > 0)
                {
                    int cnt = 0;
                    int cntPA = 0;
                    int cntWH = 0;
                    int cntRJ = 0;
                    int reclt = 0;
                    int UnholdNotify = 0;
                    cnt = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
                    cntPA = lstPatientInv.FindAll(p => p.Status == "PartiallyApproved").Count();
                    cntWH = lstPatientInv.FindAll(p => p.Status == "With Held").Count();
                    cntRJ = lstPatientInv.FindAll(p => p.Status == "Reject").Count();
                    reclt = lstPatientInv.FindAll(p => p.Status == "Retest").Count();
                    UnholdNotify = lstPatientInv.FindAll(p => p.Status == "UnHold").Count();
                    DemoBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out lstorderInvforVisit);

                    bool IsResult = false;

                    var PkgId = (from grp in lstorderInvforVisit
                                 where grp.IsCoPublish == "Y" && grp.PkgID != 0
                                 select grp.PkgID).Distinct().ToList();
                    List<string> lstInvStatus = new List<string>();
                    lstInvStatus.Add("approve");
                    lstInvStatus.Add("partiallyapproved");
                    int NonCoPublishTestCount = (from grp in lstorderInvforVisit
                                                 where grp.IsCoPublish != "Y" && grp.PkgID >= 0 && lstInvStatus.Contains(grp.Status.ToLower())
                                                 select grp).Count();

                    if (NonCoPublishTestCount == 0)
                    {
                        foreach (var item in PkgId)
                        //for (int i = 0; i < PkgId.Count; i++)
                        {
                            int CoPublishPkgCount = (from grp in lstorderInvforVisit
                                                     where grp.IsCoPublish == "Y" && grp.PkgID != 0 && grp.PkgID == item
                                                     select grp).Count();
                            int CoPublishPkgApprovalCount = (from grp in lstorderInvforVisit
                                                             where grp.IsCoPublish == "Y" && grp.PkgID != 0 && lstInvStatus.Contains(grp.Status.ToLower()) && grp.PkgID == item
                                                             select grp).Count();
                            if (CoPublishPkgCount == CoPublishPkgApprovalCount)
                            {
                                IsResult = true;
                                break;
                            }
                        }
                    }
                    #region RetestNotifyNotNeededforUnhold
                    //if (reclt > 0)
                    //{
                    //    List<PatientInvestigation> access = lstPatientInv.FindAll(P => P.Status == InvStatus.Retest);
                    //    if (access.Count > 0)
                    //    {
                    //        foreach (PatientInvestigation pinv in access)
                    //        {
                    //            OrderedInvestigations objinv = new OrderedInvestigations();
                    //            objinv.AccessionNumber = pinv.AccessionNumber;
                    //            accessionnumber += objinv.AccessionNumber.ToString() + ",";
                    //        }
                    //        ActionManager AM = new ActionManager(base.ContextInfo);
                    //        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    //        PageContextkey PC = new PageContextkey();
                    //        PC.ID = Convert.ToInt64(ILocationID);
                    //        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    //        PC.RoleID = Convert.ToInt64(RoleID);
                    //        PC.OrgID = OrgID;
                    //        PC.PatientVisitID = vid;
                    //        PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                    //        PC.ButtonName = PageContextDetails.ButtonName;
                    //        PC.ButtonValue = PageContextDetails.ButtonValue;
                    //        PC.IDS = accessionnumber;
                    //        lstpagecontextkeys.Add(PC);
                    //        long res = -1;
                    //        res = AM.PerformingNextStepNotification(PC, "", "");
                    //    }
                    //}
                   #endregion 


                    if (UnholdNotify > 0 || cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
                    {
					// Performing Next Action insert while unhold -- Merge from Narayana Seetha
                       // if ((NonCoPublishTestCount > 0) || (IsResult == true))
                       // {
                            ActionManager AM = new ActionManager(base.ContextInfo);
                            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                            PageContextkey PC = new PageContextkey();
                            PC.ID = Convert.ToInt64(ILocationID);
                            PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                            PC.RoleID = Convert.ToInt64(RoleID);
                            PC.OrgID = OrgID;
                            PC.PatientVisitID = vid;
                            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                            PC.ButtonName = PageContextDetails.ButtonName;
                            PC.ButtonValue = PageContextDetails.ButtonValue;
                            PC.IDS = accessionnumber;
                            lstpagecontextkeys.Add(PC);
                            long res = -1;
                            res = AM.PerformingNextStepNotification(PC, "", "");
                        //}
                    }
                }


            }
            /* END | NA | Sabari | 20181202 | Created | HOLD */
            #endregion 
            else
            {
                lstCoauthorizeUser = new List<long>();
                lstSelectedOpinionUser = new List<long>();
                long ApproverID = LID;                     //For revalidate task
                foreach (var O in lstPatientInv)
                {
                    if (O.Status == InvStatus.Coauthorize && O.LoginID != LID)
                    {
                        lstCoauthorizeUser.Add(O.LoginID);
                    }
                    if (O.Status == InvStatus.SecondOpinion)
                    {
                        lstSelectedOpinionUser.Add(O.LoginID);
                    }
                }
                /*Sabari added Login For on Hold approvel Start*/
                foreach (var O in lstPatientInv)
                {
                    if (O.Status == "On Hold & Approve")
                    {
                        O.IsReportable = true;
                        O.Status = InvStatus.Approved;

                    }
                    //else if (O.Status == "On Hold")
                    //{
                    //    O.IsReportable = true;
                    //    O.Status = InvStatus.Validate;
                    //}
                    else if (O.Status != "On Hold" && O.Status != "On Hold & Approve")
                    {
                        O.IsReportable = false;
                    }
                }

                foreach (List<InvestigationValues> lstInvValue in LstOfBio)
                {
                    foreach (InvestigationValues oInvValue in lstInvValue)
                    {
                        if (oInvValue.Status == "On Hold & Approve")
                        {
                            oInvValue.Status = InvStatus.Approved;
                        }
                        //else if (oInvValue.Status == "On Hold")
                        //{
                        //    oInvValue.Status = InvStatus.Validate;

                        //}
                    }
                }



            /*Sabari added Login For on Hold approvel END */
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            long taskID = -1;
            Int64.TryParse(Request.QueryString["tid"], out taskID);

            int taskActionID = 0;
            List<Tasks> lstTasks = new List<Tasks>();
            oTasksBL.GetTaskID(taskID, out lstTasks);
            if (lstTasks != null && lstTasks.Count > 0)
            {
                taskActionID = lstTasks[0].TaskActionID;
            }
            Int32 coauthorizeID = Convert.ToInt32(Attune.Podium.Common.TaskHelper.TaskAction.Coauthorize);
            if (!String.IsNullOrEmpty(hdnIsCoAuthList.Value) && taskActionID != coauthorizeID)
            {
                JavaScriptSerializer serializer1 = new JavaScriptSerializer();
                List<PatientInvestigation> lstCoAuthorizer = serializer1.Deserialize<List<PatientInvestigation>>(hdnIsCoAuthList.Value);
                PatientInvestigation oPatInv = null;
                string lstUsers = string.Empty;
                long loginID = 0;
                foreach (var O in lstPatientInv)
                {
                    if (O.Status == InvStatus.Approved)
                    {
                        if (lstCoAuthorizer.Exists(P => P.InvestigationID == O.InvestigationID))
                        {
                            oPatInv = lstCoAuthorizer.Find(P => P.InvestigationID == O.InvestigationID);
                            if (!String.IsNullOrEmpty(oPatInv.UserID))
                            {
                                string[] lstLoginid = oPatInv.UserID.Split(',');
                                foreach (string login in lstLoginid)
                                {
                                    Int64.TryParse(login, out loginID);
                                    if (loginID != LID)
                                    {
                                        O.Status = InvStatus.Coauthorize;
                                        foreach (List<InvestigationValues> lstInvValue in LstOfBio)
                                        {
                                            foreach (InvestigationValues oInvValue in lstInvValue)
                                            {
                                                if (oInvValue.InvestigationID == O.InvestigationID)
                                                {
                                                    oInvValue.Status = InvStatus.Coauthorize;
                                                }
                                            }
                                        }
                                        lstCoauthorizeUser.Add(loginID);
                                    }
                                }
                            }
                        }
                    }
                }
            }
            // int completed = -1;
            int deptID = Convert.ToInt32(hdnDept.Value);

            chkStatus = InvStatus.Pending;

            foreach (var O in lstPatientInv)
            {
                if ((O.Status == InvStatus.Completed) || (O.Status == InvStatus.Approved))
                {
                    chkStatus = InvStatus.Completed;
                }
                if (O.Status == InvStatus.Validate || O.Status == "PartiallyValidated")
                {
                    isValidate = true;
                }
                if (O.Status == InvStatus.Coauthorize || O.Status == InvStatus.SecondOpinion)
                {
                    isCoauthorize = true;
                }
                if (O.Status == InvStatus.OpinionGiven)
                {
                    isReceivedOpinion = true;
                }
                if (O.Status == InvStatus.ReflexWithNewSample)
                {
                    chkStatus = InvStatus.ReflexWithNewSample;
                }
                if (O.Status == InvStatus.ReflexWithSameSample)
                {
                    chkStatus = InvStatus.ReflexWithSameSample;
                }
                if (O.Status == InvStatus.WithholdValidation)
                {
                    isWithholdValidation = true;
                }
                if (O.Status == InvStatus.WithholdApproval)
                {
                    isWithholdApproval = true;
                }
                if (O.Status == "Retest")
                {
                    chkStatus = InvStatus.Retest;
                }
                if (O.Status == "Recheck")
                {
                    chkStatus = InvStatus.Recheck;
                }
                if (O.Status == InvStatus.PartialyApproved)
                {
                    chkStatus = InvStatus.PartialyApproved;
                }
            }
            if (isWithholdValidation)
            {
                chkStatus = InvStatus.WithholdValidation;
            }
            else if (isWithholdApproval)
            {
                chkStatus = InvStatus.WithholdApproval;
            }
            else if (isCoauthorize)
            {
                chkStatus = InvStatus.Coauthorize;
            }
            else if (isReceivedOpinion)
            {
                chkStatus = InvStatus.OpinionGiven;
            }
            else if (isValidate)
            {
                chkStatus = InvStatus.Validate;
            }
            foreach (var O in lstPatientInv)
            {
                if (O.Status == InvStatus.Validate || O.Status == InvStatus.PartiallyValidated)
                {
                    O.ValidatedBy = LID;
                }
                else
                {
                    O.ValidatedBy = 0;
                }
            }
                if (Request.QueryString["Client"] != "Y")
                {
            foreach (var O in lstPatientInv)
            {
                if (O.Status == InvStatus.Approved || O.Status == InvStatus.Coauthorize || O.Status == InvStatus.WithHeld || O.Status == InvStatus.PartialyApproved)
                {
                    if (taskActionID != coauthorizeID)
                    {
                        O.ApprovedBy = LID;
                        O.AuthorizedBy = 0;
                    }
                    else
                    {
                        O.ApprovedBy = LID;
                        O.AuthorizedBy = LID;
                    }
                }
                else
                {
                    O.ApprovedBy = 0;
                    O.AuthorizedBy = 0;
                }
                if (RoleName == "Physician Assistant")
                {
                    O.ApprovedBy = O.LoginID;
                }
            }
                }
                else
                {

                    ApproverID = 1111;   //For igentic revalidatetask
                }

            var Invcount = from grp in lstPatientInv
                           group grp by grp.GroupID into g
                           select new { groupid = g.Key, count = g.Count() };

            var InvReject = from grp in lstPatientInv
                            where grp.Status == InvStatus.Rejected
                            group grp by grp.GroupID into g
                            select new { groupid = g.Key, count = g.Count() };

            var InvCompleted = from grp in lstPatientInv
                               where grp.Status == InvStatus.Completed
                               group grp by grp.GroupID into g
                               select new { groupid = g.Key, count = g.Count() };

            var InvApprove = from grp in lstPatientInv
                             where grp.Status == InvStatus.Approved
                             group grp by grp.GroupID into g
                             select new { groupid = g.Key, count = g.Count() };


            Hashtable invstatus = new Hashtable();

            foreach (var x in InvReject)
            {
                if (!invstatus.Contains(x.groupid))
                {

                    invstatus.Add(x.groupid, InvStatus.Rejected);
                }

            }

            foreach (var x in InvCompleted)
            {
                if (!invstatus.Contains(x.groupid))
                {
                    invstatus.Add(x.groupid, InvStatus.Completed);

                }

            }

            foreach (var x in InvApprove)
            {
                if (!invstatus.Contains(x.groupid))
                {
                    invstatus.Add(x.groupid, InvStatus.Approved);
                }

            }

            foreach (DictionaryEntry dt in invstatus)
            {
                if ((dt.Value == InvStatus.Completed))
                {
                    HdnIsCompleted.Value = "True";
                    isCompleted = true;
                    break;
                }
            }
            foreach (var O in lstPatientInv)
            {
                if ((O.Status == InvStatus.Completed))
                {
                    HdnIsCompleted.Value = "True";
                    isCompleted = true;
                    break;
                }

            }
            Investigation_BL saveResults = new Investigation_BL(base.ContextInfo);
            //code added on Group Level Comment - begins

            string temp = string.Empty;

            List<InvestigationBulkData> lstInvBulkData = new List<InvestigationBulkData>();
            if (sourceNameHDN.Value != "")
            {
                foreach (string str in sourceNameHDN.Value.Split('^'))
                {
                    string[] lineItems = str.Split('~');
                    if (lineItems[0] != "")
                    {
                        InvestigationBulkData objQRM = new InvestigationBulkData();
                        objQRM.InvestigationID = Convert.ToInt64(lineItems[0]);
                        objQRM.Name = lineItems[1];
                        objQRM.Value = lineItems[2];
                        int lstlength = lstInvBulkData.Count;
                        if (lstlength != 0)
                        {
                            int count = 0;
                            for (int i = 0; i < lstlength; i++)
                            {

                                string comparer1 = objQRM.InvestigationID.ToString() + "~" +
                                                  objQRM.Name.ToString() + "~" +
                                                  objQRM.Value.ToString();

                                string comparer2 = lstInvBulkData[i].InvestigationID.ToString() + "~" +
                                                   lstInvBulkData[i].Name.ToString() + "~" +
                                                  lstInvBulkData[i].Value.ToString();

                                if (comparer1 == comparer2)
                                {
                                    count++;

                                }


                            }


                            if (count == 0)
                            {
                                lstInvBulkData.Add(objQRM);
                                lstlength++;

                            }

                        }
                        else
                        {
                            lstInvBulkData.Add(objQRM);

                        }

                    }
                }
            }

            string tempGroup = string.Empty;


            List<PatientInvestigation> lstPInvestigation = new List<PatientInvestigation>();
            if (groupCommentHDN1.Value != "")
            {
                foreach (string str in groupCommentHDN1.Value.Split('^'))
                {
                    string[] lineItems = str.Split('~');
                    if (lineItems[0] != "")
                    {
                        PatientInvestigation objPInv = new PatientInvestigation();

                        objPInv.GroupName = lineItems[0].Replace(":", "");

                        objPInv.GroupComment = lineItems[1];

                        objPInv.PatientVisitID = vid;
                        objPInv.OrgID = Convert.ToInt32(hdnOrgID.Value);

                        int lstlength = lstPInvestigation.Count;


                        if (lstlength != 0)
                        {
                            int count = 0;
                            for (int i = 0; i < lstlength; i++)
                            {

                                string comparer1 = objPInv.GroupName.ToString().Replace(":", "") + "~" +
                                                  objPInv.GroupComment.ToString();

                                string comparer2 = lstPInvestigation[i].GroupName.ToString().Replace(":", "") + "~" +
                                                   lstPInvestigation[i].GroupComment.ToString();

                                if (comparer1 == comparer2)
                                {
                                    count++;

                                }


                            }


                            if (count == 0)
                            {
                                objPInv = AddMedicalRemarks(objPInv, lstPInvestigation, lstlength);
                                lstPInvestigation.Add(objPInv);
                                lstlength++;

                            }

                        }
                        else
                        {
                            objPInv = AddMedicalRemarks(objPInv, lstPInvestigation, lstlength);
                            lstPInvestigation.Add(objPInv);

                        }

                    }
                }
            }

            if (hdnhigh.Value != "")
            {
                List<NameValuePair> lstHighRangeDetails = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnhigh.Value);
                int i = 0;
                foreach (PatientInvestigation obj in lstPatientInv)
                {
                    foreach (NameValuePair s1 in lstHighRangeDetails)
                    {
                        string[] s2 = s1.Name.Split('~');
                        if (s2[0].ToString() == obj.InvestigationID.ToString())
                        {
                            if (s1.Value == "A")
                            {
                                lstPatientInv[i].IsAbnormal = "A";
                                lstPatientInv[i].IsAutoAuthorize = "N";
                            }
                            else if (s1.Value == "L")
                            {
                                lstPatientInv[i].IsAbnormal = "L";
                                lstPatientInv[i].IsAutoAuthorize = "N";
                            }
                            else if (s1.Value == "Auto")
                            {
                                lstPatientInv[i].IsAbnormal = "N";
                                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "N";
                                }
                                else
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "Y";
                                }
                            }
                            else if (s1.Value == "P")
                            {
                                lstPatientInv[i].IsAbnormal = "P";
                                lstPatientInv[i].IsAutoAuthorize = "N";

                            }
                            else if (s1.Value == "white") { lstPatientInv[i].IsAbnormal = "N"; lstPatientInv[i].IsAutoAuthorize = "N"; }
                            else if (s1.Value == "Autowhite")
                            {
                                lstPatientInv[i].IsAbnormal = "N";
                                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "N";
                                }
                                else
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "Y";
                                    lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                }
                            }
                            else if (s1.Value == "AutoA")
                            {
                                lstPatientInv[i].IsAbnormal = "A";
                                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "N";
                                }
                                else
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "Y";
                                    lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                }
                            }
                            else if (s1.Value == "AutoP")
                            {
                                lstPatientInv[i].IsAbnormal = "P";
                                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "N";
                                }
                                else
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "Y";
                                    lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                }
                            }
                            else if (s1.Value == "AutoL")
                            {
                                lstPatientInv[i].IsAbnormal = "L";
                                if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "")
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "N";
                                }
                                else
                                {
                                    lstPatientInv[i].IsAutoAuthorize = "Y";
                                    lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                }
                            }
                            break;
                        }
                        else
                        {
                            if (lstPatientInv[i].IsAbnormal != "A" && lstPatientInv[i].IsAbnormal != "L" && lstPatientInv[i].IsAbnormal != "P")
                            { lstPatientInv[i].IsAbnormal = "N"; }
                        }
                    }
                    i++;
                }
            }
            if (hdnhigh.Value != "")
            {
                List<NameValuePair> lstHighRangeDetails = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnhigh.Value);
                List<InvestigationValues> obj_values = new List<InvestigationValues>();
                int i = 0;

                foreach (List<InvestigationValues> obj in LstOfBio)
                {
                    List<InvestigationValues> oh = new List<InvestigationValues>();

                    foreach (NameValuePair s1 in lstHighRangeDetails)
                    {
                        if(obj.Count >0)
                        {
                        string[] s2 = s1.Name.Split('~');
                        if (s2[0].ToString() == obj[0].InvestigationID.ToString())
                        {
                            if (s1.Value == "A")
                            {
                                //LstOfBio[i].Select(e => { e.IsAbnormal = "A"; return e; }).ToList();
                                LstOfBio[i][0].IsAbnormal = "A";




                            }
                            else if (s1.Value == "L")
                            {

                                LstOfBio[i][0].IsAbnormal = "L";

                            }
                            else if (s1.Value == "Auto")
                            {
                                LstOfBio[i][0].IsAbnormal = "N";

                            }
                            else if (s1.Value == "P")
                            {
                                LstOfBio[i][0].IsAbnormal = "P";



                            }
                            else if (s1.Value == "white")
                            {
                                LstOfBio[i][0].IsAbnormal = "N";

                            }
                            else if (s1.Value == "Autowhite")
                            {
                                LstOfBio[i][0].IsAbnormal = "N";

                            }
                            else if (s1.Value == "AutoA")
                            {
                                LstOfBio[i][0].IsAbnormal = "N";

                            }
                            else if (s1.Value == "AutoP")
                            {
                                LstOfBio[i][0].IsAbnormal = "P";


                            }
                            else if (s1.Value == "AutoL")
                            {
                                LstOfBio[i][0].IsAbnormal = "L";

                            }
                            break;
                        }
                        else
                        {
                            if (LstOfBio[i][0].IsAbnormal != "A" && LstOfBio[i][0].IsAbnormal != "L" && LstOfBio[i][0].IsAbnormal != "P")
                            { LstOfBio[i][0].IsAbnormal = "N"; }
                        }
                    }
                }

                    i++;
                }
            }

            if (hdnSensitivehigh.Value != "")
            {
                List<NameValuePair> lstSensitiveRangeDetails = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnSensitivehigh.Value);
                int i = 0;
                foreach (PatientInvestigation obj in lstPatientInv)
                {
                    foreach (NameValuePair s1 in lstSensitiveRangeDetails)
                    {
                        string[] s2 = s1.Name.Split('~');
                        if (s2[0].ToString() == obj.InvestigationID.ToString())
                        {
                            if (s1.Value == "N")
                            {
                                lstPatientInv[i].IsSensitive = "N";
                            }
                            else if (s1.Value == "Y")
                            {
                                lstPatientInv[i].IsSensitive = "Y";
                            }
                            break;
                        }
                        else
                        {
                            lstPatientInv[i].IsSensitive = "N";
                        }
                    }
                    i++;
                }
            }
            //code added on Notify Abnormal Values - END
            //Different between manual changing and abnormal changing
            //List<PatientInvestigation> objManual = lstPatientInv;
            if (hdnabnormalchange.Value != "")
            {
                foreach (PatientInvestigation obj in lstPatientInv)
                {
                    string[] s2 = (hdnabnormalchange.Value).Split('^');
                    foreach (string s4 in s2)
                    {
                        string[] s3 = s4.Split('~');
                        if (s3[0].ToString() == obj.InvestigationID.ToString())
                        {
                            obj.ManualAbnormal = "Y";
                            break;
                        }
                        else
                        {
                            obj.ManualAbnormal = "N";
                        }
                    }

                }
            }
            else
            {
                foreach (PatientInvestigation obj in lstPatientInv)
                {
                    obj.ManualAbnormal = "N";
                }
            }
            // Auto Approve Part
            AllowAutoApproveTask = "No";
            int PendingCount = 0;
            foreach (var O in lstPatientInv)
            {
                if (hdnDomainvalue.Value == "true")
                {
                    O.Status = "Pending";
                    AllowAutoApproveTask = "No";
                    O.IsAutoAuthorize = "N";
                    PendingCount += 1;
                }
                else if ((O.Status == "Completed" || O.Status == "Validate" || O.Status == "Approve") && O.AutoApproveLoginID > 0 && O.IsAutoAuthorize == "Y")
                {
                    //O.Status = "Approve";
                    if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "" && O.Status == "Validate")
                    {
                        O.IsAutoAuthorize = "N";
                    }
                    else
                    {
                        O.IsAutoAuthorize = "Y";
                        O.ApprovedBy = O.AutoApproveLoginID;
                    }
                }
                //else if (O.Status != "Validate" || O.IsAbnormal == "A" || O.IsAbnormal == "L" || O.IsAbnormal == "P")//|| O.AutoApproveLoginID != LID)
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}
                //else if (O.Status == "Validate")
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}
            }
            if (PendingCount == 0)
            {
                AllowAutoApproveTask = "Yes";
            }
            //Revert Auto Approve Status

                /* BEGIN | NA | Sabari | 20181202 | Created | HOLD */
                #region RemovePatientinvestigation_ListBio_Hold_Status

                /// Hold Test Filtered to change IsReportable=1 also Remove from Enter result list insertions///
                List<PatientInvestigation> lstPatientInvHoldCount = lstPatientInv.FindAll(p => p.Status.Contains("On Hold"));

                if (lstPatientInvHoldCount.Count != null && lstPatientInvHoldCount.Count > 0)
                {
                    /*This list Item Removed for PatientInvestigation Insert skip for Hold tests*/
                    lstPatientInv.RemoveAll(r => r.Status == "On Hold");


                    /*This list item  removed for InvestigationValues  table insert skip for Hold tests*/
                    if (LstOfBio.Count > 0)
                    {
                        #region CommentblogListBio
                        /*This is commented for normal For Each */
                        //if (LstOfBio.Count > 0)
                        //{
                        //    foreach (List<InvestigationValues> _Baselist in LstOfBio)
                        //    {
                        //        foreach (InvestigationValues _Childlist in _Baselist)
                        //        {
                        //            if (_Childlist.Status == "On Hold")
                        //            {
                        //                //LstOfBio.Remove(_Baselist);
                        //                _Baselist.Remove(_Childlist);

                        //                if (_Baselist.Count == 0)
                        //                {

                        //                    break;
                        //                }
                        //            }

                        //        }

                        //    }

                        //    LstOfBio.RemoveAll(r => r.Count == 0);

                        //}
                        #endregion 
                        LstOfBio.ForEach(u => { u.RemoveAll(a => a.Status == "On Hold"); }); /*List of list item removel*/
                        LstOfBio.RemoveAll(r => r.Count == 0);

                    }

                    if (lstPatientInvHoldCount.Count > 0)
                    {

                        //foreach (var O in lstPatientInvHoldCount)
                        //{
                        //    if (O.Status == "On Hold")
                        //    {
                        //        O.IsReportable = true;
                        //    }

                        //}

                        foreach (var lstholdobj in lstPatientInvHoldCount.Where(r => r.Status == "On Hold"))
                        {
                            lstholdobj.IsReportable = true;
                        }

                        
                        Investigation_BL objinvbl = new Investigation_BL(base.ContextInfo);
                        returnCode = objinvbl.SaveUnHoldDetails(lstPatientInvHoldCount);
                    }

                    

                    #region HoldNotificationInsert
                    if (lstPatientInvHoldCount.Count > 0)  //if (lstPatientInv.Count > 0)
                    {
                        int cnt = 0;
                        int cntPA = 0;
                        int cntWH = 0;
                        int cntRJ = 0;
                        int reclt = 0;
                        int holdNotify = 0;

                        ///Filer Approve test Count in the Main lstPatientInv  -> Here if count > 0 to hold Notifiation insert 
                        ///bcoz Normal Approve Notification insert will happen so here skip that 
                        cnt = lstPatientInv.FindAll(p => p.Status == "Approve").Count();

                        holdNotify = lstPatientInvHoldCount.FindAll(p => p.Status == "On Hold").Count();
                        if (cnt == 0)
                        {
                            DemoBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out lstorderInvforVisit);

                            bool IsResult = false;

                            var PkgId = (from grp in lstorderInvforVisit
                                         where grp.IsCoPublish == "Y" && grp.PkgID != 0
                                         select grp.PkgID).Distinct().ToList();
                            List<string> lstInvStatus = new List<string>();
                            lstInvStatus.Add("approve");
                            lstInvStatus.Add("partiallyapproved");
                            int NonCoPublishTestCount = (from grp in lstorderInvforVisit
                                                         where grp.IsCoPublish != "Y" && grp.PkgID >= 0 && lstInvStatus.Contains(grp.Status.ToLower())
                                                         select grp).Count();

                            if (NonCoPublishTestCount == 0)
                            {
                                foreach (var item in PkgId)
                                //for (int i = 0; i < PkgId.Count; i++)
                                {
                                    int CoPublishPkgCount = (from grp in lstorderInvforVisit
                                                             where grp.IsCoPublish == "Y" && grp.PkgID != 0 && grp.PkgID == item
                                                             select grp).Count();
                                    int CoPublishPkgApprovalCount = (from grp in lstorderInvforVisit
                                                                     where grp.IsCoPublish == "Y" && grp.PkgID != 0 && lstInvStatus.Contains(grp.Status.ToLower()) && grp.PkgID == item
                                                                     select grp).Count();
                                    if (CoPublishPkgCount == CoPublishPkgApprovalCount)
                                    {
                                        IsResult = true;
                                        break;
                                    }
                                }
                            }


                            if (holdNotify > 0 )
                            {
                                if ((NonCoPublishTestCount > 0) || (IsResult == true))
                                {
                                    ActionManager AM = new ActionManager(base.ContextInfo);
                                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                    PageContextkey PC = new PageContextkey();
                                    PC.ID = Convert.ToInt64(ILocationID);
                                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                                    PC.RoleID = Convert.ToInt64(RoleID);
                                    PC.OrgID = OrgID;
                                    PC.PatientVisitID = vid;
                                    PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                                    PC.ButtonName = PageContextDetails.ButtonName;
                                    PC.ButtonValue = PageContextDetails.ButtonValue;
                                    PC.IDS = accessionnumber;
                                    lstpagecontextkeys.Add(PC);
                                    long res = -1;
                                    res = AM.PerformingNextStepNotification(PC, "", "");

                                    /* Blog Added:To Check curr visit If all the Approced test Hold means don't want to generate report */
                                    Investigation_BL objinvbl = new Investigation_BL(base.ContextInfo);
                                    long NotifyreturnCode = objinvbl.UpdateNotificationForApprovedHold(vid, Convert.ToInt32(hdnOrgID.Value));
                                    /* Blog Added:To Check this visit All the Test Hold,If all the test Hold means don't want to generate report */

                                }
                            }
                        }
                    }
                    #endregion



                }
                /* END | NA | Sabari | 20181202 | Created | HOLD */
                #endregion

                /* 
                  
                 * HERE IF BLOG ADDED FOR ABOVE ALL INVESTIGATIONS ONLY DID HOLD MEANS NO NEED TO CHANGE STATUS /TASKS 
                 * ETC SO  NEED TO SKIP RESULT ENTRY BASED THIS CONDTITION 
                 
                 */
                if (lstPatientInv.Count > 0 && LstOfBio.Count > 0)
                {

                    Patinvestasks = lstPatientInv;

            List<PatientInvestigation> lstReflexPatientinvestigation = new List<PatientInvestigation>();
            List<PatientInvestigation> lstFinalReflexPatientinvestigation = new List<PatientInvestigation>();
            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
            Investigation_BL InvBL = new Investigation_BL();

            foreach (List<InvestigationValues> _tlist in LstOfBio)
            {
                foreach (InvestigationValues _list in _tlist)
                {
                    returnCode = InvBL.GetReflexTestDetailsbyInvID(_list.InvestigationID, OrgID, out lstInvValueRangeMaster);
                    if (lstInvValueRangeMaster.Count > 0)
                    {
                        fnValidateResulValue(_list.Value, lstInvValueRangeMaster, out lstReflexPatientinvestigation);
                    }
                    lstFinalReflexPatientinvestigation = lstFinalReflexPatientinvestigation.Union(lstReflexPatientinvestigation).ToList();
                }
            }

            if (Flag == true)
            {
                //code added on Group Level Comment - begins
                returnCode = saveResults.SaveQRMData(lstInvBulkData);
                returnCode = saveResults.SaveGroupComments(lstPInvestigation, gUID);
                //code added on Group Level Comment - ends
                string isFromDevice = "N";
                if (BtnSavePreview == true)
                {
                    returnCode = saveResults.SaveInvestigationResultsPreview(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, Convert.ToInt32(hdnOrgID.Value), deptID, LID, gUID, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice);
                }
                else
                {
                    //Changed By Arivalagan.kk/ For  Synoptic Report//
                    if (hdnSynopticTestFlag.Value != "")
                    {
                        Investigation_BL InvestigationBL = new Investigation_BL();
                        List<InvStatusmapping> lstInvStatusmapping = new List<InvStatusmapping>();
                        Boolean CompletedFlag = false;
                        long retval = -1;
                        retval = InvestigationBL.pGetQuickApprovelForCompletedStatus(OrgID, out lstInvStatusmapping);
                        if (lstInvStatusmapping.Count > 0)
                        {
                            CompletedFlag = true;
                        }
                        ucSynopticTest.saveInvestigationQueue();
                        foreach (var o in lstPatientInv)
                        {
                            if (o.Status == "Synoptic")
                            {
                                if (CompletedFlag == true)
                                {
                                    o.Status = "Completed";
                                }
                                else
                                {
                                    o.Status = "Validate";
                                }
                            }

                            else if (o.Status == "Approve")
                            {
                                if (CompletedFlag == true)
                                {
                                    o.Status = "Completed";
                                }
                                else
                                {
                                    o.Status = "Validate";
                                }
                            }
                        }
                        List<PatientInvestigationAttributes> lstpat = new List<PatientInvestigationAttributes>();
                        returnCode = saveResults.SaveInvestigationResults(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, Convert.ToInt32(hdnOrgID.Value), deptID, LID, gUID, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice,lstpat);
                        String PathAndQuery = HttpContext.Current.Request.Url.PathAndQuery;
                        PathAndQuery.Replace(Request.ApplicationPath, "~");
                        Response.Redirect(PathAndQuery, true);
                    }
                    //Changed By Arivalagan.kk/ For  Synoptic Report//
                    else
                    {
                        List<PatientInvestigationAttributes> lstpat = new List<PatientInvestigationAttributes>();
                        returnCode = saveResults.SaveInvestigationResults(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, Convert.ToInt32(hdnOrgID.Value), deptID, LID, gUID, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice,lstpat);
                    }
                }
                List<PatientInvestigation> lstReflex = lstPatientInv.FindAll(P => P.Status == InvStatus.ReflexWithNewSample || P.Status == InvStatus.ReflexWithSameSample);
                if (lstReflex.Count() > 0)
                {
                    long returncode = -1;
                    //long taskID1 = -1;
                    //Int64.TryParse(Request.QueryString["tid"], out taskID1);
                    //returncode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, "ReflexTest");
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    returncode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, "ReflexTest");
                    ucReflexTest.saveInvestigationQueue(lstReflex);
                }
            }
            ////------------------------------------------------------------------////////////////
            if (hdnSynopticTestFlag.Value == "")
            {
                int cont = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
                if (cont > 0)
                {
                    ActionManager AM = new ActionManager(base.ContextInfo);
                    List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                    PageContextkey PC = new PageContextkey();
                    PC.ID = Convert.ToInt64(ILocationID);
                    PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                    PC.RoleID = Convert.ToInt64(RoleID);
                    PC.OrgID = OrgID;
                    PC.PatientVisitID = vid;
                    PC.PageID = Convert.ToInt64(PageID);
                    PC.ButtonName = "Save";
                    PC.ButtonValue = "Save";
                    PC.ContextType = "CV";
                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                }
                int cnt = 0;
                int cntPA = 0;
                int cntWH = 0;
                int cntRJ = 0;
                int reclt = 0;
                cnt = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
                cntPA = lstPatientInv.FindAll(p => p.Status == "PartiallyApproved").Count();
                cntWH = lstPatientInv.FindAll(p => p.Status == "With Held").Count();
                cntRJ = lstPatientInv.FindAll(p => p.Status == "Reject").Count();
                reclt = lstPatientInv.FindAll(p => p.Status == "Retest").Count();
                DemoBL.pGetpatientInvestigationForVisit(vid, Convert.ToInt32(hdnOrgID.Value), ILocationID, gUID, out lstorderInvforVisit);

                bool IsResult = false;

                var PkgId = (from grp in lstorderInvforVisit
                             where grp.IsCoPublish == "Y" && grp.PkgID != 0
                             select grp.PkgID).Distinct().ToList();
                List<string> lstInvStatus = new List<string>();
                lstInvStatus.Add("approve");
                lstInvStatus.Add("partiallyapproved");
                int NonCoPublishTestCount = (from grp in lstorderInvforVisit
                                             where grp.IsCoPublish != "Y" && grp.PkgID >= 0 && lstInvStatus.Contains(grp.Status.ToLower())
                                             select grp).Count();

                if (NonCoPublishTestCount == 0)
                {
                    foreach (var item in PkgId)
                    //for (int i = 0; i < PkgId.Count; i++)
                    {
                        int CoPublishPkgCount = (from grp in lstorderInvforVisit
                                                 where grp.IsCoPublish == "Y" && grp.PkgID != 0 && grp.PkgID == item
                                                 select grp).Count();
                        int CoPublishPkgApprovalCount = (from grp in lstorderInvforVisit
                                                         where grp.IsCoPublish == "Y" && grp.PkgID != 0 && lstInvStatus.Contains(grp.Status.ToLower()) && grp.PkgID == item
                                                         select grp).Count();
                        if (CoPublishPkgCount == CoPublishPkgApprovalCount)
                        {
                            IsResult = true;
                            break;
                        }
                    }
                }
                if (reclt > 0)
                {
                    List<PatientInvestigation> access = lstPatientInv.FindAll(P => P.Status == InvStatus.Retest);
                    if (access.Count > 0)
                    {
                        foreach (PatientInvestigation pinv in access)
                        {
                            OrderedInvestigations objinv = new OrderedInvestigations();
                            objinv.AccessionNumber = pinv.AccessionNumber;
                            accessionnumber += objinv.AccessionNumber.ToString() + ",";
                        }
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.ID = Convert.ToInt64(ILocationID);
                        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PatientVisitID = vid;
                        PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                        PC.ButtonName = PageContextDetails.ButtonName;
                        PC.ButtonValue = PageContextDetails.ButtonValue;
                        PC.IDS = accessionnumber;
                        lstpagecontextkeys.Add(PC);
                        long res = -1;
                        res = AM.PerformingNextStepNotification(PC, "", "");
                    }
                }


                if (cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
                {
                    if ((NonCoPublishTestCount > 0) || (IsResult == true))
                    {
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.ID = Convert.ToInt64(ILocationID);
                        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PatientVisitID = vid;
                        PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                        PC.ButtonName = PageContextDetails.ButtonName;
                        PC.ButtonValue = PageContextDetails.ButtonValue;
                        PC.IDS = accessionnumber;
                        lstpagecontextkeys.Add(PC);
                        long res = -1;
                        res = AM.PerformingNextStepNotification(PC, "", "");
                    }
                    else if (taskID <= 0)
                    {
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.ID = Convert.ToInt64(ILocationID);
                        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PatientVisitID = vid;
                        PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                        PC.ButtonName = PageContextDetails.ButtonName;
                        PC.ButtonValue = PageContextDetails.ButtonValue;
                        lstpagecontextkeys.Add(PC);
                        long res = -1;
                        res = AM.PerformingNextStepNotification(PC, "", "");
                    }
                }
            }
            string LabNo = string.Empty;
            List<PatientInvestigation> lstRecheck = lstPatientInv.FindAll(P => P.Status == InvStatus.Recheck);
            if (lstRecheck.Count > 0)
            {
                long RefID = -1; string RefType = "";
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                PatientVisit PatientVisit = new PatientVisit();
                returnCode = DemoBL.GetNextBarcode(Convert.ToInt32(hdnOrgID.Value), ILocationID, "INV", out LabNo, RefID, RefType);
                ////------------------------------------------------------------------////////////////


                if (Request.QueryString["vid"] != null)
                {
                    foreach (PatientInvestigation invs in lstRecheck)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        objInvest.ID = invs.InvestigationID;
                        objInvest.Name = invs.InvestigationName;
                        objInvest.VisitID = vid;
                        objInvest.Status = "Pending";
                        objInvest.PaymentStatus = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = "INV";
                        objInvest.OrgID = Convert.ToInt32(hdnOrgID.Value);
                        objInvest.UID = gUID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        objInvest.LabNo = LabNo;
                        objInvest.ReferenceType = "E";
                        objInvest.ReferralID = invs.AccessionNumber;
                        objInvest.ReferedToLocation = ILocationID;
                        ordInves.Add(objInvest);
                    }
                    //if (ordInves.Count > 0)
                    //{
                    //    returnCode = DemoBL.SaveOrderedInvestigation(ordInves, Convert.ToInt32(hdnOrgID.Value));
                    //}

                    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
                    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
                    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
                    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
                    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
                    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
                    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
                    List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
                    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
                    List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
                    List<PatientInvSample> LstPinvsample = new List<PatientInvSample>();
                    List<PatientInvSampleMapping> LstPinvsamplemapping = new List<PatientInvSampleMapping>();
                    int pOrderedCount = -1;
                    DemoBL.GetInvestigationSamplesCollect(Convert.ToInt64(hdnVID.Value), Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

                            foreach (PatientInvestigation patient in lstPatientInvestigation)
                            {
                                PatientInvestigation objPinvest = new PatientInvestigation();
                                objPinvest.InvestigationID = patient.InvestigationID;
                                objPinvest.InvestigationName = patient.InvestigationName;
                                objPinvest.PatientVisitID = patient.PatientVisitID;
                                objPinvest.GroupID = patient.GroupID;
                                objPinvest.GroupName = patient.GroupName.Replace(":", "");
                                objPinvest.Status = patient.Status;
                                objPinvest.CollectedDateTime = patient.CreatedAt;
                                objPinvest.CreatedBy = LID;
                                objPinvest.Type = patient.Type;
                                objPinvest.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                objPinvest.InvestigationMethodID = 0;
                                objPinvest.KitID = 0;
                                objPinvest.InstrumentID = 0;
                                objPinvest.UID = patient.UID;
                                SaveInvestigation.Add(objPinvest);
                            }
                            foreach (PatientInvestigation patient in lstPatientInvestigation)
                            {
                                PatientInvSample objPinvsample = new PatientInvSample();
                                objPinvsample.PatientVisitID = patient.PatientVisitID;
                                objPinvsample.Status = patient.Status;
                                objPinvsample.CollectedDateTime = patient.CreatedAt;
                                objPinvsample.CreatedBy = LID;
                                objPinvsample.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                objPinvsample.UID = patient.UID;
                                LstPinvsample.Add(objPinvsample);
                            }
                            foreach (PatientInvestigation patient in lstPatientInvestigation)
                            {
                                PatientInvSampleMapping objPinvsamplemapping = new PatientInvSampleMapping();
                                objPinvsamplemapping.VisitID = patient.PatientVisitID;
                                objPinvsamplemapping.ID = patient.InvestigationID;
                                objPinvsamplemapping.CreatedAt = patient.CreatedAt;
                                objPinvsamplemapping.OrgID = Convert.ToInt32(hdnOrgID.Value);
                                objPinvsamplemapping.UID = patient.UID;
                                LstPinvsamplemapping.Add(objPinvsamplemapping);
                            }
                            if (lstPatientInvestigation.Count > 0)
                            {
                                if (lstPatientInvestigation[0].UID != null)
                                {
                                    gUID = lstPatientInvestigation[0].UID;
                                }
                            }
                            if (SaveInvestigation.Count > 0)
                            {
                                returnCode = DemoBL.SavePatientInvestigation(SaveInvestigation, Convert.ToInt32(hdnOrgID.Value), gUID, out pOrderedCount);
                            }
                            if (returnCode > -1)
                            {
                                returnCode = DemoBL.SavePatientInvSampleNMapping(LstPinvsample, LstPinvsamplemapping, gUID, Convert.ToInt32(hdnOrgID.Value));
                            }
                        }
                        else
                        {
                            returnCode = 0;
                        }
                    }
                }
            }



        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        ////------------------------------------------------------------------////////////////


        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Investigation", ex);
        }
        return returnCode;
    }
    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            Int32 orgId = 0;
            if (!String.IsNullOrEmpty(hdnOrgID.Value))
            {
                Int32.TryParse(hdnOrgID.Value, out orgId);
            }
            else
            {
                orgId = OrgID;
            }
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, orgId, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }
    public Control LoadGeneralPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_GeneralPattern GeneralPattern;
        GeneralPattern = (Investigation_GeneralPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            GeneralPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            GeneralPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            GeneralPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            GeneralPattern.Name = lstInve.InvestigationName;
            GeneralPattern.GroupID = lstInve.GroupID;
            GeneralPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            lstControl.Add(GeneralPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + GeneralPattern.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                GeneralPattern.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadGeneralPattern ", ex);
        }
        return GeneralPattern;
    }
    public Control LoadTablepatternautopopulate(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_Tablepatternautopopulate Tablepatternautopopulate;
        Tablepatternautopopulate = (Investigation_Tablepatternautopopulate)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Tablepatternautopopulate.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Tablepatternautopopulate.ControlID = Convert.ToString(lstInve.InvestigationID);
            Tablepatternautopopulate.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Tablepatternautopopulate.Name = lstInve.InvestigationName;
            Tablepatternautopopulate.GroupID = lstInve.GroupID;
            Tablepatternautopopulate.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            lstControl.Add(Tablepatternautopopulate.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Tablepatternautopopulate.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Tablepatternautopopulate.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadGeneralPattern ", ex);
        }
        return Tablepatternautopopulate;
    }
    public Control LoadRichTextPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_RichTextPattern RichTextPatternPt;
        RichTextPatternPt = (Investigation_RichTextPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            RichTextPatternPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            RichTextPatternPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            RichTextPatternPt.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            RichTextPatternPt.Name = lstInve.InvestigationName;
            RichTextPatternPt.GroupID = lstInve.GroupID;
            RichTextPatternPt.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            RichTextPatternPt.PatientVisitID = vid;
            RichTextPatternPt.PatternID = (lstInve.PatternID);
            RichTextPatternPt.POrgid = Convert.ToInt32(hdnOrgID.Value);
            RichTextPatternPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            RichTextPatternPt.TestStatus = lstInve.TestStatus;
            lstControl.Add(RichTextPatternPt.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + RichTextPatternPt.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                RichTextPatternPt.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                RichTextPatternPt.LoadDataForComments(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            //FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID==groupID ));

            RichTextPatternPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadRichTextPattern ", ex);
        }
        return RichTextPatternPt;
    }
    public Control LoadImageDescription(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_ImageDescriptionpattern Img;
        Img = (Investigation_ImageDescriptionpattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Img.ShowImagePattern();
          //  Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
              Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName.Replace(":","") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Img.ControlID = Convert.ToString(lstInve.InvestigationID);
            Img.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Img.Name = lstInve.InvestigationName;
            Img.GroupID = lstInve.GroupID;
            Img.GroupName = lstInve.GroupName;
            Img.VisitID = lstInve.PatientVisitID;
            Img.PatientID = lstInve.PatientID;
            Img.AccessionNumber = lstInve.AccessionNumber;
            Img.UID = lstInve.UID;
            Img.Age = lstInve.Age;
            Img.Sex = lstInve.Sex;
            Img.PatientName = lstInve.Name;
            Img.VisitNumber = lstInve.VisitNumber;
            Img.LabNo = lstInve.LabNo;
            Img.POrgid = OrgID;

            Img.PatientVisitID = lstInve.PatientVisitID;
            Img.PatternID = lstInve.PatternID;
            Img.TestStatus = lstInve.TestStatus;
            lstControl.Add(Img.ID);

            lstpatternID.Add(lstInve.PatternID);
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Img.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Img.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadDescriptionPattern ", ex);
        }
        return Img;
    }
    public void drawNewPatternMethod()
    {
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;
        int k = 0;
        long taskID = 0;
        StringBuilder sb = new StringBuilder();
        StringBuilder sb1 = new StringBuilder();
        StringBuilder sb2 = new StringBuilder();
        StringBuilder sb3 = new StringBuilder();
        StringBuilder sb4 = new StringBuilder();
        StringBuilder sb5 = new StringBuilder();
        StringBuilder sb6 = new StringBuilder();
        StringBuilder sb7 = new StringBuilder();
        StringBuilder sb8 = new StringBuilder();
        StringBuilder sb9 = new StringBuilder();
        StringBuilder sb10 = new StringBuilder();
        StringBuilder sb11 = new StringBuilder();
        string RerunRecollect = GetConfigValues("RerunRecollect", OrgID);
        hdnrerunrecollect.Value = RerunRecollect;
        if (Request.QueryString["tid"] != null)
        {
            Int64.TryParse(Request.QueryString["tid"], out taskID);
        }
        //InvestigationBL.GetInvstatusForDropdowns(Convert.ToInt32(hdnOrgID.Value), taskID, out header1);
        if (RoleName == "Sonologist" || RoleName == "Radiologist" || RoleName == "Physician" || RoleName == "Medical Services")
        {
            foreach (InvestigationStatus Obj in header1.FindAll(p => p.Status == "Validate"))
            {
                Obj.Status = "Approve";
            }
        }
        //List<string> header1 = header.Select(c => c.Status).Distinct().ToList();
        foreach (PatientInvestigation objDP in lstOrdered)
        {
            if (objDP.InvestigationID > 0)
            {
                //
            }
            else
            {
                int chkInt = objDP.InvestigationName.IndexOf(" :</I></B>");
                if (objDP.InvestigationName != "" && chkInt != -1)
                {
                    k += 1;
                    tr = new TableRow();
                    tc = new TableCell();
                    tc.Width = Unit.Percentage(50);
                    tc.ID = objDP.InvestigationName + k;

                    HtmlTable HtmlTab = new HtmlTable();
                    HtmlTableRow HtmlTr = new HtmlTableRow();
                    HtmlTableCell HtmlTc1 = new HtmlTableCell();
                    HtmlTableCell HtmlTc2 = new HtmlTableCell();
                    HtmlTableCell HtmlTc3 = new HtmlTableCell();
                    HtmlTableCell HtmlTc4 = new HtmlTableCell();
                    HtmlTableCell HtmlTc5 = new HtmlTableCell();

                    Label lblGrp = new Label();
                    lblGrp.ID = objDP.InvestigationName + "_Grp" + k;
                    lblGrp.Text = objDP.InvestigationName;


                    int subStatPos = lblGrp.ID.IndexOf("<I>");
                    int subEndPos = lblGrp.ID.LastIndexOf(" :");
                    int subLength = subEndPos - subStatPos;
                    string sub = lblGrp.ID.Substring(subStatPos + 3, subLength - 3);
                    if (sub != "" && sub != null)
                    {
                        sub = sub.Trim().ToString();
                    }


                    HyperLink hlnkGrpCmt = new HyperLink();
                    hlnkGrpCmt.ID = objDP.InvestigationName + "_GrpCmt" + k;

                    //InvRemarks
                    HiddenField hdnGrpCmtID = new HiddenField();
                    hdnGrpCmtID.ID = "GrpCmtID" + "~" + k + "~" + objDP.GroupID.ToString();
                    hdnGrpCmtID.Value = objDP.GroupID + "~" + "GRP" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
                    HiddenField hdnAppMedRemarksID = new HiddenField();
                    hdnAppMedRemarksID.ID = "hdnAppMedRemarksID" + "~" + k + "~" + objDP.GroupID.ToString();
                    HiddenField hdnAppTechRemarksID = new HiddenField();
                    hdnAppTechRemarksID.ID = "hdnAppTechRemarksID" + "~" + k + "~" + objDP.GroupID.ToString();
                    //InvRemarks

                    if (objDP.GroupComment != null && objDP.GroupComment.Trim() != "")
                    {
                        hlnkGrpCmt.Text = objDP.GroupComment;
                    }
                    else
                    {
                        hlnkGrpCmt.Text = "";
                        hlnkGrpCmt.ForeColor = System.Drawing.Color.Blue;
                        hlnkGrpCmt.Font.Underline = true;
                    }
                    //InvRemarks
                    List<PatientInvestigation> lstPatientInvestigationGrp = new List<PatientInvestigation>();
                    lstPatientInvestigationGrp = lstOrdered.FindAll(P => P.GroupID == objDP.GroupID && ((P.GroupComment != "" && P.GroupComment != null) || (P.GroupMedicalRemarks != "" && P.GroupMedicalRemarks != null)));
                    if (lstPatientInvestigationGrp.Count > 0)
                    {
                        hdnAppTechRemarksID.Value = lstPatientInvestigationGrp[0].GroupComment;
                        hdnAppMedRemarksID.Value = lstPatientInvestigationGrp[0].GroupMedicalRemarks;
                    }
                    string strAddChange = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_35 == null ? "Click Here To Add / Change Group Comments." : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_35;
                    //InvRemarks
                    hlnkGrpCmt.Attributes.Add("OnClick", "javascript:changeGroupComment(this.id,'" + sub + "','" + hdnGrpCmtID.ID.ToString() + "','" + hdnAppTechRemarksID.ID.ToString() + "','" + hdnAppMedRemarksID.ID.ToString() + "');"); //Modified for InvRemarks
                    hlnkGrpCmt.Attributes.Add("onmouseover", "this.style.cursor='hand'");
                    hlnkGrpCmt.ToolTip = "" + strAddChange.Trim() + "";
                    //hlnkGrpCmt.CssClass = "Duecolor";

                    DropDownList drpList = new DropDownList();
                    drpList.ID = sub + "_Grp" + k;

                    //drpList.Items.Add("Pending");
                    //if (OrgID == 72 || OrgID == 92 || OrgID == 69)
                    //{
                    // drpList.Items.Add("Completed");
                    //}
                    //header = header.OrderBy(p => p.InvestigationStatusID).ToList();
                    header1 = header.GroupBy(a => a.DisplayText).Select(g => g.First()).ToList();

                    for (int i = 0; i < header1.Count; i++)
                    {
                        //drpList.Items.Add(header1[i].Status);
                        drpList.Items.Add(new ListItem(header1[i].DisplayText, header1[i].StatuswithID));
                    }
                    //drpList.Items.Add("Approve");
                    //drpList.Items.Add("Reject");
                    //drpList.Items.Add("Retest");
                    drpList.CssClass = "ddl";
                    drpList.Attributes.Add("onchange", "javascript:ChangeStatus('" + sub + "',this.id);");
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), drpList.ClientID, "javascript:ChangeStatus('" + sub + "',\"" + drpList.ClientID + "\");", true);
                    if (String.IsNullOrEmpty(hdnGroupCollection.Value))
                    {
                        hdnGroupCollection.Value += sub + "_Grp" + k + "#";
                    }
                    else
                    {
                        hdnGroupCollection.Value += "^#" + sub + "_Grp" + k + "#";
                    }
                    HtmlTc1.Controls.Add(lblGrp);
                    HtmlTc1.Align = "Left";
                    HtmlTc2.Controls.Add(hlnkGrpCmt);

                    //InvRemarks
                    HtmlTc2.Controls.Add(hdnGrpCmtID);
                    HtmlTc2.Controls.Add(hdnAppTechRemarksID);
                    HtmlTc2.Controls.Add(hdnAppMedRemarksID);
                    //InvRemarks

                    HtmlTc2.Align = "Right";

                    HtmlTc3.Controls.Add(drpList);

                    string strReason = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_36 == null ? "Reason :" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_36;
                    string strUser = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_37 == null ? "User : " : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_37;
                    //Code for Show RejectReason in Dept Header-Add By syed
                    HtmlTable HtmlTab1 = new HtmlTable();
                    HtmlTableRow HtmlTr1 = new HtmlTableRow();
                    HtmlTableCell HtmlTd1 = new HtmlTableCell();
                    //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
                    List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
                    Label lblReason = new Label();
                    lblReason.ID = "lblGrp" + sub + "_Grp" + k;
                    lblReason.Text = "" + strReason.Trim() + "";
                    HtmlTab1.Attributes.Add("Style", "display:none");
                    HtmlTab1.ID = "tblGrpStatusReason1" + sub + "_Grp" + k;
                    HtmlTd1.Controls.Add(lblReason);
                    HtmlTr1.Controls.Add(HtmlTd1);
                    HtmlTab1.Controls.Add(HtmlTr1);
                    HtmlTc4.Controls.Add(HtmlTab1);

                    HtmlTab1 = new HtmlTable();
                    HtmlTr1 = new HtmlTableRow();
                    HtmlTd1 = new HtmlTableCell();
                    Label lblOpinionUser = new Label();
                    lblOpinionUser.ID = "lblOpinionUser" + sub + "_Grp" + k;
                    lblOpinionUser.Text = "" + strUser.Trim() + " ";
                    HtmlTab1.Attributes.Add("Style", "display:none");
                    HtmlTab1.ID = "tblGrpStatusOpinion1" + sub + "_Grp" + k;
                    HtmlTd1.Controls.Add(lblOpinionUser);
                    HtmlTr1.Controls.Add(HtmlTd1);
                    HtmlTab1.Controls.Add(HtmlTr1);
                    HtmlTc4.Controls.Add(HtmlTab1);

                    HtmlTab1 = new HtmlTable();
                    HtmlTr1 = new HtmlTableRow();
                    HtmlTd1 = new HtmlTableCell();
                    DropDownList drpDeptList1 = new DropDownList();
                    drpDeptList1.ID = "ddlGrpReason" + sub + "_Grp" + k;
                    // drpDeptList1.ID=sub + "_Grp" + k;
                    drpDeptList1.CssClass = "ddl";
                    drpDeptList1.DataSource = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
                    drpDeptList1.DataTextField = "ReasonDesc";
                    drpDeptList1.DataValueField = "ReasonID";
                    drpDeptList1.DataBind();
                    drpDeptList1.Items.Insert(0, strSelect);
                    drpDeptList1.SelectedIndex = 0;
                    drpDeptList1.Attributes.Add("onchange", "javascript:ChangeGrpStatusReason('" + sub + "',this.id);");

                    HtmlTab1.Attributes.Add("Style", "display:none");
                    HtmlTab1.ID = "tblGrpStatusReason2" + sub + "_Grp" + k;
                    HtmlTd1.Controls.Add(drpDeptList1);
                    HtmlTr1.Controls.Add(HtmlTd1);
                    HtmlTab1.Controls.Add(HtmlTr1);
                    HtmlTc5.Controls.Add(HtmlTab1);

                    HtmlTab1 = new HtmlTable();
                    HtmlTr1 = new HtmlTableRow();
                    HtmlTd1 = new HtmlTableCell();
                    DropDownList drpDeptList3 = new DropDownList();
                    drpDeptList3.ID = "ddlGrpOpinionUser" + sub + "_Grp" + k;
                    drpDeptList3.CssClass = "ddl";
                    ListItem item = new ListItem();
                    item.Text = strSelect.Trim();
                    item.Value = "0";
                    drpDeptList3.Items.Insert(0, item);
                    drpDeptList3.SelectedIndex = 0;
                    drpDeptList3.Attributes.Add("onchange", "javascript:ChangeGrpStatusOpinion('" + sub + "',this.id);");

                    HtmlTab1.Attributes.Add("Style", "display:none");
                    HtmlTab1.ID = "tblGrpStatusOpinion2" + sub + "_Grp" + k;
                    HtmlTd1.Controls.Add(drpDeptList3);
                    HtmlTr1.Controls.Add(HtmlTd1);
                    HtmlTab1.Controls.Add(HtmlTr1);
                    HtmlTc5.Controls.Add(HtmlTab1);

                    HtmlTc4.Align = "Right";
                    HtmlTc5.Align = "Left";

                    HtmlTr.Cells.Add(HtmlTc1);
                    HtmlTr.Cells.Add(HtmlTc2);
                    HtmlTr.Cells.Add(HtmlTc3);
                    HtmlTr.Cells.Add(HtmlTc4);
                    HtmlTr.Cells.Add(HtmlTc5);
                    HtmlTab.Width = "97%";

                    HtmlTab.Rows.Add(HtmlTr);

                    tc.Controls.Add(HtmlTab);
                    //tc.Attributes.Add("OnClick", "javascript:changeGroupName(this.id);");


                    tc.BorderWidth = 1;
                    tc.Style.Add("BorderColor", "#ff0000");

                    tr.Cells.Add(tc);
                    tr.Height = 20;
                    tr.CssClass = "dataheaderInvCtrl";
                    drawNewPattern.Rows.Add(tr);

                }
                //Below line commented to activate deptwise status chage - starts
                //else
                //{
                //    tr = new TableRow();
                //    tc = new TableCell();
                //    tc.Width = Unit.Percentage(50);
                //    tc.Text = objDP.InvestigationName;
                //    if (objDP.InvestigationName != "")
                //    {
                //        tc.BorderWidth = 1;
                //        tr.CssClass = "dataheaderInvCtrl";
                //    }
                //    tr.Cells.Add(tc);
                //    tr.Height = 20;
                //    drawNewPattern.Rows.Add(tr);
                //}
                ////Below line commented to deactive deptwise status chage - starts
                else
                {
                    tr = new TableRow();
                    tc = new TableCell();
                    tc.Width = Unit.Percentage(20);
                    //tc.Text = objDP.InvestigationName;

                    HtmlTable HtmlTab = new HtmlTable();
                    HtmlTableRow HtmlTr = new HtmlTableRow();
                    HtmlTableCell HtmlTc1 = new HtmlTableCell();
                    HtmlTableCell HtmlTc2 = new HtmlTableCell();
                    HtmlTableCell HtmlTc3 = new HtmlTableCell();





                    Label Deptlbl = new Label();
                    Deptlbl.Text = objDP.InvestigationName;
                    HtmlTc1.Controls.Add(Deptlbl);
                    if (objDP.InvestigationName != "")
                    {
                        string sub = string.Empty;
                        int subStatPos = objDP.InvestigationName.IndexOf("<U>");
                        int subEndPos = objDP.InvestigationName.IndexOf("</U>");
                        int subLength = subEndPos - subStatPos;
                        if (subLength > 0)
                        {
                            sub = objDP.InvestigationName.Substring(subStatPos + 3, subLength - 3);
                        }

                        k += 1;
                        tc.BorderWidth = 1;
                        tr.CssClass = "dataheaderInvCtrl";

                        DropDownList drpDeptList = new DropDownList();
                        if (RoleName == "Physician Assistant")
                        {
                            drpDeptList.ID = "ddlDptStatus" + objDP.InvestigationName + k;
                        }
                        else
                        {
                            drpDeptList.ID = objDP.InvestigationName + k;
                        }
                   
                        drpDeptList.CssClass = "ddl";
                        //header = header.OrderBy(p => p.InvestigationStatusID).ToList();
                        header1 = header.GroupBy(a => a.DisplayText).Select(g => g.First()).ToList();
                        for (int i = 0; i < header1.Count; i++)
                        {
                            drpDeptList.Items.Add(new ListItem(header1[i].DisplayText, header1[i].StatuswithID));
                        }
                        //drpDeptList.Items.Add("Completed");
                        //drpDeptList.Items.Add("Approve");
                        //drpDeptList.Items.Add("Reject");
                        //drpDeptList.Items.Add("Retest");

                        drpDeptList.Attributes.Add("onchange", "javascript:ChangeDeptStatus('" + sub + "',this.id);");
                        ////Commend by karthick.N for loading inv status 
                        ////ScriptManager.RegisterStartupScript(this, this.GetType(), drpDeptList.ClientID, "javascript:ChangeDeptStatus('" + sub + "',\"" + drpDeptList.ClientID + "\");", true);
                        ////Commend by karthick.N for loading inv status 
                        //drpList.Items.Add("Approve");

                        //drpDeptList.Attributes.Add("onchange", "javascript:alert('123')");
                        if (subLength > 0)
                        {
                            HtmlTc1.Controls.Add(drpDeptList);
                        }

                        //Code for Show RejectReason in Dept Header-Add By syed
                        HtmlTable HtmlTab1 = new HtmlTable();
                        HtmlTableRow HtmlTr1 = new HtmlTableRow();
                        HtmlTableCell HtmlTd1 = new HtmlTableCell();
                        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
                        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
                        Label lblReason = new Label();
                        lblReason.ID = "lbl" + objDP.InvestigationName + k;
                        lblReason.Text = "Reason :";
                        HtmlTab1.Attributes.Add("Style", "display:none");
                        HtmlTab1.ID = "tblStatusReason1" + objDP.InvestigationName + k;
                        HtmlTd1.Controls.Add(lblReason);
                        HtmlTr1.Controls.Add(HtmlTd1);
                        HtmlTab1.Controls.Add(HtmlTr1);
                        HtmlTc2.Controls.Add(HtmlTab1);

                        HtmlTab1 = new HtmlTable();
                        HtmlTr1 = new HtmlTableRow();
                        HtmlTd1 = new HtmlTableCell();
                        Label lblOpinionUser = new Label();
                        lblOpinionUser.ID = "lblOpinionUser" + objDP.InvestigationName + k;
                        lblOpinionUser.Text = "User : ";
                        if (RoleName != "Physician Assistant")
                        {
                            HtmlTab1.Attributes.Add("Style", "display:none");
                        }
                       
                        HtmlTab1.ID = "tblStatusOpinion1" + objDP.InvestigationName + k;
                        HtmlTd1.Controls.Add(lblOpinionUser);
                        HtmlTr1.Controls.Add(HtmlTd1);
                        HtmlTab1.Controls.Add(HtmlTr1);
                        HtmlTc2.Controls.Add(HtmlTab1);

                        HtmlTab1 = new HtmlTable();
                        HtmlTr1 = new HtmlTableRow();
                        HtmlTd1 = new HtmlTableCell();
                        DropDownList drpDeptList1 = new DropDownList();
                        drpDeptList1.ID = "ddlReason" + objDP.InvestigationName + k;
                        drpDeptList1.CssClass = "ddl";
                        //drpDeptList1.DataSource = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
                        //drpDeptList1.DataTextField = "ReasonDesc";
                        //drpDeptList1.DataValueField = "ReasonID";
                        //drpDeptList1.DataBind();
                        drpDeptList1.Items.Insert(0, strSelect.Trim());
                        drpDeptList1.SelectedIndex = 0;
                        drpDeptList1.Attributes.Add("onchange", "javascript:ChangeDeptStatusReason('" + sub + "',this.id);");

                        HtmlTab1.Attributes.Add("Style", "display:none");
                        HtmlTab1.ID = "tblStatusReason2" + objDP.InvestigationName + k;
                        HtmlTd1.Controls.Add(drpDeptList1);
                        HtmlTr1.Controls.Add(HtmlTd1);
                        HtmlTab1.Controls.Add(HtmlTr1);
                        HtmlTc3.Controls.Add(HtmlTab1);

                        HtmlTab1 = new HtmlTable();
                        HtmlTr1 = new HtmlTableRow();
                        HtmlTd1 = new HtmlTableCell();
                        DropDownList drpDeptList3 = new DropDownList();
                        drpDeptList3.ID = "ddlOpinionUser" + objDP.InvestigationName + k;
                        drpDeptList3.CssClass = "ddl";
                        ListItem item = new ListItem();
                        item.Text = strSelect.Trim();
                        item.Value = "0";
                        drpDeptList3.Items.Insert(0, item);
                        drpDeptList3.SelectedIndex = 0;
                        drpDeptList3.Attributes.Add("onchange", "javascript:ChangeDeptStatusOpinion('" + sub + "',this.id);");
                        if (RoleName != "Physician Assistant")
                        {
                            HtmlTab1.Attributes.Add("Style", "display:none");
                        }
                        HtmlTab1.ID = "tblStatusOpinion2" + objDP.InvestigationName + k;
                        HtmlTd1.Controls.Add(drpDeptList3);
                        HtmlTr1.Controls.Add(HtmlTd1);
                        HtmlTab1.Controls.Add(HtmlTr1);
                        HtmlTc3.Controls.Add(HtmlTab1);
                        if (RoleName == "Physician Assistant")
                        {
                            Users_BL oUserBL = new Users_BL(base.ContextInfo);
                            ContextInfo.AdditionalInfo = "RCROLE";
                            ContextInfo.DepartmentCode = objDP.DeptName;
                            oUserBL.GetUserListByRole(OrgID, RoleID, out lstSecondOpinionUser);
                            ContextInfo.AdditionalInfo = "";
                            ContextInfo.DepartmentCode = "";
                           
                            drpDeptList3.DataSource = lstSecondOpinionUser;

                            drpDeptList3.DataTextField = "Name";
                            drpDeptList3.DataValueField = "LoginID";
                            
                            drpDeptList3.SelectedIndex = 0;
                            drpDeptList3.DataBind();
                            ListItem item1 = new ListItem();
                            item1.Text = strSelect.Trim();
                            item1.Value = "0";

                            drpDeptList3.Items.Insert(0, "--Select--");
                            drpDeptList3.SelectedIndex = 0;
                        }

                        //HtmlTab1 = new HtmlTable();
                        //HtmlTr1 = new HtmlTableRow();
                        //HtmlTd1 = new HtmlTableCell();
                        //DropDownList drpDeptListRC = new DropDownList();
                        //drpDeptListRC.ID = "ddlOpinionUserRC"+ k;
                        //drpDeptListRC.CssClass = "ddl";
                        //ListItem item1 = new ListItem();
                        //item1.Text = strSelect.Trim();
                        //item1.Value = "0";
                        //drpDeptListRC.Items.Insert(0, item1);

                       
                       
                        //drpDeptListRC.Attributes.Add("onchange", "javascript:ChangeDeptStatusOpinionRC('" + sub + "',this.id);");

                        //HtmlTab1.Attributes.Add("Style", "display:none");
                        //HtmlTab1.ID = "tblStatusOpinionRC" + objDP.InvestigationName + k;
                        //HtmlTd1.Controls.Add(drpDeptListRC);
                        //HtmlTr1.Controls.Add(HtmlTd1);
                        //HtmlTab1.Controls.Add(HtmlTr1);
                        //HtmlTc3.Controls.Add(HtmlTab1);


                        //UpdatePanel up2 = new UpdatePanel();
                        //up2.ID = "UpdatePanel2" + objDP.InvestigationName + k; ;
                        //up2.ChildrenAsTriggers = true;
                        //up2.UpdateMode = UpdatePanelUpdateMode.Conditional;

                        //up2.ContentTemplateContainer.Controls.Add(drpDeptList1);
                        //HtmlTc3.Controls.Add(up2);




                    }
                    HtmlTr.Cells.Add(HtmlTc1);
                    HtmlTr.Cells.Add(HtmlTc2);
                    HtmlTr.Cells.Add(HtmlTc3);
                    HtmlTab.Rows.Add(HtmlTr);
                    //tr.Cells.Add(tc);
                    tc.Controls.Add(HtmlTab);
                    tr.Controls.Add(tc);
                    tr.Height = 20;
                    drawNewPattern.Rows.Add(tr);
                }

            }
            if (objDP.InvestigationID > 0)
            {
                //if (InvIDs == "")
                //{
                //    InvIDs = objDP.InvestigationID.ToString();
                //}
                //else
                //{
                //    InvIDs += "," + objDP.InvestigationID;
                //}
                switch (objDP.PatternID)
                {
                    //Load comman pattern for Unmapping investigation

                    case (Int32)TaskHelper.Pattern.Commanpattern:
                        myControl = LoadCommanPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern1:
                        myControl = loadBioControl(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern2:
                        myControl = LoadBioPattern2(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.GTTContentPattern:
                        myControl = LoadGTTContentPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;


                    //case (Int32)TaskHelper.Pattern.HematPattern7:
                    //    myControl = loadHematPattern7(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;

                    case (Int32)TaskHelper.Pattern.MicroPattern:
                        myControl = loadMicroPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern3:
                        myControl = LoadBioPattern3(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;


                    case (Int32)TaskHelper.Pattern.BioPattern4:
                        myControl = LoadBioPattern4(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern5:
                        myControl = LoadBioPattern5(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;
                    case (Int32)TaskHelper.Pattern.FishPattern1:
                        myControl = LoadFishPattern1(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.FishPattern2:
                        myControl = LoadFishPattern2(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;
                    case (Int32)TaskHelper.Pattern.MultiAddControl:
                        myControl = LoadMultiAddControl(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.ResultFishPattern:
                        myControl = LoadResultsFishPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb1.Append("SaveFishResultsPattern('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.ResultFishPattern1:
                        myControl = LoadResultsFishPattern1(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb2.Append("SaveFishResultsPattern1('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.BRCAPattern:
                        myControl = LoadResultsBCRA(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb4.Append("SaveBRCAPattern('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.BRCAPattern1:
                        myControl = LoadResultsBCRA1(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb5.Append("SaveBRCA('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.MicroBio1:
                        myControl = LoadResultsMicroBio1(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb8.Append("SaveMicroBio1Pattern('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.MolBioPattern:
                        myControl = LoadMolBio(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb3.Append("SaveMolBioPattern('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;

                    case (Int32)TaskHelper.Pattern.ImagePattern:
                        myControl = LoadImagePattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.PDFUploadpattern:
                        myControl = LoadPDFPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.TablepatternautopopulateV2:
                        myControl = LoadTablepatternautopopulateV2(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb11.Append("SaveTablepatternautopopulate('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    //case (Int32)TaskHelper.Pattern.HematPattern6:
                    //    myControl = loadHematPattern6(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;



                    //case (Int32)TaskHelper.Pattern.HematPattern8:
                    //    myControl = loadHematPattern8(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;


                    //case (Int32)TaskHelper.Pattern.HematPattern9:
                    //    myControl = loadHematPattern9(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;


                    //case (Int32)TaskHelper.Pattern.HematPattern10:
                    //    myControl = loadHematPattern10(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;

                    //case (Int32)TaskHelper.Pattern.HematPattern11:
                    //    myControl = loadHematPattern11(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;

                    case (Int32)TaskHelper.Pattern.ClinicalPattern12:
                        myControl = loadClinicalPattern12(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.ClinicalPattern13:
                        myControl = loadClincalPattern13(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    //case (Int32)TaskHelper.Pattern.DifferentialPattern:
                    //    myControl = loadDifferentialPattern12(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;

                    //case (Int32)TaskHelper.Pattern.ANAPattern:
                    //    myControl = LoadANAControl(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;

                    //case (Int32)TaskHelper.Pattern.WidelPattern:
                    //    myControl = LoadwidelControl(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;


                    //case (Int32)TaskHelper.Pattern.CastPattern:
                    //    myControl = loadCastPattern(objDP);
                    //    tblResult = new Table();
                    //    tr = new TableRow();
                    //    tc = new TableCell();
                    //    tc.Width = Unit.Percentage(70);
                    //    tc.Controls.Add(myControl);
                    //    tr.Cells.Add(tc);
                    //    drawNewPattern.Rows.Add(tr);

                    //    break;



                    case (Int32)TaskHelper.Pattern.FluidPattern:
                        myControl = LoadFluidPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.hpPattern:
                        myControl = LoadHPPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;
                    case (Int32)TaskHelper.Pattern.hpPatternQuantum:
                        myControl = LoadHPPatternQuantum(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivity:
                        myControl = LoadCultureAndSensitivityPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivityV1:
                        myControl = LoadCultureAndSensitivityV1Pattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivityV2:
                        myControl = LoadCultureAndSensitivityV2Pattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb.Append("SaveCultureSensitivityV2Details('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;

                    case (Int32)TaskHelper.Pattern.StoneAnalysis:
                        myControl = LoadStoneAnalysis(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.microbiopattern:
                        myControl = LoadMicBioPattern1(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.faCellsPattern:
                        myControl = LoadFACellsPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BodyFluidAnalysis:
                        myControl = LoadBodyFluidAnalysisPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.SMEAR:
                        myControl = LoadSmearPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.SemenAnalysisNewPattern:
                        myControl = LoadSemenAnalysisNewPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.faChemistryPattern:
                        myControl = LoadFAChemistryPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.faCytologyPattern:
                        myControl = LoadFACytologyPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.faImmunologyPattern:
                        myControl = LoadFAImmunologyPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.FungalSmearPattern:
                        myControl = LoadFSmearPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyWithMethod:
                        myControl = LoadAbMethod(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyQualitative:
                        myControl = LoadAbQualitativeMethod(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;



                    case (Int32)TaskHelper.Pattern.Semenanalysis:
                        myControl = LoadSemenAnalysis(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.Imaging:
                        myControl = LoadImaging(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.PheripheralSmear:
                        myControl = LoadSmear(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.BleedingTime:
                        myControl = loadBleedingTime(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.TextualPattern:
                        myControl = LoadTextualPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;
                    case (Int32)TaskHelper.Pattern.GTT:
                        myControl = LoadGTT(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;
                    case (Int32)TaskHelper.Pattern.OrganismDrugPattern:
                        myControl = loadOrganismDrugPatternControl(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb6.Append("SaveOrganismDrugPatternDetails('" + objDP.InvestigationID + objDP.GroupID + "','" + myControl.ClientID + "');");
                        break;
                    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
                    case (Int32)TaskHelper.Pattern.OrganismDrugPatternWithLevel:
                        myControl = OrganismDrugPatternWithLevel(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb6.Append("SaveOrganismDrugPatternDetails('" + objDP.InvestigationID + objDP.GroupID + "','" + myControl.ClientID + "');");
                        break;
                    /* END | sabari | 20181129 | Dev | Culture Report */
                    case (Int32)TaskHelper.Pattern.MicroStainPattern:
                        myControl = loadMicroStainPatternControl(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb7.Append("SaveMicroStainPatternDetails('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.HEMATOLOGY:
                        myControl = loadMicroHEMATOLOGY(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb9.Append("SaveHEMATOLOGYPatternDetails('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.GeneralPattern:
                        myControl = LoadGeneralPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb10.Append("SaveGeneralPattern('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.Tablepatternautopopulate:
                        myControl = LoadTablepatternautopopulate(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(50);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        sb11.Append("SaveTablepatternautopopulate('" + objDP.InvestigationID + "','" + myControl.ClientID + "');");
                        break;
                    case (Int32)TaskHelper.Pattern.RichTextPattern:
                        myControl = LoadRichTextPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;
                    case (Int32)TaskHelper.Pattern.HistoImageDescriptionPattern:
                        myControl = LoadHistoImageDescriptionPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;
                    case (Int32)TaskHelper.Pattern.ImageDescriptionpattern:
                        myControl = LoadImageDescription(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;
                }
            }
        }
        if (sb.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveOrganisumXMLData", "function CallingSaveCultureSensitiveV2(){" + sb.ToString() + "}", true);
        }
        if (sb1.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData", "function  CallingSaveFishResultpattern(){" + sb1.ToString() + "}", true);
        }
        if (sb2.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData", "function  CallingSaveFishResultpattern1(){" + sb2.ToString() + "}", true);
        }
        if (sb3.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData", "function  CallingSaveMolBioPattern(){" + sb3.ToString() + "}", true);
        }
        if (sb4.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData", "function  CallingSaveBRCAPattern(){" + sb4.ToString() + "}", true);
        }
        if (sb5.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData1", "function  CallingSaveBRCA(){" + sb5.ToString() + "}", true);
        }
        if (sb6.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveOrganisumDrugDetails", "function CallingOrganisumDrugPatternDetails(){" + sb6.ToString() + "}", true);
        }
        if (sb7.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveMicroStainDetails", "function CallingMicroStainPatternDetails(){" + sb7.ToString() + "}", true);
        }
        if (sb8.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData2", "function  CallingSaveMicroBio1Pattern(){" + sb8.ToString() + "}", true);
        }
        if (sb9.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveResultXMLData3", "function  CallingSaveHEMATOLOGYPattern(){" + sb9.ToString() + "}", true);
        }
        if (sb10.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveGeneralPattern", "function  CallingSaveGeneralPattern(){" + sb10.ToString() + "}", true);
        }

        if (sb11.Length > 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CallSaveTablepatternautopopulate", "function  CallingSaveTablepatternautopopulate(){" + sb11.ToString() + "}", true);
        }
        foreach (string sFormula in hFormulaCollection.Values)
        {
            if (sFormula.Contains("confirm"))
            {
                sJsSaveValidationFuntion.Append(sFormula);
            }
            else
            {
                sJsFuntion.Append(sFormula);
            }
        }
        sJsFuntion = sJsFuntion.Replace("parseFloat([", "parseFloat(\"test_");
        sJsFuntion = sJsFuntion.Replace("])", "\")");
        sJsFuntion.Append("}</script>");

        sJsSaveValidationFuntion = sJsSaveValidationFuntion.Replace("parseFloat([", "parseFloat(\"test_");
        sJsSaveValidationFuntion = sJsSaveValidationFuntion.Replace("])", "\")");
        sJsSaveValidationFuntion.Append(" return true; } catch (e) { return true; }");
        sJsSaveValidationFuntion.Append("}</script>");

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligense", sJsFuntion.ToString(), false);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "IntelligenseSave", sJsSaveValidationFuntion.ToString(), false);


        foreach (string sFormulas in hIFormulaCollection.Values)
        {
            //string tempFormulas = sFormulas;
            //foreach (long investigationID in hInvestigationFormulaCollection.Keys)
            //{
            //    if (tempFormulas.Contains("[" + investigatgionID + "]"))
            //    {
            //        tempFormulas = tempFormulas.Replace("[" + investigatgionID + "]", "document.getElementById('" + hIFormulaCollection[investigatgionID] + "').value");
            //    }
            //}
            sJsINVFuntion.Append(sFormulas);
        }

        sJsINVFuntion.Append("}</script>");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligenseser", sJsINVFuntion.ToString(), false);

        sJsSaveValidationFuntionEmptyValue.Append("<script language ='javascript' type ='text/javascript'>function ValidationFuntionEmptyValueFuntion(){ try { ");
        string EmptyValueFormulaString = "debugger;";
        EmptyValueFormulaString = "var Investgationname1 = 'The Below Test Values are Empty :\\n\\n'; var Investgationname = '';";
        foreach (PatientInvestigation lst in lstInvestigationValuesforAlert)
        {

            EmptyValueFormulaString += "if (document.getElementById('" + lst.InstrumentName + "').value == '') {  Investgationname += " + "'" + lst.InvestigationName + " \\n'" + " }";

        }
        //EmptyValueFormulaString += "var Investgationname = 'The Below Test Values are Empty: \n";
        //EmptyValueFormulaString += "'+Investgationname+' Do you want to continue?";
        EmptyValueFormulaString += " if(Investgationname!='') {return confirm(Investgationname1+Investgationname); } else{ return true; } ;";
        sJsSaveValidationFuntionEmptyValue.Append(EmptyValueFormulaString);
        sJsSaveValidationFuntionEmptyValue.Append(" } catch (e) { return true; }");
        sJsSaveValidationFuntionEmptyValue.Append("}</script>");
        if (hdnIscommonValidation.Value == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "EmptyValidation", sJsSaveValidationFuntionEmptyValue.ToString(), false);
        }
    }

    # region Load User Control

    public Control loadBioControl(PatientInvestigation lstInve)
    {
        Investigation_checkInvest bioPattern1;
        bioPattern1 = (Investigation_checkInvest)LoadControl(lstInve.PatternName);
        Boolean isFormula = false;
        try
        {
            bioPattern1.OrgID = OrgID;
            bioPattern1.RoleID = RoleID;
            bioPattern1.LID = LID;
            //Get Data to populate Status-Reason list
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //bioPattern1.LoadInvStatusReason(lstInvReasonMaster);

            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int GroupID = lstInve.GroupID;
            long InvestigationID = lstInve.InvestigationID;
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == GroupID);
            var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);

            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            bioPattern1.Name = lstInve.InvestigationName;
            bioPattern1.UOM = lstInve.UOMCode;
            //checkInvest.ID = Convert.ToString(lstInve.InvestigationID);1~grpnam~5
            string bioPattern1ID = (Convert.ToString(lstInve.InvestigationID) + "~" + ((lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") == null ? (lstInve.PackageName != null && lstInve.PackageName != "" ? lstInve.PackageName : (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "")) : (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "").Trim()) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            bioPattern1.ID = bioPattern1ID;
            bioPattern1.ControlID = Convert.ToString(lstInve.InvestigationID);
            //var set = header;
            bioPattern1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            bioPattern1.GroupID = lstInve.GroupID;
            bioPattern1.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            bioPattern1.PackageID = lstInve.PackageID;
            bioPattern1.PackageName = lstInve.PackageName;
            bioPattern1.DecimalPlaces = lstInve.DecimalPlaces;
            bioPattern1.ResultValueType = lstInve.ResultValueType;
            bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstInve.AutoApproveLoginID);
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            bioPattern1.TestStatus = lstInve.TestStatus;
            bioPattern1.IsAutoAuthorize = lstInve.IsAutoAuthorize;

            //bioPattern1.RefRange = lstInve.ReferenceRange; // "MALE:0 – 20 mm/hr FEMALE :0 – 30 mm/hr";
            if (lstInve.ReferenceRange != null)
            {
                bioPattern1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                bioPattern1.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            bioPattern1.Text = lstInve.Value;

            // bioPattern1.Readonly = false;
            bioPattern1.MakeReadOnly(bioPattern1.ID);
            bioPattern1.CurrentRoleName = RoleName.Trim();
            bioPattern1.LabTechEditMedRem = strLabTechToEditMedRem;
            //checkInvest.setAttributes(Convert.ToString(checkInvest.ID));
            lstControl.Add(bioPattern1.ID);
            lstpatternID.Add(lstInve.PatternID);
            bioPattern1.PatientVisitID = vid;
            bioPattern1.PatternID = (lstInve.PatternID);
            bioPattern1.POrgid = Convert.ToInt32(hdnOrgID.Value);
            bioPattern1.CurrentRoleName = RoleName.Trim();
            bioPattern1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            if (lstInve.CONV_Factor != 0)
            {
                bioPattern1.ConvFactorvalue = lstInve.CONV_Factor;
                bioPattern1.CONVFactorDecimalPt = lstInve.CONVFactorDecimalPt;
                bioPattern1.ConvUOMCode = lstInve.CONV_UOMCode;
            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                bioPattern1.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == GroupID));
            }
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName == null ? (lstInve.PackageName != null && lstInve.PackageName != "" ? lstInve.PackageName : lstInve.GroupName) : lstInve.GroupName.Trim()) + "|" + bioPattern1.ID + "_ddlstatus";
            //}
            //Value Formula
            //string ClientID = ((TextBox)bioPattern1.FindControl("txtValue")).ClientID;
            TextBox txtValue = (TextBox)bioPattern1.FindControl("txtValue");
            string ClientID = bioPattern1ID + "_txtValue";
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            HiddenField hdnResultValue = (HiddenField)bioPattern1.FindControl("hdnResultValue");
            //HtmlImage imgDeviceValue = (HtmlImage)bioPattern1.FindControl("imgDeviceValue");
            //imgDeviceValue.Attributes.Add("onclick", "javascript:GetDeviceValue('" + OrgID + "','" + vid + "','" + lstInve.InvestigationID + "' );");
            //System.Collections.Specialized.StringDictionary hFormulaCollection =  new System.Collections.Specialized.StringDictionary();
            if (!string.IsNullOrEmpty(lstInve.InvValidationText))
            {
                if (!hIFormulaCollection.Contains(lstInve.InvestigationID))
                {
                    hIFormulaCollection.Add(lstInve.InvestigationID, lstInve.InvValidationText);
                }
                FormulaINV = hIFormulaCollection[lstInve.InvestigationID].ToString();
                if (FormulaINV.Contains("[" + lstInve.InvestigationID + "]"))
                {
                    if (FormulaINV.Replace(" ", "").Contains("[" + lstInve.InvestigationID + "]="))
                    {
                        if (lstInve.ResultValueType == "NTS")
                        {
                            FormulaINV = FormulaINV + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                        }
                        else
                        {
                            FormulaINV = FormulaINV + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                        }
                        bioPattern1.ShowComputationFieldEditOption = true;
                    }
                    FormulaINV = FormulaINV.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                    FormulaINV = FormulaINV.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                }
                hIFormulaCollection[lstInve.InvestigationID] = FormulaINV;

            }//Investigation formula
            HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
            bool isFormulaDependent = false;

            List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();

            long ReturnRes = -1;

            ReturnRes = invesBL.GetInvComputationRuleByGroup(OrgID, lstInve.GroupID, out lstInvOrgGroup);
            if (lstInvOrgGroup.Count() > 0)
            {
                bioPattern1.Formula = lstInvOrgGroup[0].ValidationRule;
            }
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                // var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstim[0].AutoApproveLoginID);
                bioPattern1.setXmlValues(lstim[0].ReferenceRange);

                if (strSingleReferenceRange == "Y")
                {
                    bioPattern1.setPanicXmlValues(lstim[0].PanicRange);
                }
                else
                {
                    bioPattern1.setPanicXmlValues(lstim[0].ReferenceRange);
                }
            }
            //var lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            bioPattern1.BatchWise(false);
            if (!string.IsNullOrEmpty(lstInve.ValidationText))
            {
                isFormula = true;
                if (!hFormulaCollection.Contains(lstInve.GroupID))
                {
                    hFormulaCollection.Add(lstInve.GroupID, lstInve.ValidationText);

                }

                Formula = hFormulaCollection[lstInve.GroupID].ToString();
                if (Formula.Contains("[" + lstInve.InvestigationID + "]"))
                {
                    isFormulaDependent = true;
                    if (Formula.Replace(" ", "").Contains("[" + lstInve.InvestigationID + "]="))
                    {
                        HtmlAnchor EditButton = (HtmlAnchor)bioPattern1.FindControl("ATag");
                        EditButton.Visible = false;
                        //   HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
                        HiddenField hdnPanicXmlContent = (HiddenField)bioPattern1.FindControl("hdnPanicXmlContent");
                        TextBox txtIsAbnormal = (TextBox)bioPattern1.FindControl("txtIsAbnormal");
                        Label lblName = (Label)bioPattern1.FindControl("lblName");
                        Label lblUnit = (Label)bioPattern1.FindControl("lblUnit");
                        bool isInterpretationRange = false;
                        if (!string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && string.IsNullOrEmpty(bioPattern1.DeviceID))
                        {
                            XElement xe = XElement.Parse(hdnXmlContent.Value);
                            var Range = from range in xe.Elements("resultsinterpretationrange").Elements("property")
                                        select range;
                            if (Range != null && Range.Count() > 0)
                            {
                                isInterpretationRange = true;
                            }
                        }
                        if (lstInve.ResultValueType == "NTS")
                        {
                            if (isInterpretationRange)
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','','');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                            else
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                        }
                        else
                        {
                            if (isInterpretationRange)
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','','');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                            }
                            else
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                            }
                        }
                        bioPattern1.ShowComputationFieldEditOption = true;
                        hdnComputationFieldList.Value = hdnComputationFieldList.Value + ClientID + "^";
                        Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                        Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                    }
                    else
                    {
                        bool isSpecialValue = false;
                        if ((lstPendingValue.Count > 0 && !String.IsNullOrEmpty(lstPendingValue[0].Value)))
                        {
                            LabUtil oLabUtil = new LabUtil();
                            oLabUtil.IsSpecialResultValue(lstPendingValue[0].Value, out isSpecialValue);
                        }
                        bioPattern1.IsSpecialValue = isSpecialValue;
                        Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                        if (lstInve.ResultValueType == "NTS" || isSpecialValue)
                        {
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + hdnResultValue.ClientID + "').value");
                        }
                        else
                        {
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                        }
                    }
                }
                hFormulaCollection[lstInve.GroupID] = Formula;
            }
            string OtherReferenceRange = string.Empty;
            string ReferenceRange;
            string ConReferenceRange = string.Empty;
            string[] ConvReferenceRange;
            // bioPattern1.setXmlValues(lstInve.IOMReferenceRange );
            // HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
            //if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            if (lstim != null && lstim.Count > 0)
            {
                //var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstim[0].AutoApproveLoginID);
                bioPattern1.setXmlValues(lstim[0].ReferenceRange);
                bioPattern1.BatchWise(false);
                //-----Convert XmlReferenceRange to String For FormulaField Investigations------------//
                if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
                {
                    ConvertXmlToString(lstInve.IOMReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange);

                    if (ReferenceRange != null)
                    {
                        bioPattern1.RefRange = ReferenceRange.Trim().Replace("<br>", "\n"); // <90
                    }
                    if (OtherReferenceRange != null)
                    {
                        ConReferenceRange = OtherReferenceRange;
                    }
                    if (isFormula)
                    {
                        if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                        {
                            hdnlstNotYetResolvedRRParams.Value = bioPattern1.ValidateResultParameter;
                        }
                        else if (!hdnlstNotYetResolvedRRParams.Value.Contains(bioPattern1.ValidateResultParameter))
                        {
                            hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + bioPattern1.ValidateResultParameter;
                        }
                    }
                }
                else
                {
                    if (lstInve.ReferenceRange == null)
                    {
                        bioPattern1.RefRange = "";
                        bioPattern1.setXmlValues("");
                    }
                    else
                    {
                        bioPattern1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");

                    }
                    if (lstInve.ConvReferenceRange == null)
                    {
                        ConReferenceRange = "";
                    }
                    else
                    {
                        ConReferenceRange = lstInve.ConvReferenceRange.Trim();
                    }
                    if (isFormula)
                    {
                        if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                        {
                            hdnlstNotYetResolvedRRParams.Value = bioPattern1.ValidateResultParameter;
                        }
                        else if (!hdnlstNotYetResolvedRRParams.Value.Contains(bioPattern1.ValidateResultParameter))
                        {
                            hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + bioPattern1.ValidateResultParameter;
                        }
                    }
                }

                //------------------END---------------------------//


                if (strSingleReferenceRange == "Y")
                {
                    bioPattern1.setPanicXmlValues(lstim[0].PanicRange);
                }
                else
                {
                    bioPattern1.setPanicXmlValues(lstim[0].ReferenceRange);
                }
            }

            if (bioPattern1.RefRange.Contains('-') && ConReferenceRange == string.Empty)
            {
                ConvReferenceRange = bioPattern1.RefRange.Split('-');
                if (lstInve.CONV_Factor > 0)
                {
                    if (ConvReferenceRange != null)
                    {
                        ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[0]) * lstInve.CONV_Factor), lstInve.CONVFactorDecimalPt));
                    }
                    if (ConvReferenceRange.Count() > 0)
                    {
                        ConReferenceRange += "-" + Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[1]) * lstInve.CONV_Factor), lstInve.CONVFactorDecimalPt));
                    }
                }
            }
            else if (ConReferenceRange == string.Empty)
            {
                string[] strArray = { "<=", "<", ">=", ">", "=" };
                if (!string.IsNullOrEmpty(bioPattern1.RefRange))
                {
                    ConvReferenceRange = bioPattern1.RefRange.ToString().Split(strArray, StringSplitOptions.None);

                    string RefRangeSymbol = string.Empty;
                    foreach (string ObjStr in strArray)
                    {
                        if ((bioPattern1.RefRange.Contains(ObjStr) == true))
                        {
                            RefRangeSymbol = ObjStr;
                            break;
                        }
                    }
                    if (lstInve.CONV_Factor > 0)
                    {
                        if (ConvReferenceRange != null)
                        {
                            /*Avoind Roudoff In conv Refranga calculation

                            if (lstInve.CONVFactorDecimalPt == 0)
                            {
                                ConReferenceRange = decimal.Truncate((decimal)(Convert.ToDecimal((ConvReferenceRange[1])) * lstInve.CONV_Factor)).ToString();
                            }
                            else
                            {
                                ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal((ConvReferenceRange[1])) * lstInve.CONV_Factor),lstInve.CONVFactorDecimalPt));
                            }
                            */

                            ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[1]) * lstInve.CONV_Factor), lstInve.CONVFactorDecimalPt));

                            if (ConReferenceRange != "0")
                            {
                                ConReferenceRange = RefRangeSymbol + " " + ConReferenceRange;
                            }
                        }
                    }
                }
            }

            bioPattern1.ConReferenceRange = ConReferenceRange;
            try
            {
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    bioPattern1.AccessionNumber = lstPendingval[0].AccessionNumber;
                    bioPattern1.Dilution = lstPendingval[0].Dilution;
                    bioPattern1.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012

                    if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                    {
                        bioPattern1.IsAbnormal = lstInve.IsAbnormal;

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + bioPattern1.TxtControlID, "LoadAbnormalValue('" + bioPattern1.TxtControlID + "','','" + lstInve.IsAbnormal + "','" + bioPattern1.TestName + "','" + bioPattern1.TestUnit + "','" + bioPattern1.IsAutoAuthorize + "');", true);
                    }
                }
                if (lstInve.IsSensitive != null && (lstInve.IsSensitive == "Y"))
                {
                    bioPattern1.IsSensitive = lstInve.IsSensitive;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + bioPattern1.TxtControlID, "LoadSensitiveValue('" + bioPattern1.TxtControlID + "','','" + lstInve.IsSensitive + "','" + bioPattern1.TestName + "','" + bioPattern1.TestUnit + "');", true);
                }
            }
            catch (Exception e)
            {
            }
            bioPattern1.setNonEditable(lstInve);
            DropDownList ddlstatus = (DropDownList)bioPattern1.FindControl("ddlstatus");

            if (lstInve.Status == InvStatus.Approved)
            {
                //DisableUserControl(bioPattern1, false);
                HtmlTable tblBioContent = (HtmlTable)bioPattern1.FindControl("tblBioContent");
                //bioPattern1.IsStatusCompleted = "Y";
                //tblBioContent.Attributes.Add("style", "display:none");

                //tblBioContent.Style = true;
                //DropDownList ddlstatus = (DropDownList)bioPattern1.FindControl("ddlstatus");
                if (Request.QueryString["IsHold"] == null && Request.QueryString["IsHold"] != "Y")
                {
                    ddlstatus.Visible = false;
                }
                /* BEGIN | NA | Sabari | 20181202 | Created | HOLD Approve Load */
                ddlstatus.Visible = true;
                /* END | NA | Sabari | 20181202 | Created | HOLD   Approve Load */
                Label lblName = (Label)bioPattern1.FindControl("lblName");
                lblName.Enabled = true;
                lblName.Attributes.Add("onclick", "");
                TextBox txtValue1 = (TextBox)bioPattern1.FindControl("txtValue");
                txtValue1.ReadOnly = true;
                HtmlGenericControl spanIsAbnormal = (HtmlGenericControl)bioPattern1.FindControl("spanIsAbnormal");
                spanIsAbnormal.Disabled = true;
                TextBox txtReason = (TextBox)bioPattern1.FindControl("txtReason");
                txtReason.Enabled = false;
                TextBox txtMedRemarks = (TextBox)bioPattern1.FindControl("txtMedRemarks");
                txtMedRemarks.Enabled = false;
                HtmlAnchor ABetaTag = (HtmlAnchor)bioPattern1.FindControl("ABetaTag");
                ABetaTag.Visible = false;
                HtmlAnchor EditButton = (HtmlAnchor)bioPattern1.FindControl("ATag");
                EditButton.Visible = false;

                //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return bioPattern1;
    }
    public Control loadMicroPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_MicroPattern Micro;
        Micro = (Investigation_MicroPattern)LoadControl(lstInve.PatternName);

        string[] Method = new string[6];

        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int GroupID = lstInve.GroupID;

        try
        {
            //Get Data to populate Status-Reason list
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Micro.LoadInvStatusReason(lstInvReasonMaster);

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            Micro.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Micro.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Micro.Name = lstInve.InvestigationName;
            //Micro.ID = Convert.ToString(lstInve.InvestigationID);
            Micro.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Micro.ControlID = Convert.ToString(lstInve.InvestigationID);
            Micro.GroupID = lstInve.GroupID;

            Micro.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Micro.PackageID = lstInve.PackageID;
            Micro.PackageName = lstInve.PackageName;
            Micro.CurrentRoleName = RoleName;
            Micro.LabTechEditMedRem = strLabTechToEditMedRem;
            Micro.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Micro.setAttributes(Convert.ToString(Micro.ID));
            lstControl.Add(Micro.ID);
            lstpatternID.Add(lstInve.PatternID);
            Micro.MakeReadOnly(Micro.ID);
            Micro.AccessionNumber = lstInve.AccessionNumber;
            //  Micro.Readonly = false;
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Micro.ID + "_ddlstatus";
            //}


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadMicroPattern", ex);
        }
        return Micro;
    }
    public Control LoadFishPattern1(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FishPattern1 FishPt;
        FishPt = (Investigation_FishPattern1)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
            //FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID);
            FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishPt.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            FishPt.Name = lstInve.InvestigationName;
            FishPt.GroupID = lstInve.GroupID;
            FishPt.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.ResultValueType = lstInve.ResultValueType;
            FishPt.PatientVisitID = vid;
            FishPt.PatternID = (lstInve.PatternID);
            FishPt.POrgid = Convert.ToInt32(hdnOrgID.Value);
            FishPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            lstControl.Add(FishPt.ID);
            lstpatternID.Add(lstInve.PatternID);
            FishPt.BatchWise(false);
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            long ReturnRes;
            TextBox txtValue = (TextBox)FishPt.FindControl("txtValue");
            string ClientID = txtValue.ClientID;
            //common validate
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            //common validate
            if (!string.IsNullOrEmpty(lstInve.ValidationText))
            {
                if (!hFormulaCollection.Contains(lstInve.GroupID))
                {
                    hFormulaCollection.Add(lstInve.GroupID, lstInve.ValidationText);

                }

                Formula = hFormulaCollection[lstInve.GroupID].ToString();
                if (Formula.Contains("[" + lstInve.InvestigationID + "]"))
                {
                    if (Formula.Replace(" ", "").Contains("[" + lstInve.InvestigationID + "]="))
                    {
                        if (lstInve.ResultValueType == "NTS")
                        {
                            Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + FishPt.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                        }
                        else
                        {
                            Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');formatResult('" + ClientID + "','" + FishPt.DecimalPlaces + "');}";
                        }
                        FishPt.ShowComputationFieldEditOption = true;
                        hdnComputationFieldList.Value = hdnComputationFieldList.Value + ClientID + "^";
                    }
                    Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                    Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                }
                hFormulaCollection[lstInve.GroupID] = Formula;

                //if (Session["formula"] != null)
                //{
                //    Formula = Session["formula"].ToString();
                //}
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            //hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + FishPt.ID + "_ddlstatus";
            //}
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName == null ? (lstInve.PackageName != null && lstInve.PackageName != "" ? lstInve.PackageName : lstInve.GroupName) : lstInve.GroupName.Trim()) + "|" + FishPt.ID + "_ddlstatus";
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));

            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForComments(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));

            }
            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFishPattern1 ", ex);
        }
        return FishPt;
    }
    public Control LoadFishPattern2(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_Fishpattern2 FishPt;
        FishPt = (Investigation_Fishpattern2)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
         //   FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
           //    FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName.Replace(":","").Replace(";", "").Replace("-", "")) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
             FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName!=null? lstInve.GroupName.Replace(":", "").Replace(";", "").Replace("-", ""):"") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishPt.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            FishPt.Name = lstInve.InvestigationName;
            FishPt.GroupID = lstInve.GroupID;
            FishPt.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            FishPt.PatientVisitID = vid;
            FishPt.PatternID = (lstInve.PatternID);
            FishPt.POrgid = Convert.ToInt32(hdnOrgID.Value);
            FishPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.UOM = lstInve.UOMCode;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(FishPt.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + FishPt.ID + "_ddlstatus";
            //}
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForComments(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            //FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID==groupID ));

            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFishPattern2 ", ex);
        }
        return FishPt;
    }
    public Control LoadMultiAddControl(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_MultiAddControl Multiadd;
        Multiadd = (Investigation_MultiAddControl)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Multiadd.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Multiadd.ControlID = Convert.ToString(lstInve.InvestigationID);
            Multiadd.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Multiadd.Name = lstInve.InvestigationName;
            Multiadd.AccessionNumber = lstInve.AccessionNumber;
            Multiadd.GroupID = lstInve.GroupID;
            Multiadd.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            lstControl.Add(Multiadd.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Multiadd.ID + "_ddlstatus";
            //}
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Multiadd.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Multiadd.LoadDataForComments(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            //Multiadd.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID==groupID ));

            Multiadd.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadMultiAddControl ", ex);
        }
        return Multiadd;
    }
    public Control LoadResultsFishPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FishResultPattern FishResults;
        FishResults = (Investigation_FishResultPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishResults.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishResults.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishResults.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            FishResults.Name = lstInve.InvestigationName;
            FishResults.GroupID = lstInve.GroupID;
            FishResults.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            FishResults.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(FishResults.ID);
            lstpatternID.Add(lstInve.PatternID);
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + FishResults.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishResults.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadResultsFishPattern ", ex);
        }
        return FishResults;
    }
    public Control LoadResultsFishPattern1(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FishResultPattern1 FishResults1;
        FishResults1 = (Investigation_FishResultPattern1)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishResults1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishResults1.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishResults1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            FishResults1.Name = lstInve.InvestigationName;
            FishResults1.GroupID = lstInve.GroupID;
            FishResults1.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            FishResults1.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(FishResults1.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + FishResults1.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishResults1.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadResultsFishPattern1 ", ex);
        }
        return FishResults1;
    }
    public Control LoadResultsBCRA(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BRCAPattern BRCA;
        BRCA = (Investigation_BRCAPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            BRCA.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            BRCA.ControlID = Convert.ToString(lstInve.InvestigationID);
            BRCA.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            BRCA.Name = lstInve.InvestigationName;
            BRCA.GroupID = lstInve.GroupID;
            BRCA.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            BRCA.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(BRCA.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + BRCA.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                BRCA.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadResultsBCR ", ex);
        }
        return BRCA;
    }
    public Control LoadResultsBCRA1(PatientInvestigation lstInve1)
    {
        long InvestigationID = lstInve1.InvestigationID;
        Investigation_BRCAPattern1 BRCA1;
        BRCA1 = (Investigation_BRCAPattern1)LoadControl(lstInve1.PatternName);
        int groupID = lstInve1.GroupID;

        try
        {
            BRCA1.ID = (Convert.ToString(lstInve1.InvestigationID) + "~" + lstInve1.GroupName + "~" + lstInve1.GroupID + "~" + lstInve1.RootGroupID + "~" + lstInve1.PackageID + "~" + Convert.ToString(lstInve1.AccessionNumber));
            BRCA1.ControlID = Convert.ToString(lstInve1.InvestigationID);
            BRCA1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            BRCA1.Name = lstInve1.InvestigationName;
            BRCA1.GroupID = lstInve1.GroupID;
            BRCA1.GroupName = lstInve1.GroupName.Replace(":", "");
            BRCA1.AccessionNumber = lstInve1.AccessionNumber;
            lstControl.Add(BRCA1.ID);
            lstpatternID.Add(lstInve1.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve1.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve1.GroupID + "^" + lstInve1.DeptName + "|" + lstInve1.GroupName.Replace(":", "") + "|" + BRCA1.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                BRCA1.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadResultsBRCA1 ", ex);
        }
        return BRCA1;
    }
    public Control LoadResultsMicroBio1(PatientInvestigation lstInve1)
    {
        long InvestigationID = lstInve1.InvestigationID;
        Investigation_MicroBio1 MicroBio1;
        MicroBio1 = (Investigation_MicroBio1)LoadControl(lstInve1.PatternName);
        int groupID = lstInve1.GroupID;

        try
        {
            var lstInve1_GroupName = lstInve1.GroupName == null ? "" : lstInve1.GroupName;
            MicroBio1.ID = (Convert.ToString(lstInve1.InvestigationID) + "~" + lstInve1_GroupName.Replace(":", "") + "~" + lstInve1.GroupID + "~" + lstInve1.RootGroupID + "~" + lstInve1.PackageID + "~" + Convert.ToString(lstInve1.AccessionNumber));
            MicroBio1.ControlID = Convert.ToString(lstInve1.InvestigationID);
            MicroBio1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            MicroBio1.Name = lstInve1.InvestigationName;
            MicroBio1.GroupID = lstInve1.GroupID;
            MicroBio1.GroupName = lstInve1_GroupName.Replace(":", "");
            MicroBio1.MedicalRemarks = lstInve1.MedicalRemarks;
            MicroBio1.AccessionNumber = lstInve1.AccessionNumber;
            lstControl.Add(MicroBio1.ID);
            lstpatternID.Add(lstInve1.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve1.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve1.GroupID + "^" + lstInve1.DeptName + "|" + lstInve1_GroupName.Replace(":", "") + "|" + MicroBio1.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                MicroBio1.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadResultsMicroBio1 ", ex);
        }
        return MicroBio1;
    }
    public Control LoadMolBio(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_HBVDRUG HBVDRUG;
        HBVDRUG = (Investigation_HBVDRUG)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            HBVDRUG.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            HBVDRUG.ControlID = Convert.ToString(lstInve.InvestigationID);
            HBVDRUG.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            HBVDRUG.Name = lstInve.InvestigationName;
            HBVDRUG.GroupID = lstInve.GroupID;
            HBVDRUG.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            HBVDRUG.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(HBVDRUG.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + HBVDRUG.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                HBVDRUG.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HBVDRUG ", ex);
        }
        return HBVDRUG;
    }
    public Control LoadImagePattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_ImageUploadpattern Img;
        Img = (Investigation_ImageUploadpattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Img.ShowImagePattern();
            Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            Img.ControlID = Convert.ToString(lstInve.InvestigationID);
            Img.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Img.Name = lstInve.InvestigationName;
            Img.GroupID = lstInve.GroupID;
            Img.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Img.VisitID = lstInve.PatientVisitID;
            Img.PatientID = lstInve.PatientID;
            Img.AccessionNumber = lstInve.AccessionNumber;
            Img.UID = lstInve.UID;
            Img.Age = lstInve.Age;
            Img.Sex = lstInve.Sex;
            Img.PatientName = lstInve.Name;
            Img.VisitNumber = lstInve.VisitNumber;
            Img.LabNo = lstInve.LabNo;
            Img.POrgid = OrgID;
            Img.PatientVisitID = lstInve.PatientVisitID;
            Img.PatternID = lstInve.PatternID;
            Img.TestStatus = lstInve.TestStatus;
            Img.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(Img.ID);
            lstpatternID.Add(lstInve.PatternID);
			Img.MedicalRemarks = lstInve.MedicalRemarks;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Img.ID + "_ddlstatus";
            //}
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Img.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadImagePattern ", ex);
        }
        return Img;
    }
    public Control LoadPDFPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_PDFUploadpattern Img;
        Img = (Investigation_PDFUploadpattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Img.ShowImagePattern();
            Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Img.ControlID = Convert.ToString(lstInve.InvestigationID);
            Img.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Img.Name = lstInve.InvestigationName;
            Img.GroupID = lstInve.GroupID;
            Img.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Img.VisitID = lstInve.PatientVisitID;
            Img.PatientID = lstInve.PatientID;
            Img.AccessionNumber = lstInve.AccessionNumber;
            Img.UID = lstInve.UID;
            Img.Age = lstInve.Age;
            Img.Sex = lstInve.Sex;
            Img.PatientName = lstInve.Name;
            Img.VisitNumber = lstInve.VisitNumber;
            Img.LabNo = lstInve.LabNo;
            Img.POrgid = OrgID;
            Img.PatientVisitID = lstInve.PatientVisitID;
            Img.PatternID = lstInve.PatternID;
            Img.TestStatus = lstInve.TestStatus;
            lstControl.Add(Img.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Img.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Img.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPDFUploadpattern ", ex);
        }
        return Img;
    }
    public Control LoadBioPattern2(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern2 Bio1;
        Bio1 = (Investigation_BioPattern2)LoadControl(lstInve.PatternName);

        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int GroupID = lstInve.GroupID;

        try
        {
            Bio1.OrgID = OrgID;
            Bio1.RoleID = RoleID;
            Bio1.LID = LID;
            Bio1.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //Get Data to populate Status-Reason list
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Bio1.LoadInvStatusReason(lstInvReasonMaster);

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            Bio1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Label lblSex = (Label)patientHeader.FindControl("lblSEX");
            //if (lblSex.Text == "Male")
            //   Bio1.Show("M");
            //else
            //    Bio1.Show("F");
            Bio1.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Bio1.Name = lstInve.InvestigationName;
            Bio1.UOM = lstInve.UOMCode;
            //Bio1.ID = Convert.ToString(lstInve.InvestigationID);
            Bio1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + ((lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") == null ? (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") : (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "").Trim()) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio1.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio1.GroupID = lstInve.GroupID;
            Bio1.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Bio1.PackageID = lstInve.PackageID;
            Bio1.PackageName = lstInve.PackageName;
            Bio1.CurrentRoleName = RoleName;
            Bio1.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio1.DecimalPlaces = lstInve.DecimalPlaces;
            Bio1.ResultValueType = lstInve.ResultValueType;
            Bio1.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            Bio1.TestStatus = lstInve.TestStatus;
            Bio1.AccessionNumber = lstInve.AccessionNumber;
            //Bio1.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                Bio1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                Bio1.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            Bio1.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Bio1.setAttributes(Convert.ToString(Bio1.ID));
            var lstpendvalue = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            //Bio1.AccessionNumber = lstpendvalue[0].AccessionNumber;
            Bio1.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(Bio1.ID);
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                Bio1.setXmlValues(lstim[0].ReferenceRange);
            }
            lstpatternID.Add(lstInve.PatternID);
            //Bio1.Readonly = false;
            Bio1.MakeReadOnly(Bio1.ID);

            Bio1.PatientVisitID = vid;
            Bio1.PatternID = (lstInve.PatternID);

            Bio1.CurrentRoleName = RoleName.Trim();
            Bio1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio1.IsAbnormal = lstInve.IsAbnormal;
            Bio1.IsAutoAuthorize = lstInve.IsAutoAuthorize;

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                List<InvestigationValues> lstValues = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
                if (lstValues != null && lstValues.Count > 0)
                {
                    Bio1.setValues(lstValues);

                    if (!String.IsNullOrEmpty(lstValues[0].Value))
                    {
                        String ddlValue = lstValues[0].Value.Split(',')[0];
                        if (!String.IsNullOrEmpty(ddlValue))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), Bio1.DDLClientID, "setDropdownValues('" + Bio1.DDLClientID + "','" + Bio1.hdnDDLClientID + "','" + ddlValue + "');", true);
                        }
                    }
                }
            }
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Bio1.ID + "_ddlstatus";
            //}
            Bio1.BatchWise(false);
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    Bio1.IsAbnormal = lstInve.IsAbnormal;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio1.TxtControlID, "LoadAbnormalValue('" + Bio1.TxtControlID + "','" + Bio1.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio1.TestName + "','" + Bio1.TestUnit + "','" + Bio1.IsAutoAuthorize + "');", true);
                }
                if (lstInve.IsSensitive != null)
                {
                    Bio1.IsSensitive = lstInve.IsSensitive;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadSensitiveValue" + Bio1.TxtControlID, "LoadSensitiveValue('" + Bio1.TxtControlID + "','','" + lstInve.IsSensitive + "','" + Bio1.TestName + "','" + Bio1.TestUnit + "');", true);
                }
            }
            catch (Exception e)
            {
            }
            DropDownList ddlstatus = (DropDownList)Bio1.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Approved)
            {
                //DisableUserControl(bioPattern1, false);
                //HtmlTable tblBioContent = (HtmlTable)Bio1.FindControl("tblBioContent");
                //Bio1.IsStatusCompleted = "Y";
                //tblBioContent.Attributes.Add("style", "display:none");

                //tblBioContent.Style = true;
                //DropDownList ddlstatus = (DropDownList)Bio1.FindControl("ddlstatus");
                ddlstatus.Visible = false;
                Label lblName = (Label)Bio1.FindControl("lblName");
                lblName.Enabled = true;
                lblName.Attributes.Add("onclick", "");
                DropDownList txtValue1 = (DropDownList)Bio1.FindControl("ddlData");
                txtValue1.Enabled = false;
                TextBox txtResult1 = (TextBox)Bio1.FindControl("txtResult");
                txtResult1.Enabled = false;
                HtmlGenericControl spanIsAbnormal = (HtmlGenericControl)Bio1.FindControl("spanIsAbnormal");
                spanIsAbnormal.Disabled = true;
                TextBox txtReason = (TextBox)Bio1.FindControl("txtReason");
                txtReason.Enabled = false;
                TextBox txtMedRemarks = (TextBox)Bio1.FindControl("txtMedRemarks");
                txtMedRemarks.Enabled = false;
                //TextBox txtDelta = (TextBox)Bio1.FindControl("txtDelta");
                //txtDelta.Enabled = false;
                HtmlAnchor ABetaTag = (HtmlAnchor)Bio1.FindControl("ABetaTag");
                ABetaTag.Visible = false;
                HtmlAnchor EditButton = (HtmlAnchor)Bio1.FindControl("ATag");
                EditButton.Visible = false;
                //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load bio pattern 2", ex);
        }
        return Bio1;
    }
    public Control LoadGTTContentPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_GTTContentPattern GTTContent;
        GTTContent = (Investigation_GTTContentPattern)LoadControl(lstInve.PatternName);

        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int GroupID = lstInve.GroupID;

        try
        {
            GTTContent.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //Get Data to populate Status-Reason list
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //GTTContent.LoadInvStatusReason(lstInvReasonMaster);

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            GTTContent.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Label lblSex = (Label)patientHeader.FindControl("lblSEX");
            //if (lblSex.Text == "Male")
            //   Bio1.Show("M");
            //else
            //    Bio1.Show("F");
            GTTContent.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            List<InvestigationValues> tmpDemoBulk = new List<InvestigationValues>();
            var Dbulk = DemoBulk.FindAll(p => p.InvestigationID == InvestigationID);
            tmpDemoBulk = Dbulk.FindAll(p => p.Name == "Type");
            if (tmpDemoBulk.Count > 0)
            {
                GTTContent.PatternType(tmpDemoBulk[0].Value);
            }
            List<InvestigationValues> TimeBulk = new List<InvestigationValues>();
            TimeBulk = Dbulk.FindAll(p => p.Name == "Time");
            if (TimeBulk.Count > 0)
            {
                GTTContent.Time = TimeBulk[0].Value;
            }
            List<InvestigationValues> InvTypeBulk = new List<InvestigationValues>();
            InvTypeBulk = Dbulk.FindAll(p => p.Name == "InvType");
            if (InvTypeBulk.Count > 0)
            {
                GTTContent.Invtype = InvTypeBulk[0].Value;
            }
            GTTContent.Name = lstInve.InvestigationName;
            GTTContent.UOM = lstInve.UOMCode;
            //Bio1.ID = Convert.ToString(lstInve.InvestigationID);
            GTTContent.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            GTTContent.ControlID = Convert.ToString(lstInve.InvestigationID);
            GTTContent.GroupID = lstInve.GroupID;
            GTTContent.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            GTTContent.PackageID = lstInve.PackageID;
            GTTContent.PackageName = lstInve.PackageName;
            GTTContent.CurrentRoleName = RoleName;
            GTTContent.LabTechEditMedRem = strLabTechToEditMedRem;
            GTTContent.DecimalPlaces = lstInve.DecimalPlaces;
            GTTContent.ResultValueType = lstInve.ResultValueType;
            GTTContent.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //Bio1.RefRange = lstInve.ReferenceRange;
            GTTContent.SequenceNo = lstInve.SequenceNo;
            GTTContent.IsAbnormal = lstInve.IsAbnormal;
            GTTContent.UID = lstInve.UID;
            GTTContent.LabNo = lstInve.LabNo;
            GTTContent.AccessionNumber = lstInve.AccessionNumber;
            if (lstInve.ReferenceRange != null)
            {
                GTTContent.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                GTTContent.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            GTTContent.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            GTTContent.setAttributes(Convert.ToString(GTTContent.ID));
            GTTContent.AccessionNumber = lstPendingValue[0].AccessionNumber;
            lstControl.Add(GTTContent.ID);

            lstpatternID.Add(lstInve.PatternID);
            //Bio1.Readonly = false;
            GTTContent.MakeReadOnly(GTTContent.ID);

            GTTContent.PatientVisitID = vid;
            GTTContent.PatternID = (lstInve.PatternID);

            GTTContent.CurrentRoleName = RoleName.Trim();
            //GTTContent.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                GTTContent.setValues(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + GTTContent.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load bio pattern 2", ex);
        }
        return GTTContent;
    }
    public Control LoadBioPattern3(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern3 Bio;
        Bio = (Investigation_BioPattern3)LoadControl(lstInve.PatternName);

        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int GroupID = lstInve.GroupID;

        try
        {
            Bio.OrgID = OrgID;
            Bio.RoleID = RoleID;
            Bio.LID = LID;
            Bio.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //Get Data to populate Status-Reason list
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Bio.LoadInvStatusReason(lstInvReasonMaster);

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Bio.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.Name = lstInve.InvestigationName;
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + ((lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") == null ? "" : (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "").Trim()) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio.GroupID = lstInve.GroupID;
            Bio.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Bio.PackageID = lstInve.PackageID;
            Bio.PackageName = lstInve.PackageName;
            Bio.CurrentRoleName = RoleName;
            Bio.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            Bio.TestStatus = lstInve.TestStatus;
            //Bio.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                Bio.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                Bio.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            Bio.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Bio.UOM = lstInve.UOMCode;
            lstControl.Add(Bio.ID);
            //Bio.Readonly = false;
            Bio.MakeReadOnly(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);

            Bio.PatientVisitID = vid;
            Bio.PatternID = (lstInve.PatternID);

            Bio.CurrentRoleName = RoleName.Trim();
            Bio.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio.IsAbnormal = lstInve.IsAbnormal;
            Bio.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio.AccessionNumber = lstInve.AccessionNumber;
            Bio.BatchWise(false);
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                Bio.setXmlValues(lstim[0].ReferenceRange);
            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                List<InvestigationValues> lstValues = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == GroupID);
                if (lstValues != null && lstValues.Count > 0)
                {
                    Bio.LoadDataForEdit(lstValues);

                    if (!String.IsNullOrEmpty(lstValues[0].Value))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), Bio.DDLClientID, "setDropdownValues('" + Bio.DDLClientID + "','" + Bio.hdnDDLClientID + "','" + lstValues[0].Value + "');", true);
                    }
                }
            }
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + ((lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") == null ? "" : (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "").Trim()) + "|" + Bio.ID + "_ddlstatus";
            //}
            if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
            {
                Bio.IsAbnormal = lstInve.IsAbnormal;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio.DDLClientID, "LoadAbnormalValue('','" + Bio.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio.TestName + "','" + Bio.TestUnit + "','" + Bio.IsAutoAuthorize + "');", true);
            }
            if (lstInve.IsSensitive != null)
            {
                Bio.IsSensitive = lstInve.IsSensitive;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadSensitiveValue" + Bio.DDLClientID, "LoadSensitiveValue('" + Bio.DDLClientID + "','','" + lstInve.IsSensitive + "','" + Bio.TestName + "','" + Bio.TestUnit + "');", true);

            }
            DropDownList ddlstatus = (DropDownList)Bio.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Validate)
            {
                DropDownList txtValue1 = (DropDownList)Bio.FindControl("ddlData");
                txtValue1.Enabled = false;
            }
            if (lstInve.Status == InvStatus.Approved)
            {
                //DisableUserControl(bioPattern1, false);
                //HtmlTable tblBioContent = (HtmlTable)Bio1.FindControl("tblBioContent");
                //Bio.IsStatusCompleted = "Y";
                //tblBioContent.Attributes.Add("style", "display:none");

                //tblBioContent.Style = true;
                //DropDownList ddlstatus = (DropDownList)Bio.FindControl("ddlstatus");
                ddlstatus.Visible = false;
                Label lblName = (Label)Bio.FindControl("lblName");
                lblName.Enabled = true;
                lblName.Attributes.Add("onclick", "");
                DropDownList txtValue1 = (DropDownList)Bio.FindControl("ddlData");
                txtValue1.Enabled = false;
                HtmlGenericControl spanIsAbnormal = (HtmlGenericControl)Bio.FindControl("spanIsAbnormal");
                spanIsAbnormal.Disabled = true;
                TextBox txtReason = (TextBox)Bio.FindControl("txtReason");
                txtReason.Enabled = false;
                TextBox txtMedRemarks = (TextBox)Bio.FindControl("txtMedRemarks");
                txtMedRemarks.Enabled = false;
                //TextBox txtDelta = (TextBox)Bio.FindControl("txtDelta");
                //txtDelta.Enabled = false;
                HtmlAnchor ABetaTag = (HtmlAnchor)Bio.FindControl("ABetaTag");
                ABetaTag.Visible = false;
                HtmlAnchor EditButton = (HtmlAnchor)Bio.FindControl("ATag");
                EditButton.Visible = false;
                //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
                if (ddlstatus.Items.FindByValue("Approve_1") != null)
                {
                    ddlstatus.SelectedValue = "Approve_1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBioPattern3", ex);
        }
        return Bio;
    }
    public Control LoadBioPattern4(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern4 Bio;
        Bio = (Investigation_BioPattern4)LoadControl(lstInve.PatternName);
        int GroupID = lstInve.GroupID;

        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Bio.LoadInvStatusReason(lstInvReasonMaster);

            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

            ////Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            Bio.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.Name = lstInve.InvestigationName;
            Bio.UOM = lstInve.UOMCode;
            //Bio.ID = Convert.ToString(lstInve.InvestigationID);
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio.GroupID = lstInve.GroupID;
            Bio.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Bio.PackageID = lstInve.PackageID;
            Bio.PackageName = lstInve.PackageName;
            Bio.CurrentRoleName = RoleName;
            Bio.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio.DecimalPlaces = lstInve.DecimalPlaces;
            Bio.ResultValueType = lstInve.ResultValueType;
            Bio.IsAbnormal = lstInve.IsAbnormal;
            Bio.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            Bio.AccessionNumber = lstInve.AccessionNumber;
            //Bio.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            //Bio.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                Bio.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                Bio.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            Bio.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //Bio.setAttributes(Convert.ToString(Bio.ID));
            var lstpendval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            Bio.Dilution = lstpendval[0].Dilution;
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);
            // Bio.Readonly = false;
            Bio.MakeReadOnly(Bio.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Bio.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBioPattern4", ex);
        }
        return Bio;
    }
    public Control LoadBioPattern5(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern5 Bio;
        Bio = (Investigation_BioPattern5)LoadControl(lstInve.PatternName);
        int GroupID = lstInve.GroupID;
        //GroupID,
        try
        {
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            Bio.ShowGTT();
            //Bio.ID = Convert.ToString(lstInve.InvestigationID);
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            //Bio.GroupID = lstInve.GroupID;
            //Bio.GroupName = lstInve.GroupName;
            //Bio.RefRange = lstInve.ReferenceRange;
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);
            //Bio.Readonly = false;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBioPattern5 ", ex);
        }
        return Bio;
    }
    //public Control loadHematPattern6(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern6 Hemat;
    //    Hemat = (Investigation_HematPattern6)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        //    returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //    List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //Hemat.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        int GroupID = lstInve.GroupID;


    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));//Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.UOM = Convert.ToString(lstInve.UOMID);
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        Hemat.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        Hemat.PatientVisitID = vid;
    //        Hemat.PatternID = (lstInve.PatternID);
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        Hemat.CurrentRoleName = RoleName.Trim();

    //        //Hemat.Text = lstInve.Value;
    //        //Hemat.Readonly = false;
    //        Hemat.MakeReadOnly(Hemat.ID);
    //        Hemat.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
    //        lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
    //        if (lstPendingval.Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingval);
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 7", ex);
    //    }

    //    return Hemat;
    //}

    //public Control loadHematPattern7(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern7 Hemat;
    //    Hemat = (Investigation_HematPattern7)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //Hemat.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;
    //        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //Load the status
    //        int GroupID = lstInve.GroupID;


    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        ////Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, GroupID, Convert.ToInt32(hdnOrgID.Value), out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        //Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        Hemat.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //Hemat.Readonly = false;
    //        Hemat.MakeReadOnly(Hemat.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 7", ex);
    //    }

    //    return Hemat;
    //}

    //public Control loadHematPattern8(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern8 Hemat;
    //    Hemat = (Investigation_HematPattern8)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //Hemat.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

    //        int GroupID = lstInve.GroupID;



    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        //Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //Assign the Investigation id to HiddenValue of user control
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        Hemat.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //Hemat.Readonly = false;
    //        Hemat.MakeReadOnly(Hemat.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
    //        lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
    //        if (lstPendingval.Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingval);
    //        }


    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 8", ex);
    //    }

    //    return Hemat;
    //}

    //public Control loadHematPattern9(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern9 Hemat;
    //    Hemat = (Investigation_HematPattern9)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        long InvestigationID = lstInve.InvestigationID;

    //        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        //Assign the PatientInvestigation id to HiddenValue of user control
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.RefRange = lstInve.ReferenceRange;      
    //        //Add Id and PatternId to list
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        //Hemat.Readonly = false;


    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 9", ex);
    //    }

    //    return Hemat;
    //}

    //public Control loadHematPattern10(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern10 Hemat;
    //    Hemat = (Investigation_HematPattern10)LoadControl(lstInve.PatternName);
    //    //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
    //    //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //    //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

    //    try
    //    {
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //Hemat.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;
    //        int GroupID = lstInve.GroupID;



    //        //Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.loadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        //List<Config> lstConfig = new List<Config>();
    //        //new GateWay(base.ContextInfo).GetConfigDetails("ISI", OrgID, out lstConfig);
    //        //if (lstConfig.Count > 0)
    //        //    Hemat.ISI = lstConfig[0].ConfigValue.Trim();

    //        //Assign the PatientInvestigation id to HiddenValue of user control
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        Hemat.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        //Add Id and PatternId to list
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        Hemat.PatientVisitID = vid;
    //        Hemat.PatternID = (lstInve.PatternID);
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        Hemat.CurrentRoleName = RoleName.Trim();

    //        Hemat.MakeReadOnly(Hemat.ID);
    //        Hemat.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
    //        //Hemat.Readonly = false;
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
    //        lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
    //        if (lstPendingval.Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingval);
    //        }

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 10", ex);
    //    }

    //    return Hemat;
    //}

    //public Control loadHematPattern11(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern11 Hemat;

    //    Hemat = (Investigation_HematPattern11)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //Hemat.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        int GroupID = lstInve.GroupID;



    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        //            Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //Assign the PatientInvestigation id to HiddenValue of user control
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        Hemat.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        //Add Id and PatternId to list
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //Hemat.Readonly = false;
    //        Hemat.MakeReadOnly(Hemat.ID);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 10", ex);
    //    }

    //    return Hemat;
    //}
    public Control loadClinicalPattern12(PatientInvestigation lstInve)
    {
        Investigation_ClinicalPattern12 clincalPattern;
        clincalPattern = (Investigation_ClinicalPattern12)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //clincalPattern.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            clincalPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            clincalPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            clincalPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            clincalPattern.Name = Convert.ToString(lstInve.InvestigationName);
            clincalPattern.GroupID = lstInve.GroupID;
            clincalPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            clincalPattern.PackageID = lstInve.PackageID;
            clincalPattern.PackageName = lstInve.PackageName;
            clincalPattern.CurrentRoleName = RoleName;
            clincalPattern.LabTechEditMedRem = strLabTechToEditMedRem;
            clincalPattern.DecimalPlaces = lstInve.DecimalPlaces;
            clincalPattern.ResultValueType = lstInve.ResultValueType;
            clincalPattern.IsAbnormal = lstInve.IsAbnormal;
            clincalPattern.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            clincalPattern.AccessionNumber = lstInve.AccessionNumber;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //clincalPattern.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                clincalPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                clincalPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            clincalPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            clincalPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            clincalPattern.UOM = lstInve.UOMCode;
            //clincalPattern.setAttributes(Convert.ToString(clincalPattern.ID) );
            lstControl.Add(clincalPattern.ID);
            lstpatternID.Add(lstInve.PatternID);

            clincalPattern.PatientVisitID = vid;
            clincalPattern.PatternID = (lstInve.PatternID);
            clincalPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            clincalPattern.CurrentRoleName = RoleName.Trim();

            clincalPattern.MakeReadOnly(clincalPattern.ID);
            //clincalPattern.Readonly = false;
            clincalPattern.MakeReadOnly(clincalPattern.ID);
            clincalPattern.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + clincalPattern.ID + "_ddlstatus";
            //}
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                clincalPattern.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Pattern 10", ex);

        }
        return clincalPattern;
    }
    public Control loadClincalPattern13(PatientInvestigation lstInve)
    {
        Investigation_ClinicalPattern13 clincalPattern;
        clincalPattern = (Investigation_ClinicalPattern13)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //clincalPattern.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int GroupID = lstInve.GroupID;

            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            clincalPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            clincalPattern.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            //clincalPattern.ID = Convert.ToString(lstInve.InvestigationID);
            clincalPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            clincalPattern.Name = Convert.ToString(lstInve.InvestigationName);
            clincalPattern.GroupID = lstInve.GroupID;
            clincalPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            clincalPattern.PackageID = lstInve.PackageID;
            clincalPattern.PackageName = lstInve.PackageName;
            clincalPattern.CurrentRoleName = RoleName;
            clincalPattern.LabTechEditMedRem = strLabTechToEditMedRem;
            //clincalPattern.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                clincalPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                clincalPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            clincalPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            clincalPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //clincalPattern.setAttributes(Convert.ToString(clincalPattern.ID) );
            clincalPattern.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(clincalPattern.ID);
            lstpatternID.Add(lstInve.PatternID);

            //clincalPattern.Readonly = false;
            clincalPattern.MakeReadOnly(clincalPattern.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + clincalPattern.ID + "_ddlstatus";
            //}

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Pattern 10", ex);

        }
        return clincalPattern;
    }
    //public Control loadDifferentialPattern12(PatientInvestigation lstInve)
    //{
    //    Investigation_DifferentialPattern clincalDiffPattern;
    //    clincalDiffPattern = (Investigation_DifferentialPattern)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        clincalDiffPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //clincalDiffPattern.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;
    //        int GroupID = lstInve.GroupID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        clincalDiffPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        clincalDiffPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        //clincalDiffPattern.ID = Convert.ToString(lstInve.InvestigationID);

    //        clincalDiffPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        clincalDiffPattern.Name = Convert.ToString(lstInve.InvestigationName);
    //        clincalDiffPattern.GroupID = lstInve.GroupID;
    //        clincalDiffPattern.GroupName = lstInve.GroupName;
    //        clincalDiffPattern.PackageID = lstInve.PackageID;
    //        clincalDiffPattern.PackageName = lstInve.PackageName;
    //        clincalDiffPattern.CurrentRoleName = RoleName;
    //        clincalDiffPattern.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //clincalDiffPattern.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            clincalDiffPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            clincalDiffPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        clincalDiffPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        clincalDiffPattern.UOM = lstInve.UOMCode;
    //        clincalDiffPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //clincalDiffPattern.setAttributes(Convert.ToString(clincalDiffPattern.ID) );
    //        lstControl.Add(clincalDiffPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //clincalDiffPattern.Readonly = false;
    //        clincalDiffPattern.MakeReadOnly(clincalDiffPattern.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + clincalDiffPattern.ID + "_ddlstatus";
    //        //}
    //        lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
    //        if (lstPendingval.Count > 0)
    //        {
    //            clincalDiffPattern.LoadDataForEdit(lstPendingval);
    //        }

    //    }

    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 10", ex);

    //    }
    //    return clincalDiffPattern;
    //}

    //public Control loadCastPattern(PatientInvestigation lstInve)
    //{
    //    Investigation_CastPattern clincalCastPattern;
    //    clincalCastPattern = (Investigation_CastPattern)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //clincalCastPattern.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

    //        //Load the status
    //        int GroupID = lstInve.GroupID;


    //        //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        clincalCastPattern.LoadItems(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        clincalCastPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        clincalCastPattern.Name = Convert.ToString(lstInve.InvestigationName);
    //        //clincalCastPattern.ID = Convert.ToString(lstInve.InvestigationID);
    //        clincalCastPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        clincalCastPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        clincalCastPattern.GroupID = lstInve.GroupID;
    //        clincalCastPattern.GroupName = lstInve.GroupName;
    //        clincalCastPattern.PackageID = lstInve.PackageID;
    //        clincalCastPattern.PackageName = lstInve.PackageName;
    //        clincalCastPattern.CurrentRoleName = RoleName;
    //        clincalCastPattern.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //clincalCastPattern.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            clincalCastPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            clincalCastPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        clincalCastPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //clincalCastPattern.setAttributes(Convert.ToString(clincalCastPattern.ID) );
    //        lstControl.Add(clincalCastPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        //clincalCastPattern.Readonly = false;
    //        clincalCastPattern.MakeReadOnly(clincalCastPattern.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + clincalCastPattern.ID + "_ddlstatus";
    //        //}

    //    }

    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error While Loading Pattern 10", ex);

    //    }
    //    return clincalCastPattern;

    //}

    //public Control LoadANAControl(PatientInvestigation lstInve)
    //{

    //    Investigation_ANAPattern ANAPattern;
    //    ANAPattern = (Investigation_ANAPattern)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //ANAPattern.LoadInvStatusReason(lstInvReasonMaster);

    //        long InvestigationID = lstInve.InvestigationID;
    //        int GroupID = lstInve.GroupID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

    //        ANAPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        ANAPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        ANAPattern.Name = Convert.ToString(lstInve.InvestigationName);
    //        //ANAPattern.ID = Convert.ToString(lstInve.InvestigationID);
    //        ANAPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

    //        ANAPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        ANAPattern.GroupID = lstInve.GroupID;
    //        ANAPattern.GroupName = lstInve.GroupName;
    //        ANAPattern.PackageID = lstInve.PackageID;
    //        ANAPattern.PackageName = lstInve.PackageName;
    //        ANAPattern.CurrentRoleName = RoleName;
    //        ANAPattern.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //ANAPattern.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            ANAPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            ANAPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        //ANAPattern.setAttributes(Convert.ToString(ANAPattern.ID) );
    //        lstControl.Add(ANAPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //ANAPattern.Readonly = false;
    //        ANAPattern.MakeReadOnly(ANAPattern.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + ANAPattern.ID + "_ddlstatus";
    //        //}

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while load ANAPattern", ex);
    //    }
    //    return ANAPattern;
    //}

    //public Control LoadwidelControl(PatientInvestigation lstInve)
    //{
    //    Investigation_WidelPattern widelPattern;
    //    widelPattern = (Investigation_WidelPattern)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        widelPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
    //        //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
    //        //widelPattern.LoadInvStatusReason(lstInvReasonMaster);

    //        long investigationID = lstInve.InvestigationID;
    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //Load the status
    //        int GroupID = lstInve.GroupID;

    //        //invesBL.GetInvBulkDataForApprovel(gUID, investigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        widelPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == investigationID));

    //        widelPattern.Name = Convert.ToString(lstInve.InvestigationName);
    //        //widelPattern.ID = Convert.ToString(lstInves.InvestigationID);
    //        widelPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        widelPattern.loadStatus(header.FindAll(p => p.InvestigationID == investigationID));
    //        widelPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        widelPattern.GroupID = lstInve.GroupID;
    //        widelPattern.GroupName = lstInve.GroupName;
    //        widelPattern.PackageID = lstInve.PackageID;
    //        widelPattern.PackageName = lstInve.PackageName;
    //        widelPattern.CurrentRoleName = RoleName;
    //        widelPattern.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //widelPattern.RefRange = lstInve.ReferenceRange;
    //        if (lstInve.ReferenceRange != null)
    //        {
    //            widelPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //        }
    //        if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //        {
    //            widelPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //        }
    //        widelPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
    //        //widelPattern.setAttributes(Convert.ToString(widelPattern.ID) );
    //        lstControl.Add(widelPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        //widelPattern.Readonly = false;
    //        widelPattern.MakeReadOnly(widelPattern.ID);
    //        //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + widelPattern.ID + "_ddlstatus";
    //        //}
    //        lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == investigationID);
    //        if (lstPendingval.Count > 0)
    //        {
    //            widelPattern.LoadDataForEdit(lstPendingval);
    //        }


    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while load WidelPattern", ex);

    //    }
    //    return widelPattern;
    //}
    public Control LoadFluidPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FluidPattern fluidpattern;
        fluidpattern = (Investigation_FluidPattern)LoadControl(lstInve.PatternName);

        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //fluidpattern.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int GroupID = lstInve.GroupID;

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            fluidpattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            fluidpattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            fluidpattern.Name = lstInve.InvestigationName;
            fluidpattern.UOM = lstInve.UOMCode;
            //Bio.ID = Convert.ToString(lstInve.InvestigationID);
            fluidpattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //fluidpattern.Readonly = false;
            fluidpattern.MakeReadOnly(fluidpattern.ID);
            fluidpattern.ControlID = Convert.ToString(fluidpattern.ID);
            fluidpattern.GroupID = lstInve.GroupID;
            fluidpattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            fluidpattern.PackageID = lstInve.PackageID;
            fluidpattern.PackageName = lstInve.PackageName;
            fluidpattern.CurrentRoleName = RoleName;
            fluidpattern.LabTechEditMedRem = strLabTechToEditMedRem;
            fluidpattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            fluidpattern.DecimalPlaces = lstInve.DecimalPlaces;
            fluidpattern.ResultValueType = lstInve.ResultValueType;
            fluidpattern.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(fluidpattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + fluidpattern.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBioPattern4", ex);
        }
        return fluidpattern;
    }
    public Control LoadCommanPattern(PatientInvestigation lstInve)
    {

        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_CommanPattern CommanPattern;
        Investigation_BL invBl = new Investigation_BL(base.ContextInfo);
        CommanPattern = (Investigation_CommanPattern)LoadControl("~/Investigation/CommanPattern.ascx");
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //CommanPattern.LoadInvStatusReason(lstInvReasonMaster);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            CommanPattern.Name = lstInve.InvestigationName;
            //CommanPattern.UOM = lstInve.UOMCode;
            //CommanPattern.ID = Convert.ToString(lstInve.InvestigationID);
            CommanPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //invBl.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            CommanPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            //CommanPattern.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                CommanPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                CommanPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            CommanPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            CommanPattern.GroupID = lstInve.GroupID;
            CommanPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            CommanPattern.PackageID = lstInve.PackageID;
            CommanPattern.PackageName = lstInve.PackageName;
            CommanPattern.CurrentRoleName = RoleName;
            CommanPattern.LabTechEditMedRem = strLabTechToEditMedRem;
            CommanPattern.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            CommanPattern.DecimalPlaces = lstInve.DecimalPlaces;
            CommanPattern.ResultValueType = lstInve.ResultValueType;
            CommanPattern.AccessionNumber = lstInve.AccessionNumber;
            //CommanPattern.setAttributes(Convert.ToString(CommanPattern.ID) );
            lstControl.Add(CommanPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            //CommanPattern.Readonly = false;
            CommanPattern.MakeReadOnly(CommanPattern.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + CommanPattern.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return CommanPattern;
    }
    public Control LoadHPPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;
        Hdnhistoalert.Value = "Y";
        Investigation_HistoPathologyPattern hpp;
        hpp = (Investigation_HistoPathologyPattern)LoadControl(lstInve.PatternName);

        try
        {
            hpp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            hpp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.Name = lstInve.InvestigationName;
            //hpp.UOM = lstInve.UOMCode;
            //hpp.ID = Convert.ToString(lstInve.InvestigationID);
            hpp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            hpp.ControlID = Convert.ToString(lstInve.InvestigationID);
            hpp.GroupID = lstInve.GroupID;
            hpp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            hpp.PackageID = lstInve.PackageID;
            hpp.PackageName = lstInve.PackageName;
            hpp.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hpp.MedicalRemarks = lstInve.MedicalRemarks;
            hpp.AccessionNumber = lstInve.AccessionNumber;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hpp.ID);
            lstpatternID.Add(lstInve.PatternID);
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out lstPatientInvSampleAliquot);
            hpp.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //hpp.Readonly = false;

            hpp.MakeReadOnly(hpp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + hpp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHPPattern", ex);
        }
        return hpp;
    }
    public Control LoadHistoImageDescriptionPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;
        Hdnhistoalert.Value = "Y";
        Investigation_HistoImageDescriptionPattern hpp;
        hpp = (Investigation_HistoImageDescriptionPattern)LoadControl(lstInve.PatternName);

        try
        {
            hpp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            hpp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.Name = lstInve.InvestigationName;
            //hpp.UOM = lstInve.UOMCode;
            //hpp.ID = Convert.ToString(lstInve.InvestigationID);
           var lstInve_GroupName = lstInve.GroupName == null ? "" : lstInve.GroupName;
            hpp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve_GroupName.Replace(":", "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            hpp.ControlID = Convert.ToString(lstInve.InvestigationID);
            hpp.GroupID = lstInve.GroupID;
            hpp.GroupName = lstInve.GroupName;
            hpp.PackageID = lstInve.PackageID;
            hpp.PackageName = lstInve.PackageName;
            hpp.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hpp.MedicalRemarks = lstInve.MedicalRemarks;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hpp.ID);
            lstpatternID.Add(lstInve.PatternID);
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out lstPatientInvSampleAliquot);
            hpp.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //hpp.Readonly = false;

            hpp.MakeReadOnly(hpp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + hpp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHistoImageDescriptionPattern", ex);
        }
        return hpp;
    }
    public Control LoadHPPatternQuantum(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;
        Hdnhistoalert.Value = "Y";
        Investigation_HistoPathologyPatternQuantum hppQuantum;
        hppQuantum = (Investigation_HistoPathologyPatternQuantum)LoadControl(lstInve.PatternName);

        try
        {
            hppQuantum.POrgid = Convert.ToInt32(hdnOrgID.Value);
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            hppQuantum.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            hppQuantum.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            hppQuantum.Name = lstInve.InvestigationName;
            //hpp.UOM = lstInve.UOMCode;
            //hpp.ID = Convert.ToString(lstInve.InvestigationID);
            hppQuantum.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            hppQuantum.ControlID = Convert.ToString(lstInve.InvestigationID);
            hppQuantum.GroupID = lstInve.GroupID;
            hppQuantum.GroupName = lstInve.GroupName;
            hppQuantum.PackageID = lstInve.PackageID;
            hppQuantum.PackageName = lstInve.PackageName;
            hppQuantum.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hppQuantum.MedicalRemarks = lstInve.MedicalRemarks;
            //hppQuantum.AccessionNumber = lstInve.AccessionNumber;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hppQuantum.ID);
            lstpatternID.Add(lstInve.PatternID);
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out lstPatientInvSampleAliquot);
            hppQuantum.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hppQuantum.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //hpp.Readonly = false;

            //hppQuantum.MakeReadOnly(hppQuantum.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + hppQuantum.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hppQuantum.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHPPatternQuantum", ex);
        }
        return hppQuantum;
    }
    public Control LoadCultureAndSensitivityPattern(PatientInvestigation lstInve)
    {

        Investigation_CultureandSensitivityReport Culture;
        Culture = (Investigation_CultureandSensitivityReport)LoadControl(lstInve.PatternName);
        try
        {
            Culture.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Culture.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Culture.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Culture.Name = lstInve.InvestigationName;
            //Culture.ID = Convert.ToString(lstInve.InvestigationID);
            //Culture.ID = (lstInve.InvestigationName.Replace(" ","") + "_" + Convert.ToString(lstInve.InvestigationID) + "_" + lstInve.GroupName + "_" + lstInve.GroupID);
            Culture.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Culture.ControlID = Convert.ToString(lstInve.InvestigationID);
            Culture.GroupID = lstInve.GroupID;
            Culture.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Culture.PackageID = lstInve.PackageID;
            Culture.PackageName = lstInve.PackageName;
            Culture.CurrentRoleName = RoleName;
            Culture.LabTechEditMedRem = strLabTechToEditMedRem;
            Culture.AccessionNumber = lstInve.AccessionNumber;
            Culture.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            //Culture.Readonly = false;
            Culture.MakeReadOnly(Culture.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Culture.ID + "_ddlstatus";
            //}
            //Load 

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Culture.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return Culture;
    }
    public Control LoadCultureAndSensitivityV1Pattern(PatientInvestigation lstInve)
    {

        Investigation_CultureandSensitivityReportV1 Culture;
        Culture = (Investigation_CultureandSensitivityReportV1)LoadControl(lstInve.PatternName);
        try
        {
            Culture.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Culture.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Culture.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Culture.LoadOrganism(Convert.ToInt32(hdnOrgID.Value), lstInve.InvestigationID, "OrganismName", "XMLDrugList");
            Culture.Name = lstInve.InvestigationName;
            //Culture.ID = Convert.ToString(lstInve.InvestigationID);
            //Culture.ID = (lstInve.InvestigationName.Replace(" ","") + "_" + Convert.ToString(lstInve.InvestigationID) + "_" + lstInve.GroupName + "_" + lstInve.GroupID);
            Culture.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Culture.ControlID = Convert.ToString(lstInve.InvestigationID);
            Culture.GroupID = lstInve.GroupID;
            Culture.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Culture.PackageID = lstInve.PackageID;
            Culture.PackageName = lstInve.PackageName;
            Culture.CurrentRoleName = RoleName;
            Culture.LabTechEditMedRem = strLabTechToEditMedRem;
            Culture.AccessionNumber = lstInve.AccessionNumber;
            Culture.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            //Culture.Readonly = false;
            Culture.MakeReadOnly(Culture.ID);
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Culture.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return Culture;
    }
    public Control LoadCultureAndSensitivityV2Pattern(PatientInvestigation lstInve)
    {

        Investigation_CultureandSensitivityReportV2 Culture;
        Culture = (Investigation_CultureandSensitivityReportV2)LoadControl(lstInve.PatternName);
        try
        {
            Culture.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Culture.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Culture.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Culture.LoadOrganism(Convert.ToInt32(hdnOrgID.Value), lstInve.InvestigationID, "OrganismName", "XMLDrugList");
            Culture.Name = lstInve.InvestigationName;
            //Culture.ID = Convert.ToString(lstInve.InvestigationID);
            //Culture.ID = (lstInve.InvestigationName.Replace(" ","") + "_" + Convert.ToString(lstInve.InvestigationID) + "_" + lstInve.GroupName + "_" + lstInve.GroupID);
            Culture.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Culture.ControlID = Convert.ToString(lstInve.InvestigationID);
            Culture.GroupID = lstInve.GroupID;
            Culture.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Culture.PackageID = lstInve.PackageID;
            Culture.PackageName = lstInve.PackageName;
            Culture.CurrentRoleName = RoleName;
            Culture.LabTechEditMedRem = strLabTechToEditMedRem;
            Culture.AccessionNumber = lstInve.AccessionNumber;
            Culture.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            //Culture.Readonly = false;
            Culture.MakeReadOnly(Culture.ID);
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Culture.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            hdnIsCultureSensitivityV2.Value = "true";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on LoadCultureAndSensitivityV2Pattern", ex);
        }
        return Culture;
    }
    public Control LoadStoneAnalysis(PatientInvestigation lstInve)
    {

        Investigation_StoneAnalysis stoneAnalysis;
        stoneAnalysis = (Investigation_StoneAnalysis)LoadControl(lstInve.PatternName);
        try
        {
            stoneAnalysis.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //stoneAnalysis.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            stoneAnalysis.Name = lstInve.InvestigationName;
            //stoneAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            stoneAnalysis.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            stoneAnalysis.ControlID = Convert.ToString(lstInve.InvestigationID);
            stoneAnalysis.GroupID = lstInve.GroupID;
            stoneAnalysis.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            stoneAnalysis.PackageID = lstInve.PackageID;
            stoneAnalysis.PackageName = lstInve.PackageName;
            stoneAnalysis.CurrentRoleName = RoleName;
            stoneAnalysis.LabTechEditMedRem = strLabTechToEditMedRem;
            stoneAnalysis.AccessionNumber = lstInve.AccessionNumber;
            stoneAnalysis.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            stoneAnalysis.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            stoneAnalysis.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //stoneAnalysis.setAttributes(Convert.ToString(stoneAnalysis.ID) );
            lstControl.Add(stoneAnalysis.ID);
            lstpatternID.Add(lstInve.PatternID);
            //stoneAnalysis.Readonly = false;
            stoneAnalysis.MakeReadOnly(stoneAnalysis.ID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                stoneAnalysis.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return stoneAnalysis;
    }
    public Control LoadMicBioPattern1(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_MicroBioPattern1 mbp;
        mbp = (Investigation_MicroBioPattern1)LoadControl(lstInve.PatternName);
        try
        {
            mbp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //mbp.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            mbp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            mbp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            mbp.Name = lstInve.InvestigationName;
            //mbp.ID = Convert.ToString(lstInve.InvestigationID);
            mbp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            mbp.ControlID = Convert.ToString(lstInve.InvestigationID);
            mbp.GroupID = lstInve.GroupID;
            mbp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            mbp.PackageID = lstInve.PackageID;
            mbp.PackageName = lstInve.PackageName;
            mbp.CurrentRoleName = RoleName;
            mbp.LabTechEditMedRem = strLabTechToEditMedRem;
            mbp.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //mbp.setAttributes(Convert.ToString(mbp.ID) );
            lstControl.Add(mbp.ID);
            lstpatternID.Add(lstInve.PatternID);
            //mbp.Readonly = false;
            mbp.MakeReadOnly(mbp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + mbp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                mbp.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadMicBioPattern1", ex);
        }
        return mbp;
    }
    public Control LoadFACellsPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_FluidAnalysisCellsPattern facep;
        facep = (Investigation_FluidAnalysisCellsPattern)LoadControl(lstInve.PatternName);
        try
        {
            facep.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //facep.LoadInvStatusReason(lstInvReasonMaster);

            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            facep.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            facep.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            facep.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            facep.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            facep.ControlID = Convert.ToString(lstInve.InvestigationID);
            facep.GroupID = lstInve.GroupID;
            facep.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            facep.PackageID = lstInve.PackageID;
            facep.PackageName = lstInve.PackageName;
            facep.CurrentRoleName = RoleName;
            facep.LabTechEditMedRem = strLabTechToEditMedRem;
            facep.AccessionNumber = lstInve.AccessionNumber;
            facep.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(facep.ID);
            lstpatternID.Add(lstInve.PatternID);
            //facep.Readonly = false;
            facep.MakeReadOnly(facep.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + facep.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                facep.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFACellsPattern", ex);
        }
        return facep;
    }
    public Control LoadBodyFluidAnalysisPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_Body_Fluid_Analysis facep;
        facep = (Investigation_Body_Fluid_Analysis)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //facep.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            facep.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            facep.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            facep.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            facep.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            facep.ControlID = Convert.ToString(lstInve.InvestigationID);
            facep.GroupID = lstInve.GroupID;
            facep.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            facep.PackageID = lstInve.PackageID;
            facep.PackageName = lstInve.PackageName;
            facep.CurrentRoleName = RoleName;
            facep.LabTechEditMedRem = strLabTechToEditMedRem;
            facep.AccessionNumber = lstInve.AccessionNumber;
            facep.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(facep.ID);
            lstpatternID.Add(lstInve.PatternID);
            //facep.Readonly = false;
            facep.MakeReadOnly(facep.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + facep.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                facep.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBodyFluidAnalysisPattern", ex);
        }
        return facep;
    }
    public Control LoadSmearPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_SmearAnalysis facep;
        facep = (Investigation_SmearAnalysis)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //facep.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            facep.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //facep.LoadData(DemoBulk);
            facep.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            facep.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            facep.ControlID = Convert.ToString(lstInve.InvestigationID);
            facep.GroupID = lstInve.GroupID;
            facep.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            facep.PackageID = lstInve.PackageID;
            facep.PackageName = lstInve.PackageName;
            facep.CurrentRoleName = RoleName;
            facep.LabTechEditMedRem = strLabTechToEditMedRem;
            facep.AccessionNumber = lstInve.AccessionNumber;
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(facep.ID);
            lstpatternID.Add(lstInve.PatternID);
            //facep.Readonly = false;
            facep.MakeReadOnly(facep.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + facep.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                facep.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBodyFluidAnalysisPattern", ex);
        }
        return facep;
    }
    public Control LoadSemenAnalysisNewPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_SemenAnalysisNewPattern facep;
        facep = (Investigation_SemenAnalysisNewPattern)LoadControl(lstInve.PatternName);
        try
        {
            facep.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //facep.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            facep.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //facep.LoadData(DemoBulk);
            facep.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            facep.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            facep.ControlID = Convert.ToString(lstInve.InvestigationID);
            facep.GroupID = lstInve.GroupID;
            facep.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            facep.PackageID = lstInve.PackageID;
            facep.PackageName = lstInve.PackageName;
            facep.CurrentRoleName = RoleName;
            facep.LabTechEditMedRem = strLabTechToEditMedRem;
            facep.AccessionNumber = lstInve.AccessionNumber;
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(facep.ID);
            lstpatternID.Add(lstInve.PatternID);
            //facep.Readonly = false;
            facep.MakeReadOnly(facep.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + facep.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                facep.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadSemenAnalysisNewPatternPattern", ex);
        }
        return facep;
    }
    public Control LoadFAChemistryPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_FluidAnalysisChemistryPattern fachp;
        fachp = (Investigation_FluidAnalysisChemistryPattern)LoadControl(lstInve.PatternName);
        try
        {
            fachp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //fachp.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            fachp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            fachp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            fachp.Name = lstInve.InvestigationName;
            //fachp.ID = Convert.ToString(lstInve.InvestigationID);
            fachp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            fachp.ControlID = Convert.ToString(lstInve.InvestigationID);
            fachp.GroupID = lstInve.GroupID;
            fachp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            fachp.PackageID = lstInve.PackageID;
            fachp.PackageName = lstInve.PackageName;
            fachp.CurrentRoleName = RoleName;
            fachp.LabTechEditMedRem = strLabTechToEditMedRem;
            fachp.AccessionNumber = lstInve.AccessionNumber;
            //fachp.setAttributes(Convert.ToString(fachp.ID) );
            lstControl.Add(fachp.ID);
            lstpatternID.Add(lstInve.PatternID);
            //fachp.Readonly = false;
            fachp.MakeReadOnly(fachp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + fachp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                fachp.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFAChemistryPattern", ex);
        }
        return fachp;
    }
    public Control LoadFAImmunologyPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_FluidAnalysisImmunolgyPattern faimp;
        faimp = (Investigation_FluidAnalysisImmunolgyPattern)LoadControl(lstInve.PatternName);
        try
        {
            faimp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //faimp.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            faimp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            faimp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            faimp.Name = lstInve.InvestigationName;
            //faimp.ID = Convert.ToString(lstInve.InvestigationID);
            faimp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            faimp.ControlID = Convert.ToString(lstInve.InvestigationID);
            faimp.GroupID = lstInve.GroupID;
            faimp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            faimp.PackageID = lstInve.PackageID;
            faimp.PackageName = lstInve.PackageName;
            faimp.CurrentRoleName = RoleName;
            faimp.LabTechEditMedRem = strLabTechToEditMedRem;
            faimp.AccessionNumber = lstInve.AccessionNumber;
            //faimp.setAttributes(Convert.ToString(faimp.ID) );
            lstControl.Add(faimp.ID);
            lstpatternID.Add(lstInve.PatternID);
            //faimp.Readonly = false;
            faimp.MakeReadOnly(faimp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + faimp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count() > 0)
            {
                faimp.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFAImmunologyPattern", ex);
        }
        return faimp;
    }
    public Control LoadFACytologyPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_FluidAnalysisCytologyPattern facyp;
        facyp = (Investigation_FluidAnalysisCytologyPattern)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //facyp.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            facyp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            facyp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            facyp.Name = lstInve.InvestigationName;
            //facyp.ID = Convert.ToString(lstInve.InvestigationID);
            facyp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            facyp.ControlID = Convert.ToString(lstInve.InvestigationID);
            facyp.GroupID = lstInve.GroupID;
            facyp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            facyp.PackageID = lstInve.PackageID;
            facyp.PackageName = lstInve.PackageName;
            facyp.CurrentRoleName = RoleName;
            facyp.LabTechEditMedRem = strLabTechToEditMedRem;
            facyp.AccessionNumber = lstInve.AccessionNumber;
            //facyp.setAttributes(Convert.ToString(facyp.ID) );
            lstControl.Add(facyp.ID);
            lstpatternID.Add(lstInve.PatternID);
            //facyp.Readonly = false;
            facyp.MakeReadOnly(facyp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + facyp.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count() > 0)
            {
                facyp.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFACytologyPattern", ex);
        }
        return facyp;
    }
    public Control LoadFSmearPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;

        Investigation_FungalSmearPattern fsp;
        fsp = (Investigation_FungalSmearPattern)LoadControl(lstInve.PatternName);

        try
        {
            fsp.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //fsp.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            fsp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            fsp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            fsp.Name = lstInve.InvestigationName;
            //fsp.ID = Convert.ToString(lstInve.InvestigationID);
            fsp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            fsp.ControlID = Convert.ToString(lstInve.InvestigationID);
            fsp.GroupID = lstInve.GroupID;
            fsp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            fsp.PackageID = lstInve.PackageID;
            fsp.PackageName = lstInve.PackageName;
            fsp.CurrentRoleName = RoleName;
            fsp.LabTechEditMedRem = strLabTechToEditMedRem;
            fsp.AccessionNumber = lstInve.AccessionNumber;
            //fsp.setAttributes(Convert.ToString(fsp.ID) );
            lstControl.Add(fsp.ID);
            lstpatternID.Add(lstInve.PatternID);
            //fsp.Readonly = false;
            fsp.MakeReadOnly(fsp.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + fsp.ID + "_ddlstatus";
            //}
            fsp.loadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFSmearPattern", ex);
        }
        return fsp;
    }
    public Control LoadAbMethod(PatientInvestigation lstInve)
    {

        Investigation_AntibodyWithMethod ABMethod;
        ABMethod = (Investigation_AntibodyWithMethod)LoadControl(lstInve.PatternName);
        try
        {
            ABMethod.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //ABMethod.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            ABMethod.Name = lstInve.InvestigationName;
            //ABMethod.ID = Convert.ToString(lstInve.InvestigationID);
            ABMethod.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            ABMethod.ControlID = Convert.ToString(lstInve.InvestigationID);
            ABMethod.GroupID = lstInve.GroupID;
            ABMethod.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            ABMethod.PackageID = lstInve.PackageID;
            ABMethod.PackageName = lstInve.PackageName;
            ABMethod.CurrentRoleName = RoleName;
            ABMethod.LabTechEditMedRem = strLabTechToEditMedRem;
            ABMethod.DecimalPlaces = lstInve.DecimalPlaces;
            ABMethod.ResultValueType = lstInve.ResultValueType;
            ABMethod.AccessionNumber = lstInve.AccessionNumber;
            //ABMethod.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                ABMethod.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                ABMethod.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            ABMethod.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            ABMethod.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //ABMethod.setAttributes(Convert.ToString(ABMethod.ID));
            lstControl.Add(ABMethod.ID);
            lstpatternID.Add(lstInve.PatternID);

            ABMethod.MakeReadOnly(ABMethod.ID);

            ABMethod.PatientVisitID = vid;
            ABMethod.PatternID = (lstInve.PatternID);
            ABMethod.POrgid = Convert.ToInt32(hdnOrgID.Value);
            ABMethod.CurrentRoleName = RoleName.Trim();
            ABMethod.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            ABMethod.IsAbnormal = lstInve.IsAbnormal;
            ABMethod.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + ABMethod.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                ABMethod.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //ABMethod.Readonly = false;
            ABMethod.MakeReadOnly(ABMethod.ID);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return ABMethod;
    }
    public Control LoadAbQualitativeMethod(PatientInvestigation lstInve)
    {

        Investigation_AntibodyQualitative ABQualitative;
        ABQualitative = (Investigation_AntibodyQualitative)LoadControl(lstInve.PatternName);
        try
        {
            ABQualitative.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //ABQualitative.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            ABQualitative.Name = lstInve.InvestigationName;
            //ABQualitative.ID = Convert.ToString(lstInve.InvestigationID);
            ABQualitative.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            ABQualitative.UOM = lstInve.UOMCode;
            ABQualitative.IsAbnormal = lstInve.IsAbnormal;
            //ABQualitative.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                ABQualitative.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                ABQualitative.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            ABQualitative.ControlID = Convert.ToString(lstInve.InvestigationID);
            ABQualitative.GroupID = lstInve.GroupID;
            ABQualitative.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            ABQualitative.PackageID = lstInve.PackageID;
            ABQualitative.PackageName = lstInve.PackageName;
            ABQualitative.CurrentRoleName = RoleName;
            ABQualitative.LabTechEditMedRem = strLabTechToEditMedRem;
            ABQualitative.DecimalPlaces = lstInve.DecimalPlaces;
            ABQualitative.ResultValueType = lstInve.ResultValueType;
            ABQualitative.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            ABQualitative.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            ABQualitative.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            ABQualitative.AccessionNumber = lstInve.AccessionNumber;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //ABQualitative.setAttributes(Convert.ToString(ABQualitative.ID));

            lstControl.Add(ABQualitative.ID);

            lstpatternID.Add(lstInve.PatternID);
            //ABQualitative.Readonly = false;
            ABQualitative.MakeReadOnly(ABQualitative.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + ABQualitative.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                ABQualitative.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return ABQualitative;
    }
    public Control LoadSemenAnalysis(PatientInvestigation lstInve)
    {

        Investigation_SemenAnalysis semenAnalysis;
        semenAnalysis = (Investigation_SemenAnalysis)LoadControl(lstInve.PatternName);
        try
        {
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //semenAnalysis.LoadInvStatusReason(lstInvReasonMaster);
            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            semenAnalysis.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            semenAnalysis.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //semenAnalysis.UOM = lstInve.UOMCode;
            semenAnalysis.ControlID = Convert.ToString(lstInve.InvestigationID);
            semenAnalysis.GroupID = lstInve.GroupID;
            semenAnalysis.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            semenAnalysis.PackageID = lstInve.PackageID;
            semenAnalysis.PackageName = lstInve.PackageName;
            semenAnalysis.CurrentRoleName = RoleName;
            semenAnalysis.LabTechEditMedRem = strLabTechToEditMedRem;
            semenAnalysis.AccessionNumber = lstInve.AccessionNumber;
            semenAnalysis.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            semenAnalysis.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //semenAnalysis.setAttributes(Convert.ToString(semenAnalysis.ID) );
            //semenAnalysis.Readonly = false;
            semenAnalysis.MakeReadOnly(semenAnalysis.ID);
            lstControl.Add(semenAnalysis.ID);

            lstpatternID.Add(lstInve.PatternID);

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                semenAnalysis.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return semenAnalysis;
    }
    public Control LoadImaging(PatientInvestigation lstInve)
    {

        Investigation_ImagingWithFCKEditor Imaging;
        Imaging = (Investigation_ImagingWithFCKEditor)LoadControl(lstInve.PatternName);

        try
        {
            Imaging.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Imaging.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Imaging.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            Imaging.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //semenAnalysis.UOM = lstInve.UOMCode;
            Imaging.ControlID = Convert.ToString(lstInve.InvestigationID);
            Imaging.PatientVisitID = vid;
            Imaging.GroupID = lstInve.GroupID;
            Imaging.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Imaging.PackageID = lstInve.PackageID;
            Imaging.PackageName = lstInve.PackageName;
            Imaging.AccessionNumber = lstInve.AccessionNumber;
            Imaging.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Imaging.Readonly = false;
            Imaging.MakeReadOnly(Imaging.ID);
            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(Imaging.ID);

            lstpatternID.Add(lstInve.PatternID);

            Imaging.loadDrName(lPerformingPhysicain);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Imaging.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
                var lstpendvalue = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
                if (lstpendvalue[0].ApprovedBy != 0)
                {
                    if (lstpendvalue[0].ApprovedBy == LID)
                    {
                        Imaging.isReportEditable = true;
                    }
                }
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return Imaging;
    }
    public Control LoadSmear(PatientInvestigation lstInve)
    {

        Investigation_PeripheralSmear phSmear;
        phSmear = (Investigation_PeripheralSmear)LoadControl(lstInve.PatternName);
        try
        {
            phSmear.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //phSmear.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            phSmear.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            phSmear.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            phSmear.UOM = lstInve.UOMCode;
            phSmear.ControlID = Convert.ToString(lstInve.InvestigationID);
            phSmear.GroupID = lstInve.GroupID;
            phSmear.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            phSmear.PackageID = lstInve.PackageID;
            phSmear.PackageName = lstInve.PackageName;
            phSmear.CurrentRoleName = RoleName;
            phSmear.AccessionNumber = lstInve.AccessionNumber;
            phSmear.LabTechEditMedRem = strLabTechToEditMedRem;
            phSmear.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            phSmear.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //phSmear.Readonly = false;
            phSmear.MakeReadOnly(phSmear.ID);
            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(phSmear.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + phSmear.ID + "_ddlstatus";
            //}
            lstpatternID.Add(lstInve.PatternID);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return phSmear;
    }
    public Control loadBleedingTime(PatientInvestigation lstInve)
    {
        Investigation_BleedingTime bleedingTime;
        bleedingTime = (Investigation_BleedingTime)LoadControl(lstInve.PatternName);
        try
        {
            bleedingTime.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //bleedingTime.LoadInvStatusReason(lstInvReasonMaster);

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            bleedingTime.Name = lstInve.InvestigationName;
            bleedingTime.UOM = lstInve.UOMCode;
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            //checkInvest.ID = Convert.ToString(lstInve.InvestigationID);
            bleedingTime.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            bleedingTime.ControlID = Convert.ToString(lstInve.InvestigationID);
            bleedingTime.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            bleedingTime.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            bleedingTime.GroupID = lstInve.GroupID;
            bleedingTime.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            bleedingTime.PackageID = lstInve.PackageID;
            bleedingTime.PackageName = lstInve.PackageName;
            bleedingTime.CurrentRoleName = RoleName;
            bleedingTime.LabTechEditMedRem = strLabTechToEditMedRem;
            bleedingTime.AccessionNumber = lstInve.AccessionNumber;
            //bleedingTime.RefRange = lstInve.ReferenceRange; // "MALE:0 – 20 mm/hr FEMALE :0 – 30 mm/hr";
            if (lstInve.ReferenceRange != null)
            {
                bleedingTime.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
            {
                bleedingTime.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
            }
            bleedingTime.Reason = lstInve.Reason; //Added by Perumal on 13 Jan 2012
            // bleedingTime.Readonly = false;
            bleedingTime.MakeReadOnly(bleedingTime.ID);
            lstControl.Add(bleedingTime.ID);
            lstpatternID.Add(lstInve.PatternID);

            bleedingTime.PatientVisitID = vid;
            bleedingTime.PatternID = (lstInve.PatternID);
            bleedingTime.POrgid = Convert.ToInt32(hdnOrgID.Value);
            bleedingTime.CurrentRoleName = RoleName.Trim();

            bleedingTime.MakeReadOnly(bleedingTime.ID);
            bleedingTime.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + bleedingTime.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                bleedingTime.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return bleedingTime;
    }
    public Control LoadTextualPattern(PatientInvestigation lstInve)
    {

        Investigation_TextualPattern Imaging;
        Imaging = (Investigation_TextualPattern)LoadControl(lstInve.PatternName);

        try
        {
            Imaging.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //Imaging.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Imaging.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            Imaging.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //semenAnalysis.UOM = lstInve.UOMCode;
            Imaging.ControlID = Convert.ToString(lstInve.InvestigationID);
            Imaging.PatientVisitID = vid;
            Imaging.GroupID = lstInve.GroupID;
            Imaging.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Imaging.PackageID = lstInve.PackageID;
            Imaging.PackageName = lstInve.PackageName;
            Imaging.AccessionNumber = lstInve.AccessionNumber;
            Imaging.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Imaging.Readonly = false;
            Imaging.MakeReadOnly(Imaging.ID);
            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(Imaging.ID);

            lstpatternID.Add(lstInve.PatternID);
            //Imaging.LoadddlInvResultTemplate();
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Imaging.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Imaging.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return Imaging;
    }
    public Control LoadGTT(PatientInvestigation lstInve)
    {

        Investigation_GTT GTT;
        GTT = (Investigation_GTT)LoadControl(lstInve.PatternName);

        try
        {
            GTT.POrgid = Convert.ToInt32(hdnOrgID.Value);
            //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            //List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
            //GTT.LoadInvStatusReason(lstInvReasonMaster);

            long InvestigationID = lstInve.InvestigationID;
            int GroupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkDataForApprovel(gUID, InvestigationID, vid, Convert.ToInt32(hdnOrgID.Value), GroupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            GTT.Name = lstInve.InvestigationName;
            //GTT.RefRange = lstInve.ReferenceRange;
            if (lstInve.ReferenceRange != null)
            {
                GTT.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
            }
            GTT.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            GTT.ControlID = Convert.ToString(lstInve.InvestigationID);
            GTT.GroupID = lstInve.GroupID;
            GTT.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            GTT.PackageID = lstInve.PackageID;
            GTT.PackageName = lstInve.PackageName;
            GTT.AccessionNumber = lstInve.AccessionNumber;
            GTT.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            GTT.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            lstControl.Add(GTT.ID);
            lstpatternID.Add(lstInve.PatternID);

            //GTT.Readonly = false;
            GTT.MakeReadOnly(GTT.ID);
            //if (!String.IsNullOrEmpty(lstInve.DeptName) || !String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + GTT.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                GTT.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadBioControl", ex);
        }
        return GTT;
    }
    public Control loadOrganismDrugPatternControl(PatientInvestigation lstInve)
    {
        Investigation_OrganismDrugPattern orgDrugPattern;
        orgDrugPattern = (Investigation_OrganismDrugPattern)LoadControl(lstInve.PatternName);
        try
        {
            orgDrugPattern.POrgid = OrgID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;
            orgDrugPattern.Name = lstInve.InvestigationName;
            orgDrugPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            orgDrugPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            orgDrugPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            orgDrugPattern.GroupID = lstInve.GroupID;
            orgDrugPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            orgDrugPattern.PackageID = lstInve.PackageID;
            orgDrugPattern.PackageName = lstInve.PackageName;
            orgDrugPattern.CurrentRoleName = RoleName;
            orgDrugPattern.UID = lstInve.UID;
            orgDrugPattern.LabNo = lstInve.LabNo;

            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;

            //Delta
            orgDrugPattern.PatientVisitID = vid;
            orgDrugPattern.PatternID = (lstInve.PatternID);
            orgDrugPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            orgDrugPattern.CurrentRoleName = RoleName.Trim();
            orgDrugPattern.AccessionNumber = lstInve.AccessionNumber;
            orgDrugPattern.LoadOrganism(lstInve.InvestigationID);
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + orgDrugPattern.ID + "_ddlstatus";
            //}
            lstControl.Add(orgDrugPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                orgDrugPattern.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadOrgDrugPatternControl", ex);
        }
        return orgDrugPattern;
    }
    /* BEGIN | sabari | 20181129 | Dev | Culture Report */
    public Control OrganismDrugPatternWithLevel(PatientInvestigation lstInve)
    {
        Investigation_OrganismDrugPatternWithLevel orgDrugPattern;
        orgDrugPattern = (Investigation_OrganismDrugPatternWithLevel)LoadControl(lstInve.PatternName);
        try
        {
            orgDrugPattern.POrgid = OrgID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;
            orgDrugPattern.Name = lstInve.InvestigationName;
            orgDrugPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            orgDrugPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            orgDrugPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            orgDrugPattern.GroupID = lstInve.GroupID;
            orgDrugPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            orgDrugPattern.PackageID = lstInve.PackageID;
            orgDrugPattern.PackageName = lstInve.PackageName;
            orgDrugPattern.CurrentRoleName = RoleName;
            orgDrugPattern.UID = lstInve.UID;
            orgDrugPattern.LabNo = lstInve.LabNo;

            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;

            //Delta
            orgDrugPattern.PatientVisitID = vid;
            orgDrugPattern.PatternID = (lstInve.PatternID);
            orgDrugPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            orgDrugPattern.CurrentRoleName = RoleName.Trim();
            orgDrugPattern.AccessionNumber = lstInve.AccessionNumber;
            orgDrugPattern.LoadOrganism(lstInve.InvestigationID);
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + orgDrugPattern.ID + "_ddlstatus";
            //}
            lstControl.Add(orgDrugPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                orgDrugPattern.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadOrgDrugPatternControl", ex);
        }
        return orgDrugPattern;
    }
    /* END | sabari | 20181129 | Dev | Culture Report */
    public Control loadMicroStainPatternControl(PatientInvestigation lstInve)
    {
        Investigation_MicroStainPattern microStainPattern;
        microStainPattern = (Investigation_MicroStainPattern)LoadControl(lstInve.PatternName);
        try
        {
            microStainPattern.POrgid = OrgID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;
            microStainPattern.Name = lstInve.InvestigationName;
            microStainPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            microStainPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            microStainPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            microStainPattern.GroupID = lstInve.GroupID;
            microStainPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            microStainPattern.PackageID = lstInve.PackageID;
            microStainPattern.PackageName = lstInve.PackageName;
            microStainPattern.CurrentRoleName = RoleName;
            microStainPattern.UID = lstInve.UID;
            microStainPattern.LabNo = lstInve.LabNo;

            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;

            //Delta
            microStainPattern.PatientVisitID = vid;
            microStainPattern.PatternID = (lstInve.PatternID);
            microStainPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            microStainPattern.CurrentRoleName = RoleName.Trim();
            microStainPattern.AccessionNumber = lstInve.AccessionNumber;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + microStainPattern.ID + "_ddlstatus";
            //}
            lstControl.Add(microStainPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            microStainPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                microStainPattern.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadmicroStainPatternControl", ex);
        }
        return microStainPattern;
    }
    public Control loadMicroHEMATOLOGY(PatientInvestigation lstInve)
    {
        Investigation_HEMATOLOGY HEMATOLOGYPattern;
        HEMATOLOGYPattern = (Investigation_HEMATOLOGY)LoadControl(lstInve.PatternName);
        try
        {
            HEMATOLOGYPattern.POrgid = OrgID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;
            HEMATOLOGYPattern.Name = lstInve.InvestigationName;
            HEMATOLOGYPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            HEMATOLOGYPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            HEMATOLOGYPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            HEMATOLOGYPattern.GroupID = lstInve.GroupID;
            HEMATOLOGYPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            HEMATOLOGYPattern.PackageID = lstInve.PackageID;
            HEMATOLOGYPattern.PackageName = lstInve.PackageName;
            HEMATOLOGYPattern.CurrentRoleName = RoleName;
            HEMATOLOGYPattern.UID = lstInve.UID;
            HEMATOLOGYPattern.LabNo = lstInve.LabNo;

            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;

            //Delta
            HEMATOLOGYPattern.PatientVisitID = vid;
            HEMATOLOGYPattern.PatternID = (lstInve.PatternID);
            HEMATOLOGYPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            HEMATOLOGYPattern.CurrentRoleName = RoleName.Trim();
            HEMATOLOGYPattern.AccessionNumber = lstInve.AccessionNumber;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + HEMATOLOGYPattern.ID + "_ddlstatus";
            //}
            lstControl.Add(HEMATOLOGYPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            HEMATOLOGYPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                HEMATOLOGYPattern.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on loadMicroHEMATOLOGY", ex);
        }
        return HEMATOLOGYPattern;
    }



    #endregion
    /// Load Pattern according to the Investigations selected   
    /// <param name="selectedID"></param>    







    //protected void btnGo_Click(object sender, EventArgs e)
    public void loadQualitativeResultMaster()
    {
        long returnCode = -1;
        List<InvQualitativeResultMaster> lstQualitativeResult = new List<InvQualitativeResultMaster>();
        returnCode = InvestigationBL.GetInvQualitativeResultMaster(out lstQualitativeResult);

        lstQualitativeMaster.DataSource = lstQualitativeResult;
        lstQualitativeMaster.DataTextField = "QualitativeResultName";
        lstQualitativeMaster.DataValueField = "QualitativeResultId";


        lstQualitativeMaster.DataBind();

    }
    private void TaskOpen()
    {
        long returncode = -1;
        long taskID = -1;
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        returncode = new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "ReleaseTask");
    }
    public void RaiseCallbackEvent(string eventArgument)
    {
        string o = eventArgument;
        string[] value = o.Split('$');

        if (value[0] != "True") //&& value[1] == "hdnClickCheck")
        {
            if (value.Count() > 1)
            {
                if (value[1] == "hdnClickCheck")
                {
                    //CLogger.LogWarning("Navigate Open");
                    //CLogger.LogWarning("Navi "+hdnClickCheck.Value.ToString());
                    TaskOpen();
                }
            }
        }
        if (value[0].Contains("xml"))
        {
            if (value.Count() > 1)
            {
                if (value[1] == "ReferenceRange")
                {
                    //validateAllRange(value[0]);
                }
            }
        }

    }
    public string GetCallbackResult()
    {
        return hdnGenderAge.Value.ToString();
        //return "LockReleased";
    }
    //Medical Remarks
    private PatientInvestigation AddMedicalRemarks(PatientInvestigation objPInv, List<PatientInvestigation> lstPInvestigation, int intRowNum)
    {
        if (groupMedCommentHDN1.Value != "")
        {
            string[] grpLineItems = groupMedCommentHDN1.Value.Split('^');
            //            foreach (string str in groupMedCommentHDN1.Value.Split('^'))
            {
                string[] lineItems = grpLineItems[intRowNum].Split('~');
                if (lineItems[0] != "")
                {

                    objPInv.GroupName = lineItems[0].Replace(":", "");

                    objPInv.GroupMedicalRemarks = lineItems[1];

                    objPInv.PatientVisitID = vid;
                    objPInv.OrgID = OrgID;

                    int lstlength = lstPInvestigation.Count;


                    if (lstlength != 0)
                    {
                        int count = 0;
                        for (int i = 0; i < lstlength; i++)
                        {

                            string comparer1 = objPInv.GroupName.ToString().Replace(":", "") + "~" +
                                              objPInv.GroupMedicalRemarks.ToString();

                            string comparer2 = lstPInvestigation[i].GroupName.ToString().Replace(":", "") + "~" +
                                               lstPInvestigation[i].GroupMedicalRemarks.ToString();

                            if (comparer1 == comparer2)
                            {
                                count++;

                            }


                        }


                        if (count == 0)
                        {

                            //lstPInvestigation.Add(objPInv);
                            lstlength++;

                        }

                    }
                    else
                    {
                        //lstPInvestigation.Add(objPInv);

                    }

                }
            }
        }
        return objPInv;
    }
    //Medical Remarks

    public Control LoadTablepatternautopopulateV2(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_TablePatternV2 TablepatternautopopulateV2;
        TablepatternautopopulateV2 = (Investigation_TablePatternV2)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            TablepatternautopopulateV2.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            TablepatternautopopulateV2.ControlID = Convert.ToString(lstInve.InvestigationID);
            TablepatternautopopulateV2.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            TablepatternautopopulateV2.Name = lstInve.InvestigationName;
            TablepatternautopopulateV2.GroupID = lstInve.GroupID;
            TablepatternautopopulateV2.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            lstControl.Add(TablepatternautopopulateV2.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName.Replace(":", "") + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + TablepatternautopopulateV2.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                TablepatternautopopulateV2.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Tablepatternautopopulate ", ex);
        }
        return TablepatternautopopulateV2;
    }
 

}



