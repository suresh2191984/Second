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

public partial class Reports_CancelledBillReport : BasePage
{
    long returnCode = -1;
    List<CancelledBillReport> billSearch = new List<CancelledBillReport>();
    List<CancelledBillReport> FiftybillSearch = new List<CancelledBillReport>();
    string select = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_01 == null ? "--Select--" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_01;
    string objcli = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_02 == null ? "client" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_02;
    string test = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03 == null ? "Test / Profile" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_03;
    string alert = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_07 == null ? "Alert" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_07;
    string Email = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_08 == null ? "Email sent successfully" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_08;
    string cancel = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_05 == null ? "Cancelled Test Report" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_05;
    string to = Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_06 == null ? "To" : Resources.Reports_ClientDisplay.Reports_CancelledBillReport_aspx_06;
    public Reports_CancelledBillReport()
        : base("Reports_CancelledBillReports_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //txtTo.Text = DateTime.Today.ToString();
            //txtFrom.Text = DateTime.Today.ToString();
            txtFrom.Attributes.Add("onchange", "ExcedDate('" + txtFrom.ClientID.ToString() + "','',0,0);");
            txtTo.Attributes.Add("onchange", "ExcedDate('" + txtTo.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTo.ClientID.ToString() + "','txtFrom',1,1);");
            txtFrom.Text = OrgTimeZone + " 12:00:00 AM";
            txtTo.Text = OrgDateTimeZone;
            AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "^" + "0";
            modalpopupsendemail.Hide();
            LoadCountry();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[3].HeaderText = test;
        this.grdResultFifty.Columns[3].HeaderText = test;
        LoadGrid();
        LoadGridFifty();
    }

    public void LoadGridFifty()
    {
        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            btnPrintAll.Visible = true;
            btnPrintAllClient.Visible = false;
            btnConverttoXL.Visible = true;
            btnConverttoClientXL.Visible = false;           
            string strBillNo = string.Empty;
            //int strBillNo;
            string strBillFromDate = string.Empty;
            string strBillToDate = string.Empty;
            strBillNo = string.Empty;
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
          //  returnCode = new ReportExcel_BL(base.ContextInfo).CancelledBillReport(strBillNo, strBillFromDate, strBillToDate, 0, OrgID, out FiftybillSearch, out billSearch);
            grdResultFifty.Width = 600;
            grdResultFifty.Visible = true;
            grdResultFifty.DataSource = FiftybillSearch;
            grdResultFifty.DataBind();

            if (billSearch.Count > 1)
            {
                grdResultFifty.HeaderRow.Cells[2].Text = test;
                grdResultFifty.HeaderRow.Cells[4].Visible = false;
                grdResultFifty.Columns[4].Visible = false;
                divPrint1.Attributes.Add("Style", "display:block");
            }
            else
            {
                grdResultFifty.Visible = true;
                grdResultFifty.DataSource = null;
                grdResultFifty.DataBind();
                divPrint1.Attributes.Add("Style", "display:none");
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }

    public void LoadGrid()
    {
        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            btnPrintAll.Visible = true;
            btnPrintAllClient.Visible = false;
            btnConverttoXL.Visible = true;
            btnConverttoClientXL.Visible = false;            
            //ReportExcel_BL reportexcelBL = new ReportExcel_BL(base.ContextInfo);
            string SearchType = "TestWise";
            string strBillFromDate = string.Empty;
            string strBillToDate = string.Empty;            
            long CountryID=0;
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            if (hdnSelectedClientID.Value == "")
            {
                hdnSelectedClientID.Value = "0";
            }
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);            
            CountryID = Convert.ToInt64(hdnCountryID.Value);
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).CancelledBillReport(SearchType, strBillFromDate, strBillToDate, ClientID, CountryID, OrgID, out FiftybillSearch, out billSearch);
            grdResult.Width = 600;
            grdResult.Visible = true;
            grdResult.DataSource = billSearch;
            grdResult.DataBind();

            if (billSearch.Count > 1)
            {
                grdResult.HeaderRow.Cells[2].Text = test;
                grdResult.HeaderRow.Cells[4].Visible = false;
                grdResult.Columns[4].Visible = false;
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
              //  e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                Label lnkFeeDescription = (Label)e.Row.FindControl("lnkFeeDescription");
                if (lnkFeeDescription.Text == "Total")
                {
                    e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                    e.Row.Font.Bold = true;
                 //   e.Row.BackColor = System.Drawing.Color.Wheat;
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
            string str = cancel;
            string FromDate = txtFrom.Text;
            string ToDate = txtTo.Text;
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix + FromDate + " "+ to +" " + ToDate;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadGrid();           

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
            LoadGrid();            
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            grdResult.Width = 600;
            grdResult.Font.Size = 8;
            grdResult.RenderControl(hw);
            string gridHTML = sw.ToString().Replace("\"", "'")
                .Replace(System.Environment.NewLine, "");
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload = new function(){");
            sb.Append("var printWin = window.open('', '', 'left=0,right=0");
            sb.Append(",top=0,width=630,height=600,status=0,scrollbars=1');");
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
            string str = "Cancelled Test Report";
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
                    grdResultFifty.RenderControl(hw);
                    StringReader sr = new StringReader(sw.ToString());
                    res = AM.PerformingNextStepNotification(PC, sw.ToString(), rptDate + "~" + EmailTo);
                }

            }
            if (res >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + Email + "','"+alert+"');", true);
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
                lstOrg.RemoveAll(p => p.OrgID != OrgID);
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

    protected void grdResultFifty_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               // e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                Label lnkFeeDescription = (Label)e.Row.FindControl("lnkFeeDescription");
                if (lnkFeeDescription.Text == "Total")
                {
                    e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                    e.Row.Font.Bold = true;
                    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                }
                if (lnkFeeDescription.Text == "Sum")
                {
                    e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
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

    protected void LoadCountry()
    {
        long returnCode = -1;
        ReportBusinessLogic.ReportExcel_BL countryBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();


        Country selectedCountry = new Country();
        ddlCountry.Items.Clear();
        
        try
        {
            //lblCountryCode
            returnCode = countryBL.GetClientMappedCountryNames(OrgID, out countries);
            ddlCountry.DataSource = countries;
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryID";
            ddlCountry.DataBind();
            //ddlCountry.Items.Insert(0, "--Select--");
            ddlCountry.Items.Insert(0, select);




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        string CountryID = hdnCountryID.Value;
        AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "^" + CountryID;
        pnl.Visible = false;
        divPrint1.Attributes.Add("Style", "display:none");
        hdnSelectedClientID.Value = "";
    }
    protected void btnClientWise_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[3].HeaderText = objcli;
        this.grdResultFifty.Columns[3].HeaderText = objcli;
        LoadClientGrid();
        LoadClientGridFifty();
    }

    public void LoadClientGridFifty()
    {
        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            btnPrintAll.Visible = false;
            btnPrintAllClient.Visible = true;
            btnConverttoXL.Visible = false;
            btnConverttoClientXL.Visible = true;
            string strBillNo = string.Empty;
            //int strBillNo;
            string strBillFromDate = string.Empty;
            string strBillToDate = string.Empty;
            strBillNo = string.Empty;
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            //  returnCode = new ReportExcel_BL(base.ContextInfo).CancelledBillReport(strBillNo, strBillFromDate, strBillToDate, 0, OrgID, out FiftybillSearch, out billSearch);
            grdResultFifty.Width = 600;
            grdResultFifty.Visible = true;
            grdResultFifty.DataSource = FiftybillSearch;
            grdResultFifty.DataBind();

            if (billSearch.Count > 1)
            {
                grdResult.HeaderRow.Cells[2].Text = objcli;
                grdResult.HeaderRow.Cells[4].Visible = true;
                grdResult.Columns[4].Visible = true;
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

    public void LoadClientGrid()
    {
        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            btnPrintAll.Visible = false;
            btnPrintAllClient.Visible = true;
            btnConverttoXL.Visible = false;
            btnConverttoClientXL.Visible = true;
            //ReportExcel_BL reportexcelBL = new ReportExcel_BL(base.ContextInfo);
            string SearchType = "ClientWise";
            string strBillFromDate = string.Empty;
            string strBillToDate = string.Empty;
            long CountryID = 0;
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            if (hdnSelectedClientID.Value == "")
            {
                hdnSelectedClientID.Value = "0";
            }
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
            CountryID = Convert.ToInt64(hdnCountryID.Value);
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).CancelledBillReport(SearchType, strBillFromDate, strBillToDate, ClientID, CountryID, OrgID, out FiftybillSearch, out billSearch);
            grdResult.Width = 600;
            grdResult.Visible = true;
            grdResult.DataSource = billSearch;
            grdResult.DataBind();

            if (billSearch.Count > 1)
            {
                grdResultFifty.HeaderRow.Cells[2].Text = objcli;
                grdResultFifty.HeaderRow.Cells[4].Visible = true;
                grdResultFifty.Columns[4].Visible = true;

                divPrint1.Attributes.Add("Style", "display:block");
            }
            else
            {
                grdResultFifty.Visible = true;
                grdResultFifty.DataSource = null;
                grdResult.DataBind();
                divPrint1.Attributes.Add("Style", "display:none");
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

    }
    protected void btnConverttoClientXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToClientExcel();
    }

    public void ExportToClientExcel()
    {
        try
        {
            modalpopupsendemail.Hide();
            string str = "Cancelled Test Report";
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
            LoadClientGrid();

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


    protected void btnPrintAllClient_Click(object sender, EventArgs e)
    {
        try
        {
            LoadClientGrid();
            StringWriter sw = new StringWriter();
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            grdResult.Width = 600;
            grdResult.Font.Size = 8;
            grdResult.RenderControl(hw);
            string gridHTML = sw.ToString().Replace("\"", "'")
                .Replace(System.Environment.NewLine, "");
            StringBuilder sb = new StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload = new function(){");
            sb.Append("var printWin = window.open('', '', 'left=0,right=0");
            sb.Append(",top=0,width=630,height=600,status=0,scrollbars=1');");
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

