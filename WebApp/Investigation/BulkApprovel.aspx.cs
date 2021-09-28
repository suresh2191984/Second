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

using Attune.Podium.PerformingNextAction;

public partial class Investigation_BulkApprovel : BasePage
{
    public Investigation_BulkApprovel()
        : base("Investigation_BulkApprovel_aspx")
    {
    }
    #region Initialization
    string Formula = string.Empty;
    string FormulaINV = string.Empty;
    Control myControl = null;
   
    List<PatientInvestigation> lstOrdered = new List<PatientInvestigation>();
    List<InvestigationStatus> header = new List<InvestigationStatus>();
    long vid = 0;

    ArrayList lstControl = new ArrayList();
    ArrayList lstpatternID = new ArrayList();
    Hashtable hFormulaCollection = new Hashtable();
    Hashtable hSCbcFormulaCollection = new Hashtable();
    Hashtable hFormulaInvCollectionSet = new Hashtable();
    Hashtable hGroupFormulaCollection = new Hashtable();

    Hashtable hIFormulaCollection = new Hashtable();
    Hashtable hInvestigationFormulaCollection = new Hashtable();

    List<InvestigationValues> DemoBulk, lstPendingValue, lstPendingval = new List<InvestigationValues>();
    List<InvestigationOrgMapping> lstiom, lstiominv = new List<InvestigationOrgMapping>();
    #endregion

    Investigation_BL objInvBL;
    List<PatientInvestigation> lstpatinvestigation = new List<PatientInvestigation>();
    List<InvOrgGroup> lstInvOrgGroup = new List<InvOrgGroup>();
    string gUID = string.Empty;
    string IsExcludeAutoApproval;
    string AllowAutoApproveTask = string.Empty;
    long returncode = -1;
    System.Text.StringBuilder sJsFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsINVFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntion = new System.Text.StringBuilder();
    System.Text.StringBuilder sJsSaveValidationFuntionEmptyValue = new System.Text.StringBuilder();
    string strLabTechToEditMedRem = "";
    string VisitIDs = "0";
    string BarcodeNumber = string.Empty;
    string InvType = string.Empty;
    string InvName = string.Empty;
    long InvID = 0;
    long worklistid = 0;
    int hdnhighcount = 0;
    long deviceid = 0;
    string isAbnormalResult = "0";
    long headerID = 0;
    long protocalID = 0;
    int deptID = 0;
    string isMaster = "N";
    int recordCount = 0;
    int AutoApproveQueueCount = 0;
    int NormalApproveTestCount = 0;
    int IsAutoAuthRecollect = 0;
    int pageNo = 1;
    string InvType1 = string.Empty;
    string InvName1 = string.Empty;
    long InvID1 = 0;
    string Visittype = "-1";
    string Location1 = "0";
    string IsDefault = "N";
    string QcCheck = "0";
    string PatIds = string.Empty;
    string CheckQcChecks = "0";
    string accessionnumber = string.Empty;
    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
    List<string> lstFormula = new List<string>();
    List<PatientInvestigation> lstPatientInvestigation3 = new List<PatientInvestigation>();
    List<PatientInvestigation> lsttmpPatientInvestigation = new List<PatientInvestigation>();
    List<PatientInvestigation> lstInvestigationValuesforAlert = new List<PatientInvestigation>();
    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_03 == null ? "---Select---" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_03;
    string strYear= Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_10 == null ? "Year(s)" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_10;
    string strMonth= Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_11 == null ? "Month(s)" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_11;
    string strWeek= Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_12 == null ? "Week(s)" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_12;
    string strDay= Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_13 == null ? "Day(s)" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_13;
    string strMale = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_14 == null ? "Male" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_14;
    string strFemale = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_15 == null ? "Female" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_15;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        string strBatch = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_04 == null ? "Batch Wise Validate Result" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_04;

        string strApproval = Resources.Investigation_ClientDisplay.Investigation_BulkApproval_aspx_01 == null ? "Bulk Approvel" : Resources.Investigation_ClientDisplay.Investigation_BulkApproval_aspx_01;

        objInvBL = new Investigation_BL(base.ContextInfo);

        try
        {
            if (string.IsNullOrEmpty(hdnIsCancelLoad.Value) || hdnIsCancelLoad.Value != "1")
            {
                sJsFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKGroupSum(id){ try { ");
                sJsINVFuntion.Append("<script language ='javascript' type ='text/javascript'>function ChecKINVSum(){");
                sJsSaveValidationFuntion.Append("<script language ='javascript' type ='text/javascript'>function CheckSaveValidationFuntion(){ try { ");
                if (!IsPostBack)
                {
                    Session["PostID"] = "1001";
                    ViewState["PostID"] = Session["PostID"].ToString();
                    hdnLID.Value = Convert.ToString(LID);
                    GateWay gateWay = new GateWay(base.ContextInfo);

                    List<Config> lstConfig = new List<Config>();


                    strLabTechToEditMedRem = GetConfigValues("CanLabTechEditMedRem", OrgID);
                    hdnstatuschange.Value = GetConfigValues("StatusChangeByOrg", OrgID);
                    hdnIscommonValidation.Value = GetConfigValues("EnterResultCommonValidation", OrgID);
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

                    ScriptManager1.RegisterPostBackControl(btnBatchSearch);
                    ScriptManager1.RegisterPostBackControl(btnSave);
                    ScriptManager1.RegisterPostBackControl(Button2);
                    ScriptManager1.RegisterPostBackControl(imgNextPage);
                    Session["formula"] = null;
                    hdnOutofrangeCount.Value = "0";
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
                    ddlInstrument.Items.Insert(0, strSelect.Trim());
                    ddlInstrument.Items[0].Value = "0";

                    /* Added Parthi*/
                    ddlAnalyzer.DataSource = lstInstrumentMaster;
                    ddlAnalyzer.DataTextField = "InstrumentName";
                    ddlAnalyzer.DataValueField = "InstrumentID";
                    ddlAnalyzer.DataBind();
                    ddlAnalyzer.Items.Insert(0, strSelect.Trim());
                    ddlAnalyzer.Items[0].Value = "0";

                    ddlDepartment.DataSource = lstDeptMaster;
                    ddlDepartment.DataTextField = "DeptName";
                    ddlDepartment.DataValueField = "DeptID";
                    ddlDepartment.DataBind();
                    ddlDepartment.Items.Insert(0, strSelect.Trim());
                    ddlDepartment.Items[0].Value = "0";

                    ddlDept.DataSource = lstDeptMaster;
                    ddlDept.DataTextField = "DeptName";
                    ddlDept.DataValueField = "DeptID";
                    ddlDept.DataBind();
                    ddlDept.Items.Insert(0, strSelect.Trim());
                    ddlDept.Items[0].Value = "0";

                    ddlHeader.DataSource = lstInvHeaderMaster;
                    ddlHeader.DataTextField = "HeaderName";
                    ddlHeader.DataValueField = "HeaderID";
                    ddlHeader.DataBind();
                    ddlHeader.Items.Insert(0, strSelect.Trim());
                    ddlHeader.Items[0].Value = "0";

                    ddlProtocol.DataSource = lstProtocolGroupMaster;
                    ddlProtocol.DataTextField = "DisplayText";
                    ddlProtocol.DataValueField = "MetadataID";
                    ddlProtocol.DataBind();
                    ddlProtocol.Items.Insert(0, strSelect.Trim());
                    ddlProtocol.Items[0].Value = "0";
                    LoadMetaData();
                    LoadLocationNEW();
                }
                if (Request.QueryString["Action"] != null)
                {
                    hdnActionName.Value = Request.QueryString["Action"];
                    Session["Action"] = hdnActionName.Value;
                }
                if (hdnActionName.Value == "Validate")
                {
                    lblPageHeader.Text = strBatch.Trim();
                    hdnDefaultDropDownStatus.Value = "Validate";
                    Session["Action"] = hdnActionName.Value;
                }
                if (hdnActionName.Value == "Approvel")
                {
                    lblPageHeader.Text = strApproval.Trim();
                    hdnDefaultDropDownStatus.Value = "Approve";
                    Session["Action"] = hdnActionName.Value;
                  //  DivApproval.Visible = true;
                    //Panel1.Visible = false;
                }
           
            }
            List<InvReasonMasters> lstInvReasonMaster = new List<InvReasonMasters>();
            long returnCode = -1;
            returnCode = new Investigation_BL(base.ContextInfo).GetInvReasons(Convert.ToInt32(hdnOrgID.Value), out lstInvReasonMaster);
            JavaScriptSerializer reasonserializer = new JavaScriptSerializer();
            hdnlstreasons.Value = reasonserializer.Serialize(lstInvReasonMaster);

            hdnRoleName.Value = RoleName;
            
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on page_load", ex);
        }
    }
    public bool IsValidPost()
    {
        if (ViewState["PostID"].ToString()
            == Session["PostID"].ToString())
        {
            Session["PostID"] =
            (Convert.ToInt16(Session["PostID"]) + 1).ToString();

            ViewState["PostID"] = Session["PostID"].ToString();

            return true;
        }
        else
        {
            ViewState["PostID"] =
             Session["PostID"].ToString();

            return false;
        }

    }
    #endregion

    #region "Events"
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

        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation_BatchwiseEnterResilt on Button1_Click", ex);
        }
    }
    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {
        if (IsValidPost())
        {
            try
            {
                hdnTotalLoadedRecords.Value = "0";
                hdnPageNo.Value = "1";
                lblPageNo.Text = hdnPageNo.Value;
                //if (hdnActionName.Value != "Approvel")
                //{
                //    search();
                //}
                //else if (hdnActionName.Value == "Approvel")
                //{
                //    search();
                //}
                search();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in btnBatchSearch_Click at BatchWiseEnterResult Page", ex);
            }
        }

    }
    protected void imgNextPage_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int pageNo = 1;
            Int32.TryParse(hdnPageNo.Value, out pageNo);
            hdnPageNo.Value = Convert.ToString(pageNo + 1);
            lblPageNo.Text = hdnPageNo.Value;
            search();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in imgNextPage_Click at BatchWiseEnterResult Page", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            SaveContinue();
            hdnOutOfRangeDetails.Value = "";
            hdnHighRangeDetails.Value = "";
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    protected void btnApproval_Click(object sender, EventArgs e)
    {
        //if (Convert.ToInt32(hdnCheckCount.Value) > 0)
        //{
           try
            {
                PageContextDetails.ButtonName = ((Button)sender).ID;
                PageContextDetails.ButtonValue = ((Button)sender).Text;
                SaveContinue();
            }
            catch (Exception ex)
            {
                CLogger.LogError("", ex);
            }
        //}
        //else
        //{ 
      
        //}
    }


    //protected void chkDefault_Changed(Object sender, EventArgs e)
    //{

        //Tasks_BL taskBL = new Tasks_BL();
        //long retval = -1;
        //TaskProfile taskprofile = new TaskProfile();
        //if (chkDefault.Checked)
        //{
        //    retval = taskBL.InsertDefault(taskprofile);
        //    GetTasks(currentPageNo, PageSize);
        //}
        //else
        //{
        //    GetTasks(currentPageNo, PageSize);
        //}
    //}
    #endregion

    # region Methods
    public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_03 == null ? "---Select---" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_03;

        try
        {
            long returncode = -1;
            string domains = "Btc_Type,VisitType,DeltaCheck,QcCheck";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput,OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 orderby child.Code descending 
                                 where child.Domain == "Btc_Type" //&& child.DisplayText!="All"
                                 select child;
                ddlResultType.DataSource = childItems;
                ddlResultType.DataTextField = "DisplayText";
                ddlResultType.DataValueField = "Code";
                ddlResultType.DataBind();
                ddlResultType.Items.Insert(0, strSelect.Trim());
                ddlResultType.Items[0].Value = "0";

                /* Added Parthi*/
                ddlResultypes.DataSource = childItems;
                ddlResultypes.DataTextField = "DisplayText";
                ddlResultypes.DataValueField = "Code";
                ddlResultypes.DataBind();
                ddlResultypes.Items.Insert(0, strSelect.Trim());
                ddlResultypes.Items[0].Value = "0";

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType" //&& child.Code!="-1"
                                  select child;

                ddlVisitType1.DataSource = childItems2;
                ddlVisitType1.DataTextField = "DisplayText";
                ddlVisitType1.DataValueField = "Code";
                //ddlVisitType1.Items.RemoveAt(2);
                //ddlVisitType1.Items.Remove(ddlVisitType1.Items.FindByValue("2"));
                //ddlVisitType1.Items.Remove(ddlVisitType1.Items.FindByText("Both"));
                ddlVisitType1.DataBind();

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "DeltaCheck" && child.Code != "-1"
                                  select child;

                ddlDeltaCheck.DataSource = childItems3;
                ddlDeltaCheck.DataTextField = "DisplayText";
                ddlDeltaCheck.DataValueField = "Code";
                ddlDeltaCheck.DataBind();

                var childItems4 = from child in lstmetadataOutput orderby child.DisplayText ascending
                                  where child.Domain == "QcCheck" //&& child.Code != "-1"
                                  select child;

                ddlQcCheck.DataSource = childItems4;
                ddlQcCheck.DataTextField = "DisplayText";
                ddlQcCheck.DataValueField = "Code";
                ddlQcCheck.DataBind();
                ddlQcCheck.Items.Insert(0, strSelect.Trim());
                ddlQcCheck.Items[0].Value = "-1";

            }



        }
        catch (Exception ex)
        {
            Attune.Kernel.PlatForm.Utility.CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void drawNewPatternMethod()
    {
        string strPatientName = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_05 == null ? "Patient Name" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_05;
        string strVisitNumber = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_06 == null ? "Visit Number (SID)" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_06;
        string strAgeSex = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_07 == null ? "Age/Sex" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_07;
        string strInvestigationName = Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_08 == null ? "Investigation Name" : Resources.Investigation_ClientDisplay.Investigation_BatchWiseEnterresult_aspx_08;
        try
        {
            string RerunRecollect = GetConfigValues("RerunRecollect", OrgID);
            hdnrerunrecollect.Value = RerunRecollect;

            StringBuilder sb1 = new StringBuilder();
            StringBuilder sb2 = new StringBuilder();
            Table tblResult = null;
            TableRow tr = null;
            TableRow tr1 = null;
            TableCell tc = null;
            TableCell tc1 = null;
            int k = 0;
            tr = new TableRow();
            //tr1 = new TableRow();
            tc = new TableCell();
            tc1 = new TableCell();

            //CheckBox Check1 = new CheckBox();
            //tc1.Controls.Add(Check1);
            //tr1.Cells.add(tc1);

            tc.Width = Unit.Percentage(50);
            HtmlTable HtmlTab = new HtmlTable();
          
            HtmlTableRow HtmlTr = new HtmlTableRow();
            HtmlTableCell HtmlTc1 = new HtmlTableCell();
            HtmlTableCell HtmlTc2 = new HtmlTableCell();
            HtmlTableCell HtmlTc3 = new HtmlTableCell();
            HtmlTableCell HtmlTc4 = new HtmlTableCell();
            HtmlTableCell HtmlTc5 = new HtmlTableCell();
            HtmlTableCell HtmlTc6 = new HtmlTableCell();
            HtmlTableCell HtmlTr1 = new HtmlTableCell();

            //CheckBox chkappppp = new CheckBox();
            //HtmlTc6.Controls.Add(chkappppp);
            //HtmlTr1.Cells.add(HtmlTc6);

            if (hdnActionName.Value == "Approvel")
            {
                CheckBox chkappppp = new CheckBox();
               // chkappppp.Checked = true;
              //  chkappppp.Text = "PAA";
                HtmlTc6.Controls.Add(chkappppp);
                HtmlTc6.ID = "Chkapprr";
               // HtmlTc6.Attributes.AddAttributes("name=Parthi");
              //  HtmlTc6.Attributes.Add("this.name='Parthi'");
                HtmlTr.Cells.Add(HtmlTc6);
                HtmlTc6.Width = "1px";
                //HtmlTc5.InnerText = "Select";
                //HtmlTc5.Width = "2px";
                //HtmlTc5.Align = "Left";
                //HtmlTc5.Style.Add("font-weight", "bold");
                //HtmlTr.Cells.Add(HtmlTc5);
                
                //HtmlTr.Cells.add(HtmlTc6);
               // tblResult.Rows.Add(HtmlTr); 
              
            }
            HtmlTc1.InnerText = strPatientName.Trim();
            HtmlTc1.Width = "20px"; 
            HtmlTc1.Align = "Left";
            HtmlTc1.Style.Add("font-weight", "bold");
            HtmlTr.Cells.Add(HtmlTc1);

            HtmlTc4.InnerText = strVisitNumber.Trim();
            HtmlTc4.Width = "20px";
            HtmlTc4.Align = "Left";
            HtmlTc4.Style.Add("font-weight", "bold");
            HtmlTr.Cells.Add(HtmlTc4);

            HtmlTc2.InnerText = strAgeSex.Trim();
            HtmlTc2.Width = "5px";
            HtmlTc2.Align = "Left";
            HtmlTc2.Style.Add("font-weight", "bold");
            HtmlTr.Cells.Add(HtmlTc2);

            HtmlTc3.InnerText = strInvestigationName.Trim();
            HtmlTc3.Width = "10px";
            HtmlTc3.Align = "Left";
            HtmlTc3.Style.Add("font-weight", "bold");
            HtmlTr.Cells.Add(HtmlTc3);

            HtmlTab.Width = "31%";
            HtmlTab.Rows.Add(HtmlTr);

            tc.Controls.Add(HtmlTab);
            tr.Cells.Add(tc);
            tr.Height = 20;
            tr.CssClass = "dataheaderInvCtrl";
            drawNewPattern.Rows.Add(tr);
            long AccessionNo = 0;
            Hashtable htFormulaCollection = new Hashtable();
            foreach (PatientInvestigation objDP in lstOrdered)
            {
                if (objDP.InvestigationID > 0)
                {   
                    string sub1 = objDP.GroupName;
                    if (String.IsNullOrEmpty(hdnGroupCollection.Value))
                    {
                        hdnGroupCollection.Value += sub1 + "_Grp" + k + "#";
                    }
                    else
                    {
                        hdnGroupCollection.Value += "$" + sub1 + "_Grp" + k + "#";
                    }
                    drawNewPattern.CssClass = "dataheaderInvCtrl";
                    try
                    {
                        switch (objDP.PatternID)
                        {
                            case (Int32)TaskHelper.Pattern.BioPattern1:
                                myControl = loadBioControl(objDP);
                                tblResult = new Table();
                                tblResult.ID = "Parthiban";
                                //tblResult.NamingContainer = "Partable";
                                tr = new TableRow();
                                tc = new TableCell();
                                //CheckBox ch = new CheckBox();
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
                                }
                                tc.Width = Unit.Percentage(50);
                                tc.Controls.Add(myControl);
                               
                                tr.Cells.Add(tc);
                               // tc.Controls.Add(ch);
                                drawNewPattern.Rows.Add(tr);

                                break;

                            case (Int32)TaskHelper.Pattern.BioPattern2:
                                myControl = LoadBioPattern2(objDP);
                                tblResult = new Table();
                                tr = new TableRow();
                                tc = new TableCell();
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
                                }
                                tc.Width = Unit.Percentage(50);
                                tc.Controls.Add(myControl);
                                tr.Cells.Add(tc);
                                drawNewPattern.Rows.Add(tr);

                                break;

                            case (Int32)TaskHelper.Pattern.BioPattern3:
                                myControl = LoadBioPattern3(objDP);
                                tblResult = new Table();
                                tr = new TableRow();
                                tc = new TableCell();
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
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
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
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
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
                                }
                                tc.Width = Unit.Percentage(70);
                                tc.Controls.Add(myControl);
                                tr.Cells.Add(tc);
                                drawNewPattern.Rows.Add(tr);
                                break;

                            case (Int32)TaskHelper.Pattern.ImagePattern:
                                myControl = LoadImagePattern(objDP);
                                tblResult = new Table();
                                tr = new TableRow();
                                tc = new TableCell();
                                if (objDP.ErrorCode != "" && objDP.ErrorCode != null)
                                {
                                    tr.Style.Add("background-color", "#FF3300");
                                }
                                tc.Width = Unit.Percentage(70);
                                tc.Controls.Add(myControl);
                                tr.Cells.Add(tc);
                                drawNewPattern.Rows.Add(tr);

                                break;
                        }
                    }
                    catch (Exception ex)
                    {

                    }
                }
                try
                {
                    string tGroupFormula;
                    long groupAccessionNo;
                    foreach (string key in hFormulaCollection.Keys)
                    {
                        string tempFormula = Convert.ToString(hFormulaCollection[key]);
                        string[] lstKey = key.Split(',');
                        Int64.TryParse(lstKey[0], out AccessionNo);
                        if (AccessionNo == objDP.AccessionNumber)
                        {
                            tGroupFormula = string.Empty;
                            groupAccessionNo = 0;
                            foreach (long investigationID in hGroupFormulaCollection.Keys)
                            {
                                tGroupFormula = Convert.ToString(hGroupFormulaCollection[investigationID]);
                                Int64.TryParse(tGroupFormula.Split('~')[5], out groupAccessionNo);
                                if (tempFormula.Contains("[" + investigationID + "]") && groupAccessionNo == AccessionNo)
                                {
                                    tempFormula = tempFormula.Replace("'[" + investigationID + "]'", "'" + hGroupFormulaCollection[investigationID] + "'");
                                    tempFormula = tempFormula.Replace("[" + investigationID + "]", "document.getElementById('" + hGroupFormulaCollection[investigationID] + "').value");
                                }
                            }
                        }
                        htFormulaCollection[key] = tempFormula;
                    }
                }
                catch (Exception ex)
                {
                }
            }

            foreach (string sFormula in htFormulaCollection.Values)
            {
                string tempFormula = sFormula;
                if (!tempFormula.Contains("confirm"))
                {
                    sJsFuntion.Append(tempFormula);
                }
                else
                {
                    sJsSaveValidationFuntion.Append(tempFormula);
                }
            }
            sJsFuntion = sJsFuntion.Replace("parseFloat([", "parseFloat(\"test_");
            sJsFuntion = sJsFuntion.Replace("])", "\")");
            sJsFuntion.Append(" } catch (e) { return true; }");
            sJsFuntion.Append("}</script>");

            sJsSaveValidationFuntion.Append(" if(document.getElementById('hdnCommonDCcheck').value=='false'){return false;}else {return true;} } catch (e) { return true; }");
            sJsSaveValidationFuntion.Append("}</script>");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligense", sJsFuntion.ToString(), false);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "IntelligenseSave", sJsSaveValidationFuntion.ToString(), false);

            foreach (string sFormulas in hIFormulaCollection.Values)
            {
                string tempFormulas = sFormulas;
                foreach (long investigationID in hInvestigationFormulaCollection.Keys)
                {
                    if (tempFormulas.Contains("[" + investigationID + "]"))
                    {
                        tempFormulas = tempFormulas.Replace("[" + investigationID + "]", "document.getElementById('" + hIFormulaCollection[investigationID] + "').value");
                    }
                }
                sJsINVFuntion.Append(tempFormulas);
            }

            sJsINVFuntion.Append("}</script>");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Intelligenseser", sJsINVFuntion.ToString(), false);

            if (hdnActionName.Value == "EnterResult")
            {
                int formulaCount = 1;
                foreach (string ctrID in lstFormula)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadFormula" + formulaCount++, "ChecKGroupSum('" + ctrID + "');", true);
                }
            }
            if (!String.IsNullOrEmpty(hdnlstNotYetResolvedRRParams.Value))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "chkDeviceRefRange", "CallAllReferenceRangeValidate();", true);
            }
            //added by prabakar for coomon validation
            sJsSaveValidationFuntionEmptyValue.Append("<script language ='javascript' type ='text/javascript'>function ValidationFuntionEmptyValueFuntion(){ try { ");

            string EmptyValueFormulaString = "debugger;";
            EmptyValueFormulaString = "var Investgationname1 = 'The Below Test Values are Empty :\\n\\n'; var Investgationname = '';";
            foreach (PatientInvestigation lst in lstInvestigationValuesforAlert)
            {

                EmptyValueFormulaString += "if (document.getElementById('" + lst.InstrumentName + "').value == '') {  Investgationname += " + "'" + lst.InvestigationName + " \\n'" + " }";

            }
            //EmptyValueFormulaString += "var Investgationname = 'The Below Test Values are Empty: \n";
            //EmptyValueFormulaString += "'+Investgationname+' Do you want to continue?";
            EmptyValueFormulaString += " if(Investgationname!='') {return ConfirmWindow(Investgationname1+Investgationname); } else{ return true; } ;";
            sJsSaveValidationFuntionEmptyValue.Append(EmptyValueFormulaString);
            sJsSaveValidationFuntionEmptyValue.Append(" } catch (e) { return true; }");
            sJsSaveValidationFuntionEmptyValue.Append("}</script>");
            if (hdnIscommonValidation.Value == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "EmptyValidation", sJsSaveValidationFuntionEmptyValue.ToString(), false);
            }
            //
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    public void LoadPatterns()
    {
        try
        {
            drawNewPattern.Rows.Clear();
            List<RoleDeptMap> lRoleDeptMap = new List<RoleDeptMap>();
            List<InvReportMaster> lShowInvValues = new List<InvReportMaster>();
            List<InvestigationHeader> lstHeader = new List<InvestigationHeader>();
            LoginDetail objLoginDetail = new LoginDetail();
            objLoginDetail.LoginID = LID;
            objLoginDetail.RoleID = RoleID;
            objLoginDetail.Orgid = OrgID;
            int Issearched = 0;
            if (hdnActionName.Value != "Approvel")
            {
                if ((VisitIDs != "0" && VisitIDs != "0,0") || InvID != 0 || worklistid != 0 || deviceid != 0 || deptID != 0 || headerID != 0 || protocalID != 0 || BarcodeNumber != "0")
                {
                    Issearched = 1;
                    objInvBL.GetBatchWiseInvestigationResultsCaptureFormat(VisitIDs, OrgID, BarcodeNumber, RoleID, deptID, InvID, InvType, objLoginDetail, "N", worklistid, deviceid, isAbnormalResult, headerID, protocalID, hdnActionName.Value, isMaster, recordCount,0, out lstOrdered);
                }
            }
            else
            {
                if ((VisitIDs != "0" && VisitIDs != "0,0") || InvID != 0 || worklistid != 0 || deviceid != 0 || deptID != 0 || headerID != 0 || protocalID != 0 || BarcodeNumber != "0")
                {
                    Issearched = 1;
                    //objInvBL.GetBatchWiseInvestigationResultsCaptureFormat(VisitIDs, OrgID, BarcodeNumber, RoleID, deptID, InvID, InvType, objLoginDetail, "N", worklistid, deviceid, isAbnormalResult, headerID, protocalID, hdnActionName.Value, isMaster, recordCount, out lstOrdered);
                    objInvBL.GetBatchWiseInvestigationResultsCaptureFormat(VisitIDs, OrgID, BarcodeNumber, RoleID, deptID, InvID, InvType, objLoginDetail, "N", worklistid, deviceid, isAbnormalResult, headerID, protocalID, hdnActionName.Value, isMaster, recordCount, Visittype, Location1,QcCheck,PatIds, out lstOrdered);
                }
            }
            hdnDept.Value = "0";// Convert.ToString(lRoleDeptMap[0].DeptID);
            //Users_BL oUserBL = new Users_BL(base.ContextInfo);
            //oUserBL.GetUserListByRole(OrgID, RoleID, out lstSecondOpinionUser);
            //if (lstSecondOpinionUser != null && lstSecondOpinionUser.Count > 0)
            //{
            //    lstSecondOpinionUser = (from lou in lstSecondOpinionUser
            //                            where lou.LoginID != LID
            //                            select lou).ToList<Users>();
            //    hdnLstCoAuthorizeUser.Value = oJavaScriptSerializer.Serialize(lstSecondOpinionUser);
            //}
            if (lstOrdered.Count > 0)
            {
                try
                {
                    for (int i = 0; i <lstOrdered.Count; i++)
                    {
                        string str = lstOrdered[i].Age;
                        string str1 = lstOrdered[i].Sex;
                        string[] strage1 = str.Split(' ');
                        if (strage1[1] == "Year(s)")
                        {
                            lstOrdered[i].Age = strage1[0] + " " + strYear;
                        }
                        else if (strage1[1] == "Month(s)")
                        {
                            lstOrdered[i].Age = strage1[0] + " " + strMonth;
                        }
                        else if (strage1[1] == "Day(s)")
                        {
                            lstOrdered[i].Age = strage1[0] + " " + strDay;
                        }
                        else if (strage1[1] == "Week(s)")
                        {
                            lstOrdered[i].Age = strage1[0] + " " + strWeek;
                        }
                        else
                        {
                            lstOrdered[i].Age = strage1[0] + " " + strYear;
                        }
                        if (str1 == "Male")
                        {
                            lstOrdered[i].Sex = strMale;
                        }
                        else if (str1 == "Female")
                        {
                            lstOrdered[i].Sex = strFemale;
                        }
                        else
                        {
                            lstOrdered[i].Sex = strMale;
                        }
                    }
                }
                catch (Exception ex)
                {
                    CLogger.LogInfo("Errrrr", ex);
                }
            }
            //---- END---//
            if (lstOrdered.Count > 0)
            {
                objInvBL.GetBatchWiseBulkData(lstOrdered, OrgID, hdnActionName.Value, out DemoBulk, out lstPendingValue, out header, out lstiom);
                hdncountsofdata.Value = Convert.ToString(lstOrdered[0].Sno - lstOrdered.Count);
                DInvest.Style.Add("display", "block");
                drawNewPatternMethod();
                JavaScriptSerializer lst = new JavaScriptSerializer();
                hdnLstControlID.Value = lst.Serialize(lstControl);
                hdnLstPatternID.Value = lst.Serialize(lstpatternID);
                lblResult.Visible = false;
                tblTotal.Style.Add("display", "table");
                if (Session["Action"].ToString() == "Approvel")
                {
                    lblTotalRecords.Text = Convert.ToString(lstOrdered.Count);
                }
                else
                {
                    lblTotalRecords.Text = Convert.ToString(lstOrdered[0].Sno);
                }
                lblLoadedRecords.Text = Convert.ToString(lstOrdered.Count);
                hdndeltaChecks.Value = lstOrdered[0].QCData;
                int TotalLoadedRecords = 0;
                Int32.TryParse(hdnTotalLoadedRecords.Value, out TotalLoadedRecords);
                if (TotalLoadedRecords == 0)
                {
                    hdnTotalLoadedRecords.Value = Convert.ToString(lstOrdered.Count);
                }
                else
                {
                    hdnTotalLoadedRecords.Value = Convert.ToString(TotalLoadedRecords + lstOrdered.Count);
                }
                if (TotalLoadedRecords + lstOrdered.Count >= lstOrdered[0].Sno)
                {
                    tblPageNo.Style.Add("display", "none");
                    imgNextPage.Visible = false;
                }
                else
                {
                    tblPageNo.Style.Add("display", "table");
                    imgNextPage.Visible = true;
                }
                //hdndeltaChecks.Value = lstOrdered(QcCheck);
            }
            else
            {
                if (Issearched == 1)
                {
                    lblResult.Visible = true;
                    DInvest.Style.Add("display", "none");
                }
                tblTotal.Style.Add("display", "none");
                tblPageNo.Style.Add("display", "none");
            }
            if (lstOrdered.Count > 0)
            {
               
                List<Users> lstSecondOpinionUser = new List<Users>();
                Users_BL oUserBL = new Users_BL(base.ContextInfo);
                oUserBL.GetUserListByRole(OrgID, RoleID, out lstSecondOpinionUser);
                if (lstSecondOpinionUser != null && lstSecondOpinionUser.Count > 0)
                {
                    lstSecondOpinionUser = (from lou in lstSecondOpinionUser
                                            where lou.LoginID != LID
                                            select lou).ToList<Users>();
                    hdnLstCoAuthorizeUser.Value = oJavaScriptSerializer.Serialize(lstSecondOpinionUser);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadPatterns", ex);
        }
    }
    private long AutoSave()
    {
        int returnStatus = -1;
        long returnCode = -1;
        try
        {
            List<PatientInvSampleResults> lstPatientInvSampleResults = new List<PatientInvSampleResults>();
            ArrayList result = new ArrayList();

            List<List<InvestigationValues>> LstOfBio = new List<List<InvestigationValues>>();
            List<PatientInvestigation> lstPatientInv = new List<PatientInvestigation>();
            List<PatientInvestigationFiles> lPFiles = new List<PatientInvestigationFiles>();
            bool Flag = true;
            string chkapp;
            CheckBox chh = (CheckBox)FindControl("chkApprovel") as CheckBox;
            if (chh != null && chh.Checked)
            {
                chkapp = "True";
            }

            try
            {
                JavaScriptSerializer o = new JavaScriptSerializer();
                if ((!string.IsNullOrEmpty(hdnInvValues.Value)) && (!string.IsNullOrEmpty(hdnPatInv.Value)))
                {
                    LstOfBio = o.Deserialize<List<List<InvestigationValues>>>(hdnInvValues.Value);
                    lstPatientInv = o.Deserialize<List<PatientInvestigation>>(hdnPatInv.Value);

                    if (!string.IsNullOrEmpty(hdnLstImagePattern.Value))
                    {
                        List<PatientInvestigation> lstImagePattern = new List<PatientInvestigation>();
                        lstImagePattern = o.Deserialize<List<PatientInvestigation>>(hdnLstImagePattern.Value);
                        if (lstImagePattern != null && lstImagePattern.Count > 0)
                        {
                            List<PatientInvestigationFiles> PtFiles12 = new List<PatientInvestigationFiles>();
                            foreach (PatientInvestigation obj in lstImagePattern)
                            {
                               
                                PtFiles12 = new List<PatientInvestigationFiles>();
                                PtFiles12 = GetInvestigationFiles(obj.InvestigationID, obj.PatientVisitID, obj.AccessionNumber);
                                foreach (PatientInvestigationFiles objFile in PtFiles12)
                                {
                                    lPFiles.Add(objFile);
                                }
                            }
                        }
                    }

                    int deptID = Convert.ToInt32(hdnDept.Value);
                    Investigation_BL saveResults = new Investigation_BL(base.ContextInfo);

                    if (hdnhigh.Value != "")
                    {
                        List<NameValuePair> lstHighRangeDetails = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnhigh.Value);
                        int i = 0;
                        foreach (PatientInvestigation obj in lstPatientInv)
                        {
                            CheckBox chhh = (CheckBox)FindControl("chkApprovel") as CheckBox;
                            if (chhh != null && chhh.Checked)
                            {
                                chkapp = "True";
                            }

                            foreach (NameValuePair s1 in lstHighRangeDetails)
                            {
                                CheckBox ch = (CheckBox)FindControl("chkApprovel") as CheckBox;
                                if (ch != null && ch.Checked)
                                {
                                    chkapp = "True";
                                }
                                string[] s2 = s1.Name.Split('~');
                                string[] s3;
                                s3 = s2[5].Split('_');
                                lstPatientInv[i].ApprovedBy = LID;
                                if (s3[0] == obj.AccessionNumber.ToString() && s2[0] == obj.InvestigationID.ToString())
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
                                        lstPatientInv[i].IsAutoAuthorize = "Y";
                                    }
                                    else if (s1.Value == "P")
                                    {
                                        lstPatientInv[i].IsAbnormal = "P";
                                        lstPatientInv[i].IsAutoAuthorize = "N";

                                    }
                                    else if (s1.Value == "white" || s1.Value == "N") { lstPatientInv[i].IsAbnormal = "N"; lstPatientInv[i].IsAutoAuthorize = "N"; }
                                    else if (s1.Value == "Autowhite")
                                    {
                                        lstPatientInv[i].IsAbnormal = "N";
                                        lstPatientInv[i].IsAutoAuthorize = "Y";
                                        lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                    }
                                    else if (s1.Value == "AutoA")
                                    {
                                        lstPatientInv[i].IsAbnormal = "A";
                                        lstPatientInv[i].IsAutoAuthorize = "Y";
                                        lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                    }
                                    else if (s1.Value == "AutoP")
                                    {
                                        lstPatientInv[i].IsAbnormal = "P";
                                        lstPatientInv[i].IsAutoAuthorize = "Y";
                                        lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
                                    }
                                    else if (s1.Value == "AutoL")
                                    {
                                        lstPatientInv[i].IsAbnormal = "L";
                                        lstPatientInv[i].IsAutoAuthorize = "Y";
                                        lstPatientInv[i].ApprovedBy = lstPatientInv[i].AutoApproveLoginID;
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
                    AllowAutoApproveTask = "No";
                    int PendingCount = 0;
                    foreach (var O in lstPatientInv)
                    {
                        O.ApprovedBy = LID;
                        if (hdnDomainvalue.Value == "true")
                        {
                            O.Status = "Pending";
                            AllowAutoApproveTask = "No";
                            O.IsAutoAuthorize = "N";
                            PendingCount += 1;
                        }
                        else if ((O.Status == "Completed" || O.Status == "Pending" || O.Status == "Validate") && O.AutoApproveLoginID > 0 && (IsExcludeAutoApproval == "N" || String.IsNullOrEmpty(IsExcludeAutoApproval)) && O.IsAutoAuthorize == "Y")
                        {
                            Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);

                            returnCode = DemoBL.GetPatientInvestigationStatus(O.PatientVisitID, O.OrgID, out lstPatientInvestigation3);

                            AutoApproveQueueCount = (from IL in lstPatientInvestigation3
                                                     where IL.IsAutoApproveQueue == "Y"
                                                     select IL).Count();
                            NormalApproveTestCount = (from IL in lstPatientInvestigation3
                                                      where IL.AutoApproveLoginID == 0
                                                      select IL).Count();
                            IsAutoAuthRecollect = (from IL in lstPatientInvestigation3
                                                   where IL.ReferredType == "Retest"
                                                   select IL).Count();
                            hdnIsAutoAuthRecollect.Value = IsAutoAuthRecollect.ToString();
                            if (O.IsAutoApproveQueue != "Y" && AutoApproveQueueCount == 0 && NormalApproveTestCount == 0)
                            {
                                //O.Status = "Approve";
                            }
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
                    }
                    if (PendingCount == 0)
                    {
                        AllowAutoApproveTask = "Yes";
                    }
                    //Revert Auto Approve Status
                    foreach (var O in lstPatientInv)
                    {
                        if (O.Status != "Approve")
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
                                                    O1.ApprovedBy = LID;
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
                    }

                    lstpatinvestigation = lstPatientInv;


                    if (Flag == true)
                    {
                        List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();

                        long approvedBy = LID;

                        returnCode = saveResults.BatchWiseSaveInvestigationResults(-1, LstOfBio, lstPatientInv, lstPatientInvSampleResults, lstPatientInvSampleMapping, lPFiles, vid, OrgID, deptID, approvedBy, gUID, PageContextDetails, out returnStatus);

                        List<PatientInvestigation> lstReflex = lstPatientInv.FindAll(P => P.Status == InvStatus.ReflexWithNewSample || P.Status == InvStatus.ReflexWithSameSample);
                        if (lstReflex.Count() > 0)
                        {
                            ucReflexTest.saveBatchwiseInvestigationQueue(lstReflex);
                        }
                    }
                    var PatientVisitIDs =
                    from w in lstPatientInv
                    group w by w.PatientVisitID into g
                    select new { PatientVisitID = g.Key };
                    foreach (var g in PatientVisitIDs)
                    {
                        int TotalCount = 0;
                        int Total = 0;
                        accessionnumber = "";
                        List<PatientInvestigation> lsttmpPatientInv = new List<PatientInvestigation>();

                        returnCode = objInvBL.GetPatientInvestigationStatus(Convert.ToInt64(g.PatientVisitID), OrgID, out lsttmpPatientInvestigation);
                        lsttmpPatientInv = lstPatientInv.FindAll(p => p.PatientVisitID == Convert.ToInt64(g.PatientVisitID));
                        TotalCount = lsttmpPatientInv.FindAll(p => p.Status == "Approve" || p.Status == "PartiallyApproved" || p.Status == "With Held" || p.Status == "Reject").Count();
                        Total = lsttmpPatientInv.FindAll(p => p.Status == "Retest").Count();
                        if (Total > 0)
                        {
                            int reclt = 0;
                            reclt = lsttmpPatientInv.FindAll(p => p.Status == "Retest").Count();
                            if (reclt > 0)
                            {
                                List<PatientInvestigation> access = lsttmpPatientInv.FindAll(P => P.Status == InvStatus.Retest);
                                if (access.Count > 0)
                                {
                                    foreach (PatientInvestigation pinv in access)
                                    {
                                        OrderedInvestigations objinv = new OrderedInvestigations();
                                        objinv.AccessionNumber = pinv.AccessionNumber;
                                        accessionnumber += objinv.AccessionNumber.ToString() + ",";

                                    }



                                }

                                ActionManager AM = new ActionManager(base.ContextInfo);
                                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                PageContextkey PC = new PageContextkey();
                                PC.ID = Convert.ToInt64(ILocationID);
                                PC.PatientID = lsttmpPatientInvestigation[0].PatientID;
                                PC.RoleID = Convert.ToInt64(RoleID);
                                PC.OrgID = OrgID;
                                PC.PatientVisitID = Convert.ToInt64(g.PatientVisitID);
                                PC.PageID = Convert.ToInt64(PageID);
                                PC.ButtonName = PageContextDetails.ButtonName;
                                PC.ButtonValue = PageContextDetails.ButtonValue;
                                PC.IDS = accessionnumber;
                                lstpagecontextkeys.Add(PC);
                                long res = -1;
                                res = AM.PerformingNextStepNotification(PC, "", "");

                            }


                        }



                        if (TotalCount > 0)
                        {
                            int cnt = 0;
                            int cntPA = 0;
                            int cntWH = 0;
                            int cntRJ = 0;
                            cnt = lsttmpPatientInv.FindAll(p => p.Status == "Approve").Count();
                            cntPA = lsttmpPatientInv.FindAll(p => p.Status == "PartiallyApproved").Count();
                            cntWH = lsttmpPatientInv.FindAll(p => p.Status == "With Held").Count();
                            cntRJ = lsttmpPatientInv.FindAll(p => p.Status == "Reject").Count();

                            if (cnt > 0 || cntPA > 0 || cntWH > 0 || cntRJ > 0)
                            {
                                ActionManager AM = new ActionManager(base.ContextInfo);
                                List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                                PageContextkey PC = new PageContextkey();
                                PC.ID = Convert.ToInt64(ILocationID);
                                PC.PatientID = lsttmpPatientInvestigation[0].PatientID;
                                PC.RoleID = Convert.ToInt64(RoleID);
                                PC.OrgID = OrgID;
                                PC.PatientVisitID = Convert.ToInt64(g.PatientVisitID);
                                PC.PageID = Convert.ToInt64(PageID);
                                PC.ButtonName = PageContextDetails.ButtonName;
                                PC.ButtonValue = PageContextDetails.ButtonValue;
                                lstpagecontextkeys.Add(PC);
                                long res = -1;
                                res = AM.PerformingNextStepNotification(PC, "", "");
                            }
                        }
                    }
                }
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }
        catch (Exception e)
        {
            throw e;
        }
        return returnCode;
    }
    public List<PatientInvestigationFiles> GetInvestigationFiles(long ControlID, long PatientVisitID, long AccessionNumber)
    {

        string fileCtrlID;
        string[] lstFileCtrlID1;
        string[] lstFileCtrlID;
        bool addToList = false;
        byte[] fileByte = new byte[byte.MinValue];
        HttpFileCollection hfc = Request.Files;
        HttpPostedFile hpf = null;
        List<PatientInvestigationFiles> PtFiles1 = new List<PatientInvestigationFiles>();
        PatientInvestigationFiles pFiles1 = null;
        for (int i = 0; i < hfc.Count; i++)
        {
            addToList = false;
            hpf = hfc[i];
            if (hpf.ContentLength <= 0)
                continue;
            else
            {
                if (hpf.ContentLength > 0)
                {
                    fileCtrlID = hfc.Keys[i];
                    if (fileCtrlID.Contains('$'))
                    {
                        lstFileCtrlID1 = fileCtrlID.Split('$');
                        if (lstFileCtrlID1 != null && lstFileCtrlID1.Length > 0)
                        {
                            lstFileCtrlID = lstFileCtrlID1[0].Split('~');
                            if (lstFileCtrlID != null && lstFileCtrlID.Length > 4)
                            {
                                long accNo = 0;
                                long invID = 0;
                                Int64.TryParse(lstFileCtrlID[0], out invID);
                                Int64.TryParse(lstFileCtrlID[5], out accNo);
                                if (invID == ControlID && accNo == AccessionNumber)
                                {
                                    addToList = true;
                                }
                            }
                        }
                    }
                    else
                    {
                        lstFileCtrlID = fileCtrlID.Split('_');
                        if (lstFileCtrlID != null && lstFileCtrlID.Length >= 3)
                        {
                            long accNo = 0;
                            long invID = 0;
                            Int64.TryParse(lstFileCtrlID[2], out invID);
                            Int64.TryParse(lstFileCtrlID[3], out accNo);
                            if (invID == ControlID && accNo == AccessionNumber)
                            {
                                addToList = true;
                            }
                        }
                    }

                    if (addToList)
                    {
                        using (var binaryReader = new BinaryReader(hpf.InputStream))
                        {
                            fileByte = binaryReader.ReadBytes(hpf.ContentLength);
                        }
                        pFiles1 = new PatientInvestigationFiles();
                        pFiles1.PatientVisitID = PatientVisitID;
                        pFiles1.ImageSource = fileByte;
                        pFiles1.FilePath = hpf.FileName;
                        pFiles1.CreatedBy = LID;
                        pFiles1.OrgID = OrgID;
                        pFiles1.InvestigationID = Convert.ToInt32(ControlID);
                        PtFiles1.Add(pFiles1);
                    }
                }
            }
        }

        return PtFiles1;
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
    public void ConvertXmlToString(string xmlData, long PatientID, long VisitID, out string NormalReferenceRange, string uom, out string PrintableRange)
    {
        NormalReferenceRange = string.Empty;
        string OtherReferenceRange = string.Empty;
        PrintableRange = string.Empty;
        try
        {
            uom = uom == "" ? "" : uom;

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<Patient> lstpatient = new List<Patient>();
            List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();

            patientBL.GetPatientVitals(VisitID, PatientID, OrgID, out lstpatient, out lstpv);

            if (lstpatient != null && lstpatient.Count > 0)
            {
                LabUtil oLabUtil = new LabUtil();
                oLabUtil.ConvertXmlToString(xmlData, uom, lstpatient[0].SEX, lstpatient[0].PatientAge, out NormalReferenceRange, out OtherReferenceRange, out PrintableRange);
                NormalReferenceRange = !String.IsNullOrEmpty(NormalReferenceRange) ? NormalReferenceRange.Trim().Replace("<br>", "\n") : string.Empty;
                PrintableRange = !String.IsNullOrEmpty(PrintableRange) ? PrintableRange.Trim().Replace("<br>", "\n") : string.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting reference range xml to string", ex);
        }
    }
    private void search()
    {
        string FromVID = "0";
        string ToVID = "0";
        VisitIDs = "0";
        InvName = "";
        InvID = 0;
        InvType = "";
        worklistid = 0;
        deviceid = 0;
        isAbnormalResult = "0";
        deptID = 0;
        headerID = 0;
        protocalID = 0;
        isMaster = "N";
        recordCount = 0;
        pageNo = 1;
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
            if (txtSampleID.Text.Trim() != "")
            {
                BarcodeNumber = txtSampleID.Text;
            }
            if (string.IsNullOrEmpty(txtInvestigationName.Text))
            {
                InvName = "";
                InvID = 0;
                InvType = "";
                hdnTestName.Value = "";
                hdnTestID.Value = "";
                hdnTestType.Value = "";
            }
            if (hdnTestName.Value != "")
            {
                InvName = hdnTestName.Value;
                Int64.TryParse(hdnTestID.Value, out InvID);
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
                Int64.TryParse(hdnTestID.Value, out InvID);
                InvType = hdnTestType.Value;
            }
            Int64.TryParse(ddlInstrument.SelectedValue, out deviceid);
            if (ddlResultType.SelectedValue == "---Select---")
            {
                isAbnormalResult = "";
            }
            else
            {

                isAbnormalResult = ddlResultType.SelectedValue;
            }
            if (hdnActionName.Value == "Approvel")
            {
                if (ddlVisitType1.SelectedValue == "---Select---")
                {
                    Visittype = "";
                }
                else
                {

                    Visittype = ddlVisitType1.SelectedValue;
                }
                if (ddlLocation.SelectedValue == "---Select---")
                {
                    Location1 = "";
                }
                else
                {

                    Location1 = ddlLocation.SelectedValue;
                }
              
            }
            QcCheck = ddlQcCheck.SelectedValue;
            PatIds = txtPatientID.Text;
            Int32.TryParse(ddlDept.SelectedValue, out deptID);
            Int64.TryParse(ddlHeader.SelectedValue, out headerID);
            Int64.TryParse(ddlProtocol.SelectedValue, out protocalID);
            isMaster = chkIsMaster.Checked ? "Y" : "N";
            Int32.TryParse(hdnTotalLoadedRecords.Value, out recordCount);
            Int32.TryParse(hdnPageNo.Value, out pageNo);

            InvName = InvName.Replace("#", "");

            LoadPatterns();

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    private void searchApproval()
    {

        string FromVID1 = "0";
        string ToVID1 = "0";
        VisitIDs = "0";
        InvName = "";
        InvID = 0;
        InvType = "";
        worklistid = 0;
        deviceid = 0;
        isAbnormalResult = "0";
        Visittype = "-1";
        Location1 = "0";
        deptID = 0;
        headerID = 0;
        protocalID = 0;
        isMaster = "N";
        recordCount = 0;
        pageNo = 1;
        try
        {
            if (txtFromVisotNO.Text.Trim() != "")
            {
                FromVID1 = txtFromVisotNO.Text;
            }
            if (txtToVisitNO.Text.Trim() != "")
            {
                ToVID1 = txtToVisitNO.Text;
            }
            if (txtBarcodeNo.Text.Trim() != "")
            {
                BarcodeNumber = txtBarcodeNo.Text;
            }
            if (string.IsNullOrEmpty(txtInvestigationName1.Text))
            {
                InvName = "";
                InvID = 0;
                InvType = "";
                hdnTestName.Value = "";
                hdnTestID.Value = "";
                hdnTestType.Value = "";
            }
            if (hdnTestName.Value != "")
            {
                InvName = hdnTestName.Value;
                Int64.TryParse(hdnTestID.Value, out InvID);
                InvType = hdnTestType.Value;
            }

            if (FromVID1 != "0" && ToVID1 != "0")
            {
                if (ToVID1 == FromVID1)
                {
                    VisitIDs = FromVID1 + "," + FromVID1;
                }
                else
                {
                    VisitIDs = FromVID1 + "," + ToVID1;
                }
            }
            else if (FromVID1 != "0")
            {
                VisitIDs = FromVID1 + "," + FromVID1;
            }
            else if (ToVID1 != "0")
            {
                VisitIDs = ToVID1 + "," + FromVID1;
            }
            else
            {
                VisitIDs = "0";
            }

            if (txtInvestigationName.Text != "" && txtInvestigationName.Text != null)
            {
                InvName = txtInvestigationName.Text;
                Int64.TryParse(hdnTestID.Value, out InvID);
                InvType = hdnTestType.Value;
            }
            Int64.TryParse(ddlAnalyzer.SelectedValue, out deviceid);
            if (ddlResultypes.SelectedValue == "---Select---")
            {
                isAbnormalResult = "";
            }
            else
            {

                isAbnormalResult = ddlResultypes.SelectedValue;
            }
            if (ddlVisitType1.SelectedValue == "---Select---")
            {
                Visittype = "";
            }
            else
            {

                Visittype = ddlVisitType1.SelectedValue;
            }
            if (ddlLocation.SelectedValue == "---Select---")
            {
                Location1 = "";
            }
            else
            {

                Location1 = ddlLocation.SelectedValue;
            }
            Int32.TryParse(ddlDepartment.SelectedValue, out deptID);
            // Int64.TryParse(ddlHeader.SelectedValue, out headerID);
            //Int64.TryParse(ddlProtocol.SelectedValue, out protocalID);
            IsDefault = chkDefault.Checked ? "Y" : "N";
            Int32.TryParse(hdnTotalLoadedRecords.Value, out recordCount);
            Int32.TryParse(hdnPageNo.Value, out pageNo);

            InvName1 = InvName1.Replace("#", "");
            LoadPatterns();

        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public Control loadBioControl(PatientInvestigation lstInve)
    {
        Investigation_checkInvest bioPattern1;
        bioPattern1 = (Investigation_checkInvest)LoadControl(lstInve.PatternName);
        try
        {
            bioPattern1.EnableViewState = false;
            bioPattern1.POrgid = OrgID;
            bioPattern1.OrgID = OrgID;
            bioPattern1.RoleID = RoleID;
            bioPattern1.LID = LID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            long InvestigationID = lstInve.InvestigationID;
            int groupID = lstInve.GroupID;
            bioPattern1.UOM = lstInve.UOMCode;
            bioPattern1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            bioPattern1.ControlID = Convert.ToString(lstInve.InvestigationID);
            bioPattern1.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
            bioPattern1.GroupID = lstInve.GroupID;
            bioPattern1.GroupName = lstInve.GroupName;
            bioPattern1.PackageID = lstInve.PackageID;
            bioPattern1.PackageName = lstInve.PackageName;
            bioPattern1.CurrentRoleName = RoleName;
            bioPattern1.LabTechEditMedRem = strLabTechToEditMedRem;
            bioPattern1.DecimalPlaces = lstInve.DecimalPlaces;
            bioPattern1.ResultValueType = lstInve.ResultValueType;
            bioPattern1.AutoApproveLoginID = Convert.ToInt64(lstInve.AutoApproveLoginID);
            IsExcludeAutoApproval = lstInve.RefSuffixText;
            bioPattern1.VisitID = lstInve.PatientVisitID;
            bioPattern1.PatientID = lstInve.PatientVisitID;
            bioPattern1.AccessionNumber = lstInve.AccessionNumber;
            bioPattern1.UID = lstInve.UID;
            bioPattern1.Name = lstInve.InvestigationName;
            bioPattern1.Age = lstInve.Age;
            bioPattern1.Sex = lstInve.Sex;
            bioPattern1.PatientName = lstInve.Name;
            bioPattern1.LabNo = lstInve.LabNo;
            bioPattern1.PatientVisitID = lstInve.PatientVisitID;
            bioPattern1.PatternID = lstInve.PatternID;
            bioPattern1.ClientID = lstInve.ClientID;
            bioPattern1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            bioPattern1.TestStatus = lstInve.TestStatus;
            bioPattern1.VisitNumber = lstInve.VisitNumber;
            bioPattern1.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            bioPattern1.IsAutoValidate = lstInve.IsAutoValidate;
            bioPattern1.DecimalPlaces = lstInve.DecimalPlaces;
            long ReturnRes;
            TextBox txtValue = (TextBox)bioPattern1.FindControl("txtValue");
           // txtValue.Attributes.Add("onblur", "disableOnblur();");
            HiddenField hdnResultValue = (HiddenField)bioPattern1.FindControl("hdnResultValue");
            string ClientID = txtValue.ClientID;
            //added by prabakar for common emtry string validation
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            //
            if (!hGroupFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hGroupFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }
            if (!hInvestigationFormulaCollection.Contains(lstInve.InvestigationID))
            {
                hInvestigationFormulaCollection.Add(lstInve.InvestigationID, ClientID);
            }

            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + bioPattern1.ID + "_ddlstatus";
            //code added for reference range - begin
            string ReferenceRange;
            string PrintableRange = string.Empty;
            string[] ConvReferenceRange;
            string ConReferenceRange = string.Empty;
            string CheckQcChecks = string.Empty;

            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.PatientID, lstInve.PatientVisitID, out ReferenceRange, lstInve.UOMCode, out PrintableRange);
                if (ReferenceRange != null)
                {
                    bioPattern1.RefRange = ReferenceRange;
                    
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
                    bioPattern1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
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
            bioPattern1.QcCheck = lstInve.QCData;
            //if (lstOrdered.Count > 0)
            //{
            //    try
            //    {
            //        Session["Qccheck"] = "";
            //        int i = 1;
            //        hdndeltaChecks.Value = lstOrdered[i].QCData;
            //        bioPattern1.QcCheck = hdndeltaChecks.Value;
            //        bioPattern1.CheckQcChecks = lstOrdered[i].QCData;
            //        bioPattern1.QcCheck = lstOrdered[i].QCData;
            //        i++;
            //    }
            //    catch { }
            //}
            
        // Session["Qccheck"] = "";
         //Session["Qccheck"] = hdndeltaChecks.Value;
           
            bioPattern1.ConvUOMCode = lstInve.CONV_UOMCode;
            bioPattern1.ConvFactorvalue = lstInve.CONV_Factor;
            bioPattern1.CONVFactorDecimalPt = lstInve.CONVFactorDecimalPt;
            if (lstInve.ConvReferenceRange == null)
            {
                ConReferenceRange = "";

            }
            else
            {
                ConReferenceRange = lstInve.ConvReferenceRange.Trim().Replace("<br>", "\n");
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

            //code added for reference range - end
            bioPattern1.Text = lstInve.Value;
            bioPattern1.DeviceActualValue = lstInve.DeviceActualValue;
            lstControl.Add(bioPattern1.ID);
            lstpatternID.Add(lstInve.PatternID);
            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    bioPattern1.LoadDataForEdit(lstPendingval);
                }
            }
            lstiominv = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstiominv != null && lstiominv.Count > 0)
            {
                bioPattern1.setXmlValues(lstiominv[0].ReferenceRange);
                bioPattern1.setPanicXmlValues(lstiominv[0].ReferenceRange);
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
            HiddenField hdnXmlContent = (HiddenField)bioPattern1.FindControl("hdnXmlContent");
            bool isFormulaDependent = false;
            bool isFormulaField = false;
            if (!string.IsNullOrEmpty(lstInve.ValidationText))
            {
                if (!hFormulaCollection.Contains(lstInve.AccessionNumber + "," + lstInve.GroupID))
                {
                    if (lstInve.ValidationText.Contains("confirm"))
                    {
                        hFormulaCollection.Add(lstInve.AccessionNumber + "," + lstInve.GroupID, lstInve.ValidationText);
                    }
                    else
                    {
                        hFormulaCollection.Add(lstInve.AccessionNumber + "," + lstInve.GroupID, " var CurrentAccNo = id.split('~')[5]; var accNo = '" + ClientID + "'; var AccNo1 = accNo.split('~')[5]; if(CurrentAccNo == AccNo1) {" + lstInve.ValidationText + "}");
                    }
                }

                Formula = hFormulaCollection[lstInve.AccessionNumber + "," + lstInve.GroupID].ToString();
                if (Formula.Contains("[" + lstInve.InvestigationID + "]"))
                {
                    isFormulaDependent = true;
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
                    if (Formula.Replace(" ", "").Contains("[" + lstInve.InvestigationID + "]="))
                    {
                        isFormulaField = true;
                        if (lstInve.TestStatus != "FE")
                        {
                            lstFormula.Add(ClientID);
                        }
                        if (lstInve.TestStatus == "FE")
                        {
                            hdnEditableFormulaFields.Value = hdnEditableFormulaFields.Value + txtValue.ClientID + "^";
                        }
                        HiddenField hdnPanicXmlContent = (HiddenField)bioPattern1.FindControl("hdnPanicXmlContent");
                        TextBox txtIsAbnormal = (TextBox)bioPattern1.FindControl("txtIsAbnormal");
                        Label lblName = (Label)bioPattern1.FindControl("lblName");
                        Label lblUnit = (Label)bioPattern1.FindControl("lblUnit");
                        CheckBox cb = (CheckBox)bioPattern1.FindControl("ChkQcValue");

                        txtValue.Attributes.Add("style", "background-color:#FABF8F");

                        if (lstInve.ResultValueType == "NTS")
                        {
                            if (isInterpretationRange)
                            {
                                Formula = Formula + "var lstCurrentAccNo = id.split('~'); var accNo = '" + ClientID + "'; var lstAccNo = accNo.split('~'); if(lstCurrentAccNo[5] == lstAccNo[5] && document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','" + lstInve.Age + "','" + lstInve.Sex + "');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                            else
                            {
                                Formula = Formula + "var lstCurrentAccNo = id.split('~'); var accNo = '" + ClientID + "'; var lstAccNo = accNo.split('~'); if(lstCurrentAccNo[5] == lstAccNo[5] && document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');ReplaceNumberWithCommas('" + ClientID + "');}";
                            }
                        }
                        else
                        {
                            if (isInterpretationRange)
                            {
                                Formula = Formula + "var lstCurrentAccNo = id.split('~'); var accNo = '" + ClientID + "'; var lstAccNo = accNo.split('~'); if(lstCurrentAccNo[5] == lstAccNo[5] && document.getElementById('" + ClientID + "').value!=''){ValidateInterpretationRange(" + bioPattern1.PatternID + ",'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + bioPattern1.DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + bioPattern1.AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','" + lstInve.Age + "','" + lstInve.Sex + "');setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
                            }
                            else
                            {
                                Formula = Formula + "var lstCurrentAccNo = id.split('~'); var accNo = '" + ClientID + "'; var lstAccNo = accNo.split('~'); if(lstCurrentAccNo[5] == lstAccNo[5] && document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');formatResult('" + ClientID + "','" + bioPattern1.DecimalPlaces + "');}";
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
                        if ((lstPendingval != null && lstPendingval.Count > 0 && !String.IsNullOrEmpty(lstPendingval[0].Value)))
                        {
                            LabUtil oLabUtil = new LabUtil();
                            oLabUtil.IsSpecialResultValue(lstPendingval[0].Value, out isSpecialValue);
                        }
                        bioPattern1.IsSpecialValue = isSpecialValue;
                        Formula = Formula.Replace("'[" + lstInve.InvestigationID + "]'", "'" + ClientID + "'");
                        if (lstInve.ResultValueType == "NTS" || isSpecialValue || isInterpretationRange)
                        {
                            if ((lstPendingval != null && lstPendingval.Count > 0 && !String.IsNullOrEmpty(lstPendingval[0].Value)))
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
                hFormulaCollection[lstInve.AccessionNumber + "," + lstInve.GroupID] = Formula;
                //hdndeltaChecks.Value = lstOrdered[0].QCData;
                //Session["Qccheck"] = hdndeltaChecks.Value;
            }
           
            bioPattern1.BatchWise(true);
            if (isFormulaField && lstiominv != null && lstiominv.Count > 0 && !String.IsNullOrEmpty(lstiominv[0].ReferenceRange))
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
            // Below line is to display the abnormal in pending or reopening
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    bioPattern1.IsAbnormal = lstInve.IsAbnormal;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + bioPattern1.TxtControlID, "LoadAbnormalValue('" + bioPattern1.TxtControlID + "','','" + lstInve.IsAbnormal + "','" + bioPattern1.TestName + "','" + bioPattern1.TestUnit + "','" + bioPattern1.IsAutoAuthorize + "');", true);
                }
            }
            catch (Exception es)
            {
            }
            bioPattern1.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID && p.PatientVisitID == lstInve.PatientVisitID && p.AccessionNumber == lstInve.AccessionNumber));
            try
            {
                if (hdnActionName.Value == "EnterResult" && txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    DropDownList ddlstatus = (DropDownList)bioPattern1.FindControl("ddlstatus");
                    if (lstInve.GroupID == 0 && !isFormulaDependent && !string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && !String.IsNullOrEmpty(bioPattern1.DeviceID) && String.IsNullOrEmpty(lstInve.TestStatus) && (bioPattern1.IsAbnormal == "" || bioPattern1.IsAbnormal == "N"))
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
                        else
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                            ddlstatus.SelectedIndex = index;
                        }
                    }
                    bioPattern1.loadMethodForHistory(DemoBulk.FindAll(p => p.PatientVisitID == lstInve.PatientVisitID));
                }
                
            }
            catch (Exception e)
            {
            }
            
            bioPattern1.setNonEditable(lstInve);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return bioPattern1;
    }
    public Control LoadFishPattern1(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_FishPattern1 FishPt;
        FishPt = (Investigation_FishPattern1)LoadControl(lstInve.PatternName);

        try
        {
            FishPt.EnableViewState = false;
            int groupID = lstInve.GroupID;
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);

            FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishPt.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
            FishPt.VisitID = lstInve.PatientVisitID;
            FishPt.PatientID = lstInve.PatientID;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            FishPt.UID = lstInve.UID;
            FishPt.Name = lstInve.InvestigationName;
            FishPt.GroupID = lstInve.GroupID;
            FishPt.GroupName = lstInve.GroupName;
            FishPt.Age = lstInve.Age;
            FishPt.Sex = lstInve.Sex;
            FishPt.PatientName = lstInve.Name;
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.ResultValueType = lstInve.ResultValueType;
            FishPt.LabNo = lstInve.LabNo;
            FishPt.POrgid = OrgID;
            FishPt.PatientVisitID = lstInve.PatientVisitID;
            FishPt.PatternID = lstInve.PatternID;
            FishPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.VisitNumber = lstInve.VisitNumber;
            FishPt.IsAutoValidate = lstInve.IsAutoValidate;
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.BatchWise(true);
            lstControl.Add(FishPt.ID);
            lstpatternID.Add(lstInve.PatternID);

            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
            }
            long ReturnRes;
            TextBox txtValue = (TextBox)FishPt.FindControl("txtValue");
            HiddenField hdnResultValue = (HiddenField)FishPt.FindControl("hdnResultValue");
            string ClientID = txtValue.ClientID;
            //added by prabakar for common emtry string validation
            if (lstInve.IsAllowNull.ToUpper() == "N")
            {
                PatientInvestigation piobj = new PatientInvestigation();
                piobj.InvestigationName = lstInve.InvestigationName;
                piobj.InstrumentName = txtValue.ClientID;
                lstInvestigationValuesforAlert.Add(piobj);
            }
            //
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
                if (!hFormulaCollection.Contains(lstInve.AccessionNumber + "," + lstInve.GroupID))
                {
                    hFormulaCollection.Add(lstInve.AccessionNumber + "," + lstInve.GroupID, lstInve.ValidationText);

                }

                Formula = hFormulaCollection[lstInve.AccessionNumber + "," + lstInve.GroupID].ToString();
                if (Formula.Contains("[" + lstInve.InvestigationID + "]"))
                {
                    if (Formula.Replace(" ", "").Contains("[" + lstInve.InvestigationID + "]="))
                    {
                        if (lstInve.TestStatus != "FE")
                        {
                            lstFormula.Add(ClientID);
                        }
                        if (lstInve.TestStatus == "FE")
                        {
                            hdnEditableFormulaFields.Value = hdnEditableFormulaFields.Value + txtValue.ClientID + "^";
                        }
                        txtValue.Attributes.Add("style", "background-color:#FABF8F");
                        Formula = Formula + "var lstCurrentAccNo = id.split('~'); var accNo = '" + ClientID + "'; var lstAccNo = accNo.split('~'); if(lstCurrentAccNo[5] == lstAccNo[5] && document.getElementById('" + ClientID + "').value!=''){setCompletedStatus('" + lstInve.GroupName + "','" + ClientID + "','" + lstInve.IsAutoValidate + "');}";
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
                            if ((lstPendingval != null && lstPendingval.Count > 0 && !String.IsNullOrEmpty(lstPendingval[0].Value)))
                            {
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "SRV" + FishPt.ControlID, "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID + "');", true);
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
                    FishPt.Formula = lstInvOrgGroup[0].ValidationRule;
                }
                hFormulaCollection[lstInve.AccessionNumber + "," + lstInve.GroupID] = Formula;
            }
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + FishPt.ID + "_ddlstatus";
            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID && p.PatientVisitID == lstInve.PatientVisitID && p.AccessionNumber == lstInve.AccessionNumber));
            FishPt.LoadDataForEdit(lstPendingval);
            try
            {
                if (hdnActionName.Value == "EnterResult" && txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                    if (lstInve.IsAutoValidate == "Y")
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    else
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        ddlstatus.SelectedIndex = index;
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
        Investigation_Fishpattern2 FishPt;
        FishPt = (Investigation_Fishpattern2)LoadControl(lstInve.PatternName);

        try
        {
            FishPt.EnableViewState = false;
            int groupID = lstInve.GroupID;
            FishPt.OrgID = OrgID;
            FishPt.RoleID = RoleID;
            FishPt.LID = LID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);

            FishPt.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            FishPt.ControlID = Convert.ToString(lstInve.InvestigationID);
            FishPt.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
            FishPt.VisitID = lstInve.PatientVisitID;
            FishPt.PatientID = lstInve.PatientID;
            FishPt.AccessionNumber = lstInve.AccessionNumber;
            FishPt.UID = lstInve.UID;
            FishPt.Name = lstInve.InvestigationName;
            FishPt.GroupID = lstInve.GroupID;
            FishPt.GroupName = lstInve.GroupName;
            FishPt.Age = lstInve.Age;
            FishPt.Sex = lstInve.Sex;
            FishPt.PatientName = lstInve.Name;
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.LabNo = lstInve.LabNo;
            FishPt.POrgid = OrgID;
            FishPt.PatientVisitID = lstInve.PatientVisitID;
            FishPt.PatternID = lstInve.PatternID;
            FishPt.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            FishPt.TestStatus = lstInve.TestStatus;
            FishPt.VisitNumber = lstInve.VisitNumber;
            FishPt.IsAutoValidate = lstInve.IsAutoValidate;
            FishPt.DecimalPlaces = lstInve.DecimalPlaces;
            FishPt.BatchWise(true);
            lstControl.Add(FishPt.ID);
            lstpatternID.Add(lstInve.PatternID);
            long ReturnRes;
            TextBox txtValue = (TextBox)FishPt.FindControl("txtValue");

            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + FishPt.ID + "_ddlstatus";
            FishPt.loadMethod(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID && p.PatientVisitID == lstInve.PatientVisitID && p.AccessionNumber == lstInve.AccessionNumber));
            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    FishPt.LoadDataForEdit(lstPendingval);
                }
            }
            try
            {
                if (hdnActionName.Value == "EnterResult" && txtValue.Text != null && txtValue.Text.Trim().Length > 0)
                {
                    DropDownList ddlstatus = (DropDownList)FishPt.FindControl("ddlstatus");
                    if (lstInve.IsAutoValidate == "Y")
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Validate"));
                        ddlstatus.SelectedIndex = index;
                    }
                    else
                    {
                        int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                        ddlstatus.SelectedIndex = index;
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
    public Control LoadBioPattern2(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern2 Bio1;
        Bio1 = (Investigation_BioPattern2)LoadControl(lstInve.PatternName);

        try
        {
            Bio1.EnableViewState = false;
            int groupID = lstInve.GroupID;
            Bio1.POrgid = OrgID;
            Bio1.OrgID = OrgID;
            Bio1.RoleID = RoleID;
            Bio1.LID = LID;

            Bio1.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
            Bio1.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID && p.PatientVisitID == lstInve.PatientVisitID && p.AccessionNumber == lstInve.AccessionNumber));
            Bio1.Name = lstInve.InvestigationName;
            Bio1.UOM = lstInve.UOMCode;
            Bio1.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio1.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio1.GroupID = lstInve.GroupID;
            Bio1.GroupName = lstInve.GroupName;
            Bio1.PackageID = lstInve.PackageID;
            Bio1.PackageName = lstInve.PackageName;
            Bio1.CurrentRoleName = RoleName;
            Bio1.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio1.DecimalPlaces = lstInve.DecimalPlaces;
            Bio1.ResultValueType = lstInve.ResultValueType;
            Bio1.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            IsExcludeAutoApproval = lstInve.RefSuffixText;
            Bio1.VisitID = lstInve.PatientVisitID;
            Bio1.AccessionNumber = lstInve.AccessionNumber;
            Bio1.UID = lstInve.UID;
            Bio1.PatientName = lstInve.Name;
            Bio1.Age = lstInve.Age;
            Bio1.Sex = lstInve.Sex;
            Bio1.LabNo = lstInve.LabNo;
            Bio1.PatientVisitID = lstInve.PatientVisitID;
            Bio1.PatternID = lstInve.PatternID;
            Bio1.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio1.TestStatus = lstInve.TestStatus;
            Bio1.VisitNumber = lstInve.VisitNumber;
            Bio1.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio1.IsAutoValidate = lstInve.IsAutoValidate;
            Bio1.DecimalPlaces = lstInve.DecimalPlaces;
            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    Bio1.setValues(lstPendingval);

                    if (!String.IsNullOrEmpty(lstPendingval[0].Value))
                    {
                        String ddlValue = lstPendingval[0].Value.Split(',')[0];
                        if (!String.IsNullOrEmpty(ddlValue))
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), Bio1.DDLClientID, "setDropdownValues('" + Bio1.DDLClientID + "','" + Bio1.hdnDDLClientID + "','" + ddlValue + "');", true);
                        }
                    }
                }
            }
            //code added for reference range - begin
            string ReferenceRange;
            string PrintableRange = string.Empty;
            
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.PatientID, lstInve.PatientVisitID, out ReferenceRange, lstInve.UOMCode, out PrintableRange);
                Bio1.RefRange = ReferenceRange;
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
                    if (lstInve.ReferenceRange != null)
                    {
                        Bio1.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
                }
                if (!string.IsNullOrEmpty(lstInve.PrintableRange))
                {
                    Bio1.PrintableRange = lstInve.PrintableRange.Trim().Replace("<br>", "\n");
                }
            }

            //code added for reference range - end
            lstControl.Add(Bio1.ID);

            lstiominv = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstiominv != null && lstiominv.Count > 0)
            {
                Bio1.setXmlValues(lstiominv[0].ReferenceRange);
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

            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Bio1.ID + "_ddlstatus";
            Bio1.BatchWise(true);
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    Bio1.IsAbnormal = lstInve.IsAbnormal;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio1.TxtControlID, "LoadAbnormalValue('" + Bio1.TxtControlID + "','" + Bio1.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio1.TestName + "','" + Bio1.TestUnit + "','" + Bio1.IsAutoAuthorize + "');", true);
                }
            }
            catch (Exception es)
            {
            }
            Bio1.loadMethodForHistory(DemoBulk.FindAll(p => p.PatientVisitID == lstInve.PatientVisitID));
            try
            {
                if (hdnActionName.Value == "EnterResult" && lstPendingval != null && lstPendingval.Count > 0 && !string.IsNullOrEmpty(lstPendingval[0].Value))
                {
                    HiddenField hdnXmlContent = (HiddenField)Bio1.FindControl("hdnXmlContent");
                    DropDownList ddlstatus = (DropDownList)Bio1.FindControl("ddlstatus");
                    if (lstInve.GroupID == 0 && !string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && !String.IsNullOrEmpty(Bio1.DeviceID) && String.IsNullOrEmpty(lstInve.TestStatus) && (Bio1.IsAbnormal == "" || Bio1.IsAbnormal == "N"))
                    {
                        // ddlstatus.Items.Add(new ListItem("Validate", "Validate_10"));
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
                        else
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                            ddlstatus.SelectedIndex = index;
                        }
                    }
                }
            }
            catch (Exception e)
            {
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return Bio1;
    }
    public Control LoadBioPattern3(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_BioPattern3 Bio;
        Bio = (Investigation_BioPattern3)LoadControl(lstInve.PatternName);

        try
        {
            Bio.EnableViewState = false;
            int groupID = lstInve.GroupID;
            Bio.POrgid = OrgID;
            Bio.OrgID = OrgID;
            Bio.RoleID = RoleID;
            Bio.LID = LID;
            //Get Data to populate Dropdown list
            Bio.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
            Bio.LoadData(DemoBulk.FindAll(p => p.InvestigationID == InvestigationID && p.GroupID == groupID && p.PatientVisitID == lstInve.PatientVisitID && p.AccessionNumber == lstInve.AccessionNumber));
            Bio.Name = lstInve.InvestigationName;
            Bio.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Bio.ControlID = Convert.ToString(lstInve.InvestigationID);
            Bio.GroupID = lstInve.GroupID;
            Bio.GroupName = lstInve.GroupName;
            Bio.PackageID = lstInve.PackageID;
            Bio.PackageName = lstInve.PackageName;
            Bio.CurrentRoleName = RoleName;
            Bio.LabTechEditMedRem = strLabTechToEditMedRem;
            Bio.VisitID = lstInve.PatientVisitID;
            Bio.AccessionNumber = lstInve.AccessionNumber;
            Bio.UID = lstInve.UID;
            Bio.PatientName = lstInve.Name;
            Bio.Age = lstInve.Age;
            Bio.Sex = lstInve.Sex;
            Bio.LabNo = lstInve.LabNo;
            Bio.AutoApproveLoginID = lstInve.AutoApproveLoginID;
            Bio.PatientVisitID = lstInve.PatientVisitID;
            Bio.PatternID = lstInve.PatternID;
            Bio.IsDeltaCheckWant = Convert.ToBoolean(hdnIsDeltaCheckWant.Value);
            Bio.TestStatus = lstInve.TestStatus;
            Bio.VisitNumber = lstInve.VisitNumber;
            Bio.IsAutoAuthorize = lstInve.IsAutoAuthorize;
            Bio.IsAutoValidate = lstInve.IsAutoValidate;
            Bio.BatchWise(true);
            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    Bio.LoadDataForEdit(lstPendingval);

                    if (!String.IsNullOrEmpty(lstPendingval[0].Value))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), Bio.DDLClientID, "setDropdownValues('" + Bio.DDLClientID + "','" + Bio.hdnDDLClientID + "','" + lstPendingval[0].Value + "');", true);
                    }
                }
            }
            //code added for reference range - begin
            string ReferenceRange;
            string PrintableRange = string.Empty;
            if (lstInve.ReferenceRange != null && LabUtil.TryParseXml(lstInve.ReferenceRange))
            {
                ConvertXmlToString(lstInve.ReferenceRange, lstInve.PatientID, lstInve.PatientVisitID, out ReferenceRange, lstInve.UOMCode, out PrintableRange);
                Bio.RefRange = ReferenceRange;
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
                    if (lstInve.ReferenceRange != null)
                    {
                        Bio.RefRange = lstInve.ReferenceRange.Trim().Replace("<br>", "\n");
                    }
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
            Bio.UOM = lstInve.UOMCode;
            lstControl.Add(Bio.ID);
            lstpatternID.Add(lstInve.PatternID);

            lstiominv = lstiom.FindAll(p => p.InvestigationID == InvestigationID);
            if (lstiominv != null && lstiominv.Count > 0)
            {
                Bio.setXmlValues(lstiominv[0].ReferenceRange);
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
            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Bio.ID + "_ddlstatus";
            try
            {
                if (lstInve.IsAbnormal != null && (lstInve.IsAbnormal == "A" || lstInve.IsAbnormal == "L" || lstInve.IsAbnormal == "P" || lstInve.IsAbnormal == "N"))
                {
                    Bio.IsAbnormal = lstInve.IsAbnormal;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "loadingabnormalvalue" + Bio.DDLClientID, "LoadAbnormalValue('','" + Bio.DDLClientID + "','" + lstInve.IsAbnormal + "','" + Bio.TestName + "','" + Bio.TestUnit + "','" + Bio.IsAutoAuthorize + "');", true);
                }
            }
            catch (Exception es)
            {
            }
            try
            {
                if (hdnActionName.Value == "EnterResult" && lstPendingval != null && !string.IsNullOrEmpty(lstPendingval[0].Value))
                {
                    HiddenField hdnXmlContent = (HiddenField)Bio.FindControl("hdnXmlContent");
                    DropDownList ddlstatus = (DropDownList)Bio.FindControl("ddlstatus");
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
                        else
                        {
                            int index = ddlstatus.Items.IndexOf(ddlstatus.Items.FindByText("Completed"));
                            ddlstatus.SelectedIndex = index;
                        }
                    }
                }
            }
            catch (Exception e)
            {
            }
            Bio.loadMethodForHistory(DemoBulk.FindAll(p => p.PatientVisitID == lstInve.PatientVisitID));
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return Bio;
    }
    public Control LoadImagePattern(PatientInvestigation lstInve)
    {
        long InvestigationID = lstInve.InvestigationID;
        Investigation_ImageUploadpattern Img;
        Img = (Investigation_ImageUploadpattern)LoadControl(lstInve.PatternName);

        try
        {
            Img.EnableViewState = false;
            int groupID = lstInve.GroupID;
            Investigation_BL invesBL = new Investigation_BL(base.ContextInfo);
            Img.ShowImagePattern();
            Img.ID = (Convert.ToString(lstInve.InvestigationID) + "~" + lstInve.GroupName + "~" + lstInve.GroupID + "~" + lstInve.RootGroupID + "~" + lstInve.PackageID + "~" + Convert.ToString(lstInve.AccessionNumber));
            Img.ControlID = Convert.ToString(lstInve.InvestigationID);
            Img.loadStatus(header.FindAll(p => p.Status == lstInve.Status));
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
            Img.LabNo = lstInve.LabNo;
            Img.POrgid = OrgID;
            Img.PatientVisitID = lstInve.PatientVisitID;
            Img.PatternID = lstInve.PatternID;
            Img.TestStatus = lstInve.TestStatus;
            Img.VisitNumber = lstInve.VisitNumber;
            Img.BatchWise(true);
            Img.IsAutoValidate = lstInve.IsAutoValidate;
            lstControl.Add(Img.ID);
            lstpatternID.Add(lstInve.PatternID);

            hdnGroupCollection.Value = hdnGroupCollection.Value + "^" + lstInve.GroupID + "^" + lstInve.DeptName + "|" + lstInve.GroupName + "|" + Img.ID + "_ddlstatus";
            if (lstPendingValue != null && lstPendingValue.Count > 0)
            {
                lstPendingval = lstPendingValue.FindAll(p => p.InvestigationID == InvestigationID && p.PatientVisitID == lstInve.PatientVisitID && p.GroupID == lstInve.GroupID && p.AccessionNumber == lstInve.AccessionNumber);
                if (lstPendingval != null && lstPendingval.Count > 0)
                {
                    Img.LoadDataForEdit(lstPendingval);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadImagePattern ", ex);
        }
        return Img;
    }
    private void SaveContinue()
    {
        try
        {
            hdnButtonName.Value = string.Empty;
            if (Request.QueryString["pid"] != null)
            {
                PageContextDetails.PatientID = Convert.ToInt64(Request.QueryString["pid"]);
            }
            long returncode = AutoSave();

            if (returncode == 0)
            {
                List<PatientInvestigation> Patinvestasks = new List<PatientInvestigation>();
                Patinvestasks = lstpatinvestigation.GroupBy(x => new { x.PatientVisitID, x.PatternID, x.UID, x.LabNo })
                    .Select(y => new PatientInvestigation()
                    {
                        PatientVisitID = y.Key.PatientVisitID,
                        PatternID = y.Key.PatternID,
                        UID = y.Key.UID,
                        LabNo = y.Key.LabNo
                    }
                    ).Distinct().ToList();
                if (Patinvestasks.Count > 0)
                {
                    Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);
                    long returnCode = -1;
                    List<InvestigationStatus> lstInvStatus;
                    List<InvestigationStatus> lstFilteredInvStatus;
                    int completedCount = 0;
                    int notGivenStatus = 0;
                    List<PatientVisitDetails> lstVisitDetails;
                    List<OrderedInvestigations> FilteredInvestigations = new List<OrderedInvestigations>();
                    foreach (PatientInvestigation item in Patinvestasks)
                    {
                        lstInvStatus = new List<InvestigationStatus>();
                        lstFilteredInvStatus = new List<InvestigationStatus>();
                        lstVisitDetails = new List<PatientVisitDetails>();
                        completedCount = 0;
                        notGivenStatus = 0;

                        returnCode = DemoBL.GetPatientInvestigationStatus(item.PatientVisitID, OrgID, item.UID, out lstInvStatus, out lstVisitDetails, out completedCount, out notGivenStatus);
                        /**Exclude VID Lock for Org to Org Transfered Tests ***/
                        lstFilteredInvStatus = lstInvStatus.FindAll(P => P.ExcludeVIDlock == "N");

                        if (hdnActionName.Value == "EnterResult")
                        {
                            if (completedCount > 0)
                            {
                                Tasks task = new Tasks();
                                Hashtable dText = new Hashtable();
                                Hashtable urlVal = new Hashtable();

                                long createTaskID = -1;

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
                                returncode = Utilities.GetHashTable(Convert.ToInt64(TaskActionID),
                                             item.PatientVisitID, 0, lstVisitDetails[0].PatientID, lstVisitDetails[0].TitleName + " " +
                                             lstVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                             , out dText, out urlVal, "0", lstVisitDetails[0].PatientNumber, 0,
                                             item.UID, lstVisitDetails[0].ExternalVisitID, lstVisitDetails[0].VisitNumber,"");
                                task.TaskActionID = Convert.ToInt32(TaskActionID);
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.RoleID = RoleID;
                                task.OrgID = OrgID;
                                task.PatientVisitID = item.PatientVisitID;
                                task.PatientID = lstVisitDetails[0].PatientID;
                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                task.CreatedBy = LID;
                                task.RefernceID = item.LabNo;
                                //Create task               
                                returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                                string display = string.Empty;
                            }
                            else
                            {
                                CreateTask(item, lstFilteredInvStatus, notGivenStatus, lstVisitDetails);
                            }
                        }
                        else
                        {

                            CreateTask(item, lstFilteredInvStatus, notGivenStatus, lstVisitDetails);
                        }
                    }
                }
            }
            DInvest.Style.Add("display", "none");
            tblTotal.Style.Add("display", "none");
            //btnBatchSearch_Click(null, null);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public void CreateTask(PatientInvestigation item, List<InvestigationStatus> _InvestigationList, int notGivenCount, List<PatientVisitDetails> lstVisitDetails)
    {
        try
        {
            Investigation_BL DemoBL = new Investigation_BL(base.ContextInfo);
            List<InvestigationStatus> _NonapprovedInvestigations = new List<InvestigationStatus>();
            List<InvestigationStatus> lstCoauthorizeInvestigations = new List<InvestigationStatus>();
            List<InvestigationStatus> lstSecondOpinionInvestigations = new List<InvestigationStatus>();
            List<InvestigationStatus> SecondOpinionInvestigations = new List<InvestigationStatus>();
            List<InvestigationStatus> WithholdValidationInvestigations = new List<InvestigationStatus>();
            List<InvestigationStatus> ValidatableInvestigations = new List<InvestigationStatus>();
            List<PatientInvestigation> lsttmpPatientInvestigation = new List<PatientInvestigation>();
            List<InvestigationStatus> FilteredInvestigations = new List<InvestigationStatus>();

            int nonValidatedCount = 0;
            int AutoApproveQueueCount = 0;
            int NormalApproveTestCount = 0;
            long returnCode = -1;

            /**Exclude VID Lock for Org to Org Transfered Tests ***/
            FilteredInvestigations = _InvestigationList.FindAll(P => P.ExcludeVIDlock == "N");

            nonValidatedCount = (from IL in FilteredInvestigations
                                 where IL.Status != InvStatus.Validate && IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize
                                 && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.PartiallyValidated && IL.Status != InvStatus.Cancel
                                 && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld
                                 && IL.Status != InvStatus.WithholdValidation && IL.Status != InvStatus.WithholdApproval && IL.Status != "ReflexTest"
                                   && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive"
                                 select IL).Count();
            int nonAutoautherizedCount = 0;
            nonAutoautherizedCount = (from IL in FilteredInvestigations
                                      where (IL.Status == InvStatus.Validate || IL.Status == "PartiallyValidated") && IL.IsAutoAuthorize == "N"
                                      select IL).Count();
            int WithholdValidationInvestigationsCount = 0;
            WithholdValidationInvestigationsCount = (from IL in FilteredInvestigations
                                                     where IL.Status == InvStatus.WithholdValidation
                                                     select IL).Count();
            if (nonValidatedCount > 0 && notGivenCount <= 0)
            {
                nonValidatedCount = 0;
            }
            _NonapprovedInvestigations = (from IL in FilteredInvestigations
                                          where IL.Status != InvStatus.Approved && IL.Status != InvStatus.Coauthorize && IL.Status != InvStatus.SecondOpinion && IL.Status != InvStatus.OpinionGiven
                                           && IL.Status != InvStatus.Coauthorized && IL.Status != InvStatus.PartialyApproved && IL.Status != InvStatus.WithHeld && IL.Status != InvStatus.Cancel
                                           && IL.Status != InvStatus.WithholdValidation && IL.Status != InvStatus.WithholdApproval && IL.Status != "ReflexTest" && IL.Status != InvStatus.ReflexWithNewSample && IL.Status != InvStatus.ReflexWithSameSample
                                             && IL.Status != InvStatus.Rejected && IL.Status != "Rejected" && IL.Status != InvStatus.Retest && IL.Status != "InActive"
                                          select IL).Distinct().ToList();
            Tasks_BL oTasksBL = new Tasks_BL(base.ContextInfo);
            if (_NonapprovedInvestigations.Count == 0)
            {
                oTasksBL.UpdateTaskForaVisit(item.PatientVisitID, OrgID, LID, Convert.ToInt16(TaskHelper.TaskAction.Approval));
            }
            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();

            long createTaskID = -1;
            PatientVisit_BL objPatientVisit_BL = new PatientVisit_BL();

            int OtherID = RoleID;
            returnCode = DemoBL.GetPatientInvestigationStatus(item.PatientVisitID, OrgID, out lsttmpPatientInvestigation);
            AutoApproveQueueCount = (from IL in lsttmpPatientInvestigation
                                     where IL.IsAutoApproveQueue == "Y"
                                     select IL).Count();
            NormalApproveTestCount = (from IL in lsttmpPatientInvestigation
                                      where IL.AutoApproveLoginID == 0
                                      select IL).Count();
            if (FilteredInvestigations.FindAll(P => P.Status == InvStatus.Validate).Count > 0 && nonAutoautherizedCount == 0)
            {
                if (AutoApproveQueueCount > 0)
                {
                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.AutoApproval),
                                   item.PatientVisitID, 0, lstVisitDetails[0].PatientID, lstVisitDetails[0].TitleName + " " +
                                   lstVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                   , out dText, out urlVal, "0", lstVisitDetails[0].PatientNumber, 0,
                                   item.UID, lstVisitDetails[0].ExternalVisitID, lstVisitDetails[0].VisitNumber,"");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.AutoApproval);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = item.PatientVisitID;
                    task.PatientID = lstVisitDetails[0].PatientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    task.RefernceID = item.LabNo;
                    //Create task               
                    returncode = oTasksBL.CreateTask(task, out createTaskID);
                }
                else
                {
                    int returnStatus = -1;
                    returncode = DemoBL.ApprovePatientInvestigationStatus(lsttmpPatientInvestigation, item.UID, out returnStatus);
                    if (returnStatus > 0)
                    {
                        ActionManager AM = new ActionManager(base.ContextInfo);
                        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
                        PageContextkey PC = new PageContextkey();
                        PC.ID = Convert.ToInt64(ILocationID);
                        PC.PatientID = Convert.ToInt64(PageContextDetails.PatientID);
                        PC.RoleID = Convert.ToInt64(RoleID);
                        PC.OrgID = OrgID;
                        PC.PatientVisitID = item.PatientVisitID;
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
                if (FilteredInvestigations.FindAll(P => P.Status == InvStatus.Validate).Count > 0 && nonValidatedCount == 0)
                {
                    returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Validate),
                                item.PatientVisitID, 0, lstVisitDetails[0].PatientID, lstVisitDetails[0].TitleName + " " +
                                lstVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                                , out dText, out urlVal, "0", lstVisitDetails[0].PatientNumber, 0,
                                item.UID, lstVisitDetails[0].ExternalVisitID, lstVisitDetails[0].VisitNumber,"");
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.Validate);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = item.PatientVisitID;
                    task.PatientID = lstVisitDetails[0].PatientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    task.RefernceID = item.LabNo;
                    //Create task               
                    returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                    string display = string.Empty;
                }
            }
            if (WithholdValidationInvestigationsCount > 0)
            {
                returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.WithholdValidation),
                             item.PatientVisitID, 0, lstVisitDetails[0].PatientID, lstVisitDetails[0].TitleName + " " +
                             lstVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV"
                             , out dText, out urlVal, "0", lstVisitDetails[0].PatientNumber, 0,
                             item.UID, lstVisitDetails[0].ExternalVisitID, lstVisitDetails[0].VisitNumber,"");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.WithholdValidation);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = item.PatientVisitID;
                task.PatientID = lstVisitDetails[0].PatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                task.RefernceID = item.LabNo;
                //Create task               
                returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                string display = string.Empty;
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
    public void LoadLocationNEW()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, RoleID, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                //ParentLoc = (from lst in lstOrganizationAddress
                //             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                //             select lst).ToList();
                //LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlLocation.DataSource = LoginLoc;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
            else
            {
                ddlLocation.DataSource = lstOrganizationAddress;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
        }
        //ddlocations.Items.Insert(0, strSelect.Trim());
        //ddlocations.Items[0].Value = "0";
    }


    //public void GetTasks(int currentPageNo, int PageSize)
    //{
    //    TaskProfile taskprofile = new TaskProfile();
    //    taskprofile.LoginID = LID;
    //    taskprofile.RoleID = Convert.ToInt64(RoleID);
    //    taskprofile.OrgID = OrgID;
    //    taskprofile.OrgAddressID = ILocationID;
    //    taskprofile.Location = ddLO.SelectedValue;
    //    taskprofile.Type = "Task";



    //    if (ddlInstrument.SelectedValue != "")
    //    {
    //        taskprofile.DeptID = Convert.ToInt32(ddlInstrument.SelectedValue);
    //    }
    //    else
    //    {
    //        taskprofile.DeptID = 0;
    //    }





    //    string sLoc = ddlLocation.SelectedValue == "0" ? "-1" : ddlLocation.SelectedValue;
    //    if (sLoc == "")
    //    {
    //        sLoc = "-1";
    //    }

    //    string sDept = ddlDept.SelectedValue == "0" ? "-1" : ddlDept.SelectedValue;
       
    //    //if (txttext.Text.Trim() == defaultText.Trim())
    //    //{
    //    //    txttext.Text = "";
    //    //}
       
    //    int ClientID = 0;
    //    if (hdnSelectedClientID.Value != null && hdnSelectedClientID.Value != "0")
    //    {
    //        Int32.TryParse(hdnSelectedClientID.Value, out ClientID);
    //    }
    //    if (hdnSelectedClientID.Value == "0")
    //    {
    //        if (txtClientName.Text != null && txtClientName.Text != "")
    //        {
    //            if (Request.QueryString["CLID"] != null)
    //            {
    //                Int32.TryParse(Request.QueryString["CLID"], out ClientID);
    //            }
    //        }
    //    }

    //    //string PatientNumber = txtPatientNumber.Text == "" ? "-1" : txtPatientNumber.Text;
    //    GetAllData(sDate, sCat, Convert.ToInt64(sLoc), Convert.ToInt32(sSpec), PatientNumber, inventoryLocationID, currentPageNo, PageSize, out totalRows, Convert.ToInt32(sDept), ClientID, ProtocalGroupID);
    //    //OrgLocation = Convert.ToInt32(sLoc);

    //    //EventArgs e = new EventArgs();
    //    //if (onTaskLoadComplete != null)
    //    //{
    //    //    onTaskLoadComplete(this, e);
    //    //}

    //}
    #endregion
}
