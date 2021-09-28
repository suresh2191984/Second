using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.DAL;
using System.Collections.Generic;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System.Drawing;


public partial class Billing_BillDetailsSearch : BasePage
{
    DateTime FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    List<ResultSearch> lstResultSearch;
    int startRowIndex = 1;
    int tempID = 0;
    int _pageSize = 200;
    long totalRows = 0;
    long totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GrdFooter.Style.Add("display", "none");
            GrdSavCancel.Style.Add("display", "none");
            lnkviewtestdetails.Visible = false;
            imgExportToExcel.Visible = false;            
            AutoCompleteExtender1.ContextKey = "0" + '^' + OrgID.ToString();
        }

    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            loadgrid(startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            loadgrid(startRowIndex, PageSize);
        }

    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            loadgrid(startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            loadgrid(startRowIndex, PageSize);
        }
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        loadgrid(Convert.ToInt32(txtpageNo.Text), PageSize);

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        startRowIndex = 1;
        hdnCurrent.Value = startRowIndex.ToString();
        try
        {

            string Visinum = "";
            string RdoResult = "Mapped";
            FromDate = Convert.ToDateTime(txtFrom.Text.ToString());
            ToDate = Convert.ToDateTime(txtTo.Text.ToString());
            lstResultSearch = new List<ResultSearch>();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            if (txtVisitNo.Text != "")
            {
                Visinum = txtVisitNo.Text;
            }

            if (RdoMissData.Checked == true)
            {
                RdoResult = "Missed";
            }
            billingEngineBL.getBillDetailSearch(txtClientName.Text, Visinum, FromDate, ToDate, OrgID, RdoResult, startRowIndex, PageSize, out totalRows, out lstResultSearch);

            if (lstResultSearch.Count != 0)
            {
                grdResult.DataSource = lstResultSearch;
                grdResult.DataBind();
                grdResult.Visible = true;
                GrdFooter.Style.Add("display", "block");
                GrdSavCancel.Style.Add("display", "block");
                lnkviewtestdetails.Visible = true;
                imgExportToExcel.Visible = true;  
            }
            else
            {
                grdResult.DataSource = lstResultSearch;
                grdResult.DataBind();
                grdResult.Visible = true;
                GrdFooter.Style.Add("display", "none");
                GrdSavCancel.Style.Add("display", "none");
                lnkviewtestdetails.Visible = false;
                imgExportToExcel.Visible = false;  
            }
            if (RdoMapData.Checked == true)
            {
                GrdSavCancel.Style.Add("display", "none");
            }
            
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();

            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = startRowIndex.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                startRowIndex = Convert.ToInt32(hdnCurrent.Value);
            }
            if (startRowIndex == 1)
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

                if (startRowIndex == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Rate Type Master ", ex);
        }
    }
    protected void Btn_Save_Click(object sender, EventArgs e)
    {
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        List<ResultSearch> lsResultSearch = new List<ResultSearch>();
        ResultSearch ObjResultSearch;


        foreach (GridViewRow row in grdResult.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                ObjResultSearch = new ResultSearch();
                CheckBox chkRow = (row.Cells[0].FindControl("chkRow") as CheckBox);

                if (chkRow.Checked)
                {
                    Label lblBillingDetailsID = (Label)row.FindControl("lblBillingDetailsID");
                    Label lblRateID = (Label)row.FindControl("lblRateID");
                    Label lblMRateID = (Label)row.FindControl("lblMRateID");
                    Label lblBaseRateID = (Label)row.FindControl("lblBaseRateID");
                    Label lblMBaseRateID = (Label)row.FindControl("lblMBaseRateID");
                    Label lblDiscountPolicyID = (Label)row.FindControl("lblDiscountPolicyID");
                    Label lblMDiscountPolicyID = (Label)row.FindControl("lblMDiscountPolicyID");
                    Label lblDiscountPercentage = (Label)row.FindControl("lblDiscountPercentage");
                    Label lblFinalBillID = (Label)row.FindControl("lblFinalBillID");
                    ObjResultSearch.BillingDetailsID = Convert.ToInt64(lblBillingDetailsID.Text == string.Empty ? "0" : lblBillingDetailsID.Text);
                    ObjResultSearch.RateID = Convert.ToInt64(lblRateID.Text == string.Empty ? "0" : lblRateID.Text);
                    ObjResultSearch.MRateID = Convert.ToInt64(lblMRateID.Text == string.Empty ? "0" : lblMRateID.Text);
                    ObjResultSearch.BaseRateID = Convert.ToInt64(lblBaseRateID.Text == string.Empty ? "0" : lblBaseRateID.Text);
                    ObjResultSearch.MBaseRateID = Convert.ToInt64(lblMBaseRateID.Text == string.Empty ? "0" : lblMBaseRateID.Text);
                    ObjResultSearch.DiscountPolicyID = Convert.ToInt64(lblDiscountPolicyID.Text == string.Empty ? "0" : lblDiscountPolicyID.Text);
                    ObjResultSearch.MDiscountPolicyID = Convert.ToInt64(lblMDiscountPolicyID.Text == string.Empty ? "0" : lblMDiscountPolicyID.Text);
                    ObjResultSearch.DiscountPercentage = Convert.ToInt64(lblDiscountPercentage.Text == string.Empty ? "0" : lblDiscountPercentage.Text);
                    ObjResultSearch.FinalBillID = Convert.ToInt64(lblFinalBillID.Text == string.Empty ? "0" : lblFinalBillID.Text);
                    ObjResultSearch.MAmount = Convert.ToDecimal(row.Cells[7].Text == string.Empty ? "0" : row.Cells[7].Text);
                    lsResultSearch.Add(ObjResultSearch);
                }
            }
        }
       // long returnCode = billingEngineBL.SaveBillDetailSearch(OrgID, lsResultSearch);
        //if (returnCode > 0)
        //{
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Updated Successfully');", true);
        //}
        btnSearch_Click(sender, e);
    }

    private void loadgrid(int startRowIndex, int PageSize)
    {
        string Visinum = "";
        string RdoResult = "Mapped";
        FromDate = Convert.ToDateTime(txtFrom.Text.ToString());
        ToDate = Convert.ToDateTime(txtTo.Text.ToString());
        lstResultSearch = new List<ResultSearch>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        if (txtVisitNo.Text != "")
        {
            Visinum = txtVisitNo.Text;
        }

        if (RdoMissData.Checked == true)
        {
            RdoResult = "Missed";
        }
        billingEngineBL.getBillDetailSearch(txtClientName.Text, Visinum, FromDate, ToDate, OrgID, RdoResult, startRowIndex, PageSize, out totalRows, out lstResultSearch);

        if (lstResultSearch.Count != 0)
        {
            grdResult.DataSource = lstResultSearch;
            grdResult.DataBind();
            grdResult.Visible = true;
            GrdFooter.Style.Add("display", "block");
            GrdSavCancel.Style.Add("display", "block");
            lnkviewtestdetails.Visible = true;
            imgExportToExcel.Visible = true;  

        }
        else
        {
            grdResult.DataSource = lstResultSearch;
            grdResult.DataBind();
            grdResult.Visible = true;
            GrdFooter.Style.Add("display", "none");
            GrdSavCancel.Style.Add("display", "none");
            lnkviewtestdetails.Visible = false;
            imgExportToExcel.Visible = false; 
        }

        totalpage = totalRows;
        lblTotal.Text = CalculateTotalPages(totalRows).ToString();

        if (hdnCurrent.Value == "")
        {
            lblCurrent.Text = startRowIndex.ToString();
        }
        else
        {
            lblCurrent.Text = hdnCurrent.Value;
            startRowIndex = Convert.ToInt32(hdnCurrent.Value);
        }
        if (startRowIndex == 1)
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

            if (startRowIndex == Int32.Parse(lblTotal.Text))
                Btn_Next.Enabled = false;
            else Btn_Next.Enabled = true;
        }
    }
    private long CalculateTotalPages(double totalRows)
    {
        long totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }
    protected void Btn_Cancel_Click(object sender, EventArgs e)
    {
        GrdFooter.Style.Add("display", "none");
        lnkviewtestdetails.Visible = false;
        imgExportToExcel.Visible = false;    
        GrdSavCancel.Style.Add("display", "none");
        grdResult.DataSource = null;
        grdResult.DataBind();
        grdResult.Visible = false;

    }
    protected void lnkExportToExcel_Click(object sender, EventArgs e)
    {
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        List<ResultSearch> lsResultSearch = new List<ResultSearch>();
        ResultSearch ObjResultSearch;
        tempID = 0;
        if (grdResult.Rows.Count > 1)
        {
            using (ExcelPackage pck = new ExcelPackage())
            {
                ExcelWorksheet ws = pck.Workbook.Worksheets.Add("Rates");
               
                foreach (GridViewRow row in grdResult.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {

                        ObjResultSearch = new ResultSearch();
                        ObjResultSearch.VisitNumber = Convert.ToString((row.Cells[1].Text.Trim() == string.Empty || row.Cells[1].Text.Trim() == "&nbsp;") ? "" : row.Cells[1].Text);
                        ObjResultSearch.VisitDate = Convert.ToDateTime(row.Cells[2].Text.Trim() == string.Empty ? DateTime.MaxValue.ToString() : row.Cells[2].Text);
                        ObjResultSearch.Name = Convert.ToString((row.Cells[3].Text.Trim() == string.Empty  || row.Cells[3].Text.Trim() == "&nbsp;")? "" : row.Cells[3].Text);
                        ObjResultSearch.FeeDescription = Convert.ToString((row.Cells[4].Text.Trim() == string.Empty  || row.Cells[4].Text.Trim() == "&nbsp;")? "" : row.Cells[4].Text);
                        ObjResultSearch.FeeType = Convert.ToString((row.Cells[5].Text.Trim() == string.Empty  || row.Cells[5].Text.Trim() == "&nbsp;") ? "" : row.Cells[5].Text);
                        ObjResultSearch.Amount = Convert.ToDecimal((row.Cells[6].Text.Trim() == string.Empty || row.Cells[6].Text.Trim() == "&nbsp;") ? "0" : row.Cells[6].Text);
                        ObjResultSearch.MAmount = Convert.ToDecimal((row.Cells[7].Text.Trim() == string.Empty  || row.Cells[7].Text.Trim() == "&nbsp;") ? "0" : row.Cells[7].Text);
                       
                        ObjResultSearch.RateCard = Convert.ToString((row.Cells[8].Text.Trim() == string.Empty  || row.Cells[8].Text.Trim() == "&nbsp;") ? "" : row.Cells[8].Text);
                        ObjResultSearch.MRatecard = Convert.ToString((row.Cells[9].Text.Trim() == string.Empty  || row.Cells[9].Text.Trim() == "&nbsp;")? "" : row.Cells[9].Text);
                        ObjResultSearch.BaseAmount = Convert.ToDecimal((row.Cells[10].Text.Trim() == string.Empty  || row.Cells[10].Text.Trim() == "&nbsp;")? "0" : row.Cells[10].Text);
                        ObjResultSearch.MBaseAmount = Convert.ToDecimal((row.Cells[11].Text.Trim() == string.Empty  || row.Cells[11].Text.Trim() == "&nbsp;")? "0" : row.Cells[11].Text);
                                   
                       
                    
                        ObjResultSearch.BaseRateCard = Convert.ToString((row.Cells[12].Text.Trim() == string.Empty  || row.Cells[12].Text.Trim() == "&nbsp;") ? "" : row.Cells[12].Text);
                        ObjResultSearch.MBaseRatecard = Convert.ToString((row.Cells[13].Text.Trim() == string.Empty  || row.Cells[13].Text.Trim() == "&nbsp;")? "" : row.Cells[13].Text);
                        ObjResultSearch.ClientName = Convert.ToString((row.Cells[14].Text.Trim() == string.Empty || row.Cells[14].Text.Trim() == "&nbsp;") ? "" : row.Cells[14].Text);
                        ObjResultSearch.DiscounCategory = Convert.ToString((row.Cells[15].Text.Trim() == string.Empty || row.Cells[15].Text.Trim() == "&nbsp;") ? "" : row.Cells[15].Text);
                        ObjResultSearch.MDiscounCategory = Convert.ToString((row.Cells[16].Text.Trim() == string.Empty || row.Cells[16].Text.Trim() == "&nbsp;")? "" : row.Cells[16].Text);
                        ObjResultSearch.DiscountPolicy = Convert.ToString((row.Cells[17].Text.Trim() == string.Empty || row.Cells[17].Text.Trim() == "&nbsp;")? "" : row.Cells[17].Text);
                        ObjResultSearch.MDiscountPolicy = Convert.ToString((row.Cells[18].Text.Trim() == string.Empty || row.Cells[18].Text.Trim() == "&nbsp;")? "" : row.Cells[18].Text);
                        lsResultSearch.Add(ObjResultSearch);

               
                    }
                }
               System.Data.DataTable dt = ConvertToDatatable1(lsResultSearch);
                var tbl = dt;
                ws.Cells["A1"].LoadFromDataTable(tbl, true);
                using (ExcelRange rng = ws.Cells["A1:R1"])
                {
                    rng.Style.Font.Bold = true;
                    rng.Style.Fill.PatternType = ExcelFillStyle.Solid;                      //Set Pattern for the background to Solid
                    rng.Style.Fill.BackgroundColor.SetColor(Color.FromArgb(79, 129, 189));  //Set color to dark blue
                    rng.Style.Font.Color.SetColor(Color.White);
                }
                var dataRange = ws.Cells[ws.Dimension.Address.ToString()];

                dataRange.AutoFitColumns();
                HttpContext.Current.Response.Clear();
                //Write it back to the client
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;  filename= ViewTestDetails - " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xlsx");

                HttpContext.Current.Response.BinaryWrite(pck.GetAsByteArray());
                //HttpContext.Current.ApplicationInstance.CompleteRequest(); 
                HttpContext.Current.Response.End();
            }
        }
    }
    public static DataTable ConvertToDatatable1(List<ResultSearch> lstClientDetails)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("VisitNumber");
        dt.Columns.Add("VisitDate");
        dt.Columns.Add("Name");
        dt.Columns.Add("FeeDescription");
        dt.Columns.Add("FeeType");
        dt.Columns.Add("Amount");
        dt.Columns.Add("MAmount");
        dt.Columns.Add("RateCard");
        dt.Columns.Add("MRatecard");
        dt.Columns.Add("BaseAmount");
        dt.Columns.Add("MBaseAmount");
        dt.Columns.Add("BaseRateCard");
        dt.Columns.Add("MBaseRatecard");
        dt.Columns.Add("ClientName");
        dt.Columns.Add("DiscounCategory");
        dt.Columns.Add("MDiscounCategory");
        dt.Columns.Add("DiscountPolicy");
        dt.Columns.Add("MDiscountPolicy");
        
            foreach (var item in lstClientDetails)
            {
                dt.Rows.Add(item.VisitNumber, item.VisitDate, item.Name, item.FeeDescription, item.FeeType, item.Amount,
                    item.MAmount, item.RateCard, item.MRatecard, item.BaseAmount, item.MBaseAmount, item.BaseRateCard,
                    item.MBaseRatecard, item.ClientName, item.DiscounCategory, item.MDiscounCategory, item.DiscountPolicy, item.MDiscountPolicy);
            }
        
        return dt;
    }
}
