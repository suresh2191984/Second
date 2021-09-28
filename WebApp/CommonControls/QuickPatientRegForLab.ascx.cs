using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;
using System.Web.Caching;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Configuration;


public partial class CommonControls_QuickPatientRegForLab : BaseControl
{
    public bool pIPMakePayment { get; set; }
    string NeedCreditLimt = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = OrgID + "~" + "OP" + "~" + "0";
        
        //if (rdlSearchType.SelectedItem.Value == "0")
        //    AutoCompleteExtender1.MinimumPrefixLength = 1;
        //if (rdlSearchType.SelectedItem.Value == "1")
        //    AutoCompleteExtender1.MinimumPrefixLength = 3;
        //if (rdlSearchType.SelectedItem.Value == "2")
        //    AutoCompleteExtender1.MinimumPrefixLength = 5;

        // ddSalutation.Attributes.Add("onchange", "setSexValue('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        ddSalutation.Attributes.Add("onchange", "setSexValueQB('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "');");
        //ddlSex.Attributes.Add("onchange", "setSexValue('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        ddlSex.Attributes.Add("onchange", "setSexValueopt('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {
            rdoOP.Disabled = true;
            ddlSelectOnOption.Enabled = false;
            ddlSelectOnOption.SelectedValue = "MakeBill";
            if (pIPMakePayment)
            {
                rdoOP.Disabled = false;
                hdnMakePayment.Value = "Y";
                ddlSelectOnOption.Enabled = true;
            }
            loadRateSubTypeMapping();
            LoadQuickBillLoading();
            string chkdaycare = GetConfigValue("IsDayCare", OrgID);
            if (chkdaycare != "Y")
            {
                rdoDayCare.Style.Add("display", "none");
                RS_Daycare.Style.Add("display", "none");
            }
            NeedCreditLimt = GetConfigValue("CreditLimitForIP", OrgID);
            if (NeedCreditLimt != "" && NeedCreditLimt == "Y")
            {
                hdnOrgCreditLimtCtrl.Value = "Y";
            }
            ddlPriority.Focus();
            
             ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:SetVisitTypePros('OP');", true);
            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "clear", "javascript:SetVisitTypePros('OP');", true);
        }

    }

    public bool getIpMakePayment()
    {
        return pIPMakePayment;
    }

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
        LoadNationality(lstNationality);
        LoadCountry(lstCountries);
        LoadVisitPurpose(lstVisitPurpose);
        LoadPriority();
        LoadRace();
        loadrelation();
        LoadURNtype();
    }

    private void loadRateSubTypeMapping()
    {
        List<RateSubTypeMapping> lstRateSubTypeMapping = new List<RateSubTypeMapping>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetRateSubVisitTypeDetails(OrgID, "VST", out lstRateSubTypeMapping);
        ddlVisitDetails.DataSource = lstRateSubTypeMapping;
        ddlVisitDetails.DataTextField = "Description";
        ddlVisitDetails.DataValueField = "TypeOfSubType";
        ddlVisitDetails.DataBind();

        foreach (RateSubTypeMapping item in lstRateSubTypeMapping)
        {
            hdnVisitSubType.Value += item.Description + "^" + item.TypeOfSubType + "|";
        }

    }

    protected void LoadCountry(List<Country> lstcountries)
    {
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        int countryID = 0;
        try
        {
            ddCountry.DataSource = lstcountries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            selectedCountry = lstcountries.Find(FindCountry);
            ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }

    public void LoadNationality(List<Country> lstNationality)
    {
        try
        {
            Country selectednationality = new Country();
            ddlNationality.DataSource = lstNationality;
            ddlNationality.DataTextField = "Nationality";
            ddlNationality.DataValueField = "NationalityID";
            ddlNationality.DataBind();
            selectednationality = lstNationality.Find(FindNationality);
            ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;

        }
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
            CLogger.LogError("Error in patient registration.Message:", ex);
        }
    }

    public void LoadVisitPurpose(List<VisitPurpose> vPurp)
    {
        //dPurpose.DataSource = vPurp;
        //dPurpose.DataTextField = "VisitPurposeName";
        //dPurpose.DataValueField = "VisitPurposeID";
        //dPurpose.DataBind();
        //hdnVisitPurpose.Value="";

        foreach (VisitPurpose item in vPurp)
        {
            hdnVisitPurpose.Value += item.VisitPurposeID + "~" + item.VisitPurposeName + "~" + item.VisitType + "^";
        }
        dPurpose.Items.Insert(0, "-----Select-----");
        //string Obj = "OP";
        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:SetVisitPurpose('" + Obj + "');", true);
    }

    protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddCountry.SelectedIndex > 0)
        //{

        LoadState(Convert.ToInt32(ddCountry.SelectedValue));
        ViewState["Country"] = ddCountry.SelectedItem.Value.ToString();

        //}
    }

    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {
            //LoadControls LL = new LoadControls();
            //  List<State> sat = new List<State>();// LL.LoadStateControl(countryID);


            returnCode = stateBL.GetStateByCountry(countryID, out states);
            //Commanded By Shajahan:

            //ddState.DataSource = states;
            //ddState.DataTextField = "StateName";
            //ddState.DataValueField = "StateID";
            //ddState.DataBind();
            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName.ToUpper(), st.StateID.ToString()));
            }

            selectedState = states.Find(FindState);
            ddState.SelectedValue = selectedState.StateID.ToString();
            Int32.TryParse(ddState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }

    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    protected void LoadCountry()
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        int countryID = 0;
        try
        {
            returnCode = countryBL.GetCountryList(out countries);
            ddCountry.DataSource = countries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            selectedCountry = countries.Find(FindCountry);
            ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            LoadState(countryID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
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

    public int settabindex(int TabIndexs)
    {
        ddSalutation.TabIndex = (short)TabIndexs;
        TabIndexs++;
        txtPatientName.TabIndex = (short)(TabIndexs++);
        tDOB.TabIndex = (short)(TabIndexs++);
        txtDOBNos.TabIndex = (short)(TabIndexs++);
        ddlDOBDWMY.TabIndex = (short)(TabIndexs++);
        ddlSex.TabIndex = (short)(TabIndexs++);
        ddMarital.TabIndex = (short)(TabIndexs++);
        txtAddress.TabIndex = (short)(TabIndexs++);
        txtCity.TabIndex = (short)(TabIndexs++);
        txtPhone.TabIndex = (short)(TabIndexs++);
        txtMobile.TabIndex = (short)(TabIndexs++);
        return TabIndexs;
    }

    public Patient GetPatientDetails()
    {
        Patient patient = new Patient();
        try
        {

            //long returnCode = 0;
            Int16 age = 0;
            DateTime DOB = new DateTime();


            //int cnt = 0;
            List<PatientAddress> pAddresses = new List<PatientAddress>();
            //List<AllergyMaster> Allergylst = new List<AllergyMaster>();
            string finalPName = txtPatientName.Text.ToString();
            //string txtllno = txtPhone.Text.Split(',')[0].ToString();
            //string txtmno = (txtPhone.Text.Split(',').Count()) > 1 ? txtPhone.Text.Split(',')[1].ToString() : "";

            //returnCode = new Patient_BL(base.ContextInfo).CheckPatientforDuplicate(finalPName, txtmno.Trim(), txtllno.Trim(), OrgID, out cnt);

            //if (cnt <= 0)
            //{
            //string compName = Utilities.getCompressedName(txtPatientName.Text.Trim());
            patient.Name = finalPName;
            patient.AliasName = "";
            patient.PersonalIdentification = "";
            patient.AlternateContact = "";
            patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            DOB = new DateTime(1800, 1, 1);
            tDOB.Text = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            patient.DOB = Convert.ToDateTime(tDOB.Text);
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            patient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            patient.TitleName = ddSalutation.SelectedItem.Text;
            patient.SEX = ddlSex.SelectedValue;
            patient.MartialStatus = ddMarital.SelectedValue.ToString();
            patient.RegistrationFee = 0;
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.CompressedName = finalPName.ToString();
            patient.BloodGroup = ddBloodGrp.SelectedItem.Text.ToString();
            UserAddress useAddress = new UserAddress();
            short CountryID;
            short StateID;
            PatientAddress PA = new PatientAddress();
            PA.Add1 = txtAddress.Text.Trim();
            PA.Add2 = txtAddress2.Text;
            PA.Add3 = txtAddress3.Text;
            PA.City = txtCity.Text.Trim();
            PA.AddressType = "P";
            PA.LandLineNumber = txtPhone.Text.Trim();
            PA.MobileNumber = txtMobile.Text.Trim();

            Int16.TryParse(ddCountry.SelectedValue, out CountryID);
            Int16.TryParse(ddState.SelectedValue, out StateID);

            PA.CountryID = CountryID;
            PA.StateID = StateID;
            pAddresses.Add(PA);
            patient.PatientAddress = pAddresses;
            patient.VisitPurposeID =int.Parse(hdnVisitPurposeID.Value);
            //patient.VisitPurposeID =Convert.ToInt32(dPurpose.SelectedValue);
            //patient.VisitPurposeID = 1;
            patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);
            long tempaddrid = patient.PatientAddress[0].AddressID;

            patient.RelationName = txtRelationname.Text;
            patient.RelationTypeId = Convert.ToInt64(ddlRelationtype.SelectedValue);
            patient.Race = ddlRace.SelectedItem.ToString();
            patient.EMail = txtEmailID.Text;
            patient.StateID = Convert.ToInt16(ddState.SelectedValue);
            patient.PriorityID = ddlPriority.SelectedValue;
            patient.WardNo = txtward.Text;
            patient.NotifyType = 0;
            if (chkMobileNotify.Checked)
            {
                patient.NotifyType = 1;

            }
            if (chkEmailNotify.Checked)
            {
                patient.NotifyType = 2;
            }
            if (chkMobileNotify.Checked && chkEmailNotify.Checked)
            {
                patient.NotifyType = 3;
            }
            HttpFileCollection hfc = Request.Files;

            //}
            if (hdnPatientID.Value != string.Empty)
            {
                patient.PatientID = Convert.ToInt64(hdnPatientID.Value.ToString());
            }
            else
            {
                patient.PatientID = 0;
            }
            URNTypes objURNTypes = GetURN();
            patient.URNO = objURNTypes.URN;
            patient.URNofId = objURNTypes.URNof;
            patient.URNTypeId = objURNTypes.URNTypeId;
            return patient;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient details.", ex);
            return patient;
        }
    }

    public long GetPatientVisitID()
    {
        long VisitID = 0;
        Int64.TryParse(hdnVisitID.Value.ToString(), out VisitID);
        return VisitID;
    }

    public long GetRefPhyID()
    {
        long RefPhyID = 0;
        Int64.TryParse(hdnRefPhyID.Value.ToString(), out RefPhyID);
        return RefPhyID;
    }

    public long GetEpisodeID()
    {
        long EpisodeID = 0;
        Int64.TryParse(hdnEpisodeID.Value.ToString(), out EpisodeID);
        return EpisodeID;
    }

    public long GetVisitPurposeID()
    {
        long VisitPurposeID = 0;
        Int64.TryParse(hdnVisitPurposeID.Value.ToString(), out VisitPurposeID);
        return VisitPurposeID;
    }

    public long GetPatientID()
    {
        long PatientID = 0;
        Int64.TryParse(hdnPatientID.Value.ToString(), out PatientID);
        return PatientID;
    }

    public string GetPatientNumber()
    {
        string PatientNumber = string.Empty;
        PatientNumber = hdnPatientNumber.Value.ToString();
        return PatientNumber;
    }

    public string GetVisitType()
    {
        string visit = string.Empty;
        if (rdoNewVisit.Checked == true)
        {
            visit = "NewVisit";
        }
        else
        {
            visit = "ExisitingVisit";
        }
        return visit;
    }

    public void SetPatientID(long PatientID, long PatientVisitID)
    {
        hdnPatientID.Value = PatientID.ToString();
        hdnVisitID.Value = PatientVisitID.ToString();
        hdnVisitDetails.Value = "Today's Visit~" + hdnVisitID.Value;
        ScriptManager.RegisterStartupScript(this, this.GetType(), "visit", "SetVisitDetails()", true);

    }

    public long GetCurrentVisitType()
    {
        long VisitType = 0;
        VisitType = lblVisitType.Text.ToUpper() == "OP" || lblVisitType.Text.Trim() == "" ? 0 : 1;
        return VisitType;
    }

    public void PatientName(out string NAme)
    {
        NAme = Utilities.getCompressedName(txtPatientName.Text.Trim());
    }

    public void SetDate()
    {
        if (tDOB.Text == "01/01/1800")
        {
            tDOB.Text = "";
        }
    }

    static bool FindNationality(Country c)
    {
        //if (c.Nationality.ToUpper() == "INDIAN")
        //{
        //    return true;
        //}
        if (c.IsDefault != null && c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    protected void btnSmartDummy_Click(object sender, EventArgs e)
    {

    }

    public void MrdSearch()
    {
        Rs_MRDNumber.Visible = true;
        rdoMrd.Visible = true;
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

    private string needCreditLimtiOrg;

    public string NeedCreditLimitOrg
    {
        get { return needCreditLimtiOrg; }
        set { needCreditLimtiOrg = value; }
    }

    public void LoadPriority()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<PriorityMaster> getPriorityMaster = new List<PriorityMaster>();
            retCode = patBL.GetPriorityMaster(out getPriorityMaster);
            if (retCode == 0)
            {
                ddlPriority.DataSource = getPriorityMaster;
                ddlPriority.DataTextField = "PriorityName";
                ddlPriority.DataValueField = "PriorityID";
                ddlPriority.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Priority Master Details.", ex);
        }
    }

    public void LoadRace()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<Racemaster> Race = new List<Racemaster>();
            patBL.getRaceDetails(out Race);
            ddlRace.DataSource = Race;
            ddlRace.DataTextField = "racename";
            ddlRace.DataValueField = "racename";
            ddlRace.DataBind();
            ddlRace.Items.Insert(0, "-----Select-----");
            ddlRace.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Priority Master Details.", ex);

        }
    }

    public void loadrelation()
    {
        long returncode = -1;
        List<RelationshipMaster> lstrelation = new List<RelationshipMaster>();
        try
        {
            returncode = new Patient_BL(base.ContextInfo).GetRelationship(out lstrelation);
            if (lstrelation.Count > 0)
            {
                ddlRelationtype.DataSource = lstrelation;
                ddlRelationtype.DataTextField = "RelationshipName";
                ddlRelationtype.DataValueField = "RelationshipID";
                ddlRelationtype.DataBind();
                ddlRelationtype.Items.Insert(0, "-----Select-----");
                ddlRelationtype.Items[0].Value = "0";
            }


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadRelationtype", ex);
        }
    }
    public void SentSms()
    {
        //if (chkMobileNotify.Checked && !String.IsNullOrEmpty(pAdd ress.MobileNumber))
        //    Communication.SendSMS("Dear " + patient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", pAddress.MobileNumber);

    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }
    public void SaveProfilePicture(string number, string picExtension)
    {
        try
        {
            string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
            string picNameWithoutExt = number + '_' + OrgID;
            string pictureName = number + '_' + OrgID + picExtension;
            string filePath = imagePath + pictureName;

            Response.OutputStream.Flush();

            string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
            foreach (string path in fileNames)
            {
                File.Delete(path);
            }
            if (chkRemovePhoto.Checked)
            {
                imgPatient.Src = "~/Images/ProfileDefault.jpg";
                hdnPatientImageName.Value = string.Empty;
                divRemovePhoto.Style.Add("display", "none");
            }
            else if (PhotoUpload.PostedFile != null && PhotoUpload.PostedFile.ContentLength > 0)
            {
                string fileName = Path.GetFileNameWithoutExtension(PhotoUpload.PostedFile.FileName);
                string fileExtension = Path.GetExtension(PhotoUpload.PostedFile.FileName);
                int thumbWidth = 130, thumbHeight = 154;

                System.Drawing.Image image = System.Drawing.Image.FromStream(PhotoUpload.PostedFile.InputStream);
                int srcWidth = image.Width;
                int srcHeight = image.Height;
                if (thumbWidth > srcWidth)
                    thumbWidth = srcWidth;
                if (thumbHeight > srcHeight)
                    thumbHeight = srcHeight;
                Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);

                System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;

                System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);

                bmp.Save(filePath, ImageFormat.Jpeg);
                hdnPatientImageName.Value = pictureName;
                gr.Dispose();
                bmp.Dispose();
                image.Dispose();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Unable to upload photo ", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in photo upload. Please contact system administrator.";
        }
    }

    public void GetPictureExtension(out string picExtension, out bool isSavePicture)
    {
        picExtension = string.Empty;
        isSavePicture = false;
        try
        {

            if (chkRemovePhoto.Checked)
            {
                isSavePicture = true;
            }
            else if (chkUploadPhoto.Checked)
            {
                if (Request.Files != null)
                {
                    if (PhotoUpload.PostedFile.ContentLength > 0)
                    {
                        picExtension = ".jpeg";
                        isSavePicture = true;
                    }
                }
            }

            else
            {
                picExtension = Path.GetExtension(hdnPatientImageName.Value);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetPictureExtension", ex);
        }
    }
    public string StrUrn = "";
    public void LoadURNtype()
    {
        try
        {
            long returnCode = -1;
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            Salutation selectedSalutation = new Salutation();

            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();

                ddlUrnType.Items.Insert(0, "--Select--");
                ddlUrnType.Items[0].Value = "0";

                ddlUrnoOf.DataSource = objURNof;
                ddlUrnoOf.DataTextField = "URNOf";
                ddlUrnoOf.DataValueField = "URNOfId";
                ddlUrnoOf.DataBind();

                ddlUrnoOf.Items.Insert(0, "--Select--");
                ddlUrnoOf.Items[0].Value = "0";
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading URNtype", ex);
        }

    }

    public void SetURN(URNTypes objURNTypes)
    {
        if (StrUrn != "")
            hdnUrn.Value = objURNTypes.URN;
        txtURNo.Text = objURNTypes.URN;
        ddlUrnoOf.SelectedValue = objURNTypes.URNof.ToString();
        ddlUrnType.SelectedValue = objURNTypes.URNTypeId.ToString();
    }

    public URNTypes GetURN()
    {
        URNTypes objURNTypes = new URNTypes();
        objURNTypes.URN = txtURNo.Text;
        objURNTypes.URNof = Int64.Parse(ddlUrnoOf.SelectedValue);
        objURNTypes.URNTypeId = Int64.Parse(ddlUrnType.SelectedValue);
        return objURNTypes;
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }

}
