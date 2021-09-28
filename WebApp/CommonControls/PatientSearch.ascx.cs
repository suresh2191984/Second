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
using System.Configuration;
using System.IO;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
public partial class CommonControls_PatientSearch : BaseControl
{
    public CommonControls_PatientSearch()
        : base("CommonControls_PatientSearch_ascx")
    {
    }
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    int OP;
    int IP;
    int currentPageNo = 1;
    string isWardNo = string.Empty;

    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    Patient_BL pBL;
    IP_BL IPBL;
    Investigation_BL InvestigationBL;
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }

   
        
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteProduct.ContextKey = "N";
        if (!IsPostBack)
        {

            btnGo1.Attributes.Add("onclick", "return checkForValues();");
            //txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            //txtPatientName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            txtRelation.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
            txtDOB.Attributes.Add("onKeyDown", "return validatenumber(event);");
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucINPatientSearch_txtFromDate',1,1);");
            hdnDateImage.Value = "0";
            LoadNationality();
            LoadSearchTypeMeatData();
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            pBL = new Patient_BL(base.ContextInfo);
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();
            }
            List<TPAMaster> lTpaMaster = new List<TPAMaster>();
            IPBL = new IP_BL(base.ContextInfo);
            IPBL.GetTPAName(OrgID, out lTpaMaster);
            ddlTpaName.DataSource = lTpaMaster;

            ddlTpaName.DataTextField = "TPAName";
            ddlTpaName.DataValueField = "TPAID";
            ddlTpaName.DataBind();
            ddlTpaName.Items.Insert(0, new ListItem("All", "-1"));
            List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
            InvestigationBL = new Investigation_BL(base.ContextInfo);
            InvestigationBL.getOrgClientName(OrgID, out Clientmaster);
            if (Clientmaster.Count > 0)
            {
                ddlCorporate.DataSource = Clientmaster;
                ddlCorporate.DataTextField = "ClientName";
                ddlCorporate.DataValueField = "ClientID";
                ddlCorporate.DataBind();
                ddlCorporate.Items.Insert(0, "All");
                ddlCorporate.Items[0].Value = "0";
            }
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd/MM/yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd/MM/yyyy");
            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd/MM/yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd/MM/yyyy"); //last day
            hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;

            #region lastmonth
            DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
            hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd/MM/yyyy");
            dtlm = dtlm.AddMonths(1);
            hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd/MM/yyyy");
            #endregion

            #region lastweek
            DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime LwkStDt = DateTime.MinValue;
            DateTime LwkEndDt = DateTime.MinValue;
            hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd/MM/yyyy");
            hdnLastWeekLast.Value = dt1.AddDays(-1 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd/MM/yyyy");

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
        }
        ScriptManager.RegisterStartupScript(this.Page, this.Page.GetType(), "Showddl", "javascript:ShowDDl();", true);
        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
                divRegDate.Attributes.Add("display", "block");
            }

        }
    }

    public void LoadNationality()
    {
        string select = Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03;
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
               // ddlNationality.Items.Insert(0, new ListItem("--Select--", "0"));  andrews
                ddlNationality.Items.Insert(0, select);

            }
            else
            {
            }
        }
        catch (Exception ex)
        {
        }
    }
    static bool FindNationality(Country c)
    {
        if (c.Nationality.ToUpper() == "INDIAN")
        {
            return true;
        }
        return false;
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        LoadGrid(e, currentPageNo, PageSize);
    }

    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
        long returnCode = -1;
        string strPatientName = "";
        string strDOB = "";
        string iPatientNo = "";
        string strLocation = "";
        string strOccuption = "";
        string strCity = "";
        string strMobile = "";
        string strRelation = "";
        string strUrno = "";
        long lngUrnTypeID = 0;
        string strNationality = "";
        string TPAID = "";
        string ClientID = "";
        string strSmartCardNo = "";
        string strLandLine = string.Empty;
        List<Patient> lstPatient = new List<Patient>();
        List<PatientVisit> lsttotalPatientCount = new List<PatientVisit>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        iPatientNo = txtPatientNo.Text;
        strPatientName = txtPatientName.Text;
        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
        strDOB = txtDOB.Text;
        strRelation = txtRelation.Text;
        strLocation = txtLocation.Text;
        strSmartCardNo = txtSmartCardNo.Text;

        if (ddOthers.SelectedValue == "Occupation")
        {
            strOccuption = txtOthers.Text;
        }
        else if (ddOthers.SelectedValue == "City")
        {
            strCity = txtOthers.Text;
        }
        else if (ddOthers.SelectedValue == "Mobile")
        {
            strMobile = txtOthers.Text;
        }
        else if (ddOthers.SelectedValue == "LandLine")
        {
            strLandLine = txtOthers.Text;
        }
        if (txtURNo.Text != "")
        {
            strUrno = txtURNo.Text;
            URNo = strUrno;
            lngUrnTypeID = Convert.ToInt64(ddlUrnType.SelectedValue);
        }
        if (ddlNationality.SelectedItem.Value == "0")
        {
            strNationality = "";
        }
        else
        {
            strNationality = ddlNationality.SelectedValue.ToString();
        }
        if (ddlType.SelectedItem.Text == "Any")
        {
            TPAID = "";
            ClientID = "";
        }

        if (ddlType.SelectedItem.Text == "Client")
        {
            if (ddlCorporate.SelectedItem.Text == "All")
            {
                ClientID = "";
                TPAID = "-1";
            }
            else
            {
                ClientID = ddlCorporate.SelectedValue.ToString();
                TPAID = "-1";
            }
        }
        if (ddlType.SelectedItem.Text == "Insurance")
        {
            if (ddlTpaName.SelectedItem.Text == "All")
            {
                ClientID = "-1";
                TPAID = "";
            }
            else
            {
                ClientID = "-1";
                TPAID = ddlTpaName.SelectedValue.ToString();
            }
        }
        string tempfrom = "";
        string fromDate, ToDate;
        if (ddlRegisterDate.SelectedItem.Value != "0" || ddlRegisterDate.SelectedItem.Value != "-1")
        {
            if (txtFromDate.Text != "" && txtToDate.Text != "")
            {
                fromDate = txtFromDate.Text;
                ToDate = txtToDate.Text;
            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                fromDate = txtFromPeriod.Text;
                ToDate = txtToPeriod.Text;
            }
            else if (ddlRegisterDate.SelectedValue == "4")
            {
                fromDate = OrgTimeZone;
                ToDate = OrgTimeZone;
            }
            else
            {
                fromDate = txtFromDate.Text;
                ToDate = txtToDate.Text;
            }
        }
        else
        {
            fromDate = tempfrom;
            ToDate = OrgTimeZone;

        }
        try
        {
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            string ShareType = "Clinical View";
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
            int Trustedlist = 0;
            foreach (TrustedOrgDetails a in lstTOD)
            {
                Trustedlist++;
            }

            HiddenField hdnPStatus = (HiddenField)Parent.FindControl("hdnPStatus");
            string Pstatus = "D";
            if (txtPatientName.Text.Trim() != "")
            {
                Pstatus = hdnPStatus.Value;
            }
            if (chkInactive.Checked == true)
            {
                Pstatus = string.Empty;
            }


            returnCode = patientBL.SearchPatient(iPatientNo, strSmartCardNo, strPatientName, strDOB, strRelation, strLocation, strOccuption, strCity, strMobile, OrgID, PageSize, currentPageNo, out totalRows, out lsttotalPatientCount, lstTOD, Convert.ToInt32(TaskHelper.SearchType.OP), URNo, lngUrnTypeID, out lstPatient, strNationality, TPAID, ClientID, fromDate, ToDate, strLandLine, Pstatus);
            lblpatientCount.Text = totalRows.ToString();
            if (lsttotalPatientCount.Count > 0)
            {
                foreach (var item in lsttotalPatientCount)
                {
                    lblPatientTotalVisitCount.Text = item.PatientVisitCount.ToString();
                }
            }
            if (lstPatient.Count > 0)
            {
                GrdFooter.Style.Add("display", "block");
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

                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        Btn_Next.Enabled = false;
                    else Btn_Next.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Search Patient", ex);
        }
        if (returnCode == 0 && lstPatient.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstPatient;
            grdResult.DataBind();
            HasResult = true;
            GrdHeader.Style.Add("display", "block");
            Label4.Visible = true;
            imgstar.Visible = true;
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            GrdHeader.Style.Add("display", "none");
            //lblResult.Text = "No matching records found";
            lblResult.Text = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_001 == null ? "No Matching Records Found" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_001;
            Label4.Visible = false;
            imgstar.Visible = false;
        }
        onSearchComplete(this, e);
    }
    public List<String> PatientSearchColumn()
    {

        string[] Str = { "PatientNumber", "Name", "Age", "URNNo", "MobileNumber", "Address" };
        List<String> lstpatient = new List<String>(Str);
        return lstpatient;
    }
    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;

                string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "','" + p.OrgID + "','" + p.PatientVisitID + "','" + p.Name + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                DropDownList ddlVisitActionName = (DropDownList)e.Row.FindControl("ddlVisitActionName");
                List<VisitPurpose> lstvisitpurpose = new List<VisitPurpose>();
                new PatientVisit_BL(base.ContextInfo).GetVisitPurposeName(OrgID, p.PatientVisitID, out lstvisitpurpose);

                if (lstvisitpurpose.Count > 0)
                {
                    if (lstvisitpurpose[0].VisitPurposeID == Convert.ToInt32(TaskHelper.VisitPurpose.BloodDonation))
                    {
                        e.Row.Attributes.Add("onmouserover", "showTooltip(event,BloodDonor);return false;");
                    }
                }
                ((Button)e.Row.Cells[0].FindControl("btnGo")).Attributes.Add("onclick", "return CheckVisitID('" + ((DropDownList)e.Row.Cells[1].FindControl("ddlVisitActionName")).ClientID + "');");
                if (lstActionMaster.Count == 0)
                    GetActionMaster(out lstActionMaster);

                ddlVisitActionName.DataSource = lstActionMaster;
                ddlVisitActionName.DataTextField = "ActionName";
                ddlVisitActionName.DataValueField = "PageURL";
                ddlVisitActionName.DataBind();

                if (OrgID != p.OrgID)
                {
                    e.Row.BackColor = System.Drawing.Color.CornflowerBlue;
                }
                if (Int32.Parse(hdnTrustedlist.Value) > 1)
                {
                    HtmlTableCell tc2 = (HtmlTableCell)tblHeader.FindControl("tdorg");
                    tdorg.Visible = true;
                    HtmlTable Tabchild = (HtmlTable)e.Row.FindControl("TabChild");
                    HtmlTableCell tc3 = (HtmlTableCell)Tabchild.FindControl("tdOrganizationID");
                    tc3.Visible = true;
                }

                bool isPhotoNotExist = true;
                ImageButton imgPatient = (ImageButton)e.Row.Cells[1].FindControl("imgPatient");
                if (!String.IsNullOrEmpty(p.PictureName))
                {
                    string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
                    if (File.Exists(imagePath + p.PictureName))
                    {
                        imgPatient.Visible = true;
                        imgPatient.Attributes.Add("onmouseover", "ShowPicture(this.id,'" + p.PictureName + "')");
                        imgPatient.Attributes.Add("onmouseout", "HidePicture()");
                        isPhotoNotExist = false;
                    }
                }
                if (isPhotoNotExist)
                    imgPatient.Visible = false;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }
    }

    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    string pPatientName = "";
    string pPatientNo = "";

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "History")
            {
                if (e.CommandArgument.ToString() != "")
                {
                    long patientID = -1;
                    int intID = 0;
                    patientID = Convert.ToInt64(e.CommandArgument);
                    if (patientID != -1)
                    {
                        audit_History.ViewAudit_History(patientID, OrgID, "PATSRCH");
                        ModelPopPatientSearch.Show();
                    }
                }
            }
            else
            {
                if (HdnID.Value != string.Empty)
                {
                    if (HdnID.Value != e.CommandArgument.ToString())
                    {
                        int rID = Convert.ToInt32(HdnID.Value);
                        HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                        ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                        imgBTN.ImageUrl = "~/Images/collapse.jpg";
                        Div1.Style.Add("display", "none");
                    }
                }

                if (e.CommandArgument.ToString() != "")
                {
                    int A = 0;
                    ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
                    imgBTN.ImageUrl = "~/Images/expand.jpg";
                    TextBox patientId = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientId");
                    HtmlControl Div = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
                    string[] str = (Div.Attributes["style"].ToString()).Split(';');
                    if (str[0] == "display:block")
                    {
                        Div.Style.Add("display", "none");
                        imgBTN.ImageUrl = "~/Images/collapse.jpg";
                    }
                    else
                    {
                        Div.Style.Add("display", "block");
                        A = A + 2;
                    }
                    if (A != 0)
                    {
                        HdnPID.Value = patientId.Text;
                        int VisitID = 0;
                        GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGrid");
                        returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(patientId.Text), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
                        if (lstPatientVisit.Count != 0)
                        {
                            Button Gobtn = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                            Gobtn.Focus();
                            ChildGrd.DataSource = lstPatientVisit;
                            ChildGrd.DataBind();
                            Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                            DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                            Gobtn1.Visible = true;
                            DrpList.Visible = true;
                            if (ChildGrd.Columns.Count != 0)
                            {
                                List<DynamicColumnMapping> lst = new List<DynamicColumnMapping>();
                                lst = VisitSearchColumn();

                                for (int j = 0; ChildGrd.Columns.Count > j; j++)
                                {
                                    if (lst.Exists(delegate(DynamicColumnMapping x) { return x.SearchColumnName == ChildGrd.Columns[j].HeaderText; }) || ChildGrd.Columns[j].HeaderText == "Select")
                                        ChildGrd.Columns[j].Visible = true;
                                    else
                                        ChildGrd.Columns[j].Visible = false;
                                }
                            }
                            HasResult = true;
                        }
                        else
                        {
                            ChildGrd.DataSource = null;
                            Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                            DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                            Gobtn1.Visible = false;
                            DrpList.Visible = false;
                        }
                        onSearchComplete(this, e);
                    }
                    else
                    {
                        Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        Gobtn1.Visible = false;
                        DrpList.Visible = false;
                    }
                }
                HdnID.Value = e.CommandArgument.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
        }
    }

    public List<DynamicColumnMapping> VisitSearchColumn()
    {
        long returnCode = -1;
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        try
        {
            int VisitSearch = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
            returnCode = new Patient_BL(base.ContextInfo).SearchColumns(VisitSearch, OrgID, out lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SearchColumns", ex);
        }
        return lstColumn;
    }
    public string GetSelectedPatientName()
    {
        string PatientName = string.Empty;
        if (Request.Form["PNAME"] != null && Request.Form["PNAME"].ToString() != "")
        {
            PatientName = Request.Form["pid"].ToString();
        }
        else
        {
            PatientName = hdnPNAME.Value;
        }
        return PatientName;

    }

    public long GetSelectedPatient()
    {
        long patientID = -1;
        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToInt64(Request.Form["pid"]);
        }
        else
        {
            patientID = Convert.ToInt64(hdnTempPatientid.Value);
        }
        return patientID;
    }

    public long GetSelectedVisit()
    {
        long PatientVisitID = -1;
      
           if (hdnVID.Value !="" && hdnVID.Value !=null)
        {
            PatientVisitID = Convert.ToInt64(hdnVID.Value);
        }
        else
        {
            PatientVisitID =-1;
        }
        return PatientVisitID;
    }
    public long GetSelectedPatientID()
    {
        long patientID = -1;
        if (hdnPatientID.Value != "")
        {
            patientID = Convert.ToInt64(hdnPatientID.Value);
        }
        return patientID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public int GetSelectedPatientOrgID()
    {
        int patientOrgID = -1;
        if (patOrgID != null)
        {
            patientOrgID = Convert.ToInt32(patOrgID.Value);
        }
        return patientOrgID;
    }
    public void accessinPatientSearchPage(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    #region Child Grid Activities...........

    public long GetActionMaster(out List<ActionMaster> lstActionMaster)
    {
        IP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
        long returnCode = -1;
        lstActionMaster = new List<ActionMaster>();
        try
        {
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  GetActions", ex);
        }

        return returnCode;
    }
    protected void ChildGrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(HdnID.Value)].FindControl("ChildGrid");
        if (e.NewPageIndex == ChildGrd.PageCount)
        {
            try
            {
                ImageButton ibtnNext = (ImageButton)(ChildGrd.BottomPagerRow.FindControl("lnkNext"));
                if (ibtnNext != null) ibtnNext.Visible = false;
            }
            catch (Exception ex)
            {
                ImageButton ibtnPrev = (ImageButton)(ChildGrd.BottomPagerRow.FindControl("lnkPrev"));
                if (ibtnPrev != null) ibtnPrev.Visible = false;
            }
        }
        if (e.NewPageIndex >= 0)
        {
            int VisitID = 0;
            List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(HdnPID.Value), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
            ChildGrd.PageIndex = e.NewPageIndex;
            ChildGrd.DataSource = lstPatientVisit;
            ChildGrd.DataBind();
        }
    }
    long patientID;
    long pvisitID;
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string Information = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_003 == null ? "Alert" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_003;
        string UsrMsgs = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_002 == null ? "Please select visit detail." : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_002;
        string UsrMsgs1 = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_004 == null ? "Please Proceed via Todays Patient Link" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_004;
        string UsrMsgs3 = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_005 == null ? "This action cannot be performed for New born baby" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_005;
        string UsrMsgs4 = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_006 == null ? "This action can not performed for this Patient Visit" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_006;
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        try
        {
            string pagename = string.Empty;
            returnCode = -1;
            long pBornVisitID = -1;
            if (hdnVID.Value == "")
            {
              //  string sPath = "CommonControls\\\\PatientSearch.ascx.cs_1";
                string sPath = UsrMsgs;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs + "','" + Information + "');", true);

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ");", true);
                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonControls\\PatientSearch.ascx.cs_1").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "alert('" + sUserMsg + "');", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please select visit detail');", true);
                //}
                //return;
            }
            DropDownList DrpName = (DropDownList)grdResult.Rows[Convert.ToInt32(HdnID.Value)].Cells[0].FindControl("ddlVisitActionName");
            returnCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(hdnVID.Value), out pBornVisitID);
            if (hdnVisitDetail.Value == "Print Bill")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=BP&V=Y";
            else if (hdnVisitDetail.Value == "Print CaseSheet")
                pagename = "?vid=" + hdnVID.Value + "&pid=" + patientID + "&pagetype=CP";
            else if (hdnVisitDetail.Value == "Print Consolidate Report")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=CR";
            else if (hdnVisitDetail.Value == "Print Prescription")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=PP";
            else if (hdnVisitDetail.Value == "Dialysis Case Sheet")
                pagename = "?vid=" + hdnVID.Value;
            else if (hdnVisitDetail.Value == "Show Report")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=CPL";
            else if (hdnVisitDetail.Value == "Order Investigation")
                pagename = "?vid=" + hdnVID.Value + " &pid=" + HdnPID.Value + "&pagetype=OI";
            else if (hdnVisitDetail.Value == "Add Bill Items")
                pagename = "?vid=" + hdnVID.Value + " &pid=" + HdnPID.Value + "&pagetype=ABI";
            else if (hdnVisitDetail.Value == "Collect Payments")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=CPay";
            else if (hdnVisitDetail.Value == "Refund to Patient")
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            else if (hdnVisitDetail.Value == "Enter Additional Notes")
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            else if (hdnVisitDetail.Value == "Print Label")
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            else if (hdnVisitDetail.Value == "Consolidated Lab Report")
                pagename = "?vid=" + hdnVID.Value + "&pagetype=CPL";
            else if (hdnVisitDetail.Value == "Print Workup Details")
                pagename = "?pid=" + HdnPID.Value + "&vid=" + hdnVID.Value;
            else if (hdnVisitDetail.Value == "View and Edit Workup Details")
                pagename = "?pid=" + HdnPID.Value + "&vid=" + hdnVID.Value;
            else if (hdnVisitDetail.Value == "View Patient Case Detail")
                pagename = "?pid=" + HdnPID.Value + "&vid=" + hdnVID.Value;
            else if (hdnVisitDetail.Value == "Upload Old Notes")
            {
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Edit Patient History")
            {
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&RePage=PatientSearch";
            }
            else if (hdnVisitDetail.Value == "View/Edit Counseling")
            {
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Print Counseling")
            {
               pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Generate Bill")
            {
                pagename = "?pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Upload File")
            {
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "OPBillSettlement")
            {
                pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Print Merge Bill")
            {
                pagename = "?VID=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            }
            else if (hdnVisitDetail.Value == "Edit Diagnosis")
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
                if (lstPatientComplaintDetail.Count > 1)
                {
                    Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + HdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
                }
                else if (lstPatientComplaintDetail.Count == 1)
                {
                    Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + HdnPID.Value + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + pvisitID + "&tid=" + "0", true);
                }
                else if (lstPatientComplaintDetail.Count == 0)
                {
                    string str1 = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_007 == null ? "The Patient " : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_007;
                    string str2 = Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_008 == null ? "' is yet to be Diagnosed" : Resources.CommonControls_ClientDisplay.CommonControls_PatientSearch_ascx_008;
                    //lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
                    lblResult.Text = str1 + " " + hdnPNAME.Value + str2;
                    return;
                }
            }
            if (hdnVisitDetail.Value == "Collect Consultation Fees")
            {
                string sPath = UsrMsgs1;// "CommonControls\\\\PatientSearch.ascx.cs_2";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ");", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs1 + "','" + Information + "');", true);

                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonControls\\PatientSearch.ascx.cs_2").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "alert('" + sUserMsg + "');", true);
                //}
                //else
                //{
                            
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please Proceed via Todays Patient Link');", true);
                //}
            }
            else if (hdnVisitDetail.Value == "Print Secured Prescription Page")
            {
                string sPath = UsrMsgs1;// "CommonControls\\\\PatientSearch.ascx.cs_2";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ");", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs1 + "','" + Information + "');", true);
                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonControls\\PatientSearch.ascx.cs_3").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "alert('" + sUserMsg + "');", true);
                //}
                //else
                //{
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days2", "javascript:alert('Please Proceed via Todays Patient Link');", true);
                //}
            }
            else if (hdnVisitDetail.Value == "Print HealthPackage CaseSheet")
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value, true);
            }
            else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Edit/Print Discharge Summary")
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
            }
            else if (pBornVisitID == 0 && (hdnVisitDetail.Value == "View/Edit Admission Notes" || hdnVisitDetail.Value == "Edit/Capture Case Sheet"))
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
            }
            else if (pBornVisitID == 0 && hdnVisitDetail.Value == "View/Print Case Sheet")
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + HdnPID.Value + "','OP');", true);
            }
            else if (hdnVisitDetail.Value == "View/Edit Operation Notes")
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);
            }
            else if (pBornVisitID > 0)
            {
                if (hdnVisitDetail.Value == "View/Edit Admission Notes" || hdnVisitDetail.Value == "Edit/Print Discharge Summary")
                {
                    //string sPath = "CommonControls\\\\PatientSearch.ascx.cs_4";
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ");", true);
                    string sPath = UsrMsgs3;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs3 + "','" + Information + "');", true);

                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonControls\\PatientSearch.ascx.cs_4").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "alert('" + sUserMsg + "');", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for New born baby');", true);
                //}
                }
                else if (hdnVisitDetail.Value == "Print Bill")
                {
                    Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

                }
                else if (hdnVisitDetail.Value == "Print Bill")
                {
                    Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

                }
                else if (hdnVisitDetail.Value == "Show Report")
                {
                    Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

                }
                else if (hdnVisitDetail.Value == "Print Neonatal Notes")
                {
                    if (patientID != 0)
                    {
                        HdnPID.Value = patientID.ToString();
                    }
                    Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
                }
            }
            else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Print Neonatal Notes")
            {
                string sPath = UsrMsgs3;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs3 + "','" + Information + "');", true);

                //string sPath = "CommonControls\\\\PatientSearch.ascx.cs_4";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ");", true);
                // string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "CommonControls\\PatientSearch.ascx.cs_4").ToString();
                //if (sUserMsg != null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "alert('" + sUserMsg + "');", true);
                //}
                //else
                //{
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);
                //}

            }
            else if (hdnVisitDetail.Value == "Add Referral / Certificate")
            {
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value.Split('~')[0] + pagename + "?pid=" + HdnPID.Value + "&vid=" + hdnVID.Value, true);
            }
                  else if (hdnVisitDetail.Value == "Print Patient Registration Details")
            {
                PrintNewPatientVisitDetailsXml(Convert.ToInt64(HdnPID.Value), Convert.ToInt64(hdnVID.Value));
            }
            else if (hdnVisitDetail.Value == "Print OP Card")
            {
                PrintExistingPatientVisitDetailsXml (Convert.ToInt64(HdnPID.Value), Convert.ToInt64(hdnVID.Value));
            }
            else if (hdnVisitDetail.Value == "Edit Patient HealthCheck Up")
            {
                if (patientID != 0)
                {
                    HdnPID.Value = patientID.ToString();
                }
                if (hdnIsHealthCheckUp.Value.ToString() == "Y")
                {
                    // ../Patient/PatientEMRPackage.aspx?pid={PatientID}&vid={PatientVisitID}&Flow=HealthScreening
                    Response.Redirect("../Patient/PatientEMRPackage.aspx?pid=" + HdnPID.Value + "&vid=" + hdnVID.Value + "&tid=" + "0" + "&Flow=HealthScreening", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + UsrMsgs4 + "','" + Information + "');", true);

                 //   ScriptManager.RegisterStartupScript(Page, this.GetType(), "HealthCheckUp", "javascript:alert('This action can not performed for this Patient Visit');", true);
                }
            }
          else
            {
                Response.Redirect(Request.ApplicationPath  + DrpName.SelectedItem.Value + pagename, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    string gUID = string.Empty;
   protected void ChildGrid_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
            List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
            List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
            List<InvDeptMaster> deptList1 = new List<InvDeptMaster>();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + HdnPID.Value + "','" + pv.PatientName + "','" + pv.IsAllMedical + "','" + pv.IsMismatchData + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);           
                new Investigation_BL(base.ContextInfo).GetInvestigationSamplesCollect(pv.PatientVisitId, OrgID, Convert.ToInt64(RoleID), gUID, ILocationID,22, out lstPatientInvestigation,
                                            out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample
                                              , out deptList1, out lstSampleContainer);//By Shajahan , out lstorderInv
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(pv.PatientVisitId, ILocationID, OrgID, out lstorderInv);
                if (lstorderInv.Count > 0)
                {
                    string strtemp = GetToolTip(lstorderInv);
                    e.Row.Cells[5].Attributes.Add("onmouseover", "showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[5].Attributes.Add("onmouseout", "hideTooltip();");

                    e.Row.Cells[6].Attributes.Add("onmouseover", "showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[6].Attributes.Add("onmouseout", "hideTooltip();");
                    e.Row.Style.Add("Cursor", "Pointer");
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }
    }
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List</td><td>Reporting Radiologist</td><td>Status</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>";
            TableDate += " <td>" + Item.PerformingPhysicain + "</td>";
            TableDate += " <td>" + Item.Status + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }



    public void LoadSearchTypeMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "CustomPeriodRange,PatientSearchType,OtherSearchCriteria";
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


            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            //if (returncode == 0)
            //{

            string select = Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03;

                // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
				returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "CustomPeriodRange"
                                     select child;
                    ddlRegisterDate.DataSource = childItems;
                    ddlRegisterDate.DataTextField = "DisplayText";
                    ddlRegisterDate.DataValueField = "Code";
                    ddlRegisterDate.DataBind();
                 //   ddlRegisterDate.Items.Insert(0, "--Select--");
                    ddlRegisterDate.Items.Insert(0, select);
                    ddlRegisterDate.Items[0].Value = "-1";

                    var childItems1 = from child in lstmetadataOutput
                                      where child.Domain == "PatientSearchType"
                                      select child;

                    ddlType.DataSource = childItems1;
                    ddlType.DataTextField = "DisplayText";
                    ddlType.DataValueField = "Code";
                    ddlType.DataBind();

                    var childItems2 = from child in lstmetadataOutput
                                      where child.Domain == "OtherSearchCriteria"
                                      select child;

                    ddOthers.DataSource = childItems2;
                    ddOthers.DataTextField = "DisplayText";
                    ddOthers.DataValueField = "Code";
                    ddOthers.DataBind();
                    //ddOthers.Items.Insert(0, "--Select--");
                    ddOthers.Items.Insert(0, select);

                    ddOthers.Items[0].Value = "0";
                }
           
       

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);
          
        }
    }
    #endregion
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
                xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString());
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
                    xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
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

}
