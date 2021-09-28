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
using System.Web.Script.Serialization;

public partial class Reports_RollingAdvanceClientDetails : BasePage
{

    List<AdvanceClientDetails> lstCollectionsHistory = new List<AdvanceClientDetails>();
    List<AdvanceClientDetails> lstRefundistory = new List<AdvanceClientDetails>();

    public Reports_RollingAdvanceClientDetails()
        : base("Reports\\RollingAdvanceClientDetails.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Page.Form.DefaultButton = btnSearch.UniqueID;
            /*AutoCompleteExtender1.ContextKey = "3";*/
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            loadInitialClientDatas();
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        clear();
    }
    private void clear()
    {
        /*txtClientNameSrch.Text = "";*/
        hdnClientList.Value = "";
        gvAdvanceClientDetails.DataSource = null;
        gvAdvanceClientDetails.DataBind();
        PrintgvAdvanceClientDetails.DataSource = null;
        PrintgvAdvanceClientDetails.DataBind();
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
        if (gvAdvanceClientDetails.Rows.Count > 0)
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
            prefix = "Client Wise Advance Collection and Refund Reports_";
            string rptDate = prefix + OrgTimeZone;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>Client Wise Advance Collection and Refund Reports</span>");

            tralldetails.RenderControl(oHtmlTextWriter);
            trbeakupdetails.RenderControl(oHtmlTextWriter);

            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }

    protected void gvAdvanceClientDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                /*
                int currentPageNo = 1;
                int PageSize = 10;
                */ 
                CollectionsHistory PPD = (CollectionsHistory)e.Row.DataItem;
                long pClientID = 0;
                pClientID = PPD.Identificationid;

                GridView gv1 = (GridView)e.Row.FindControl("grdResult");
                GridView gv2 = (GridView)e.Row.FindControl("gridRefund");
                
                /*long returnCode = -1;*/ 
                Page.Form.DefaultButton = btnSearch.UniqueID;
               


                /*returnCode = patientBL.SearchRollingAdvanceClientDetails(OrgID, ClientID, currentPageNo, PageSize, out lstCollectionsHistory, out lstRefundistory);*/
                List<AdvanceClientDetails> lstChildAdvanceCollection = new List<AdvanceClientDetails>();
                lstChildAdvanceCollection = (from ex in lstCollectionsHistory
                                             where ex.ClientID == pClientID
                                             group ex by new { ex.Sno, ex.ClientID, ex.ClientName, ex.DepositedDate, ex.AmountDeposited, ex.ReceiptNo, ex.CollectedBy } into g
                                             select new AdvanceClientDetails
                                             {
                                                 Sno = g.Key.Sno,
                                                 ClientID = g.Key.ClientID,
                                                 ClientName = g.Key.ClientName,
                                                 DepositedDate = g.Key.DepositedDate,
                                                 AmountDeposited = g.Key.AmountDeposited,
                                                 ReceiptNo = g.Key.ReceiptNo,
                                                 CollectedBy = g.Key.CollectedBy
                                             }).Distinct().ToList();

                if (lstCollectionsHistory.Count > 0)
                {
                    gv1.DataSource = lstChildAdvanceCollection;
                    gv1.DataBind();
                }

                List<AdvanceClientDetails> lstChildAdvanceRefund = new List<AdvanceClientDetails>();
                lstChildAdvanceRefund = (from ex in lstRefundistory
                                         where ex.ClientID == pClientID
                                         group ex by new { ex.Sno, ex.ClientID, ex.ClientName, ex.DepositedDate, ex.RefundAmount, ex.ReceiptNo, ex.RefundedBy } into g
                                         select new AdvanceClientDetails
                                         {
                                             Sno = g.Key.Sno,
                                             ClientID = g.Key.ClientID,
                                             ClientName = g.Key.ClientName,
                                             DepositedDate = g.Key.DepositedDate,
                                             RefundAmount = g.Key.RefundAmount,
                                             ReceiptNo = g.Key.ReceiptNo,
                                             RefundedBy = g.Key.RefundedBy
                                         }).Distinct().ToList();

                //  returnCode = patientBL.SearchRollingAdvanceClientDetails(OrgID, ClientID, currentPageNo, PageSize, out lstCollectionsHistory, out lstRefundistory);

                if (lstRefundistory.Count > 0)
                {
                    gv2.DataSource = lstChildAdvanceRefund;
                    gv2.DataBind();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void PrintgvAdvanceClientDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                /*
                int currentPageNo = 1;
                int PageSize = 10;
                 * */ 
                GridView gv1 = (GridView)e.Row.FindControl("PrintgrdResult");
                GridView gv2 = (GridView)e.Row.FindControl("PrintgridRefund");
                HiddenField lblclientid = (HiddenField)e.Row.FindControl("hdnPrintCntId");
                /*long returnCode = -1;*/ 
                Page.Form.DefaultButton = btnSearch.UniqueID;

                CollectionsHistory PPD = (CollectionsHistory)e.Row.DataItem;
                long pClientID = 0;
                pClientID = PPD.Identificationid; 

                List<AdvanceClientDetails> lstChildAdvanceCollection = new List<AdvanceClientDetails>();
                lstChildAdvanceCollection = (from ex in lstCollectionsHistory
                                             where ex.ClientID == pClientID
                                             group ex by new { ex.Sno, ex.ClientID, ex.ClientName, ex.DepositedDate, ex.AmountDeposited, ex.ReceiptNo, ex.CollectedBy } into g
                                             select new AdvanceClientDetails
                                             {
                                                 Sno = g.Key.Sno,
                                                 ClientID = g.Key.ClientID,
                                                 ClientName = g.Key.ClientName,
                                                 DepositedDate = g.Key.DepositedDate,
                                                 AmountDeposited = g.Key.AmountDeposited,
                                                 ReceiptNo = g.Key.ReceiptNo,
                                                 CollectedBy = g.Key.CollectedBy
                                             }).Distinct().ToList();

                if (lstCollectionsHistory.Count > 0)
                {
                    gv1.DataSource = lstChildAdvanceCollection;
                    gv1.DataBind();
                }

                List<AdvanceClientDetails> lstChildAdvanceRefund = new List<AdvanceClientDetails>();
                lstChildAdvanceRefund = (from ex in lstRefundistory
                                         where ex.ClientID == pClientID
                                         group ex by new { ex.Sno, ex.ClientID, ex.ClientName, ex.DepositedDate, ex.RefundAmount, ex.ReceiptNo, ex.RefundedBy } into g
                                         select new AdvanceClientDetails
                                   {
                                       Sno = g.Key.Sno,
                                       ClientID = g.Key.ClientID,
                                       ClientName = g.Key.ClientName,
                                       DepositedDate = g.Key.DepositedDate,
                                       RefundAmount = g.Key.RefundAmount,
                                       ReceiptNo = g.Key.ReceiptNo,
                                       RefundedBy = g.Key.RefundedBy
                                   }).Distinct().ToList();

                /*returnCode = patientBL.SearchRollingAdvanceClientDetails(OrgID, ClientID, currentPageNo, PageSize, out lstCollectionsHistory, out lstRefundistory);*/ 

                if (lstRefundistory.Count > 0)
                {
                    gv2.DataSource = lstChildAdvanceRefund;
                    gv2.DataBind();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
    }
    protected void loadInitialClientDatas()
    {
        List<DespatchMode> lstClientID = new List<DespatchMode>();

        JavaScriptSerializer serializer = new JavaScriptSerializer();

        try
        {

           
            string StrListClientIDs = String.Empty;
            StrListClientIDs = hdnClientList.Value;
            lstClientID = serializer.Deserialize<List<DespatchMode>>(StrListClientIDs);
            string s = hdnClientList.Value;
            AdvancePaid_BL objapdBL = new AdvancePaid_BL(base.ContextInfo);
            List<CollectionsHistory> lstRollingAdvance = new List<CollectionsHistory>();

            long clientid = 0;
            if (hdnClientID.Value != "")
            {
                clientid = Convert.ToInt32(hdnClientID.Value);
            }

            objapdBL.pGetClientDepositDetailsSummary(lstClientID, OrgID, out lstRollingAdvance, out lstCollectionsHistory, out lstRefundistory);

            gvAdvanceClientDetails.DataSource = lstRollingAdvance;
            gvAdvanceClientDetails.DataBind();
            PrintgvAdvanceClientDetails.DataSource = lstRollingAdvance;
            PrintgvAdvanceClientDetails.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loadInitialClientDatas", ex);
        }
    }
}
