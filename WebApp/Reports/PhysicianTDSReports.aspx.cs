using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;

public partial class Admin_PhysicianTDSReports : BasePage
{
    List<Organization> lstOrganization = new List<Organization>();
    decimal calc = decimal.Zero;
    decimal val = decimal.Zero;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,0);");
        txtTDate.Attributes.Add("onchange", "ExcedDate('" + txtTDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTDate.ClientID.ToString() + "','txtFDate',1,1);");
        if (!IsPostBack)
        {
            Physician_BL PhysicianBL = new Physician_BL(base.ContextInfo);
            List<Physician> lstPhysician = new List<Physician>();
            PhysicianBL.GetPhysicianListByOrg(OrgID, out lstPhysician, 0); 
            LoadPhysicians(lstPhysician);
            txtFDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
            txtTDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        }
    }
    public void LoadPhysicians(List<Physician> phySch)
    {

        if (phySch.Count > 0)
        {
            var lstphy = (from phy in phySch select new { phy.PhysicianID, phy.PhysicianName }).Distinct();
            ddlDrName.DataSource = lstphy;
            ddlDrName.DataTextField = "PhysicianName";
            ddlDrName.DataValueField = "PhysicianID";
            ddlDrName.DataBind();
            ddlDrName.Items.Insert(0, "--Select--");
            ddlDrName.Items[0].Value = "0";
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        decimal total=decimal.Zero;
        decimal tds=decimal.Zero;
        decimal net = decimal.Zero;
        List<CashFlowSummary> lstCashFlowSummary = new List<CashFlowSummary>();
        long lPhysicianID = 0;
        DateTime dfromDate = DateTime.MaxValue;
        DateTime toDate = DateTime.MaxValue;
        dfromDate = Convert.ToDateTime(txtFDate.Text);
        toDate = Convert.ToDateTime(txtTDate.Text);
        Int64.TryParse(ddlDrName.SelectedValue.ToString(), out lPhysicianID);
        long retval = -1;
        string vtype = string.Empty;
        retval = new Report_BL(base.ContextInfo).GetPhysicianTDSReport(dfromDate, toDate, OrgID, lPhysicianID,vtype, out lstCashFlowSummary);

        if (lstCashFlowSummary.Count > 0)
        {
            gvPhysicianamtdet.DataSource = lstCashFlowSummary;
            gvPhysicianamtdet.DataBind();
            gvPhysicianamtdet.Visible = true;
            tdscalc.Visible = true;
            total = lstCashFlowSummary.Sum(p => p.PhysicianAmount);
            lbltdsamt.Text = Convert.ToString(total * 10 / 100);
            net = total - Convert.ToDecimal(lbltdsamt.Text);
            lblnettotal.Text = Convert.ToString(net);
        }
        else
        {
            gvPhysicianamtdet.Visible = false;
            tdscalc.Visible = false;
        }




    }
    protected void gvPhysicianamtdet_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CashFlowSummary dwcr = new CashFlowSummary();
                dwcr = (CashFlowSummary)e.Row.DataItem;
                 


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvIPReport_RowDataBound IPCollectionReport", ex);
        }
    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            FilterControls(gvPhysicianamtdet);
            ExportToExcel();
            //export to excel
            //string attachment = "attachment; filename=Reports.xls";
            //Response.ClearContent();
            //Response.AddHeader("content-disposition", attachment);
            //Response.ContentType = "application/ms-excel";
            //Response.Charset = "";
            //System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            //System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            ////divOPDWCR.RenderControl(oHtmlTextWriter);
            //Response.Write(oStringWriter.ToString());
            //Response.End();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Convert to XL, PhysicianwiseCollectionReport", ex);
        }
    }
    public void ExportToExcel()
    {
        //export to excel
        string prefix = string.Empty;
        prefix = "PhysicianTDSReport_";

        string rptDate = prefix + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        string attachment = "attachment; filename=" + rptDate + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/ms-excel";
        Response.Charset = "";
        this.EnableViewState = false;
        HttpContext.Current.Response.Write(getReportHeader(gvPhysicianamtdet.Columns.Count));
        System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);

        drreports.RenderControl(oHtmlTextWriter);
        Response.Write(oStringWriter.ToString());
        Response.End();


    }

    public string getReportHeader(int tdCount)
    {
        string strHeader = string.Empty;
        string rptName = string.Empty;

        long lresult = new SharedInventory_BL(base.ContextInfo).getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

        rptName = "<span style='font-size:10.0pt; color:block;font-weight:700;'>Physician TDS  Reports</span>";

        strHeader = "<center><h3>" + OrgName.ToString() + "</h3></center>";
        strHeader += "<center><table>";
        strHeader += "<tr><td align='LEFT' style='color:block;font-weight:700;'>From Date : " + txtFDate.Text + "</td></tr>";
        strHeader += "<tr><td align='LEFT' style='color:block;font-weight:700;'>To Date : " + txtTDate.Text + "</td></tr>";
        strHeader += "<tr><td align='LEFT' style='color:block;font-weight:700;'>Dr. Name : " + ddlDrName.SelectedItem.Text + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].Address + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>Report Name : " + rptName + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].City + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'>Report Date : " + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString() + "</td></tr>";
        strHeader += "<tr><td align='left'>" + lstOrganization[0].PhoneNumber + "</td>" + getBlankTD(tdCount + 2) + "<td align='LEFT'></td></tr>";
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

    public override void VerifyRenderingInServerForm(Control control)
    {
    }
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
