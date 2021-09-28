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
using System.IO;

public partial class Reports_MedPatientWiseBillWiseCollectionReport : BasePage
{
    long returnCode = -1;
    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    DataSet ds = new DataSet();

    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lstOverAllInfo = new List<DayWiseCollectionReport>();
    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
        masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
       
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            masterBL.GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
            if (lstCurrOrgMapp.Count > 0)
            {
                ddlCurrency.DataSource = lstCurrOrgMapp;
                ddlCurrency.DataTextField = "CurrencyName";
                ddlCurrency.DataValueField = "CurrencyID";
                ddlCurrency.DataBind();
                ddlCurrency.Items.Insert(0, "-----All-----");
                ddlCurrency.Items[0].Value = "0";
                ddlCurrency.SelectedValue = BaseCurrencyID.ToString();
                if (lstCurrOrgMapp.Count > 1)
                {
                    tabCurrency.Style.Add("display", "block");
                }
                else
                {
                    tabCurrency.Style.Add("display", "none");
                }
            }
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();

        DataColumn dcol1 = new DataColumn("BillNumber");
        DataColumn dcol2 = new DataColumn("PatientName");
        DataColumn dcol3 = new DataColumn("Age");
        DataColumn dcol4 = new DataColumn("ConsultantName");
        DataColumn dcol5 = new DataColumn("VisitDate");
        DataColumn dcol6 = new DataColumn("FeeType");
        DataColumn dcol7 = new DataColumn("BilledAmount");
        DataColumn dcol8 = new DataColumn("AmountReceived");
       
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
        dt.Columns.Add(dcol8);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();

            dr["BillNumber"] = item.BillNumber;
            dr["PatientName"] = item.PatientName;
            dr["Age"] = item.Age;
            dr["ConsultantName"] = item.ConsultantName;
            dr["VisitDate"] = item.VisitDate.ToString("dd/MMM/yy hh:mm tt");
            dr["FeeType"] = item.FeeType;
            dr["BilledAmount"] = item.BilledAmount;
            dr["AmountReceived"] = item.AmountReceived;

            dt.Rows.Add(dr);
        }
        return dt;
    }


    bool gvFlag=true;
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {

            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
               DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;

               var childItems = from child in lstDWCR

                                where child.BillNumber == RMaster.BillNumber
                                && child.FeeType == RMaster.FeeType
                                group child by new { child.FeeType, child.ConsultantName, child.BilledAmount, child.AmountReceived } into g
                                
                                select new DayWiseCollectionReport 
                                
                                {
                                    FeeType = g.Key.FeeType,
                                    ConsultantName = g.Key.ConsultantName,
                                    BilledAmount = g.Key.BilledAmount,
                                    AmountReceived = g.Key.AmountReceived,
                                    //FeeType=child.FeeType 
                                };
               //lstOverAllInfo = (from lst in lstDWCR

               //                  group lst by new { lst.FeeType, lst.BillNumber, lst.VisitDate, lst.PatientName, lst.Age, lst.PaidCurrency } into g

               //                  select new DayWiseCollectionReport
               //                  {
               //                      FeeType = g.Key.FeeType,
               //                      BillNumber = g.Key.BillNumber,
               //                      VisitDate = g.Key.VisitDate,
               //                      PatientName = g.Key.PatientName,
               //                      Age = g.Key.Age,
               //                      ItemQuantity = g.Sum(p => p.ItemQuantity),
               //                      ItemAmount = g.Sum(p => p.ItemAmount),
               //                      BilledAmount = g.Sum(p => p.BilledAmount),
               //                      AmountReceived = g.Sum(p => p.AmountReceived),
               //                      PaidCurrency = g.Key.PaidCurrency,
               //                      PaidCurrencyAmount = g.Sum(p => p.PaidCurrencyAmount),
               //                      DepositUsed = g.Sum(p => p.DepositUsed)
               //                  }
               //                 ).Distinct().ToList();                     
                  

               if (RMaster.FeeType == "Total")
               {
                   e.Row.BackColor = System.Drawing.Color.Gray;
                   e.Row.Font.Bold = true;
                   e.Row.Font.Size = 8;
                   e.Row.Cells[0].Text = "";
                  
                   e.Row.Cells[2].Text = "";
                   e.Row.Cells[3].Text = "";
                   e.Row.Cells[4].Text = "";
                  

               }    
               GridView childGrid = (GridView)e.Row.FindControl("gvDescription");



               if (gvFlag == true)
               {
                   childGrid.ShowHeader = true;
                   gvFlag = false;
               }
               else
               {
                   childGrid.ShowHeader = false;
               }

                               
               childGrid.DataSource = childItems;
               childGrid.DataBind();
               ChildGridDecorator.MergeRows(childGrid);
               }

          
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound OPCollectionReport", ex);
        }
    }
   
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
            DateTime fDate, tDate;
            DateTime.TryParse(txtFDate.Text, out fDate);
            DateTime.TryParse(txtTDate.Text, out tDate);

          
            
                returnCode = new Report_BL(base.ContextInfo).GetBillWiseDeptCollectionReport(fDate, tDate, OrgID, 0, visitType, currencyID, out lstDWCR, out pTotalItemAmt, out pTotalDiscount, out pTotalReceivedAmt, out pTotalDue, out pTax, out pServiceCharge, "0");

                lstOverAllInfo = (from lst in lstDWCR

                                  group lst by new { lst.FeeType, lst.BillNumber, lst.VisitDate, lst.PatientName, lst.Age, lst.PaidCurrency, lst.DepositUsed, lst.Discount, lst.Due, lst.AmountReceived } into g

                                  select new DayWiseCollectionReport
                                 {
                                     FeeType = g.Key.FeeType,
                                     BillNumber = g.Key.BillNumber,
                                     VisitDate = g.Key.VisitDate,
                                     PatientName = g.Key.PatientName,
                                     Age = g.Key.Age,
                                     DepositUsed = g.Key.DepositUsed,
                                     Discount = g.Key.Discount,
                                     Due = g.Key.Due,
                                     AmountReceived = g.Key.AmountReceived,
                                     ItemQuantity = g.Sum(p => p.ItemQuantity),
                                     ItemAmount = g.Sum(p => p.ItemAmount),
                                     BilledAmount = g.Sum(p => p.BilledAmount),
                                     //AmountReceived = g.Sum(p => p.AmountReceived),
                                     PaidCurrency = g.Key.PaidCurrency,
                                     PaidCurrencyAmount = g.Sum(p => p.PaidCurrencyAmount),
                                     //DepositUsed = g.Sum(p => p.DepositUsed)
                                     //DepositUsed = g.Key.DepositUsed
                                 }
                                ).Distinct().ToList();


                if (lstOverAllInfo.Count() > 0)
                {
                    gvIPReport.DataSource = lstOverAllInfo;
                    gvIPReport.DataBind();
                    gvIPReport.Visible = true;
                    DataTable dt = loaddata(lstDWCR);
                    ds.Tables.Add(dt);
                    ViewState["report"] = ds;
                    hdnXLFlag.Value = "1";
                    divPrint.Visible = true;
                }
                else
                {
                    gvIPReport.DataSource = null;
                    gvIPReport.DataBind();
                    ViewState.Remove("report");
                    hdnXLFlag.Value = "0";
                }

            }
         

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, BillWiseDeptCollectionReport", ex);
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

    protected void gvIPReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvIPReport.PageIndex = e.NewPageIndex;
            btnSubmit_Click(sender, e);
        }
    }

    protected void lnkExportXL_Click(object sender, EventArgs e)
    {
        try
        {
            gvIPReport.AllowPaging = false;
            btnSubmit_Click(sender, e);
            string prefix = string.Empty;
            prefix = "BillWiseDeptCollection_Reports_";
             
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            //HttpContext.Current.Response.Write(getReportHeader(rdostock.SelectedItem.Text == "NilStock", gvIPReport.Columns.Count));
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            gvIPReport.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
           
            gvIPReport.AllowPaging = true;
            gvIPReport.DataSource = lstOverAllInfo;
            gvIPReport.DataBind();
            Response.End();

        }
        catch (System.Threading.ThreadAbortException ex)
        {
            CLogger.LogError("Error in Convert to XL, BillWiseDeptCollectionReport", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    //public string getReportHeader(bool rptFlag, int tdCount)
    //{
    //    string strHeader = string.Empty;
    //    string rptName = string.Empty;
    //    List<Organization> lstOrganization = new List<Organization>();
    //    if (rptFlag == true)
    //    {
    //        rptName = "Nil Stock Report";
    //    }
    //    else
    //    {
    //        rptName = "Stock InHand Report";
    //    }
    //    long lresult = new Inventory_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
    //    rptName = "Sales Report";
    //    strHeader = "<center><h1>" + OrgName.ToString() + "</h1></center>";
    //    strHeader += "<center><table>";
    //    strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
    //    strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Date : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + "</td></tr>";
    //    strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
    //    strHeader += "<tr><td><br /></td></tr>";
    //    strHeader += "</table></center>";

    //    return strHeader;
    //}
 
    protected void gridView_PreRender(object sender, EventArgs e)
    {
        GridDecorator.MergeRows(gvIPReport);
    }
    protected void childGrid_PreRender(object sender, EventArgs e)
    {
        //GridView childGrid = (GridView)gvIPReport.FindControl("gvDescription");
       // ChildGridDecorator.MergeRows(childGrid);
    }
}
public class GridDecorator
{
    public static void MergeRows(GridView gridView)
    {
        decimal PAmt = 0;
        decimal CAmt = 0; 
        for (int rowIndex = gridView.Rows.Count - 3; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = gridView.Rows[rowIndex];
            GridViewRow previousRow = gridView.Rows[rowIndex + 1];
           
            if (row.Cells[0].Text == previousRow.Cells[0].Text)
            {
                //Bill Number,Patient Name,Age,Visit Date
                for (int i = 0; i < 4; i++)
                {
                    if (row.Cells[i].Text == previousRow.Cells[i].Text)
                    {
                        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                               previousRow.Cells[i].RowSpan + 1;
                        previousRow.Cells[i].Visible = false;
                    }
                }
                //BilledAmount
                for (int i = 5; i < 6; i++)
                {
                    PAmt = Convert.ToDecimal(previousRow.Cells[i].Text);
                    CAmt = Convert.ToDecimal(row.Cells[i].Text);

                    PAmt += CAmt;
                    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                           previousRow.Cells[i].RowSpan + 1;
                    previousRow.Cells[i].Visible = false;
                    row.Cells[i].Text = Convert.ToString(PAmt);
                }
               //DiscountAmount
                for (int i = 6; i < 10; i++)
                {
                    if (row.Cells[i].Text == previousRow.Cells[i].Text)
                    {
                        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                               previousRow.Cells[i].RowSpan + 1;
                        previousRow.Cells[i].Visible = false;
                    }
                }

                //for (int i = 7; i < 8; i++)
                //{
                //    PAmt = Convert.ToDecimal(previousRow.Cells[i].Text);
                //    CAmt = Convert.ToDecimal(row.Cells[i].Text);

                //    PAmt += CAmt;
                //    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                //                           previousRow.Cells[i].RowSpan + 1;
                //    previousRow.Cells[i].Visible = false;
                //    row.Cells[i].Text = Convert.ToString(PAmt);
                //}
                //for (int i = 8; i < 10; i++)
                //{
                //    if (row.Cells[i].Text == previousRow.Cells[i].Text)
                //    {
                //        row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                //                               previousRow.Cells[i].RowSpan + 1;
                //        previousRow.Cells[i].Visible = false;
                //    }
                //}
                
            }
        }
    }
}

public class ChildGridDecorator
{
    public static void MergeRows(GridView gridView)
    {
        for (int rowIndex = gridView.Rows.Count - 2; rowIndex >= 0; rowIndex--)
        {
            GridViewRow row = gridView.Rows[rowIndex];
            GridViewRow previousRow = gridView.Rows[rowIndex + 1];

            for (int i = 2; i < row.Cells.Count; i++)
            {
                if (row.Cells[i].Text == previousRow.Cells[i].Text)
                {
                    row.Cells[i].RowSpan = previousRow.Cells[i].RowSpan < 2 ? 2 :
                                           previousRow.Cells[i].RowSpan + 1;
                    previousRow.Cells[i].Visible = false;
                }
            }
        }
    }
}