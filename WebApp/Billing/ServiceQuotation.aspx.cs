﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Web.Script.Serialization;
using System.Xml;

public partial class Billing_ServiceQuotation : BasePage
{
    string strSelect = Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_03 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_03;
    public Billing_ServiceQuotation()
        : base("Billing_ServiceQuotation_aspx")
    {
    }

    List<Salutation> lstTitles = new List<Salutation>();
    List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    List<Country> lstNationality = new List<Country>();
    List<Country> lstCountries = new List<Country>();
    List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Patient objPatient = new Patient();
    FinalBill objFinalBill = new FinalBill();
    public string save_mesge = Resources.AppMessages.Save_Message;
    string AgeUnit = string.Empty, BillNumber = string.Empty, Labno = string.Empty, pathname = string.Empty;
    int AgeValue = 0, ClientID = 0; long bookingID = -1;
    bool isADD;

    #region "Common Resource Property"

    string strAlert = Resources.Billing_AppMsg.Billing_Header_Alert == null ? "Alert" : Resources.Billing_AppMsg.Billing_Header_Alert;
    string strError = Resources.Billing_AppMsg.Billing_ServiceQuotation_aspx_05 == null ? "Error While Saving Data" : Resources.Billing_AppMsg.Billing_ServiceQuotation_aspx_05;

    #endregion
    #region "Initial"
	
   
   
 protected void Page_Load(object sender, EventArgs e)
    {
        ddlRate.Items.Insert(0, strSelect.Trim());
        hdnOrgID.Value = OrgID.ToString();
        ddSalutation.Focus();
        billPart.BillingPageType = "Service";
     // Added by Jayaramanan 13/08/2018
     if((Request.QueryString["Name"] != null) && (Request.QueryString["Name"] != ""))
     {
         this.txtName.Text = Request.QueryString["Name"].ToString().ToUpper();
     }
     if ((Request.QueryString["Age"] != null) && (Request.QueryString["Age"] != ""))
     {
        this.txtDOBNos.Text = Request.QueryString["Age"];
     }
     if ((Request.QueryString["MobileNo"] != null) && (Request.QueryString["MobileNo"] != ""))
     {
        this.txtMobileNumber.Text = Request.QueryString["MobileNo"];
     }
     if ((Request.QueryString["Doctor"] != null) && (Request.QueryString["Doctor"] != ""))
     {
        this.txtInternalExternalPhysician.Text = Request.QueryString["Doctor"].ToString().ToUpper();
     }
        
        
        
        
     //
        if (!IsPostBack)
        {
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
            ddlSex.Attributes.Add("onchange", "setSexValueoptLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            LoadQuickBillLoading();
            string strRate = GetConfigValue("ShowRateType", OrgID);
            string rval, roundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            hdnDefaultRoundoff.Value = rval;
            hdnRoundOffType.Value = roundpattern;
        }
    }
    #endregion
 

    #region "Events"
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        long returnCode;
        Save(out returnCode);
        if (returnCode > 0)
        {
            if (chkboxPrintQuotation.Checked == true)
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Saved successfully", "alert('" + save_mesge + "BookingID:" + returnCode + "');", true);
              //  ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:PrintBillDetails(" + returnCode + ");", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey3", "javascript:PrintBillDetails(" + returnCode + ");", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Saved successfully", "ValidationWindow('" + save_mesge + "BookingID:" + returnCode + "," + strAlert.Trim() + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:ServiceQuotationClearControls();PrintBillClear();", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow('" + strError.Trim() + "," + strAlert.Trim() + "');", true);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "clearcontent", "clearSQControls(0);", true);

    }

    protected void btnSaveBook_Click(object sender, EventArgs e)
    {
        long returnCode;
        Save(out returnCode);
        if (returnCode > 0)
        {
            if (chkboxPrintQuotation.Checked == true)
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Saved successfully", "alert('" + save_mesge +"BookingID:"+ returnCode+ "');", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:PrintBillDetails(" + returnCode + ");", true);

            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Saved successfully", "ValidationWindow('" + save_mesge + "BookingID:" + returnCode + "," + strAlert.Trim() + "');", true);
                ScriptManager.RegisterStartupScript(Page, GetType(), "", "javascript:ServiceQuotationClearControls();PrintBillClear();", true);
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "ValidationWindow('" + strError.Trim() + "," + strAlert.Trim() + "');", true);
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "clearcontent", "clearSQControls(0);", true);

    }
    #endregion
    #region "Methods"
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
    public void Save(out long bookingID)
    {
        bookingID = 0;
        try
        {
            Int16 age = 0;
            long returnCode = -1;
            DateTime DOB = new DateTime();
            List<Bookings> lstBookings = new List<Bookings>();
            Bookings oBookings = new Bookings();
            string[] SplitAge;
            objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            SplitAge = objPatient.Age.Split('~');
            AgeValue = Convert.ToInt32(SplitAge[0]);
            if (SplitAge[1].Trim() == "Day(s)")
            {
                AgeUnit = "D";
            }
            else if (SplitAge[1].Trim() == "Week(s)")
            {
                AgeUnit = "W";
            }
            else if (SplitAge[1].Trim() == "Month(s)")
            {
                AgeUnit = "M";
            }
            else
            {
                AgeUnit = "Y";
            }
            if (tDOB.Text == "")
            {
                tDOB.Text = hdnPatientDOB.Value;
            }
            oBookings.TokenNumber = 0;
            oBookings.CreatedBy = LID;
            oBookings.OrgID = OrgID;
            oBookings.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            oBookings.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            oBookings.PatientName = txtName.Text.Trim().ToString().ToUpper();
            oBookings.SEX = ddlSex.SelectedValue;
            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            oBookings.DOB = Convert.ToDateTime(Date);
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            string pAge = string.Empty;
            pAge = txtDOBNos.Text + " " + ddlDOBDWMY.SelectedValue.ToString();
            oBookings.Age = pAge;
            //oBookings.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            oBookings.PhoneNumber = txtMobileNumber.Text.Trim();
            oBookings.LandLineNumber = txtPhone.Text.Trim();
            oBookings.EMail = txtEmail.Text.Trim().ToString();
            oBookings.FeeType = txtClient.Text;
            oBookings.RefPhysicianName = hdnReferedPhyID.Value;
            oBookings.SourceType = "Service Quotation";
            ClientID = Convert.ToInt32(hdnSelectedClientClientID.Value);
            DateTime CollectionTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            oBookings.ClientID = ClientID;
            hdnQuotesGivenBy.Value = _LoginName.ToString();
            hdnQuotesDate.Value = OrgDateTimeZone;

            oBookings.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
            oBookings.CollectionTime = CollectionTime;

            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            string gUID = string.Empty;
            lstInv = billPart.GetOrderedInvestigations(-1, out gUID);

            oBookings.BillDescription = CreateBookingXML(lstInv);

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, OrgID, LID, out  bookingID);
            hdnId.Value = bookingID.ToString();
            returnCode = bookingID;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }
    }
  
   
    string CreateBookingXML(List<OrderedInvestigations> lstInv)
    {
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<AmtDetails></AmtDetails>");
        XmlNode xmlNode;
        string BillDescription;

        for (int i = 0; i < lstInv.Count; i++)
        {
            XmlElement xmlElement = Doc.CreateElement("BillDescription");

            xmlNode = Doc.CreateNode(XmlNodeType.Element, "FeeID", lstInv[0].ID.ToString());
            xmlElement.AppendChild(xmlNode);

            xmlNode = Doc.CreateNode(XmlNodeType.Element, "FeeType", lstInv[0].Type.ToString());
            xmlElement.AppendChild(xmlNode);

            xmlNode = Doc.CreateNode(XmlNodeType.Element, "Descrip", lstInv[0].Name.ToString());
            xmlElement.AppendChild(xmlNode);

            xmlNode = Doc.CreateNode(XmlNodeType.Element, "Rate", lstInv[0].Rate.ToString());
            xmlElement.AppendChild(xmlNode);

            Doc.DocumentElement.AppendChild(xmlElement);
        }
        return Doc.InnerXml;
    }
    #region PageLoadingData

    public void LoadQuickBillLoading()
    {
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        List<Country> lstCountries = new List<Country>();

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        LoadTitle(lstTitles);
        LoadMeatData();
        loadRateType();
        loadClient();
    }

    private void LoadTitle(List<Salutation> lstTitles)
    {
        try
        {
            int titleID = 0;
            List<Salutation> titles = new List<Salutation>();
            Salutation selectedSalutation = new Salutation();

            ddSalutation.DataSource = lstTitles;
            ddSalutation.DataTextField = "TitleName";
            ddSalutation.DataValueField = "TitleID";
            ddSalutation.DataBind();
            selectedSalutation = lstTitles.Find(Findsalutation);
            ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadTitle() Method in Lab Quick Billing", ex);
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }
    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus";
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
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }
                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  select child;
                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, strSelect.Trim());
                    ddlSex.Items[0].Value = "0";
                    
                }
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "MaritalStatus"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    ddMarital.DataSource = childItems2;
                    ddMarital.DataTextField = "DisplayText";
                    ddMarital.DataValueField = "Code";
                    ddMarital.DataBind();
                    ddMarital.Items.Insert(0, strSelect.Trim());
                    ddMarital.Items[0].Value = "0";
                    ddMarital.SelectedValue = "S";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);
        }
    }

    public void loadClient()
    {
        string strClientAssOrg = Resources.Billing_AppMsg.Billing_ServiceQuotation_aspx_06 == null ? "No general Client associated this Organisation" : Resources.Billing_AppMsg.Billing_ServiceQuotation_aspx_06;
        SharedInventorySales_BL inventorySalesBL = new SharedInventorySales_BL(base.ContextInfo);
        List<ClientMaster> lstclients = new List<ClientMaster>();
        inventorySalesBL.GetClientNames(OrgID, out lstclients);
        if (lstclients.Count > 0)
        {
            var temp = lstclients.FindAll(p => p.ClientCode == "GENERAL" || p.ClientName == "GENERAL");
            if (lstclients.Count > 0)
            {
                hdnBaseClientID.Value = temp[0].ClientID.ToString();
                hdnSelectedClientClientID.Value = temp[0].ClientID.ToString();
            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "Alt", "ValidationWindow('" + strClientAssOrg.Trim() + "," + strClientAssOrg.Trim() + "," + strAlert.Trim() + "');", true);
        }

    }
    public void loadRateType()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
            if (lstRateMaster.Count > 0)
            {
                var temp = lstRateMaster.FindAll(p => p.RateCode == "GENERAL");
                if (temp.Count > 0)
                {
                    hdnBaseRateID.Value = temp[0].RateId.ToString();
                    //hdnRateID.Value = temp[0].RateId.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }
     
    #endregion
    #endregion
}