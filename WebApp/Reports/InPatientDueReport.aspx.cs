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
using System.Data;
using System.IO;

public partial class Reports_InPatientDueReport : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    DataSet ds = new DataSet();
    decimal pTotalDueAmt = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalBilledAmt = -1;
    decimal pTotalGross = -1;
    decimal pTotalPharmacyBill = -1;
    decimal pTotalHospitalBill = -1;
    decimal pTotalPharmacyReceived = -1;
    decimal pTotalHospitalReceived = -1;
    decimal pTotalPharmacyRefund = -1;
    decimal pTotalHospitalRefund = -1;
    int currentPageNo = 1;
    int PageSize = 25;
    int totalRows = 0;
    int totalpage = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {

            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }

    public void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            int visitType = 1;
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            string IsCreditBill = Rbltypeofpatient.SelectedValue.ToString();

            returnCode = new Report_BL(base.ContextInfo).GetInpatientDueReport(fDate, tDate, OrgID, visitType, IsCreditBill, PageSize, currentPageNo, out totalRows, out lstDWCR);

            if (lstDWCR.Count > 0)
            {
                gvIPCreditMain.DataSource = lstDWCR;
                gvIPCreditMain.DataBind();
                
                GrdFooter.Style.Add("display", "block");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();


                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }

                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;

                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;

                }

                else
                {
                    btnPrevious.Enabled = true;

                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
                 
            }
            else
            {
                gvIPCreditMain.DataSource = "";
                gvIPCreditMain.DataBind();
                GrdFooter.Style.Add("display", "none");
                

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        LoadGrid(e, currentPageNo, PageSize);
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
    public override void VerifyRenderingInServerForm(Control control)
    {
        //don't delete this method
        // Confirms that an HtmlForm control is rendered for the
        // specified ASP.NET server control at run time.

    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        ExportToXL();
    }
    public void ExportToXL()
    {

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=Expesnses Report.xls");

        Response.Charset = "";

        // If you want the option to open the Excel file without saving than

        // comment out the line below

        // Response.Cache.SetCacheability(HttpCacheability.NoCache);

        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();

        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

        gvIPCreditMain.RenderControl(htmlWrite);

        Response.Write(stringWrite.ToString());

        Response.End();
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {

        ExportToXL();
    }






    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {


        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblIPNummber = (Label)e.Row.FindControl("lblIPNummber");
            if (lblIPNummber.Text == "")
                lblIPNummber.Text = "-";
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            pTotalBilledAmt = lstDWCR.Sum(p => p.ActualBilled);
            pTotalReceivedAmt = lstDWCR.Sum(p => p.AmountReceived);
            pTotalDueAmt = lstDWCR.Sum(p => p.Due);
            pTotalPharmacyBill = lstDWCR.Sum(p => p.Pharmacy);
            pTotalPharmacyReceived = lstDWCR.Sum(p => p.PRMReceived);
            pTotalPharmacyRefund = lstDWCR.Sum(p => p.PRMRefund);
            pTotalHospitalBill = lstDWCR.Sum(p => p.BillAmount);
            pTotalHospitalReceived = lstDWCR.Sum(p => p.HOSReceived);
            pTotalHospitalRefund = lstDWCR.Sum(p => p.HOSRefund);
            e.Row.Cells[9].Text = "<b>Total:</b>";
            e.Row.Cells[10].Text = pTotalBilledAmt.ToString("0.00");
            e.Row.Cells[11].Text = pTotalPharmacyBill.ToString("0.00");
            e.Row.Cells[12].Text = pTotalHospitalBill.ToString("0.00");
            e.Row.Cells[13].Text = pTotalPharmacyReceived.ToString("0.00");
            e.Row.Cells[14].Text = pTotalHospitalReceived.ToString("0.00");
            e.Row.Cells[15].Text = pTotalPharmacyRefund.ToString("0.00");
            e.Row.Cells[16].Text = pTotalHospitalRefund.ToString("0.00");
            e.Row.Cells[17].Text = pTotalReceivedAmt.ToString("0.00");
            e.Row.Cells[18].Text = pTotalDueAmt.ToString("0.00");

         


        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoadGrid(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";

    }
}
