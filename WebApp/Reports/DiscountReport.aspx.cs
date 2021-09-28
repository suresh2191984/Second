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

public partial class Reports_DiscountReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalDiscountAmt = -1;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            //lTotalPreDueReceived.Visible = false;
            //lblTotalPreDueReceived.Visible = false;

            //lTotalDiscount.Visible = false;
            //lblTotalDiscount.Visible = false;

            //lTotalDue.Visible = false;
            //lblTotalDue.Visible = false;

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
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
     
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
            //if (visitTypeID == 0)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //if (visitTypeID == 1)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //else if (visitTypeID == -1)
            //{
            //    e.Row.Cells[4].Visible = true;
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                var childItems = from child in lstDWCR
                                 where child.VisitDate == RMaster.VisitDate
                                 select child;

                lstday = childItems.ToList();
                Label lblTPC = (Label)e.Row.FindControl("lblTPC");
                lblTPC.Text = "(" + lstday.Count.ToString()+" Patient )";
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
                Label lblDiscountAmount = (Label)e.Row.FindControl("lblDiscountAmount");
                lblDiscountAmount.Text = childItems.Sum(p => p.TotalAmount).ToString("0.00");
            }
             
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        int reportTypeID = Convert.ToInt32(rblReportType.SelectedValue);

        if (reportTypeID == 1)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";

                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
            }
        }
        else if (reportTypeID == 0)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
                {
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[2].Text = "";
                    e.Row.Cells[3].Text = "";

                    e.Row.Style.Add("font-weight", "bold");
                    e.Row.Style.Add("color", "Black");
                }
                else
                {
                    e.Row.Visible = false;
                }
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            returnCode = new Report_BL(base.ContextInfo).GetDueandDiscount(fDate, tDate, OrgID, visitType, "DISCOUNT","","", out lstDWCR, out pTotalDiscountAmt);

            var dwcr = (from dw in lstDWCR
                        select new { dw.VisitDate }).Distinct();

            List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
            foreach (var obj in dwcr)
            {
                DayWiseCollectionReport pdc = new DayWiseCollectionReport();
                pdc.VisitDate = obj.VisitDate;
                lstDayWiseRept.Add(pdc);
            }

            if (lstDWCR.Count > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divPrint.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                divPrint.Visible = true;
                if (visitType == 0)
                {
                    //gvOPReport.Visible = false;
                    gvIPReport.Visible = true;
                    gvIPReport.Columns[0].HeaderText = "OP - Discount Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == 1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "IP - Discount Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
                else if (visitType == -1)
                {
                    gvIPReport.Visible = true;
                    //gvOPReport.Visible = false;
                    gvIPReport.Columns[0].HeaderText = "OP / IP - Discount Report";
                    gvIPReport.DataSource = lstDayWiseRept;
                    gvIPReport.DataBind();
                    CalculationPanelBlock();
                }
            }
            else
            {
                divOPDWCR.Attributes.Add("style", "none");
                divPrint.Attributes.Add("style", "none");
                divOPDWCR.Visible = false;
                divPrint.Visible = false;
                //CalculationPanelNone();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
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

    public void CalculationPanelBlock()
    {
        tabGranTotal1.Visible = true;

        lblDiscountTotal.InnerText = String.Format("{0:0.00}", (pTotalDiscountAmt));
    }

    public void CalculationPanelNone()
    {
        tabGranTotal1.Visible = false;
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TPA/Corp Outstanding Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    btnSubmit_Click(sender, e);
                    gvIPReport.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
