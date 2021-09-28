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

public partial class Reports_BillsforthedayReport : BasePage
{
    long returnCode = -1;
    List<BillsfortheDayReport> lstBillReportList = new List<BillsfortheDayReport>();
    List<BillsfortheDayReport> lstFiftyBillReportList = new List<BillsfortheDayReport>();
    string SearchTypeTestWise = "TestWise";
    string SearchTypeClientWise = "ClientWise";
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    decimal Totcount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "^" + "0";
            modalpopupsendemail.Hide();
            LoadCountry();
           
           
        }
        pnl.Visible = false;
       
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[3].HeaderText = "Test / Profile";
        this.grdResultFifty.Columns[3].HeaderText = "Test / Profile";
        LoadGrid();
        LoadGridTopFifty();
        
    }
    public void LoadGridTopFifty()
    {

        try
        {
            modalpopupsendemail.Hide();
            pnl.Visible = true;
            btnPrintAll.Visible = true;
            btnPrintAllClient.Visible = false;
            btnConverttoXL.Visible = true;
            btnConverttoClientXL.Visible = false;
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
          //  returnCode = new ReportExcel_BL(base.ContextInfo).GetBillsfortheDayReport(SearchTypeTestWise, strBillFromDate, strBillToDate, 0, out lstFiftyBillReportList, out lstBillReportList);
            grdResultFifty.Width = 600;
            grdResultFifty.Visible = true;
            grdResultFifty.DataSource = lstFiftyBillReportList;
            grdResultFifty.DataBind();
            if (lstBillReportList.Count > 1)
            {
                grdResultFifty.HeaderRow.Cells[2].Text = "Test / Profile";
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
            CLogger.LogError("Error while Loading GetBillsfortheDayReport", ex);
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
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
            long CountryID = 0;
            if (ddlCountry.SelectedItem.Text != "--Select--")
            {
                CountryID = Convert.ToInt64(hdnCountryID.Value);
            }
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetBillsfortheDayReport(SearchTypeTestWise, strBillFromDate, strBillToDate, ClientID, CountryID, out lstFiftyBillReportList, out lstBillReportList);
            grdResult.Width = 600;
            grdResult.Visible = true;
            grdResult.DataSource = lstBillReportList;
            grdResult.DataBind();
            if (lstBillReportList.Count > 1)
            {
                grdResult.HeaderRow.Cells[2].Text = "Test / Profile";
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
            CLogger.LogError("Error while Loading GetBillsfortheDayReport", ex);
        }
    }

    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
    }

    protected void btnConverttoClientXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToClientExcel();
    }

    public void ExportToClientExcel()
    {
        try
        {
            string str = "Period wise collection Data";
            string FromDate = txtFrom.Text;
            string ToDate = txtTo.Text;
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix + FromDate + " to " + ToDate;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            StringWriter sw = new StringWriter();
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            LoadClientGrid();
           // grdResult.AllowPaging = false;
           // grdResult.DataBind();

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

    public void ExportToExcel()
    
    {
        try
        {
            string str = "Period wise collection Data";
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
            LoadGrid();
          //  grdResult.AllowPaging = false;
         //   grdResult.DataBind();

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

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
              //  e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                Label lnkFeeDescription = (Label)e.Row.FindControl("lnkFeeDescription");
                Label lnkCountryName = (Label)e.Row.FindControl("lnkCountryName");
               
                if (lnkFeeDescription.Text == "Total")
                {
                    e.Row.Font.Bold = true;
                  //  e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }

                
                if (lnkCountryName.Text == "Total")
                {
                    e.Row.Font.Bold = true;
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }
                

      
            }        

           



        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading BillsfortheDay Reports", Ex);
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

    protected void btnClientSearch_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[3].HeaderText = "Client";
        this.grdResultFifty.Columns[3].HeaderText = "Client";
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
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
          //  returnCode = new ReportExcel_BL(base.ContextInfo).GetBillsfortheDayReport(SearchTypeClientWise, strBillFromDate, strBillToDate, ClientID,out lstFiftyBillReportList, out lstBillReportList);
            grdResultFifty.Width = 600;
            grdResultFifty.Visible = true;
            grdResultFifty.DataSource = lstFiftyBillReportList;
            grdResultFifty.DataBind();
            if (lstBillReportList.Count > 1)
            {
                grdResultFifty.HeaderRow.Cells[2].Text = "Client";
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
            CLogger.LogError("Error while Loading GetBillsfortheDayReport", ex);
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
            strBillFromDate = txtFrom.Text;
            strBillToDate = txtTo.Text;
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
            long CountryID = Convert.ToInt64(hdnCountryID.Value);
            returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetBillsfortheDayReport(SearchTypeClientWise, strBillFromDate, strBillToDate, ClientID, CountryID, out lstFiftyBillReportList, out lstBillReportList);
            grdResult.Width = 600;
            grdResult.Visible = true;
            grdResult.DataSource = lstBillReportList;
            grdResult.DataBind();
            if (lstBillReportList.Count > 1)
            {
                grdResult.HeaderRow.Cells[2].Text = "Client";
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
            CLogger.LogError("Error while Loading GetBillsfortheDayReport", ex);
        }
    }

    protected void btnPrintAllClient_Click(object sender, EventArgs e)
    {
        try
        {
            LoadClientGrid();
            //grdResult.AllowPaging = false;
          //  grdResult.DataBind();
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
            //grdResult.AllowPaging = true;
            //grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
    }

    protected void btnPrintAll_Click(object sender, EventArgs e)
    {
        try
        {
            LoadGrid();
            //grdResult.AllowPaging = false;
            // grdResult.DataBind();
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
          //  grdResult.AllowPaging = true;
           // grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
    }

    protected void btnSendMailReport_Click(object sender, EventArgs e)
    {
        
        //long ReturnCode = -1;
        //string EmailTo = String.Empty;
        //EmailTo = txtMailAddress.Text; 
        //using (StringWriter sw = new StringWriter())
        //{
        //    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
        //    {
        //        grdResult.RenderControl(hw);
        //        StringReader sr = new StringReader(sw.ToString());
        //        List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
        //        MailConfig oMailConfig = new MailConfig();
        //        ActionManager OBJ = new ActionManager();
        //        OBJ.GetEMailConfig(OrgID, out oMailConfig);
        //        if (!String.IsNullOrEmpty(oMailConfig.FromAddress) && oMailConfig.FromAddress != "")
        //        {
        //            ReturnCode = Communication.SendMail(EmailTo, "", "", "BillsforthedayReport", sw.ToString() + "<div style='font-family:Verdana;font-size:12;'><p></p><div><br><br>Sincerely,<br><strong><br>" + OrgName + "<br/>" + "</strong></div></div>", lstMailAttachment, oMailConfig);
        //        }
        //    }

        //}     
        try
        {
        string EmailTo = String.Empty;
        EmailTo = txtMailAddress.Text;
        string str = "Period wise collection Data";
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
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Email Sent Successfully');", true);
        }
        divPrint1.Attributes.Add("Style", "display:none");
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


    protected void grdResultFifty_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               // e.Row.BackColor = System.Drawing.Color.PapayaWhip;
                e.Row.Font.Size = 8;

                Label lnkFeeDescription = (Label)e.Row.FindControl("lnkFeeDescription");
                Label lnkCountryName = (Label)e.Row.FindControl("lnkCountryName");

                if (lnkFeeDescription.Text == "Total")
                {
                    e.Row.Font.Bold = true;
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }

                if (lnkCountryName.Text == "Total")
                {
                    e.Row.Font.Bold = true;
                 //   e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }

                if (lnkFeeDescription.Text == "Sum")
                {
                    e.Row.Font.Bold = true;
                 //   e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }


                if (lnkCountryName.Text == "Sum")
                {
                    e.Row.Font.Bold = true;
                //    e.Row.BackColor = System.Drawing.Color.Wheat;
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                }



            }





        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading BillsfortheDay Reports", Ex);
        }

    }

    protected void LoadCountry()
    {
        long returnCode = -1;
        ReportBusinessLogic.ReportExcel_BL countryBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
        List<Country> countries = new List<Country>();
      

        Country selectedCountry = new Country();
        ddlCountry.Items.Clear();
        int countryID = 0;
        try
        {
            //lblCountryCode
            returnCode = countryBL.GetClientMappedCountryNames(OrgID,out countries);
            ddlCountry.DataSource = countries;
            ddlCountry.DataTextField = "CountryName";
            ddlCountry.DataValueField = "CountryID";
            ddlCountry.DataBind();
            ddlCountry.Items.Insert(0, "--Select--");
          
           
           

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
        hdnSelectedClientID.Value = "0";
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
