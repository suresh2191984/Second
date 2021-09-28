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
public partial class Reports_OperationTheatre : BasePage
{
    List<WardOccupancy> lstward = new List<WardOccupancy>();
    long returnCode = -1;
    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Page_Load", ex);
        }
    }
    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        LoadGrid(e, currentPageNo, PageSize);
    }
    public void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            DateTime fDate = Convert.ToDateTime(txtFDate.Text);
            DateTime tDate = Convert.ToDateTime(txtTDate.Text);
            returnCode = new Report_BL(base.ContextInfo).GetBedBookedReport(fDate, tDate, OrgID, PageSize, currentPageNo, out totalRows, out lstward);
           
                if (lstward.Count > 0)
                {
                    grdresult.DataSource = lstward;
                    grdresult.DataBind();
                    grdresult.Visible = true;
                    lblOTReport.Visible = true;


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
                    GrdFooter.Style.Add("display", "none");
                    grdresult.DataSource = "";
                    grdresult.DataBind();
                    lblOTReport.Visible = false;
                }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in submit click", ex);
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
