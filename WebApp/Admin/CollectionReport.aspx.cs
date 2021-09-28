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

public partial class Admin_CollectionReport : BasePage
{
    long returnCode = -1;
    string deptName = string.Empty;
    string visitType = string.Empty;
    DateTime visitdate =DateTime.MinValue;
    DateTime visitFdate = DateTime.MinValue;
    DateTime visitTdate = DateTime.MinValue;

    decimal pTotalItemAmt = -1;
    decimal pTotalDiscount = -1;
    decimal pTotalNetValue = -1;
    decimal pTotalReceivedAmt = -1;
    decimal pTotalDue = -1;
    decimal pTax = -1;
    decimal pServiceCharge = -1;

    IEnumerable<DayWiseCollectionReport> temp;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    List<DayWiseCollectionReport> lst = new List<DayWiseCollectionReport>();

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnEmpty_Click(object sender, EventArgs e)
    {
        fnCall();
    }
    
    protected void fnCall()
    {
        long retCode = -1;
        DateTime pFDT;
        string strFromDate = string.Empty;
        if (Request.QueryString["FromDate"] != null)
        {
            strFromDate = Request.QueryString["FromDate"].ToString();
        }
        string strToDate = string.Empty;
        if (Request.QueryString["ToDate"] != null)
        {
            strToDate = Request.QueryString["ToDate"].ToString();
        }
        string strType = string.Empty;
        if (Request.QueryString["SType"] != null)
        {
            strType = Request.QueryString["SType"].ToString();
        }
        DateTime.TryParse(strFromDate, out pFDT);
        DateTime pTDT;
        DateTime.TryParse(strToDate, out pTDT);
        List<ReceivedAmount> lstBillingDetails = new List<ReceivedAmount>();
        DataTable dtUser = new DataTable();
        DataColumn dbCol1 = new DataColumn("LoginID");
        dtUser.Columns.Add(dbCol1);
        DataRow dr;
        string[] strUserid = hdnUserIDs.Value.Split('~');
        for (int i = 0; i < strUserid.Count()-1; i++)
        {
            dr = dtUser.NewRow();
            dr["LoginID"] = Convert.ToInt64(strUserid[i]);
            dtUser.Rows.Add(dr);
        }
        retCode = new BillingEngine(base.ContextInfo).GetTransactionByType(pFDT, pTDT, OrgID, dtUser, strType, out lstBillingDetails);
        if (lstBillingDetails.Count() > 0)
        {
            gvPayDet.DataSource = lstBillingDetails;
            gvPayDet.DataBind();
        }
    }
}
