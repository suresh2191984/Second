using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using Attune.Utilitie.Helper;

public partial class Reports_AdvanceCollectionRefundDetails : BasePage
{

    List<AdvanceClientDetails> lstCollectionsHistory = new List<AdvanceClientDetails>();
    public Reports_AdvanceCollectionRefundDetails()
        : base("Reports\\AdvanceCollectionRefundDetails.aspx")
    {
    }
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            divFooterNav.Visible = false;
            Page.Form.DefaultButton = btnSearch.UniqueID;
            AutoCompleteExtender1.ContextKey = "3";

        }


    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        //Allows for printing
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            currentPageNo = 1;
            PageSize = 10;
            loadGrid(currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtClientNameSrch.Text = "";
        txtFromDate.Text = "";
        txtToDate.Text = "";
        clear();
    }
    public void loadGrid(int GridPageNo, int GridPageSize)
    {
        try
        {
            clear();
            long returnCode = -1;
            Page.Form.DefaultButton = btnSearch.UniqueID;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            long ClientID = 0;
            if (hdnClientID.Value != "")
            {
                ClientID = Convert.ToInt64(hdnClientID.Value);
            }

            string type = ddlType.SelectedItem.ToString();

            string fromdate = hdnFromDate.Value.ToString();
            string todate = hdnToDate.Value.ToString();

            returnCode = patientBL.SearchAdvanceClientDetails(OrgID, ClientID, type, fromdate, todate, GridPageNo, GridPageSize, out lstCollectionsHistory);
            if (lstCollectionsHistory.Count > 0)
            {
                if (type == "Refund")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                    totalRows = lstCollectionsHistory[0].TotalRows;
                    lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                    gridRefund.DataSource = lstCollectionsHistory;
                    gridRefund.DataBind();
                    PrintgridRefund.DataSource = lstCollectionsHistory;
                    PrintgridRefund.DataBind();
                    PrintgrdResult.DataSource = null;
                    PrintgrdResult.DataBind();
                    txtFromDate.Text = hdnFromDate.Value.ToString();
                    txtToDate.Text = hdnToDate.Value.ToString();
                    divFooterNav.Visible = true;
                }
                else
                {
                    lblCurrent.Text = currentPageNo.ToString();
                    totalRows = lstCollectionsHistory[0].TotalRows;
                    lblTotal.Text = CalculateTotalPages(totalRows).ToString();

                    grdResult.DataSource = lstCollectionsHistory;
                    grdResult.DataBind();
                    PrintgrdResult.DataSource = lstCollectionsHistory;
                    PrintgrdResult.DataBind();
                    PrintgridRefund.DataSource = null;
                    PrintgridRefund.DataBind();
                    txtFromDate.Text = hdnFromDate.Value.ToString();
                    txtToDate.Text = hdnToDate.Value.ToString();
                    divFooterNav.Visible = true;
                }
                if (currentPageNo == 1)
                {
                    Btn_Previous.Enabled = false;

                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        Btn_Next.Enabled = true;
                    }
                    else
                        Btn_Next.Enabled = false;

                }

                else
                {
                    Btn_Previous.Enabled = true;

                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        Btn_Next.Enabled = false;
                    else Btn_Next.Enabled = true;
                }
            }
            else
            {
                divFooterNav.Visible = false;
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>alert('No Records Found.');</script>", false);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
    }
    private void clear()
    {
        
        gridRefund.DataSource = null;
        gridRefund.DataBind();
        grdResult.DataSource = null;
        grdResult.DataBind();
        PrintgrdResult.DataSource = null;
        PrintgrdResult.DataBind();
        PrintgridRefund.DataSource = null;
        PrintgridRefund.DataBind();
        divFooterNav.Visible = false;

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
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        if (grdResult.Rows.Count > 0)
        {
            ExportToExcel(tralldetails);
        }

        else if (gridRefund.Rows.Count > 0)
        {
            ExportToExcel(trbeakupdetails);
        }
        else
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>alert('No Records are Found');</script>", false);

        }
    }
    public void ExportToExcel(Control ctr)
    {
        try
        {
            grdResult.AllowPaging = false;
            loadGrid(0, 0);
            string prefix = string.Empty;
            prefix = "Client Wise Advance Collection and Refund Reports_";
            string rptDate = prefix + OrgTimeZone;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>Client Wise Advance Collection and Refund Reports</span>");

            tralldetails.RenderControl(oHtmlTextWriter);
            trbeakupdetails.RenderControl(oHtmlTextWriter);
            //ctr.RenderControl(oHtmlTextWriter);
            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            grdResult.AllowPaging = false;
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        try
        {

            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            loadGrid(currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        try
        {


            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            loadGrid(currentPageNo, PageSize);


        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            hdnCurrent.Value = txtpageNo.Text;
            int ar = Convert.ToInt32(txtpageNo.Text);

            Int32.TryParse(txtpageNo.Text, out ar);

            if (ar != 0)
            {
                loadGrid(ar, PageSize);
            }
            else
            {
                loadGrid(currentPageNo, PageSize);
            }
            txtpageNo.Text = "";

        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }

    }

}
