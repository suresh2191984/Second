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
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Solution.BusinessComponent;
using Attune.Podium.ExcelExportManager;
using System.Collections.Generic;
using System.IO;



public partial class Reports_MonthwiseDischargeReport : BasePage
{

    long returnCode = -1;
    DataSet ds = new DataSet();
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    protected void Page_Load(object sender, EventArgs e)
    {

        txtDisFMon.Attributes.Add("onchange", "ExcedDate('" + txtDisFMon.ClientID.ToString() + "','',0,0);");
        txtDisTMon.Attributes.Add("onchange", "ExcedDate('" + txtDisTMon.ClientID.ToString() + "','',0,0); ExcedDate('" + txtDisTMon.ClientID.ToString() + "','txtDisFMon',1,1);");

        if (!IsPostBack)
        {
            txtDisFMon.Text = System.DateTime.Today.ToString("MM/yyyy");
            txtDisTMon.Text = System.DateTime.Today.ToString("MM/yyyy");
        }



    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("Period");
        DataColumn dcol2 = new DataColumn("OpeningBalance");
        DataColumn dcol3 = new DataColumn("AdmitedPatient");
        DataColumn dcol4 = new DataColumn("DischargedPatient");
        DataColumn dcol5 = new DataColumn("ClosingBalance");

        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);
        dt.Columns.Add(dcol4);
        dt.Columns.Add(dcol5);

        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["Period"] = item.Period;
            dr["OpeningBalance"] = item.OpeningBalance;
            dr["AdmitedPatient"] = item.AdmitedPatient;
            dr["DischargedPatient"] = item.DischargedPatient;
            dr["ClosingBalance"] = item.ClosingBalance;

            dt.Rows.Add(dr);
        }
        return dt;

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();

            DateTime fDate = Convert.ToDateTime(txtDisFMon.Text);
            DateTime tDate = Convert.ToDateTime(txtDisTMon.Text);
            returnCode = new Report_BL(base.ContextInfo).GetMonthWiseDischargeReport(fDate, tDate, OrgID, out lstday);

            if (lstday.Count > 0)
            {
                //lstday = lstDWCR;
                //DataTable dt = loaddata(lstday);
                //ds.Tables.Add(dt);
                gvMonthwiseDischargeRpt.Visible = true;
                gvMonthwiseDischargeRpt.DataSource = lstday;
                gvMonthwiseDischargeRpt.DataBind();
                divPrint.Style.Add("display", "block");

            }
            else
            {
                gvMonthwiseDischargeRpt.Visible = false;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Matching Records found for the selected dates');", true);
            }

            ViewState["report"] = ds;
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, MonthWiseDischrgeReport", ex);
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
    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        btnSubmit_Click(sender, e);
        ExportToExcel(gvMonthwiseDischargeRpt);
    }
    public void ExportToExcel(Control CTRl)
    {
        Response.Clear();
        Response.AddHeader("content-disposition",
        string.Format("attachment;filename={0}.xls", "MonthWiseDischrge Report"));
        Response.Charset = "";
        Response.ContentType = "application/vnd.xls";
        StringWriter stringWrite = new StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        gvMonthwiseDischargeRpt.RenderControl(htmlWrite);
        Response.Write(stringWrite.ToString());
        Response.End();

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }



}
