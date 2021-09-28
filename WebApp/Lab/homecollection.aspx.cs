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

public partial class Lab_homecollection : BasePage
{
    string Task = string.Empty;
    string PatientName = string.Empty;
    int HC;
    long Returncode = -1;
    int PageSize = 10;
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
    string strSelect = Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_15 == null ? "---Select---" : Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_15;
    public Lab_homecollection()
        : base("Lab_homecollection_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteProduct.ContextKey = "Y";
        hdnOrgID.Value = OrgID.ToString();
        long bookingID = Convert.ToInt64(Request.QueryString["bookingID"]);
        hdnBookingID.Value = bookingID.ToString();
        billPart.BillingPageType = "HomeCollection";

       
        if (!IsPostBack)
        {
            if (bookingID > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:showsave();", true);

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            List<Bookings> lstBookings = new List<Bookings>();
            sBL.GetServiceQuotationDetails(bookingID, OrgID, out lstBookings);

            if (lstBookings.Count > 0)
            {
                Bookings oBookings = lstBookings[0];
                txtPatientName.Text = String.IsNullOrEmpty(oBookings.PatientName) ? string.Empty : oBookings.PatientName;
                txtDOBNos.Text = String.IsNullOrEmpty(oBookings.Age) ? string.Empty : oBookings.Age.Split('~')[0];
                ddlSex.SelectedValue = oBookings.SEX;
                txtMobile.Text = String.IsNullOrEmpty(oBookings.PhoneNumber) ? string.Empty : oBookings.PhoneNumber;
                chkNewPatient.Checked = true;
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

            //ddlRole.Items.Add(new ListItem("--Select--", "0"));
            //ddlUser.Items.Add(new ListItem("--Select--", "0"));

            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
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
            LoadAutoAutorize();
            LoadMeatData();
            string rval, roundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            hdnDecimalAgeHC.Value = GetConfigValue("DecimalAge", OrgID);
            hdnDefaultRoundoff.Value = rval;
            hdnRoundOffType.Value = roundpattern;
            ddlUser.Attributes.Add("onchange","ChangeUsers()");
            CascadeddlOrg.SelectedValue = OrgID.ToString();

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showuserRole", "javascript:showsave();resetsave();", true);
        }
        //else
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "showuserRole", "javascript:ShowUserForRole();loadlocations();loadRole();", true);
        //}
        if (!IsPostBack)
        {
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
        }

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

    protected void btnSave_Click(object sender, EventArgs e)
    {
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
            if (!chkNewPatient.Checked)
            {
                PatientID = Convert.ToInt64(hdnSelectedPatientID.Value);
            }
            else
            {
                PatientID = -1;
            }
            // PatientID = Convert.ToInt64(Patientdetails[1]);
        }
        CollectionAddr = txtAddress.Text;
        DateTime CollectionTime = Convert.ToDateTime(txtTime.Text);

        DateTime BookedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        DateTime BookedTo = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        if (ddlOrg.SelectedValue != "0" && ddlOrg.SelectedValue != null && ddlOrg.SelectedValue != "")
        {
            string[] OrgDetail = ddlOrg.SelectedValue.Split('~');
            OtherOrg = Convert.ToInt32(OrgDetail[0]);
            CollecOrgID = Convert.ToInt16(OrgDetail[0]);
        }

        if (ddlLocation.SelectedValue != "0" && ddlLocation.SelectedValue != null && ddlLocation.SelectedValue != "")
        {
            CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue.ToString());
        }

        if (ddlRole.SelectedValue != "0" && ddlRole.SelectedValue != null && ddlRole.SelectedValue != "")
        {
            string[] Roles = ddlRole.SelectedValue.Split('~');
            RoleID = Convert.ToInt64(Roles[0]);
        }
        if (ddlUser.SelectedValue != "0" && ddlUser.SelectedValue != null && ddlUser.SelectedValue != "")
        {
            string[] Users = ddlUser.SelectedValue.Split('~');
            UserID = Convert.ToInt64(Users[0]);
        }
        LoginOrgID = OrgID;
        string Status = string.Empty;
        Status = "B";
        Task = "Save";
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;

        //RetValue = new Investigation_BL(base.ContextInfo).SaveHomeCollectionDetails(PatientID, CollectionAddr, CollectionTime, CollectionTime,
        //    RoleID, UserID, CollecOrgID, CollecOrgAddrID, LoginOrgID, BookedAt,BookedTo, Status, Task, out lstHomeCollectionDetails, Add2,
        //    City, MobileNumber, pAge, Sex, pName, PageSize, currentPageNo, out totalRows);
        //if (lstHomeCollectionDetails.Count > 0)
        //{
        //    GrdFooter.Style.Add("display", "block");
        //    grdResult.DataSource = lstHomeCollectionDetails;
        //    grdResult.DataBind();
        //    grdResult.Visible = true;
        //    divPrintarea.Visible = true;
        //    grdResult.Visible = true;
        //    divPrint.Attributes.Add("style", "block");
        //    aRow.Attributes.Add("style", "block");
        //    divPrint.Visible = true;
        //    aRow.Visible = true;
        //}
        //else
        //{
        //    GrdFooter.Style.Add("display", "none");
        //    divPrintarea.Visible = false;
        //    divPrint.Attributes.Add("style", "none");
        //    aRow.Attributes.Add("style", "none");
        //    divPrint.Visible = false;
        //    aRow.Visible = false;
        //}
        //hdnUserID.Value = "0";

        ////////////////
        try
        {
            long returnCode = -1;
            List<Bookings> lstBookings = new List<Bookings>();
            Bookings oBookings = new Bookings();
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
            }
            oBookings.DOB = Convert.ToDateTime(Date);

            oBookings.PhoneNumber = txtMobile.Text.Trim();
            oBookings.LandLineNumber = txtTelephoneNo.Text;
            oBookings.FeeType = txtClient.Text;
            oBookings.SourceType = "Home Collection";
            oBookings.ClientID = 0;

            oBookings.PatientID = PatientID;
            oBookings.OrgAddressID = CollecOrgAddrID;
            oBookings.OtherOrgID = OtherOrg;
            oBookings.CollectionAddress = CollectionAddr;
            oBookings.RoleID = RoleID;
            oBookings.UserID = UserID;
            oBookings.CollectionTime = CollectionTime;
            oBookings.BookingOrgID = CollecOrgID;
            oBookings.BookingStatus = Status;
            oBookings.CollectionAddress2 = Add2;
            oBookings.City = City;
            oBookings.PatientNumber ="0";

            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            string gUID = string.Empty;
            lstInv = billPart.GetOrderedInvestigations(-1, out gUID);

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, OrgID, UserID, out  bookingID);
            //
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = bookingID;
            PC.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
            PC.OrgID = OrgID;
            PC.PatientVisitID = 0;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStep(PC);
            //
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsave", "showsave();", true);
            if (returnCode > -1)
            {
                string WinHdr = Resources.Lab_AppMsg.Lab_homecollection_aspx_02 == null ? "Alert" : Resources.Lab_AppMsg.Lab_homecollection_aspx_02;
                //string AlertMesg = "Patient Details Saved Successfully,Booking No is " + bookingID.ToString();
                string AlertMesg = Resources.Lab_AppMsg.Lab_homecollection_aspx_34 == null ? "Patient Details Saved Successfully,Booking No is " : Resources.Lab_AppMsg.Lab_homecollection_aspx_34;
                string AlrtMsgs = AlertMesg + bookingID.ToString();
                string PageUrl = Request.ApplicationPath + @"/Lab/homecollection.aspx?IsPopup=Y";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('" + AlrtMsgs + "','" + WinHdr + "');window.location ='" + PageUrl + "';", true);

            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving SaveData() Method Lab Quick Billing", ex);
        }
    

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetResult(e, currentPageNo, PageSize);
        //loaddata(lstHomeCollectionDetails);
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        string AlrtWin = Resources.Lab_AppMsg.Lab_homecollection_aspx_02 == null ? "Alert" : Resources.Lab_AppMsg.Lab_homecollection_aspx_02;
        string UsrWind = Resources.Lab_AppMsg.Lab_homecollection_aspx_35 == null ? "Updated successfully" : Resources.Lab_AppMsg.Lab_homecollection_aspx_35;

        try
        {
            string Patient = string.Empty;
            long PatientID = 0;
            string CollectionAddr = string.Empty;
            long RoleID = 0;
            long UserID = 0;
            int OtherOrg = 0;
            long CollecOrgAddrID = 0;
            string Add2 = string.Empty;
            string City = string.Empty;
            string MobileNumber = string.Empty;
            string pAge = string.Empty;
            string Sex = string.Empty;
            string pName = string.Empty;
            string Status = string.Empty;
            int CollecOrgID = 0;
            Add2 = txtSuburb.Text;
            City = txtCity.Text;
            MobileNumber = txtMobile.Text;
            pAge = txtDOBNos.Text + " " + ddlDOBDWMY.SelectedValue.ToString();
            Sex = ddlSex.SelectedValue.ToString();

            pName = txtPatientName.Text;

            Patient = txtPatientName.Text;
            string[] Patientdetails = Patient.Split('~');
            CollectionAddr = txtAddress.Text;
            DateTime CollectionTime = Convert.ToDateTime(txtTime.Text);
            
            DateTime Createdat = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            Status = ddlStatus.SelectedValue;

            if (ddlOrg.SelectedValue != "0" && ddlOrg.SelectedValue != null && ddlOrg.SelectedValue != "")
            {
                // string[] OrgDetail = ddlOrg.SelectedItem.Value.Split('~');
                CollecOrgID = Convert.ToInt32(ddlOrg.SelectedValue);
                string[] OrgDetail = ddlOrg.SelectedValue.Split('~');
                OtherOrg = Convert.ToInt32(OrgDetail[0]);
            }

            if (ddlLocation.SelectedValue != "0" && ddlLocation.SelectedValue != null && ddlLocation.SelectedValue != "")
            {
                CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue.ToString());
            }

            if (ddlRole.SelectedValue != "0" && ddlRole.SelectedValue != null && ddlRole.SelectedValue != "")
            {
                string[] Roles = (ddlRole.SelectedValue.Split('~'));
                RoleID = Convert.ToInt64(Roles[0]);

            }

            if (ddlUser.SelectedValue != "0" && ddlUser.SelectedValue != null && ddlUser.SelectedValue != "")
            {
                string[] Users = (ddlUser.SelectedValue.Split('~'));
                UserID = Convert.ToInt64(Users[0]);
            }
            
            long returnCode = -1;
            
            List<Bookings> lstBookings = new List<Bookings>();
            Bookings oBookings = new Bookings();
            oBookings.BookingID = Convert.ToInt64(hdnSelectedBookingID.Value);
            oBookings.TokenNumber = 0;
            oBookings.CreatedBy = LID;
            oBookings.OrgID = OrgID;
            oBookings.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            oBookings.PatientName = txtPatientName.Text.Trim().ToString().ToUpper();
            oBookings.SEX = ddlSex.SelectedValue;
            oBookings.Age = pAge;
            oBookings.OtherOrgID = OtherOrg;
            DateTime DOB = new DateTime();
            DOB = new DateTime(1800, 1, 1);
            string Date = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            oBookings.DOB = Convert.ToDateTime(Date);

            oBookings.PhoneNumber = txtMobile.Text.Trim();
            oBookings.LandLineNumber = txtTelephoneNo.Text.Trim();
            oBookings.FeeType = txtClient.Text;
            oBookings.SourceType = "Home Collection";
            oBookings.ClientID = 0;

            oBookings.PatientID = PatientID;
            oBookings.OrgAddressID = CollecOrgAddrID;
            oBookings.CollectionAddress = CollectionAddr;
            oBookings.RoleID = RoleID;
            oBookings.UserID = UserID;
            oBookings.CollectionTime = CollectionTime;
            oBookings.BookingOrgID = CollecOrgID;
            oBookings.BookingStatus = Status;
            oBookings.CollectionAddress2 = Add2;
            oBookings.City = City;
            oBookings.PatientNumber = "0";

            List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            string gUID = string.Empty;
            lstInv = billPart.GetOrderedInvestigations(-1, out gUID);

            Schedule_BL sBL = new Schedule_BL(base.ContextInfo);
            long bookingID = -1;
            returnCode = sBL.SaveServiceQuotationDetails(oBookings, lstInv, OrgID, LID, out  bookingID);
            if (returnCode == 1)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrWind + "','" + AlrtWin + "');", true);

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert1", "javascript:alert('Updated successfully');", true);
				ScriptManager.RegisterStartupScript(this, this.GetType(), "Clear", "clearupdate();", true);

            }
            clearAll();
            grdResult.Visible = false;
            //GetResult(e, currentPageNo, PageSize);
            PageContextDetails.ButtonName = ((Button)sender).ID;
            PageContextDetails.ButtonValue = ((Button)sender).Text;
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = bookingID;
            PC.RoleID = Convert.ToInt64(Session["RoleID"].ToString());
            PC.OrgID = OrgID;
            PC.PatientVisitID = 0;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = PageContextDetails.ButtonName;
            PC.ButtonValue = PageContextDetails.ButtonValue;
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStep(PC);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Date", ex);
        }
    }



    //public void loadOrgDetails()
    //{
    //    List<TrustedOrgDetails> lstTrustedOrgDetails = new List<TrustedOrgDetails>();
    //    new GateWay(base.ContextInfo).GetOrgDetails(OrgID, out lstTrustedOrgDetails);

    //    //lstTrustedOrgDetails = lstTrustedOrgDetails.FindAll(p => p.AddressID == ILocationID.ToString()).ToList();
    //    ddlOrg.DataSource = lstTrustedOrgDetails;
    //    ddlOrg.DataTextField = "OrgName";
    //    ddlOrg.DataValueField = "LoggedOrgID";
    //    ddlOrg.DataBind();
    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "StatusAlert", "loadlocations();loadRole();", true);
    //}


    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Bookings HCD = (Bookings)e.Row.DataItem;

            string strScript = "SelectRow('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + HCD.BookingID + "','" + HCD.PatientID + "','" + HCD.BookingStatus + "','" + HCD.PatientName + "','" + HCD.BookingID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

            string strEditScript = "SelectedPatient('" + HCD.BookingID + "','" + HCD.BookingStatus + "','" + HCD.PatientName + "','" + HCD.Age + "','" + HCD.DOB + "','" + HCD.SEX + "','" + HCD.PhoneNumber + "','" + HCD.CollectionAddress + "','" + HCD.CollectionAddress2 + "','" + HCD.City + "','" + HCD.CollectionTime.ToString("dd/MM/yyyy hh:mm tt") + "','" + HCD.LandLineNumber + "','" + HCD.RoleID + "','" + HCD.UserID + "','" + HCD.BookingOrgID + "','" + HCD.OrgAddressID + "');";
            ((LinkButton)e.Row.Cells[0].FindControl("linkEdit")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((LinkButton)e.Row.Cells[0].FindControl("linkEdit")).Attributes.Add("onclick", strEditScript);
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        if (e.CommandName == "Edit")
        {
            //string Roler = e.CommandArgument.ToString();
            //string[] RoleUser = new string[2];

            //RoleUser = Roler.Split(',');
            //hdnRoleId.Value = RoleUser[0];
            //hdnUserID.Value = RoleUser[1];

            //if (hdnUserID.Value != "0")
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "getAttrib", "loadusers()", true);
            //}

        }
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        string Alrtwin = Resources.Lab_AppMsg.Lab_homecollection_aspx_02 == null ? "Alert" : Resources.Lab_AppMsg.Lab_homecollection_aspx_02;
        string UsrWind = Resources.Lab_AppMsg.Lab_homecollection_aspx_36 == null ? "URL Not Found" : Resources.Lab_AppMsg.Lab_homecollection_aspx_36;
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
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrWind + "','" + Alrtwin + "');", true);

                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                }
            }
            #endregion
        }
    }

    public DataTable loaddata(List<Bookings> lstHomeCollectionDetails)
    {
        DataTable dt = new DataTable();
        DataColumn dcol8 = new DataColumn("Booking Number");
        DataColumn dcol9 = new DataColumn("Patient Number");
        DataColumn dcol10 = new DataColumn("Patient Name");
        DataColumn dcol11 = new DataColumn("Age/Gender");
        DataColumn dcol12 = new DataColumn("Collection Time");
        DataColumn dcol13 = new DataColumn("Collection Address");
        DataColumn dcol14 = new DataColumn("Role Name");
        DataColumn dcol15 = new DataColumn("User");
        DataColumn dcol17 = new DataColumn("Status");

        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol17);

        foreach (Bookings item in lstHomeCollectionDetails)
        {
            DataRow dr = dt.NewRow();
            dr["Booking Number"] = item.BookingID;
            dr["Patient Number"] = item.PatientNumber;
            dr["Patient Name"] = item.PatientName;
            dr["Age/Gender"] = item.Age;
            dr["Collection Time"] = item.CollectionTime.ToString("dd/MMM/yy hh:mm tt");
            dr["Collection Address"] = item.CollectionAddress;
            dr["Role Name"] = item.RoleName;
            dr["User"] = item.UserName;
            dr["Status"] = item.BookingStatus;
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

    /*****************Modified by Arivalagan.KK*****************/
    public void LoadAutoAutorize()
    {
        long returnCode = -1;
        List<LoginRole> objLoginRole = new List<LoginRole>();
        returnCode = new Investigation_BL(base.ContextInfo).GetRoleUserLogin(OrgID, out objLoginRole);
        if (objLoginRole.Count > 0)
        {
            Hashtable htRole = new Hashtable();
            SortedDictionary<string, string> sdList = new SortedDictionary<string, string>();
            sdList.Add("0", "--Select--");
            ddlUser.Items.Insert(0, "--Select--");
            ddlUser.Items[0].Value = "0";
            foreach (LoginRole item in objLoginRole)
            {
                if (item.RoleName == "Phlebotomist" || item.RoleName == "Sr Phlebotomist")
                {
                    if (!htRole.Contains(item.RoleID))
                    {
                        htRole.Add(item.RoleID, item.RoleName);
                    }
                    if (!sdList.ContainsKey(item.RoleID.ToString()))
                    {
                        sdList.Add(item.RoleID.ToString(), item.RoleName.ToString());
                    }

                    hdnRoleUser.Value += item.Status.ToString() +
                    "~" + item.OrganisationName.ToString() + "^";
                }
            }
            ddlRole.DataTextField = "Value";
            ddlRole.DataValueField = "Key";
            ddlRole.DataSource = sdList;
            ddlRole.DataBind();
            ddlRole.Attributes.Add("onchange", "ShowUserForRole()");
            ddlUser.Attributes.Add("onchange", "getUservalue()");
        }
    }
    /*****************Ens Modified by Arivalagan.KK*****************/
    public void LoadMeatData()
    {
        string select = Resources.Lab_ClientDisplay.Lab_homecollection_aspx_020 == null ? "--Select--" : Resources.Lab_ClientDisplay.Lab_homecollection_aspx_020;
        try
        {
            long returncode = -1;
            string domains = "DateAttributes,Gender";
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
            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
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
                    ddlSex.Items.Insert(0, select);
                    //ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedValue = "M";
                }
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "Homecollstatus"
                                  select child;

                if (childItems2.Count() > 0)
                {
                    ddlStatus.DataSource = childItems2;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();
                   // ddlStatus.Items.Insert(0, "--Select--");
                    ddlStatus.Items.Insert(0, strSelect);
                    ddlStatus.Items[0].Value = "0";
                    
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() Method in Lab Quick Billing", ex);

        }
    }

    private void GetResult(EventArgs e, int currentPageNo, int PageSize)
    {

        string Alrtwin = Resources.Lab_AppMsg.Lab_homecollection_aspx_02 == null ? "Alert" : Resources.Lab_AppMsg.Lab_homecollection_aspx_02;
        string UsrWind = Resources.Lab_AppMsg.Lab_homecollection_aspx_37 == null ? "No Matching Records Found" : Resources.Lab_AppMsg.Lab_homecollection_aspx_37;
        
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

       
        pName = txtPatientName.Text;
        if (txtBookingNumber.Text == string.Empty)
        {
            BookingNumber = 0;
        }
        else
        {
            BookingNumber = Convert.ToInt64(txtBookingNumber.Text);

        }
        MobileNumber = txtMobile.Text;
        TelePhone = txtTelephoneNo.Text.Trim();

        if (ddlOrg.SelectedValue != "0" && ddlOrg.SelectedValue != null && ddlOrg.SelectedValue != "")
        {
            // string[] OrgDetail = ddlOrg.SelectedValue.Split('~');
            CollecOrgID = Convert.ToInt32(ddlOrg.SelectedValue);

        }
        if (ddlLocation.SelectedValue != "0" && ddlLocation.SelectedValue != null && ddlLocation.SelectedValue != "")
        {
            CollecOrgAddrID = Convert.ToInt64(ddlLocation.SelectedValue.ToString());
        }

        LoginOrgID = OrgID;

        if (ddlRole.SelectedValue != "0" && ddlRole.SelectedValue != null && ddlRole.SelectedValue != "")
        {
            string[] Roles = (ddlRole.SelectedValue.Split('~'));
            RoleID = Convert.ToInt64(Roles[0]);
        }

        if (ddlUser.SelectedValue != "0" && ddlUser.SelectedValue != null && ddlUser.SelectedValue != "")
        {
            string[] Users = (ddlUser.SelectedValue.Split('~'));
            UserID = Convert.ToInt64(Users[0]);
        }
      
        if (txtFrom.Text != "")
        {
            BookedFrom = Convert.ToDateTime(txtFrom.Text);
        }
        else
        {
            BookedFrom = Convert.ToDateTime("1/1/1753");
        }
        if (txtTo.Text != "")
        {
            BookedTo = Convert.ToDateTime(txtTo.Text);
        }
        else
        {
            BookedTo = Convert.ToDateTime("1/1/1753");
        }
        if (txtCollFrom.Text != "")
        {
            Fromdate = Convert.ToDateTime(txtCollFrom.Text);
        }
        else
        {
            Fromdate = Convert.ToDateTime("1/1/1753");
        }
        if (txtCollto.Text != "")
        {
            Todate = Convert.ToDateTime(txtCollto.Text);
        }
        else
        {
            Todate = Convert.ToDateTime("1/1/1753");
        }

        Status = ddlStatus.SelectedValue;

        if (txtPatientName.Text != "")
        {
            if (!chkNewPatient.Checked)
            {
                Int64.TryParse(hdnSelectedPatientID.Value, out PatientID);
                //PatientID = Convert.ToInt64(hdnSelectedPatientID.Value);
            }
            else
            {
                PatientID = -1;
            }
            // PatientID = Convert.ToInt64(Patientdetails[1]);
        }

        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsave", "javascript:ShowUserForRole();", true);
        if (ddlUser.Items.FindByValue(hdnUserID.Value) != null)
        {
            ddlUser.SelectedValue =hdnUserID.Value;
        }
       
        Task = "Search";
        //ddlUser.SelectedValue = hdnUserID.Value;
        List<Bookings> lstHomeCollectionDetails = new List<Bookings>();

        new Investigation_BL(base.ContextInfo).GetHomeCollectionDetails(PatientID,Fromdate, Todate, RoleID, UserID, CollecOrgID,
            CollecOrgAddrID, LoginOrgID, BookedFrom,BookedTo, Status, Task, out lstHomeCollectionDetails,MobileNumber,TelePhone,
            pName, PageSize, currentPageNo,BookingNumber, out totalRows);

        if (lstHomeCollectionDetails.Count > 0)
        {
            loaddata(lstHomeCollectionDetails);
            GrdFooter.Style.Add("display", "block");
            aRow.Style.Add("display", "block");
            grdResult.Visible = true;
            divPrintarea.Visible = true;
            grdResult.DataSource = lstHomeCollectionDetails;
            grdResult.DataBind();
            divPrint.Style.Add("display", "block");
            aRow.Style.Add("display", "block");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsearch", "javascript:showsearch();", true);
        }
        else
        {
            GrdFooter.Style.Add("display", "none");
            aRow.Style.Add("display", "none");
            grdResult.Visible = false;
            divPrintarea.Visible = false;
            GrdFooter.Style.Add("display", "none");
            divPrint.Style.Add("display", "none");
            aRow.Style.Add("display", "none");
            divPrint.Visible = false;
            //aRow.Visible = false;
            divPrint.Visible = true;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrWind + "','" + Alrtwin + "');", true);

            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('No Matching Records Found');", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "showsearch1", "javascript:showsearch();clearupdate();", true);
        }
        hdnUserID.Value = "0";
       
    }

    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        GetResult(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }

    public void getdata(long bookingID)
    {
        try
        {
            Schedule_BL objBl = new Schedule_BL(base.ContextInfo);
            List<Bookings> lstBookingDetails = new List<Bookings>();
            List<Bookings> lstBookingDetailsQuot = new List<Bookings>();
            Returncode = objBl.GetBookingsDt(bookingID, out lstBookingDetails, out lstBookingDetailsQuot);
            if (lstBookingDetails.Count > 0)
            {
                lblPatAge.Text = lstBookingDetails[0].Age.ToString();
                lblEmail.Text = lstBookingDetails[0].EMail.ToString();
                lblMobNo.Text = lstBookingDetails[0].PhoneNumber.ToString();
                lblPatientName.Text = lstBookingDetails[0].PatientName.ToString();
                lblPatSex.Text = lstBookingDetails[0].SEX.ToString();
                lblTpno.Text = lstBookingDetails[0].LandLineNumber.ToString();
                lblNetAmt.Text = lstBookingDetails[0].Rate.ToString();
                lblGrossValue.Text = lstBookingDetails[0].Rate.ToString();
                lblDiscount.Text = "0.00";
                lblTax.Text = "0.00";
                lblEDCess.Text = "0.00";
                lblSHEDCess.Text = "0.00";
                lblSerChrg.Text = "0.00";
                lblRounOff.Text = "0.00";
                lblQuoteGivenby.Text = lstBookingDetails[0].PatientNumber.ToString();
                lblQuoteDate.Text = lstBookingDetails[0].CreatedAt.ToShortDateString();
            }

            grdBillDes.DataSource = lstBookingDetailsQuot;
            grdBillDes.DataBind();

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
        txtMobile.Text = "";
        txtTelephoneNo.Text = "";
        txtDOBNos.Text = "";
        ddlSex.SelectedValue = "M";
        txtPatientName.Text = "";
        txtBookingNumber.Text = "";
        ddlStatus.SelectedValue = "0";
        //hdnRoleId.Value = "0";
        //hdnUserID.Value = "0";
        //hdnlocid.Value = "0";
        txtAddress.Text = "";
        txtTime.Text = "";
    }
}

