using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryReports.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryReports_MedicineWiseReport:Attune_BasePage
{
    public InventoryReports_MedicineWiseReport()
        : base("InventoryReports_MedicineWiseReport_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
    List<Organization> lstOrganization = new List<Organization>();
    int currentPageNo = 1;
    int PageSize = 50;
    int totalRows = 0;
    int totalpage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        btnGo.Attributes.Add("onclick", "return checkForValues();");
        if (!IsPostBack)
        {
            txtFrom.Focus();
            txtFrom.Text = DateTimeUtility.GetServerDate().ToString("dd/MM/yyyy");
            txtTo.Text = DateTimeUtility.GetServerDate().ToString("dd/MM/yyyy");
            lblTotalAmt.Visible = false;
            lblTotalAmount.Visible = false;

        }
    }

    private void LoadLocationName()
    {
        try
        {
            List<Locations> lstLocation = new List<Locations>();
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocation);
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Location Details", Ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading DispensingReport", ex);
        }
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            LoaderDispensingReport(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";

    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoaderDispensingReport(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    string strRefAmt = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_01 == null ? "Pharmacy Total Refund Amount" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_01;
    string strItemRef = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_02 == null ? "Pharmacy Total Product Item Refund" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_02;
    string strSaleVal = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_03 == null ? "Pharmacy Total Sales value" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_03;

    public void LoaderDispensingReport(EventArgs e, int currentPageNo, int PageSize)
    {
        try
        {
            long returnCode = -1;
            DateTime fromDate = Convert.ToDateTime(txtFrom.Text);
            DateTime toDate = Convert.ToDateTime(txtTo.Text);
            //long Billno = Convert.ToInt64(txtBillNo.Text.Trim() == "" ? "-1" : txtBillNo.Text);
            string PName = txtPatientName.Text; //== "" ? "" : txtPatientName.Text;
            string Product = txtProductName.Text; //== "" ? "" : txtProductName.Text;
            hdnCurrent.Value = string.Empty;

            returnCode = new InventoryReports_BL(base.ContextInfo).GetProductWiseReport(fromDate, toDate, OrgID, PName, Product, out lstBillingDetails, PageSize, currentPageNo, out totalRows);
            if (lstBillingDetails.Count > 0)
            {
                gvResult.Visible = true;
                gvResult.DataSource = lstBillingDetails.FindAll(p=>p.Name !="Total" && p.FeeDescription !="Summary");
                gvResult.DataBind();
                lblTotalAmount.Visible = true;
                lblTotalAmt.Visible = true;
                lblPharmacytotRefund.Text = strRefAmt + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Quantity.ToString("0.00");
                lblPharmacyDateRangeRefund.Text = strItemRef + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Rate.ToString();
                lblPharmacyItemRefund.Text = strSaleVal + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Amount.ToString("0.00");
                hdnResult.Value = "1";
                divPharmacytotRefund.Visible = true;
                 totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                if (lblTotal.Text == "0")
                {
                    lblTotalAmount.Text = "0.00";
                    GrdFooter.Visible = false;
                }
                else
                {
                    GrdFooter.Visible = true;
                }

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
                gvResult.Visible = false;
                lblTotalAmount.Visible = false;
                lblTotalAmt.Visible = false;
                GrdFooter.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while loading DispensingReport", ex);
        }
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        
        return totalPages;
    }
    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }


    protected void imgBtnXL_Click(Object sender, EventArgs e)
    {
        try
        {
            gvResult.AllowPaging = false;
            LoaderDispensingReport(e, 0, 1500);
            FilterControls(gvResult);
            ExportToExcel();
            gvResult.AllowPaging = true;
            gvResult.DataSource = lstBillingDetails.FindAll(p => p.Name != "Total" && p.FeeDescription != "Summary");
            gvResult.DataBind();
            lblTotalAmount.Visible = true;
            lblTotalAmt.Visible = true;
            lblPharmacytotRefund.Text = strRefAmt + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Quantity.ToString("0.00");
            lblPharmacyDateRangeRefund.Text = strItemRef + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Rate.ToString("0.00");
            lblPharmacyItemRefund.Text = strSaleVal + " :" + lstBillingDetails.Find(p => p.Name == "Total" && p.FeeDescription == "Summary").Amount.ToString("0.00");
            divPharmacytotRefund.Visible = true;
           

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        prefix = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_06 == null ? "MedicineWiseReport_" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_06;

        string rptDate = prefix + DateTimeUtility.GetServerDate().ToShortDateString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        HttpContext.Current.Response.Write(getReportHeader(gvResult.Columns.Count));
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

        gvResult.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();


    }
    string strReportName = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_04 == null ? "Report Name" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_04;
    string strReportDate = Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_05 == null ? "Report Date" : Resources.InventoryReports_ClientDisplay.InventoryReports_MedicineWiseReport_aspx_05;

    public string getReportHeader(int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        long lresult = new Organization_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

        rptName = "<span style='font-size:14.0pt; color:block;font-weight:700;'>Dispensing Reports</span>";

        strHeader = "<center><h3>" + OrgName.ToString() + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>" + strReportName + " : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>" + strReportDate + ": " + DateTimeUtility.GetServerDate().ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "</table></center>";

        return strHeader;
    }

    public string getBlankTD(int tdCount)
    {
        string strTD = string.Empty;
        if (tdCount > 4)
        {
            tdCount -= 4;
        }
        while (tdCount > 0)
        {
            strTD += "<td></td>";
            tdCount--;
        }
        return strTD;
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
    }


    private void FilterControls(Control gvRst)
    {
        //Removing Hyperlinks and other controls b4 export

        LinkButton lb = new LinkButton();
        HyperLink hl = new HyperLink();
        Literal l = new Literal();
        string name = String.Empty;
        for (int i = 0; i < gvRst.Controls.Count; i++)
        {
            if (gvRst.Controls[i].GetType() == typeof(LinkButton))
            {
                l.Text = (gvRst.Controls[i] as LinkButton).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].GetType() == typeof(HyperLink))
            {
                l.Text = (gvRst.Controls[i] as HyperLink).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].HasControls())
            {
                FilterControls(gvRst.Controls[i]);
            }
        }
    }
    public string SetExpDateIn(string input)
    {
        if (DateTime.Parse(input) <= DateTime.Parse("01/01/1901"))
        {
            return "--";
        }
        else
        {
            return input;
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
    decimal dAmt = 0;
    protected void gvResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Footer)
            {
                //List<FinalBill> lstfb = new List<FinalBill>();
                BillingDetails IOM = (BillingDetails)e.Row.DataItem;
                //((Label)e.Row.FindControl("lblTotalAmt")).Text = IOM.BillNumber.ToString();
                dAmt = dAmt+(IOM.Rate * IOM.Quantity);
                lblTotalAmount.Text = String.Format("{0:0.00}", dAmt);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading SalesReport.", ex);
        }
    }

}