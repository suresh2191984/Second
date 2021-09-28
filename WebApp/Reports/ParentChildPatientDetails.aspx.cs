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

public partial class Reports_ParentChildPatientDetails : BasePage
{
    List<AdvanceClientDetails> lstCollectionsHistory = new List<AdvanceClientDetails>();
    public Reports_ParentChildPatientDetails()
        : base("Reports\\ParentChildPatientDetails.aspx")
    {
    }

    int currentPageNo = 1;
    int PageSize = 500;
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
            AutoCompleteExtender1.ContextKey = "3";
            Page.Form.DefaultButton = btnSearch.UniqueID;
            LoadLocation();
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
            PageSize = 500;
            loadGrid(currentPageNo, PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
        ddlocations.SelectedIndex = 0;
    }

    public void loadGrid(int GridPageNo, int GridPageSize)
    {
        try
        {
            clear();
            long returnCode = -1;
            long ClientID = 0;
            Page.Form.DefaultButton = btnSearch.UniqueID;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            if (hdnClientID.Value != "")
            {
                Int64.TryParse(hdnClientID.Value, out ClientID);
            }
            long type = 0;
            Int64.TryParse(ddlocations.SelectedValue, out type);

            string fromdate = hdnFromDate.Value.ToString();
            string todate = hdnToDate.Value.ToString();
            returnCode = patientBL.SearchParentClientPatientDetails(OrgID, ClientID, type, fromdate, todate, GridPageNo, GridPageSize, out lstCollectionsHistory);
            if (lstCollectionsHistory.Count > 0)
            {

                lblCurrent.Text = currentPageNo.ToString();
                totalRows = lstCollectionsHistory[0].TotalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                grdResult.DataSource = lstCollectionsHistory;
                grdResult.DataBind();
                PrintgrdResult.DataSource = lstCollectionsHistory;
                PrintgrdResult.DataBind();
                divFooterNav.Visible = true;
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
                ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>alert('No Recors Found.');</script>", false);
            }
            txtFromDate.Text = hdnFromDate.Value.ToString();
            txtToDate.Text = hdnToDate.Value.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }

    protected void grdResult_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        var amt = lstCollectionsHistory.Sum(p => p.amount);
        if (e.Row.RowType == DataControlRowType.Footer)
        {

            Label lblGrandTotal = (Label)e.Row.FindControl("lbltotal");
            lblGrandTotal.Text = amt.ToString();
        }

    }
    protected void PrintgrdResult_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        var amt = lstCollectionsHistory.Sum(p => p.amount);
        if (e.Row.RowType == DataControlRowType.Footer)
        {

            Label lblGrandTotal = (Label)e.Row.FindControl("lbltotal");
            lblGrandTotal.Text = amt.ToString();
        }

    }

    public void LoadLocation()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlocations.DataSource = LoginLoc;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
            else
            {
                ddlocations.DataSource = lstOrganizationAddress;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
        }
        ddlocations.Items.Insert(0, "--Select--");
        ddlocations.Items[0].Value = "0";
        ddlocations.SelectedValue = Convert.ToString(ILocationID);
    }

    private void clear()
    {
        txtClientNameSrch.Text = "";
        txtFromDate.Text = "";
        txtToDate.Text = "";
        grdResult.DataSource = null;
        grdResult.DataBind();
        PrintgrdResult.DataSource = null;
        PrintgrdResult.DataBind();
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
        else
        {
            ScriptManager.RegisterStartupScript(this, typeof(Page), "Alert", "<script>alert('No Records are Found');</script>", false);
        }

    }
    public void ExportToExcel(Control ctr)
    {
        try
        {
            string prefix = string.Empty;
            prefix = "Parent Child Patient Details_";
            string rptDate = prefix + OrgTimeZone;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>Parent Child Patient Details</span>");

            tralldetails.RenderControl(oHtmlTextWriter);

            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in AdvanceClient PatientDetails Report-ExportToExcel", ioe);
        }
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

    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);







        return totalPages;
    }
}