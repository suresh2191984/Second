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

public partial class Reports_midnitesensexreport : BasePage
{
    MidNitesensexreport mid = new MidNitesensexreport();
    List<MidNitesensexreport> midlst = new List<MidNitesensexreport>();
    long returnCode = -1;
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Page_load", ex);
        }
    }
    public void binddetails()
    {
        try
        {
            StringBuilder sbappend = new StringBuilder();
            //Midnite mid = new Midnite();
            //List<Midnite> lstmid = new List<Midnite>();
            String dtfrm = Convert.ToDateTime(txtFDate.Text).AddDays(-1).ToString("dd/MM/yyyy");
            DateTime dtfrmdate = Convert.ToDateTime(txtFDate.Text).AddDays(-1);
            DateTime dtfrmdt = Convert.ToDateTime(txtFDate.Text);
            returnCode = new Report_BL(base.ContextInfo).GetmidniteReport(dtfrmdt, OrgID, out midlst);
            if (midlst.Count > 0)
            {                                        
                divPrint.Attributes.Add("Style", "Display:Block");
                var newlst = midlst.GroupBy(c => new { c.WardName }) 
                    .Select(g => new
                        {
                            WardName = g.Key.WardName + '-' + g.Where(c => c.Status != "Cancelled").Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != dtfrm).Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => c.Fromdate <= dtfrmdate && c.Todate >= dtfrmdate).Count(),
                            MaleAdmission = g.Where(c => c.Sex == "M").Where(c => c.Age > 14).Where(c => c.Status != "Transfered").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            FemaleAdmission = g.Where(c => c.Sex == "F").Where(c => c.Age > 14).Where(c => c.Status != "Transfered").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            ChildAdmission = g.Where(c => c.Age <= 14).Where(c => c.Status != "Transfered").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            MaleDischarge = g.Where(c => c.VisitState == "Discharged").Where(c => c.Status == "Discharged").Where(c => c.Sex == "M").Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => c.Age > 14).Count(),
                            ChildDischarge = g.Where(c => c.VisitState == "Discharged").Where(c => c.Status == "Discharged").Where(c => c.Age <= 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            FemaleDischarge = g.Where(c => c.VisitState == "Discharged").Where(c => c.Status == "Discharged").Where(c => c.Sex == "F").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            FemaleTransferIN = g.Where(c => c.Status == "Occupied").Where(c => c.Sex == "F").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == "01/01/0001").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() + g.Where(c => c.Status == "Transfered").Where(c => c.Sex == "F").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            ChildTransferIN = g.Where(c => c.Status == "Occupied").Where(c => c.Age <= 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == "01/01/0001").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() + g.Where(c => c.Status == "Transfered").Where(c => c.Age < 14).Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            MaleTransferIN = g.Where(c => c.Status == "Occupied").Where(c => c.Sex == "M").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == "01/01/0001").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() + g.Where(c => c.Status == "Transfered").Where(c => c.Sex == "M").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            FemaleTransferOut = g.Where(c => c.Status == "Transfered").Where(c => c.Sex == "F").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            ChildTransferOut = g.Where(c => c.Status == "Transfered").Where(c => c.Age <= 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            MaleTransferOut = g.Where(c => c.Status == "Transfered").Where(c => c.Sex == "M").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            MaleBirth = g.Where(c => c.Sex == "M").Where(c => Convert.ToDateTime(c.DOB).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            Wardclose = g.Key.WardName + '-' + (g.Where(c => c.Status != "Cancelled").Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != dtfrm).Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => c.Fromdate <= dtfrmdate && c.Todate >= dtfrmdate).Count() + g.Where(c => c.Status != "Cancelled").Where(c => c.Status != "Transfered").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") != Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() +
                            g.Where(c => c.Status == "Occupied").Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == "01/01/0001").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() + g.Where(c => c.Status == "Transfered").Where(c => Convert.ToDateTime(c.Fromdate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() -
                            g.Where(c => c.Status == "Transfered").Where(c => c.Todate.ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count() - g.Where(c => c.VisitState == "Discharged").Where(c => c.Status == "Discharged").Where(c => Convert.ToDateTime(c.Todate).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count()),
                            FemaleBirth = g.Where(c => c.Sex == "F").Where(c => Convert.ToDateTime(c.DOB).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            ChildBirth=0,
                            MaleDeath = g.Where(c => c.Sex == "M").Where(c => c.Age > 14).Where(c => c.Status == "Discharged").Where(c => Convert.ToDateTime(c.DOD).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            ChildDeath = g.Where(c => c.Age <= 14).Where(c => c.Status == "Discharged").Where(c => Convert.ToDateTime(c.DOD).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                            FemaleDeath = g.Where(c => c.Sex == "F").Where(c => c.Status == "Discharged").Where(c => c.Age > 14).Where(c => Convert.ToDateTime(c.DOD).ToString("dd/MM/yyyy") == Convert.ToDateTime(txtFDate.Text).ToString("dd/MM/yyyy")).Count(),
                        }).ToList();
                DataTable dt;
                Utilities.ConvertFrom(newlst, out dt);
                gvDuepaidReport.DataSource = dt;
                gvDuepaidReport.DataBind();
                ds.Tables.Add(dt);
                ViewState["report"] = ds;
            }
            else
            {
                divPrint.Attributes.Add("Style", "Display:None");
                gvDuepaidReport.DataSource = null;
                gvDuepaidReport.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in binddetails", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            binddetails();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in btnSearch_Click", ex);
        }
    }
    public String strbuilder(string str)
    {
        StringBuilder strBld = new StringBuilder();
        try
        {
            strBld.Append("<table width=100%>");
            strBld.Append("<tr>");
            strBld.AppendFormat("<td align=center COLSPAN=" + 3 + ">");
            strBld.AppendFormat(""+str+"");
            strBld.AppendFormat("<hr>");
            strBld.AppendFormat("</td>");
            strBld.Append("</tr>");            
            strBld.Append("<tr>");            
            strBld.Append("<br>");
            strBld.Append("<td>");
            strBld.AppendFormat("Male");
            strBld.Append("</td>");
            strBld.Append("<td align=Center>");
            strBld.AppendFormat("Female");
            strBld.Append("</td>");
            strBld.Append("<td align=right>");
            strBld.AppendFormat("Child");
            strBld.Append("</td>");
            strBld.Append("<tr>");
            strBld.Append("</table>");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in strbuilder", ex);
        }
        return strBld.ToString();
    }
    protected void gvDuepaidReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {  
        try
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {              
                
                    e.Row.Cells[0].Text = "Opening Bed Statistics";
                    e.Row.Cells[1].ColumnSpan = 3;
                    e.Row.Cells[1].Text = strbuilder("Admission");
                    e.Row.Cells[2].ColumnSpan = 3;
                    e.Row.Cells[2].Text = strbuilder("Birth");
                    e.Row.Cells[3].ColumnSpan = 3;                     
                    e.Row.Cells[3].Text = strbuilder("TransferIN");
                    e.Row.Cells[4].ColumnSpan = 3;
                    e.Row.Cells[4].Text = strbuilder("TransferOUT");
                    e.Row.Cells[5].ColumnSpan = 3;
                    e.Row.Cells[5].Text = strbuilder("Discharge");
                    e.Row.Cells[6].ColumnSpan = 3;
                    e.Row.Cells[6].Text = strbuilder("Death");
                    e.Row.Cells[7].ColumnSpan = 0;
                    e.Row.Cells[7].Text = "Closing Bed Statistics";
                    e.Row.Cells[8].Visible = false;
                    e.Row.Cells[9].Visible = false;
                    e.Row.Cells[10].Visible = false;
                    e.Row.Cells[11].Visible = false;
                    e.Row.Cells[12].Visible = false;
                    e.Row.Cells[13].Visible = false;
                    e.Row.Cells[14].Visible = false;
                    e.Row.Cells[15].Visible = false;
                    e.Row.Cells[16].Visible = false;
                    e.Row.Cells[17].Visible = false;
                    e.Row.Cells[18].Visible = false;
                    e.Row.Cells[19].Visible = false; 
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in gvDuepaidReport_RowDataBound", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            string prefix = string.Empty;
            prefix = "Midnitesensex_Report_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First You have to click d Get report');", true);
            }
            //HttpContext.Current.ApplicationInstance.CompleteRequest();
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
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
}
