using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Data.SqlClient;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Text;
using System.IO;

public partial class ReportsLims_HistopathalogyReport : BasePage
{
    long returnCode = -1;
   
  
    public ReportsLims_HistopathalogyReport()
        : base("ReportsLims_LabStatisticsReportLims_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        DateTime Fdate;
        DateTime TDate;
        txtFDate.Attributes.Add("onchange", "validateFrom('" + txtFDate.ClientID.ToString() + "','" + txtTDate.ClientID.ToString() + "');");
        txtTDate.Attributes.Add("onchange", "ValidDate('" + txtFDate.ClientID.ToString() + "','" + txtTDate.ClientID.ToString() + "','txtFDate',0,0);");
        if (!IsPostBack)
        {
            LoadOrgan();
            LoadDepartement();
            Fdate = DateTime.Parse(OrgDateTimeZone.ToString());
            TDate = DateTime.Parse(OrgDateTimeZone.ToString());
            txtFDate.Text = Convert.ToString(Fdate.ToString("dd/MM/yyyy"));
            txtTDate.Text = Convert.ToString(TDate.ToString("dd/MM/yyyy"));

          
        }
    }
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);



            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
    private void LoadDepartement()
    {
        try
        {
            ddlDepartment.Items.Clear();
            List<InvDeptMaster> ObjInvDep = new List<InvDeptMaster>();
            List<InvDeptMaster> FilteredInvDep;
            List<InvestigationHeader> objHeader = new List<InvestigationHeader>();
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            long returnCode = -1;
            int DeptID = 0;

            returnCode = investigationBL.getOrgDepartHeadName(OrgID, out ObjInvDep, out objHeader);

            //List<InvDeptMaster> lstinvmaster = new List<InvDeptMaster>();
            FilteredInvDep = ObjInvDep.FindAll(P => (P.Code == "Histo")).ToList();

            //var lstinvmaster= from c in ObjInvDep where c.DeptName.ToLower().Contains("histopathology")
            //              select c;

            if (ObjInvDep.Count > 0)
            {
                ddlDepartment.DataTextField = "DeptName";
                ddlDepartment.DataValueField = "DeptID";
                ddlDepartment.DataSource = FilteredInvDep;
                ddlDepartment.DataBind();
            }

            DeptID = Convert.ToInt32(ddlDepartment.SelectedValue);

            LoadTestName(DeptID);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to LoadDepartement", ex);
        }
        
    }

    private void LoadTestName(int DeptID)
    {
        List<InvDeptMaster> lstTestName = new List<InvDeptMaster>();
        
        returnCode = -1;
        Investigation_BL Invbl = new Investigation_BL(base.ContextInfo);
        returnCode = Invbl.GetHistoDeptTestNames(DeptID, out lstTestName);

        if (lstTestName.Count > 0)
        {
            drpTestName.DataTextField = "DeptName";
            drpTestName.DataValueField = "DeptID";
            drpTestName.DataSource = lstTestName;
            drpTestName.DataBind();
            drpTestName.Items.Insert(0, new ListItem("Select", "0"));
        }
        
    }
 
    protected void btnSubmit_Click(object sender, EventArgs e)
    {

        LoadGrid();
    }

    public void LoadGrid()
    {

        returnCode = -1;

        try
        {
            Investigation_BL Invbl = new Investigation_BL(base.ContextInfo);
            List<HistopathologyReport> lsthisto = new List<HistopathologyReport>();
            DateTime fromdate = Convert.ToDateTime(txtFDate.Text);
            DateTime todate = Convert.ToDateTime(txtTDate.Text);
            int DeptID = Convert.ToInt32(ddlDepartment.SelectedValue);
            int TestID = Convert.ToInt32(drpTestName.SelectedValue);
            returnCode = Invbl.GetKPIReport(fromdate, todate, DeptID, TestID, out lsthisto);
            if (lsthisto.Count > 0)
            {
                grdHistoReport.DataSource = lsthisto;
                grdHistoReport.DataBind();
                Excel.Attributes.Add("style", "display:Block");
                pnl.Attributes.Add("style", "display:Block");
            }
            else
            {
                grdHistoReport.DataSource = null;
                grdHistoReport.DataBind();
                Excel.Attributes.Add("style", "display:none");
                pnl.Attributes.Add("style", "display:none");
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('No Matching Records Found!');", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Gird", ex);
        }

    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
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

    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
    }

    public void ExportToExcel()
    {
        try
        {
            string str = "Histopathology Department Report";
            string FromDate = txtFDate.Text;
            string ToDate = txtTDate.Text;
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix + FromDate + " to " + ToDate;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadGrid();
            //  grdResult.AllowPaging = false;
            //   grdResult.DataBind();

            //Applying stlye to gridview header cells
            for (int i = 0; i < grdHistoReport.HeaderRow.Cells.Count; i++)
            {
                grdHistoReport.HeaderRow.Cells[i].Style.Add("background-color", "#80CCD8");
            }
            int j = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in grdHistoReport.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= grdHistoReport.Rows.Count)
                {
                    if (j % 2 != 0)
                    {
                        for (int k = 0; k < gvrow.Cells.Count; k++)
                        {
                            gvrow.Cells[k].Style.Add("background-color", "#FFFFFF");
                        }
                    }
                }
                j++;
            }
            htw.WriteLine("<span style='font-size:14.0pt; color:#E54C70;font-weight:500;font-weight: bold;'>" + rptDate + " </span>");
            grdHistoReport.RenderControl(htw);
            Response.Write(sw.ToString());
            sw.Close();
            htw.Close();
            Response.End();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
        finally
        {

        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
  
   
}
