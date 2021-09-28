using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Collections;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
using Attune.Podium.TrustedOrg;
using System.Net;
using System.Xml;
using System.Data;
using Attune.Podium.ExcelExportManager;
using System.IO;
using ReportBusinessLogic;
using System.Drawing;
using System.Text;
using Attune.Podium.PerformingNextAction;

public partial class Reports_PeriodWiseMeanTATReport : BasePage
{
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtTo.Text = DateTime.Today.ToString();
            //txtFrom.Text = DateTime.Today.ToString();
            modalpopupsendemail.Hide();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[1].HeaderText = "Tests";
        LoadGrid();
    }

    public void LoadGrid()
    {
        try
        {

            modalpopupsendemail.Hide();
            pnl.Visible = true;
            List<PeriodWiseMeanTAT> LstTAT = new List<PeriodWiseMeanTAT>();
            //ReportExcel_BL reportexcelBL = new ReportExcel_BL(base.ContextInfo);
            string strBillNo = string.Empty;
            //int strBillNo;
            DateTime strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);           
            strBillNo = string.Empty;
            string SearchType = string.Empty;
            SearchType = "TestWise";
            strBillFromDate = Convert.ToDateTime(txtFrom.Text);
            strBillToDate =Convert.ToDateTime(txtTo.Text);
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetPeriodwiseMeanTATReport(OrgID, SearchType, strBillFromDate, strBillToDate, out LstTAT);
            grdResult.Width = 525;
            grdResult.Visible = true;
            grdResult.DataSource = LstTAT;
            grdResult.DataBind();

            if (LstTAT.Count > 1)
            {
                divPrint1.Attributes.Add("Style", "display:block");


            }
            else
            {
                grdResult.Visible = true;
                grdResult.DataSource = null;
                grdResult.DataBind();
                divPrint1.Attributes.Add("Style", "display:none");
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }


    public void LoadProfileGrid()
    {
        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            List<PeriodWiseMeanTAT> LstTAT = new List<PeriodWiseMeanTAT>();
            //ReportExcel_BL reportexcelBL = new ReportExcel_BL(base.ContextInfo);
            string strBillNo = string.Empty;
            //int strBillNo;
            DateTime strBillFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DateTime strBillToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            strBillNo = string.Empty;
            string SearchType = string.Empty;
            SearchType = "ProfileWise";
            strBillFromDate = Convert.ToDateTime(txtFrom.Text);
            strBillToDate = Convert.ToDateTime(txtTo.Text);
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetPeriodwiseMeanTATReport(OrgID, SearchType, strBillFromDate, strBillToDate, out LstTAT);
            grdResult.Width = 525;
            grdResult.Visible = true;
            grdResult.DataSource = LstTAT;
            grdResult.DataBind();

            if (LstTAT.Count > 1)
            {
                divPrint1.Attributes.Add("Style", "display:block");


            }
            else
            {
                grdResult.Visible = true;
                grdResult.DataSource = null;
                grdResult.DataBind();
                divPrint1.Attributes.Add("Style", "display:none");
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                Label lnkFeeDescription = (Label)e.Row.FindControl("lnkFeeDescription");
                if (lnkFeeDescription.Text == "Total Mean")
                {
                    e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                    e.Row.Font.Bold = true;
                    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                }


            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Cancelled BIll Details", Ex);
        }


    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
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
            modalpopupsendemail.Hide();
            string str = "Period_Wise_Mean_TAT";
            string FromDate = txtFrom.Text;
            string ToDate = txtTo.Text;
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
            //LoadGrid();

            //Applying stlye to gridview header cells
            for (int i = 0; i < grdResult.HeaderRow.Cells.Count; i++)
            {
                grdResult.HeaderRow.Cells[i].Style.Add("background-color", "#80CCD8");
            }
            int j = 1;
            //This loop is used to apply stlye to cells based on particular row
            foreach (GridViewRow gvrow in grdResult.Rows)
            {
                gvrow.BackColor = Color.White;
                if (j <= grdResult.Rows.Count)
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
            grdResult.RenderControl(htw);
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

    protected void btnPrintAll_Click(object sender, EventArgs e)
    {
        try
        {
           // LoadGrid();
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            grdResult.Width = 525;
            grdResult.Font.Size = 8;
            grdResult.RenderControl(hw);
            string gridHTML = sw.ToString().Replace("\"", "'")
                .Replace(System.Environment.NewLine, "");
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload = new function(){");
            sb.Append("var printWin = window.open('', '', 'left=0,right=0");
            sb.Append(",top=0,width=600,height=600,status=0,scrollbars=1');");
            sb.Append("printWin.document.write(\"");
            sb.Append(gridHTML);
            sb.Append("\");");
            sb.Append("printWin.document.close();");
            sb.Append("printWin.focus();");
            sb.Append("printWin.print();};");
            // sb.Append("printWin.close();};"); 
            sb.Append("</script>");
            ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
    }


    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {
        try
        {

            

            string EmailTo = String.Empty;
            EmailTo = txtMailAddress.Text;
            string str = "Period Wise Mean TAT";
            string FromDate = txtFrom.Text;
            string ToDate = txtTo.Text;
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix + FromDate + " to " + ToDate;
            rptDate = "<div style='font-family:Verdana;font-size:12;'><div><strong><br>" + rptDate + "<br/>" + "</strong></div></div><br>";
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = "SendMISReportMail";
            PC.ButtonValue = "Send ReportMail";
            PC.Description = txtMailAddress.Text;
            lstpagecontextkeys.Add(PC);
            long res = -1;


            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    grdResult.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    res = AM.PerformingNextStepNotification(PC, sw.ToString(), rptDate + "~" + EmailTo);
                }

            }
            if (res >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Email Sent Successfully');", true);
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Send SendMail", ex);
        }

    }

    protected void btnSendmail_Click(object sender, EventArgs e)
    {
        long rCode = -1;
        modalpopupsendemail.Show();
        try
        {
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrg = new List<Organization>();
            rCode = objBl.pGetOrgLoction(out lstOrg);
            if (lstOrg.Count > 0)
            {
                if (!String.IsNullOrEmpty(lstOrg[0].Email) && lstOrg[0].Email.Length > 0)
                {
                    txtMailAddress.Text = lstOrg[0].Email.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetOrgLoction", ex);
        }

    }

    protected void btnProfile_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[1].HeaderText = "Profile";
        LoadProfileGrid();
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
}
