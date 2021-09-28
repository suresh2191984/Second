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



public partial class Reports_ClientStaticsReport : BasePage
{
    long returnCode = -1;
    Report_BL reportBL;
    List<FinalBill> lstResult = new List<FinalBill>();
    protected void Page_Load(object sender, EventArgs e)
    {
        reportBL = new Report_BL(base.ContextInfo);
        try
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                txtToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");              
                LoadOrganizations();
                btnGo_Click(sender,e);
               
                SetContext();
            }
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in TPACORPOutstandingReport.aspx:Page_Load", ex);
        }
    }
    protected void LoadOrganizations()
    {
        try
        {
            AdminReports_BL AdminReportsBL = new AdminReports_BL(base.ContextInfo);
            List<Organization> lstOrganizations = new List<Organization>();
            long lngReturnCode = 0;
            lngReturnCode = AdminReportsBL.GetSharingOrganizations(OrgID, out lstOrganizations);

            ddlOrganization.DataSource = lstOrganizations;
            ddlOrganization.DataTextField = "Name";
            ddlOrganization.DataValueField = "OrgID";
            ddlOrganization.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InvestigationStatusReport_LoadOrganizations", ex);
        }
    }
    public void SetContext()
    {
        string ClientID = hdnClientID.Value;
        AutoCompleteExtenderClientCorp.ContextKey = "";
    }
   
    protected void btnGo_Click(object sender, EventArgs e)
    {


        int reporttype = Convert.ToInt32(rblReportType.SelectedValue);
        Int64 drpClientID = Convert.ToInt64(hdnClientID.Value);
        System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");      
        DataSet ds = new DataSet();
        reportBL.getClientStatics_Report(Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text + " 23:59:58"), OrgID, txtClient.Text,reporttype, out ds);
          
        if (ds.Tables.Count > 0 && !String.IsNullOrEmpty(txtClient.Text))
        {
            DataTable dt = new DataTable();
            dt = ds.Tables[0];
            dt.DefaultView.RowFilter = "[Client Name]='" + txtClient.Text.Trim() + "'";
            grdResult.Visible = true;           
             grdResult.DataSource = dt.DefaultView; 
             grdResult.DataBind();
          
        }
        else if (ds.Tables.Count > 0 && ddlType.SelectedItem.Text == "Cash")
        {
            
            DataTable dt = new DataTable();
            dt = ds.Tables[0];
            dt.DefaultView.RowFilter = "ISCash = 'Y'"; 
             grdResult.Visible = true;
            grdResult.DataSource = dt.DefaultView;
            grdResult.DataBind();
        }

        else if (ds.Tables.Count > 0 && ddlType.SelectedItem.Text == "Credit")
        {

            DataTable dt = new DataTable();
            dt = ds.Tables[0];
            dt.DefaultView.RowFilter = "ISCash ='N'";           
            grdResult.Visible = true;
            grdResult.DataSource = dt.DefaultView;
            grdResult.DataBind();
        }

        else if (ds.Tables.Count > 0 && !String.IsNullOrEmpty(txtClient.Text) && ddlType.SelectedItem.Text == "Cash")
        {
            DataTable dt = new DataTable();
            dt = ds.Tables[0];
        
            dt.DefaultView.RowFilter = "[Client Name]='" + txtClient.Text.Trim() + "' And ISCash = 'Y' ";
            grdResult.Visible = true;
            grdResult.DataSource = dt.DefaultView;
            grdResult.DataBind();
        }

        else if (ds.Tables.Count > 0 && !String.IsNullOrEmpty(txtClient.Text) && ddlType.SelectedItem.Text == "Credit")
        {
            DataTable dt = new DataTable();
            dt = ds.Tables[0];

            dt.DefaultView.RowFilter = "[Client Name]='" + txtClient.Text.Trim() + "' And ISCash != 'Y' ";
            grdResult.Visible = true;
            grdResult.DataSource = dt.DefaultView;
            grdResult.DataBind();
        }


        else if (ds.Tables.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = ds;
            grdResult.DataBind();
        }

        else
        {
            //grdResult.Visible = false;
            string sPath = "No Matching Records found for the selected dates";
            ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('" + sPath + "');", true);
        }
    }

    decimal c = 0;
    decimal n = 0;
    decimal d = 0;

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {



            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                Label CrossValue = (Label)e.Row.FindControl("lblUserGross");
                Label NetValue = (Label)e.Row.FindControl("lblUserNet");
                Label Discount = (Label)e.Row.FindControl("lblUserDiscount");
                c += Convert.ToDecimal(CrossValue.Text);
                n += Convert.ToDecimal(NetValue.Text);
                d += Convert.ToDecimal(Discount.Text);
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label TotalCross = (Label)e.Row.FindControl("lblCrossValue");
                Label TotalNet = (Label)e.Row.FindControl("lblNetValue");
                Label TotalDiscount = (Label)e.Row.FindControl("lblDiscount");
                TotalCross.Text = c.ToString();             
                TotalNet.Text = n.ToString();
                TotalDiscount.Text = d.ToString();
            }
                   


                
            

                
                //Table tb = new Table();
            
           

            //decimal CrossValue = 0;
            //decimal NetValue = 0;
            //decimal Discount = 0;


            //for (int i = 0; i < grdResult.Rows.Count; i++)
            //{

            //    CrossValue += Convert.ToDecimal(((Label)grdResult.Rows[i].FindControl("lblUserGross")).Text);
            //    NetValue += Convert.ToDecimal(((Label)grdResult.Rows[i].FindControl("lblUserNet")).Text);
            //    Discount += Convert.ToDecimal(((Label)grdResult.Rows[i].FindControl("lblUserDiscount")).Text);
            //    //sum += decimal.Parse(grdResult.Rows[i].Cells[3].Text);
            //}
            //lblCrossValue.Text = CrossValue.ToString();
            //lblNetValue.Text = NetValue.ToString();
            //lblDiscount.Text = Discount.ToString();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading ClientStaticsReport.", ex);
        }
    }

    protected string CalcPatientDueAmount(object NetAmount, object TPABillAmount, object ReceivedAmount)
    {
        decimal c = 0;
        c = (((decimal)NetAmount - (decimal)TPABillAmount) - (decimal)ReceivedAmount);
        //if (c < 0)
        //    c = 0;
        return c.ToString("0.00");
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

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }

    //protected void OnPaging(object sender, GridViewPageEventArgs e)
    //{
    //    grdResult.PageIndex = e.NewPageIndex;
    //    grdResult.DataBind();
    //}

    

    protected void PrintAllPages(object sender, EventArgs e)
    {
        grdResult.AllowPaging = false;
        btnGo_Click(sender, e);
        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);
        grdResult.RenderControl(hw);
        string gridHTML = sw.ToString().Replace("\"", "'")
            .Replace(System.Environment.NewLine, "");
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload = new function(){");
        sb.Append("var printWin = window.open('', '', 'left=0");
        sb.Append(",top=0,width=1000,height=600,status=0');");
        sb.Append("printWin.document.write(\"");
        sb.Append(gridHTML);
        sb.Append("\");");
        sb.Append("printWin.document.close();");
        sb.Append("printWin.focus();");
        sb.Append("printWin.print();");
        sb.Append("printWin.close();};");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(), "GridPrint", sb.ToString());
        grdResult.AllowPaging = true;
        //grdResult.DataBind();
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int reporttype = Convert.ToInt32(rblReportType.SelectedValue);
            //DateTime fDate = Convert.ToDateTime(txtFromDate.Text);
            //DateTime tDate = Convert.ToDateTime(txtToDate.Text);
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-GB");
            //DateTime dFromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone); // Convert.ToDateTime(txtFromDate.Text).ToShortDateString();
            //DateTime.TryParse(txtFromDate.Text, out dFromDate);
            //DateTime dToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            //DateTime dToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            //DateTime.TryParse(txtToDate.Text + " 23:59:58", out dToDate);
            DataSet ds = new DataSet();
            reportBL.getClientStatics_Report(Convert.ToDateTime(txtFromDate.Text), Convert.ToDateTime(txtToDate.Text + " 23:59:58"), OrgID, txtClient.Text,reporttype, out ds);
            //if (ds.Tables.Count > 0)
            //{
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ClientStaticsReport.xls"));
                HttpContext.Current.Response.ContentType = "application/ms-excel";
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                    {
                        grdResult.AllowPaging = false;
                        btnGo_Click(sender, e);
                        
                        grdResult.RenderControl(htw);
                        htw.WriteLine("<br>");
                        
                        HttpContext.Current.Response.Write(sw.ToString());
                        HttpContext.Current.Response.End();
                    }
                }
           // }
            //else
            //{
            //    string sPath = "No Matching Records found for the selected dates";
            //    ScriptManager.RegisterStartupScript(this.Page, GetType(), "alert", "alert('" + sPath + "');", true);
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Records", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}

