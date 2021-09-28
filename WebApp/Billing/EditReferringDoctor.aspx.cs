using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BillingEngine;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Billing_EditReferringDoctor : BasePage
{
    public string lblstatus = Resources.ClientSideDisplayTexts.Billing_EditReferringDoctor_aspx_cs_lblstatus;
    public Billing_EditReferringDoctor()
        : base("Billing\\EditReferringDoctor.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }





    List<ReferingPhysician> refPhysician = new List<ReferingPhysician>();
    long PatientID = -1;
    long pVisitID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            //vid=121373&pid=58849
            if (Request.QueryString["vid"] != null)
            {
                pVisitID = Convert.ToInt32(Request.QueryString["vid"]);
            }
            if (Request.QueryString["pid"] != null)
            {
                PatientID = Convert.ToInt32(Request.QueryString["pid"]);
            }
            if (!IsPostBack)
            {
                returnCode = LoadData();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in pageload editreferringdoctor", ex);
        }
    }
    private long LoadData()
    {
        List<PatientDueChart> Duechart = new List<PatientDueChart>();
        List<BillingDetails> PatientBillingDetails = new List<BillingDetails>();
        long returnCode = -1;
        returnCode = new Patient_BL(base.ContextInfo).GetReferingPhysician("", OrgID, out refPhysician);
        returnCode = new BillingEngine(base.ContextInfo).GetPatientBillingDetails(PatientID, pVisitID, txtItemnae.Text, out Duechart, out PatientBillingDetails);
        if (PatientBillingDetails.Count > 0)
        {
            grdBillingdetails.DataSource = PatientBillingDetails;
            grdBillingdetails.DataBind();
            grdBillingdetails.Visible = true;
            lblBillDeatils.Visible = true;

        }
        if (Duechart.Count > 0)
        {
            grdDueChart.DataSource = Duechart;
            grdDueChart.DataBind();
            grdDueChart.Visible = true;
            lblDueDetails.Visible = true;
        }
        return returnCode;
    }
    protected void grdBillingdetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "BDUpdate")
        {
            long returnCode = -1;
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            long billinDetailsID = Convert.ToInt64(grdBillingdetails.DataKeys[rowIndex][0]);
            //long PatientDueChartID = Convert.ToInt64(grdBillingdetails.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
            GridViewRow row = (GridViewRow)grdBillingdetails.Rows[rowIndex];
            DropDownList ddl = (DropDownList)row.FindControl("ddlRefnameBD");
            long refPhyID = Convert.ToInt64(ddl.SelectedItem.Value);
            string refPhyname = ddl.SelectedItem.Text;
            returnCode = new BillingEngine(base.ContextInfo).UpdateBillingDetails(billinDetailsID, 0, refPhyID, refPhyname);
            if (returnCode != -1)
            {
                
                lblStatus.Text = lblstatus;
            }
        }

    }
    protected void grdBillingdetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            BillingDetails BD = (BillingDetails)e.Row.DataItem;
            DropDownList ddl = (DropDownList)e.Row.FindControl("ddlRefnameBD");
            ddl.DataSource = refPhysician;
            ddl.DataTextField = "PhysicianName";
            ddl.DataValueField = "ReferingPhysicianID";
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("--Select--", "0"));
            ddl.SelectedValue = BD.RefPhysicianID.ToString();
        }
    }
    protected void grdDueChart_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueChart BD = (PatientDueChart)e.Row.DataItem;
            DropDownList ddl = (DropDownList)e.Row.FindControl("ddlDCRefname");
            ddl.DataSource = refPhysician;
            ddl.DataTextField = "PhysicianName";
            ddl.DataValueField = "ReferingPhysicianID";
            ddl.DataBind();
           ddl.Items.Insert(0, new ListItem("--Select--", "0"));
            ddl.SelectedValue = BD.RefPhysicianID.ToString();
        }
    }
    protected void grdDueChart_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "DueChartUpdate")
        {
            long returnCode = -1;
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            long duechartID = Convert.ToInt64(grdDueChart.DataKeys[rowIndex][0]);
            //long PatientDueChartID = Convert.ToInt64(grdBillingdetails.DataKeys[Convert.ToInt32(e.CommandArgument)].Value);
            GridViewRow row = (GridViewRow)grdDueChart.Rows[rowIndex];
            DropDownList ddl = (DropDownList)row.FindControl("ddlDCRefname");
            long refPhyID = Convert.ToInt64(ddl.SelectedItem.Value);
            string refPhyname = ddl.SelectedItem.Text;
            returnCode = new BillingEngine(base.ContextInfo).UpdateBillingDetails(0, duechartID, refPhyID, refPhyname);
            if (returnCode != -1)
            {
                lblStatus.Text = lblstatus;
            }
        }
    }
    protected void grdBillingdetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdBillingdetails.PageIndex = e.NewPageIndex;
                long returnCode = -1;
                List<PatientDueChart> Duechart = new List<PatientDueChart>();
                List<BillingDetails> PatientBillingDetails = new List<BillingDetails>();
                returnCode = new BillingEngine(base.ContextInfo).GetPatientBillingDetails(PatientID, pVisitID, txtItemnae.Text, out Duechart, out PatientBillingDetails);
                if (PatientBillingDetails.Count > 0)
                {
                    grdBillingdetails.DataSource = PatientBillingDetails;
                    grdBillingdetails.DataBind();
                    grdBillingdetails.Visible = true;
                    lblBillDeatils.Visible = true;

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdBillingdetails_PageIndexChanging(Edit Refering Phy Page", ex);
        }
    }
    protected void grdDueChart_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            long returnCode = -1;
            List<PatientDueChart> Duechart = new List<PatientDueChart>();
            List<BillingDetails> PatientBillingDetails = new List<BillingDetails>();
            returnCode = new BillingEngine(base.ContextInfo).GetPatientBillingDetails(PatientID, pVisitID, txtItemnae.Text, out Duechart, out PatientBillingDetails);
            if (Duechart.Count > 0)
            {
                grdDueChart.DataSource = Duechart;
                grdDueChart.DataBind();
                grdDueChart.Visible = true;
                lblDueDetails.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdDueChart_PageIndexChanging(Edit Refering Phy Page)", ex);
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadData();
    }
}