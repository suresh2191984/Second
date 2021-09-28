using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;

public partial class Reports_DischargeAnalysisReport : BasePage
{
    long returnCode = -1;
    DataSet ds = new DataSet();
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<MRDDischargeAnalysis> lstMRDDischargeAnalysis = new List<MRDDischargeAnalysis>();

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //string requestType = rblVisitType.SelectedItem.Text;        
        //e.Row.Cells[2].Visible = false;
        e.Row.Cells[19].Visible = false;        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[1].Text = "";
                e.Row.Cells[3].Text = "";
                e.Row.Cells[4].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
            //if(((DayWiseCollectionReport)e.Row.DataItem).PatientVisitId == lstMRDDischargeAnalysis[)
            DayWiseCollectionReport dw = (DayWiseCollectionReport)e.Row.DataItem;
            if (lstMRDDischargeAnalysis.Exists(p => p.PatientVisitID == dw.PatientVisitId))
            {
                CheckBox chk = (CheckBox)e.Row.FindControl("chkCS");
                chk.Checked = true;
                chk.Enabled = false;
            }
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("PatientName");
        DataColumn dcol4 = new DataColumn("IPNumber");
        DataColumn dcol2 = new DataColumn("InsuranceName");
        DataColumn dcol5 = new DataColumn("MLCNo");
        DataColumn dcol6 = new DataColumn("Age");
        DataColumn dcol7 = new DataColumn("ReferredBy");
        DataColumn dcol8 = new DataColumn("ConsultantName");
        DataColumn dcol9 = new DataColumn("SpecialityName");
        DataColumn dcol10 = new DataColumn("ADMDiagnosis");
        DataColumn dcol11 = new DataColumn("TypeofSurgery");
        DataColumn dcol12 = new DataColumn("SurgeonName");
        DataColumn dcol13 = new DataColumn("Anaesthetist");
        DataColumn dcol14 = new DataColumn("TypeofAnaesthesia");
        DataColumn dcol15 = new DataColumn("DischargeStatus");
        DataColumn dcol16 = new DataColumn("LengthofStay");
        DataColumn dcol17 = new DataColumn("DateofSurgery");
        DataColumn dcol18 = new DataColumn("Address");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);
        dt.Columns.Add(dcol9);
        dt.Columns.Add(dcol10);
        dt.Columns.Add(dcol11);
        dt.Columns.Add(dcol12);
        dt.Columns.Add(dcol13);
        dt.Columns.Add(dcol14);
        dt.Columns.Add(dcol15);
        dt.Columns.Add(dcol16);
        dt.Columns.Add(dcol17);
        dt.Columns.Add(dcol18);
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["PatientNumber"] = item.PatientNumber;
            dr["PatientName"] = item.PatientName;
            dr["IPNumber"] = item.IPNumber;
            dr["InsuranceName"] = item.InsuranceName;
            dr["MLCNo"] = item.MLCNo;
            dr["Age"] = item.Age;
            dr["ReferredBy"] = item.ReferredBy;
            dr["ConsultantName"] = item.ConsultantName;
            dr["SpecialityName"] = item.SpecialityName;
            dr["ADMDiagnosis"] = item.ADMDiagnosis;
            dr["TypeofSurgery"] = item.TypeofSurgery;
            dr["SurgeonName"] = item.SurgeonName;
            dr["Anaesthetist"] = item.Anaesthetist;
            dr["TypeofAnaesthesia"] = item.TypeofAnaesthesia;
            dr["DischargeStatus"] = item.DischargeStatus;
            dr["LengthofStay"] = item.LengthofStay;
            dr["DateofSurgery"] = item.DateofSurgery;
            dr["Address"] = item.Address;
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            
            returnCode = new Report_BL(base.ContextInfo).GetDischargeAnalysisReport(fDate, tDate, OrgID, 0, out lstDWCR);
            returnCode = new Report_BL(base.ContextInfo).GetMRDDischargeAnalysis(OrgID, out lstMRDDischargeAnalysis);

            if (lstDWCR.Count > 0)
            {
                lstday = lstDWCR;
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt); 

                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;

                gvIPCreditMain.Visible = true;
                //gvOPReport.Visible = false;
                //gvIPCreditMain.Columns[0].HeaderText = "Admission Report";
                gvIPCreditMain.DataSource = lstDWCR;
                gvIPCreditMain.DataBind();
                btnSave.Visible = true;
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                btnSave.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<MRDDischargeAnalysis> lstMRDDA = new List<MRDDischargeAnalysis>();
        foreach (GridViewRow grd in gvIPCreditMain.Rows)
        {
            if ((((CheckBox)grd.FindControl("chkCS")).Checked == true) &&  (((CheckBox)grd.FindControl("chkCS")).Enabled == true))
            {
                MRDDischargeAnalysis mrd = new MRDDischargeAnalysis();
                Label lblpid = (Label)grd.FindControl("lblPatientID");
                Label lblpvid = (Label)grd.FindControl("lblPatientVisitId");

                mrd = new MRDDischargeAnalysis();
                mrd.PatientID = Convert.ToInt64(lblpid.Text);
                mrd.PatientVisitID = Convert.ToInt64(lblpvid.Text);
                mrd.CaseSheetRcvdStatus = "RECEIVED";
                mrd.CreatedBy = LID;
                lstMRDDA.Add(mrd);
            }
        }
        long errCode = -1;
        long returnCode = -1;
        returnCode = new Report_BL(base.ContextInfo).InsertMRDDischargeAnalysis(OrgID, lstMRDDA, out errCode);
        btnSubmit_Click(sender, e);
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "DischargeAnalysis_Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while converting to Excel", ex);
        }
    }
}
