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
using System.Configuration;
using System.IO;
public partial class CommonControls_DaycarePatientSearch : BaseControl
{
    private bool hasResult = false;
    private string strpatientName = "";
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    int IP;
    List<Patient> lstPatient = new List<Patient>();
    List<PatientEpisode> lstPatientEpisode = new List<PatientEpisode>();
    PatientEpisode_BL patientBL;
    string needDischargePat = "N";
    List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
    string roomStatus = string.Empty;
    List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    long rateID = 0;
    [System.ComponentModel.Browsable(false)]
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    public long RateID
    {
        get { return rateID; }
        set { rateID = value; }
    }
    public string DischargeInPatient { get; set; }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new PatientEpisode_BL(base.ContextInfo);

        AutoCompleteProduct.ContextKey = "N";
        if (!IsPostBack)
        {
            txtPatientNo.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            txtPatientName.Attributes.Add("onkeypress", "return ValidateOnlyNumeric(this);");
            txtDOB.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            txtRoomNo.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            txtCellNo.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            txtPatientName.Attributes.Add("onkeypress", "return ValidateOnlyNumeric(this);");
            txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
            txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','ucDaycarePatientSearch_txtFromDate',1,1);");
            AdtxtFromDate.Attributes.Add("onchange", "ExcedDate('" + AdtxtFromDate.ClientID.ToString() + "','',0,0);");
            AdtxtToDate.Attributes.Add("onchange", "ExcedDate('" + AdtxtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + AdtxtToDate.ClientID.ToString() + "','ucDaycarePatientSearch_AdtxtFromDate',1,1);");

            try
            {
                string needIPNo = string.Empty;
                List<Config> lstCon = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out lstCon);
                if (lstCon.Count > 0)
                    needIPNo = lstCon[0].ConfigValue.Trim();
                LoadPurposeOfAdmission();
                IP = Convert.ToInt32(TaskHelper.SearchType.InPatientSearch);
                string PatientNo = string.Empty;
                if (txtPatientNo.Text.Trim() != "")
                {
                    PatientNo = Convert.ToString(txtPatientNo.Text);
                }
                isTrustedOrg();
                string tempfrom = "01/01/1753";
                string fromDate, ToDate;
                DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime wkStDt = DateTime.MinValue;
                DateTime wkEndDt = DateTime.MinValue;
                wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
                wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
                hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
                AdhdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
                hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");
                AdhdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");



                DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
                hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
                AdhdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day
                dateNow = dateNow.AddMonths(1);
                hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day
                AdhdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day


                hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                AdhdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
                AdhdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;




                #region lastmonth
                DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
                hdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
                AdhdnLastMonthFirst.Value = dtlm.AddDays(-(dtlm.Day - 1)).ToString("dd-MM-yyyy");
                dtlm = dtlm.AddMonths(1);
                hdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
                AdhdnLastMonthLast.Value = dtlm.AddDays(-(dtlm.Day)).ToString("dd-MM-yyyy");
                #endregion

                #region lastweek
                DateTime dt1 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime LwkStDt = DateTime.MinValue;
                DateTime LwkEndDt = DateTime.MinValue;
                hdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
                AdhdnLastWeekFirst.Value = dt1.AddDays(-7 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
                hdnLastWeekLast.Value = dt1.AddDays(0 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");
                AdhdnLastWeekLast.Value = dt1.AddDays(0 - Convert.ToDouble(dt1.DayOfWeek)).ToString("dd-MM-yyyy");

                #endregion

                #region lastYear
                DateTime dt2 = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                string tempyear = dt2.AddYears(-1).ToString();
                string[] tyear = new string[5];
                tyear = tempyear.Split('/', '-');
                tyear = tyear[2].Split(' ');
                hdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
                AdhdnLastYearFirst.Value = "01-01-" + tyear[0].ToString();
                hdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
                AdhdnLastYearLast.Value = "31-12-" + tyear[0].ToString();
                #endregion

                string fdate = "01/01/2001 00:00:00";
                fromDate = fdate;
                ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy")).ToString();
                AdtxtFromDate.Text = AdhdnFirstDayWeek.Value;
                AdtxtToDate.Text = AdhdnLastDayWeek.Value;
                ddlAdmissionDate.SelectedValue = "-1";
                this.Page.RegisterStartupScript("strKey", "<script type='text/javascript'> ShowAdmDate(); </script>");
                divAdmDate.Attributes.Add("display", "block");
                //returnCode = patientBL.SearchInPatient("", "", "", "", "", "", "", OrgID, Convert.ToInt32(TaskHelper.SearchType.IP), "", needDischargePat, "", " ", " ", fromDate, ToDate, Convert.ToDateTime(AdtxtFromDate.Text).ToString(), Convert.ToDateTime(AdtxtToDate.Text).ToString(), PageSize, currentPageNo, out totalRows, out lstPatient);
                returnCode = patientBL.SearchEpisodePatient("", "", "", "", "", "", "", "", "", OrgID, 0, "", 0, 10, currentPageNo, "", "", "", Convert.ToDateTime(fromDate), Convert.ToDateTime(ToDate), out lstPatientEpisode);
                //returnCode = patientBL.SearchEpisodePatient(PatientNo, strSmartCardNo, strPatientName, "", "", "", "", "", strCellNo, 78, 0, "", 0, 10, currentPageNo, strNationality, "", ClientID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), Convert.ToDateTime(new BasePage().OrgDateTimeZone), out lstPatientEpisode);

                if (lstPatientEpisode.Count > 0)
                {

                    //GrdFooter.Style.Add("display", "block");
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

                LoadNationality();
                List<TPAMaster> lTpaMaster = new List<TPAMaster>();
                new IP_BL(base.ContextInfo).GetTPAName(OrgID, out lTpaMaster);
                ddlTpaName.DataSource = lTpaMaster;

                ddlTpaName.DataTextField = "TPAName";
                ddlTpaName.DataValueField = "TPAID";
                ddlTpaName.DataBind();
                ddlTpaName.Items.Insert(0, new ListItem("All", "-1"));
                //List<CorporateMaster> lCorpMaster = new List<CorporateMaster>();
                //new IP_BL(base.ContextInfo).GetCorporateMaster(OrgID, out lCorpMaster);

                //if (lCorpMaster.Count > 0)
                //{
                //    ddlCorporate.DataSource = lCorpMaster;
                //    ddlCorporate.DataTextField = "CorporateName";
                //    ddlCorporate.DataValueField = "CorporateID";
                //    ddlCorporate.DataBind();
                //    ddlCorporate.Items.Insert(0, new ListItem("All", "-1"));
                //}
                List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
                new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
                if (Clientmaster.Count > 0)
                {
                    ddlCorporate.DataSource = Clientmaster;
                    ddlCorporate.DataTextField = "ClientName";
                    ddlCorporate.DataValueField = "ClientID";
                    ddlCorporate.DataBind();
                    ddlCorporate.Items.Insert(0, "All");
                    ddlCorporate.Items[0].Value = "0";
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in DaycarePatientSearch.ascx.cs", ex);
            }
            try
            {
                if (returnCode == 0 && lstPatientEpisode.Count > 0)
                {

                    grdResult.Visible = true;
                    lblResult.Visible = false;
                    lblResult.Text = "";
                    grdResult.DataSource = lstPatientEpisode;
                    grdResult.DataBind();
                    HasResult = true;
                    //if (lstPatient[0].IPNumber != null)
                    //{
                    //    lblPatientNumberHeader.Text = "Patient No./IP No.";
                    //}
                    //else { lblPatientNumberHeader.Text = "Patient No."; }


                }
                else
                {
                    HasResult = false;
                    grdResult.Visible = false;
                    lblResult.Visible = true;
                    lblResult.Text = "No matching records found";
                }
                onSearchComplete(this, e);
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in IP Search", ex);
            }
            loadSearch(sender, e);


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
            }
            if (AdhdnTempFrom.Value != "" && AdhdnTempTo.Value != "")
            {
                AdtxtFromDate.Text = AdhdnTempFrom.Value;
                AdtxtToDate.Text = AdhdnTempTo.Value;
                AdtxtFromDate.Attributes.Add("disabled", "true");
                AdtxtToDate.Attributes.Add("disabled", "true");
            }

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
                ddlNationality.Items.Insert(0, new ListItem("--Select--", "0"));
                //selectednationality = lstNationality.Find(FindNationality);
                //ddlNationality.SelectedValue = selectednationality.NationalityID.ToString();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {
        }
    }
    public void loadSearch(object sender, EventArgs pCall)
    {
        string strPatientName = "";
        string strDOB = "";
        string inPatientNo = "";
        string strCellNo = "";
        string strRoomNo = "";
        string strPurpose = "0";
        bool IsTrue = false;

        if (Request.QueryString["SPN"] != null)
        {
            strPatientName = Request.QueryString["SPN"].ToString();
            IsTrue = true;
        }
        if (Request.QueryString["SDOB"] != null)
        {
            strDOB = Request.QueryString["SDOB"].ToString();
            IsTrue = true;
        }
        if (Request.QueryString["SPID"] != null)
        {
            inPatientNo = Request.QueryString["SPID"].ToString();
            IsTrue = true;
        }
        if (Request.QueryString["SCELL"] != null)
        {
            strCellNo = Request.QueryString["SCELL"].ToString();
            IsTrue = true;
        }
        if (Request.QueryString["SR"] != null)
        {
            strRoomNo = Request.QueryString["SR"].ToString();
            IsTrue = true;
        }

        if (Request.QueryString["SPRP"] != null)
        {
            strPurpose = Request.QueryString["SPRP"].ToString();
            IsTrue = true;
        }

        txtPatientName.Text = strPatientName;
        txtDOB.Text = strDOB;
        txtPatientNo.Text = inPatientNo;
        txtCellNo.Text = strCellNo;
        txtRoomNo.Text = strRoomNo;
        purposeOfAdmission.SelectedValue = strPurpose;
        if (IsTrue)
        {
            btnSearch_Click(sender, pCall);
        }
    }
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        IP = Convert.ToInt32(TaskHelper.SearchType.DayCare);
        long returnCode = -1;
        string strPatientName = "";
        string strDOB = "";
        string  PatientNo = "";
        string strCellNo = "";
        string strRoomNo = "";
        string strPurpose = "";
        string ipNo = string.Empty;
        string strNationality = "";
        string TPAID = "";
        string ClientID = "";
        string strSmartCardNo = "";
        if(txtPatientNo.Text.Trim() != "")
        {
            PatientNo = Convert.ToString(txtPatientNo.Text);
        }
        strPatientName = txtPatientName.Text;
        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
        strDOB = txtDOB.Text;
        strRoomNo = txtRoomNo.Text;
        strCellNo = txtCellNo.Text; 
        //ipNo = txtIPNo.Text;
        strSmartCardNo = txtSmartCardNo.Text;
        //StrPatientName = txtPatientName.Text;

        if (purposeOfAdmission.SelectedItem.Text == "----Select----")
        {
            strPurpose = "";
        }
        else
        {
            strPurpose = purposeOfAdmission.SelectedItem.Text;
        }
        if (chkDischarge.Checked == true)
        {
            needDischargePat = "Y";
        }
        else
        {
            needDischargePat = "N";
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
        string tempfrom = "01/01/2001 00:00:00";
        string fromDate, ToDate;
        if (ddlRegisterDate.SelectedItem.Text != "--Select--")
        {
            if ((txtFromDate.Text != "" && txtToDate.Text != ""))
            {

                fromDate = Convert.ToDateTime(txtFromDate.Text).ToString();
                ToDate = Convert.ToDateTime(txtToDate.Text).ToString();

            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                fromDate = Convert.ToDateTime(txtFromPeriod.Text).ToString();
                ToDate = Convert.ToDateTime(txtToPeriod.Text).ToString();
            }
            else if (ddlRegisterDate.SelectedItem.Text == "Today")
            {
                fromDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy")).ToString();
                ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy")).ToString();

            }
            else
            {
                fromDate = Convert.ToDateTime(txtFromDate.Text).ToString("dd-MM-yyyy").ToString();
                ToDate = Convert.ToDateTime(txtToDate.Text).ToString("dd-MM-yyyy").ToString();

            }
        }
        else
        {
            //fromDate = Convert.ToDateTime(tempfrom.ToString());
            //ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
            fromDate = null;
            ToDate = null;

        }


        //To Assign Admission Date..
        //code Start..
        string tempfrom1 = "01/01/2001 00:00:00";
        string AdfromDate1, AdToDate1;
        if (ddlAdmissionDate.SelectedItem.Text != "--Select--")
        {
            if ((AdtxtFromDate.Text != "" && AdtxtToDate.Text != ""))
            {

                AdfromDate1 = Convert.ToDateTime(AdtxtFromDate.Text).ToString();
                AdToDate1 = Convert.ToDateTime(AdtxtToDate.Text).ToString();

            }
            else if (AdtxtFromPeriod.Text != "" && AdtxtToPeriod.Text != "")
            {
                AdfromDate1 = Convert.ToDateTime(AdtxtFromPeriod.Text).ToString();
                AdToDate1 = Convert.ToDateTime(AdtxtToPeriod.Text).ToString();
            }
            else if (ddlAdmissionDate.SelectedItem.Text == "Today")
            {
                AdfromDate1 = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy")).ToString();
                AdToDate1 = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy")).ToString();

            }
            else
            {
                AdfromDate1 = Convert.ToDateTime(AdtxtFromDate.Text).ToString();
                AdToDate1 = Convert.ToDateTime(AdtxtToDate.Text).ToString();
            }
        }
        else
        {

            AdfromDate1 = null;
            AdToDate1 = null;
        }
        //Code End
        try
        {
            DateTime fDate = Convert.ToDateTime("01/01/2001 00:00:00");
            DateTime tDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy")); 
            if(fromDate != null)
            {
                fDate =Convert.ToDateTime(fromDate);
            }
            if (ToDate != null)
            {
                tDate = Convert.ToDateTime(ToDate);
            }

            patientBL = new PatientEpisode_BL(base.ContextInfo);
                returnCode = patientBL.SearchEpisodePatient(PatientNo, strSmartCardNo, strPatientName, "", strDOB, "", "", "", strCellNo, OrgID, 0, "", 0, 10, currentPageNo, strNationality,TPAID, ClientID, fDate, tDate, out lstPatientEpisode);

                if (lstPatientEpisode.Count > 0)
                {

                    //GrdFooter.Style.Add("display", "block");
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
            CLogger.LogError("Error in DaycarePatientSearch.ascx.cs", ex);
        }

        if (returnCode == 0 && lstPatientEpisode.Count > 0)
        {

            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstPatientEpisode;
            grdResult.DataBind();
            HasResult = true;
            //if (lstPatient[0].IPNumber != null)
            //{
            //    lblPatientNumberHeader.Text = "Patient No./IP No.";
            //}
            //else { lblPatientNumberHeader.Text = "Patient No."; }


        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No matching records found";
        }

        //txtPatientNo.Text = "";
        //txtPatientName.Text = "";
        //txtDOB.Text = "";
        //txtRoomNo.Text = "";
        //txtCellNo.Text = "";
        //txtPurpose.Text = "";
        //purposeOfAdmission.SelectedValue = "0";
        onSearchComplete(this, e);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    public void btnSearch_Click(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        LoadGrid(e, currentPageNo, PageSize);

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

    public string StrPatientName
    {
        get
        {
            return txtPatientName.Text;
        }
    }

    public string StrDOB
    {
        get
        {
            return txtDOB.Text;
        }
    }

    public string InPatientNo
    {
        get
        {
            return txtPatientNo.Text;
        }
    }

    public string StrCellNo
    {
        get
        {
            return txtCellNo.Text;
        }
    }

    public string StrRoomNo
    {
        get
        {
            return txtRoomNo.Text;
        }
    }

    public string StrPurpose
    {
        get
        {
            return purposeOfAdmission.SelectedValue;
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {


                Label lblContact = (Label)e.Row.FindControl("lblMobileNumber");
                if (lblContact.Text.StartsWith(",") || lblContact.Text.EndsWith(", "))
                {
                    char[] specialChars = new char[] { ',', ' ' };
                    lblContact.Text = lblContact.Text.Trim(specialChars);
                }

                //Label lblRegDate = (Label)e.Row.FindControl("lblRegDate");
                //if (lblRegDate.Text == "01/01/0001 00:00:00")
                //{
                //    lblRegDate.Text = " - ";
                //}

                PatientEpisode p = (PatientEpisode)e.Row.DataItem;
                string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "','" + p.EpisodeID + "' ,'" + p.PatientVisitId + "' , '" + p.PatientName + "', '" + p.IsCreditBill + "'," + p.RateID  + ");";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                Label lblAddress = (Label)e.Row.FindControl("lblAddress");

                string ReplaceAddress = p.Address.Replace(",,", ",");
                lblAddress.Text = ReplaceAddress.TrimStart(',').TrimEnd(',');


               
                //Label lblBirthDays = (Label)e.Row.FindControl("lblAge");
                //long days = Convert.ToInt64(lblBirthDays.Text == "" ? "0" : lblBirthDays.Text);
                //if (days == 0)
                //{
                //    lblBirthDays.Text = String.Empty;
                //}
                //else if(days ==1)
                //{
                //    lblBirthDays.Text = days+ " year";
                //}
                //else if (days > 1)
                //{
                //    lblBirthDays.Text = days + " years";
                //}

                //if (p.PreAuthAmount == 0)
                //{
                //    Label lblPreAuthAmount = (Label)e.Row.FindControl("lblPreAuthAmount");
                //    lblPreAuthAmount.Text = "";

                //}


                //if (p.IPNumber != null)
                //{
                //    if (p.PatientNumber != null && p.PatientNumber != "")
                //    {
                //        Label PatientNumber = (Label)e.Row.FindControl("lblPatientNumber");
                //        PatientNumber.Visible = true;
                //        Label Seperator = (Label)e.Row.FindControl("lblSeperator");
                //        Seperator.Visible = true;
                //    }
                //    Label IPNumber = (Label)e.Row.FindControl("lblIPNumber");
                //    IPNumber.Visible = true;


                //}
                //else
                //{
                //    Label PatientNumber = (Label)e.Row.FindControl("lblPatientNumber");
                //    PatientNumber.Visible = true;
                //    Label Seperator = (Label)e.Row.FindControl("lblSeperator");
                //    Seperator.Visible = false;
                //    Label IPNumber = (Label)e.Row.FindControl("lblIPNumber");
                //    IPNumber.Visible = false;

                //}

                if (p.IsCreditBill == "Y")
                {
                    //e.Row.BackColor = System.Drawing.Color.Gray;
                    e.Row.CssClass = "grdrows";
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

                //if ((RoleName == "Receptionist" || RoleName == "Administrator"))
                //{
                //    grdResult.Columns[10].Visible = true;
                //}
                //else
                //{
                //    grdResult.Columns[10].Visible = false;
                //}
                //if (DischargeInPatient == "true")
                //{
                //    if ((RoleName == "Receptionist" || RoleName == "Administrator"))
                //    {
                //        grdResult.Columns[12].Visible = true;
                //    }
                //    else
                //    {
                //        grdResult.Columns[12].Visible = false;
                //    }
                //}
                //else
                //{
                //    if ((RoleName == "Receptionist") || (RoleName == "Administrator"))
                //    {
                //        grdResult.Columns[12].Visible = true;
                //    }
                //    else
                //    {
                //        grdResult.Columns[12].Visible = false;
                //    }
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in DaycarePatientSearch Grid", ex);
        }
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {


        GridViewRow row = grdResult.SelectedRow;
        if (e.CommandName == "Discharge")
        {
            long patientID = Convert.ToInt64(e.CommandArgument.ToString());
            string vid = "";
            string sPatientName = "";
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            try
            {
                long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);
                long rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(lstPatientVisit[0].PatientVisitId), out lstBookStatus, out roomStatus);


                if (OrgID == 26)
                {
                    if (roomStatus == "Occupied")
                    {
                        if (lstPatientVisit.Count > 0)
                        {
                            vid = lstPatientVisit[0].PatientVisitId.ToString();
                            sPatientName = lstPatientVisit[0].Name.ToString();
                        }
                        Response.Redirect(@"../InPatient/IPBillSettlement.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed as the Room is not occupied by this patient');", true);

                    }
                }
                else
                {
                    if (lstPatientVisit.Count > 0)
                    {
                        vid = lstPatientVisit[0].PatientVisitId.ToString();
                        sPatientName = lstPatientVisit[0].Name.ToString();
                    }
                    Response.Redirect(@"../InPatient/IPBillSettlement.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                }
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string ta = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in IP Search Discharge", ex);
            }
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {

            grdResult.PageIndex = e.NewPageIndex;
            currentPageNo = grdResult.PageIndex;
            currentPageNo = currentPageNo + 1;
            btnSearch_Click(sender, e);
        }
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
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public long GetSelectedInPatient()
    {
        long patientID = -1;

        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToInt32(Request.Form["pid"]);
        }

        return patientID;
    }
    public long GetSelectedPatientVisit()
    {
        long visitID = -1;
        visitID = Convert.ToInt64(hdnVID.Value.ToString()); 
        //if (Request.Form["VID"] != null && Request.Form["vid"].ToString() != "")
        //{
        //    visitID = Convert.ToInt32(Request.Form["vid"]);
        //}

        return visitID;
    }

    public long GetSelectedPatientRateID()
    {
        long rateID = -1;
        rateID = Convert.ToInt64(hdnRateID.Value.ToString());
        //if (Request.Form["VID"] != null && Request.Form["vid"].ToString() != "")
        //{
        //    visitID = Convert.ToInt32(Request.Form["vid"]);
        //}

        return rateID;
    }
    public string  GetCreditBill()
    {
        string Iscreditbill = string.Empty;
        Iscreditbill = hdniscredit.Value.ToString();
        return hdniscredit.ToString();
    }
    public string GetSelectedPatientNumber()
    {
        string patientID = string.Empty;

        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToString(Request.Form["pid"]);
        }

        return patientID;
        //long patientNumber = -1;
        //if (Request.Form["PNumber"] != null && Request.Form["PNumber"].ToString() != "")
        //{
        //    patientNumber = Convert.ToInt64(Request.Form["PNumber"]);
        //}
        //return patientNumber;
    }
    public void LoadPurposeOfAdmission()
    {
        long retCode = -1;
        PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
        List<PurposeOfAdmission> vPOA = new List<PurposeOfAdmission>();
        retCode = patBL.GetPurposeOfAdmission(OrgID, out vPOA);

        if (retCode == 0)
        {
            purposeOfAdmission.DataSource = vPOA;
            purposeOfAdmission.DataTextField = "PurposeOfAdmissionName";
            purposeOfAdmission.DataValueField = "PurposeOfAdmissionID";
            purposeOfAdmission.DataBind();
            purposeOfAdmission.Items.Insert(0, "----Select----");
            purposeOfAdmission.Items[0].Value = "0";

        }


    }

    public void isTrustedOrg()
    {
        try
        {
            string ShareType = "Clinical View";
            if (Session["isTrustedOrg"] == "YES")
            {
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            }
            else
            {
                TrustedOrgDetails TOD = new TrustedOrgDetails();
                TOD.SharingOrgID = OrgID;
                lstTOD.Add(TOD);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in isTrustedOrg", ex);
        }
    }
}
