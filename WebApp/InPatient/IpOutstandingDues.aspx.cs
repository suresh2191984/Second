using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;

public partial class InPatient_OutstandingDues : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindInitialDatas();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }

        decimal FinalAmount = 0;

        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        foreach (GridViewRow row in gvIndents.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            HiddenField hdnAmount = new HiddenField();

            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");
            hdnAmount = (HiddenField)row.FindControl("hdnAmount");


            PatientDueChart _PatientDueChart = new PatientDueChart();
            _PatientDueChart.DetailsID = Convert.ToInt64(row.Cells[0].Text);
            _PatientDueChart.FeeID = Convert.ToInt64(row.Cells[2].Text);
            _PatientDueChart.FeeType = row.Cells[1].Text;
            _PatientDueChart.Description = row.Cells[4].Text;

            txtAmount.Text = txtAmount.Text == "" ? txtUnitPrice.Text : txtAmount.Text;
            hdnAmount.Value = (hdnAmount.Value == null || hdnAmount.Value == "") ? txtAmount.Text : hdnAmount.Value;
            _PatientDueChart.Amount = Convert.ToDecimal(txtUnitPrice.Text.ToString());
            _PatientDueChart.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            _PatientDueChart.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            _PatientDueChart.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            _PatientDueChart.Unit = Convert.ToDecimal(txtQuantity.Text.ToString());
            if (txtQuantity.Text != "0")
            {
                _PatientDueChart.Status = "Paid";
            }
            else
            {
                _PatientDueChart.Status = "Deleted";
            }
            FinalAmount += _PatientDueChart.Amount;
            lstPatientDueChart.Add(_PatientDueChart);
        }

        new PatientVisit_BL(base.ContextInfo).UpdatePatientDueChart(lstPatientDueChart);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Saved", "alert('Changes saved successfully.');", true);
        BindInitialDatas();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void gvIndents_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
    }
    protected void gridAttributesAdd()
    {
        decimal dtotalAmount = 0;
        foreach(GridViewRow row in gvIndents.Rows)
        {
            TextBox txtUnitPrice = new TextBox();
            TextBox txtQuantity = new TextBox();
            TextBox txtAmount = new TextBox();
            HiddenField hdnAmount = new HiddenField();
            HiddenField hdnOldPrice = new HiddenField();
            HiddenField hdnOldQuantity = new HiddenField();

            txtUnitPrice = (TextBox)row.FindControl("txtUnitPrice");
            txtQuantity = (TextBox)row.FindControl("txtQuantity");
            txtAmount = (TextBox)row.FindControl("txtAmount");

            hdnAmount = (HiddenField)row.FindControl("hdnAmount");
            hdnOldPrice = (HiddenField)row.FindControl("hdnOldPrice");
            hdnOldQuantity = (HiddenField)row.FindControl("hdnOldQuantity");

            string sFunProcedures = "funcChkProcedures('" + txtUnitPrice.ClientID + 
                                            "','" + txtQuantity.ClientID + "','" + txtAmount.ClientID + 
                                            "','" + hdnAmount.ClientID +  
                                            "','" + hdnOldPrice.ClientID + "','" + hdnOldQuantity.ClientID + 
                                            "','" + txtGross.ClientID + "','" + txtDiscount.ClientID +
                                            "','" + txtRecievedAdvance.ClientID + "','" + txtGrandTotal.ClientID + "','" + hdnGross.ClientID + "');";

            txtUnitPrice.Attributes.Add("onBlur", sFunProcedures);
            txtQuantity.Attributes.Add("onBlur", sFunProcedures);
            dtotalAmount += Convert.ToDecimal(txtAmount.Text);
        }
        txtGross.Text = dtotalAmount.ToString();
        
    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }

    protected void BindInitialDatas()
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string sPaymentType = "";

        decimal dAdvanceAmount = 0;
        PatientHeader.PatientID = patientID;
        PatientHeader.PatientVisitID = visitID;

        List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
        List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
        new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, sPaymentType, out dAdvanceAmount, out lstadvancepaidDetails);
        if (lstDueChart.Count > 0)
        {
            gvIndents.DataSource = lstDueChart;
            gvIndents.DataBind();
            gridAttributesAdd();
        }
        txtGrandTotal.Text = Convert.ToString(Convert.ToDecimal(txtGross.Text));
        hdnGross.Value = txtGrandTotal.Text;
    }
}
