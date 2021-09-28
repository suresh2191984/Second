using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Drawing;
using System.Web.Script.Serialization;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;
using System.Xml.XPath;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class CommonControls_TestMaster : BaseControl
{
    public CommonControls_TestMaster()
        : base("CommonControls_TestMaster_ascx")
    {
    }
    public string save_mesge = Resources.AppMessages.Save_Message;
    string xmlContent;
    string rawData;
    string xmlValue;
    string xmlString;
    LabUtil oLabUtil = new LabUtil();
    List<ReasonMaster> lstReasonMaster;
    Master_BL objReasonMaster;
    string Reftypes = "TM";
    //public delegate void delPopulateData(int myInt);
    string select = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40 == null ? "--Select--" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40;
    string Useyes = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_065 == null ? "Yes" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_065;
    string UseNo = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_066 == null ? "No" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_066;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {         
               
               //Role based view access of Test Master
                string val = Request.QueryString["View"];
                hdnView.Value = val;
                if (val == "Y")
                {
                    //Jr.Scientific Officer Lab role can't access test master
                    btnSave.Style.Add("display", "none");
                    btnReset.Style.Add("display", "none");
                    btnProcessingLocation.Style.Add("display", "none");
                  
                }
                else
                {
                    //Administrator can access test master 
                    btnSave.Style.Add("display", "block");
                    btnReset.Style.Add("display", "block");
                    btnProcessingLocation.Style.Add("display", "block");
                

                }
              
                lblMessage.Text = string.Empty;
                ACETestCodeScheme.ContextKey = OrgID + "~" + CodeSchemeType.Investigations;
                AutoCompleteReflexTesttMapping.ContextKey = OrgID + "~" + "";       // CodeSchemeType.Investigations;
                AutoCompleteCrossParameter.ContextKey = OrgID + "~" + "";  
                AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");

                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath;
                sPath = sPath + "/fckeditor/";

                //FCKeditor1.BasePath = sPath;
                //FCKeditor1.ToolbarSet = "Interpretation";
                //FCKeditor1.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor1.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor1", String.Format("var lblFCKeditor1=\"{0}\";", FCKeditor1.ClientID), true);

                //ScriptManager.RegisterOnSubmitStatement(this, FCKeditor1.GetType(), FCKeditor1.ClientID + "editor1", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "').UpdateLinkedField();}}");

                //FCKeditor2.BasePath = sPath;
                //FCKeditor2.ToolbarSet = "Interpretation";
                //FCKeditor2.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor2.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor2", String.Format("var lblFCKeditor2=\"{0}\";", FCKeditor2.ClientID), true);

                //ScriptManager.RegisterOnSubmitStatement(this, FCKeditor2.GetType(), FCKeditor2.ClientID + "editor2", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "').UpdateLinkedField();}}");

                //FCKeditor3.BasePath = sPath;
                //FCKeditor3.ToolbarSet = "Interpretation";
                //FCKeditor3.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor3.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor3", String.Format("var lblFCKeditor3=\"{0}\";", FCKeditor3.ClientID), true);

                //ScriptManager.RegisterOnSubmitStatement(this, FCKeditor3.GetType(), FCKeditor3.ClientID + "editor3", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor3.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor3.ClientID + "').UpdateLinkedField();}}");

                hdnOrgID.Value = Convert.ToString(OrgID);
                hdnLocationID.Value = Convert.ToString(ILocationID);
                LoadMeatData();
                loadEmailTemplates();
                loadSMSTemplates();
                LoadDoctor();
                LoadScheduleType();
                Loadprotocalgroup();
				loadReasonDetails();
                LoadInvLocationMapping();
                hdnSelectedOrgID.Value = drpProcessingOrg.SelectedItem.Value;
            }

            string IsFieldTestConfig = GetConfigValues ("TestMasterFieldTest",OrgID );
                if (IsFieldTestConfig=="Y")
                {
                    chkIsFieldTest.Style.Add("display", "block");
                    lblIsFieldTest.Style.Add("display", "block"); 
                }
            else 
                {
                    chkIsFieldTest.Style.Add("display", "none");
                    lblIsFieldTest.Style.Add("display", "none"); 
                }
                
            string strHasOrederableReflex = GetConfigValues("HasOrderableReflex", OrgID);
            if (strHasOrederableReflex != "Y")
            {
                ChkChargeable.Attributes.Add("style:display", "none");
                lblChargeable.Attributes.Add("style:display", "none");

                ChkChargeable.Visible = false;
                lblChargeable.Visible = false;
            }
            string ConvReferenceRange = GetConfigValues("ConvReferenceRange", OrgID);
            if (!string.IsNullOrEmpty(ConvReferenceRange))
            {
                hdnConfRefRange.Value = ConvReferenceRange;
                if (hdnConfRefRange.Value == "Y")
                {
                    trConvUOMFactor.Style.Add("display", "table-row");
                    thConvUOMCode.Style.Add("display", "table-cell");
                    thConvFactorValue.Style.Add("display", "table-cell");
                    thConvdecimalvalue.Style.Add("display", "table-cell");

                }

                else
                {
                    trConvUOMFactor.Style.Add("display", "none");
                    thConvUOMCode.Style.Add("display", "none");
                    thConvFactorValue.Style.Add("display", "none");
                    thConvdecimalvalue.Style.Add("display", "none");

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in test master page load", ex);
        }
    }
    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            Int32 orgId = 0;

            orgId = OrgID;

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
	 void loadReasonDetails()
    {
        long returnCode = -1;
        lstReasonMaster = new List<ReasonMaster>();
        objReasonMaster = new Master_BL(base.ContextInfo);
        returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);

        if (lstReasonMaster.Count > 0)
        {
            string setID = "0";
            ddlReasonn.DataSource = lstReasonMaster;
            ddlReasonn.DataTextField = "Reason";
            ddlReasonn.DataValueField = "Reason";
            ddlReasonn.DataBind();
            ddlReasonn.Items.Insert(0, new ListItem(select, "0"));
            ddlReasonn.Items[0].Value = "0";
            ddlReasonn.SelectedValue = setID;
        }
    }
    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "Gender,TGender,DateAttributes,TMasterCtrlOperRange,TMasterCtrlOperRange1,TMasterCtrlInterpretation,TMasterCtrlSubCategory,TMasterCtrlRtype,DeltaCheckCalculation,DeltaCheckTimeUnit";
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
                                  where child.Domain == "Gender"
                                  select child;
                if (childItems.Count() > 0)
                {
                    ddlGender.DataSource = childItems;
                    ddlGender.DataTextField = "DisplayText";
                    ddlGender.DataValueField = "Code";
                    ddlGender.DataBind();
                    ddlGender.Items.Insert(0, new ListItem(select, "0"));
                    ddlGender.Items[0].Value = "0";
ddlGender.Items.Remove((ddlGender.Items.FindByValue("U")));
                    ddlGender.Items.Remove((ddlGender.Items.FindByValue("B"))); /*added by jagatheesh*/
                    ddlCategory.DataSource = childItems;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.DataBind();
                    ddlCategory.Items.Insert(0, new ListItem(select, "0"));
                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "DateAttributes"
                                 select child;
                if (childItems1.Count() > 0)
                {
                    ddlAgeType.DataSource = childItems1;
                    ddlAgeType.DataTextField = "DisplayText";
                    ddlAgeType.DataValueField = "Code";
                    ddlAgeType.DataBind();
                    ddlAgeType.Items.Insert(0, new ListItem(select, "0"));
                     ddlAgeType.Items.Remove((ddlAgeType.Items.FindByValue("UnKnown")));
                    
                    ddlOtherAgeType.DataSource = childItems1;
                    ddlOtherAgeType.DataTextField = "DisplayText";
                    ddlOtherAgeType.DataValueField = "Code";
                    ddlOtherAgeType.DataBind();
                    ddlOtherAgeType.Items.Insert(0, new ListItem(select, "0"));
                  
                    
                    
                }
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "TMasterCtrlOperRange"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddlOperatorRange1.DataSource = childItems2;
                    ddlOperatorRange1.DataTextField = "DisplayText";
                    ddlOperatorRange1.DataValueField = "Code";
                    ddlOperatorRange1.DataBind();
                    ddlOperatorRange1.Items.Insert(0, new ListItem(select, "0"));

                    ddlOtherAgeOperator.DataSource = childItems2;
                    ddlOtherAgeOperator.DataTextField = "DisplayText";
                    ddlOtherAgeOperator.DataValueField = "Code";
                    ddlOtherAgeOperator.DataBind();
                    ddlOtherAgeOperator.Items.Insert(0, new ListItem(select, "0"));

                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "TMasterCtrlOperRange1"
                                  select child;
                if (childItems3.Count() > 0)
                {
                    ddlOperatorRange2.DataSource = childItems3;
                    ddlOperatorRange2.DataTextField = "DisplayText";
                    ddlOperatorRange2.DataValueField = "Code";
                    ddlOperatorRange2.DataBind();
                    ddlOperatorRange2.Items.Insert(0, new ListItem(select, "0"));
                    ddlGenderValueOpt.DataSource = childItems3;
                    ddlGenderValueOpt.DataTextField = "DisplayText";
                    ddlGenderValueOpt.DataValueField = "Code";
                    ddlGenderValueOpt.DataBind();
                    //ddlGenderValueOpt.SelectedValue = "0";
                    ddlGenderValueOpt.Items.Insert(0, new ListItem(select, "0"));
                    ddlOtherRangeOpt.DataSource = childItems3;
                    ddlOtherRangeOpt.DataTextField = "DisplayText";
                    ddlOtherRangeOpt.DataValueField = "Code";
                    ddlOtherRangeOpt.DataBind();
                    ddlOtherRangeOpt.Items.Insert(0, new ListItem(select, "0"));
                  

                }
                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "TMasterCtrlInterpretation"
                                  select child;
                if (childItems4.Count() > 0)
                {
                    ddlAgeResult.DataSource = childItems4;
                    ddlAgeResult.DataTextField = "DisplayText";
                    ddlAgeResult.DataValueField = "Code";
                    ddlAgeResult.DataBind();
                    ddlCommonResult.DataSource = childItems4;
                    ddlCommonResult.DataTextField = "DisplayText";
                    ddlCommonResult.DataValueField = "Code";
                    ddlCommonResult.DataBind();
                    ddlOtherResult.DataSource = childItems4;
                    ddlOtherResult.DataTextField = "DisplayText";
                    ddlOtherResult.DataValueField = "Code";
                    ddlOtherResult.DataBind();
                    ddlOtherResult.Items.Insert(0, new ListItem(select, "0"));

                }
                var childItems5 = from child in lstmetadataOutput
                                  where child.Domain == "TMasterCtrlSubCategory"
                                  select child;
                if (childItems5.Count() > 0)
                {
                    ddlRRSubCategory.DataSource = childItems5;
                    ddlRRSubCategory.DataTextField = "DisplayText";
                    ddlRRSubCategory.DataValueField = "Code";
                    ddlRRSubCategory.DataBind();
                    ddlRRSubCategory.Items.Insert(0, new ListItem(select, "0"));
                   
                }
                var childItems6 = from child in lstmetadataOutput
                                  where child.Domain == "TGender"
                                  select child;
                if (childItems6.Count() > 0)
                {
                    ddlCategory.DataSource = childItems6;
                    ddlCategory.DataTextField = "DisplayText";
                    ddlCategory.DataValueField = "Code";
                    ddlCategory.DataBind();
                    ddlCategory.Items.Insert(0, new ListItem(select, "0"));
                    ddlCategory.SelectedValue ="0";

                }
                var childItems7 = from child in lstmetadataOutput
                                  where child.Domain == "TMasterCtrlRtype"
                                  select child;
                if (childItems7.Count() > 0)
                {
                    
               
                }
                var childItems8 = from child in lstmetadataOutput
                                  where child.Domain == "DeltaCheckCalculation"
                                  select child;
                if (childItems8.Count() > 0)
                {
                    ddlDeltachkcalc.DataSource = childItems8;
                    ddlDeltachkcalc.DataTextField = "DisplayText";
                    ddlDeltachkcalc.DataValueField = "Code";
                    ddlDeltachkcalc.DataBind();
                    ddlDeltachkcalc.Items.Insert(0, new ListItem(select, "0"));
                    //ddlDeltachkcalc.SelectedValue = "0";
                    ddlDeltachkcalc.Items[0].Value = "-1";

                }
                var childItems9 = from child in lstmetadataOutput
                                  where child.Domain == "DeltaCheckTimeUnit"
                                  select child;
                if (childItems9.Count() > 0)
                {
                    ddlTimeUnit.DataSource = childItems9;
                    ddlTimeUnit.DataTextField = "DisplayText";
                    ddlTimeUnit.DataValueField = "Code";
                    ddlTimeUnit.DataBind();
                    ddlTimeUnit.Items.Insert(0, new ListItem(select, "0"));
                    //ddlTimeUnit.SelectedValue = "0";
                    ddlTimeUnit.Items[0].Value = "-1";

                }
            }
            string domains1 = "TestNotification";
            string[] Tempdata1 = domains1.Split(',');
            string LangCode1 = "en-GB";
            List<MetaData> lstmetadataInputs = new List<MetaData>();
            List<MetaData> lstmetadataOutputs = new List<MetaData>();
            MetaData objMeta1;

            for (int i = 0; i < Tempdata1.Length; i++)
            {
                objMeta1 = new MetaData();
                objMeta1.Domain = Tempdata1[i];
                lstmetadataInputs.Add(objMeta1);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInputs, OrgID, LangCode1, out lstmetadataOutputs);
            if (lstmetadataOutputs.Count > 0)
            {
                var childItems = from child in lstmetadataOutputs
                                 where child.Domain == "TestNotification"
                                 select child;
                if (childItems.Count() > 0)
                {
                    checklstDomain.DataSource = childItems;
                    checklstDomain.DataTextField = "DisplayText";
                    checklstDomain.DataValueField = "Code";
                    checklstDomain.DataBind();
                    checklstDomain1.DataSource = childItems;
                    checklstDomain1.DataTextField = "DisplayText";
                    checklstDomain1.DataValueField = "Code";
                    checklstDomain1.DataBind();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

    //protected void lstViewRemarks_PagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
    //{
    //    //set current page startindex, max rows and rebind to false
    //    ItemDataPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);

    //    //rebind List View
    //    BindGrid(e.StartRowIndex);
    //}

    //protected void TabContainer1_ActiveTabChanged(object sender, EventArgs e)
    //{
    //    long returnCode = -1;
    //    try
    //    {
    //        if (TabContainer1.ActiveTabIndex == 3)
    //        {
    //            //BindGrid(1);
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while changing tab", ex);
    //    }
    //}

    //private void BindGrid(int PageIndex)
    //{
    //    try
    //    {
    //        if (ddlRemarksType.Items.Count > 0)
    //        {
    //            string pRemarksType = ddlRemarksType.SelectedItem.Value;
    //            Master_BL oMaster_BL = new Master_BL(base.ContextInfo);
    //            List<Remarks> lstRemarks = new List<Remarks>();
    //            Int32 TotalRecords = 0;
    //            //oMaster_BL.GetRemarkDetails(pRemarksType, PageIndex, ItemDataPager.PageSize, out lstRemarks, out TotalRecords);
    //            lstViewRemarks.DataSource = lstRemarks;
    //            lstViewRemarks.DataBind();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading remarks", ex);
    //    }
    //}

    protected void btnLoadTestDetails_Click(object sender, EventArgs e)
    {
        string UserWin = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_37 == null ? "Test master details loaded successfully!" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_37;
        string UserWin1 = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_38 == null ? "Unable to load test master details!" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_38;
        try
        {
            Reset();
            lblMessage.Text = string.Empty;
            long invID = 0;
            Int64.TryParse(hdnInvID.Value, out invID);
            List<TestMaster> lstTestMasterDetails = new List<TestMaster>();
            List<CodingScheme> lstCodingScheme = new List<CodingScheme>();
            List<Remarks> lstInvRemarks = new List<Remarks>();
            List<InvOrgReferenceMapping> lstInvOrgReferenceMapping = new List<InvOrgReferenceMapping>();
            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
            List<InvOrgNotifications> lstInvOrgNotifications = new List<InvOrgNotifications>();
            List<InvOrgAuthorization> lstCoAuth = new List<InvOrgAuthorization>();
            List<InvestigationBulkData> lstInvBulkData = new List<InvestigationBulkData>();
            List<InvInstrumentMaster> lstInstrumentMaster = new List<InvInstrumentMaster>();
            List<InvestigationLocationMapping> lstLocationMapping = new List<InvestigationLocationMapping>();
            List<InvDeltaCheck> objInvDeltaCheck = new List<InvDeltaCheck>();
            List<InvValueRangeMaster> lstCrossParametertests = new List<InvValueRangeMaster>();
            List<InvAutoCertifyValidation> lstInvAutoCertify = new List<InvAutoCertifyValidation>();
            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            oInvestigationBL.GetTestMasterDetails(OrgID, invID, CodeSchemeType.Investigations, out lstTestMasterDetails, out lstCodingScheme, out lstInvRemarks, out lstInvOrgReferenceMapping, out lstInvValueRangeMaster, out lstInvOrgNotifications, out lstCoAuth, out lstInvBulkData, out lstInstrumentMaster, out lstLocationMapping, out objInvDeltaCheck, out lstCrossParametertests, out lstInvAutoCertify);
            
            
            if (lstTestMasterDetails.Count > 0)
            {
                if (objInvDeltaCheck.Count > 0)
                {
                    chkDeltaCheck.Checked = true;
                    InvDeltaCheck oInvDeltaCheck = objInvDeltaCheck[0];
                    txtDeltaUnit.Text = String.IsNullOrEmpty(Convert.ToString(oInvDeltaCheck.DeltaUnit)) ? string.Empty : Convert.ToString(oInvDeltaCheck.DeltaUnit);
                    txtTimeFrame.Text = String.IsNullOrEmpty(Convert.ToString(oInvDeltaCheck.TimeFrame)) ? string.Empty : Convert.ToString(oInvDeltaCheck.TimeFrame);
                    if (oInvDeltaCheck.DeltaCalculationType != "-1" && oInvDeltaCheck.DeltaCalculationType != "")
                    {
                        ddlDeltachkcalc.SelectedValue = Convert.ToString(oInvDeltaCheck.DeltaCalculationType);
                    }
                    if (oInvDeltaCheck.TimeUnit != "-1" && oInvDeltaCheck.TimeUnit != "")
                    {
                        ddlTimeUnit.SelectedValue = Convert.ToString(oInvDeltaCheck.TimeUnit);
                    }
                }
                else
                {
                    chkDeltaCheck.Checked = false;
                    txtDeltaUnit.Text = string.Empty;
                    txtTimeFrame.Text = string.Empty;
                    ddlDeltachkcalc.SelectedValue = "-1";
                    ddlTimeUnit.SelectedValue = "-1";
                }
                btnAddRemarks.Enabled = true;
                btnSave.Enabled = true;
                btnAddRefMapping.Enabled = true;
                TestMaster oTestMaster = lstTestMasterDetails[0];
                txtName.Text = String.IsNullOrEmpty(oTestMaster.InvestigationName) ? string.Empty : oTestMaster.InvestigationName;
                txtDisplayText.Text = String.IsNullOrEmpty(oTestMaster.DisplayText) ? string.Empty : oTestMaster.DisplayText;
                txtBillingName.Text = String.IsNullOrEmpty(oTestMaster.BillingName) ? string.Empty : oTestMaster.BillingName;
                txtOutputCode.Text = String.IsNullOrEmpty(oTestMaster.OutputGroupingCode) ? string.Empty : oTestMaster.OutputGroupingCode;
                

                if (oTestMaster.IsTATrandom != -1)
                {
                    ddlScheduleType.SelectedValue = Convert.ToString(oTestMaster.IsTATrandom);
                }
                if (oTestMaster.ProtocalGroupID != 0)
                {
                    ddlprotocalgroup.SelectedValue = Convert.ToString(oTestMaster.ProtocalGroupID);
                }

                if (oTestMaster.DeptID != 0)
                {
                    ddlDept.SelectedIndex = ddlDept.Items.IndexOf(ddlDept.Items.FindByValue(Convert.ToString(oTestMaster.DeptID)));
                }
                if (oTestMaster.HeaderID != 0)
                {
                    ddlHeader.SelectedIndex = ddlHeader.Items.IndexOf(ddlHeader.Items.FindByValue(Convert.ToString(oTestMaster.HeaderID)));
                }
                if (oTestMaster.SampleCode != 0)
                {
                    ddlSample.SelectedIndex = ddlSample.Items.IndexOf(ddlSample.Items.FindByValue(Convert.ToString(oTestMaster.SampleCode)));
                }
                if (oTestMaster.SampleContainerID != 0)
                {
                    ddlAdditive.SelectedIndex = ddlAdditive.Items.IndexOf(ddlAdditive.Items.FindByValue(Convert.ToString(oTestMaster.SampleContainerID)));
                }
                if (oTestMaster.MethodID != 0)
                {
                    ddlMethod.SelectedIndex = ddlMethod.Items.IndexOf(ddlMethod.Items.FindByValue(Convert.ToString(oTestMaster.MethodID)));
                }
                if (oTestMaster.PrincipleID != 0)
                {
                    ddlPrinciple.SelectedIndex = ddlPrinciple.Items.IndexOf(ddlPrinciple.Items.FindByValue(Convert.ToString(oTestMaster.PrincipleID)));
                }
                if (oTestMaster.PreSampleConditionID != 0)
                {
                    ddlPreSampleCondition.SelectedIndex = ddlPreSampleCondition.Items.IndexOf(ddlPreSampleCondition.Items.FindByValue(Convert.ToString(oTestMaster.PreSampleConditionID)));
                }
                if (oTestMaster.PostSampleConditionID != 0)
                {
                    ddlPostSampleCondition.SelectedIndex = ddlPostSampleCondition.Items.IndexOf(ddlPostSampleCondition.Items.FindByValue(Convert.ToString(oTestMaster.PostSampleConditionID)));
                }
                if (!String.IsNullOrEmpty(oTestMaster.ResultValueType))
                {
                    ddlResultValue.SelectedIndex = ddlResultValue.Items.IndexOf(ddlResultValue.Items.FindByValue(oTestMaster.ResultValueType));
                }
                if (oTestMaster.AutoApproveLoginID != null)
                {
                    ddlAutoAuthorizeRole.SelectedIndex = ddlAutoAuthorizeRole.Items.IndexOf(ddlAutoAuthorizeRole.Items.FindByValue(Convert.ToString(oTestMaster.RoleID)));
                    hdnAutoAuthorizeUser.Value = Convert.ToString(oTestMaster.AutoApproveLoginID);
                    ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "onChangeAutoAuthorizeRole", "onChangeAutoAuthorizeRole();", true);
                }
                if (!String.IsNullOrEmpty(oTestMaster.Category))
                {
                    ddlTestCategory.SelectedIndex = ddlTestCategory.Items.IndexOf(ddlTestCategory.Items.FindByValue(oTestMaster.Category));
                }
                txtDecimalPlace.Text = String.IsNullOrEmpty(oTestMaster.DecimalPlaces) ? string.Empty : Convert.ToString(oTestMaster.DecimalPlaces);
                chkNonOrderable.Checked = oTestMaster.IsOrderable == "Y" ? false : true;
                chkAutoCertification.Checked = oTestMaster.IsAutoCertification == "Y" ? true : false;

                if (oTestMaster.Gender != null)
                {
                    ddlGender.SelectedIndex = ddlGender.Items.IndexOf(ddlGender.Items.FindByValue(Convert.ToString(oTestMaster.Gender)));
                }
                chkMachineInterface.Checked = oTestMaster.IsInterfaced == "Y" ? true : false;
                txtCostPerTest.Text = Convert.ToString(oTestMaster.CPT);
                txtCostPerReportableTest.Text = Convert.ToString(oTestMaster.CPRT);
                chkDiscountable.Checked = oTestMaster.IsDiscountable == "Y" ? true : false;
                chkServiceTax.Checked = oTestMaster.IsServiceTax == "Y" ? true : false;
                chkQCData.Checked = oTestMaster.QCData == "Y" ? true : false;
                chkSMS.Checked = oTestMaster.IsSMS == "Y" ? true : false;
                chkPrintSeparately.Checked = oTestMaster.PrintSeparately == "Y" ? true : false;
                chkNABL.Checked = oTestMaster.IsNABL == "Y" ? true : false;
                chkCAP.Checked = oTestMaster.IsCAP == "Y" ? true : false;
                chkRepeatable.Checked = oTestMaster.IsRepeatable == "Y" ? true : false;
                chkSTAT.Checked = oTestMaster.IsSTAT == "Y" ? true : false;
                chkIsActive.Checked = oTestMaster.IsActive == "Y" ? true : false;
                chkNonReportable.Checked = oTestMaster.IsNonReportable == "Y" ? true : false;
                chkIsFieldTest.Checked = oTestMaster.IsFieldTest == "Y" ? true : false;
                //Adeed by Arivalgan.kk/For SynopticReport//
                ChkSynoptic.Checked = oTestMaster.IsSynoptic == "Y" ? true : false;
                ChkIsSensitivetest.Checked = oTestMaster.IsSensitiveTest == "Y" ? true : false;

                if (!String.IsNullOrEmpty(oTestMaster.Classification))
                {
                    ddlClassification.SelectedIndex = ddlClassification.Items.IndexOf(ddlClassification.Items.FindByValue(oTestMaster.Classification));
                }
                txtCOTValue.Text = oTestMaster.CutOffTimeValue == 0 ? string.Empty : Convert.ToString(oTestMaster.CutOffTimeValue);
                if (!String.IsNullOrEmpty(oTestMaster.CutOffTimeType))
                {
                    ddlCOTType.SelectedIndex = ddlCOTType.Items.IndexOf(ddlCOTType.Items.FindByValue(oTestMaster.CutOffTimeType));
                }
                FCKeditor1.Text = string.Empty;
                FCKeditor2.Text = string.Empty;
                FCKeditor3.Text = string.Empty;

                string interpretation = string.Empty;

                if (!String.IsNullOrEmpty(oTestMaster.Interpretation))
                {
                    interpretation = oTestMaster.Interpretation;

                    FCKeditor1.Text = interpretation;
                    FCKeditor2.Text = interpretation;
                    FCKeditor3.Text = interpretation;
                    if (interpretation.StartsWith("<Interpretation") && LabUtil.TryParseXml(interpretation))
                    {
                        XmlDocument xmlDoc = new XmlDocument();
                        xmlDoc.LoadXml(interpretation);
                        XmlNodeList lstLayout = xmlDoc.GetElementsByTagName("Layout");
                        string layoutType = string.Empty;
                        if (lstLayout != null && lstLayout.Count > 0)
                        {
                            layoutType = lstLayout[0].Attributes[0].Value;
                        }
                        XmlNodeList lstText1Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text1']");
                        if (lstText1Items != null && lstText1Items.Count > 0)
                        {
                            FCKeditor1.Text = lstText1Items.Item(0).Attributes["Value"].Value;
                           // FCKeditor2.Text = lstText1Items.Item(0).Attributes["Value"].Value;
                            //FCKeditor3.Text = lstText1Items.Item(0).Attributes["Value"].Value;
                        }
                        XmlNodeList lstText2Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text2']");
                        if (lstText2Items != null && lstText2Items.Count > 0)
                        {
                           // FCKeditor1.Text = lstText2Items.Item(0).Attributes["Value"].Value;
                            FCKeditor2.Text = lstText2Items.Item(0).Attributes["Value"].Value;
                           // FCKeditor3.Text = lstText2Items.Item(0).Attributes["Value"].Value;
                        }
                        XmlNodeList lstText3Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text3']");
                        if (lstText3Items != null && lstText3Items.Count > 0)
                        {
                          //  FCKeditor1.Text = lstText3Items.Item(0).Attributes["Value"].Value;
                          //  FCKeditor2.Text = lstText3Items.Item(0).Attributes["Value"].Value;
                            FCKeditor3.Text = lstText3Items.Item(0).Attributes["Value"].Value;
                        }
                        bool isTableExists = false;
                        XmlNodeList lstTable1Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='table1']");
                        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                        List<List<string>> lstTable = new List<List<string>>();
                        List<string> oTable = new List<string>();
                        Int32 rowNo = 0;
                        Int32 xmlRowNo = 0;
                        string table1Data = string.Empty;
                        string table2Data = string.Empty;
                        if (lstTable1Items != null && lstTable1Items.Count > 0)
                        {
                            isTableExists = true;
                            lstTable = new List<List<string>>();
                            oTable = new List<string>();
                            rowNo = 0;
                            xmlRowNo = 0;
                            foreach (XmlNode xmlNode in lstTable1Items)
                            {
                                Int32.TryParse(xmlNode.Attributes["RowNo"].Value, out xmlRowNo);

                                if (rowNo != xmlRowNo)
                                {
                                    if (oTable.Count > 0)
                                    {
                                        lstTable.Add(oTable);
                                    }
                                    oTable = new List<string>();
                                    rowNo = xmlRowNo;
                                }
                                oTable.Add(xmlNode.Attributes["Value"].Value);
                            }
                            if (oTable.Count > 0)
                            {
                                lstTable.Add(oTable);
                            }
                            hdnHandsonTable1Data.Value = oJavaScriptSerializer.Serialize(lstTable);
                        }
                        XmlNodeList lstTable2Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='table2']");
                        if (lstTable2Items != null && lstTable2Items.Count > 0)
                        {
                            isTableExists = true;
                            lstTable = new List<List<string>>();
                            oTable = new List<string>();
                            rowNo = 0;
                            xmlRowNo = 0;
                            foreach (XmlNode xmlNode in lstTable2Items)
                            {
                                Int32.TryParse(xmlNode.Attributes["RowNo"].Value, out xmlRowNo);

                                if (rowNo != xmlRowNo)
                                {
                                    if (oTable.Count > 0)
                                    {
                                        lstTable.Add(oTable);
                                    }
                                    oTable = new List<string>();
                                    rowNo = xmlRowNo;
                                }
                                oTable.Add(xmlNode.Attributes["Value"].Value);
                            }
                            if (oTable.Count > 0)
                            {
                                lstTable.Add(oTable);
                            }
                            hdnHandsonTable2Data.Value = oJavaScriptSerializer.Serialize(lstTable);
                        }
                        if (isTableExists)
                        {
                            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "onChangeLayout", "changeLayout('" + layoutType + "');loadInterpretationTableData('" + hdnHandsonTable1Data.ClientID + "','" + hdnHandsonTable2Data.ClientID + "');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "onChangeLayout", "changeLayout('" + layoutType + "');", true);
                        }
                    }
                    else
                    {
                        FCKeditor1.Text = interpretation;
                        FCKeditor2.Text = interpretation;
                        FCKeditor3.Text = interpretation;
                    }
                }
                else
                {
                    FCKeditor1.Text = string.Empty;
                    FCKeditor2.Text = interpretation;
                    FCKeditor3.Text = interpretation;
                }

                lblMessage.Text = UserWin;
            }
            else
            {
                btnAddRemarks.Enabled = false;
                btnSave.Enabled = false;
                btnAddRefMapping.Enabled = false;
                lblMessage.Text = UserWin1;
            }
            if (lstCodingScheme.Count > 0)
            {
                rptCodeSchema.DataSource = lstCodingScheme;
                rptCodeSchema.DataBind();
            }
            else
            {
                rptCodeSchema.DataSource = null;
                rptCodeSchema.DataBind();
            }
            if (lstInvRemarks.Count > 0)
            {
                rptRemarks.DataSource = lstInvRemarks;
                rptRemarks.DataBind();
            }
            else
            {
                rptRemarks.DataSource = null;
                rptRemarks.DataBind();
            }
            if (lstInvOrgReferenceMapping.Count > 0)
            {
                rptInvRefMapping.DataSource = lstInvOrgReferenceMapping;
                rptInvRefMapping.DataBind();
            }
            else
            {
                rptInvRefMapping.DataSource = null;
                rptInvRefMapping.DataBind();
            }
            if (lstInvValueRangeMaster.Count > 0)
            {
                reflexRepeter.DataSource = lstInvValueRangeMaster;
                reflexRepeter.DataBind();
            }
            else
            {
                reflexRepeter.DataSource = null;
                reflexRepeter.DataBind();
            }
            if (lstCrossParametertests.Count > 0)
            {
                CrossRepeter.DataSource = lstCrossParametertests;
                CrossRepeter.DataBind();
            }
            else
            {
                CrossRepeter.DataSource = null;
                CrossRepeter.DataBind();
            }

            if (lstLocationMapping.Count > 0)
            {
                rptInvLocationMapping.DataSource = lstLocationMapping;
                rptInvLocationMapping.DataBind();
            }

            if (lstInvOrgNotifications.Count > 0)
            {
                foreach (InvOrgNotifications objNotifications in lstInvOrgNotifications)
                {
                    if (objNotifications.ActionType == "Email")
                    {
                        chkEmail.Checked = objNotifications.ActionType == "Email" ? true : false;
                        drpEmailTemplate.SelectedValue = objNotifications.ActionTemplateID.ToString();
                        foreach (ListItem item in checklstDomain.Items)
                        {
                            if (item.Value == objNotifications.NotifiedTo)
                            {
                                item.Selected = true;
                                break;
                            }

                        }
                    }
                    if (objNotifications.ActionType == "Sms")
                    {
                        CheckSMS.Checked = objNotifications.ActionType == "Sms" ? true : false;
                        drpSmsTemplate.SelectedValue = objNotifications.ActionTemplateID.ToString();
                        foreach (ListItem item in checklstDomain1.Items)
                        {
                            if (item.Value == objNotifications.NotifiedTo)
                            {
                                item.Selected = true;
                                break;
                            }
                        }
                    }
                }
            }
            if (lstCoAuth.Count > 0)
            {
                rptCoAuth.DataSource = lstCoAuth;
                rptCoAuth.DataBind();
            }
            if (lstInvBulkData.Count > 0)
            {
                ddlAgeBulkData.DataSource = lstInvBulkData;
                ddlAgeBulkData.DataTextField = "Value";
                ddlAgeBulkData.DataValueField = "Value";
                ddlAgeBulkData.DataBind();
                ddlCommonBulkData.DataSource = lstInvBulkData;
                ddlCommonBulkData.DataTextField = "Value";
                ddlCommonBulkData.DataValueField = "Value";
                ddlCommonBulkData.DataBind();
                ddlOtherBulkData.DataSource = lstInvBulkData;
                ddlOtherBulkData.DataTextField = "Value";
                ddlOtherBulkData.DataValueField = "Value";
                ddlOtherBulkData.DataBind();
            }
            if (lstInstrumentMaster.Count > 0)
            {
                ddlAgeDevice.DataSource = lstInstrumentMaster;
                ddlAgeDevice.DataTextField = "InstrumentName";
                ddlAgeDevice.DataValueField = "ProductCode";
                ddlAgeDevice.DataBind();
                ddlCommonDevice.DataSource = lstInstrumentMaster;
                ddlCommonDevice.DataTextField = "InstrumentName";
                ddlCommonDevice.DataValueField = "ProductCode";
                ddlCommonDevice.DataBind();
                ddlOtherDevice.DataSource = lstInstrumentMaster;
                ddlOtherDevice.DataTextField = "InstrumentName";
                ddlOtherDevice.DataValueField = "ProductCode";
                ddlOtherDevice.DataBind();
            }
            ListItem item1 = new ListItem();
            item1.Text = select;
            item1.Value = "0";

            ddlAgeBulkData.Items.Insert(0, item1);
            ddlCommonBulkData.Items.Insert(0, item1);
            ddlOtherBulkData.Items.Insert(0, item1);
            ddlAgeDevice.Items.Insert(0, item1);
            ddlCommonDevice.Items.Insert(0, item1);
            ddlOtherDevice.Items.Insert(0, item1);

            ddlAgeBulkData.SelectedIndex = 0;
            ddlCommonBulkData.SelectedIndex = 0;
            ddlOtherBulkData.SelectedIndex = 0;
            ddlAgeDevice.SelectedIndex = 0;
            ddlCommonDevice.SelectedIndex = 0;
            ddlOtherDevice.SelectedIndex = 0;
            if (lstInvAutoCertify.Count > 0)
            { 
                chkautocertify.Checked=lstInvAutoCertify[0].Isautocertify==true?true :false;
                chkdeviceerr.Checked = lstInvAutoCertify[0].IsDeviceError == true ? true : false;
                chkisQCstatus.Checked = lstInvAutoCertify[0].IsQCstatus == true ? true : false;
                chkiscritical.Checked = lstInvAutoCertify[0].IsCriticalValue == true ? true : false;
                chkdeltaval.Checked = lstInvAutoCertify[0].IsDeltavalue == true ? true : false;
                chkautoauth.Checked = lstInvAutoCertify[0].IsAutoauthorizationrange == true ? true : false;
                chkgrpdepend.Checked = lstInvAutoCertify[0].IsGroupDependencies == true ? true : false;
                chkcrossparam.Checked = lstInvAutoCertify[0].IsCrossParameterCheck == true ? true : false;
                chktechverify.Checked = lstInvAutoCertify[0].IsTechnicianVerificationNeeded == true ? true : false;
            
            }
            if (chkAutoCertification.Checked == true)
            { 
                chkautocertify.Enabled=true;
                chkdeviceerr.Enabled=true;
                chkiscritical.Enabled=true;
                chkisQCstatus.Enabled=true;
                chkdeltaval.Enabled=true;
                chkautoauth.Enabled=true;
                chkgrpdepend.Enabled=true;
                chkcrossparam.Enabled=true;
                chktechverify.Enabled = true;

            }
            //Hide the Add and Cancel button for Jr.Scientific Officer Lab role
            string val = Request.QueryString["View"];
            if (val == "Y")
            {
                btnAddRefMapping.Style.Add("display", "none");
                btnCancelRefMapping.Style.Add("display", "none");
                btnReflexMap.Style.Add("display", "none");
                btnAdd.Style.Add("display", "none");
            }

            LoadInvLocationMapping();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading Test Details", ex);
        }
    }

    protected void rptCodeSchema_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            HiddenField hdnisprimary = (HiddenField)e.Item.FindControl("hdnisprimary");
            Label lblIsPrimary = (Label)e.Item.FindControl("lblIsPrimary");
            if(hdnisprimary.Value == "Yes")
            {
                lblIsPrimary.Text = Useyes;
            }
            else
            {
                lblIsPrimary.Text = UseNo;
            }
            
        }
    }
    protected void rptInvRefMapping_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            InvOrgReferenceMapping oInvOrgRefMapping = (InvOrgReferenceMapping)e.Item.DataItem;
            HiddenField lblRRString = (HiddenField)e.Item.FindControl("lblRRString");
            Label lblRRXML = (Label)e.Item.FindControl("lblRRXML");
            Label lblReferenceRange = (Label)e.Item.FindControl("lblReferenceRange");
            Label lblIsActive = (Label)e.Item.FindControl("lblActive");
            Label lblIsPrimary = (Label)e.Item.FindControl("lblPrimary");
            xmlString = string.Empty;
            xmlValue = string.Empty;
            if (!String.IsNullOrEmpty(oInvOrgRefMapping.ReferenceRange) && LabUtil.TryParseXml(oInvOrgRefMapping.ReferenceRange))
            {
                string data = string.Empty;
                string Tempxml = string.Empty;
                Tempxml = oInvOrgRefMapping.ReferenceRange;
                string xmlContent =oInvOrgRefMapping.ReferenceRange;
                oLabUtil.ConvertXmlToExtend(data, out xmlContent, out xmlValue, out xmlString, Tempxml);
                lblRRXML.Text = oInvOrgRefMapping.ReferenceRange;
                lblRRString.Value = xmlString;
                lblReferenceRange.Text = xmlValue;
                if (oInvOrgRefMapping.IsPrimary == "Yes")
                {
                    lblIsPrimary.Text = Useyes;
                }
                else
                {
                    lblIsPrimary.Text = UseNo;
                }
                if (oInvOrgRefMapping.IsActive == "Yes")
                {
                    lblIsActive.Text = Useyes;
                }
                else
                {
                    lblIsActive.Text = UseNo;
                }  
            }
            else
            {
                lblReferenceRange.Text = oInvOrgRefMapping.ReferenceRange;
                lblRRXML.Text = string.Empty;
                lblRRString.Value = string.Empty;
                if (oInvOrgRefMapping.IsPrimary == "Yes")
                {
                    lblIsPrimary.Text = Useyes;
                }
                else
                {
                    lblIsPrimary.Text = UseNo;
                }
                if (oInvOrgRefMapping.IsActive == "Yes")
                {
                    lblIsActive.Text = Useyes;
                }
                else
                {
                    lblIsActive.Text = UseNo;
                }  
            }

            if (hdnConfRefRange.Value == "Y")
            {

                HtmlTableCell tdRefMapConv_UOM = (HtmlTableCell)e.Item.FindControl("tdRefMapConv_UOM");
                HtmlTableCell tdRefMapConv_Factor = (HtmlTableCell)e.Item.FindControl("tdRefMapConv_Factor");
                HtmlTableCell tdRefMapConvFac_DecimalPoint = (HtmlTableCell)e.Item.FindControl("tdRefMapConvFac_DecimalPoint");
                tdRefMapConv_UOM.Style.Add("display", "table-cell");
                tdRefMapConv_Factor.Style.Add("display", "table-cell");
                tdRefMapConvFac_DecimalPoint.Style.Add("display", "table-cell");

            }
            else
            {
                HtmlTableCell tdRefMapConv_UOM = (HtmlTableCell)e.Item.FindControl("tdRefMapConv_UOM");
                HtmlTableCell tdRefMapConv_Factor = (HtmlTableCell)e.Item.FindControl("tdRefMapConv_Factor");
                HtmlTableCell tdRefMapConvFac_DecimalPoint = (HtmlTableCell)e.Item.FindControl("tdRefMapConvFac_DecimalPoint");
                tdRefMapConv_UOM.Style.Add("display", "none");
                tdRefMapConv_Factor.Style.Add("display", "none");
                tdRefMapConvFac_DecimalPoint.Style.Add("display", "none");
            }
        }
    }
    protected void reflexRepeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (hdnView.Value == "Y")
            { 
                    HtmlInputButton btnReflexDelete = (HtmlInputButton)e.Item.FindControl("btnReflexDelete");
                    btnReflexDelete.Visible = false; 
            }
        }
    }
    protected void CrossRepeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (hdnView.Value == "Y")
            {
                HtmlInputButton btnCrossDelete = (HtmlInputButton)e.Item.FindControl("btnCrossDelete");
                btnCrossDelete.Visible = false;
            }
        }
    }

    protected void rptCoAuth_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (hdnView.Value == "Y")
            {
                HtmlInputButton btnDeleteCoAuth = (HtmlInputButton)e.Item.FindControl("btnDeleteCoAuth");
                btnDeleteCoAuth.Visible = false;
            }
        }
    }

    protected void rptInvLocationMapping_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Header)
            if (hdnView.Value == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "test", "javascript:hidetask()", true);
                //thTask.Attributes.Add("style", "display:none");
                //HtmlInputButton btnDeleteLocation = (HtmlInputButton)e.Item.FindControl("btnDeleteLocation");
                //btnDeleteLocation.Visible = false;
                
               
            }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        string AlertWin = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03 == null ? "Alert" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_03;
        string UserWin = Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_01 == null ? "Saved Successfully" : Resources.CommonControls_AppMsg.CommonControls_PatientDetails_ascx_01;
        string UserWin1 = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_01 == null ? "Unable to save test master details!" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_01;
        long returnCode = -1;
        try
        {
            lblMessage.Text = string.Empty;
            long InvID = 0;
            int DeptID = 0;
            long HeaderID = 0;
            int RoleID = 0;
            int UserID = 0;
            int SampleCode = 0;
            int ContainerID = 0;
            long MethodID = 0;
            long PrincipleID = 0;
            long PreShippingConditionID = 0;
            long PostShippingConditionID = 0;
            int ProcessingAddressID = 0;
            int CutOffTimeValue = 0;
            int AutoAuthorizeLoginID = 0;
            decimal CPT = 0.00M;
            decimal CPRT = 0.00M;
            string ResultValueType = string.Empty;
            string SubCategory = string.Empty;
            string Gender = string.Empty;
            string Classification = string.Empty;
            string TestCategory = string.Empty;
            string Protocalgroup = string.Empty;
            string Reason = string.Empty;

            Int64.TryParse(hdnInvID.Value, out InvID);
            InvDeltaCheck oInvDeltaCheck = new InvDeltaCheck();
            oInvDeltaCheck.InvestigationId = InvID;
            oInvDeltaCheck.Orgid = OrgID;
            if (ddlDeltachkcalc.SelectedValue != "-1" && ddlDeltachkcalc.SelectedValue != "")
            {
                oInvDeltaCheck.DeltaCalculationType = ddlDeltachkcalc.SelectedValue;
            }

            if (txtDeltaUnit.Text != "" && txtTimeFrame.Text != "")
            {
                oInvDeltaCheck.DeltaUnit = Convert.ToDecimal(txtDeltaUnit.Text);
                oInvDeltaCheck.TimeFrame = Convert.ToInt16(txtTimeFrame.Text);
            }
            oInvDeltaCheck.TimeUnit = ddlTimeUnit.SelectedValue;
            if (chkDeltaCheck.Checked == false)
            {
                oInvDeltaCheck = new InvDeltaCheck();
            }

            TestMaster oTestMaster = new TestMaster();
            oTestMaster.OrgID = OrgID;
            oTestMaster.InvestigationID = InvID;
            oTestMaster.InvestigationName = txtName.Text;
            oTestMaster.DisplayText = txtDisplayText.Text;
            oTestMaster.BillingName = txtBillingName.Text;
            oTestMaster.OutputGroupingCode = txtOutputCode.Text;

            if (ddlScheduleType.SelectedValue != "-1" && ddlScheduleType.SelectedValue != "")

            {
                oTestMaster.IsTATrandom = Convert.ToInt16((ddlScheduleType.SelectedValue));
            }
            else
            {
                oTestMaster.IsTATrandom = 0;
            }

            if (ddlDept.Items.Count > 0)
            {
                Int32.TryParse(ddlDept.SelectedItem.Value, out DeptID);
            }
            if (ddlHeader.Items.Count > 0)
            {
                Int64.TryParse(ddlHeader.SelectedItem.Value, out HeaderID);
            }
            if (ddlSample.Items.Count > 0)
            {
                Int32.TryParse(ddlSample.SelectedItem.Value, out SampleCode);
            }
            if (ddlAdditive.Items.Count > 0)
            {
                Int32.TryParse(ddlAdditive.SelectedItem.Value, out ContainerID);
            }
            if (ddlMethod.Items.Count > 0)
            {
                Int64.TryParse(ddlMethod.SelectedItem.Value, out MethodID);
            }
            if (ddlPrinciple.Items.Count > 0)
            {
                Int64.TryParse(ddlPrinciple.SelectedItem.Value, out PrincipleID);
            }
            if (ddlPreSampleCondition.Items.Count > 0)
            {
                Int64.TryParse(ddlPreSampleCondition.SelectedItem.Value, out PreShippingConditionID);
            }
            if (ddlPostSampleCondition.Items.Count > 0)
            {
                Int64.TryParse(ddlPostSampleCondition.SelectedItem.Value, out PostShippingConditionID);
            }
            if (ddlResultValue.Items.Count > 0)
            {
                ResultValueType = (String.IsNullOrEmpty(ddlResultValue.SelectedItem.Value) || ddlResultValue.SelectedIndex == 0) ? string.Empty : ddlResultValue.SelectedItem.Value;
            }
            
            if (ddlGender.Items.Count > 0)
            {
                Gender = (String.IsNullOrEmpty(ddlGender.SelectedItem.Value) || ddlGender.SelectedIndex == 0) ? string.Empty : ddlGender.SelectedItem.Value;
            }
            if (!String.IsNullOrEmpty(hdnProcessingLocation.Value) && hdnProcessingLocation.Value != "0")
            {
                Int32.TryParse(hdnProcessingLocation.Value, out ProcessingAddressID);
            }
            if (!String.IsNullOrEmpty(hdnAutoAuthorizeUser.Value))
            {
                Int32.TryParse(hdnAutoAuthorizeUser.Value, out AutoAuthorizeLoginID);
            }

            if (ddlRole.Items.Count > 0)
            {
                Int32.TryParse(ddlRole.SelectedItem.Value, out RoleID);
            }

            if (ddlDoctor.Items.Count > 0)
            {
                Int32.TryParse(ddlDoctor.SelectedItem.Value, out UserID);
            }

            oTestMaster.DeptID = DeptID;
            oTestMaster.HeaderID = HeaderID;
            oTestMaster.SampleCode = SampleCode;
            oTestMaster.SampleContainerID = ContainerID;
            oTestMaster.MethodID = MethodID;
            oTestMaster.PrincipleID = PrincipleID;
            oTestMaster.PreSampleConditionID = PreShippingConditionID;
            oTestMaster.PostSampleConditionID = PostShippingConditionID;
            oTestMaster.ResultValueType = ResultValueType;
            oTestMaster.SubCategory = SubCategory;
            oTestMaster.Gender = Gender;
            oTestMaster.IsOrderable = chkNonOrderable.Checked ? "N" : "Y";
            oTestMaster.IsInterfaced = chkMachineInterface.Checked ? "Y" : "N";
            oTestMaster.IsAutoCertification = chkAutoCertification.Checked ? "Y" : "N";

            oTestMaster.DecimalPlaces = String.IsNullOrEmpty(txtDecimalPlace.Text.Trim()) ? string.Empty : txtDecimalPlace.Text.Trim();
            oTestMaster.ProcessingAddressID = ProcessingAddressID;
            oTestMaster.AutoApproveLoginID = AutoAuthorizeLoginID;
            Decimal.TryParse(txtCostPerTest.Text, out CPT);
            oTestMaster.CPT = CPT;
            Decimal.TryParse(txtCostPerReportableTest.Text, out CPRT);
            oTestMaster.CPRT = CPRT;
            oTestMaster.IsDiscountable = chkDiscountable.Checked ? "Y" : "N";
            oTestMaster.IsServiceTax = chkServiceTax.Checked ? "Y" : "N";
            oTestMaster.QCData = chkQCData.Checked ? "Y" : "N";
            oTestMaster.IsSMS = chkSMS.Checked ? "Y" : "N";
            oTestMaster.PrintSeparately = chkPrintSeparately.Checked ? "Y" : "N";
            oTestMaster.IsNABL = chkNABL.Checked ? "Y" : "N";
            oTestMaster.IsCAP = chkCAP.Checked ? "Y" : "N";
            oTestMaster.IsRepeatable = chkRepeatable.Checked ? "Y" : "N";
            oTestMaster.IsSTAT = chkSTAT.Checked ? "Y" : "N";
            oTestMaster.IsActive = chkIsActive.Checked ? "Y" : "N";
            oTestMaster.IsNonReportable = chkNonReportable.Checked ? "Y" : "N";
            //Added By Arivalagan.kk/ For Synotic Report//
            oTestMaster.IsSynoptic = ChkSynoptic.Checked ? "Y" : "N";
            oTestMaster.IsFieldTest = chkIsFieldTest.Checked ? "Y" : "N";
            oTestMaster.IsSensitiveTest = ChkIsSensitivetest.Checked ? "Y" : "N";
            if (!String.IsNullOrEmpty(txtCOTValue.Text) && ddlCOTType.Items.Count > 0)
            {
                Int32.TryParse(txtCOTValue.Text, out CutOffTimeValue);
                oTestMaster.CutOffTimeValue = CutOffTimeValue;
                oTestMaster.CutOffTimeType = ddlCOTType.SelectedItem.Value;
            }
            if (ddlClassification.Items.Count > 0)
            {
                Classification = (String.IsNullOrEmpty(ddlClassification.SelectedItem.Value) || ddlClassification.SelectedIndex == 0) ? string.Empty : ddlClassification.SelectedItem.Value;
            }
            if (ddlTestCategory.Items.Count > 0)
            {
                TestCategory = (String.IsNullOrEmpty(ddlTestCategory.SelectedItem.Value) || ddlTestCategory.SelectedIndex == 0) ? string.Empty : ddlTestCategory.SelectedItem.Value;
            }
            if (ddlprotocalgroup.Items.Count > 0)
            {
                Protocalgroup = (String.IsNullOrEmpty(ddlprotocalgroup.SelectedItem.Value) || ddlprotocalgroup.SelectedIndex == 0) ? string.Empty : ddlprotocalgroup.SelectedItem.Value;
            }
            oTestMaster.Classification = Classification;
            int Protocal = 0;
            Int32.TryParse(Protocalgroup, out Protocal);
            oTestMaster.ProtocalGroupID = Protocal;
            //oTestMaster.Interpretation = FCKeditor1.Value;
            string selectedLayout = hdnSelectedLayout.Value;
            string fckEditorText1 = FCKeditor1.Text == "<br />" ? string.Empty : FCKeditor1.Text;
            string fckEditorText2 = FCKeditor2.Text == "<br />" ? string.Empty : FCKeditor2.Text;
            string fckEditorText3 = FCKeditor3.Text == "<br />" ? string.Empty : FCKeditor3.Text;
            if (selectedLayout == "layout1")
            {
                if (!String.IsNullOrEmpty(fckEditorText1))
                {
                    oTestMaster.Interpretation = fckEditorText1;
                }
                else
                {
                    oTestMaster.Interpretation = string.Empty;
                }
            }
            else
            {
                if (!String.IsNullOrEmpty(fckEditorText1) || !String.IsNullOrEmpty(fckEditorText2) || !String.IsNullOrEmpty(fckEditorText3) || hdnIsEmptyHandsonTable1.Value != "true" || hdnIsEmptyHandsonTable2.Value != "true")
                {
                    JavaScriptSerializer interSerializer = new JavaScriptSerializer();
                    List<List<string>> lstHandsonTable1 = new List<List<string>>();
                    List<List<string>> lstHandsonTable2 = new List<List<string>>();

                    string strlstHandsonTable1 = hdnHandsonTable1.Value;
                    lstHandsonTable1 = interSerializer.Deserialize<List<List<string>>>(strlstHandsonTable1);

                    string strlstHandsonTable2 = hdnHandsonTable2.Value;
                    lstHandsonTable2 = interSerializer.Deserialize<List<List<string>>>(strlstHandsonTable2);

                    int cellCount = 1;
                    int rowCount = 1;

                    XmlDocument xmlDoc = new XmlDocument();
                    xmlDoc.LoadXml("<Interpretation></Interpretation>");
                    XmlElement xmlLayoutElement = xmlDoc.CreateElement("Layout");
                    XmlAttribute xmlLayoutAttribute = xmlDoc.CreateAttribute("Type");
                    xmlLayoutAttribute.Value = selectedLayout;
                    xmlLayoutElement.Attributes.Append(xmlLayoutAttribute);
                    xmlDoc.DocumentElement.AppendChild(xmlLayoutElement);

                    XmlElement xmlText1Element = xmlDoc.CreateElement("Item");
                    XmlAttribute xmlAttribute;
                    if (!String.IsNullOrEmpty(fckEditorText1))
                    {
                        xmlAttribute = xmlDoc.CreateAttribute("Type");
                        xmlAttribute.Value = "text1";
                        xmlText1Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("Value");
                        xmlAttribute.Value = fckEditorText1;
                        xmlText1Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText1Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText1Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                        xmlAttribute.Value = string.Empty;
                        xmlText1Element.Attributes.Append(xmlAttribute);
                    }
                    XmlElement xmlText2Element = xmlDoc.CreateElement("Item");
                    if (!String.IsNullOrEmpty(fckEditorText2))
                    {
                        xmlAttribute = xmlDoc.CreateAttribute("Type");
                        xmlAttribute.Value = "text2";
                        xmlText2Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("Value");
                        xmlAttribute.Value = fckEditorText2;
                        xmlText2Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText2Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText2Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                        xmlAttribute.Value = string.Empty;
                        xmlText2Element.Attributes.Append(xmlAttribute);
                    }
                    XmlElement xmlText3Element = xmlDoc.CreateElement("Item");
                    if (!String.IsNullOrEmpty(fckEditorText3))
                    {
                        xmlAttribute = xmlDoc.CreateAttribute("Type");
                        xmlAttribute.Value = "text3";
                        xmlText3Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("Value");
                        xmlAttribute.Value = fckEditorText3;
                        xmlText3Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText3Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                        xmlAttribute.Value = string.Empty;
                        xmlText3Element.Attributes.Append(xmlAttribute);

                        xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                        xmlAttribute.Value = string.Empty;
                        xmlText3Element.Attributes.Append(xmlAttribute);
                    }
                    XmlElement xmlTable1Element = null;
                    List<XmlElement> lstTable1XmlElement = new List<XmlElement>();

                    XmlElement xmlTable2Element = null;
                    List<XmlElement> lstTable2XmlElement = new List<XmlElement>();

                    if (lstHandsonTable1 != null && lstHandsonTable1.Count > 0)
                    {
                        rowCount = 1;
                        foreach (List<string> rows in lstHandsonTable1)
                        {
                            cellCount = 1;
                            foreach (string cell in rows)
                            {
                                xmlTable1Element = xmlDoc.CreateElement("Item");

                                xmlAttribute = xmlDoc.CreateAttribute("Type");
                                xmlAttribute.Value = "table1";
                                xmlTable1Element.Attributes.Append(xmlAttribute);

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
                                xmlAttribute.Value = hdnHandsonTable1ColumnCount.Value;
                                xmlTable1Element.Attributes.Append(xmlAttribute);

                                cellCount = cellCount + 1;

                                lstTable1XmlElement.Add(xmlTable1Element);
                            }
                            rowCount = rowCount + 1;
                        }
                    }

                    if (lstHandsonTable2 != null && lstHandsonTable2.Count > 0)
                    {
                        rowCount = 1;
                        foreach (List<string> rows in lstHandsonTable2)
                        {
                            cellCount = 1;
                            foreach (string cell in rows)
                            {
                                xmlTable2Element = xmlDoc.CreateElement("Item");

                                xmlAttribute = xmlDoc.CreateAttribute("Type");
                                xmlAttribute.Value = "table2";
                                xmlTable2Element.Attributes.Append(xmlAttribute);

                                xmlAttribute = xmlDoc.CreateAttribute("Value");
                                xmlAttribute.Value = string.IsNullOrEmpty(cell) ? string.Empty : cell;
                                xmlTable2Element.Attributes.Append(xmlAttribute);

                                xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                                xmlAttribute.Value = rowCount.ToString();
                                xmlTable2Element.Attributes.Append(xmlAttribute);

                                xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                                xmlAttribute.Value = cellCount.ToString();
                                xmlTable2Element.Attributes.Append(xmlAttribute);

                                xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                                xmlAttribute.Value = hdnHandsonTable2ColumnCount.Value;
                                xmlTable2Element.Attributes.Append(xmlAttribute);

                                lstTable2XmlElement.Add(xmlTable2Element);
                                cellCount = cellCount + 1;
                            }
                            rowCount = rowCount + 1;
                        }
                    }

                    if (selectedLayout == "layout1")
                    {
                        xmlDoc.DocumentElement.AppendChild(xmlText1Element);
                    }
                    else if (selectedLayout == "layout2")
                    {
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                    }
                    else if (selectedLayout == "layout3")
                    {
                        xmlDoc.DocumentElement.AppendChild(xmlText1Element);
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                    }
                    else if (selectedLayout == "layout4")
                    {
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        xmlDoc.DocumentElement.AppendChild(xmlText2Element);
                    }
                    else if (selectedLayout == "layout5")
                    {
                        xmlDoc.DocumentElement.AppendChild(xmlText1Element);
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        xmlDoc.DocumentElement.AppendChild(xmlText2Element);
                    }
                    else if (selectedLayout == "layout6")
                    {
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        xmlDoc.DocumentElement.AppendChild(xmlText2Element);
                        foreach (XmlElement element in lstTable2XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                    }
                    else if (selectedLayout == "layout7")
                    {
                        xmlDoc.DocumentElement.AppendChild(xmlText1Element);
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        foreach (XmlElement element in lstTable2XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                    }
                    else if (selectedLayout == "layout8")
                    {
                        foreach (XmlElement element in lstTable1XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        foreach (XmlElement element in lstTable2XmlElement)
                        {
                            xmlDoc.DocumentElement.AppendChild(element);
                        }
                        xmlDoc.DocumentElement.AppendChild(xmlText3Element);
                    }
                    oTestMaster.Interpretation = xmlDoc.InnerXml;
                }
                else
                {
                    oTestMaster.Interpretation = string.Empty;
                }
            }

            oTestMaster.Category = TestCategory;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<InvRemarks> lstInvRemarks = new List<InvRemarks>();
            string strLstInvRemarks = hdnLstInvRemarks.Value;
            lstInvRemarks = serializer.Deserialize<List<InvRemarks>>(strLstInvRemarks);
            if (lstInvRemarks == null)
            {
                lstInvRemarks = new List<InvRemarks>();
            }

            List<InvOrgReferenceMapping> lstInvOrgReferenceMapping = new List<InvOrgReferenceMapping>();
            List<InvOrgReferenceMapping> lstNewInvOrgReferenceMapping = new List<InvOrgReferenceMapping>();
            List<BulkReferenceRange> lstBulkRR = new List<BulkReferenceRange>();

            
            string strLstInvOrgRefMapping = hdnLstInvOrgRefMapping.Value;
            lstNewInvOrgReferenceMapping = serializer.Deserialize<List<InvOrgReferenceMapping>>(strLstInvOrgRefMapping);
            if (lstNewInvOrgReferenceMapping == null)
            {
                lstInvOrgReferenceMapping = new List<InvOrgReferenceMapping>();
                lstBulkRR = new List<BulkReferenceRange>();
            }
            else
            {
                string xmlContent = string.Empty;
                string xmlValue = string.Empty;
                string xmlString = string.Empty;
                InvOrgReferenceMapping objInvOrgReferenceMapping = new InvOrgReferenceMapping();
                LabUtil oLabUtil = new LabUtil();
                foreach (InvOrgReferenceMapping oInvOrgReferenceMapping in lstNewInvOrgReferenceMapping)
                {
                    objInvOrgReferenceMapping = new InvOrgReferenceMapping();
                    objInvOrgReferenceMapping = oInvOrgReferenceMapping;
                    if (objInvOrgReferenceMapping.IsRRXML)
                    {
                        xmlContent = string.Empty;
                        xmlValue = string.Empty;
                        xmlString = string.Empty;
                        if (objInvOrgReferenceMapping.ReferenceRange != null && objInvOrgReferenceMapping.ReferenceRange != "")
                        {
                            oLabUtil.ConvertStringToXml(objInvOrgReferenceMapping.ReferenceRange, out xmlContent, out xmlValue, out xmlString);
                        }
                        ConvertXMLStringToUDT(objInvOrgReferenceMapping.ReferenceRange, hdnTestCode.Value, objInvOrgReferenceMapping.InvestigationID, out lstBulkRR);
                        objInvOrgReferenceMapping.ReferenceRange = xmlContent;
                    }
                    lstInvOrgReferenceMapping.Add(objInvOrgReferenceMapping);
                }
            }

            InvestigationLocationMapping oInvestigationLocationMapping = new InvestigationLocationMapping();
            if (!String.IsNullOrEmpty(SubCategory) && ProcessingAddressID > 0)
            {
                oInvestigationLocationMapping.OrgID = OrgID;
                oInvestigationLocationMapping.InvestigationID = InvID;
                oInvestigationLocationMapping.LocationID = ILocationID;
                oInvestigationLocationMapping.ProcessingAddressID = ProcessingAddressID;
                if (SubCategory == "OUT")
                {
                    oInvestigationLocationMapping.Type = 12;
                }
            }
            string strLstInvValueRangeMaster = hdnLstInvValueRangeMaster.Value;
            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
            lstInvValueRangeMaster = serializer.Deserialize<List<InvValueRangeMaster>>(strLstInvValueRangeMaster);
            if (lstInvValueRangeMaster == null)
            {
                lstInvValueRangeMaster = new List<InvValueRangeMaster>();
            }
            string strlstInvCrossparameterTest = hdnlstInvCrossparameterTest.Value;
            List<InvValueRangeMaster> lstInvCrossparameterTest = new List<InvValueRangeMaster>();
            lstInvCrossparameterTest = serializer.Deserialize<List<InvValueRangeMaster>>(strlstInvCrossparameterTest);
            if (lstInvCrossparameterTest == null)
            {
                lstInvCrossparameterTest = new List<InvValueRangeMaster>();
            }
			            List<InvOrgNotifications> lstInvOrgNotifications = new List<InvOrgNotifications>();
            if (chkEmail.Checked)
            {
                foreach (ListItem item in checklstDomain.Items)
                {
                    if (item.Selected == true)
                    {
                        InvOrgNotifications objinvnotification = new InvOrgNotifications();

                        Int64.TryParse(hdnInvID.Value, out InvID);
                        objinvnotification.InvestigationID = InvID;
                        objinvnotification.OrgID = OrgID;
                        objinvnotification.Type = "CRITICAL";
                        objinvnotification.ActionType = chkEmail.Checked == true ? "EMAIL" : "SMS";  //Type
                        objinvnotification.ActionTemplateID = Convert.ToInt32(drpEmailTemplate.SelectedValue);      //TypeTemplate                  
                        objinvnotification.NotifiedTo = item.Value;
                        lstInvOrgNotifications.Add(objinvnotification);
                    }

                }
            }
            if (CheckSMS.Checked)
            {
                foreach (ListItem item in checklstDomain1.Items)
                {
                    if (item.Selected == true)
                    {
                        InvOrgNotifications objinvnotification = new InvOrgNotifications();

                        Int64.TryParse(hdnInvID.Value, out InvID);
                        objinvnotification.InvestigationID = InvID;
                        objinvnotification.OrgID = OrgID;
                        objinvnotification.Type = "CRITICAL";
                        objinvnotification.ActionType = CheckSMS.Checked == true ? "SMS" : "EMAIL";
                        objinvnotification.ActionTemplateID = Convert.ToInt32(drpSmsTemplate.SelectedValue);
                        objinvnotification.NotifiedTo = item.Value;
                        lstInvOrgNotifications.Add(objinvnotification);
                    }

                }
            }

            JavaScriptSerializer serializer1 = new JavaScriptSerializer();
            List<InvOrgAuthorization> lstCoAuth = new List<InvOrgAuthorization>();
            string strCoAuth = hdnLstCoAuth.Value;
            lstCoAuth = serializer1.Deserialize<List<InvOrgAuthorization>>(strCoAuth);
            if (lstCoAuth == null)
            {
                lstCoAuth = new List<InvOrgAuthorization>();
            }

            JavaScriptSerializer serializer2 = new JavaScriptSerializer();
            List<InvestigationLocationMapping> lstInvLocation = new List<InvestigationLocationMapping>();
            string strInvLocation = hdnInvLocation.Value;
            lstInvLocation = serializer2.Deserialize<List<InvestigationLocationMapping>>(strInvLocation);

            if (lstInvLocation == null)
            {
                lstInvLocation = new List<InvestigationLocationMapping>();
            }



            if (ddlReasonn.SelectedValue != "0")
            {
                Reason = ddlReasonn.SelectedItem.ToString();
            }

            oTestMaster.ReferenceRangeString = Request.Form[txtROReferenceRange.UniqueID];

            List<InvAutoCertifyValidation> lstInvAuroCertify = new List<InvAutoCertifyValidation>();
            InvAutoCertifyValidation objInvAutoCertify = new InvAutoCertifyValidation();
             Int64.TryParse(hdnInvID.Value, out InvID);
             objInvAutoCertify.InvestigationId = InvID;
             objInvAutoCertify.Type = "INV";
             objInvAutoCertify.Isautocertify = chkautocertify.Checked?true:false;
            objInvAutoCertify.IsDeviceError=chkdeviceerr.Checked?true:false;
            objInvAutoCertify.IsQCstatus=chkisQCstatus.Checked?true:false;
            objInvAutoCertify.IsCriticalValue = chkiscritical.Checked ? true : false;
            objInvAutoCertify.IsDeltavalue = chkdeltaval.Checked ? true : false;
            objInvAutoCertify.IsAutoauthorizationrange = chkautoauth.Checked ? true : false;
            objInvAutoCertify.IsGroupDependencies = chkgrpdepend.Checked ? true : false;
            objInvAutoCertify.IsCrossParameterCheck = chkcrossparam.Checked ? true : false;
            objInvAutoCertify.IsTechnicianVerificationNeeded = chktechverify.Checked ? true : false;
            lstInvAuroCertify.Add(objInvAutoCertify);
            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            returnCode = oInvestigationBL.SaveTestMasterDetails(oTestMaster, lstInvRemarks, lstInvOrgReferenceMapping, oInvestigationLocationMapping, OrgID, Convert.ToInt64(hdnInvID.Value), "INV", LID, lstInvValueRangeMaster, lstInvOrgNotifications, lstCoAuth, lstInvLocation, Reason, lstBulkRR, oInvDeltaCheck, lstInvCrossparameterTest, lstInvAuroCertify);
            if (returnCode >= 0)
            {
                Reset();
                btnLoadTestDetails_Click(btnLoadTestDetails, null);
                lblMessage.Text = "";
                //ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "saved successfully", "alert('" + save_mesge + "');", true);
                ScriptManager.RegisterStartupScript(UpdatePanel1, typeof(UpdatePanel), "Alert_002", "javascript:ValidationWindow('" + UserWin + "','" + AlertWin + "');", true);
            }
            else
            {
                Reset();
                lblMessage.Text = "";
               // string sPath = "CommonControls\\\\TestMaster.ascx.cs_1";
                string sPath = UserWin1;
                ScriptManager.RegisterStartupScript(UpdatePanel1, typeof(UpdatePanel), "unsaved", "javascript:ValidationWindow('" + UserWin1 + "','" + AlertWin + "');", true);

                //ScriptManager.RegisterClientScriptBlock(UpdatePanel1, typeof(UpdatePanel), "unsaved", " ShowAlertMsg('" + sPath + "');", true);
               // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "unsaveed", "alert('Unable to save test master details!');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving Test Details", ex);
            //lblMessage.Text = "Unable to save test master details!";
            lblMessage.Text = UserWin1;
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            txtTestCodeScheme.Text = string.Empty;
            hdnInvID.Value = string.Empty;
            Reset();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Resetting Test Details", ex);
        }
    }
    private void Reset()
    {
        try
        {
            ListItem item = new ListItem();
            item.Text = select;
            item.Value = "0";
            btnAddRemarks.Enabled = false;
            btnSave.Enabled = false;
            btnAddRefMapping.Enabled = false;
            txtName.Text = string.Empty;
            txtDisplayText.Text = string.Empty;
            txtBillingName.Text = string.Empty;
            txtOutputCode.Text = string.Empty;
            ddlDept.SelectedIndex = 0;
            ddlHeader.SelectedIndex = 0;
            ddlSample.SelectedIndex = 0;
            ddlAdditive.SelectedIndex = 0;
            ddlResultValue.SelectedIndex = 0;
            ddlMethod.SelectedIndex = 0;
            ddlPrinciple.SelectedIndex = 0;
            ddlGender.SelectedIndex = 0;
            ddlPreSampleCondition.SelectedIndex = 0;
            ddlPostSampleCondition.SelectedIndex = 0;
            chkNonOrderable.Checked = false;
            txtCOTValue.Text = string.Empty;
            ddlCOTType.SelectedIndex = 0;
            txtCostPerTest.Text = string.Empty;
            txtCostPerReportableTest.Text = string.Empty;
            txtDecimalPlace.Text = string.Empty;
            ddlClassification.SelectedIndex = 0;
            chkRepeatable.Checked = false;
            chkQCData.Checked = false;
            chkSMS.Checked = false;
            chkPrintSeparately.Checked = false;
            chkDiscountable.Checked = false;
            ddlAutoAuthorizeRole.SelectedIndex = 0;
            ddlAutoAuthorizeUser.Items.Clear();
            ddlAutoAuthorizeUser.Items.Insert(0, item);
            chkNonReportable.Checked = false;
            chkNABL.Checked = false;
            chkCAP.Checked = false;
            chkSTAT.Checked = false;
            chkServiceTax.Checked = false;
            chkMachineInterface.Checked = false;
            rptCodeSchema.DataSource = null;
            rptCodeSchema.DataBind();
            FCKeditor1.Text = string.Empty;
            FCKeditor2.Text = string.Empty;
            FCKeditor3.Text = string.Empty;
            ddlRemarksType.SelectedIndex = 0;
            txtRemarks.Text = string.Empty;
            rptRemarks.DataSource = null;
            rptRemarks.DataBind();
            rptInvRefMapping.DataSource = null;
            rptInvRefMapping.DataBind();
            ddlInstrument.SelectedIndex = 0;
            //ddlKit.SelectedIndex = 0;
            txtClient.Text = string.Empty;
            hdnSelectedClientID.Value = "0";
            //txtTestCode.Text = string.Empty;
            txtUOM.Text = string.Empty;
            hdnUOMID.Value = "0";
            txtReferenceRange.Text = string.Empty;
            chkPrimary.Checked = false;
            chkRefMappingActive.Checked = true;
            hdnRRXMLAdd.Value = string.Empty;
            hdnRRStringAdd.Value = string.Empty;
            lblMessage.Text = string.Empty;
            hdnLstInvOrgRefMapping.Value = string.Empty;
            hdnSelectedLayout.Value = "layout1";
            hdnLstInvRemarks.Value = string.Empty;
            hdnSelectedRefMappingRowIndex.Value = string.Empty;
            chkEmail.Checked = false;
            CheckSMS.Checked = false;
            drpEmailTemplate.SelectedIndex = 0;
            drpSmsTemplate.SelectedIndex = 0;
            ddlDept1.SelectedIndex = 0;
            hdnLstCoAuth.Value = string.Empty;
            rptCoAuth.DataSource = null;
            hdnHandsonTable1.Value = "";
            hdnHandsonTable2.Value = "";
            hdnHandsonTable1ColumnCount.Value = "";
            hdnHandsonTable2ColumnCount.Value = "";
            hdnHandsonTable1Data.Value = "";
            hdnHandsonTable2Data.Value = "";
            ddlTestCategory.SelectedIndex = 0;
            ddlprotocalgroup.SelectedIndex = 0;
            ddlScheduleType.SelectedIndex = 0;
            ddlClassification.SelectedIndex = 0;
            rptCoAuth.DataBind();
            rptInvLocationMapping.DataSource = null;
            rptInvLocationMapping.DataBind();
            CrossRepeter.DataSource = null;
            CrossRepeter.DataBind();
            txtConvUom.Text = string.Empty;
            txtConvFactor.Text = string.Empty;
            txtConvDecimal.Text = string.Empty;
            chkautocertify.Checked=false;
            chkdeviceerr.Checked=false;
            chkisQCstatus.Checked=false;
            chkiscritical.Checked=false;
            chkdeltaval.Checked=false;
            chkautoauth.Checked = false;
            chkgrpdepend.Checked=false;
            chkcrossparam.Checked=false;
            chktechverify.Checked=false;
            foreach (ListItem domainItem in checklstDomain.Items)
            {
                domainItem.Selected = false;
            }
            foreach (ListItem domainItem in checklstDomain1.Items)
            {
                domainItem.Selected = false;
            }
            //Added By Arivalagan.kk/ For Synotic Report//
            ChkSynoptic.Checked = false;
            ChkIsSensitivetest.Checked = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in reset", ex);
            throw ex;
        }
    }
    //protected void ddlRemarksType_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        BindGrid(1);
    //        //delPopulateData delPopulate = new delPopulateData(this.BindGrid);
    //        //pagerApps.UpdatePageIndex = delPopulate;
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in loading remarks", ex);
    //    }
    //}

    //protected void ddlSubCategory_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        ListItem item = new ListItem();
    //        item.Text = "---Select---";
    //        item.Value = "0";
    //        ddlProcessingLocation.Items.Clear();
    //        if (ddlSubCategory.SelectedIndex > 0)
    //        {
    //            string pType = ddlSubCategory.SelectedItem.Value;
    //            List<OrganizationAddress> lstProcessingLocation = new List<OrganizationAddress>();
    //            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
    //            oInvestigationBL.GetTestProcessingLocation(OrgID, ILocationID, pType, out lstProcessingLocation);
    //            if (lstProcessingLocation.Count > 0)
    //            {
    //                ddlProcessingLocation.DataSource = lstProcessingLocation;
    //                ddlProcessingLocation.DataTextField = "Location";
    //                ddlProcessingLocation.DataValueField = "AddressID";
    //                ddlProcessingLocation.DataBind();
    //            }
    //        }
    //        else
    //        {
    //            ddlProcessingLocation.Items.Clear();
    //        }
    //        ddlProcessingLocation.Items.Insert(0, item);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Loading processing locations", ex);
    //    }
    //}

    public void LoadTestMasterDetails()
    {
        string select1 = Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40 == null ? "--Select--" : Resources.CommonControls_AppMsg.CommonControls_TestMaster_ascx_40;
        long returnCode = -1;
        try
        {
            lblMessage.Text = string.Empty;
            Master_BL oMasterBL = new Master_BL(base.ContextInfo);
            List<InvDeptMaster> lstDept = new List<InvDeptMaster>();
            List<InvSampleMaster> lstSample = new List<InvSampleMaster>();
            List<InvestigationSampleContainer> lstAdditive = new List<InvestigationSampleContainer>();
            List<InvestigationMethod> lstMethod = new List<InvestigationMethod>();
            List<InvPrincipleMaster> lstPrinciple = new List<InvPrincipleMaster>();
            List<MetaValue_Common> lstResultValue = new List<MetaValue_Common>();
            List<MetaValue_Common> lstSubCategory = new List<MetaValue_Common>();
            List<Role> lstRoles = new List<Role>();
            List<InvInstrumentMaster> lstInstrument = new List<InvInstrumentMaster>();
            List<Products> lstKit = new List<Products>();
            List<InvClientMaster> lstInvClientMaster = new List<InvClientMaster>();
            List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
            List<MetaValue_Common> lstCategory = new List<MetaValue_Common>();
            List<InvestigationHeader> lstHeader = new List<InvestigationHeader>();
            List<ShippingConditionMaster> lstSampleCondition = new List<ShippingConditionMaster>();
            returnCode = oMasterBL.GetTestMasterDropDownValues(OrgID, out lstDept, out lstSample, out lstAdditive, out lstMethod, out lstPrinciple,
                out lstResultValue, out lstSubCategory, out lstRoles, out lstInstrument, out lstKit, out lstInvClientMaster, out lstReasonMaster, 
                out lstCategory, out lstHeader ,out lstSampleCondition);
            if (returnCode == 0)
            {
                if (lstDept.Count > 0)
                {
                    ddlDept.DataSource = lstDept;
                    ddlDept.DataTextField = "DeptName";
                    ddlDept.DataValueField = "DeptID";
                    ddlDept.DataBind();
                }
                if (lstSample.Count > 0)
                {
                    ddlSample.DataSource = lstSample;
                    ddlSample.DataTextField = "SampleDesc";
                    ddlSample.DataValueField = "SampleCode";
                    ddlSample.DataBind();
                }
                if (lstAdditive.Count > 0)
                {
                    ddlAdditive.DataSource = lstAdditive;
                    ddlAdditive.DataTextField = "ContainerName";
                    ddlAdditive.DataValueField = "SampleContainerID";
                    ddlAdditive.DataBind();
                }
                if (lstMethod.Count > 0)
                {
                    ddlMethod.DataSource = lstMethod;
                    ddlMethod.DataTextField = "MethodName";
                    ddlMethod.DataValueField = "MethodID";
                    ddlMethod.DataBind();
                }
                if (lstPrinciple.Count > 0)
                {
                    ddlPrinciple.DataSource = lstPrinciple;
                    ddlPrinciple.DataTextField = "PrincipleName";
                    ddlPrinciple.DataValueField = "PrincipleID";
                    ddlPrinciple.DataBind();
                }
                if (lstResultValue.Count > 0)
                {
                    ddlResultValue.DataSource = lstResultValue;
                    ddlResultValue.DataTextField = "Value";
                    ddlResultValue.DataValueField = "Code";
                    ddlResultValue.DataBind();
                }
                 
                if (lstRoles.Count > 0)
                {
                    ddlAutoAuthorizeRole.DataSource = lstRoles;
                    ddlAutoAuthorizeRole.DataTextField = "Description";
                    ddlAutoAuthorizeRole.DataValueField = "RoleID";
                    ddlAutoAuthorizeRole.DataBind();
                }
                if (lstInstrument.Count > 0)
                {
                    ddlInstrument.DataSource = lstInstrument;
                    ddlInstrument.DataTextField = "InstrumentName";
                    ddlInstrument.DataValueField = "InstrumentID";
                    ddlInstrument.DataBind();
                }
                if (lstKit.Count > 0)
                {
                    //ddlKit.DataSource = lstKit;
                    //ddlKit.DataTextField = "ProductName";
                    //ddlKit.DataValueField = "ProductID";
                    //ddlKit.DataBind();
                }
                //if (lstInvClientMaster.Count > 0)
                //{
                //    ddlClient.DataSource = lstInvClientMaster;
                //    ddlClient.DataTextField = "ClientName";
                //    ddlClient.DataValueField = "ClientID";
                //    ddlClient.DataBind();
                //}
                if (lstReasonMaster.Count > 0)
                {
                    ddlReason.DataSource = lstReasonMaster;
                    ddlReason.DataTextField = "Reason";
                    ddlReason.DataValueField = "ReasonCode";
                    ddlReason.DataBind();
                }
                if (lstCategory.Count > 0)
                {
                    ddlTestCategory.DataSource = lstCategory;
                    ddlTestCategory.DataTextField = "Value";
                    ddlTestCategory.DataValueField = "Code";
                    ddlTestCategory.DataBind();
                }
                if (lstHeader.Count > 0)
                {
                    ddlHeader.DataSource = lstHeader;
                    ddlHeader.DataTextField = "HeaderName";
                    ddlHeader.DataValueField = "HeaderID";
                    ddlHeader.DataBind();
                }

                if (lstRoles.Count > 0)
                {
                    ddlRole.DataSource = lstRoles;
                    ddlRole.DataTextField = "Description"; 
                    ddlRole.DataValueField = "RoleID";
                    ddlRole.DataBind();
                }
                if (lstSampleCondition.Count > 0)
                {
                    var lstSampleCondition1 = from child in lstSampleCondition
                                              where child.ConditionDesc != select1
                                              orderby child.ConditionDesc
                                              select child;
                    ddlPreSampleCondition.DataSource = lstSampleCondition1;
                    ddlPreSampleCondition.DataTextField = "ConditionDesc";
                    ddlPreSampleCondition.DataValueField = "ShippingConditionID";
                    ddlPreSampleCondition.DataBind();
                    ddlPreSampleCondition.Items.Insert(0, select);

                    ddlPostSampleCondition.DataSource = lstSampleCondition1;
                    ddlPostSampleCondition.DataTextField = "ConditionDesc";
                    ddlPostSampleCondition.DataValueField = "ShippingConditionID";
                    ddlPostSampleCondition.DataBind();
                    ddlPostSampleCondition.Items.Insert(0, select);
                }
            }
            MetaData oMetaData = new MetaData();
            oMetaData.Domain = "TestClassification";
            string LangCode = "en-GB";
            List<MetaData> lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            List<MetaData> lstMetaData = new List<MetaData>();
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping (lstDomain,OrgID,LanguageCode , out lstMetaData);

            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstClassification = ((from child in lstMetaData
                                                     where child.Domain == "TestClassification"
                                                     select child).Distinct()).ToList();
                if (lstClassification != null && lstClassification.Count > 0)
                {
                    ddlClassification.DataSource = lstClassification;
                    ddlClassification.DataTextField = "DisplayText";
                    ddlClassification.DataValueField = "Code";
                    ddlClassification.DataBind();
                }
            }
          
            oMetaData = new MetaData();
            oMetaData.Domain = "RemarksType";
            lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            lstMetaData = new List<MetaData>();
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping (lstDomain,OrgID,LanguageCode , out lstMetaData);

            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstRemarksType = ((from child in lstMetaData
                                                  where child.Domain == "RemarksType"
                                                  select child).Distinct()).ToList();
                if (lstRemarksType != null && lstRemarksType.Count > 0)
                {
                    ddlRemarksType.DataSource = lstRemarksType;
                    ddlRemarksType.DataTextField = "DisplayText";
                    ddlRemarksType.DataValueField = "Code";
                    ddlRemarksType.DataBind();
                    ddlRtype.DataSource = lstRemarksType;
                    ddlRtype.DataTextField = "DisplayText";
                    ddlRtype.DataValueField = "Code";
                    ddlRtype.DataBind();
                    ddlType.DataSource = lstRemarksType;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "Code";
                    ddlType.DataBind();
                    
                }
            }
           
            oMetaData = new MetaData();
            oMetaData.Domain = "CutOffTimeType";
            lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            lstMetaData = new List<MetaData>();
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LanguageCode, out lstMetaData);

            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstCutOffTimeType = ((from child in lstMetaData
                                                     where child.Domain == "CutOffTimeType"
                                                     select child).Distinct()).ToList();
                if (lstCutOffTimeType != null && lstCutOffTimeType.Count > 0)
                {
                    ddlCOTType.DataSource = lstCutOffTimeType;
                    ddlCOTType.DataTextField = "DisplayText";
                    ddlCOTType.DataValueField = "Code";
                    ddlCOTType.DataBind();
                }
            }
        
            oMetaData = new MetaData();
            oMetaData.Domain = "TestReferenceRangeType";
            lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            lstMetaData = new List<MetaData>();
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LanguageCode, out lstMetaData);

            if (lstMetaData.Count > 0)
            {
                List<MetaData> lstRefRangeType = ((from child in lstMetaData
                                                   where child.Domain == "TestReferenceRangeType" & child.Code != "0"
                                                   orderby child.DisplayText
                                                   select child).Distinct()).ToList();
                if (lstRefRangeType != null && lstRefRangeType.Count > 0)
                {
                    ddlRefRangeType.DataSource = lstRefRangeType;
                    ddlRefRangeType.DataTextField = "DisplayText";
                    ddlRefRangeType.DataValueField = "Code";
                    ddlRefRangeType.DataBind();
                    ddlRefRangeType.Items.Insert(0, new ListItem(select, "0"));
                }
            }
            ListItem item = new ListItem();
            item.Text = select;
            item.Value = "0";
            ddlDept.Items.Insert(0, item);
            ddlHeader.Items.Insert(0, item);
            ddlSample.Items.Insert(0, item);
            ddlAdditive.Items.Insert(0, item);
            ddlMethod.Items.Insert(0, item);
            ddlPrinciple.Items.Insert(0, item);
            ddlResultValue.Items.Insert(0, item);
            ddlClassification.Items.Insert(0, item);
            ddlAutoAuthorizeRole.Items.Insert(0, item);
            ddlAutoAuthorizeUser.Items.Insert(0, item);
            ddlInstrument.Items.Insert(0, item);
           // ddlKit.Items.Insert(0, item);
            //ddlClient.Items.Insert(0, item);
            ddlReason.Items.Insert(0, item);
            ddlTestCategory.Items.Insert(0, item);
            ddlprotocalgroup.Items.Insert(0, item);
            ddlDept1.Items.Insert(0, item);
            ddlRole.Items.Insert(0, item);
            ddlDoctor.Items.Insert(0, item);
            ddlDept1.ClearSelection();
            ddlRole.ClearSelection();
            ddlDoctor.ClearSelection();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading test master", ex);
        }
    }
    private void loadEmailTemplates()
    {
        long returnCode = -1;
        List<ActionTemplate> lstActiontemplate = new List<ActionTemplate>();
        try
        {
            string ActionName = "Email";
            Investigation_BL invBL = new Investigation_BL();
            returnCode = invBL.GetTemplatesforAction(ActionName, out lstActiontemplate);
            if (lstActiontemplate.Count > 0)
            {
                drpEmailTemplate.DataSource = lstActiontemplate;
                drpEmailTemplate.DataTextField = "TemplateName";
                drpEmailTemplate.DataValueField = "TemplateID";
                drpEmailTemplate.DataBind();
                drpEmailTemplate.Items.Insert(0, new ListItem(select, "0"));
                BindEmailTemplates(lstActiontemplate);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Templates", ex);
        }

    }
    public void BindEmailTemplates(List<ActionTemplate> lstActiontemplate)
    {
        try
        {
            for (int i = 0; i < drpEmailTemplate.Items.Count - 1; i++)
            {
                ListItemCollection item = drpEmailTemplate.Items;
                item[i + 1].Attributes.Add("title", lstActiontemplate[i].Template);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BindEmailTemplates", ex);
        }
    }
    private void loadSMSTemplates()
    {
        long returnCode = -1;
        List<ActionTemplate> lstActiontemplate = new List<ActionTemplate>();
        try
        {
            string ActionName = "SMS";
            Investigation_BL invBL = new Investigation_BL();
            returnCode = invBL.GetTemplatesforAction(ActionName, out lstActiontemplate);
            if (lstActiontemplate.Count > 0)
            {
                drpSmsTemplate.DataSource = lstActiontemplate;
                drpSmsTemplate.DataTextField = "TemplateName";
                drpSmsTemplate.DataValueField = "TemplateID";
                drpSmsTemplate.DataBind();
                drpSmsTemplate.Items.Insert(0, new ListItem(select, "0"));
                BindSMSTemplates(lstActiontemplate);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading Templates", ex);
        }

    }
    public void BindSMSTemplates(List<ActionTemplate> lstActiontemplate)
    {
        try
        {
            for (int i = 0; i < drpSmsTemplate.Items.Count - 1; i++)
            {
                ListItemCollection item = drpSmsTemplate.Items;
                item[i + 1].Attributes.Add("title", lstActiontemplate[i].Template);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in BindSMSTemplates", ex);
        }
    }

    public void LoadDoctor()
    {
        try
        {
            PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
            List<InvOrgAuthorization> lstPhysician = new List<InvOrgAuthorization>();
            long returnCode = -1;

            returnCode = visitBL.GetDoctors(OrgID, out lstPhysician);

            ddlDoctor.DataSource = lstPhysician;
            ddlDoctor.DataTextField = "UserName";
            ddlDoctor.DataValueField = "UserID";
            ddlDoctor.DataBind();

            ddlDoctor.Items.Insert(0, new ListItem(select, "0"));
            ddlDoctor.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Refering Physician Details.", ex);
        }
    }

    public void LoadScheduleType()
    {
        try
        {
            long returncode = -1;
            string domains = "TestScheduleType";
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
                                 where child.Domain == "TestScheduleType"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlScheduleType.DataSource = childItems;
                    ddlScheduleType.DataTextField = "DisplayText";
                    ddlScheduleType.DataValueField = "Code";
                    ddlScheduleType.DataBind();
                    ddlScheduleType.Items.Insert(0, new ListItem(select, "0"));
                    ddlScheduleType.Items[0].Value = "-1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }
    public void Loadprotocalgroup()
    {
        try
        {
            long returncode = -1;
            string domains = "ProtocalGroup_Based";
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
                                 where child.Domain == "ProtocalGroup_Based"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlprotocalgroup.DataSource = childItems;
                    ddlprotocalgroup.DataTextField = "DisplayText";
                    ddlprotocalgroup.DataValueField = "Code";
                    ddlprotocalgroup.DataBind();
                    ddlprotocalgroup.Items.Insert(0, new ListItem(select, "0"));
                    ddlprotocalgroup.Items[0].Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadMetaData() in Test Master", ex);
        }
    }

    #region function
    public void LoadInvLocationMapping()
    {
        try
        {
            long returncode = -1;
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<MetaValue_Common> lstType = new List<MetaValue_Common>();
            List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
            returncode = masterbl.GetInvLocationMapping(OrgID, out lstType, out lstOrgLocation);
            if (lstType.Count > 0)
            {
                drpType.DataSource = lstType;
                drpType.DataTextField = "Value";
                drpType.DataValueField = "Code";
                drpType.DataBind();
                //drpType.Items.Insert(0, "--Select--");
                //drpType.Items[0].Value = "0";

            }
            if (lstOrgLocation.Count > 0)
            {
                drpRegLocation.DataSource = lstOrgLocation;
                drpRegLocation.DataTextField = "Location";
                drpRegLocation.DataValueField = "AddressID";
                drpRegLocation.DataBind();
                //drpProcessingOrg.Items.Insert(0, "--Select--");
                //drpProcessingOrg.Items[0].Value = "0";

            }

            ListItem item = new ListItem();
            drpProcessingOrg.Items.Clear();
            drpProcessLocation.Items.Clear();
            item.Text = select;
            item.Value = "0";
            drpType.Items.Insert(0, item);
            drpProcessingOrg.Items.Insert(0, item);
            drpProcessLocation.Items.Insert(0, item);
            drpRegLocation.Items.Insert(0, item);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Exception Occured in Testmaster page", ex);
        }

    }


    #endregion

    public void ConvertXMLStringToUDT(string rawData, String TestCode, Int64 InvestigationId, out List<BulkReferenceRange> lstBulKRR)
    {
        try
        {
            lstBulKRR = new List<BulkReferenceRange>();
            string[] lstReferenceRange = rawData.Split('#');
            if (lstReferenceRange.Count() > 0)
            {
                foreach (string rangeType in lstReferenceRange)
                {
                    if (!String.IsNullOrEmpty(rangeType))
                    {
                        string[] ReferenceRange = rangeType.Split('$');
                        string[] lstSubCatagory = ReferenceRange[1].Split('@');

                        foreach (string subCatagory in lstSubCatagory)
                        {
                            BulkReferenceRange ObjBulkRR = new BulkReferenceRange();
                            if (!String.IsNullOrEmpty(subCatagory))
                            {
                                string[] CatagoryAgeMain = subCatagory.Split('|');
                                //Age
                                if (CatagoryAgeMain[1].ToString() == "Age")
                                {
                                    Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
                                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                    {
                                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                        ObjBulkRR.SubCategoryType = Convert.ToString(CatagoryAgeMain[1]);
                                        ObjBulkRR.TestCode = TestCode;
                                        ObjBulkRR.InvestigationID = InvestigationId;
                                        ObjBulkRR.RangeType = ReferenceRange[0];
                                        ObjBulkRR.GenderValue = Convert.ToString(CatagoryAgeSubarrAge.GetValue(0));
                                        ObjBulkRR.ResultType = "";
                                        ObjBulkRR.TypeMode = Convert.ToString(CatagoryAgeSubarrAge.GetValue(3));
                                        ObjBulkRR.AgeRangeType = Convert.ToString(CatagoryAgeSubarrAge.GetValue(1));
                                        ObjBulkRR.AgeRange = Convert.ToString(CatagoryAgeSubarrAge.GetValue(2));
                                        ObjBulkRR.ReferenceName = "";
                                        ObjBulkRR.ValueTypeMode = Convert.ToString(CatagoryAgeSubarrAge.GetValue(4));
                                        ObjBulkRR.Value = Convert.ToString(CatagoryAgeSubarrAge.GetValue(5));
                                        ObjBulkRR.IsNormal = "";
                                        ObjBulkRR.IsSourceText = "";
                                        ObjBulkRR.ResultType = "";
                                        ObjBulkRR.Device = "";
                                        ObjBulkRR.Interpretation = "";
                                        ObjBulkRR.OrgID = OrgID;
                                        ObjBulkRR.InvestigationName = txtName.Text;
                                        ObjBulkRR.Status = true;
                                    }
                                }
                                //Common
                                if (CatagoryAgeMain[1].ToString() == "Common")
                                {
                                    Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
                                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                    {
                                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                        ObjBulkRR.SubCategoryType = Convert.ToString(CatagoryAgeMain[1]);
                                        ObjBulkRR.TestCode = TestCode;
                                        ObjBulkRR.InvestigationID = InvestigationId;
                                        ObjBulkRR.RangeType = ReferenceRange[0];
                                        ObjBulkRR.GenderValue = Convert.ToString(CatagoryAgeSubarrAge.GetValue(0));
                                        ObjBulkRR.ResultType = "";
                                        ObjBulkRR.TypeMode = "";
                                        ObjBulkRR.AgeRangeType = "";
                                        ObjBulkRR.AgeRange = "";
                                        ObjBulkRR.ReferenceName = "";
                                        ObjBulkRR.ValueTypeMode = Convert.ToString(CatagoryAgeSubarrAge.GetValue(1));
                                        ObjBulkRR.Value = Convert.ToString(CatagoryAgeSubarrAge.GetValue(2));
                                        ObjBulkRR.IsNormal = "";
                                        ObjBulkRR.IsSourceText = "";
                                        ObjBulkRR.ResultType = "";
                                        ObjBulkRR.Device = "";
                                        ObjBulkRR.Interpretation = "";
                                        ObjBulkRR.OrgID = OrgID;
                                        ObjBulkRR.InvestigationName = txtName.Text;
                                        ObjBulkRR.Status = true;
                                    }
                                }
                                //Other
                                if (CatagoryAgeMain[1].ToString() == "Other")
                                {
                                    Array CatagoryAgeSubarr = CatagoryAgeMain[0].Split('^');
                                    for (int j = 0; j < CatagoryAgeSubarr.Length - 1; j++)
                                    {
                                        Array CatagoryAgeSubarrAge = CatagoryAgeSubarr.GetValue(j).ToString().Split('~');
                                        ObjBulkRR.SubCategoryType = Convert.ToString(CatagoryAgeMain[1]);
                                        ObjBulkRR.TestCode = TestCode;
                                        ObjBulkRR.InvestigationID = InvestigationId;
                                        ObjBulkRR.RangeType = ReferenceRange[0];
                                        ObjBulkRR.GenderValue = Convert.ToString(CatagoryAgeSubarrAge.GetValue(0));
                                        ObjBulkRR.ResultType = "";
                                        ObjBulkRR.TypeMode = Convert.ToString(CatagoryAgeSubarrAge.GetValue(6));
                                        ObjBulkRR.AgeRangeType = Convert.ToString(CatagoryAgeSubarrAge.GetValue(2));
                                        ObjBulkRR.AgeRange = Convert.ToString(CatagoryAgeSubarrAge.GetValue(3));
                                        ObjBulkRR.ReferenceName = Convert.ToString(CatagoryAgeSubarrAge.GetValue(1));
                                        ObjBulkRR.ValueTypeMode = Convert.ToString(CatagoryAgeSubarrAge.GetValue(7));
                                        ObjBulkRR.Value = Convert.ToString(CatagoryAgeSubarrAge.GetValue(8));
                                        ObjBulkRR.IsNormal = Convert.ToString(CatagoryAgeSubarrAge.GetValue(4));
                                        ObjBulkRR.IsSourceText = Convert.ToString(CatagoryAgeSubarrAge.GetValue(5));
                                        ObjBulkRR.ResultType = Convert.ToString(CatagoryAgeSubarrAge.GetValue(12));
                                        ObjBulkRR.Device = "";
                                        ObjBulkRR.Interpretation = "";
                                        ObjBulkRR.OrgID = OrgID;
                                        ObjBulkRR.InvestigationName = txtName.Text;
                                        ObjBulkRR.Status = true;
                                    }
                                }
                            }
                            lstBulKRR.Add(ObjBulkRR);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while converting string to xml", ex);
            throw ex;
        }
    }

}
