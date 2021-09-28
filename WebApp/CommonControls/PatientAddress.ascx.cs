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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;

public partial class CommonControls_PatientAddress : BaseControl
{
    public CommonControls_PatientAddress()
        : base("CommonControls_PatientAddress_ascx")
    {
    }
	
   eAddType iAddressType;
    string title = string.Empty;
    string tabIndex = string.Empty;
    public short tIndex = 0;
    string cityName =string.Empty; 
    static string TempStateId = string.Empty;
    static string TempCountryId = string.Empty;
    int CodeID;
    Utilities objut = new Utilities();
    string sDefSelect = string.Empty;
       
    public string StartIndex
    {
        get
        {
            return tabIndex;
        }
        set
        {
            tabIndex = value;
            
            //tIndex = Convert.ToInt16(tabIndex);
            //txtAddress2.TabIndex = tIndex++;
            //txtAddress1.TabIndex = tIndex++;
            //txtAddress3.TabIndex = tIndex++;
            //ddCountry.TabIndex = tIndex++;
            //ddState.TabIndex = tIndex++;
            //ddlCity.TabIndex = tIndex++;
            //ddlDistricts.TabIndex = tIndex++;
            //ddllocalities.TabIndex = tIndex++;
            //txtPostalCode.TabIndex = tIndex++;
            //txtMobile.TabIndex = tIndex++;
            //txtLandLine.TabIndex = tIndex++;
            //txtOtherCountry.TabIndex = tIndex++;
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
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //litTitle.Text = Title;

        if (title == "1")
        {
            litCurrentTitle.Visible = false;
        }

        else if (title == "2")
        {
            litTitle.Visible = false;
        }

        if (!IsPostBack)
        {
            if (ddCountry.Items.Count <= 0)
                LoadCountry(CodeID);


        }
        txtAddress2.Rows = 1;
        txtAddress2.Columns = 20;
        sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");
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

    public  void LoadCountry(int CodeID)
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
        Utilities objUt = new Utilities();
        string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

       
      
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
                ddCountry.Items.Insert(0,Select);
            }
            if (CountryID > 0)
            {
                var childItems = (from n in countries
                              where n.CountryID == CountryID
                              select new { n.CountryCode,n.PhoneNo_Length }).ToList();
               int CountryCode=Convert.ToInt16(childItems[0].CountryCode);
               int PhLength = childItems[0].PhoneNo_Length;
               hdnPhLength.Value = PhLength.ToString(); 
                txtMobile.Attributes.Add("MaxLength",PhLength.ToString());
               ddCountry.SelectedValue = CountryCode.ToString();
               hdnAddressCountry.Value = CountryCode.ToString();
               LoadStates(CountryCode);
            }
            if (StateID > 0)
            {
                stateBL.GetStateByCountry(CountryID, out states);
                var StateCodes = (from n in states
                                  where n.StateID == StateID
                                  select new { n.StateCode }).ToList();
                int StateCode = StateCodes[0].StateCode;
                ddState.SelectedValue = StateCode.ToString();
                hdnAddressState.Value = StateCode.ToString();
                LoadCity(StateCode);
                ddlDistricts.Items.Insert(0, Select);
                ddllocalities.Items.Insert(0, Select);
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
            //LoadCity(Convert.ToDecimal(ddState.SelectedValue));
            
        }
    }

    public void SetAddress(PatientAddress pAddress)
    {
       int CCodeID = pAddress.CountryCode;
       int Statecode = pAddress.StateCode;
       int CityCode = pAddress.CityCode;
       int disCode = pAddress.AddLevel1;
       int locCode = pAddress.AddLevel2;
        LoadCountry(CodeID);
        LoadStates(CCodeID);
        LoadCity(Statecode);
        if (CityCode > 0)
        {
            LoadDistricts(CityCode);
        }
        if (disCode > 0)
        {
            Loadlocalities(disCode);
        }
        hdnDistricts.Value = disCode.ToString();
        hdnLoclities.Value = locCode.ToString();
        txtAddressID.Text = pAddress.AddressID.ToString();
        txtAddress2.Text = pAddress.Add1;
        txtAddress1.Text = pAddress.Add2;
        txtAddress3.Text = pAddress.Add3;
        if (pAddress.CountryCode > 0)
        {
            ddCountry.SelectedValue = pAddress.CountryCode.ToString();
        }
        if (pAddress.StateCode > 0)
        {
            ddState.SelectedValue = pAddress.StateCode.ToString();
        }
        if (pAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = pAddress.CityCode.ToString();
        }
        if (pAddress.AddLevel1 > 0)
        {
            ddlDistricts.SelectedValue = pAddress.AddLevel1.ToString();
        }
        if (pAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = pAddress.AddLevel2.ToString();
        }
        txtPostalCode.Text = pAddress.PostalCode;
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
        txtAddress2.Text = NAddress.Add2;
        txtAddress3.Text = NAddress.Add3;
        ddlCity.SelectedValue = NAddress.City;

        if (NAddress.CountryCode > 0)
        {
            ddCountry.SelectedValue = NAddress.CountryCode.ToString();
        }
        if (NAddress.StateCode > 0)
        {
            ddState.SelectedValue = NAddress.StateCode.ToString();
        }
        if (NAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = NAddress.CityCode.ToString();
        }
        if (NAddress.AddLevel1 > 0)
        {
            ddlDistricts.SelectedValue = NAddress.AddLevel1.ToString();
        }
        if (NAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = NAddress.AddLevel2.ToString();
        }

        hdnAddressCountry.Value = NAddress.CountryCode.ToString();
        hdnAddressState.Value = NAddress.StateCode.ToString();
        hdnCityID.Value = NAddress.CityCode.ToString();
        hdnDistricts.Value = NAddress.AddLevel1.ToString();
        hdnLoclities.Value = NAddress.AddLevel2.ToString();
      
        txtPostalCode.Text = NAddress.PostalCode;
        txtMobile.Text = NAddress.MobileNumber;
        txtLandLine.Text = NAddress.LandLineNumber;
        txtOtherCountry.Text=NAddress.OtherCountryName;
        txtOtherState.Text=NAddress.OtherStateName;
        
    }

    public NurseAddress nurseAddress()
    {
        NurseAddress NAddress = new NurseAddress();
        if (txtAddressID.Text != "")
        {
            NAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        NAddress.Add1 = txtAddress1.Text;
        NAddress.Add2 = txtAddress2.Text;
        NAddress.Add3 = txtAddress3.Text;
        NAddress.AddressType = iAddressType.ToString();

        NAddress.CountryCode = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != string.Empty) ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        NAddress.StateCode = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != string.Empty) ? Convert.ToInt32(hdnAddressState.Value) : 0;
        NAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != string.Empty) ? Convert.ToInt32(hdnCityID.Value) : 0;
        NAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != string.Empty) ? Convert.ToInt32(hdnDistricts.Value) : 0;
        NAddress.AddLevel1 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != string.Empty) ? Convert.ToInt32(hdnLoclities.Value) : 0;
        NAddress.CountryID = Convert.ToInt16(CountryID);
        NAddress.StateID = Convert.ToInt16(StateID);
        
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
        txtAddress2.Text = phyAddress.Add2;
        txtAddress3.Text = phyAddress.Add3;

        if (phyAddress.CountryCode > 0)
        {
            ddCountry.SelectedValue = phyAddress.CountryCode.ToString();
        }
        if (phyAddress.StateCode > 0)
        {
            ddState.SelectedValue = phyAddress.StateCode.ToString();
        }
        if (phyAddress.CityCode > 0)
        {
            ddlCity.SelectedValue = phyAddress.CityCode.ToString();
        }
        if (phyAddress.AddLevel1 > 0)
        {
            ddlDistricts.SelectedValue = phyAddress.AddLevel1.ToString();
        }
        if (phyAddress.AddLevel2 > 0)
        {
            ddllocalities.SelectedValue = phyAddress.AddLevel2.ToString();
        }
        
        hdnAddressCountry.Value = phyAddress.CountryCode.ToString();
        hdnAddressState.Value = phyAddress.StateCode.ToString();
        hdnCityID.Value = phyAddress.CityCode.ToString();
        hdnDistricts.Value = phyAddress.AddLevel1.ToString();
        hdnLoclities.Value = phyAddress.AddLevel2.ToString();
        txtPostalCode.Text = phyAddress.PostalCode;

        txtMobile.Text = phyAddress.MobileNumber;
        txtLandLine.Text = phyAddress.LandLineNumber;
        txtOtherCountry.Text=phyAddress.OtherCountryName ;
        txtOtherState.Text=phyAddress.OtherStateName ;
        
    }

    public PhysicianAddress physicianAddress()
    {
        PhysicianAddress phyAddress = new PhysicianAddress();
        if (txtAddressID.Text != "")
        {
            phyAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        phyAddress.Add1 = txtAddress1.Text;
        phyAddress.Add2 = txtAddress2.Text;
        phyAddress.Add3 = txtAddress3.Text;
        phyAddress.AddressType = iAddressType.ToString();
        
        
        phyAddress.City = ddlCity.SelectedValue;
        phyAddress.CountryID = Convert.ToInt16(CountryID);
        phyAddress.StateID = Convert.ToInt16(StateID);
        phyAddress.CountryCode = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != string.Empty) ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        phyAddress.StateCode = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != string.Empty) ? Convert.ToInt32(hdnAddressState.Value) : 0;
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
        txtAddress2.Text = pAddress.Add2;
        txtAddress3.Text = pAddress.Add3;
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
        short CountryID;
        short StateID;
        short CityID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        Int16.TryParse(hdnCityID.Value, out CityID);
        objAddress.City = CityID.ToString();
        Int16.TryParse(hdnAddressCountry.Value, out CountryID);
        Int16.TryParse(hdnAddressState.Value, out StateID);
        objAddress.CountryID = CountryID;
        objAddress.StateID = StateID;
        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        return objAddress;

    }
    public PatientAddress GetPAddress()
    {
        //LoadCountry() run;    
        PatientAddress objAddress = new PatientAddress();
        short CountryID;
        
        Utilities objut = new Utilities();
        string sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress2.Text;
        objAddress.Add2 = txtAddress1.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);

        
        TempCountryId = hdnAddressCountry.Value == "" ? TempCountryId : hdnAddressCountry.Value;
       
        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        objAddress.CountryCode = (hdnAddressCountry.Value != sDefSelect && hdnAddressCountry.Value != "") ? Convert.ToInt32(hdnAddressCountry.Value) : 0;
        objAddress.StateCode = (hdnAddressState.Value != sDefSelect && hdnAddressState.Value != "") ? Convert.ToInt32(hdnAddressState.Value) : 0;
        objAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != "") ? Convert.ToInt32(hdnCityID.Value) : 0;
        objAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != "") ? Convert.ToInt32(hdnDistricts.Value) : 0;
        objAddress.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != "") ? Convert.ToInt32(hdnLoclities.Value) : 0;
        return objAddress;

    }
    public PatientAddress GetAddress()
    { 
        PatientAddress objAddress = new PatientAddress();
        short CountryID;
        short StateID;
        short CityID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        Int16.TryParse(ddlCity.SelectedValue,out CityID);
        objAddress.City = CityID.ToString();
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        objAddress.CountryID = CountryID;
        objAddress.StateID = StateID;
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
        short CountryID;
        short StateID;

        objEmployer.PatientID = patientID;
        objEmployer.EmployerName = employerName;
        objEmployer.EmployeeName = employeeName;
        objEmployer.EmployeeNo = employeeNo;
        objEmployer.Add1 = txtAddress1.Text;
        objEmployer.Add2 = txtAddress2.Text;
        objEmployer.Add3 = txtAddress3.Text;
        objEmployer.City = ddlCity.SelectedValue;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        objEmployer.CountryID = CountryID;
        objEmployer.StateID = StateID;
        objEmployer.PostalCode = txtPostalCode.Text;
        objEmployer.MobileNumber = txtMobile.Text;
        objEmployer.LandLineNumber = txtLandLine.Text;
        objEmployer.CreatedBy = createdBy;
        objEmployer.OtherCountryName = txtOtherCountry.Text;
        objEmployer.OtherStateName = txtOtherState.Text;
        return 0;

    }

    #region Properties

    public enum eAddType
    {
        CURRENT = 1, PERMANENT = 2, ALTERNATE = 3, OFFICE = 4
    }

    public eAddType AddressType
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
            int CCodeID = lstOrgUsers[0].CountryCode;
            int Statecode = lstOrgUsers[0].StateCode;
            int CityCode = lstOrgUsers[0].CityCode;
            int disCode = lstOrgUsers[0].AddLevel1;
            int locCode = lstOrgUsers[0].AddLevel2;
            LoadCountry(CodeID);
            if (lstOrgUsers[0].CountryCode > 0)
            {
                ddCountry.SelectedValue = lstOrgUsers[0].CountryCode.ToString();
            }
            hdnAddressCountry.Value = lstOrgUsers[0].CountryCode.ToString();
            
            LoadStates(CCodeID);
            LoadCity(Statecode);
            LoadDistricts(CityCode);
            Loadlocalities(disCode);
            
           
            //int cid = Convert.ToInt32(lstOrgUsers[0].CountryID.ToString());

            if (lstOrgUsers[0].StateCode > 0)
            {
                ddState.SelectedValue = lstOrgUsers[0].StateCode.ToString();
            }
            hdnAddressState.Value = lstOrgUsers[0].StateCode.ToString();
            txtAddress1.Text = lstOrgUsers[0].Add1;
            txtAddress2.Text = lstOrgUsers[0].Add2;
            txtAddress3.Text = lstOrgUsers[0].Add3;
            //ddlCity.Text = lstOrgUsers[0].City;
            if (lstOrgUsers[0].CityCode > 0)
            {
                ddlCity.SelectedValue = lstOrgUsers[0].CityCode.ToString();
            }
            hdnCityID.Value = lstOrgUsers[0].CityCode.ToString();
            if (lstOrgUsers[0].AddLevel1 > 0)
            {
                ddlDistricts.SelectedValue = lstOrgUsers[0].AddLevel1.ToString();
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
            int cid = Convert.ToInt32(lstOrgLocation[0].CountryID.ToString());
            ddCountry.SelectedValue = lstOrgLocation[0].CountryID.ToString();
            LoadState(cid);
            ddState.SelectedValue = lstOrgLocation[0].StateID.ToString();
            txtAddress1.Text = lstOrgLocation[0].Add2;
            txtAddress2.Text = lstOrgLocation[0].Add1;
            txtAddress3.Text = lstOrgLocation[0].Add3;
            ddlCity.SelectedValue = lstOrgLocation[0].City;
            ddCountry.SelectedValue = lstOrgLocation[0].CountryID.ToString();
            ddState.SelectedValue = lstOrgLocation[0].StateID.ToString();
            txtPostalCode.Text = lstOrgLocation[0].PostalCode;
            txtMobile.Text = lstOrgLocation[0].MobileNumber;
            txtLandLine.Text = lstOrgLocation[0].LandLineNumber;
            txtOtherCountry.Text = lstOrgLocation[0].OtherCountryName;
            txtOtherState.Text = lstOrgLocation[0].OtherStateName;
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
    


    public string GetAddressDetails(PatientAddress cAddress)
    {
        string Address = "<table><tr><td>";
        if (cAddress.Add1 != "")
        {
            Address += cAddress.Add1 + ","+cAddress.Add2+", </td><td> </td></tr><tr><td>";;
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
         Address += "-"+cAddress.PostalCode + "</td><td></td></tr><tr><td>";
        }   
        if (cAddress.MobileNumber != "")
        {
            Address += "Mob : " + cAddress.MobileNumber + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.LandLineNumber != "")
        {
            Address += "Ph : " + cAddress.LandLineNumber+"</td><td></td></tr><tr><td>";
        }
        if (cAddress.OtherCountryName != "")
        {
            Address += "OCountry: " + cAddress.OtherCountryName + "</td><td></td></tr><tr><td>";
        }
        if (cAddress.OtherStateName != "")
        {
            Address += "OState : " + cAddress.OtherStateName + "</td><td></td></tr><tr><td>";
        }
        Address+=" </td></tr></table>";
        return Address;
        
    }
    public void clearAddress()
    {

        LoadCountry(CodeID);
        txtAddressID.Text = "";
        txtAddress1.Text = "";
        txtAddress2.Text = "";
        txtAddress3.Text = "";
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

   
    protected void LoadState(int ID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Localities> lstLocalities = new List<Localities>();
        long returnCode = -1;

        ddState.Items.Clear();
        int stateID = 0;
        //Decimal Key = new decimal(0.00);
        try
        {

            //returnCode = stateBL.GetStateByCountry(countryID, out states);
            returnCode = countryBL.GetLocalities(ID, out lstLocalities);
            foreach (Localities st in lstLocalities)
            {
                ddState.Items.Add(new ListItem(st.Locality_Value, st.Locality_ID.ToString()));
            }
            ddState.Items.Insert(0, "Select");
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
    public string ddlDistrictsID { get { return ddlDistricts.ClientID; } }

    public void LoadStates(int CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        Utilities objUt = new Utilities();
        string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddState.DataSource = lstLocalities;
            ddState.DataTextField = "Locality_Value";
            ddState.DataValueField = "Locality_ID";
            ddState.DataBind();
            ddState.Items.Insert(0, Select);
            var childItems = (from n in lstLocalities
                              where n.ParentID == CodeID
                              select new { n.Locality_ID, n.ISDCode }).ToList();
            if (childItems.Count() > 0)
            {
                txtCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
                txtCountryCode.Enabled = false;

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

    public void LoadCity(int CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        Utilities objUt = new Utilities();
        string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddlCity.DataSource = lstLocalities;
            ddlCity.DataTextField = "Locality_Value";
            ddlCity.DataValueField = "Locality_ID";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, Select);



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    public void LoadDistricts(int CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        Utilities objUt = new Utilities();
        string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddlDistricts.DataSource = lstLocalities;
            ddlDistricts.DataTextField = "Locality_Value";
            ddlDistricts.DataValueField = "Locality_ID";
            ddlDistricts.DataBind();
            ddlDistricts.Items.Insert(0, Select);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    public void Loadlocalities(int CodeID)
    {
        long returnCode = -1;
        Country_BL countryBL = new Country_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
        List<Localities> lstLocalities = new List<Localities>();
        List<InvestigationMaster> i = new List<InvestigationMaster>();

        Country selectedCountry = new Country();
        //ddCountry.Items.Clear();
        Utilities objUt = new Utilities();
        string Select = objUt.GetDefaultEntryForDropDownControl("Defaults", "Select");

        try
        {

            returnCode = countryBL.GetLocalities(CodeID, out lstLocalities);
            ddllocalities.DataSource = lstLocalities;
            ddllocalities.DataTextField = "Locality_Value";
            ddllocalities.DataValueField = "Locality_ID";
            ddllocalities.DataBind();
            ddllocalities.Items.Insert(0, Select);
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
        string sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");  
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            useAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        useAddress.Add1 = txtAddress1.Text;
        useAddress.Add2 = txtAddress2.Text;
        useAddress.Add3 = txtAddress3.Text;
        useAddress.AddressType = iAddressType.ToString();
       // useAddress.City = txtCity.Text;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        useAddress.CountryID = CountryID;
        useAddress.StateID = StateID;
        useAddress.PostalCode = txtPostalCode.Text;
        useAddress.MobileNumber = txtMobile.Text;
        useAddress.LandLineNumber = txtLandLine.Text;
        useAddress.CreatedBy = LID;
        useAddress.OtherCountryName = txtOtherCountry.Text;
        useAddress.OtherStateName = txtOtherState.Text;

        useAddress.CountryCode = (ddCountry.SelectedValue != sDefSelect && ddCountry.SelectedValue != "") ? Convert.ToInt32(ddCountry.SelectedValue) : 0;
        useAddress.StateCode = (ddState.SelectedValue != sDefSelect && ddState.SelectedValue != "") ? Convert.ToInt32(ddState.SelectedValue) : 0;
        useAddress.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != "") ? Convert.ToInt32(hdnCityID.Value) : 0;
        useAddress.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != "") ? Convert.ToInt32(hdnDistricts.Value) : 0;
        useAddress.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != "") ? Convert.ToInt32(hdnLoclities.Value) : 0;

       

        return useAddress;
    }

    public OrgUsers GetDynamicAddress(OrgUsers eUsers)
    {
        eUsers.Add1 = txtAddress1.Text;
        eUsers.Add2 = txtAddress2.Text;
        eUsers.Add3 = txtAddress3.Text;
        eUsers.CountryID = Convert.ToInt16(CountryID);
        eUsers.StateID = Convert.ToInt16(StateID);
        string sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");
        eUsers.CountryCode = (ddCountry.SelectedValue != sDefSelect && ddCountry.SelectedValue != "") ? Convert.ToInt32(ddCountry.SelectedValue) : 0;
        eUsers.StateCode = (ddState.SelectedValue != sDefSelect && ddState.SelectedValue != "") ? Convert.ToInt32(ddState.SelectedValue) : 0;
        eUsers.CityCode = (hdnCityID.Value != sDefSelect && hdnCityID.Value != "") ? Convert.ToInt32(hdnCityID.Value) : 0;
        eUsers.AddLevel1 = (hdnDistricts.Value != sDefSelect && hdnDistricts.Value != "") ? Convert.ToInt32(hdnDistricts.Value) : 0;
        eUsers.AddLevel2 = (hdnLoclities.Value != sDefSelect && hdnLoclities.Value != "") ? Convert.ToInt32(hdnLoclities.Value) : 0;
        eUsers.PostalCode = txtPostalCode.Text;
        eUsers.MobileNumber = txtMobile.Text;
        eUsers.LandLineNumber = txtLandLine.Text;
        return eUsers;
    }

   
}


