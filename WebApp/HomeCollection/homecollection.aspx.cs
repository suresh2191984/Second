using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Podium.BillingEngine;
using Microsoft.Reporting.WebForms;
using HomeCollectionsBL;
//using Attune.Solution.BusinessLogic;


public partial class HomeCollection_homecollection : BasePage
{
    Role_BL roleBL;
    public HomeCollection_homecollection()
        : base("HomeCollection_homecollection_aspx")
    {
    }
    string SCPTechID = string.Empty;
    string SCPPincode = string.Empty;
    string SCPTime = string.Empty;
    string SCPDate = string.Empty;
    string SCPTechName = string.Empty;
    string Task = string.Empty;
    string PatientName = string.Empty;
    int HC;
    long Returncode = -1;
    int pPageSize = 20;
    int currentPageNo = 1;
    int totalRows = 0;
    int totalpage = 0;
    DateTime BookedFrom = new DateTime();
    DateTime Fromdate = new DateTime();
    DateTime Todate = new DateTime();
    DateTime BookedTo = new DateTime();
    DataTable dt = new DataTable();
    List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
    List<Role> role = new List<Role>();
    List<LoginRole> lstrole = new List<LoginRole>();
    List<Users> lstUsers = new List<Users>();
    string SetDefaultClient = string.Empty;
    string strDisableclient = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        //rdoPatientSave.Checked = true;
      //  HCReportpanel.Visible = false;//added by jagatheesh
        txtCity.Attributes.Add("readonly", "readonly");
        txtstate.Attributes.Add("readonly", "readonly");
      // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:loadUsers();", true);
        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:enableurntxt(); ", true);
        //AutoCompleteProduct.ContextKey = "Y";
        AutocompleteGetLocationforHomeCollection.ContextKey = "Y";
        AutocompleteGetLocationforHomeCollection.BehaviorID = "P";
        AutoCompleteHCGetLoc.ContextKey = "Y";
        AutoCompleteHCGetLoc.BehaviorID = "P";
        hdnOrgID.Value = OrgID.ToString();
        long bookingID = Convert.ToInt64(Request.QueryString["bookingID"]);
        //hdnBookingID.Value = bookingID.ToString();
        billPart.BillingPageType = "HomeCollection";
        ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
        ddlSex.Attributes.Add("onchange", "setSexValueoptLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");

        if (!IsPostBack)
        {
            if (!String.IsNullOrEmpty(Request.QueryString["TechID"]))
            {
                SCPTechID = Request.QueryString["TechID"].ToString();
                hdnSCPTechnicianID.Value = SCPTechID; 
            }
            if (!String.IsNullOrEmpty(Request.QueryString["BkDate"]))
            {
                SCPDate = Request.QueryString["BkDate"].ToString();
                hdnSCPdate.Value = SCPDate;
            }
            if (!String.IsNullOrEmpty(Request.QueryString["Hours"]))
            {
                SCPTime = Request.QueryString["Hours"].ToString();
                hdnSCPhours.Value = SCPTime;
            }
            if (!String.IsNullOrEmpty(Request.QueryString["PinCode"]))
            {
                SCPDate = Request.QueryString["PinCode"].ToString();
                hdnSCPPinCode.Value = SCPDate;
            }
            if (!String.IsNullOrEmpty(Request.QueryString["TechName"]))
            {
                SCPTechName = Request.QueryString["TechName"].ToString();
                hdnSCPTechnician.Value = SCPTechName;
            }
			LoadQuickBillLoading();
            {
                AutoCompleteExtenderRefPhy.ContextKey = "RPH";
                AutoCompleteExtenderClientCorp.ContextKey = "CLI";
                trBilling.Attributes.Add("display", "table-row");
                txtFeedback.Attributes.Add("maxlength", txtFeedback.MaxLength.ToString());
                txtAddress.Attributes.Add("maxlength", txtAddress.MaxLength.ToString());
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:showsave();", true);

                HomeCollections_BL sBL = new HomeCollections_BL(base.ContextInfo);
                List<Bookings> lstBookings = new List<Bookings>();
                sBL.GetServiceQuotationDetails(bookingID, OrgID, out lstBookings);

                if (lstBookings.Count > 0)
                {
                    Bookings oBookings = lstBookings[0];
                    txtPatientName.Text = String.IsNullOrEmpty(oBookings.PatientName) ? string.Empty : oBookings.PatientName;
                    txtDOBNos.Text = String.IsNullOrEmpty(oBookings.Age) ? string.Empty : oBookings.Age.Split('~')[0];
                    ddlSex.SelectedValue = oBookings.SEX;
                    txtMobile.Text = String.IsNullOrEmpty(oBookings.PhoneNumber) ? string.Empty : oBookings.PhoneNumber;
                    
                    //chkNewPatient.Checked = true;
                }

            }
            hdnPatientID.Value = "";
            hdnPatientName.Value = "";
            hdnSelectedPatientID.Value = "";
            rdoPatientSave.Focus();
            //loadOrgLocations();
            hdncurdatetime.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
            txtTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            // txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy") + " " + "12:01 AM";
            // txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            // txtCollFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            // txtCollto.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(1).ToString("dd/MM/yyyy hh:mm tt");
            HC = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);

            //ddlHCRole.Items.Add(new ListItem("--Select--", "0"));
            //ddlUser.Items.Add(new ListItem("--Select--", "0"));
            //ddlHCRole.Items.Insert(0, "------Select------");
            //ddlHCRole.Items[0].Value = "0";
            //ddlUser.Items.Insert(0, "------Select------");
            //ddlUser.Items[0].Value = "0";
            //long orgID = ddlOrg.SelectedIndex > 0 ? Convert.ToInt32(ddlOrg.SelectedValue) : 0;
            //long RoleID = ddlHCRole.SelectedIndex > 0 ? Convert.ToInt32(ddlHCRole.SelectedValue) : 1;
            //LoadUser(OrgID,RoleID);
            long returnCode = -1;
            HomeCollections_BL nurseBL = new HomeCollections_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            if (IsTrustedOrg == "Y")
            {
                returnCode = nurseBL.GetActionsIsTrusterdOrg(RoleID, HC, out lstActionMaster);
            }
            else
            {
                returnCode = nurseBL.GetActions(RoleID, 45, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }
            //lstActionsMaster = lstActionMaster.ToList();
            if (lstActionMaster.Count > 0)
            {
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                //dList.DataValueField = "PageURL";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            /////  tbmain.Attributes.Add("style", "display:none");
            //LoadAutoAutorize();
            LoadMeatData();
            LoadURNtype();


            string rval, roundpattern, ClientMandt, EmailMandt;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            hdnDecimalAgeHC.Value = GetConfigValue("DecimalAge", OrgID);
            EmailMandt = GetConfigValues("ISHCEmail", OrgID);
           // EmailMandt = "N";
            hdnIsNonMandatoryEmail.Value = EmailMandt;
            ClientMandt = GetConfigValues("ISHCClientName", OrgID);
            //ClientMandt = "N";
            hdnIsNonMandatoryClientName.Value = ClientMandt;
            if (ClientMandt == "Y")
            {
                imgClient.Style.Add("display", "block");
            }
            else
            {
                imgClient.Style.Add("display", "none");
            }
            if (EmailMandt == "Y")
            {
                ImgEmail.Style.Add("display", "block");
            }
            else
            {
                ImgEmail.Style.Add("display", "none");
            }
            hdnDefaultRoundoff.Value = rval;
            hdnRoundOffType.Value = roundpattern;
            //ddlUser.Attributes.Add("onchange", "ChangeUsers()");

            //CascadeddlOrg.SelectedValue = OrgID.ToString();

            string HCTechScheduler = GetConfigValues("IsHCTechnician", OrgID);
         
            if (HCTechScheduler == "Y")
            {
                hdnHCTechScheduler.Value = "Y";
                rdoPatientSearch.Enabled = false;
             
                tdrdoPatientSearch.Attributes.Add("style", "display:none");
                userImage.Style.Add("display", "none");
            }
            else
            {
                tdrdoPatientSearch.Style.Add("style", "display:block");
                hdnHCTechScheduler.Value = "N";
            }

            string IsMandatoryEmailandRefDr = GetConfigValues("IsMandatoryEmailandRefDr", OrgID);
            if (IsMandatoryEmailandRefDr == "Y")
            {
                hdnIsMandatoryEmailandRefDr.Value = "Y";
               
                ImgRefDr.Style.Add("display", "block");
            }
            else
            {
               // ImgEmail.Style.Add("display", "none");
                ImgRefDr.Style.Add("display", "none");
                hdnIsMandatoryEmailandRefDr.Value = "N";
            }

            string IsNonMandatoryCollectionTime = GetConfigValues("IsNotMandatoryCollectionTime", OrgID);
            if (IsNonMandatoryCollectionTime == "Y")
            {
                hdnIsNonMandatoryCollectionDt.Value = "Y";
                ImgCollDt.Style.Add("display", "none");
                hdncurdatetime.Value = string.Empty;
                txtTime.Text = string.Empty;
            }
            else
            {
                ImgCollDt.Style.Add("display", "block");
                hdnIsNonMandatoryCollectionDt.Value = "N";
            }

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showuserRole", "javascript:showsave();resetsave();", true);

        }
        DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime wkStDt = DateTime.MinValue;
        DateTime wkEndDt = DateTime.MinValue;
        wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
        wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
        hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
        hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");



        DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
        hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
        dateNow = dateNow.AddMonths(1);
        hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day


        DateTime OrgDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        hdnFirstDayYear.Value = "01-01-" + OrgDateTime.Year;
        hdnLastDayYear.Value = "31-12-" + OrgDateTime.Year;

        #region lastmonth
        DateTime dtlm = OrgDateTime.AddMonths(-1);
        hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
        dtlm = dtlm.AddMonths(1);
        hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
        #endregion

        #region lastweek
        DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime LwkStDt = DateTime.MinValue;
        DateTime LwkEndDt = DateTime.MinValue;
        hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
        hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

        #endregion

        #region lastYear
        DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        string tempyear = dt2.AddYears(-1).ToString();
        string[] tyear = new string[5];
        tyear = tempyear.Split('/', '-');
        tyear = tyear[2].Split(' ');
        hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
        hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
        #endregion
        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
                divRegDate.Attributes.Add("display", "block");
                divRegDateBook.Attributes.Add("display", "block");
            }
        }
        if (!IsPostBack)
        {
            LoadMetaData();
            if (bookingID != 0)
            {
                BillingEngine objBillingengine = new BillingEngine();
                List<Bookings> lstBookings = new List<Bookings>();
                long returncode = -1;
                returncode = objBillingengine.GetBookingOrderDetails(Convert.ToInt64(bookingID), OrgID, 0, out lstBookings);
                hdnPreviousVisitDetails.Value = "";
                if (lstBookings.Count > 0)
                {
                    for (int i = 0; i < lstBookings.Count; i++)
                    {
                        hdnPreviousVisitDetails.Value += lstBookings[i].Name + '$' + lstBookings[i].ID + '$' + lstBookings[i].Type + '$' + " " + '$' + "" + '$' + "" + '$' + "N" + '$' + "0" + '$' + "" + '$' + "" + '^';
                    }
                }
                hdnDefaultOrgBillingItems.Value = "";
                ScriptManager.RegisterStartupScript(Page, GetType(), "CallEdit", "javascript:SetBookedItems();", true);
            }
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:loadRole();", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:loadUsers();", true);

            if (!String.IsNullOrEmpty(Request.QueryString["TechID"]))
            {
                SCPTechID = Request.QueryString["TechID"].ToString();
                SCPTechName = Request.QueryString["TechName"].ToString();
                ddlUser.Items.Insert(0, SCPTechName);
                ddlUser.Items[0].Value = SCPTechID;
                ddlUser.SelectedValue = SCPTechID;
            }
            else {

           LoadUser(OrgID, RoleID);
            }
        }


    }
    private void LoadUser(long OrgID, long RoleID)
    {
        try
        {
            long returncode = -1;
            Role_BL RoleBL = new Role_BL(new BaseClass().ContextInfo);
            roleBL = new Role_BL(base.ContextInfo);

            long loginid = LID;

           // GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = loginid;
            loginRole.RoleID = RoleID;
            List<LoginRole> lstrole = new List<LoginRole>();

           // gateway.GetLoggedInRoles(loginRole, out lstrole);
            List<Role> Temprole = new List<Role>();

            long returnCode = -1;
            int pOrgID = Convert.ToInt32(OrgID);
            returnCode = roleBL.GetRoleName(pOrgID, out role);
            RoleID = Int64.Parse(role.Where(o => o.RoleName == "Phlebotomist").Select(o => o.RoleID).FirstOrDefault().ToString());
            
          //  RoleID = Int64.Parse(lstrole.Where(o => o.RoleName == "Phlebotomist").Select(o => o.RoleID).FirstOrDefault().ToString());

            

            //int RoleIDno=RoleIDL.
            List<Users> lstResult = new List<Users>();

            RoleBL.GetUserName(OrgID, RoleID, out lstResult);
            if (lstResult.Count > 0)
            {
                ddlUser.Enabled = true;
                ddlUser.DataSource = lstResult;
                ddlUser.DataTextField = "Name";
                ddlUser.DataValueField = "UserID";
                ddlUser.DataBind();
                ddlUser.Items.Insert(0, "------Select------");
                ddlUser.Items[0].Value = "0";
                ddlOrg1.Items.Insert(0, "------Select------");
                ddlOrg1.Items[0].Value = "0";
                drpTech.DataSource = lstResult;
                drpTech.DataTextField = "Name";
                drpTech.DataValueField = "UserID";
                
                drpTech.DataBind();
                drpTech.Items.Insert(0, "------Select ALL------");
                drpTech.Items[0].Value = "0";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  LoadUser ", ex);

        }
    }
    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "HcCancelStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL().LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "HcCancelStatus" //orderby child .MetaDataID
                                 select child;
                drpCancelStatus.DataSource = childItems;
                drpCancelStatus.DataTextField = "DisplayText";
                drpCancelStatus.DataValueField = "Code";
                drpCancelStatus.DataBind();
                
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }


    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        HomeCollections_BL objGateway = new HomeCollections_BL(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        btnSave.Visible = true;
        btnUpdate.Visible = false;
        string DispatchMode = string.Empty;
        string Patient = string.Empty;
        long PatientID = 0;
        string CollectionAddr = string.Empty;
        long RoleID = 0;
        long UserID = 0;
        int CollecOrgID = 0;
        long CollecOrgAddrID = 0;
        int LoginOrgID = 0;
        int OtherOrg = 0;
        string Add2 = string.Empty;
        string City = string.Empty;
        string MobileNumber = string.Empty;
        string pAge = string.Empty;
        string Sex = string.Empty;
        string pName = string.Empty;
        //int Priority = 0;
        string Priority = string.Empty;
        string BillDescription = string.Empty;
        string State = string.Empty;
        string Pincode = string.Empty;
        string RefPhysicianName = string.Empty;

        //if (Convert.ToInt32(ddlPriority.SelectedValue) > 0)
        //{
        //    Priority = Convert.ToInt32(ddlPriority.SelectedValue);
        //}

       // Priority = ddlPriority.SelectedValue;


        BillDescription = txtFeedback.Text;


        long bookingID = -1;
        Add2 = txtSuburb.Text;
        City = txtCity.Text;
        MobileNumber = txtMobile.Text;
        pAge = txtDOBNos.Text + " " + ddlDOBDWMY.SelectedValue.ToString();

        Sex = ddlSex.SelectedValue.ToString();
        pName = txtPatientName.Text;

        Patient = txtPatientName.Text;
        string[] Patientdetails = Patient.Split('~');
        if (txtPatientName.Text != "")
        {
            //if (!chkNewPatient.Checked)
            //{
            //    PatientID = Convert.ToInt64(hdnSelectedPatientID.Value);
            //}
            //else
            //{
                PatientID = -1;
            //}
            // PatientID = Convert.ToInt64(Patientdetails[1]);
        }
        CollectionAddr = txtAddress.Text;
        DateTime CollectionTime = DateTime.MaxValue;
        if(!string.IsNullOrEmpty(txtTime.Text)){
            CollectionTime =  Convert.ToDateTime(txtTime.Text);
        }

        DateTime BookedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime BookedTo = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        if (ddlOrg1.SelectedValue != "0" && ddlOrg1.SelectedValue != null && ddlOrg1.SelectedValue != "")
        {
            string[] OrgDetail = ddlOrg1.SelectedValue.Split('~');
            OtherOrg = Convert.ToInt32(OrgDetail[0]);
            CollecOrgID = Convert.ToInt16(OrgDetail[0]);
        }

        if (ddlLocation.SelectedValue != "0" && ddlLocation.SelectedValue != null && ddlLocation.SelectedValue != "")
        {
            CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue.ToString());
        }

        //if (ddlHCRole.SelectedValue != "0" && ddlHCRole.SelectedValue != null && ddlHCRole.SelectedValue != "")
        //{
        //    string[] Roles = ddlHCRole.SelectedValue.Split('~');
        //    RoleID = Convert.ToInt64(Roles[0]);
        //}
        if (ddlUser.SelectedValue != "0" && ddlUser.SelectedValue != null && ddlUser.SelectedValue != "")
        {
            string[] Users = ddlUser.SelectedValue.Split('~');
            UserID = Convert.ToInt64(Users[0]);
        }
        if (hdnuserselectedval.Value != "") {
            UserID = Convert.ToInt64(hdnuserselectedval.Value);
        }
        LoginOrgID = OrgID;
        string Status = string.Empty;
        Status = "B";
        Task = "Save";
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;

        try
        {
            long returnCode = -1;
            if (hdnBookingID.Value == "" || hdnBookingID.Value == null)
            {
                hdnBookingID.Value = "0";
            }

            List<Bookings> lstBookings = new List<Bookings>();
            Bookings oBookings = new Bookings();
            oBookings.BookingID = Convert.ToInt32(hdnBookingID.Value) > 0 ? Convert.ToInt32(hdnBookingID.Value) : 0;
            oBookings.TokenNumber = 0;
            oBookings.CreatedBy = LID;
            oBookings.OrgID = OrgID;
            oBookings.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            oBookings.PatientName = txtPatientName.Text.Trim().ToString().ToUpper();
            oBookings.SEX = ddlSex.SelectedValue;
            oBookings.Age = pAge;

            DateTime DOB = new DateTime();
            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            if (Date == "01/01/1800")
            {
                if (hdnDOB.Value != "")
                {
                    Date = hdnDOB.Value.ToString();
                }
                else if (hdnNewDOB.Value != "")
                {
                    Date = hdnNewDOB.Value.ToString();
                }
            }
            oBookings.DOB = Convert.ToDateTime(Date);

            oBookings.PhoneNumber = txtMobile.Text.Trim();
            oBookings.LandLineNumber = txtTelephoneNo.Text;
            oBookings.FeeType = txtClient.Text;
            oBookings.SourceType = "Home Collection";
       //     oBookings.ClientID = 0;

            billPart.IsClientSelected = txtClient.Text.Trim() == "" ? "N" : "Y";
        //    billPart.MappingClientID = Convert.ToInt64(hdnMappingClientID.Value);
        //    billPart.RateID = Convert.ToInt32(hdnRateID.Value);
            billPart.ClientID = Convert.ToInt64(hdnSelectedClientClientID.Value);
            //billPart.DespatchMode = CreateDespatchMode(); //Convert.ToInt32(ddlDespatchMode.SelectedItem.Value);
            Int64 clientID = 0;
            Int64.TryParse(hdnSelectedClientClientID.Value, out clientID);
            if (clientID == 0)
            {
                Int64.TryParse(hdnBaseClientID.Value, out clientID);
            }
        //    billPart.ClientID = clientID;

            oBookings.ClientID = Convert.ToInt32(clientID);




            oBookings.NRICNumber = hdnClientRateID.Value; //General RateID for HomeCollection

            oBookings.PatientID = PatientID;
            oBookings.OrgAddressID = CollecOrgAddrID;
            oBookings.OtherOrgID = OtherOrg;
            oBookings.CollectionAddress = CollectionAddr;
            oBookings.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
            oBookings.UserID = UserID;
            oBookings.CollectionTime = CollectionTime;
            oBookings.BookingOrgID = CollecOrgID;
            oBookings.BookingStatus = Status;
            oBookings.CollectionAddress2 = Add2;
            oBookings.City = City;
            oBookings.PatientNumber = "0";
            oBookings.Priority = Priority;
            oBookings.BillDescription = BillDescription;
            oBookings.State = txtstate.Text;
            oBookings.Pincode = txtpincode.Text;
            if (txtpincode.Text == "") {
                oBookings.Pincode = hdnSCPPinCode.Value;
            }
            oBookings.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            DispatchMode = hdnDispatch.Value;
            oBookings.DispatchValue = DispatchMode;
            oBookings.URNTypeID = Convert.ToInt64(ddlUrnType.SelectedValue);
            oBookings.URNO = txtURNo.Text.Trim();
            oBookings.EMail = txtEmail.Text.Trim();
            oBookings.RefPhysicianName = txtInternalExternalPhysician.Text.ToString();//Added By Jagatheesh

            if (!string.IsNullOrEmpty(hdnStateID.Value))
            {
                oBookings.StateID = Convert.ToInt32(hdnStateID.Value);
            }
            oBookings.CityID = Convert.ToInt32(hdnCityID.Value);
            
            if (!string.IsNullOrEmpty(hdnCountryID.Value))
            {
                oBookings.CountryID = Convert.ToInt32(hdnCountryID.Value);
            }

            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            string gUID = string.Empty;
            lstInv = billPart.GetOrderedInvestigations(-1, out gUID);

            List<OrderedInvestigations> lstPreOrderInv = new List<OrderedInvestigations>();
            lstPreOrderInv = billPart.GetPreOrdered(-1);

            HomeCollections_BL sBL = new HomeCollections_BL(base.ContextInfo);
            returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, lstPreOrderInv, OrgID, UserID, out  bookingID);
            //returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, 67, 2628, out bookingID);

            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = bookingID;
            PC.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
            PC.OrgID = OrgID;
            PC.PatientVisitID = bookingID;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
			
            if(PC.ActionType == null)
            {
            PC.ActionType = "P";
            }
			
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC,"","");
           // res = AM.PerformingNextStep(PC);
            //
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsave", "showsave();", true);
            if (returnCode > -1 && bookingID != 5)
            {
                string AlertMesg = "Patient Details Saved Successfully,Booking No is " + bookingID.ToString();
                string PageUrl = Request.ApplicationPath + @"/Homecollection/homecollection.aspx?IsPopup=Y";
                //Added By Prabakaran
                //   ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location.href ='" + PageUrl + "';", true);
                Response.Write("<script>alert('" + AlertMesg + "')</script>");
                Response.Write("<script>window.location.href='" + PageUrl + "';</script>");
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "locAlert", "alert('Please enter valid Pincode and Location')", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetResult(e, currentPageNo, pPageSize);
        //loaddata(lstHomeCollectionDetails);
    }
    protected void grdResult_RowEdit(object sender, EventArgs e)
    {
        tdlblDOB.Style.Add("display", "none");
        trBilling.Style.Add("display", "none");
        tdtxtDOB.Style.Add("display", "none");
        ddlUser.Items.Insert(0, "------Select------");
        ddlUser.Items[0].Value = "0";

    }

    protected void grdResult_OnClick(object sender, EventArgs e)
    {
        //ddlHCRole.Items.Insert(0, "------Select------");
        //ddlHCRole.Items[0].Value = "0";
        // LoadUser();
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        btnSave.Visible = false;
        btnUpdate.Visible = true;
        long returnCode = -1;
        List<Bookings> lstBookings = new List<Bookings>();
        Bookings oBookings = new Bookings();
        string DispatchMode = string.Empty;
        string Patient = string.Empty;

        long PatientID = 0;
        string CollectionAddr = string.Empty;
        long RoleID = 0;
        long UserID = 0;
        int CollecOrgID = 0;
        long CollecOrgAddrID = 0;
        int LoginOrgID = 0;
        int OtherOrg = 0;
        string Add2 = string.Empty;
        string City = string.Empty;
        string MobileNumber = string.Empty;
        string pAge = string.Empty;
        string Sex = string.Empty;
        string pName = string.Empty;
        //int Priority = 0;
        string Priority = string.Empty;
        string BillDescription = string.Empty;
        string State = string.Empty;
        string Pincode = string.Empty;
        string RefPhysicianName = string.Empty;
        long bookingID = -1;
       // Priority = ddlPriority.SelectedValue;
        Patient = txtPatientName.Text;
        Sex = ddlSex.SelectedValue;
        pAge = txtDOBNos.Text + ddlDOBDWMY.SelectedValue;
        DateTime CollectionTime = Convert.ToDateTime(txtTime.Text);
        Add2 = txtAddress.Text;
        Pincode = txtpincode.Text;
        string Update = "Update";
        BillDescription = txtFeedback.Text;
        State = ddlStatus.SelectedValue;
        oBookings.Priority = Priority;
        oBookings.PatientName = Patient;
        oBookings.SEX = Sex;
        oBookings.Age = pAge;
        oBookings.CollectionTime = CollectionTime;
        oBookings.Pincode = Pincode;
        oBookings.BillDescription = BillDescription;
        oBookings.State = State;
        oBookings.Comments = Update;


        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        string gUID = string.Empty;
        lstInv = billPart.GetOrderedInvestigations(-1, out gUID);

        HomeCollections_BL sBL = new HomeCollections_BL(base.ContextInfo);
        //  returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, OrgID, UserID, out  bookingID);
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Bookings HCD = (Bookings)e.Row.DataItem;

            string strScript = "SelectRow('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + HCD.BookingID + "','" + HCD.PatientID + "','" + HCD.BookingStatus + "','" + HCD.PatientName + "','" + HCD.BookingID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

            string strEditScript = "SelectedPatient('" + HCD.BookingID + "','" + HCD.BookingStatus + "','" + HCD.PatientName + "','" + HCD.Age + "','" + HCD.DOB.ToString("dd/MM/yyyy") + "','" + HCD.SEX + "','" + HCD.PhoneNumber + "','" + HCD.CollectionAddress + "','" + HCD.CollectionAddress2 + "','" + HCD.City + "','" + HCD.CollectionTime.ToString("dd/MM/yyyy hh:mm tt") + "','" + HCD.LandLineNumber + "','" + HCD.RoleID + "','" + HCD.UserID + "','" + HCD.BookingOrgID + "','" + HCD.OrgAddressID + "','" + HCD.Priority + "','" + HCD.CityID + "','" + HCD.StateID + "','" + HCD.State + "','" + HCD.Pincode + "','" + HCD.BillDescription + "','" + HCD.Comments + "');";
            ((LinkButton)e.Row.Cells[0].FindControl("linkEdit")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((LinkButton)e.Row.Cells[0].FindControl("linkEdit")).Attributes.Add("onclick", strEditScript);

        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        //if (e.CommandName == "Edit")
        //{
        //    string Roler = e.CommandArgument.ToString();
        //    string[] RoleUser = new string[2];
        //    long RoleID = 0;
        //    long OrgID = 0;
        //    RoleUser = Roler.Split(',');
        //    hdnRoleId.Value = RoleUser[0];
        //    hdnUserID.Value = RoleUser[1];
        //    RoleID = Convert.ToInt32(hdnRoleId.Value);
        //    OrgID = Convert.ToInt32(hdnOrgID.Value);
        //    LoadUser(OrgID, RoleID);
        //    if (hdnUserID.Value != "0")
        //    {
        //        if (ddlUser.Items.FindByValue(hdnUserID.Value) != null)
        //        {
        //            ddlUser.SelectedValue = hdnUserID.Value;
        //        }
        //        //ScriptManager.RegisterStartupScript(this, this.GetType(), "getAttrib", "loadUsers()", true);
        //    }
        //}
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        //Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?pid=" + hdnPatientID.Value.ToString() + "&HCDID=" + hdnHomeCollDtdID.Value.ToString(), true);
        if (hdnstatus.Value == "Registered")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "StatusAlert", "StatusAlert();", true);
        }
        else
        {
            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();

            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = dList.SelectedValue;
            string ActionList = ViewState["ActionList"].ToString();
            foreach (string CompareList in ActionList.Split('^'))
            {
                if (CompareList.Split('~')[0] == ActCode)
                {
                    QueryString = CompareList.Split('~')[1];
                    break;
                }
            }
            #endregion
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = hdnPatientID.Value;
            //objQueryMaster.PatientVisitID = hdnHomeCollDtdID.Value;
            objQueryMaster.PatientName = hdnPatientName.Value;
            objQueryMaster.AccessionNumber = hdnBookingNumber.Value;

            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (dList.SelectedValue == "Reprint_QuotationBill")
            {
                getdata(Convert.ToInt64(hdnBookingNumber.Value));
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:popupprint();", true);
            }
            else
            {
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    RedirectURL = RedirectURL + "&HC=Y";
                    Response.Redirect(RedirectURL, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                }
            }
            #endregion
        }
    }

    public DataTable loaddata(List<Bookings> lstHomeCollectionDetails)
    {
        DataTable dt = new DataTable();
        DataColumn dcol8 = new DataColumn("Booking Number");
        //DataColumn dcol9 = new DataColumn("Patient Number");
        DataColumn dcol10 = new DataColumn("Patient Name");
        DataColumn dcol11 = new DataColumn("Age/Gender");
        DataColumn dcol12 = new DataColumn("Collection Time");
        DataColumn dcol13 = new DataColumn("Collection Address");
        DataColumn dcol14 = new DataColumn("Role Name");
        DataColumn dcol15 = new DataColumn("UserName");
        DataColumn dcol17 = new DataColumn("Status");
        DataColumn dcol118 = new DataColumn("DisplayText");

        DataColumn dcol119 = new DataColumn("State");
        DataColumn dcol120 = new DataColumn("Pincode");
        DataColumn dcol121 = new DataColumn("StateID");
        DataColumn dcol122 = new DataColumn("CityID");
        DataColumn dcol123 = new DataColumn("BillDescription");
        DataColumn dcol124 = new DataColumn("DOB");
        DataColumn dcol125 = new DataColumn("Priority");
        DataColumn dcol126 = new DataColumn("Comments");

        dt.Columns.Add(dcol8);
        //dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol17);
        dt.Columns.Add(dcol118);
        dt.Columns.Add(dcol119);
        dt.Columns.Add(dcol120);
        dt.Columns.Add(dcol121);
        dt.Columns.Add(dcol122);
        dt.Columns.Add(dcol123);
        dt.Columns.Add(dcol124);
        dt.Columns.Add(dcol125);
        dt.Columns.Add(dcol126);
        foreach (Bookings item in lstHomeCollectionDetails)
        {
            DataRow dr = dt.NewRow();
            dr["Booking Number"] = item.BookingID;
            //dr["Patient Number"] = item.PatientNumber;
            dr["Patient Name"] = item.PatientName;
            dr["Age/Gender"] = item.Age;
            dr["Collection Time"] = item.CollectionTime.ToString("dd/MMM/yy hh:mm tt");
            dr["Collection Address"] = item.CollectionAddress;
            dr["Role Name"] = item.RoleName;
            dr["UserName"] = item.UserName;
            dr["Status"] = item.BookingStatus;
            dr["DisplayText"] = item.Comments;
            dr["State"] = item.State;
            dr["Pincode"] = item.Pincode;
            dr["StateID"] = item.StateID;
            dr["CityID"] = item.CityID;
            dr["BillDescription"] = item.BillDescription;
            dr["DOB"] = item.DOB.ToString("dd/MM/yyyy");
            //dr["Priority"] = item.Priority.ToString();
            //dr["Comments"] = item.Priority.ToString();
            dt.Rows.Add(dr);
        }
        ViewState["report"] = dt;
        return dt;
    }

    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            DataTable dt = (DataTable)ViewState["report"];
            string prefix = string.Empty;
            prefix = "HomeCollection_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            var ds = new DataSet();
            ds.Tables.Add(dt);
            ExcelHelper.ToExcel(ds, rptDate, Page.Response);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }

    ///mohan

    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,CustomPeriodRange";
            string[] Tempdata = domains.Split(',');
            //string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }


            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "Code";
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
                                  where child.Domain == "CustomPeriodRange"
                                  select child;
                if (childItems2.Count() > 0)
                {
                    drpBooked.DataSource = childItems2;
                    drpBooked.DataTextField = "DisplayText";
                    drpBooked.DataValueField = "Code";
                    drpBooked.DataBind();
                    drpBooked.Items.Insert(0, "--Select ALL--");
                    drpBooked.Items[0].Value = "-1";
                    drpBooked.Items.Remove(drpBooked.Items.FindByValue("2"));
                    drpBooked.Items.Remove(drpBooked.Items.FindByValue("7"));
                    drpCollection.DataSource = childItems2;
                    drpCollection.DataTextField = "DisplayText";
                    drpCollection.DataValueField = "Code";
                    drpCollection.DataBind();
                    drpCollection.Items.Insert(0, "--Select ALL--");
                    drpCollection.Items[0].Value = "-1";
                    drpCollection.Items.Remove(drpCollection.Items.FindByValue("2"));
                    drpCollection.Items.Remove(drpCollection.Items.FindByValue("7"));

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }
    private void GetResult(EventArgs e, int currentPageNo, int pPageSize)
    {
        string Patient = string.Empty;
        long PatientID = 0;
        long RoleID = 0;
        long UserID = 0;
        int CollecOrgID = 0;
        long CollecOrgAddrID = 0;
        int LoginOrgID = 0;
        string Status = string.Empty;
        string MobileNumber = string.Empty;
        string TelePhone = string.Empty;
        string pName = string.Empty;
        long BookingNumber = -1;


        //pName = txtPatientName.Text;
        //if (txtBookingNumber.Text == string.Empty)
        //{
        //    BookingNumber = 0;
        //}
        //else
        //{
        //    BookingNumber = Convert.ToInt64(txtBookingNumber.Text);

        //}
        //MobileNumber = txtMobile.Text;
        //TelePhone = txtTelephoneNo.Text.Trim();

        ////if (ddlOrg.SelectedValue != "0" && ddlOrg.SelectedValue != null && ddlOrg.SelectedValue != "")
        ////{
        ////    // string[] OrgDetail = ddlOrg.SelectedValue.Split('~');
        ////    CollecOrgID = Convert.ToInt32(ddlOrg.SelectedValue);

        ////}
        ////if (ddlLocation.SelectedValue != "0" && ddlLocation.SelectedValue != null && ddlLocation.SelectedValue != "")
        ////{
        ////    CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue.ToString());
        ////}

        ////LoginOrgID = OrgID;

        ////if (ddlHCRole.SelectedValue != "0" && ddlHCRole.SelectedValue != null && ddlHCRole.SelectedValue != "")
        ////{
        ////    string[] Roles = (ddlHCRole.SelectedValue.Split('~'));
        ////    RoleID = Convert.ToInt64(Roles[0]);
        ////}

        //if (ddlUser.SelectedValue != "0" && ddlUser.SelectedValue != null && ddlUser.SelectedValue != "")
        //{
        //    string[] Users = (ddlUser.SelectedValue.Split('~'));
        //    UserID = Convert.ToInt64(Users[0]);
        //}

        //if (txtFrom.Text != "")
        //{
        //    BookedFrom = Convert.ToDateTime(txtFrom.Text);
        //}
        //else
        //{
        //    BookedFrom = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtTo.Text != "")
        //{
        //    BookedTo = Convert.ToDateTime(txtTo.Text);
        //}
        //else
        //{
        //    BookedTo = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtCollFrom.Text != "")
        //{
        //    Fromdate = Convert.ToDateTime(txtCollFrom.Text);
        //}
        //else
        //{
        //    Fromdate = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtCollto.Text != "")
        //{
        //    Todate = Convert.ToDateTime(txtCollto.Text);
        //}
        //else
        //{
        //    Todate = Convert.ToDateTime("1/1/1753");
        //}

        //Status = ddlStatus.SelectedValue;

        //if (txtPatientName.Text != "")
        //{
        //    //if (!chkNewPatient.Checked)
        //    //{
        //    //    Int64.TryParse(hdnSelectedPatientID.Value, out PatientID);
        //    //    //PatientID = Convert.ToInt64(hdnSelectedPatientID.Value);
        //    //}
        //    //else
        //    //{
        //        PatientID = -1;
        //   // }
        //    // PatientID = Convert.ToInt64(Patientdetails[1]);
        //}

        ////ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsave", "javascript:ShowUserForRole();", true);
        //if (ddlUser.Items.FindByValue(hdnUserID.Value) != null)
        //{
        //    ddlUser.SelectedValue = hdnUserID.Value;
        //}

        //Task = "Search";
        ////ddlUser.SelectedValue = hdnUserID.Value;
        //List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        //new HomeCollections_BL(base.ContextInfo).GetHomeCollectionDetails(PatientID, Fromdate, Todate, RoleID, UserID, CollecOrgID,
        //    CollecOrgAddrID, LoginOrgID, BookedFrom, BookedTo, Status, Task, out lstHomeCollectionDetails, MobileNumber, TelePhone,
        //    pName, pPageSize, currentPageNo, BookingNumber, out totalRows);

        //if (lstHomeCollectionDetails.Count > 0)
        //{
        //    loaddata(lstHomeCollectionDetails);
        //    GrdFooter.Style.Add("display", "block");
        //    // aRow.Style.Add("display", "none");
        //    grdResult.Visible = true;
        //    divPrintarea.Visible = true;
        //    grdResult.DataSource = lstHomeCollectionDetails;
        //    grdResult.DataBind();

        //    divPrint.Style.Add("display", "block");
        //    //  aRow.Style.Add("display", "none");
        //    totalpage = totalRows;
        //    lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        //    if (hdnCurrent.Value == "")
        //    {
        //        lblCurrent.Text = currentPageNo.ToString();
        //    }
        //    else
        //    {
        //        lblCurrent.Text = hdnCurrent.Value;
        //        currentPageNo = Convert.ToInt32(hdnCurrent.Value);
        //    }
        //    if (currentPageNo == 1)
        //    {
        //        btnPrevious.Enabled = false;
        //        if (Int32.Parse(lblTotal.Text) > 1)
        //        {
        //            btnNext.Enabled = true;
        //        }
        //        else
        //            btnNext.Enabled = false;
        //    }
        //    else
        //    {
        //        btnPrevious.Enabled = true;
        //        if (currentPageNo == Int32.Parse(lblTotal.Text))
        //            btnNext.Enabled = false;
        //        else btnNext.Enabled = true;
        //    }
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsearch", "javascript:showsearch();", true);
        //}
        //else
        //{
        //    GrdFooter.Style.Add("display", "none");
        //    aRow.Style.Add("display", "none");
        //    grdResult.Visible = false;
        //    divPrintarea.Visible = false;
        //    GrdFooter.Style.Add("display", "none");
        //    divPrint.Style.Add("display", "none");
        //    aRow.Style.Add("display", "none");
        //    divPrint.Visible = false;
        //    //aRow.Visible = false;
        //    divPrint.Visible = true;
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Matching Records Found');", true);
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsearch1", "javascript:showsearch();clearupdate();", true);
        //}
        //hdnUserID.Value = "0";

    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, pPageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, pPageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, pPageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, pPageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        GetResult(e, Convert.ToInt32(txtpageNo.Text), pPageSize);
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / pPageSize);
        return totalPages;
    }

    public void getdata(long bookingID)
    {
        try
        {
            HomeCollections_BL objBl = new HomeCollections_BL(base.ContextInfo);
            List<Bookings> lstBookingDetails = new List<Bookings>();
            List<Bookings> lstBookingDetailsQuot = new List<Bookings>();
            Returncode = objBl.GetBookingsDt(bookingID, out lstBookingDetails, out lstBookingDetailsQuot);
            //if (lstBookingDetails.Count > 0)
            //{
            //lblPatAge.Text = lstBookingDetails[0].Age.ToString();
            //lblEmail.Text = lstBookingDetails[0].EMail.ToString();
            //lblMobNo.Text = lstBookingDetails[0].PhoneNumber.ToString();
            //lblPatientName.Text = lstBookingDetails[0].PatientName.ToString();
            //lblPatSex.Text = lstBookingDetails[0].SEX.ToString();
            //lblTpno.Text = lstBookingDetails[0].LandLineNumber.ToString();
            //lblNetAmt.Text = lstBookingDetails[0].Rate.ToString();
            //lblGrossValue.Text = lstBookingDetails[0].Rate.ToString();
            //lblDiscount.Text = "0.00";
            //lblTax.Text = "0.00";
            //lblEDCess.Text = "0.00";
            //lblSHEDCess.Text = "0.00";
            //lblSerChrg.Text = "0.00";
            //lblRounOff.Text = "0.00";
            //lblQuoteGivenby.Text = lstBookingDetails[0].PatientNumber.ToString();
            //lblQuoteDate.Text = lstBookingDetails[0].CreatedAt.ToShortDateString();
            //}

            //grdBillDes.DataSource = lstBookingDetailsQuot;
            //grdBillDes.DataBind();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
    }

    public void clearAll()
    {
        txtSuburb.Text = "";
        txtCity.Text = "";
        txtpincode.Text = "";
        txtstate.Text = "";


        txtMobile.Text = "";
        txtTelephoneNo.Text = "";
        txtDOBNos.Text = "";
        ddlSex.SelectedValue = "M";
        txtPatientName.Text = "";
        txtBookingNumber.Text = "";
        ddlStatus.SelectedValue = "0";
       // ddlPriority.SelectedValue = "0";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Clear", "ddlRoleDefault();", true);
        //ddlHCRole.SelectedValue = "0";
        //ddlUser.SelectedValue = "0";
        txtFeedback.Text = "";
        //hdnRoleId.Value = "0";
        hdnUserID.Value = "0";
        //hdnlocid.Value = "0";
        txtAddress.Text = "";
        txtTime.Text = "";
        SetDefaultClient = GetConfigValue("SetDefaultClientForLoc", OrgID);
        if (SetDefaultClient == "Y")
        {
            LoadDefaultClientNameBasedOnOrgLocation();
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
            ddSalutation.Items.Insert(0, "-Select-");
            ddSalutation.Items[0].Value = "0";
            ddSalutation.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
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
        LoadDespatchMode();

    }


    void LoadDespatchMode()
    {
        try
        {
            long returnCode = -1;
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);
            if (lstactiontype.Count > 0)
            {
                var DispatchMode = lstactiontype.FindAll(p => (p.Type == "DisM" || p.ActionCode == "REmail" || p.ActionCode == "RSms"));
                chkDespatchMode.DataSource = DispatchMode;
                chkDespatchMode.DataTextField = "ActionType";
                chkDespatchMode.DataValueField = "ActionTypeID";
                chkDespatchMode.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While LoadDespatchMode() in Lab Quick Billing", ex);
        }
    }
    protected void btnSend_Click(object sender, EventArgs e)
    {
        string Email = string.Empty;
        string SMS = string.Empty;
        string Name = string.Empty;
        SMS = "9791087485";
        Email = "premanand.m@attunelive.com";
        ActionManager AM = new ActionManager(base.ContextInfo);
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        PageContextkey PC = new PageContextkey();
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.OrgID = OrgID;
        PC.PageID = Convert.ToInt64(PageID);
        PC.ButtonName = "SendSmsandEmail";
        PC.ButtonValue = "HomeCollection";
        PC.Description = Email;
        lstpagecontextkeys.Add(PC);
        long res = -1;
        res = AM.PerformingNextStepNotification(PC, SMS, Name + "~" + Email);
    }
    public List<PatientDisPatchDetails> CreateDespatchMode1()
    {

        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        PatientDisPatchDetails PDPD;
        foreach (System.Web.UI.WebControls.ListItem li in chkDespatchMode.Items)
        {
            if (li.Selected == true)
            {
                PDPD = new PatientDisPatchDetails();
                PDPD.DispatchType = "M";
                PDPD.DispatchValue = li.Value;
                lstDispatchDetails.Add(PDPD);
            }
        }
        return lstDispatchDetails;
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
                ddlUrnType.DataTextField = "DisplayText";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();

                ddlUrnType.Items.Insert(0, "--Select--");
                ddlUrnType.Items[0].Value = "0";

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
        ddlUrnType.SelectedValue = objURNTypes.URNTypeId.ToString();
    }

    public URNTypes GetURN()
    {
        URNTypes objURNTypes = new URNTypes();
        objURNTypes.URN = txtURNo.Text;
        objURNTypes.URNTypeId = Int64.Parse(ddlUrnType.SelectedValue);
        return objURNTypes;
    }



    class MyReportServerCredent : IReportServerCredentials
    {
        //string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
        //string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];
        string CredentialuserName = "Administrator";
        string CredentialpassWord = "kmarun";


        public MyReportServerCredent()
        {
        }

        public System.Security.Principal.WindowsIdentity ImpersonationUser
        {
            get
            {
                return null;  // Use default identity.
            }
        }

        public System.Net.ICredentials NetworkCredentials
        {
            get
            {
                return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
            }
        }

        public bool GetFormsCredentials(out System.Net.Cookie authCookie,
                out string user, out string password, out string authority)
        {
            authCookie = null;
            user = password = authority = null;
            return false;  // Not use forms credentials to authenticate.
        }
    }
    private void LoadPassingData()
    {
        DateTime FromdateLoc;
        DateTime TodateLoc;
        DateTime ClollectFromLoc;
        DateTime ClollectToLoc;
        int PageSizeLoc = 0;
        int CurrentPageNoLoc = 0;
        int CollecOrgIDLoc = OrgID;
        int LoginOrgIDLoc = 0;
        Task = "Search";
        string Status = string.Empty;
        long BookingNumberLoc = 0;
        int PPageSize = 0;
        Int64.TryParse(txtBookingNumber.Text, out BookingNumberLoc);
        string MobileNumber = txtMobile.Text;
        string TelePhone = txtTelephoneNo.Text;
        string pName = txtPatientName.Text;

        //if (txtFrom.Text != "")
        //{
        //    DateTime.TryParse(txtFrom.Text, out FromdateLoc);
        //}
        //else
        //{
        //    FromdateLoc = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtTo.Text != "")
        //{
        //    DateTime.TryParse(txtTo.Text, out TodateLoc);
        //}
        //else
        //{
        //    TodateLoc = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtCollFrom.Text != "")
        //{

        //    DateTime.TryParse(txtCollFrom.Text, out ClollectFromLoc);
        //}
        //else
        //{
        //    ClollectFromLoc = Convert.ToDateTime("1/1/1753");
        //}
        //if (txtCollto.Text != "")
        //{

        //    DateTime.TryParse(txtCollto.Text, out ClollectToLoc);
        //}
        //else
        //{
        //    ClollectToLoc = Convert.ToDateTime("1/1/1753");
        //}

        //if (ddlStatus.SelectedItem.Text != "--Select--")
        //{
        //    Status = ddlStatus.SelectedItem.Value;
        //}
        //else
        //{
        //    Status = "0";
        //}
        ////List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
        ////string Patient = string.Empty;
        //string reportPath;
        //reportPath = "/HCDetails/HCDetails";
        //ShowReport(FromdateLoc, TodateLoc, ClollectFromLoc, ClollectToLoc, CollecOrgIDLoc,
        //              LoginOrgIDLoc, Status, Task, MobileNumber, TelePhone,
        //              pName, PPageSize, currentPageNo, BookingNumberLoc, reportPath);
    }
    //public void ShowReport(DateTime Fromdate, DateTime Todate, DateTime CollectFromdate, DateTime CollectTodate,
    //     int CollecOrgID, int LoginOrgID, string Status, string Task,
    //    string MobileNumber, string TelePhone,
    //    string pName, int PageSize, int currentPageNo, long BookingNumber, string sReportPath)
    //{
    //    long returnCode = -1;
    //    try
    //    {

    //        ReportViewer.Visible = true;
    //        ReportViewer.Attributes.Add("style", "width:100%; height:10000px");
    //        string strURL = string.Empty;
    //        string connectionString = string.Empty;
    //        connectionString = Utilities.GetConnectionString();
    //        ReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
    //        strURL = GetConfigValues("ReportServerURL", OrgID);
    //        ReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
    //        ReportViewer.ShowParameterPrompts = false;
    //        ReportViewer.ShowPrintButton = true;
    //        ReportViewer.ServerReport.ReportPath = sReportPath;
    //        string GroupOrgIDs = OrgID.ToString();
    //        Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[16];
    //        reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("CollectionTime", Convert.ToString(CollectFromdate));
    //        reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("toTime", Convert.ToString(CollectTodate));
    //        reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("CollecOrgID", Convert.ToString(CollecOrgID));
    //        reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("LoginOrgID", Convert.ToString(LoginOrgID));
    //        reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("BookedFrom", Convert.ToString(Fromdate));
    //        reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("BookedTo", Convert.ToString(Todate));
    //        reportParameterList[6] = new Microsoft.Reporting.WebForms.ReportParameter("Status", Convert.ToString(Status));
    //        reportParameterList[7] = new Microsoft.Reporting.WebForms.ReportParameter("Task", Convert.ToString(Task));
    //        reportParameterList[8] = new Microsoft.Reporting.WebForms.ReportParameter("MobileNumber", Convert.ToString(MobileNumber));
    //        reportParameterList[9] = new Microsoft.Reporting.WebForms.ReportParameter("TelePhone", Convert.ToString(TelePhone));
    //        reportParameterList[10] = new Microsoft.Reporting.WebForms.ReportParameter("pName", Convert.ToString(pName));
    //        reportParameterList[11] = new Microsoft.Reporting.WebForms.ReportParameter("pageSize", Convert.ToString(PageSize));
    //        reportParameterList[12] = new Microsoft.Reporting.WebForms.ReportParameter("startRowIndex", Convert.ToString(currentPageNo));
    //        reportParameterList[13] = new Microsoft.Reporting.WebForms.ReportParameter("BookingNumber", Convert.ToString(BookingNumber));
    //        reportParameterList[14] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
    //        reportParameterList[15] = new Microsoft.Reporting.WebForms.ReportParameter("GroupOrgIDs", GroupOrgIDs);
    //        ReportUtil rUtil = new ReportUtil();
    //        returnCode = rUtil.GenerateReport(ReportViewer, reportParameterList, OrgID, sReportPath);
    //        ReportViewer.ServerReport.Refresh();

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Loading SSRS", ex);
    //    }
    //}


    public string GetConfigValues(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                strConfigValue = lstConfig[0].ConfigValue == null ? "" : lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    protected void bExportPdf_Click(object sender, EventArgs e)
    {
        HCmodalPopUp.Show();
        LoadPassingData();
    }
    public void LoadDefaultClientName()
    {
        Master_BL Master_BL = new Master_BL(new BaseClass().ContextInfo);
        List<ClientMaster> lstClientNames = new List<ClientMaster>();
        List<OrganizationAddress> lstorgname = new List<OrganizationAddress>();
        List<ClientMaster> lstClientNames1 = new List<ClientMaster>();
        string prefixText = string.Empty;
        long Ret1 = new Master_BL(base.ContextInfo).GetCollectionCentreClients(OrgID, ILocationID, prefixText, out lstClientNames);
        {
            string Location = LocationName.Trim().ToString();
            lstClientNames1 = (from find in lstClientNames
                               where
                               find.ClientName.Contains(Location)
                               orderby find.ClientName.ToUpper()
                               select find).ToList();

            if (lstClientNames1.Count > 0)
            {
                //txtLocClient.Text = lstClientNames1[0].ClientName;
                //hdnClienID.Value = lstClientNames1[0].ClientID.ToString();
                //hdnClienID.Value = lstClientNames[0].ClientID.ToString();
            }

        }
    }
    public void LoadDefaultClientNameBasedOnOrgLocation()
    {
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        string pType = "CLI";
        long refhospid = -1;
        strDisableclient = GetConfigValue("DisableClientForDefaultLocation", OrgID);
        lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            string[] ClientValues = lstClientNames[0].Value.Split('^');
            //string[] ClientRateID = ClientValues[4].Split('~');
            if (ClientValues[22] == "Y")
            {
                hdnLocationClient.Value = "Y";
                if (hdnDefaultClienID != null)
                {
                    hdnDefaultClienID.Value = Convert.ToString(lstClientNames[0].ClientID);
                }
                if (hdnDefaultClienName != null)
                {
                    hdnDefaultClienName.Value = lstClientNames[0].ClientName;
                }
                if (txtClient.Text == string.Empty)
                {
                    txtClient.Text = ClientValues[1];
                    if (strDisableclient == "Y")
                    {
                        txtClient.Enabled = true;
                    }
                    else
                    {
                        txtClient.Enabled = false;
                    }
                }
                if ((txtClient.Text == string.Empty) || (txtClient.Text == ClientValues[1]))
                {
                    hdnSelectedClientClientID.Value = Convert.ToString(lstClientNames[0].ClientID);
                    hdnIsCashClient.Value = ClientValues[17];
                    //hdnRateID.Value = Convert.ToString(ClientRateID[0]);
                }
            }
            else
                hdnLocationClient.Value = "N";
        }
    }
}

