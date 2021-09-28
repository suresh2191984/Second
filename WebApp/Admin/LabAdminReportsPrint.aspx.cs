using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
public partial class Admin_LabAdminReportsPrint : System.Web.UI.Page
{
    string pClientID;
    string frmDate;
    string toDate;
    long returnCode = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //pClientID = Request.QueryString["cid"].ToString();
        //string clientID = string.Empty;
        //string strPatientName = string.Empty;
        //string strBillFromDate = string.Empty;
        //string strBillNo = string.Empty;
        //string strDrName = string.Empty;
        //string strHospitalName = string.Empty;
        //string strBillToDate = string.Empty;
        //clientID = pClientID;
        //string clientName = Request.QueryString["cname"].ToString();
        //clientPackage.Text = clientName;
        //frmDate = Request.QueryString["frmDate"].ToString();
        //toDate = Request.QueryString["toDate"].ToString();

        //int clientID;
        //string strPatientName = string.Empty;
        //DateTime dtBillFromDate = DateTime.MinValue;
        //DateTime dtBillToDate = DateTime.MinValue;
        //long lBillNo = 0;
        //string strDrName = string.Empty;
        //string strHospitalName = string.Empty;
        //long returnCode = -1;

        //Int32.TryParse(ddlClient.SelectedValue.ToString(), out clientID);
        //DateTime.TryParse(txtFrom.Text, out dtBillFromDate);
        //DateTime.TryParse(txtTo.Text, out dtBillToDate);
        //List<BillSearch> billSearch = new List<BillSearch>();
        //Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        try
        {
        //    returnCode = patientBL.SearchBill(lBillNo, dtBillFromDate, dtBillToDate, strPatientName, strDrName, strHospitalName, clientID, out billSearch);
        }
        catch
        {
        }
        //if (returnCode == 0 && billSearch.Count > 0)
        //{
        //    grdResult.Visible = true;
        //    grdResult.DataSource = billSearch;
        //    grdResult.DataBind();
        //}
        //else
        //{
        //    grdResult.Visible = false;
        //}
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        GridViewRow row = grdResult.SelectedRow;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdResult.PageIndex = e.NewPageIndex;
    }
}
