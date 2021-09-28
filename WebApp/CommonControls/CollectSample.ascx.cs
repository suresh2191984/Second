using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Web.Script.Serialization;

public partial class CommonControls_CollectSample : BaseControl
{
    public CommonControls_CollectSample()
        : base("CommonControls_CollectSample_ascx")
    {
    }

    List<InvestigationOrgMapping> lstInvestigationOrgMapping = new List<InvestigationOrgMapping>();
    List<InvestigationOrgMapping> lstInvestigationLocationMapping = new List<InvestigationOrgMapping>();
    List<InvSampleStatusmaster> lstInvSampleStatus;
    List<LabRefOrgAddress> lstOutsource;
    List<OrganizationAddress> lstLocation;
    Referrals_BL objReferralsBL;
    List<MetaData> childItems = new List<MetaData>();
    List<ShippingConditionMaster> lstShippingConditionMaster = new List<ShippingConditionMaster>();
    string strLstReason = string.Empty;
    List<NameValuePair> lstReason = new List<NameValuePair>();
    List<NameValuePair> lstNotGivenReason = new List<NameValuePair>();
    string IsNeedBarcodecount = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            long returnCode = -1;
            GateWay gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returnCode = gateWay.GetConfigDetails("NeedAutoAlicoteforOutSource", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                hdnBarcodeForExtraSample.Value = lstConfig[0].ConfigValue;
            }
            string AddSampleDropDownStatus = GetConfigValue("IsReceived/Collected", OrgID);
           // txtAddCollectedDate.Text = OrgDateTimeZone; 
            if (AddSampleDropDownStatus != "")
            {
                hdnAddSampleStatuschange.Value = AddSampleDropDownStatus;
            }
            else {
                hdnAddSampleStatuschange.Value = "N";
            }
			 string SampleStatusneedtoShow = GetConfigValue("SampleStatusneedtoShow", OrgID);
            hdnIsShowStatus.Value = SampleStatusneedtoShow;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading collect sample control", ex);
        }
    }
    protected void rptSamples_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            PatientInvSample oPatientInvSample = (PatientInvSample)e.Item.DataItem;
            HtmlSelect ddlStatus = (HtmlSelect)e.Item.FindControl("ddlStatus");
            HtmlSelect ddlLocation = (HtmlSelect)e.Item.FindControl("ddlLocation");
            HtmlSelect ddlOutsource = (HtmlSelect)e.Item.FindControl("ddlOutsource");
            HtmlSelect ddlReason = (HtmlSelect)e.Item.FindControl("ddlReason");
            HtmlInputHidden hdnInvestigationID = (HtmlInputHidden)e.Item.FindControl("hdnInvestigationID");
            HtmlInputHidden sampleCode = (HtmlInputHidden)e.Item.FindControl("hdnSampleCode");
            HtmlContainerControl divOutsource = (HtmlContainerControl)e.Item.FindControl("divOutsource");
            HtmlInputHidden hdnIsTimed = (HtmlInputHidden)e.Item.FindControl("hdnIsTimed");
            HtmlInputButton lnkShow = (HtmlInputButton)e.Item.FindControl("lnkShow");
            TextBox txtbarcode = (TextBox)e.Item.FindControl("txtBarcode");
            TextBox txtbarcodecount = (TextBox)e.Item.FindControl("TxtBarcodeCount");
            string barcodeEdit = GetConfigValue("barcodeEdit", OrgID);
            HtmlInputHidden hdnExtraSampleInvID = (HtmlInputHidden)e.Item.FindControl("hdnExtraSampleInvID");
            
            if (String.IsNullOrEmpty(barcodeEdit))
            {
                txtbarcode.Enabled = false;
                ddlLocation.Disabled = true;
            }
            else if (!String.IsNullOrEmpty(barcodeEdit) && barcodeEdit == "Y")
            {
                hdnBarCodeEdit.Value = barcodeEdit;
            }
            txtbarcode.Attributes.Add("onkeypress", "javascript:return validateSpecialCharacters(event)");
            // Check Barcode exists 
                    txtbarcode.Attributes.Add("onblur", "javascript:return IsBarcodeExist(" + OrgID + ",'" + txtbarcode.ClientID + "','N')");
            //End
            //txtbarcode.Enabled = false;
            //ddlLocation.Disabled = true;
            //changes by sudhakar for NotGiven Work 

            string SetNotGivenStatus ="Y";

            if (Request.QueryString["SetNG"] != null)
            {
                SetNotGivenStatus = Request.QueryString["SetNG"].ToString();
            }


            string InvDetail = hdnInvestigationID.Value;
            string[] InvID = InvDetail.Split('~');
            long InvestigationID = Convert.ToInt64(InvID[2]);
            long SampleCode = Convert.ToInt64(sampleCode.Value);
            string pType = string.Empty;
            pType = "INV";
            if (InvID[1] != null && InvID[1] != "")
            {
                if (InvID[1] == "GRP")
                {
                    InvestigationID = Convert.ToInt64(InvID[0]);
                    pType = "GRP";
                }
            }

            if (objReferralsBL == null)
            { objReferralsBL = new Referrals_BL(base.ContextInfo); }

            objReferralsBL.GetProcessingLocation(OrgID, ILocationID, InvestigationID,pType, out lstInvestigationOrgMapping, out lstInvestigationLocationMapping);
            long patienid = -1;
            if (Request.QueryString["pid"] != null)
            {
                Int64.TryParse(Request.QueryString["pid"], out patienid);
            }  
           
            //lnkShow.Attributes.Add("onclick", "javascript:ShowPopUp('" + patienid + "','" + OrgID + "','" + InvestigationID + "','" + txtbarcode.ClientID + "')");
           long result = -1;
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvSample> lstPatientInvSampleGrouped = new List<PatientInvSample>();
            Investigation_BL Inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
            result = Inv_BL.GetExtraSampleList(patienid, SampleCode, OrgID, out lstPatientInvSample);

            if (lstPatientInvSample.Count > 0)
            {
                lnkShow.Visible = true;
            }
            else
            {
                lnkShow.Visible = false;
            }
            lnkShow.Attributes.Add("onclick", "javascript:ShowPopUp('" + patienid + "','" + OrgID + "','" + SampleCode + "','" + txtbarcode.ClientID + "')");
            
            if (lstLocation != null && lstLocation.Count > 0)
            {
                ddlLocation.DataSource = lstLocation;//.FindAll(p => p.CenterTypeCode == "PCS");
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataBind();

                ddlLocation.Value = Convert.ToString(ILocationID);
                if (lstInvestigationOrgMapping.Count > 0)
                {
                    if (lstInvestigationOrgMapping[0].OutsourceProcessingAddressID != null)
                    {
                        ddlLocation.Value = Convert.ToString(lstInvestigationOrgMapping[0].OutsourceProcessingAddressID);
                    }
                }
            }
            if (!String.IsNullOrEmpty(hdnLstSampleStatus.Value))
            {
                ddlStatus.DataSource = lstInvSampleStatus;
                ddlStatus.DataTextField = "Displaytext";
                ddlStatus.DataValueField = "InvSampleStatusID";
                ddlStatus.DataBind();
                var s = lstInvSampleStatus.FindAll(p => p.IsDefault == "Y");
                if (s.Count > 0)
                {
                    if (s[0].ToString() != null || s[0].ToString() != "")
                    {
                        ddlStatus.Value = s[0].InvSampleStatusID.ToString();
                    }
                }

                HtmlContainerControl divReason = (HtmlContainerControl)e.Item.FindControl("divReason");
                ddlStatus.Attributes.Add("onchange", "onSampleStatusChange('" + divReason.ClientID + "','" + divOutsource.ClientID + "','" + ddlReason.ClientID + "','" + ddlOutsource.ClientID + "','" + ddlStatus.ClientID + "');");
            }
            if (lstInvestigationLocationMapping.Count > 0)
            {
                if (lstInvestigationLocationMapping[0].Type == 12)
                {
                    //ddlStatus.Value = "12";
                    divOutsource.Attributes.Add("style", "display:block");
                    if (lstOutsource != null && lstOutsource.Count > 0)
                    {
                        ddlOutsource.DataSource = lstOutsource;
                        ddlOutsource.DataTextField = "City";
                        ddlOutsource.DataValueField = "AddressID";
                        ddlOutsource.DataBind();

                        ddlOutsource.Value = Convert.ToString(lstInvestigationLocationMapping[0].OutsourceProcessingAddressID);
                        var s = lstInvSampleStatus.FindAll(p => p.InvSampleStatusID == 12);
                        if (s.Count > 0)
                        {
                            if (s[0].ToString() != null || s[0].ToString() != "")
                            {
                                ddlStatus.Value = s[0].InvSampleStatusID.ToString();
                            }
                        } 
                    }
                }
            }
            //changes by sudhakar for NotGiven Work 
            else if (hdnIsTimed.Value == "Y" && SetNotGivenStatus == "Y")
            {
                HtmlContainerControl divReason = (HtmlContainerControl)e.Item.FindControl("divReason");
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                strLstReason = hdnLstRejectReason.Value;
                lstReason = serializer.Deserialize<List<NameValuePair>>(strLstReason);
                lstNotGivenReason = lstReason.FindAll(P => P.ParentID == "6");

                ddlStatus.Value = "6";
                divReason.Style.Add("display", "block");
                ddlReason.DataSource = lstNotGivenReason;
                ddlReason.DataTextField = "Name";
                ddlReason.DataValueField = "Value";
                ddlReason.DataBind();
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "changefn", "onSampleStatusChange('" + divReason.ClientID + "','" + divOutsource.ClientID + "','" + ddlReason.ClientID + "','" + ddlOutsource.ClientID + "','" + ddlStatus.ClientID + "');", true);
            }
            else
            {
                if (ddlLocation.Value == Convert.ToString(ILocationID))
                {
                    string IsStatus = GetConfigValue("IsReceived/Collected", OrgID);
                    if (IsStatus != "Y")
                    {
                        ddlStatus.Value = "3";
                    }
                    else
                    {
                        ddlStatus.Value = "1";
                    }
                }
                else
                {
                    if (ddlStatus.Items.Contains(ddlStatus.Items.FindByValue("1")))
                    {
                        ddlStatus.Value = "1";
                    }
                    else
                    {
                        ddlStatus.Items.Insert(0, new ListItem("Collected", "1"));
                        ddlStatus.Value = "1";
                    }
                }
            }

            //TextBox txtCollectedDate = (TextBox)e.Item.FindControl("txtCollectedDate");
            //txtCollectedDate.Text = OrgDateTimeZone;
            //txtCollectedDate.ToolTip = "dd-MM-yyyy hh:mm:sstt";

            //Added By Jayaramanan.L
            string IsExternalBarcode = GetConfigValue("AllowExternalBarcode", OrgID);
            hdnIsExternalBarcode.Value = IsExternalBarcode; 
            HtmlTableCell tdExternalBarcode = (HtmlTableCell)e.Item.FindControl("tdExternalBarcode");

            HtmlTableCell tdBarcodeCount = (HtmlTableCell)e.Item.FindControl("tdBarcodeCount");
            if (IsExternalBarcode == "Y")
            {
                thlblExternalBarcode.Attributes.Add("style", "display:block");
                tdExternalBarcode.Attributes.Add("style", "display:block");
                thAddExternalBarcode.Attributes.Add("style", "display:block");
                tdAddExternalBarcode.Attributes.Add("style", "display:block");
            }
            else
            {
                thlblExternalBarcode.Attributes.Add("style", "display:none");
                tdExternalBarcode.Attributes.Add("style", "display:none");
                thAddExternalBarcode.Attributes.Add("style", "display:none");
                tdAddExternalBarcode.Attributes.Add("style", "display:none");
            }
            string IsNeedBarcodecount = GetConfigValue("BarcodePrintCollectSample", OrgID);
            hdnIsNeedBarcodeCount.Value = IsNeedBarcodecount;
            if (IsNeedBarcodecount == "Y")
            {
                tdAddBarcodeCount.Visible = true;
                thlblbarcodecount.Visible = true;
                thAddbarcodecount.Visible = true;
                tdBarcodeCount.Visible = true;

            }
            else
            {

                tdAddBarcodeCount.Visible = false;
                thlblbarcodecount.Visible = false;
                thAddbarcodecount.Visible = false;
                tdBarcodeCount.Visible = false;
            }
            HtmlInputButton btnPrintBarcode = (HtmlInputButton)e.Item.FindControl("btnPrintBarcode");
            HtmlTableCell tdBarcode = (HtmlTableCell)e.Item.FindControl("tdBarcode");
            if (IsBarcodeNeeded)
            {
                btnPrintBarcode.Visible = true;
                thBarcode.Visible = true;
                tdBarcode.Visible = true;
            }
            else
            {
                btnPrintBarcode.Visible = false;
               // btnPrintBarcode.Visible = true;
                thBarcode.Visible = true;
                tdBarcode.Visible = true;
            }
            HtmlInputHidden hdnIsAlicotedSample = (HtmlInputHidden)e.Item.FindControl("hdnIsAlicotedSample");
            HtmlInputHidden hdnIsOutsourcingSample = (HtmlInputHidden)e.Item.FindControl("hdnIsOutsourcingSample");
            if (hdnIsOutsourcingSample.Value == "Y" && hdnIsAlicotedSample.Value == "Y")
            {
                ddlStatus.Value = "7";
                ddlStatus.Disabled = true;
            }
            if (oPatientInvSample.ConsignmentNo == "N")
            {
                HtmlContainerControl divReason = (HtmlContainerControl)e.Item.FindControl("divReason");
                HtmlContainerControl trCollectSample = (HtmlContainerControl)e.Item.FindControl("trCollectSample");
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                strLstReason = hdnLstRejectReason.Value;
                lstReason = serializer.Deserialize<List<NameValuePair>>(strLstReason);
                lstNotGivenReason = lstReason.FindAll(P => P.ParentID == "6");

                ddlStatus.Value = "6";
                divReason.Style.Add("display", "block");
                ddlReason.DataSource = lstNotGivenReason;
                ddlReason.DataTextField = "Name";
                ddlReason.DataValueField = "Value";
                ddlReason.DataBind();
                var S = lstNotGivenReason.FindAll(p => p.Name == "ReflexTest");
                if (S.Count > 0)
                {
                    ddlReason.Value = S[0].Value;
                    trCollectSample.Disabled = true;
                }

            }
        }
    }

    private void LoadAddDropDownList(List<InvSampleMaster> lstInvSampleMaster, List<InvestigationSampleContainer> lstSampleContainer, List<InvSampleStatusmaster> lstInvSampleStatus, List<OrganizationAddress> lstLocation)
    {
        string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_02 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_CollectSample_ascx_02;
        try
        {

            ddlDynamicSampleContainer.DataSource = lstSampleContainer;
            ddlDynamicSampleContainer.DataTextField = "ContainerName";
            ddlDynamicSampleContainer.DataValueField = "SampleContainerID";
            ddlDynamicSampleContainer.DataBind();

            ddlDynamicSample.DataSource = lstInvSampleMaster;
            ddlDynamicSample.DataTextField = "SampleDesc";
            ddlDynamicSample.DataValueField = "SampleCode";
            ddlDynamicSample.DataBind();
		//ddlDynamicSample.Items.Insert(0, strSelect.Trim());
		//ddlDynamicSample.Items[0].Value = "0";

            ddlAddSampleName.DataSource = lstInvSampleMaster;
            ddlAddSampleName.DataTextField = "SampleDesc";
            ddlAddSampleName.DataValueField = "SampleCode";
            ddlAddSampleName.DataBind();
            ddlAddSampleName.Items.Insert(0, strSelect.Trim());
            ddlAddSampleName.Items[0].Value = "0";

            ddlAddAdditive.DataSource = lstSampleContainer;
            ddlAddAdditive.DataTextField = "ContainerName";
            ddlAddAdditive.DataValueField = "SampleContainerID";
            ddlAddAdditive.DataBind();
            ddlAddAdditive.Items.Insert(0, strSelect.Trim());
            ddlAddAdditive.Items[0].Value = "0";

            ddlAddStatus.DataSource = lstInvSampleStatus;
            ddlAddStatus.DataTextField = "Displaytext";
            ddlAddStatus.DataValueField = "InvSampleStatusID";
            ddlAddStatus.DataBind();
            var s = lstInvSampleStatus.FindAll(p => p.IsDefault == "Y");
            if (s.Count > 0)
            {
                if (s[0].ToString() != null || s[0].ToString() != "")
                {
                    ddlAddStatus.SelectedValue = s[0].InvSampleStatusID.ToString();
                }
            }

            ddlAddStatus.Attributes.Add("onchange", "onSampleStatusChange('" + divAddReason.ClientID + "','" + divAddOutsource.ClientID + "','" + ddlAddReason.ClientID + "','" + ddlAddOutsource.ClientID + "','" + ddlAddStatus.ClientID + "');");

            ddlAddLocation.DataSource = lstLocation;//.FindAll(p => p.CenterTypeCode == "PCS");
            ddlAddLocation.DataTextField = "Location";
            ddlAddLocation.DataValueField = "AddressID";
            ddlAddLocation.DataBind();
            if (ddlAddLocation.Items.Count > 0)
            {
                int itemIndex = ddlAddLocation.Items.IndexOf(ddlAddLocation.Items.FindByValue(ILocationID.ToString()));
                if (itemIndex >= 0)
                {
                    ddlAddLocation.SelectedIndex = itemIndex;
                }
            }

            ClinicalTrail_BL CT_BL = new ClinicalTrail_BL(base.ContextInfo);
            CT_BL.GetShippingCondition(OrgID, out lstShippingConditionMaster);
            if (lstShippingConditionMaster.Count > 0)
            {
                ddlAddShippingCondition.DataTextField = "ConditionDesc";
                ddlAddShippingCondition.DataValueField = "ShippingConditionID";
                ddlAddShippingCondition.DataSource = lstShippingConditionMaster;
                ddlAddShippingCondition.DataBind();

                JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
                lstNameValuePair = (from l in lstShippingConditionMaster
                                    select new NameValuePair { Name = l.ConditionDesc, Value = Convert.ToString(l.ShippingConditionID) }).ToList<NameValuePair>();
                hdnShippingCondition.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);
            }


            long returncode = -1;
            string domains = "SamplesUnits";
            string[] Tempdata = domains.Split(',');
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    childItems = (from child in lstmetadataOutput
                                  where child.Domain == "SamplesUnits"
                                  orderby child.MetaDataID ascending
                                  select child).ToList();
                    if (childItems.Count() > 0)
                    {
                        ddlAddvolumeUnits.DataSource = childItems;
                        ddlAddvolumeUnits.DataTextField = "DisplayText";
                        ddlAddvolumeUnits.DataValueField = "Code";
                        ddlAddvolumeUnits.DataBind();
                    }
                    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                    List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
                    lstNameValuePair = (from l in childItems
                                        select new NameValuePair { Name = l.DisplayText, Value = Convert.ToString(l.Code) }).ToList<NameValuePair>();
                    hdnvolumeUnits.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);
                }
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading dropdown values", ex);
        }
    }

    public void SetValues(List<InvSampleMaster> lstInvSampleMaster, List<InvestigationSampleContainer> lstSampleContainer, List<InvSampleStatusmaster> oInvSampleStatus, List<InvReasonMasters> oInvReasonMaster, List<OrganizationAddress> oLocation, List<LabRefOrgAddress> oOutsource, List<PatientInvestigation> lstPatientInvestigation)
    {
        try
        {
            LoadAddDropDownList(lstInvSampleMaster, lstSampleContainer, oInvSampleStatus, oLocation);
            dlInvName.DataSource = lstPatientInvestigation;
            dlInvName.DataBind();

            lstInvSampleStatus = oInvSampleStatus;
            lstLocation = oLocation;
            lstOutsource = oOutsource;
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
            lstNameValuePair = (from l in oInvSampleStatus
                                select new NameValuePair { Name = l.Displaytext, Value = Convert.ToString(l.InvSampleStatusID) }).ToList<NameValuePair>();
            hdnLstSampleStatus.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

            lstNameValuePair = new List<NameValuePair>();
            lstNameValuePair = (from l in oInvReasonMaster
                                select new NameValuePair { Name = l.ReasonDesc, Value = Convert.ToString(l.ReasonID), ParentID = Convert.ToString(l.StatusID) }).ToList<NameValuePair>();
            hdnLstRejectReason.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

            lstNameValuePair = new List<NameValuePair>();
            lstNameValuePair = (from l in oLocation
                                select new NameValuePair { Name = l.Location, Value = Convert.ToString(l.AddressID) }).ToList<NameValuePair>();
            hdnLstReceiveLoc.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);

            lstNameValuePair = new List<NameValuePair>();
            lstNameValuePair = (from l in oOutsource
                                select new NameValuePair { Name = l.City, Value = Convert.ToString(l.AddressID) }).ToList<NameValuePair>();
            hdnLstOutSourceLoc.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while storing dropdownvalues", ex);
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

    public void LoadCollectSampleList(List<PatientInvSample> lstPatInvSample, long DoFromVisitID)
    {
        try
        {
            long returnCode = -1;
            string IshistopathTest = "N";
            List<PatientInvSample> lsttempPatInvSample = new List<PatientInvSample>();
            List<PatientInvSample> lsttempPatInvSample1 = new List<PatientInvSample>();
            List<PatientInvSample> lsttempHistoPatInvSample = new List<PatientInvSample>();
            LabUtil objLabUtil = new LabUtil();
            lsttempPatInvSample = objLabUtil.GroupCollectSampleDetails(lstPatInvSample);
            GateWay gateWay = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            List<PatientInvSample> lsttempPatInvSample2 = new List<PatientInvSample>();

            lsttempPatInvSample2.AddRange(lsttempPatInvSample);

            lsttempPatInvSample2.RemoveAll(p => p.IsHistoPathSample == "Y");

            PatientInvSample objSample = null;
            PatientInvSample lstSample = null;
           
            if (lsttempPatInvSample.Count > 0)
            {
                foreach (var item in lsttempPatInvSample)
                {
                    if (item.IsHistoPathSample == "Y" && item.HistoPathSampleCount > 0)
                    {
                        for (int i = 0; i < item.HistoPathSampleCount; i++)
                        {
                            objSample = new PatientInvSample();
                            objSample.SampleCode = item.SampleCode;
                            objSample.SampleDesc = item.SampleDesc;
                            objSample.SampleContainerID = item.SampleContainerID;
                            objSample.SampleContainerName = item.SampleContainerName;
                            objSample.InvestigtionName = item.InvestigtionName;
                            objSample.BarcodeNumber = item.BarcodeNumber;
                            objSample.Reason = item.Reason;
                            objSample.InvestigationID = item.InvestigationID;
                            objSample.RecSampleLocID = item.RecSampleLocID;
                            objSample.IsOutsourcingSample = item.IsOutsourcingSample;
                            objSample.SampleID = item.SampleID;
                            objSample.IsTimed = item.IsTimed;
                            objSample.Type = item.Type;
                            objSample.AddExtraTube = item.AddExtraTube;
                            objSample.Suffix = item.Suffix;
                            objSample.VisitNumber = item.VisitNumber;
                            objSample.PatientVisitID = item.PatientVisitID;
                            objSample.IsHistoPathSample = item.IsHistoPathSample;
                            lsttempHistoPatInvSample.Add(objSample);
                        }

                    }

                }
            }

            if (lsttempPatInvSample2.Count > 0 && lsttempHistoPatInvSample.Count >0)
            {
                foreach (var item in lsttempPatInvSample2)
                {
                    lstSample = new PatientInvSample();
                            lstSample.SampleCode = item.SampleCode;
                            lstSample.SampleDesc = item.SampleDesc;
                            lstSample.SampleContainerID = item.SampleContainerID;
                            lstSample.SampleContainerName = item.SampleContainerName;
                            lstSample.InvestigtionName = item.InvestigtionName;
                            lstSample.BarcodeNumber = item.BarcodeNumber;
                            lstSample.Reason = item.Reason;
                            lstSample.InvestigationID = item.InvestigationID;
                            lstSample.RecSampleLocID = item.RecSampleLocID;
                            lstSample.IsOutsourcingSample = item.IsOutsourcingSample;
                            lstSample.SampleID = item.SampleID;
                            lstSample.IsTimed = item.IsTimed;
                            lstSample.Type = item.Type;
                            lstSample.AddExtraTube = item.AddExtraTube;
                            lstSample.Suffix = item.Suffix;
                            lstSample.VisitNumber = item.VisitNumber;
                            lstSample.PatientVisitID = item.PatientVisitID;
                            lsttempHistoPatInvSample.Add(lstSample);                     

                   

                }
            }


            if (lsttempHistoPatInvSample.Count <= 0)
            {

                returnCode = gateWay.GetConfigDetails("NeedAutoAlicoteforOutSource", OrgID, out lstConfig);
                if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                {
                    lsttempPatInvSample1 = objLabUtil.GetAutoAlicotedSampleForOutSourcing(lsttempPatInvSample);
                }

                else
                {
                    lsttempPatInvSample1 = lsttempPatInvSample;
                }

            }
            else
            {

                lsttempPatInvSample1 = lsttempHistoPatInvSample;
            }
            


            //hdnLabNoBarcode.Value = lsttempPatInvSample1[0].BarcodeNumber.Remove(9, 2);
            returnCode = gateWay.GetConfigDetails("PrintSampleBarcode", OrgID, out lstConfig);
            long RefID = -1; string RefType = "";
            long PatientVisitID = -1;
            if (DoFromVisitID != -1 || DoFromVisitID != 0)
            {
                PatientVisitID = DoFromVisitID;
            }
            else
            {
                PatientVisitID = -1;
            }
            if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
            {
                int SampleCode = -1;
                int sampleContainerID = -1;
                string type = string.Empty;
                string UID = string.Empty;
                if (lsttempPatInvSample1.Count > 0)
                {
                    string BarcodeNo = "0";
                    string MLNumber ="0";
                      
                    Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
                    foreach (PatientInvSample Pinv in lsttempPatInvSample1)
                    {
					 if (Pinv.IsMLNumber != "Y")
                     {
                        if (PatientVisitID == -1 || PatientVisitID == 0)
                        {
                            if (Pinv.LocationType == "EPC")
                            {
                                if (hdnSampleForLocation.Value != Pinv.SampleCode.ToString() || hdnContainerForLocation.Value != Pinv.SampleContainerID.ToString())
                                {
                                    returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                                    hdnSampleForLocation.Value = Pinv.SampleCode.ToString();
                                    hdnContainerForLocation.Value = Pinv.SampleContainerID.ToString();
                                }
                                string barcodeSufix = string.IsNullOrEmpty(Pinv.Suffix) == false ? Pinv.Suffix : "";
                                string barcodeempty = GetConfigValue("IsEmptyBarcode", OrgID);
                                if (barcodeempty == "Y")
                                {
                                    hdnIsEmptyBarcode.Value = barcodeempty;
                                    Pinv.BarcodeNumber = string.Empty;
                                }
                                else
                                {
                                    Pinv.BarcodeNumber = BarcodeNo + barcodeSufix;
                                }
                            }
                            else
                            {
                                RefID = lsttempPatInvSample[0].PatientVisitID;
                                string AllowExternalBarcode = GetConfigValue("AllowExternalBarcode", OrgID);
                                string ShowExternalBarcodeInsteadofBarcode = GetConfigValue("ShowExternalBarcodeInsteadofBarcode", OrgID);
                                if (AllowExternalBarcode == "Y" && ShowExternalBarcodeInsteadofBarcode == "Y" && Pinv.ExternalBarcode != "" && Pinv.ExternalBarcode != null)
                                {
                                    BarcodeNo = "" ; //Pinv.ExternalBarcode;
                                    Pinv.BarcodeNumber = ""; //Pinv.ExternalBarcode;
                                }
                                else 
                                {
                                    returnCode = InvestigationBL.GetNextBarcode(OrgID, ILocationID, "BCODE", out BarcodeNo, RefID, RefType);
                                }
                                string barcodeSufix = string.IsNullOrEmpty(Pinv.Suffix) == false ? Pinv.Suffix : "";
                                string barcodesuffix = GetConfigValue("Add_Suffix_Barcode", OrgID);
                                string barcodeempty = GetConfigValue("IsEmptyBarcode", OrgID);
                                string LabNoBasedBarcode = GetConfigValue("LabNoBasedBarcode", OrgID);
                                if (LabNoBasedBarcode == "Y")
                                {
                                    Pinv.BarcodeNumber = Pinv.BarcodeNumber;
                                }
                                
                                else if (barcodeempty == "Y")
                                {
                                    hdnIsEmptyBarcode.Value = barcodeempty;
                                    Pinv.BarcodeNumber = string.Empty;
                                }
                                
                                else if(barcodesuffix=="Y")
                                {
                                 Pinv.BarcodeNumber =  barcodeSufix +  BarcodeNo ;
                                }
                                else
								{
								Pinv.BarcodeNumber = BarcodeNo + barcodeSufix;
								}
                               					  						  						  						  						  						  
                            }
                            //Pinv.BarcodeNumber = BarcodeNo;
                        }
                        else if (PatientVisitID != -1 || PatientVisitID != 0)
                        {
                            SampleCode = Pinv.SampleCode;
                            long OrganizationID = Convert.ToInt64(OrgID);
                            sampleContainerID = Pinv.SampleContainerID;
                            returnCode = InvestigationBL.GetBarcodeNumForDoFromVisit(OrganizationID, DoFromVisitID, out BarcodeNo, SampleCode, UID, type, sampleContainerID);
                            Pinv.BarcodeNumber = BarcodeNo;
                        }
					  }

                        else
                        {
                            string[] InvID = Pinv.InvestigationID.Split('~');
                            if (InvID.Count() > 0)
                            {
                                Int64.TryParse(InvID[0], out RefID);
                                RefType = InvID[1];
                            }
                            returnCode = InvestigationBL.GetNextMLNumber(OrgID, ILocationID, "MLNO", out MLNumber, RefID, RefType);
                            string barcodeSufix = string.IsNullOrEmpty(Pinv.Suffix) == false ? Pinv.Suffix : "";
                            Pinv.BarcodeNumber = MLNumber + barcodeSufix;
                        }

                        
                    }
                    PatientVisitID = -1;
                }
            }
			 else
            {
                 string Barcode_Alphabets = GetConfigValue("Barcode_Alphabets", OrgID);
               if (Barcode_Alphabets == "Y")
               {
                string visitNumber = string.Empty;
                int barcodecount = 1;
                foreach (PatientInvSample Pinv in lsttempPatInvSample1)
                {
                    switch (barcodecount)
                    {
                        case 1:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "A"));
                            break;
                        case 2:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "B"));
                            break;
                        case 3:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "C"));
                            break;
                        case 4:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "D"));
                            break;
                        case 5:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "E"));
                            break;
                        case 6:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "F"));
                            break;
                        case 7:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "G"));
                            break;
                        case 8:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "H"));
                            break;
                        case 9:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "I"));
                            break;
                        case 10:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "J"));
                            break;
                        case 11:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "K"));
                            break;
                        case 12:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "L"));
                            break;
                        case 13:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "M"));
                            break;
                        case 14:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "N"));
                            break;
                        case 15:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "O"));
                            break;
                        case 16:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "P"));
                            break;
                        case 17:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "Q"));
                            break;
                        case 18:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "R"));
                            break;
                        case 19:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "S"));
                            break;
                        case 20:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "T"));
                            break;
                        case 21:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "U"));
                            break;
                        case 22:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "V"));
                            break;
                        case 23:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "W"));
                            break;
                        case 24:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "X"));
                            break;
                        case 25:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "Y"));
                            break;
                        case 26:
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber + "Z"));
                            break;

                        default :
                            Console.WriteLine(Pinv.BarcodeNumber = (Pinv.VisitNumber));
                            break;

                    }
                    barcodecount++;
                }
              }
            }
            hdnSampleForLocation.Value = "N";
            hdnContainerForLocation.Value = "N";
            rptSamples.DataSource = lsttempPatInvSample1;
            rptSamples.DataBind();
            pnlSamples.Attributes.Add("style", "display:block;");
            LabUtil objLabUtil1 = new LabUtil();
            rptChildSamples.DataSource = lsttempPatInvSample1;
            rptChildSamples.DataBind();
            // pnlChildSamples.Attributes.Add("style", "display:block;"); 
            if (lsttempPatInvSample1 != null && lsttempPatInvSample1.Count > 0)
            {
                List<InvestigationSampleContainer> lstContainerCount = (from ord in lsttempPatInvSample1
                                                                        where !String.IsNullOrEmpty(ord.SampleContainerName)
                                                                        group ord by ord.SampleContainerID into g
                                                                        select new InvestigationSampleContainer
                                                                        {
                                                                            SampleContainerID = g.Key,
                                                                            ContainerName = g.Select(n => n.SampleContainerName).First(),
                                                                            ContainerCount = g.Count()
                                                                        }).ToList();
                if (lstContainerCount != null && lstContainerCount.Count > 0)
                {
                    JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                    hdnContainerCount.Value = oJavaScriptSerializer.Serialize(lstContainerCount);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while excecuting investigation sample page", ex);
            throw ex;
        }
    }

    public bool IsBarcodeNeeded
    {
        get
        {
            return Convert.ToBoolean(hdnIsBarcodeNeeded.Value);
        }
        set
        {
            hdnIsBarcodeNeeded.Value = Convert.ToString(value);
            if (value)
            {
                thAddBarcode.Visible = true;
                tdAddBarcode.Visible = true;
                thBarcode.Visible = true;
            }
            else
            {
                thAddBarcode.Visible = true;
                tdAddBarcode.Visible = true;
                thBarcode.Visible = true;
            }
        }
    }

    public bool IsSRSNeeded
    {
        get
        {
            return Convert.ToBoolean(hdnIsSrsNeeded.Value);
        }
        set
        {
            hdnIsSrsNeeded.Value = Convert.ToString(value);
            if (value)
            {
                thAddBarcode.Visible = true;
                tdAddBarcode.Visible = true;
                thBarcode.Visible = true;
            }
            else
            {
                thAddBarcode.Visible = true;
                tdAddBarcode.Visible = true;
                thBarcode.Visible = true;
            }
        }
    }

    protected void rptChildSamples_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        PatientInvSample oPatientInvSample = (PatientInvSample)e.Item.DataItem;
        HtmlInputHidden hdnInvestigationID = (HtmlInputHidden)e.Item.FindControl("hdnInvestigationID");
        string InvDetail = hdnInvestigationID.Value;
        string[] InvID = InvDetail.Split('~');
        //long InvestigationID = Convert.ToInt64(InvID[0]);

        //if (objReferralsBL == null)
        //{ objReferralsBL = new Referrals_BL(base.ContextInfo); }

        //objReferralsBL.GetProcessingLocation(OrgID, ILocationID, InvestigationID, out lstInvestigationOrgMapping, out lstInvestigationLocationMapping);

        HtmlSelect ddlShippingCondition = (HtmlSelect)e.Item.FindControl("ddlShippingCondition");
        HtmlSelect ddlvolumeUnits = (HtmlSelect)e.Item.FindControl("ddlvolumeUnits");
        TextBox txtVolume = (TextBox)e.Item.FindControl("txtVolume");


        if (lstShippingConditionMaster.Count > 0)
        {
            ddlShippingCondition.DataTextField = "ConditionDesc";
            ddlShippingCondition.DataValueField = "ShippingConditionID";
            ddlShippingCondition.DataSource = lstShippingConditionMaster;
            ddlShippingCondition.DataBind();
        }

        txtVolume.Text = Convert.ToString(oPatientInvSample.VmValue);


        if (childItems.Count() > 0)
        {
            ddlvolumeUnits.DataSource = childItems;
            ddlvolumeUnits.DataTextField = "DisplayText";
            ddlvolumeUnits.DataValueField = "Code";
            ddlvolumeUnits.DataBind();
        }

        ddlvolumeUnits.SelectedIndex = oPatientInvSample.VmUnitID;
        ddlShippingCondition.SelectedIndex = oPatientInvSample.SampleConditionID;

    }
    public void ExtractInvestigations(long vid, string gUID)
    {
        long returnCode = -1;
        int pOrderedCount = -1;
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
        List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
        List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
        List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
        List<InvDeptMaster> deptList = new List<InvDeptMaster>();
        List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
        List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
        invbl.GetInvestigationSamplesCollect(vid, OrgID, RoleID, gUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

        foreach (PatientInvestigation patient in lstPatientInvestigation)
        {

            PatientInvestigation objInvest = new PatientInvestigation();
            objInvest.InvestigationID = patient.InvestigationID;
            objInvest.InvestigationName = patient.InvestigationName;
            objInvest.PatientVisitID = patient.PatientVisitID;
            objInvest.GroupID = patient.GroupID;
            objInvest.GroupName = patient.GroupName;
            objInvest.Status = patient.Status;
            objInvest.CollectedDateTime = patient.CreatedAt;
            objInvest.CreatedBy = LID;
            objInvest.Type = patient.Type;
            objInvest.OrgID = OrgID;
            objInvest.InvestigationMethodID = 0;
            objInvest.KitID = 0;
            objInvest.InstrumentID = 0;
            objInvest.UID = patient.UID;
            objInvest.PackageID = patient.PackageID;
            objInvest.PackageName = patient.PackageName;
            SaveInvestigation.Add(objInvest);
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
            returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(SaveInvestigation, OrgID, gUID, out pOrderedCount);
        }
    }

    public void ResetData()
    {
        try
        {
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
            List<InvSampleStatusmaster> oInvSampleStatus = new List<InvSampleStatusmaster>();
            List<InvReasonMasters> oInvReasonMaster = new List<InvReasonMasters>();
            List<OrganizationAddress> oLocation = new List<OrganizationAddress>();
            List<LabRefOrgAddress> oOutsource = new List<LabRefOrgAddress>();
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            SetValues(lstInvSampleMaster, lstSampleContainer, oInvSampleStatus, oInvReasonMaster, oLocation, oOutsource, lstPatientInvestigation);

            List<InvSampleStatusmaster> lstInvSampleStatus = new List<InvSampleStatusmaster>();
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            LoadAddDropDownList(lstInvSampleMaster, lstSampleContainer, lstInvSampleStatus, lstLocation);

            List<PatientInvSample> lstPatInvSample = new List<PatientInvSample>();
            long DoFromVisitID = 0;
            LoadCollectSampleList(lstPatInvSample, DoFromVisitID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while resetting collect sample control", ex);
        }
    }
}
