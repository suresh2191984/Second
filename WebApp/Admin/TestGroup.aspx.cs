using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;
using System.Web.Script.Serialization;
using System.Xml;
using System.Xml.Linq;
using Attune.Kernel.PlatForm.Base;

public partial class Admin_TestGroup :BasePage
{
    public Admin_TestGroup()
        : base("Admin_TestGroup_aspx")
    {
    }
    public string Update_Msg = Resources.AppMessages.Update_Message;
    public string Delete_Msg = Resources.AppMessages.Delete_Message;
    string StrShow = Resources.Admin_AppMsg.Admin_TestGroup_aspx_20 == null ? "Show" : Resources.Admin_AppMsg.Admin_TestGroup_aspx_20;
    string ModifiedBy = string.Empty;
    List<InvGroupMaster> objInvGrp = new List<InvGroupMaster>();
    List<InvGroupMaster> objGrpMap = new List<InvGroupMaster>();
    List<ReasonMaster> lstReasonMaster;
    Master_BL objReasonMaster;
    string Reftypes = "TM";
    int currentPageNo = 1;
    int PageSize = 20;
    int totalRows = 0;
    int totalpage = 0;
    string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        //this.GetPostBackEventReference(this, string.Empty);
        //if (this.IsPostBack)
        //{
        //    string eventTarget = (this.Request["__EVENTTARGET"] == null) ?
        //     string.Empty : this.Request["__EVENTTARGET"];
        //    string eventArgument = (this.Request["__EVENTARGUMENT"] == null) ?
        //     string.Empty : this.Request["__EVENTARGUMENT"];
        //    if (eventTarget == "Execute")
        //        Execute(eventArgument);
        //}
        try
        {
            if (!IsPostBack)
            {
                loadgrid(e, currentPageNo, PageSize);
                LoadMetaValues();
                string CodingScheme = GetConfigValue("CodingScheme", OrgID);
                if (CodingScheme == "Y")
                {
                    loadCodingSchemaName();
                }
                ACETestCodeScheme.ContextKey = OrgID + "~" + CodeSchemeType.Groups;
                hdnOrgID.Value = Convert.ToString(OrgID);
                hdnLocationID.Value = Convert.ToString(ILocationID);
                //hdnSelectedOrgID.Value = drpProcessingOrg.SelectedItem.Value;
                LoadMetaData();
                LoadScheduleType();
                LoadProtocalGroup();
                loadReasonDetails();
                LoadInvLocationMapping();
                /* Registering FCKEditor Begins */
                string sPath = Request.Url.AbsolutePath;
                int iIndex = sPath.LastIndexOf("/");

                sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
                sPath = Request.ApplicationPath;
                sPath = sPath + "/fckeditor/";

                //FCKeditor1.BasePath = sPath;
                //FCKeditor1.ToolbarSet = "Interpretation";
                //FCKeditor1.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor1.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

              //  ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor1", String.Format("var lblFCKeditor1=\"{0}\";", FCKeditor1.ClientID), true);

              //  ScriptManager.RegisterOnSubmitStatement(this, FCKeditor1.GetType(), FCKeditor1.ClientID + "editor1", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor1.ClientID + "').UpdateLinkedField();}}");

                //FCKeditor2.BasePath = sPath;
                //FCKeditor2.ToolbarSet = "Interpretation";
                //FCKeditor2.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor2.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

               // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor2", String.Format("var lblFCKeditor2=\"{0}\";", FCKeditor2.ClientID), true);

               // ScriptManager.RegisterOnSubmitStatement(this, FCKeditor2.GetType(), FCKeditor2.ClientID + "editor2", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor2.ClientID + "').UpdateLinkedField();}}");

                //FCKeditor3.BasePath = sPath;
                //FCKeditor3.ToolbarSet = "Interpretation";
                //FCKeditor3.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
                //FCKeditor3.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

               // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "lblFCKeditor3", String.Format("var lblFCKeditor3=\"{0}\";", FCKeditor3.ClientID), true);

               // ScriptManager.RegisterOnSubmitStatement(this, FCKeditor3.GetType(), FCKeditor3.ClientID + "editor3", "if (typeof FCKeditorAPI != 'undefined' && FCKeditorAPI != null){ if(FCKeditorAPI.GetInstance('" + FCKeditor3.ClientID + "') !=null){FCKeditorAPI.GetInstance('" + FCKeditor3.ClientID + "').UpdateLinkedField();}}");
                /* Registering FCKEditor ends */
            }
            if (Request.QueryString["IsPopUp"] == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "all", "hideHeader();", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Group Page_Load", ex);
        }
    }
    void loadReasonDetails()
    {
        string objddlReasonn = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
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
            ddlReasonn.Items.Insert(0, objddlReasonn);
            //ddlReasonn.Items.Insert(0, "--Select--");
            ddlReasonn.Items[0].Value = "0";
            ddlReasonn.SelectedValue = setID;
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
    public void LoadMetaData()
    {
        string objddlGender = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
        try
        {
            long returncode = -1;
            string domains = "Gender";
            //string domains = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_13;
            string[] Tempdata = domains.Split(',');
           // string LangCode = "en-GB";
            string LangCode = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_14;
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
                //var childItems = from child in lstmetadataOutput
                //                 where child.Domain == "Gender"
                //                 select child;
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == domains
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlGender.DataSource = childItems;
                    ddlGender.DataTextField = "DisplayText";
                    ddlGender.DataValueField = "Code";
                    ddlGender.DataBind();
                    ddlGender.Items.Insert(0, objddlGender);
                   // ddlGender.Items.Insert(0, "--Select--");
                    ddlGender.Items[0].Value = "0";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }
    protected void btnLoadGroupDetails_Click(object sender, EventArgs e)
    {
        try
        {
            long invID = 0;
            Int64.TryParse(hdnInvID.Value, out invID);
            Reset();
            rptCodeSchema.DataSource = null;
            rptCodeSchema.DataBind();
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
            oInvestigationBL.GetTestMasterDetails(OrgID, invID, CodeSchemeType.Groups, out lstTestMasterDetails, out lstCodingScheme, out lstInvRemarks, out lstInvOrgReferenceMapping, out lstInvValueRangeMaster, out lstInvOrgNotifications, out lstCoAuth, out lstInvBulkData, out lstInstrumentMaster, out lstLocationMapping, out objInvDeltaCheck, out lstCrossParametertests, out lstInvAutoCertify);
            if (lstTestMasterDetails.Count > 0)
            {
                TestMaster oTestMaster = lstTestMasterDetails[0];
                txtName.Text = String.IsNullOrEmpty(oTestMaster.InvestigationName) ? string.Empty : oTestMaster.InvestigationName;
                txtDisplayText.Text = String.IsNullOrEmpty(oTestMaster.DisplayText) ? string.Empty : oTestMaster.DisplayText;
                txtBillingName.Text = String.IsNullOrEmpty(oTestMaster.BillingName) ? string.Empty : oTestMaster.BillingName;
                txtOutputCode.Text = String.IsNullOrEmpty(oTestMaster.OutputGroupingCode) ? string.Empty : oTestMaster.OutputGroupingCode;
                txtCutOffValue.Text = oTestMaster.CutOffTimeValue == 0 ? string.Empty : Convert.ToString(oTestMaster.CutOffTimeValue);
                chkIsOrder.Checked = oTestMaster.IsOrderable == "Y" ? true : false;
                chkDiscount.Checked = oTestMaster.IsDiscountable == "Y" ? true : false;
                chkServiceTax.Checked = oTestMaster.IsServiceTax == "Y" ? true : false;
                chkPrintSeparately.Checked = oTestMaster.PrintSeparately == "Y" ? true : false;
                ChkIsSensitivetest.Checked = oTestMaster.IsSensitiveTest == "Y" ? true : false;
                chkIsActive.Checked = oTestMaster.IsSTAT == "Y" ? true : false;
                Chksummaryworklist.Checked = oTestMaster.GetWorkList == "Y" ? true : false;
                chkIsFieldTest.Checked = oTestMaster.IsFieldTest == "Y" ? true : false;
                //Adeed by Arivalgan.kk/For SynopticReport//
                ChkSynoptic.Checked = oTestMaster.IsSynoptic == "Y" ? true : false;
                chkshowgrpinstruction.Checked = oTestMaster.ShowGroupInstruction;

                if (oTestMaster.IsTATrandom != -1)
                {
                    ddlScheduleType.SelectedValue = Convert.ToString(oTestMaster.IsTATrandom);

                }
                /* Loading saved interpretation detail Begins */
                FCKeditor1.Text = string.Empty;
                FCKeditor2.Text = string.Empty;
                FCKeditor3.Text = string.Empty;

                string interpretation = string.Empty;

                if (!String.IsNullOrEmpty(oTestMaster.Interpretation))
                {
                    interpretation = oTestMaster.Interpretation;

                    FCKeditor1.Text = interpretation;

                    if (TryParseXml(interpretation)) // Check whether the saved interpretation is xml format and loading the details
                    {
                        XmlDocument xmlDoc = new XmlDocument();
                        xmlDoc.LoadXml(interpretation);
                        XmlNodeList lstLayout = xmlDoc.GetElementsByTagName("Layout"); // Getting the tabular interpretation layout type
                        string layoutType = string.Empty;
                        if (lstLayout != null && lstLayout.Count > 0)
                        {
                            layoutType = lstLayout[0].Attributes[0].Value;
                        }
                       
                        XmlNodeList lstText1Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text1']");
                        if (lstText1Items != null && lstText1Items.Count > 0)
                        {
                            FCKeditor1.Text = lstText1Items.Item(0).Attributes["Value"].Value;
                        }
                        XmlNodeList lstText2Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text2']");
                        if (lstText2Items != null && lstText2Items.Count > 0)
                        {
                            FCKeditor2.Text = lstText2Items.Item(0).Attributes["Value"].Value;
                        }
                        XmlNodeList lstText3Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='text3']");
                        if (lstText3Items != null && lstText3Items.Count > 0)
                        {
                            FCKeditor3.Text = lstText3Items.Item(0).Attributes["Value"].Value;
                        }
                      
                        bool isTableExists = false;
                        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                        List<List<string>> lstTable = new List<List<string>>();
                        List<string> oTable = new List<string>();
                        Int32 rowNo = 0;
                        Int32 xmlRowNo = 0;
                        string table1Data = string.Empty;
                        string table2Data = string.Empty;
                      
                        XmlNodeList lstTable1Items = xmlDoc.SelectNodes("/Interpretation/Item[@Type='table1']");
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
                            ScriptManager.RegisterClientScriptBlock(UpdPnlAssociateGroup, typeof(UpdatePanel), "onChangeLayout", "changeLayout('" + layoutType + "');loadInterpretationTableData('" + hdnHandsonTable1Data.ClientID + "','" + hdnHandsonTable2Data.ClientID + "');", true);
                        }
                        else
                        {
                            ScriptManager.RegisterClientScriptBlock(UpdPnlAssociateGroup, typeof(UpdatePanel), "onChangeLayout", "changeLayout('" + layoutType + "');", true);
                        }
                        
                    }
                    else
                    {
                        FCKeditor1.Text = interpretation; // Loading non xml format interpretation details
                    }
                }
                else
                {
                    FCKeditor1.Text = string.Empty;
                }
                /* Loading saved interpretation detail Ends */
                if (!String.IsNullOrEmpty(oTestMaster.CutOffTimeType))
                {
                    ddlCutOffType.SelectedIndex = ddlCutOffType.Items.IndexOf(ddlCutOffType.Items.FindByValue(oTestMaster.CutOffTimeType));
                }
                if (!String.IsNullOrEmpty(oTestMaster.Classification))
                {
                    ddlClassification.SelectedIndex = ddlClassification.Items.IndexOf(ddlClassification.Items.FindByValue(oTestMaster.Classification));
                }
                if (!String.IsNullOrEmpty(oTestMaster.SubCategory))
                {
                    ddlTestCategory.SelectedIndex = ddlTestCategory.Items.IndexOf(ddlTestCategory.Items.FindByValue(oTestMaster.SubCategory));
                }
                if (oTestMaster.Gender != null)
                {
                    ddlGender.SelectedIndex = ddlGender.Items.IndexOf(ddlGender.Items.FindByValue(Convert.ToString(oTestMaster.Gender)));
                }
                if (oTestMaster.ProtocalGroupID != 0)
                {
                    ddlProtocalGroup.SelectedIndex = ddlProtocalGroup.Items.IndexOf(ddlProtocalGroup.Items.FindByValue(oTestMaster.ProtocalGroupID.ToString()));
                }
            }
            if (lstCodingScheme.Count > 0)
            {
                rptCodeSchema.DataSource = lstCodingScheme;
                rptCodeSchema.DataBind();
            }
            if (lstInvRemarks.Count > 0)
            {
                rptRemarks.DataSource = lstInvRemarks;
                rptRemarks.DataBind();
            }
            if (lstLocationMapping.Count > 0)
            {
                rptInvLocationMapping.DataSource = lstLocationMapping;
                rptInvLocationMapping.DataBind();
            }

            LoadInvLocationMapping();
            btnSave.Enabled = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in btnLoadGroupDetails_Click", ex);
        }
    }
    bool TryParseXml(string xml)
    {
        try
        {
            XElement xe = XElement.Parse(xml);
            return true;
        }
        catch (XmlException e)
        {
            return false;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        try
        {
            long InvID = 0;
            string Classification = string.Empty;
            string SubCategory = string.Empty;
            int CutOffTimeValue = 0;
            Int64.TryParse(hdnInvID.Value, out InvID);
            string Gender = string.Empty;
            string Protocalgroup = string.Empty;
            string Reason = string.Empty;
            TestMaster oTestMaster = new TestMaster();
            oTestMaster.OrgID = OrgID;
            oTestMaster.InvestigationID = InvID;
            oTestMaster.InvestigationName = txtName.Text;
            oTestMaster.DisplayText = txtDisplayText.Text;
            oTestMaster.BillingName = txtBillingName.Text;
            oTestMaster.OutputGroupingCode = txtOutputCode.Text;
            oTestMaster.IsSTAT = chkIsActive.Checked == true ? "Y" : "N";
            oTestMaster.Gender = ddlGender.SelectedItem.Value;
            oTestMaster.IsFieldTest = chkIsFieldTest.Checked ? "Y" : "N";
            if (ddlScheduleType.SelectedValue != "-1" && ddlScheduleType.SelectedValue != "")
            {
                oTestMaster.IsTATrandom = Convert.ToInt16((ddlScheduleType.SelectedValue));
            } 
            else
            {   
                oTestMaster.IsTATrandom = 0;
            }
            if (ddlProtocalGroup.Items.Count>0)
            {
                Protocalgroup = (String.IsNullOrEmpty(ddlProtocalGroup.SelectedItem.Value) || ddlProtocalGroup.SelectedIndex == 0) ? string.Empty : ddlProtocalGroup.SelectedItem.Value;
            }
            int Protocal = 0;
            Int32.TryParse(Protocalgroup, out Protocal);
            oTestMaster.ProtocalGroupID = Protocal;
            if (!String.IsNullOrEmpty(txtCutOffValue.Text) && ddlCutOffType.Items.Count > 0)
            {
                Int32.TryParse(txtCutOffValue.Text, out CutOffTimeValue);
                oTestMaster.CutOffTimeValue = CutOffTimeValue;
                oTestMaster.CutOffTimeType = ddlCutOffType.SelectedItem.Value;
            }
            if (ddlClassification.Items.Count > 0)
            {
                Classification = (String.IsNullOrEmpty(ddlClassification.SelectedItem.Value) ? string.Empty : ddlClassification.SelectedItem.Value);
            }
            if (ddlTestCategory.Items.Count > 0)
            {
                SubCategory = (String.IsNullOrEmpty(ddlTestCategory.SelectedItem.Value) || ddlTestCategory.SelectedIndex == 0) ? string.Empty : ddlTestCategory.SelectedItem.Value;
            }
            if (ddlGender.Items.Count > 0)
            {
                Gender = (String.IsNullOrEmpty(ddlGender.SelectedItem.Value) || ddlGender.SelectedIndex == 0) ? string.Empty : ddlGender.SelectedItem.Value;
            }
            oTestMaster.SubCategory = SubCategory;
            oTestMaster.Classification = Classification;
            oTestMaster.Gender = Gender;
            oTestMaster.IsOrderable = chkIsOrder.Checked == true ? "Y" : "N";
            oTestMaster.IsDiscountable = chkDiscount.Checked == true ? "Y" : "N";
            oTestMaster.IsServiceTax = chkServiceTax.Checked == true ? "Y" : "N";
            oTestMaster.PrintSeparately = chkPrintSeparately.Checked == true ? "Y" : "N";
            oTestMaster.IsSensitiveTest = ChkIsSensitivetest.Checked == true ? "Y" : "N";
            oTestMaster.GetWorkList = Chksummaryworklist.Checked == true ? "Y" : "N";
            //Added By Arivalagan.kk/ For Synotic Report//
            oTestMaster.IsSynoptic = ChkSynoptic.Checked ? "Y" : "N";

            /* Show Group instruction -- Seetha */
            oTestMaster.ShowGroupInstruction = chkshowgrpinstruction.Checked == true ? true : false;
            /* Show Group instruction */
            /* Saving tabular interpretation details begins */
            string selectedLayout = hdnSelectedLayout.Value;
            string fckEditorText1 = FCKeditor1.Text == "<br />" ? string.Empty : FCKeditor1.Text;
            string fckEditorText2 = FCKeditor2.Text == "<br />" ? string.Empty : FCKeditor2.Text;
            string fckEditorText3 = FCKeditor3.Text == "<br />" ? string.Empty : FCKeditor3.Text;
            if (selectedLayout == "layout1")
            {
                // Saving text content directly if layout 1 is selected
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
                // Creating xml to store the tabular interpretation details
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
            /* Saving tabular interpretation details ends */
            List<InvRemarks> lstInvRemarks = new List<InvRemarks>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strLstInvRemarks = hdnLstInvRemarks.Value;
            lstInvRemarks = serializer.Deserialize<List<InvRemarks>>(strLstInvRemarks);
            if (lstInvRemarks == null)
            {
                lstInvRemarks = new List<InvRemarks>();
            }
            /* Saving Processing Location Mapping */
            JavaScriptSerializer serializer2 = new JavaScriptSerializer();
            List<InvestigationLocationMapping> lstInvLocation = new List<InvestigationLocationMapping>();
            string strInvLocation = hdnInvLocation.Value;
            lstInvLocation = serializer2.Deserialize<List<InvestigationLocationMapping>>(strInvLocation);

            if (lstInvLocation == null)
            {
                lstInvLocation = new List<InvestigationLocationMapping>();
            }
            List<InvOrgReferenceMapping> lstInvOrgReferenceMapping = new List<InvOrgReferenceMapping>();
            InvestigationLocationMapping oInvestigationLocationMapping = new InvestigationLocationMapping();
            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
            List<InvOrgAuthorization> lstCoAuth = new List<InvOrgAuthorization>();
            Investigation_BL oInvestigationBL = new Investigation_BL(base.ContextInfo);
            List<InvOrgNotifications> lstInvOrgNotifications = new List<InvOrgNotifications>();
            List<BulkReferenceRange> lstBulkRR = new List<BulkReferenceRange>();

            if (ddlReasonn.SelectedValue != "0")
            {
                Reason = ddlReasonn.SelectedItem.ToString();
            }
            List<InvValueRangeMaster> lstInvCrossparameterTest = new List<InvValueRangeMaster>();
            List<InvAutoCertifyValidation> lstInvAutoCertify = new List<InvAutoCertifyValidation>();
            InvDeltaCheck oInvDeltaCheck = new InvDeltaCheck();
            returnCode = oInvestigationBL.SaveTestMasterDetails(oTestMaster, lstInvRemarks, lstInvOrgReferenceMapping, oInvestigationLocationMapping, OrgID, Convert.ToInt64(hdnInvID.Value), CodeSchemeType.Groups, LID, lstInvValueRangeMaster, lstInvOrgNotifications, lstCoAuth, lstInvLocation, Reason, lstBulkRR, oInvDeltaCheck, lstInvCrossparameterTest, lstInvAutoCertify);
            if (returnCode >= 0)
            {
                Reset();
                btnLoadGroupDetails_Click(btnLoadGroupDetails, null);
                //string sPath = "Admin\\\\TestGroup.aspx.cs_9";
                string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_15 == null ? "Record saved successfully" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_15;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ShowAlertMsg('"+sPath+"');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('Record saved successfully');", true);
              //  btnSave.Enabled = false;
                ddlReasonn.SelectedValue ="0";
            }
            else
            {
                Reset();
                txtTestCodeScheme.Text = string.Empty;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Saving Group Details", ex);
        }
    }
    private void Reset()
    {
        try
        {
            txtName.Text = string.Empty;
            txtDisplayText.Text = string.Empty;
            txtBillingName.Text = string.Empty;
            txtCutOffValue.Text = string.Empty;
            ddlCutOffType.SelectedIndex = 0;
            ddlClassification.SelectedIndex = 0;
            ddlTestCategory.SelectedIndex = 0;
            ddlProtocalGroup.SelectedIndex = 0;
            ddlScheduleType.SelectedIndex = 0;
            chkIsOrder.Checked = false;
            chkDiscount.Checked = false;
            chkServiceTax.Checked = false;
            chkPrintSeparately.Checked = false;
            ChkIsSensitivetest.Checked = false;
            txtRemarks.Text = string.Empty;
            chkIsActive.Checked = false;
            rptRemarks.DataSource = null;
            rptRemarks.DataBind();
            hdnSelectedRemarksID.Value = string.Empty;
            btnSave.Enabled = false;
            ddlGender.SelectedIndex = 0;
            chkIsFieldTest.Checked = false;
            rptCodeSchema.DataSource = null;
            rptCodeSchema.DataBind();
            rptInvLocationMapping.DataSource = null;
            rptInvLocationMapping.DataBind();

            //Added By Arivalagan.kk/ For Synotic Report//
            ChkSynoptic.Checked = false;
            txtOutputCode.Text = string.Empty;
            chkshowgrpinstruction.Checked = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in reset", ex);
            throw ex;
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Reset();
        txtTestCodeScheme.Text = string.Empty;
    }
    public void LoadMetaValues()
    {
        string objitem = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
        try
        {
            long returnCode = -1;
            MetaData oMetaData = new MetaData();
            oMetaData.Domain = "TestClassification";
            string LangCode = "en-GB";
            List<MetaData> lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData);
            List<MetaData> lstMetaData = new List<MetaData>();
            // returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);
			returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LangCode, out lstMetaData);

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
            MetaData oMetaData1 = new MetaData();
            oMetaData1.Domain = "RemarksType";
            lstDomain = new List<MetaData>();
            lstDomain.Add(oMetaData1);
            lstMetaData = new List<MetaData>();
            // returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstDomain, LangCode, out lstMetaData);
			returnCode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstDomain, OrgID, LangCode, out lstMetaData);
			
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
                    ddlCutOffType.DataSource = lstCutOffTimeType;
                    ddlCutOffType.DataTextField = "DisplayText";
                    ddlCutOffType.DataValueField = "Code";
                    ddlCutOffType.DataBind();
                }
            }
            List<MetaValue_Common> lstGroupCategory = new List<MetaValue_Common>();
            returnCode = new Master_BL(base.ContextInfo).GetmetaValue(OrgID, "INVESTIGATION_FEE", out lstGroupCategory);

            if (lstGroupCategory.Count > 0)
            {
                ddlTestCategory.DataSource = lstGroupCategory;
                ddlTestCategory.DataTextField = "Value";
                ddlTestCategory.DataValueField = "Code";
                ddlTestCategory.DataBind();
            }
            ListItem item = new ListItem();
            item.Text = objitem;
            //item.Text = "---Select---";
            item.Value = "0";
            ddlTestCategory.Items.Insert(0, item);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in the Fill funtion in Group Master", ex);
        }
    }
    public void fill()
    {
        long Returncode = -1;
        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
        //List<InvGroupMaster> objInvGrp = new List<InvGroupMaster>();
        //List<InvGroupMaster> objGrpMap = new List<InvGroupMaster>();
        List<InvGroupMaster> objGrp = new List<InvGroupMaster>();
        List<OrderedInvestigations> validId = new List<OrderedInvestigations>();
        List<OrderedInvestigations> grouvalid = new List<OrderedInvestigations>();
        // List<OrderedInvestigations> grop = new List<OrderedInvestigations>();
        try
        {
            chklstGrp.Items.Clear();
            chkGrpMap.Items.Clear();

            Returncode = ObjInv.GetInvForMDMAddGrp(OrgID, CodeSchemeType.Groups, out objInvGrp, out validId);
            Returncode = ObjInv.GetInvForMDMAddGrp(OrgID, "GRPMAP", out objGrpMap, out grouvalid);
            //Returncode = ObjInv.GroupValidation(OrgID, out grop); 

            //LinkButton lnk = new LinkButton();
            //LinkButton lnk1 = new LinkButton();
            //lnk1.ID = "lnk1";
            //lnk1.CommandName = "Show";
            //lnk1.Text = "Show";
            //lnk1.Font.Underline = true;
            //lnk1.ForeColor = System.Drawing.Color.Red;
            //lnk1.Click += new EventHandler(lnk1_Click);
            //onclick = " + Execute(map.OrgGroupID) + ";
            var groupmap = from map in objGrpMap
                           select new
                           {
                               GroupName = map.GroupName.ToUpper() + "  " + "<input onclick='clicked(name);' name='" + map.OrgGroupID + "'  value = " + StrShow + " type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>"
                                     ,
                               OrgGroupID = map.OrgGroupID

                               //GroupName = map.GroupName.ToUpper() + "<asp:LinkButton ID='lnk' runat='server' text='Show' ForeColor='Red' > </asp:LinkButton>",
                               //OrgGroupID = map.OrgGroupID                                                        
                           };
            //Session["Grpmas"] = new List<InvGroupMaster>();
            //Session["Grpmas"] = objInvGrp;

            //Session["Grpmap"] = new List<InvGroupMaster>();
            //Session["Grpmap"] = objGrpMap;



            if (objInvGrp.Count > 0)
            {
                chklstGrp.DataSource = objInvGrp;
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataBind();
            }
            else
            {
                chklstGrp.DataSource = null;
                chklstGrp.DataBind();
            }
            if (objGrpMap.Count() > 0)
            {
                chkGrpMap.DataSource = groupmap;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "OrgGroupID";
                chkGrpMap.DataBind();

                var OrderedGroupList = (from IL in groupmap
                                        join VA in validId on IL.OrgGroupID equals VA.ID
                                        select IL).ToList();

                foreach (var ord in OrderedGroupList)
                {
                    string ID = ord.OrgGroupID.ToString();
                    ListItem item = chkGrpMap.Items.FindByValue(ID);
                    if (item != null)
                    {
                        item.Enabled = false;
                    }
                }

                /*
                foreach (ListItem item in chkGrpMap.Items)
                {
                    //item.Attributes.Add("onclick", "Execute()");
                    //LinkButton lnk1 = new LinkButton();
                    ///HtmlTableCell tblCellDef = new HtmlTableCell();
                    //LinkButton lnk1 = new LinkButton();
                    //lnk1.ID = "lnk1";
                    //lnk1.CommandName = "Show";
                    //lnk1.Text = "Show";
                    //lnk1.Font.Underline = true;
                    //lnk1.ForeColor = System.Drawing.Color.Red;
                    //lnk1.Click += new EventHandler(lnk1_Click);
                    ////tblCellDef.Controls.Add(lnk1);
                    ////lnk1.Attributes.Add("onclick", "Execute()");
                    //item.Text = item.Text+"  "+ lnk1.Text;
                    //chkGrpMap.Controls.Add(lnk1);
                    //chkGrpMap.DataBind();
                    foreach (OrderedInvestigations ord in validId)
                    {
                        if (item.Value == ord.ID.ToString())
                        {
                            item.Enabled = false;
                        }
                    }

                }
                 * */
            }
            else
            {
                chkGrpMap.DataSource = null;
                chkGrpMap.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in the Fill funtion in Group Master", ex);
        }
    }
    protected void lnkshow_click(object sender, EventArgs e)
    {
        string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_16;
        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ShowAlertMsg('"+sPath+"');", true);
       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ShowAlertMsg('" + sPath + "');", true);
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('No Such Records found');", true);
    }
    //[WebMethod]
    public void Execute1(object sender, EventArgs e)
    {
        // CommonControls_ManageInvestigation MI = new CommonControls_ManageInvestigation();
        ManageInvestigation.show(OrgID, Convert.ToInt32(hdnshowid.Value));
        mpe.Show();
        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "NotifyLoadingDrug", "reloadauto();", true);
        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "document.getElementById('"+ Panel2.ClientID +"').style.display='block';", true);
        //Page.RegisterStartupScript("Scrpt1","<script>$find('grouptab_addgrouptab_mpe').show();</Script>");
        //ClientScript.RegisterStartupScript(this.GetType(), "srchmap", "$find('grouptab_addgrouptab_mpe').show();", true);   
        // MI.show(bp.OrgID, id);
    }
    protected void btnmassearch_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        List<InvGroupMaster> objSearch = new List<InvGroupMaster>();
        try
        {
            chklstGrp.Items.Clear();
            string srch = txt_search.Text.Trim();
            // objSearch = (List<InvGroupMaster>)Session["Grpmas"];
            //objSearch = (List<InvGroupMaster>)objInvGrp;
            Investigation_BL ObjInvBL = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> objGrp = new List<InvGroupMaster>();
            List<OrderedInvestigations> validId = new List<OrderedInvestigations>();
            Returncode = ObjInvBL.GetInvForMDMAddGrp(OrgID, CodeSchemeType.Groups, out objInvGrp, out validId);
            var search = from find in objInvGrp
                         where
                         find.GroupName.Contains(srch.ToUpper())
                         orderby find.GroupName.ToUpper()
                         select find;

            if (string.IsNullOrEmpty("search") && (search.Count() > 0))
            //if (search.Count() > 0)
            {
                chklstGrp.DataSource = search;
                chklstGrp.DataValueField = "GroupID";
                chklstGrp.DataTextField = "GroupName";
                chklstGrp.DataBind();
            }
            else
            {
                string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_16;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

                //string sPath = "Admin\\\\TestGroup.aspx.cs_10";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ShowAlertMsg('"+sPath+"');", true);
                ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('No Such Records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in the Group master search in Group Master ", ex);
        }
    }
    protected void btnmapsearch_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        List<InvGroupMaster> objSrch = new List<InvGroupMaster>();
        try
        {
            chkGrpMap.Items.Clear();
            string srch = txt_searchmap.Text.Trim();
            //objSrch = (List<InvGroupMaster>)Session["Grpmap"];
            //objSrch = (List<InvGroupMaster>)objGrpMap;
            Investigation_BL ObjInvBL = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> objGrp = new List<InvGroupMaster>();
            List<OrderedInvestigations> grouvalid = new List<OrderedInvestigations>();
            Returncode = ObjInvBL.GetInvForMDMAddGrp(OrgID, "GRPMAP", out objGrpMap, out grouvalid);
            var search = from find in objGrpMap
                         where
                         find.GroupName.Contains(srch.ToUpper())
                         orderby find.GroupName.ToUpper()
                         select find;

            LinkButton lnkbtn = new LinkButton();
            var groupmap = from map in search
                           select new
                           {
                               GroupName = map.GroupName.ToUpper() + "<input onclick='show(name);' name='" + map.OrgGroupID
                               + "'  value = " + StrShow + " type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>"
                               ,
                               OrgGroupID = map.OrgGroupID

                           };

            if (search.Count() > 0)
            {
                chkGrpMap.DataSource = groupmap;
                chkGrpMap.DataTextField = "GroupName";
                chkGrpMap.DataValueField = "OrgGroupID";
                chkGrpMap.DataBind();
            }
            else
            {
                string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_16==null ? "No Such Records found" :Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_16;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);

                //string sPath = "Admin\\\\TestGroup.aspx.cs_10";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ShowAlertMsg('"+sPath+"');", true);
                ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:alert('No Such Records found');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in the Group Map Search in Group Master", ex);
        }
    }
    protected void btnGrpAdd_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            long returnCode = -1;
            string type = CodeSchemeType.Groups;
            int ddlCase = 7;
            int iDptId = 0;
            long lHeader = 0;
            string groupName = "0";
            string GroupCode = string.Empty;
            string BillingName = string.Empty;
            string remarks = string.Empty;
            string status = string.Empty;
            string pkgcode = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            //Get the Selected Item in checkboxlist using LINQ.
            IEnumerable<ListItem> allChecked = (from ListItem item in chklstGrp.Items
                                                where item.Selected
                                                select item);

            foreach (ListItem item in allChecked)
            {
                InvestigationOrgMapping objmap = new InvestigationOrgMapping();
                objmap.InvestigationID = Int64.Parse(item.Value);
                objmap.InvestigationName = item.Text;
                objmap.OrgID = OrgID;
                lstIOM.Add(objmap);
            }
            returnCode = ObjInv.SaveInvestigationGrpName(lstIOM, groupName,BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType,Gender,IsServiceTaxable,ScheduleType,true);
            if (returnCode == 0)
            {
                string UserMsg = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_02 == null ? "Changes saved successfully" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_02;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + UserMsg + "','" + Information + "');", true);
 
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('"+Update_Msg+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('.');", true);
            }
            else
            {
                string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_17 == null ? "Select a group to add" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_17;
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ShowAlertMsg('" + sPath + "');", true);
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
 
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Select a group to add');", true);
                fill();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Adding the Group in Group Master", ex);
        }
    }
    protected void btnGrpRemove_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvestigationOrgMapping> lstIOM = new List<InvestigationOrgMapping>();
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            long returnCode = -1;
            string type = CodeSchemeType.Groups;
            int ddlCase = 6;
            int iDptId = 0;
            long lHeader = 0;
            string groupName = "0";
            string GroupCode = string.Empty;
            string BillingName = string.Empty;
            string remarks = string.Empty;
            string status = string.Empty;
            string pkgcode = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges(); 
            //Get the Selected Item in checkboxlist using LINQ.
            IEnumerable<ListItem> allChecked = (from ListItem item in chkGrpMap.Items
                                                where item.Selected
                                                select item);

            foreach (ListItem item in allChecked)
            {
                InvestigationOrgMapping objmap = new InvestigationOrgMapping();
                objmap.InvestigationID = Int64.Parse(item.Value);
                objmap.InvestigationName = item.Text;
                objmap.OrgID = OrgID;
                lstIOM.Add(objmap);
            }
            returnCode = ObjInv.SaveInvestigationGrpName(lstIOM, groupName,BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType,Gender,IsServiceTaxable,ScheduleType,true);
            if (returnCode > 0)
            {
                string DeleteMsg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_18 == null ? "Delete Successfully" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_18;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + DeleteMsg + "','" + Information + "');", true);
 
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('"+Delete_Msg+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Sucessfully removed');", true);
            }
            else
            {
                string sPath = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_19 == null ? "Select a group to remove" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_19;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + Information + "');", true);
 
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ShowAlertMsg('"+sPath+"');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Select a group to remove');", true);
                fill();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Removing the Group Master", ex);
        }
    }
    protected void Add_Click(object sender, EventArgs e)
    {
        try
        {
            int groupid = 0;
            string groupName = string.Empty;
            string BillingName = string.Empty;
            string type = string.Empty;
            string text = string.Empty;
            string GroupCode = string.Empty;
            string remarks = string.Empty;
            string status = "Y";
            string pkgcode = string.Empty;
            int CutOffTimeValue = 0;
            string CutOffTimeType = string.Empty;
            string Gender = string.Empty;
            string IsServiceTaxable = string.Empty;
            short ScheduleType = 0;
            long returnCode;

            string[] Codeschemelabels = new string[grdInvCodingScheme.Rows.Count];
            string[] CodeSchemeNames = new string[grdInvCodingScheme.Rows.Count];
            string[] CodeMasterId = new string[grdInvCodingScheme.Rows.Count];

            int i = 0;
            foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
            {
                Codeschemelabels[i] = (GrdRow.FindControl("lblCodingSchemeNameMasterID") as Label).Text;
                CodeSchemeNames[i] = (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text;
                CodeMasterId[i] = (GrdRow.FindControl("lblCodeMasterID") as Label).Text;
                i = i + 1;

            }
            DataTable dtCodingSchemeMaster = new DataTable();
            dtCodingSchemeMaster.Columns.Add("CodeLabel");
            dtCodingSchemeMaster.Columns.Add("CodeTextbox");
            dtCodingSchemeMaster.Columns.Add("CodeMasterID");
            dtCodingSchemeMaster.AcceptChanges();
            int j = 0;
            for (j = 0; j <= i - 1; j++)
            {
                DataRow dr;
                dr = dtCodingSchemeMaster.NewRow();
                dr["CodeLabel"] = Codeschemelabels[j];
                dr["CodeTextbox"] = CodeSchemeNames[j];
                dr["CodeMasterID"] = CodeMasterId[j];
                dtCodingSchemeMaster.Rows.Add(dr);
                dtCodingSchemeMaster.AcceptChanges();

            } 
            GroupCode = CodeSchemeNames[0];
            Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
            List<InvestigationOrgMapping> objMap = new List<InvestigationOrgMapping>();
            if (hdnGroupID.Value != "")
            {
                groupid = Convert.ToInt32(hdnGroupID.Value);
            }
            groupName = txtpackage.Text;
            BillingName = txtpackage.Text;
            //GroupCode = txtAbbreviation.Text.Trim() == "" ? string.Empty : txtAbbreviation.Text.Trim();
            type = CodeSchemeType.Groups;
            int ddlCase = 2;
            int iDptId = 0;
            long lHeader = 0;
            InvestigationOrgMapping objGpMas = new InvestigationOrgMapping();
            List<InvGroupMaster> objGpMap = new List<InvGroupMaster>();
            long iInv = 0;
            string stradd = string.Empty;
            stradd = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_25 == null ? "Add" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_25;               
            if (Add.Text == stradd)
            {
                returnCode = ObjInv.SearchInvForMDMAddGrp(groupName, OrgID, "CHKGRP", GroupCode, out objGpMap);
            }
            if (objGpMap.Count > 0)
            {
                string strMSg = string.Empty;
                strMSg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20 == null ? "Group Name or CodeName already exists !!" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20;
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strMSg + "','" + Information + "');", true);
 
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('" + strMSg + "');", true);
            }
            else
            {
                objGpMas.InvestigationID = iInv;
                objGpMas.OrgID = OrgID;
                objGpMas.DeptID = 0;
                objGpMas.HeaderID = 0;
                objMap.Add(objGpMas);
                if (Add.Text == stradd)
                {
                    returnCode = ObjInv.SaveInvestigationGrpName(objMap, groupName,BillingName, iDptId, lHeader, ddlCase, type, OrgID, ModifiedBy, GroupCode, remarks, status, pkgcode, string.Empty, dtCodingSchemeMaster, CutOffTimeValue, CutOffTimeType,Gender,IsServiceTaxable,ScheduleType,true);
                    //ClientScript.RegisterStartupScript(this.GetType(), "key", "alert('Changes saved successfully.');");
                    if (returnCode >= 0)
                    {
                        string strMSg = string.Empty;
                        strMSg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_21 == null ? "Group Added Successfully!!! " : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_21;
                        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strMSg + "','" + Information + "');", true);
 
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Group Added Successfully!!! ');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('Changes saved successfully.');", true);
                    }
                    else
                    {
                        string strMSg = string.Empty;
                        strMSg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20 == null ? "GroupName or CodeName Already Exists !!! " : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20;
                        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strMSg + "','" + Information + "');", true);
 
                      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('GroupName or CodeName Already Exists !!! ');", true);
                    }
                }
                else
                {
                    returnCode = ObjInv.UpdateInvestigationGrpName(groupid, OrgID, groupName, remarks, status, ModifiedBy, dtCodingSchemeMaster);
                    if (returnCode >= 0)
                    {
                        string strMSg = string.Empty;
                        strMSg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_22 == null ? "Changes have been Updated successfully. " : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_22;
                        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strMSg + "','" + Information + "');", true);
 
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:alert('" + Update_Msg + "');", true);
                    }
                    else
                    {
                        string strMSg = string.Empty;
                        strMSg = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20 == null ? "GroupName or CodeName Already Exists !!! " : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_20;
                        string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + strMSg + "','" + Information + "');", true);
 
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('GroupName or CodeName Already Exists !!! ');", true);
                    }
                }

                loadgrid(e, currentPageNo, PageSize);
                fill();
                chklstGrp.Items.Clear();
                grouptab.ActiveTabIndex = 1;
            }
            txtpackage.Text = String.Empty;
            //Add.Text = "Add";
            foreach (GridViewRow GrdRow in grdInvCodingScheme.Rows)
            {
                (GrdRow.FindControl("txtCodingSchemeNameMaster") as TextBox).Text = string.Empty;
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Creating a New Group", ex);
        }
    }
    protected void OKButton_Click(object sender, EventArgs e)
    {
        mpe.Hide();
    }
    protected void grdInvCodingScheme_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdInvCodingScheme.PageIndex = e.NewPageIndex;
        }
        loadCodingSchemaName();

    }

    protected void grdInvCodingScheme_OnRowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[0].Visible = false;
            e.Row.Cells[1].Visible = false;
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton starbutton = (ImageButton)e.Row.FindControl("starbutton") as ImageButton;
            if (e.Row.RowIndex >= 1)
            {
                starbutton.Attributes.Add("style", "display:none");
            }
        }
    }
    private void loadCodingSchemaName()
    {
        try
        {
            long returnCode = -1;

            List<CodingSchemeMaster> CSM = new List<CodingSchemeMaster>();
            int InvID = 0;
            if (hdnGroupID.Value != "")
            {
                InvID = Convert.ToInt32(hdnGroupID.Value.ToString());
            }
            string PkgName = txtpackage.Text;
            string Type = "GRP";
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            returnCode = MasterBL.GetCodingSchemeName(OrgID, PkgName, Type, InvID, out CSM);
            grdInvCodingScheme.DataSource = CSM;
            grdInvCodingScheme.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadCodingSchemeName", ex);
        }
    }

    protected void loadgrid(EventArgs e, int currentPageNo, int PageSize)
    {
        long returnCode = -1;
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        string GrpName = txtSearchGrp.Text;
        //string packagecode = string.Empty;
        List<InvOrgGroup> lstGroups = new List<InvOrgGroup>();
        try
        {
            returnCode = invbl.SearchGroups(OrgID, GrpName, out lstGroups, PageSize, currentPageNo, out totalRows);
            if (lstGroups.Count > 0)
            {
                GrdFooter.Style.Add("display", "table-row");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                hdnTotalPage.Value = lblTotal.Text;
          
                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
            if (lstGroups.Count > 0)
            {
                grdGroups.Visible = true;
                grdGroups.DataSource = lstGroups;
                grdGroups.DataBind();
            }
            else
            {
                grdGroups.Visible = false;

            }
            hdnCurrent.Value = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("No Matching Records ", ex);
        }

    }

    protected void grdGroups_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "EditGroups")
            {
                Add.Text = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_23;
                Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
                hdnGroupID.Value = grdGroups.DataKeys[rowIndex]["OrgGroupID"] != null ? Convert.ToString(grdGroups.DataKeys[rowIndex]["OrgGroupID"]) : string.Empty;
                txtpackage.Text = grdGroups.DataKeys[rowIndex]["DisplayText"] != null ? (string)grdGroups.DataKeys[rowIndex]["DisplayText"] : string.Empty;
                txtpackage.Focus();
                loadCodingSchemaName();

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading InvestigationName", ex);
        }
    }
    protected void btnSearchGrp_Click(object sender, EventArgs e)
    {
        try
        {
            string GrpName = txtSearchGrp.Text;
            loadgrid(e, currentPageNo, PageSize);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Search Groupnames", ex);
        }
        //txtSearchGrp.Text = "";
    }
    protected void grdGroups_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdGroups.PageIndex = e.NewPageIndex;
        }
        loadgrid(e, currentPageNo, PageSize);
        
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadgrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadgrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = "";
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadgrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            loadgrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnGoes_Click(object sender, EventArgs e)
    {
       
        
        hdnCurrent.Value = "";
       // int PageGO = Convert.ToInt32(txtpageNo.Text.ToString());
       // currentPageNo = PageGO;

        loadgrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
        txtpageNo.Text = "";

      /*  if (PageGO >= 1)
        {
            loadgrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
           // if (PageGO > PageSize)
            if (PageGO > Convert.ToInt32(lblTotal.Text))
            {
                string pageno = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_0025 == null ? "Enter Correct Page Number" : Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_0025;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + pageno + "','" + Information + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Enter Correct Page Number');", true);
            }
        }
        txtpageNo.Text = "";  */
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }

    public void LoadScheduleType()
    {
        string objddlScheduleType = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
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
                    ddlScheduleType.Items.Insert(0, new ListItem(objddlScheduleType, "0"));
                    //ddlScheduleType.Items.Insert(0, "--Select--");
                    ddlScheduleType.Items[0].Value = "-1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }

    public void LoadProtocalGroup()
    {
        string objddlProtocalGroup = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
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
                    ddlProtocalGroup.DataSource = childItems;
                    ddlProtocalGroup.DataTextField = "DisplayText";
                    ddlProtocalGroup.DataValueField = "Code";
                    ddlProtocalGroup.DataBind();
                    ddlProtocalGroup.Items.Insert(0, objddlProtocalGroup);
                    //ddlProtocalGroup.Items.Insert(0, "--Select--");
                    ddlProtocalGroup.Items[0].Value = "-1";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }
    protected void lnkCreateInvestigation_Click(object sender, EventArgs e)
    {
        // LinkButton lnk = (LinkButton)FindControl("lnkCreateInvestigation");
        // LinkButton lnk = (LinkButton)sender;
        // lnk.Attributes.Add("onclick", "javascript:ShowPopUp()");
    }
    #region function
    public void LoadInvLocationMapping()
    {
        string objitem = Resources.Admin_ClientDisplay.Admin_TestGroup_aspx_24;
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
            item.Text = objitem;
            //item.Text = "--Select--";
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

    #region Export Excel
    protected void ImageBtnExport_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            loaddgrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }
    }
    public void loaddgrid()
    {
        try
        {
            long returnCode = 0;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            string GrpName = txtSearchGrp.Text;
            ContextInfo.AdditionalInfo = "Y";
            List<InvOrgGroup> lstGroups = new List<InvOrgGroup>();
            //PrepareExcelSheet();
            returnCode = invbl.SearchGroups(OrgID, GrpName, out lstGroups, PageSize, currentPageNo, out totalRows);
            if (lstGroups.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstGroups);
                grdGroups.DataSource = lstGroups;
                grdGroups.DataBind();
                ExportToExcel();
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    private void PrepareExcelSheet()
    {
        try
        {

            grdGroups.HeaderRow.Cells[grdGroups.Columns.Count - 1].Visible = false;
            for (int i = 0; i < grdGroups.Rows.Count; i++)
            {
                grdGroups.Rows[i].Cells[grdGroups.Columns.Count - 1].Visible = false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }


    }


    public void ExportToExcel()
    {
        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            string attachment = "attachment; filename=" + "TestGroup" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            PrepareExcelSheet();
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdGroups.AllowPaging = false;
            long returnCode = 0;
            Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
            string GrpName = txtSearchGrp.Text;
            ContextInfo.AdditionalInfo = "Y";
            List<InvOrgGroup> lstGroups = new List<InvOrgGroup>();
            //PrepareExcelSheet();
            returnCode = invbl.SearchGroups(OrgID, GrpName, out lstGroups, 10000, currentPageNo, out totalRows);
            grdGroups.DataSource = null;
            grdGroups.DataBind();
            if (lstGroups.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstGroups);
                grdGroups.DataSource = lstGroups;
                grdGroups.DataBind();
            }
            grdGroups.Visible = true;
            grdGroups.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    #endregion


}
