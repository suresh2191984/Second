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
using System.Drawing;
using System.Globalization;


using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using System.Collections;


public partial class Reports_HomecollectionCancelledReport : BasePage
{
    long loginID = 0;
    decimal total;
    protected void Page_Load(object sender, EventArgs e)
    {
        // AutocompleteGetUserName.ContextKey = "Y";
        try
        {

            if (!IsPostBack)
            {
                txtFDate.Text = OrgTimeZone;
                txtbxtodate.Text = OrgTimeZone;
            }


            ddlstatusall.Enabled = false;


        }


        catch (Exception ex)
        {
            CLogger.LogError("Error while page Load", ex);
        }

    }


    protected void btnExcel_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (GVhomecollectcancel.Rows.Count > 0)
            {
                string attachment = "attachment; filename=HomeCollectionCancelled_Report" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
                Response.ClearContent();
                Response.AddHeader("content-disposition", attachment);
                Response.ContentType = "application/ms-excel";
                Response.Charset = "";
                this.EnableViewState = false;
                System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
                System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
                GVhomecollectcancel.RenderControl(oHtmlTextWriter);
                Response.Write(oStringWriter.ToString());
                Response.End();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Converting to Excel.", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void GVhomecollectcancel_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            total += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Amount"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblamount = (Label)e.Row.FindControl("lblTotal");
            lblamount.Text = total.ToString();
        }
    }

    protected void btnSubmit_onclick(object sender, EventArgs e)
    {
        try
        {
            string FromDate = (txtFDate.Text.ToString());
            string ToDate = (txtbxtodate.Text.ToString());
            DateTime TodateLoc;
            DateTime FrmdateLoc;
            if (hdnLoginID.Value == "")
            {
                loginID = 0;
            }
            else
            {
                loginID = Convert.ToInt64(hdnLoginID.Value);
            }
            //DateTime.TryParse(FromDate, out FrmdateLoc);
            //DateTime.TryParse(ToDate, out TodateLoc);
            FrmdateLoc = DateTime.ParseExact(txtFDate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            TodateLoc = DateTime.ParseExact(txtbxtodate.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
            string status = "C";

            Attune.Solution.BusinessComponent.Report_BL objReportExcel = new Attune.Solution.BusinessComponent.Report_BL(base.ContextInfo);

            List<HomeCollectionCancel> lstGetHomeCollectionCancelledReport = new List<HomeCollectionCancel>();
            long result = objReportExcel.GetHomeCollectionCancelledReport(loginID, status, FrmdateLoc, TodateLoc, out lstGetHomeCollectionCancelledReport);

            if (lstGetHomeCollectionCancelledReport.Count() > 0)
            {
                divOPDWCR.Attributes.Add("style", "block");
                divOPDWCR.Visible = true;
                GVhomecollectcancel.Visible = true;
                GVhomecollectcancel.DataSource = lstGetHomeCollectionCancelledReport;
                GVhomecollectcancel.DataBind();
                btnExcel.Visible = true;
            }

            hdnLoginID.Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  Load on btnSubmit_onclick", ex);
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
}
