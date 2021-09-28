using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Text;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;


public partial class Reports_CommunicableDiseaseReport : BasePage
{
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        //binddropdown();
        if (!IsPostBack)
        {
            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        }
    }

    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        Report_BL reportBL = new Report_BL(base.ContextInfo);
        List<PatientVisit> patientVisit = new List<PatientVisit>();
        DateTime fromdate = Convert.ToDateTime(txtFrom.Text);
        DateTime todate = Convert.ToDateTime(txtTo.Text);
        string ddlvalue;
        if (ddlICDCode.SelectedValue == "All")
        {
            ddlvalue = "";
        }
        else
        {
            ddlvalue = ddlICDCode.SelectedValue;
        }
        returnCode = reportBL.GetCommunicableDiseasesReport(OrgID, fromdate, todate, ddlvalue, out patientVisit);
        var varICD = (from res in patientVisit
                      select res.ICDCode).Distinct();
        List<PatientVisit> patientVisit1 = new List<PatientVisit>();
        foreach (var test in varICD)
        {
            PatientVisit obj = new PatientVisit();
            obj.ICDCode = test;
            patientVisit1.Add(obj);
        }
        if (patientVisit1.Count() > 0)
        {
            icddrop.Visible = true;
            ddlICDCode.DataSource = patientVisit1;
            ddlICDCode.DataValueField = "ICDCode";
            ddlICDCode.DataTextField = "ICDCode";
            ddlICDCode.DataBind();
            ListItem li = new ListItem();
            li.Value = "All";
            li.Text = "All";
            li.Selected = true;
            ddlICDCode.Items.Add(li);
        }
        if (patientVisit.Count > 0)
        {
            grdResult.Visible = true;
            grdResult.DataSource = patientVisit;
            grdResult.DataBind();

            //str = lbl.Text.ToString();
            //dt.TableName = str;

            foreach (GridViewRow item in grdResult.Rows)
            {
                Label l1 = (Label)item.FindControl("lblgrdVisitType");
                if (l1.Text == "0")
                    l1.Text = "OP";
                if (l1.Text == "1")
                    l1.Text = "IP";
            }
            lblResult.Visible = false;
            lblResult.Text = "";
        }
        else
        {
            grdResult.Visible = false;
            icddrop.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found";
        }
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Admin/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    #region BindICDCode & Name
    public void binddropdown()
    {
        Report_BL reportBL = new Report_BL(base.ContextInfo);
        List<CommunicableDiseaseMaster> cds = new List<CommunicableDiseaseMaster>();
        reportBL.GetCommunicableDiseasesICD(OrgID, out cds);
        if (cds.Count > 0)
        {
            ArrayList alist = new ArrayList();
            string lstCDS;
            foreach (CommunicableDiseaseMaster item in cds)
            {
                lstCDS = item.ICDCode + " ~ " + item.ICDName;
                alist.Add(lstCDS);
            }
            ddlICDCode.DataSource = alist;
            ddlICDCode.DataBind();
            ddlICDCode.Items.Insert(0, new ListItem("--All--", "-1"));
        }
    }
     
    #endregion
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "TPA/Corp Outstanding Report.xls"));
            HttpContext.Current.Response.ContentType = "application/ms-excel";
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    btnSearch_Click(sender, e);
                    grdResult.RenderControl(htw);
                    //gvIPCreditMain.RenderEndTag(htw);
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();


                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured while converting to Excel", ex);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

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
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string add = "", tempadd = "";
            Label lblAddress = (Label)e.Row.FindControl("lblAddress");
            add = lblAddress.Text.Replace(",", " ").Trim();
            tempadd = add.ToString().Replace("    ", "");
            tempadd = tempadd.ToString().Replace("  ", ",");
            lblAddress.Text = tempadd;
        }
    }
}
