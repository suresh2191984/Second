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
using System.Xml;
using System.Web.Script.Serialization;
using Attune.Podium.EMR;
using Attune.Podium.PerformingNextAction;
using System.Text.RegularExpressions;

public partial class Patient_ManagePatientEMR : BasePage, IDisposable
{
    IP_BL ipBL;
    long returnCode = -1;
    List<IPComplaint> lstIPComplaint = new List<IPComplaint>();
    List<PhysioCompliant> lstPhysioCompliant = new List<PhysioCompliant>();
    BillingEngine billingEngineBL;
    Patient objPatient = new Patient();
    int AgeValue = 0;
    long PatientId = -1;
    string AgeUnit = string.Empty;
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtenderPatient.ContextKey = OrgID.ToString() + '~' + PatientId.ToString() +'~' + 0 ;
        hdnOrgID.Value = OrgID.ToString();
        ipBL = new IP_BL(base.ContextInfo);
        ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
        ddlSex.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "ddlgender" + "');");
        tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
        LoadQuickBillLoading();
    }
    public void LoadQuickBillLoading()
    {
        try
        {
            List<Salutation> lstTitles = new List<Salutation>();
            List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
            List<Country> lstNationality = new List<Country>();
            List<Country> lstCountries = new List<Country>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            billingEngineBL = new BillingEngine(base.ContextInfo);
            billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
            LoadTitle(lstTitles);
            LoadCountry(lstCountries);
            LoadURNtype();
            if (!IsPostBack)
            {
                LoadMeatData();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Quick Billing LoadQuickBillLoading() Method", ex);
        }

    }
    public string StrUrn = "";
    public void LoadURNtype()
    {
        if (ddlUrnType.SelectedIndex == -1)
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
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,DespatchType";
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
                    ddlSex.Items.Insert(0, "--Select--");
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
                    ddMarital.Items.Insert(0, "--Select--");
                    ddMarital.Items[0].Value = "0";
                    ddMarital.SelectedValue = "0";
                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "PatientType"
                                  select child;

                if (childItems3.Count() > 0)
                {
                    ddlPatientType.DataSource = childItems3;
                    ddlPatientType.DataTextField = "DisplayText";
                    ddlPatientType.DataValueField = "Code";
                    ddlPatientType.DataBind();
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    protected void LoadCountry(List<Country> lstcountries)
    {
        if (ddCountry.SelectedIndex == -1)
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
                var childItems = (from n in lstcountries
                                  where n.IsDefault == "Y"
                                  select new { n.CountryID, n.ISDCode }).ToList();
                if (childItems.Count() > 0)
                {
                    hdnDefaultCountryID.Value = childItems[0].CountryID.ToString();
                    lblCountryCode.Text = "+" + childItems[0].ISDCode.ToString();
                    hdnDefaultCountryStdCode.Value = "+" + childItems[0].ISDCode.ToString();
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
    }
    protected void LoadState(int countryID)
    {
        if (ddState.SelectedIndex == 0)
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

            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName, st.StateID.ToString()));
            }

                selectedState = states.Find(FindState);
                ddState.Value = selectedState.StateID.ToString();
                Int32.TryParse(ddState.Value, out stateID);
                hdnPatientStateID.Value = selectedState.StateID.ToString();
                hdnDefaultStateID.Value = selectedState.StateID.ToString();
                //Int32.TryParse(, out stateID);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading Sate", ex);
            }
            finally
            {
            }
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

    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {

            return true;
        }
        return false;
    }

    private void LoadTitle(List<Salutation> lstTitles)
    {
        try
        {
            if (ddSalutation.SelectedItem == null)
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
    protected void btnSaveEMR_Click(object sender, EventArgs e)
    {
        List<PatientQualification> lstQualification = new List<PatientQualification>();
        List<PatientPreferences> lstPatientPreferences = new List<PatientPreferences>();
        Patient_BL patientBL = new Patient_BL();
        objPatient = GetPatientDetails();
        string uName = string.Empty;
        string Pwd = string.Empty;
        string patientNumber = string.Empty;
        long val = -1;
        long patientID = -1;
        try
        {
            string[] SplitAge = objPatient.Age.Split('~');
            AgeValue = Convert.ToInt32(SplitAge[0]);
            returnCode = patientBL.SavePatient(objPatient, objPatient.DOB, AgeValue, objPatient.AgeUnit, "", "", out uName, out  Pwd, out patientNumber, out patientID, val, lstQualification);

            string AlertMesg = "Patient No: " + patientNumber;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "Save Emr", "javascript:clearPageControlsVal('N');alert('" + AlertMesg + "');", true);
            string ICDvalue = ComplaintICDCodeBP1.Returnval();
            string[] icd = ICDvalue.Split('^');
            for (int i = 0; i < (icd.Length)-1; i++)
            {
                PhysioCompliant lstPhysioCompliants = new PhysioCompliant();
                string [] IcdValue = icd[i].Split('~');
                string icdCode = IcdValue[3];
                int complaintID = int.Parse(IcdValue[2]);
                lstPhysioCompliants.ComplaintID = complaintID;
                lstPhysioCompliants.ICDCode = icdCode;
                lstPhysioCompliant.Add(lstPhysioCompliants);
            }
            List<string> value = new List<string>();
            string[] valueOf = new string[0];
            string[] values = hdnPreference.Value.Split('~');
            for (int row = 0; row <= values.Length - 1; row++)
            {
                if (values[row] != "")
                {
                    valueOf = values[row].Split('^');
                    value.Add(valueOf[1].ToString());
                }
            }
            for (int i = 0; i < (value.Count); i++)
            {
                PatientPreferences lstPatientPreference = new PatientPreferences();
                lstPatientPreference.PatientPreference = value[i].ToString();
                lstPatientPreference.PatientID = patientID;
                lstPatientPreferences.Add(lstPatientPreference);
            }
            
           // hdnPreference.Value="";
            returnCode = patientBL.SavePatientEMRDetails(lstPhysioCompliant, patientID, lstPatientPreferences);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Method in Manage EMR Page", ex);
        }
    }

    public Patient GetPatientDetails()
    {
        Patient patient = new Patient();
        try
        {
            UserAddress useAddress = new UserAddress();
            short CountryID;
            short StateID;
            PatientAddress PA = new PatientAddress();
            Int16 age = 0;
            DateTime DOB = new DateTime();
            objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            List<PatientAddress> pAddresses = new List<PatientAddress>();
            string[] SplitAge = objPatient.Age.Split('~');
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

            string finalPName = txtName.Text.Trim().ToString();
            patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.Name = finalPName;
            patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            patient.SEX = ddlSex.SelectedValue;
            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            patient.DOB = Convert.ToDateTime(Date);
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            patient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            patient.PatientNumber = hdnPatientNumber.Value;
            PA.Add1 = txtAddress.Text.Trim();
            PA.Add2 = txtSuburban.Text.Trim();
            PA.City = txtCity.Text.Trim();
            patient.Add3 = "";
            PA.AddressType = "P";
            PA.LandLineNumber = txtPhone.Text.Trim();
            PA.MobileNumber = txtMobileNumber.Text.Trim();
            PA.PostalCode = txtPincode.Text;
            Int16.TryParse(ddCountry.SelectedValue, out CountryID);
            //Int16.TryParse(ddState.Value, out StateID);
            Int16.TryParse(hdnPatientStateID.Value, out StateID);
            PA.CountryID = CountryID;
            PA.StateID = StateID;
            pAddresses.Add(PA);
            patient.PatientAddress = pAddresses;
            patient.MartialStatus = ddMarital.SelectedValue.ToString();
            patient.CompressedName = finalPName.ToString();
            patient.StateID = StateID;
            patient.CountryID = CountryID;
            patient.RegistrationFee = 0;
            patient.SmartCardNumber = "0";
            patient.RelationName = "";
            patient.RelationTypeId = 0;
            patient.Race = "";
            patient.EMail = txtEmail.Text;
            patient.AgeUnit = AgeUnit;
            if (txtURNo.Text.Trim() != "")
            {
                patient.URNO = txtURNo.Text;
                patient.URNofId = Convert.ToInt64(ddlUrnoOf.SelectedValue);
                patient.URNTypeId = Convert.ToInt64(ddlUrnType.SelectedValue);
            }
            else
            {
                patient.URNO = "";
                patient.URNofId = 0;
                patient.URNTypeId = 0;
            }
            patient.VisitPurposeID = 3;
            //ClientID = hdnClientID.Value == "-1" ? Convert.ToInt32(hdnBaseClientID.Value) : Convert.ToInt32(hdnClientID.Value);
            patient.PatientVisitID = Convert.ToInt32(HDPatientVisitID.Value);
            patient.PatientType = ddlPatientType.SelectedValue;
            return patient;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Getting GetPatientDetails() Method in Manage EMR Page", ex);
            return patient;
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
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


    
}
