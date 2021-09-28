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
public partial class Reports_ICDReports : BasePage
{

    List<PatientComplaint> lstPatientComplaint;
    List<Patient> lstPatientICDDetail;
    List<Patient> lstPatientICDSummary;
    Report_BL objReport_BL;
    string ReportView = string.Empty;
    DataSet ds = new DataSet();
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
        ReportView=rblReportType.SelectedItem.Text;
        lstPatientICDDetail = new List<Patient>();
        lstPatientICDSummary = new List<Patient>();
        objReport_BL.GetICDReport(OrgID, ReportView, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), lstPatientComplaint, out lstPatientICDSummary, out lstPatientICDDetail);

        if (lstPatientICDDetail.Count > 0)
        {
            divPrint.Style.Add("display", "block");
            lblmsg.Visible = false;
            if (ReportView == "Detail")
            {
                gvSummary.Visible = false;
                gvSummary.DataSource = null;
                gvSummary.DataBind();

                grdResult.Visible = true;
                grdResult.DataSource = lstPatientICDSummary;
                grdResult.DataBind();               
            }
            else
            {
                grdResult.DataSource = null;
                grdResult.DataBind();
                grdResult.Visible = false;

                gvSummary.Visible = true;
                gvSummary.DataSource = lstPatientICDSummary;
                gvSummary.DataBind();
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
                                 where child.ICDCode == P.ICDCode
                                 select child;
               
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);                                
                ds.Tables.Add(dt);  
                            }
            ViewState["report"]=ds;
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

            ICDCode = lblICDS.Text;
            ICDName = lblICDNameS.Text;

            lblIcdCodePD.Text = ICDCode;
            lblIcdNamePD.Text = ICDName;

            ICDCodeReport1.LoadComplaintItems();
            lstPatientComplaint = new List<PatientComplaint>();
            lstPatientComplaint = ICDCodeReport1.GetPatientComplaint();
            objReport_BL = new Report_BL(base.ContextInfo);
            ReportView = rblReportType.SelectedItem.Text;
            lstPatientICDDetail = new List<Patient>();
            lstPatientICDSummary = new List<Patient>();
            objReport_BL.GetICDReport(OrgID, ReportView, Convert.ToDateTime(txtFDate.Text), Convert.ToDateTime(txtTDate.Text), lstPatientComplaint, out lstPatientICDSummary, out lstPatientICDDetail);

        if (lstPatientICDDetail.Count > 0)
        {
            var childItems = from child in lstPatientICDDetail
                             where child.ICDCode == ICDCode
                             select child;



            if (childItems.Count() > 0)
            {
                gvPatientDetail.DataSource = childItems;
                gvPatientDetail.DataBind();
                ModelPopPatientDetail.Show();
            }
           
        }      
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
