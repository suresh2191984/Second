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

public partial class CommonControls_QuickPatientReg : BaseControl
{
    public bool pIPMakePayment { get; set; }
    string NeedCreditLimt = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
       // AutoCompleteExtender1.ContextKey = OrgID+"~"+rdoVisitType.SelectedValue;

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
            ddlSelectOnOption.SelectedValue = "MAKE_BILL";
            if(pIPMakePayment)
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
        }

        HiddenField parentHdnBillingLogic = (HiddenField)Parent.Page.FindControl("hdnBillingLogic");
        hdnBillingLogic.Value = parentHdnBillingLogic.Value;
        LoadPatientDetails();
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
       LoadMeatData();
       LoadDepartment();
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
            Salutation selectedSalutation = new Salutation();
            ddSalutation.DataSource = lstTitles;
            ddSalutation.DataTextField = "TitleName";
            ddSalutation.DataValueField = "TitleID";
            ddSalutation.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
        }
    }

    public void LoadVisitPurpose(List<VisitPurpose> vPurp)
    {
        //////dPurpose.DataSource = vPurp;
        //////dPurpose.DataTextField = "VisitPurposeName";
        //////dPurpose.DataValueField = "VisitPurposeID";
        //////dPurpose.DataBind();
        hdnVisitPurpose.Value="";

        foreach (VisitPurpose item in vPurp)
        {
            hdnVisitPurpose.Value += item.VisitPurposeID + "~" + item.VisitPurposeName + "~" + item.VisitType + "^";
        }
        dPurpose.Items.Insert(0, "-----Select-----");
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
            ddState.SelectedValue = (selectedState != null)? selectedState.StateID.ToString(): string.Empty;
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
                patient.DOB = Convert.ToDateTime(tDOB.Text );
                Int16.TryParse(txtDOBNos.Text.Trim(), out age);
                patient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
                patient.TitleName = ddSalutation.SelectedItem.Text;
                patient.SEX = ddlSex.SelectedValue;
                patient.MartialStatus = ddMarital.SelectedValue.ToString();
                patient.RegistrationFee = 0;
                patient.OrgID = OrgID;
                patient.CreatedBy = LID;
                patient.CompressedName = finalPName.ToString();
                UserAddress useAddress = new UserAddress();
                short CountryID;
                short StateID;
                PatientAddress PA = new PatientAddress();
                PA.Add1 = txtAddress.Text.Trim();
                PA.Add2 = "";
                PA.City = txtCity.Text.Trim();
                patient.Add3 = "";
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
                patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);
                patient.EmpDeptCode = ddlDepartment.SelectedItem.Value == "0" ? "" : ddlDepartment.SelectedItem.Value;
                long tempaddrid = patient.PatientAddress[0].AddressID;
            //}
            if (hdnPatientID.Value != string.Empty)
            {
                patient.PatientID = Convert.ToInt64(hdnPatientID.Value.ToString());
            }
            else
            {
                patient.PatientID = 0;
            }
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
        PatientNumber=hdnPatientNumber.Value.ToString();
        return PatientNumber;
    }

    public string GetVisitType()
    {
        string visit=string.Empty;
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

   
    public void SetPatientID(long PatientID,long PatientVisitID)
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

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,InPatientActions";
            string[] Tempdata = domains.Split(',');
            string LangCode = LanguageCode;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{

                // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
				returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "DateAttributes"
                                     select child;

                    ddlDOBDWMY.DataSource = childItems.OrderByDescending(p => p.DisplayText);
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();



                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "Gender"
                                      select child;


                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedIndex = 1;


                    var childItems2 = from child in lstmetadataOutput
                                      where child.Domain == "MaritalStatus"
                                      select child;


                    ddMarital.DataSource = childItems2;
                    ddMarital.DataTextField = "DisplayText";
                    ddMarital.DataValueField = "Code";
                    ddMarital.DataBind();
                    ddMarital.Items.Insert(0, "--Select--");
                    ddMarital.Items[0].Value = "0";
                    ddMarital.SelectedIndex = 1;



                    var childItems3 = from child in lstmetadataOutput
                                      where child.Domain == "InPatientActions"
                                      select child;


                    ddlSelectOnOption.DataSource = childItems3;
                    ddlSelectOnOption.DataTextField = "DisplayText";
                    ddlSelectOnOption.DataValueField = "Code";
                    ddlSelectOnOption.DataBind();


                }
           // }
        }




        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    void LoadDepartment()
    {
        long returnCode = -1;
        List<EmployerDeptMaster> lstEmpDeptMaster = new List<EmployerDeptMaster>();
        Master_BL obj = new Master_BL(base.ContextInfo);
        returnCode = obj.GetEmployerDeptMaster(OrgID, out lstEmpDeptMaster);
        if (lstEmpDeptMaster.Count > 0)
        {
            ddlDepartment.DataSource = lstEmpDeptMaster;
            ddlDepartment.DataValueField = "Code";
            ddlDepartment.DataTextField = "EmpDeptName";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items[0].Value = "0";
        }
        else
        {
            ddlDepartment.Items.Insert(0, "--Select--");
            ddlDepartment.Items[0].Value = "0";
        }
    }
    void LoadPatientDetails()
    {
        Patient_BL pbl = new Patient_BL(base.ContextInfo);
        List<Patient> lstPatientDetails = new List<Patient>();
        string PatientNumber = string.Empty;
        long returnCode = -1;
        if (Request.QueryString["PNO"] != null)
        {
            PatientNumber = Request.QueryString["PNO"];
            returnCode = pbl.GetPatientListForQuickBill(PatientNumber, "0", OrgID, ILocationID, out lstPatientDetails);
            
        }
       
        if (lstPatientDetails.Count() > 0)
        {
            hdnLoadPatientDetails.Value = lstPatientDetails[0].Comments;
            hdnLoadPatientData.Value = "1";
        }
    }
}
