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


public partial class UserControl_QuickAddressControl : BaseControl
{
    eAddType iAddressType;
    string title = string.Empty;
    string tabIndex = string.Empty;
    public short tIndex = 0;
    static string TempStateId = string.Empty;
    static string TempCountryId = string.Empty;
    public string StartIndex
    {
        get
        {
            return tabIndex;
        }
        set
        {
            tabIndex = value;
            
            tIndex = Convert.ToInt16(tabIndex);
            txtAddress2.TabIndex = tIndex++;
            txtAddress1.TabIndex = tIndex++;
            txtAddress3.TabIndex = tIndex++;
            txtCity.TabIndex = tIndex++;
            ddCountry.TabIndex = tIndex++;
            ddState.TabIndex = tIndex++;
            txtPostalCode.TabIndex = tIndex++;
            txtMobile.TabIndex = tIndex++;
            txtLandLine.TabIndex = tIndex++;
            txtOtherCountry.TabIndex = tIndex++;
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
        litTitle.Text = Title;

        if (!IsPostBack)
        {
            if (ddCountry.Items.Count <= 0)
                LoadCountry();
        }
        txtAddress2.Rows = 1;
        txtAddress2.Columns = 20;
        //txtMobile.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtLandLine.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtPostalCode.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtCity.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
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
    public string GetCurrentPageName()
    { 
        string sPath = System.Web.HttpContext.Current.Request.Url.AbsolutePath;
        System.IO.FileInfo oInfo = new System.IO.FileInfo(sPath);
        string sRet = oInfo.Name; return sRet;
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
                ddState.Items.Add(new ListItem(st.StateName.ToUpper(),st.StateID.ToString()));
            }
            
            //selectedState = states.Find(FindState);
            //ddState.SelectedValue = selectedState.StateID.ToString();
            //Int32.TryParse(ddState.SelectedItem.Value, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }

    protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (ddCountry.SelectedIndex > 0)
        //{
            DropDownList dd=  (DropDownList)sender;
            LoadState(Convert.ToInt32(ddCountry.SelectedValue));
            ViewState["Country"] = ddCountry.SelectedItem.Value.ToString();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sky1", "showotherUCcouuntry('" + dd.ClientID + "');", true);

        //}
    }

    protected void ddState_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddState.SelectedIndex > 0)
        {
            ViewState["State"] = ddState.SelectedItem.Value.ToString();
        }
    }

    public void SetAddress(PatientAddress pAddress)
    {
        LoadCountry();
        txtAddressID.Text = pAddress.AddressID.ToString();
        //changes by GURUNATH.S
        txtAddress2.Text = pAddress.Add1;
        txtAddress1.Text = pAddress.Add2;
        //
        txtAddress3.Text = pAddress.Add3;
        txtCity.Text = pAddress.City;
        ddCountry.SelectedValue = pAddress.CountryID.ToString();
        LoadState(Convert.ToInt32(ddCountry.SelectedValue));
        ddState.SelectedValue = pAddress.StateID.ToString();
        txtPostalCode.Text = pAddress.PostalCode;
        txtMobile.Text = pAddress.MobileNumber;
        txtLandLine.Text = pAddress.LandLineNumber;
        txtOtherCountry.Text = pAddress.OtherCountryName;
        txtOtherState.Text = pAddress.OtherStateName;
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

    public void SetAddress(NurseAddress NAddress)
    {
        LoadCountry();
        txtAddressID.Text = NAddress.AddressID.ToString();
        txtAddress1.Text = NAddress.Add1;
        txtAddress2.Text = NAddress.Add2;
        txtAddress3.Text = NAddress.Add3;
        txtCity.Text = NAddress.City;
        ddCountry.SelectedValue = NAddress.CountryID.ToString();
        ddState.SelectedValue = NAddress.StateID.ToString();
        txtPostalCode.Text = NAddress.PostalCode;
        txtMobile.Text = NAddress.MobileNumber;
        txtLandLine.Text = NAddress.LandLineNumber;
        txtOtherCountry.Text=NAddress.OtherCountryName;
        txtOtherState.Text=NAddress.OtherStateName;
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

    public NurseAddress nurseAddress()
    {
        NurseAddress NAddress = new NurseAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            NAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        NAddress.Add1 = txtAddress1.Text;
        NAddress.Add2 = txtAddress2.Text;
        NAddress.Add3 = txtAddress3.Text;
        NAddress.AddressType = iAddressType.ToString();
        NAddress.City = txtCity.Text;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        NAddress.CountryID = CountryID;
        NAddress.StateID = StateID;
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
        LoadCountry();
        txtAddressID.Text = phyAddress.AddressID.ToString();
        txtAddress1.Text = phyAddress.Add1;
        txtAddress2.Text = phyAddress.Add2;
        txtAddress3.Text = phyAddress.Add3;
        txtCity.Text = phyAddress.City;
        ddCountry.SelectedValue = phyAddress.CountryID.ToString();
        ddState.SelectedValue = phyAddress.StateID.ToString();
        txtPostalCode.Text = phyAddress.PostalCode;
        txtMobile.Text = phyAddress.MobileNumber;
        txtLandLine.Text = phyAddress.LandLineNumber;
        txtOtherCountry.Text=phyAddress.OtherCountryName ;
        txtOtherState.Text=phyAddress.OtherStateName ;
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

    public PhysicianAddress physicianAddress()
    {
        PhysicianAddress phyAddress = new PhysicianAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            phyAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }

        phyAddress.Add1 = txtAddress1.Text;
        phyAddress.Add2 = txtAddress2.Text;
        phyAddress.Add3 = txtAddress3.Text;
        phyAddress.AddressType = iAddressType.ToString();
        phyAddress.City = txtCity.Text;
        CountryID =Convert.ToInt16(ddCountry.SelectedValue);
        StateID = Convert.ToInt16(ddState.SelectedValue); 
        //Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        //Int16.TryParse(ddState.SelectedValue, out StateID);
        phyAddress.CountryID = CountryID;
        phyAddress.StateID = StateID;
        phyAddress.PostalCode = txtPostalCode.Text;
        phyAddress.MobileNumber = txtMobile.Text;
        phyAddress.LandLineNumber = txtLandLine.Text;
        phyAddress.CreatedBy = LID;
        phyAddress.OtherCountryName = txtOtherCountry.Text;
        phyAddress.OtherStateName = txtOtherState.Text;
        return phyAddress;
    }

    public void SetAddress(UserAddress uAddress)
    {
        LoadCountry();
        txtAddressID.Text = uAddress.AddressID.ToString();
        txtAddress1.Text = uAddress.Add1;
        txtAddress2.Text = uAddress.Add2;
        txtAddress3.Text = uAddress.Add3;
        txtCity.Text = uAddress.City;
        
        ddCountry.SelectedValue = uAddress.CountryID.ToString();
        ddState.SelectedValue = uAddress.StateID.ToString();
        txtPostalCode.Text = uAddress.PostalCode;
        txtMobile.Text = uAddress.MobileNumber;
        txtLandLine.Text = uAddress.LandLineNumber;
        txtOtherCountry.Text=uAddress.OtherCountryName ;
        txtOtherState.Text=uAddress.OtherStateName ;
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

    public UserAddress GetAddress1()
    {
        UserAddress useAddress = new UserAddress();
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
        useAddress.City = txtCity.Text;
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
        return useAddress;
    }

    public void SetLabRefOrgAddress(LabRefOrgAddress pAddress)
    {
        LoadCountry();
        txtAddressID.Text = pAddress.AddressID.ToString();
        txtAddress1.Text = pAddress.Add1;
        txtAddress2.Text = pAddress.Add2;
        txtAddress3.Text = pAddress.Add3;
        txtCity.Text = pAddress.City;
        ListItem Country = ddCountry.Items.FindByValue(pAddress.CountryID.ToString());

        if (Country != null)
        {
            ddCountry.SelectedValue = pAddress.CountryID.ToString();
        }
        if (ddState.Items.FindByValue(pAddress.StateID.ToString()) != null)
        {
            ddState.SelectedValue = pAddress.StateID.ToString();
        }
        txtPostalCode.Text = pAddress.PostalCode;
        txtMobile.Text = pAddress.MobileNumber;
        txtLandLine.Text = pAddress.LandLineNumber;
        txtOtherCountry.Text = pAddress.OtherCountryName;
        txtOtherState.Text = pAddress.OtherStateName;
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
    public LabRefOrgAddress GetLabRefOrgAddress()
    {
        //LoadCountry();    
        LabRefOrgAddress objAddress = new LabRefOrgAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        objAddress.City = txtCity.Text;
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
    public PatientAddress GetPAddress()
    {
        //LoadCountry();    
        PatientAddress objAddress = new PatientAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        //changes By GURUNATH.S
        objAddress.Add1 = txtAddress2.Text;
        objAddress.Add2 = txtAddress1.Text;
        //
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        objAddress.City = txtCity.Text;
        Int16.TryParse(ddCountry.SelectedValue, out CountryID);
        Int16.TryParse(ddState.SelectedValue, out StateID);
        TempCountryId = hdnCurrentAddressCountry.Value == "" ? TempCountryId : hdnCurrentAddressCountry.Value;
        objAddress.CountryID = hdnCurrentAddressCountry.Value == "" ? Convert.ToInt16(TempCountryId) : Convert.ToInt16(hdnCurrentAddressCountry.Value);
        TempStateId = hdnCurrentAddressState.Value == "" ? TempStateId : hdnCurrentAddressState.Value;
        objAddress.StateID = hdnCurrentAddressState.Value == "" ? Convert.ToInt16(TempStateId) : Convert.ToInt16(hdnCurrentAddressState.Value);
        objAddress.PostalCode = txtPostalCode.Text;
        objAddress.MobileNumber = txtMobile.Text;
        objAddress.LandLineNumber = txtLandLine.Text;
        objAddress.OtherCountryName = txtOtherCountry.Text;
        objAddress.OtherStateName = txtOtherState.Text;
        return objAddress;

    }
    public PatientAddress GetAddress()
    { 
        PatientAddress objAddress = new PatientAddress();
        short CountryID;
        short StateID;
        if (txtAddressID.Text != "")
        {
            objAddress.AddressID = Convert.ToInt32(txtAddressID.Text);
        }
        objAddress.Add1 = txtAddress1.Text;
        objAddress.Add2 = txtAddress2.Text;
        objAddress.Add3 = txtAddress3.Text;
        objAddress.AddressType = iAddressType.ToString();
        objAddress.City = txtCity.Text;
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
        objEmployer.City = txtCity.Text;
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
            int cid = Convert.ToInt32(lstOrgUsers[0].CountryID.ToString());
            ddCountry.SelectedValue = lstOrgUsers[0].CountryID.ToString();
            LoadState(cid);
            ddState.SelectedValue = lstOrgUsers[0].StateID.ToString();
            txtAddress1.Text = lstOrgUsers[0].Add1;
            txtAddress2.Text = lstOrgUsers[0].Add2;
            txtAddress3.Text = lstOrgUsers[0].Add3;
            txtCity.Text = lstOrgUsers[0].City;
            ddCountry.SelectedValue = lstOrgUsers[0].CountryID.ToString();
            ddState.SelectedValue = lstOrgUsers[0].StateID.ToString();
            txtPostalCode.Text = lstOrgUsers[0].PostalCode;
            txtMobile.Text = lstOrgUsers[0].MobileNumber;
            txtLandLine.Text = lstOrgUsers[0].LandLineNumber;
            txtOtherCountry.Text = lstOrgUsers[0].OtherCountryName;
            txtOtherState.Text = lstOrgUsers[0].OtherStateName;
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
            txtCity.Text = lstOrgLocation[0].City;
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
    //     txtAddress1.Text = pAddress.Add1;
    //txtAddress2.Text = pAddress.Add2;
    //txtAddress3.Text = pAddress.Add3;
    //txtCity.Text = pAddress.City;
    //ddCountry.SelectedValue = pAddress.CountryID.ToString();
    //ddState.SelectedValue = pAddress.StateID.ToString();
    //txtPostalCode.Text = pAddress.PostalCode;
    //txtMobile.Text = pAddress.MobileNumber;
    //txtLandLine.Text = pAddress.LandLineNumber;


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
        LoadCountry();
        txtAddressID.Text = "";
        txtAddress1.Text = "";
        txtAddress2.Text = "";
        txtAddress3.Text = "";
        txtCity.Text = "";
        txtPostalCode.Text = "";
        txtMobile.Text = "";
        txtLandLine.Text = "";
        txtOtherCountry.Text = "";
        txtOtherState.Text = "";

    }
    
}
