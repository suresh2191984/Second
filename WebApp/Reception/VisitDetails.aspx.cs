using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.TrustedOrg;
using System.IO;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.Collections;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.pdf.draw;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;
using iTextSharp.tool.xml.html;
using iTextSharp.tool.xml.parser;
using iTextSharp.tool.xml.css;
using iTextSharp.tool.xml.pipeline.html;
using iTextSharp.tool.xml.pipeline.css;
using iTextSharp.tool.xml.pipeline.end;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;

public partial class Reception_VisitDetails : BasePage
{
    int startRowIndex = 1;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    long returnCode = -1;
    long patientID = -1;
    long visitID = 0;
    string vType = string.Empty;
    long pvisitID = 0;
    string pPatientName = string.Empty;
    string pPatientNo = string.Empty;
    int OP, IP;
    string pVisitType = string.Empty;
    long FinalbillId = 0;
    string BillNumber = string.Empty;
    string Visitno = string.Empty;
    string Gen = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<PatientVisit> lsttotalPatientCount = new List<PatientVisit>();
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    string pathname = string.Empty;
    string defaultText = string.Empty;
    string ExternalVisitSearch = string.Empty;
    string UseWarbNoAsSRFID = string.Empty;
    //string IsColumnViewable = string.Empty;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    private IList<OrderedInvestigations> lstgvChild
    {
        get
        {
            // to do not break SRP it's better to move check logic out of the getter
            return ViewState["key"] as List<OrderedInvestigations>;
        }
        set
        {
            ViewState["key"] = value;
        }
    }

    public Reception_VisitDetails()
        : base("Reception_VisitDetails_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string strSelect = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20;
    string strDateTime = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_06 == null ? "DateTime" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_06;
    string strRegLocation = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_07 == null ? "Registeration Location" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_07;
    string strPrintUser = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_08 == null ? "Printed User" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_08;
    string strTotalNoPatient = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_09 == null ? "Total Number of Patients" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_09;
    string strPatientNo= Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_25 == null ? "Patient Number" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_25;
    string strConNo = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_26 == null ? "Contact No" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_26;
    string strAge = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_27 == null ? "Age" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_27;
    string strVisitDate= Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_28 == null ? "VisitDate" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_28;
    string strVisitPurp = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_29 == null ? "Visit Purpose" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_29;
    string strLoc = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_30 == null ? "Location" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_30;
    string strIsCrdt = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_31 == null ? "IsCreatedBill" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_31;
    string strVisitStatus = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_32 == null ? "Visit Status" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_32;
    string strVisitTyp = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_33 == null ? "Visit Type" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_33;
    string strURN = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_34 == null ? "URNNO" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_34;
    string strClientAdd = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_35 == null ? "Client Address" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_35;
    string strInvDtls = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_36 == null ? "Investigation Details" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_36;
    string strViewDtls = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_37 == null ? "View Detail" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_37;
    string strFirstCD = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_38 == null ? "First CollectionDate" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_38;

    string strPatientName = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_10 == null ? "Patient Name" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_10;
    string strVisitNo = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11 == null ? "Visit Number" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_11;
    string strAgeGender = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_12 == null ? "Age/Gender" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_12;
    string strVisitDateTime = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_13 == null ? "Visit DateTime" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_13;
    string strClientName = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_14 == null ? "Client Name" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_14;
    string strRefDr = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_15 == null ? "Ref.Dr" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_15;
    string strZone = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_16 == null ? "Zone" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_16;
    string strRegUserName = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_17 == null ? "Registered Username" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_17;
    string strTestDescription = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_18 == null ? "Test Description" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_18;
    string strPatientNoVisit = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_01 == null ? "Patient No/Visit No :" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_01;
    string strregs= Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_24 == null ? "REGISTRATION CHECK LIST" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_24;
    string strMonth = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062 == null ? "Month(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_062;
    string strWeek = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063 == null ? "Week(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_063;
    string strYear = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064 == null ? "Year(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_064;
    string strDay = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061 == null ? "Day(s)" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_061;
    string strMale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072 == null ? "M" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_072;
    string strFemale = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073 == null ? "F" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_073;
    string strVet = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074 == null ? "Vet" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_074;
    string strNa = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_075 == null ? "N" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_075;
    string strUnknow = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_076 == null ? "U" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_076;
   string VisitSearch = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_0067 == null ? "VisitSearch" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_0067;
   string strUnknownF = Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086 == null ? "UnKnown" : Resources.CommonControls_ClientDisplay.CommonControls_TestMaster_ascx_086;
    string strLabNo = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04 == null ? "Lab Number" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04;
    protected void Page_Load(object sender, EventArgs e)
    {

        iframeBarcode.Attributes.Remove("src");
        AutoCompleteExtender2.ContextKey = "zone" + '~' + "-1";
        AutoUser.ContextKey = OrgID.ToString();
        /****************Added by Arivalagan.kk****************/
        ExternalVisitSearch = GetConfigValue("ExternalVisitSearch", OrgID);

        /****************End Added by Arivalagan.kk************/

        ////Added by Radha for Merging activity
        //IsColumnViewable = GetConfigValue("IsColumnViewable", OrgID);
        //changes by arun - after take reprint trf barcode, count box shouldbe shown
        if (ddlVisitActionName.SelectedValue == "Reprint_TRFBarcode_SampleSearch")
        {
            txtprintCnt.Attributes.Add("style", "display:inherit"); 
        }
        //
        if (!Page.IsPostBack)
        {
            UseWarbNoAsSRFID = GetConfigValue("UseWardnoAsSRFID", OrgID);
            hdnissrfidsearch.Value = UseWarbNoAsSRFID == "Y" ? UseWarbNoAsSRFID : "N";
            if (hdnissrfidsearch.Value == "Y")
            {
                tdlblsrfid.Style.Add("display", "table-cell");
                tdtxtsrfid.Style.Add("display", "table-cell");
            }
            //txtPatientNumber.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //txtPname.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            txtFrom.Attributes.Add("onchange", "ExcedDatevisitsearch('" + txtFrom.ClientID.ToString() + "','',0,0);ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            txtTo.Attributes.Add("onchange", "ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDatevisitsearch('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");

            if (RoleName == RoleHelper.Patient)
            {

                lblPatientNumber.Visible = false;
                txtPatientNumber.Visible = false;
                lblPatientname.Visible = false;
                txtPname.Visible = false;

            }


            grdResult.Visible = true;
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZoneNew);
            txtFrom.Text = OrgDateTimeZoneNew;
            txtFrom.Text = dt.ToString("dd-MM-yyyy") + " " + "00:00AM";
            txtTo.Text = dt.ToString("dd-MM-yyyy") + " " + "11:59PM";
            //txtTo.Text = OrgDateTimeZoneNew;
            
            string locationID = Convert.ToString(base.ILocationID);
            ddlocations.SelectedValue = locationID;
            GrdFooter.Visible = false;
            AddSearchColumns();
            LoadMetaData();
            LoadSpeciality();
            LoadDepartment();
            LoadLocation();
            Session["LastPageUrl"] = Request.Url.AbsolutePath.ToString();
            string configvalue = GetConfigValue("HideColumnForLab", OrgID);
            if (configvalue == "Y")
            {
                HideSpec.Visible = false;
                lblPatientNumber.Text = strPatientNoVisit.Trim();
                hdnspecdept.Value = configvalue;
            }

            vType = Request.QueryString["vType"];

            if (vType == "OP")
            {
                ddlType.SelectedValue = "OP";
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                GetPatientVisitDetails();
                // List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, OP, out lstVisitSearchAction);
                //lstActionsMaster = lstActionMaster.ToList();
                if (lstActionMaster.Count > 0)//(lstVisitSearchAction.Count > 0)//
                {
                    #region Add View State ActionList
                    string temp = string.Empty;
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    ViewState.Add("ActionList", temp);
                    #endregion
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    //ddlVisitActionName.DataValueField = "PageURL";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();
                }
            }
            else if (vType == "IP")
            {
                ddlType.SelectedItem.Text = "IP";
                ddlType.SelectedValue = "IP";
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                GetPatientVisitDetails();
                //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster); //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, IP, out lstVisitSearchAction);
                //lstActionsMaster = lstActionMaster.ToList();
                if (lstActionMaster.Count > 0)//(lstVisitSearchAction.Count > 0)
                {
                    #region Add View State ActionList
                    string temp = string.Empty;
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    ViewState.Add("ActionList", temp);
                    #endregion
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    //ddlVisitActionName.DataValueField = "PageURL";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();
                }
            }
            else
            {
                string temp = string.Empty;
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
                if (lstActionMaster.Count > 0)
                {
                    #region Add View State ActionList
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                }
                    #endregion
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
                if (lstActionMaster.Count > 0)
                {
                    #region Add View State ActionList
                    foreach (ActionMaster objActionMaster in lstActionMaster)
                    {
                        temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                    }
                    // ViewState.Add("ActionList", temp);
                }
                ViewState.Add("ActionList", temp);
                hdnCurrent.Value = "1";
                if (CID > 0)
                {
                    txtClientName.Text = UserName;
                    txtClientName.Attributes.Add("disabled", "true");
                }
                LoadGrid(e, 1, PageSize);
                    #endregion
            }

        }
        AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        //  AutoCompleteExtenderRefPhy.ContextKey = "RPH" + "^" + OrgID + "^" + "0";
        AutoCompleteExtenderRefPhy.ContextKey = Convert.ToString(OrgID);
        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitSearch", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {

            defaultText = strLabNo.Trim();
            txtPatientNumber.MaxLength = 20;
        }
        else
        {
            defaultText = strVisitNo.Trim();
        }
        txtwatermark();
    }

    public void txtwatermark()
    {
        if (txtPatientNumber.Text.Trim() != defaultText.Trim())
        {
            txtPatientNumber.Attributes.Add("style", "color:black");
        }
        if (txtPatientNumber.Text == "")
        {
            //txtPatientNumber.Text = defaultText;
            txtPatientNumber.Attributes.Add("style", "color:gray");
        }
        //txtPatientNumber.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        //txtPatientNumber.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

    }
   
    public void LoadLocation()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlocations.DataSource = LoginLoc;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
            else
            {
                ddlocations.DataSource = lstOrganizationAddress;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
        }
        ddlocations.Items.Insert(0, strSelect.Trim());
        ddlocations.Items[0].Value = "0";
    }

    public void LoadDepartment()
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
        }
        ddlDepartment.Items.Insert(0, strSelect.Trim());
        ddlDepartment.Items[0].Value = "0";
    }
    public void LoadSpeciality()
    {
        List<Speciality> lstSpeciality = new List<Speciality>();
        returnCode = new Speciality_BL(base.ContextInfo).GetSpeciality(OrgID, out lstSpeciality);
        if (lstSpeciality.Count > 0)
        {
            ddlspeciality.DataSource = lstSpeciality;
            ddlspeciality.DataTextField = "SpecialityName";
            ddlspeciality.DataValueField = "SpecialityID";
            ddlspeciality.DataBind();
        }
        ddlspeciality.Items.Insert(0, strSelect.Trim());
        ddlspeciality.Items[0].Value = "0";
    }

    #region Commented code - not required
    /*
    protected override void Render(HtmlTextWriter writer)
    {
        ddlVisitActionName.Items.Clear();
        long returnCode = -1;
        if (ddlType.SelectedItem.Text == "OP")
        {
            OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);

            //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
        }
        else if (ddlType.SelectedItem.Text == "IP")
        {
            IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
            //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
        }
        else
        {
            //IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
            //returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, out lstActionMaster);
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
        }
        if (ddlType.SelectedItem.Value != "Both")
        {
            ddlVisitActionName.DataSource = lstActionMaster;
            ddlVisitActionName.DataTextField = "ActionName";
            //ddlVisitActionName.DataValueField = "PageURL";
            ddlVisitActionName.DataValueField = "ActionCode";
            ddlVisitActionName.DataBind();
        }
        for (int i = 0; i < lstActionMaster.Count; i++)
        {
            Page.ClientScript.RegisterForEventValidation(ddlVisitActionName.UniqueID, lstActionMaster[i].ActionName.ToString());
        }
        base.Render(writer);

    }
     */
    #endregion

    //string strOP = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_02 == null ? "OP" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_02;
    //string strIP = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_03 == null ? "IP" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_03;
    private void GetPatientVisitDetails()
    {
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        vType = Request.QueryString["vType"];
        if (vType == "OP")
        {
            pVisitType = "0";
        }
        else
        {
            if (vType == "IP")
            {
                pVisitType = "1";
            }
        }

        if (vType == null)
        {
            if (ddlType.SelectedItem.Text == strOP.Trim())
            {
                pVisitType = "0";
            }
            else
            {
                if (ddlType.SelectedItem.Text == strIP.Trim())
                {
                    pVisitType = "1";
                }
            }
        }




        //returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(patientID,0, OrgID,Convert.ToInt32(pVisitType), out lstPatientVisit, out pPatientName, out pPatientNo);

        int VisitID = 0;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(patientID, VisitID, OrgID, Convert.ToInt32(pVisitType), out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);


        if (patientID == 0)
        {
            txtPatientNumber.Enabled = true;
        }
        else
        {

            txtPatientNumber.Text = pPatientNo;
            txtPatientNumber.Enabled = false;
        }


        lblPName.Text = pPatientName;

        grdResult.DataSource = lstPatientVisit;
        grdResult.DataBind();

        if (lstPatientVisit.Count > 0)
            trSelectVisit.Visible = true;
        else
            trSelectVisit.Visible = false;

        Visitno = lstPatientVisit[0].VisitNumber;
    }
    string strOP = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_02 == null ? "OP" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_02;
    string strIP = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_03 == null ? "IP" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_03;
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                //if (CID > 0)
                //{
                //    e.Row.Cells[11].Visible = false;
                //    e.Row.Cells[21].Visible = false;
                //}
                if (ExternalVisitSearch == "Y")
                { e.Row.Cells[6].Visible = true; }
                else
                { e.Row.Cells[6].Visible = false; }

               //Added by Radha for MergingActivity
                //if (IsColumnViewable == "Y")
                //{
                //    e.Row.Cells[17].Visible = true;
                //    e.Row.Cells[26].Visible = true;
                //    e.Row.Cells[9].Visible = true;
                //    e.Row.Cells[11].Visible = true;
                //    e.Row.Cells[6].Visible = true;
                //    e.Row.Cells[16].Visible = false;
                //    e.Row.Cells[28].Visible = false;
                //    e.Row.Cells[10].Visible = false;
                //    e.Row.Cells[7].Visible = false;
                //    e.Row.Cells[12].Visible = false;
                //    e.Row.Cells[25].Text = "Sample CollectionDate";
                //}

            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (ExternalVisitSearch == "Y")
                { e.Row.Cells[6].Visible = true; }
                else
                { e.Row.Cells[6].Visible = false; }

                //Added by Radha for MergingActivity
                //if (IsColumnViewable == "Y")
                //{
                //    e.Row.Cells[17].Visible = true;
                //    e.Row.Cells[26].Visible = true;
                //    e.Row.Cells[9].Visible = true;
                //    e.Row.Cells[11].Visible = true;
                //    e.Row.Cells[6].Visible = true;
                //    e.Row.Cells[16].Visible = false;
                //    e.Row.Cells[28].Visible = false;
                //    e.Row.Cells[10].Visible = false;                   
                //    e.Row.Cells[12].Visible = false;
                //    e.Row.Cells[7].Visible = false;
                //}


                LinkButton lnk = (LinkButton)e.Row.FindControl("lnkvisitno");
                lnk.Attributes.Add("onclick", "javascript:ShowPopUp('" + lnk.Text + "','Visit');");

                //Added By Sudha
                LinkButton lnkLabNo = (LinkButton)e.Row.FindControl("lnklabno");
                lnkLabNo.Attributes.Add("onclick", "javascript:ShowPopUp('" + lnkLabNo.Text + "','Lab');");

                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "Select_Visit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','"
                    + pv.PatientVisitId + "','" + pv.PatientID + "','" + pv.PatientName + "','" + pv.VisitType + "','" + pv.VisitState + "','"
                    + pv.WardNo + "','" + pv.PatientNumber + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
                Int64 FinalBillID = Convert.ToInt64(pv.FinalBillID.ToString() == "" ||
                    pv.FinalBillID.ToString() == string.Empty ? "0" : pv.FinalBillID.ToString());
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForBillVisit(pv.PatientVisitId, FinalBillID, OrgID,
                    ILocationID, out lstorderInv);

                //added by jegan
                //lstgvChild = lstorderInv;

                ViewState["PatientVisitId"] = pv.PatientVisitId;
                ViewState["FinalBillID"] = FinalBillID;
                ViewState["ILocationID"] = ILocationID;

                //
                ContextInfo.AdditionalInfo = pv.FinalBillID.ToString();
                ContextInfo.DepartmentName = "New";
                if (CID > 0)
                {
                    //e.Row.Cells[11].Visible=false;
                    //e.Row.Cells[21].Visible = false;
                    string Flag = string.Empty;
                    foreach (OrderedInvestigations item in lstorderInv)
                    {
                        if (item.ResCaptureLoc != ILocationID && item.Status != "Yet to Transfer")
                        {
                            Flag = "Y";
                        }
                    }
                    if (Flag == "Y")
                    {
                        RadioButton radio = (RadioButton)e.Row.Cells[0].FindControl("rdSel");
                        radio.Attributes.Add("disabled", "true");
                    }
                }
                if (lstorderInv.Count > 0)
                {
                    GridView grdChild = (GridView)e.Row.Cells[0].FindControl("ChildGrd");
                    grdChild.DataSource = lstorderInv;
                    grdChild.DataBind();

                    //DynamicGridColumns(grdChild);
                }
                if (pv.NurseNotes != null)
                {
                    string[] AgeValues;
                    string Ageval = string.Empty;
                    if (pv.NurseNotes != null)
                    {
                        AgeValues = pv.NurseNotes.Split('.');

                        if (AgeValues[0] != "0" && AgeValues[1] != "0")
                        {
                            Ageval = (AgeValues[0] + "." + AgeValues[1] + "Year(s)").ToString();
                            if (ExternalVisitSearch == "Y")
                            { e.Row.Cells[6].Text = Ageval; }
                            else
                            {
                                e.Row.Cells[7].Text = Ageval;
                            }
                        }

                    }
                }
                //added by jegan start
                string strFirstCollDate = string.Empty;
                strFirstCollDate = e.Row.Cells[24].Text;
                if (strFirstCollDate == "01/01/1900 00:00" || strFirstCollDate == "01/01/0001 00:00:00" || strFirstCollDate == "31/12/9999 00:00:00" || strFirstCollDate == "31/12/9999 23:59:59")
                    e.Row.Cells[24].Text = "";
                //end
            }
            foreach (GridViewRow grd in grdResult.Rows)
            {
                grdResult.Columns[3].Visible = true;
                Label l1 = (Label)grd.FindControl("lblGrdVisitType");
                if (l1.Text == "0")
                {
                    l1.Text = strOP.Trim();
                    l1.ForeColor = System.Drawing.Color.DarkMagenta;
                    l1.Font.Size = 11;

                }
                if (l1.Text == "1")
                {
                    l1.Text = strIP.Trim();
                    l1.ForeColor = System.Drawing.Color.Brown;
                    l1.Font.Size = 11;

                }
            }
            // DynamicGridColumns(grdResult);
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in grdResult_RowDataBound", Ex);
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewBill")
        {
            hdnFinalBillID.Value = "";//Added by Thamilselvan R for Showing the SSRS Report...
            hdnPVisitID.Value = "";//Added by Thamilselvan R for Showing the SSRS Report...

            string[] Data = e.CommandArgument.ToString().Split(',');
            string patientVisitID = Data[0].ToString();
            string FinalBillID = Data[1].ToString();
            string BillNumber = Data[2].ToString();

            //Added by Thamilselvan R for Showing the SSRS Report... 
            hdnFinalBillID.Value = FinalBillID.ToString();
            hdnPVisitID.Value = patientVisitID.ToString();

            decimal Creditvalue = Convert.ToDecimal(Data[3].ToString());//Added by Thamilselvan R for Showing the SSRS Report...

            string strSsrsShowReport = string.Empty;
            strSsrsShowReport = GetConfigValue("B2CSSRSFILLFORMAT", OrgID);

            if (strSsrsShowReport == "Y")
            {
                //CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=POPUP&type=printreport&invstatus=approve" + "&#toolbar=0&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                CouponCardBillFrame.Attributes["src"] = "..\\Investigation\\BillPrint.aspx?vid=" + patientVisitID + "&finalBillID=" + FinalBillID + "&actionType=POPUP&type=printreport&invstatus=approve" + "&navpanes=0";//added by Thamilselvan R...for Changing same as Billing...
                hdnTargetCtlMailReport.Value = "test";//added by Thamilselvan R...for Changing same as Billing...
                modalpopupsendemail.Show();//added by Thamilselvan R...for Changing same as Billing...     
            }

            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "PopUP", "javascript:OpenPopUp('" + patientVisitID + "','" + FinalBillID + "','" + BillNumber + "');", true);
            }
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {


        if (e.NewPageIndex >= 0)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }
    //added by jegan start
    protected void ChildGrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView ChildGrd=(sender as GridView);
        if (e.NewPageIndex >= 0)
        {
            ChildGrd.PageIndex = e.NewPageIndex;
            long PatientVisitId = Convert.ToInt64(ViewState["PatientVisitId"]);
            long FinalBillID = Convert.ToInt64(ViewState["FinalBillID"]);
            ILocationID = Convert.ToInt32(ViewState["ILocationID"]);
            List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
            ViewState["PatientVisitId"] = PatientVisitId;
            ViewState["FinalBillID"] = FinalBillID;
            ViewState["ILocationID"] = ILocationID;

            returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForBillVisit(PatientVisitId, FinalBillID, OrgID,
                   ILocationID, out lstorderInv);
            ChildGrd.DataSource = lstorderInv;
            ChildGrd.DataBind();
        }      

    }
    //End
    protected void btnGo_Click(object sender, EventArgs e)
    {
        #region Commented code
        /*
        if (hdndrpdowndetail.Value != "" && ddlType.SelectedItem.Text == "Both")
        {
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, out lstActionMaster);
            foreach (ActionMaster item in lstActionMaster)
            {
                if (hdndrpdowndetail.Value == item.ActionName)
                {
                    //ddlVisitActionName.SelectedValue = item.PageURL;
                    ddlVisitActionName.SelectedItem.Text = item.ActionName;
                    ddlVisitActionName.SelectedItem.Value = item.ActionCode;
                }
            }
        }
        if (ddlType.SelectedItem.Text == "OP")
        {
            OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);

            //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
        }
        else if (ddlType.SelectedItem.Text == "IP")
        {
            IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
            //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            #region Add View State ActionList
            string temp = string.Empty;
            foreach (ActionMaster objActionMaster in lstActionMaster)
            {
                temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
            }
            ViewState.Add("ActionList", temp);
            #endregion
        } */
        #endregion

        Int64.TryParse(Request.QueryString["PID"], out patientID);
        try
        {
            if (txtPatientNumber.Text.Trim() == defaultText.Trim())
            {
                txtPatientNumber.Text = "";
            }
            string pagename = string.Empty;
            returnCode = -1;
            long pBornVisitID = -1;
            returnCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(hdnVID.Value), out pBornVisitID);

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();

            string RedirectURL = string.Empty;
            string QueryString = string.Empty;

            //changes by arun
            if (ddlVisitActionName.SelectedValue == "Reprint_TRFBarcode_SampleSearch")
            {
                string barcodeType = string.Empty;
                string strPatientVisitId = string.Empty;
                string strSampleId = string.Empty;
                string MachineID = string.Empty;
                List<PrintBarcode> lstPrintBarcode = new List<PrintBarcode>();
                if (Session["MacAddress"] != null)
                {
                    MachineID = (string)Session["MacAddress"];
                }
                List<BarcodeAttributes> lstBarcodeAttributes;
                BarcodeHelper objBarcodeHelper = new BarcodeHelper();

                barcodeType = BarcodeCategory.TRF;
                strPatientVisitId = hdnVID.Value;                              
                objBarcodeHelper.GetBarcodeQueryString(OrgID, strPatientVisitId, strSampleId, 0, barcodeType, out lstBarcodeAttributes);

                if (lstBarcodeAttributes.Count > 0)
                {
                    foreach (BarcodeAttributes objBarcodeAttributes in lstBarcodeAttributes)
                    {
                        PrintBarcode objPrintBarcode = new PrintBarcode();
                        objPrintBarcode.VisitID = objBarcodeAttributes.VisitID;
                        objPrintBarcode.SampleID = objBarcodeAttributes.SampleID;
                        objPrintBarcode.BarcodeNumber = objBarcodeAttributes.BarcodeNumber;
                        objPrintBarcode.MachineID = MachineID;
                        objPrintBarcode.HeaderLine1 = objBarcodeAttributes.HeaderLine1;
                        objPrintBarcode.HeaderLine2 = objBarcodeAttributes.HeaderLine2;
                        objPrintBarcode.FooterLine1 = objBarcodeAttributes.FooterLine1;
                        objPrintBarcode.FooterLine2 = objBarcodeAttributes.FooterLine2;
                        if (txtprintCnt.Text != "")
                        {
                            for (int i = 0; i < Convert.ToInt32(txtprintCnt.Text); i++)
                            {
                                lstPrintBarcode.Add(objPrintBarcode);
                            }
                        }
                        else
                        {
                            lstPrintBarcode.Add(objPrintBarcode);
                        }
                    }
                }
                if (lstPrintBarcode.Count > 0)
                {
                    string barcode = string.Empty;
                    foreach (PrintBarcode oPrintBarcode in lstPrintBarcode)
                    {
                        if (barcode == string.Empty)
                        {
                            barcode = oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                        }
                        else
                        {
                            barcode = barcode + "?" + oPrintBarcode.HeaderLine1.Replace(" ", "|") + "~" + oPrintBarcode.HeaderLine2.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine1.Replace(" ", "|") + "~" + oPrintBarcode.FooterLine2.Replace(" ", "|") + "~" + oPrintBarcode.BarcodeNumber.Replace(" ", "|");
                        }
                    }
                    if (barcode != string.Empty)
                    {
                        CLogger.LogInfo("RePrint Barcode :   " + barcode);
                        iframeBarcode.Attributes["src"] = "attunebarcode:" + barcode;
                    }
                }
            }
            //
            else if (ddlVisitActionName.SelectedValue == "View_Print_Case_Sheet_IPCaseRecordSheet")
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + hdnPID.Value + "','OP');", true);
                return;
            }
            else if (ddlVisitActionName.SelectedValue == "Collect_Consultation_Fees_CheckPayment" || ddlVisitActionName.SelectedValue == "Print_Secured_Prescription_Page_ViewPrintPage")
            {
                string sPath = "Reception\\\\VisitDetails.aspx.cs_7";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days2", "javascript:ShowAlertMsg('" + sPath + "');", true);
            }
            else if (pBornVisitID > 0)
            {
                if (ddlVisitActionName.SelectedValue == "Edit_Capture_Case_Sheet_IPCaseRecord" || ddlVisitActionName.SelectedValue == "View_Edit_Admission_Notes_IPCaseRecordSheet" || ddlVisitActionName.SelectedValue == "Edit_Print_Discharge_Summary_DischargeSummaryDynamic")
                {
                    string sPath = "Reception\\VisitDetails.aspx.cs_8";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);
                }
            }
            else if (pBornVisitID == 0 && ddlVisitActionName.SelectedValue == "Print_Neonatal_Notes_NeonatalCaseSheet")
            {
                string sPath = "Reception\\VisitDetails.aspx.cs_8";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            }
            else if (ddlVisitActionName.SelectedValue == "Close_OP_Visit_CloseOPVisit")
            {

                long VisitID = Convert.ToInt32(hdnVID.Value);
                long ReturnStatus = 0;

                int PatientID = Convert.ToInt32(hdnPID.Value);
                if (visittype.Value == "0")
                {
                    List<PatientVisit> lstPatientVisitDetails = new List<PatientVisit>();
                    PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);

                    //returnCode = PatientVisit_BL.GetPatientVisitAndMRD(VisitID, out ReturnStatus, out lstPatientVisitDetails);
                    if (ReturnStatus == 0 || ReturnStatus == 1)
                    {
                        string sPath = "Reception\\VisitDetails.aspx.cs_10";
                        ClientScript.RegisterStartupScript(this.GetType(), "regis", "ShowAlertMsg('" + sPath + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert(' Munst CheckIn the Mrd File');", true);
                    }

                    if (ReturnStatus == 2)
                    {
                        string sPath = "Reception\\VisitDetails.aspx.cs_11";
                        ClientScript.RegisterStartupScript(this.GetType(), "regis", "ShowAlertMsg('" + sPath + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Visit State not in Open');", true);
                    }
                    if (ReturnStatus == 3)
                    {
                        string sPath = "Reception\\VisitDetails.aspx.cs_12";
                        ClientScript.RegisterStartupScript(this.GetType(), "regis", "ShowAlertMsg('" + sPath + "');", true);
                        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Task Can not be Pending');", true);
                    }
                    if (ReturnStatus == 4)
                    {
                        string sPath = "Reception\\VisitDetails.aspx.cs_13";
                        ClientScript.RegisterStartupScript(this.GetType(), "regis", "ShowAlertMsg('" + sPath + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('OP Visit Closed ');", true);
                    }
                }
            }
            else if (ddlVisitActionName.SelectedValue == "Print_VisitBarCode_PrintVisitBarCode")
            {
                string BarcodeType = string.Empty;
                BarcodeType = ddlVisitActionName.SelectedValue;
                GenerateBarCodeOutput(BarcodeType);
            }
            else if (ddlVisitActionName.SelectedValue == "Print_MRDBarCode_PrintMRDBarCode")
            {
                string BarcodeType = string.Empty;
                BarcodeType = ddlVisitActionName.SelectedValue;
                GenerateBarCodeOutput(BarcodeType);
            }
            else if (ddlVisitActionName.SelectedValue == "Print_Patient_Registration_Details_PrintPatientRegistration")
            {
                visitID = Convert.ToInt64(hdnVID.Value);
                long PatientID = Convert.ToInt64(hdnPID.Value);
                PrintNewPatientVisitDetailsXml(PatientID, visitID);
            }
            else if (ddlVisitActionName.SelectedValue == "PRINT_OP_CARD")
            {
                visitID = Convert.ToInt64(hdnVID.Value);
                long PatientID = Convert.ToInt64(hdnPID.Value);
                PrintExistingPatientVisitDetailsXml(PatientID, visitID);
            }
            else
            {
                //if (lstActionsMaster.Exists(p => p.ActionCode == ddlVisitActionName.SelectedValue))
                //{
                //    QueryString = lstActionsMaster.Find(p => p.ActionCode == ddlVisitActionName.SelectedValue).QueryString;
                //}
                #region View State Action List
                string ActCode = ddlVisitActionName.SelectedValue;
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
                objQueryMaster.PatientID = hdnPID.Value;
                objQueryMaster.PatientVisitID = hdnVID.Value;
                objQueryMaster.FinalBillID = FinalbillId.ToString();
                objQueryMaster.BillNumber = BillNumber.ToString();
                objQueryMaster.PatientName = hdnPNAME.Value.ToString();
                if (ddlVisitActionName.SelectedValue == "Print_CaseSheet_ViewPrintPage" || ddlVisitActionName.SelectedValue == "Edit_Print_Discharge_Summary_DischargeSummaryDynamic" || ddlVisitActionName.SelectedValue == "View_Edit_Operation_Notes_OperationNotesCaseSheet" || ddlVisitActionName.SelectedValue == "Print_Neonatal_Notes_NeonatalCaseSheet" || ddlVisitActionName.SelectedValue == "Print_IPAdmissionData_PrintIPAdmissionData")
                {
                    objQueryMaster.PatientID = patientID.ToString();
                }
                if (ddlVisitActionName.SelectedValue == "View_Edit_Admission_Notes_IPCaseRecordSheet" && pBornVisitID == 0)
                {
                    objQueryMaster.PatientID = patientID.ToString();
                }
                if (ddlVisitActionName.SelectedValue == "Edit_Diagnosis_PatientDiagnose")
                {
                    visitID = Convert.ToInt64(hdnVID.Value);
                    pvisitID = Convert.ToInt64(hdnVID.Value);
                    List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
                    if (visitID != null)
                    {
                        if (visitID == pvisitID)
                            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                        else
                            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    }
                    else
                    {
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    }
                    if (lstPatientComplaintDetail.Count == 0)
                    {
                        string strPatient = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_04 == null ? "The Patient" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_04;
                        string strDiagnosed = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_05 == null ? "is yet to be Diagnosed" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_05;
                        lblResult.Text = "" + strPatient + " '" + hdnPNAME.Value + "' " + strDiagnosed + "";
                        return;
                    }
                    else if (lstPatientComplaintDetail.Count > 1)
                    {
                        objQueryMaster.IdentityValue = "0";
                    }
                    else if (lstPatientComplaintDetail.Count == 1)
                    {
                        objQueryMaster.IdentityValue = lstPatientComplaintDetail[0].ComplaintID.ToString();
                    }
                    objQueryMaster.CountValue = lstPatientComplaintDetail.Count.ToString();
                }
                Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    if (ddlVisitActionName.SelectedValue == "Print_Bill_Print_Page")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintBill('" + RedirectURL + "');", true);
                    }
                    else
                    {
                        if (ddlVisitActionName.SelectedValue != "TRF_Upload" && ddlVisitActionName.SelectedValue != "Photo_Upload")
                        {
                            string PatVid = hdnVID.Value;
                            if (ViewState["Invcomment"] != null)
                            {
                                string Invcomment = ViewState["Invcomment"].ToString();
                                string[] GenderVid = Invcomment.Split(',');
                                if (GenderVid.Contains(PatVid) == true)
                                {
                                    RedirectURL = RedirectURL + "&VS=Y" + "&GR=Y";
                                }
                            }

                            else
                            {
                                if (ddlVisitActionName.SelectedValue == "Edit_Doctor")
                                {
                                    RedirectURL = RedirectURL + "&VS=Y" + "&GR=N&EditDoctor=Y";
                                }
                                else {
                                    RedirectURL = RedirectURL + "&VS=Y" + "&GR=N";
                                }
                            }
                            RedirectURL = RedirectURL + "&VS=Y";
                            Response.Redirect(RedirectURL, true);
                        }
                    }
                }
                else
                {
                    string sPath = "Reception\\VisitDetails.aspx.cs_9";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('" + sPath + "');", true);
                }
            }
            #endregion

            #region Hardcode Action Master
            //if (hdnVisitDetail.Value == "Print Bill")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=BP"+"&bid="+FinalbillId+"&BillNo="+BillNumber;
            //else if (hdnVisitDetail.Value == "View Pharm Consolidated Bill")
            //    pagename = "?vid=" + hdnVID.Value;
            //else if (hdnVisitDetail.Value == "View/Add diagnosis")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //else if (hdnVisitDetail.Value == "Print CaseSheet")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + patientID + "&pagetype=CP";
            //else if (hdnVisitDetail.Value == "Print Consolidate Report")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CR";
            //else if (hdnVisitDetail.Value == "Print Prescription")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=PP";
            //else if (hdnVisitDetail.Value == "Dialysis Case Sheet")
            //    pagename = "?vid=" + hdnVID.Value;
            //else if (hdnVisitDetail.Value == "Show Report")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CPL";
            //else if (hdnVisitDetail.Value == "Order Investigation")
            //    pagename = "?vid=" + hdnVID.Value + " &pid=" + hdnPID.Value + "&pagetype=OI";
            //else if (hdnVisitDetail.Value == "Add Bill Items")
            //    pagename = "?vid=" + hdnVID.Value + " &pid=" + hdnPID.Value + "&pagetype=ABI";
            //else if (hdnVisitDetail.Value == "Collect Payments")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CPay";
            //else if (hdnVisitDetail.Value == "Refund to Patient")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //else if (hdnVisitDetail.Value == "Upload Old Notes")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "Print IPAdmissionData")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "Print Label")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "View Consolidated Bill" || hdnVisitDetail.Value == "Edit/Capture Case Sheet")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "View/Print Case Sheet")
            //{
            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + hdnPID.Value + "','OP');", true);
            //    return ;
            //}
            //else if (hdnVisitDetail.Value == "Edit Admission Patient Details")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&IsCreditPatient=Y";
            //}
            //else if (hdnVisitDetail.Value == "Edit Patient Admission Details")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&IsCreditPatient=Y";
            //}
            //else if (hdnVisitDetail.Value == "Edit Diagnosis")
            //{
            //    visitID = Convert.ToInt64(hdnVID.Value);
            //    pvisitID = Convert.ToInt64(hdnVID.Value);
            //    List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            //    if (visitID != null)
            //    {
            //        if (visitID == pvisitID)
            //            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //        else
            //            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    }
            //    else
            //    {
            //        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    }
            //    if (lstPatientComplaintDetail.Count > 1)
            //    {
            //        Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
            //    }
            //    else if (lstPatientComplaintDetail.Count == 1)
            //    {
            //        Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + hdnPID.Value + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + pvisitID + "&tid=" + "0", true);
            //    }
            //    else if (lstPatientComplaintDetail.Count == 0)
            //    {
            //        lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
            //        return;
            //    }
            //}
            //if (hdnVisitDetail.Value == "Collect Consultation Fees")
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please Proceed via Todays Patient Link');", true);
            //}
            //else if (hdnVisitDetail.Value == "Print Secured Prescription Page")
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days2", "javascript:alert('Please Proceed via Todays Patient Link');", true);
            //}
            //else if (hdnVisitDetail.Value == "Print HealthPackage CaseSheet")
            //{
            //    if (patientID != 0)
            //    {
            //        hdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value, true);
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Edit/Print Discharge Summary")
            //{
            //    if (patientID != 0)
            //    {
            //        hdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&vType=" + "IP", true);
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "View/Edit Admission Notes")
            //{
            //    if (patientID != 0)
            //    {
            //        hdnPID.Value = patientID.ToString();
            //    }

            //    Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&vType=" + "IP", true);
            //}
            //else if (hdnVisitDetail.Value == "View/Edit Operation Notes")
            //{
            //    if (patientID != 0)
            //    {
            //        hdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&page=" + "Visit", true);
            //}
            //else if (pBornVisitID > 0)
            //{
            //    if (hdnVisitDetail.Value == "Edit/Capture Case Sheet")
            //    {
            //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for New born baby');", true);
            //    }
            //    else if (hdnVisitDetail.Value == "View/Edit Admission Notes" || hdnVisitDetail.Value == "Edit/Print Discharge Summary")
            //    {
            //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for New born baby');", true);
            //    }
            //    else if (hdnVisitDetail.Value == "Print Bill")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&page=" + "Visit", true);

            //    }
            //    else if (hdnVisitDetail.Value == "Show Report")
            //    {
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&page=" + "Visit", true);

            //    }
            //    else if (hdnVisitDetail.Value == "Print Neonatal Notes")
            //    {
            //        if (patientID != 0)
            //        {
            //            hdnPID.Value = patientID.ToString();
            //        }
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&vType=" + "IP", true);
            //    }

            //    else if (hdnVisitDetail.Value == "Print IPAdmissionData")
            //    {
            //        if (patientID != 0)
            //        {
            //            hdnPID.Value = patientID.ToString();
            //        }
            //        Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?PID=" + hdnPID.Value + "&VID=" + hdnVID.Value + "&PNAME=" + "" + "&vType=" + "IP", true);

            //    }
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Print Neonatal Notes")
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);
            //}
            ////else if()
            //else
            //{

            //    //Response.Redirect("../Reception/ViewPrintPage.aspx?vid=" + hdnVID.Value + "&pagetype=" + pagename + "", true);
            //    //Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + "?vid=" + hdnVID.Value, true);
            //    Response.Redirect(Helper.GetAppName() + ddlVisitActionName.SelectedItem.Value + pagename, true);
            //}
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    hdnvisit.Value = "";
    //    if (ddlType.SelectedItem.Text == "OP")
    //    {
    //        pVisitType = "0";
    //    }
    //    else if (ddlType.SelectedItem.Text == "IP")
    //    {

    //        pVisitType = "1";
    //    }
    //    else
    //    {
    //        pVisitType = "";
    //    }
    //    if (hdnspecdept.Value == "Y")
    //    {
    //        grdResult.Columns[15].Visible = true;
    //        grdResult.Columns[4].Visible = false;
    //        grdResult.Columns[8].Visible = false;
    //        grdResult.Columns[13].Visible = false;
    //        grdResult.Columns[10].Visible = false;
    //        grdResult.Columns[14].Visible = false;

    //    List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
    //    string pSearchType = "VISIT";
    //    string ShareType = "Clinical View";
    //    if (IsTrustedOrg == "Y")
    //    {
    //        returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
    //    }
    //    else
    //    {
    //        TrustedOrgDetails TOD = new TrustedOrgDetails();
    //        TOD.SharingOrgID = OrgID;
    //        lstTOD.Add(TOD);
    //    }
    //    string tempfrom = "01/01/2000";
    //    string fromDate, ToDate;

    // Validations done in the client side. No need to send the From date as '01/01/2000'
    //    fromDate = txtFrom.Text;
    //    ToDate = txtTo.Text;

    //    if (RoleName == RoleHelper.Patient)
    //    {
    //        returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, fromDate.ToString(), ToDate.ToString(), OrgID, pSearchType, out lstPatientVisit, currentPageNo, PageSize, out totalRows);
    //    }
    //    else
    //    {
    //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchDetailByPatient(txtPatientNumber.Text, txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, out lstPatientVisit, ddlDepartment.SelectedItem.Value, Convert.ToInt64(ddlspeciality.SelectedItem.Value), txtPatientNumber.Text, Convert.ToInt64(ddlocations.SelectedItem.Value));
    //    }

    //    if (lstPatientVisit.Count > 0)
    //    {
    //        lblPName.Text = lstPatientVisit[0].PatientName;
    //        grdResult.DataSource = lstPatientVisit;
    //        grdResult.DataBind();
    //        trSelectVisit.Visible = true;
    //        lblMessage.Text = "";
    //        if (ddlType.SelectedItem.Text == "Both")
    //        {

    //            foreach (GridViewRow grd in grdResult.Rows)
    //            {
    //                grdResult.Columns[3].Visible = true;
    //                Label l1 = (Label)grd.FindControl("lblGrdVisitType");
    //                if (l1.Text == "0")
    //                {
    //                    l1.Text = "OP";
    //                    l1.ForeColor = System.Drawing.Color.DarkMagenta;
    //                    l1.Font.Size = 11;

    //                }
    //                if (l1.Text == "1")
    //                {
    //                    l1.Text = "IP";
    //                    l1.ForeColor = System.Drawing.Color.Brown;
    //                    l1.Font.Size = 11;

    //                }
    //            }
    //        }
    //        else
    //        {
    //            grdResult.Columns[3].Visible = false;
    //        }
    //        if (ddlType.SelectedItem.Text == "OP")
    //        {
    //            OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
    //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
    //            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
    //        }
    //        else if (ddlType.SelectedItem.Text == "IP")
    //        {
    //            IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
    //List<VisitSearchActions> lstVisitSearchAction = new List<VisitSearchActions>();
    //            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
    //        }
    //        else
    //        {
    //            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, out lstActionMaster);
    //            foreach (ActionMaster item in lstActionMaster)
    //            {
    //                hdnvisit.Value += item.VisitType + "~" + item.ActionCode + "~" + item.ActionName + "^";
    //            }
    //lstActionMaster.Clear();
    //OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
    //returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
    //        }
    //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchActions(RoleID, OP, out lstVisitSearchAction);
    //        if (lstActionMaster.Count > 0)
    //        {
    //            ddlVisitActionName.DataSource = lstActionMaster;
    //            ddlVisitActionName.DataTextField = "ActionName";
    //            ddlVisitActionName.DataValueField = "ActionCode";
    //            ddlVisitActionName.DataBind();


    //    //DynamicGridColumns(grdResult);
    //   {
    //        grdResult.Visible = false;
    //        grdResult.DataSource = null;
    //        trSelectVisit.Visible = false;
    //        lblMessage.Text = "No matching records found";
    //    }


    //    //DynamicGridColumns(grdResult);
    //}

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            //added by jegan for date validation
             DateTime dtGetFromDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MM-yyyy HH:mm:sstt"));
            DateTime dtGetToDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MM-yyyy HH:mm:sstt"));
            dtGetFromDate = Convert.ToDateTime(txtFrom.Text.TrimEnd());
            dtGetToDate = Convert.ToDateTime(txtTo.Text.TrimEnd());
            if (dtGetFromDate.Date <= dtGetToDate.Date)
            {

                startRowIndex = 1;
                hdnCurrent.Value = startRowIndex.ToString();
                LoadGrid(e, startRowIndex, PageSize);
                lblCurrent.Text = startRowIndex.ToString();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "CheckFromDateToDate()", true);
                
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while btnSearch_Click", ex);

        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reception/VisitDetails.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    #region Formtodb Date Conversion
    protected string FormtoDb(string val)
    {
        if (val != "")
        {
            string[] dd = val.Split('/');
            val = dd[1].Trim() + "/" + dd[0].Trim() + "/" + dd[2].Trim();
        }
        return val;
    }
    #endregion

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "VisitType,";
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

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "VisitType"
                                  select child;

                ddlType.DataSource = childItems2;
                ddlType.DataTextField = "DisplayText";
                ddlType.DataValueField = "DisplayText";
                ddlType.DataBind();
                ddlType.SelectedValue = "Both";

            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data", ex);

        }
    }

    private void GenerateBarCodeOutput(string BarcodeType)
    {

        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        long patientVisitID = 0;
        patientVisitID = Convert.ToInt32(hdnVID.Value);
        if (BarcodeType == "Print_VisitBarCode_PrintVisitBarCode")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintVisitBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + patientVisitID + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.VisitNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
        }
        else if (BarcodeType == "Print_MRDBarCode_PrintMRDBarCode")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintVisitBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + patientVisitID + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.MRDNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
        }
    }

    protected void PrintNewPatientVisitDetailsXml(long patientID, long patientVisitID)
    {
        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<Patient> lstPatient = new List<Patient>();

        oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);
        oPatVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

        if (patientVisitID.Equals(-1))
        {
            patientVisitID = 0;
        }
        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("PatientIdentificationSheet");

                xw.WriteStartElement("VisitNo", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber)))
                {
                    xw.WriteString(lstPatientVisit[0].VisitNumber);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitDate", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MedicalRecordNo", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber)))
                {
                    xw.WriteString(lstPatientVisit[0].PatientNumber);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("PatientName", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].Name)))
                {
                    xw.WriteString(lstPatient[0].Name);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Location", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].PlaceOfBirth)))
                {
                    xw.WriteString(lstPatient[0].PlaceOfBirth);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("DOB", "");
                if (!string.IsNullOrEmpty(lstPatient[0].DOB.ToString()))
                {
                    xw.WriteString(lstPatient[0].DOB.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Age", "");
                if (!string.IsNullOrEmpty(lstPatient[0].Age))
                {
                    xw.WriteString(lstPatient[0].Age);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Sex", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].SEX)))
                {
                    xw.WriteString(lstPatient[0].SEX);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Religion", "");
                if (!string.IsNullOrEmpty(lstPatient[0].Religion))
                {
                    xw.WriteString(lstPatient[0].Religion);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Address", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].Address)))
                {
                    xw.WriteString(lstPatientVisit[0].Address);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("RTRW", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("Kelurahan", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("Kecamatan", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("City", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].City)))
                {
                    xw.WriteString(lstPatientVisit[0].City);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("State", "");

                if (!string.IsNullOrEmpty(lstPatient[0].StateName))
                {
                    xw.WriteString(lstPatient[0].StateName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("TelephoneNo", "");
                if (lstPatient.Count != 0 && lstPatient[0].MobileNumber != null)
                {
                    xw.WriteString(lstPatient[0].MobileNumber.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Country", "");
                if (!string.IsNullOrEmpty(lstPatient[0].CountryName))
                {
                    xw.WriteString(lstPatient[0].CountryName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("NoKTP", "");
                if (!string.IsNullOrEmpty(lstPatient[0].URNO))
                {
                    xw.WriteString(lstPatient[0].URNO);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Qualification", "");
                if (!string.IsNullOrEmpty(lstPatient[0].TypeName))
                {
                    xw.WriteString(lstPatient[0].TypeName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Occupation", "");
                if (!string.IsNullOrEmpty(lstPatient[0].OCCUPATION))
                {
                    xw.WriteString(lstPatient[0].OCCUPATION);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MaritalStatus", "");
                if (!string.IsNullOrEmpty(lstPatient[0].MartialStatus))
                {
                    xw.WriteString(lstPatient[0].MartialStatus);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("LastVisitDate", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Insurance", "");
                if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].ClientName)))
                {
                    xw.WriteString(lstPatientVisit[0].ClientName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Department", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("SubDepartment", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Speciality", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].SpecialityName))
                {
                    xw.WriteString(lstPatientVisit[0].SpecialityName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Allergy", "");
                xw.WriteString("----");
                xw.WriteEndElement();

                xw.WriteStartElement("CurrentDate", "");
                xw.WriteString(OrgTimeZone);
                xw.WriteEndElement();

                xw.WriteStartElement("LoginName", "");
                if (!string.IsNullOrEmpty(Name))
                {
                    xw.WriteString(Name);
                }
                else
                {
                    xw.WriteString("Officer Sign");
                }
                xw.WriteEndElement();

                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sw.ToString());
                ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                XslTransform xsl = new XslTransform();
                string s = Server.MapPath("..\\xsl\\patientIdentificationSheet.xsl");
                xsl.Load(s);

                XmlOP.Document = xml;
                XmlOP.Transform = xsl;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintOpCard", "PrintOpCard();", true);

            }
        }
    }


    protected void PrintExistingPatientVisitDetailsXml(long patientID, long patientVisitID)
    {
        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<Patient> lstPatient = new List<Patient>();

        oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);
        oPatVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("GenerateVisit");

                xw.WriteStartElement("Department", "");

                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                {
                    xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();


                xw.WriteStartElement("VisitPurpose", "");
                if (lstPatientVisit.Count != 0 && !string.IsNullOrEmpty(lstPatientVisit[0].VisitPurposeName))
                {
                    xw.WriteString(lstPatientVisit[0].VisitPurposeName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber))
                {
                    xw.WriteString(lstPatientVisit[0].VisitNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitDate", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString(OrgDateTimeZone);
                }
                xw.WriteEndElement();

                xw.WriteStartElement("SerialNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientVisitId.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].PatientVisitId.ToString());
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MediacalRecordNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber))
                {
                    xw.WriteString(lstPatientVisit[0].PatientNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("PatientName", "");
                if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].Name)))
                {
                    xw.WriteString(lstPatient[0].Name);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("DOB", "");
                if (!string.IsNullOrEmpty(lstPatient[0].DOB.ToString()))
                {
                    xw.WriteString(lstPatient[0].DOB.ToString());
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Age", "");
                string age = string.Empty;
                if (!string.IsNullOrEmpty(lstPatient[0].Age))
                {
                    xw.WriteString(lstPatient[0].Age);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Insurance", "");
                xw.WriteString("Insurance");

                xw.WriteEndElement();

                xw.WriteStartElement("InsuranceName", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].ClientName))
                {
                    xw.WriteString(lstPatientVisit[0].ClientName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("LoginName", "");
                xw.WriteString("");
                xw.WriteEndElement();

                xw.WriteEndElement();
                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sw.ToString());
                ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                XslTransform xsl = new XslTransform();
                string s = Server.MapPath("..\\xsl\\GenerateVisit.xsl");
                xsl.Load(s);

                XmlOP.Document = xml;
                XmlOP.Transform = xsl;
            }
        }


        ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintOpCard", "PrintOpCard();", true);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
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

    public List<DynamicColumnMapping> DynamicColumn()
    {
        long retCode = -1;
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        try
        {
            int SearchType = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
            retCode = new Patient_BL(base.ContextInfo).SearchColumns(SearchType, OrgID, out lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SearchColumns", ex);
        }
        return lstColumn;
    }
    private void AddSearchColumns()
    {
        Hashtable searchColumns = new Hashtable();
        DataTable dt = new DataTable();
        DataColumn dcName = new DataColumn("columnname");
        DataColumn dcValue = new DataColumn("columnvalue");
        dt.Columns.Add(dcName);
        dt.Columns.Add(dcValue);
        DataRow dr;
        searchColumns.Add(strPatientName, "Patient Name~1");
        searchColumns.Add(strPatientNo, "Patient Number~19");
        searchColumns.Add(strConNo, "Contact No~16");
        //searchColumns.Add("Patient VisitId", "Patient VisitId~18");
        searchColumns.Add(strVisitNo, "Visit Number~23");
        searchColumns.Add(strAge, "Age/Gender~15");
        searchColumns.Add(strVisitDate, "Visit Date~2");
        searchColumns.Add(strVisitPurp, "Visit Purpose~7");
        searchColumns.Add(strLoc, "Location~22");
        searchColumns.Add(strIsCrdt, "IsCreatedBill~24");
        searchColumns.Add(strVisitStatus, "Visit Status~26");
        searchColumns.Add(strVisitTyp , "Visit Type~25");
        searchColumns.Add(strURN, "URNNO~7");
        searchColumns.Add(strClientName , "Client Name~30");
        searchColumns.Add(strClientAdd, "Client Address~24");
        searchColumns.Add(strInvDtls, "Investigation Details~10");
        searchColumns.Add(strRegUserName, "Registered Username~40");
        searchColumns.Add(strViewDtls, "View Details~41");

        searchColumns.Add(strFirstCD, "Sample CollectionDate~25");
        //  searchColumns.Add("VisitNumber", "VisitNumber~15");



        foreach (DictionaryEntry dictE in searchColumns)
        {
            dr = dt.NewRow();
            dr["columnname"] = dictE.Key.ToString();
            dr["columnvalue"] = dictE.Value.ToString();
            dt.Rows.Add(dr);
        }
        ChkLstColumns.DataSource = dt;
        ChkLstColumns.DataTextField = "columnname";
        ChkLstColumns.DataValueField = "columnvalue";
        ChkLstColumns.DataBind();
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        lstColumn = DynamicColumn();
        foreach (DynamicColumnMapping item in lstColumn)
        {
            for (int i = 0; i < ChkLstColumns.Items.Count; i++)
            {
                string chkValueRaw = ChkLstColumns.Items[i].Value.ToString();
                string[] chkValue = chkValueRaw.Split('~');

                if (chkValue[0] == item.SearchColumnName && item.Visible == "true")
                {
                    ChkLstColumns.Items[i].Selected = true;
                }
            }
        }
    }

    string strNoRecord = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_21 == null ? "No matching records found" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_21;
    // andrews
    protected void btnUpdateFilter_Click(object sender, EventArgs e)
    {
        try
        {

            CollapsiblePanelExtender1.Collapsed = true;
            CollapsiblePanelExtender1.ClientState = "true";
            ArrayList arrayCheckedItem = new ArrayList();

            foreach (System.Web.UI.WebControls.ListItem chkitem in ChkLstColumns.Items)
            {
                if (chkitem.Selected == true)
                {
                    string chkValueRaw = chkitem.Value.ToString();
                    string[] chkValue = chkValueRaw.Split('~');
                    arrayCheckedItem.Add(chkValue[0]);
                }
            }
            for (int j = 0; grdResult.Columns.Count > j; j++)
            {
                if (grdResult.Columns[j].HeaderText != "Select" && grdResult.Columns[j].HeaderText != "Action")
                {
                    if (arrayCheckedItem.Contains(grdResult.Columns[j].HeaderText))
                    {
                        grdResult.Columns[j].Visible = true;
                    }
                    else
                    {
                        grdResult.Columns[j].Visible = false;
                    }
                }
            }

            List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
            lstColumn.Clear();

            foreach (System.Web.UI.WebControls.ListItem chkitem in ChkLstColumns.Items)
            {
                if (chkitem.Selected == true)
                {
                    string chkValueRaw = chkitem.Value.ToString();
                    string[] chkValue = chkValueRaw.Split('~');
                    DynamicColumnMapping lstitem = new DynamicColumnMapping();
                    lstitem.SearchTypeID = 11;
                    lstitem.SearchColumnID = Convert.ToInt32(chkValue[1]);
                    lstitem.OrgID = OrgID;
                    lstitem.Deleted = "N";
                    lstitem.Visible = "true";
                    lstColumn.Add(lstitem);
                }

                if (chkitem.Selected == false)
                {
                    string chkValueRaw = chkitem.Value.ToString();
                    string[] chkValue = chkValueRaw.Split('~');
                    DynamicColumnMapping lstitem = new DynamicColumnMapping();
                    lstitem.SearchTypeID = 11;
                    lstitem.SearchColumnID = Convert.ToInt32(chkValue[1]);
                    lstitem.OrgID = OrgID;
                    lstitem.Deleted = "N";
                    lstitem.Visible = "false";
                    lstColumn.Add(lstitem);
                }
            }
            returnCode = new PatientVisit_BL(base.ContextInfo).SaveDynamicColumnMapping(lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DynamicColumnMapping", ex);
        }


    }
    private void LoadGrid(EventArgs e, int startRowIndex, int PageSize)
    {
        if (txtClientName.Text == "")
        {
            hdnClientID.Value = "0";
        }
        if(txtzone.Text == "")
        {
            hdntxtzoneID.Value = "0";
        }       
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        if (ddlType.SelectedItem.Text == "OP")
        {
            pVisitType = "0";
        }
        else if (ddlType.SelectedItem.Text == "IP")
        {
            pVisitType = "1";
        }
        else
        {
            pVisitType = "";
        }
        if (hdnspecdept.Value == "Y")
        {
            grdResult.Columns[16].Visible = true;
            grdResult.Columns[4].Visible = false;
            grdResult.Columns[9].Visible = false;
            grdResult.Columns[14].Visible = false;
            grdResult.Columns[11].Visible = false;
            grdResult.Columns[15].Visible = false;
        }

      

        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string pSearchType = "VISIT";
        string ShareType = "Clinical View";
        long ClientID = 0;
        long LoginID = 0;
        long RefPhyID = 0;
        long ZoneId = 0;
        long SelectedlocationID = -1;
        Int64.TryParse(ddlocations.SelectedItem.Value, out SelectedlocationID);
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
        }
        else
        {
            TrustedOrgDetails TOD = new TrustedOrgDetails();
            TOD.SharingOrgID = OrgID;
            lstTOD.Add(TOD);
        }
        string tempfrom = "01/01/2000";
        string fromDate, ToDate;
        ClientID = Convert.ToInt64(hdnClientID.Value);
        if (hdnPhysicianID.Value != "0")
        {
            RefPhyID = Convert.ToInt64(hdnPhysicianID.Value.Split('~')[1]);
        }
        else
        {
            RefPhyID = 0;
        }

        if (hdntxtzoneID.Value != "0")
        {
            ZoneId = Convert.ToInt64(hdntxtzoneID.Value);
        }
        else
        {
            ZoneId = 0;
        }

        //added by jegan start
        if (txtUserName.Text != "")
            LoginID = Convert.ToInt32(hdnUserId.Value);
        //end
        fromDate = txtFrom.Text.ToString();
        ToDate = txtTo.Text.ToString();

        //added by Jegan
        if (txtPatientNumber.Text == "Visit Number")
            txtPatientNumber.Text = "";

        if (txtPatientNumber.Text == "Lab Number")
            txtPatientNumber.Text = "";

        if (CID > 0)
        {
            ClientID = CID;
        }
        if (txtSRFNumber.Text != "")
        {
            ContextInfo.AdditionalInfo = txtSRFNumber.Text;
        }
        if (RoleName == RoleHelper.Patient)
        {
            returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, fromDate, ToDate, OrgID, pSearchType, out lstPatientVisit, startRowIndex, PageSize, out totalRows);
        }
        else
        {
            if ((txtPatientNumber.Text != null) && (txtPatientNumber.Text != ""))
            {
  DateTime MinDate=DateTime.Now;
                if (txtFrom.Text.Trim() == "")
                {
                    MinDate = Convert.ToDateTime("01/01/1900 00:00:00AM");
                }
                else
                {
                    MinDate = Convert.ToDateTime(fromDate);
                }
                fromDate = MinDate.ToString("dd-MM-yyyy") + " " + "00:00AM";
               // ToDate = OrgDateTimeZone;
              //  SelectedlocationID = 0;
            }
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchDetailByPatient(txtPatientNumber.Text,
                txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, PageSize, startRowIndex, out totalRows,
                out lstPatientVisit, Convert.ToString(ddlDepartment.SelectedItem.Value), Convert.ToInt64(ddlspeciality.SelectedItem.Value), RefPhyID, ZoneId, out lsttotalPatientCount,
                "", SelectedlocationID, ClientID, LoginID, -1);
            if (totalRows > 0)
            {
                lblpatientCount.Text = totalRows.ToString();
            }
            else
            {
                lblpatientCount.Text = "0";
            }
            if (lsttotalPatientCount.Count > 0)
            {
                foreach (var item in lsttotalPatientCount)
                {
                    lblPatientTotalVisitCount.Text = item.PatientVisitCount.ToString();
                }
            }

        }
        ContextInfo.AdditionalInfo = "";
        if (lstPatientVisit.Count > 0)
        {

            if (pVisitType != "1")
            {
                grdResult.Columns[26].Visible = false;
                grdResult.Columns[27].Visible = false;
            }
            else
            {
                grdResult.Columns[26].Visible = true;
                grdResult.Columns[27].Visible = true;

            }
            //vijayalakshmi.M //
            if (lstPatientVisit.Count > 0)
            {
                for (int i = 0; i <lstPatientVisit.Count; i++)
                {
                    string age = string.Empty;
                    string[] splityears = lstPatientVisit[i].Age.Split(' ');
                    string[] splityears1 = lstPatientVisit[i].Age.Split('/');
                    string[] tempyears = splityears1[0].Split(' ');
                    if (tempyears.Length > 1)
                    {
                    if (tempyears[1] == "Year(s)")
                    {
                        //splityears[0] = tempyears[1] + "/" + strMale;
                        age = tempyears[0] + " " + strYear;
                    }
                    else if (tempyears[1] == "Week(s)")
                    {
                        //splityears[0] = tempyears[1] + "/" + strMale;
                        //age = tempyears[0] + " " + "Week(s)";
                        age = tempyears[0] + " " +strWeek;
                    }
                    else if (tempyears[1] == "Day(s)")
                    {
                        age = tempyears[0] + " " + strDay;
                    }
                    else if (tempyears[1] == "Month(s)")
                    {
                        age = tempyears[0] + " " + strMonth;
                    }
                    else if (tempyears[1] == "UnKnown")
                    {
                        age = strUnknownF;
                    }
                    else
                    {
                        age = tempyears[0] + " " + strYear;
                        }
                    }
                    if (splityears1.Length > 1)
                    {
                        if (splityears1[1] == " M")
                        {
                            age = age + "/ " + strMale;
                        }
                        else if (splityears1[1] == " F")
                        {
                            age = age + "/ " + strFemale;
                        }
                        else if (splityears1[1] == " U")
                        {
                            //age = age + "/ " + strUnknow;
                            if (age.Contains("UnKnown"))
                            {
                                age = strUnknownF;
                            }
                            else
                            {
                                age = age + "/ " + strUnknow;
                            }

                        }
                        else if (splityears1[1] == " N")
                        {
                            age = age + "/ NA" ;
                        }
                        else
                        {
                            age = age + "/ ";
                        }
                    }
                    else {
                        age = age + "/ ";
                    }
                    lstPatientVisit[i].Age = age;
                }
            }
            //ENd//
            lblPName.Text = lstPatientVisit[0].PatientName;
            grdResult.DataSource = lstPatientVisit;
            grdResult.DataBind();
            grdResult.Visible = true;
            GrdFooter.Visible = true;
            trSelectVisit.Visible = true;
            lblMessage.Text = "";
            if (ddlType.SelectedItem.Text == "Both")
            {
                foreach (GridViewRow grd in grdResult.Rows)
                {
                    grdResult.Columns[3].Visible = true;
                    Label l1 = (Label)grd.FindControl("lblGrdVisitType");
                    if (l1.Text == "0")
                    {
                        l1.Text = strOP.Trim();
                        l1.ForeColor = System.Drawing.Color.DarkMagenta;
                        l1.Font.Size = 11;
                    }
                    if (l1.Text == "1")
                    {
                        l1.Text = strIP.Trim();
                        l1.ForeColor = System.Drawing.Color.Brown;
                        l1.Font.Size = 11;
                    }
                }
            }
            else
            {
                grdResult.Columns[3].Visible = false;
            }
            if (ddlType.SelectedItem.Text == strOP.Trim())
            {
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
            }
            else if (ddlType.SelectedItem.Text == strIP.Trim())
            {
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            }
            else
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, out lstActionMaster);
                if (!IsPostBack)
                {
                    foreach (ActionMaster item in lstActionMaster)
                    {

                        hdnvisit.Value += item.VisitType + "~" + item.ActionCode + "~" + item.ActionName + "^";

                    }
                }
            }
            if (lstActionMaster.Count > 0)
            {
                ddlVisitActionName.DataSource = lstActionMaster;
                ddlVisitActionName.DataTextField = "ActionName";
                ddlVisitActionName.DataValueField = "ActionCode";
                ddlVisitActionName.DataBind();
            }
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = startRowIndex.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                startRowIndex = Convert.ToInt32(hdnCurrent.Value);
            }
            if (startRowIndex == 1)
            {
                Btn_Previous.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;
            }
            else
            {
                Btn_Previous.Enabled = true;
                if (startRowIndex == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Visible = false;
            grdResult.Visible = false;
            trSelectVisit.Visible = false;
            lblMessage.Text = "" + strNoRecord + "";
        }
       // hdntxtzoneID.Value = "0";
        //txtzone.Text = "";

        //Added by Radha for MergingActivity
        //if (IsColumnViewable == "Y")
        //{
        //    grdResult.Columns[17].Visible = true;
        //    grdResult.Columns[6].Visible = true;
        //    grdResult.Columns[26].Visible = true;
        //    grdResult.Columns[9].Visible = true;
        //    grdResult.Columns[11].Visible = true;
        //    grdResult.Columns[16].Visible = false;
        //    grdResult.Columns[28].Visible = false;
        //    grdResult.Columns[10].Visible = false;
        //    grdResult.Columns[8].Visible = false;
           
        //}
    }
    string strBoth = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_21 == null ? "Both" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_21;
    private void LoadGridExcel(EventArgs e, int startRowIndex, int PageSize)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";

        pVisitType = "1";

        if (hdnspecdept.Value == "Y")
        {
            grdResult.Columns[16].Visible = true;
            grdResult.Columns[4].Visible = false;
            grdResult.Columns[9].Visible = false;
            grdResult.Columns[14].Visible = false;
            grdResult.Columns[11].Visible = false;
            grdResult.Columns[15].Visible = false;
        }
        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string pSearchType = "VISIT";
        string ShareType = "Clinical View";
        long ClientID = 0;
        long LoginID = 0;
        long RefPhyID = 0;
        long ZoneId = 0;
        long SelectedlocationID = -1;
        Int64.TryParse(ddlocations.SelectedItem.Value, out SelectedlocationID);
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
        }
        else
        {
            TrustedOrgDetails TOD = new TrustedOrgDetails();
            TOD.SharingOrgID = OrgID;
            lstTOD.Add(TOD);
        }
        string tempfrom = "01/01/2000";
        string fromDate, ToDate;
        ClientID = Convert.ToInt64(hdnClientID.Value);
        if (hdnPhysicianID.Value != "0")
        {
            RefPhyID = Convert.ToInt64(hdnPhysicianID.Value.Split('~')[1]);
        }
        else
        {
            RefPhyID = 0;
        }

        if (hdntxtzoneID.Value != "0")
        {
            ZoneId = Convert.ToInt64(hdntxtzoneID.Value);
        }
        else
        {
            ZoneId = 0;
        }

        LoginID = Convert.ToInt64(hdnApprovedByID.Value);
        fromDate = txtFrom.Text.ToString();
        ToDate = txtTo.Text.ToString();

        if (CID > 0)
        {
            ClientID = CID;
        }
        if (txtSRFNumber.Text != "")
        {
            ContextInfo.AdditionalInfo = txtSRFNumber.Text;
        }
        if (RoleName == RoleHelper.Patient)
        {
            returnCode = new PatientAccess_BL(base.ContextInfo).pGetVisitSearchDetailByLoginID(LID, fromDate, ToDate, OrgID, pSearchType, out lstPatientVisit, startRowIndex, PageSize, out totalRows);
        }
        else
        {
            if ((txtPatientNumber.Text != null) && (txtPatientNumber.Text != ""))
            {
                DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00AM");
                fromDate = MinDate.ToString("MM-dd-yyyy") + " " + "00:00:00AM";
                ToDate = OrgDateTimeZone;
                SelectedlocationID = 0;
            }
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitSearchDetailByPatient(txtPatientNumber.Text,
                txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, PageSize, startRowIndex, out totalRows,
                out lstPatientVisit, Convert.ToString(ddlDepartment.SelectedItem.Value), Convert.ToInt64(ddlspeciality.SelectedItem.Value), RefPhyID, ZoneId, out lsttotalPatientCount,
                txtPatientNumber.Text, SelectedlocationID, ClientID, LoginID, -1);
            if (totalRows > 0)
            {
                lblpatientCount.Text = totalRows.ToString();
            }
            else
            {
                lblpatientCount.Text = "0";
            }
            if (lsttotalPatientCount.Count > 0)
            {
                foreach (var item in lsttotalPatientCount)
                {
                    lblPatientTotalVisitCount.Text = item.PatientVisitCount.ToString();
                }
            }

        }
        if (lstPatientVisit.Count > 0)
        {

            if (pVisitType != "1")
            {
                grdResult.Columns[26].Visible = false;
                grdResult.Columns[27].Visible = false;
            }
            else
            {
                grdResult.Columns[26].Visible = true;
                grdResult.Columns[27].Visible = true;

            }
            //vijayalakshmi.M //
            if (lstPatientVisit.Count > 0)
            {
                for (int i = 0; i < lstPatientVisit.Count; i++)
                {
                    string age = string.Empty;
                    string[] splityears = lstPatientVisit[i].Age.Split(' ');
                    string[] splityears1 = lstPatientVisit[i].Age.Split('/');
                    string[] tempyears = splityears1[0].Split(' ');
                    if (tempyears[1] == "Year(s)")
                    {
                        //splityears[0] = tempyears[1] + "/" + strMale;
                        age = tempyears[0] + " " + strYear;
                    }
                    else if (tempyears[1] == "Day(s)")
                    {
                        age = tempyears[0] + " " + strDay;
                    }
                    else if (tempyears[1] == "Month(s)")
                    {
                        age = tempyears[0] + " " + strMonth;
                    }
                    else if (tempyears[1] == "UnKnown")
                    {
                        age = strUnknownF;
                    }
                    else
                    {
                        age = tempyears[0] + " " + strYear;
                    }
                    if (splityears1[1] == " M")
                    {
                        age = age + "/ " + strMale;
                    }
                    else if (splityears1[1] == " F")
                    {
                        age = age + "/ " + strFemale;
                    }
                    else if (splityears1[1] == " U")
                    {
                        //age = age + "/ " + strUnknow;
                        if (age.Contains("UnKnown"))
                        {
                            age = strUnknownF;
                        }
                        else
                        {
                            age = age + "/ " + strUnknow;
                        }
                    }
                    else
                    {
                        age = age + "/ " + strMale;
                    }
                    lstPatientVisit[i].Age = age;
                }
            }
            //ENd//
            lblPName.Text = lstPatientVisit[0].PatientName;
            grdResult.DataSource = lstPatientVisit;
            grdResult.DataBind();
            grdResult.Visible = true;
            GrdFooter.Visible = true;
            trSelectVisit.Visible = true;
            lblMessage.Text = "";
            if (ddlType.SelectedItem.Text == strBoth.Trim())
            {
                foreach (GridViewRow grd in grdResult.Rows)
                {
                    grdResult.Columns[3].Visible = true;
                    Label l1 = (Label)grd.FindControl("lblGrdVisitType");
                    if (l1.Text == "0")
                    {
                        l1.Text = strOP.Trim();
                        l1.ForeColor = System.Drawing.Color.DarkMagenta;
                        l1.Font.Size = 11;
                    }
                    if (l1.Text == "1")
                    {
                        l1.Text = strIP.Trim();
                        l1.ForeColor = System.Drawing.Color.Brown;
                        l1.Font.Size = 11;
                    }
                }
            }
            else
            {
                grdResult.Columns[3].Visible = false;
            }
            if (ddlType.SelectedItem.Text == strOP.Trim())
            {
                OP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, OP, out lstActionMaster);
            }
            else if (ddlType.SelectedItem.Text == strIP.Trim())
            {
                IP = Convert.ToInt32(TaskHelper.SearchType.IPVisitSearch);
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            }
            else
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, out lstActionMaster);
                if (!IsPostBack)
                {
                    foreach (ActionMaster item in lstActionMaster)
                    {

                        hdnvisit.Value += item.VisitType + "~" + item.ActionCode + "~" + item.ActionName + "^";

                    }
                }
            }
            if (lstActionMaster.Count > 0)
            {
                ddlVisitActionName.DataSource = lstActionMaster;
                ddlVisitActionName.DataTextField = "ActionName";
                ddlVisitActionName.DataValueField = "ActionCode";
                ddlVisitActionName.DataBind();
            }
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = startRowIndex.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                startRowIndex = Convert.ToInt32(hdnCurrent.Value);
            }
            if (startRowIndex == 1)
            {
                Btn_Previous.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;
            }
            else
            {
                Btn_Previous.Enabled = true;
                if (startRowIndex == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Visible = false;
            grdResult.Visible = false;
            trSelectVisit.Visible = false;
            lblMessage.Text = strNoRecord.Trim();
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    string strNoData = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_22 == null ? "No Datas Found" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_22;
    protected void Bind(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        if (ddlType.SelectedItem.Text == strOP.Trim())
        {
            pVisitType = "0";
        }
        else if (ddlType.SelectedItem.Text == strIP.Trim())
        {
            pVisitType = "1";
        }
        else
        {
            pVisitType = "";
        }
        if (hdnspecdept.Value == "Y")
        {
            grdResult.Columns[16].Visible = true;
            grdResult.Columns[4].Visible = false;
            grdResult.Columns[9].Visible = false;
            grdResult.Columns[14].Visible = false;
            grdResult.Columns[11].Visible = false;
            grdResult.Columns[15].Visible = false;
        }
        List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
        string pSearchType = "VISIT";
        string ShareType = "Clinical View";
        long ClientID = 0;
        long LoginID = 0;
        long RefPhyID = 0;
        long ZoneId = 0;
        if (IsTrustedOrg == "Y")
        {
            returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
        }
        else
        {
            TrustedOrgDetails TOD = new TrustedOrgDetails();
            TOD.SharingOrgID = OrgID;
            lstTOD.Add(TOD);
        }
        string tempfrom = "01/01/2000";
        string fromDate, ToDate;
        ClientID = Convert.ToInt64(hdnClientID.Value);
        if (hdnPhysicianID.Value != "0")
        {
            RefPhyID = Convert.ToInt64(hdnPhysicianID.Value.Split('^')[1]);
        }
        else
        {
            RefPhyID = 0;
        }

        if (hdntxtzoneID.Value != "0")
        {
            ZoneId = Convert.ToInt64(hdntxtzoneID.Value);
        }
        else
        {
            ZoneId = 0;
        }
        if (CID > 0)
        {
            ClientID = CID;
        }
        if (txtSRFNumber.Text != "")
        {
            ContextInfo.AdditionalInfo = txtSRFNumber.Text;
        }
        LoginID = Convert.ToInt64(hdnApprovedByID.Value);
        fromDate = txtFrom.Text.ToString();
        ToDate = txtTo.Text.ToString();
        //if ((txtPatientNumber.Text != null) && (txtPatientNumber.Text != ""))
        //{
         //   DateTime MinDate = Convert.ToDateTime("01/01/1900 00:00:00AM");
          //  fromDate = MinDate.ToString("MM-dd-yyyy") + " " + "00:00:00AM";
         //   ToDate = OrgDateTimeZone;
        //}
        returnCode = new PatientVisit_BL(base.ContextInfo).GetAllVisitSearchDetailByPatient("",
              txtPname.Text, pVisitType, fromDate, ToDate, OrgID, lstTOD, pSearchType, PageSize, startRowIndex, out totalRows,
              out lstPatientVisit, Convert.ToString(ddlDepartment.SelectedItem.Value), Convert.ToInt64(ddlspeciality.SelectedItem.Value), RefPhyID, ZoneId, out lsttotalPatientCount,
              "", Convert.ToInt64(ddlocations.SelectedItem.Value), ClientID, LoginID);
        if (lstPatientVisit.Count > 0)
        {
            grdResult.Columns[16].Visible = false;
            grdResult.Columns[26].Visible = true;
            grdResult.Visible = true;
            for (int i = 0; i < lstPatientVisit.Count; i++)
            {
                List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(lstPatientVisit[i].PatientVisitId, OrgID, ILocationID, out lstorderInv);
                string InvestigationName = string.Empty;
                if (lstorderInv.Count > 0)
                {
                    for (int j = 0; j < lstorderInv.Count; j++)
                    {
                        if (InvestigationName == string.Empty)
                        {
                            InvestigationName = lstorderInv[j].InvestigationName;
                        }
                        else
                        {

                            InvestigationName += "," + lstorderInv[j].InvestigationName;
                        }
                    }
                }
                lstPatientVisit[i].ICDCodeStatus = InvestigationName;
            }
            //vijayalakshmi.M //
            if (lstPatientVisit.Count > 0)
            {
                for (int i = 0; i < lstPatientVisit.Count; i++)
                {
                    string age = string.Empty;
                    string[] splityears = lstPatientVisit[i].Age.Split(' ');
                    string[] splityears1 = lstPatientVisit[i].Age.Split('/');
                    string[] tempyears = splityears1[0].Split(' ');
                    if (tempyears[1] == "Year(s)")
                    {
                        //splityears[0] = tempyears[1] + "/" + strMale;
                        age = tempyears[0] + " " + strYear;
                    }
                    else if (tempyears[1] == "Day(s)")
                    {
                        age = tempyears[0] + " " + strDay;
                    }
                    else if (tempyears[1] == "Month(s)")
                    {
                        age = tempyears[0] + " " + strMonth;
                    }
                    else if (tempyears[1] == "UnKnown")
                    {
                        age = strUnknownF;
                    }
                    else
                    {
                        age = tempyears[0] + " " + strYear;
                    }
                    if (splityears1[1] == " M")
                    {
                        age = age + "/ " + strMale;
                    }
                    else if (splityears1[1] == " F")
                    {
                        age = age + "/ " + strFemale;
                    }
                    else if (splityears1[1] == " U")
                    {
                        //age = age + "/ " + strUnknow;
                        if (age.Contains("UnKnown"))
                        {
                            age = strUnknownF;
                        }
                        else
                        {
                            age = age + "/ " + strUnknow;
                        }
                    }
                    else
                    {
                        age = age + "/ " + strMale;
                    }
                    lstPatientVisit[i].Age = age;
                }
            }
            //ENd//
            IEnumerable<PatientVisit> lstfilter = (from S in lstPatientVisit
                                                   group S by new
                                                   {
                                                       S.PatientName,
                                                       S.VisitNumber,
                                                       S.ExternalVisitID, 
                                                       S.Location,
                                                       S.Age,
                                                       S.VisitDate,
                                                       S.ClientName,
                                                       S.PhysicianName,
                                                       S.Zone,
                                                       S.UserName,
                                                       S.ICDCodeStatus,
                                                       S.PhoneNumber
                                                   } into g
                                                   select new PatientVisit
                                                                {
                                                                    PatientName = g.Key.PatientName,
                                                                    VisitNumber = g.Key.VisitNumber,
                                                                    ExternalVisitID=g.Key.ExternalVisitID,
                                                                    Location=g.Key.Location,
                                                                    Age = g.Key.Age,
                                                                    VisitDate = g.Key.VisitDate,
                                                                    ClientName = g.Key.ClientName,
                                                                    PhysicianName = g.Key.PhysicianName,
                                                                    Zone = g.Key.Zone,
                                                                    UserName = g.Key.UserName,
                                                                    ICDCodeStatus = g.Key.ICDCodeStatus,
                                                                    PhoneNumber = g.Key.PhoneNumber
                                                                }).ToList();


            grdResult.DataSource = lstfilter;
            grdResult.DataBind();
        }
        else
        {
            grdResult.DataSource = "";
            grdResult.DataBind();
            grdResult.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('" + strNoData + "');", true);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        byte[] output = new byte[byte.MaxValue];
        grdResult.AllowPaging = false;

        //this functionality hide by sudha
        //this.Bind(sender, e);


        //this functionality added by sudha
        LoadGrid(e, 1, 0);
        

        if (lstPatientVisit.Count > 0)
        {
            try
            {

                string myFont =Server.MapPath(@"../Chinesefont/SIMSUN.ttf");
                //Response.Write("<script>alert('"+myFont+"')</script>");
                iTextSharp.text.pdf.BaseFont bfR;
                bfR = iTextSharp.text.pdf.BaseFont.CreateFont(myFont,
                  BaseFont.IDENTITY_H,
                  iTextSharp.text.pdf.BaseFont.EMBEDDED);

                Response.ClearContent();
                //Response.AddHeader("content-disposition", attachment);
                Response.AddHeader("content-disposition", @"attachment;filename=""PatientVisitDetails.pdf""");
                Response.ContentType = "application/pdf";
                Response.ContentEncoding = System.Text.Encoding.UTF8;
                Response.BinaryWrite(System.Text.Encoding.UTF8.GetPreamble());
                //StringWriter stw = new StringWriter();
                //HtmlTextWriter htextw = new HtmlTextWriter(stw);
                Document document = new Document(iTextSharp.text.PageSize.A4_LANDSCAPE.Rotate(), 7f, 7f, 7f, 0f);
                document.SetMargins(40f, 40f, 190f, 0f);
                MemoryStream memoryStream = new MemoryStream();
                PdfWriter writer = PdfWriter.GetInstance(document, Response.OutputStream);
                PdfPTable table1 = new PdfPTable(1);
                var physicalPath = Server.MapPath(LogoPath);
                iTextSharp.text.Image chartImage = iTextSharp.text.Image.GetInstance(physicalPath);
                //iTextSharp.text.Image chartImage = iTextSharp.text.Image.GetInstance(@"D:\dec_05_2013\Metro_Replica\Metro_Replica\Lims\Solution\WebApp\Images\Logo\Metropolis.png");
                chartImage.ScaleToFit(252f, 60f);
                PdfPCell cell = new PdfPCell();
                Phrase p = new Phrase(new Chunk(chartImage, 0, 0));
                cell.PaddingLeft = 10f;
                cell.PaddingTop = 40f;
                cell.PaddingBottom = 20f;
                iTextSharp.text.Font Head = new iTextSharp.text.Font(bfR, 12, iTextSharp.text.Font.BOLD);
                iTextSharp.text.Font fntHead = new iTextSharp.text.Font(bfR, 12, iTextSharp.text.Font.NORMAL);
                p.Add(Chunk.NEWLINE);
                p.Add(new Phrase(strregs,fntHead));
                p.Add(Chunk.NEWLINE);
                p.Add(new Phrase("" + strDateTime + " :  " + OrgDateTimeZone + "", fntHead));
                p.Add(new Phrase("    " + strRegLocation + " :  " + LocationName + "",fntHead));
                p.Add(new Phrase("    " + strPrintUser + " :  " + LoginName + "",fntHead));
                p.Add(new Phrase("    " + strTotalNoPatient + " :  " + lstPatientVisit.Count + "",fntHead));
                p.Font.Size = 12f;
                cell.HorizontalAlignment = PdfPCell.ALIGN_CENTER;
                cell.AddElement(p);
                table1.AddCell(cell);
                table1.SplitLate = false;
                table1.WidthPercentage = 100f;
                table1.TotalWidth = document.PageSize.Width - (document.LeftMargin + document.RightMargin);
                writer.PageEvent = new PdfPageEvents(table1);
                document.Open();
                PdfPTable ntable = new PdfPTable(9);
                ntable.WidthPercentage = 100;
                ntable.SplitLate = false;
                ntable.DefaultCell.BorderWidth = 0;
                ntable.DefaultCell.NoWrap = false;
                ntable.DefaultCell.Padding = 15;
                ntable.DefaultCell.SpaceCharRatio = 2;
                ntable.SetWidths(new int[9] { 27, 21, 22, 19, 32, 23, 30, 24, 30 });
                

               //iTextSharp.text.Font labelFont = iTextSharp.text.FontFactory.GetFont(bfR, 10, iTextSharp.text.Font.NORMAL);
               //iTextSharp.text.Font titleFont = iTextSharp.text.FontFactory.GetFont(bfR, 12, iTextSharp.text.Font.BOLD);
                PdfPCell cell1 = new PdfPCell(new Phrase("" + strPatientName + "",Head));
                ntable.AddCell(cell1);
                PdfPCell cell2 = new PdfPCell(new Phrase("" + strVisitNo + "",Head));
                ntable.AddCell(cell2);
                PdfPCell cell3 = new PdfPCell(new Phrase("" + strAgeGender + "",Head));
                ntable.AddCell(cell3);
                PdfPCell cell4 = new PdfPCell(new Phrase("" + strVisitDateTime + "",Head));
                ntable.AddCell(cell4);
                PdfPCell cell5 = new PdfPCell(new Phrase("" + strClientName + "",Head));
                ntable.AddCell(cell5);
                PdfPCell cell6 = new PdfPCell(new Phrase("" + strRefDr + "",Head));
                ntable.AddCell(cell6);
                PdfPCell cell7 = new PdfPCell(new Phrase("" + strZone + "",Head));
                ntable.AddCell(cell7);
                PdfPCell cell8 = new PdfPCell(new Phrase("" + strRegUserName + "",Head));
                ntable.AddCell(cell8);
                PdfPCell cell9 = new PdfPCell(new Phrase("" + strTestDescription + "",Head));
                ntable.AddCell(cell9);
                //vijayalakshmi.M //
                if (lstPatientVisit.Count > 0)
                {
                    for (int i = 0; i < lstPatientVisit.Count; i++)
                    {
                        string age = string.Empty;
                        string[] splityears = lstPatientVisit[i].Age.Split(' ');
                        string[] splityears1 = lstPatientVisit[i].Age.Split('/');
                        string[] tempyears = splityears1[0].Split(' ');
                        if (tempyears[1] == "Year(s)")
                        {
                            //splityears[0] = tempyears[1] + "/" + strMale;
                            age = tempyears[0] + " " + strYear;
                        }
                        else if (tempyears[1] == "Day(s)")
                        {
                            age = tempyears[0] + " " + strDay;
                        }
                        else if (tempyears[1] == "Month(s)")
                        {
                            age = tempyears[0] + " " + strMonth;
                        }
                        else if (tempyears[1] == "Unknown")
                        {
                            age = strUnknownF;
                        }
                        else
                        {
                            age = tempyears[0] + " " + strYear;
                        }
                        if (splityears1[1] == " M")
                        {
                            age = age + "/ " + strMale;
                        }
                        else if (splityears1[1] == " F")
                        {
                            age = age + "/ " + strFemale;
                        }
                        else if (splityears1[1] == " U")
                        {
                            //age = age + "/ " + strUnknow;
                            if (age.Contains("UnKnown"))
                            {
                                age = strUnknownF;
                            }
                            else
                            {
                                age = age + "/ " + strUnknow;
                            }
                        }
                        else
                        {
                            age = age + "/ " + strMale;
                        }
                        lstPatientVisit[i].Age = age;
                    }
                }
                //ENd//
                for (int i = 0; i < lstPatientVisit.Count; i++)
                {
                    PdfPCell cell10 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].PatientName.ToString(),fntHead)));
                    PdfPCell cell11 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].VisitNumber.ToString(),fntHead)));
                    PdfPCell cell12 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].Age.ToString(),fntHead)));
                    PdfPCell cell13 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].VisitDate.ToString(),fntHead)));
                    PdfPCell cell14 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].ClientName.ToString(),fntHead)));
                    PdfPCell cell15 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].PhysicianName.ToString(),fntHead)));
                    PdfPCell cell16;
                    if (lstPatientVisit[i].Zone == null)
                    {
                        cell16 = new PdfPCell(new Phrase(new Chunk("",fntHead)));
                    }
                    else
                    {
                        cell16 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].Zone.ToString().Trim(),fntHead)));
                    }
                    PdfPCell cell17 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].UserName.ToString(),fntHead)));
                    PdfPCell cell18 = new PdfPCell(new Phrase(new Chunk(lstPatientVisit[i].ICDCodeStatus.ToString(),fntHead)));
                    cell10.FixedHeight = 28;
                    ntable.AddCell(cell10);
                    ntable.AddCell(cell11);
                    ntable.AddCell(cell12);
                    ntable.AddCell(cell13);
                    ntable.AddCell(cell14);
                    ntable.AddCell(cell15);
                    ntable.AddCell(cell16);
                    ntable.AddCell(cell17);
                    ntable.AddCell(cell18);

                }

                document.Add(ntable);
                writer.CloseStream = false;
                document.Close();
                memoryStream.Position = 0;

                output = memoryStream.ToArray();
                memoryStream.Dispose();
            }
            catch (Exception Ex)
            {

            }
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('There is No Data to Export');", true);
        }
    }
    protected void imgbtnxls_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            grdResult.AllowPaging = false;
            //condition disabled by sudha
            Bind(sender, e);


            //condition added by sudha 
            string ShowPatientEmailID = GetConfigValue("ShowPatientEmailID", OrgID);
            if (ShowPatientEmailID == "Y")
            {
                grdResult.Columns[29].Visible = true;
               LoadGrid(e, 1, 0);
            }  
            //LoadGrid(e, 1, 0);

            string prefix = string.Empty;
            prefix = VisitSearch;
            string rptDate = prefix;
            string attachment = "attachment; filename=" + rptDate + "_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone) + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            grdResult.Columns[1].Visible = false;          //select
            grdResult.Columns[3].Visible = false;
            //grdResult.Columns[8].Visible = false;       //contact no
            grdResult.Columns[13].Visible = false;      //location
            grdResult.Columns[24].Visible = false;      //test description
            grdResult.Columns[25].Visible = false;
            grdResult.Columns[12].Visible = false;
            grdResult.Columns[20].Visible = false;

            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdResult.RenderControl(oHtmlTextWriter);
            string headerTable = @"<Table><tr><td ALIGN='CENTER' colspan='9' style='font-family:Verdana;font-size:20px;background-color:#E0FFFF;'><b>" + OrgName + "</b></td></tr>" +
               "<tr><td ALIGN='CENTER' colspan='9'; style='font-family:Verdana;font-size:15px;background-color:#F0FFF0;'><b>" + strregs + "</b></td></tr>" +
               "<tr ><td ALIGN='CENTER' colspan='3'   >" + strDateTime+"</b>" + OrgDateTimeZone + "</b></td> " +

                  "<td  colspan='2'>"+strRegLocation+"</b>" + LocationName + "</b></td>" +
                  "<td  colspan='2'>" + strPrintUser + "</b>" + LoginName + "</b></td>" +
                  "<td  ALIGN='CENTER' colspan='2'>"+strTotalNoPatient+"</b>" + lstPatientVisit.Count + "</b><td></tr>" +
               "<tr></tr>   </Table>";

            Response.Write(headerTable);
            Response.Write(oStringWriter.ToString());
            grdResult.AllowPaging = false;
            Response.End();
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error in exporting excel", ex);
        }
    }
    protected void TRFImageUpload_Click(object sender, FileCollectionEventArgs e)
    {
        Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
        string VisitID = string.Empty;
        String VisitNumber = String.Empty;
        string PID = hdnPID.Value;
        string VID = hdnVID.Value;
        long returncode = -1;
        pathname = GetConfigValue("TRF_UploadPath", OrgID);

        DateTime dt = new DateTime();
        dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        int Year = dt.Year;
        int Month = dt.Month;
        int Day = dt.Day;

        //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf
        new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(PID), out VisitID, out VisitNumber);
        String Root = String.Empty;
        String RootPath = String.Empty;
        //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
        Root = "UnKnown-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
        Root = Root.Replace("-", "\\\\");
        RootPath = pathname + Root;
        //ENd///

        HttpFileCollection oHttpFileCollection = e.PostedFiles;
        HttpPostedFile oHttpPostedFile = null;
        if (e.HasFiles)
        {
            for (int n = 0; n < e.Count; n++)
            {
                oHttpPostedFile = oHttpFileCollection[n];
                if (oHttpPostedFile.ContentLength <= 0)
                    continue;
                else
                {
                    // oHttpPostedFile.SaveAs(pathname + System.IO.Path.GetFileName(oHttpPostedFile.FileName));


                    string imagePath = pathname;

                    if (!String.IsNullOrEmpty(imagePath) && imagePath.Length > 0)
                    {

                        string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                        string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                        string picNameWithoutExt = PID + '_' + VID + '_' + +OrgID;
                        string pictureName = PID + '_' + VID + '_' + OrgID + '_' + Picture;
                        string NotImageFormat = PID + '_' + VID + '_' + OrgID + '_' + FullName;
                        string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                        //string filePath = imagePath + NotImageFormat;
                        string filePath = RootPath + NotImageFormat;
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        Response.OutputStream.Flush();

                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = pictureName + ".jpg";
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(oHttpPostedFile.InputStream);
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
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            int pno = int.Parse(PID.ToString());
                            int Vid = int.Parse(VID.ToString());
                            returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "UnKnown", Root, LID, dt, "Y",0);
                        }
                        else
                        {
                            oHttpPostedFile.SaveAs(filePath);
                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            int pno = int.Parse(PID.ToString());
                            int Vid = int.Parse(VID.ToString());
                            returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, "UnKnown", Root, LID, dt, "Y",0);

                        }

                        if (returncode >= 0)
                        {
                            string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_6";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('" + sPath + "');", true);
                            divUpload.Style.Add("Display", "none");
                        }
                    }
                    else
                    {
                        string sPath = "Patient\\\\PatientsCurrDateVist.aspx.cs_7";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('" + sPath + "');", true);
                    }
                }

            }
        }
    }
    //Added by Thamilselvan R to disable the IFrame source....
    protected void btn_DisableIframSRC(object sender, EventArgs e)
    {
        CouponCardBillFrame.Attributes["src"] = "";
    }

}

internal class PdfPageEvents : IPdfPageEvent
{
    #region members

    private PdfContentByte _content;
    private PdfPTable _footerTable;

    #endregion

    #region IPdfPageEvent Members

    public PdfPageEvents(PdfPTable footerTable)
    {
        _footerTable = footerTable;
    }

    public void OnOpenDocument(PdfWriter writer, Document document)
    {
        _content = writer.DirectContent;
    }

    public void OnStartPage(PdfWriter writer, Document document)
    {

    }

    public void OnEndPage(PdfWriter writer, Document document)
    {
        _footerTable.WriteSelectedRows(0, 3, document.LeftMargin, document.PageSize.Height - 40, writer.DirectContent);
    }

    public void OnCloseDocument(PdfWriter writer, Document document)
    {
    }

    public void OnParagraph(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnParagraphEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnChapter(PdfWriter writer, Document document, float paragraphPosition, Paragraph title)
    {
    }

    public void OnChapterEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnSection(PdfWriter writer, Document document, float paragraphPosition, int depth, Paragraph title)
    {
    }

    public void OnSectionEnd(PdfWriter writer, Document document, float paragraphPosition)
    {
    }

    public void OnGenericTag(PdfWriter writer, Document document, iTextSharp.text.Rectangle rect, string text)
    {
    }

    #endregion
}