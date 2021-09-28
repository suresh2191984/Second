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
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.PerformingNextAction;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.Script.Serialization;
using System.Web.Services;
using FredCK.FCKeditorV2;
using CKEditor.NET;
using System.Web.Script.Services;

public partial class Investigation_InvestigationResultsCaptureBulk : BasePage, System.Web.UI.ICallbackEventHandler
{
    public Investigation_InvestigationResultsCaptureBulk()
        : base("Investigation_InvestigationResultsCaptureBulk_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #region Initialization
    long pSCMID = -1;
    //  UserControl BioControl = null;
    //Control HematControl = null;
    // int PatternID = 0;
    string fileName = string.Empty;
    string Formula = string.Empty;
    string FormulaINV = string.Empty;
    Control myControl = null;
    string pathname = string.Empty;
    string autoComments = string.Empty;
    List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
    List<InvestigationStatus> header = new List<InvestigationStatus>();
    List<InvestigationStatus> header1 = new List<InvestigationStatus>();
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
    List<PatientInvestigation> lstInvestigationValuesforAlert = new List<PatientInvestigation>();
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
    long patientVisitID = 0;
    string reportID = string.Empty;
    long investigatgionID = 0;
    string AutoAuthorizeCheck = string.Empty;//added by jegan for --do autoauthorize based on  previous visit 
    List<InvReportMaster> lstReport = new List<InvReportMaster>();
    List<InvReportMaster> lstReportName = new List<InvReportMaster>();

    Investigation_BL InvestigationBL;
    List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
    List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
    List<PerformingPhysician> lPerformingPhysicain = new List<PerformingPhysician>();
    List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
    Investigation_BL objInvBL;
    Investigation_BL DemoBL;
    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
    List<Users> lstSecondOpinionUser = new List<Users>();
    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
    List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();

    List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();
    string gUID = string.Empty;
    string chkStatus = string.Empty;
    string rawData, textColor, RangeCode;
    string AllowAutoApproveTask = string.Empty;
    string AllowAutoApprove = string.Empty;
    long returncode = -1;
    //static int countOutOfRange = 0;
    static bool countOutOfRangebypass = true;
    System.Text.StringBuilder sJsFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsINVFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntionEmptyValue = new System.Text.StringBuilder();

    string LabNo = string.Empty;
    long DeptID = 0;
    string strLabTechToEditMedRem = "";
    string strSingleReferenceRange = "";
    //string pGender = string.Empty;
    Array pAgeRaw;
    long patientID = 0;
    public int AutoApproveQueueCount = 0;
    public int NormalApproveTestCount = 0;
    public int IsAutoAuthRecollect = 0;
    List<InvestigationValues> DemoBulk, lstPendingValue, lstPendingval = new List<InvestigationValues>();
    List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
    List<Patient> lstpatient;
    List<VitalsUOMJoin> lstpv;
    string GUID;
    //= Guid.NewGuid().ToString();
    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
    WebService objWS = new WebService();
    List<PatientInvestigation> lstPatientInvestigation3 = new List<PatientInvestigation>();
    List<PatientInvestigation> LstINVHideStatus = new List<PatientInvestigation>();
    PatientInvestigation INVHideStatus;
    List<ReferenceRangeType> lstReferenceRangeType = new List<ReferenceRangeType>();

    string IsCommonValidation = string.Empty;
    string accessionnumber = string.Empty;
    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38;
    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
    string FilePath = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        long returnCode = -1;
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        objInvBL = new Investigation_BL(base.ContextInfo);
        GateWay gateWay = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();
        returncode = gateWay.GetConfigDetails("PrintSampleBarcode", OrgID, out lstConfig);
        string rtnCode = GetConfigValues("AutoSave", OrgID);
        hdnAutoSave.Value = rtnCode.ToString();
        if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
        {

            ViewTRF.Attributes.Add("style", "display:block");
        }
        else
        {
            ViewTRF.Attributes.Add("style", "display:none");
        }
        string DisableContinueButton = GetConfigValues("DisableResultCaptureContinueButton", OrgID);
        autoComments = GetConfigValues("AutoMedicalComments", OrgID);

        if (autoComments != "")
        {
            hdnAutoMedicalComments.Value = autoComments;
        }
        if (!String.IsNullOrEmpty(DisableContinueButton) && DisableContinueButton == "Y")
        {
            btnShowRR1.Visible = false;
            btnShowRR.Visible = false;
        }
        hdnIscommonValidation.Value = GetConfigValues("EnterResultCommonValidation", OrgID);


        FilePath = GetConfigValues("TabularPattern_FilePath", OrgID);

        if (!string.IsNullOrEmpty(FilePath))
        {
            if (!Directory.Exists(FilePath))
            {
                Directory.CreateDirectory(FilePath);
            }
        }
        LoadRangeColor();

        // Need to be change
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

        strLabTechToEditMedRem = GetConfigValues("CanLabTechEditMedRem", OrgID);
        hdnstatuschange.Value = GetConfigValues("StatusChangeByOrg", OrgID);
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
        else if ((Request.QueryString["AccNo"] != null) && (Request.QueryString["AccNo"] != ""))
        {
            LabNo = Request.QueryString["AccNo"].ToString();
        }
        if ((Request.QueryString["DeptID"] != null) && (Request.QueryString["DeptID"] != ""))
        {
            DeptID = Convert.ToInt64(Request.QueryString["DeptID"].ToString());
        }
        //code added on 23-07-2010 QRM - Started

        lstQualitativeMaster.Attributes.Add("OnClick", "DisplaySelectedItem('" + lstQualitativeMaster.ClientID + "','" + sourceNameTXT.ClientID + "')");
        lstQualitativeMaster.Attributes.Add("onDblclick", "addSourceName();");

        ClientScriptManager cs = Page.ClientScript;
        String callBackReference = cs.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "ValidateUserResult", "", "ProcessCallBackError", false);
        String callBackScript = "function ValidateToXml(arg) {" + callBackReference + "; }";
        cs.RegisterClientScriptBlock(this.GetType(), "CallXmlValidation", callBackScript, true);
        sJsFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKGroupSum(id){ try { ");
        sJsINVFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKINVSum(){");
        sJsSaveValidationFuntion.Append("<script language ='javascript' type ='text/javascript'>function CheckSaveValidationFuntion(){ try { ");

        hdnOrgID.Value = OrgID.ToString();
        hdnRoleName.Value = RoleName;
        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
        string configApprovalSingleScreen = GetConfigValue("LabTech_Complete_Validate_Approval", OrgID);
        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */

        if (!IsPostBack)
        {
            Session["formula"] = null;
            loadQualitativeResultMaster();
            countOutOfRangebypass = true;
            hdnOutofrangeCount.Value = "0";
            mpeAttributeLocation.Hide();
            ScriptManager1.RegisterPostBackControl(btnShowRR);
            ScriptManager1.RegisterPostBackControl(btnApproval);
            ScriptManager1.RegisterPostBackControl(btnApproval1);
            ScriptManager1.RegisterPostBackControl(btnShowRR1);
        }

        //code added on 23-07-2010 QRM - Completed
        try
        {
            //vid = Convert.ToInt64(hdnVID.Value);
            //patientHeader.PatientVisitID = vid;

            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
                hdnPatientVisitID.Value = Request.QueryString["vid"];
                string invStatus = "all";
                lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + vid + "','" + RoleID + "','" + invStatus + "');return false;");
            }
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
            }

            if (vid != 0)
            {
                patientVisitID = Convert.ToInt64(vid);

            }

            hdnVID.Value = vid.ToString();
            //patientHeader.PatientVisitID = vid;
            List<RoleDeptMap> lRoleDeptMap = new List<RoleDeptMap>();
            List<InvReportMaster> lShowInvValues = new List<InvReportMaster>();
            List<InvestigationHeader> lstHeader = new List<InvestigationHeader>();
            List<MedicalRemarksRuleMaster> lstmedremarkrule = new List<MedicalRemarksRuleMaster>();
            string InvIDs = "";
            if (Request.QueryString["Invid"] != null)
            {
                string IDS = Request.QueryString["Invid"].ToString(); //.Split('^');
                IDS.Replace('^', ',');
                InvIDs = IDS;
                //for (int i = 0; IDS.Length > i; i++)
                //    if (InvIDs != "")
                //        InvIDs += "," + IDS[i];
                //    else
                //InvIDs += IDS[i];
            }
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            //InvestigationBL.GetInvestigatonResultsCapture(vid, OrgID, RoleID,gUID,InvIDs, ILocationID, objLoginDetail, out lstOrdered, out header, out lRoleDeptMap);
            string status = string.Empty;
            //long DeptID = 0;
            long taskID = -1;
            string IsTrustedDetails = string.Empty;
            /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
            if (configApprovalSingleScreen == "Y")
            {
                InvestigationBL.GetInvestigatonResultsCaptureSingleScreen(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, objLoginDetail, taskID, IsTrustedDetails, status, out lstOrdered, out header, out lRoleDeptMap);
            }
            else
            {
                InvestigationBL.GetInvestigatonResultsCapture(vid, OrgID, RoleID, gUID, DeptID, InvIDs, ILocationID, objLoginDetail, taskID, IsTrustedDetails, status, out lstOrdered, out header, out lRoleDeptMap, out lstmedremarkrule);
            }
            /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
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
                P.HeaderName = "Y";
                if (P.HeaderName.ToString() == "Y")
                {
                    hdnInvRemarks.Value += (P.InvestigationID.ToString() + '~' + P.HeaderName.ToString() + '^').ToString();
                }
                lstInvPackageMapping.Add(IPM);
            }

            if (lstOrdered.Count > 0)
            {
                foreach (var item in lstOrdered)
                {
                    if (item.Display == "Y")
                    {
                        hdnHeaderName.Value = "Imaging";
                        break;
                    }
                    else
                    {
                        hdnHeaderName.Value = "";

                    }
                }
            }

            /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
            if (configApprovalSingleScreen == "Y")
            {
                InvestigationBL.GetDrawPatternInvBulkDataSingleScreen(gUID, lstInvPackageMapping, vid, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom, out lPerformingPhysicain);
            }
            else
            {
                InvestigationBL.GetDrawPatternInvBulkData(gUID, lstInvPackageMapping, vid, OrgID, status, out DemoBulk, out lstPendingValue, out header, out lstiom, out lPerformingPhysicain);
            }
            /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
            returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            JavaScriptSerializer reasonserializer = new JavaScriptSerializer();
            hdnlstreasons.Value = reasonserializer.Serialize(lstInvReasonMaster);
            returnCode = new Investigation_BL().getReferencerangetype(OrgID, "en-GB", out lstReferenceRangeType);
            hdnRefrtype.Value = reasonserializer.Serialize(lstReferenceRangeType);
            hdnRuleMedRemarks.Value = GetConfigValues("RuleMedicalRemarks", OrgID);
            if (!IsPostBack)
            {
                //if (Request.QueryString["vid"] != null)
                //{
                //    //long returnCode = -1;
                //    //List<PatientVisit> visitList = new List<PatientVisit>();
                //    //PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
                //    //Patient_BL patientBL = new Patient_BL(base.ContextInfo);

                //}



                /*
                 * ConvertXmlToString this method each time to call patterndrawing on that each time reference range to fill data based on following sp
                 * 
                 * so now avoid each time..Only one time to call from global level...
                 * */
                if (Request.QueryString["pid"] != null)
                {
                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                }
                Patient_BL patientBLs = new Patient_BL(base.ContextInfo);
                lstpatient = new List<Patient>();
                //lstpv = new List<VitalsUOMJoin>();
                //patientBLs.GetPatientVitals(patientVisitID, patientID, OrgID, out lstpatient, out lstpv);
                List<PatientVisit> visitList = new List<PatientVisit>();
                patientBLs.GetLabVisitDetails(vid, OrgID, out visitList);

                if (visitList.Count > 0)
                {
                    hdnPatientGender.Value = visitList[0].Sex.ToString();
                    //    pAgeRaw = visitList[0].ReferenceRangeAge.Split(' ');
                    hdnpagearraw.Value = Convert.ToString(visitList[0].ReferenceRangeAge);
                    if (!String.IsNullOrEmpty(visitList[0].AgeDays))
                    {
                        hdnAgeDays.Value = visitList[0].AgeDays;
                    }
                }

                DemoBL = new Investigation_BL();
                returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation3);
                AutoApproveQueueCount = (from IL in lstPatientInvestigation3
                                         where IL.IsAutoApproveQueue == "Y"
                                         select IL).Count();
                hdnAutoApproveQueueCount.Value = AutoApproveQueueCount.ToString();
                NormalApproveTestCount = (from IL in lstPatientInvestigation3
                                          where IL.AutoApproveLoginID == 0
                                          select IL).Count();
                hdnNormalApproveTestCount.Value = NormalApproveTestCount.ToString();

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


            //if (!IsPostBack)
            //{
            //    HDnInVID.Value = "";
            //    foreach (InvReportMaster lst in lShowInvValues)
            //    {
            //        if (HDnInVID.Value == "")
            //            HDnInVID.Value += lst.InvestigationID.ToString();
            //        else
            //            HDnInVID.Value += "," + lst.InvestigationID.ToString();
            //    }
            //}

            //---------suresh  InvestigationBL.GetPatientInvSample(vid, OrgID, out lstPatientInvSample, out lstSampleAttributes, out lPerformingPhysicain);
            //need to change (for demo only)



            //List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
            //List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
            List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
            //new Investigation_BL(base.ContextInfo).GetWayToMethodKit(vid, OrgID, RoleID, out lstSampleDept1, out lstSampleDept2);
            //returncode = new Investigation_BL(base.ContextInfo).GetWayToMethodKit(RoleID, OrgID, deptID, out display);
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
            //if (hdnHeaderName.Value == "Imaging")
            //{
            //    //lnkCollectMoreSample.Visible = false;
            //}



            if (lstOrdered.Count > 0)
            {
                // hdnHeaderName.Value = lstOrdered[0].HeaderName;

                //if (lstPatientInvSample.Count > 0)
                //{
                //    if (hdnHeaderName.Value != "Imaging")
                //    {
                //        //ucSC.Visible = true;
                //        //ucSC.LoadPatientInvSample(lstPatientInvSample, lstSampleAttributes);
                //        //ucSC.GetPatientInvestigationSampleResults(vid, lRoleDeptMap[0].DeptID);
                //    }
                //    else
                //    {
                // ucSC.Visible = false;
                //btnApproval1.Visible = false;
                //btnShowRR1.Visible = false;
                //Button3.Visible = false;
                //    }
                //}
                //else
                //{
                //    //ucSC.Visible = false;
                //    btnApproval1.Visible = false;
                //    btnShowRR1.Visible = false;
                //    Button3.Visible = false;
                //}





                drawNewPatternMethod();
                //ShowInvestigation();

                // if (lShowInvValues.Count > 0)
                // {
                //     rptCaptureResult.DataSource = lShowInvValues;
                //     rptCaptureResult.DataBind();
                // }
                ucSCTab.Style.Add("display", "table");
                lblResult.Visible = false;
                //divSave.Visible = true;
                ucReflexTest.VisitID = vid;
                ucReflexTest.GUID = gUID;
                ucReflexTest.LabNo = LabNo;
                ucReflexTest.POrgid = OrgID;
            }
            else
            {
                lblResult.Visible = true;
                //divSave.Visible = false;
            }
            try
            {
                if (!String.IsNullOrEmpty(hdnUnCheckedAbnormalControl.Value))
                {
                    string[] valUnCheckedAbnormalControl = hdnUnCheckedAbnormalControl.Value.Split('^');
                    for (int iii = 0; iii < valUnCheckedAbnormalControl.Length - 1; iii++)
                    {
                        string[] unCheckedCtrl = valUnCheckedAbnormalControl[iii].Split('_');
                        if (unCheckedCtrl.Length > 1)
                        {
                            Control txtctl = (Control)Page.FindControl(unCheckedCtrl[0]);
                            TextBox ttl = null;
                            DropDownList ddl = null;
                            if (txtctl != null)
                            {
                                if (!unCheckedCtrl[1].Contains("ddlData"))
                                {
                                    ttl = (TextBox)txtctl.FindControl(unCheckedCtrl[1]);
                                }
                                ddl = (DropDownList)txtctl.FindControl("ddlData");

                                if (ttl != null)
                                {
                                    //ttl.BackColor = System.Drawing.Color.White;
                                    ttl.Attributes.Add("style", "background-color:white;");
                                }
                                if (ddl != null)
                                {
                                    //ddl.BackColor = System.Drawing.Color.White;
                                    ddl.Attributes.Add("style", "background-color:white;");
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in abnormal settings", ex);
            }
            if (Request.QueryString["POrgID"] != null)
            {

                hdnOrgID.Value = Request.QueryString["POrgID"].ToString();
                hdnRoleID.Value = RoleID.ToString();
                hdnloginid.Value = LID.ToString();
                hdnguid.Value = gUID.ToString();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation result capture on page_load", ex);
        }
    }
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
    protected void btnSave_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;

        Investigation_MultipleFileUpload MultipleUpload;
        MultipleUpload = (Investigation_MultipleFileUpload)LoadControl("MultipleFileUpload.ascx");

        long PatientID = 0;
        Int64.TryParse(Request.QueryString["pid"], out PatientID);
        long Returncode = MultipleUpload.CommonUpload(PatientID, patientVisitID, Request.Files, OrgID);
        SaveContinue();

        //validateAllRange(hdnValidateData.Value.ToString());
        //if (sender == btnSaveConfirm)
        //{
        //    countOutOfRangebypass = true;
        //    SaveContinue();
        //}
        //if (Convert.ToInt32(hdnOutofrangeCount.Value) <= 0)
        //{
        //    mpeAttributeLocation.Hide();
        //    string id = mpeAttributeLocation.ClientID;
        //    countOutOfRangebypass = true;
        //    SaveContinue();
        //}
        //else
        //{
        //    countOutOfRangebypass = false;
        //    mpeAttributeLocation.Show();
        //}
        // hdnValidateData.Value = "0";
        //code added for reference range - begin
    }
    protected void btnApproval_Click(object sender, EventArgs e)
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

        //validateAllRange(hdnValidateData.Value.ToString());
        //if (sender == btnSaveConfirm)
        //{
        //    countOutOfRangebypass = true;
        //    SaveContinue();
        //}
        //if (Convert.ToInt32(hdnOutofrangeCount.Value) <= 0)
        //{
        //    mpeAttributeLocation.Hide();
        //    string id = mpeAttributeLocation.ClientID;
        //    countOutOfRangebypass = true;
        //    SaveContinue();
        //}
        //else
        //{
        //    countOutOfRangebypass = false;
        //    mpeAttributeLocation.Show();
        //}
        // hdnValidateData.Value = "0";
        //code added for reference range - begin

    }
    private void SaveContinue()
    {
        try
        {
            if (Request.QueryString["pid"] != null)
            {
                PageContextDetails.PatientID = Convert.ToInt64(Request.QueryString["pid"]);
            }
            long returncode = AutoSave();

            if (returncode == 0)
            {
                ///////////karthick//////////////// && AllowAutoApproveTask == "No"
                if (chkStatus != "Pending")
                {
                    long PatientID = -1;
                    Tasks task = new Tasks();
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();

                    Int64.TryParse(Request.QueryString["pid"], out PatientID);
                    long createTaskID = -1;
                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(vid, out lstPatientVisitDetails);
                    DemoBL = new Investigation_BL();
                    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
                    List<PatientInvestigation> FilteredInvestigations = new List<PatientInvestigation>();
                    long returnCode = -1;
                    returnCode = DemoBL.GetPatientInvestigationStatus(vid, OrgID, out lstPatientInvestigation);
                    int completedCount = 0;

                    /**Exclude VID Lock for Org to Org Transfered Tests ***/
                    FilteredInvestigations = lstPatientInvestigation.FindAll(P => P.ExcludeVIDlock == "N");

                    completedCount = (from IL in FilteredInvestigations
                                      where IL.Status == InvStatus.Completed || IL.Status == "PartiallyCompleted"
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

                    if (completedCount > 0)
                    {
                        List<PatientInvestigation> pattasks = new List<PatientInvestigation>();
                        string STATUS = string.Empty;
                        STATUS = GetConfigValues("SampleStatusAllCompleted", OrgID);



                        /* 
                         * Created By : Gurunath S 
                         * Created At : 23-Apr-2013
                         * Purpose : Create Task based on Task Action mapping.
                         * --------------------Code Begins ----------------------*/
                        PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();
                        long TaskActionID = -1;
                        int VisitPurposeID = Convert.ToInt32(TaskHelper.VisitPurpose.LabInvestigation);
                        int OtherID = RoleID;
                        List<TaskActions> lstTaskActions = new List<TaskActions>();
                        objPatientVisit_BL.GetTaskActionID(OrgID, VisitPurposeID, RoleID, out lstTaskActions);
                        if (lstTaskActions.Count > 0)
                        {
                            if (lstTaskActions[0].TaskActionID > 0)
                            {
                                TaskActionID = lstTaskActions[0].TaskActionID;
                            }
                            else
                            {
                                TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.Approval);
                            }
                        }
                        else
                        {
                            TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.Approval);
                        }
                        /*-------------------------------Code Ends -----------------------------*/
                        if (!string.IsNullOrEmpty(STATUS) && STATUS == "Y")
                        {

                            //SampleStatusAllCompleted
                            string SampleID = string.Empty;
                            PatientDetail.GetSampleID(out SampleID);

                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskActionID),
                                         vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                         lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                         , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                         gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber, "");
                            task.TaskActionID = Convert.ToInt32(TaskActionID);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = vid;
                            task.PatientID = PatientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.RefernceID = LabNo;
                            //Create task 

                            if (Patinvestasks.Count > 0)
                            {

                                Patinvestasks.Select(e => new { e.AccessionNumber }).Distinct().ToList();

                                DemoBL.GetGrouplevelvalidation(vid, task.TaskActionID, Patinvestasks, OrgID, 0, out pattasks);

                            }
                            if (pattasks.Count > 0)
                            {
                                returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                                string display = string.Empty;
                            }
                        }
                        else
                        {
                            string SampleID = string.Empty;
                            PatientDetail.GetSampleID(out SampleID);
                            //task.StatusName = SampleID;

                            returncode = Utilities.GetHashTable(Convert.ToInt64(TaskActionID),
                                            vid, 0, PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                            lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                            , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                            gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber, SampleID);//added SampleID For waters approval task purpose
                            task.TaskActionID = Convert.ToInt32(TaskActionID);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = vid;
                            task.PatientID = PatientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            task.RefernceID = LabNo;
                            //Create task               
                            returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                            string display = string.Empty;

                        }
                        //returncode = new Investigation_BL(base.ContextInfo).GetWayToMethodKit(RoleID, OrgID, deptID, out display);
                    }
                    else
                    {
                        PatientInvestigation item = new PatientInvestigation();
                        item.PatientVisitID = vid;
                        item.UID = gUID;
                        item.LabNo = LabNo;
                        CreateTask(item, FilteredInvestigations);
                    }
                }

                int deptID = Convert.ToInt32(hdnDept.Value);
                string InvId = Request.QueryString["Invid"].ToString();// == ""? HDnInVID.Value : Request.QueryString["Invid"].ToString();
                string Pid = Request.QueryString["pid"].ToString();
                if (hdnDirectApproval.Value == "1")
                {
                    //IncludeMethodKit();

                    Response.Redirect("~/Lab/Home.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();


                }
                else
                {
                    if (hdnHeaderName.Value == "Imaging")
                    {
                        //Response.Redirect("~/Investigation/ViewInvestigationReport.aspx?vid=" + vid);

                        Response.Redirect("~/Investigation/InvReportsForDept.aspx?vid=" + vid + "&dID=" + deptID + "&ShwBtn=N" + "&gUID=" + gUID + "&Invid=" + InvId + "&pid=" + Pid);
                    }
                    else
                    {
                        Response.Redirect("~/Investigation/MethodKitCapture.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUID + "&Invid=" + InvId);
                        Response.Redirect("~/Investigation/InvReportsForApproval.aspx?vid=" + vid + "&dID=" + hdnDept.Value + "&gUID=" + gUID + "&Invid=" + InvId + "&pid=" + Pid + "&Result=" + "Y");
                        // Response.Redirect("~/Investigation/MethodKitCapture.aspx?vid=" + vid + "&dept=" + hdnHeaderName.Value + "&dID=" + hdnDept.Value + "&gUID=" + gUID + "&Invid=" + InvId + "&pid=" + Pid);
                    }
                }
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSave_Click Event", ex);
        }

    }
    public void CreateTask(PatientInvestigation item, List<PatientInvestigation> lstPatientInvestigation)
    {
        try
        {
            Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);
            List<OrderedInvestigations> _InvestigationList = new List<OrderedInvestigations>();
            List<OrderedInvestigations> _NonapprovedInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstCoauthorizeInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> lstSecondOpinionInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> SecondOpinionInvestigations = new List<OrderedInvestigations>();
            List<OrderedInvestigations> FilteredInvestigations = new List<OrderedInvestigations>();
            DemoBL.pGetpatientInvestigationForVisit(item.PatientVisitID, OrgID, ILocationID, item.UID, out _InvestigationList);

            int nonValidatedCount = 0;
            long returnCode = -1;

            /**Exclude VID Lock for Org to Org Transfered Tests ***/
            FilteredInvestigations = _InvestigationList.FindAll(P => P.ExcludeVIDlock == "N");

            nonValidatedCount = (from IL in FilteredInvestigations
                                 where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                 && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.PartiallyValidated && IL.Status != InvStatus.Cancel
                                 && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                  && IL.Status != "ReflexTest"
                                  && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive"
                                 select IL).Count();
            if (nonValidatedCount > 0)
            {
                List<SampleTracker> lstSampleTracker = new List<SampleTracker>();
                returnCode = DemoBL.GetSampleNotGiven(OrgID, item.PatientVisitID, out lstSampleTracker);
                if (lstSampleTracker.Count > 0)
                {
                    int validatedCount = 0;
                    validatedCount = (from IL in FilteredInvestigations
                                      where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                      && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.PartiallyValidated && IL.Status != InvStatus.Cancel
                                      && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                      && IL.Status != InvStatus.Notgiven && IL.Status != "ReflexTest" && IL.Status != "Not Given"
                                        && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive"
                                      select IL).Count();
                    if (validatedCount <= 0)
                    {
                        nonValidatedCount = 0;
                    }
                }
            }
            _NonapprovedInvestigations = (from IL in FilteredInvestigations
                                          where IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.OpinionGiven
                                           && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld && IL.Status != InvStatus.Cancel
                                            && IL.Status != "ReflexTest" && IL.Status != InvStatus.ReflexWithNewSample && IL.Status != InvStatus.ReflexWithSameSample
                                          select IL).Distinct().ToList();
            int nonAutoautherizedCount = 0;
            nonAutoautherizedCount = (from IL in FilteredInvestigations
                                      where (IL.Status == InvStatus.Validate || IL.Status == "PartiallyValidated") && IL.IsAutoAuthorize == "N"
                                      select IL).Count();
            returnCode = DemoBL.GetPatientInvestigationStatus(vid, Convert.ToInt32(hdnOrgID.Value), out lstPatientInvestigation3);
            AutoApproveQueueCount = (from IL in lstPatientInvestigation3
                                     where IL.IsAutoApproveQueue == "Y"
                                     select IL).Count();
            NormalApproveTestCount = (from IL in lstPatientInvestigation3
                                      where IL.AutoApproveLoginID == 0
                                      select IL).Count();
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);

            string TASKSTATUSs = string.Empty;
            TASKSTATUSs = "N";
            //STATUS = GetConfigValues("SampleStatusAllValidate", OrgID);
            TASKSTATUSs = GetConfigValues("DeptwiseLoginRole", OrgID);
            if (_NonapprovedInvestigations.Count == 0 && TASKSTATUSs != "Y")
            {
                oTasksBL.UpdateTaskForaVisit(item.PatientVisitID, OrgID, LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
            }
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();

            long createTaskID = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returncode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(item.PatientVisitID, out lstPatientVisitDetails);
            PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();

            int OtherID = RoleID;
            if (nonValidatedCount == 0)
            {
                if (nonAutoautherizedCount == 0)
                {
                    if (AutoApproveQueueCount > 0)
                    {
                        returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.AutoApproval),
                                       item.PatientVisitID, 0, lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                       lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                       , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                       gUID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber, "");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.AutoApproval);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = Convert.ToInt32(hdnOrgID.Value);
                        task.PatientVisitID = vid;
                        task.PatientID = item.PatientVisitID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = item.LabNo;
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
                            PC.PageID = Convert.ToInt64(PageContextDetails.PageID);
                            PC.ButtonName = PageContextDetails.ButtonName;
                            PC.ButtonValue = PageContextDetails.ButtonValue;
                            PC.ActionType = "";
                            lstpagecontextkeys.Add(PC);
                            long res = -1;
                            res = AM.PerformingNextStepNotification(PC, "", "");
                        }
                    }
                }
                else
                {
                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                 item.PatientVisitID, 0, lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " +
                                 lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                 , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0,
                                 item.UID, lstPatientVisitDetails[0].ExternalVisitID, lstPatientVisitDetails[0].VisitNumber, "");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = item.PatientVisitID;
                    task.PatientID = lstPatientVisitDetails[0].PatientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    task.RefernceID = item.LabNo;
                    //Create task               
                    returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                    string display = string.Empty;
                }
            }
            if (FilteredInvestigations.FindAll(P => P.Status == InvStatus.Completed).Count == 0)
            {
                List<Tasks> lstTasks = new List<Tasks>();
                oTasksBL.GetTaskByVisit(item.PatientVisitID, OrgID, Convert.ToInt32(TaskHelper.TaskAction.Approval), out lstTasks);
                foreach (Tasks oTasks in lstTasks)
                {
                    oTasksBL.UpdateTask(oTasks.TaskID, TaskHelper.TaskStatus.Completed, LID);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating task", ex);
        }
    }
    # region Load User Control
    public Control loadBioControl(PatientInvestigation lstInve)
    {
        Investigation_checkInvest bioPattern1;
        bioPattern1 = (Investigation_checkInvest)LoadControl(lstInve.PatternName);
        try
        {
            bioPattern1.POrgid = OrgID;
            bioPattern1.OrgID = OrgID;
            bioPattern1.RoleID = RoleID;
            bioPattern1.LID = LID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            long InvestigationID = lstInve.InvestigationID;
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            int groupID = lstInve.GroupID;
            // invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            bioPattern1.Name = lstInve.InvestigationName;
            bioPattern1.UOM = lstInve.UOMCode;
            //checkInvest.ID = Convert.ToString(lstInve.InvestigationID);

            bioPattern1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(",", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));  //Added by vijayalakshmi.m 
            //bioPattern1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID);
            bioPattern1.ControlID = Convert.ToString(lstInve.InvestigationID);
            bioPattern1.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            bioPattern1.GroupID = lstInve.GroupID;
            bioPattern1.GroupName = lstInve.GroupName;
            bioPattern1.PackageID = lstInve.PackageID;
            bioPattern1.PackageName = lstInve.PackageName;
            bioPattern1.CurrentRoleName = RoleName;
            bioPattern1.LabTechEditMedRem = strLabTechToEditMedRem;
            bioPattern1.DecimalPlaces = lstInve.DecimalPlaces;
            bioPattern1.ResultValueType = lstInve.ResultValueType;
            bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstInve.AutoApproveLoginID);
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            bioPattern1.TestStatus = lstInve.TestStatus;

            bioPattern1.QCData = lstInve.QCData;
            //Delta
            bioPattern1.Isdeltastatus = lstInve.IsDeltaStatus;
            bioPattern1.IsDeltaCheck = lstInve.IsDeltaCheck;
            bioPattern1.DeltaLowerLimit = lstInve.DeltaLowerLimit;
            bioPattern1.DeltaHigherLimit = lstInve.DeltaHigherLimit;
            bioPattern1.DeltaDetails = lstInve.IsAutoAbnormalResult;
            bioPattern1.IsAutoCertification = lstInve.IsAutoCertification;
            bioPattern1.PatientVisitID = vid;
            bioPattern1.PatternID = (lstInve.PatternID);
            bioPattern1.POrgid = Convert.ToInt32(hdnOrgID.Value);
            bioPattern1.CurrentRoleName = RoleName.Trim();
            bioPattern1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            bioPattern1.AccessionNumber = lstInve.AccessionNumber;
            bioPattern1.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            bioPattern1.IsAutoApproveQueue = lstInve.IsAutoApproveQueue;
            bioPattern1.IsAutoValidate = lstInve.IsAutoValidate;
            bioPattern1.DecimalPlaces = lstInve.DecimalPlaces;
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstim[0].AutoApproveLoginID);
            }
            //string ClientID = ((TextBox)bioPattern1.FindControl("txtValue")).ClientID;
            TextBox txtValue = (TextBox)bioPattern1.FindControl("txtValue");
            HiddenField hdnResultValue = (HiddenField)bioPattern1.FindControl("hdnResultValue");
            if (!string.IsNullOrEmpty(lstInve.Status))
            {
                if (lstInve.Status == "SampleLoaded")
                {
                    txtValue.ReadOnly = true;
                }
                else
                {
                    txtValue.ReadOnly = false;
                }
            }
            string ClientID = txtValue.ClientID;
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            if (!hGroupFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hGroupFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }
            if (!hInvestigationFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hInvestigationFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }
            //System.Collections.Specialized.StringDictionary hFormulaCollection =  new System.Collections.Specialized.StringDictionary();
            long ReturnRes;
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
                        txtValue.Attributes.Add("style", "background-color:#FABF8F");
                        FormulaINV = FormulaINV + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "');}";
                        bioPattern1.ShowComputationFieldEditOption = true;
                    }
                    FormulaINV = FormulaINV.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                    FormulaINV = FormulaINV.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                }
                hIFormulaCollection[lstInve.InvestigationID] = FormulaINV;
            }
            bioPattern1.setXmlValues(lstInve.ReferenceRange);
            HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
            bool isFormulaDependent = false;
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
                        isFormulaDependent = true;
                        txtValue.Attributes.Add("style", "background-color:#FABF8F");

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
                            FormulaINV = FormulaINV + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                        }
                        else
                        {
                            FormulaINV = FormulaINV + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                        }
                        bioPattern1.ShowComputationFieldEditOption = true;
                    }

                    FormulaINV = FormulaINV.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                    FormulaINV = FormulaINV.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                }
                hIFormulaCollection[lstInve.InvestigationID] = FormulaINV;

            }

            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + bioPattern1.ID + "_ddlstatus";
            //}
            //code added for reference range - begin
            string ReferenceRange;
            string[] ConvReferenceRange;
            string ConReferenceRange = string.Empty;
            string GenderType = string.Empty;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);

                if (ReferenceRange != null)
                {
                    bioPattern1.RefRange = ReferenceRange.Trim().Replace("<br>", "\n"); // <90
                }
                if (OtherReferenceRange != null)
                {
                    ConReferenceRange = OtherReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    bioPattern1.PrintableRange = PrintableRange;
                }
                bioPattern1.setXmlValues(lstInve.ReferenceRange);
                if (!String.IsNullOrEmpty(bioPattern1.DeviceID))
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
                    //bioPattern1.RefRange = lstInve.ReferenceRange;
                    bioPattern1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");

                    // bioPattern1.setXmlValues(lstInve.ReferenceRange);
                }
                if (lstInve.ConvReferenceRange == null)
                {
                    ConReferenceRange = "";

                }
                else
                {
                    ConReferenceRange = lstInve.ConvReferenceRange.Trim().Replace("<br>", "\n");
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    bioPattern1.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    bioPattern1.PrintableRange = string.Empty;
                }
            }
            bioPattern1.ConvUOMCode = lstInve.CONV_UOMCode;
            bioPattern1.ConvFactorvalue = lstInve.CONV_Factor;
            bioPattern1.CONVFactorDecimalPt = lstInve.CONVFactorDecimalPt;

            //code added for reference range - end
            //bioPattern1.RefRange = lstInve.ReferenceRange; // "MALE:0 – 20 mm/hr FEMALE :0 – 30 mm/hr";
            bioPattern1.Text = lstInve.Value;
            //checkInvest.setAttributes(Convert.ToString(checkInvest.ID));
            lstControl.Add(bioPattern1.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingval != null && lstPendingval.Count > 0)
            {
                bioPattern1.LoadDataForEdit(lstPendingval);
                var lstim = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
                bioPattern1.DeviceErrorCode = lstim[0].DeviceErrorCode;

            }
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                bioPattern1.setXmlValues(lstim[0].ReferenceRange);
                bioPattern1.BatchWise(false);
                //if (InvestigationID == 3123)
                //{

                if (lstim[0].ReferenceRange != null && LabUtil.TryParseXml(lstim[0].ReferenceRange))
                {
                    CLogger.LogWarning(lstim[0].ReferenceRange + InvestigationID.ToString());
                    ConvertXmlToString(lstim[0].ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);

                    if (OtherReferenceRange != null)
                    {
                        ConReferenceRange = OtherReferenceRange;
                    }
                    if (!string.IsNullOrEmpty(PrintableRange))
                    {
                        bioPattern1.PrintableRange = PrintableRange;
                    }
                    CLogger.LogWarning("OtherRef" + OtherReferenceRange);
                }
                //   }
                if (!String.IsNullOrEmpty(bioPattern1.DeviceID))
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
                if (isFormulaDependent)
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

                            if (ConvReferenceRange.Count() > 1)
                            {
                                double pOut = 0;
                                bool isNumber = Double.TryParse(ConvReferenceRange[1], out pOut);
                                if (isNumber)
                                {
                                    ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[1]) * lstInve.CONV_Factor), lstInve.CONVFactorDecimalPt));
                                }
                            }
                            else
                            {
                                double pOut = 0;
                                bool isNumber = Double.TryParse(ConvReferenceRange[0], out pOut);
                                if (isNumber)
                                {
                                    ConReferenceRange = Convert.ToString(Math.Round((Convert.ToDecimal(ConvReferenceRange[0]) * lstInve.CONV_Factor), lstInve.CONVFactorDecimalPt));
                                }
                            }

                            if (ConReferenceRange != "0")
                            {
                                ConReferenceRange = RefRangeSymbol + " " + ConReferenceRange;
                            }
                        }
                    }
                }
            }

            bioPattern1.ConReferenceRange = ConReferenceRange;
            //HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
            //bool isFormulaDependent = false;
            if (!string.IsNullOrEmpty(lstInve.ValidationText))
            {
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
                        HiddenField hdnPanicXmlContent = (HiddenField)bioPattern1.FindControl("hdnPanicXmlContent");
                        TextBox txtIsAbnormal = (TextBox)bioPattern1.FindControl("txtIsAbnormal");
                        Label lblName = (Label)bioPattern1.FindControl("lblName");
                        Label lblUnit = (Label)bioPattern1.FindControl("lblUnit");

                        txtValue.Attributes.Add("style", "background-color:#FABF8F");

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
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','','');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                            else
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                        }
                        else
                        {
                            if (isInterpretationRange)
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','','');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                            }
                            else
                            {
                                Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
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
                            if ((lstPendingValue.Count > 0 && !String.IsNullOrEmpty(lstPendingValue[0].Value)))
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "SRV" + bioPattern1.TxtControlID, "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID + "');", true);
                            }
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + hdnResultValue.ClientID + "').value");
                        }
                        else
                        {
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                        }
                    }
                    if (!hFormulaInvCollectionSet.Contains(lstInve.GroupID))//syed
                    {
                        ReturnRes = objInvBL.GetInvComputationRuleByGroup(OrgID, lstInve.GroupID, out lstInvOrgGroup);
                        hFormulaInvCollectionSet.Add(lstInve.GroupID, lstInvOrgGroup[0].ValidationRule);

                    }
                    bioPattern1.Formula = lstInvOrgGroup[0].ValidationRule;
                }
                hFormulaCollection[lstInve.GroupID] = Formula;
            }
            bioPattern1.BatchWise(false);
            // Below line is to display the abnormal in pending or reopening
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    bioPattern1.IsAbnormal = lstInve.IsAbnormal;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + bioPattern1.TxtControlID, "LoadAbnormalValue('" + bioPattern1.TxtControlID + "','','" + lstInve.IsAbnormal + "','" + bioPattern1.TestName + "','" + bioPattern1.TestUnit + "','" + bioPattern1.IsAutoAuthorize + "');", true);
                }
                if (lstInve.IsSensitive != null && (lstInve.IsSensitive == "Y"))
                {
                    bioPattern1.IsSensitive = lstInve.IsSensitive;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadSensitiveValue" + bioPattern1.TxtControlID, "LoadSensitiveValue('" + bioPattern1.TxtControlID + "','','" + lstInve.IsSensitive + "','" + bioPattern1.TestName + "','" + bioPattern1.TestUnit + "');", true);
                }
            }
            catch (Exception e)
            {
            }
            bioPattern1.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));
            try
            {
                DropDownList ddlstatus = (DropDownList)bioPattern1.FindControl("ddlstatus");
                if (txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    //Added by Vijayalakshmi.m 
                    //Issue: Abnormal value not highlighting for history Capturing 
                    if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                    {
                        hdnlstNotYetResolvedRRParams.Value = bioPattern1.ValidateResultParameter;
                    }
                    else if (!hdnlstNotYetResolvedRRParams.Value.Contains(bioPattern1.ValidateResultParameter))
                    {
                        hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + bioPattern1.ValidateResultParameter;
                    }
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "CallAllReferenceRangeValidate", "CallAllReferenceRangeValidate();", true);
                    //END
                    if (lstInve.GroupID == 0 && !isFormulaDependent && !string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && !String.IsNullOrEmpty(bioPattern1.DeviceID) && String.IsNullOrEmpty(lstInve.TestStatus) && (bioPattern1.IsAbnormal == "" || bioPattern1.IsAbnormal == "N"))
                    {
                        string Status = GetConfigValues("IsStatusPending/Validate", OrgID);
                        if (Status == "Y")
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Pending"));
                            ddlstatus.SelectedIndex = index;
                        }
                        else
                        {
                            //ddlstatus.Items.Add(new ListItem("Validate", "Validate_10"));
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                            ddlstatus.SelectedIndex = index;
                        }
                    }
                    else
                    {
                        if (lstInve.IsAutoValidate == "Y")
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                            ddlstatus.SelectedIndex = index;
                        }
                        //else
                        //{
                        //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        //    ddlstatus.SelectedIndex = index;
                        //}
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        /* This block was commented for not select Complete At already Completed test*/
                        //else
                        //{
                        //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        //    ddlstatus.SelectedIndex = index;
                        //}
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    }
                }
                /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                //if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)  //old code
                if (lstInve.Status == InvStatus.Approved)
                {
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    //DisableUserControl(bioPattern1, false);
                    HtmlTable tblBioContent = (HtmlTable)bioPattern1.FindControl("tblBioContent");
                    //bioPattern1.IsStatusCompleted = "Y";
                    //tblBioContent.Attributes.Add("style", "display:none");
                    //tblBioContent.Style = true;
                    //DropDownList ddlstatus = (DropDownList)bioPattern1.FindControl("ddlstatus");
                    ddlstatus.Visible = false;
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    INVHideStatus = new PatientInvestigation();
                    INVHideStatus.InvestigationID = lstInve.InvestigationID;
                    LstINVHideStatus.Add(INVHideStatus);
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
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

                    //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                    if (ddlstatus.Items.FindByValue("Completed_2") != null)
                    {
                        ddlstatus.SelectedValue = "Completed_2";
                    }
                }
            }
            catch (Exception e)
            {
            }
            bioPattern1.setNonEditable(lstInve);
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

        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int groupID = lstInve.GroupID;

        try
        {
            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

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
            Micro.AccessionNumber = lstInve.AccessionNumber;
            //Micro.setAttributes(Convert.ToString(Micro.ID));
            lstControl.Add(Micro.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
        int GroupID = lstInve.GroupID;
        Investigation_FishPattern1 FishPt;
        FishPt = (Investigation_FishPattern1)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
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
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.UOM = lstInve.UOMCode;
            lstControl.Add(FishPt.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            FishPt.IsAutoValidate = lstInve.IsAutoValidate;
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            long ReturnRes;
            TextBox txtValue = (TextBox)FishPt.FindControl("txtValue");
            HiddenField hdnResultValue = (HiddenField)FishPt.FindControl("hdnResultValue");
            string ClientID = txtValue.ClientID;
            //common validate added by prabakar
            // if (lstInve.ReferenceRange.Contains("domain") || lstInve.IsAllowNull.ToUpper() != "Y")
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            // common validate
            if (!hGroupFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hGroupFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }
            if (!hInvestigationFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hInvestigationFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }
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
                        txtValue.Attributes.Add("style", "background-color:#FABF8F");
                        if (lstInve.ResultValueType == "NTS")
                        {
                            Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + FishPt.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                        }
                        else
                        {
                            Formula = Formula + "if(document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + FishPt.DecimalPlaces + "');}";
                        }
                        FishPt.ShowComputationFieldEditOption = true;
                        hdnComputationFieldList.Value = hdnComputationFieldList.Value + ClientID + "^";
                        Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                        Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                    }
                    else
                    {
                        Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                        if (lstInve.ResultValueType == "NTS")
                        {
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + hdnResultValue.ClientID + "').value");
                        }
                        else
                        {
                            Formula = Formula.Replace("[" + lstInve.InvestigationID + "]", "document.getElementById('" + ClientID + "').value");
                        }
                    }
                    if (!hFormulaInvCollectionSet.Contains(lstInve.GroupID))//syed
                    {
                        ReturnRes = objInvBL.GetInvComputationRuleByGroup(OrgID, lstInve.GroupID, out lstInvOrgGroup);
                        hFormulaInvCollectionSet.Add(lstInve.GroupID, lstInvOrgGroup[0].ValidationRule);

                    }
                    FishPt.Formula = lstInvOrgGroup[0].ValidationRule;
                }
                hFormulaCollection[lstInve.GroupID] = Formula;

                //if (Session["formula"] != null)
                //{
                //    Formula = Session["formula"].ToString();
                //}
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + FishPt.ID + "_ddlstatus";
            //}
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));

            }
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                FishPt.LoadDataForComments(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            //FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID==groupID ));

            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID));
            FishPt.BatchWise(false);
            try
            {
                DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                if (txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    if (lstInve.IsAutoValidate == "Y")
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    /* This block was commented for not select Complete At already Completed test*/
                    //else
                    //{
                    //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                    //    ddlstatus.SelectedIndex = index;
                    //}
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                }
                //ABC
                if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
                {

                    //DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                    ddlstatus.Visible = false;
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    INVHideStatus = new PatientInvestigation();
                    INVHideStatus.InvestigationID = lstInve.InvestigationID;
                    LstINVHideStatus.Add(INVHideStatus);
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    TextBox txtValue1 = (TextBox)FishPt.FindControl("txtValue");
                    txtValue1.ReadOnly = true;
                    TextBox txtMedRemarks = (TextBox)FishPt.FindControl("txtMedRemarks");
                    txtMedRemarks.Enabled = false;

                    //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                    if (ddlstatus.Items.FindByValue("Completed_2") != null)
                    {
                        ddlstatus.SelectedValue = "Completed_2";
                    }
                }
            }
            catch (Exception e)
            {
            }
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
        int GroupID = lstInve.GroupID;
        Investigation_Fishpattern2 FishPt;
        FishPt = (Investigation_Fishpattern2)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
            FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishPt.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            FishPt.Name = lstInve.InvestigationName;
            FishPt.GroupID = lstInve.GroupID;
            FishPt.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            lstControl.Add(FishPt.ID);
            FishPt.PatientVisitID = vid;
            FishPt.PatternID = (lstInve.PatternID);
            FishPt.POrgid = Convert.ToInt32(hdnOrgID.Value);
            FishPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.UOM = lstInve.UOMCode;
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            FishPt.IsAutoValidate = lstInve.IsAutoValidate;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + FishPt.ID + "_ddlstatus";
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
            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == GroupID));
            //FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            FishPt.MedicalRemarks = lstInve.MedicalRemarks;
            TextBox txtValue = (TextBox)FishPt.FindControl("txtValue");
            try
            {
                if (txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                    if (lstInve.IsAutoValidate == "Y")
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    /* This block was commented for not select Complete At already Completed test*/
                    //else
                    //{
                    //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                    //    ddlstatus.SelectedIndex = index;
                    //}
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                }
                //ABC
                if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
                {

                    DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                    ddlstatus.Visible = false;
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    INVHideStatus = new PatientInvestigation();
                    INVHideStatus.InvestigationID = lstInve.InvestigationID;
                    LstINVHideStatus.Add(INVHideStatus);
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    TextBox lblName = (TextBox)FishPt.FindControl("txtCode");
                    lblName.Enabled = false;
                    TextBox txtValue1 = (TextBox)FishPt.FindControl("txtValue");
                    txtValue1.ReadOnly = true;
                    TextBox txtMedRemarks = (TextBox)FishPt.FindControl("txtMedRemarks");
                    txtMedRemarks.Enabled = false;

                    //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                    if (ddlstatus.Items.FindByValue("Completed_2") != null)
                    {
                        ddlstatus.SelectedValue = "Completed_2";
                    }
                }
            }

            catch (Exception e)
            {
            }
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
            Multiadd.GroupID = lstInve.GroupID;
            Multiadd.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");

            Multiadd.AccessionNumber = lstInve.AccessionNumber;
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
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
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
            CLogger.LogError("Error in LoadResultsBRCA ", ex);
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
            BRCA1.ID = (Convert.ToString(lstInve1.InvestigationID) + "~" + lstInve1.GroupName.Replace(":", "").Replace(":", "") + "~" + lstInve1.GroupID + "~" + lstInve1.RootGroupID + "~" + lstInve1.PackageID + "~" + Convert.ToString(lstInve1.AccessionNumber));
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
            MicroBio1.ID = (Convert.ToString(lstInve1.InvestigationID) + "~" + lstInve1_GroupName.Replace(":", "").Replace(":", "") + "~" + lstInve1.GroupID + "~" + lstInve1.RootGroupID + "~" + lstInve1.PackageID + "~" + Convert.ToString(lstInve1.AccessionNumber));
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
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve1.GroupID + "^" + lstInve1.DeptName + "|" + lstInve1_GroupName.Replace(":", "").Replace(":", "") + "|" + MicroBio1.ID + "_ddlstatus";
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
            lstControl.Add(Img.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Img.ID + "_ddlstatus";
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
    //public Control LoadPDFPattern(PatientInvestigation lstInve)
    //{
    //    long InvestigationID = lstInve.InvestigationID;
    //    Investigation_PDFUploadpattern Img;
    //    Img = (Investigation_PDFUploadpattern)LoadControl(lstInve.PatternName);
    //    int groupID = lstInve.GroupID;

    //    try
    //    {
    //        Img.ShowImagePattern();
    //        Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Img.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        Img.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        Img.Name = lstInve.InvestigationName;
    //        Img.GroupID = lstInve.GroupID;
    //        Img.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : ""); ;
    //        Img.VisitID = lstInve.PatientVisitID;
    //        Img.PatientID = lstInve.PatientID;
    //        Img.AccessionNumber = lstInve.AccessionNumber;
    //        Img.UID = lstInve.UID;
    //        Img.Age = lstInve.Age;
    //        Img.Sex = lstInve.Sex;
    //        Img.PatientName = lstInve.Name;
    //        Img.VisitNumber = lstInve.VisitNumber;
    //        Img.LabNo = lstInve.LabNo;
    //        Img.POrgid = OrgID;
    //        Img.PatientVisitID = lstInve.PatientVisitID;
    //        Img.PatternID = lstInve.PatternID;
    //        Img.TestStatus = lstInve.TestStatus;
    //        lstControl.Add(Img.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Img.ID + "_ddlstatus";
    //        //}
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
    //        {
    //            Img.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in LoadPDFUploadpattern ", ex);
    //    }
    //    return Img;
    //}
    public Control LoadBioPattern2(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern2 Bio1;
        Bio1 = (Investigation_BioPattern2)LoadControl(lstInve.PatternName);

        Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int groupID = lstInve.GroupID;

        try
        {
            Bio1.POrgid = OrgID;
            Bio1.OrgID = OrgID;
            Bio1.RoleID = RoleID;
            Bio1.LID = LID;
            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

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
            //Bio1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID);
            Bio1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
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

            Bio1.QCData = lstInve.QCData;
            //Delta
            Bio1.PatientVisitID = vid;
            Bio1.PatternID = (lstInve.PatternID);
            Bio1.POrgid = Convert.ToInt32(hdnOrgID.Value);
            Bio1.CurrentRoleName = RoleName.Trim();
            Bio1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio1.IsAbnormal = lstInve.IsAbnormal;
            Bio1.AccessionNumber = lstInve.AccessionNumber;
            Bio1.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio1.IsAutoApproveQueue = lstInve.IsAutoApproveQueue;
            Bio1.IsAutoValidate = lstInve.IsAutoValidate;
            Bio1.DecimalPlaces = lstInve.DecimalPlaces;
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
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    Bio1.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    Bio1.PrintableRange = PrintableRange;
                }
                Bio1.setXmlValues(lstInve.ReferenceRange);
                if (!String.IsNullOrEmpty(Bio1.DeviceID))
                {
                    if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                    {
                        hdnlstNotYetResolvedRRParams.Value = Bio1.ValidateResultParameter;
                    }
                    else if (!hdnlstNotYetResolvedRRParams.Value.Contains(Bio1.ValidateResultParameter))
                    {
                        hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + Bio1.ValidateResultParameter;
                    }
                }
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    Bio1.RefRange = "";
                    Bio1.setXmlValues("");
                }
                else
                {
                    //Bio1.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        Bio1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    // Bio1.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    Bio1.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    Bio1.PrintableRange = string.Empty;
                }
            }

            //code added for reference range - end
            //Bio1.RefRange = lstInve.ReferenceRange;
            //Bio1.setAttributes(Convert.ToString(Bio1.ID));
            lstControl.Add(Bio1.ID);

            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                Bio1.setXmlValues(lstim[0].ReferenceRange);
                if (!String.IsNullOrEmpty(Bio1.DeviceID))
                {
                    if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                    {
                        hdnlstNotYetResolvedRRParams.Value = Bio1.ValidateResultParameter;
                    }
                    else if (!hdnlstNotYetResolvedRRParams.Value.Contains(Bio1.ValidateResultParameter))
                    {
                        hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + Bio1.ValidateResultParameter;
                    }
                }
            }
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Bio1.ID + "_ddlstatus";
            //}
            Bio1.BatchWise(false);
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    Bio1.IsAbnormal = lstInve.IsAbnormal;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio1.TxtControlID, "LoadAbnormalValue('" + Bio1.TxtControlID + "','" + Bio1.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio1.TestName + "','" + Bio1.TestUnit + "','" + Bio1.IsAutoAuthorize + "');", true);
                }
            }
            catch (Exception e)
            {
            }
            try
            {
                if (lstInve.IsSensitive != null && (lstInve.IsSensitive == "Y"))
                {
                    Bio1.IsSensitive = lstInve.IsSensitive;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadSensitiveValue" + Bio1.TxtControlID, "LoadSensitiveValue('" + Bio1.TxtControlID + "','','" + lstInve.IsSensitive + "','" + Bio1.TestName + "','" + Bio1.TestUnit + "');", true);
                }

                DropDownList ddlstatus = (DropDownList)Bio1.FindControl("ddlstatus");
                if (!string.IsNullOrEmpty(lstPendingValue[0].Value))
                {
                    HiddenField hdnXmlContent = (HiddenField)Bio1.FindControl("hdnXmlContent");

                    if (lstInve.GroupID == 0 && !string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && !String.IsNullOrEmpty(Bio1.DeviceID) && String.IsNullOrEmpty(lstInve.TestStatus) && (Bio1.IsAbnormal == "" || Bio1.IsAbnormal == "N"))
                    {
                        //ddlstatus.Items.Add(new ListItem("Validate", "Validate_10"));
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    else
                    {
                        if (lstInve.IsAutoValidate == "Y")
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                            ddlstatus.SelectedIndex = index;
                        }
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        /* This block was commented for not select Complete At already Completed test*/
                        //else
                        //{
                        //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        //    ddlstatus.SelectedIndex = index;
                        //}
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    }
                }
                //ABC
                if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
                {
                    //DisableUserControl(bioPattern1, false);
                    //HtmlTable tblBioContent = (HtmlTable)Bio1.FindControl("tblBioContent");
                    //Bio1.IsStatusCompleted = "Y";
                    //tblBioContent.Attributes.Add("style", "display:none");

                    //tblBioContent.Style = true;
                    //DropDownList ddlstatus = (DropDownList)Bio1.FindControl("ddlstatus");
                    ddlstatus.Visible = false;
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    INVHideStatus = new PatientInvestigation();
                    INVHideStatus.InvestigationID = lstInve.InvestigationID;
                    LstINVHideStatus.Add(INVHideStatus);
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
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
                    //HtmlAnchor ABetaTag = (HtmlAnchor)Bio1.FindControl("ABetaTag");
                    //ABetaTag.Visible = false;
                    //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                    if (ddlstatus.Items.FindByValue("Completed_2") != null)
                    {
                        ddlstatus.SelectedValue = "Completed_2";
                    }
                }
            }
            catch (Exception e)
            {
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

        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        int groupID = lstInve.GroupID;

        try
        {
            GTTContent.POrgid = OrgID;
            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            GTTContent.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Label lblSex = (Label)patientHeader.FindControl("lblSEX");
            //if (lblSex.Text == "Male")
            //   Bio1.Show("M");
            //else
            //    Bio1.Show("F");
            GTTContent.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            List<InvestigationValues> tmpDemoBulk = new List<InvestigationValues>();
            tmpDemoBulk = DemoBulk.FindAll(p => p.InvestigationID == InvestigationID).FindAll(p => p.Name == "Type");
            if (tmpDemoBulk.Count > 0)
            {
                GTTContent.PatternType(tmpDemoBulk[0].Value);
            }
            List<InvestigationValues> TimeBulk = new List<InvestigationValues>();
            TimeBulk = DemoBulk.FindAll(p => p.InvestigationID == InvestigationID).FindAll(p => p.Name == "Time");

            //CLogger.LogWarning("~+ " + tmpDemoBulk.Count.ToString());
            if (TimeBulk.Count > 0)
            {
                GTTContent.Time = TimeBulk[0].Value;
            }
            List<InvestigationValues> InvTypeBulk = new List<InvestigationValues>();
            InvTypeBulk = DemoBulk.FindAll(p => p.InvestigationID == InvestigationID).FindAll(p => p.Name == "InvType");
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
            //Delta
            GTTContent.PatientVisitID = vid;
            GTTContent.PatternID = (lstInve.PatternID);
            GTTContent.POrgid = Convert.ToInt32(hdnOrgID.Value);
            GTTContent.CurrentRoleName = RoleName.Trim();
            //GTTContent.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            GTTContent.SequenceNo = lstInve.SequenceNo;
            GTTContent.IsAbnormal = lstInve.IsAbnormal;
            GTTContent.AccessionNumber = lstInve.AccessionNumber;
            GTTContent.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            GTTContent.LabNo = lstInve.LabNo;
            GTTContent.UID = lstInve.UID;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    GTTContent.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    GTTContent.PrintableRange = PrintableRange;
                }
                GTTContent.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    GTTContent.RefRange = "";
                    GTTContent.setXmlValues("");
                }
                else
                {
                    //Bio1.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        GTTContent.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    // Bio1.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    GTTContent.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    GTTContent.PrintableRange = string.Empty;
                }
            }

            //code added for reference range - end
            //Bio1.RefRange = lstInve.ReferenceRange;
            //Bio1.setAttributes(Convert.ToString(Bio1.ID));
            lstControl.Add(GTTContent.ID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                GTTContent.setValues(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));


            }
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                GTTContent.setXmlValues(lstim[0].ReferenceRange);
            }
            //if (lstiom.Count > 0)
            //{
            //    GTTContent.setXmlValues(lstiom[0].ReferenceRange);
            //}
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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

        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
        int groupID = lstInve.GroupID;

        try
        {
            Bio.POrgid = OrgID;
            Bio.OrgID = OrgID;
            Bio.RoleID = RoleID;
            Bio.LID = LID;
            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Bio.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Bio.Name = lstInve.InvestigationName;
            //Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID);
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio.GroupID = lstInve.GroupID;
            Bio.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Bio.PackageID = lstInve.PackageID;
            Bio.PackageName = lstInve.PackageName;
            Bio.CurrentRoleName = RoleName;
            Bio.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio.PatientVisitID = vid;
            Bio.PatternID = (lstInve.PatternID);
            Bio.POrgid = Convert.ToInt32(hdnOrgID.Value);
            Bio.CurrentRoleName = RoleName.Trim();
            Bio.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio.IsAbnormal = lstInve.IsAbnormal;
            Bio.AccessionNumber = lstInve.AccessionNumber;
            Bio.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            Bio.BatchWise(false);
            Bio.TestStatus = lstInve.TestStatus;

            Bio.QCData = lstInve.QCData;

            Bio.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio.IsAutoApproveQueue = lstInve.IsAutoApproveQueue;
            Bio.IsAutoValidate = lstInve.IsAutoValidate;
            Bio.BatchWise(false);
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                List<InvestigationValues> lstValues = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
                if (lstValues != null && lstValues.Count > 0)
                {
                    Bio.LoadDataForEdit(lstValues);

                    if (!String.IsNullOrEmpty(lstValues[0].Value))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), Bio.DDLClientID, "setDropdownValues('" + Bio.DDLClientID + "','" + Bio.hdnDDLClientID + "','" + lstValues[0].Value + "');", true);
                    }
                }
            }
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    Bio.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    Bio.PrintableRange = PrintableRange;
                }
                Bio.setXmlValues(lstInve.ReferenceRange);
                if (!String.IsNullOrEmpty(Bio.DeviceID))
                {
                    if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                    {
                        hdnlstNotYetResolvedRRParams.Value = Bio.ValidateResultParameter;
                    }
                    else if (!hdnlstNotYetResolvedRRParams.Value.Contains(Bio.ValidateResultParameter))
                    {
                        hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + Bio.ValidateResultParameter;
                    }
                }
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    Bio.RefRange = "";
                    Bio.setXmlValues("");
                }
                else
                {
                    //Bio.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        Bio.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    //Bio.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    Bio.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    Bio.PrintableRange = string.Empty;
                }
            }

            //code added for reference range - end
            //Bio.RefRange = lstInve.ReferenceRange;
            Bio.UOM = lstInve.UOMCode;
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            //if (lstiom.Count > 0)
            //{
            //    Bio.setXmlValues(lstiom[0].ReferenceRange);
            //}
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                Bio.setXmlValues(lstim[0].ReferenceRange);
                if (!String.IsNullOrEmpty(Bio.DeviceID))
                {
                    if (String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
                    {
                        hdnlstNotYetResolvedRRParams.Value = Bio.ValidateResultParameter;
                    }
                    else if (!hdnlstNotYetResolvedRRParams.Value.Contains(Bio.ValidateResultParameter))
                    {
                        hdnlstNotYetResolvedRRParams.Value = hdnlstNotYetResolvedRRParams.Value + "^" + Bio.ValidateResultParameter;
                    }
                }
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Bio.ID + "_ddlstatus";
            //}

            if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
            {
                Bio.IsAbnormal = lstInve.IsAbnormal;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio.DDLClientID, "LoadAbnormalValue('','" + Bio.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio.TestName + "','" + Bio.TestUnit + "','" + Bio.IsAutoAuthorize + "');", true);
            }
            try
            {
                if (lstInve.IsSensitive != null && (lstInve.IsSensitive == "Y"))
                {
                    Bio.IsSensitive = lstInve.IsSensitive;

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadSensitiveValue" + Bio.DDLClientID, "LoadSensitiveValue('" + Bio.DDLClientID + "','','" + lstInve.IsSensitive + "','" + Bio.TestName + "','" + Bio.TestUnit + "');", true);
                }
                DropDownList ddlstatus = (DropDownList)Bio.FindControl("ddlstatus");
                if (!string.IsNullOrEmpty(lstPendingValue[0].Value))
                {
                    HiddenField hdnXmlContent = (HiddenField)Bio.FindControl("hdnXmlContent");

                    if (lstInve.GroupID == 0 && !string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && !String.IsNullOrEmpty(Bio.DeviceID) && String.IsNullOrEmpty(lstInve.TestStatus) && (Bio.IsAbnormal == "" || Bio.IsAbnormal == "N"))
                    {
                        //ddlstatus.Items.Add(new ListItem("Validate", "Validate_10"));
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    else
                    {
                        if (lstInve.IsAutoValidate == "Y")
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                            ddlstatus.SelectedIndex = index;
                        }
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        /* This block was commented for not select Complete At already Completed test*/
                        //else
                        //{
                        //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        //    ddlstatus.SelectedIndex = index;
                        //}
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
       
                    }
                }
                //ABC
                if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
                {
                    //DisableUserControl(bioPattern1, false);
                    //HtmlTable tblBioContent = (HtmlTable)Bio1.FindControl("tblBioContent");
                    //Bio.IsStatusCompleted = "Y";
                    //tblBioContent.Attributes.Add("style", "display:none");

                    //tblBioContent.Style = true;
                    //DropDownList ddlstatus = (DropDownList)Bio.FindControl("ddlstatus");
                    ddlstatus.Visible = false;
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
                    INVHideStatus = new PatientInvestigation();
                    INVHideStatus.InvestigationID = lstInve.InvestigationID;
                    LstINVHideStatus.Add(INVHideStatus);
                    //**************Added By Arivalagan.kk for getting hide status InvId***************//
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
                    //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                    if (ddlstatus.Items.FindByValue("Completed_2") != null)
                    {
                        ddlstatus.SelectedValue = "Completed_2";
                    }
                }
            }
            catch (Exception e)
            {
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
        int groupID = lstInve.GroupID;

        try
        {
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

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

            Bio.QCData = lstInve.QCData;

            Bio.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio.IsAutoApproveQueue = lstInve.IsAutoApproveQueue;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            Bio.AccessionNumber = lstInve.AccessionNumber;
            Bio.IsAutoValidate = lstInve.IsAutoValidate;
            Bio.DecimalPlaces = lstInve.DecimalPlaces;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    Bio.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    Bio.PrintableRange = PrintableRange;
                }
                Bio.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    Bio.RefRange = "";
                    Bio.setXmlValues("");
                }
                else
                {
                    //Bio.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        Bio.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    //Bio.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    Bio.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    Bio.PrintableRange = string.Empty;
                }
            }
            //if (lstiom.Count > 0)
            //{
            //    Bio.setXmlValues(lstiom[0].ReferenceRange);
            //}
            if (lstiom.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                var lstim = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
                Bio.setXmlValues(lstim[0].ReferenceRange);
            }
            //code added for reference range - ends
            //Bio.RefRange = lstInve.ReferenceRange;
            //Bio.setAttributes(Convert.ToString(Bio.ID));
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
        int groupID = lstInve.GroupID;
        // groupID,
        try
        {
            //  Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            Bio.ShowGTT();
            //Bio.ID = Convert.ToString(lstInve.InvestigationID);
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            //Bio.GroupID = lstInve.GroupID;
            //Bio.GroupName = lstInve.GroupName;
            //Bio.RefRange = lstInve.ReferenceRange;
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Bio.ID + "_ddlstatus";
            //}
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
    //        long InvestigationID = lstInve.InvestigationID;
    //        Hemat.POrgid = OrgID;
    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        int groupID = lstInve.GroupID;


    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        Hemat.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));//Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.GroupID = lstInve.GroupID;
    //        Hemat.GroupName = lstInve.GroupName;
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);
    //        Hemat.UOM = Convert.ToString(lstInve.UOMID);

    //        Hemat.PatientVisitID = vid;
    //        Hemat.PatternID = (lstInve.PatternID);
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        Hemat.CurrentRoleName = RoleName.Trim();
    //        Hemat.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                Hemat.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                Hemat.PrintableRange = PrintableRange;
    //            }
    //            Hemat.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                Hemat.RefRange = "";
    //                Hemat.setXmlValues("");
    //            }
    //            else
    //            {
    //                //Hemat.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                Hemat.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                Hemat.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //Hemat.RefRange = lstInve.ReferenceRange;            
    //        Hemat.PackageID = lstInve.PackageID;
    //        Hemat.PackageName = lstInve.PackageName;
    //        Hemat.CurrentRoleName = RoleName;
    //        Hemat.LabTechEditMedRem = strLabTechToEditMedRem;
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //Hemat.Text = lstInve.Value;
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
    //        }
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
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

    //public Control loadHematPattern7(PatientInvestigation lstInve)
    //{
    //    Investigation_HematPattern7 Hemat;
    //    Hemat = (Investigation_HematPattern7)LoadControl(lstInve.PatternName);
    //    try
    //    {
    //        long InvestigationID = lstInve.InvestigationID;
    //        // Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //Load the status
    //        int groupID = lstInve.GroupID;

    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        ////Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                Hemat.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                Hemat.PrintableRange = PrintableRange;
    //            }
    //            Hemat.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {

    //            if (lstInve.ReferenceRange == null)
    //            {
    //                Hemat.RefRange = "";
    //                Hemat.setXmlValues("");
    //            }
    //            else
    //            {
    //                //Hemat.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                Hemat.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                Hemat.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        Hemat.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();


    //        int groupID = lstInve.GroupID;


    //        //Get Data to populate Dropdown list
    //        // callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                Hemat.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                Hemat.PrintableRange = PrintableRange;
    //            }
    //            Hemat.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                Hemat.RefRange = "";
    //                Hemat.setXmlValues("");
    //            }
    //            else
    //            {
    //                //Hemat.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                Hemat.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                Hemat.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
    //        }
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
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

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

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

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    //        long InvestigationID = lstInve.InvestigationID;
    //        Hemat.POrgid = OrgID;
    //        Hemat.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
    //        int groupID = lstInve.GroupID;

    //        //Hemat.ID = Convert.ToString(lstInve.InvestigationID);
    //        Hemat.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
    //        Hemat.Name = Convert.ToString(lstInve.InvestigationName);

    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //Delta
    //        Hemat.PatientVisitID = vid;
    //        Hemat.PatternID = (lstInve.PatternID);
    //        Hemat.POrgid = Convert.ToInt32(hdnOrgID.Value);
    //        Hemat.CurrentRoleName = RoleName.Trim();
    //        Hemat.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                Hemat.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                Hemat.PrintableRange = PrintableRange;
    //            }
    //            Hemat.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {

    //            if (lstInve.ReferenceRange == null)
    //            {
    //                Hemat.RefRange = "";
    //                Hemat.setXmlValues("");
    //            }
    //            else
    //            {
    //                //Hemat.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                Hemat.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                Hemat.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        //Add Id and PatternId to list
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
    //        {
    //            Hemat.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
    //        }
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
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
    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        int groupID = lstInve.GroupID;



    //        //Get Data to populate Dropdown list
    //        //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                Hemat.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                Hemat.PrintableRange = PrintableRange;
    //            }
    //            Hemat.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                Hemat.RefRange = "";
    //                Hemat.setXmlValues("");
    //            }
    //            else
    //            {
    //                //Hemat.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    Hemat.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                Hemat.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                Hemat.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                Hemat.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //Hemat.RefRange = lstInve.ReferenceRange;
    //        //Hemat.setAttributes(Convert.ToString(Hemat.ID) );
    //        //Add Id and PatternId to list
    //        lstControl.Add(Hemat.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Hemat.ID + "_ddlstatus";
    //        //}
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
            clincalPattern.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            //Delta
            clincalPattern.PatientVisitID = vid;
            clincalPattern.PatternID = (lstInve.PatternID);
            clincalPattern.POrgid = Convert.ToInt32(hdnOrgID.Value);
            clincalPattern.CurrentRoleName = RoleName.Trim();
            clincalPattern.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            clincalPattern.IsAbnormal = lstInve.IsAbnormal;

            clincalPattern.AccessionNumber = lstInve.AccessionNumber;
            clincalPattern.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    clincalPattern.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    clincalPattern.PrintableRange = PrintableRange;
                }
                clincalPattern.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    clincalPattern.RefRange = "";
                    clincalPattern.setXmlValues("");
                }
                else
                {
                    //clincalPattern.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        clincalPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    clincalPattern.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    clincalPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    clincalPattern.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //clincalPattern.RefRange = lstInve.ReferenceRange;
            clincalPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            clincalPattern.UOM = lstInve.UOMCode;
            //clincalPattern.setAttributes(Convert.ToString(clincalPattern.ID) );
            lstControl.Add(clincalPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                clincalPattern.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    public Control loadClincalPattern13(PatientInvestigation lstInve)
    {
        Investigation_ClinicalPattern13 clincalPattern;
        clincalPattern = (Investigation_ClinicalPattern13)LoadControl(lstInve.PatternName);
        try
        {
            long InvestigationID = lstInve.InvestigationID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int groupID = lstInve.GroupID;

            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            clincalPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            clincalPattern.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            //clincalPattern.ID = Convert.ToString(lstInve.InvestigationID);
            clincalPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            clincalPattern.Name = Convert.ToString(lstInve.InvestigationName);
            clincalPattern.GroupID = lstInve.GroupID;
            clincalPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            clincalPattern.PackageID = lstInve.PackageID;
            clincalPattern.PackageName = lstInve.PackageName;
            clincalPattern.AccessionNumber = lstInve.AccessionNumber;
            clincalPattern.CurrentRoleName = RoleName;
            clincalPattern.LabTechEditMedRem = strLabTechToEditMedRem;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    clincalPattern.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    clincalPattern.PrintableRange = PrintableRange;
                }
                clincalPattern.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    clincalPattern.RefRange = "";
                    clincalPattern.setXmlValues("");
                }
                else
                {
                    //clincalPattern.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        clincalPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    clincalPattern.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    clincalPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    clincalPattern.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //clincalPattern.RefRange = lstInve.ReferenceRange;
            clincalPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            //clincalPattern.setAttributes(Convert.ToString(clincalPattern.ID) );
            lstControl.Add(clincalPattern.ID);
            lstpatternID.Add(lstInve.PatternID);


            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    //        clincalDiffPattern.POrgid = OrgID;
    //        long InvestigationID = lstInve.InvestigationID;
    //        int groupID = lstInve.GroupID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                clincalDiffPattern.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                clincalDiffPattern.PrintableRange = PrintableRange;
    //            }
    //            clincalDiffPattern.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                clincalDiffPattern.RefRange = "";
    //                clincalDiffPattern.setXmlValues("");
    //            }
    //            else
    //            {
    //                //clincalDiffPattern.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    clincalDiffPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                clincalDiffPattern.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                clincalDiffPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                clincalDiffPattern.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //clincalDiffPattern.RefRange = lstInve.ReferenceRange;
    //        clincalDiffPattern.UOM = lstInve.UOMCode;
    //        clincalDiffPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        //clincalDiffPattern.setAttributes(Convert.ToString(clincalDiffPattern.ID) );
    //        lstControl.Add(clincalDiffPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
    //        {
    //            clincalDiffPattern.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
    //        }

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + clincalDiffPattern.ID + "_ddlstatus";
    //        //}
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
    //        long InvestigationID = lstInve.InvestigationID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

    //        //Load the status
    //        int groupID = lstInve.GroupID;


    //        //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                clincalCastPattern.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                clincalCastPattern.PrintableRange = PrintableRange;
    //            }
    //            clincalCastPattern.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                clincalCastPattern.RefRange = "";
    //                clincalCastPattern.setXmlValues("");
    //            }
    //            else
    //            {
    //                //clincalCastPattern.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    clincalCastPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                clincalCastPattern.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                clincalCastPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                clincalCastPattern.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //clincalCastPattern.RefRange = lstInve.ReferenceRange;
    //        //clincalCastPattern.setAttributes(Convert.ToString(clincalCastPattern.ID) );
    //        lstControl.Add(clincalCastPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);


    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    //        long InvestigationID = lstInve.InvestigationID;
    //        int groupID = lstInve.GroupID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
    //        //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

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
    //        //code added for reference range - begin
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                ANAPattern.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                ANAPattern.PrintableRange = PrintableRange;
    //            }
    //            ANAPattern.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                ANAPattern.RefRange = "";
    //                ANAPattern.setXmlValues("");
    //            }
    //            else
    //            {
    //                //ANAPattern.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    ANAPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                ANAPattern.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                ANAPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                ANAPattern.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - end
    //        //ANAPattern.RefRange = lstInve.ReferenceRange;
    //        //ANAPattern.setAttributes(Convert.ToString(ANAPattern.ID) );
    //        lstControl.Add(ANAPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
    //        widelPattern.POrgid = OrgID;
    //        long investigationID = lstInve.InvestigationID;

    //        //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
    //        //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
    //        //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();

    //        //Load the status
    //        int groupID = lstInve.GroupID;


    //        //invesBL.GetInvBulkData(gUID, investigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
    //        widelPattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == investigationID));
    //        widelPattern.Name = Convert.ToString(lstInve.InvestigationName);
    //        widelPattern.loadStatus(header.FindAll(p => p.InvestigationID == investigationID)); //widelPattern.ID = Convert.ToString(lstInves.InvestigationID);
    //        widelPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

    //        widelPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
    //        widelPattern.GroupID = lstInve.GroupID;
    //        widelPattern.GroupName = lstInve.GroupName;
    //        widelPattern.PackageID = lstInve.PackageID;
    //        widelPattern.PackageName = lstInve.PackageName;
    //        widelPattern.CurrentRoleName = RoleName;
    //        widelPattern.LabTechEditMedRem = strLabTechToEditMedRem;
    //        //code added for reference range - begins
    //        string ReferenceRange;
    //        string OtherReferenceRange = string.Empty;
    //        string PrintableRange = string.Empty;
    //        if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
    //        {
    //            ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
    //            if (ReferenceRange != null)
    //            {
    //                widelPattern.RefRange = ReferenceRange;
    //            }
    //            if (!string.IsNullOrEmpty(PrintableRange))
    //            {
    //                widelPattern.PrintableRange = PrintableRange;
    //            }
    //            widelPattern.setXmlValues(lstInve.ReferenceRange);
    //        }
    //        else
    //        {
    //            if (lstInve.ReferenceRange == null)
    //            {
    //                widelPattern.RefRange = "";
    //                widelPattern.setXmlValues("");
    //            }
    //            else
    //            {
    //                //widelPattern.RefRange = lstInve.ReferenceRange;
    //                if (lstInve.ReferenceRange != null)
    //                {
    //                    widelPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
    //                }
    //                widelPattern.setXmlValues(lstInve.ReferenceRange);
    //            }
    //            if (!string.IsNullOrEmpty(lstInve.PrintableRange))
    //            {
    //                widelPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
    //            }
    //            else
    //            {
    //                widelPattern.PrintableRange = string.Empty;
    //            }
    //        }
    //        //code added for reference range - ends
    //        //widelPattern.RefRange = lstInve.ReferenceRange;
    //        //widelPattern.setAttributes(Convert.ToString(widelPattern.ID) );
    //        lstControl.Add(widelPattern.ID);
    //        lstpatternID.Add(lstInve.PatternID);

    //        ViewState["ControlID"] = lstControl;
    //        ViewState["PatternID"] = lstpatternID;
    //        if (lstPendingValue.FindAll(p => p.InvestigationID == investigationID).Count > 0)
    //        {
    //            widelPattern.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == investigationID));
    //        }
    //        //if (!String.IsNullOrEmpty(lstInve.GroupName))
    //        //{
    //        hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + widelPattern.ID + "_ddlstatus";
    //        //}

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
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int groupID = lstInve.GroupID;

            //Get Data to populate Dropdown list
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            fluidpattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));

            fluidpattern.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            fluidpattern.Name = lstInve.InvestigationName;
            fluidpattern.UOM = lstInve.UOMCode;
            //Bio.ID = Convert.ToString(lstInve.InvestigationID);
            fluidpattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            fluidpattern.ControlID = Convert.ToString(fluidpattern.ID);
            fluidpattern.GroupID = lstInve.GroupID;
            fluidpattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            fluidpattern.PackageID = lstInve.PackageID;
            fluidpattern.PackageName = lstInve.PackageName;
            fluidpattern.CurrentRoleName = RoleName;
            fluidpattern.LabTechEditMedRem = strLabTechToEditMedRem;
            fluidpattern.Reason = lstInve.Reason;
            fluidpattern.DecimalPlaces = lstInve.DecimalPlaces;
            fluidpattern.ResultValueType = lstInve.ResultValueType;
            fluidpattern.AccessionNumber = lstInve.AccessionNumber;
            lstControl.Add(fluidpattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
        Investigation_CommanPattern CommanPattern;
        CommanPattern = (Investigation_CommanPattern)LoadControl("~/Investigation/CommanPattern.ascx");
        try
        {
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);

            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            int groupID = lstInve.GroupID;

            //Get Data to populate Dropdown list
            // callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);

            CommanPattern.Name = lstInve.InvestigationName;
            //CommanPattern.UOM = lstInve.UOMCode;
            //CommanPattern.ID = Convert.ToString(lstInve.InvestigationID);
            CommanPattern.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            CommanPattern.ControlID = Convert.ToString(lstInve.InvestigationID);
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    CommanPattern.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    CommanPattern.PrintableRange = PrintableRange;
                }
                CommanPattern.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    CommanPattern.RefRange = "";
                    CommanPattern.setXmlValues("");
                }
                else
                {
                    //CommanPattern.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        CommanPattern.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    CommanPattern.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    CommanPattern.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    CommanPattern.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //CommanPattern.RefRange = lstInve.ReferenceRange;
            CommanPattern.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            CommanPattern.GroupID = lstInve.GroupID;
            CommanPattern.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            CommanPattern.PackageID = lstInve.PackageID;
            CommanPattern.PackageName = lstInve.PackageName;
            CommanPattern.CurrentRoleName = RoleName;
            CommanPattern.LabTechEditMedRem = strLabTechToEditMedRem;
            CommanPattern.DecimalPlaces = lstInve.DecimalPlaces;
            CommanPattern.ResultValueType = lstInve.ResultValueType;
            CommanPattern.Reason = lstInve.Reason;
            CommanPattern.AccessionNumber = lstInve.AccessionNumber;
            //CommanPattern.setAttributes(Convert.ToString(CommanPattern.ID) );
            lstControl.Add(CommanPattern.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
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
        Investigation_HistoPathologyPattern hpp;
        hpp = (Investigation_HistoPathologyPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            hpp.POrgid = OrgID;
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            hpp.CurrentRoleName = RoleName;
            hpp.LabTechEditMedRem = strLabTechToEditMedRem;
            hpp.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hpp.MedicalRemarks = lstInve.MedicalRemarks;
            hpp.AccessionNumber = lstInve.AccessionNumber;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hpp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, OrgID, groupID, out lstPatientInvSampleAliquot);
            hpp.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + hpp.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHPPattern", ex);
        }
        return hpp;
    }
    public Control LoadHPLPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_HistoPathologyPatternLilavathi hpp;
        hpp = (Investigation_HistoPathologyPatternLilavathi)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            hpp.POrgid = OrgID;
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            List<InvPackageMapping> lstInvPackageMapping = new List<InvPackageMapping>();
            List<InvestigationValues> DemoBulk1, lstPendingValue1;
            List<InvestigationStatus> header1 = new List<InvestigationStatus>();
            List<InvestigationOrgMapping> lstiom1 = new List<InvestigationOrgMapping>();
            DemoBulk1 = new List<InvestigationValues>();
            lstPendingValue1 = new List<InvestigationValues>();
            callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, lstInvPackageMapping, out DemoBulk1, out lstPendingValue1, out header1, out lstiom1);
            hpp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.LoadData(DemoBulk1.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.Name = lstInve.InvestigationName;
            //hpp.UOM = lstInve.UOMCode;
            //hpp.ID = Convert.ToString(lstInve.InvestigationID);
            hpp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            hpp.ControlID = Convert.ToString(lstInve.InvestigationID);
            hpp.GroupID = lstInve.GroupID;
            hpp.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            hpp.PackageID = lstInve.PackageID;
            hpp.PackageName = lstInve.PackageName;
            hpp.CurrentRoleName = RoleName;
            hpp.LabTechEditMedRem = strLabTechToEditMedRem;
            hpp.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hpp.MedicalRemarks = lstInve.MedicalRemarks;
            hpp.AccessionNumber = lstInve.AccessionNumber;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hpp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, OrgID, groupID, out lstPatientInvSampleAliquot);
            hpp.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + hpp.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHPLPattern", ex);
        }
        return hpp;
    }
    public Control LoadHistoImageDescriptionPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_HistoImageDescriptionPattern hpp;
        hpp = (Investigation_HistoImageDescriptionPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            hpp.POrgid = OrgID;
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            hpp.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            hpp.Name = lstInve.InvestigationName;
            //hpp.UOM = lstInve.UOMCode;
            //hpp.ID = Convert.ToString(lstInve.InvestigationID);
            hpp.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            hpp.ControlID = Convert.ToString(lstInve.InvestigationID);
            hpp.GroupID = lstInve.GroupID;
            hpp.GroupName = lstInve.GroupName;
            hpp.PackageID = lstInve.PackageID;
            hpp.PackageName = lstInve.PackageName;
            hpp.CurrentRoleName = RoleName;
            hpp.LabTechEditMedRem = strLabTechToEditMedRem;
            hpp.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hpp.MedicalRemarks = lstInve.MedicalRemarks;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hpp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, OrgID, groupID, out lstPatientInvSampleAliquot);
            hpp.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hpp.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + hpp.ID + "_ddlstatus";
            //}
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
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
        Investigation_HistoPathologyPatternQuantum hppQuantum;
        hppQuantum = (Investigation_HistoPathologyPatternQuantum)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            hppQuantum.POrgid = OrgID;
            Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            List<PatientInvSampleAliquot> lstPatientInvSampleAliquot = new List<PatientInvSampleAliquot>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            hppQuantum.CurrentRoleName = RoleName;
            hppQuantum.LabTechEditMedRem = strLabTechToEditMedRem;
            hppQuantum.Reason = lstInve.Reason;//Added by Perumal on 13 Jan 2012
            hppQuantum.MedicalRemarks = lstInve.MedicalRemarks;
            //hppQuantum.AccessionNumber = lstInve.AccessionNumber;
            //hpp.setAttributes(Convert.ToString(hpp.ID) );
            lstControl.Add(hppQuantum.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            callBulkData.GetAliquotBarcode(gUID, lstInve.InvestigationID, vid, OrgID, groupID, out lstPatientInvSampleAliquot);
            hppQuantum.loadAliquotBarcode(lstPatientInvSampleAliquot);
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                hppQuantum.SetInvestigationValue(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + hppQuantum.ID + "_ddlstatus";
            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadHPPattern", ex);
        }
        return hppQuantum;
    }
    public Control LoadCultureAndSensitivityPattern(PatientInvestigation lstInve)
    {

        Investigation_CultureandSensitivityReport Culture;
        Culture = (Investigation_CultureandSensitivityReport)LoadControl(lstInve.PatternName);
        try
        {
            Culture.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Culture.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            DropDownList ddlstatus = (DropDownList)Culture.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                Label lblName = (Label)Culture.FindControl("Label1");
                lblName.Visible = false;
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
        return Culture;
    }
    public Control LoadCultureAndSensitivityV1Pattern(PatientInvestigation lstInve)
    {

        Investigation_CultureandSensitivityReportV1 Culture;
        Culture = (Investigation_CultureandSensitivityReportV1)LoadControl(lstInve.PatternName);
        try
        {
            Culture.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Culture.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Culture.LoadOrganism(OrgID, lstInve.InvestigationID, "OrganismName", "XMLDrugList");
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
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
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
            Culture.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Culture.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            Culture.LoadOrganism(OrgID, lstInve.InvestigationID, "OrganismName", "XMLDrugList");
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
            Culture.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //Culture.setAttributes(Convert.ToString(Culture.ID) );
            lstControl.Add(Culture.ID);
            lstpatternID.Add(lstInve.PatternID);
            Culture.TID = Culture.ID;
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Culture.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            hdnIsCultureSensitivityV2.Value = "true";
            /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Culture.ID + "_ddlstatus";
            /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
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
            stoneAnalysis.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            stoneAnalysis.Name = lstInve.InvestigationName;
            //stoneAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            stoneAnalysis.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            stoneAnalysis.ControlID = Convert.ToString(lstInve.InvestigationID);
            stoneAnalysis.GroupID = lstInve.GroupID;
            stoneAnalysis.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            stoneAnalysis.PackageID = lstInve.PackageID;
            stoneAnalysis.PackageName = lstInve.PackageName;
            stoneAnalysis.CurrentRoleName = RoleName;
            stoneAnalysis.AccessionNumber = lstInve.AccessionNumber;
            stoneAnalysis.LabTechEditMedRem = strLabTechToEditMedRem;
            stoneAnalysis.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            stoneAnalysis.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //stoneAnalysis.setAttributes(Convert.ToString(stoneAnalysis.ID) );
            lstControl.Add(stoneAnalysis.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

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
        int groupID = lstInve.GroupID;

        Investigation_MicroBioPattern1 mbp;
        mbp = (Investigation_MicroBioPattern1)LoadControl(lstInve.PatternName);
        try
        {
            mbp.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            mbp.AccessionNumber = lstInve.AccessionNumber;
            //mbp.setAttributes(Convert.ToString(mbp.ID) );
            lstControl.Add(mbp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                mbp.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + mbp.ID + "_ddlstatus";
            //}
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
        Investigation_FluidAnalysisCellsPattern facep;
        facep = (Investigation_FluidAnalysisCellsPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            facep.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(facep.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

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
    public Control LoadSmearPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_SmearAnalysis SMEAR;
        SMEAR = (Investigation_SmearAnalysis)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            SMEAR.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //SMEAR.LoadData(DemoBulk);
            SMEAR.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            SMEAR.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            SMEAR.ControlID = Convert.ToString(lstInve.InvestigationID);
            SMEAR.GroupID = lstInve.GroupID;
            SMEAR.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            SMEAR.PackageID = lstInve.PackageID;
            SMEAR.PackageName = lstInve.PackageName;
            SMEAR.CurrentRoleName = RoleName;
            SMEAR.LabTechEditMedRem = strLabTechToEditMedRem;
            SMEAR.AccessionNumber = lstInve.AccessionNumber;
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(SMEAR.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                SMEAR.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadsmearPattern", ex);
        }
        return SMEAR;
    }
    public Control LoadBodyFluidAnalysisPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_Body_Fluid_Analysis BodyFluidAnalysis;
        BodyFluidAnalysis = (Investigation_Body_Fluid_Analysis)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            BodyFluidAnalysis.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //SMEAR.LoadData(DemoBulk);
            BodyFluidAnalysis.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            BodyFluidAnalysis.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            BodyFluidAnalysis.ControlID = Convert.ToString(lstInve.InvestigationID);
            BodyFluidAnalysis.GroupID = lstInve.GroupID;
            BodyFluidAnalysis.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            BodyFluidAnalysis.PackageID = lstInve.PackageID;
            BodyFluidAnalysis.PackageName = lstInve.PackageName;
            BodyFluidAnalysis.CurrentRoleName = RoleName;
            BodyFluidAnalysis.LabTechEditMedRem = strLabTechToEditMedRem;
            BodyFluidAnalysis.AccessionNumber = lstInve.AccessionNumber;
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(BodyFluidAnalysis.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                BodyFluidAnalysis.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadBodyFluidAnalysisPattern", ex);
        }
        return BodyFluidAnalysis;
    }
    public Control LoadSemenAnalysisNewPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_SemenAnalysisNewPattern SemenAnalysisNew;
        SemenAnalysisNew = (Investigation_SemenAnalysisNewPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            SemenAnalysisNew.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            SemenAnalysisNew.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //SMEAR.LoadData(DemoBulk);
            SemenAnalysisNew.Name = lstInve.InvestigationName;
            //facep.ID = Convert.ToString(lstInve.InvestigationID);
            SemenAnalysisNew.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            SemenAnalysisNew.ControlID = Convert.ToString(lstInve.InvestigationID);
            SemenAnalysisNew.GroupID = lstInve.GroupID;
            SemenAnalysisNew.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            SemenAnalysisNew.PackageID = lstInve.PackageID;
            SemenAnalysisNew.PackageName = lstInve.PackageName;
            SemenAnalysisNew.CurrentRoleName = RoleName;
            SemenAnalysisNew.LabTechEditMedRem = strLabTechToEditMedRem;

            SemenAnalysisNew.AccessionNumber = lstInve.AccessionNumber;
            //facep.setAttributes(Convert.ToString(facep.ID) );
            lstControl.Add(SemenAnalysisNew.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                SemenAnalysisNew.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadsmearPattern", ex);
        }
        return SemenAnalysisNew;
    }
    public Control LoadFAChemistryPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FluidAnalysisChemistryPattern fachp;
        fachp = (Investigation_FluidAnalysisChemistryPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            fachp.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

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
        Investigation_FluidAnalysisImmunolgyPattern faimp;
        faimp = (Investigation_FluidAnalysisImmunolgyPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            faimp.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            faimp.AccessionNumber = lstInve.AccessionNumber;
            faimp.CurrentRoleName = RoleName;
            faimp.LabTechEditMedRem = strLabTechToEditMedRem;
            //faimp.setAttributes(Convert.ToString(faimp.ID) );
            lstControl.Add(faimp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
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
        Investigation_FluidAnalysisCytologyPattern facyp;
        facyp = (Investigation_FluidAnalysisCytologyPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            //facyp.CurrentRoleName = RoleName;
            //facyp.LabTechEditMedRem = strLabTechToEditMedRem;
            //facyp.setAttributes(Convert.ToString(facyp.ID) );
            lstControl.Add(facyp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

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
        Investigation_FungalSmearPattern fsp;
        fsp = (Investigation_FungalSmearPattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            fsp.POrgid = OrgID;
            //Investigation_BL callBulkData = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //callBulkData.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            fsp.AccessionNumber = lstInve.AccessionNumber;
            fsp.CurrentRoleName = RoleName;
            fsp.LabTechEditMedRem = strLabTechToEditMedRem;
            //fsp.setAttributes(Convert.ToString(fsp.ID) );
            lstControl.Add(fsp.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
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
        int groupID = lstInve.GroupID;

        try
        {
            ABMethod.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            //Delta
            ABMethod.PatientVisitID = vid;
            ABMethod.PatternID = (lstInve.PatternID);
            ABMethod.POrgid = Convert.ToInt32(hdnOrgID.Value);
            ABMethod.CurrentRoleName = RoleName.Trim();
            ABMethod.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            ABMethod.DecimalPlaces = lstInve.DecimalPlaces;
            ABMethod.ResultValueType = lstInve.ResultValueType;
            ABMethod.IsAbnormal = lstInve.IsAbnormal;
            ABMethod.AccessionNumber = lstInve.AccessionNumber;
            ABMethod.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //code added for reference range - begins
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                string ReferenceRange;
                string OtherReferenceRange = string.Empty;
                string PrintableRange = string.Empty;
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    ABMethod.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    ABMethod.PrintableRange = PrintableRange;
                }
                ABMethod.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    ABMethod.RefRange = "";
                    ABMethod.setXmlValues("");
                }
                else
                {
                    //ABMethod.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        ABMethod.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    ABMethod.setXmlValues(lstInve.ReferenceRange);
                }

                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    ABMethod.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    ABMethod.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - ends
            //ABMethod.RefRange = lstInve.ReferenceRange;
            ABMethod.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            ABMethod.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //ABMethod.setAttributes(Convert.ToString(ABMethod.ID));
            lstControl.Add(ABMethod.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                ABMethod.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + ABMethod.ID + "_ddlstatus";
            //}
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
        int groupID = lstInve.GroupID;

        try
        {
            ABQualitative.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            ABQualitative.Name = lstInve.InvestigationName;
            //ABQualitative.ID = Convert.ToString(lstInve.InvestigationID);
            ABQualitative.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));

            ABQualitative.UOM = lstInve.UOMCode;
            //ABQualitative.RefRange = lstInve.ReferenceRange;

            ABQualitative.ControlID = Convert.ToString(lstInve.InvestigationID);
            ABQualitative.GroupID = lstInve.GroupID;
            ABQualitative.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            ABQualitative.PackageID = lstInve.PackageID;
            ABQualitative.PackageName = lstInve.PackageName;
            ABQualitative.CurrentRoleName = RoleName;
            ABQualitative.LabTechEditMedRem = strLabTechToEditMedRem;
            ABQualitative.DecimalPlaces = lstInve.DecimalPlaces;
            ABQualitative.ResultValueType = lstInve.ResultValueType;
            ABQualitative.IsAbnormal = lstInve.IsAbnormal;
            ABQualitative.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            ABQualitative.AccessionNumber = lstInve.AccessionNumber;
            hdnIsExcludeAutoApproval.Value = lstInve.RefSuffixText;
            //code added for reference range - begins
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    ABQualitative.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    ABQualitative.PrintableRange = PrintableRange;
                }
                ABQualitative.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    ABQualitative.RefRange = "";
                    ABQualitative.setXmlValues("");
                }
                else
                {
                    //ABQualitative.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        ABQualitative.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    ABQualitative.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    ABQualitative.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    ABQualitative.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - ends
            ABQualitative.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            ABQualitative.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //ABQualitative.setAttributes(Convert.ToString(ABQualitative.ID));

            lstControl.Add(ABQualitative.ID);

            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                ABQualitative.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + ABQualitative.ID + "_ddlstatus";
            //}
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
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            semenAnalysis.AccessionNumber = lstInve.AccessionNumber;
            semenAnalysis.LabTechEditMedRem = strLabTechToEditMedRem;
            semenAnalysis.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            semenAnalysis.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));
            //semenAnalysis.setAttributes(Convert.ToString(semenAnalysis.ID) );

            lstControl.Add(semenAnalysis.ID);

            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

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
            Imaging.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            //lstInve.DeptID
            Imaging.SelectedValue = lstInve.DeptID.ToString();
            int groupID = lstInve.GroupID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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

            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(Imaging.ID);

            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;

            Imaging.loadDrName(lPerformingPhysicain);

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
    public Control LoadSmear(PatientInvestigation lstInve)
    {

        Investigation_PeripheralSmear phSmear;
        phSmear = (Investigation_PeripheralSmear)LoadControl(lstInve.PatternName);
        try
        {
            phSmear.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            phSmear.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            phSmear.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            phSmear.UOM = lstInve.UOMCode;
            phSmear.ControlID = Convert.ToString(lstInve.InvestigationID);
            phSmear.GroupID = lstInve.GroupID;
            phSmear.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            phSmear.PackageID = lstInve.PackageID;
            phSmear.PackageName = lstInve.PackageName;
            phSmear.AccessionNumber = lstInve.AccessionNumber;
            phSmear.CurrentRoleName = RoleName;
            phSmear.LabTechEditMedRem = strLabTechToEditMedRem;
            phSmear.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            phSmear.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(phSmear.ID);

            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
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
            bleedingTime.POrgid = OrgID;
            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            bleedingTime.Name = lstInve.InvestigationName;
            bleedingTime.UOM = lstInve.UOMCode;
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
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
            //Delta
            bleedingTime.PatientVisitID = vid;
            bleedingTime.PatternID = (lstInve.PatternID);
            bleedingTime.POrgid = Convert.ToInt32(hdnOrgID.Value);
            bleedingTime.CurrentRoleName = RoleName.Trim();
            bleedingTime.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    bleedingTime.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    bleedingTime.PrintableRange = PrintableRange;
                }
                bleedingTime.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    bleedingTime.RefRange = "";
                    bleedingTime.setXmlValues("");
                }
                else
                {
                    //bleedingTime.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        bleedingTime.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    bleedingTime.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    bleedingTime.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    bleedingTime.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //bleedingTime.RefRange = lstInve.ReferenceRange; // "MALE:0 – 20 mm/hr FEMALE :0 – 30 mm/hr";
            lstControl.Add(bleedingTime.ID);
            lstpatternID.Add(lstInve.PatternID);
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                bleedingTime.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + bleedingTime.ID + "_ddlstatus";
            //}
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
            Imaging.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            Imaging.Name = lstInve.InvestigationName;
            //semenAnalysis.ID = Convert.ToString(lstInve.InvestigationID);
            Imaging.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            //semenAnalysis.UOM = lstInve.UOMCode;
            Imaging.ControlID = Convert.ToString(lstInve.InvestigationID);
            Imaging.PatientVisitID = vid;
            Imaging.GroupID = lstInve.GroupID;
            Imaging.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            Imaging.PackageID = lstInve.PackageID;
            Imaging.AccessionNumber = lstInve.AccessionNumber;
            Imaging.PackageName = lstInve.PackageName;
            Imaging.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));

            //semenAnalysis.LoadData(DemoBulk);
            //Imaging.setAttributes(Convert.ToString(Imaging.ID));
            lstControl.Add(Imaging.ID);

            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //Imaging.LoadddlInvResultTemplate();

            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Imaging.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }

            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Imaging.ID + "_ddlstatus";
            DropDownList ddlstatus = (DropDownList)Imaging.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                Label lblName = (Label)Imaging.FindControl("Label1");
                lblName.Visible = false;
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
        return Imaging;
    }
    public Control LoadGTT(PatientInvestigation lstInve)
    {

        Investigation_GTT GTT;
        GTT = (Investigation_GTT)LoadControl(lstInve.PatternName);

        try
        {
            GTT.POrgid = OrgID;
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            GTT.Name = lstInve.InvestigationName;
            if (lstInve.ReferenceRange != null)
            {
                //GTT.RefRange = lstInve.ReferenceRange;
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

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;


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
    public Control LoadaPTT(PatientInvestigation lstInve)
    {

        Investigation_aPTTPattern aPTT;
        aPTT = (Investigation_aPTTPattern)LoadControl(lstInve.PatternName);

        try
        {
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            aPTT.Name = lstInve.InvestigationName;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    aPTT.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    aPTT.PrintableRange = PrintableRange;
                }
                aPTT.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    aPTT.RefRange = "";
                    aPTT.setXmlValues("");
                }
                else
                {
                    //aPTT.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        aPTT.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    aPTT.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    aPTT.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    aPTT.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //aPTT.RefRange = lstInve.ReferenceRange;
            aPTT.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            aPTT.ControlID = Convert.ToString(lstInve.InvestigationID);
            aPTT.GroupID = lstInve.GroupID;
            aPTT.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            aPTT.PackageID = lstInve.PackageID;
            aPTT.PackageName = lstInve.PackageName;
            aPTT.AccessionNumber = lstInve.AccessionNumber;
            aPTT.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //GTT.LoadData(DemoBulk);

            lstControl.Add(aPTT.ID);
            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;


            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                aPTT.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + aPTT.ID + "_ddlstatus";
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on LoadaPTT Control", ex);
        }
        return aPTT;
    }
    public Control LoadPTT(PatientInvestigation lstInve)
    {

        Investigation_PTTPattern PTT;
        PTT = (Investigation_PTTPattern)LoadControl(lstInve.PatternName);

        try
        {
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;

            //Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            //List<InvestigationValues> DemoBulk, lstPendingValue = new List<InvestigationValues>();
            //List<InvestigationOrgMapping> lstiom = new List<InvestigationOrgMapping>();
            //invesBL.GetInvBulkData(gUID, InvestigationID, vid, OrgID, groupID, out DemoBulk, out lstPendingValue, out header, out lstiom);
            PTT.Name = lstInve.InvestigationName;
            //code added for reference range - begin
            string ReferenceRange;
            string OtherReferenceRange = string.Empty;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.UOMCode, out ReferenceRange, out OtherReferenceRange, out PrintableRange);
                if (ReferenceRange != null)
                {
                    PTT.RefRange = ReferenceRange;
                }
                if (!string.IsNullOrEmpty(PrintableRange))
                {
                    PTT.PrintableRange = PrintableRange;
                }
                PTT.setXmlValues(lstInve.ReferenceRange);
            }
            else
            {
                if (lstInve.ReferenceRange == null)
                {
                    PTT.RefRange = "";
                    PTT.setXmlValues("");
                }
                else
                {
                    //PTT.RefRange = lstInve.ReferenceRange;
                    if (lstInve.ReferenceRange != null)
                    {
                        PTT.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                    PTT.setXmlValues(lstInve.ReferenceRange);
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    PTT.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
                else
                {
                    PTT.PrintableRange = string.Empty;
                }
            }
            //code added for reference range - end
            //PTT.RefRange = lstInve.ReferenceRange;
            PTT.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            PTT.ControlID = Convert.ToString(lstInve.InvestigationID);
            PTT.GroupID = lstInve.GroupID;
            PTT.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "");
            PTT.PackageID = lstInve.PackageID;
            PTT.PackageName = lstInve.PackageName;
            PTT.AccessionNumber = lstInve.AccessionNumber;
            PTT.CurrentRoleName = RoleName;
            PTT.LabTechEditMedRem = strLabTechToEditMedRem;
            PTT.loadStatus(header.FindAll(p => p.InvestigationID == InvestigationID));
            //GTT.LoadData(DemoBulk);

            lstControl.Add(PTT.ID);
            lstpatternID.Add(lstInve.PatternID);

            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;


            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                PTT.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + PTT.ID + "_ddlstatus";
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on load Ptt Control", ex);
        }
        return PTT;
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
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                DropDownList ddlstatus = (DropDownList)orgDrugPattern.FindControl("ddlstatus");
                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                ////TextBox lblName = (TextBox)orgDrugPattern.FindControl("txtCode");
                ////lblName.Enabled = false;
                ////TextBox txtValue1 = (TextBox)orgDrugPattern.FindControl("txtValue");
                ////txtValue1.ReadOnly = true;
                ////TextBox txtMedRemarks = (TextBox)orgDrugPattern.FindControl("txtMedRemarks");
                ////txtMedRemarks.Enabled = false;

                //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
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
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                DropDownList ddlstatus = (DropDownList)orgDrugPattern.FindControl("ddlstatus");
                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                ////TextBox lblName = (TextBox)orgDrugPattern.FindControl("txtCode");
                ////lblName.Enabled = false;
                ////TextBox txtValue1 = (TextBox)orgDrugPattern.FindControl("txtValue");
                ////txtValue1.ReadOnly = true;
                ////TextBox txtMedRemarks = (TextBox)orgDrugPattern.FindControl("txtMedRemarks");
                ////txtMedRemarks.Enabled = false;

                //string SelString = ddlstatus.Items.Find(O => O.StatuswithID.Contains("Completed")).StatuswithID;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
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
            DropDownList ddlstatus = (DropDownList)microStainPattern.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                Label lblName = (Label)microStainPattern.FindControl("Label1");
                lblName.Visible = false;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
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
    //kapil
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
            Img.GroupName = (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : ""); ;
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
            DropDownList ddlstatus = (DropDownList)Img.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {

                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                Label lblName = (Label)Img.FindControl("Label1");
                lblName.Visible = false;
                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPDFUploadpattern ", ex);
        }
        return Img;
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
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName.Replace(":", "") + "|" + (lstInve.GroupName != null ? lstInve.GroupName.Replace(":", "") : "") + "|" + Tablepatternautopopulate.ID + "_ddlstatus";
            //}
            //Load 
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Tablepatternautopopulate.SetInvestigationValueForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Tablepatternautopopulate ", ex);
        }
        return Tablepatternautopopulate;
    }
    public Control LoadRichTextPattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        int GroupID = lstInve.GroupID;
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
            lstControl.Add(RichTextPatternPt.ID);
            RichTextPatternPt.PatientVisitID = vid;
            RichTextPatternPt.PatternID = (lstInve.PatternID);
            RichTextPatternPt.POrgid = Convert.ToInt32(hdnOrgID.Value);
            RichTextPatternPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            RichTextPatternPt.TestStatus = lstInve.TestStatus;
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
            RichTextPatternPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == GroupID));
            //FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID));

            //Changed BY Arivalagan.KK
            //FCKeditor txtValue = ((FCKeditor)RichTextPatternPt.FindControl("fckVal"));
            CKEditorControl txtValue = ((CKEditorControl)RichTextPatternPt.FindControl("fckVal"));

            try
            {
                //if (txtValue.Value != null && txtValue.Value.Trim().Length > 0)
                if (txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    DropDownList ddlstatus = (DropDownList)RichTextPatternPt.FindControl("ddlstatus");
                    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    /* This block was commented for not select Complete At already Completed test*/
                    //else
                    //{
                    //    int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                    //    ddlstatus.SelectedIndex = index;
                    //}
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */

                }
            }
            catch (Exception e)
            {
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadRichTextPattern", ex);
        }
        return RichTextPatternPt;

    }
    public Control LoadImageDescriptionpattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_ImageDescriptionpattern Img;
        Img = (Investigation_ImageDescriptionpattern)LoadControl(lstInve.PatternName);
        int groupID = lstInve.GroupID;

        try
        {
            Img.ShowImagePattern();
            Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
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
            ViewState["ControlID"] = lstControl;
            ViewState["PatternID"] = lstpatternID;
            //if (!String.IsNullOrEmpty(lstInve.GroupName))
            //{
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Img.ID + "_ddlstatus";
            //}
            if (lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID).Count > 0)
            {
                Img.LoadDataForEdit(lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID));

            }
            DropDownList ddlstatus = (DropDownList)Img.FindControl("ddlstatus");
            if (lstInve.Status == InvStatus.Completed || lstInve.Status == InvStatus.Approved)
            {
                ddlstatus.Visible = false;
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                INVHideStatus = new PatientInvestigation();
                INVHideStatus.InvestigationID = lstInve.InvestigationID;
                LstINVHideStatus.Add(INVHideStatus);
                //**************Added By Arivalagan.kk for getting hide status InvId***************//
                Repeater txtReason = (Repeater)Img.FindControl("rptimages");
                //txtReason.FindControl("btnDelete").Enabled = false;
                //((Button)txtReason.FindControl("btnDelete")).Enabled = false;

                if (ddlstatus.Items.FindByValue("Completed_2") != null)
                {
                    ddlstatus.SelectedValue = "Completed_2";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadImageDescriptionPattern ", ex);
        }

        return Img;
    }
    public void drawNewPatternMethod()
    {
        Table tblResult = null;
        TableRow tr = null;
        TableCell tc = null;
        int k = 0;
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

        string RerunRecollectReason = GetConfigValues("Need_Reason_For_Rerun_Recollect", OrgID);
        Reasonloading.Value = RerunRecollectReason;

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
                    //tc.Text = objDP.InvestigationName;



                    HtmlTable HtmlTab = new HtmlTable();
                    HtmlTableRow HtmlTr = new HtmlTableRow();
                    HtmlTableCell HtmlTc1 = new HtmlTableCell();
                    HtmlTableCell HtmlTc2 = new HtmlTableCell();
                    HtmlTableCell HtmlTc3 = new HtmlTableCell();

                    HtmlTableCell HtmlTc4 = new HtmlTableCell();
                    HtmlTableCell HtmlTc5 = new HtmlTableCell();

                    HyperLink hlnkGrp = new HyperLink();
                    hlnkGrp.ID = objDP.InvestigationName + "_Grp" + k;
                    hlnkGrp.Text = objDP.InvestigationName;
                    hlnkGrp.Attributes.Add("OnClick", "javascript:changeGroupName(this.id);");

                    int subStatPos = hlnkGrp.ID.IndexOf("<I>");
                    int subEndPos = hlnkGrp.ID.LastIndexOf(" :");
                    int subLength = subEndPos - subStatPos;
                    string sub = hlnkGrp.ID.Substring(subStatPos + 3, subLength - 3);

                    long returnCode = -1;
                    DropDownList drpList = new DropDownList();
                    drpList.ID = sub + "_Grp" + k;
                    var header1 = header.Select(e => new { e.DisplayText, e.StatuswithID })
                               .Distinct();
                    drpList.DataSource = header1;
                    drpList.DataTextField = "DisplayText";
                    drpList.DataValueField = "StatuswithID";
                    drpList.DataBind();
                    if (drpList.Items.FindByValue("Pending_1") != null)
                    {
                        drpList.SelectedValue = "Pending_1";
                    }
                    //List<string> header1 = header.Select new(c => c.DisplayText,c.StatuswithID).Distinct().ToList();
                    //drpList.Items.Add("Pending");
                    //drpList.Items.Add("Completed");
                    //drpList.Items.Add("Recheck");
                    drpList.CssClass = "ddl";
                    //drpList.Items.Add("Approve");
                    drpList.Attributes.Add("onchange", "javascript:ChangeStatus('" + sub + "',this.id);");
                    if (String.IsNullOrEmpty(hdnGroupCollection.Value))
                    {
                        hdnGroupCollection.Value += sub + "_Grp" + k + "#";
                    }
                    else
                    {
                        hdnGroupCollection.Value += "^#" + sub + "_Grp" + k + "#";
                    }
                    HyperLink hlnkGrpCmt = new HyperLink();
                    hlnkGrpCmt.ID = objDP.InvestigationName + "_GrpCmt" + k;

                    HiddenField hdnGrpCmtID = new HiddenField();
                    hdnGrpCmtID.ID = "GrpCmtID" + "~" + k + "~" + objDP.GroupID.ToString();
                    hdnGrpCmtID.Value = objDP.GroupID + "~" + "GRP" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

                    //InvRemarks
                    HiddenField hdnAppMedRemarksID = new HiddenField();
                    hdnAppMedRemarksID.ID = "hdnAppMedRemarksID" + "~" + k + "~" + objDP.GroupID.ToString();
                    HiddenField hdnAppTechRemarksID = new HiddenField();
                    hdnAppTechRemarksID.ID = "hdnAppTechRemarksID" + "~" + k + "~" + objDP.GroupID.ToString();
                    //InvRemarks

                    //string[] splitComment = objDP.InvestigationName.Split(':');

                    //if (splitComment[2].Trim() != "" && splitComment[2] != "</I></B>")
                    //{
                    //  hlnkGrpCmt.Text = splitComment[2].Trim();
                    //}
                    //else
                    //{
                    //hlnkGrpCmt.Text = "Add Comments";
                    // }

                    objDP.GroupComment = objDP.GroupComment == null ? "" : objDP.GroupComment;
                    if (objDP.GroupComment.Trim() != "")
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
                    //InvRemarks

                    hlnkGrpCmt.Attributes.Add("OnClick", "javascript:changeGroupComment(this.id,'" + sub + "','" + hdnGrpCmtID.ID.ToString() + "','" + hdnAppTechRemarksID.ID.ToString() + "','" + hdnAppMedRemarksID.ID.ToString() + "');"); //Modified for InvRemarks
                    hlnkGrpCmt.Attributes.Add("onmouseover", "this.style.cursor='hand'");
                    hlnkGrpCmt.ToolTip = "Click Here To Add / Change Group Comments.";
                    //hlnkGrpCmt.CssClass = "Duecolor";

                    HtmlTc1.Controls.Add(hlnkGrp);
                    HtmlTc1.Align = "Left";
                    HtmlTc2.Controls.Add(hlnkGrpCmt);

                    HtmlTc2.Controls.Add(hdnGrpCmtID); // Added for InvRemarks
                    HtmlTc2.Controls.Add(hdnAppTechRemarksID); // Added for InvRemarks
                    HtmlTc2.Controls.Add(hdnAppMedRemarksID); // Added for InvRemarks

                    HtmlTc2.Align = "Right";
                    HtmlTc3.Controls.Add(drpList);

                    //Code for Show RejectReason in Dept Header-Add By syed
                    HtmlTable HtmlTab1 = new HtmlTable();
                    HtmlTableRow HtmlTr1 = new HtmlTableRow();
                    HtmlTableCell HtmlTd1 = new HtmlTableCell();
                    //returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
                    List<InvReasonMasters> lstInvReasonMaster1 = lstInvReasonMaster.FindAll(P => P.StatusID == 4);
                    Label lblReason = new Label();
                    lblReason.ID = "lblGrp" + sub + "_Grp" + k;
                    lblReason.Text = "Reason :";
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
                    lblOpinionUser.Text = "User : ";
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
                    drpDeptList1.Items.Insert(0, "-----Select-----");
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
                    item.Text = "---Select---";
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
                else
                {
                    tr = new TableRow();
                    tc = new TableCell();
                    tc.Width = Unit.Percentage(50);
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
                        drpDeptList.ID = objDP.InvestigationName + k;
                        drpDeptList.CssClass = "ddl";
                        //header = header.OrderBy(p => p.InvestigationStatusID).ToList();
                        header1 = header.GroupBy(a => a.DisplayText).Select(g => g.First()).ToList();
                        for (int i = 0; i < header1.Count; i++)
                        {
                            drpDeptList.Items.Add(new ListItem(header1[i].DisplayText, header1[i].StatuswithID));
                        }
                        if (drpDeptList.Items.FindByValue("Pending_1") != null)
                        {
                            drpDeptList.SelectedValue = "Pending_1";
                        }
                        //drpDeptList.Items.Add("Completed");
                        //drpDeptList.Items.Add("Approve");
                        //drpDeptList.Items.Add("Reject");
                        //drpDeptList.Items.Add("Retest");

                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        //drpDeptList.Attributes.Add("onchange", "javascript:ChangeDeptStatus('" + sub + "',this.id);");
                        drpDeptList.Attributes.Add("onchange", "javascript:ChangeDeptStatusSingleScreen('" + sub + "',this.id);");
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */

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
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        //HtmlTab1.Attributes.Add("Style", "display:none");
                        if (RoleName == "Lab Technician" || RoleName == "Physician Assistant")
                        {
                            HtmlTab1.Attributes.Add("Style", "display:block");
                        }
                        else
                        {
                            HtmlTab1.Attributes.Add("Style", "display:none");
                        }
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
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
                        drpDeptList1.Items.Insert(0, "-----Select-----");
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
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        //drpDeptList3.ID = "ddlOpinionUser" + objDP.InvestigationName + k;
                        //UserDropDown Name changed
                        drpDeptList3.ID = "ddlOpinionUser_" + sub;
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        drpDeptList3.CssClass = "ddl";
                        ListItem item = new ListItem();
                        item.Text = "---Select---";
                        item.Value = "0";
                        drpDeptList3.Items.Insert(0, item);
                        drpDeptList3.SelectedIndex = 0;
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        //Javascript Method Name changed  DOne by sabari
                        //drpDeptList3.Attributes.Add("onchange", "javascript:ChangeDeptStatusOpinion('" + sub + "',this.id);");
                        drpDeptList3.Attributes.Add("onchange", "javascript:ChangeDeptStatusOpinionSingleScreen('" + sub + "',this.id);");
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        if (RoleName == "Lab Technician" || RoleName == "Physician Assistant")
                        {
                            HtmlTab1.Attributes.Add("Style", "display:block");
                        }
                        else
                        {
                            HtmlTab1.Attributes.Add("Style", "display:none");
                        }
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        HtmlTab1.ID = "tblStatusOpinion2" + objDP.InvestigationName + k;
                        HtmlTd1.Controls.Add(drpDeptList3);
                        HtmlTr1.Controls.Add(HtmlTd1);
                        HtmlTab1.Controls.Add(HtmlTr1);
                        HtmlTc3.Controls.Add(HtmlTab1);
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        if (RoleName == "Lab Technician" || RoleName == "Physician Assistant")
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
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */


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

                //IInvestigationPattern Pattern = (IInvestigationPattern)LoadControl("~/Investigation/FluidPattern.ascx");


                switch (objDP.PatternID)
                {
                    //Load comman pattern for Unmapping investigation

                    case (Int32)TaskHelper.Pattern.Commanpattern:
                        myControl = LoadCommanPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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

                    case (Int32)TaskHelper.Pattern.BioPattern5:
                        myControl = LoadBioPattern5(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);

                        break;

                    case (Int32)TaskHelper.Pattern.HistoPathologyPatternLilavathi:
                        myControl = LoadHPLPattern(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.aPTT:
                        myControl = LoadaPTT(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
                        tc.Width = Unit.Percentage(70);
                        tc.Controls.Add(myControl);
                        tr.Cells.Add(tc);
                        drawNewPattern.Rows.Add(tr);
                        break;

                    case (Int32)TaskHelper.Pattern.PTT:
                        myControl = LoadPTT(objDP);
                        tblResult = new Table();
                        tr = new TableRow();
                        tc = new TableCell();
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        if (objDP.ErrorCode != "" && objDP.ErrorCode != null && objDP.ErrorCode != "N")
                        {
                            tr.Style.Add("background-color", "#faa603");
                        }
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
                        tc.Width = Unit.Percentage(50);
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
                        myControl = LoadImageDescriptionpattern(objDP);
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

        if (!String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "chkDeviceRefRange", "CallAllReferenceRangeValidate();", true);
        }
        foreach (string sFormula in hFormulaCollection.Values)
        {
            string tempFormula = sFormula;
            foreach (long investigationID in hGroupFormulaCollection.Keys)
            {
                if (tempFormula.Contains("[" + investigationID + "]"))
                {
                    tempFormula = tempFormula.Replace("'[" + investigationID + "]'", "'" + hGroupFormulaCollection[investigationID] + "'");
                    tempFormula = tempFormula.Replace("[" + investigationID + "]", "document.getElementById('" + hGroupFormulaCollection[investigationID] + "').value");
                }
            }
            if (tempFormula.Contains("confirm"))
            {
                sJsSaveValidationFuntion.Append(tempFormula);
            }
            else
            {
                sJsFuntion.Append(tempFormula);
            }
        }
        sJsFuntion = sJsFuntion.Replace("parseFloat([", "parseFloat(\"test_");
        sJsFuntion = sJsFuntion.Replace("])", "\")");
        sJsFuntion.Append(" } catch (e) { return true; }");
        sJsFuntion.Append("}</script>");

        sJsSaveValidationFuntion = sJsSaveValidationFuntion.Replace("parseFloat([", "parseFloat(\"test_");
        sJsSaveValidationFuntion = sJsSaveValidationFuntion.Replace("])", "\")");
        sJsSaveValidationFuntion.Append(" return true; } catch (e) { return true; }");
        sJsSaveValidationFuntion.Append("}</script>");
        //Page.RegisterClientScriptBlock("Intelligense", sJsFuntion.ToString());
        //ScriptManager.RegisterStartupScript(this.Page,Page.GetType() , "Intelligense", sJsFuntion.ToString(),false);
        //ClientScript.RegisterClientScriptBlock(Page.GetType(),"Intelligense", sJsFuntion.ToString());
        //if (!this.Page.IsStartupScriptRegistered("Intelligense"))
        //{
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligense", sJsFuntion.ToString(), false);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "IntelligenseSave", sJsSaveValidationFuntion.ToString(), false);

        foreach (string sFormulas in hIFormulaCollection.Values)
        {
            string tempFormulas = sFormulas;
            foreach (long investigationID in hInvestigationFormulaCollection.Keys)
            {
                if (tempFormulas.Contains("[" + investigatgionID + "]"))
                {
                    tempFormulas = tempFormulas.Replace("[" + investigatgionID + "]", "document.getElementById('" + hIFormulaCollection[investigatgionID] + "').value");
                }
            }
            sJsINVFuntion.Append(tempFormulas);
        }

        sJsINVFuntion.Append("}</script>");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligenseser", sJsINVFuntion.ToString(), false);
        JavaScriptSerializer jSAlert = new JavaScriptSerializer();
        //  hdnInvestigationAlertMsg.Value = jSAlert.Serialize(lstInvestigationValuesforAlert);

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

        ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ChecKGroupSum();", true);
        //}
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Lab/Home.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {

    }
    protected void tmrPostback_Tick(object sender, EventArgs e)
    {
        AutoSave();
        //Page_Load(sender, e);
    }
    private long AutoSave()
    {
        List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
        //lstPatientInvSampleResults = ucSC.GetPInvSampleResults(vid);
        //lstPatientInvSampleMapping = ucSC.GetSampleInvMapping();
        ArrayList result = new ArrayList();
        int returnStatus = -1;
        long returnCode = -1;
        long ApprovedBy = 0;

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
        List<InvestigationValues> lstPDF = new List<InvestigationValues>();  //kapil


        List<InvestigationValues> lstMicroVal = new List<InvestigationValues>();
        List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
        List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
        List<InvestigationValues> lstHPP = new List<InvestigationValues>();
        List<InvestigationValues> lstHPLP = new List<InvestigationValues>();
        List<InvestigationValues> lstABMethod = new List<InvestigationValues>();
        List<InvestigationValues> lstABQualitative = new List<InvestigationValues>();
        List<InvestigationValues> lstSemenanalysis = new List<InvestigationValues>();
        List<InvestigationValues> lstImaging = new List<InvestigationValues>();
        List<InvestigationValues> lstphsmear = new List<InvestigationValues>();
        List<InvestigationValues> lstBleedingtime = new List<InvestigationValues>();
        List<InvestigationValues> lTxtpattern = new List<InvestigationValues>();
        List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
        //kapil
        List<InvestigationValues> lstGeneralPattern = null;
        List<InvestigationValues> lstTablepatternautopopulate = null;
        List<InvestigationValues> lstRichTextPattern = null;
        List<InvestigationValues> lstHistoImageDescriptionPattern = null;
        List<InvestigationValues> lstImageDescriptionpattern = null;
        bool Flag = true;
        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
        string configApprovalSingleScreen = GetConfigValue("LabTech_Complete_Validate_Approval", OrgID);
        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */  
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
                        commanPattern = (Investigation_CommanPattern)this.Page.FindControl(result[i].ToString());
                        //InvestigationValues iVal = commanPattern.GetResult(vid);
                        List<InvestigationValues> lstcomman = new List<InvestigationValues>();
                        lstcomman = commanPattern.GetResult(vid);
                        LstOfBio.Add(lstcomman);
                        PatientInvestigation PINVComman = commanPattern.GetInvestigations(vid);
                        lstPatientInv.Add(PINVComman);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern1:
                        Investigation_checkInvest checkInvest;
                        checkInvest = (Investigation_checkInvest)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iVal = checkInvest.GetResult(vid);
                        lstBio1 = new List<InvestigationValues>();
                        if (iVal.Value != "")
                        {
                            lstBio1.Add(iVal);
                        }
                        LstOfBio.Add(lstBio1);
                        PatientInvestigation PINV1 = checkInvest.GetInvestigations(vid);
                        PINV1.AccessionNumber = checkInvest.AccessionNumber;
                        PINV1.IsAutoApproveQueue = checkInvest.IsAutoApproveQueue;
                        PINV1.IsAutoValidate = checkInvest.IsAutoValidate;
                        lstPatientInv.Add(PINV1);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern2:
                        Investigation_BioPattern2 BioPatten2;
                        BioPatten2 = (Investigation_BioPattern2)this.Page.FindControl(result[i].ToString());
                        lstBio2 = BioPatten2.GetResult(vid);
                        LstOfBio.Add(lstBio2);
                        PatientInvestigation PINV2 = BioPatten2.GetInvestigations(vid);
                        PINV2.AccessionNumber = BioPatten2.AccessionNumber;
                        PINV2.IsAutoApproveQueue = BioPatten2.IsAutoApproveQueue;
                        PINV2.IsAutoValidate = BioPatten2.IsAutoValidate;
                        lstPatientInv.Add(PINV2);
                        break;
                    case (Int32)TaskHelper.Pattern.GTTContentPattern:
                        Investigation_GTTContentPattern GTTContentPattern;
                        GTTContentPattern = (Investigation_GTTContentPattern)this.Page.FindControl(result[i].ToString());
                        lstBio2 = GTTContentPattern.GetResult(vid);
                        LstOfBio.Add(lstBio2);
                        PatientInvestigation GTTPINV = GTTContentPattern.GetInvestigations(vid);
                        GTTPINV.AccessionNumber = GTTContentPattern.AccessionNumber;
                        lstPatientInv.Add(GTTPINV);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern3:
                        Investigation_BioPattern3 BioPatten3;
                        BioPatten3 = (Investigation_BioPattern3)this.Page.FindControl(result[i].ToString());
                        lstBio3 = BioPatten3.GetResult(vid);
                        LstOfBio.Add(lstBio3);
                        PatientInvestigation PINV3 = BioPatten3.GetInvestigations(vid);
                        PINV3.AccessionNumber = BioPatten3.AccessionNumber;
                        PINV3.IsAutoApproveQueue = BioPatten3.IsAutoApproveQueue;
                        PINV3.IsAutoValidate = BioPatten3.IsAutoValidate;
                        lstPatientInv.Add(PINV3);
                        break;
                    case (Int32)TaskHelper.Pattern.FishPattern1:
                        Investigation_FishPattern1 Fishpatten;
                        Fishpatten = (Investigation_FishPattern1)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValFishpattern1 = Fishpatten.GetResult(vid);
                        lstFishpattern1 = new List<InvestigationValues>();
                        if (iValFishpattern1.Value != "")
                        {
                            lstFishpattern1.Add(iValFishpattern1);
                        }
                        LstOfBio.Add(lstFishpattern1);
                        PatientInvestigation PINVFishPattern1 = Fishpatten.GetInvestigations(vid);
                        PINVFishPattern1.AccessionNumber = Fishpatten.AccessionNumber;
                        PINVFishPattern1.IsAutoValidate = Fishpatten.IsAutoValidate;
                        lstPatientInv.Add(PINVFishPattern1);
                        break;
                    case (Int32)TaskHelper.Pattern.FishPattern2:
                        Investigation_Fishpattern2 Fishpatten3;
                        Fishpatten3 = (Investigation_Fishpattern2)this.Page.FindControl(result[i].ToString());
                        InvestigationValues iValFishpattern2 = Fishpatten3.GetResult(vid);
                        lstFishpattern2 = new List<InvestigationValues>();
                        //if (iValFishpattern2.Value != "")
                        //{
                        lstFishpattern2.Add(iValFishpattern2);
                        //}
                        LstOfBio.Add(lstFishpattern2);
                        PatientInvestigation PINVFishPattern2 = Fishpatten3.GetInvestigations(vid);
                        PINVFishPattern2.AccessionNumber = Fishpatten3.AccessionNumber;
                        PINVFishPattern2.IsAutoValidate = Fishpatten3.IsAutoValidate;
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
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern4:
                        Investigation_BioPattern4 BioPatten4;
                        BioPatten4 = (Investigation_BioPattern4)this.Page.FindControl(result[i].ToString());
                        lstBio4 = BioPatten4.GetResult(vid);
                        LstOfBio.Add(lstBio4);
                        PatientInvestigation PINV4 = BioPatten4.GetInvestigations(vid);
                        PINV4.IsAutoApproveQueue = BioPatten4.IsAutoApproveQueue;
                        PINV4.IsAutoValidate = BioPatten4.IsAutoValidate;
                        lstPatientInv.Add(PINV4);
                        break;

                    case (Int32)TaskHelper.Pattern.BioPattern5:
                        Investigation_BioPattern5 BioPatten5;
                        BioPatten5 = (Investigation_BioPattern5)this.Page.FindControl(result[i].ToString());
                        lstBio5 = BioPatten5.GetResult(vid);
                        LstOfBio.Add(lstBio5);
                        break;

                    case (Int32)TaskHelper.Pattern.MicroPattern:
                        Investigation_MicroPattern MicroPattern;
                        MicroPattern = (Investigation_MicroPattern)this.Page.FindControl(result[i].ToString());
                        lstMicroVal = MicroPattern.GetResult(vid);
                        LstOfBio.Add(lstMicroVal);
                        PatientInvestigation PINV6 = MicroPattern.GetInvestigations(vid);
                        lstPatientInv.Add(PINV6);
                        break;

                    case (Int32)TaskHelper.Pattern.ClinicalPattern12:
                        Investigation_ClinicalPattern12 Clinical12;
                        Clinical12 = (Investigation_ClinicalPattern12)this.Page.FindControl(result[i].ToString());
                        lstclinic12 = Clinical12.GetResult(vid);
                        LstOfBio.Add(lstclinic12);
                        PatientInvestigation PINV15 = Clinical12.GetInvestigations(vid);
                        lstPatientInv.Add(PINV15);
                        break;


                    case (Int32)TaskHelper.Pattern.ClinicalPattern13:
                        Investigation_ClinicalPattern13 Clinical13;
                        Clinical13 = (Investigation_ClinicalPattern13)this.Page.FindControl(result[i].ToString());
                        lstclinic13 = Clinical13.GetResult(vid);
                        LstOfBio.Add(lstclinic13);
                        PatientInvestigation PINV16 = Clinical13.GetInvestigations(vid);
                        lstPatientInv.Add(PINV16);
                        break;

                    case (Int32)TaskHelper.Pattern.FluidPattern:
                        Investigation_FluidPattern fluidpattern;
                        fluidpattern = (Investigation_FluidPattern)this.Page.FindControl(result[i].ToString());
                        lstFluid = fluidpattern.GetResult(vid);
                        LstOfBio.Add(lstFluid);
                        PatientInvestigation PINV19 = fluidpattern.GetInvestigations(vid);
                        lstPatientInv.Add(PINV19);
                        break;

                    case (Int32)TaskHelper.Pattern.hpPattern:
                        Investigation_HistoPathologyPattern histpathologypattern;
                        histpathologypattern = (Investigation_HistoPathologyPattern)this.Page.FindControl(result[i].ToString());
                        lstHPP = histpathologypattern.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation PINV20 = histpathologypattern.GetInvestigations(vid);
                        List<PatientInvestigationFiles> PtFiles = new List<PatientInvestigationFiles>();
                        PtFiles = histpathologypattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFiles)
                        {
                            PatientInvestigationFiles pFiles = new PatientInvestigationFiles();
                            pFiles.PatientVisitID = ObjP.PatientVisitID;
                            pFiles.ImageSource = ObjP.ImageSource;
                            pFiles.FilePath = ObjP.FilePath;
                            pFiles.CreatedBy = LID;
                            pFiles.OrgID = OrgID;
                            pFiles.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFiles);
                        }
                        lstPatientInv.Add(PINV20);
                        break;

                    case (Int32)TaskHelper.Pattern.HistoPathologyPatternLilavathi:

                        Investigation_HistoPathologyPatternLilavathi histoPathologyPatternLilavathi;
                        histoPathologyPatternLilavathi = (Investigation_HistoPathologyPatternLilavathi)this.Page.FindControl(result[i].ToString());
                        lstHPLP = histoPathologyPatternLilavathi.GetResult(vid);
                        LstOfBio.Add(lstHPLP);
                        PatientInvestigation PINV66 = histoPathologyPatternLilavathi.GetInvestigations(vid);
                        List<PatientInvestigationFiles> PLFiles = new List<PatientInvestigationFiles>();
                        PLFiles = histoPathologyPatternLilavathi.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PLFiles)
                        {
                            PatientInvestigationFiles pFiles = new PatientInvestigationFiles();
                            pFiles.PatientVisitID = ObjP.PatientVisitID;
                            pFiles.ImageSource = ObjP.ImageSource;
                            pFiles.FilePath = ObjP.FilePath;
                            pFiles.CreatedBy = LID;
                            pFiles.OrgID = OrgID;
                            pFiles.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(pFiles);
                        }
                        lstPatientInv.Add(PINV66);
                        break;

                    case (Int32)TaskHelper.Pattern.hpPatternQuantum:
                        Investigation_HistoPathologyPatternQuantum histpathologypatternQuantum;
                        histpathologypatternQuantum = (Investigation_HistoPathologyPatternQuantum)this.Page.FindControl(result[i].ToString());
                        lstHPP = histpathologypatternQuantum.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation PINVHisto = histpathologypatternQuantum.GetInvestigations(vid);
                        List<PatientInvestigationFiles> PtFilesQuantum = new List<PatientInvestigationFiles>();
                        PtFilesQuantum = histpathologypatternQuantum.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFilesQuantum)
                        {
                            PatientInvestigationFiles PFilesQuantum = new PatientInvestigationFiles();
                            PFilesQuantum.PatientVisitID = ObjP.PatientVisitID;
                            PFilesQuantum.ImageSource = ObjP.ImageSource;
                            PFilesQuantum.FilePath = ObjP.FilePath;
                            PFilesQuantum.CreatedBy = LID;
                            PFilesQuantum.OrgID = OrgID;
                            PFilesQuantum.InvestigationID = ObjP.InvestigationID;
                            lPFiles.Add(PFilesQuantum);
                        }
                        lstPatientInv.Add(PINVHisto);
                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivity:
                        Investigation_CultureandSensitivityReport culture;
                        culture = (Investigation_CultureandSensitivityReport)this.Page.FindControl(result[i].ToString());
                        lstHPP = culture.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation CultureTest = culture.GetInvestigations(vid);
                        lstPatientInv.Add(CultureTest);
                        break;

                    case (Int32)TaskHelper.Pattern.CultureAndSensitivityV1:
                        Investigation_CultureandSensitivityReportV1 cultureV1;
                        cultureV1 = (Investigation_CultureandSensitivityReportV1)this.Page.FindControl(result[i].ToString());
                        lstHPP = cultureV1.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation CultureTestV1 = cultureV1.GetInvestigations(vid);
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
                        lstHPP = stoneAnalysis.GetResult(vid);
                        LstOfBio.Add(lstHPP);
                        PatientInvestigation lstStoneAnalysis = stoneAnalysis.GetInvestigations(vid);
                        lstPatientInv.Add(lstStoneAnalysis);
                        break;

                    case (Int32)TaskHelper.Pattern.microbiopattern:
                        Investigation_MicroBioPattern1 microbiopattern1;
                        microbiopattern1 = (Investigation_MicroBioPattern1)this.Page.FindControl(result[i].ToString());
                        lstMicBioPattern1 = microbiopattern1.GetResult(vid);
                        LstOfBio.Add(lstMicBioPattern1);
                        PatientInvestigation PINV22 = microbiopattern1.GetInvestigations(vid);
                        lstPatientInv.Add(PINV22);
                        break;

                    case (Int32)TaskHelper.Pattern.faCellsPattern:
                        Investigation_FluidAnalysisCellsPattern facp;
                        facp = (Investigation_FluidAnalysisCellsPattern)this.Page.FindControl(result[i].ToString());
                        lstFACellsPattern = facp.GetResult(vid);
                        LstOfBio.Add(lstFACellsPattern);
                        PatientInvestigation PINV23 = facp.GetInvestigations(vid);
                        lstPatientInv.Add(PINV23);
                        break;

                    case (Int32)TaskHelper.Pattern.SMEAR:
                        Investigation_SmearAnalysis smear;
                        smear = (Investigation_SmearAnalysis)this.Page.FindControl(result[i].ToString());
                        lstSmearReport = smear.GetResult(vid);
                        LstOfBio.Add(lstSmearReport);
                        PatientInvestigation PINVsmear = smear.GetInvestigations(vid);
                        lstPatientInv.Add(PINVsmear);
                        break;

                    case (Int32)TaskHelper.Pattern.BodyFluidAnalysis:
                        Investigation_Body_Fluid_Analysis BFA;
                        BFA = (Investigation_Body_Fluid_Analysis)this.Page.FindControl(result[i].ToString());
                        lstBodyFluid = BFA.GetResult(vid);
                        LstOfBio.Add(lstBodyFluid);
                        PatientInvestigation PINVBFA = BFA.GetInvestigations(vid);
                        lstPatientInv.Add(PINVBFA);
                        break;

                    case (Int32)TaskHelper.Pattern.SemenAnalysisNewPattern:
                        Investigation_SemenAnalysisNewPattern SANP;
                        SANP = (Investigation_SemenAnalysisNewPattern)this.Page.FindControl(result[i].ToString());
                        lstSemenanalysisnew = SANP.GetResult(vid);
                        LstOfBio.Add(lstSemenanalysisnew);
                        PatientInvestigation PINVSANP = SANP.GetInvestigations(vid);
                        lstPatientInv.Add(PINVSANP);
                        break;

                    case (Int32)TaskHelper.Pattern.faChemistryPattern:
                        Investigation_FluidAnalysisChemistryPattern fachp;
                        fachp = (Investigation_FluidAnalysisChemistryPattern)this.Page.FindControl(result[i].ToString());
                        lstFAChemistryPattern = fachp.GetResult(vid);
                        LstOfBio.Add(lstFAChemistryPattern);
                        PatientInvestigation PINV24 = fachp.GetInvestigations(vid);
                        lstPatientInv.Add(PINV24);
                        break;

                    case (Int32)TaskHelper.Pattern.faCytologyPattern:
                        Investigation_FluidAnalysisCytologyPattern facyp;
                        facyp = (Investigation_FluidAnalysisCytologyPattern)this.Page.FindControl(result[i].ToString());
                        lstFACytologyPattern = facyp.GetResult(vid);
                        LstOfBio.Add(lstFACytologyPattern);
                        PatientInvestigation PINV25 = facyp.GetInvestigations(vid);
                        lstPatientInv.Add(PINV25);
                        break;

                    case (Int32)TaskHelper.Pattern.faImmunologyPattern:
                        Investigation_FluidAnalysisImmunolgyPattern faimp;
                        faimp = (Investigation_FluidAnalysisImmunolgyPattern)this.Page.FindControl(result[i].ToString());
                        lstFAImmunologyPattern = faimp.GetResult(vid);
                        LstOfBio.Add(lstFAImmunologyPattern);
                        PatientInvestigation PINV26 = faimp.GetInvestigations(vid);
                        lstPatientInv.Add(PINV26);
                        break;

                    case (Int32)TaskHelper.Pattern.FungalSmearPattern:
                        Investigation_FungalSmearPattern fsp;
                        fsp = (Investigation_FungalSmearPattern)this.Page.FindControl(result[i].ToString());
                        lstFSmearPattern = fsp.GetResult(vid);
                        LstOfBio.Add(lstFSmearPattern);
                        PatientInvestigation PINV28 = fsp.GetInvestigations(vid);
                        lstPatientInv.Add(PINV28);
                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyWithMethod:
                        Investigation_AntibodyWithMethod ABMethod;
                        ABMethod = (Investigation_AntibodyWithMethod)this.Page.FindControl(result[i].ToString());
                        lstABMethod = ABMethod.GetResult(vid);
                        LstOfBio.Add(lstABMethod);
                        PatientInvestigation PINV29 = ABMethod.GetInvestigations(vid);
                        lstPatientInv.Add(PINV29);
                        break;

                    case (Int32)TaskHelper.Pattern.AntiBodyQualitative:
                        Investigation_AntibodyQualitative Qualitative;
                        Qualitative = (Investigation_AntibodyQualitative)this.Page.FindControl(result[i].ToString());
                        lstABQualitative = Qualitative.GetResult(vid);
                        LstOfBio.Add(lstABQualitative);
                        PatientInvestigation PINV30 = Qualitative.GetInvestigations(vid);
                        lstPatientInv.Add(PINV30);
                        break;

                    case (Int32)TaskHelper.Pattern.Semenanalysis:
                        Investigation_SemenAnalysis Semenanalysis;
                        Semenanalysis = (Investigation_SemenAnalysis)this.Page.FindControl(result[i].ToString());
                        lstSemenanalysis = Semenanalysis.GetResult(vid);
                        LstOfBio.Add(lstSemenanalysis);
                        PatientInvestigation PINV31 = Semenanalysis.GetInvestigations(vid);
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
                        if (PINV32 != null)
                        {
                            lstPatientInv.Add(PINV32);
                        }
                        break;

                    case (Int32)TaskHelper.Pattern.PheripheralSmear:
                        Investigation_PeripheralSmear phSmear;
                        phSmear = (Investigation_PeripheralSmear)this.Page.FindControl(result[i].ToString());
                        lstphsmear = phSmear.GetResult(vid);
                        LstOfBio.Add(lstphsmear);
                        PatientInvestigation PINV33 = phSmear.GetInvestigations(vid);
                        lstPatientInv.Add(PINV33);
                        break;

                    case (Int32)TaskHelper.Pattern.BleedingTime:
                        Investigation_BleedingTime bleedingtime;
                        bleedingtime = (Investigation_BleedingTime)this.Page.FindControl(result[i].ToString());
                        lstBleedingtime = bleedingtime.GetResult(vid);
                        LstOfBio.Add(lstBleedingtime);
                        PatientInvestigation PINVbleedingtime = bleedingtime.GetInvestigations(vid);
                        lstPatientInv.Add(PINVbleedingtime);
                        break;

                    case (Int32)TaskHelper.Pattern.TextualPattern:
                        Investigation_TextualPattern TxtPattern;
                        TxtPattern = (Investigation_TextualPattern)this.Page.FindControl(result[i].ToString());
                        lTxtpattern = TxtPattern.GetResult(vid);
                        LstOfBio.Add(lTxtpattern);
                        PatientInvestigation PINVTxtPattern = TxtPattern.GetInvestigations(vid);

                        List<PatientInvestigationFiles> PtFiles1 = new List<PatientInvestigationFiles>();
                        PtFiles1 = TxtPattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtFiles1)
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

                        lstPatientInv.Add(PINVTxtPattern);
                        break;

                    case (Int32)TaskHelper.Pattern.GTT:
                        Investigation_GTT Gtt;
                        Gtt = (Investigation_GTT)this.Page.FindControl(result[i].ToString());
                        lTxtpattern = Gtt.GetResult(vid);
                        LstOfBio.Add(lTxtpattern);
                        PatientInvestigation PINVGtt = Gtt.GetInvestigations(vid);
                        lstPatientInv.Add(PINVGtt);
                        break;
                    case (Int32)TaskHelper.Pattern.aPTT:
                        Investigation_aPTTPattern aptt;
                        aptt = (Investigation_aPTTPattern)this.Page.FindControl(result[i].ToString());
                        lTxtpattern = aptt.GetResult(vid);
                        LstOfBio.Add(lTxtpattern);
                        PatientInvestigation PINVaptt = aptt.GetInvestigations(vid);
                        lstPatientInv.Add(PINVaptt);
                        break;

                    case (Int32)TaskHelper.Pattern.PTT:
                        Investigation_PTTPattern ptt;
                        ptt = (Investigation_PTTPattern)this.Page.FindControl(result[i].ToString());
                        lTxtpattern = ptt.GetResult(vid);
                        LstOfBio.Add(lTxtpattern);
                        PatientInvestigation PINVptt = ptt.GetInvestigations(vid);
                        lstPatientInv.Add(PINVptt);
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
                        /////////////karthick
                        PatientInvestigation PINVHisto1 = HistoImageDescriptionPattern.GetInvestigations(vid);
                        List<PatientInvestigationFiles> PtHistoFiles = new List<PatientInvestigationFiles>();
                        PtHistoFiles = HistoImageDescriptionPattern.GetInvestigationFiles(vid, out Flag);
                        foreach (PatientInvestigationFiles ObjP in PtHistoFiles)
                        {
                            PatientInvestigationFiles PtHistoFiles1 = new PatientInvestigationFiles();
                            PtHistoFiles1.PatientVisitID = ObjP.PatientVisitID;
                            PtHistoFiles1.ImageSource = ObjP.ImageSource;
                            PtHistoFiles1.FilePath = ObjP.FilePath;
                            PtHistoFiles1.CreatedBy = LID;
                            PtHistoFiles1.OrgID = OrgID;
                            PtHistoFiles1.InvestigationID = ObjP.InvestigationID;
                            PtHistoFiles1.Description = ObjP.Description;
                            lPFiles.Add(PtHistoFiles1);
                        }
                        lstPatientInv.Add(PINVHisto1);
                        break;
                    case (Int16)TaskHelper.Pattern.ImageDescriptionpattern:
                        Investigation_ImageDescriptionpattern ImageDescriptionPattern;
                        ImageDescriptionPattern = (Investigation_ImageDescriptionpattern)this.Page.FindControl(result[i].ToString());
                        lstImageDescriptionpattern = ImageDescriptionPattern.GetResult(vid);
                        LstOfBio.Add(lstImageDescriptionpattern);

                        PatientInvestigation ptdes1 = ImageDescriptionPattern.GetInvestigations(vid);
                        //PINV3.AccessionNumber = BioPatten3.AccessionNumber;               
                        List<PatientInvestigationFiles> ptdes2 = new List<PatientInvestigationFiles>();
                        ptdes2 = ImageDescriptionPattern.GetInvestigationFiles(vid, out Flag);
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
                }
            }
            // int completed = -1;
            chkStatus = "Pending";
            foreach (var O in lstPatientInv)
            {
                if (O.Status == "Completed" || O.Status == "PartiallyCompleted")
                {
                    chkStatus = "Completed";
                    break;
                }
                if (O.Status == "Validate" || O.Status == InvStatus.PartiallyValidated)
                {
                    chkStatus = "Validate";
                }
                if (O.Status == "Approve" || O.Status == InvStatus.Approved)
                {
                    ApprovedBy = LID;
                    /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    O.ApprovedBy = O.LoginID; //Added
                    //O.AuthorizedBy = LID;   //Comm
                    /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                }
            }
            int deptID = Convert.ToInt32(hdnDept.Value);
            Investigation_BL saveResults = new Investigation_BL(base.ContextInfo);

            //code added on 23-07-2010 QRM - Started
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
            //code added on 23-07-2010 QRM - Completed
            //code added on Group Level Comment - begins

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
                        objPInv.OrgID = OrgID;

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
                            else if (s1.Value == "Auto" || s1.Value == "")
                            {
                                //added by jegan
                                if (s1.Value == "")
                                    lstPatientInv[i].IsAutoValidation = "Not Apporved";//its shouldnot allow to approve 

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
                            //Added by Jegan
                            if (s1.Value == "Black")
                            {
                                lstPatientInv[i].IsAbnormal = "N";
                                //lstPatientInv[i].IsAutoAuthorize = "N";
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

            List<PatientInvestigation> resultantList = ((from child in lstPatientInv
                                                         where child.GroupID > 0 && child.IsAutoAuthorize == "N"
                                                         select child).Distinct()).ToList();

            if (resultantList.Count() > 0)
            {
                foreach (PatientInvestigation obj in resultantList)
                {
                    lstPatientInv.Where(x => x.GroupID == obj.GroupID && x.IsAutoAuthorize == "Y").ToList().ForEach(Y => { Y.IsAutoAuthorize = "N"; });
                }
            }

            if (hdnhigh.Value != "")
            {
                List<NameValuePair> lstHighRangeDetails = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnhigh.Value);
                List<InvestigationValues> obj_values = new List<InvestigationValues>();
                int i = 0;

                foreach (List<InvestigationValues> obj in LstOfBio)
                {

                    if (obj.Count > 0)
                    {
                        foreach (NameValuePair s1 in lstHighRangeDetails)
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
                //////////////karthick//////////////////
                ////////else if (O.Status == "Completed" && O.AutoApproveLoginID > 0 && hdnIsExcludeAutoApproval.Value == "N" && O.IsAutoAuthorize == "Y")
                ////////{
                ////////    if (O.IsAutoApproveQueue != "Y" && Convert.ToInt32(hdnAutoApproveQueueCount.Value) == 0 && Convert.ToInt32(hdnNormalApproveTestCount.Value) == 0)
                ////////    {
                ////////        // O.Status = "Approve";
                ////////    }
                ////////    //O.Status = "Approve";
                ////////    if (hdnIsAutoAuthRecollect.Value != "0" && hdnIsAutoAuthRecollect.Value != "" && O.Status == "Validate")
                ////////    {
                ////////        O.IsAutoAuthorize = "N";
                ////////    }
                ////////    else
                ////////    {
                ////////        O.IsAutoAuthorize = "Y";
                ////////        O.ApprovedBy = O.AutoApproveLoginID;
                ////////    }
                ////////}
                //////////////karthick//////////////////
                else if (O.Status == "Completed" && (O.IsAbnormal == "N" || O.IsAbnormal == "") && O.AutoApproveLoginID > 0 && hdnIsExcludeAutoApproval.Value == "N" && O.IsAutoAuthorize == "Y")
                {
                    string AutoCertifywithQC = GetConfigValues("AutoCertifyWithQC", OrgID);
                    if (AutoCertifywithQC == "Y" && O.QCData == "1")
                    {
                        if (O.IsAutoValidation != "Not Apporved")
                        {

                            if (O.DeltaLowerLimit != 0 && O.DeltaHigherLimit != 0)
                            {
                                decimal val = 0;
                                bool isNum = decimal.TryParse(O.Value, out val);
                                if (isNum)
                                {
                                    if (O.DeltaLowerLimit != 0 && val >= O.DeltaLowerLimit && val <= O.DeltaHigherLimit)
                                    {
                                        O.Status = "Approve";
                                    }
                                    else
                                    {
                                        O.Status = "Completed";
                                    }
                                }
                                else
                                {
                                    O.Status = "Completed";
                                }
                            }
                            else
                            {
                                O.Status = "Approve";
                            }
                        }
                        else
                        {
                            O.Status = "Completed";
                        }
                    }
                    else if (O.IsAutoValidation != "Not Apporved")
                    {

                        O.Status = "Approve";
                    }
                    else
                    {
                        O.Status = "Completed";
                    }

                    O.IsAutoAuthorize = "Y";
                    O.ApprovedBy = O.AutoApproveLoginID;
                }
                else if (O.Status != "Completed" || O.IsAbnormal == "A" || O.IsAbnormal == "L" || O.IsAbnormal == "P")//|| O.AutoApproveLoginID != LID)
                {
                    AllowAutoApproveTask = "No";
                    O.IsAutoAuthorize = "N";
                    PendingCount += 1;
                }
                else if (O.Status == "Completed")
                {
                    AllowAutoApproveTask = "No";
                    O.IsAutoAuthorize = "N";
                    PendingCount += 1;
                }


                //else if (O.Status != "Completed" || O.IsAbnormal == "A" || O.IsAbnormal == "L" || O.IsAbnormal == "P")//|| O.AutoApproveLoginID != LID)
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}
                //else if (O.Status == "Completed")
                //{
                //    AllowAutoApproveTask = "No";
                //    O.IsAutoAuthorize = "N";
                //    PendingCount += 1;
                //}
                if (O.IsAutoValidation == "Not Apporved")//Added by jegan 
                    AllowAutoApproveTask = "No";
            }
            if (PendingCount == 0)
            {
                AllowAutoApproveTask = "Yes";
            }

            //Revert Auto Approve Status
            foreach (var O in lstPatientInv)
            {
                if (O.Status != "Approve" && O.IsAutoValidation != "Not Apporved")//added by jegan
                {
                    if (hFormulaInvCollectionSet[O.GroupID] != null)
                    {
                        var SplitKey = hFormulaInvCollectionSet[O.GroupID].ToString().Split('^');
                        foreach (var intTest in SplitKey)
                        {
                            if (intTest.Contains(O.InvestigationID.ToString()))
                            {
                                foreach (var O1 in lstPatientInv)
                                {
                                    if (intTest.Contains(O1.InvestigationID.ToString()))
                                    {
                                        if (O1.Status == "Approve")
                                        {
                                            O1.Status = "Completed";
                                            O.IsAutoAuthorize = "N";
                                            O1.ApprovedBy = 0;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
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
                if (O.Status == InvStatus.ReflexWithNewSample)
                {
                    chkStatus = InvStatus.ReflexWithNewSample;
                }
                if (O.Status == InvStatus.ReflexWithSameSample)
                {
                    chkStatus = InvStatus.ReflexWithSameSample;
                }
            }

            //foreach (var O in lstPatientInv)
            //{
            //    if (O.Status == "Approve")
            //    {
            //        O.Status = "Pending";
            //        O.ApprovedBy = 0;
            //    }
            //}

            List<PatientInvestigation> lstPI = lstPInvestigation;
            //code added on Group Level Comment - ends


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
                //code added on 23-07-2010 QRM - Started
                returnCode = saveResults.SaveQRMData(lstInvBulkData);
                returnCode = saveResults.SaveGroupComments(lstPInvestigation, gUID);
                //code added on 23-07-2010 QRM - Completed
                string isFromDevice = "N";

                ////Added by Arivalagan.kk for Hide status investigationID//
                var RemoveInvestigationID = from A in LstINVHideStatus select A.InvestigationID;
                lstPatientInv.RemoveAll(x => RemoveInvestigationID.Contains(x.InvestigationID));
                ////Added by Arivalagan.kk for Hide status investigationID//
                /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                ///LID[Approved by ] Provided instead for 0 inbetween deptid vs guid
                /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                if (configApprovalSingleScreen == "Y")
                {
                    returnCode = saveResults.SaveInvestigationResultsSingleScreen(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, OrgID, deptID, LID, gUID, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice);
                    if (returnCode > -1)
                    {
                        if (lstPatientInv.Any(obj => obj.Status == "Cancel"))
                        {
                            returnCode = saveResults.UpdatenotificationforCancel(lstPatientInv[0].PatientVisitID);
                        }
                    }
                }
                else
                {
                    List<PatientInvestigationAttributes> lstpat = new List<PatientInvestigationAttributes>();
                    returnCode = saveResults.SaveInvestigationResults(pSCMID, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, OrgID, deptID, LID, gUID, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice,lstpat);
                    if (returnCode > -1)
                    {
                        if (lstPatientInv.Any(obj => obj.Status == "Cancel"))
                        {
                            returnCode = saveResults.UpdatenotificationforCancel(lstPatientInv[0].PatientVisitID);
                        }
                    }
                }
                /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */


                List<PatientInvestigation> lstReflex = lstPatientInv.FindAll(P => P.Status == InvStatus.ReflexWithNewSample || P.Status == InvStatus.ReflexWithSameSample);
                if (lstReflex.Count() > 0)
                {
                    ucReflexTest.saveInvestigationQueue(lstReflex);
                }
            }
            int reclt = 0;
            reclt = lstPatientInv.FindAll(p => p.Status == "Retest").Count();
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
                    PC.ActionType = "";
                    PC.IDS = accessionnumber;
                    lstpagecontextkeys.Add(PC);
                    long res = -1;
                    res = AM.PerformingNextStepNotification(PC, "", "");
                }
            }

            ////------------------------------------------------------------------////////////////
            int cnt = 0;
            int cntPA = 0;
            int cntWH = 0;
            int cntRJ = 0;
            cnt = lstPatientInv.FindAll(p => p.Status == "Approve").Count();
            cntPA = lstPatientInv.FindAll(p => p.Status == "PartiallyApproved").Count();
            cntWH = lstPatientInv.FindAll(p => p.Status == "With Held").Count();
            cntRJ = lstPatientInv.FindAll(p => p.Status == "Reject").Count();
            if (cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
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
                PC.ActionType = "";
                lstpagecontextkeys.Add(PC);
                long res = -1;
                res = AM.PerformingNextStepNotification(PC, "", "");
            }
            string LabNo = string.Empty;
            List<PatientInvestigation> lstRecheck = lstPatientInv.FindAll(P => P.Status == InvStatus.Recheck);
            if (lstRecheck.Count > 0)
            {
                long RefID = -1; string RefType = "";
                List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
                PatientVisit PatientVisit = new PatientVisit();
                returnCode = InvestigationBL.GetNextBarcode(Convert.ToInt32(hdnOrgID.Value), ILocationID, "INV", out LabNo, RefID, RefType);
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
                    //    returnCode = InvestigationBL.SaveOrderedInvestigation(ordInves, Convert.ToInt32(hdnOrgID.Value));
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
                    InvestigationBL.GetInvestigationSamplesCollect(Convert.ToInt64(hdnVID.Value), Convert.ToInt32(hdnOrgID.Value), RoleID, gUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

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
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        if (configApprovalSingleScreen == "Y")
                        {
                            returnCode = InvestigationBL.SavePatientInvestigationSingleScreen(SaveInvestigation, Convert.ToInt32(hdnOrgID.Value), gUID, out pOrderedCount);
                        }
                        else
                        {
                            returnCode = InvestigationBL.SavePatientInvestigation(SaveInvestigation, Convert.ToInt32(hdnOrgID.Value), gUID, out pOrderedCount);
                        }
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    }
                    if (returnCode > -1)
                    {
                        /* BEGIN | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                        if (configApprovalSingleScreen == "Y")
                        {
                            returnCode = InvestigationBL.SavePatientInvSampleNMappingSingleScreen(LstPinvsample, LstPinvsamplemapping, gUID, Convert.ToInt32(hdnOrgID.Value));
                        }
                        else
                        {
                            returnCode = InvestigationBL.SavePatientInvSampleNMapping(LstPinvsample, LstPinvsamplemapping, gUID, Convert.ToInt32(hdnOrgID.Value));
                        }
                        /* END | NA | Sabari | 17072019 | Created | LabTechPhysicianUsers */
                    }
                }
                else
                {
                    returnCode = 0;
                }
            }

        }

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
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
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
        }
    }
    protected void grdResult_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            patientVisitID = Convert.ToInt64(vid);
            ShowReport(reportPath, patientVisitID, reportID, 0);
        }
    }
    protected void dlChildInvName_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "ShowReport")
        {
            reportID = ((Label)e.Item.FindControl("lblReportID")).Text;
            reportPath = ((Label)e.Item.FindControl("lblReportname")).Text;
            investigatgionID = Convert.ToInt64(((Label)e.Item.FindControl("lblInvID")).Text);
            patientVisitID = Convert.ToInt64(vid);
            ShowReport(reportPath, patientVisitID, reportID, investigatgionID);
        }
    }
    //code added on 23-07-2010 QRM - Started
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
    //code added on 23-07-2010 QRM - Completed
    //code added Reference Range - Started - altered on 13-10-2011 by mohan for medall
    public void RaiseCallbackEvent(String eventArgument)
    {
        rawData = eventArgument;

        //ValidateUserResult(rawData, out textColor);
        //validateAllRange(rawData);

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
    }
    public string GetCallbackResult()
    {
        // return textColor.ToString();
        return hdnGenderAge.Value.ToString();
    }
    public void ConvertXmlToString(string xmlData, string uom, out string NormalReferenceRange, out string OtherReferenceRange, out string PrintableRange)
    {
        NormalReferenceRange = string.Empty;
        OtherReferenceRange = string.Empty;
        PrintableRange = string.Empty;
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
            oLabUtil.ConvertXmlToString(xmlData, uom, hdnPatientGender.Value, hdnpagearraw.Value, out NormalReferenceRange, out OtherReferenceRange, out PrintableRange);
            NormalReferenceRange = !String.IsNullOrEmpty(NormalReferenceRange) ? NormalReferenceRange.Trim().Replace("<br>", "\n") : string.Empty;
            PrintableRange = !String.IsNullOrEmpty(PrintableRange) ? PrintableRange.Trim().Replace("<br>", "\n") : string.Empty;
        }
        catch (Exception ex)
        {
            NormalReferenceRange = string.Empty;
            PrintableRange = string.Empty;
            CLogger.LogError("Error while parsing reference range xml", ex);
        }
    }
    long ConvertToDays(int age, string agetype)
    {
        long ageInDays = 0;

        switch (agetype)
        {
            case "Weeks":
                ageInDays = age * 7;
                break;
            case "Months":
                ageInDays = age * 30;
                break;
            case "Years":
                ageInDays = age * 12 * 30;
                break;
            case "Days":
                ageInDays = age;
                break;
        }
        return ageInDays;

    }
    // code added to include Save & home feature - BEGIN
    public void IncludeMethodKit()
    {
        if (Request.QueryString["vid"] != null)
        {
            Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
        }

        if (Request.QueryString["gUID"] != null)
        {
            gUID = Request.QueryString["gUID"].ToString();
        }
        int Deptid = -1;
        Int32.TryParse(hdnDept.Value, out Deptid);
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientInvestigation> lstPatientInvestigation2 = new List<PatientInvestigation>();
        new Investigation_BL(base.ContextInfo).GetInvMethodKit(vid, OrgID, Deptid, gUID, out lstPatientInvestigation);
        string strMethodKitData = string.Empty;
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation obj in lstPatientInvestigation)
            {
                if ((obj.Interpretation != "" && obj.Interpretation != null) || (obj.MethodName != "" && obj.MethodName != null) || (obj.KitName != "" && obj.KitName != null) || (obj.InstrumentName != "" && obj.InstrumentName != null) || (obj.PrincipleName != "" && obj.PrincipleName != null) || (obj.QCData != "" && obj.QCData != null))
                {
                    if (obj.Interpretation == "" || obj.Interpretation == null)
                    {
                        obj.Interpretation = "--";
                    }
                    if (obj.MethodName == "" || obj.MethodName == null)
                    {
                        obj.MethodName = "--";
                    }
                    if (obj.KitName == "" || obj.KitName == null)
                    {
                        obj.KitName = "--";
                    }
                    if (obj.InstrumentName == "" || obj.InstrumentName == null)
                    {
                        obj.InstrumentName = "--";
                    }
                    if (obj.PrincipleName == "" || obj.PrincipleName == null)
                    {
                        obj.PrincipleName = "--";
                    }
                    if (obj.QCData == "" || obj.QCData == null)
                    {
                        obj.QCData = "--";
                    }

                }
                strMethodKitData += obj.InvestigationID + obj.InvestigationMethodID + obj.KitID + obj.InstrumentID + "~" + obj.InvestigationID + "~" + obj.InvestigationMethodID + "~" + obj.KitID + "~" + obj.InstrumentID + "~" + obj.Interpretation + "~" + obj.InvestigationName + "~" + obj.MethodName + "~" + obj.KitName + "~" + obj.InstrumentName + "~" + "INV" + "~" + obj.PrincipleID + "~" + obj.PrincipleName + "~" + obj.QCData + "^";
            }
        }

        foreach (string splitString in strMethodKitData.Split('^'))
        {
            PatientInvestigation objPatientInvestigation = new PatientInvestigation();
            if (splitString != string.Empty)
            {
                string[] lineItems = splitString.Split('~');
                objPatientInvestigation.OrgID = OrgID;
                objPatientInvestigation.PatientVisitID = vid;
                if (lineItems[10] == "INV")
                {
                    objPatientInvestigation.InvestigationID = Convert.ToInt64(lineItems[1]);
                    objPatientInvestigation.InvestigationName = lineItems[6];
                }
                else if (lineItems[10] == "GRP")
                {
                    objPatientInvestigation.GroupID = Convert.ToInt32(lineItems[1]);
                    objPatientInvestigation.GroupName = lineItems[6].Replace(":", "");
                }
                objPatientInvestigation.Type = lineItems[10];
                objPatientInvestigation.InvestigationMethodID = Convert.ToInt64(lineItems[2]);
                objPatientInvestigation.KitID = Convert.ToInt64(lineItems[3]);
                objPatientInvestigation.InstrumentID = Convert.ToInt64(lineItems[4]);
                objPatientInvestigation.PrincipleID = Convert.ToInt64(lineItems[11]);
                if (lineItems[5] != "--")
                {
                    objPatientInvestigation.Interpretation = lineItems[5];
                }
                if (lineItems[7] != "--")
                {
                    objPatientInvestigation.MethodName = lineItems[7];
                }
                if (lineItems[8] != "--")
                {
                    objPatientInvestigation.KitName = lineItems[8];
                }
                if (lineItems[9] != "--")
                {
                    objPatientInvestigation.InstrumentName = lineItems[9];
                }
                if (lineItems[12] != "--")
                {
                    objPatientInvestigation.PrincipleName = lineItems[12];
                }
                if (lineItems[13] != "--")
                {
                    objPatientInvestigation.QCData = lineItems[13];
                }
                lstPatientInvestigation2.Add(objPatientInvestigation);
            }
        }

        new Investigation_BL(base.ContextInfo).SaveInvestigationMethodKit(vid, OrgID, Deptid, lstPatientInvestigation2);

    }
    // code added to include Save & home feature - END
    //Medical Remarks
    private PatientInvestigation AddMedicalRemarks(PatientInvestigation objPInv, List<PatientInvestigation> lstPInvestigation, int intRowNum)
    {
        if (groupMedCommentHDN1.Value != "")
        {
            string[] grpLineItems = groupMedCommentHDN1.Value.Split('^');
            //foreach (string str in groupMedCommentHDN1.Value.Split('^'))
            {
                //string[] lineItems = str.Split('~');
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

    //protected void btnReflex_Click(object sender, EventArgs e)
    //{
    //    Investigation_BL Delta_BL = new Investigation_BL(new BaseClass().ContextInfo);
    //    List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
    //    //~/Investigation/FishPattern1.ascx
    //    Investigation_ReflexTest ReflexTest;
    //    ReflexTest = (Investigation_ReflexTest)LoadControl("~/Investigation/ReflexTest.ascx");
    //    try
    //    {
    //            string gen;
    //            HiddenField obj = (HiddenField)PatientDetail.FindControl("hdnClientID");
    //            string ClientID = obj.Value;
    //            HiddenField obj1 = (HiddenField)PatientDetail.FindControl("hdnGender");
    //            string Gender = obj1.Value;                
    //            gen = Gender == "Male" ? "M" : "F";

    //            //ucReflexTest.fnloadOrderedInvestigation(vid, ClientID, gen);

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Reflex Test Added", ex);
    //    }
    //}
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
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static void AutoSaveHisto(List<List<InvestigationValues>> LstinvValues, List<PatientInvestigation> lstPatientInvs, long vid, string guid, int orgid)
    {
        try
        {
            List<List<InvestigationValues>> lstvalue = new List<List<InvestigationValues>>();
            PageContextkey PageContextDetails = new PageContextkey();
            int returnStatus = -1;
            long pSCMID = -1;
            long returnCode = -1;
            int deptID = -1;
            string isFromDevice = "N";
            List<PatientInvestigation> lstFinalReflexPatientinvestigation = new List<PatientInvestigation>();
            List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
            List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
            List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
            Investigation_BL saveResults = new Investigation_BL(new BaseClass().ContextInfo);
            List<PatientInvestigationAttributes> lstpat = new List<PatientInvestigationAttributes>();
            returnCode = saveResults.SaveInvestigationResults(pSCMID, LstinvValues, lstPatientInvs, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, 0, deptID, orgid, guid, PageContextDetails, out returnStatus, lstFinalReflexPatientinvestigation, isFromDevice, lstpat);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Erro while autosave Histo values", ex);
        }
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string createXMLDoc(string id)
    {
        XmlDocument xmlDoc = new XmlDocument();
        XmlElement xmlTable1Element;
        List<XmlElement> lstTable1XmlElement = new List<XmlElement>();
        xmlDoc.LoadXml("<InvestigationResults></InvestigationResults>");
        XmlAttribute xmlAttribute;
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strGenResult = id.ToString();
            List<List<string>> lstGenResult = new List<List<string>>();
            if (!String.IsNullOrEmpty(strGenResult))
            {
                lstGenResult = serializer.Deserialize<List<List<string>>>(strGenResult);
                //  hdnBindData.Value = oJavaScriptSerializer.Serialize(lstTable);
            }
            int cellCount = 1;
            int rowCount = 1;
            foreach (List<string> rows in lstGenResult)
            {
                cellCount = 1;
                foreach (string cell in rows)
                {
                    xmlTable1Element = xmlDoc.CreateElement("Item");

                    xmlAttribute = xmlDoc.CreateAttribute("Value");
                    xmlAttribute.Value = string.IsNullOrEmpty(cell) ? string.Empty : cell;
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                    xmlAttribute.Value = rowCount.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                    xmlAttribute.Value = cellCount.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                    xmlAttribute.Value = rows.Count.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    cellCount = cellCount + 1;
                    xmlDoc.DocumentElement.AppendChild(xmlTable1Element);
                }
                rowCount = rowCount + 1;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating xml", ex);
        }
        // hdnXMLDoc.Value = xmlDoc.InnerXml;
        StringWriter sw = new StringWriter();
        XmlTextWriter xw = new XmlTextWriter(sw);
        xmlDoc.WriteTo(xw);
        return sw.ToString();
        // return xmlDoc.InnerXml.ToString();
    }

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