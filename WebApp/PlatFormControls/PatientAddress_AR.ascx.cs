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
using System.Collections.Generic;
using Attune.Kernel.BusinessEntities;

using Attune.Kernel.PlatForm.Utility;
using System.Linq;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Base;

public partial class PlatFormControls_PatientAddress_AR : Attune_BaseControl, Attune_IPatientAddress
{
    public PlatFormControls_PatientAddress_AR()
        : base("PlatFormControls_PatientAddress_AR_ascx")
    {}
    Attune_eAddType iAddressType;
    string title = string.Empty;
    string tabIndex = string.Empty;
    public short tIndex = 0;
    string cityName = string.Empty;
    string IsMiddleEastConfig = string.Empty;
    static string TempStateId = string.Empty;
    static string TempCountryId = string.Empty;
    long CodeID = 0;
    Utilities objut = new Utilities();
    string sDefSelect = string.Empty;
    
    private Int32 _ucOrgID;
    public Int32 ucOrgID
    {
        get { return _ucOrgID; }
        set { _ucOrgID = value; }
    }
    public string StartIndex
    {
        get
        {
            return tabIndex;
        }
        set
        {
            tabIndex = value;

        }


    }

    public string Title
    {
        get
        {
            return title;
        }
        set
        {
            title = value;
            if (value == "1")
            {
                litCurrentTitle.Visible = false;
            }
            else if (value == "2")
            {
                litTitle.Visible = false;
            }
            else if (value == "3")
            {
                TitleRow.Visible = false;
            }
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //litTitle.Text = Title;

        //if (title == "1")
        //{
        //    litCurrentTitle.Visible = false;
        //}

        //else if (title == "2")
        //{
        //    litTitle.Visible = false;
        //}

        string IsSmeConfig = "IsSMEOrg";
        string Smecode = GetConfigValue(IsSmeConfig, OrgID);
        hdnsme.Value = Smecode.ToString();
                
        if (!IsPostBack)
        {
            IsMiddleEastConfig = GetConfigValue("IsMiddleEast",OrgID);
            if (ddCountry.Items.Count <= 0)
            {
                LoadCountry(CodeID);
            }
            if (IsMiddleEastConfig == "Y")
            {
                hdnConfigvalue.Value = "Y";
            }
            if (Session["OrgID"] != null)
            {
                hdnOrgID.Value = Session["OrgID"].ToString();
            }
            if (Session["LanguageCode"] != null)
            {
                hdnLangCode.Value = Session["LanguageCode"].ToString();
            }
			string hideMandatField = GetConfigValue("IsMandatoryFieldRequired", OrgID);
            if (hideMandatField == "Y")
            {
                // imgDistrict.Style.Add("display", "none");
                imgddState.Style.Add("display", "none");
                //imgAddrs1.Style.Add("display", "none");
                imgCity.Style.Add("display", "none");
                hdnIsMandtReq.Value = "N";
            }
            else
            {
                hdnIsMandtReq.Value = "Y";
            }
        }
        txtAddress1.Rows = 1;
        txtAddress1.Columns = 20;
        sDefSelect = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_01;
    }

    public bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    public bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }

    public void LoadCountry(long CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();
        //Utilities objUt = new Utilities();
        //string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {
            returnCode = countryBL.GetCountryList(out countries);

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);


            if (CodeID == 0)
            {
                ddCountry.DataSource = lstLocalities;
                ddCountry.DataTextField = "Locality_Value";
                ddCountry.DataValueField = "Locality_ID";
                ddCountry.DataBind();
                ddCountry.Items.Insert(0, GetMetaData("Select", "0"));
            }
            if (CountryID > 0)
            {
                var childItems = (from n in countries
                                  where n.CountryID == CountryID
                                  select new { n.CountryID, n.PhoneNo_Length }).ToList();
                long CountryCode = childItems[0].CountryID;
                int PhLength = childItems[0].PhoneNo_Length;
                hdnPhLength.Value = PhLength.ToString();
                txtMobile.Attributes.Add("MaxLength", PhLength.ToString());
                ddCountry.SelectedValue = CountryCode.ToString();
                hdnAddressCountry.Value = CountryCode.ToString();
                LoadStates(CountryCode);
            }
            if (StateID > 0)
            {
                stateBL.GetStateByCountry(CountryID, out states);
                var StateCodes = (from n in states
                                  where n.StateID == StateID
                                  select new { n.StateID }).ToList();
                long StateCode = StateCodes[0].StateID;
                IsMiddleEastConfig = GetConfigValue("IsMiddleEast", OrgID);
                ddState.SelectedValue = StateCode.ToString();
                hdnAddressState.Value = StateCode.ToString();
               // LoadDistricts(StateCode);
                //ddlDistricts.Items.Insert(0, Select);
                ddllocalities.Items.Insert(0, GetMetaData("Select", "0"));
                ddlCity.Items.Insert(0, GetMetaData("Select", "0"));
                if (IsMiddleEastConfig == "Y")
                {
                    ddState.SelectedValue = null;
                    hdnAddressState.Value = "";
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
    public string GetCurrentPageName()
    {
        string sPath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
        System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
        string sRet = oInfo.Name; return sRet;
    }


    protected void ddState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddState.SelectedIndex > 0)
        {
            //LoadCity(Convert.ToInt32(ddState.SelectedValue));

        }
    }

    public void SetAddress(PatientAddress pAddress)
    {
        long CCodeID = pAddress.CountryID;
        long Statecode = pAddress.StateID;
        int CityCode = pAddress.CityCode;
        int disCode = pAddress.AddLevel1;
        int locCode = pAddress.AddLevel2;
       
        hdnAddressCountry.Value = Convert.ToString(CCodeID);
        hdnAddressState.Value = Convert.ToString(Statecode);
        hdnCityID.Value = Convert.ToString(CityCode);
        hdnDistricts.Value = Convert.ToString(disCode);
        hdnLoclities.Value = Convert.ToString(locCode);
        LoadCountry(CodeID);
        if (CCodeID > 0) 
 	      { 
 			 LoadStates(CCodeID); 
 	} 
        if (Statecode > 0)
        {
            //LoadDistricts(Statecode);
        }
        //string sessionorg = Session["OrgID"].ToString();
        int sessionorg = ucOrgID;
        
        //int sessionorgs=Session["orgID"];
        //IsMiddleEast = GetConfigValue("IsMiddleEast", (new BasePage()).OrgID);
        if (Statecode > 0 && isMiddleEast)
        {
            LoadCity(Statecode);
        }
        else
        {
            if (disCode > 0)
            {
                LoadCity(disCode);
            }
        }
        if (CityCode > 0)
        {
            Loadlocalities(CityCode);
        }
        hdnDistricts.Value = disCode.ToString();
        hdnLoclities.Value = locCode.ToString();
        txtAddressID.Text = pAddress.AddressID.ToString();
        txtAddress1.Text = pAddress.Add1;

        if (pAddress.CountryID > 0)
        {
            ddCountry.SelectedValue = pAddress.CountryID.ToString();
        }
        if (pAddress.StateID > 0)
        {
            ddState.SelectedValue = pAddress.StateID.ToString();
        }
        if (pAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = pAddress.CityCode.ToString();
        }
        if (pAddress.AddLevel1 > 0)
        {
            //ddlDistricts.SelectedValue = pAddress.AddLevel1.ToString();
        }
        if (pAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = pAddress.AddLevel2.ToString();
        }

        txtMobile.Text = pAddress.MobileNumber;
        txtLandLine.Text = pAddress.LandLineNumber;
        txtOtherCountry.Text = pAddress.OtherCountryName;
        txtOtherState.Text = pAddress.OtherStateName;


    }

    public void SetAddress(NurseAddress NAddress)
    {
        LoadCountry(CodeID);
        txtAddressID.Text = NAddress.AddressID.ToString();

        txtAddress1.Text = NAddress.Add1;

        ddlCity.SelectedValue = NAddress.City;

        if (NAddress.CountryID > 0)
        {
            ddCountry.SelectedValue = NAddress.CountryID.ToString();
        }
        if (NAddress.StateID > 0)
        {
            ddState.SelectedValue = NAddress.StateID.ToString();
        }
        if (NAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = NAddress.CityCode.ToString();
        }
        if (NAddress.AddLevel1 > 0)
        {
            //ddlDistricts.SelectedValue = NAddress.AddLevel1.ToString();
        }
        if (NAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = NAddress.AddLevel2.ToString();
        }

        hdnAddressCountry.Value = NAddress.CountryID.ToString();
        hdnAddressState.Value = NAddress.StateID.ToString();
        hdnCityID.Value = NAddress.CityCode.ToString();
        hdnDistricts.Value = NAddress.AddLevel1.ToString();
        hdnLoclities.Value = NAddress.AddLevel2.ToString();

        txtPostalCode.Text = NAddress.PostalCode;
        txtMobile.Text = NAddress.MobileNumber;
        txtLandLine.Text = NAddress.LandLineNumber;
        txtOtherCountry.Text = NAddress.OtherCountryName;
        txtOtherState.Text = NAddress.OtherStateName;

    }
    public NurseAddress nurseAddress()
    {
        NurseAddress NAddress = new NurseAddress();
        if (txtAddressID.Text != "")
        {
            NAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }


        NAddress.Add1 = txtAddress1.Text;

        NAddress.AddressType = iAddressType.ToString();

        NAddress.CountryID = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != string.Empty) ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        NAddress.StateID = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != string.Empty) ? Convert.ToInt32(hdnAddressState.Value) : 0;
        NAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != string.Empty) ? Convert.ToInt32(hdnCityID.Value) : 0;
        NAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != string.Empty) ? Convert.ToInt32(hdnDistricts.Value) : 0;
        NAddress.AddLevel1 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != string.Empty) ? Convert.ToInt32(hdnLoclities.Value) : 0;
        //NAddress.CountryID = Convert.ToInt16(CountryID);
        //NAddress.StateID = Convert.ToInt16(StateID);

        NAddress.PostalCode = txtPostalCode.Text;
        NAddress.MobileNumber = txtMobile.Text;
        NAddress.LandLineNumber = txtLandLine.Text;
        NAddress.CreatedBy = LID;
        NAddress.OtherCountryName = txtOtherCountry.Text;
        NAddress.OtherStateName = txtOtherState.Text;
        return NAddress;
    }

    public void SetAddress(PhysicianAddress phyAddress)
    {
        LoadCountry(CodeID);
        txtAddressID.Text = phyAddress.AddressID.ToString();

        txtAddress1.Text = phyAddress.Add1;


        if (phyAddress.CountryID > 0)
        {
            ddCountry.SelectedValue = phyAddress.CountryID.ToString();
        }
        if (phyAddress.StateID > 0)
        {
            ddState.SelectedValue = phyAddress.StateID.ToString();
        }
        if (phyAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = phyAddress.CityCode.ToString();
        }
        if (phyAddress.AddLevel1 > 0)
        {
            //ddlDistricts.SelectedValue = phyAddress.AddLevel1.ToString();
        }
        if (phyAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = phyAddress.AddLevel2.ToString();
        }

        hdnAddressCountry.Value = phyAddress.CountryID.ToString();
        hdnAddressState.Value = phyAddress.StateID.ToString();
        hdnCityID.Value = phyAddress.CityCode.ToString();
        hdnDistricts.Value = phyAddress.AddLevel1.ToString();
        hdnLoclities.Value = phyAddress.AddLevel2.ToString();
        txtPostalCode.Text = phyAddress.PostalCode;

        txtMobile.Text = phyAddress.MobileNumber;
        txtLandLine.Text = phyAddress.LandLineNumber;
        txtOtherCountry.Text = phyAddress.OtherCountryName;
        txtOtherState.Text = phyAddress.OtherStateName;

    }

    public PhysicianAddress physicianAddress()
    {
        PhysicianAddress phyAddress = new PhysicianAddress();
        if (txtAddressID.Text != "")
        {
            phyAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }


        phyAddress.Add1 = txtAddress1.Text;

        phyAddress.AddressType = iAddressType.ToString();


        phyAddress.City = ddlCity.SelectedValue;
        //phyAddress.CountryID = Convert.ToInt64(CountryID);
       // phyAddress.StateID = Convert.ToInt64(StateID);
        phyAddress.CountryID = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != string.Empty) ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        phyAddress.StateID = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != string.Empty) ? Convert.ToInt32(hdnAddressState.Value) : 0;
        phyAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != string.Empty) ? Convert.ToInt32(hdnCityID.Value) : 0;
        phyAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != string.Empty) ? Convert.ToInt32(hdnDistricts.Value) : 0;
        phyAddress.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != string.Empty) ? Convert.ToInt32(hdnLoclities.Value) : 0;

        phyAddress.PostalCode = txtPostalCode.Text;
        phyAddress.MobileNumber = txtMobile.Text;
        phyAddress.LandLineNumber = txtLandLine.Text;
        phyAddress.CreatedBy = LID;
        phyAddress.OtherCountryName = txtOtherCountry.Text;
        phyAddress.OtherStateName = txtOtherState.Text;
        return phyAddress;
    }





    public void SetLabRefOrgAddress(LabRefOrgAddress pAddress)
    {
        LoadCountry(CodeID);
        txtAddressID.Text = pAddress.AddressID.ToString();

        txtAddress1.Text = pAddress.Add1;

        ddlCity.SelectedValue = pAddress.City;
        hdnCityID.Value = pAddress.City;
        ListItem Country = ddCountry.Items.FindByValue(pAddress.CountryID.ToString());

        if (Country != null)
        {
            ddCountry.SelectedValue = pAddress.CountryID.ToString();
            hdnAddressCountry.Value = pAddress.CountryID.ToString();
        }
        if (ddState.Items.FindByValue(pAddress.StateID.ToString()) != null)
        {
            ddState.SelectedValue = pAddress.StateID.ToString();
            hdnAddressState.Value = pAddress.StateID.ToString();
        }
        txtPostalCode.Text = pAddress.PostalCode;
        txtMobile.Text = pAddress.MobileNumber;
        txtLandLine.Text = pAddress.LandLineNumber;
        txtOtherCountry.Text = pAddress.OtherCountryName;
        txtOtherState.Text = pAddress.OtherStateName;

    }
    public LabRefOrgAddress GetLabRefOrgAddress()
    {
        //LoadCountry();    
        LabRefOrgAddress objAddress = new LabRefOrgAddress();
        long CountryID;
        long StateID;
        int CityID;
        int AddLevel1;
        int AddLevel2;

        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        objAddress.Add1 = txtAddress1.Text;
        
        objAddress.AddressType = iAddressType.ToString();
        //Int16.TryParse(hdnCityID.Value, out CityID);
        //objAddress.City = CityID.ToString();
        //Int16.TryParse(hdnAddressCountry.Value, out CountryID);
        //Int16.TryParse(hdnAddressState.Value, out StateID);
        //objAddress.CountryID = CountryID;
        //objAddress.StateID = StateID;

        Int64.TryParse(hdnAddressCountry.Value, out CountryID);
        objAddress.CountryID = CountryID;
        Int64.TryParse(hdnAddressState.Value, out StateID);
        objAddress.StateID = StateID;
        Int32.TryParse(hdnCityID.Value, out CityID);
        objAddress.CityCode = CityID;
        Int32.TryParse(hdnDistricts.Value, out AddLevel1);
        objAddress.AddLevel1 = AddLevel1;
        Int32.TryParse(hdnLoclities.Value, out AddLevel2);
        objAddress.AddLevel2 = AddLevel2;

        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        return objAddress;

    }
    public PatientAddress GetPAddress()
    {

        PatientAddress objAddress = new PatientAddress();
        long CountryID;

        Utilities objut = new Utilities();
        string sDefSelect = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_01;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;

        objAddress.AddressType = iAddressType.ToString();

        Int64.TryParse(ddCountry.SelectedValue, out CountryID);


        TempCountryId = hdnAddressCountry.Value == "" ? TempCountryId : hdnAddressCountry.Value;

        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        objAddress.CountryID = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != "") ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        objAddress.StateID = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != "") ? Convert.ToInt32(hdnAddressState.Value) : 0;
        objAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != "") ? Convert.ToInt32(hdnCityID.Value) : 0;
        objAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != "") ? Convert.ToInt32(hdnDistricts.Value) : 0;
        objAddress.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != "") ? Convert.ToInt32(hdnLoclities.Value) : 0;
        return objAddress;

    }
    public PatientAddress GetAddress()
    {
        PatientAddress objAddress = new PatientAddress();
        long CountryID;
        long StateID;
        int CityID;
        int LocalityID;
        int DistrictID;

        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        objAddress.Add1 = txtAddress1.Text;
        objAddress.AddressType = iAddressType.ToString();

        Int64.TryParse(hdnAddressCountry.Value, out CountryID);
        Int64.TryParse(hdnAddressState.Value, out StateID);
        Int32.TryParse(hdnCityID.Value, out CityID);
        Int32.TryParse(hdnDistricts.Value, out DistrictID);
        Int32.TryParse(hdnLoclities.Value, out LocalityID);

        #region We need to save only locality table ID
        objAddress.CountryID = CountryID;
        objAddress.StateID = StateID;
        objAddress.CityCode = CityID;
        objAddress.AddLevel1 = DistrictID;
        objAddress.AddLevel2 = LocalityID;
        #endregion

        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        return objAddress;

    }
    public long GetPatientEmployer(long patientID, string employerName, string employeeName, string employeeNo, long createdBy, out PatientEmployer objEmployer)
    {

        objEmployer = new PatientEmployer();
        long CountryID;
        long StateID;
        int DistrictID;
        int LocalityID;
        int CityID;

        objEmployer.PatientID = patientID;
        objEmployer.EmployerName = employerName;
        objEmployer.EmployeeName = employeeName;
        objEmployer.EmployeeNo = employeeNo;

        objEmployer.Add1 = txtAddress1.Text;


        Int64.TryParse(hdnAddressCountry.Value, out CountryID);
        Int64.TryParse(hdnAddressState.Value, out StateID);
        Int32.TryParse(hdnCityID.Value, out CityID);
        Int32.TryParse(hdnDistricts.Value, out DistrictID);
        Int32.TryParse(hdnLoclities.Value, out LocalityID);
        objEmployer.CountryID = CountryID;
        objEmployer.StateID = StateID;
        objEmployer.CityCode = CityID;
        objEmployer.AddLevel1 = DistrictID;
        objEmployer.AddLevel2 = LocalityID;
        objEmployer.PostalCode = txtPostalCode.Text;
        objEmployer.MobileNumber = txtMobile.Text;
        objEmployer.LandLineNumber = txtLandLine.Text;
        objEmployer.CreatedBy = createdBy;
        objEmployer.OtherCountryName = txtOtherCountry.Text;
        objEmployer.OtherStateName = txtOtherState.Text;
        return 0;

    }

    #region Properties



    public Attune_eAddType AddressType
    {
        get
        {
            return iAddressType;
        }
        set
        {
            iAddressType = value;
        }
    }
    #endregion

    public void SetAddresstoEdit(List<OrgUsers> lstOrgUsers)
    {
        if (lstOrgUsers.Count != 0)
        {
            long CCodeID = lstOrgUsers[0].CountryID;
            long Statecode = lstOrgUsers[0].StateID;
            int CityCode = lstOrgUsers[0].CityCode;
            int disCode = lstOrgUsers[0].AddLevel1;
            int locCode = lstOrgUsers[0].AddLevel2;
            LoadCountry(CodeID);
            if (lstOrgUsers[0].CountryCode > 0)
            {
                ddCountry.SelectedValue = lstOrgUsers[0].CountryID.ToString();
            }
            hdnAddressCountry.Value = lstOrgUsers[0].CountryID.ToString();

            LoadStates(CCodeID);
            //LoadDistricts(Statecode);
            LoadCity(Statecode);
            Loadlocalities(CityCode);


            //int cid = Convert.ToInt32(lstOrgUsers[0].CountryID.ToString());

            //if (lstOrgUsers[0].StateCode > 0)
            //{

            //    ddState.SelectedValue = lstOrgUsers[0].StateCode.ToString();
            //}
            hdnAddressState.Value = lstOrgUsers[0].StateCode.ToString();

            txtAddress1.Text = lstOrgUsers[0].Add1;
            
            //ddlCity.Text = lstOrgUsers[0].City;
            if (lstOrgUsers[0].CityCode > 0)
            {
                ddlCity.SelectedValue = lstOrgUsers[0].CityCode.ToString();
                //ddlCity.SelectedItem.Text = lstOrgUsers[0].City.ToString();
            }
            hdnCityID.Value = lstOrgUsers[0].CityCode.ToString();
            if (lstOrgUsers[0].AddLevel1 > 0)
            {
                //ddlDistricts.SelectedValue = lstOrgUsers[0].AddLevel1.ToString();
            }
            hdnDistricts.Value = lstOrgUsers[0].AddLevel1.ToString();
            if (lstOrgUsers[0].AddLevel2 > 0)
            {
                ddllocalities.SelectedValue = lstOrgUsers[0].AddLevel2.ToString();
            }
            hdnLoclities.Value = lstOrgUsers[0].AddLevel2.ToString();
            txtPostalCode.Text = lstOrgUsers[0].PostalCode;
            txtMobile.Text = lstOrgUsers[0].MobileNumber;
            txtLandLine.Text = lstOrgUsers[0].LandLineNumber;



        }
    }
    public void SetAddresstoEdit1(List<OrganizationAddress> lstOrgLocation)
    {
        if (lstOrgLocation.Count != 0)
        {
            long cid = Convert.ToInt64(lstOrgLocation[0].CountryID.ToString());
            ddCountry.SelectedValue = lstOrgLocation[0].CountryID.ToString();
            LoadState(cid);
            ddState.SelectedValue = lstOrgLocation[0].StateID.ToString();

            txtAddress1.Text = lstOrgLocation[0].Add1;

            ddlCity.SelectedValue = lstOrgLocation[0].City;
            ddCountry.SelectedValue = lstOrgLocation[0].CountryID.ToString();
            ddState.SelectedValue = lstOrgLocation[0].StateID.ToString();
            txtPostalCode.Text = lstOrgLocation[0].PostalCode;
            txtMobile.Text = lstOrgLocation[0].MobileNumber;
            txtLandLine.Text = lstOrgLocation[0].LandLineNumber;
            txtOtherCountry.Text = lstOrgLocation[0].OtherCountryName;
            txtOtherState.Text = lstOrgLocation[0].OtherStateName;
            string sPath = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_cs_01;
            if (sPath == null)
            {
                sPath = "OTHERS";
            }
            if (ddState.SelectedItem.Text.ToUpper() == sPath & ddCountry.SelectedItem.Text.ToUpper() == sPath)
            {
                tbState.Style.Add("display", "block");
                tbCountry.Style.Add("display", "block");
            }
            else if (ddState.SelectedItem.Text.ToUpper() == sPath)
            {
                tbState.Style.Add("display", "block");
            }
            else
            {
                tbState.Style.Add("display", "none");
                tbCountry.Style.Add("display", "none");
            }
        }
    }



    public string GetAddressDetails(PatientAddress cAddress)
    {
        string Address = "<table><tr><td>";
        if (cAddress.Add1 != "")
        {
            Address += cAddress.Add1 + "," + cAddress.Add2 + ", </td><td> </td></tr><tr><td>"; ;
        }
        if (cAddress.Add3 != "")
        {
            Address += cAddress.Add3 + ",</td><td></td></tr><tr><td>";
        }
        if (cAddress.City != "")
        {
            Address += cAddress.City + ",</td><td></td></tr><tr><td>";
        }
        Address += ddState.SelectedItem.Text + ",</td><td></td></tr><tr><td>";
        Address += ddCountry.SelectedItem.Text;
        if (cAddress.PostalCode != "")
        {
            Address += "-" + cAddress.PostalCode + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.MobileNumber != "")
        {
            Address += "Mob : " + cAddress.MobileNumber + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.LandLineNumber != "")
        {
            Address += "Ph : " + cAddress.LandLineNumber + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.OtherCountryName != "")
        {
            Address += "OCountry: " + cAddress.OtherCountryName + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.OtherStateName != "")
        {
            Address += "OState : " + cAddress.OtherStateName + "</td><td></td></tr><tr><td>";
        }
        Address += " </td></tr></table>";
        return Address;

    }
    public void clearAddress()
    {

        LoadCountry(CodeID);
        txtAddressID.Text = "";

        txtAddress1.Text = "";

        txtPostalCode.Text = "";
        txtMobile.Text = "";
        txtLandLine.Text = "";
        txtOtherCountry.Text = "";
        txtOtherState.Text = "";

    }
    //protected void LoadCity(int ID)
    //{
    //    List<City> Cities = new List<City>();
    //    State_BL stateBL = new State_BL(base.ContextInfo);
    //    List<Localities> lstLocalities = new List<Localities>();
    //    Country_BL countryBL = new Country_BL(base.ContextInfo);
    //    long returnCode = -1;
    //    ddlCity.Items.Clear();
    //    try
    //    {

    //        //returnCode = stateBL.GetCityByState(StateID, out Cities);
    //        returnCode = countryBL.GetLocalities(ID, out lstLocalities);
    //        ddlCity.DataSource = lstLocalities;
    //        ddlCity.DataTextField = "Locality_Values";
    //        ddlCity.DataValueField = "Locality_ID";
    //        ddlCity.DataBind();
    //        ddlCity.Items.Insert(0, "Select");
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while loading City", ex);
    //    }
    //    finally
    //    {
    //    }
    //}


    public void LoadState(long ID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        long returnCode = -1;

        ddState.Items.Clear();
        //int stateID = 0;
        //Decimal Key = new decimal(0.00);
        try
        {

            //returnCode = stateBL.GetStateByCountry(countryID, out states);
            returnCode = countryBL.GetLocalities(ID, out lstLocalities);
            foreach (Localities st in lstLocalities)
            {
                ddState.Items.Add(new ListItem(st.Locality_Value, st.Locality_ID.ToString()));
            }
            string sPath = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_cs_02;
            if (sPath == null)
            {
                sPath = "Select";
            }
            ddState.Items.Insert(0, GetMetaData("Select", "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }

    public string ddlStateID { get { return ddState.ClientID; } }
    public string ddlCityID { get { return ddlCity.ClientID; } }
    public string ddllocalitiesID { get { return ddllocalities.ClientID; } }
   // public string ddlDistrictsID { get { return ddlDistricts.ClientID; } }

    public void LoadStates(long CodeID)
    {
        long returnCode = -1;
        //Country_BL countryBL = new Country_BL(base.ContextInfo);
        //List<Country> countries = new List<Country>();
        //List<Localities> lstLocalities = new List<Localities>();
        //List<InvestigationMaster> i = new List<InvestigationMaster>();

        //Country selectedCountry = new Country();
        ////ddCountry.Items.Clear();
        //Utilities objUt = new Utilities();
        //string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        ddState.Items.Clear();

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddState.DataSource = lstLocalities;
            ddState.DataTextField = "Locality_Value";
            ddState.DataValueField = "Locality_ID";
            ddState.DataBind();
            ddState.Items.Insert(0, GetMetaData("Select", "0"));
            long StateLocID = 0;
            Int64.TryParse(hdnAddressState.Value, out StateLocID);
            if (StateLocID == 0)
            {
                StateLocID = StateID;
            }
            txtCountryCode.Text = "+" + lstLocalities[0].ISDCode.ToString();

            var childItems = (from n in lstLocalities
                              where n.Locality_ID == StateLocID
                              select new { n.Locality_ID, n.ISDCode }).FirstOrDefault();
            if (childItems != null)
            {
               
                txtCountryCode.Enabled = false;
                ddState.SelectedValue = Convert.ToString(childItems.Locality_ID);
                //LoadDistricts(StateLocID);
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

    public void LoadCity(long CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        //Utilities objUt = new Utilities();
        //string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddlCity.Items.Clear();
            ddlCity.SelectedValue = null;
            ddlCity.DataSource = lstLocalities;
            ddlCity.DataTextField = "Locality_Value";
            ddlCity.DataValueField = "Locality_ID";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, GetMetaData("Select", "0"));

            int CityID = 0;
            int.TryParse(hdnCityID.Value, out CityID);
            if (CityID != 0)
            {
                var item = (from c in lstLocalities
                            where c.Locality_ID == CityID
                            select c).FirstOrDefault();
                if (item != null)
                {
                    ddlCity.SelectedValue = Convert.ToString(CityID);
                    Loadlocalities(CityID);
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
    public void LoadDistricts(long CodeID)
    {
        //long returnCode = -1;
        //Country_BL countryBL = new Country_BL(base.ContextInfo);
        //List<Country> countries = new List<Country>();
        //List<Localities> lstLocalities = new List<Localities>();
        //List<InvestigationMaster> i = new List<InvestigationMaster>();

        //Country selectedCountry = new Country();
        ////ddCountry.Items.Clear();
        //Utilities objUt = new Utilities();
        //string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        //try
        //{

        //    returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);

        //    ddlDistricts.Items.Clear();
        //    ddlDistricts.SelectedValue = null;
        //    ddlDistricts.DataSource = lstLocalities;
        //    ddlDistricts.DataTextField = "Locality_Value";
        //    ddlDistricts.DataValueField = "Locality_ID";
        //    ddlDistricts.DataBind();
        //    ddlDistricts.Items.Insert(0, Select);
        //    int DistLocID = 0;
        //    int.TryParse(hdnDistricts.Value, out DistLocID);
        //    if (DistLocID != 0)
        //    {
        //        var items = (from c in lstLocalities
        //                     where c.Locality_ID == DistLocID
        //                     select c).FirstOrDefault();
        //        if (items != null)
        //        {
        //            ddlDistricts.SelectedValue = Convert.ToString(DistLocID);
        //            LoadCity(DistLocID);
        //        }
        //    }

        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error while loading Country", ex);
        //}
        //finally
        //{
        //}
    }
    public void Loadlocalities(long CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        //Utilities objUt = new Utilities();
        //string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {
            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddllocalities.Items.Clear();
            ddllocalities.SelectedValue = null;
            ddllocalities.DataSource = lstLocalities;
            ddllocalities.DataTextField = "Locality_Value";
            ddllocalities.DataValueField = "Locality_ID";
            ddllocalities.DataBind();
            ddllocalities.Items.Insert(0, GetMetaData("Select", "0"));
            int LocID = 0;
            int.TryParse(hdnLoclities.Value, out LocID);
            if (LocID != 0)
            {
                var item = (from c in lstLocalities
                            where c.Locality_ID == LocID
                            select c).FirstOrDefault();
                if (item != null)
                {
                    ddllocalities.SelectedValue = Convert.ToString(LocID);
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
    public UserAddress GetAddress1()
    {
        UserAddress useAddress = new UserAddress();
        string sDefSelect = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_01;
        long CountryID;
        long StateID;
        if (txtAddressID.Text != "")
        {
            useAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }


        useAddress.Add1 = txtAddress1.Text;

        useAddress.AddressType = iAddressType.ToString();
        // useAddress.City = txtCity.Text;
        Int64.TryParse(ddCountry.SelectedValue, out CountryID);
        Int64.TryParse(ddState.SelectedValue, out StateID);
        //useAddress.CountryID = CountryID;
        //useAddress.StateID = StateID;
        useAddress.PostalCode = txtPostalCode.Text;
        useAddress.MobileNumber = txtMobile.Text;
        useAddress.LandLineNumber = txtLandLine.Text;
        useAddress.CreatedBy = LID;
        useAddress.OtherCountryName = txtOtherCountry.Text;
        useAddress.OtherStateName = txtOtherState.Text;

        useAddress.CountryID = (ddCountry.SelectedValue != sDefSelect && ddCountry.SelectedValue != "") ? Convert.ToInt32(ddCountry.SelectedValue) : 0;
        useAddress.StateID = (ddState.SelectedValue != sDefSelect && ddState.SelectedValue != "") ? Convert.ToInt32(ddState.SelectedValue) : 0;
        useAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != "") ? Convert.ToInt32(hdnCityID.Value) : 0;
        useAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != "") ? Convert.ToInt32(hdnDistricts.Value) : 0;
        useAddress.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != "") ? Convert.ToInt32(hdnLoclities.Value) : 0;



        return useAddress;
    }

    public OrgUsers GetDynamicAddress(OrgUsers eUsers)
    {

        eUsers.Add1 = txtAddress1.Text;

        //eUsers.CountryID = Convert.ToInt16(CountryID);
        //eUsers.StateID = Convert.ToInt16(StateID);
        string sDefSelect = Resources.PlatFormControls_ClientDisplay.PlatFormControls_PatientAddress_AR_ascx_01;
        eUsers.CountryID = (ddCountry.SelectedValue != sDefSelect && ddCountry.SelectedValue != "") ? Convert.ToInt32(ddCountry.SelectedValue) : 0;
        eUsers.StateID = (ddState.SelectedValue != sDefSelect && ddState.SelectedValue != "") ? Convert.ToInt32(ddState.SelectedValue) : 0;
        eUsers.CityCode = (ddlCity.SelectedValue != sDefSelect && ddlCity.SelectedValue != "") ? Convert.ToInt32(ddlCity.SelectedValue) : 0;
        //eUsers.AddLevel1 = (ddlDistricts.SelectedValue != sDefSelect && ddlDistricts.SelectedValue != "") ? Convert.ToInt32(ddlDistricts.SelectedValue) : 0;
        eUsers.AddLevel2 = (ddllocalities.SelectedValue != sDefSelect && ddllocalities.SelectedValue != "") ? Convert.ToInt32(ddllocalities.SelectedValue) : 0;
        eUsers.PostalCode = txtPostalCode.Text;
        eUsers.MobileNumber = txtMobile.Text;
        eUsers.LandLineNumber = txtLandLine.Text;
        return eUsers;
    }





    #region Attune_IPatientAddress Members


    public void SetTabIndex(ref short tabIndex)
    {
        txtAddress1.TabIndex = tabIndex++;
        ddCountry.TabIndex = tabIndex++;
        ddState.TabIndex = tabIndex++;
       // ddlDistricts.TabIndex = tabIndex++;
        ddlCity.TabIndex = tabIndex++;
        ddllocalities.TabIndex = tabIndex++;
        txtPostalCode.TabIndex = tabIndex++;
        txtMobile.TabIndex = tabIndex++;
        txtLandLine.TabIndex = tabIndex++;
    }

    #endregion

    #region Attune_IPatientAddress Members

    private bool _showExpandedMode;
    public bool ShowExpandedMode
    {
        get
        {
            return _showExpandedMode;
        }
        set
        {
            _showExpandedMode = value;
        }
    }


    #endregion



    #region Attune_IPatientAddress Members


    public void SetColumnWidths(double col1, double col2, double col3, double col4)
    {
        //Col1.Style.Add("Width", Convert.ToString(col1) + "%");
        //Col2.Style.Add("Width", Convert.ToString(col2) + "%");
        //Col3.Style.Add("Width", Convert.ToString(col3) + "%");
        //Col4.Style.Add("Width", Convert.ToString(col4) + "%");

    }

    #endregion
    #region Attune_IPatientAddress Members

    private bool _isMiddleEast;
    public bool isMiddleEast
    {
        get
        {
            return _isMiddleEast;
        }
        set
        {
            _isMiddleEast = value;
        }
    }

    #endregion

    public void SetAddresstoLocEdit(List<NewInstanceWaitingCustomers> lstloc)
    {
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        if (lstloc.Count != 0)
        {
            int cid = Convert.ToInt32(lstloc[0].CountryID.ToString());
            ddCountry.SelectedValue = lstloc[0].CountryID.ToString();
            LoadState(cid);
            ddState.SelectedValue = lstloc[0].StateID.ToString();
            int Sid = Convert.ToInt32(lstloc[0].StateID.ToString());
            LoadDistricts(Sid);
            LoadCity(Sid);
            ddlCity.SelectedValue = lstloc[0].AddLevel1.ToString();
            txtAddress1.Text = lstloc[0].Add1;
            txtPostalCode.Text = lstloc[0].PostalCode;
            txtMobile.Text = lstloc[0].MobileNo;
            txtLandLine.Text = lstloc[0].LandLineNumber;
            if (ddState.SelectedItem.Text.ToUpper() == "OTHERS" & ddCountry.SelectedItem.Text.ToUpper() == "OTHERS")
            {
                tbState.Style.Add("display", "block");
                tbCountry.Style.Add("display", "block");
            }
            else if (ddState.SelectedItem.Text.ToUpper() == "OTHERS")
            {
                tbState.Style.Add("display", "block");
            }
            else
            {
                tbState.Style.Add("display", "none");
                tbCountry.Style.Add("display", "none");
            }
        }
    }

    public void HideAddressCon()
    {
        txtAddress1.ReadOnly = true;
        ddCountry.Enabled = false;
        ddState.Enabled = false;
        ddlCity.Enabled = false;
        ddllocalities.Enabled = false;
        txtPostalCode.ReadOnly = true;
        txtLandLine.ReadOnly = true;
    }

    public void UnHideAddressCon()
    {
        txtAddress1.ReadOnly = false;
        ddCountry.Enabled = true;
        ddState.Enabled = true;
        ddlCity.Enabled = true;
        ddllocalities.Enabled = true;
        txtPostalCode.ReadOnly = false;
        txtLandLine.ReadOnly = false;
    }

    public void ResetAddress()
    {
        ddlCity.SelectedIndex = -1;
        txtAddress1.Text = string.Empty;
        txtPostalCode.Text = string.Empty;
        txtMobile.Text = string.Empty;
        txtLandLine.Text = string.Empty;
        txtOtherCountry.Text = txtOtherCountry.Text;
        txtOtherState.Text = txtOtherState.Text;
        ddCountry.SelectedIndex = -1;
    }
}


