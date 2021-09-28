using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Attune.Podium.Common;
using System.Data;
using System.Collections;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using System.Web.UI.HtmlControls;

public partial class CommonControls_TimingSpecimen : BaseControl
{
    public CommonControls_TimingSpecimen()
        : base("CommonControls_TimingSpecimen_ascx")
    {
    }

    DateTime FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    List<Schedules> schedules = new List<Schedules>();
    BillingEngine bill;
    Investigation_BL investigationBL;
    int tempID = 0;
    int PageSize = 10;
    int currentPageNo = 1;
    int totalRows = 0;
    int totalpage = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        
      
        if (!IsPostBack)
        {
            //GetResult();
            txtFrom.Text = OrgTimeZone;
            txtTo.Text = OrgTimeZone;
            //GetResult(e, currentPageNo, PageSize);
        } 
    }  
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //GetResult();
        GetResult(e, currentPageNo, PageSize);
    }

    public void GetResult()
    {
        long RetValue = -1;
        investigationBL = new Investigation_BL(base.ContextInfo);
        List<PatientInvSample> lstInvsampleList = new List<PatientInvSample>();          
        FromDate = DateTime.Parse(txtFrom.Text);
        ToDate = DateTime.Parse(txtTo.Text);
     //   RetValue = investigationBL.GetTimingSpecimenDelails(FromDate, ToDate, out lstInvsampleList);
        GridView1.DataSource = lstInvsampleList;
        GridView1.DataBind();
    }

    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex >= 0)
        {
            GetResult(e, currentPageNo, PageSize);

            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();

        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            { 
                // e.Row.Attributes.Add("onMouseOver", "this.style.cursor='hand'");
                //e.Row.Cells[0].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
                //e.Row.Cells[1].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
                //e.Row.Cells[2].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.GridView1, "Select$" + e.Row.RowIndex));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Row Data bound in Client Schedules", ex);
        }
    }


    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UpdateHistory")
        { 
            Int32 rowIndex = int.Parse(e.CommandArgument.ToString());
            GridViewRow row = GridView1.Rows[rowIndex];

            Int64 PatientID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["PatientID"]);
            Int64 PatientVisitID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["PatientVisitID"]);
            Int64 GroupID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["InvSampleStatusID"]);
            Int64 InvestigationID = Convert.ToInt64(GridView1.DataKeys[rowIndex]["InvestigationID"]);
            string Type = GroupID.ToString();
            if (Type == "0")
            {
                Type = "INV";
            }
            Response.Redirect("../Patient/PatientEMRComplaintHistory.aspx?vid=" + Convert.ToString(PatientVisitID) + "&pid=" + Convert.ToString(PatientID) + "&invid=" + Convert.ToString(InvestigationID) + "&Type=" + Type + "&RePage=" + "LabReceptionHome" + " ");
 
        }
    }
    private void GetResult(EventArgs e, int currentPageNo, int PageSize)
    {
        long RetValue = -1;
        investigationBL = new Investigation_BL(base.ContextInfo);
        List<PatientInvSample> lstInvsampleList = new List<PatientInvSample>();
        FromDate = DateTime.Parse(txtFrom.Text);
        ToDate = DateTime.Parse(txtTo.Text);
        RetValue = investigationBL.GetTimingSpecimenDelails(FromDate, ToDate, PageSize, currentPageNo, out totalRows, out lstInvsampleList);
        if (lstInvsampleList.Count > 0)
        {
            GrdFooter.Style.Add("display", "block");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;
                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;
                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
            }
        }
        else
        {
            GrdFooter.Style.Add("display", "none");
        }
        GridView1.DataSource = lstInvsampleList;
        GridView1.DataBind();
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            GetResult(e, currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        GetResult(e, Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
}