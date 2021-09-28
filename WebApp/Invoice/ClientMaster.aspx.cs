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
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
using Attune.Podium.PerformingNextAction;
using System.Web.Script.Serialization;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;
using System.Globalization;

public partial class Lab_InvocieMaster : BasePage
{
    public string Save_Message = Resources.AppMessages.Save_Message;
    public string Update_Message = Resources.AppMessages.Update_Message;
    public string ErrorMessage_Save = Resources.AppMessages.Errormessage_Add;
    public string ErrorMessage_Update = Resources.AppMessages.Errormessage_Update;

    public string UpdateButton = Resources.ClientSideDisplayTexts.Invoice_ClientMaster_aspx_cs_UpdateButton;
    string select = Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_006 == null ? "--Select--" : Resources.Invoice_ClientDisplay.Invoice_InvoiceTracker_aspx_006;
    public Lab_InvocieMaster()
        : base("Lab_InvocieMaster_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    Master_BL masterbl;
    Role_BL roleBL;
    List<Role> role = new List<Role>();
    List<ClientDetails> lstClientDetails;
    List<ClientDetails> lstClientDetails1;
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    List<ReasonMaster> lstReasonMaster;
    Master_BL objReasonMaster;
    string Reftypes = "CM";

    //For Client Logo Newly Added Lines//
    string IsLogoNeeded = string.Empty;
    //For Client Logo Newly Added Lines//
    protected void Page_Load(object sender, EventArgs e)
    {

        LoadMeatData();
        //Added By Arivalagan.kk/For  recall to show the datepicker/
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ShowDate", "TempDate();", true);
        masterbl = new Master_BL(base.ContextInfo);
        roleBL = new Role_BL(base.ContextInfo);

        //View access of Client master to all with role authority
        string val=Request.QueryString["view"];
        if (val=="y")
        {
            //NO access for client customercare 
            btnFinish.Style.Add("display", "none");
            btnCancel.Style.Add("display", "none");
           
        }
        else 
        {       
            //Access for credit controller
            btnFinish.Style.Add("display", "black");
            btnCancel.Style.Add("display", "black");
        }
        
        if (!IsPostBack)
        {
            GetPrintLocation();

            string CTORG = "N";
            IsCtParentOrg();
            hdnclientnames.Value = "";
            GetGroupValues();
            LoadMetaData();
            LoadReason();
            LoadRole();
            ddlAuthorizedBy.SelectedIndex = 0;
            ddlClientStatus.SelectedIndex = 0;
            GetAddressType();
            //GetDespatchmodes();
            LoadCountry();
            GetClientType();
            Load_ddlTaxDetails();
            loadReasonDetails();
            //GetClientDetails();
            //Added By Gurunath
            LoadClientStatus();
            DisplayTab();
            //--Code End
            int ClientTypeID = 0;
            int CustomerTypeID = 0;
            AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + ClientTypeID.ToString() + "~" + CustomerTypeID.ToString();
            hdnOrgID.Value = OrgID.ToString();
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");
            GetPaymentType();
            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";
            fckInvDetailss.BasePath = sPath;
            fckInvDetailss.ToolbarSet = "Basic";
            fckInvDetailss.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckInvDetailss.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

            //VEL
            string DisplayMRPAmount = GetConfigValue("IsMRPAmountDisplay", OrgID);
            DisplayMRPAmount = string.IsNullOrEmpty(DisplayMRPAmount) ? "N" : DisplayMRPAmount;
            if (DisplayMRPAmount == "Y")
            {
                pnlbilltype.Visible = true;
            }

            string LanguageBasedReport = GetConfigValue("LanguageBasedReport", OrgID);
            if (LanguageBasedReport != "Y")
            {
                pnlrepang.Style.Add("display", "none");
            }
            else
            {
                pnlrepang.Style.Add("display", "block");
            }
            //VEL
        }
        lnkviewtestdetails.Visible = false;
        //AutoCompleteExtender12.ContextKey = "route";
        //AutoCompleteExtender2.ContextKey = "zone";
        AutoCompleteExtender5.ContextKey = "Hub";
        AutoCompleteExtender7.ContextKey = "TOD";
        AutoCompleteExtender13.ContextKey = "TOV";
        AutoCompleteExtender8.ContextKey = "TAX";
        AutoCompleteExtender9.ContextKey = "-1";
        AutoCompleteExtender10.ContextKey = "-2";
        AutoCompleteExtender11.ContextKey = "DCP";
        pnlClientStatus.Style.Add("display", "none");
        alert.Style.Add("display", "none");
        //AB Code
        lblmiaxAdvance.Visible = false;
        txtmaxAdvance.Visible = false;
        txtminAdvance.Text = "0.00";
        
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Hide Address div", "showResponses('Div1','Div2','divLocation',0);", true);
        IsLogoNeeded = GetConfigValue("NeedClientLogo", OrgID);
        if (IsLogoNeeded == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "CallMyMethod", "GetClientLogoUpload();", true);
        }
        string isGST = GetConfigValue("GSTTAX", OrgID);
        if(isGST=="Y")
        {
            lblCstno.Text = "GST No";
        }
    }
    public void LoadMeatData()
    {
        try
        {
            
            long returncode = -1;
            string domains = "RemoteType,ThresholdType,VirtualType";
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


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var CustomPeriodRange = from child in lstmetadataOutput
                                        where child.Domain == "RemoteType"
                                        select child;
                //if (CustomPeriodRange.Count() > 0)
                //{
                //    RdoClientRmtAccess.DataSource = CustomPeriodRange;
                //    RdoClientRmtAccess.DataTextField = "DisplayText";
                //    RdoClientRmtAccess.DataValueField = "Code";
                //    RdoClientRmtAccess.DataBind();
                //    RdoClientRmtAccess.SelectedValue = "0";
                   
                var ThresholdType = from child in lstmetadataOutput
                                        where child.Domain == "ThresholdType"
                                        select child;
                if (ThresholdType.Count() > 0)
                {
                    rdThreadsHold1.DataSource = ThresholdType;
                    rdThreadsHold1.DataTextField = "DisplayText";
                    rdThreadsHold1.DataValueField = "Code";
                    rdThreadsHold1.DataBind();
                    rdThreadsHold1.SelectedValue = "1";

                }
                var VirtualType = from child in lstmetadataOutput
                                        where child.Domain == "VirtualType"
                                        select child;
                if (VirtualType.Count() > 0)
                {
                    rdVirtualCredit1.DataSource = VirtualType;
                    rdVirtualCredit1.DataTextField = "DisplayText";
                    rdVirtualCredit1.DataValueField = "DisplayText";
                    rdVirtualCredit1.DataBind();
                    rdVirtualCredit1.SelectedValue = "Virtual_Credit_% ";

                }
             
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading  Type", ex);
        }
    }
    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
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
            ddlReason.DataSource = lstReasonMaster;
            ddlReason.DataTextField = "Reason";
            ddlReason.DataValueField = "Reason";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, select);
            ddlReason.Items[0].Value = "0";
            ddlReason.SelectedValue = setID;
        }
        else {
            ddlReason.Items.Insert(0,"ClientMaster Details");
            ddlReason.Items[0].Value = "1";
        
        }
    }
    public void GetGroupValues()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstclientattrib.Count > 0)
            {
                chkClientAttributes.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Commercial");
                chkClientAttributes.DataTextField = "AttributeName";
                chkClientAttributes.DataValueField = "AttributeID";
                chkClientAttributes.DataBind();

                chkNotification.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Notify");
                chkNotification.DataTextField = "AttributeName";
                chkNotification.DataValueField = "AttributeID";
                chkNotification.DataBind();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "ReportPrintChanged();",true);

                chklstReport.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Report");
                chklstReport.DataTextField = "AttributeName";
                chklstReport.DataValueField = "AttributeID";
                chklstReport.DataBind();

                chklstIdentity.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Identity");
                chklstIdentity.DataTextField = "AttributeName";
                chklstIdentity.DataValueField = "AttributeID";
                chklstIdentity.DataBind();

                chklstIsSponsor.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Sponsor");
                chklstIsSponsor.DataTextField = "AttributeName";
                chklstIsSponsor.DataValueField = "AttributeID";
                chklstIsSponsor.DataBind();

                ddlStationery.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Stationery");
                ddlStationery.DataTextField = "AttributeName";
                ddlStationery.DataValueField = "AttributeID";
                ddlStationery.DataBind();
                ddlStationery.Items.Insert(0, select);
                ddlStationery.Items[0].Value = "0";

                ddlbilltype.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "BillType");
                ddlbilltype.DataTextField = "AttributeName";
                ddlbilltype.DataValueField = "AttributeID";
                ddlbilltype.DataBind();
                ddlbilltype.Items.Insert(0, select);
                ddlbilltype.Items[0].Value = "0";

                JavaScriptSerializer Objserializer = new JavaScriptSerializer();
                hdnlstStationery.Value = Objserializer.Serialize(lstclientattrib.FindAll(p => p.AttributesType == "Stationery"));

                //VEL
                JavaScriptSerializer ObjserializerBillType = new JavaScriptSerializer();
                hdnlstBillType.Value = ObjserializerBillType.Serialize(lstclientattrib.FindAll(p => p.AttributesType == "BillType"));
                //VEL
            }
            if (lstmetavalue.Count > 0)
            {
                string setID = "0";
                lstmetavalue.RemoveAll(p => p.Code != "BT");
                string getCTOrg = "";
                getCTOrg = GetConfigValue("CTORG", OrgID);
                if (getCTOrg == "Y")
                {
                    if (lstmetavalue.Exists(p => p.Value == "CLINICALTRIAL"))
                    {
                        setID = lstmetavalue.Find(p => p.Value == "CLINICALTRIAL").MetaValueID.ToString();
                    }
                }
                drpBusinessType.DataSource = lstmetavalue;
                drpBusinessType.DataTextField = "Value";
                drpBusinessType.DataValueField = "MetaValueID";
                drpBusinessType.DataBind();
                drpBusinessType.Items.Insert(0, select);
                drpBusinessType.Items[0].Value = "0";
                drpBusinessType.SelectedValue = setID;
            }
            if (lstactiontype.Count > 0)
            {
                var Client = lstactiontype.FindAll(p => p.Type == "Client");
                chkDespatch.DataSource = Client;
                chkDespatch.DataTextField = "ActionType";
                chkDespatch.DataValueField = "ActionTypeID";
                chkDespatch.DataBind();
            }
            if (lstrptmaster.Count > 0)
            {
                drpreportformat.DataSource = lstrptmaster;
                drpreportformat.DataTextField = "ReportTemplateName";
                drpreportformat.DataValueField = "TemplateID";
                drpreportformat.DataBind();
                drpreportformat.Items.Insert(0, select);
                drpreportformat.Items[0].Value = "0";
            }
            else
            {
                drpreportformat.Items.Insert(0, select);
                drpreportformat.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }

    private void LoadRole()
    {
        long returnCode = -1;
        int pOrgID = OrgID;
        string GetRoleID = "0";
        returnCode = roleBL.GetRoleName(pOrgID, out role);
        if (role.Count() > 0)
        {
            var filteredRole = role.Where(name => name.RoleName == RoleHelper.SrCreditControler).ToList();

            if (role.Exists(p => p.RoleName == RoleHelper.SrCreditControler))
            {


                GetRoleID = role.Find(p => p.RoleName == RoleHelper.SrCreditControler).RoleID.ToString();
            }
            ddlRole.DataSource = filteredRole;
            ddlRole.DataTextField = "RoleName";
            ddlRole.DataValueField = "RoleID";
            ddlRole.DataBind();
            ddlRole.Items.Insert(0, select);
            ddlRole.Items[0].Value = "0";
            ddlRole.SelectedValue = GetRoleID;

            ddlAuthorizedBy.DataSource = role;
            ddlAuthorizedBy.DataTextField = "IntegrationName";
            ddlAuthorizedBy.DataValueField = "RoleID";
            ddlAuthorizedBy.DataBind();
            ddlAuthorizedBy.Items.Insert(0, select);
            ddlAuthorizedBy.Items[0].Value = "0";
            ddlAuthorizedBy.SelectedValue = GetRoleID;
            ViewState.Add("SetRoleID", GetRoleID);
        }
    }

    public void GetAddressType()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<AddressType> lstAddressType = new List<AddressType>();
            returnCode = obj.GetAddressType(out lstAddressType);
            if (lstAddressType.Count > 0)
            {
                drpaddresstype.DataSource = lstAddressType;
                drpaddresstype.DataValueField = "TypeID";
                drpaddresstype.DataTextField = "TypeName";
                drpaddresstype.DataBind();
                drpaddresstype.Items.Insert(0, select);
                drpaddresstype.Items[0].Value = "0";
                //hdnAddressTypeID.Value = lstAddressType.Find(p => p.TypeName == "Person").TypeID.ToString();
            }

            //Added By Gururnat S 
            List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
            returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
            string AddNewDepartment = string.Empty;
            if (!String.IsNullOrEmpty(ViewState["AddDepartment"].ToString()))
            {
                AddNewDepartment = ViewState["AddDepartment"].ToString();
            }
            if (lstEmpDeptMaster.Count > 0 || (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0))
            {
                if (!String.IsNullOrEmpty(AddNewDepartment) && AddNewDepartment.Length > 0)
                {
                    string[] Department = AddNewDepartment.Split('^');
                    for (int i = 0; i < Department.Length; i++)
                    {
                        if (!String.IsNullOrEmpty(Department[i]) && Department[i].Length > 0)
                        {
                            EmployerDeptMaster objEDM = new EmployerDeptMaster();
                            objEDM.EmpDeptName = Department[i].Split('~')[0];
                            objEDM.Code = Department[i].Split('~')[1];
                            lstEmpDeptMaster.Add(objEDM);
                        }
                    }
                }
                drplstPerson.DataSource = lstEmpDeptMaster;
                drplstPerson.DataValueField = "Code";
                drplstPerson.DataTextField = "EmpDeptName";
                drplstPerson.DataBind();
                drplstPerson.Items.Insert(0, select);
                drplstPerson.Items[0].Value = "0";
            }
            //---Code End---
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Despatch Mode", ex);
        }
    }
    public void Load_ddlTaxDetails()
    {
        ChkIsActive.Checked = true;
        long returnCode = -1;
        try
        {
            Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
            List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
            returnCode = objMaster_BL.LoadTaxDetails(OrgID, out lstTaxmaster);

            if (lstTaxmaster.Count > 0)
            {
                ddlTaxDetails.DataSource = lstTaxmaster;
                ddlTaxDetails.DataValueField = "TaxID";
                ddlTaxDetails.DataTextField = "TaxName";
                ddlTaxDetails.DataBind();
                ddlTaxDetails.Items.Insert(0, select);
                ddlTaxDetails.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to Load ddlTaxDetails", ex);
        }
    }
    public void GetPaymentType()
    {
        BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);
        List<PaymentType> lstPaymentType = new List<PaymentType>();
        long retval = -1;

        retval = objBillingEngine.GetPaymentType(OrgID, out lstPaymentType);
        if (lstPaymentType.Count > 0)
        {
            chkPaymentMode.DataSource = lstPaymentType;
            chkPaymentMode.DataTextField = "PaymentName";
            chkPaymentMode.DataValueField = "PaymentTypeID";
            chkPaymentMode.DataBind();
        }
        //ddlPaymentType.Items.Insert(0, new ListItem("-- Select --", "0"));
        //ddlPaymentType.SelectedValue = Convert.ToString(lstPaymentType.Find(p => p.IsDefault == "Y").PaymentTypeID);
    }

    public void GetClientType()
    {
        long returnCode = -1;
        try
        {
            Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
            List<InvClientType> lstInvClientType = new List<InvClientType>();
            returnCode = objPatient_BL.GetInvClientType(out lstInvClientType);
            hdnGetParentID.Value = "";
            foreach (InvClientType objInvClientType in lstInvClientType)
            {
                hdnGetParentID.Value += objInvClientType.ClientTypeID + "~" + objInvClientType.ClientTypeCode + "^";
            }
            if (GetConfigValue("CTPARENTORG", OrgID) == "Y")
            {
                lstInvClientType = lstInvClientType.FindAll(p => p.ClientTypeCode == "CRO");
            }
            else if (GetConfigValue("CTCHILDORG", OrgID) == "Y")
            {
                lstInvClientType = lstInvClientType.FindAll(p => p.ClientTypeCode != "CRO");
            }
            //lstInvClientType.RemoveAll(p => p.IsInternal == "N");
            if (lstInvClientType.Count > 0)
            {
                ddlClientType.DataSource = lstInvClientType;
                if (hdnIsCtParentOrg.Value == "Y")
                {
                    if (lstInvClientType.Exists(p => p.ClientTypeCode == "COP"))
                    {
                        hdnClientTypeID.Value = lstInvClientType.Find(p => p.ClientTypeCode == "COP").ClientTypeID.ToString();
                    }
                }

                ddlClientType.DataValueField = "ClientTypeID";
                ddlClientType.DataTextField = "ClientTypeName";
                ddlClientType.DataBind();
                ddlClientType.Items.Insert(0, select);
                ddlClientType.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
        }
    }
    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        drpCountry.Items.Clear();
        int countryID = 0;
        try
        {
            //lblCountryCode
            returnCode = countryBL.GetCountryList(out countries);
            drpCountry.DataSource = countries;
            drpCountry.DataTextField = "CountryName";
            drpCountry.DataValueField = "CountryID";
            drpCountry.DataBind();
            drpCountry.Items.Insert(0, select);
            #region Get the Country using isDefault
            selectedCountry = countries.Find(FindCountry);
            drpCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(drpCountry.SelectedItem.Value, out countryID);
            #endregion
            #region Set the Country by location's country
            if (CountryID > 0)
            {
                drpCountry.SelectedValue = CountryID.ToString();
                countryID = CountryID;
            }

            #endregion
            LoadState(countryID);
            var childItems = (from n in countries
                              where n.IsDefault == "Y"
                              select new { n.CountryID, n.ISDCode }).ToList();
            if (childItems.Count() > 0)
            {
                //hdnCountryID.Value = childItems[0].CountryID.ToString();
                string MobileNoCountryCode = GetConfigValue("MobileNoFormat", OrgID);
                if (!string.IsNullOrEmpty(MobileNoCountryCode) && MobileNoCountryCode.Length > 0)
                {
                    lblCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
                }
                else
                {
                    lblCountryCode.Text = "";
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }

    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        drpState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);

            foreach (State st in states)
            {
                drpState.Items.Add(new ListItem(st.StateName.ToUpper(), st.StateID.ToString()));
            }
            if (StateID > 0)
            {
                drpState.SelectedValue = StateID.ToString();
            }
            selectedState = states.Find(FindState);
            drpState.SelectedValue = selectedState.StateID.ToString();
            Int32.TryParse(drpState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    protected void ddState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drpState.SelectedIndex > 0)
        {
            ViewState["State"] = drpState.SelectedItem.Value.ToString();
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string Information = Resources.Invoice_AppMsg.Invoice_ClientMaster_aspx_58 == null ? "Information" : Resources.Invoice_AppMsg.Invoice_ClientMaster_aspx_58;
                    
        btnFinish.Enabled = false;
        List<ClientMaster> lstinvmaster = new List<ClientMaster>();
        List<AddressDetails> lstAddressDetails = new List<AddressDetails>();
        List<ClientAttributesDetails> lstclientattrib = new List<ClientAttributesDetails>();
        List<DespatchMode> lstDespatchmode = new List<DespatchMode>();
        List<ClientAttributesDetails> lstpaymode = new List<ClientAttributesDetails>();
        List<ClientTaxMaster> lstClientTaxMaster = new List<ClientTaxMaster>();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Hide Attributes", "showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0);", true);
        long NewClientID = -1;
        string CliID = "";
        string CLIName = "";
        string Reason = "";
        try
        {
            lblmsg.Text = "";
            long returnCode = -1;
            ClientMaster obj = new ClientMaster();
            obj.ClientCode = txtClientCode.Text.Trim().ToUpper();
            obj.ClientID = int.Parse(hdnId.Value);
            obj.ClientName = txtClientName.Text;
            //Commented By Guruanth S
            //obj.ContactPerson = txtContactPersons.Text; 
            obj.ServiceTaxNo = txtServiceTaxNo.Text;
            obj.PanNo = txtPanNo.Text;
            obj.ZonalID = Convert.ToInt64(hdntxtzoneID.Value);
            obj.PrintOrgAddressID = Convert.ToInt64(ddlPrintLocation.SelectedValue);
            obj.RouteID = Convert.ToInt64(hdntxtrouteID.Value);
            obj.CstNo = txtcstno.Text;
            obj.Attributes = CreateClientXML();
            obj.ClientStatus = "N";
            obj.ClientTypeID = Convert.ToInt32(ddlClientType.SelectedItem.Value);
            obj.ReportTemplateID = Convert.ToInt64(drpreportformat.SelectedItem.Value);
            obj.IsMappedItem = chkShowMappedItems.Checked ? "Y" : "N";
            obj.ApprovalRequired = chkisapproval.Checked ? "Y" : "N";
            obj.ISCash = Chkiscash.Checked ? "Y" : "N";
            obj.CreditLimit = txtcreditlimit.Text == "" ? 0 : Convert.ToDecimal(txtcreditlimit.Text);
            obj.CreditDays = txtCreditDays.Text == "" ? 0 : Convert.ToInt64(txtCreditDays.Text);
            obj.CustomerType = Convert.ToInt64(drpBusinessType.SelectedItem.Value);
            // obj.SalesManID = Convert.ToInt64(hdntxtsalesmancode.Value);
            obj.CollectionCenterID = Convert.ToInt64(hdncollectioncenterid.Value);
            obj.SapCode = txtsapcode.Text;
            obj.FilePath = Txtftppath.Text; //Alex
            //obj.SalesManName = txtsalesmancode.Text;
            //obj.Pathologist = txtpathlogist.Text;
            if (chkisparent.Checked == true)
            {
                obj.ParentClientID = Convert.ToInt64(hdnParentClientID.Value);
            }
            else
            {
                obj.ParentClientID = 0;
            }
            obj.InvoiceShowColumns = rblSearchType.SelectedIndex;
            obj.GraceLimit = txtgracelimit.Text == "" ? 0 : Convert.ToDecimal(txtgracelimit.Text);
            obj.GraceDays = txtgracedays.Text == "" ? 0 : Convert.ToInt64(txtgracedays.Text);

            obj.Termsconditions = fckInvDetailss.Value;
            //Added By Gurunath.S
            obj.HubID = hdnHubID.Value == "" ? 0 : Convert.ToInt32(hdnHubID.Value);
            obj.IsParentPayer = chkDebtor.Checked ? "Y" : "N";
            obj.Status = ddlClientStatus.SelectedValue.ToString();
            if (drpReason.SelectedValue == select)
                obj.Reason = "";
            else
                obj.Reason = drpReason.SelectedValue;
            obj.IsDiscount = chkDiscount.Checked ? "Y" : "N";
            obj.PromisedAmount = txtPromisedAmount.Text == "" ? 0 : Convert.ToDecimal(txtPromisedAmount.Text);
            DateTime TodateLoc;
            DateTime FrmdateLoc;
            if (obj.Status != "A")
            {
                if (Request.Form[txtFDate.UniqueID].Trim().ToString() != "")
                {
                    FrmdateLoc = DateTime.ParseExact(Request.Form[txtFDate.UniqueID].Trim().ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    obj.BlockFrom = Convert.ToDateTime(FrmdateLoc);
                }
                if (Request.Form[txtTDate.UniqueID].Trim().ToString() != "")
                {
                    TodateLoc = DateTime.ParseExact(Request.Form[txtTDate.UniqueID].Trim().ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                    obj.BlockTo = Convert.ToDateTime(TodateLoc);
                }
            }
            else
            {
                obj.BlockFrom = Convert.ToDateTime("01/01/1753");
                obj.BlockTo = Convert.ToDateTime("01/01/1753");
            }

            if (chkCreditLimit.Checked)
            {
                obj.ThresholdType = "CREDITAMOUNT";
                obj.ThresholdValue = String.IsNullOrEmpty(txtThreadshold.Text) ? 0 : Convert.ToDecimal(txtThreadshold.Text);
                obj.ThresholdValue2 = String.IsNullOrEmpty(txtThreadshold2.Text) ? 0 : Convert.ToDecimal(txtThreadshold2.Text);
                obj.ThresholdValue3 = String.IsNullOrEmpty(txtThreadshold3.Text) ? 0 : Convert.ToDecimal(txtThreadshold3.Text);
            }



            /*AB Code*/
            //AdvanceDeposite aDeposite = new AdvanceDeposite();
            if (IsAdvanceClient.Checked)
            {
                //obj.IsAdvanceClient = 1;
                obj.IsAdvanceClient = true;
                if (rdThreadsHold1.Items[0].Selected == true)
                {
                    obj.ThresholdType = "AMOUNT";
                    obj.ThresholdValue = String.IsNullOrEmpty(txtThreadshold.Text) ? 0 : Convert.ToDecimal(txtThreadshold.Text);
                    obj.ThresholdValue2 = String.IsNullOrEmpty(txtThreadshold2.Text) ? 0 : Convert.ToDecimal(txtThreadshold2.Text);
                    obj.ThresholdValue3 = String.IsNullOrEmpty(txtThreadshold3.Text) ? 0 : Convert.ToDecimal(txtThreadshold3.Text);

                }
                else
                {

                    obj.ThresholdType = "PERCENTAGE";
                    obj.ThresholdValue = Convert.ToDecimal(txtThreadshold.Text);
                }
                //if (rdVirtualCredit1.Items[0].Selected == true)
                //{

                //    obj.VirtualCreditType = "PERCENTAGE"; 
                //    obj.VirtualCreditValue= Convert.ToDecimal(txtVirtualCredit.Text);
                //}
                //else
                //{
                //    obj.VirtualCreditType = "AMOUNT"; 
                //    obj.VirtualCreditValue = Convert.ToDecimal(txtVirtualCredit.Text);
                //}
                obj.MinimumAdvanceAmt = Convert.ToDecimal(txtminAdvance.Text);

                //obj.MaximumAdvanceAmt = Convert.ToDecimal(txtmaxAdvance.Text);

            }
            else
            {
                obj.IsAdvanceClient = false;
            }
            /* End AB Code*/
            foreach (string TaxDetails in hdnTxDetails.Value.Split('^'))
            {
                if (TaxDetails != null && TaxDetails != "")
                {
                    ClientTaxMaster objTaxDetails = new ClientTaxMaster();
                    string[] strEachItem = TaxDetails.Split('|');
                    objTaxDetails.TaxID = Convert.ToInt32(strEachItem[3]);
                    objTaxDetails.IsActive= strEachItem[2] == "" ? "" : strEachItem[2];
                    objTaxDetails.SequenceNo= Convert.ToInt32(strEachItem[1]);
                    objTaxDetails.ClientID = int.Parse(hdnId.Value);
                    lstClientTaxMaster.Add(objTaxDetails);
                }
            }
            foreach (string contPrsn in hdnPrsnDetails.Value.Split('^'))
            {
                if (contPrsn != null && contPrsn != "")
                {
                    AddressDetails objContPrsn = new AddressDetails();
                    string[] strEachItem = contPrsn.Split('~');
                    objContPrsn.Name = strEachItem[1] == "" ? "" : strEachItem[1];
                    objContPrsn.EmpID = strEachItem[2] == "" ? 0 : Convert.ToInt64(strEachItem[2]);
                    objContPrsn.Mobile = strEachItem[5] == "" ? "" : strEachItem[5];
                    objContPrsn.Phone = strEachItem[6] == "" ? "" : strEachItem[6];
                    objContPrsn.EmailID = strEachItem[7] == "" ? "" : strEachItem[7];
                    objContPrsn.IsCommunication = strEachItem[8] == "" ? "" : strEachItem[8];
                    objContPrsn.ContactType = strEachItem[4] == "" ? "" : strEachItem[4];
                    objContPrsn.AddressID = strEachItem[10] == "" ? 0 : Convert.ToInt64(strEachItem[10]);
                    objContPrsn.ReferenceID = hdnId.Value == "" ? 0 : int.Parse(hdnId.Value);
                    lstAddressDetails.Add(objContPrsn);
                }
            }
            obj.ReferingID = hdnHosOrRefID.Value == "" ? 0 : Convert.ToInt32(hdnHosOrRefID.Value);

            obj.TodID = hdnTodID.Value == "" ? 0 : Convert.ToInt32(hdnTodID.Value);
            obj.TodID = txtTODCode.Text == "" ? 0 : Convert.ToInt32(hdnTodID.Value);

            obj.VoLID = hdnVolID.Value == "" ? 0 : Convert.ToInt32(hdnVolID.Value);
            obj.VoLID = txtvolume.Text == "" ? 0 : Convert.ToInt32(hdnVolID.Value);
            //--Code End---
            if (chkShowMappedItems.Checked == true)
            {
                obj.IsMappedItem = "Y";
            }
            else
            {
                obj.IsMappedItem = "N";
            }
            List<ClientLanguage> objlang = new List<ClientLanguage>();
            foreach (string lstlanguage in hdnreplanguage.Value.Split('^'))
            {
             if (lstlanguage!="")
             {
               ClientLanguage cl=new ClientLanguage();
               string[] lstlang = lstlanguage.Split('|');
               cl.ReportLanguage = lstlang[2];
               cl.IsActive = "A";
               cl.NoofCopies = Convert.ToInt32(lstlang[1]);
               cl.CreatedAt = DateTime.Now;
               cl.CreatedBy = LID;
               cl.ModifiedAt = DateTime.Now;
               cl.ModifiedBy = LID;
               objlang.Add(cl);
             }
            }
            foreach (string listParent in hdnAddressDetails.Value.Split('^'))
            {
                if (listParent != "")
                {
                    AddressDetails det = new AddressDetails();
                    string[] listChild = listParent.Split('|');
                    det.Address1 = listChild[0];
                    det.City = listChild[1];
                    det.EmailID = listChild[2];
                    det.Phone = listChild[3];
                    det.Mobile = listChild[4];
                    det.FaxNumber = listChild[5];
                    det.AddressTypeID = Convert.ToInt32(listChild[6]);
                    //det.CountryID = Convert.ToInt32(listChild[9]);
                    det.CountryID = listChild[9].ToString() == "" ? 0 : Convert.ToInt32(listChild[9]);
                    det.StateID = listChild[10].ToString() =="" ? 0 : Convert.ToInt32(listChild[10]);
                   // det.StateID = Convert.ToInt32(listChild[10]);
                    det.AddressID = Convert.ToInt32(listChild[8]);
                    det.ReferenceID = int.Parse(hdnId.Value);
                    det.IsCommunication = listChild[7];
                    det.ISDCode = Convert.ToInt32(listChild[12] == "" ? "0" : listChild[12]);
                    det.SubUrban = listChild[13] == "" ? "" : listChild[13];
                    det.InvoiceEmail = listChild[14];
                    lstAddressDetails.Add(det);
                }
            }
            for (int i = 0; i < chkPaymentMode.Items.Count; i++)
            {
                ClientAttributesDetails cpaymode = new ClientAttributesDetails();
                if (chkPaymentMode.Items[i].Selected == true)
                {
                    cpaymode.AttributesID = Convert.ToInt32(chkPaymentMode.Items[i].Value);
                    lstpaymode.Add(cpaymode);
                }
            }
            for (int i = 0; i < chkClientAttributes.Items.Count; i++)
            {
                ClientAttributesDetails objattributes = new ClientAttributesDetails();
                if (chkClientAttributes.Items[i].Selected == true)
                {
                    objattributes.AttributesID = Convert.ToInt32(chkClientAttributes.Items[i].Value);
                    objattributes.Description = chkClientAttributes.Items[i].Text;
                    lstclientattrib.Add(objattributes);
                }
            }

            for (int j = 0; j < chkDespatch.Items.Count; j++)
            {
                DespatchMode objdespatch = new DespatchMode();
                if (chkDespatch.Items[j].Selected == true)
                {
                    objdespatch.ActionTypeID = Convert.ToInt32(chkDespatch.Items[j].Value);
                    objdespatch.Despatch = chkDespatch.Items[j].Text;
                    lstDespatchmode.Add(objdespatch);
                }
            }
            //Added By Gurunath S
            for (int k = 0; k < chkNotification.Items.Count; k++)
            {
                ClientAttributesDetails objNotifyattributes = new ClientAttributesDetails();
                if (chkNotification.Items[k].Selected == true)
                {
                    objNotifyattributes.AttributesID = Convert.ToInt32(chkNotification.Items[k].Value);
                    objNotifyattributes.Description = chkNotification.Items[k].Text;
                    lstclientattrib.Add(objNotifyattributes);
                }
            }
            //Added By Arivalagan K 
            if (TxtRptPrintFrom.Text != "" && TxtRptPrintFrom.Text!="01/01/0001")
            {
                obj.ReportPrintdate = Convert.ToDateTime(TxtRptPrintFrom.Text);
            }
            else { obj.ReportPrintdate =Convert.ToDateTime("2013-01-10 00:00:00.000"); }
            //Added By Arivalagan K 
            for (int x = 0; x < chklstReport.Items.Count; x++)
            {
                ClientAttributesDetails objReportyattributes = new ClientAttributesDetails();
                if (chklstReport.Items[x].Selected == true)
                {
                    objReportyattributes.AttributesID = Convert.ToInt32(chklstReport.Items[x].Value);
                    objReportyattributes.Description = chklstReport.Items[x].Text;
                    lstclientattrib.Add(objReportyattributes);
                }
            }
            for (int y = 0; y < chklstIdentity.Items.Count; y++)
            {
                ClientAttributesDetails objIdentityattributes = new ClientAttributesDetails();
                if (chklstIdentity.Items[y].Selected == true)
                {
                    objIdentityattributes.AttributesID = Convert.ToInt32(chklstIdentity.Items[y].Value);
                    objIdentityattributes.Description = chklstIdentity.Items[y].Text;
                    lstclientattrib.Add(objIdentityattributes);
                }
            }

            ClientAttributesDetails ObjlstStationery = new ClientAttributesDetails();
            if (ddlStationery.SelectedValue != "0")
            {
                ObjlstStationery.AttributesID = Convert.ToInt32(ddlStationery.SelectedValue);
                ObjlstStationery.Description = ddlStationery.SelectedItem.ToString();
                lstclientattrib.Add(ObjlstStationery);
            }

            ClientAttributesDetails Objlstbilltype = new ClientAttributesDetails();
            if (ddlbilltype.SelectedValue != "0")
            {
                Objlstbilltype.AttributesID = Convert.ToInt32(ddlbilltype.SelectedValue);
                Objlstbilltype.Description = ddlbilltype.SelectedItem.ToString();
                lstclientattrib.Add(Objlstbilltype);
            }

            if (hdnIsCtParentOrg.Value == "Y" && ddlClientType.SelectedValue == "5")
            {
                for (int y = 0; y < chklstIsSponsor.Items.Count; y++)
                {
                    ClientAttributesDetails objIdentityattributes = new ClientAttributesDetails();
                    if (chklstIsSponsor.Items[y].Selected == true)
                    {
                        objIdentityattributes.AttributesID = Convert.ToInt32(chklstIsSponsor.Items[y].Value);
                        objIdentityattributes.Description = chklstIsSponsor.Items[y].Text;
                        lstclientattrib.Add(objIdentityattributes);
                    }
                }
            }
            string sendSMS = chkSndSMS.Checked ? "Y" : "N";
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            PageContextDetails.PageID = PageID;
            PageContextDetails.OrgID = OrgID;
            PageContextDetails.RoleID = RoleID;
            obj.AuthorizedBy = Convert.ToInt64(ddlAuthorizedBy.SelectedValue);
            obj.TransitTimeValue = txtTransitTime.Text == "" ? 0 : Convert.ToInt32(txtTransitTime.Text);
            obj.TransitTimeType = ddlTransitTime.SelectedValue.ToString();

            /*BEGIN || TAT || RAJKUMAR G || 20191001*/
            obj.Tatprocessdatetype = Convert.ToByte(ddlTATStartsfrom.SelectedValue.ToString());
            obj.Tattransitbasetype = Convert.ToByte(ddlTransitType.SelectedValue.ToString());
            /*END || TAT || RAJKUMAR G || 20191001*/

            //SERVICE TAX(Bill)-5%~23^
            if (!String.IsNullOrEmpty(hdnTaxValue.Value) && hdnTaxValue.Value.Length > 0)
            {
                string[] TaxValue = hdnTaxValue.Value.Split('^');
                for (int i = 0; i < TaxValue.Count(); i++)
                {
                    if (TaxValue[i] != "")
                    {
                        obj.Tax += TaxValue[i].Split('~')[1] + '~';
                    }
                }
            }
            //Added By Arivalagan K InvoiceCycle//
            if (ddlInvoiceCycle.Items.Count > 0)
            {
                obj.InvoiceCycle = ddlInvoiceCycle.SelectedValue.ToString();
            }
            //End InvoiceCycle//

            if (!String.IsNullOrEmpty(hdnPolicyID.Value) && hdnPolicyID.Value.Length > 0 && !String.IsNullOrEmpty(txtPolicyName.Text) && txtPolicyName.Text.Length > 0)
                obj.DiscountPolicyID = Convert.ToInt64(hdnPolicyID.Value);
            else
                obj.DiscountPolicyID = 0;
            //------
            // long pClientID = -1;

            //Added And Modified by Arivalagan KK //
             int IsClient = 0;
             int IsRemoteAccess=0;
            //IsClient=chkClientAccess.Checked == true ? 1 : 0;
            if (RdoClientRmtAccess.Items[1].Selected)
            {
                IsClient = 1;
                
            }
            if (RdoClientRmtAccess.Items[2].Selected)
            { 
            IsRemoteAccess = 1;
            } 
            
            //chkClientAccess.Checked == true ? 1 : 0;
            if (ddlReason.Items.Count > 0)
            {
                if (ddlReason.SelectedValue != "0")
                {
                    Reason = ddlReason.SelectedItem.ToString();
                }
            }
            else
            {
                Reason = "";
            }
            //End  Changed  by Arivalagan.KK//

           // returnCode = masterbl.SaveClientMasters(OrgID, ILocationID, LID, obj, lstAddressDetails, lstclientattrib, lstDespatchmode, lstpaymode, out NewClientID, sendSMS, PageContextDetails, IsClient, lstClientTaxMaster,Reason);
            returnCode = masterbl.SaveClientMasters(OrgID, 
                ILocationID,
                LID,
                obj,
                lstAddressDetails, 
                lstclientattrib, 
                lstDespatchmode, 
                lstpaymode, 
                out NewClientID,
                sendSMS, 
                PageContextDetails, 
                IsClient, 
                IsRemoteAccess,
                lstClientTaxMaster,
                Reason, objlang);
            //---------------------client logo-----

          
            IsLogoNeeded = GetConfigValue("NeedClientLogo", OrgID);
            if (IsLogoNeeded == "Y")
            {
                if (flUpload.HasFile)
                {
                    CliID = hdnId.Value;
                    if (btnFinish.Text == UpdateButton)
                    {
                        UpdateClientLogo(Convert.ToString(CliID));
                    }
                    else
                    {
                        UpdateClientLogo(Convert.ToString(NewClientID));
                    }
                }
            }

            //-----------------------client logo---------------
            if (returnCode == 0)
            {
                if (btnFinish.Text == UpdateButton)
                {
                    CliID = hdnId.Value;

                    string UsrMsgs2 = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_027 == null ? "Client Updated sucessfully.." : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_027;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs2 + "','" + Information + "');", true);

                   // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "alert('" + Update_Message + "');", true);
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "alert('Client Updated sucessfully.');", true);
                }
                else
                {
                    CliID = NewClientID.ToString();
                    if (NewClientID > 0 && ddlClientType.SelectedItem.ToString() == "CRO" && hdnIsCtParentOrg.Value == "Y")
                    {
                        NewInstanceCreation(NewClientID);
                        HttpContext.Current.Cache.Remove("ConfigData");
                    }

                    string UsrMsgs3 = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_028 == null ? "Client Added sucessfully." : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_028;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs3 + "','" + Information + "');", true);

                   // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "alert('" + Save_Message + "');", true);

                    // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Client", "alert('Client Added sucessfully.');", true);
                }
            }
            else
            {
                if (btnFinish.Text == UpdateButton)
                {
                    string UsrMsgs4 = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_029 == null ? "Update Failed." : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_029;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs4 + "','" + Information + "');", true);

                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Update", "alert('" + ErrorMessage_Update + "');", true);
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Update", "alert('Update Failed.');", true);
                }
                else
                {
                    string UsrMsgs5 = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_030 == null ? "Add Failed." : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_030;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs5 + "','" + Information + "');", true);
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Update", "alert('" + ErrorMessage_Save + "');", true);
                    //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Update", "alert('Add Failed.');", true);
                }
            }
            if (chkShowMappedItems.Checked == true && ddlClientStatus.SelectedValue == "A")
            {
                CLIName = txtClientName.Text;
                string CID = ddlClientType.SelectedItem.Value.ToString() + "~" + CliID + "~" + CLIName;
                //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Redirect", "javascript:redirectPage('" + CID + "');", true);
            }
            string getCTOrg = string.Empty;
            getCTOrg = GetConfigValue("CTORG", OrgID);
            if (getCTOrg == "Y")
            {
                SendSMS(CliID);
            }
            hdnStatus.Value = "";
            hdnClientAttributes.Value = "";
            ClearFields();
            //Added  By Arivalagan.kk//
            //GetClientDetails();
            gvclientmaster.DataSource = null;
            gvclientmaster.DataBind();
            txtClientNameSrch.Text = "";
            txtClientCodeSrch.Text = "";
            Txtftppath.Text = ""; //Alex
            //End  Added  By Arivalagan//

            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "LoadCSS", "LoadCSS();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Invoice Master - InvoiceMaster.aspx", ex);
        }

    }

    public void ClearFields()
    {
        txtTDate.Text = "";
        txtFDate.Text = "";
        txtClientCode.Enabled = true; txtClientCode.Text = ""; txtClientName.Text = ""; txtcstno.Text = ""; txtEmailID.Text = "";
        hdnreplanguage.Value = "";
        txtfax.Text = ""; txtmobileno.Text = ""; txtPhoneNumber.Text = ""; txtServiceTaxNo.Text = ""; txtServiceTaxNo.Text = "";
        txtPanNo.Text = ""; txtaddres1.Text = ""; txtciti.Text = ""; drpaddresstype.SelectedValue = "0"; txtzone.Text = ""; txtRouteName.Text = "";
        hdnTxDetails.Value = ""; ddlTaxDetails.SelectedIndex = 0; TxtSeqNo.Text = "";
        hdnId.Value = "0"; ddlClientType.SelectedValue = "0"; hdnAddressDetails.Value = ""; hdnTxDetails.Value = ""; ddlTaxDetails.SelectedIndex = 0; TxtSeqNo.Text = ""; hdnAddressID.Value = "0"; hdnParentClientID.Value = "0";
        fckInvDetailss.Value = ""; hdnParentClientID.Value = "0"; txtgracelimit.Text = ""; txtgracedays.Text = ""; txtparentClient.Text = "";
        drpBusinessType.SelectedValue = "0"; drpreportformat.SelectedValue = "0"; hdntxtzoneID.Value = "0"; hdntxtrouteID.Value = "0";
        txtsapcode.Text = ""; hdncollectioncenterid.Value = "0"; txtcollectioncenter.Text = ""; txtsapcode.Text = "";
        txtcreditlimit.Text = ""; txtCreditDays.Text = ""; fckInvDetailss.Value = ""; Chkiscash.Checked = false; chkisparent.Checked = false;
        chkShowMappedItems.Checked = false; chkisapproval.Checked = false; txtHub.Text = ""; txtTODCode.Text = ""; txtvolume.Text = ""; txtPromisedAmount.Text = "";
        rblSearchType.SelectedIndex = 0;
        Txtftppath.Text = "";//Alex
        hdnStatus.Value = "Save";
        string save = Resources.ClientSideDisplayTexts.Invoice_ClientMaster_aspx_cs_Save;
        btnFinish.Text = save;
        hdnValidateActive.Value = "0"; chkDiscount.Checked = false; chkDebtor.Checked = false;
        hdnStatus.Value = "";
        for (int i = 0; i < chkPaymentMode.Items.Count; i++)
        {
            chkPaymentMode.Items[i].Selected = false;
        }
        for (int i = 0; i < chkDespatch.Items.Count; i++)
        {
            chkDespatch.Items[i].Selected = false;
        }
        for (int i = 0; i < chkClientAttributes.Items.Count; i++)
        {
            chkClientAttributes.Items[i].Selected = false;
        }
        for (int i = 0; i < chkNotification.Items.Count; i++)
        {
            chkNotification.Items[i].Selected = false;
        }
        for (int i = 0; i < chklstIdentity.Items.Count; i++)
        {
            chklstIdentity.Items[i].Selected = false;
        }
        for (int i = 0; i < chklstReport.Items.Count; i++)
        {
            chklstReport.Items[i].Selected = false;
        }
        for (int i = 0; i < chklstIsSponsor.Items.Count; i++)
        {
            chklstIsSponsor.Items[i].Selected = false;
        }
        //
        LoadCountry();
        GetPrintLocation();
        //Added By Guruanth S
        LoadClientStatus();
        hdnPrsnDetails.Value = "";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "TempDate();", true);
        LoadReason();
        txtFDate.Text = "";
        txtTDate.Text = "";
        TxtRptPrintFrom.Text = "";
        ReportPrintFrom.Style.Add("display", "none");
        tdReasonBlock.Style.Add("display", "none");
        tdBlockDate.Style.Add("display", "none");
        isparentclient.Attributes.Add("style", "display:none");
        chkSndSMS.Checked = false;
        tdSendSMS.Style.Add("display", "none");
        btnFinish.Enabled = true;
        txtSubUrban.Text = "";
        txtTransitTime.Text = "";
        lblHeaderText.Text = "";
        grdClientHistory.DataSource = null;
        grdClientHistory.DataBind();
        ddlTransitTime.SelectedValue = "0";
        tdHistory.Style.Add("display", "none");
        hdnTaxValue.Value = "";
        txtTaxName.Text = "";
        divTax.InnerHtml = "";
        hdnSkipID.Value = "0";
        hdnSetParentID.Value = "";
        txtPolicyName.Text = "";
        hdnPolicyID.Value = "";
        AutoCompleteExtender2.ContextKey = "";
        AutoCompleteExtender12.ContextKey = "";
        Txtftppath.Text = ""; //Alex

        if (!String.IsNullOrEmpty(ViewState["SetRoleID"].ToString()) && ViewState["SetRoleID"].ToString().Length > 0)
        {
            ddlRole.SelectedValue = ViewState["SetRoleID"].ToString();
        }
        foreach (ListItem drpItems in drpBusinessType.Items)
        {
            if (drpItems.Value == "CLINICALTRIAL")
            {
                drpBusinessType.SelectedValue = "CLINICALTRIAL";
                break;
            }
        }
        ddlStationery.SelectedValue = "0";
        ddlreplang.SelectedIndex = 0;
        //VEL
        ddlbilltype.SelectedValue = "0";
        //VEL
        if (ddlInvoiceCycle.Items.Count > 0)
        {
            ddlInvoiceCycle.SelectedIndex = 0;
        }
        tdRole.Style.Add("display", "none");
        tdlblRole.Style.Add("display", "none");
        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "LoadCSS", "LoadCSS();", true);
        RdoClientRmtAccess.SelectedIndex = 0;
        /*Modified By AB*/
        txtThreadshold.Text = "";
        txtThreadshold2.Text = "";
        txtThreadshold3.Text = "";
        txtVirtualCredit.Text = "";
        txtmaxAdvance.Text = "";
        txtminAdvance.Text = "";
        IsAdvanceClient.Checked = false;
        /*End AB Code*/
        if (ddlReason.Items.Count > 0)
        {
            ddlReason.SelectedIndex = 0;
        }
        txtPendingCreditlimit.Text = "";
        txtSapDue.Text = "";
        txtnotInvoiced.Text = "";
        chkCreditLimit.Checked = false;
        lblValidTo.Text = "";
        lblBlockDate.Style.Add("display", "none");
        lblValidTo.Style.Add("display", "none");

        /*BEGIN || TAT || RAJKUMAR G || 20191001*/
        ddlTATStartsfrom.SelectedValue = "0";
        ddlTransitType.SelectedValue = "0";
        /*END || TAT || RAJKUMAR G || 20191001*/

    }

    public void GetClientDetails()
    {
        try
        {
            List<ClientMaster> lstinvmasters = new List<ClientMaster>();
            lstinvmasters.Clear();
            long returncode = -1;
            long ClientID = 0;
            if ((txtClientNameSrch.Text.Trim() != "" && txtClientNameSrch.Text.Length > 2) || txtClientCodeSrch.Text.Trim() != "")
            {
                masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
            }
            gvclientmaster.DataSource = lstinvmasters;
            gvclientmaster.DataBind();
            if (lstinvmasters.Count == 1)
            {
                GetInvoiceClientDetails(lstinvmasters[0].ClientID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting client - Invoicemaster.aspx", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        tdLogoStatus.Visible = false;
        ClearFields();
        GetClientDetails();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearFields();
        txtClientNameSrch.Text = "";
        txtClientCodeSrch.Text = "";
        GetClientDetails();
    }
    protected void gvclientmaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvclientmaster.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    protected void grdClientHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdClientHistory.PageIndex = e.NewPageIndex;
            long ClientID = hdnId.Value == "" ? 0 : Convert.ToInt64(hdnId.Value);
            LoadClientHistory(ClientID);
        }
    }

    string CustomiseString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("AttribDetails").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("AttribDetails"))
        {
            HdnText += xmNode["ID"].InnerText + "~" + xmNode["Name"].InnerText + "~" + xmNode["Type"].InnerText + "~" + xmNode["Value"].InnerText + "^";
        }
        return HdnText;
    }
    protected void gvclientmaster_RowDataCommand(object sender, GridViewRowEventArgs e)
    {

    }
    protected void gvclientmaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
            }

            ClientMaster si = (ClientMaster)e.Row.DataItem;
            string HIDstr = "";
            string strScript = "";
            string data = "";
            e.Row.Attributes.Add("onmouseover", "this.className='hover'");
            e.Row.Attributes.Add("onmouseout", "this.className='hout'");
            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("btnEdit");
            if (si.ClientCode.ToUpper() == "GENERAL")
            {
                hdnclientnames.Value = "GENERAL";
                e.Row.Enabled = false;
            }
        }
        if (hdnIsCtParentOrg.Value == "N")
        {
            gvclientmaster.Columns[7].Visible = false;
        }
    }
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            //BEGIN || TAT || RAJKUMAR G || 20191001 
            //string domains = "ClientAttributeType,CutOffTimeType,Department,InvoiceCycle";
            string domains = "ClientAttributeType,CutOffTimeType,Department,InvoiceCycle,TATStartsFrom,TransitType,ReportLanguage";
            //END || TAT || RAJKUMAR G || 20191001 
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ClientAttributeType"
                                     orderby child.MetaDataID ascending
                                     select child;
                    ddlClientTypes.DataSource = childItems;
                    ddlClientTypes.DataTextField = "DisplayText";
                    ddlClientTypes.DataValueField = "Code";
                    ddlClientTypes.DataBind();
                    //Added By Arivalagan 22-07-2014//
                    var InvoiceCycle = from IC in lstmetadataOutput
                                       where IC.Domain == "InvoiceCycle"
                                       orderby IC.MetaDataID ascending
                                       select IC;
                    ddlInvoiceCycle.DataSource = InvoiceCycle;
                    ddlInvoiceCycle.DataTextField = "DisplayText";
                    ddlInvoiceCycle.DataValueField = "Code";
                    ddlInvoiceCycle.DataBind();
                    //ddlInvoiceCycle.Items.Insert(0, "--Select--");
                    //ddlInvoiceCycle.Items[0].Value = "0.5";

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "CutOffTimeType"
                                      orderby child.MetaDataID ascending
                                      select child;
                    ddlTransitTime.DataSource = childItems1;
                    ddlTransitTime.DataTextField = "DisplayText";
                    ddlTransitTime.DataValueField = "Code";
                    ddlTransitTime.DataBind();
                    ddlTransitTime.Items.Insert(0, select);
                    ddlTransitTime.Items[0].Value = "0";

                    var childItems2 = from child in lstmetadataOutput
                                      where child.Domain == "Department"
                                      orderby child.MetaDataID ascending
                                      select child;
                    string temp = string.Empty;
                    foreach (var child in childItems2)
                    {
                        temp += child.DisplayText + "~" + child.Code + "^";
                    }
                    if (!String.IsNullOrEmpty(temp) && temp.Length > 0)
                    {
                        hdnAddDepart.Value = temp;
                        ViewState.Add("AddDepartment", temp);
                    }


                    //BEGIN || TAT || RAJKUMAR G || 20191001 
                    var childItems3 = from child3 in lstmetadataOutput
                                      where child3.Domain == "TATStartsFrom"
                                      orderby child3.MetaDataID ascending
                                      select child3;
                    ddlTATStartsfrom.DataSource = childItems3;
                    ddlTATStartsfrom.DataTextField = "DisplayText";
                    ddlTATStartsfrom.DataValueField = "Code";
                    ddlTATStartsfrom.DataBind();
                    ddlTATStartsfrom.Items.Insert(0, "--Select--");
                    ddlTATStartsfrom.Items[0].Value = "0";


                    var childItems4 = from child4 in lstmetadataOutput
                                      where child4.Domain == "TransitType"
                                      orderby child4.MetaDataID ascending
                                      select child4;
                    ddlTransitType.DataSource = childItems4;
                    ddlTransitType.DataTextField = "DisplayText";
                    ddlTransitType.DataValueField = "Code";
                    ddlTransitType.DataBind();
                    ddlTransitType.Items.Insert(0, "--Select--");
                    ddlTransitType.Items[0].Value = "0";
                    //END || TAT || RAJKUMAR G || 20191001 

                    var childItems5 = from child in lstmetadataOutput
                                      where child.Domain == "ReportLanguage"
                                      orderby child.MetaDataID ascending
                                      select child;
                    ddlreplang.DataSource = childItems5;
                    ddlreplang.DataTextField = "DisplayText";
                    ddlreplang.DataValueField = "Code";
                    ddlreplang.DataBind();
                    ddlreplang.Items.Insert(0, select);
                    ddlreplang.Items[0].Value = "0";

                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);

        }
    }
    string CreateClientXML()
    {

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<ClientAttributes></ClientAttributes>");
        XmlNode xmlNode;
        foreach (string O in hdnClientAttributes.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;
                string type = string.Empty;
                string value = string.Empty;
                if (O.Split('~')[0] != string.Empty)
                {
                    Id = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    name = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    type = O.Split('~')[2];
                }
                if (O.Split('~')[3] != string.Empty)
                {
                    value = O.Split('~')[3];
                }
                XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = type;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = value;
                xmlElement.AppendChild(xmlNode);
                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;

    }

    public void GetInvoiceClientDetails(long clientid)
    {
        List<ClientMaster> lstinvmasters = new List<ClientMaster>();
        lstinvmasters.Clear();
        long returncode = -1;
        btnFinish.Text = UpdateButton;
        long ClientID = 0;
        ClientID = clientid;
        returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
        if (lstinvmasters.Count > 0)
        {
            var s = lstinvmasters.Find(p => p.ClientID == ClientID);
            txtClientCode.Text = s.ClientCode;
            hdnId.Value = s.ClientID.ToString();
            txtClientName.Text = s.ClientName;
            ddlClientType.SelectedValue = s.ClientTypeID.ToString();
            hdnAddressDetails.Value = s.AddressDetails;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "SplitAddresType", "GenerateTable();", true);
            chkisapproval.Checked = s.ApprovalRequired.Trim() == "Y" ? true : false;
            chkShowMappedItems.Checked = s.IsMappedItem.Trim() == "Y" ? true : false;
            Chkiscash.Checked = s.ISCash.Trim() == "Y" ? true : false;
            txtsapcode.Text = s.SapCode;
            txtzone.Text = s.ZoneName;
            ddlPrintLocation.SelectedValue = s.PrintOrgAddressID.ToString();
            hdntxtzoneID.Value = s.ZonalID.ToString();
            txtServiceTaxNo.Text = s.ServiceTaxNo;
            txtcstno.Text = s.CstNo;
            txtCreditDays.Text = s.CreditDays.ToString();
            txtcreditlimit.Text = s.CreditLimit.ToString();
            txtPromisedAmount.Text = s.PromisedAmount.ToString();
            Txtftppath.Text =Convert.ToString(s.FilePath);
            /*Added By AB*/

            /* added for credit limit */

            txtPendingCreditlimit.Text = s.PendingCreditLimit.ToString();
            txtSapDue.Text = s.SAPDue.ToString();
            txtnotInvoiced.Text = s.NotInvoiced.ToString();
            if (Convert.ToInt32(s.CreditLimit) > 0)
            {
                lblBlockDate.Style.Add("display", "block");
                lblValidTo.Style.Add("display", "block");
                lblValidTo.Text = s.ValidTo.Date.ToString();
            }
            else
            {
                lblBlockDate.Style.Add("display", "none");
                lblValidTo.Style.Add("display", "none");
            }
            /* end */

            if (s.IsAdvanceClient == true)
            {
                IsAdvanceClient.Checked = true;
            }
            if (s.ThresholdType == "AMOUNT" || s.ThresholdType == "PERCENTAGE" || s.VirtualCreditType == "AMOUNT" || s.VirtualCreditType == "PERCENTAGE")
            {
                IsAdvanceClient.Checked = true;
            }
            if (s.ThresholdType == "CREDITAMOUNT")
            {
                chkCreditLimit.Checked = true;
                txtThreadshold.Text = s.ThresholdValue.ToString();
                txtThreadshold2.Text = s.ThresholdValue2.ToString();
                txtThreadshold3.Text = s.ThresholdValue3.ToString();
            }
            if (s.ThresholdType == "AMOUNT")
            {
                rdThreadsHold1.SelectedValue = "1";
                txtThreadshold.Text = s.ThresholdValue.ToString();
                txtThreadshold2.Text = s.ThresholdValue2.ToString();
                txtThreadshold3.Text = s.ThresholdValue3.ToString();
            }
            else
            {
                rdThreadsHold1.SelectedIndex = 0;
                txtThreadshold.Text = s.ThresholdValue.ToString();
            }
            if (s.VirtualCreditType == "AMOUNT")
            {
                rdVirtualCredit1.SelectedIndex = 1;
                txtVirtualCredit.Text = s.VirtualCreditValue.ToString();
            }
            else
            {
                rdVirtualCredit1.SelectedIndex = 0;
                txtVirtualCredit.Text = s.VirtualCreditValue.ToString();
            }
            txtminAdvance.Text = s.MinimumAdvanceAmt.ToString();
            txtmaxAdvance.Text = s.MaximumAdvanceAmt.ToString();
            /*End AB Code*/
            if (s.InvoiceCycle == null)
            {
                ddlInvoiceCycle.SelectedIndex = 0;
            }
            else
            {
                ddlInvoiceCycle.SelectedValue = s.InvoiceCycle;
            }
            if (s.ParentClientName != "" && s.ParentClientName != null)
            {
                isparentclient.Attributes.Add("style", "display:block");
                txtparentClient.Text = s.ParentClientName;
                chkisparent.Checked = true;
            }
            else
            {
                chkisparent.Checked = false;
                isparentclient.Attributes.Add("style", "display:none");
            }
            if (s.InvoiceShowColumns == 0)
            { 
                rblSearchType.SelectedValue = "0";
            }
            if (s.InvoiceShowColumns == 1)
            { 
                rblSearchType.SelectedValue = "1";
            }
            if (s.InvoiceShowColumns == 2)
            { 
                rblSearchType.SelectedValue = "2";
            }
            hdnParentClientID.Value = s.ParentClientID.ToString();
            txtgracedays.Text = s.GraceDays.ToString();
            txtgracelimit.Text = s.GraceLimit.ToString();
            //drpBusinessType.SelectedValue = s.CustomerType.ToString();
            drpreportformat.SelectedValue = s.ReportTemplateID.ToString();
            txtPanNo.Text = s.PanNo;
            txtcollectioncenter.Text = s.CollectionCenter;
            hdncollectioncenterid.Value = s.CollectionCenterID.ToString();
            fckInvDetailss.Value = s.Termsconditions;
            ddlClientType.SelectedValue = s.ClientTypeID.ToString();
            drpBusinessType.SelectedValue = s.CustomerType.ToString();
            lbidcode.Attributes.Add("style", "display:table-cell");
            txtclcode.Attributes.Add("style", "display:table-cell");
            txtClientCode.Enabled = true;
            ClearChkBxList();
            if (s.DespatchMode != "" && s.DespatchMode != null)
            {
                foreach (string txt in s.DespatchMode.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chkDespatch.Items)
                        {

                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
            if (s.ClientPayment != "" && s.ClientPayment != null)
            {
                foreach (string txt in s.ClientPayment.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chkPaymentMode.Items)
                        {

                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
            }
            if (s.Attributes != "")
            {
                string datas = CustomiseString(s.Attributes);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "xmlattrib", "LoadOrdItemsCorp('" + datas + "');", true);
            }
            hdnreplanguage.Value = s.ReportLanguage!=null ? s.ReportLanguage :string.Empty;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "SplitLanguage", "GenerateLangTable();", true);
            //Added By Guruanth S
            txtHub.Text = s.HubName;
            hdnHubID.Value = s.HubID.ToString();
            txtRouteName.Text = s.RouteName;
            hdntxtrouteID.Value = s.RouteID.ToString();
            chkDebtor.Checked = s.IsParentPayer.Trim() == "Y" ? true : false;
            ddlClientStatus.SelectedValue = s.Status;
            hdnClientStatus.Value = s.Status;
            tdReasonBlock.Style.Add("display", "none");
            tdBlockDate.Style.Add("display", "none");
            tdSendSMS.Style.Add("display", "none");
            if (s.Status == "A" && s.Reason != select)
            {
                // tdReasonBlock.Style.Add("display", "block");
                tdSendSMS.Style.Add("display", "table-cell");
                drpReason.SelectedValue = s.Reason == "" ? select : s.Reason;

            }
            if (s.Status != "A")
            {
                tdReasonBlock.Style.Add("display", "table-cell");
                tdSendSMS.Style.Add("display", "table-cell");
                drpReason.SelectedValue = s.Reason == "" ? select : s.Reason;
                tdBlockDate.Style.Add("display", "table-cell");
                txtFDate.Text = s.BlockFrom.ToString("dd/MM/yyyy");
                txtTDate.Text = s.BlockTo.ToString("dd/MM/yyyy");
            }
            hdnValidateActive.Value = s.Reason;
            hdnGetEmpContact.Value = s.EmployeeContacts;
            hdnGetOtherContact.Value = s.OtherContacts;
            if (s.ClientAttributes != "" && s.ClientAttributes != null)
            {
                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chkNotification.Items)
                        {
                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                            if (item.Text == "Report Print" && item.Value.Trim() == txt.Trim()) 
                            {
                                item.Attributes.Add("onchange", "javascript: return ReportPrintChanged('Y');");
                                ReportPrintFrom.Style.Add("display", "table-row");
                            }
                        }
                    }

                }
                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chklstIdentity.Items)
                        {
                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chklstReport.Items)
                        {
                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chkClientAttributes.Items)
                        {
                            if (item.Value.Trim() == txt.Trim())
                            {
                                item.Selected = true;
                            }
                        }
                    }
                }
                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ListItem item in chklstIsSponsor.Items)
                        {
                            if (item.Value.Trim() == txt.Trim())
                            {

                                tdIsSponsor.Attributes.Add("style", "table-cell");
                                item.Selected = true;
                            }
                        }
                    }
                }
                JavaScriptSerializer Objserializer = new JavaScriptSerializer();
                List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
                string  StrlstStationery = hdnlstStationery.Value;
                int IsSelected = 0;
                lstclientattrib = Objserializer.Deserialize<List<ClientAttributes>>(StrlstStationery);
                

                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach(ClientAttributes Obj in lstclientattrib)
                        {
                            if (Obj.AttributeID.ToString() == txt.Trim())
                            {
                                ddlStationery.SelectedValue = txt.Trim();
                                IsSelected = 1;
                                break;
                            }
                        }
                        if (IsSelected == 1)
                        {
                            break;
                        }
                    }
                }

                //VEL
                JavaScriptSerializer ObjserializerBillType = new JavaScriptSerializer();
                List<ClientAttributes> lstclientattribBillType = new List<ClientAttributes>();
                string strBillType = hdnlstBillType.Value;
                int IsBillTypeSelected = 0;
                lstclientattribBillType = Objserializer.Deserialize<List<ClientAttributes>>(strBillType);


                foreach (string txt in s.ClientAttributes.Split('^'))
                {
                    if (txt != "")
                    {
                        foreach (ClientAttributes Obj in lstclientattribBillType)
                        {
                            if (Obj.AttributeID.ToString() == txt.Trim())
                            {
                                ddlbilltype.SelectedValue = txt.Trim();
                                IsBillTypeSelected = 1;
                                break;
                            }
                        }
                        if (IsBillTypeSelected == 1)
                        {
                            break;
                        }
                    }
                }
                //VEL
                
            }

            if (chkisapproval.Checked == true)
            {
                tdlblRole.Style.Add("display", "table-cell");
                tdRole.Style.Add("display", "table-cell");
                if (chkisparent.Checked == true)
                {
                    td2AdColspan.Style.Add("display", "table-cell");
                    td4AdColspan.Style.Add("display", "none");
                }
                else
                {
                    td2AdColspan.Style.Add("display", "none");
                    td4AdColspan.Style.Add("display", "table-cell");
                }
            }
            else
            {
                tdlblRole.Style.Add("display", "none");
                tdRole.Style.Add("display", "none");
                if (chkisparent.Checked == true)
                {
                    td2AdColspan.Style.Add("display", "none");
                    td4AdColspan.Style.Add("display", "table-cell");
                }
                else
                {
                    td2AdColspan.Style.Add("display", "table-cell");
                    td4AdColspan.Style.Add("display", "none");
                }
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Contact", "GenerateContactTable();", true);
            hdnHosOrRefID.Value = s.ReferingID == 0 ? "0" : Convert.ToString(s.ReferingID);
            hdnTodID.Value = s.TodID == 0 ? "0" : Convert.ToString(s.TodID);
            hdnVolID.Value = s.VoLID == 0 ? "0" : Convert.ToString(s.VoLID);

            if (!String.IsNullOrEmpty(s.TodCode) && s.TodCode.Length > 0)
            {
                txtTODCode.Text = s.TodCode;
            }
            else
            {
                txtTODCode.Text = "";
            }
            if (!String.IsNullOrEmpty(s.TodVol) && s.TodVol.Length > 0)
            {
                txtvolume.Text = s.TodVol;
            }
            else
            {
                txtvolume.Text = "";
            }
            // txtTODCode.Text = s.TodCode;

            chkDiscount.Checked = s.IsDiscount == "Y" ? true : false;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "TempDate();", true);
            ddlAuthorizedBy.SelectedValue = s.AuthorizedBy.ToString();

            /*BEGIN || TAT || RAJKUMAR G || 20191001*/
            ddlTATStartsfrom.SelectedValue = s.Tatprocessdatetype.ToString();
            ddlTransitType.SelectedValue = s.Tattransitbasetype.ToString();
            /*END || TAT || RAJKUMAR G || 20191001*/

            txtTransitTime.Text = s.TransitTimeValue == 0 ? "" : s.TransitTimeValue.ToString();
            ddlTransitTime.SelectedValue = s.TransitTimeType == null ? "0" : s.TransitTimeType.ToString();
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "LoadCSS", "LoadCSS();", true);

            if( s.ClientTaxDetails !="")
            hdnTxDetails.Value = s.ClientTaxDetails;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "TaxDetails", "CreateTaxDetails();", true);
            LoadClientHistory(Convert.ToInt64(s.ClientID));
            hdnTaxValue.Value = "";
            if (!String.IsNullOrEmpty(s.Tax) && s.Tax.Length > 0)
            {
                string[] ClientTax = s.Tax.Split('~');
                string[] TaxMaster = s.TaxMaster.Split('^');
                string ClientTaxValue = string.Empty;
                for (int i = 0; i < ClientTax.Count(); i++)
                {
                    if (!String.IsNullOrEmpty(ClientTax[i]) && ClientTax[i].Length > 0)
                    {
                        for (int j = 0; j < TaxMaster.Count(); j++)
                        {
                            if (!String.IsNullOrEmpty(TaxMaster[j]) && TaxMaster[j].Length > 0)
                            {
                                if (TaxMaster[j].Split('~')[0] == ClientTax[i])
                                {
                                    ClientTaxValue += TaxMaster[j].Split('~')[1] + '-' + TaxMaster[j].Split('~')[2].Split('.')[0] + '%' + '~' + TaxMaster[j].Split('~')[0] + '^';
                                }
                            }
                        }
                    }
                }
                if (!String.IsNullOrEmpty(ClientTaxValue) && ClientTaxValue.Length > 0)
                {
                    hdnTaxValue.Value = ClientTaxValue;
                    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "CreateTaxTable", "AddTax();", true);
                }
            }
            if (s.Tax == "HOS" || s.Tax == "RPH")
            {
                AutoCompleteExtender6.ContextKey = s.ClientTypeID.ToString();
            }
            else
            {
                AutoCompleteExtender6.ContextKey = "";
            }
            hdnSkipID.Value = "1";
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "setContext", "SetContextKeyRefHos();", true);
            if (hdnSetParentID.Value != "")
            {
                AutoCompleteExtender1.ContextKey = hdnSetParentID.Value;
            }

            txtPolicyName.Text = ""; hdnPolicyID.Value = "";
            if (!String.IsNullOrEmpty(s.DiscountPolicyID.ToString()) && s.DiscountPolicyID.ToString().Length > 0)
                hdnPolicyID.Value = s.DiscountPolicyID.ToString().Trim();
            if (!String.IsNullOrEmpty(s.PolicyName) && s.PolicyName.Length > 0)
                txtPolicyName.Text = s.PolicyName;
            AutoCompleteExtender11.ContextKey = "DCP";
            //Added By arivalagan KK//
            RdoClientRmtAccess.Items[0].Selected = false;
            if (s.IsClientAccess == 1) 
            {
              //  RdoClientRmtAccess.SelectedIndex = 1;
                RdoClientRmtAccess.Items[1].Selected = true;
            }
            if (s.IsRemoteAccess == 1)
            { //RdoClientRmtAccess.SelectedIndex = 2 ;
            RdoClientRmtAccess.Items[2].Selected = true;
            }

            if (s.IsClientAccess == 0 && s.IsRemoteAccess == 0)
            { 
             RdoClientRmtAccess.SelectedIndex = 0; }

            // chkClientAccess.Checked = s.LoginID > 0 ? true : false;
            //End Added By arivalagan KK//

            if (s.HubID > 0)
            {
                AutoCompleteExtender2.ContextKey = "zone~" + s.HubID.ToString();
            }
            if (s.ZonalID > 0)
            {
                AutoCompleteExtender12.ContextKey = "route~" + s.ZonalID.ToString();
            }
            TxtRptPrintFrom.Text =s.ReportPrintdate.ToShortDateString();

            

        }
    }
    protected void gvclientmaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            long returncode = -1;
            btnFinish.Text = UpdateButton;
            int ClientID = 0;

            if (e.CommandName == "Select")
            {
                int rowIndex = -1;
                rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow grow = gvclientmaster.Rows[rowIndex];
                ClientID = Convert.ToInt32(gvclientmaster.DataKeys[rowIndex][0].ToString());
                GetInvoiceClientDetails(ClientID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Client Attributes.", ex);
        }
    }

    public void LoadClientStatus()
    {
        long returnCode = -1;
        try
        {
            string domains = "ClientStatus,";
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
            returnCode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returnCode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ClientStatus"
                                     orderby child.MetaDataID ascending
                                     select child;
                    tdlblCStatus.Style.Add("display", "table-cell");
                    tdClientStatus.Style.Add("display", "table-cell");
                    ddlClientStatus.DataSource = childItems;
                    ddlClientStatus.DataTextField = "DisplayText";
                    ddlClientStatus.DataValueField = "Code";
                    ddlClientStatus.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading ClientStatus in DropDownlist in InvoiceMaster.aspx.cs", ex);
        }
    }

    public void ClearChkBxList()
    {
        chkPaymentMode.ClearSelection();
        chkDespatch.ClearSelection();
        chkNotification.ClearSelection();
        chklstIdentity.ClearSelection();
        chklstReport.ClearSelection();
        chkClientAttributes.ClearSelection();
        chklstIsSponsor.ClearSelection();
    }

    public void DisplayTab()
    {
        //Is Client Logo Needed Starts//
        IsLogoNeeded = GetConfigValue("NeedClientLogo", OrgID);
        if (IsLogoNeeded == "Y")
        {
            tdCommercial.Style.Add("display", "none");
            li11.Attributes.Add("class", "active");

            li11.Attributes.Remove("class");
        }
        else
        {
            tdCommercial.Style.Add("display", "block");
            li11.Style.Add("display", "none");

        }
        tdCommercial.Style.Add("display", "table-cell");
        tdShip.Style.Add("display", "none");
        tdContact.Style.Add("display", "none");
        tdNotify.Style.Add("display", "none");
        tdReports.Style.Add("display", "none");
        tdTerms.Style.Add("display", "none");
        tdDespt.Style.Add("display", "none");
        tdAttribs.Style.Add("display", "none");
        if (IsLogoNeeded == "Y")
        {
            if (RoleHelper.CreditControler == RoleName || RoleHelper.Admin == RoleName)
            {
                tdLogoStatus.Style.Add("display", "block;");
            }
            else
            {
                tdLogoStatus.Style.Add("display", "none;");
            }

        }
    }

    public void LoadReason()
    {
        long ReturnCode = -1;
        Users_BL user = new Users_BL(base.ContextInfo);
        List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
        ReturnCode = user.GetReasonforblocking(OrgID, out lstmetavalue);
        if (lstmetavalue.Count > 0)
        {

            drpReason.DataSource = lstmetavalue;
            drpReason.DataTextField = "Value";
            drpReason.DataValueField = "Code";
            drpReason.DataBind();
            drpReason.Items.Insert(0, select);
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
    public void NewInstanceCreation(long pClientID)
    {
        long returnCode = -1;
        int pDefaultOrgID = -1;
        long pDefaultOrgAddID = -1;
        int retStatus = -1;
        long AliceID = -1;
        string AliceType = string.Empty;
        List<Role> lstRole = new List<Role>();
        List<Role> lstRoleNew = new List<Role>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Organization> lstOrganization = new List<Organization>();
        List<NewInstanceCreationTracker> lstNICT = new List<NewInstanceCreationTracker>();
        List<Department> lstDept = new List<Department>();

        pDefaultOrgID = OrgID;
        pDefaultOrgAddID = ILocationID;

        #region SetDefaultRole
        pDefaultOrgID = OrgID;
        //returnCode = new Role_BL(base.ContextInfo).GetRoleName(pDefaultOrgID, out lstRole); 
        //lstRole = lstRole.FindAll(p => p.RoleID == RoleID);
        //Role r = new Role();
        //r.RoleID =RoleID;
        //r.RoleName = lstRole[0].RoleName;
        //r.Description = lstRole[0].RoleName;  
        //r.OrgID = pDefaultOrgID;
        //r.OrgAddressID = pDefaultOrgAddID;
        //lstRoleNew.Add(r);
        returnCode = new Role_BL(base.ContextInfo).GetRoleName(pDefaultOrgID, out lstRoleNew);
        #endregion
        #region VisitPurpose
        //Not Need to Set Any Data
        #endregion

        #region OrgDetails

        Organization org = new Organization();
        org.OrgID = pDefaultOrgID;
        //org.AddressID = pDefaultOrgAddID;
        org.Name = txtClientName.Text; //txtOrgName.Text;
        org.Location = txtClientName.Text + " Loc"; //txtLocation.Text;
        org.OrganizationTypeID = 1;
        org.LogoPath = "";
        org.StartDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        org.EndDTTM = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        if (ddlreplang.SelectedValue != "0")
            org.ReportLanguage = ddlreplang.SelectedItem.Value;
        else
            org.ReportLanguage = string.Empty;
        foreach (string listParent in hdnAddressDetails.Value.Split('^'))
        {
            if (listParent != "")
            {
                string[] listChild = listParent.Split('|');
                org.Add1 = listChild[0];
                org.City = listChild[1];
                org.LandLineNumber = listChild[3];
                org.PhoneNumber = listChild[4];
                org.CountryID = Convert.ToInt32(drpCountry.SelectedValue);
                org.StateID = Convert.ToInt32(drpState.SelectedValue);
                break;
            }
        }
        AliceID = pClientID;
        AliceType = "Client";
        lstOrganization.Add(org);
        #endregion

        string EncryptedString = string.Empty;
        Attune.Cryptography.CCryptography obj = new Attune.Cryptography.CCryptFactory().GetEncryptor();
        obj.Crypt("abc123", out EncryptedString);

        returnCode = new NewInstance(base.ContextInfo).CreateOrgInstanceQueue(txtClientName.Text, lstOrganization, lstRoleNew, lstVisitPurpose, lstDept, out retStatus, EncryptedString, 0, AliceType, Convert.ToInt32(AliceID));
    }

    public void LoadClientHistory(long ClientID)
    {
        long returncode = -1;
        try
        {
            List<ClientMaster_HIST> lstClientMaster_HIST = new List<ClientMaster_HIST>();
            Master_BL objMaster = new Master_BL(base.ContextInfo);
            returncode = objMaster.GetClientHistory(ClientID, OrgID, out lstClientMaster_HIST);
            if (lstClientMaster_HIST.Count > 0)
            {
                tdHistory.Style.Add("display", "table-cell");
                lblHeaderText.Text = lstClientMaster_HIST[0].ClientName;
            }
            else
            {
            // lblHeaderText.Text = "No History for this client";
                lblHeaderText.Text = Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_031 == null ? "No History for this client" : Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_031;
            }
            grdClientHistory.Visible = true;
            grdClientHistory.DataSource = lstClientMaster_HIST;
            grdClientHistory.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Client History Details", ex);
        }
    }

    public void IsCtParentOrg()
    {
        string CTORG = "N";
        string IsCtParentOrg = "N";
        hdnIsCtParentOrg.Value = "N";
        if (!string.IsNullOrEmpty(GetConfigValue("CTORG", OrgID)))
        {
            CTORG = GetConfigValue("CTORG", OrgID);
        }
        if (CTORG == "Y")
        {
            Schedule_BL objSchBL = new Schedule_BL(base.ContextInfo);
            List<Organization> lstOrganisation = new List<Organization>();
            long lresult = objSchBL.getOrganizations(out lstOrganisation);
            lstOrganisation = lstOrganisation.FindAll(p => p.OrgID == p.ParentOrgID && p.OrgID == OrgID);
            if (lstOrganisation.Count > 0)
            {
                IsCtParentOrg = "Y";
                hdnIsCtParentOrg.Value = "Y";

            }
        }

    }
    public long SendSMS(string CliID)
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();
        long LoginID = -1;
        LoginID = LID;
        PC.PatientID = LoginID;
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.OrgID = OrgID;
        PC.ButtonName = btnFinish.ID;
        PC.ButtonValue = btnFinish.Text;
        PC.ID = Convert.ToInt64(CliID);
        PC.PageID = PageID;// Convert.ToInt64(hdnProtocalID.Value);
        PC.ContextType = ddlClientType.SelectedItem.Text;
        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
    }
    //private string isCtParentOrg = "N";
    //public string IsCtParentOrg
    //{
    //    get {
    //        string CTORG = "N";
    //        if (!string.IsNullOrEmpty(GetConfigValue("CTORG", OrgID)))
    //        {
    //            CTORG = GetConfigValue("CTORG", OrgID);
    //        }
    //        if (CTORG == "Y")
    //        {
    //            Schedule_BL objSchBL = new Schedule_BL(base.ContextInfo);
    //            List<Organization> lstOrganisation = new List<Organization>();
    //            long lresult = objSchBL.getOrganizations(out lstOrganisation);
    //            lstOrganisation = lstOrganisation.FindAll(p => p.OrgID == p.ParentOrgID && p.OrgID == OrgID);
    //            if (lstOrganisation.Count > 0)
    //            {
    //                isCtParentOrg = "Y";
    //            }
    //        } 
    //        return isCtParentOrg;
    //    }
    //    set {

    //        isCtParentOrg = value; 
    //    }
    //}

    //protected void TRFImageUpload_Click(object sender, FileCollectionEventArgs e)
    //{
    //    int ClientID = int.Parse(hdnId.Value);
    //    string FileType = "Client";
    //    string pathname = string.Empty;
    //    long returncode = -1;
    //    pathname = GetConfigValue("TRF_UploadPath", OrgID);
    //    HttpFileCollection oHttpFileCollection = e.PostedFiles;
    //    HttpPostedFile oHttpPostedFile = null;
    //    if (e.HasFiles)
    //    {
    //        for (int n = 0; n < e.Count; n++)
    //        {
    //            oHttpPostedFile = oHttpFileCollection[n];
    //            if (oHttpPostedFile.ContentLength <= 0)
    //                continue;
    //            else
    //            {
    //               string filePath = pathname + System.IO.Path.GetFileName(oHttpPostedFile.FileName);
    //                    oHttpPostedFile.SaveAs(filePath);
    //                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);                     
    //                    returncode = patientBL.SaveClientDocs(filePath, ClientID, FileType,OrgID);

    //                }

    //                if (returncode >= 0)
    //                {
    //                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('File Uploaded Successfully');", true);
    //                    divUpload.Style.Add("Display", "none");
    //                }
    //            }

    //        }
    //    }
    //}

    //public string GetConfigValue(string configKey, int orgID)
    //{
    //    string configValue = string.Empty;
    //    long returncode = -1;
    //    GateWay objGateway = new GateWay(base.ContextInfo);
    //    List<Config> lstConfig = new List<Config>();

    //    returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
    //    if (lstConfig.Count > 0)
    //        configValue = lstConfig[0].ConfigValue;

    //    return configValue;
    //}


    //----Code End---------
    public void GetPrintLocation()
    {
        long returnCode = -1;
        returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
        lAddress = lAddress.FindAll(p => p.IsPrint == "Y");
        ddlPrintLocation.DataSource = lAddress;
        ddlPrintLocation.DataTextField = "City";
        ddlPrintLocation.DataValueField = "AddressID";
        ddlPrintLocation.DataBind();
        ddlPrintLocation.Items.Insert(0, select);
        ddlPrintLocation.Items[0].Value = "0";
        if (lAddress.Exists(p => p.AddressID == ILocationID))
        {
            ddlPrintLocation.SelectedValue = ILocationID.ToString();
        }
    }
    protected void lnkviewtestdetails_Click(object sender, EventArgs e)
    {
        Master_BL objMaster_BL = new Master_BL(base.ContextInfo);
        lstClientDetails = new List<ClientDetails>();
        lstClientDetails1 = new List<ClientDetails>();
         long ClientID = hdnId.Value == "" ? 0 : Convert.ToInt64(hdnId.Value);
         objMaster_BL.GetViewTestDetails(ClientID, OrgID, out lstClientDetails, out lstClientDetails1);
         System.Data.DataTable dt = ConvertToDatatable1(lstClientDetails);
         System.Data.DataTable dt1 = ConvertToDatatable2(lstClientDetails1);
         if (lstClientDetails.Count > 0)
         {
             using (ExcelPackage pck = new ExcelPackage())
             {
                 //Create the worksheet
                 // pck.Workbook.Worksheets.Add("INV_Rates").Protection.IsProtected = true;

                 ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Rates");
                 ExcelWorksheet ws1 = pck.Workbook.Worksheets.Add("RateCards");
                 var tbl = dt;
                 var tbl1 = dt1;
                 //Load the datatable into the sheet, starting from cell A1. Print the column names on row 1

                 ws.Cells["A1"].LoadFromDataTable(tbl, true);

                 //Format the header for column 1-7
                 using (ExcelRange rng = ws.Cells["A1:R1"])
                 {
                     rng.Style.Font.Bold = true;
                     rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                     rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                     rng.Style.Font.Color.SetColor(Color.White);
                 }

                 ws1.Cells["A1"].LoadFromDataTable(tbl1, true);

                 //Format the header for column 1-7
                 using (ExcelRange rng = ws1.Cells["A1:K1"])
                 {
                     rng.Style.Font.Bold = true;
                     rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                     rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                     rng.Style.Font.Color.SetColor(Color.White);
                 }

              



                 //ws.Column(7).Style.Hidden = true;
                 //for (int i = 0; i < dt.Rows.Count; i++)
                 //    ws.Cells["M" + (i + 1)].Style.Hidden = true;

                  
                 var dataRange = ws.Cells[ws.Dimension.Address.ToString()];

                 dataRange.AutoFitColumns();

                 var dataRange1 = ws1.Cells[ws1.Dimension.Address.ToString()];

                 dataRange1.AutoFitColumns();
                 
                 HttpContext.Current.Response.Clear();
                 //Write it back to the client
                 HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                 HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename=" + txtClientCode.Text.Trim() + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");
                 
                 HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                 //HttpContext.Current.ApplicationInstance.CompleteRequest(); 
                 HttpContext.Current.Response.End();

                 //Response.Clear();
                 // //Write it back to the client
                 // Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                 //Response.AddHeader("content-disposition", "attachment;  filename=" + ddlFeeType.SelectedValue + " - " + hdnRateName.Value + " - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");
                 //Response.BinaryWrite(pck.GetAsByteArray());
                 // //HttpContext.Current.ApplicationInstance.CompleteRequest();

                 //  Response.End();
             }
         }


    }
    public static DataTable ConvertToDatatable1(List<ClientDetails> lstClientDetails)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("OrgID");
        dt.Columns.Add("ClientID");
        dt.Columns.Add("ClientCode");
        dt.Columns.Add("ClientName");
        dt.Columns.Add("Test_Attune_Code");

        dt.Columns.Add("Test_Org_Code");
        dt.Columns.Add("Test_EDOS_Code");
        dt.Columns.Add("Test_Type");
        dt.Columns.Add("Test_Name");
        dt.Columns.Add("Discount_Catergory");

        dt.Columns.Add("Base_Rate_Card");
        dt.Columns.Add("Applied_Rate_Card");
        dt.Columns.Add("RateType");
        dt.Columns.Add("Discount_Policy");
        dt.Columns.Add("Discount_Applied");

        dt.Columns.Add("MRP");
        dt.Columns.Add("Rate");
        dt.Columns.Add("Collection_Charges");

        if (lstClientDetails.Count > 0)
        {
            foreach (var item in lstClientDetails)
            {
                dt.Rows.Add(item.OrgId, item.ClientID, item.ClientCode, item.ClientName, item.Test_Attune_Code, item.Test_Org_Code,
                    item.Test_EDOS_Code, item.Test_Type, item.Test_Name, item.Discount_Catergory, item.Base_Rate_Card, item.Applied_Rate_Card,
                    item.RateType, item.Discount_Policy, item.Discount_Applied, item.MRP, item.Rate, item.Collection_Charges);
            }
        }
        return dt;
    }

    public static DataTable ConvertToDatatable2(List<ClientDetails> lstClientDetails)
    {
        DataTable dt = new DataTable();
     
        dt.Columns.Add("ClientID");
        dt.Columns.Add("OrgID");
        
        dt.Columns.Add("ClientName");
        dt.Columns.Add("ClientCode");
        dt.Columns.Add("RateId");

        dt.Columns.Add("RateName");
        dt.Columns.Add("ValidFrom");
        dt.Columns.Add("ValidTo");
        dt.Columns.Add("Priority");
        dt.Columns.Add("PolicyName");

        dt.Columns.Add("BaseRate");      

        if (lstClientDetails.Count > 0)
        {
            foreach (var item in lstClientDetails)
            {
                dt.Rows.Add(item.ClientID, item.OrgId, item.ClientName, item.ClientCode, item.RateId, item.RateName,
                    item.ValidFrom, item.ValidTo, item.Priority, item.PolicyName, item.BaseRate);
            }
        }
        return dt;
    }
    #region Export Excel
    public void ImageBtnExport_Click(object sender, EventArgs e)
    {
        try
        {
            loadgridtoexcel();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }
    }
    public void loadgridtoexcel()
    {
        try
        {
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<ClientMaster> lstinvmasters = new List<ClientMaster>();
            lstinvmasters.Clear();
            long returncode = -1;
            btnFinish.Text = UpdateButton;
            long ClientID = 0;
            //ClientID = clientid;
            returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
            if (lstinvmasters.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstinvmasters);
                gvclientmaster.DataSource = lstinvmasters;
                gvclientmaster.AllowPaging = false;
                gvclientmaster.DataBind();
                ExportToExcel();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }
    }
    public void ExportToExcel()
    {

        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string attachment = "attachment; filename=" + "ClientMaster" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            gvclientmaster.Visible = true;
            gvclientmaster.RenderControl(oHtmlTextWriter);
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
    //Srini Added for Client Logo Starts//
    public void GetClientLogoImage()
    {

        long returnCode = -1;
        long ClientId = Convert.ToInt64(hdnId.Value);
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        Role_BL roleBL = new Role_BL(base.ContextInfo);
        returnCode = roleBL.GetClientLogo(OrgID, ClientId, out login);
        byte[] byteArray = login.ImageSource;
        if (byteArray != null && byteArray.Count() > 0)
        {
            imgView.Visible = true;
            imgView.Attributes.Add("Style", "block");
            imgView.Attributes.Add("Style", "width:42%");
            trflUpload.Attributes.Add("Style", "block");
            //imgView.Src = "ClientLogoHandler.ashx?OrgID=" + OrgID + "&ClientId=" + ClientId;
            imgView.Src = "../Admin/ClientLogoHandler.ashx?OrgID=" + OrgID + "&ClientId=" + ClientId;

        }
        else
        {
            imgView.Visible = false;
        }

    }


    public void UpdateClientLogo(string ClientId)
    {
        long lresult = -1;
        Role_BL roleBL = new Role_BL(base.ContextInfo);
        Attune.Podium.BusinessEntities.Login client = new Attune.Podium.BusinessEntities.Login();
        client.OrgID = OrgID;
        client.LoginID = Convert.ToInt64(ClientId);
        if (flUpload.HasFile)
        {
     if ((flUpload.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload.PostedFile.ContentType == "jpg")
         || (flUpload.PostedFile.ContentType == "image/pjpeg") || (flUpload.PostedFile.ContentType == "image/jpeg"))
            {

                client.ImageSource = flUpload.FileBytes;
                client.FilePath = flUpload.FileName;

            }
            lresult = roleBL.UpdateClientLogo(client);
        }
    }

    protected void btn_ViewLogo(object sender, EventArgs e)
    {
        GetClientLogoImage();
        li11.Attributes.Remove("class");
    }

    //Srini Added for Client Logo Ends//
    #endregion
}
