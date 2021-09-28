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
public partial class CommonControls_ReceiptSearch : BaseControl
{
    public CommonControls_ReceiptSearch()
        : base("CommonControls_ReceiptSearch_ascx")
    {
    }

    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long returnCode = 0;
    int PageNo = 1;
    int Page_Count = 20;
    int total_rows = -1;
    int totalpage = 0;
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

    #region "Common Resource Property"

    string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_ReceiptSearch_ascx_01 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_ReceiptSearch_ascx_01;

    #endregion

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadMeatData();
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtHospitalName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        //txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        if (!IsPostBack)
        {
            btnGo1.Attributes.Add("onclick", "return checkForValues();");
            bindDropDown();
            //txtBillDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtFromPeriod.Attributes.Add("onchange", "ExcedDate('" + txtFromPeriod.ClientID.ToString() + "','',0,0);");
            txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToPeriod.ClientID.ToString() + "','uctrlBillSearch_txtFromPeriod',1,1);");

            #region currentweek
            DateTime dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime wkStDt = DateTime.MinValue;
            DateTime wkEndDt = DateTime.MinValue;
            wkStDt = dt.AddDays(1 - Convert.ToDouble(dt.DayOfWeek));
            wkEndDt = dt.AddDays(7 - Convert.ToDouble(dt.DayOfWeek));
            hdnFirstDayWeek.Value = wkStDt.ToString("dd-MM-yyyy");
            hdnLastDayWeek.Value = wkEndDt.ToString("dd-MM-yyyy");
            #endregion

            #region currentmont
            DateTime dateNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone); //create DateTime with current date                  
            hdnFirstDayMonth.Value = dateNow.AddDays(-(dateNow.Day - 1)).ToString("dd-MM-yyyy"); //first day 
            dateNow = dateNow.AddMonths(1);
            hdnLastDayMonth.Value = dateNow.AddDays(-(dateNow.Day)).ToString("dd-MM-yyyy"); //last day
            #endregion

            #region current year
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

            btnSearch_Click(sender, e);
        }
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

    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "CustomPeriodRange,ReceiptType";
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
                var CustomPeriodRange = from child in lstmetadataOutput
                                        where child.Domain == "CustomPeriodRange"
                                        select child;
                if (CustomPeriodRange.Count() > 0)
                {
                    ddlRegisterDate.DataSource = CustomPeriodRange;
                    ddlRegisterDate.DataTextField = "DisplayText";
                    ddlRegisterDate.DataValueField = "DisplayText";
                    ddlRegisterDate.DataBind();
                    ddlRegisterDate.SelectedValue = "Year(s)";
                    ddlRegisterDate.Items.Insert(0, strSelect);
                }
                var ReceiptType = from child in lstmetadataOutput
                                  where child.Domain == "ReceiptType"
                                  select child;
                if (ReceiptType.Count() > 0)
                {
                    ddlReceiptType.DataSource = ReceiptType;
                    ddlReceiptType.DataTextField = "DisplayText";
                    ddlReceiptType.DataValueField = "Code";
                    ddlReceiptType.DataBind();
                    ddlReceiptType.SelectedValue = strSelect;
                    //ddlReceiptType.Items.Insert(0, strSelect);
                }


            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }


    #endregion
    #region "Events"
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            PageNo = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            PageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = PageNo.ToString();
            btnSearch_Click(sender, e);
        }
        else
        {
            PageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = PageNo.ToString();
            btnSearch_Click(sender, e);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            PageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = PageNo.ToString();
            btnSearch_Click(sender, e);
        }
        else
        {
            PageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = PageNo.ToString();
            btnSearch_Click(sender, e);
        }
        txtpageNo.Text = "";

    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        PageNo = Int32.Parse(hdnCurrent.Value);
        btnSearch_Click(sender, e);
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        string strNoRecordFound = Resources.CommonControls_ClientDisplay.CommonControls_ReceiptSearch_ascx_02 == null ? "No Matching Records Found!" : Resources.CommonControls_ClientDisplay.CommonControls_ReceiptSearch_ascx_02;
        returnCode = -1;
        string strBillNo = "";
        string strPatientName = "";
        string strPatientNo = "";

        txtpageNo.Text = "";
        hdnCurrent.Value = "";

        List<BillSearch> billSearch = new List<BillSearch>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strPatientName = txtPatientName.Text;
        strPatientNo = txtPatientNo.Text;
        string strBillFromDate = string.Empty;
        string strBillToDate = string.Empty;
        strBillNo = txtBillNo.Text;
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
            else if (ddlRegisterDate.SelectedItem.Text == "Today")
            {
                strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
                strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            }
        }
        else
        {
            strBillFromDate = "";
            strBillToDate = "";
        }
        int pType = -1;
        //if (ddlReceiptType.SelectedItem.Value == "0")
        //{
        //    pType = 0;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "1")
        //{
        //    pType = 1;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "2")
        //{
        //    pType = 2;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "3")
        //{
        //    pType = 3;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "4")
        //{
        //    pType = 4;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "6")
        //{
        //    pType = 6;
        //}
        //if (ddlReceiptType.SelectedItem.Value == "7")
        //{
        //    pType = 7;
        //}
        pType = Convert.ToInt32(ddlReceiptType.SelectedItem.Value);
        string VisitID = string.Empty;
        if (pType == 0 && Request.QueryString["VID"] != null && strPatientName == "" && strPatientNo == "" && strBillNo == "" && strBillToDate == "")
        {
            pType = 5;
            VisitID = Request.QueryString["VID"];
        }
        try
        {
            int Page_index = PageNo - 1;

            returnCode = patientBL.SearchReceiptDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, strPatientNo, OrgID, pType, VisitID, Page_index, Page_Count, out total_rows, out billSearch);
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


            GrdFooter.Style.Add("display", "block");
            totalpage = total_rows;
            lblTotal.Text = CalculateTotalPages(total_rows).ToString();


            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = PageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                PageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (PageNo == 1)
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

                if (PageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = strNoRecordFound.Trim();
            GrdFooter.Style.Add("display", "none");
        }
        onSearchComplete(this, e);
    }

 
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillSearch bs = (BillSearch)e.Row.DataItem;
                //SelectedReceiptNo(dAmount, dDate, dReceiptNo, PNAME,ddetid,dpatid,dvisitid,sType)
                HtmlInputCheckBox chkDuplicate = (HtmlInputCheckBox)e.Row.FindControl("chkDuplicate");
                if (bs.Status == "DEPOSIT")
                {
                    string strScript = "SelectedReceiptNo('" + bs.Amount
                        + "','" + bs.BillDate
                        + "','" + bs.BillNumber
                        + "','" + bs.Name
                        + "','" + bs.PatientNumber
                        + "','" + bs.PaymentDetailsID
                        + "','" + bs.PatientID
                        + "','" + bs.PatientVisitId
                        + "','" + bs.Status // Status Referred as FeeTye
                        + "','" + bs.BilledBy
                        + "','" + 0
                        + "','" + chkDuplicate.ClientID
                        + "');return false;";
                    ((HtmlInputButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                }
                else if (bs.Status.ToUpper() == "CASH IN FLOW")
                {
                    string strScript = "PrintSelectedReceiptNo('" + bs.BillNumber + "');return false;";
                    ((HtmlInputButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                }
                else
                {
                    string strScript = "SelectedPaymentReceiptNo('" + bs.Amount
                    + "','" + bs.BillDate
                    + "','" + bs.BillNumber
                    + "','" + bs.Name
                    + "','" + bs.PatientNumber
                    + "','" + bs.PaymentDetailsID
                    + "','" + bs.PatientID
                    + "','" + bs.PatientVisitId
                    + "','" + bs.Status // Status Referred as FeeTye
                    + "','" + bs.BilledBy
                    + "','" + 0
                     + "','" + chkDuplicate.ClientID
                    + "');return false;";
                    ((HtmlInputButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                }


                HyperLink hlink = (HyperLink)e.Row.FindControl("lnkID");
                if (bs.VisitState.ToUpper() == "DISCHARGED")
                {
                    string SelectReceiptPatientDischarged = "javascript:SelectReceiptPatientDischarged('" + ((HyperLink)e.Row.FindControl("lnkID")).ClientID + "');";
                    ((HyperLink)e.Row.FindControl("lnkID")).Attributes.Add("onclick", SelectReceiptPatientDischarged);
                    //e.Row.CssClass = "grdrows";
                    e.Row.Style.Add("cursor", "pointer");

                }

                if (bs.Status.ToUpper() == "IPPAYMENTS" && bs.VisitState.ToUpper() != "DISCHARGED")
                {
                    hlink.NavigateUrl = "../Patient/ReceiptRefundtoPatient.aspx?vid=" + bs.PatientVisitId + "&pid=" + bs.PatientID + "&pname=" + bs.Name + "&PNumber=" + bs.PatientNumber + "&interPayId=" + bs.PaymentDetailsID + "&receiptType=" + bs.Status + "&btype=RFD" + "&bid=" + bs.BillID;
                    e.Row.ToolTip = "Payment Receipt";
                }
                if (bs.Status.ToUpper() == "DEPOSIT")
                {
                    hlink.NavigateUrl = "../Billing/DepositRefund.aspx?PID=" + bs.PatientID + "&DID=" + 0;
                    e.Row.ToolTip = "Deposit Receipt";
                    e.Row.Style.Add("Cursor", "Pointer");
                }
                if (bs.Status.ToUpper() == "ADVANCE")
                {
                    string SelectedAdvance = "javascript:SelectAdvance('" + ((HyperLink)e.Row.FindControl("lnkID")).ClientID + "');";
                    ((HyperLink)e.Row.FindControl("lnkID")).Attributes.Add("onclick", SelectedAdvance);
                    e.Row.ToolTip = "Advance Receipt";
                    e.Row.Style.Add("Cursor", "Pointer");

                }
                if (bs.Status.ToUpper() == "COPAYMENT")
                {
                    string SelectedAdvance = "javascript:SelectCopayment('" + ((HyperLink)e.Row.FindControl("lnkID")).ClientID + "');";
                    ((HyperLink)e.Row.FindControl("lnkID")).Attributes.Add("onclick", SelectedAdvance);
                    e.Row.CssClass = "grdrows";
                    e.Row.ToolTip = "Co Payment Receipt";
                    e.Row.Style.Add("Cursor", "Pointer");
                }
            }
            if ((RoleName == "Receptionist") || (RoleName == "Reception"))
            {
                e.Row.Cells[6].Visible = false;
            }

        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
    }
    #endregion
    #region "Methods"
    public long GetSelectedBill()
    {
        long BillID = -1;
        if (Request.Form["bid"] != null && Request.Form["bid"].ToString() != "")
        {
            BillID = Convert.ToInt32(Request.Form["bid"]);
        }
        return BillID;
    }
  
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / Page_Count);

        return totalPages;
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
    //        Response.Redirect(Request.ApplicationPath + path, true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //}

    #region BindPhysicians
    public void bindDropDown()
    {

        Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
        if (lstPhysician.Count > 0)
        {
            //ddlPhysician.DataSource = lstPhysician;

            //ddlPhysician.DataTextField = "PhysicianName";
            //ddlPhysician.DataValueField = "PhysicianID";
            //ddlPhysician.DataBind();
            //ddlPhysician.Items.Insert(0, new ListItem("--All--", "-1"));
        }

    }
    #endregion
    #endregion
}
