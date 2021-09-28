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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Linq;

public partial class Masters_Reg : BasePage
{
    long patientID = 0;
    long pid = 0;
    int AgeLimit = 0;
    string compName = string.Empty;
    string finalPName = string.Empty;
    Patient_BL patient ;
    long returncode = -1;
    static string EmpDE = string.Empty;
    public string EmpReg = string.Empty;
    CommonControls_EmployerRegDetail objcntrl;
	
	 string AlertType = Resources.Reception_AppMsg.Reception_Header_Alert == null ? "Alert" : Resources.Reception_AppMsg.Reception_Header_Alert;
    string strSelect = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20;
    string strProblem = Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_15 == null ? "There was a problem in photo upload. Please contact system administrator." : Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_15;

     public Masters_Reg()
        : base("Reception_PatientRegistration_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            patient = new Patient_BL(base.ContextInfo);
            Int64.TryParse(Request.QueryString["PID"], out patientID);
            if (patientID != 0)
            {
                trapprovedby.Style.Add("display", "block");
            }
            else
            {
                trapprovedby.Style.Add("display", "none");
            }
            if (isCorporateOrg != null)
                hdnIsCorpOrg.Value = isCorporateOrg;
            if (isCorporateOrg == "Y")
            {
                #region CorporateOrg Vijayaraja
                Control objCtrl;
                objCtrl = LoadControl("../CommonControls/EmployerRegDetail.ascx");
                objcntrl = (CommonControls_EmployerRegDetail)objCtrl;
                objCtrl.ID = "uctrlEmployer";
                //objcntrl.LoadSessionValue();
                pnEmployerDetails.Controls.Add(objCtrl);
                Rs_SmartCard.Visible = false;
                chkGenerateLogin.Visible = false;
                tradmitdaycare.Visible = false;
                rowSmartCard.Visible = false;
                divSmartCard1.Visible = false;
                EmpControl.Attributes.Add("style", "block");
                // divEmp1.Attributes.Add("style", "none");
                trFileNo.Attributes.Add("style", "block");
                //---------------------------------AgeLimit Configuration
                List<Config> lstConfig = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("AgeLimitForDependents", OrgID, out lstConfig);
                if (lstConfig.Count > 0)
                    AgeLimit = Convert.ToInt32(lstConfig[0].ConfigValue.Trim());
                hdnPatientAgeLimit.Value = AgeLimit.ToString();
                //--------------------------------------------------------
                tdBloodgrouplable.Visible = false;
                tdBloodgrouplable1.Visible = false;
                #endregion
            }
            //smart card code added - begins
            uctlSmartCard1.ShowIssueSmartCard = true;
            //smart card code added - ends
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "OrgID", "var OrgID= '" + OrgID + "';", true);
            AutoApprovedBy.ContextKey = OrgID.ToString();
            AutoCompleteProduct.ContextKey = "Y";
            cAdsame.Attributes.Add("onclick", "toggle('CAD','" + cAdsame.ClientID.ToString() + "');");
            //tDOB.Attributes.Add("onblur", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0); countAge('" + tDOB.ClientID.ToString() + "');");            
            ddSalutation.Attributes.Add("onchange", "setSexValue('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            ddSex.Attributes.Add("onchange", "setSalValue('" + ddSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            txtPatientNo.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtRegistFees.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            //txtName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            txtAge.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtAge.Attributes.Add("onblur", "setDOBYear('" + txtAge.ClientID.ToString() + "');");
            tAlias.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            //txtReligion.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            txtDOBNos.Attributes.Add("onkeydown", "return ValidateOnlyNumeric(this);");
            txtDOBNos.Attributes.Add("onblur", "setDOBYear('" + txtDOBNos.ClientID.ToString() + "');");
            //divOthers.Style.Add("display", "none");

            txtAddress.Rows = 1;
            txtAddress.Columns = 23;

            if (allowPatientAccess())
            {
                chkGenerateLogin.Visible = true;
            }
            else
            {
                chkGenerateLogin.Visible = false;
                chkGenerateLogin.Checked = false;
            }

            if (Request.QueryString["mode"] == "q")
            {
                // pnlQuick.Visible = true;
                //  pnlFull.Visible = false;
            }
            if (chkUploadPhoto.Checked)
            {
                PhotoUpload.Style.Add("display", "none");
            }
            if (!IsPostBack)
            {
                ScriptManager1.RegisterPostBackControl(btnFinish);
                ScriptManager1.RegisterPostBackControl(btnUpdate);
                ScriptManager1.RegisterPostBackControl(btnURNo);
                ScriptManager1.RegisterPostBackControl(btnCancel);

                List<Racemaster> Race = new List<Racemaster>();
                returncode = patient.getRaceDetails(out Race);
                ddRace.DataSource = Race;
                ddRace.DataTextField = "racename";
                ddRace.DataValueField = "racename";
                ddRace.DataBind();
                string chkdaycare = GetConfigValue("IsDayCare", OrgID);
                if (chkdaycare != "Y")
                {
                    chkDayCare.Visible = false;
                }
                else
                {
                    chkDayCare.Visible = true;
                }

                //ddRace.Items.Insert(0, "---Select-->");

                //btnPrint.Enabled = true;
                //if (isSmartCardUser()) //Commented by mohan for fixing replication of smart card config
                //{
                //    lblUseSmartCard.Text = "Y";
                //    txtPatientNo.Enabled = true;
                //}
                //else
                //{
                //    lblUseSmartCard.Text = "N";
                //    txtPatientNo.Enabled = false;
                //}
                LoadTitle();
                SetMenu(); LoadNationality(); LoadReligion();

                LoadMetaData();
                //To Show State in the edit Patient Registration Details 
                LoadCountry();
                URNControl1.LoadURNtype();

                if ((Request.QueryString["PID"] != null) && (Request.QueryString["TORG"] == "Y"))
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    PopulatePatientDetails(patientID);
                    //btnFinish.Text = "Enter URNo & Make Visit";
                    btnURNo.Visible = true;
                    btnURNo.Enabled = true;
                    hdnTOrg.Value = "Y";
                    //btnPrint.Visible = false;
                }
                else if (Request.QueryString["PID"] != null)
                {
                    trPatientStatus.Style.Add("display", "block");
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    PopulatePatientDetails(patientID);
                    //btnFinish.Text = "Update";
                    btnUpdate.Visible = true;
                    btnUpdate.Enabled = true;
                    hdnTOrg.Value = "N";
                    string strDaycare = string.Empty;
                    strDaycare = Convert.ToString(Request.QueryString["vType"]);
                    if (strDaycare == "DayCare")
                    {
                        chkBox.Visible = true;
                        chkDayCare.Visible = true;
                        chkDonor.Visible = true;
                    }
                    else
                    {
                        chkBox.Visible = false;
                        chkDayCare.Visible = false;
                        chkDonor.Visible = false;
                    }
                    //btnPrint.Visible = false;
                }
                else if (Request.QueryString["PID"] == null)
                {
                    btnFinish.Enabled = true;
                    btnFinish.Visible = true;

                    string feeType = "RegistrationFees";
                    string regFees = string.Empty;
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                    if (lstConfig.Count > 0)
                        regFees = lstConfig[0].ConfigValue.Trim();
                    txtRegistFees.Text = regFees;
                    chkBox.Visible = true;
                    //txtRegistFees.Enabled = false;


                }
                if (Request.QueryString["Rid"] != null)
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "URN", "var URN= 'Y';", true);
                    txtPatientNo.Text = "";
                    txtRegistFees.Text = "";
                    txtRegistFees.Enabled = true;
                    // btnFinish.Text = "Finish";
                    btnFinish.Visible = true;
                    btnFinish.Enabled = true;
                    txtPatientNo.Enabled = false;
                    hdnTOrg.Value = "N";
                }
                else
                {
                    Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "URN", "var URN= 'N';", true);
                }
                //--------------------------------------------Hind uses of Hide trFileNo
                if (IsCorporateOrg == "Y")
                {
                    //btnFinish.Enabled = false;
                    if (btnFinish.Visible == true)
                        hdnInsertorUpdate.Value = "1";
                    else
                        hdnInsertorUpdate.Value = "0";

                    //btnUpdate.Visible = true;
                    //btnUpdate.Enabled = true;
                }
                //--------------------------------------------------------------
            }
            else
            {
                if (lblUseSmartCard.Text == "Y")
                {
                    txtPatientNo.Enabled = true;
                }
                else
                {
                    txtPatientNo.Enabled = false;
                }
            }
            SetTabIndex();
            //code added for smart card access - begin
            string smartCard = "IssueSmartCard";
            List<Config> lstConfigSmart = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails(smartCard, OrgID, out lstConfigSmart);
            if (lstConfigSmart.Count > 0)
                if (lstConfigSmart[0].ConfigValue.Trim() == "Y")
                {
                    rowSmartCard.Visible = true;
                }
                else { rowSmartCard.Visible = false; }
            //code added for smart card access - begin
            //code added for Configuring Redirecting to patientVisit - begins

            List<Config> lstConfigRedirect = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("RedirectToPatientVisit", OrgID, out lstConfigRedirect);
            if (lstConfigRedirect.Count > 0)
            {
                if (lstConfigRedirect[0].ConfigValue.Trim() == "Y")
                {
                    hdnRedirectPateintVisit.Value = "Y";
                }
                else { hdnRedirectPateintVisit.Value = "N"; }
            }
            else
            {
                hdnRedirectPateintVisit.Value = "N";
            }
            //code added for Configuring Redirecting to patientVisit - ends

            //code added by suresh
            //LoadCountry();

        }
        catch (Exception ex)
        {
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "alert('There was a problem in page load. Please contact system administrator');", true);
            CLogger.LogError("Error in PatientRegistration:Page_Load", ex);
            //btnFinish.Visible = true;
            // btnFinish.Enabled = true;
            if (btnFinish.Visible == true)
            {
                btnFinish.Enabled = true;
            }
            if (btnUpdate.Visible == true)
            {
                btnUpdate.Enabled = true;
            }
            if (btnURNo.Visible == true)
            {
                btnURNo.Enabled = true;
            }
            //btnPrint.Enabled = true;
        }

    }

    #region suresh added
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
            ddCountry.Items.Insert(0, strSelect.Trim());
            #region Get the Country using isDefault
                selectedCountry = countries.Find(FindCountry);
                ddCountry.SelectedValue = selectedCountry.CountryID.ToString();
                Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            #endregion
            #region Set the Country by location's country
                if (CountryID > 0)
                {
                    ddCountry.SelectedValue = CountryID.ToString();
                    countryID = CountryID;
                }
            #endregion
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

            ddState.Items.Insert(0, "Select");
            if (StateID > 0)
            {
                ddState.SelectedValue = StateID.ToString();
            }
            else
            {
                ddState.SelectedValue = "0";
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
    protected void ddCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddCountry.SelectedIndex > 0)
        {
            LoadState(Convert.ToInt32(ddCountry.SelectedValue));
            LoadNationalityOfCountry(Convert.ToInt32(ddCountry.SelectedValue));
            ViewState["Country"] = ddCountry.SelectedItem.Value.ToString();
        }


    }



    #endregion


    private bool allowPatientAccess()
    {
        bool retval = false;
        List<Config> lstConfig = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("AllowPatientAccess", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            if (lstConfig[0].ConfigValue == "Y")
                retval = true;
        }
        return retval;
    }

    private bool isSmartCardUser()
    {
        bool retval = false;
        List<Config> lstConfig = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("UseSmartCardForPatient", OrgID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            if (lstConfig[0].ConfigValue == "Y")
                retval = true;
        }
        return retval;
    }

    public void saveCorporatePatient(long PatientID, string picExtension, out string EmpTypeNumber)
    {
        EmpTypeNumber = string.Empty;
        Patient_BL pbl = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        List<EmployeeRegMaster> EmpDetails = new List<EmployeeRegMaster>();
        objcntrl.GetDetail(out EmpDetails);
        Int64 type = 0;
        pbl.InsertPatientEmployee(txtName.Text, LID, PatientID, type, EmpDetails, picExtension, out EmpTypeNumber);

    }

    public void saveCorporatePatient(long PatientID, string EmpNo, string picExtension, out string EmpTypeNumber)
    {
        EmpTypeNumber = string.Empty;
        Patient_BL pbl = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        List<EmployeeRegMaster> EmpDetails = new List<EmployeeRegMaster>();
        objcntrl.GetDetail(out EmpDetails);
        Int64 type = 1;
        pbl.InsertPatientEmployee(EmpNo, LID, PatientID, type, EmpDetails, picExtension, out EmpTypeNumber);

    }

    private void PopulatePatientDetails(long patientID)
    {
        Patient_BL pBL = new Patient_BL(base.ContextInfo);
        List<Patient> patients = new List<Patient>();
        List<AllergyMaster> Allergy = new List<AllergyMaster>();
        //AllergyMaster Agy = new AllergyMaster();
        Patient patient = new Patient();
        URNTypes objURNTypes = new URNTypes();
        try
        {
            pBL.GetPatientDemoandAddress(patientID, out patients);
            pBL.GetPatientAllergy((int)patientID, out Allergy);
            foreach (AllergyMaster Agy in Allergy)
            {
                if (Agy.AllergyType == "Drug")
                {
                    chkDrugs_1061.Checked = true;
                    this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> showContentHis('chkDrugs_1061'); </script>");
                    foreach (ListItem item in chkDrugs.Items)
                    {
                        if (Agy.AllergyId == int.Parse(item.Value))
                        {
                            item.Selected = true;

                        }
                        if (Agy.AllergyId == 0)
                        {
                            item.Selected = true;
                            this.Page.RegisterStartupScript("skydrugOthers", "<script type='text/javascript'> showdrugothers('chkDrugs'); </script>");
                            txtOthersTypeDrugs_34.Text = Agy.AllergyName.ToString();
                        }

                        HdnDrug.Value += Agy.AllergyId + "~" + Agy.AllergyName + "^";
                    }
                }
                else if (Agy.AllergyType == "Food")
                {
                    chkFood_1062.Checked = true;
                    this.Page.RegisterStartupScript("skyFoodDetails", "<script type='text/javascript'> showContent('chkFood_1062'); </script>");

                    foreach (ListItem item in chkFood.Items)
                    {
                        if (Agy.AllergyId == int.Parse(item.Value))
                        {
                            item.Selected = true;

                        }
                        if (Agy.AllergyId == 0)
                        {
                            item.Selected = true;
                            txtOthersTypeFood_37.Text = Agy.AllergyName.ToString();
                            this.Page.RegisterStartupScript("skyfoodOthers", "<script type='text/javascript'> showfoodothers('chkFood'); </script>");
                        }

                    }
                    HdnFood.Value += Agy.AllergyId + "~" + Agy.AllergyName + "^";
                }
            }


            if (patients.Count > 0)
                patient = patients[0];
            LoadState(Convert.ToInt32(patient.PatientAddress[0].CountryID));
            txtName.Text = patient.Name;
            tAlias.Text = patient.AliasName;
            string[] idMarks = patient.PersonalIdentification == null ? "".Split() : patient.PersonalIdentification.Split('~');
            if (idMarks.Length > 0)
            {
                if (idMarks[0] != null)
                    txtIdentification1.Text = idMarks[0];
            }
            if (idMarks.Length > 1)
            {
                if (idMarks[1] != null)
                    txtIdentification2.Text = idMarks[1];
            }
            ddSalutation.SelectedValue = patient.TITLECode.ToString();
            txtEmail.Text = patient.EMail;

            string temp = patient.DOB.ToShortDateString().ToString();
            if (patient.DOB.ToShortDateString().ToString() == "01/01/0001")
            {
                tDOB.Text = "";
                txtAge.Text = "";
            }
            else
            {
                tDOB.Text = patient.DOB.ToShortDateString();
                //txtAge.Text = patient.Age.ToString();
                int page = 0; // Convert.ToInt32(lstPatient[0].PatientAge.Split(' ')[0]);
                if (patient.Age != "" && patient.Age != null)
                {
                    Int32.TryParse(patient.Age.Split(' ')[0].ToString(), out page);
                    txtDOBNos.Text = page.ToString(); //patient.Age.Split(' ')[0].ToString();
                    ddlDOBDWMY.SelectedValue = patient.Age.Split(' ')[1].Substring(0, 1).ToString();
                }
            }

            txtRelation.Text = patient.RelationName;
            txtOccupation.Text = patient.OCCUPATION;
            ddMarital.SelectedValue = patient.MartialStatus;
            ddlReligion.SelectedValue = patient.Religion;// txtReligion.Text = patient.Religion;
            ddSex.SelectedValue = patient.SEX;
            txtPlaceOfBirth.Text = patient.PlaceOfBirth;
            if (IsCorporateOrg == "N")
            ddBloodGrp.SelectedValue = patient.BloodGroup;
            txtPatientNo.Text = patient.PatientNumber;
            ddRace.SelectedItem.Text = patient.Race;
            ddlNationality.SelectedValue = patient.Nationality.ToString();// txtNationality.Text = patient.Nationality;
            txtFileNo.Text = patient.FileNo;
            objURNTypes.URN = patient.URNO;
            objURNTypes.URNof = patient.URNofId;
            objURNTypes.URNTypeId = patient.URNTypeId;
            URNControl1.SetURN(objURNTypes);
            txtPatientNo.Enabled = false;
            txtRegistFees.Text = patient.RegistrationFee.ToString();
            txtRegistFees.Enabled = false;
            rblPatientStatus.SelectedValue = patient.Status;

            bool isPhotoNotExist = true;
            if (!String.IsNullOrEmpty(patient.PictureName))
            {
                string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
                if (File.Exists(imagePath + patient.PictureName))
                {
                    imgPatient.Src = "PatientImageHandler.ashx?FileName=" + patient.PictureName;
                    hdnPatientImageName.Value = patient.PictureName;
                    divRemovePhoto.Style.Add("display", "block");
                    lblUploadPhoto.InnerHtml = "Update";
                    isPhotoNotExist = false;
                }
            }
            if(isPhotoNotExist)
            {
                imgPatient.Src = "~/Images/ProfileDefault.jpg";
                hdnPatientImageName.Value = string.Empty;
                divRemovePhoto.Style.Add("display", "none");
                lblUploadPhoto.InnerHtml = "Upload";
            }

            PatientAddress cAddress = new PatientAddress();
            PatientAddress pAddress = new PatientAddress();

            if (patient.PatientAddress[0].AddressType == "C")
            {
                cAddress = patient.PatientAddress[0];
                pAddress = patient.PatientAddress[1];
            }
            else
            {
                cAddress = patient.PatientAddress[1];
                pAddress = patient.PatientAddress[0];
            }
            ucCAdd.SetAddress(cAddress);
            ucPAdd.SetAddress(pAddress);
            txtAddress.Text = pAddress.Add1;
            txtCity.Text = pAddress.City;
            txtMobile.Text = pAddress.MobileNumber;
            txtLandLine.Text = pAddress.LandLineNumber;
            txtOtherCountry.Text = pAddress.OtherCountryName;
            txtOtherState.Text = pAddress.OtherStateName;
            //To Show State in the edit Patient Registration Details
            ddCountry.SelectedValue = pAddress.CountryID.ToString();
            ddState.SelectedValue = pAddress.StateID.ToString();
            Suppliers sup = new Suppliers();

            string ddBloodGrpe = string.Empty;
            if (IsCorporateOrg == "Y")
            {
                //objcntrl = (CommonControls_EmployerRegDetail)FindControl("uctrlEmployer");
                objcntrl.LoadEmployeeDetails(patientID, "", "", OrgID);
                DropDownList ddlddBloodGrpe = (DropDownList)objcntrl.FindControl("ddBloodGrp");
                //DropDownList ddlPatientType = (DropDownList)objcntrl.FindControl("ddlPatientType");
                //DropDownList ddlExtended = (DropDownList)objcntrl.FindControl("ddlExtended");
                //TextBox txtEmployerID = (TextBox)objcntrl.FindControl("txtEmployerID");
                //TextBox txtEmployementTypeNo = (TextBox)objcntrl.FindControl("txtEmployementTypeNo");
                //Button lblFetchEmpDetail0 = (Button)uctrlEmployer.FindControl("lblFetchEmpDetail0");
                //ddlPatientType.Enabled = false;
                //ddlExtended.Enabled = false;
                //txtEmployerID.Enabled = false;
                //txtEmployementTypeNo.Enabled = false;
                //lblFetchEmpDetail0.Visible = false;
                ddlddBloodGrpe.SelectedValue = patient.BloodGroup;
                ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "javascript:showResponse();", true);
            }

            if (Request.QueryString["Rid"] != null)
            {
                txtPatientNo.Text = "";
                txtPatientNo.Enabled = true;
                txtRegistFees.Text = ""; txtRegistFees.Enabled = true;
            }


            if (patient.SmartCardIssued == "Y" && patient.SmartCardNumber != "")
            {
                uctlSmartCard1.ShowIssueSmartCard = false;
                uctlSmartCard1.ShowReIssueSmartCard = true;
                uctlSmartCard1.ShowUpdateSmartCardno = false;

            }
            else if (patient.SmartCardIssued == "Y" && patient.SmartCardNumber == "")
            {
                uctlSmartCard1.ShowIssueSmartCard = false;
                uctlSmartCard1.ShowReIssueSmartCard = false;
                uctlSmartCard1.ShowUpdateSmartCardno = true;

            }
            else if (patient.SmartCardIssued == "N" && patient.SmartCardNumber == "")
            {
                uctlSmartCard1.ShowIssueSmartCard = false;
                uctlSmartCard1.ShowReIssueSmartCard = true;
                uctlSmartCard1.ShowUpdateSmartCardno = false;

            }
            else if (patient.SmartCardIssued == "" && patient.SmartCardNumber == "")
            {
                uctlSmartCard1.ShowIssueSmartCard = true;
                uctlSmartCard1.ShowReIssueSmartCard = false;
                uctlSmartCard1.ShowUpdateSmartCardno = false;

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing PopulatePatientDetails", ex);
        }
    }
    //    long cAddrId = 0;
    //    long pAddrId = 0;
    private void SetMenu()
    {

    }

    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
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
            returnCode = titelBL.GetTitle(OrgID, LanguageCode, out titles);
            Salutation selectedSalutation = new Salutation();
            int titleID = 0;
            if (returnCode == 0)
            {
                ddSalutation.DataSource = titles;
                ddSalutation.DataTextField = "TitleName";
                ddSalutation.DataValueField = "TitleID";
                ddSalutation.DataBind();
                //selectedSalutation = titles.Find(Findsalutation);
                //ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
                Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
            }
            else
            {
                CLogger.LogWarning("Salutation cannot be retrieved");
                //edisp.Visible = true;
                //ErrorDisplay1.ShowError = true;
                // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        string strError = Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_12 == null ? "Error while saving patient details.Please try after some time." : Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_12;
        string strSuccessSave = Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_13 == null ? "Patient registration successfull. Patient Number:" : Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_13;
        string strErrorSysAdmin = Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_14 == null ? "There was a problem in page load. Please contact system administrator" : Resources.Reception_AppMsg.Reception_PatientRegistration_aspx_14;

        int BtnStatus = -1;
        if(hdnBtnStatus.Value!="")
        BtnStatus = Int32.Parse(hdnBtnStatus.Value);

        if (BtnStatus == 0)
        {
            btnFinish.Enabled = false;
        }
        if (BtnStatus == 1)
        {
            btnUpdate.Enabled = false;
        }
        if (BtnStatus == 2)
        {
            btnURNo.Enabled = false;
        }

        //btnFinish.Enabled = false;
        try
        {
            List<PatientQualification> lstQualification = new List<PatientQualification>();
            if (hdnPatientID.Value == string.Empty)
            {
                long returnCode = -1;
                Int16 age = 0;
                DateTime DOB = new DateTime();
                Patient patient = new Patient();
                Patient_BL patBL = new Patient_BL(base.ContextInfo);
                int cnt = 0;
                List<PatientAddress> pAddresses = new List<PatientAddress>();
                List<AllergyMaster> Allergylst = new List<AllergyMaster>();
                //if (btnFinish.Text == "Finish")
                if (BtnStatus == 0)
                {
                    if (txtPatientNo.Text.Length > 0)
                    {
                        List<Patient> lPatient = new List<Patient>();
                        returnCode = new Patient_BL(base.ContextInfo).GetRegistrationStatus(txtPatientNo.Text, OrgID, out cnt, out lPatient);
                    }
                }
                if (cnt > 0)
                {
                    string sPath = "Reception\\PatientRegistration.aspx.cs_7";
                    ClientScript.RegisterStartupScript(this.GetType(), "regis", "ShowAlertMsg('" + sPath + "');", true);
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientRegistration.aspx.cs_7").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "regis", "alert('" + sUserMsg + "');", true);
                    //}
                    //else
                    //{
                    //    ClientScript.RegisterStartupScript(this.GetType(), "regis", "alert('Patient number already exits');", true);
                    //}
                }
                else
                {
                    //finalPName = Utilities.removeSCharinName(txtName.Text);
                    string ddBloodGrpe = string.Empty;
                    string ENumber = string.Empty;
                    #region Corporateorg
                    if (IsCorporateOrg == "Y")
                    {
                        string ddlPatientType = string.Empty;
                        string ddlEmployerName = string.Empty;
                        DropDownList ddlddBloodGrpe = (DropDownList)objcntrl.FindControl("ddBloodGrp");
                        ddBloodGrpe = ddlddBloodGrpe.SelectedValue;
                        DropDownList ddlddlPatientType = (DropDownList)objcntrl.FindControl("ddlPatientType");
                        ddlPatientType = ddlddlPatientType.SelectedValue;
                        if (Convert.ToInt32(ddlPatientType) == 1)
                        {
                            TextBox txtEPatientNumber = (TextBox)objcntrl.FindControl("txtEmployementTypeNo");
                            DropDownList ddlddlEmployerName = (DropDownList)objcntrl.FindControl("ddlEmployerName");
                            ddlEmployerName = ddlddlEmployerName.SelectedValue;
                            ENumber = txtEPatientNumber.Text + "~" + ddlddlPatientType.SelectedValue + "~" + ddlEmployerName;
                        }
                        else if (Convert.ToInt32(ddlPatientType) == 4)
                        {
                            TextBox txtEPatientNumber = (TextBox)objcntrl.FindControl("txtExternalnumber");
                            ENumber = txtEPatientNumber.Text + "~" + ddlddlPatientType.SelectedValue + "~" + ddlEmployerName;
                        }
                        else
                        {
                            TextBox txtEPatientNumber = (TextBox)objcntrl.FindControl("txtEmployerID");
                            ENumber = txtEPatientNumber.Text + "~" + ddlddlPatientType.SelectedValue + "~" + ddlEmployerName;
                        }
                    }
                    #endregion
                    finalPName = txtName.Text.Trim();
                    TextBox txtmno = (TextBox)ucPAdd.FindControl("txtMobile");
                    TextBox txtllno = (TextBox)ucPAdd.FindControl("txtLandLine");

                    //returnCode = new Patient_BL(base.ContextInfo).CheckPatientforDuplicate(txtName.Text, txtmno.Text, txtllno.Text, OrgID, out cnt);
                   
                    if (Request.QueryString["PID"] == null)
                    {
                        returnCode = new Patient_BL(base.ContextInfo).CheckPatientforDuplicate(finalPName, txtmno.Text.Trim(), txtllno.Text.Trim(), OrgID,ENumber, out cnt);
                    }
                    else
                    {
                        cnt = 0;
                    }
                    if (cnt <= 0)
                    {
                        //compName = Utilities.getCompressedName(txtName.Text.Trim());
                        compName = txtName.Text.Trim();
                        patient.Name = finalPName;
                        patient.AliasName = tAlias.Text.Trim();
                        patient.PersonalIdentification = txtIdentification1.Text.Trim();
                        patient.PersonalIdentification += "~" + txtIdentification2.Text.Trim();
                        patient.AlternateContact = "";
                        patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
                        patient.EMail = txtEmail.Text.Trim();
                        if (tDOB.Text.Trim().Length > 0)
                        {
                            if (!DateTime.TryParse(tDOB.Text.Trim(), out DOB))
                                DOB = new DateTime(1800, 1, 1);
                        }
                        else
                        {
                            // Min. default date.DateTime cannot be null and cannot be less that 1701
                            DOB = new DateTime(1800, 1, 1);
                        }
                        patient.DOB = DOB;
                        Int16.TryParse(txtAge.Text.Trim(), out age);
                        patient.Age = age.ToString();
                        patient.RelationName = txtRelation.Text.Trim();
                        patient.OCCUPATION = txtOccupation.Text.Trim();
                        patient.MartialStatus = ddMarital.SelectedValue;
                        patient.Religion = ddlReligion.SelectedValue;// txtReligion.Text.Trim();
                        patient.SEX = ddSex.SelectedValue;
                        patient.PlaceOfBirth = txtPlaceOfBirth.Text.Trim();
                        patient.BloodGroup = ddBloodGrp.SelectedValue == "-1" ? ddBloodGrpe : ddBloodGrp.SelectedValue;
                        patient.PatientNumber = txtPatientNo.Text.Trim();
                        txtRegistFees.Text = (txtRegistFees.Text.Trim() == "") ? "0" : txtRegistFees.Text.Trim();
                        patient.RegistrationFee = Convert.ToDecimal(txtRegistFees.Text.Trim());
                        patient.OrgID = OrgID;
                        patient.CreatedBy = LID;
                        patient.ModifiedBy = LID;
                        URNTypes objURNTypes = URNControl1.GetURN();
                        patient.URNO = objURNTypes.URN;
                        patient.URNofId = objURNTypes.URNof;
                        patient.URNTypeId = objURNTypes.URNTypeId;
                        patient.CompressedName = compName.ToString();
                        patient.Race = ddRace.SelectedItem.Text.Trim();
                        patient.Nationality = Convert.ToInt64(ddlNationality.SelectedValue);// txtNationality.Text.Trim();
                        patient.FileNo = txtFileNo.Text;
                        string dds = ddState.SelectedValue.ToString();
                        pAddresses.Add(ucCAdd.GetPAddress());
                        pAddresses.Add(ucPAdd.GetPAddress());
                        patient.PatientAddress = pAddresses;

                        long tempaddrid = patient.PatientAddress[0].AddressID;
                        //tAlias.Text = "";
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        DateTime dtConverted = DOB;
                        int tDWMY = -1;
                        string UName = string.Empty;
                        string Pwd = string.Empty;
                        string PatientNumber = string.Empty;
                        string strCreateLogin = chkGenerateLogin.Checked == true ? "Y" : "N";


                        txtDOBNos.Text = (txtDOBNos.Text.Trim() == "") ? "0" : txtDOBNos.Text.Trim();
                        tDWMY = Convert.ToInt32(txtDOBNos.Text.Trim());

                        string picExtension = string.Empty;
                        bool isSavePicture = false;
                        if (IsCorporateOrg != "Y")
                        {
                            GetPictureExtension(out picExtension, out isSavePicture);
                        }

                        if (Request.QueryString["PID"] != null)
                        {
                            Int64.TryParse(Request.QueryString["PID"], out patientID);
                            patient.PatientID = patientID;
                            patient.Status = rblPatientStatus.SelectedValue;
                        }
                        if (Request.QueryString["Rid"] != null)
                        {
                            string Rid = Request.QueryString["Rid"];
                            string pIspatient = Request.QueryString["IsPan"];
                            returnCode = patientBL.SavePatient(patient, dtConverted, tDWMY, ddlDOBDWMY.SelectedValue, strCreateLogin, picExtension, out UName, out Pwd, out PatientNumber, out patientID, 0, lstQualification);
                            if (pIspatient == "N")
                            {
                                patient.PatientID = 0;
                                returnCode = patientBL.SavePatient(patient, dtConverted, tDWMY, ddlDOBDWMY.SelectedValue, strCreateLogin, picExtension, out UName, out Pwd, out PatientNumber, out patientID, 0, lstQualification);
                            }
                            else
                            {
                                Int64.TryParse(Request.QueryString["PID"], out patientID);

                                //Code Added for smart card - begins

                                CheckBox chkIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkIssueSmartCard");
                                string RedrictURL = string.Empty;
                                //code added for Configuring Redirecting to patientVisit
                                if (!chkBox.Checked && chkBox.Visible && hdnRedirectPateintVisit.Value != "Y")
                                {
                                    // RedrictURL = "~" + RedirectToLandingPage(); 
                                    // RedrictURL = Request.ApplicationPath + RedirectToLandingPage();
                                    if (chkDayCare.Checked == true)
                                    {
                                        RedrictURL = "../Reception/Episode.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }
                                    else
                                    {
                                        RedrictURL = Request.RawUrl;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }
                                }
                                else
                                {
                                    if (chkDayCare.Checked == true)
                                    {
                                        RedrictURL = "../Reception/Episode.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }
                                    else
                                    {
                                        GetPatientDetail(pid, UName, Pwd);
                                        RedrictURL = "../Reception/PatientVisit.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }

                                }

                                if (uctlSmartCard1.ShowIssueSmartCard && chkIssueCard.Checked)
                                {

                                    uctlSmartCard1.SetRedirectURL(hdnRedirectURL.Value);
                                    divSmartCard1.Attributes.Add("style", "display:block");
                                    //divSmartCard2.Attributes.Add("style", "display:block");
                                    divSmartCard3.Attributes.Add("style", "display:block");
                                    uctlSmartCard1.ShowPopUp();
                                    uctlSmartCard1.LoadPatientDetail(pid);
                                    if (chkDayCare.Checked == true)
                                    {
                                        RedrictURL = "../Reception/Episode.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }


                                }
                                else
                                {


                                    if (chkDayCare.Checked == true)
                                    {
                                        GetPatientDetail(pid, UName, Pwd);
                                        RedrictURL = "../Reception/Episode.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        hdnRedirectURL.Value = RedrictURL;
                                    }
                                    else
                                    {
                                        GetPatientDetail(pid, UName, Pwd);
                                        hdnRedirectURL.Value = RedrictURL;
                                    }

                                    //Response.Redirect(RedrictURL, true);

                                }
                                //Code Added for smart card - ends
                                //Response.Redirect("PatientVisit.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid, true);
                            }


                            if (returnCode != 0)
                            {
                                // ErrorDisplay1.ShowError = true;
                                //  ErrorDisplay1.Status = "Error while saving patient details.Please try after some time.";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strError.Trim() + "," + AlertType.Trim() + ");", true);
                                btnFinish.Visible = true;
                                btnFinish.Enabled = true;
                            }
                            else
                            {

                                //Code Added for smart card - begins

                                CheckBox chkIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkIssueSmartCard");

                                if (uctlSmartCard1.ShowIssueSmartCard && chkIssueCard.Checked)
                                {
                                    uctlSmartCard1.SetRedirectURL("PatientVisit.aspx?PID=" + patient.PatientID.ToString() + "&Rid=" + Rid);
                                    divSmartCard1.Attributes.Add("style", "display:block");
                                    //divSmartCard2.Attributes.Add("style", "display:block");
                                    divSmartCard3.Attributes.Add("style", "display:block");
                                    uctlSmartCard1.ShowPopUp();
                                    uctlSmartCard1.LoadPatientDetail(pid);


                                }
                                else
                                {

                                    if (chkDayCare.Checked == true)
                                    {
                                        hdnRedirectURL.Value = "../Reception/Episode.aspx?PID=" + patientID.ToString() + "&Rid=" + Rid;
                                        GetPatientDetail(pid, UName, Pwd);
                                    }
                                    else
                                    {
                                        hdnRedirectURL.Value = "PatientVisit.aspx?PID=" + patient.PatientID.ToString() + "&Rid=" + Rid;
                                        GetPatientDetail(pid, UName, Pwd);
                                    }
                                    //Response.Redirect("PatientVisit.aspx?PID=" + patient.PatientID.ToString() + "&Rid=" + Rid, true);
                                }
                                //Code Added for smart card - ends


                                //Response.Redirect("PatientVisit.aspx?PID=" + patient.PatientID.ToString() + "&Rid=" + Rid, true);



                            }
                        }


                        long ApprovedBY = 0;
                        ApprovedBY = Convert.ToInt64(hdnapprovedid.Value);
                        if (ApprovedBY == 0 && patientID != 0)
                        {
                            string sPath = "Reception\\\\PatientRegistration.aspx_25";
                            ClientScript.RegisterStartupScript(this.GetType(), "Approved", "ShowAlertMsg('" + sPath + "');", true);



                            //ClientScript.RegisterStartupScript(this.GetType(), "Approved", "alert('Provide Approved By ');", true);
                            returnCode = 0;
                            btnUpdate.Enabled = true;
                        }
                        else
                        {

                            returnCode = patientBL.SavePatient(patient, dtConverted, tDWMY, ddlDOBDWMY.SelectedValue, strCreateLogin, picExtension, out UName, out Pwd, out PatientNumber, out patientID, ApprovedBY, lstQualification);

                            //  returnCode = patientBL.SavePatient(patient, dtConverted, tDWMY, ddlDOBDWMY.SelectedValue, strCreateLogin, picExtension, out UName, out Pwd, out PatientNumber);

                            if (returnCode == -1)
                            {
                                //ErrorDisplay1.ShowError = true;
                                //ErrorDisplay1.Status = "Error while saving patient details.Please try after some time.";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strError.Trim() + "," + AlertType.Trim() + ");", true);
                                btnFinish.Visible = true;
                                btnFinish.Enabled = true;
                            }
                            else
                            {
                                string EmpTypeNumber = string.Empty;
                                if (IsCorporateOrg == "Y")
                                {
                                    GetPictureExtension(out picExtension, out isSavePicture);
                                }
                                else
                                {
                                    if (isSavePicture)
                                        SavePicture(PatientNumber, picExtension);
                                }

                                //if (btnFinish.Text == "Finish")
                                if (BtnStatus == 0)
                                {
                                    //ErrorDisplay1.ShowError = true;
                                    //ErrorDisplay1.Status = "Patient registration successfull. Patient Number: " + patient.PatientID.ToString();
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ShowAlertMsg('" + strSuccessSave.Trim() + "" + patient.PatientID.ToString() + "');", true);
                                    //DropDownList ddlpatientType=(DropDownList)uctrlEmployer.FindControl("ddlPatientType");
                                    if (IsCorporateOrg == "Y")
                                    {
                                        saveCorporatePatient(patient.PatientID, picExtension, out EmpTypeNumber);
                                        if (isSavePicture)
                                            SavePicture(EmpTypeNumber, picExtension);
                                    }
                                    pid = Convert.ToInt64(patient.PatientID);
                                    foreach (ListItem item in chkDrugs.Items)
                                    {
                                        if (item.Selected)
                                        {
                                            if (item.Text == "Others")
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = 0;
                                                Allergy.AllergyName = txtOthersTypeDrugs_34.Text;
                                                Allergy.AllergyType = "Drug";
                                                Allergylst.Add(Allergy);
                                            }
                                            else
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = int.Parse(item.Value);
                                                Allergy.AllergyName = item.Text;
                                                Allergy.AllergyType = "Drug";
                                                Allergylst.Add(Allergy);
                                            }
                                        }
                                    }
                                    foreach (ListItem item in chkFood.Items)
                                    {
                                        if (item.Selected)
                                        {
                                            if (item.Text == "Others")
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = 0;
                                                Allergy.AllergyName = txtOthersTypeFood_37.Text;
                                                Allergy.AllergyType = "Food";
                                                Allergylst.Add(Allergy);
                                            }
                                            else
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = int.Parse(item.Value);
                                                Allergy.AllergyName = item.Text;
                                                Allergy.AllergyType = "Food";
                                                Allergylst.Add(Allergy);
                                            }
                                        }
                                    }
                                    //Venkat added this line
                                    //if Allergylst.Count is zero no need to call BL method
                                    if (Allergylst.Count > 0)
                                    {
                                        returnCode = patBL.pGetPatientAllergyDetails(pid, Allergylst);
                                    }
                                    string RedrictURL = string.Empty;
                                    //code added for Configuring Redirecting to patientVisit - begins
                                    if (!chkBox.Checked && chkBox.Visible && hdnRedirectPateintVisit.Value != "Y")
                                    {
                                        long PatientVisitID = -1;
                                        long PatientID = patient.PatientID;
                                        // RedrictURL = "~" + RedirectToLandingPage(); 
                                        // RedrictURL =Request.ApplicationPath + RedirectToLandingPage();
                                        if (chkDayCare.Checked == true)
                                        {
                                            // returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                                            RedrictURL = "../Reception/Episode.aspx?PID=" + patient.PatientID.ToString() + "&vid=" + PatientVisitID;
                                            hdnRedirectURL.Value = RedrictURL;
                                        }
                                        else if (chkDonor.Checked == true)
                                        {
                                            returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                                            long ret = -1;
                                            ret = new BloodBank_BL(base.ContextInfo).InsertPatientDonor(PatientID, PatientVisitID);
                                            RedrictURL = "../Reception/PatientVisit.aspx?PID=" + patient.PatientID.ToString();
                                            hdnRedirectURL.Value = RedrictURL;
                                            long returnCodeINV = -1;
                                            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                                            returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(PatientVisitID, out lstPatientVisitDetails);
                                            Tasks task = new Tasks();
                                            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                                            UcDCard.loadDonorCardPage(lstPatientVisitDetails[0].PatientNumber, patient.Name, patient.Age, patient.SEX, patient.BloodGroup, patient.PatientAddress[0].Add1.ToString(), patient.PatientAddress[0].MobileNumber);
                                            long lVisitType = 0;
                                            if (lVisitType != 1)
                                            {
                                                //if (returnCode > 0)
                                                //{

                                                Hashtable dText = new Hashtable();
                                                Hashtable urlVal = new Hashtable();
                                                long taskIDReffered = -1;

                                                long pSpecialityID = Convert.ToInt32(TaskHelper.speciality.BloodBank);
                                                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.BloodBank), PatientVisitID, 0,
                                                 lstPatientVisitDetails[0].PatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", pSpecialityID, "", 0, "", 0, "", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                                                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.BloodBank);
                                                task.DispTextFiller = dText;
                                                task.URLFiller = urlVal;
                                                task.RoleID = RoleID;
                                                task.OrgID = OrgID;
                                                task.SpecialityID = Convert.ToInt32(pSpecialityID);
                                                //task.BillID = FinalBillID;
                                                task.PatientVisitID = PatientVisitID;
                                                task.PatientID = lstPatientVisitDetails[0].PatientID;
                                                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                                task.CreatedBy = LID;
                                                //task.RefernceID = labno.ToString();
                                                //Create task               
                                                returnCode = taskBL.CreateTask(task, out taskIDReffered);
                                                //}
                                                //if (chkboxPrintOPCard.Checked == true)
                                                //{
                                                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:popupprintDonorCard();", true);
                                                //}
                                                //else
                                                //{
                                                //Response.Redirect("../Lab/Home.aspx", true);
                                                string sPath = "Reception\\\\PatientRegistration.aspx_26";
                                                ScriptManager.RegisterStartupScript(this, this.GetType(), "Registration", "ShowAlertMsg('" + sPath + "');", true);

                                                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Registration", "alert('Donor registered successfully');", true);
                                                //}
                                                //Response.Redirect(hdnPageUrl.Value, true);
                                            }
                                            else
                                            {
                                                CLogger.LogWarning("Error in Save Patient Details");
                                                string str = "BloodBank";


                                                string sPath = "Reception\\\\PatientRegistration.aspx_27";

                                                ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ShowAlertMsg('" + sPath + "');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);

                                                
                                                //ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "alert('There was a problem in Save Billing Details.');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                                            }
                                        }
                                        else
                                        {
                                            RedrictURL = Request.RawUrl;
                                            hdnRedirectURL.Value = RedrictURL;
                                        }
                                    }
                                    else
                                    {
                                        //Venkat added this code
                                        long PatientVisitID = -1;
                                        long PatientID = patient.PatientID;
                                        if (chkBox.Checked)
                                        {
                                            returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                                            RedrictURL = "../Reception/InPatientRegistration.aspx?pid=" + PatientID.ToString() + "&vid=" + PatientVisitID;
                                            hdnRedirectURL.Value = RedrictURL;
                                        }
                                        else
                                        {
                                            RedrictURL = "../Reception/PatientVisit.aspx?PID=" + patient.PatientID.ToString();
                                        }
                                        //RedrictURL = "../Reception/PatientVisit.aspx?PID=" + patient.PatientID.ToString();
                                    }

                                    //Code Added for smart card - begins

                                    CheckBox chkIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkIssueSmartCard");

                                    if (uctlSmartCard1.ShowIssueSmartCard && chkIssueCard.Checked)
                                    {

                                        uctlSmartCard1.SetRedirectURL(RedrictURL);
                                        divSmartCard1.Attributes.Add("style", "display:block");
                                        //divSmartCard2.Attributes.Add("style", "display:block");
                                        divSmartCard3.Attributes.Add("style", "display:block");
                                        uctlSmartCard1.ShowPopUp();
                                        uctlSmartCard1.LoadPatientDetail(pid);
                                        if (chkDayCare.Checked == true)
                                        {
                                            RedrictURL = "../Reception/Episode.aspx?PID=" + patientID.ToString();
                                            hdnRedirectURL.Value = RedrictURL;
                                        }

                                    }
                                    else
                                    {
                                        //long PatientVisitID = -1;
                                        //long PatientID = patient.PatientID;
                                        //returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                                        //Response.Redirect("InPatientRegistration.aspx?pid=" + PatientID.ToString() + "&vid=" + PatientVisitID, true);
                                        if (chkDayCare.Checked == true)
                                        {
                                            GetPatientDetail(pid, UName, Pwd);
                                            RedrictURL = "../Reception/Episode.aspx?PID=" + patient.PatientID.ToString();
                                            hdnRedirectURL.Value = RedrictURL;
                                        }
                                        else
                                        {
                                            hdnRedirectURL.Value = RedrictURL;
                                            GetPatientDetail(pid, UName, Pwd);
                                        }


                                        // Response.Redirect(RedrictURL, true);
                                    }
                                    //Code Added for smart card - ends
                                    //Response.Redirect("PatientVisit.aspx?PID=" + patient.PatientID.ToString(), true);
                                }
                                //else if (btnFinish.Text == "Enter URNo & Make Visit")
                                else if (BtnStatus == 2)
                                {
                                    long pRefOrgPID = -1;
                                    //ErrorDisplay1.ShowError = true;
                                    //ErrorDisplay1.Status = "Patient registration successfull. Patient Number: " + patient.PatientID.ToString();
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ShowAlertMsg('" + strSuccessSave.Trim() + "" + patient.PatientID.ToString() + "');", true);
                                    returnCode = new Patient_BL(base.ContextInfo).InsertPatientFromReferredOrg(patient.PatientID, OrgID, out pRefOrgPID);

                                    //Code Added for smart card - begins

                                    CheckBox chkIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkIssueSmartCard");

                                    if (uctlSmartCard1.ShowIssueSmartCard && chkIssueCard.Checked)
                                    {

                                        uctlSmartCard1.SetRedirectURL("PatientVisit.aspx?PID=" + pRefOrgPID + "&vType=OP");
                                        divSmartCard1.Attributes.Add("style", "display:block");
                                        //divSmartCard2.Attributes.Add("style", "display:block");
                                        divSmartCard3.Attributes.Add("style", "display:block");
                                        uctlSmartCard1.ShowPopUp();
                                        uctlSmartCard1.LoadPatientDetail(pid);
                                        if (chkDayCare.Checked == true)
                                        {
                                            hdnRedirectURL.Value = "../Reception/Episode.aspx?PID=" + patientID.ToString();
                                            GetPatientDetail(pid, UName, Pwd);
                                        }


                                    }
                                    else
                                    {

                                        if (chkDayCare.Checked == true)
                                        {
                                            hdnRedirectURL.Value = "../Reception/Episode.aspx?PID=" + patientID.ToString();
                                            GetPatientDetail(pid, UName, Pwd);
                                        }
                                        else
                                        {
                                            hdnRedirectURL.Value = "PatientVisit.aspx?PID=" + pRefOrgPID + "&vType=OP";
                                            GetPatientDetail(pid, UName, Pwd);
                                        }
                                        //Response.Redirect("PatientVisit.aspx?PID=" + pRefOrgPID + "&vType=OP", true);
                                    }
                                    //Code Added for smart card - ends

                                    //Response.Redirect("PatientVisit.aspx?PID=" + pRefOrgPID + "&vType=OP", true);
                                }
                                //else if (btnFinish.Text == "Update")
                                else if (BtnStatus == 1)
                                {
                                    foreach (ListItem item in chkDrugs.Items)
                                    {
                                        if (item.Selected)
                                        {
                                            if (item.Text == "Others")
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = 0;
                                                Allergy.AllergyName = txtOthersTypeDrugs_34.Text;
                                                Allergy.AllergyType = "Drug";
                                                Allergylst.Add(Allergy);
                                            }
                                            else
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = int.Parse(item.Value);
                                                Allergy.AllergyName = item.Text;
                                                Allergy.AllergyType = "Drug";
                                                Allergylst.Add(Allergy);
                                            }
                                        }
                                    }
                                    foreach (ListItem item in chkFood.Items)
                                    {
                                        if (item.Selected)
                                        {
                                            if (item.Text == "Others")
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = 0;
                                                Allergy.AllergyName = txtOthersTypeFood_37.Text;
                                                Allergy.AllergyType = "Food";

                                                Allergylst.Add(Allergy);
                                            }
                                            else
                                            {
                                                AllergyMaster Allergy = new AllergyMaster();
                                                Allergy.AllergyId = int.Parse(item.Value);
                                                Allergy.AllergyName = item.Text;
                                                Allergy.AllergyType = "Food";
                                                Allergylst.Add(Allergy);
                                            }
                                        }
                                    }
                                    pid = Convert.ToInt64(patient.PatientID);
                                    returnCode = patBL.pGetPatientAllergyDetails(pid, Allergylst);
                                    //ErrorDisplay1.ShowError = true;

                                    if (IsCorporateOrg == "Y")
                                    {
                                        saveCorporatePatient(pid, txtName.Text, picExtension, out EmpTypeNumber);
                                        if (isSavePicture)
                                            SavePicture(EmpTypeNumber, picExtension);
                                    }

                                    //ErrorDisplay1.Status = "Patient update successfull. Patient Number: " + patient.PatientID.ToString();
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ShowAlertMsg('" + strSuccessSave.Trim() + "" + patient.PatientID.ToString() + "');", true);
                                    //Response.Redirect("../Reception/Home.aspx", true);
                                    List<Role> lstUserRole1 = new List<Role>();
                                    string path1 = string.Empty;
                                    Role role1 = new Role();
                                    role1.RoleID = RoleID;
                                    lstUserRole1.Add(role1);
                                    returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                                    //Code added for smart card - Begins

                                    CheckBox chkUpdateCard = (CheckBox)uctlSmartCard1.FindControl("chkUpdateSmartCardNo");
                                    CheckBox chkReIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkReIssueSmartCard");
                                    CheckBox chkIssueCard = (CheckBox)uctlSmartCard1.FindControl("chkIssueSmartCard");
                                    if ((uctlSmartCard1.ShowUpdateSmartCardno && chkUpdateCard.Checked) || (uctlSmartCard1.ShowReIssueSmartCard && chkReIssueCard.Checked) || uctlSmartCard1.ShowIssueSmartCard && chkIssueCard.Checked)
                                    {
                                        divSmartCard1.Attributes.Add("style", "display:block");
                                        divSmartCard3.Attributes.Add("style", "display:block");
                                        uctlSmartCard1.ShowPopUp();
                                        uctlSmartCard1.LoadPatientDetail(pid);
                                        uctlSmartCard1.SetRedirectURL(Request.ApplicationPath + path1);

                                    }
                                    else
                                    {

                                        //GetPatientDetail(pid);

                                        if (chkDayCare.Checked == true)
                                        {
                                            hdnRedirectURL.Value = "../Reception/Episode.aspx?PID=" + patientID.ToString();
                                            GetPatientDetail(pid, UName, Pwd);
                                        }
                                        else
                                        {
                                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:FnIsvalid();", true);
                                            //Response.Redirect(Request.ApplicationPath + path1, true);
                                        }

                                    }

                                    //Code added for smart card - Ends
                                    //Response.Redirect(Request.ApplicationPath + path1, true);
                                }
                            }
                        }
                    }
                    else
                    {
                        if (hdnBtnStatus.Value == "0")
                        {
                            btnFinish.Enabled = true;
                            btnFinish.Enabled = true;
                        }
                        if (hdnBtnStatus.Value == "1")
                        {
                            btnUpdate.Enabled = true;
                            btnUpdate.Enabled = true;
                        }
                        if (hdnBtnStatus.Value == "2")
                        {
                            btnURNo.Enabled = true;
                            btnURNo.Enabled = true;
                        }

                        //  btnFinish.Visible = true;
                        // btnFinish.Enabled = true;


                        string sPath = "Reception\\PatientRegistration.aspx.cs_10";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:ShowAlertMsg('" + sPath + "');", true);



                        //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientRegistration.aspx.cs_10").ToString();
                        //if (sUserMsg != null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "skeyShowDuplicate", "alert('" + sUserMsg + "');", true);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:alert('The patient details with same name and contact details already exist. Provide the changes and retry.');", true);
                        //}
                    }
                }
            }

            else
            {
                if (IsCorporateOrg == "Y")
                {
                    string sPath = "Reception\\PatientRegistration.aspx.cs_10";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:ShowAlertMsg('" + sPath + "');", true);




                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientRegistration.aspx.cs_10").ToString();
                    //if (sUserMsg != null)
                    //{
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "skeyShowDuplicate", "alert('" + sUserMsg + "');", true);
                    //}
                    //else
                    //{
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:alert('The patient details with same name and contact details already exist. Provide the changes and retry.');", true);
                    //}
                }
                else
                {
                    Response.Redirect(Request.ApplicationPath + "/Reception/PatientVisit.aspx?PID=" + hdnPatientID.Value + "&vType=OP");
                }
            }
        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
            if (btnFinish.Visible == true)
            {
                btnFinish.Enabled = true;
            }
            if (btnUpdate.Visible == true)
            {
                btnUpdate.Enabled = true;
            }
            if (btnURNo.Visible == true)
            {
                btnURNo.Enabled = true;
            }
            // btnFinish.Visible = true;
            // btnFinish.Enabled = true;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient details.", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strErrorSysAdmin.Trim() + "," + AlertType.Trim() + ");", true);
            // btnFinish.Visible = true;
            //btnFinish.Enabled = true;
            if (btnFinish.Visible == true)
            {
                btnFinish.Enabled = true;
            }
            if (btnUpdate.Visible == true)
            {
                btnUpdate.Enabled = true;
            }
            if (btnURNo.Visible == true)
            {
                btnURNo.Enabled = true;
            }
        }
    }

    private long CreateVisit(long returnCode, long PatientID, out long PatientVisitID)
    {
        string needIPNo = string.Empty;
        List<Config> ConfigDetails = new List<Config>();
        DateTime dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone), dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        int iRetTokenNumber = -1;
        PatientVisit pVisit = new PatientVisit();
        pVisit.VisitType = 1;
        pVisit.PhysicianName = "";
        pVisit.VisitPurposeID = (int)TaskHelper.VisitPurpose.Admission;// Visit Purpose ID for Admission is 9
        pVisit.PhysicianID = -1;
        pVisit.OrgID = OrgID;
        pVisit.PatientID = PatientID;
        pVisit.ReferingPhysicianID = -1;
        pVisit.ReferingPhysicianName = string.Empty;
        pVisit.ReferingSpecialityID = -1;
        pVisit.OrgAddressID = ILocationID;
        pVisit.SpecialityID = -1;
        pVisit.ReferOrgID = -1;

        pVisit.CreatedBy = LID;
        pVisit.ClientMappingDetailsID = 0;
        pVisit.ParentVisitId = 0;
        pVisit.PriorityID = 0;
        if (chkDonor.Checked == true)
        {
            pVisit.SpecialityID = Convert.ToInt32(TaskHelper.speciality.BloodBank);
            pVisit.VisitPurposeID = Convert.ToInt32(TaskHelper.VisitPurpose.BloodDonation);
            pVisit.VisitType = 0;
        }
        returnCode = new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out ConfigDetails);
        if (ConfigDetails.Count > 0)
            needIPNo = ConfigDetails[0].ConfigValue.Trim();
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        returnCode = new PatientVisit_BL(base.ContextInfo).SaveVisit(pVisit, out PatientVisitID, PatientID, 0, 0, 0, "", out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);

        return returnCode;
    }

    private string RedirectToLandingPage()
    {
        long returnCode = -1;
        List<Role> lstUserRole = new List<Role>();
        string path = string.Empty;
        Role role = new Role();
        role.RoleID = RoleID;
        lstUserRole.Add(role);
        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
        return path;

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    private void ExpirePageCache()
    {
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        //Response.Cache.SetExpires(Convert.ToDateTime(new BasePage().OrgDateTimeZone) - new TimeSpan(1, 0, 0));
        //Response.Cache.SetLastModified(Convert.ToDateTime(new BasePage().OrgDateTimeZone));
        //Response.Cache.SetAllowResponseInBrowserHistory(false);
    }
    protected void lnkLogOut_Click(object sender, EventArgs e)
    {


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
                selectednationality = lstNationality.Find(FindNationality);
                ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
        }
    }
    public void LoadNationalityOfCountry(int countryid)
    {
        try
        {
            long returnCode = -1;
            List<Country> lstNationality = new List<Country>();
            Country selectednationality = new Country();
            ddlNationality.Items.Clear();
            returnCode = new Country_BL(base.ContextInfo).LoadNationalityOfCountry(countryid, out lstNationality);
            if (returnCode == 0)
            {
                if (lstNationality.Count > 0)
                {
                    ddlNationality.DataSource = lstNationality;
                    ddlNationality.DataTextField = "Nationality";
                    ddlNationality.DataValueField = "NationalityID";
                    ddlNationality.DataBind();
                }
                //selectednationality = lstNationality.Find(FindNationality);
                //ddlNationality.SelectedValue = lstNationality[0].NationalityID.ToString();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
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
    public void LoadReligion()
    {
        try
        {
            long returnCode = -1;
            List<Religion> lstReligion = new List<Religion>();
            returnCode = new Country_BL(base.ContextInfo).GetReligionList(out lstReligion);
            if (returnCode == 0)
            {
                ddlReligion.DataSource = lstReligion;
                ddlReligion.DataTextField = "ReligionName";
                ddlReligion.DataValueField = "ReligionID";
                ddlReligion.DataBind();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Nationality ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
        }
    }
    private void SetTabIndex()
    {
        ddSalutation.Focus();
        short tabIndex = 0;
        ddSalutation.TabIndex = tabIndex++;
        txtName.TabIndex = tabIndex++;
        tDOB.TabIndex = tabIndex++;
        txtDOBNos.TabIndex = tabIndex++;
        ddlDOBDWMY.TabIndex = tabIndex++;
        tAlias.TabIndex = tabIndex++;
        ddMarital.TabIndex = tabIndex++;
        ddSex.TabIndex = tabIndex++;
        txtAddress.TabIndex = tabIndex++;
        txtCity.TabIndex = tabIndex++;
        txtMobile.TabIndex = tabIndex++;
        txtLandLine.TabIndex = tabIndex++;

        txtPatientNo.TabIndex = tabIndex++;
        txtRegistFees.TabIndex = tabIndex++;
        txtRelation.TabIndex = tabIndex++;
        txtPlaceOfBirth.TabIndex = tabIndex++;
        txtOccupation.TabIndex = tabIndex++;
        ddBloodGrp.TabIndex = tabIndex++;
        ddlReligion.TabIndex = tabIndex++;
        txtEmail.TabIndex = tabIndex++;
        ddRace.TabIndex = tabIndex++;
        ddlNationality.TabIndex = tabIndex++;
        txtIdentification1.TabIndex = tabIndex++;
        txtIdentification2.TabIndex = tabIndex++;
        URNControl1.StartIndex = Convert.ToString(tabIndex);
        tabIndex = URNControl1.tIndex;
        chkDrugs_1061.TabIndex = tabIndex++;
        chkFood_1062.TabIndex = tabIndex++;
        ucPAdd.StartIndex = Convert.ToString(tabIndex);
        tabIndex = ucPAdd.tIndex;
        cAdsame.TabIndex = tabIndex++;
        ucCAdd.StartIndex = Convert.ToString(tabIndex);
        tabIndex = ucCAdd.tIndex;
        btnFinish.TabIndex = tabIndex++;


    }
    private void GetPatientDetail(long patientID, string User, string Pass)
    {
        string strLogin = Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_01 == null ? "LoginID:" : Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_01;
        string strPassword = Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_02 == null ? "Password:" : Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_02;

        Patient_BL pBL = new Patient_BL(base.ContextInfo);
        List<Patient> patients = new List<Patient>();
        if (IsCorporateOrg == "N")
        {
            pBL.GetPatientDemoandAddress(patientID, out patients);
            if (patients.Count > 0)
            {
                //lblPatientName.Attributes.Add("value",patients[0].Name );
                //lblPatientNumber.Attributes.Add("value", patients[0].PatientNumber);
                //lblPatientSex.Attributes.Add("value", patients[0].SEX == "M" ? "Male" : "Female");
                ModalPopupExtender1.Show();
                lblPatientName.Text = patients[0].Name;
                lblPatientNumber.Text = patients[0].PatientNumber;
                if (!String.IsNullOrEmpty(User))
                {
                    lblUserPass.Text = "" + strLogin.Trim() + ": <b>" + User + "</b><br>  " + strPassword.Trim() + ": <b>" + Pass + "</b>";
                }
            }
        }
        else
        {
            pBL.GetEmployeeDemoandAddress(patientID, out patients);
            if (patients.Count > 0)
            {
                ModalPopupExtender1.Show();
                hdnPatientID.Value = patientID.ToString();
                Rs_PatientName.Text = "";
                Rs_PatientNumber.Text = "";
                Rs_PatientNumber.Text = "Number";
                Rs_PatientName.Text = "Name";
                lblPatientNumber.Visible = false;
                lblEmpNumber.Visible = true;
                lblPatientName.Text = patients[0].Name;
                lblEmpNumber.Text = patients[0].PatientNumber;


            }
        }
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        if (IsCorporateOrg == "Y")
        {
            //string Pth = RedirectToLandingPage();
            string PatientReg = GetConfigValue("RedirectToPatientVisit", OrgID);
            if (PatientReg == "Y")
            {
                Response.Redirect(Request.ApplicationPath + "/Reception/PatientRegistration.aspx");
            }
            else
            {
                #region Please Don't Delete Vijayaraja
                //List<EmployeeRegMaster> EmpDetails = new List<EmployeeRegMaster>();
                //uctrlEmployer.GetDetail(out EmpDetails);
                //if (EmpDetails[0].Type.ToString() == "Dep")
                //{
                //    if (EmpDetails[0].EmployerID.ToString() == "4" || EmpDetails[0].EmployerID.ToString() == "3")
                //    {
                //        if (ddMarital.SelectedItem.Text == "Married" && ddSex.SelectedItem.Text == "Female" && Convert.ToInt32(txtDOBNos.Text) > 24)
                //        {
                //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "AgeLimit", "javascript:AgeLimit();", true);
                //            Response.Redirect(Request.ApplicationPath + "/Reception/PatientRegistration.aspx");
                //        }
                //        else if (ddSex.SelectedItem.Text == "Male" && Convert.ToInt32(txtDOBNos.Text) > 24)
                //        {
                //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "AgeLimit", "javascript:AgeLimit();", true);
                //            Response.Redirect(Request.ApplicationPath + "/Reception/PatientRegistration.aspx");
                //        }
                //        else
                //        {
                //            btnEmp_Click(sender, e);
                //        }
                //    }
                //    else
                //    {
                //        btnEmp_Click(sender, e);
                //    }

                //}
                //else
                //{
                //    btnEmp_Click(sender, e);
                //}
                #endregion
                btnEmp_Click(sender, e);
            }
            //Response.Redirect(Request.ApplicationPath + "/Corporate/CorporatePatientSearch.aspx?EID=" + lblPatientNumber.Text + "&vType=OP");
            //Response.Redirect(Request.ApplicationPath + Pth);
        }
        Response.Redirect(hdnRedirectURL.Value);

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

    private void GetPictureExtension(out string picExtension, out bool isSavePicture)
    {
        picExtension = string.Empty;
        isSavePicture = false;
        if (chkRemovePhoto.Checked)
        {
            isSavePicture = true;
        }
        else if (PhotoUpload.PostedFile != null && PhotoUpload.PostedFile.ContentLength > 0)
        {
            picExtension = ".jpeg";
            isSavePicture = true;
        }
        else
        {
            picExtension = Path.GetExtension(hdnPatientImageName.Value);
        }
    }

    private void SavePicture(string number, string picExtension)
    {
        try
        {
            string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
            string picNameWithoutExt = number.Replace('/','_') + '_' + OrgID;
            string pictureName = number.Replace('/', '_') + '_' + OrgID + picExtension;
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
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in photo upload. Please contact system administrator.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
        }
    }
    protected void btnEmp_Click(object sender, EventArgs e)
    {
        try
        {
           string EmpNo = string.Empty;
           int RateID = 0;
            long retCode = -1;
            List<RateMaster> lstRateType = new List<RateMaster>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            RateMaster obja = new RateMaster();
            string OrgType = "COrg";
            retCode = objBl.pGetRateTypeMaster(OrgID, OrgType, out lstRateType);
            if (lstRateType.Count > 0)
            {
                RateID = lstRateType.Find(p => p.RateCode == "GENERAL").RateId;
            }
            Int64.TryParse(hdnPatientID.Value, out patientID);
            EmpNo = hdnEmpNo.Value.ToString();
            Response.Redirect(Request.ApplicationPath + "/Corporate/CorporateQuickBilling.aspx" + "?EmpNo=" + EmpNo.ToString() + "&PID=" + patientID.ToString()  + "&vType=" + "OP" + "&RateID=" + RateID, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("emp Visit creation faild ", ex);
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in photo upload. Please contact system administrator.";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "ValidationWindow(" + strProblem.Trim() + "," + AlertType.Trim() + ");", true);
        }


    }
   
  

    public void LoadMetaData()
    {
        string Select = Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_10 == null ? "---Select One---" : Resources.Reception_ClientDisplay.Reception_PatientRegistration_aspx_10;

        try
        {
            string domains = "DateAttributes,Gender,MaritalStatus,BloodGrp,PackageStatus,Food,TypeDrugs"; // andrews add - BloodGrp only
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain  = Tempdata[i];
                lstmetadataInput.Add(objMeta);
             
            }


              // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			  returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
              if (lstmetadataOutput.Count > 0)
              {

              
                     var childItems = from child in lstmetadataOutput
                                     where child.Domain =="DateAttributes" orderby child.DisplayText descending   
                                     select child;
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "Code";
                    ddlDOBDWMY.DataBind();


                   var childItems1 = from child in lstmetadataOutput
                                 where child.Domain =="Gender" orderby child.Code descending  
                                 select child;

                   ddSex.DataSource = childItems1;
                   ddSex.DataTextField = "DisplayText";
                   ddSex.DataValueField = "Code";
                   ddSex.DataBind();

                   var childItems2 = from child in lstmetadataOutput
                                 where child.Domain =="MaritalStatus" orderby child.MetaDataID ascending 
                                 select child;

                   ddMarital.DataSource = childItems2;
                   ddMarital.DataTextField = "DisplayText";
                   ddMarital.DataValueField = "Code";
                   ddMarital.DataBind();
                // andrews 
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "BloodGrp"
                                  select child;
                ddBloodGrp.DataSource = childItems3;
                ddBloodGrp.DataTextField = "DisplayText";
                ddBloodGrp.DataValueField = "Code";
                ddBloodGrp.DataBind();
                ddBloodGrp.Items.Insert(0, Select);


                var childItems4 = from child in lstmetadataOutput
                                  where child.Domain == "PackageStatus"
                                  orderby child.MetaDataID ascending
                                  select child;

                rblPatientStatus.DataSource = childItems4;
                rblPatientStatus.DataTextField = "DisplayText";
                rblPatientStatus.DataValueField = "Code";
                rblPatientStatus.DataBind();



                var childItems5 = from child in lstmetadataOutput
                                  where child.Domain == "TypeDrugs"
                                  orderby child.MetaDataID ascending
                                  select child;

                chkDrugs.DataSource = childItems5;
                chkDrugs.DataTextField = "DisplayText";
                chkDrugs.DataValueField = "Code";
                chkDrugs.DataBind();


                var childItems6 = from child in lstmetadataOutput
                                  where child.Domain == "Food"
                                  orderby child.MetaDataID ascending
                                  select child;

                chkFood.DataSource = childItems6;
                chkFood.DataTextField = "DisplayText";
                chkFood.DataValueField = "Code";
                chkFood.DataBind();
                }
           
        }
     
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrsuccessmsg", "alert('There was a problem in page load. Please contact system administrator');", true);
        }
    }
}
