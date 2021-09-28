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
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;

public partial class CommonControls_HospitalBillSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    List<PaymentType> lPaymentType = new List<PaymentType>();
    public event EventHandler onSearchComplete;
    long returnCode = 0;
    string strBillNo = "";
    string strPatientName = "";
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    string strPatientNumber = string.Empty;
    string strClientID = string.Empty;
    int iPhysicianID = -1;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    List<BillSearch> billSearch = new List<BillSearch>();
   
    //Added by Perumal on 29 Oct 2011 - Start
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    //Added by Perumal on 29 Oct 2011 - End

    public CommonControls_HospitalBillSearch()
        : base("Billing_HospitalBillSearch_aspx")
    {
    }

  

    /// <summary>
    /// Page_Load
    /// </summary>
    /// <param name="sender">object</param>
    /// <param name="e">EventArgs</param>
    string strLabNo = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04 == null ? "Lab Number" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04;
    string strVisitNo = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04 == null ? "Visit Number" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_04;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "OrgID", "var OrgID= '" + OrgID + "';", true);

        //AutoCompleteProduct.ContextKey = "Y";
        btnGo.Attributes.Add("onclick", "return checkForValues();");
        //txtPatientNumber.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','uctrlBillSearch_txtFromDate',1,1);");
        txtFromPeriod.Attributes.Add("onchange", "ExcedDate('" + txtFromPeriod.ClientID.ToString() + "','',0,0);");
        txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToPeriod.ClientID.ToString() + "','uctrlBillSearch_txtFromPeriod',1,1);");
        //txtHospitalName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        AutoCompleteExtenderRefPhy.ContextKey = "RPH";
        if (!IsPostBack)
        {
            string lsConfigValue = GetConfigValue("SHOWFEESPLIT", OrgID);

            if (lsConfigValue == "Y")
            {
                chkSplit.Style.Add("display", "block");
            }
            else
            {
                chkSplit.Style.Add("display", "none");

            }
            //bindDropDown();
            LoadSearchTypeMetaData();
            LoadLocation();
            #region currentWeek
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(0 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");
            #endregion

            #region currentMonth
            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day
            #endregion

            #region currentYear
            hdnFirstDayYear.Value = "01-01-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            hdnLastDayYear.Value = "31-12-" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year;
            #endregion

            #region lastmonth
            DateTime dtlm = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1);
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

            //to bind grid with today's bills on pageload
            #region Today
            strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            /* Modified by NallaThambi on 16 Oct 2013 - Start
            try
            {
                //Modified by Perumal on 31 Oct 2011 - Start
                //returnCode = patientBL.SearchBillOptionDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, iPhysicianID, OrgID, strPatientNumber, strClientID, out billSearch, PageSize, currentPageNo, out totalRows);
                //hdnRefundstatus.Value = billSearch[0].Refundstatus;
                //LoadGrid(e, currentPageNo, PageSize);
                //Modified by Perumal on 31 Oct 2011 - End
            }
            catch
            {
            }
            if (returnCode == 0 && billSearch.Count > 0)
            {
                grdResult.Visible = true;
                lblResult.Visible = false;
                lblResult.Text = "";
                grdResult.DataSource = billSearch;
                grdResult.DataBind();
                HasResult = true;
            }
            else
            {
                HasResult = false;
                grdResult.Visible = false;
                lblResult.Visible = true;
                lblResult.Text = "No Matching Records Found!";
            }
             Modified by NallaThambi on 16 Oct 2013 - End */

            btnSearch_Click(sender, e); // Modified by NallaThambi on 16 Oct 2013 to bind the data with today's bills on pageload

            onSearchComplete(this, e);
            //List<InvClientMaster> Clientmaster = new List<InvClientMaster>();
            //new Investigation_BL(base.ContextInfo).getOrgClientName(OrgID, out Clientmaster);
            //if (Clientmaster.Count > 0)
            //{
            //    ddlCorporate.DataSource = Clientmaster;
            //    ddlCorporate.DataTextField = "ClientName";
            //    ddlCorporate.DataValueField = "ClientID";
            //    ddlCorporate.DataBind();
            //    ddlCorporate.Items.Insert(0, "All");
            //    ddlCorporate.Items[0].Value = "0";
            //}

        }
            #endregion
        if (IsPostBack)
        {
            if (hdnTempFrom.Value != "" && hdnTempTo.Value != "")
            {
                txtFromDate.Text = hdnTempFrom.Value;
                txtToDate.Text = hdnTempTo.Value;
                txtFromDate.Attributes.Add("disabled", "true");
                txtToDate.Attributes.Add("disabled", "true");
            }

        }

        IsNeedExternalVisitIdWaterMark = GetConfigValue("ExternalVisitIdWaterMark", OrgID);
        if (IsNeedExternalVisitIdWaterMark == "Y")
        {
            defaultText = strLabNo.Trim();
            txtVisitNo.MaxLength = 9;
        }
        else
        {
            defaultText = strVisitNo.Trim();
        }
        txtwatermark();
        if (CID > 0)
        {
            txtClientName.Text = UserName;
            txtClientName.Attributes.Add("disabled", "true");
            hdnClientPortal.Value = "Y";
        }
        else
        {
            hdnClientPortal.Value = "N";
        }

    }
    public void txtwatermark()
    {
        if (txtVisitNo.Text.Trim() != defaultText.Trim())
        {
            txtVisitNo.Attributes.Add("style", "color:black");
        }
        if (txtVisitNo.Text == "")
        {
            txtVisitNo.Text = defaultText;
            txtVisitNo.Attributes.Add("style", "color:gray");
        }
        txtVisitNo.Attributes.Add("onblur", "WaterMark(this,event,'" + defaultText + "');");
        txtVisitNo.Attributes.Add("onfocus", "WaterMark(this,event,'" + defaultText + "');");

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        if (txtVisitNo.Text.Trim() == defaultText.Trim())
        {
            txtVisitNo.Text = "";
        }
        LoadGrid(e, currentPageNo, PageSize);

        //Commented by Perumal on 31 Oct 2011 - this code block was moved to LoadGrid() method

        //long returnCode = -1;

        //int iPhysicianID = -1;
        //List<BillSearch> billSearch = new List<BillSearch>();

        //Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        //strPatientName = txtPatientName.Text;
        //string[] ArrayPName = strPatientName.Split('-');
        //strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();

        //if (ddlRegisterDate.SelectedItem.Text != "--Select--")
        //{
        //    if ((txtFromDate.Text != "" && txtToDate.Text != ""))
        //    {

        //        strBillFromDate = txtFromDate.Text;
        //        strBillToDate = txtToDate.Text;

        //    }
        //    else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
        //    {
        //        strBillFromDate = txtFromPeriod.Text;
        //        strBillToDate = txtToPeriod.Text;
        //    }
        //    else if(ddlRegisterDate.SelectedItem.Text == "Today")
        //    {
        //        strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
        //        strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy"); 
        //    }
        //}
        //else
        //{
        //    strBillFromDate = "";
        //    strBillToDate = "";
        //}

        //strBillNo = txtBillNo.Text;
        //iPhysicianID = Int32.Parse(ddlPhysician.SelectedValue);
        //strPatientNumber = txtPatientNumber.Text;
        //strClientID = ddlCorporate.SelectedItem.Value;
        //if (strClientID == "0")
        //{
        //    strClientID = "";
        //}
        //try
        //{
        //    //Modified by Perumal on 29 Oct 2011 - Start
        //    returnCode = patientBL.SearchBillOptionDetails(strBillNo, strBillFromDate,strBillToDate, strPatientName, iPhysicianID, OrgID,strPatientNumber,strClientID, out billSearch, PageSize, currentPageNo);
        //    //Modified by Perumal on 29 Oct 2011 - End
        //}
        //catch
        //{
        //}
        //if (returnCode == 0 && billSearch.Count > 0)
        //{
        //    grdResult.Visible = true;
        //    lblResult.Visible = false;
        //    lblResult.Text = "";
        //    grdResult.DataSource = billSearch;
        //    grdResult.DataBind();
        //    HasResult = true;
        //}
        //else
        //{
        //    HasResult = false;
        //    grdResult.Visible = false;
        //    lblResult.Visible = true;
        //    lblResult.Text = "No Matching Records Found!";
        //}
        //onSearchComplete(this, e);
        txtwatermark();
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
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillSearch bs = (BillSearch)e.Row.DataItem;
                if (bs.IsCreditBill == "Y")
                {
                    e.Row.CssClass = "ClientBill";
                    e.Row.Cells[1].ToolTip = "Credit Patient";
                    e.Row.Cells[2].ToolTip = "Credit Patient";
                    e.Row.Cells[3].ToolTip = "Credit Patient";
                    e.Row.Cells[4].ToolTip = "Credit Patient";
                    e.Row.Cells[5].ToolTip = "Credit Patient";
                    e.Row.Cells[6].ToolTip = "Credit Patient";
                    e.Row.Cells[7].ToolTip = "Credit Patient";
                }
                if (bs.Refundstatus == "CANCELLED")
                    bs.Status = "CANCELLED";
                //Done by Arivu                                                                                                                                                                                                                                                                                                                                                         
                string strScript = "javascript:SelectedBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','"
                    + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.Name.Replace("'","") + "','" + bs.PatientNumber + "','"
                    + bs.BillID + "', '" + bs.Status + "','" + bs.BillNumber + "','" + bs.MembershipCardNo + "','" + bs.Type + "','" + bs.Age + "','" + bs.Refundstatus
                    + "');javascript:SelectBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','"
                    + bs.BillID + "','" + bs.BillNumber + "', '" + bs.Refundstatus + "','" + bs.VisitType + "','"
                    + bs.IsCreditBill + "','" + bs.VisitState + "','" + bs.CollectionType + "','" + bs.AmountReceived
                    + "','" + Convert.ToDecimal(bs.ClientName) + "','" + Convert.ToDecimal(bs.Amount) + "','"
                    + bs.IsCoPaymentBill + "','" + bs.IsTransfered + "');javascript:SelectType('" + bs.Type + "')";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", "SelectBillNo('','1');");

                if (bs.Status == "CANCELLED" || bs.Refundstatus == "CANCELLED")
                {
                    //e.Row.BackColor = System.Drawing.Color.LimeGreen;
                    e.Row.CssClass = "CancelBill";

                    e.Row.Cells[1].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[2].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[3].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[4].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[5].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[6].ToolTip = "This bill has been cancelled";
                    e.Row.Cells[7].ToolTip = "This bill has been cancelled";
                }
                if (bs.RefOrgName != "" && bs.RefOrgName != null)
                {
                    //e.Row.BackColor = System.Drawing.Color.LimeGreen;
                    e.Row.CssClass = "InvoiceBill";
                }
                Label btnRowCommand = (Label)e.Row.FindControl("lblEdit");
                string ConfigRolID = GetConfigValue("HideFieldInEditBill", OrgID);
                BaseClass bc = new BaseClass();
                int currentroleid = bc.RoleID;
                if (ConfigRolID == Convert.ToInt32(currentroleid).ToString())
                {
                    btnRowCommand.Visible = false;
                }
                string Restrictdiffday = GetConfigValue("Restrictbills", OrgID);
                if (Restrictdiffday == "Y" && bs.Age == "N")
                {
                    btnRowCommand.Visible = false;
                }
                btnRowCommand.Attributes.Add("onclick", "ChangePaymentModes('" + bs.BillID + "','" + bs.PatientID + "','" + bs.PatientVisitId + "','" + bs.PatientNumber + "','" + bs.BillNumber + "','" + OrgID + "','" + bs.ClientID + "','" + bs.Name + "','" + bs.AmountReceived + "');");


            }
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
        }
        catch (Exception Ex)
        {
            //report error
        }
    }

    public string GetSelectedBill()
    {
        string BillID = "";
        if (Request.Form["bid"] != null && Request.Form["bid"].ToString() != "")
        {
            BillID = Convert.ToString(Request.Form["bid"]);
        }
        return BillID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - Start
            currentPageNo = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - End
            btnSearch_Click(sender, e);
        }
    }
    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        List<Role> lstUserRole = new List<Role>();
    //        string path = string.Empty;
    //        Role role = new Role();
    //        role.RoleID = RoleID;
    //        lstUserRole.Add(role);
    //        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
    //        Response.Redirect(Helper.GetAppName() + path, true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //}

    #region BindPhysicians
    //public void bindDropDown()
    //{

    //    Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
    //    List<Physician> lstPhysician = new List<Physician>();
    //    PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
    //    var lstphy = (from phy in lstPhysician select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
    //    ddlPhysician.DataSource = lstphy;
    //    ddlPhysician.DataTextField = "PhysicianName";
    //    ddlPhysician.DataValueField = "PhysicianID";
    //    ddlPhysician.DataBind();
    //    ddlPhysician.Items.Insert(0, new ListItem("--All--", "-1"));


    //}
    #endregion


    //Added by Perumal on 31 Oct 2011 - Start
    protected void btnPrevious_Click(object sender, EventArgs e)
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
    protected void btnNext_Click(object sender, EventArgs e)
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
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }

    string strNoRecord = Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_02 == null ? "No matching records found" : Resources.Billing_AppMsg.Billing_HospitalBillSearch_aspx_02;
    string strSelect = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_02 == null ? "--Select--" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_02;
    string strToday = Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_03 == null ? "Today" : Resources.Billing_ClientDisplay.Billing_HospitalBillSearch_aspx_03;
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            long returnCode = -1;
            trlegend.Style.Add("display", "table-row");
            int iPhysicianID = -1;
            List<BillSearch> billSearch = new List<BillSearch>();

            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            strPatientName = txtPatientName.Text;
            string[] ArrayPName = strPatientName.Split('-');
            strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
            string VisitNumber = string.Empty;
            int LocationID = Convert.ToInt32(ddlocations.SelectedValue);
            if (ddlRegisterDate.SelectedItem.Text != strSelect.Trim())
            {
                if ((txtFromDate.Text != "" && txtToDate.Text != ""))
                {

                    strBillFromDate = txtFromDate.Text;
                    strBillToDate = txtToDate.Text;

                }
                else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
                {
                    strBillFromDate = txtFromPeriod.Text;
                    strBillToDate = txtToPeriod.Text;
                }
                else if (ddlRegisterDate.SelectedItem.Text.ToLower() == strToday.Trim().ToLower())
                {
                    strBillFromDate = OrgTimeZone;
                    strBillToDate = OrgTimeZone;
                }
            }
            else
            {
                strBillFromDate = "";
                strBillToDate = "";
            }

            strBillNo = txtBillNo.Text;
            if (hdnPhysicianID.Value != "0")
            {
                iPhysicianID = Convert.ToInt32(hdnPhysicianID.Value.Split('^')[1]);
            }
            strPatientNumber = txtPatientNumber.Text;
            if (CID > 0)
            {
                strClientID = CID.ToString();
            }
            else
            {
                strClientID = (hdnClientID.Value.Split('|')[0]).ToString();
            }
            VisitNumber = txtVisitNo.Text;
            string BarcodeNumber = String.Empty;
            try
            {
                returnCode = patientBL.SearchBillOptionDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, iPhysicianID, OrgID, strPatientNumber, strClientID, VisitNumber, BarcodeNumber, "", out billSearch, PageSize, currentPageNo, out totalRows, LocationID);
            }
            catch
            {
            }

            if (billSearch.Count > 0)
            {
                GrdFooter.Style.Add("display", "table-row");
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
            }
            else
                GrdFooter.Style.Add("display", "none");

            if (returnCode == 0 && billSearch.Count > 0)
            {
                grdResult.Visible = true;
                lblResult.Visible = false;
                lblResult.Text = "";
                grdResult.DataSource = billSearch;
                grdResult.DataBind();
                HasResult = true;
                ////////GrdHeader.Style.Add("display", "block");
                ////////Label4.Visible = true;
                ////////imgstar.Visible = true;
            }
            else
            {
                HasResult = false;
                grdResult.Visible = false;
                lblResult.Visible = true;
                ////////GrdHeader.Style.Add("display", "none");
                lblResult.Text = strNoRecord.Trim();
                trlegend.Style.Add("display", "none");
                ////////Label4.Visible = false;
                ////////imgstar.Visible = false;
            }

            onSearchComplete(this, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
        //Added by Perumal on 31 Oct 2011 - End

    }

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

    //Added by Perumal on 31 Oct 2011 - End


    public void LoadSearchTypeMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "CustomPeriodRange,";
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
                /*Modified by Nallathambi on 16 Oct 2013  Start*/
                //ddlRegisterDate.Items.Insert(0, "--Select--");
                //ddlRegisterDate.Items[0].Value = "-1";
                ddlRegisterDate.SelectedValue = "4"; //set Default Date is Today's Date
                /*Modified by Nallathambi on 16 Oct 2013  END*/
            }
            //}


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

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

    protected void Update_Click(object sender, EventArgs e)
    {
        string strAlert = Resources.CommonControls_ClientDisplay.CommonControls_HospitalBillSearch_ascx_07 == null ? "Alert" : Resources.CommonControls_ClientDisplay.CommonControls_HospitalBillSearch_ascx_07;

        string strUpdate = Resources.CommonControls_AppMsg.CommonControls_HospitalBillSearch_ascx_06 == null ? "Paymentmode is updated successfully" : Resources.CommonControls_AppMsg.CommonControls_HospitalBillSearch_ascx_06;
        try
        {
            long returCode = -1;
            long finalBillID = -1;
            // decimal serviceCharge = 0;
            // decimal TotalAmt;
            string bankName = string.Empty;
            //int TypeID = 0;
            List<AmountReceivedDetails> amtDetails = new List<AmountReceivedDetails>();
            AmountReceivedDetails eAmt = new AmountReceivedDetails();
            //TextBox txtamt = (TextBox)PaymentTypeDetails1.FindControl("txtAmount");
            //DropDownList ddltype = (DropDownList)PaymentTypeDetails1.FindControl("ddlPaymentType");
            //TextBox txtBankname  = (TextBox)PaymentTypeDetails1.FindControl("txtBankType");
            //TextBox txtNumber = (TextBox)PaymentTypeDetails1.FindControl("txtNumber");
            //TextBox txtChDate = (TextBox)PaymentTypeDetails1.FindControl("txtDate");
            //TextBox txtServiceCharge = (TextBox)PaymentTypeDetails1.FindControl("txtServiceCharge");
            //TextBox txtCardHolderName = (TextBox)PaymentTypeDetails1.FindControl("txtCardHolderName");

            //eAmt.AmtReceivedID = Convert.ToInt64(hdnAmtReceivedID.Value);
            //eAmt.AmtReceived = txtamt.Text == "" ? 0 : Convert.ToDecimal(txtamt.Text);
            //TypeID = Convert.ToInt16(ddltype.SelectedValue.Split('~')[0]);
            //eAmt.TypeID = TypeID;
            //eAmt.BankNameorCardType = txtBankname.Text;
            //eAmt.ChequeorCardNumber = txtNumber.Text;
            //eAmt.ServiceCharge = txtServiceCharge.Text == "" ? 0 : Convert.ToDecimal(txtServiceCharge.Text);
            //eAmt.CardHolderName = txtCardHolderName.Text;
            //amtDetails.Add(eAmt);

            Decimal TotalAmtreceived = 0;
            Decimal EditPaymentAmt = 0;

            if (HdnEditPaymentAmt.Value != "" && HdnEditPaymentAmt.Value != "0")
            {
                EditPaymentAmt = Convert.ToDecimal(HdnEditPaymentAmt.Value);
            }
            if (HdnTotalAmtreceived.Value != "" && HdnTotalAmtreceived.Value != "0")
            {
                TotalAmtreceived = Convert.ToDecimal(HdnTotalAmtreceived.Value);
            }
            if (EditPaymentAmt == TotalAmtreceived && TotalAmtreceived!=0 && EditPaymentAmt!=0 )
            {
                finalBillID = Convert.ToInt64(hdnFinalBillId.Value);
                decimal chkAmt = amtDetails.Sum(p => p.AmtReceived);
                finalBillID = Convert.ToInt64(hdnFinalBillId.Value);
                DataTable dt = new DataTable();
                UpdateAmountReceivedDetails(out dt);
                returCode = new BillingEngine(base.ContextInfo).UpdateAmountReceivedDetails(finalBillID, dt);
                PaymentTypeDetails1.Refresh = true;
                ScriptManager.RegisterStartupScript(this, this.GetType(), "BulkRatecardUpdate", "javascript:ValidationWindow('" + strUpdate + "','" + strAlert + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.Page.GetType(), "scrAlert", "javascript:alert('Paymentmode is updated successfully');", true);
                ScriptManager.RegisterStartupScript(Page, this.Page.GetType(), "scrAlert", "javascript:CancelPopup();", true);
                //Response.Redirect(Request.ApplicationPath + "/Billing/HospitalBillSearch.aspx", true);
            }
            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.Page.GetType(), "scrAlert", "javascript:alert('Amount Entered is greater than bill amount');", true);
            //    PaymentTypeDetails1.Refresh = true;
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in update amount received details", ex);
        }
    }
    public void UpdateAmountReceivedDetails(out DataTable dt)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        HiddenField hdfPaymentType = (HiddenField)PaymentTypeDetails1.FindControl("hdfPaymentType");
        //HiddenField hdnBaseCurrencyID = (HiddenField)PaymentTypeDetails1.FindControl("hdnBaseCurrencyID");
        //HiddenField hdnOtherCurrencyID = (HiddenField)PaymentTypeDetails1.FindControl("hdnOtherCurrencyID");
        //HiddenField hdnIsEMI = (HiddenField)PaymentTypeDetails1.FindControl("hdnIsEMI");

        System.Data.DataTable _datatable = new System.Data.DataTable();
        _datatable.Columns.Add("AmtReceivedID", typeof(System.Int64));
        _datatable.Columns.Add("AmtReceived", typeof(System.Decimal));
        _datatable.Columns.Add("TypeID", typeof(System.Int32));
        _datatable.Columns.Add("ChequeorCardNumber", typeof(System.String));
        _datatable.Columns.Add("BankNameorCardType", typeof(System.String));
        _datatable.Columns.Add("Remarks", typeof(System.String));
        _datatable.Columns.Add("ChequeValidDate", typeof(System.DateTime));
        _datatable.Columns.Add("ServiceCharge", typeof(System.Decimal));
        _datatable.Columns.Add("BaseCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("PaidCurrencyID", typeof(System.Int32));
        _datatable.Columns.Add("OtherCurrencyAmount", typeof(System.Decimal));
        _datatable.Columns.Add("EMIOpted", typeof(System.String));
        _datatable.Columns.Add("EMIROI", typeof(System.Decimal));
        _datatable.Columns.Add("EMITenor", typeof(System.Int32));
        _datatable.Columns.Add("EMIValue", typeof(System.Decimal));
        _datatable.Columns.Add("ReferenceID", typeof(System.Int64));
        _datatable.Columns.Add("ReferenceType", typeof(System.String));
        _datatable.Columns.Add("Units", typeof(System.Int32));
        _datatable.Columns.Add("CardHolderName", typeof(System.String));
        _datatable.Columns.Add("CashGiven", typeof(System.Decimal));
        _datatable.Columns.Add("BalanceGiven", typeof(System.Decimal));
        _datatable.Columns.Add("ModifiedBy", typeof(System.Int64));

        DataRow _datarow;
        List<AmountReceivedDetails> amtDetails = new List<AmountReceivedDetails>();


        if (hdfPaymentType.Value != null)
            prescription = hdfPaymentType.Value.ToString();

        string sNewDatas = "";
        sNewDatas = prescription;

        foreach (string row in sNewDatas.Split('|'))
        {
            AmountReceivedDetails eAmt = new AmountReceivedDetails();
            if (row.Trim().Length != 0)
            {
                AmountReceivedDetails amtReceived = new AmountReceivedDetails();
                _datarow = _datatable.NewRow();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    //"RID^" + 0 + "~PaymentNAME^" + PaymentName + "~PaymentAmount^" + PaymentAmount + "~PaymenMNumber^" + PaymentMethodNumber + "~PaymentBank^" + PaymentBankType + "~PaymentRemarks^" + PaymentRemarks + "~PaymentTypeID^" + PaymentTypeID + "";
                    // RID^0~PaymentNAME^Debit Card~PaymentAmount^5000.00~PaymenMNumber^1212121~PaymentBank^sdksdsk~PaymentRemarks^~PaymentTypeID^3~ServiceCharge^1.50~TotalAmount^5075.00
                    switch (colName)
                    {
                        //case "TotalAmount":
                        ///Table Header PaymentAmount is interchanged to OtherCurrAmt
                        /// Table Value AmtReceived is interchanged to OtherCurrencyAmount
                        /// Modi By: Kutti  A
                        /// 28/12/2010
                        /// 
                        /// AmtReceivedID




                        case "PaymentAmount":
                            colValue = (colValue == "" ? "0" : colValue);

                            _datarow["OtherCurrencyAmount"] = Convert.ToDecimal(colValue);
                            break;
                        case "PaymenMNumber":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["ChequeorCardNumber"] = (colValue);
                            break;
                        case "PaymentBank":
                            _datarow["BankNameorCardType"] = colValue;
                            break;
                        case "PaymentRemarks":
                            _datarow["Remarks"] = colValue;
                            break;
                        case "PaymentTypeID":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["TypeID"] = Convert.ToInt32(colValue);
                            break;
                        case "ChequeValidDate":
                            colValue = colValue == "" ? Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString() : colValue;
                            _datarow["ChequeValidDate"] = Convert.ToDateTime(colValue);
                            break;
                        case "ServiceCharge":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ServiceCharge"] = Convert.ToDecimal(colValue);
                            break;
                        case "OtherCurrAmt":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["AmtReceived"] = Convert.ToDecimal(colValue);
                            break;
                        case "EMIROI":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMIROI"] = Convert.ToDecimal(colValue);
                            break;

                        case "EMITenor":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMITenor"] = Convert.ToInt16(colValue);
                            break;
                        case "EMIValue":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["EMIValue"] = Convert.ToDecimal(colValue);
                            break;
                        case "ReferenceID":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["ReferenceID"] = Convert.ToInt64(colValue);
                            break;
                        case "ReferenceType":
                            _datarow["ReferenceType"] = colValue;
                            break;
                        case "Units":
                            colValue = colValue == "" ? "0" : colValue;
                            _datarow["Units"] = Convert.ToInt32(colValue);
                            break;
                        case "CardHolderName":
                            _datarow["CardHolderName"] = colValue;
                            break;
                        case "AmtReceivedID":
                            colValue = (colValue == "" ? "0" : colValue);
                            _datarow["AmtReceivedID"] = Convert.ToDecimal(colValue);
                            break;
                    };
                    _datarow["EMIOpted"] = "Y";
                    //if (hdnIsEMI.Value == "Y")
                    //{
                    //    _datarow["EMIOpted"] = "Y";
                    //}
                    //else
                    //{
                    //    _datarow["EMIOpted"] = "N";
                    //}
                    _datarow["BaseCurrencyID"] = 63;
                    _datarow["PaidCurrencyID"] = 63;
                    _datarow["CashGiven"] = 0;
                    _datarow["BalanceGiven"] = 0;
                    _datarow["ModifiedBy"] = ContextInfo.LoginID;

                }
                _datatable.Rows.Add(_datarow);
            }
        }
        dt = _datatable;
        ///return _datatable;
    }
    /*Added By Nallathambi Bind the Locations in ddlocations  */
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
        ddlocations.SelectedValue = Convert.ToString(ILocationID);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtVisitNo.Text = "";
        txtwatermark();
        txtPatientNumber.Text = "";
        txtBillNo.Text = "";
        txtPatientName.Text = "";
        txtClientName.Text = "";
        txtInternalExternalPhysician.Text = "";
        ddlocations.SelectedValue = Convert.ToString(ILocationID);
        ddlRegisterDate.SelectedIndex = 4;
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "LoadDate", "clearvalue();", true);
        LoadGrid(e, currentPageNo, PageSize);
    }
    public string CheckType
    {
        set { hdnChecklist.Value = value; }
        get { return hdnChecklist.Value; }
    }

}
