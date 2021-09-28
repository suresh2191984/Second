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


public partial class Reports_PhysioReport : BasePage
{
    List<PatientPhysioDetails> lstPatientPhysioDetails;
    Patient_BL objPatient_BL;
    List<Patient> lstPatient;
    long retCode = -1;
    int RptType = 0;
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindPhysioName();
            BindComplaintName();

            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

            rblReportType.SelectedValue = "0";

        }
    }
    private void BindPhysioName()
    {
        lstPatientPhysioDetails = new List<PatientPhysioDetails>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        retCode = objPatient_BL.GetPhysioName(OrgID, out lstPatientPhysioDetails);
        if (lstPatientPhysioDetails.Count > 0)
        {
            ddlPhysio.DataSource = lstPatientPhysioDetails;
            ddlPhysio.DataTextField = "ProcedureName";
            ddlPhysio.DataValueField = "ProcedureName";
            ddlPhysio.DataBind();
            ddlPhysio.Items.Insert(0, "--All--");
            ddlPhysio.Items[0].Value = "0";
        }
    }

    private void BindComplaintName()
    {
        lstPatientPhysioDetails = new List<PatientPhysioDetails>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        retCode = objPatient_BL.GetComplaintName(OrgID, out lstPatientPhysioDetails);

        if (lstPatientPhysioDetails.Count > 0)
        {
            ddlcPhysio.DataSource = lstPatientPhysioDetails;
            ddlcPhysio.DataTextField = "ComplaintName";
            ddlcPhysio.DataValueField = "ComplaintName";
            ddlcPhysio.DataBind();
            ddlcPhysio.Items.Insert(0, "--All--");
            ddlcPhysio.Items[0].Value = "0";
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (rblReportType.SelectedValue == "0")
        {
            tdddlPhysio.Style.Add("display", "block");
            tdddlcPhysio.Style.Add("display", "none");
            tblgvPCReport.Style.Add("display", "none");
            divPrintPC.Style.Add("display", "none");
            divPrintPhysioreport.Style.Add("display", "none");
            lstPatientPhysioDetails = new List<PatientPhysioDetails>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            retCode = objPatient_BL.GetPhysioReport(ddlPhysio.SelectedValue, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, out lstPatientPhysioDetails);
            if (lstPatientPhysioDetails.Count > 0)
            {
                lblErrorMsg.Visible = false;
                tblPhysioreport.Style.Add("display", "block");
                divPrintPhysioreport.Style.Add("display", "block");
                gvPhysioreport.DataSource = lstPatientPhysioDetails;
                gvPhysioreport.DataBind();

                gvPhysioreportp.DataSource = lstPatientPhysioDetails;
                gvPhysioreportp.DataBind();
                DataTable dt = loaddata(lstPatientPhysioDetails);   
                ds.Tables.Add(dt);
            }
            else
            {
                tblPhysioreport.Style.Add("display", "none");
                lblErrorMsg.Visible = true;

            }
        }
        else
        {
            tdddlPhysio.Style.Add("display", "none");
            tdddlcPhysio.Style.Add("display", "block");
            tblPhysioreport.Style.Add("display", "none");
            divPrintPhysioreport.Style.Add("display", "none");
            divPrintPC.Style.Add("display", "none");
            lstPatientPhysioDetails = new List<PatientPhysioDetails>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            retCode = objPatient_BL.GetPhysioCompliantReport(ddlcPhysio.SelectedItem.Text, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, out lstPatientPhysioDetails);
            if (lstPatientPhysioDetails.Count > 0)
            {
                lblErrorMsg.Visible = false;
                tblgvPCReport.Style.Add("display", "block");
                divPrintPC.Style.Add("display", "block");
                gvPCReport.DataSource = lstPatientPhysioDetails;
                gvPCReport.DataBind();

                gvPCReportP.DataSource = lstPatientPhysioDetails;
                gvPCReportP.DataBind();

                DataTable dt = loaddata(lstPatientPhysioDetails);
                ds.Tables.Add(dt);


            }
            else
            {
                tblgvPCReport.Style.Add("display", "none");
                lblErrorMsg.Visible = true;
               
            }
        }

        ViewState["report"] = ds;
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
    protected void gvPhysioreport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvPhysioreport.PageIndex = e.NewPageIndex;
                btnSubmit_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvPhysioreport_PageIndexChanging", ex);
        }
    }

    protected void gvPCReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvPCReport.PageIndex = e.NewPageIndex;
                btnSubmit_Click(sender, e);
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, gvPCReport_PageIndexChanging", ex);
        }
    }


    protected void gvPCReport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OView")
        {
            string CName = string.Empty;
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            CName = gvPCReport.DataKeys[RowIndex][0].ToString();

            RptType = int.Parse(rblReportType.SelectedValue);
            lstPatient = new List<Patient>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            retCode = objPatient_BL.GetPhysioCompliantPatient(RptType, CName, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, out lstPatient);

            if (lstPatient.Count > 0)
            {


                gvPatientDetail.DataSource = lstPatient;
                gvPatientDetail.DataBind();
                ModelPopPatientDetail.Show();
            }


        }
    }

    protected void gvPhysioreport_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "OView")
        {
            string CName = string.Empty;
            int RowIndex = Convert.ToInt32(e.CommandArgument);
            CName = gvPhysioreport.DataKeys[RowIndex][0].ToString();

            RptType = int.Parse(rblReportType.SelectedValue);

            lstPatient = new List<Patient>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            retCode = objPatient_BL.GetPhysioCompliantPatient(RptType, CName, Convert.ToDateTime(txtFrom.Text), Convert.ToDateTime(txtTo.Text), OrgID, out lstPatient);

            if (lstPatient.Count > 0)
            {
                gvPatientDetail.DataSource = lstPatient;
                gvPatientDetail.DataBind();
                ModelPopPatientDetail.Show();
            }


        }
    }


    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            string prefix = string.Empty;
            prefix = "Physiotheraphy_Report";
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
            CLogger.LogError("Error while converting to Excel", ex);
        }



    }






    public DataTable loaddata(List<PatientPhysioDetails> lstPatientPhysioDetails)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("ProcedureName");
        DataColumn dcol2 = new DataColumn("VisitCount");
        DataColumn dcol3 = new DataColumn("ProcedureCount");
      

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
       
        foreach (PatientPhysioDetails item in lstPatientPhysioDetails)
        {
            DataRow dr = dt.NewRow();
         
            dr["ProcedureName"] = item.ProcedureName;
            dr["VisitCount"] = item.VisitCount;
            dr["ProcedureCount"] = item.ProcedureCount;    
        

            dt.Rows.Add(dr);
        }
        return dt;
    }


    protected void imgBtnXLPC_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "PhysioComplaint_Report";
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
            CLogger.LogError("Error while converting to Excel", ex);
        }

    }



}
