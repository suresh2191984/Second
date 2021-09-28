using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Solution.BusinessLogic_Ledger;
using Attune.Solution.BusinessLogic_InvoiceLedger;
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
using System.Web.UI.HtmlControls;
using System.Web.Services;

public partial class Billing_PreQuotation : BasePage
{
    string strSelect = Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_03 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_ServiceQuotation_aspx_03;
    public Billing_PreQuotation()
        : base("Billing_PreQuotation_aspx")
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
        //billPart.BillingPageType = "Service";
        Session["PreQuotationPage"] = hdnPreQuotation.Value;
        // Added by Jayaramanan 13/08/2018
        //this.txtName.Text = Request.QueryString["Name"].ToString().ToUpper();
        //this.txtDOBNos.Text = Request.QueryString["Age"];
        //this.txtMobileNumber.Text = Request.QueryString["MobileNo"];
        //this.txtInternalExternalPhysician.Text = Request.QueryString["Doctor"].ToString().ToUpper();
        // 

        if (!IsPostBack)
        {
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
            ddlSex.Attributes.Add("onchange", "setSexValueoptLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            LoadQuickBillLoading();
            string strRate = GetConfigValue("ShowRateType", OrgID);
            string ConfigKey = GetConfigValue("PreQuotation", OrgID);
            hdnConfigID.Value = ConfigKey;
            LoadFeeType();
            if (ConfigKey == "Y")
            {
                tblPre1.Visible = true;
                tblPre2.Visible = true;
                tblPre3.Visible = true;

            }
            else
            {
                tblPre1.Visible = false;
                tblPre2.Visible = false;
                tblPre3.Visible = false;
            }
            


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
            string ConfigKey = GetConfigValue("PreQuotation", OrgID);
            LoadFeeType();
            if (ConfigKey == "Y")
            {

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
                
            }
            else{
                oBookings.TokenNumber = 0;
                oBookings.CreatedBy = LID;
                oBookings.OrgID = OrgID;
                oBookings.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                oBookings.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
                oBookings.PatientName = "Dummy";
                oBookings.SEX = "F";
                DOB = new DateTime(1800, 1, 1);
                //string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
                oBookings.DOB = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                // Int16.TryParse(txtDOBNos.Text.Trim(), out age);
                string pAge = string.Empty;
                pAge = txtDOBNos.Text + " " + ddlDOBDWMY.SelectedValue.ToString();
                oBookings.Age = "22";
                //oBookings.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                oBookings.PhoneNumber = "Dummy";
                oBookings.LandLineNumber = "Dummy";
                oBookings.EMail = "XYZ";
                oBookings.FeeType = "Dummy";
                oBookings.RefPhysicianName = "761390";
                oBookings.SourceType = "PreQuotation";
                ClientID = Convert.ToInt32(hdnSelectedClientClientID.Value);
                DateTime CollectionTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                oBookings.ClientID = ClientID;
                hdnQuotesGivenBy.Value = _LoginName.ToString();
                hdnQuotesDate.Value = OrgDateTimeZone;

                oBookings.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
                oBookings.CollectionTime = CollectionTime;
                
            }
            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            string gUID = string.Empty;
            lstInv = GetOrderedInvestigations(-1, out gUID);

            oBookings.BillDescription = CreateBookingXML(lstInv);
        
            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, OrgID, LID, out  bookingID);
            hdnId.Value = bookingID.ToString();
            returnCode = bookingID;

            string sPage = "../Admin/PreBillPrintPage.aspx?bookingid=" + bookingID.ToString()
                       + "&Orgid=" + OrgID.ToString() + "&Config=" + ConfigKey.ToString();
            
           string spage1 = "&RedirectPage=/Admin/PreQuotation.aspx";
            sPage = sPage + spage1;            
            sPage = sPage.Replace(" ", "&nbsp;");


            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:OpenBillPrint('" + sPage + "');window.location ='../Admin/PreQuotation.aspx';", true);
            ClearValues();
            //Response.Redirect(Page.ResolveClientUrl("../Admin/PreQuotation.aspx"));
           // ScriptManager.RegisterStartupScript(page, page.GetType(), "alert", "ValidationWindow('" + strRejectSave.Trim() + "','" + strAlert.Trim() + "');window.location ='" + Request.ApplicationPath + path + "';", true);
 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }
    }
    void ClearValues()
    {
        txtName.Text = "";
        txtMobileNumber.Text = "";
        txtInternalExternalPhysician.Text = "";
        hdnPreQuotation.Value = "";
        hdnFeeID.Value = "";
        hdnFeeType.Value = "";
        hdnSearchtext.Value = "";        
        hdnReferedPhyID.Value = "";
        hdnOrgID.Value = "";

    }


    public List<OrderedInvestigations> GetOrderedInvestigations(long visitID, out string gUID)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        gUID = Guid.NewGuid().ToString();

        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        //long tempAdd = 0;
        OrderedInvestigations PatientInves;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();

        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
        string sVal = GetConfigValue("SampleCollect", OrgID);
        int SeqNo = 0;
        foreach (string row in sNewDatas.Split('|'))
        {
            PatientInves = new OrderedInvestigations();
            SeqNo = SeqNo + 1;
            if (row.Trim().Length != 0)
            {
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    //"RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "";
                    colValue = colValue.Trim();

                    switch (colName)
                    {
                        case "FeeID":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.ID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            PatientInves.Name = colValue;
                            break;
                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.Rate = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":

                            PatientInves.Type = colValue;
                            break;
                        //case "refType":
                        //    PatientInves.ReferenceType = colValue;
                        //    break;
                        //case "refPhyID":
                        //    if (colValue != null && colValue != "")
                        //    {
                        //        PatientInves.RefPhysicianID = Int64.Parse(colValue);
                        //    }
                        //    break;
                        //case "refPhyName":
                        //    PatientInves.RefPhyName = colValue;
                        //    break;


                    };

                }
                //if (tempAdd == 0)
                //{
                PatientInves.UID = gUID;
              //  PatientInves.StudyInstanceUId = CreateUniqueDecimalString();
                PatientInves.VisitID = visitID;
                PatientInves.OrgID = OrgID;
                PatientInves.PaymentStatus = "Paid";
                PatientInves.Status = "Ordered";
                PatientInves.CreatedBy = LID;
                PatientInves.SequenceNo = SeqNo;
                if (sVal.Trim() == "N")
                {
                    PatientInves.Status = "Paid";
                }

                if (PatientInves.Type == "INV" || PatientInves.Type == "GRP" || PatientInves.Type == "PKG")
                {
                    lstOrderedInvestigations.Add(PatientInves);
                }
            }
        }
        return lstOrderedInvestigations;
    }

    protected void Repeter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (hdnView.Value == "Y")
            {
                HtmlInputButton btnDelete = (HtmlInputButton)e.Item.FindControl("btnDelete");
                btnDelete.Visible = false;
            }
        }
    }
    public void LoadFeeType()
    {
        #region Load Searchtext
        //long returnCode = -1;
        List<InvestigationValues> PgetPreQuotation = new List<InvestigationValues>();
        //returnCode = new Investigation_BL(base.ContextInfo).PgetPreQuotation(OrgID, Searchtext, out PgetPreQuotation);

        string fromPreQuotationPage = String.Empty;
        if (Session["PreQuotationPage"] != null)
        {
            fromPreQuotationPage = Session["PreQuotationPage"].ToString();
        }
        string ConfigKey = GetConfigValue("PreQuotation", OrgID);
        if (ConfigKey == "Y" && fromPreQuotationPage == "Y")
        {
            hdnConfig.Value = "";
            hdnTestDetailes.Value = "";
            hdnTestvalue.Value = "";
            hdnFeeID.Value = "";
            hdnFeeType.Value = "";
            hdnSearchtext.Value = "";
            string[] str = AutoCompleteExtender3.UniqueID.Split('^');
            AutoCompleteExtender3.ContextKey = hdnSearchtext.Value.ToString() + "~" + hdnFeeType.Value.ToString() + "~" + OrgID.ToString() 
                + "~" + 0.ToString() + "~" + hndLocationID.Value.ToString() + "~" + "";
        }
        else
        {
            AutoCompleteExtender3.ContextKey = "" + "~" + "" + "~" + OrgID.ToString()
                + "~" + 0.ToString() + "~" + 0.ToString() + "~" + "";
               
        }
       
        #endregion
    }
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetBillingItems(string prefixText, string contextKey)
    {
        Investigation_BL be = new Investigation_BL(new BaseClass().ContextInfo);
        List<string> items = new List<string>();
        List<InvestigationValues> PgetPreQuotation = new List<InvestigationValues>();
        try
        {
            
            long lresutl = -1;
            int OrgID = 0;
            long ClientID = 0;

            string FeeType = string.Empty, Description = prefixText, IsMappedItem = string.Empty, Remarks = string.Empty;
            string Gender = string.Empty;
            string[] strValue = contextKey.Split('~');
            //Int32.TryParse(Session["OrgID"].ToString(), out OrgID);
            FeeType = strValue[0];

            Int64.TryParse(strValue[1], out ClientID);
            IsMappedItem = strValue[2].ToUpper();
            Remarks = strValue[3].ToUpper();
            Gender = strValue[4];

            lresutl = be.PgetPreQuotation(OrgID, prefixText, out PgetPreQuotation);
            
            if (PgetPreQuotation.Count > 0)
            {
                foreach (InvestigationValues item in PgetPreQuotation)
                {
                    items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.Name, item.Precision)); 

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetQuickBillItems Message:", ex);
        }


        return items;
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
                    ddlSex.SelectedValue = "M";
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