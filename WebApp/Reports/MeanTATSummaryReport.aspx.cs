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

public partial class Reports_MeanTATSummaryReport : BasePage
{
    long returnCode = -1;
    string SearchType = string.Empty;
    string ReportsType = string.Empty;
    List<InvDeptMaster> lstDeptMaster = new List<InvDeptMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            modalpopupsendemail.Hide();
            LoadCountry();
            LoadDept();
            AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "^" + "0";
            rdopreTAT.Checked = true;
            tddept.Attributes.Add("style", "display:none");
            tddept1.Attributes.Add("style", "display:none");
        }


    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.grdResult.Columns[1].HeaderText = hdnTestType.Value;
        LoadGrid();
    }

    public void LoadGrid()
    {
        try
        {

            modalpopupsendemail.Hide();
            pnl.Visible = true;
            List<MeanTATSummaryReport> LstTAT = new List<MeanTATSummaryReport>();
            ReportBusinessLogic.ReportExcel_BL reportexcelBL = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo);
            ReportsType = hdnTestType.Value;
            SearchType = hdnSearchType.Value;
            long ClientID = Convert.ToInt64(hdnSelectedClientID.Value);
            int CountryID = 0;
            int DeptID = 0;

            if (ddlDept.SelectedValue != "ALL" || hdnDeptID.Value != "ALL")
            {
                DeptID = Convert.ToInt32(hdnDeptID.Value);
            }

            if (ddlCountry.SelectedItem.Text != "--Select--")
            {
                CountryID = Convert.ToInt32(hdnCountryID.Value);
            }

            if (rdopostTAT.Checked == true)
            {

                returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetWeeklyMeanTATReport(OrgID, ReportsType, SearchType, CountryID, ClientID, DeptID, out LstTAT);


                grdResult.Width = 600;
                grdResult.Visible = true;
                grdResult.DataSource = LstTAT;
                grdResult.DataBind();

                if (LstTAT.Count > 0)
                {
                    divPrint1.Attributes.Add("Style", "display:block");
                    tddept.Attributes.Add("style", "display:block");
                    tddept1.Attributes.Add("style", "display:block");

                }
                else
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    divPrint1.Attributes.Add("Style", "display:none");
                    tddept.Attributes.Add("style", "display:block");
                    tddept1.Attributes.Add("style", "display:block");
                }
            }
            else
            {

                returnCode = new ReportBusinessLogic.ReportExcel_BL(base.ContextInfo).GetWeeklyMeanPRETATReport(OrgID, ReportsType, SearchType, CountryID, ClientID, DeptID, out LstTAT);

                grdResult.Width = 600;
                grdResult.Visible = true;
                grdResult.DataSource = LstTAT;
                grdResult.DataBind();

                if (LstTAT.Count > 0)
                {
                    divPrint1.Attributes.Add("Style", "display:block");
                    tddept.Attributes.Add("style", "display:none");
                    tddept1.Attributes.Add("style", "display:none");


                }
                else
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = null;
                    grdResult.DataBind();
                    divPrint1.Attributes.Add("Style", "display:none");
                    tddept.Attributes.Add("style", "display:none");
                    tddept1.Attributes.Add("style", "display:none");
                }
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
                if (lnkFeeDescription.Text == "Total Mean")
                {
                    e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Right;
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
            string str = string.Empty;
            modalpopupsendemail.Hide();
            if (rdopostTAT.Checked == true)
            {
                str = "Post Analytical Weekly Mean TAT Summary";
            }
            if (rdopreTAT.Checked == true)
            {
                str = "Pre Analytical Weekly Mean TAT Summary";
            }
            string FromDate = string.Empty;
            string ToDate = string.Empty;
            string attachment = "attachment; filename=" + str + ".xls";
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
            htw.WriteLine("<span style='font-size:14.0pt; color:#E54C70;font-weight:500;font-weight: bold;'>" + str + " </span>");
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
            grdResult.Width = 600;
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
            string str = string.Empty;
            string EmailTo = String.Empty;
            EmailTo = txtMailAddress.Text;
            if (rdopostTAT.Checked == true)
            {
                str = "Post Analytical Weekly Mean TAT Summary";
            }
            if (rdopreTAT.Checked == true)
            {
                str = "Pre Analytical Weekly Mean TAT Summary";
            }
            string FromDate = string.Empty;
            string ToDate = string.Empty;
            string rptDate = string.Empty;
            rptDate = "<div style='font-family:Verdana;font-size:12;'><div><strong><br>" + str + "<br/>" + "</strong></div></div><br>";
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PageID = Convert.ToInt64(PageID);
            if (rdopostTAT.Checked == true)
            {
                PC.ButtonName = "SendPostMISReportMail";
            }
            if (rdopreTAT.Checked == true)
            {
                PC.ButtonName = "SendPreMISReportMail";
            }

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
    protected void LoadDept()
    {
        PatientVisit_BL PatientVisitBL = new PatientVisit_BL(base.ContextInfo);

        returnCode = PatientVisitBL.GetDepartment(OrgID, 0, 0, out lstInvDeptMaster, out lstDeptMaster);
        if (lstInvDeptMaster.Count > 0)
        {
            ddlDept.DataSource = lstInvDeptMaster;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptID";
            ddlDept.DataBind();
            ddlDept.Items.Insert(0, "ALL");
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
            returnCode = countryBL.GetClientMappedCountryNames(OrgID, out countries);
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
        if (hdnCountryID.Value != "0")
        {
            ddlCountry.SelectedValue = hdnCountryID.Value;
        }
        AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "^" + CountryID;
        pnl.Visible = false;
        divPrint1.Attributes.Add("Style", "display:none");
        hdnSelectedClientID.Value = "0";
    }
    protected void grdResult_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {

            GridViewRow HeaderRow = new GridViewRow(1, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell HeaderCell2 = new TableCell();

            HeaderCell2.Text = "Department - " + ddlDept.SelectedItem.Text;
            HeaderCell2.HorizontalAlign = HorizontalAlign.Center;
            HeaderCell2.ColumnSpan = 10;
            HeaderRow.Cells.Add(HeaderCell2);
            grdResult.Controls[0].Controls.AddAt(0, HeaderRow);
            HeaderRow.BackColor = System.Drawing.Color.SteelBlue;
            HeaderRow.ForeColor = System.Drawing.Color.White;
            HeaderRow.Font.Bold = true;
            if (rdopostTAT.Checked == true)
            {
                HeaderRow.Attributes.Add("style", "display:block;");
            }
            else
            {
                HeaderRow.Attributes.Add("style", "display:none;");
            }



            GridViewRow HeaderRow1 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "SI.No";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = ddlTestType.SelectedItem.Text;
            HeaderRow1.Cells.Add(HeaderCell);
            HeaderRow1.Cells[1].HorizontalAlign = HorizontalAlign.Center;

            HeaderCell = new TableCell();
            HeaderCell.Text = "W1";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W2";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W3";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W4";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W5";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W6";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W7";
            HeaderRow1.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "W8";
            HeaderRow1.Cells.Add(HeaderCell);


            HeaderRow.Attributes.Add("class", "header");
            HeaderRow1.Attributes.Add("class", "header");
            grdResult.Controls[0].Controls.AddAt(1, HeaderRow1);
            HeaderRow1.BackColor = System.Drawing.Color.SteelBlue;
            HeaderRow1.ForeColor = System.Drawing.Color.White;
            HeaderRow1.Font.Bold = true;
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
