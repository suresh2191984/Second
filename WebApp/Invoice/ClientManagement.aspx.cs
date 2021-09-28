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
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.ServiceModel.Web;

public partial class Lab_InvocieMaster : BasePage
{
    public static string sFilePath = string.Empty;
    public static string FilePath = string.Empty;
    public Lab_InvocieMaster()
        : base("Invoice\\ClientMaster.aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
        GetClientType();
        GetPrintLocation();
        LoadMetaData();
        GetAddressType();
        GetGroupValues();
        LoadReason();
        LoadCurrency();
        loadOrderableLocation();
        loadReasonDetails();
        LoadCountry();
        GetTabDetails();
        Load_ddlTaxDetails();
        sFilePath = GetConfigValue("RateDocumentUpload", OrgID).Replace("\\", "-");
        FilePath = GetConfigValue("RateDocumentUpload", OrgID);
        
    }
    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        ddlCountry.Items.Clear();
        try
        {
            returnCode = countryBL.GetCountryList(out countries);
            ddlCountry.DataSource = countries;
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryID";
            ddlCountry.DataBind();
            ddlCountry.Items.Insert(0, "--Select--");
            ddlCountry.Items[0].Value = "0";

            var DefaultCountry = (from n in countries
                                  where n.IsDefault == "Y"
                                  select n.CountryID).FirstOrDefault();
            ddlCountry.SelectedValue = DefaultCountry.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    
    public void Load_ddlTaxDetails()
    {
        chkIsActive.Checked = true;
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
                ddlTaxDetails.Items.Insert(0, "--Select--");
                ddlTaxDetails.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to Load ddlTaxDetails", ex);
        }
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
           // lstInvClientType.RemoveAll(p => p.IsInternal == "N");
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
                ddlClientType.Items.Insert(0, "--Select--");
                ddlClientType.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get Get InvClientType", ex);
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

    public  void GetPrintLocation()
    {
        long returnCode = -1;
        Deployability_BL DeployabilityBL = new Deployability_BL();
        List<LocationPrintMap> lAddress = new List<LocationPrintMap>();
        returnCode = DeployabilityBL.GetLocationPrinter(OrgID, 0,"",out lAddress);
        ddlPrintLocation.DataSource = lAddress;
        ddlPrintLocation.DataTextField = "PrinterName";
        ddlPrintLocation.DataValueField = "OrgAddressID";
        ddlPrintLocation.DataBind();
        ddlPrintLocation.Items.Insert(0, "--Select--");
        ddlPrintLocation.Items[0].Value = "0";
        if (lAddress.Exists(p => p.OrgAddressID == ILocationID))
        {
            ddlPrintLocation.SelectedValue = ILocationID.ToString();
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
                ddlAddressType.DataSource = lstAddressType;
                ddlAddressType.DataValueField = "TypeID";
                ddlAddressType.DataTextField = "TypeName";
                ddlAddressType.DataBind();
                ddlAddressType.Items.Insert(0, "--Select--");
                ddlAddressType.Items[0].Value = "0";
            }

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
                ddlContactType.DataSource = lstEmpDeptMaster;
                ddlContactType.DataValueField = "Code";
                ddlContactType.DataTextField = "EmpDeptName";
                ddlContactType.DataBind();
                ddlContactType.Items.Insert(0, "--Select--");
                ddlContactType.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Despatch Mode", ex);
        }
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ClientAttributeType,CutOffTimeType,Department,InvoiceCycle,ClientStatus,RegistrationType,SpecialPrevileges,ClientAction,ReportAttCat,DiscountTaxType,ClientPaymentCategory,CMNotifyType,CMNotifyMode";
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
                    ddlAttributesType.DataSource = childItems;
                    ddlAttributesType.DataTextField = "DisplayText";
                    ddlAttributesType.DataValueField = "Code";
                    ddlAttributesType.DataBind();
                    ddlAttributesType.Items.Insert(0, "--Select--");
                    ddlAttributesType.Items[0].Value = "0";

                    var InvoiceCycle = from IC in lstmetadataOutput
                                       where IC.Domain == "InvoiceCycle"
                                       orderby IC.MetaDataID ascending
                                       select IC;
                    ddlInvoiceCycle.DataSource = InvoiceCycle;
                    ddlInvoiceCycle.DataTextField = "DisplayText";
                    ddlInvoiceCycle.DataValueField = "Code";
                    ddlInvoiceCycle.DataBind();
                    ddlInvoiceCycle.Items.Insert(0, "--Select--");
                    ddlInvoiceCycle.Items[0].Value = "0";

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "CutOffTimeType"
                                      orderby child.MetaDataID ascending
                                      select child;
                    ddlTransitTime.DataSource = childItems1;
                    ddlTransitTime.DataTextField = "DisplayText";
                    ddlTransitTime.DataValueField = "Code";
                    ddlTransitTime.DataBind();
                    ddlTransitTime.Items.Insert(0, "--Select--");
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
                    var childItems3 = from child in lstmetadataOutput
                                      where child.Domain == "ClientStatus"
                                      orderby child.MetaDataID ascending
                                      select child;
                    //tdlblCStatus.Style.Add("display", "table-cell");
                    // tdClientStatus.Style.Add("display", "table-cell");
                    ddlClientStatus.DataSource = childItems3;
                    ddlClientStatus.DataTextField = "DisplayText";
                    ddlClientStatus.DataValueField = "Code";
                    ddlClientStatus.DataBind();
                    ddlClientStatus.Items.Insert(0, "--Select--");
                    ddlClientStatus.Items[0].Value = "0";

                    var childItems4 = from child in lstmetadataOutput
                                      where child.Domain == "RegistrationType"
                                      orderby child.MetaDataID ascending
                                      select child;
                    ddlRegistrationType.DataSource = childItems4;
                    ddlRegistrationType.DataTextField = "DisplayText";
                    ddlRegistrationType.DataValueField = "Code";
                    ddlRegistrationType.DataBind();
                    //ddlRegistrationType.Items.Insert(0, "--Select--");
                    //ddlRegistrationType.Items[0].Value = "0";

                      var childItems5 = from child in lstmetadataOutput
                                        where child.Domain == "SpecialPrevileges"
                                      orderby child.MetaDataID ascending
                                      select child;
                      ddlSplPrivileges.DataSource = childItems5;
                      ddlSplPrivileges.DataTextField = "DisplayText";
                      ddlSplPrivileges.DataValueField = "Code";
                      ddlSplPrivileges.DataBind();
                      ddlSplPrivileges.Items.Insert(0, "--Select--");
                      ddlSplPrivileges.Items[0].Value = "0";


                      var childItems6 = from child in lstmetadataOutput
                                        where child.Domain == "ClientAction"
                                        orderby child.MetaDataID ascending
                                        select child;
                      ddlAction.DataSource = childItems6;
                      ddlAction.DataTextField = "DisplayText";
                      ddlAction.DataValueField = "Code";
                      ddlAction.DataBind();
                      ddlAction.Items.Insert(0, "--Select--");
                      ddlAction.Items[0].Value = "0";
                      //var childItems7 = from child in lstmetadataOutput 
                      //                  where child.Domain == "ReportAttCat"
                      //                  orderby child.MetaDataID ascending
                      //                  select child;
                      //ddlCategory.DataSource = childItems7;
                      //ddlCategory.DataTextField = "DisplayText";
                      //ddlCategory.DataValueField = "Code";
                      //ddlCategory.DataBind();

                     var childItems8= from child in lstmetadataOutput
                                      where child.Domain == "DiscountTaxType"
                                        orderby child.MetaDataID ascending
                                        select child;
                     ddlType.DataSource = childItems8;
                     ddlType.DataTextField = "DisplayText";
                     ddlType.DataValueField = "Code";
                     ddlType.DataBind();
                     ddlType.Items.Insert(0, "--Select--");
                     ddlType.Items[0].Value = "0";

                     var childItems9 = from child in lstmetadataOutput
                                       where child.Domain == "ClientPaymentCategory"
                                       orderby child.MetaDataID ascending
                                       select child;
                     ddlPaymentCategory.DataSource = childItems9;
                     ddlPaymentCategory.DataTextField = "DisplayText";
                     ddlPaymentCategory.DataValueField = "Code";
                     ddlPaymentCategory.DataBind();
                     ddlPaymentCategory.Items.Insert(0, "--Select--");
                     ddlPaymentCategory.Items[0].Value = "0";

                     var childItems10 = from child in lstmetadataOutput
                                        where child.Domain == "CMNotifyType"
                                       orderby child.MetaDataID ascending
                                       select child;
                     ddlNotifications.DataSource = childItems10;
                     ddlNotifications.DataTextField = "DisplayText";
                     ddlNotifications.DataValueField = "Code";
                     ddlNotifications.DataBind();
                     ddlNotifications.Items.Insert(0, "--Select--");
                     ddlNotifications.Items[0].Value = "0";


                     var childItems11 = from child in lstmetadataOutput
                                        where child.Domain == "CMNotifyMode"
                                        orderby child.MetaDataID ascending
                                        select child;
                     ddlCommunicationMode.DataSource = childItems11;
                     ddlCommunicationMode.DataTextField = "DisplayText";
                     ddlCommunicationMode.DataValueField = "Code";
                     ddlCommunicationMode.DataBind();
                     ddlCommunicationMode.Items.Insert(0, "--Select--");
                     ddlCommunicationMode.Items[0].Value = "0";
                   
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);

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

            ddlReason.DataSource = lstmetavalue;
            ddlReason.DataTextField = "Value";
            ddlReason.DataValueField = "Code";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, "---Select---");
            ddlReason.Items[0].Value = "0";
        }
       
    }
    void loadReasonDetails()
    {
        long returnCode = -1;
        List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
        Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
        string Reftypes = "CM";
        returnCode = objReasonMaster.GetReasonMaster(0, 0, Reftypes, out lstReasonMaster);

        if (lstReasonMaster.Count > 0)
        {
            ddlReasonForSave.DataSource = lstReasonMaster;
            ddlReasonForSave.DataTextField = "Reason";
            ddlReasonForSave.DataValueField = "Reason";
            ddlReasonForSave.DataBind();
            ddlReasonForSave.Items.Insert(0, "--Select--");
            ddlReasonForSave.Items[0].Value = "0";
            ddlReasonForSave.SelectedValue = "0";
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
                
                foreach (ClientAttributes m in lstclientattrib.FindAll(p => p.AttributesType == "Notify"))
                {
                    ListItem lstItem = new ListItem(m.AttributeName, m.AttributeID.ToString(), true);
                    lstItem.Attributes.Add("AttributeID", m.AttributeID.ToString());
                    if (m.AttributeName == "Report Print")
                    {
                        lstItem.Attributes.Add("onclick", "ReportPrintChanged(this.id);");
                        
                    }
                    chkNotification.Items.Add(lstItem);
                }
               
                ddlStationery.DataSource = lstclientattrib.FindAll(p => p.AttributesType == "Stationery");
                ddlStationery.DataTextField = "AttributeName";
                ddlStationery.DataValueField = "AttributeID";
                ddlStationery.DataBind();
                ddlStationery.Items.Insert(0, "--Select--");
                ddlStationery.Items[0].Value = "0";

                JavaScriptSerializer Objserializer = new JavaScriptSerializer();
                hdnlstStationery.Value = Objserializer.Serialize(lstclientattrib.FindAll(p => p.AttributesType == "Stationery"));


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
                ddlBusinessType.DataSource = lstmetavalue;
                ddlBusinessType.DataTextField = "Value";
                ddlBusinessType.DataValueField = "MetaValueID";
                ddlBusinessType.DataBind();
                ddlBusinessType.Items.Insert(0, "--Select--");
                ddlBusinessType.Items[0].Value = "0";
                ddlBusinessType.SelectedValue = setID;
            }
            //if (lstactiontype.Count > 0)
            //{
            //    var Client = lstactiontype.FindAll(p => p.Type == "Client");
            //    chkDespatch.DataSource = Client;
            //    chkDespatch.DataTextField = "ActionType";
            //    chkDespatch.DataValueField = "ActionTypeID";
            //}
            if (lstrptmaster.Count > 0)
            {
                ddlDescription.DataSource = lstrptmaster;
                ddlDescription.DataTextField = "ReportTemplateName";
                ddlDescription.DataValueField = "TemplateID";
                ddlDescription.DataBind();
                ddlDescription.Items.Insert(0, "--Select--");
                ddlDescription.Items[0].Value = "0";
            }
            else
            {
                ddlDescription.Items.Insert(0, "--Select--");
                ddlDescription.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    public void LoadCurrency()
    {
        Master_BL BL = new Master_BL();
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
         int BaseCurrencyID = -1;
         string BaseCurrencyCode = string.Empty;
         BL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
        if (lstCurrencyMaster.Count > 0)
        {
            ddlCurrencyType.DataSource = lstCurrencyMaster;
            ddlCurrencyType.DataTextField = "CurrencyName";
            ddlCurrencyType.DataValueField = "CurrencyID";
            ddlCurrencyType.DataBind();
            ddlCurrencyType.Items.Insert(0, "--Select--");
            ddlCurrencyType.Items[0].Value = "0";
            ddlCurrencyType.SelectedValue = BaseCurrencyID.ToString();
            hdnbaseCurrencyID.Value = BaseCurrencyID.ToString();
        }
    }
    public void loadOrderableLocation()
    {
        Deployability_BL BL = new Deployability_BL();
        List<OrganizationAddress> lstLocationMaster = new List<OrganizationAddress>();
        List<EmployeeMaster> lstEmployeeMaster = new List<EmployeeMaster>();
        BL.GetOrderableLocation(OrgID, out lstLocationMaster, out lstEmployeeMaster);
        if (lstLocationMaster.Count > 0)
        {
            foreach (OrganizationAddress m in lstLocationMaster)
            {
                ListItem lstItemOL = new ListItem(m.Location, m.AddressID.ToString(), true);
                lstItemOL.Attributes.Add("OrgID", m.AddressID.ToString());
                chklstOrderableLocation.Items.Add(lstItemOL);
            }
            
            
        }
        //if (lstEmployeeMaster.Count > 0)
        //{
        //    ddlAccountHolder.DataSource = lstEmployeeMaster;
        //    ddlAccountHolder.DataTextField = "Name";
        //    ddlAccountHolder.DataValueField = "ID";
        //    ddlAccountHolder.DataBind();
        //    ddlAccountHolder.Items.Insert(0, "--Select--");
        //    ddlAccountHolder.Items[0].Value = "0";
        //}
    }

    public void GetTabDetails()
    {

        object Obj;
        DataTable tblTabDetails = new DataTable();
        long returnCode = -1;
        List<TabMaster> lstTabDetails = new List<TabMaster>();
        returnCode =new Deployability_BL(new BaseClass().ContextInfo).GetClientTabMappingDetails(out lstTabDetails);
        Utilities.ConvertFrom(lstTabDetails, out tblTabDetails);


        foreach (DataRow drOutputList in tblTabDetails.Rows)
        {
            hdnTabAccessdetails.Value += Convert.ToString(drOutputList["Code"]) + '(' + Convert.ToString(drOutputList["HasAccess"]) + ")~";
            string ID = Convert.ToString(drOutputList["Code"]);
            HtmlGenericControl ili = new HtmlGenericControl("li");
            ili.ID = drOutputList["Code"].ToString();
            ili.Attributes.Add("onclick", "ShowTabContent('" + ID + "')");

            if (Convert.ToString(drOutputList["Isdefault"]) == "True")
            {
                hdnBasicTab.Value = ID;
            }
            if (Convert.ToString(drOutputList["HasAccess"]) == "False")
            {
                hdnReadOnlyTab.Value += ID + '~';
            }

            ulTabsMenu.Controls.Add(ili);
            HtmlGenericControl ianchor = new HtmlGenericControl("a");
                ianchor.Attributes.Add("href", "#");
                var span = new HtmlGenericControl("span");
                span.InnerHtml = Convert.ToString(drOutputList["Name"]);
                ianchor.Controls.Add(span);
                ili.Controls.Add(ianchor);
        }
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static void AddNewPrinter(string txtCode, string hdnOrgAddressID, String txtPrinterName, int OrgID)
    {
        long returncode = -1;
        Deployability_BL Deployability_BL = new Deployability_BL(new BaseClass().ContextInfo);
        List<LocationPrintMap> lAddress = new List<LocationPrintMap>();
        JavaScriptSerializer js = new JavaScriptSerializer();
        LocationPrintMap objLocationPrintMap = new LocationPrintMap();
        if (txtCode == "")
            objLocationPrintMap.Code = 0;
        else
            objLocationPrintMap.Code = Convert.ToInt64(txtCode.Trim());

        objLocationPrintMap.PrinterName = txtPrinterName;
        string pCodeStr = "";
        if (hdnOrgAddressID == "")
            hdnOrgAddressID = "0";
        int pOrgAddressID = Convert.ToInt32(hdnOrgAddressID);
        try
        {
            if (txtPrinterName != "")
            {
                returncode = Deployability_BL.SaveLocationPrintMapDetails(OrgID, pCodeStr, pOrgAddressID, objLocationPrintMap);
            }
            
           // Deployability_BL.GetLocationPrinter(OrgID, 0, out lAddress);

            txtCode = "";
            txtPrinterName = "";
            hdnOrgAddressID = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdLocationPrinter Save", ex);
        }
        
        
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetInvoiceClientDetails(int ClientID, String ClientName, int ILocationID, String ClientCode, int OrgID)
    {
        Deployability_BL masterbl = new Deployability_BL(); ;
        List<ClientMaster> lstinvmasters = new List<ClientMaster>();
        lstinvmasters.Clear();
        masterbl.GetInvoiceClientDetails(OrgID, ILocationID, ClientName, ClientCode, ClientID, out lstinvmasters);
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(lstinvmasters);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<ClientMaster> GetAssociateClient(int OrgId, int ClientId)
    {
        long returnvalue = -1;
        Deployability_BL DeployabilityBL = new Deployability_BL();
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        returnvalue = DeployabilityBL.GetAssociatedClientDetails(OrgId, ClientId, out lstClientMaster);
        return lstClientMaster;
    }
  
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetClientNameAutocomplete(string prefixText, string contextKey, int orgID)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientMaster = new List<ClientMaster>();
        List<string> items = new List<string>();
        if (contextKey != "")
        {
            int ClientTypeID = Convert.ToInt32(contextKey);
            Master_BL.GetHospAndRefPhy(orgID, "", ClientTypeID, out lstClientMaster);
        }
        var query = from c in lstClientMaster
                    where c.ClientName.ToLower().Contains(prefixText.ToLower()) || c.ClientCode.ToLower().Contains(prefixText.ToLower())
                    select new { c.ClientName,c.ClientID,c.Status };
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(query);
        return strout;
    }


    #region GetHubDetails [GetHubDetails] 
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetHubDetails(string prefixText, string contextKey, int orgID)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        string Code = string.Empty;
        Code = contextKey.ToString();
        Master_BL.GetGroupMasterDetails(orgID, "Hub", prefixText, out lstLocalities);
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(lstLocalities);
        return strout;
    }
    #endregion

    #region GetLocationDetails [GetLocationDetails]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetLocationDetails(string prefixText, String contextKey, int orgID)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<OrganizationAddress> lstorgaddress = new List<OrganizationAddress>();
        Master_BL.GetCollectionCentreMaster(orgID, prefixText, out lstorgaddress);
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(lstorgaddress);
        return strout;
    }
    #endregion

    #region GetZoneDetails [GetZoneDetails]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetZoneDetails(string prefixText, string contextKey, int HubID,int orgID)
    {
            Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
            List<Localities> lstLocalities = new List<Localities>();
            if (contextKey != "")
            {
                Master_BL.GetZoneDetails(orgID, "zone", prefixText, HubID, out lstLocalities);
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lstLocalities);
            return strout;
    }
    #endregion

    #region GetRouteNames [GetRouteNames]
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static string GetRouteNames(string prefixText, string contextKey, int ZoneID, int orgID)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        if (contextKey != "")
        {
            Master_BL.GetRouteNames(orgID, "route", prefixText, ZoneID, out lstLocalities);
        }
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(lstLocalities);
        return strout;
    }
    #endregion


    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static string GetAddressDetails(int OrgID,String PostalCode)
    {
        Deployability_BL masterbl = new Deployability_BL(); ;
        List<AddressDetails> lstAddressmasters = new List<AddressDetails>();
        masterbl.GetAddressDetails(OrgID,PostalCode, out lstAddressmasters);
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(lstAddressmasters);
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static List<ClientBasicGridDetails> GetClientMasterDetails(int OrgId, int ClientId, String ClientCode)
    {
        long returnvalue = -1;
        Deployability_BL DeployabilityBL = new Deployability_BL();
        List<ClientBasicGridDetails> lstClientMaster = new List<ClientBasicGridDetails>();
        returnvalue = DeployabilityBL.GetClientMasterDetails(OrgId, ClientId,ClientCode, out lstClientMaster);
        return lstClientMaster;
    }

    [WebMethod]
    public static String RemoveDocDetails(string searchtext, string type)
    {
        try
        {
            {
                DirectoryInfo diSource = new DirectoryInfo(FilePath);

                foreach (FileInfo file in diSource.GetFiles(@"*.*"))
                {
                    string FileName = file.Name.Trim();
                    string FileNameExt = Path.GetFileNameWithoutExtension(FileName);
                    if (FileNameExt == searchtext)
                    {
                        System.IO.File.Delete(file.FullName);

                    }
                }
            }

            return "";
        }
        catch (Exception ex)
        { throw ex; }
    }


    [WebMethod(EnableSession = true)]
    public static long SaveTypeDetails(string lstInvestigationDetail, String UpdateDate, String Reason)
    {
        try
        {
            long Returncode = -1;
            Deployability_BL objMetaData_BL = new Deployability_BL(new BaseClass().ContextInfo);
            List<FileUploadDetails> lstInvestigationDetails = new JavaScriptSerializer().Deserialize<List<FileUploadDetails>>(lstInvestigationDetail);
            Returncode = objMetaData_BL.InsertDocData(lstInvestigationDetails, Convert.ToDateTime(UpdateDate), Reason);
            return Returncode;

        }
        catch (Exception ex)
        {
            return 1;
        }
    }

    [WebMethod]
    public static string GetUploadDocDetails(int FileDetails)
    {
        try
        {
            long returnvalue = -1;
            List<FileUploadDetails> lstUploadDocDetail = new List<FileUploadDetails>();
            Deployability_BL objMetaData_BL = new Deployability_BL(new BaseClass().ContextInfo);
            returnvalue = objMetaData_BL.GetUploadDocDetail(FileDetails, out lstUploadDocDetail);
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lstUploadDocDetail);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }
    }

    [WebMethod]
    public static string GetTODCodeAndID(string prefixText, string contextKey, int orgID)
    {
        Referrals_BL objReferral = new Referrals_BL(new BaseClass().ContextInfo);
        List<DiscountPolicy> lstDiscountPolicy = new List<DiscountPolicy>();
        List<string> items = new List<string>();
        int count = 0;
        int ExecuteType = 0;
        if (contextKey == "TOD" || contextKey == "TAX" || contextKey == "DCP" || contextKey == "TOV")
            ExecuteType = 1;
        objReferral.GetCheckCode(contextKey, prefixText, ExecuteType, out count, orgID, out lstDiscountPolicy);
        JavaScriptSerializer js = new JavaScriptSerializer();
      return  js.Serialize(lstDiscountPolicy);
    }
    [WebMethod(EnableSession = true)]
    public static string GetPrinterLocation(int OrgID)
    {
        try
        {
            long returnCode = -1;
            Deployability_BL DeployabilityBL = new Deployability_BL();
            List<LocationPrintMap> lAddress = new List<LocationPrintMap>();
            returnCode = DeployabilityBL.GetLocationPrinter(OrgID, 0,"", out lAddress);

            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lAddress);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }


    }
    [WebMethod(EnableSession = true)]
    public static string LoadState(int countryID)
    {
        
        try
        {
            List<State> states = new List<State>();
            State_BL stateBL = new State_BL(new BaseClass().ContextInfo);
            State selectedState = new State();
            long returnCode = -1;
        
            returnCode = stateBL.GetStateByCountry(countryID, out states);
            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(states);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }
        
    }
    [WebMethod(EnableSession = true)]
    public static void RemovePrinterLocation(long OrgID, int OrgAddressID)
    {
        long returnCode = -1;
        try
        {
            Deployability_BL DeployabilityBL = new Deployability_BL();
            returnCode = DeployabilityBL.DeleteLocationPrintMapDetails(OrgID, OrgAddressID);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdLocationPrinter_RowDelete Event()", ex);
        }
    }
    [WebMethod]
    public static string GetDiscountConfig(string Drop, int OrgID)
    {

        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(Drop, OrgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
    [WebMethod]
    public static string GetSPOCName(string prefixText, string contextKey, int orgID)
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        Referrals_BL objReferral = new Referrals_BL(new BaseClass().ContextInfo);
        string DeptCode = contextKey;
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();

        Master_BL.GetSpecifiedDeptEmployee(orgID, DeptCode, prefixText, out lstEmployeeRegMaster);
        JavaScriptSerializer js = new JavaScriptSerializer();
        return js.Serialize(lstEmployeeRegMaster);
    }
    [WebMethod]
    [WebInvoke(Method="POST",RequestFormat=WebMessageFormat.Json,ResponseFormat=WebMessageFormat.Json,BodyStyle=WebMessageBodyStyle.WrappedRequest, UriTemplate="btnFinalSaveContents")]
   public static string btnFinalSaveContents(Hashtable[] Details, List<ClientBasicDetails> lstBasicDetails, List<AddressDetails> lstContactcAndShipping,
        List<ClientCreditDetails> lstCreditDetails, List<ClientCommunication> lstClientCommunication, List<ClientTaxMaster> lstTaxDetails,
        List<ClientDiscountPolicyMapping> lstDiscountPolicy, List<ClientAttributesDetails> lstClientAttributes, List<FileUploadDetails> lstDocUpload)
    {
        long ClientID,ReportTemplateID,returnCode = -1, NewClientID = -1;
        string ClientCode, ClientName, Termsconditions, ReasonForUpdate, TabDesiable;
        DateTime ReportPrintFrom;

        var AttributeDetails = Convert.ToString(Details[0]["AttributeDetails"]);
        ClientID = Convert.ToInt64(Details[0]["ClientID"]);
        ReportTemplateID = Convert.ToInt64(Details[0]["ReportTemplateID"]);
        ClientCode = Convert.ToString(Details[0]["ClientCode"]);
        ReasonForUpdate = Convert.ToString(Details[0]["ReasonForUpdate"]);
        ClientName = Convert.ToString(Details[0]["ClientName"]);
        ReportPrintFrom = Convert.ToDateTime(Details[0]["ReportPrintdate"]);
        Termsconditions = Convert.ToString(Details[0]["Termsconditions"]);
        TabDesiable = Convert.ToString(Details[0]["TabDesiable"]);
               Deployability_BL objClientMaster = new Deployability_BL(new BaseClass().ContextInfo);
               returnCode = objClientMaster.InsertInvoiceClientDetails(ClientID, ClientCode, ClientName, ReportTemplateID, AttributeDetails, Termsconditions,
               ReasonForUpdate, ReportPrintFrom, TabDesiable, lstBasicDetails, lstContactcAndShipping, lstClientAttributes, lstClientCommunication, lstCreditDetails, lstDiscountPolicy, lstTaxDetails, lstDocUpload, out NewClientID);
               string RedirectValues = ClientName + '~' + ClientCode + '~' + NewClientID + '~' + returnCode;
        return RedirectValues;

    }
    [WebMethod(EnableSession = true)]
    public static string GetCheckClientCode(string CodeType, string Code)
    {
        long returnCode = -1;
        int Count = -1;
        Referrals_BL referralBL = new Referrals_BL(new BaseClass().ContextInfo);
        int OrgID = -1;
        List<DiscountPolicy> lstDisCountPolicy = null;
        int ExecuteType = 0;
        returnCode = referralBL.GetCheckCode(CodeType, Code, ExecuteType, out Count, OrgID, out lstDisCountPolicy);
        
        JavaScriptSerializer js = new JavaScriptSerializer();
        string strout = js.Serialize(Count);
        return strout;
        
    }
       
}
