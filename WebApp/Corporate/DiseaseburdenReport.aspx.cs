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

public partial class Corporate_DiseaseburdenReport : BasePage
{
    List<PatientComplaint> lstPatientComplaint;
    List<Patient> lstPatientICDDetail;
    List<Patient> lstPatientMoreICDDetail;
    List<Patient> lstPatientICDSummary;
    Report_BL objReport_BL;
    string ReportView = string.Empty;
    DataSet ds = new DataSet();
    bool Icdcode;
    protected void Page_Load(object sender, EventArgs e)
    {
        ICDCodeReport1.LoadComplaintItems();
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {

        }
       
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        ICDCodeReport1.LoadComplaintItems();
        lstPatientComplaint = new List<PatientComplaint>();
        lstPatientComplaint = ICDCodeReport1.GetPatientComplaint();
        objReport_BL = new Report_BL(base.ContextInfo);
        ReportView = rblReportType.SelectedValue;
        if (rblReportType.SelectedValue == "0")
        {
            ReportView = "Detail" + "~" + "DT";
        }
        else
        {
            ReportView = "Summary" + "~" + "SMRY";
        }
        lstPatientICDDetail = new List<Patient>();
        lstPatientICDSummary = new List<Patient>();
        //if (ChkIcdcode.Checked == true)
        //{
        //    Icdcode = true;
        //}
        //else
        //{
        Icdcode = true;
        //}
        objReport_BL.GetDiseaseBurdenReport(OrgID, ReportView, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), lstPatientComplaint, out lstPatientICDSummary, out lstPatientICDDetail,Icdcode);

        if (lstPatientICDDetail.Count > 0 || lstPatientICDSummary.Count > 0)
        {
            divPrint.Style.Add("display", "block");
            lblmsg.Visible = false;
            if (rblReportType.SelectedValue == "0")
            {
                gvSummary.Visible = false;
                gvSummary.DataSource = null;
                gvSummary.DataBind();

                grdDetails.Visible = false;
                grdDetails.DataSource = null;
                grdDetails.DataBind();

                grdResult.Visible = true;
                grdResult.DataSource = lstPatientICDSummary;
                grdResult.DataBind();
            }
            else
            {
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    grdResult.Visible = false;

                    gvSummary.Visible = false;
                    gvSummary.DataSource = null;
                    gvSummary.DataBind();

                    grdDetails.Visible = true;
                    grdDetails.DataSource = lstPatientICDSummary;
                    grdDetails.DataBind();

            }
        }
        else
        {
            lblmsg.Visible = true;
            divPrint.Style.Add("display", "none");
            gvSummary.Visible = false;
            gvSummary.DataSource = null;
            gvSummary.DataBind();

            grdResult.DataSource = null;
            grdResult.DataBind();
            grdResult.Visible = false;
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
    }
    public DataTable loaddata(List<Patient> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Name");
        DataColumn dcol2 = new DataColumn("PatientNumber");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("VisitDate");
        DataColumn dcol5 = new DataColumn("VisitType");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);

        foreach (Patient item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["Name"] = item.Name;
            dr["PatientNumber"] = item.PatientNumber;
            dr["Age"] = item.Age;
            dr["VisitDate"] = item.VisitDate;
            dr["VisitType"] = item.VisitType;
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            List<Patient> lstday = new List<Patient>();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                Patient P = (Patient)e.Row.DataItem;
                var childItems = from child in lstPatientICDDetail
                                 where child.ComplaintName == P.ComplaintName 
                                 select child;

                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);
                ds.Tables.Add(dt);
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading ICD Reports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    protected void gvSummary_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OView")
        {
            string ICDCode = string.Empty;
            string ICDName = string.Empty;
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            //ICDCode = gvSummary.DataKeys[RowIndex][0].ToString();
            Label lblICDS = (Label)gvSummary.Rows[RowIndex].FindControl("lblICDS");
            Label lblICDNameS = (Label)gvSummary.Rows[RowIndex].FindControl("lblICDNameS");
            //Label lblEdeptmentS = (Label)gvSummary.Rows[RowIndex].FindControl("lblICDNameS");
            ICDCode = lblICDS.Text;
            ICDName = lblICDNameS.Text;

            lblIcdCodePD.Text = ICDCode;
            lblIcdNamePD.Text = ICDName;
            //lblEdeptment.Text=
            ICDCodeReport1.LoadComplaintItems();
            lstPatientComplaint = new List<PatientComplaint>();
            lstPatientComplaint = ICDCodeReport1.GetPatientComplaint();
            objReport_BL = new Report_BL(base.ContextInfo);
            ReportView = rblReportType.SelectedItem.Text;
            lstPatientICDDetail = new List<Patient>();
            lstPatientICDSummary = new List<Patient>();
            ReportView = "PT" + "~" + lblIcdNamePD.Text;
            objReport_BL.GetDiseaseBurdenReport(OrgID, ReportView, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), lstPatientComplaint, out lstPatientICDSummary, out lstPatientICDDetail, Icdcode);

            if (lstPatientICDDetail.Count > 0 || lstPatientICDSummary.Count > 0)
            {
                lstPatientMoreICDDetail = (from child in lstPatientICDDetail
                                           where child.ComplaintName == ICDName & child.CompressedName == ICDCode
                                           group child by new { child.Age, child.Name, child.VisitDate, child.VisitType, child.PatientNumber } into g

                                           select new Patient
                                           {
                                               Name = g.Key.Name,
                                               Age = g.Key.Age,
                                               VisitDate = g.Key.VisitDate,
                                               VisitType = g.Key.VisitType,
                                               PatientNumber = g.Key.PatientNumber

                                           }).Distinct().ToList();



                if (lstPatientMoreICDDetail.Count > 0)
                {

                    GridView1.DataSource = lstPatientMoreICDDetail;
                    GridView1.DataBind();
                    ModelPopPatientDetail.Show();
                }

            }
        }
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            string path = "/Reports/ViewReportList.aspx";
            Response.Redirect(Request.ApplicationPath + path, true);
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
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "ICDCode_Reports_";
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
            CLogger.LogError("Error while Converting to Excel", ex);
        }
    }
}
