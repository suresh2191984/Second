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


public partial class Admin_PhysicianwiseCollectionReport : BasePage
{
    long returnCode = -1;
    AdminReports_BL arBL;
    List<CashFlowSummary> lstCashFlowSummary = new List<CashFlowSummary>();
    List<CashFlowSummary> lstCashFlowSummary1 = new List<CashFlowSummary>();
    List<CashFlowSummary> lstCashFlowSummary2 = new List<CashFlowSummary>();
    List<CashFlowSummary> lstCashFlowSummarySubTotal = new List<CashFlowSummary>();

    Physician_BL PhysicianBL;
    List<Physician> lstPhysician = new List<Physician>();
    decimal totalCollectionAmount = 0;
    decimal totalDiscountAmount = 0;
    decimal totalRefundAmount = 0;
    decimal totalOrganisationAmount = 0;
    decimal totalPhysicianAmount = 0;
    int PagewisePatientCount=0;
    static string physician = string.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            arBL = new AdminReports_BL(base.ContextInfo);
            PhysicianBL = new Physician_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0);
                LoadPhysicians(lstPhysician);
                txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            }
                  }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in PhysicianwiseCollectionReport.aspx:Page_Load", ex);
        }
    }

    protected void btnGo_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        decimal net = decimal.Zero;
        DateTime dFromDate = Convert.ToDateTime(txtFrom.Text);
        DateTime dToDate = Convert.ToDateTime(txtTo.Text);
        long physicianID = Convert.ToInt64(ddlDrName.SelectedValue);
        arBL.GetPhysicianWiseCollectionSummary(OrgID, physicianID, dFromDate, dToDate, rblIsCreditBill.SelectedValue, out lstCashFlowSummary, out lstCashFlowSummarySubTotal);
        lstCashFlowSummary1 = lstCashFlowSummary;
        if (lstCashFlowSummary.Count > 0)
        {
            
            var childItems = (from child in lstCashFlowSummary select child.PhysicianName).Distinct();
            foreach (var list in childItems)
            {
                CashFlowSummary obj = new CashFlowSummary();
                obj.PhysicianName = list;
                lstCashFlowSummary2.Add(obj);
            }
            divPrint.Attributes.Add("style", "block");
            divPrint.Visible = true;
            grdResult.Visible = true;
            lblResult.Visible = false;
            //commented by sami
            //btnConverttoXL.Visible = true;
            grdResult.DataSource = lstCashFlowSummary2;
            grdResult.DataBind();
            //loaddata(lstCashFlowSummary1);
            
            tabPageTotal.Style.Add("display", "block");
            tabGrandTotal.Style.Add("display", "block");
            tdCollectionAmount.InnerText = totalCollectionAmount.ToString("0.00");
            tdDiscountAmount.InnerText=totalDiscountAmount.ToString("0.00");
            tdRefundAmount.InnerText=totalRefundAmount.ToString("0.00");
            tdOrganisationAmount.InnerText = totalOrganisationAmount.ToString("0.00");
            tdPhysicianAmount.InnerText = totalPhysicianAmount.ToString("0.00");
            lblPTC.Text = "( " + PagewisePatientCount.ToString() + " Patient )";
            tabGrandTotal.Style.Add("display", "block");
            if (OrgID == 131)
            {
                tdscalc.Visible = true;
                lbltdsamt.Text = Convert.ToString(totalPhysicianAmount * 10 / 100);
                net = Convert.ToDecimal(totalPhysicianAmount) - Convert.ToDecimal(lbltdsamt.Text);
                lblnettotal.Text = Convert.ToString(net);
            }

            var GrandTotal = from lstCFS in lstCashFlowSummarySubTotal
                             group lstCFS by lstCFS.VisitType into g
                             select new { 
                                 CashFlowSummarySubTotal = g.Key,
                                 Amount = g.Sum(p => p.Amount),
                                 DiscountAmount=g.Sum(p=>p.DiscountAmount),
                                 RefundAmount=g.Sum(p=>p.RefundAmount),
                                 AmountToHostingOrg = g.Sum(p => p.AmountToHostingOrg),
                                 PhysicianAmount = g.Sum(p => p.PhysicianAmount),
                                 TotalPatientCount = g.Sum(p => p.Quantity), };

            foreach (var GrandTotalList in GrandTotal)
            {
                tdTCollectionAmount.InnerText = GrandTotalList.Amount.ToString("0.00");
                tdTDiscountAmount.InnerText = GrandTotalList.DiscountAmount.ToString("0.00");
                tdTRefundAmount.InnerText = GrandTotalList.RefundAmount.ToString("0.00");
                tdTOrganisationAmount.InnerText = GrandTotalList.AmountToHostingOrg.ToString("0.00");
                tdTPhysicianAmount.InnerText = GrandTotalList.PhysicianAmount.ToString("0.00");
                lblTPC.Text = "( " + GrandTotalList.TotalPatientCount.ToString() + " Patient )";
            }
        }
        else
        {
            divPrint.Attributes.Add("style", "none");
            divPrint.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
            //btnConverttoXL.Visible = false;
            grdResult.Visible = false;
            tabPageTotal.Style.Add("display", "none");
            tabGrandTotal.Style.Add("display", "none");
        }        
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }
    protected void grdChildResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label isCreditBill = (Label)e.Row.FindControl("isCreditBill");
                CashFlowSummary BMaster = (CashFlowSummary)e.Row.DataItem;
                //var phy = from child in lstCashFlowSummary1
                //          where child.PhysicianName == physician
                //          select child;
                //foreach (var list in phy)
                //{
                //    if (list.IsCreditBill == "Y")
                //    {
                //        isCreditBill.Text = "Credit";
                //    }
                //    else
                //    {
                //        isCreditBill.Text = "Non-Credit";
                //    }

                //}
                if (BMaster.IsCreditBill == "Y")
                {
                    isCreditBill.Text = "Credit";
                }
                else
                {
                    isCreditBill.Text = "Paid";
                }

            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianWiseCollectionReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CashFlowSummary BMaster = (CashFlowSummary)e.Row.DataItem;
                var childItems = from child in lstCashFlowSummary1
                                 where child.PhysicianName == BMaster.PhysicianName
                                 select child;
                physician = BMaster.PhysicianName;
               
                
                foreach (var List in childItems)
                {
                     totalCollectionAmount += List.Amount;
                     totalDiscountAmount += List.DiscountAmount;
                     totalRefundAmount += List.RefundAmount;
                     totalOrganisationAmount += List.AmountToHostingOrg;
                     totalPhysicianAmount += List.PhysicianAmount;
                     PagewisePatientCount += List.Quantity;
                }
                GridView childGrid = (GridView)e.Row.FindControl("grdChildResult");
                childGrid.DataSource = childItems;

                childGrid.DataBind();

                Label lblSubTotal = (Label)e.Row.FindControl("lblSubTotal");
                Label lblQty = (Label)e.Row.FindControl("lblQty");
                Label lblCA = (Label)e.Row.FindControl("lblCA");
                Label lblDA = (Label)e.Row.FindControl("lblDA");
                Label lblRA = (Label)e.Row.FindControl("lblRA");
                Label lblAmtToOrg = (Label)e.Row.FindControl("lblAmtToOrg");
                Label lblAmtToPhy = (Label)e.Row.FindControl("lblAmtToPhy");
                Label lblPhy = (Label)e.Row.FindControl("lblPhy");
                //Label isCreditBill = (Label)e.Row.FindControl("isCreditBill");
                

                var SubTotal = from child in lstCashFlowSummarySubTotal
                               where child.PhysicianName == BMaster.PhysicianName
                               select child;

                //Table tdPhysican = (Table)e.Row.FindControl("tdPhysican");

                int qty = 0;
                decimal amt=0;
                decimal disAmt = 0;
                decimal refundAmt = 0;
                decimal amtorg = 0;
                decimal pamt = 0;
                foreach (var SubList in SubTotal)
                {
                     lblSubTotal.Text =SubList.VisitType;
                     qty += SubList.Quantity;
                     amt +=SubList.Amount;
                     disAmt += SubList.DiscountAmount;
                     refundAmt += SubList.RefundAmount;
                     amtorg += SubList.AmountToHostingOrg;
                     pamt += SubList.PhysicianAmount;
                     if (SubList.DiscountAmount > 0 || SubList.RefundAmount>0)
                     {
                         childGrid.BackColor = System.Drawing.Color.GreenYellow;
                     }
                    
                }
                lblQty.Text = qty.ToString(); ;
                lblCA.Text = amt.ToString();
                lblDA.Text = disAmt.ToString();
                lblRA.Text = refundAmt.ToString();
                lblAmtToOrg.Text = amtorg.ToString();
                lblAmtToPhy.Text =pamt.ToString();
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading PhysicianWiseCollectionReports Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    public void LoadPhysicians(List<Physician> phySch)
    {
        if (phySch.Count > 0)
        {
            //code added for fixing bug - Begins
            var lstphy = (from phy in phySch select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
            //code added for fixing bug - ends
            ddlDrName.DataSource = lstphy;
            ddlDrName.DataTextField = "PhysicianName";
            ddlDrName.DataValueField = "PhysicianID";
            ddlDrName.DataBind();
            ddlDrName.Items.Insert(0, "-----Show All-----");
            ddlDrName.Items[0].Value = "0";
        }
    }

    //public DataTable loaddata(List<CashFlowSummary> lstCFS)
    //{
    //    DataTable dt = new DataTable();

    //    // DataColumn dcol1 = new DataColumn("BillingDetailsID");
    //    //DataColumn dcol2 = new DataColumn("Amount");
    //    //DataColumn dcol3 = new DataColumn("Quantity");
    //    //DataColumn dcol4 = new DataColumn("VisitType");
    //    //DataColumn dcol5 = new DataColumn("VisitDate");
    //    //DataColumn dcol6 = new DataColumn("PatientName");
    //    //DataColumn dcol7 = new DataColumn("CommisionToOrg");
    //    //DataColumn dcol8 = new DataColumn("AmountToHostingOrg");
    //    DataColumn dcol9 = new DataColumn("PhysicianAmount");
    //    DataColumn dcol10 = new DataColumn("PhysicianName");
    //    DataColumn dcol11 = new DataColumn("PhysicianID");
    //    DataColumn dcol12 = new DataColumn("DiscountAmount");
    //    //DataColumn dcol13 = new DataColumn("CollectionDate");
    //    DataColumn dcol14 = new DataColumn("FeeType");
    //    //dt.Columns.Add(dcol1);
    //    //dt.Columns.Add(dcol2);
    //    //dt.Columns.Add(dcol3);
    //    //dt.Columns.Add(dcol4);
    //    //dt.Columns.Add(dcol5);
    //    //dt.Columns.Add(dcol6);
    //    //dt.Columns.Add(dcol7);
    //    //dt.Columns.Add(dcol8);
    //    dt.Columns.Add(dcol9);
    //    dt.Columns.Add(dcol10);
    //    dt.Columns.Add(dcol11);
    //    dt.Columns.Add(dcol12);
    //    //dt.Columns.Add(dcol13);
    //    dt.Columns.Add(dcol14);
    //    foreach (CashFlowSummary item in lstCFS)
    //    {
    //        DataRow dr = dt.NewRow();
    //        //dr["BillingDetailsID"] = item.BillingDetailsID;
    //        //dr["Amount"] = item.Amount;
    //        //dr["Quantity"]=item.Quantity;
    //        //dr["VisitType"]=item.VisitType;
    //        //dr["VisitDate"]=item.VisitDate;
    //        //dr["PatientName"]=item.PatientName;
    //        //dr["CommisionToOrg"]=item.CommisionToOrg;
    //        // dr["AmountToHostingOrg"]=item.AmountToHostingOrg;
    //        dr["PhysicianAmount"] = item.PhysicianAmount;
    //        dr["PhysicianName"] = item.PhysicianName;
    //        dr["PhysicianID"] = item.PhysicianID;
    //        dr["DiscountAmount"] = item.DiscountAmount;
    //        // dr["CollectionDate"]=item.CollectionDate;
    //        dr["FeeType"] = item.FeeType;
    //        dt.Rows.Add(dr);

    //    }
    //    ViewState["report"] = dt;
    //    return dt;
    //}
    public DataTable loaddata(List<CashFlowSummary> lstCFS)
    {
        DataTable dt = new DataTable();

        DataColumn dcol1 = new DataColumn("PhysicianName");
        DataColumn dcol2 = new DataColumn("PaymentType");
        DataColumn dcol3 = new DataColumn("Visit Type");
        DataColumn dcol4 = new DataColumn("No's");
        DataColumn dcol5 = new DataColumn("Collection Amount");
        DataColumn dcol6 = new DataColumn("Amount To Organisation");
        DataColumn dcol7 = new DataColumn("Amount To Physician");
        DataColumn dcol8 = new DataColumn("DiscountAmount");
        
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);
        dt.Columns.Add(dcol6);
        dt.Columns.Add(dcol7);
       // dt.Columns.Add(dcol8);
        foreach (CashFlowSummary item in lstCFS)
        {
            DataRow dr = dt.NewRow();

            dr["PhysicianName"] =item.PhysicianName;
           // dr["PaymentType"]=item.FeeType;
            if (item.IsCreditBill == "Y")
            {
                dr["PaymentType"] = "Credit";
            }
            else
            {
                dr["PaymentType"] = "Cash";
            }
            dr["Visit Type"]=item.VisitType;
            dr["No's"]=item.Quantity;
            dr["Collection Amount"] = item.Amount;
            dr["Amount To Organisation"] = item.AmountToHostingOrg;
            dr["Amount To Physician"] = item.PhysicianAmount;
            //dr["DiscountAmount"] = item.DiscountAmount;
            
            


            //dr["PhysicianAmount"] = item.PhysicianAmount;
            //dr["PhysicianName"] = item.PhysicianName;
            //dr["PhysicianID"] = item.PhysicianID;
            //dr["DiscountAmount"] = item.DiscountAmount;
            //// dr["CollectionDate"]=item.CollectionDate;
            //dr["FeeType"] = item.FeeType;
            dt.Rows.Add(dr);

        }
        ViewState["report"] = dt;
        return dt;
    }
    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //export to excel
            //DataTable dt = (DataTable)ViewState["report"];
            //string prefix = string.Empty;
            //prefix = "Physician_Reports_";
            //string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            //var ds = new DataSet();
            //ds.Tables.Add(dt);
            //ExcelHelper.ToExcel(ds, rptDate, Page.Response);

            grdResult.AllowPaging = false;
            btnGo_Click(sender, e);
            grdResult.DataSource = lstCashFlowSummary2;
            grdResult.DataBind();
            ExportToExcel(tabGrandTotal);
            ExportToExcel(grdResult);
            grdResult.AllowPaging = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    public void ExportToExcel(Control CTRl)
    {


        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "Physician_Reports_" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString()));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        tabGrandTotal.RenderControl(htmlWrite);
        grdResult.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

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
