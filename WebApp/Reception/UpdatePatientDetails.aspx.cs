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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Text;
using Attune.Podium.Common;
using System.Web.Caching;

public partial class Reception_UpdatePatientDetails: BasePage
{
    public Reception_UpdatePatientDetails()
        : base("Reception\\UpdatePatientDetails.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long PPatientID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        long result = -1;
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtAge.Attributes.Add("onblur", "age();");
        txtAge.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");      
        try
        {
            Int64.TryParse(Request.QueryString["pid"], out PPatientID);
           
            if (!IsPostBack)
            {
                LoadTitle();
                LoadNationality();
                URNTypes objURNTypes = new URNTypes();
                List<Racemaster> Race = new List<Racemaster>();
                new Patient_BL(base.ContextInfo).getRaceDetails(out Race);
                ddRace.DataSource = Race;
                ddRace.DataTextField = "racename";
                ddRace.DataValueField = "racename";
                ddRace.DataBind();
                ddRace.Items.Insert(0, "-----Select-----");
                ddRace.Items[0].Value = "0";
                URNControl1.LoadURNtype();
                if (PPatientID != 0)
                {
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    List<Patient> patientList = new List<Patient>();
                    result = patientBL.GetLabPatientDemoandAddress(PPatientID, out patientList);
                    txtPatientName.Text = patientList[0].Name;
                    ddSalutation.SelectedValue = patientList[0].TITLECode.ToString() == "" ? "0" : patientList[0].TITLECode.ToString();
                    ddSex.SelectedValue = patientList[0].SEX.ToString();
                    ddlNationality.SelectedValue= patientList[0].Nationality.ToString();
                    ddRace.SelectedValue = patientList[0].Race.ToString();
                    tDOB.Text = patientList[0].DOB.ToString();
                    string[] AgeStr = null;
                    if (patientList[0].PatientAge.ToString() != "")
                    {
                        AgeStr = patientList[0].PatientAge.Split(' ');
                        if (AgeStr.Length > 0)
                        {
                            txtAge.Text = AgeStr[0].ToString();
                            ddlAgeUnit.SelectedValue = AgeStr[1].ToString();
                        }
                        ddlAgeUnit.SelectedValue = patientList[0].Age;
                    }
                    
                    if (patientList[0].PatientAddress.Count != 0)
                    {
                        ucPAdd.SetAddress(patientList[0].PatientAddress[0]);
                       
                    }
                    objURNTypes.URN = patientList[0].URNO;

                    objURNTypes.URNof = patientList[0].URNofId;
                    objURNTypes.URNTypeId = patientList[0].URNTypeId;
                    URNControl1.StrUrn = patientList[0].URNO;
                    URNControl1.SetURN(objURNTypes);
                }
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            CLogger.LogError("Error in UpdatePatientDetails.aspx:Page_Load", ex);
        }
    }
    public void LoadNationality()
    {
        try
        {
            long returnCode = -1;
            List<Country> lstNationality = new List<Country>();
            Country selectednationality = new Country();
            returnCode = new Country_BL(base.ContextInfo).GetNationalityList(out lstNationality);
            if (returnCode == 0)
            {
                ddlNationality.DataSource = lstNationality;
                ddlNationality.DataTextField = "Nationality";
                ddlNationality.DataValueField = "NationalityID";
                ddlNationality.DataBind();
                ddlNationality.SelectedValue = "178";
                //selectednationality = lstNationality.Find(FindNationality);
                //ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    static bool FindNationality(Country c)
    {
        if (c.Nationality.ToUpper() == "Singaporean")
        {
            return true;
        }
        return false;
    }
    private void LoadTitle()
    {
        try
        {
            long returnCode = -1;
            Title_BL titelBL = new Title_BL(base.ContextInfo);
            List<Salutation> titles = new List<Salutation>();
            string LanguageCode = string.Empty;
            LanguageCode = ContextInfo.LanguageCode;
            if (Cache["titles"] == null)
            {
                returnCode = titelBL.GetTitle(OrgID ,LanguageCode , out titles);
                if (returnCode == 0)
                {
                    Cache.Add("titles", titles,null,Cache.NoAbsoluteExpiration,Cache.NoSlidingExpiration,CacheItemPriority.Normal,null);
                }
            }
            else
            {
                titles = (List<Salutation>)Cache["titles"];
                returnCode = 0;
            }
            returnCode = titelBL.GetTitle(OrgID ,LanguageCode , out titles);
            Salutation selectedSalutation = new Salutation();
            int titleID = 0;
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();
                ddSalutation.Items.Add(new ListItem("--Select--", "0"));
                ddSalutation.SelectedValue = "0";
                selectedSalutation = titles.Find(Findsalutation);
                //ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
                Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
            }
            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Loading Salutation in Patient Sample Registration.Message:", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
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
    
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
     
        try
        {
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            if (PPatientID > 0)
            {
                Patient patient = new Patient();
                PatientAddress pAddress = new PatientAddress();
                patient.PatientID = PPatientID;
                patient.Name = txtPatientName.Text;
                patient.OrgID = OrgID;
                patient.ModifiedBy = LID;
                patient.SEX = ddSex.SelectedValue;
                patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue); ;
                patient.Race = ddRace.SelectedValue;
                patient.DOB = Convert.ToDateTime(tDOB.Text);
                if (txtAge.Text != string.Empty)
                {
                    //patient.Age = Convert.ToInt16(txtAge.Text);
                    patient.Age = txtAge.Text + " " + ddlAgeUnit.Text;
                    //patient.AgeUnit = ddlAgeUnit.Text;
                }
                URNTypes objURNTypes = URNControl1.GetURN();
                patient.URNO = objURNTypes.URN;
                patient.URNofId = objURNTypes.URNof;
                patient.URNTypeId = objURNTypes.URNTypeId;
                patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
                pAddress = ucPAdd.GetAddress();
                pAddress.AddressType = "P";
                returnCode = patientBL.UpdateLabPatientDetails(patient, pAddress);
            }
           
            if (returnCode == 0)
            {
                try
                {
                    Navigation navigation = new Navigation();
                    Role role = new Role();
                    role.RoleID = RoleID;
                    List<Role> userRoles = new List<Role>();
                    userRoles.Add(role);
                    string relPagePath = string.Empty;
                    returnCode = -1;
                    returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

                    if (returnCode == 0)
                    {
                        //HdnUpdate.Value = "Updated";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Changes saved successfully.');", true);
                //string strEx = "<script>alert('At least one check box must be selected');</script>";
                        //RegisterStartupScript("Key1", strEx);
                        Response.Redirect(Request.ApplicationPath + relPagePath, true);
                    }
                }
                catch (System.Threading.ThreadAbortException tex)
                {
                    string te = tex.ToString();
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
                }
            }
           
        }
       
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Patient Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

}
