using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using Attune.Utilitie.Helper;
using System.Security.Cryptography;
using Attune.Podium.PerformingNextAction;
using System.Data;
using System.Globalization;
using System.Xml.Serialization;
using System.Text;
using System.Xml.Xsl;

public partial class Reports_TestStatisticsReport : BasePage
{

    public Reports_TestStatisticsReport()
        : base("Reports_TestStatisticsReport_aspx")
    {

    }
    string strselect = Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_01 == null ? "--Select--" : Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_01;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtenderClient.ContextKey = "CLI";
        if (!IsPostBack)
        { 
            LoadMetaData();
            List< OrganizationAddress> lstOrgAdd=new List<OrganizationAddress> ();
            AdminReports_BL objBL = new AdminReports_BL(base.ContextInfo);
            objBL.pGetOrganizationLocation(base.ContextInfo.OrgID, 0, 1, out lstOrgAdd);
            ddlLocations.DataSource = lstOrgAdd;
            ddlLocations.DataTextField = "Location";
            ddlLocations.DataValueField = "AddressID";
            ddlLocations.DataBind();
            ddlLocations.Items.Insert(0, new ListItem(strselect,"0"));
        }
        txtToDate.Attributes.Add("onchange", "ValidDate('" + txtFromDate.ClientID.ToString() + "','" + txtToDate.ClientID.ToString() + "');");
    }
    public void LoadMetaData()
    {
       
        try
        {
            long returncode = -1;
            //string domains = "TestRoutineBatch,LocationType";
            string domains = "TestRoutineBatch";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TestRoutineBatch"
                                 select child;
                ddlRoutineStat.DataSource = childItems;
                ddlRoutineStat.DataTextField = "DisplayText";
                ddlRoutineStat.DataValueField = "Code";
                ddlRoutineStat.DataBind();
                ddlRoutineStat.SelectedValue = "3";

                //var LocationType = from child in lstmetadataOutput
                //                   where child.Domain == "LocationType"
                //                 select child;
                //ddlLocations.DataSource = LocationType;
                //ddlLocations.DataTextField = "DisplayText";
                //ddlLocations.DataValueField = "Code";
                //ddlLocations.DataBind();
                //ddlLocations.Items.Insert(0,strselect);
               // ddlLocations.SelectedValue = "3";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
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
    //protected void btnConverttoXL_OnClick(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        Response.AddHeader("Content-Disposition", "attachment;filename=download.xls");
    //        ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "ExportExcel", "javascript:Exportexcel();", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while btnConverttoXL_OnClick Method in TestStatisticsReport.aspx.cs Page", ex);
    //    }
    //}

    //protected void imgBtnXL_Click(object sender, EventArgs e)
    //{
    //    ExportToExcel(divPrint);
    //}

    //public void ExportToExcel(Control ctr)
    //{
    //    //export to excel
    //    try
    //    {
    //        string rptDate = "TestStatisticsReport" + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
    //        string attachment = "attachment; filename=" + rptDate + ".xls";
    //        Response.ClearContent();
    //        Response.AddHeader("content-disposition", attachment);
    //        Response.ContentType = "application/ms-excel";
    //        Response.Charset = "UTF-8";
    //        this.EnableViewState = false;
    //        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
    //        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
    //        BindGridView();
    //        divPrint.Visible = true;
    //        ctr.RenderControl(oHtmlTextWriter);
    //        Response.Write(oStringWriter.ToString());
    //        Response.End();
    //        divPrint.Visible = false;
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }

    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //}
    //protected void BindGridView()
    //{
    //    Master_BL obj = new Master_BL(base.ContextInfo);
    //    DateTime pfromDate = DateTime.ParseExact(txtFromDate.Text, "MM/dd/yyyy", CultureInfo.CurrentUICulture);
    //    DateTime pToDate = DateTime.ParseExact(txtToDate.Text, "MM/dd/yyyy", CultureInfo.CurrentUICulture);
    //    ArrayList NewArray = new ArrayList();
    //    long returncode = -1;
    //    imgBtnXL.Visible = true;
    //    DataSet DtTestStatistics = new DataSet();
    //    List<TestStatistics> lstTestStatistics = new List<TestStatistics>();
    //    returncode = obj.GetTestStatReport(pfromDate, pToDate, out DtTestStatistics);
    //    NewArray.Add(DtTestStatistics);
    //    returncode = Utilities.ConvertTo(DtTestStatistics.Tables[0], out lstTestStatistics);
    //    gvTestStatReport.DataSource = lstTestStatistics;
    //    gvTestStatReport.DataBind();
    //} 

    //protected void btnPrint_OnClick(object sender, EventArgs e)
    //{
    //    BindGridView();
    //    divPrint.Visible = true;
    //    ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "ExportExcel", "javascript:popupprint();", true);
    //}
}
