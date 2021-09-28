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
public partial class Reports_wardoccupancyreport : BasePage
{
    public Reports_wardoccupancyreport()
        : base("Reports\\wardoccupancyreport.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<WardOccupancy> lstward = new List<WardOccupancy>();
    long returnCode = -1;
    int currentPageNo = 1;
    int PageSize = 15;
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
    }
    protected void gvReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                WardOccupancy ward = (WardOccupancy)e.Row.DataItem;

                var child = from s in lstward
                            where s.VisitDate == ward.VisitDate && s.FloorName==ward.FloorName
                            select s;                
                
                GridView gvchild = (GridView)e.Row.FindControl("gvwardReport");
                gvchild.AllowPaging = false;
                gvchild.DataSource = child;
                gvchild.DataBind();                         
            }  
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in gvIPReport_RowDataBound", ex);
        }
    }    
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                WardOccupancy ward = (WardOccupancy)e.Row.DataItem;

                var child = from s in lstward
                            where s.VisitDate == ward.VisitDate
                            select s;

                GridView gvchild = (GridView)e.Row.FindControl("gvReport");
                gvchild.DataSource = child;
                gvchild.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in gvIPReport_RowDataBound", ex);
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
            returnCode = new Report_BL(base.ContextInfo).GetWardOccupancyReport(fDate, tDate, OrgID, PageSize, currentPageNo,out totalRows, out lstward);
            if (rblReportType.Text == "0")
            {
                gvIPReport.Visible = false;
            }
            else
            {
                if (lstward.Count > 0)
                {
                    gvIPReport.DataSource = lstward;
                    gvIPReport.DataBind();
                    gvIPReport.Visible = true;


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
                    gvIPReport.DataSource = "";
                    gvIPReport.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in submit click", ex);
        }
    }
    
    protected void gvIPReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvIPReport.PageIndex = e.NewPageIndex;
                currentPageNo = e.NewPageIndex;
                LoadGrid(e, currentPageNo, PageSize);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in gvIPReport_SelectedIndexChanged", ex);
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
