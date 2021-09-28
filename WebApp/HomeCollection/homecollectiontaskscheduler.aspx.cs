using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
using System.Web.Services;
public partial class HomeCollection_homecollectiontaskscheduler : BasePage
{
    Role_BL roleBL;
    List<Role> role = new List<Role>();
   
    public HomeCollection_homecollectiontaskscheduler()
        : base("HomeCollection_homecollectiontaskscheduler_aspx")
    {
    }
    string SetDefaultClient = string.Empty;
    string strDisableclient = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        roleBL = new Role_BL(base.ContextInfo);
        // divsearch.Attributes.Add("display", "block");
        divsearch.Attributes.Add("style", "display:block;");
        hdnOrgID.Value = OrgID.ToString();
        hdnRoleId.Value = RoleID.ToString();
        hdnPageID.Value = PageID.ToString();
        long bookingID = Convert.ToInt64(Request.QueryString["bookingID"]);
        hdnBookingID.Value = bookingID.ToString();
        ddSalutation.Attributes.Add("onchange", "setSexValueQBLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "','" + "" + "');");
        ddlSex.Attributes.Add("onchange", "setSexValueoptLab('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
        HomeCollections_BL sBL = new HomeCollections_BL(base.ContextInfo);
        List<Bookings> lstBookings = new List<Bookings>();
        sBL.GetServiceQuotationDetails(bookingID, OrgID, out lstBookings);
        string PinCodeLoc = string.Empty;
        PinCodeLoc = GetConfigValues("PincodeandLocation", OrgID);
        hdnLoginID.Value = Convert.ToString(LID);
        if (PinCodeLoc == "Y")
        {
            hdnPinLoc.Value = "Y";
            txtpincode.Style.Add("display","none");//.Visible = false;
            txtPinCodeBo.Style.Add("display","none");//.Visible = false;
            txtLoc.Style.Add("display","none");//.Visible = false;
            txtSuburb.Style.Add("display","none");//.Visible = false;
            txtConfpincode.Style.Add("display","inline-block");//.Visible = true;
            txtConfPinCodeBo.Style.Add("display","inline-block");//.Visible = true;
            txtConfLoc.Style.Add("display","inline-block");//.Visible = true;
            txtConfigLoc.Style.Add("display","inline-block");//.Visible = true;
        }
        else
        {
            hdnPinLoc.Value = "N";
            txtConfpincode.Style.Add("display","inline-block");//.Visible = true;
            txtConfPinCodeBo.Style.Add("display","inline-block");//.Visible = true;
            txtConfLoc.Style.Add("display","inline-block");//.Visible = true;
            txtConfigLoc.Style.Add("display","inline-block");//.Visible = true;
            txtpincode.Style.Add("display","none");//.Visible = false;
            txtPinCodeBo.Style.Add("display","none");//.Visible = false;
            txtLoc.Style.Add("display","none");// = false;
            txtSuburb.Style.Add("display","none");// = false;
        }
        LoadQuickBillLoading();
        //{
            AutoCompleteExtenderRefPhy.ContextKey = "RPH";
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
			AutoCompleteExtenderClientCorp1.ContextKey ="CLI";
         //   AutoCompleteExtenderClientCorp.ContextKey = "0^0";
         //   AutoCompleteExtenderClientCorp1.ContextKey = "0^0";
            //    trBilling.Attributes.Add("display", "table-row");
            txtFeedback.Attributes.Add("maxlength", txtFeedback.MaxLength.ToString());
            txtAddress.Attributes.Add("maxlength", txtAddress.MaxLength.ToString());
            // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:showsave();", true);

            //  HomeCollections_BL sBL = new HomeCollections_BL(base.ContextInfo);
            //  List<Bookings> lstBookings = new List<Bookings>();
            //   sBL.GetServiceQuotationDetails(bookingID, OrgID, out lstBookings);

            if (lstBookings.Count > 0)
            {
                Bookings oBookings = lstBookings[0];
                txtPatientName.Text = String.IsNullOrEmpty(oBookings.PatientName) ? string.Empty : oBookings.PatientName;
                txtDOBNos.Text = String.IsNullOrEmpty(oBookings.Age) ? string.Empty : oBookings.Age.Split('~')[0];
                ddlSex.SelectedValue = oBookings.SEX;
                txtMobile.Text = String.IsNullOrEmpty(oBookings.PhoneNumber) ? string.Empty : oBookings.PhoneNumber;

                //chkNewPatient.Checked = true;
            }

       // }
        if (lstBookings.Count > 0)
        {
            Bookings oBookings = lstBookings[0];
            txtPatientName.Text = String.IsNullOrEmpty(oBookings.PatientName) ? string.Empty : oBookings.PatientName;
            txtDOBNos.Text = String.IsNullOrEmpty(oBookings.Age) ? string.Empty : oBookings.Age.Split('~')[0];
            ddlSex.SelectedValue = oBookings.SEX;
            txtMobile.Text = String.IsNullOrEmpty(oBookings.PhoneNumber) ? string.Empty : oBookings.PhoneNumber;

            //chkNewPatient.Checked = true;
        }
        hdncurdatetime.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(2).ToString("dd/MM/yyyy hh:mm tt");
        txtTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        if (!IsPostBack)
        {
            LoadDespatchMode();
            LoadMeatData();
            LoadURNtype();
        }
        DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime wkStDt = DateTime.MinValue;
        DateTime wkEndDt = DateTime.MinValue;
        wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
        wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
        hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
        hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");

        LoadURNtype();

        DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
        hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
        dateNow = dateNow.AddMonths(1);
        hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day

     //   string HCTechScheduler = GetConfigValues("IsHCSchedulerWorkflow", OrgID);
    //    if (HCTechScheduler == "Y")
     //   {
     //       hdnHCTechScheduler.Value = "Y";
     //      userImage.Style.Add("display", "none");
//userImage1.Style.Add("display", "none");
    //    }
    //    else
     //   {
      //     
         //   hdnHCTechScheduler.Value = "N";
      //  }
	   string HCTechScheduler = GetConfigValues("IsHCTechnician", OrgID);
         
            if (HCTechScheduler == "Y")
            {
                hdnHCTechScheduler.Value = "Y";
              //  rdoPatientSearch.Enabled = false;
             
              //  tdrdoPatientSearch.Attributes.Add("style", "display:none");
                        userImage.Style.Add("display", "none");
						userImage1.Style.Add("display", "none");
            }
            else
            {
            //    tdrdoPatientSearch.Style.Add("style", "display:block");
                hdnHCTechScheduler.Value = "N";
            }

        string IsMandatoryEmailandRefDr = GetConfigValues("IsMandatoryEmailandRefDr", OrgID);
        if (IsMandatoryEmailandRefDr == "Y")
        {
            hdnIsMandatoryEmailandRefDr.Value = "Y";
            ImgEmail.Style.Add("display", "block");
            ImgRefDr.Style.Add("display", "block");
        }
        else
        {
            ImgEmail.Style.Add("display", "none");
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


            LoadUser(OrgID, RoleID);
        }

    }
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
        //   LoadMeatData();
        //   LoadDespatchMode();

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
        strDisableclient = GetConfigValues("DisableClientForDefaultLocation", OrgID);
        lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            string[] ClientValues = lstClientNames[0].Value.Split('^');
            //string[] ClientRateID = ClientValues[4].Split('~');
            if (ClientValues[22] == "Y")
            {
              //  hdnLocationClient.Value = "Y";
                //if (hdnDefaultClienID != null)
                //{
                //    hdnDefaultClienID.Value = Convert.ToString(lstClientNames[0].ClientID);
                //}
                //if (hdnDefaultClienName != null)
                //{
                //    hdnDefaultClienName.Value = lstClientNames[0].ClientName;
                //}
                if (txtClientName.Text == string.Empty)
                {
                    txtClientName.Text = ClientValues[1];
                    if (strDisableclient == "Y")
                    {
                        txtClientName.Enabled = true;
                    }
                    else
                    {
                        txtClientName.Enabled = false;
                    }
                }
                if ((txtClientName.Text == string.Empty) || (txtClientName.Text == ClientValues[1]))
                {
                    hdnSelectedClientClientID.Value = Convert.ToString(lstClientNames[0].ClientID);
                 //   hdnIsCashClient.Value = ClientValues[17];
                    //hdnRateID.Value = Convert.ToString(ClientRateID[0]);
                }
            }
           // else
             //   hdnLocationClient.Value = "N";
        }
    }
    private void LoadUser(long OrgID, long RoleID)
    {
        try
        {
            //  long returncode = -1;
            Role_BL RoleBL = new Role_BL(new BaseClass().ContextInfo);

            long loginid = LID;

            GateWay gateway = new GateWay(base.ContextInfo);
            LoginRole loginRole = new LoginRole();
            loginRole.LoginID = loginid;
            loginRole.RoleID = RoleID;
            List<LoginRole> lstrole = new List<LoginRole>();

            gateway.GetLoggedInRoles(loginRole, out lstrole);
            List<Role> Temprole = new List<Role>();

            long returnCode = -1;
            int pOrgID = Convert.ToInt32(OrgID);
            returnCode = roleBL.GetRoleName(pOrgID, out role);
            RoleID = Int64.Parse(role.Where(o => o.RoleName == "Phlebotomist").Select(o => o.RoleID).FirstOrDefault().ToString());



            //int RoleIDno=RoleIDL.
            List<Users> lstResult = new List<Users>();

            RoleBL.GetUserName(OrgID, RoleID, out lstResult);
            if (lstResult.Count > 0 && lstResult != null)
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
                ddlOrg.Items.Insert(0, "------Select------");
                ddlOrg.Items[0].Value = "0";
                drpTech.DataSource = lstResult;
                drpTech.DataTextField = "Name";
                drpTech.DataValueField = "UserID";

                drpTech.DataBind();
                drpTech.Items.Insert(0, "------Select ALL------");
                drpTech.Items[0].Value = "0";
                ddlTechni.DataSource = lstResult;
                ddlTechni.DataTextField = "Name";
                ddlTechni.DataValueField = "UserID";

                ddlTechni.DataBind();
                ddlTechni.Items.Insert(0, "------Select ALL------");
                ddlTechni.Items[0].Value = "0";

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

            //if (lstmetadataOutput.Count > 0)
            //{
            //    var childItems = from child in lstmetadataOutput
            //                     where child.Domain == "HcCancelStatus" //orderby child .MetaDataID
            //                     select child;
            //    drpCancelStatus.DataSource = childItems;
            //    drpCancelStatus.DataTextField = "DisplayText";
            //    drpCancelStatus.DataValueField = "Code";
            //    drpCancelStatus.DataBind();

            //}



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }


   /* public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        HomeCollections_BL objGateway = new HomeCollections_BL(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }*/
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,CustomPeriodRange,HC-BookingStatus";
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
                    drpBooked.Items[0].Value = "0";
                    drpBooked.Items.Remove(drpBooked.Items.FindByValue("2"));
                    drpBooked.Items.Remove(drpBooked.Items.FindByValue("7"));
                    drpCollection.DataSource = childItems2;
                    drpCollection.DataTextField = "DisplayText";
                    drpCollection.DataValueField = "Code";
                    drpCollection.DataBind();
                    drpCollection.Items.Insert(0, "--Select ALL--");
                    drpCollection.Items[0].Value = "0";
                    drpCollection.Items.Remove(drpCollection.Items.FindByValue("2"));
                    drpCollection.Items.Remove(drpCollection.Items.FindByValue("7"));

                }
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "HC-BookingStatus" //&& child.DisplayText != "Completed"
                                  select child;
                if (childItems3.Count() > 0)
                {

                    // search status
                    ddlStat.DataSource = childItems3;
                    ddlStat.DataTextField = "DisplayText";
                    ddlStat.DataValueField = "Code";
                    ddlStat.DataBind();
                    ddlStat.Items.Insert(0, "--Select ALL--");
                    ddlStat.Items[0].Value = "0";
                    //  ddlStat.Items[1].Attributes["disabled"] = "disabled";
                    // ddlStat.Items[2].Attributes["disabled"] = "disabled";
                    //  ddlStat.Items[3].Attributes["disabled"] = "disabled";
                    //  ddlStat.Items[4].Attributes["disabled"] = "disabled";
                    //  ddlStat.Items[5].Attributes["disabled"] = "disabled";
                    //    ddlStat.Items[6].Attributes["disabled"] = "disabled";
                    //  ddlStat.Items[7].Attributes["disabled"] = "disabled";

                    //update status
                    ddlstats.DataSource = childItems3;
                    ddlstats.DataTextField = "DisplayText";
                    ddlstats.DataValueField = "Code";
                    ddlstats.DataBind();
                    ddlstats.Items.Insert(0, "--Select ALL--");
                    ddlstats.Items[0].Value = "0";
                    //ddlstats.Items[1].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[2].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[3].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[4].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[5].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[6].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[7].Attributes["disabled"] = "disabled";
                    //ddlstats.Items[8].Attributes["disabled"] = "disabled";
                    //buk update status
                    drpStatusBo.DataSource = childItems3;
                    drpStatusBo.DataTextField = "DisplayText";
                    drpStatusBo.DataValueField = "Code";
                    drpStatusBo.DataBind();
                    drpStatusBo.Items.Insert(0, "--Select ALL--");
                    drpStatusBo.Items[0].Value = "0";
                    //drpStatusBo.Items[2].Attributes["disabled"] = "disabled";
                    //drpStatusBo.Items[3].Attributes["disabled"] = "disabled";
                    //drpStatusBo.Items[4].Attributes["disabled"] = "disabled";
                    //drpStatusBo.Items[5].Attributes["disabled"] = "disabled";
                    //drpStatusBo.Items[6].Attributes["disabled"] = "disabled";
                    //drpStatusBo.Items[7].Attributes["disabled"] = "disabled";

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

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
    //protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    //{

    //    ExportToXL();
    //}
    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        BindDummyRow();
        ExportToXL();
    }
    public void ExportToXL()
    {
        string Ssting = "HomeCollection_Reports_Scheduler-Task";//Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_001 == null ? "TestWiseStatisticsReport" : Resources.Reports_ClientDisplay.Reports_TestWiseReportForLIMS_aspx_001;
        try
        {
            //Response.ClearContent();
            //Response.Buffer = true;
            //Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", (Ssting + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls")));
            //Response.ContentType = "application/ms-excel";
            //StringWriter sw = new StringWriter();
            //HtmlTextWriter htw = new HtmlTextWriter(sw);

            // grdResult.AllowPaging = false;

            ////Change the Header Row back to white color

            //BindDummyRow();

            //grdResult.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //grdResult.RenderControl(htw);
            //HttpContext.Current.Response.Write(sw.ToString());
            //HttpContext.Current.Response.End();

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", (Ssting + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls")));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {

                    grdResult.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }


    }
    private void BindDummyRow()
    {

        long UserID = 0;



        DateTime FromdateLoc;
        DateTime TodateLoc;
        DateTime ClollectFromLoc;
        DateTime ClollectToLoc;


        long BookingNumberLoc = 0;
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();
        List<OrderedInvestigations> lstOrdInvDetails = new List<OrderedInvestigations>();
        List<OrderedInvestigations> lstPreOrdInvDetails = new List<OrderedInvestigations>();




        DateTime today = new DateTime();




        UserID = Convert.ToInt64(drpTech.SelectedValue);


        long CollecOrgAddrID = 0;
        string Location = "";
        string Pincode = "";
        string BookingStatus = "";
        string pFromDate;
        string pToDate;
        string pCollectionFromDate;
        string pCollectionToDate;
        long OrgID = 0;
        long BookingNumber = -1;
        int CollecOrgIDLoc = 0;
        int LoginOrgIDLoc = 0;


        CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue);
        OrgID = Convert.ToInt64(ddlOrg.SelectedValue);

        Int32.TryParse(ddlOrg.SelectedValue, out CollecOrgIDLoc);
        Int32.TryParse(ddlLocation.SelectedValue, out LoginOrgIDLoc);

        Location = txtLoc.Text;
        Pincode = txtpincode.Text;
        BookingStatus = drpStatusBo.SelectedValue;
        pFromDate = txtFromDateBook.Text;
        pToDate = txtToDateBook.Text;
        pCollectionFromDate = txtFromDate.Text;
        pCollectionToDate = txtToDate.Text;


        if (drpCollection.SelectedIndex == 3)
        {
            pCollectionFromDate = txtFromPeriod.Text;
            pCollectionToDate = txtToPeriod.Text;

        }
        else if (drpCollection.SelectedIndex == 4)
        {

            pCollectionFromDate = today + " 00:00 AM";
            pCollectionToDate = today + " 23:59 PM";

        }

        if (drpBooked.SelectedIndex == 3)
        {
            pFromDate = txtFromPeriodBook.Text;
            pToDate = txtToPeriodBook.Text;
        }

        else if (drpBooked.SelectedIndex == 4)
        {
            pFromDate = today + " 00:00 AM";
            pToDate = today + " 23:59 PM";
        }

        if (pFromDate != "")
        {
            DateTime.TryParse(pFromDate, out FromdateLoc);
        }
        else
        {
            FromdateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (pToDate != "")
        {
            DateTime.TryParse(pToDate, out TodateLoc);
        }
        else
        {
            TodateLoc = Convert.ToDateTime("1/1/1753");
        }
        if (pCollectionFromDate != "")
        {

            DateTime.TryParse(pCollectionFromDate, out ClollectFromLoc);
        }
        else
        {
            ClollectFromLoc = Convert.ToDateTime("1/1/1753");
        }
        if (pCollectionToDate != "")
        {

            DateTime.TryParse(pCollectionToDate, out ClollectToLoc);
        }
        else
        {
            ClollectToLoc = Convert.ToDateTime("1/1/1753");
        }



        Int64.TryParse(txtBookNos.Text, out BookingNumberLoc);

        var MobileNumber = txtMob.Text;

        var Task = "Search";
        var TelePhone = "";
        var pName = "";

        var PageSize = 5;
        var currentPageNo = 1;

        if (txtBookingNumber.Text == string.Empty)
        {
            BookingNumber = 0;
        }
        else
        {
            BookingNumber = Convert.ToInt64(txtBookingNumber.Text);

        }
        Int64 clientID = 0;
    
        if (clientID == 0)
        {
            Int64.TryParse(hdnClientID.Value, out clientID);
        }
        var clientname = pName + "|" + clientID;
        
     //   ContextInfo.AdditionalInfo =clientID.ToString();

        HomeCollections_BL home_BlUI1 = new HomeCollections_BL(new BaseClass().ContextInfo);
        // data: "{CollecttionFromdate:'" + pCollectionFromDate + "',CollecttionTodate:'" + pCollectionToDate + "',Fromdate:'" + pFromDate + "',Todate:'" + pToDate + "',CollecOrgID:'" + CollecOrgID + "',LoginOrgID:'" + LoginOrgID + "',Status:'" + BookingStatus + "',Task:'" + Task + "',Location:'" + Location + "',Pincode:'" + Pincode + "',UserID:'" + UserID + "',MobileNumber:'" + MobileNumber + "',TelePhone:'" + TelePhone + "',pName:'" + pName + "',PageSize:'" + PageSize + "',currentPageNo:'" + currentPageNo + "',BookingNumber:" + BookingNumber + "}",
        home_BlUI1.GetHCBookingDetails(ClollectFromLoc, ClollectToLoc, UserID, CollecOrgIDLoc, Location, Pincode, LoginOrgIDLoc, FromdateLoc, TodateLoc,
        BookingStatus, Task, MobileNumber, TelePhone, clientname, PageSize, currentPageNo, BookingNumber,
        out  lstOrdInvDetails, out lstPreOrdInvDetails, out lstHomeCollectionDetails);

        if (lstHomeCollectionDetails.Count > 0)
        {
            divPrintarea.Visible = true;
            grdResult.DataSource = lstHomeCollectionDetails;
            grdResult.DataBind();
            hdnXLFlag.Value = "1";
        }
        else
        {
            grdResult.DataSource = "";
            grdResult.DataBind();
            hdnXLFlag.Value = "0";
        }


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadDefaultClientName();
        Int64 clientID = 0;

        if (clientID == 0)
        {
            Int64.TryParse(hdnSelectedClientClientID.Value, out clientID);
        }
        ContextInfo.AdditionalInfo = clientID.ToString();
        SearchData();


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    public void SearchData()
    {
        string WinAlert = "Alert";
        string UsrMsgWin = "No Matching Record Found";

        try
        {

            long returnCode = -1;

            HomeCollections_BL objBl = new HomeCollections_BL(base.ContextInfo);



            lnkExportXL.Visible = true;
            imgBtnXL.Visible = true;


            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgWin + "','" + WinAlert + "');", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured during GetScheduler", ex);
        }

    }
	
}
