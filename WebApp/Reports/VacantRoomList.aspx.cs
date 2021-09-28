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

public partial class Reports_VacantRoomList : BasePage
{
    long returnCode = -1;
    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    public DataSet ds = new DataSet();

    public Reports_VacantRoomList()
        : base("Reports\\VacantRoomList.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            txtFDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            txtTDate.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
        }
    }
    public DataTable loaddata(List<DayWiseCollectionReport> lstDWCR)
    {
        DataTable dt = new DataTable();
        DataColumn dcol1 = new DataColumn("RoomName");
        DataColumn dcol2 = new DataColumn("BedName");
        DataColumn dcol3 = new DataColumn("RoomTypeName");
        dt.Columns.Add(dcol1);
        dt.Columns.Add(dcol2);
        dt.Columns.Add(dcol3);        
        foreach (DayWiseCollectionReport item in lstDWCR)
        {
            DataRow dr = dt.NewRow();
            dr["RoomName"] = item.RoomName;
            dr["BedName"] = item.BedName;
            dr["RoomTypeName"] = item.RoomTypeName;           
            dt.Rows.Add(dr);           
        }
        return dt;
    }
    protected void gvIPReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string str;
            //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
            //if (visitTypeID == 0)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //if (visitTypeID == 1)
            //{
            //    e.Row.Cells[4].Visible = false;
            //}
            //else if (visitTypeID == -1)
            //{
            //    e.Row.Cells[4].Visible = true;
            //}
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
                DayWiseCollectionReport RMaster = (DayWiseCollectionReport)e.Row.DataItem;
                Label lbl = (Label)e.Row.FindControl("lbl");
                var childItems = from child in lstDWCR
                                 where child.RoomTypeName == RMaster.RoomTypeName
                                 select child;
                lstday = childItems.ToList();
                DataTable dt = loaddata(lstday);
                //str = lbl.Text.ToString();
                //dt.TableName = str;
                ds.Tables.Add(dt);                
                GridView childGrid = (GridView)e.Row.FindControl("gvIPCreditMain");
                childGrid.DataSource = childItems;
                childGrid.DataBind();
            }
            ViewState["report"] = ds;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound CreditCardStmt", ex);
        }
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //int visitTypeID = Convert.ToInt32(rblVisitType.SelectedValue);
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((DayWiseCollectionReport)e.Row.DataItem).PatientName == "TOTAL")
            {
                e.Row.Cells[0].Text = "";
                e.Row.Cells[2].Text = "";
                e.Row.Cells[3].Text = "";

                e.Row.Style.Add("font-weight", "bold");
                e.Row.Style.Add("color", "Black");
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            bindGrid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
        }
    }
    private void bindGrid()
    {
        try
        {        
        //int visitType = Convert.ToInt32(rblVisitType.SelectedValue);
        DateTime fDate = Convert.ToDateTime(txtFDate.Text);
        DateTime tDate = Convert.ToDateTime(txtTDate.Text);
        returnCode = new Report_BL(base.ContextInfo).GetVacantRoomReport(fDate, tDate, ILocationID, out lstDWCR);

        var dwcr = (from dw in lstDWCR
                    select new { dw.RoomTypeName }).Distinct();

        List<DayWiseCollectionReport> lstDayWiseRept = new List<DayWiseCollectionReport>();
        foreach (var obj in dwcr)
        {
            DayWiseCollectionReport pdc = new DayWiseCollectionReport();
            pdc.RoomTypeName = obj.RoomTypeName;
            lstDayWiseRept.Add(pdc);
        }
        if (lstDWCR.Count > 0)
        {
            divOPDWCR.Attributes.Add("style", "block");
            divPrint.Attributes.Add("style", "block");
            divOPDWCR.Visible = true;
            divPrint.Visible = true;
            //if (visitType == 0)
            //{
            //    //gvOPReport.Visible = false;
            //    gvIPReport.Visible = true;
            //    gvIPReport.Columns[0].HeaderText = "OP - Credit Card Statement";
            //    gvIPReport.DataSource = lstDayWiseRept;
            //    gvIPReport.DataBind();
            //    CalculationPanelBlock();
            //}
            //else if (visitType == 1)
            //{
            gvIPReport.Visible = true;
            //gvOPReport.Visible = false;
           // gvIPReport.Columns[0].HeaderText = "Room Vacant List";
            gvIPReport.Columns[0].HeaderText = Resources.ClientSideDisplayTexts.Report_VacantRoomList;
            gvIPReport.DataSource = lstDayWiseRept;
            gvIPReport.DataBind();
            CalculationPanelBlock();
            //}
            //else if (visitType == -1)
            //{
            //    gvIPReport.Visible = true;
            //    //gvOPReport.Visible = false;
            //    gvIPReport.Columns[0].HeaderText = "OP / IP - Credit Card Statement";
            //    gvIPReport.DataSource = lstDayWiseRept;
            //    gvIPReport.DataBind();
            //    CalculationPanelBlock();
            //}
        }
        else
        {
            divOPDWCR.Attributes.Add("style", "none");
            divPrint.Attributes.Add("style", "none");
            divOPDWCR.Visible = false;
            divPrint.Visible = false;
            //CalculationPanelNone();
            string spath = "Reports\\\\VacantRoomList.aspx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ShowAlertMsg('"+ spath +"');", true);
        }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Get Report, CreditCardStmt", ex);
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
    public void CalculationPanelBlock()
    {
        //tabGranTotal1.Visible = true;

        //lblCardTotal.InnerText = String.Format("{0:0.00}", (pTotalCardAmt));
        //lblServiceCharge.InnerText = String.Format("{0:0.00}", (pTotalServiceCharge));
    }
    public void CalculationPanelNone()
    {
        //tabGranTotal1.Visible = false;
    }

    

    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {                     
            string prefix = string.Empty;
            prefix = "Vacant_RoomList_Reports_";
            string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + ".xls";
            DataSet dsrpt = (DataSet)ViewState["report"];                      
            if (dsrpt != null)
            {
                ExcelHelper.ToExcel(dsrpt, rptDate, Page.Response);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('First click the get report');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in exporting to excel", ex);
        }
    }
   

    public string getReportHeader(bool rptFlag, int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;
        List<Organization> lstOrganization = new List<Organization>();
        if (rptFlag == true)
        {
            rptName = "Nil Stock Report";
        }
        else
        {
            rptName = "Stock InHand Report";
        }
        long lresult = new SharedInventory_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);
        rptName = "Sales Report";
        strHeader = "<center><h3>" + OrgName.ToString() + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'>Report Date : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 1) + "<td align='LEFT'></td></tr>";
        strHeader += "<tr><td><br /></td></tr>";
        strHeader += "</table></center>";
        return strHeader;
    }

    public string getBlankTD(int tdCount)
    {
        string strTD = string.Empty;
        if (tdCount > 4)
        {
            tdCount -= 4;
        }
        while (tdCount > 0)
        {
            strTD += "<td></td>";
            tdCount--;
        }
        return strTD;
    }

   
    //public string getDate()
    //{

    //    return Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();

    //}

    private void FilterControls(Control gvRst)
    {
        //Removing Hyperlinks and other controls b4 export

        LinkButton lb = new LinkButton();
        HyperLink hl = new HyperLink();
        Literal l = new Literal();
        string name = String.Empty;
        for (int i = 0; i < gvRst.Controls.Count; i++)
        {
            if (gvRst.Controls[i].GetType() == typeof(LinkButton))
            {
                l.Text = (gvRst.Controls[i] as LinkButton).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].GetType() == typeof(HyperLink))
            {
                l.Text = (gvRst.Controls[i] as HyperLink).Text;
                gvRst.Controls.Remove(gvRst.Controls[i]);
                gvRst.Controls.AddAt(i, l);
            }
            if (gvRst.Controls[i].HasControls())
            {
                FilterControls(gvRst.Controls[i]);
            }
        }
    }
  
}
