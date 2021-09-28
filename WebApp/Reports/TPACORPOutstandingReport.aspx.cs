using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Text;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;

public partial class Reports_TPACORPOutstandingReport : BasePage
{
    long returnCode = -1;
    Report_BL reportBL;
    List<Patient> lstResult = new List<Patient>();
    protected void Page_Load(object sender, EventArgs e)
    {
        reportBL = new Report_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in TPACORPOutstandingReport.aspx:Page_Load", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        DateTime dFromDate = Convert.ToDateTime(txtFromDate.Text);
        DateTime dToDate = Convert.ToDateTime(txtToDate.Text);
        int VisitType = Convert.ToInt32(rblVisitType.SelectedValue);
        reportBL.GetTPACORPoutstandingreport(dFromDate, dToDate, OrgID, VisitType, out lstResult);
        if (lstResult.Count > 0)
        {
            
            grdResult.Visible = true;
            grdResult.DataSource = lstResult;
            grdResult.DataBind();
        }
        else
        {
            grdResult.Visible = false;
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('No Datas Found');", true);
        }

    }
    protected string CalcPatientDueAmount(object NetAmount, object TPABillAmount, object ReceivedAmount)
    {
        
        decimal c = 0;
        c = (((decimal)NetAmount - (decimal)TPABillAmount) - (decimal)ReceivedAmount);
        //if (c < 0)
        //    c = 0;
        return c.ToString("0.00");
    }
    protected string OutStandingCalculation(object NetAmount, object ReceivedAmount, object TPAAmount, object TDS, object TPADiscountAmt, object RightOff, object TPABillAmount)
    {
        decimal osc = 0;
        if((decimal)RightOff > 0)
        {
            //osc = 0;
            osc = (((decimal)NetAmount - (decimal)TPABillAmount) - (decimal)ReceivedAmount);
        }
        else
        {

            osc = (decimal)NetAmount - ((decimal)ReceivedAmount + (decimal)TPAAmount + (decimal)TDS + (decimal)TPADiscountAmt);
            
        }


        return osc.ToString("0.00");
    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                 

                GridView grid = sender as GridView;

                if (grid != null)
                {
                    GridViewRow row = new GridViewRow(0, -1,
                    DataControlRowType.Header, DataControlRowState.Normal);

                    TableCell BillDetails = new TableHeaderCell();
                    BillDetails.ColumnSpan = 6;
                    BillDetails.Attributes.Add("align", "center");
                    BillDetails.Text = "Bill Details";
                    row.Cells.Add(BillDetails);

                    TableCell PatientDetails = new TableHeaderCell();
                    PatientDetails.ColumnSpan = 6;
                    PatientDetails.Attributes.Add("align", "center");
                    PatientDetails.Text = "Patient Details";
                    row.Cells.Add(PatientDetails);

                    TableCell TPADetails = new TableHeaderCell();
                    TPADetails.ColumnSpan = 9;
                    TPADetails.Attributes.Add("align", "center");
                    TPADetails.Text = "TPA/CORP Settlement Details";
                    row.Cells.Add(TPADetails);

                    TableCell totals = new TableHeaderCell();
                    totals.ColumnSpan = grid.Columns.Count - 21;
                    row.Cells.Add(totals);

                    Table t = grid.Controls[0] as Table;
                    if (t != null)
                    {
                        t.Rows.AddAt(0, row);
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;

                //Label lblDispatchingDate = (Label)e.Row.FindControl("lblDispatchingDate");
                //Label lblTPASettlementDate = (Label)e.Row.FindControl("lblTPASettlementDate");
                
                //if (p.CliamForwardDate.ToString() == "01/01/0001 00:00:00")
                //{
                //    lblDispatchingDate.Text = "-";
                //}
                //else
                //{
                //    lblDispatchingDate.Text = p.CliamForwardDate.ToString("dd/MM/yyyy");
                //}
                //if (p.TPASettlementDate.ToString() == "01/01/0001 00:00:00")
                //{
                //    lblTPASettlementDate.Text = "-";
                //}
                //else
                //{
                //    lblTPASettlementDate.Text = p.TPASettlementDate.ToString("dd/MM/yyyy");
                   
                //}

            }
            


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in TPA Corp outstanding report rowdatabound in TPACORPOutstandingReport.aspx", ex);
        }

    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TPA/Corp Outstanding Report.xls"));
        HttpContext.Current.Response.ContentType = "application/ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                btnGo_Click(sender, e);
                grdResult.RenderControl(htw);
                //gvIPCreditMain.RenderEndTag(htw);
                HttpContext.Current.Response.Write(sw.ToString());
                HttpContext.Current.Response.End();


            }
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
