using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data.SqlClient;

public partial class Reports_GeneralReports : BasePage
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
                txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
                loadTotalVisitCount();
                //txtFDate.Text = Convert.ToString(System.DateTime.Today.DayOfWeek);
        }
    }
    //27/12/1998
    
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }

    }

    private void loadTotalVisitCount()
    {
        long returnCode = -1;
        DateTime today = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        List<CusTrackerReport> FrToVisitCount = new List<CusTrackerReport>();
        Report_BL ReportBL = new Report_BL(base.ContextInfo);
        DateTime fdate = Convert.ToDateTime(txtFDate.Text);
        DateTime tdate = Convert.ToDateTime(txtTDate.Text);
        returnCode = ReportBL.CustomerTrackerTVC(fdate, tdate, out FrToVisitCount);
        grdResult.DataSource = FrToVisitCount;
        grdResult.DataBind();
        grdResult.Visible = true;
        //GrdHeader.Style.Add("display", "block");
        int pargrdcnt = FrToVisitCount.Count;
        int i=0;
        foreach (CusTrackerReport item in FrToVisitCount)
        {
            List<CusTrackerReport> DetailedOPRpt = new List<CusTrackerReport>();
            List<CusTrackerReport> DetailedIPRpt = new List<CusTrackerReport>();
            List<CusTrackerReport> DischDtlrpt = new List<CusTrackerReport>();
            int DischargeSummaryCount = -1;
            int PatientsDischarged = -1;
            HdnitemOID.Value = item.OrgID.ToString();
            HdnitemOAID.Value = item.orgAddressID.ToString();
            long returncode = -1;
            int orgid = Convert.ToInt32(HdnitemOID.Value);
            int orgaddrid = Convert.ToInt32(HdnitemOAID.Value);
            returncode = ReportBL.CustomerTrackerDetRpt(fdate, tdate, orgid, orgaddrid, out DetailedOPRpt, out DetailedIPRpt, out DischDtlrpt, out DischargeSummaryCount, out PatientsDischarged);

            GridView ChildGridOP = (GridView)grdResult.Rows[i].FindControl("ChildGridOP");
            ChildGridOP.DataSource = DetailedOPRpt;
            ChildGridOP.DataBind();
            ChildGridOP.Visible = true;

            GridView ChildGridIP = (GridView)grdResult.Rows[i].FindControl("ChildGridIP");
            ChildGridIP.DataSource = DetailedIPRpt;
            ChildGridIP.DataBind();
            ChildGridIP.Visible = true;

            GridView ChildGridDS = (GridView)grdResult.Rows[i].FindControl("ChildGridDS");
            ChildGridDS.DataSource = DischDtlrpt;
            ChildGridDS.DataBind();
            ChildGridDS.Visible = true;
            i++;
        }
        
    }

    //protected void ChildGrid_RowDataBound(Object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {

    //    }
    //    catch (Exception Ex)
    //    {
    //        CLogger.LogError("Error while report generation", Ex);
    //    }
    //}

    //protected void ChildGridOP_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView ChildGridOP = (GridView)grdResult.Rows[Convert.ToInt32(HdnID.Value)].FindControl("ChildGridOP");
    //    long returnCode;
    //    DateTime today = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //    DateTime fdate = Convert.ToDateTime(txtFDate.Text);
    //    DateTime tdate = Convert.ToDateTime(txtTDate.Text);

    //    if (e.NewPageIndex == ChildGridOP.PageCount)
    //    {
           
    //        try
    //        {
    //            ImageButton ibtnNext = (ImageButton)(ChildGridOP.BottomPagerRow.FindControl("lnkNext"));
    //            if (ibtnNext != null) ibtnNext.Visible = false;
    //        }
    //        catch (Exception ex)
    //        {
    //            ImageButton ibtnPrev = (ImageButton)(ChildGridOP.BottomPagerRow.FindControl("lnkPrev"));
    //            if (ibtnPrev != null) ibtnPrev.Visible = false;
    //        }
    //    }
    //    if (e.NewPageIndex >= 0)
    //    {
    //        List<CusTrackerReport> DetailedOPRpt = new List<CusTrackerReport>();
    //        List<CusTrackerReport> DetailedIPRpt = new List<CusTrackerReport>();
    //        long returncode = -1;
    //        int orgid = Convert.ToInt32(HdnitemOID.Value);
    //        int orgaddrid = Convert.ToInt32(HdnitemOAID.Value);
    //        returncode = new Report_BL(base.ContextInfo).CustomerTrackerDetRpt(fdate, tdate, orgid, orgaddrid, out DetailedOPRpt, out DetailedIPRpt);
    //        ChildGridOP.PageIndex = e.NewPageIndex;
    //        ChildGridOP.DataSource = DetailedOPRpt;
    //        ChildGridOP.DataBind();

    //        //ChildGridIP.PageIndex = e.NewPageIndex;
    //        //ChildGridIP.DataSource = DetailedOPRpt;
    //        //ChildGridIP.DataBind();
    //    }

    //}


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        loadTotalVisitCount();
    }
   
    protected void grdResult_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    //private void loadDetRpt()
    //{
    //    int rID = Convert.ToInt32(HdnID.Value);
    //    HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
    //    //HtmlControl NoRecordDiv1 = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("NoRecord");
    //    ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClickcl");
    //    imgBTN.ImageUrl = "~/Images/collapse.jpg";
    //    Div1.Style.Add("display", "block");
    //    List<CusTrackerReport> DetailedOPRpt = new List<CusTrackerReport>();
    //    List<CusTrackerReport> DetailedIPRpt = new List<CusTrackerReport>();
    //    Report_BL ReportBL = new Report_BL(base.ContextInfo);
    //    int RowIndex = Convert.ToInt32(grdResult);
    //    HdnitemOID.Value = grdResult.DataKeys[RowIndex][0].ToString();
    //    HdnitemOAID.Value = grdResult.DataKeys[RowIndex][1].ToString();
    //    long returnCode = -1;
    //    DateTime today = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //    DateTime fdate = Convert.ToDateTime(txtFDate.Text);
    //    DateTime tdate = Convert.ToDateTime(txtTDate.Text);
    //    int orgid = Convert.ToInt32(HdnitemOID.Value);
    //    int orgaddrid = Convert.ToInt32(HdnitemOAID.Value);
    //    returnCode = ReportBL.CustomerTrackerDetRpt(fdate, tdate, orgid, orgaddrid, out DetailedOPRpt, out DetailedIPRpt);

    //    GridView ChildGridOP = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGridOP");
    //    ChildGridOP.DataSource = DetailedOPRpt;
    //    ChildGridOP.DataBind();
    //    ChildGridOP.Visible = true;

    //    GridView ChildGridIP = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGridIP");
    //    ChildGridIP.DataSource = DetailedIPRpt;
    //    ChildGridIP.DataBind();
    //    ChildGridIP.Visible = true;
    //}

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
            //e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            //e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
            //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
        }
        
    }

    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.grdResult.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
        }
        base.Render(writer);
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            HdnID.Value = e.CommandArgument.ToString();
            if (HdnID.Value != string.Empty)
            {
                if (HdnID.Value != e.CommandArgument.ToString())
                {
                    int rID = Convert.ToInt32(HdnID.Value);
                    //HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                    //HtmlControl Div2 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChildDS");
                    ////HtmlControl NoRecordDiv1 = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("NoRecord");
                    //ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                    //imgBTN.ImageUrl = "~/Images/collapse.jpg";
                    //Div1.Style.Add("display", "none");
                    //Div2.Style.Add("display", "none");
                }
            }

            if (e.CommandArgument.ToString() != "")
            {
               
               // ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
               // imgBTN.ImageUrl = "~/Images/expand.jpg";
               // HtmlControl Div1 = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
               // string[] str = (Div1.Attributes["style"].ToString()).Split(';');
               // if (str[0] == "display:block")
               // {
               //     Div1.Style.Add("display", "none");
               //     imgBTN.ImageUrl = "~/Images/expand.jpg";
               // }
               // else if (str[0] == "display:none" || str[0] == "display: none")
               //{ 
               //     Div1.Style.Add("display", "block");
               //     imgBTN.ImageUrl = "~/Images/collapse.jpg";
               //     //imgBTNnxt.Focus();
               // }

               // HtmlControl Div2 = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChildDS");
               // string[] str2 = (Div2.Attributes["style"].ToString()).Split(';');
               // if (str2[0] == "display:block")
               // {
               //     Div2.Style.Add("display", "none");
               //     imgBTN.ImageUrl = "~/Images/expand.jpg";
               // }
               // else if (str2[0] == "display:none")
               // {
               //     Div2.Style.Add("display", "block");
               //     imgBTN.ImageUrl = "~/Images/collapse.jpg";
               //     //imgBTNnxt.Focus();
               // }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Customer Tracker Report", ex);
        }
    }
}
