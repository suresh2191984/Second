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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using AjaxControlToolkit;
using System.Drawing;

public partial class Admin_MRDView : BasePage
{
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;

    public Admin_MRDView()
        : base("Admin\\MRDView.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {

            LoadSearchTypeMetaData();
            DateValidation();
            GridResults(0);
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

    public void DateValidation()
    {

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
        #endregion
    }
    public void GridResults(int index)
    {
        long returnCode = -1;
        List<PatientMRDDetails> lstPatientMRDDetails = new List<PatientMRDDetails>();
        Patient_BL lsPatient = new Patient_BL(base.ContextInfo);

        string VisitFrom = string.Empty;
        string VisitTo = string.Empty;
        string PatientName = string.Empty;
        string MRDNO = string.Empty;
        string SearchType = string.Empty;
        string SearchName = string.Empty;
        string MrdStatus = string.Empty;

        if (ddlRegisterDate.SelectedItem.Text != "--Select--")
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
            strBillFromDate = "";//Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
            strBillToDate = "";// Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd-MM-yyyy");
        }

        if (!string.IsNullOrEmpty(txtSearchMRDNO.Text))
        {
            MRDNO = txtSearchMRDNO.Text;
        }
        if (!string.IsNullOrEmpty(txtSerachPatientName.Text))
        {
            PatientName = txtSerachPatientName.Text;
        }
        SearchType = hdnSearchOption.Value;
        SearchName = txtSelectOption.Text;
        MrdStatus = ddlStatus.SelectedValue;
        
        returnCode = lsPatient.GetPatientMRDDetils(MRDNO, PatientName, strBillFromDate, strBillToDate, OrgID, SearchType, SearchName, MrdStatus, out lstPatientMRDDetails);
        //hdnSearchOption.Value = "";
        //txtSelectOption.Text = "";
        //ddlStatus.SelectedItem.Text = "";

        if (lstPatientMRDDetails.Count > 0)
        {
            dgvResult.DataSource = lstPatientMRDDetails;
            dgvResult.PageIndex = index;
            dgvResult.DataBind();


            foreach (GridViewRow row in dgvResult.Rows)
            {
                Label lblStatus = (Label)row.FindControl("txtStatus");
                LinkButton lnkout = (LinkButton)row.FindControl("lnkCheckOut");
                LinkButton lnkIn = (LinkButton)row.FindControl("lnkTransfer");
                LinkButton lnkTransfer = (LinkButton)row.FindControl("lnkCheckIN");
                LinkButton Receive = (LinkButton)row.FindControl("lnkReceive");
                
                if (lblStatus.Text == "CheckOut")
                {
                    lnkout.Style.Add("display", "none");
                    Receive.Style.Add("display", "block");
                    lnkIn.Style.Add("display", "block");
                    lnkTransfer.Style.Add("display", "block");
                }
                else if (lblStatus.Text == "Transfer")
                {
                    lnkout.Style.Add("display", "none");
                    lnkIn.Style.Add("display", "block");
                    lnkTransfer.Style.Add("display", "block");
                    Receive.Style.Add("display", "block");
                }
                else if (lblStatus.Text == "CheckIN")
                {
                    lnkout.Style.Add("display", "block");
                    lnkIn.Style.Add("display", "none");
                    lnkTransfer.Style.Add("display", "none");
                    Receive.Style.Add("display", "none");
                }
                else if (lblStatus.Text == "Receive")
                {
                    lnkout.Style.Add("display", "none");
                    lnkIn.Style.Add("display", "block");
                    lnkTransfer.Style.Add("display", "block");
                    Receive.Style.Add("display", "block");
                }
                else
                {
                    lnkout.Style.Add("display", "block");
                    lnkIn.Style.Add("display", "none");
                    lnkTransfer.Style.Add("display", "none");
                    Receive.Style.Add("display", "none");
                }


            }
        }
        else
        {
            dgvResult.DataSource = lstPatientMRDDetails;
            dgvResult.DataBind();
        }

    }

    public void GridHistoryResult(int Index)
    {
        long returnCode = -1;
        List<PatientMRDDetails> lstPatientMRDDetails = new List<PatientMRDDetails>();
        Patient_BL lsPatient = new Patient_BL(base.ContextInfo);

        returnCode = lsPatient.GetMRDFileDetails(Convert.ToInt64(hdnPatientID.Value), Convert.ToInt64(hdnPatientVisitID.Value), OrgID, out lstPatientMRDDetails);


        dgvHistory.DataSource = lstPatientMRDDetails;
        dgvHistory.PageIndex = Index;
        dgvHistory.DataBind();


    }

    protected void dgvResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            dgvResult.PageIndex = e.NewPageIndex;
            GridResults(e.NewPageIndex);
        }

    }
    protected void dgvResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        
        if (e.CommandName == "Transfer" || e.CommandName == "CheckOut" || e.CommandName == "CheckIN" || e.CommandName == "Receive")
        {
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            Label lblPatient = (Label)dgvResult.Rows[RowIndex].FindControl("txtPatientName");
            Label lblMRD = (Label)dgvResult.Rows[RowIndex].FindControl("txtPatientNumber");
            Label lblVisit = (Label)dgvResult.Rows[RowIndex].FindControl("txtVisitNumber");
            Label lblSpecit = (Label)dgvResult.Rows[RowIndex].FindControl("txtSpecialityName");
            
            lblPatientName.Text = lblPatient.Text;
            lblMRDNo.Text = lblMRD.Text == "" ? "0" : lblMRD.Text;
            lblVisitNo.Text = lblVisit.Text == "" ? "0" : lblVisit.Text;
            lblSpeciality.Text = lblSpecit.Text;

            Label lblPatientID = (Label)dgvResult.Rows[RowIndex].FindControl("txtPatientID");
            Label lblPatientVisitId = (Label)dgvResult.Rows[RowIndex].FindControl("txtPatientVisitId");

            long PatientID = 0;
            long PatientVisitID = 0;
            PatientID = Convert.ToInt64(lblPatientID.Text);
            PatientVisitID = Convert.ToInt64(lblPatientVisitId.Text);

            if (e.CommandName == "Transfer" || e.CommandName == "CheckOut" || e.CommandName == "Receive")
            {
                hdnPatientID.Value = PatientID.ToString();
                hdnPatientVisitID.Value = PatientVisitID.ToString();
                hdnStatus.Value = e.CommandName.ToString();
                ViewState["Value"] = "";
                ViewState["Value"] = PatientID.ToString() + "$" + PatientVisitID.ToString() + "$" + e.CommandName.ToString();
                MPEFeeType.Show();
                GridHistoryResult(0);
            }
            else if (e.CommandName == "CheckIN")
            {
                MRDFileDetails MRD = new MRDFileDetails();
                MRD.CategoryID = 0;
                MRD.CategoryType = "";
                MRD.CreatedBy = LID;
                MRD.ToPersonID = LID;
                MRD.PatientID = PatientID;
                MRD.PatientVisitId = PatientVisitID;
                MRD.Status = e.CommandName.ToString();

                Patient_BL lsPatient = new Patient_BL(base.ContextInfo);
                long returnCode = -1;
                returnCode = lsPatient.InsertMRDFileDetails(MRD.PatientID, MRD.PatientVisitId, MRD.CategoryType, MRD.CategoryID, MRD.ToPersonID, MRD.CreatedBy, MRD.Status);

                GridHistoryResult(0);
                string sPath = "Admin\\\\MRDView.aspx_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "MRDVIEW", "ShowAlertMsg('" + sPath + "');", true);

                //ScriptManager.RegisterStartupScript(this, this.GetType(), "Script", "alert('Update Successfully');", true);
                Response.Redirect("../Admin/MRDView.aspx");  
            }

        }


    }
    protected void dgvHistory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            dgvHistory.PageIndex = e.NewPageIndex;
            GridHistoryResult(e.NewPageIndex);
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string lsValue = ViewState["Value"].ToString();

        char[] lcsplitFirst = { '$' };
        string[] lsValues = lsValue.Split(lcsplitFirst);
        hdnPatientID.Value = lsValues[0].ToString();
        hdnPatientVisitID.Value = lsValues[1].ToString();
        hdnStatus.Value = lsValues[2].ToString();


        MRDFileDetails MRD = new MRDFileDetails();
        MRD.CategoryID = Convert.ToInt32(hdnCatgID.Value);
        MRD.CategoryType = radSelectOption.SelectedValue.ToString();
        MRD.CreatedBy = LID;
        MRD.ToPersonID = hdnCollectedID.Value == "0" ? 0 : Convert.ToInt64(hdnCollectedID.Value);
        MRD.PatientID = Convert.ToInt64(hdnPatientID.Value);
        MRD.PatientVisitId = Convert.ToInt64(hdnPatientVisitID.Value);
        MRD.Status = hdnStatus.Value;

        Patient_BL lsPatient = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        returnCode = lsPatient.InsertMRDFileDetails(MRD.PatientID, MRD.PatientVisitId, MRD.CategoryType, MRD.CategoryID, MRD.ToPersonID, MRD.CreatedBy, MRD.Status);
        MPEFeeType.Hide();

        hdnPatientID.Value = "0";
        hdnPatientVisitID.Value = "0";
        hdnStatus.Value = "";
        hdnCatgID.Value = "0";
        hdnCollectedID.Value = "0";
        txtName.Text = "";
        txtCollectedPerson.Text = "";
        radSelectOption.SelectedIndex = -1;
        string sPath = "Admin\\\\MRDView.aspx_3";        
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "MRDVIEW", "ShowAlertMsg('" + sPath + "');", true);
                    
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "Script", "alert('Update Successfully');", true);

        GridResults(0);


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridResults(0);
    }

    public void LoadSearchTypeMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "CustomPeriodRange,MRDVIEW,MRDStatus";
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
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "CustomPeriodRange"
                                 select child;
                ddlRegisterDate.DataSource = childItems;
                ddlRegisterDate.DataTextField = "DisplayText";
                ddlRegisterDate.DataValueField = "Code";
                ddlRegisterDate.DataBind();
                ddlRegisterDate.Items.Insert(0, "--Select--");
                ddlRegisterDate.Items[0].Value = "-1";

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "MRDVIEW" && child.Code != "None"
                                  select child;

                radSelectOption.DataSource = childItems1;
                radSelectOption.DataTextField = "DisplayText";
                radSelectOption.DataValueField = "Code";
                radSelectOption.DataBind();

                var childItems11 = from child in lstmetadataOutput
                                   where child.Domain == "MRDVIEW"
                                   select child;
                radSearchSelectOption.DataSource = childItems11;
                radSearchSelectOption.DataTextField = "DisplayText";
                radSearchSelectOption.DataValueField = "Code";
                radSearchSelectOption.DataBind();

                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "MRDStatus"
                                  orderby child.DisplayText
                                  select child;
                ddlStatus.DataSource = childItems2;
                ddlStatus.DataTextField = "DisplayText";
                ddlStatus.DataValueField = "Code";
                ddlStatus.DataBind();
                ddlStatus.Items.Insert(0, "--Select--");
                ddlStatus.Items[0].Value = "-1";

            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }
    protected void dgvResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblStatus = (Label)e.Row.FindControl("txtStatus");
            string MrdStatus = lblStatus.Text;
            if (MrdStatus == "")
            {
                
                e.Row.BackColor = ColorTranslator.FromHtml("#c6efce");
            }
            
        }
    }
}