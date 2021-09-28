using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using System.Collections;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;

public partial class CommonControls_InPatientProceduresBill : BaseControl
{
    List<BillingFeeDetails> lstProcedureFeesDetails = new List<BillingFeeDetails>();
    protected string _Status = "";
    protected long _PatientID = 0;
    protected long _VisitID = 0;

    public long VisitID
    {
        get { return _VisitID; }
        set { _VisitID = value; }
    }
    protected long _pClientID = 0;

    public long pClientID
    {
        get { return _pClientID; }
        set { _pClientID = value; }
    }

    public string Status
    {
        get { return _Status; }
        set { _Status = value; }
    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ProcID"] == null)
        {
            if (!Page.IsPostBack)
            {
                GetProcedureData();
            }

            ddlProcedureName.Focus();
        }
        else
        {
            if (!IsPostBack)
            {
                GetProcedureData();
                long ProcedureID = Convert.ToInt64(Request.QueryString["ProcID"].ToString());
                long visitID = Convert.ToInt64(Request.QueryString["vid"].ToString());
                ddlProcedureName.SelectedValue = ProcedureID.ToString();
                ddlProcedureName.Enabled = false;
                gvProcedureDetails.Visible = true;
                //gvProcedureDetails.Dispose();
                BillingEngine billingBL = new BillingEngine(base.ContextInfo);
                billingBL.GetProcedureFeesDetails(VisitID, ProcedureID, OrgID, out lstProcedureFeesDetails, "Y");
                gvProcedureDetails.DataSource = lstProcedureFeesDetails;
                gvProcedureDetails.DataBind();

                List<PatientTreatmentProcedure> lpatProcedure = new List<PatientTreatmentProcedure>();
                new PatientVisit_BL(base.ContextInfo).GetProcedureDetailsForVisit(visitID, OrgID, out lpatProcedure);
                if (lpatProcedure.Count > 0)
                {
                    SetProcedure(lpatProcedure);
                }
            }
        }
    }

    public void GetProcedureData()
    {
        long returnCode = -1;
        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);

        ddlProcedureName.DataSource = lstProceduremaster;
        ddlProcedureName.DataTextField = "ProcedureName";
        ddlProcedureName.DataValueField = "ProcedureID";
        ddlProcedureName.DataBind();

        ddlProcedureName.Items.Insert(0, "---Select---");
    }

    public void GetProcedureNameByProcedure()
    {

        if (ddlProcedureName.SelectedItem.Text != "---Select---")
        {
            long ProcedureID = Convert.ToInt64(ddlProcedureName.SelectedValue.ToString());
            
            gvProcedureDetails.Visible = true;
            //gvProcedureDetails.Dispose();
            BillingEngine billingBL = new BillingEngine(base.ContextInfo);
            if (pClientID != 0)
            {
                billingBL.GetProcedureFeeDetailsWithClientID(VisitID, ProcedureID, OrgID, out lstProcedureFeesDetails, "Y", pClientID);
            }
            else
            {
                billingBL.GetProcedureFeesDetails(VisitID, ProcedureID, OrgID, out lstProcedureFeesDetails, "Y");
            }
            gvProcedureDetails.DataSource = lstProcedureFeesDetails;
            gvProcedureDetails.DataBind();
        }
        else
        {
            gvProcedureDetails.Visible = false;
        }
    }
    protected void ddlProcedureName_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProcedureNameByProcedure();
    }
  
    public List<PatientDueChart> getInPatientProcedureDetails()
    {
        List<PatientDueChart> lstBillingDetails = new List<PatientDueChart>();
        

        foreach (GridViewRow rows in gvProcedureDetails.Rows)
        {
            Label lblID = new Label();
            CheckBox chkSelected = new CheckBox();
          

            lblID = (Label)rows.FindControl("lblID");
            chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
            if (chkSelected.Checked == true)
            {
                TextBox txtAmt = (TextBox) rows.FindControl("txtAmount");
                TextBox txtQuantity = (TextBox)rows.FindControl("txtQuantity");

                PatientDueChart objBilling = new PatientDueChart();
                lblID.Text = lblID.Text == "" ? "0" : lblID.Text.Trim();
                objBilling.FeeID = Convert.ToInt64(lblID.Text);
                objBilling.FeeType = "PRO";
                objBilling.Description = rows.Cells[1].Text.Trim();
                objBilling.Comments = "";
                objBilling.Status = Status;
                objBilling.FromDate = Convert.ToDateTime(hdnFromDate.Value.ToString());
                objBilling.ToDate = Convert.ToDateTime(hdnFromDate.Value.ToString());
                objBilling.Unit = Convert.ToDecimal(txtQuantity.Text.Trim());
                objBilling.Amount = Convert.ToDecimal(txtAmt.Text);

                lstBillingDetails.Add(objBilling);
            }
        }
        return lstBillingDetails;
    }
    public List<PatientTreatmentProcedure> getPTT(long visitID, long proID)
    {
        List<PatientTreatmentProcedure> lstPTT = new List<PatientTreatmentProcedure>();

        foreach (GridViewRow rows in gvProcedureDetails.Rows)
        {
            Label lblID = new Label();
            CheckBox chkSelected = new CheckBox();

            lblID = (Label)rows.FindControl("lblID");
            chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
            if (chkSelected.Checked == true)
            {
                PatientTreatmentProcedure ptt = new PatientTreatmentProcedure();
                ptt.PatientVisitID = visitID;
                ptt.ProcedureID = proID;
                lblID.Text = lblID.Text == "" ? "0" : lblID.Text.Trim();
                ptt.ProcedureFID = Convert.ToInt64(lblID.Text);
                ptt.ProcedureDesc = rows.Cells[1].Text.Trim();
                ptt.CreatedBy = LID;
                lstPTT.Add(ptt);
            }
        }
        return lstPTT;
    }
    protected void gvProcedureDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //d & p refers to OP Dialysis, Physiotheraphy
                if ((Request.QueryString["type"] == "d") || (Request.QueryString["type"] == "p"))
                {
                    gvProcedureDetails.Columns[2].Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InPatientProceduresBill, gvProcedureDetails_RowDataBound", ex);
        }
    }
    public void SetProcedure(List<PatientTreatmentProcedure> oProcedure)
    {
        //GetProcedureData();
        //long ProcedureID = Convert.ToInt64(Request.QueryString["ProcID"].ToString());

        //ddlProcedureName.SelectedValue = ProcedureID.ToString();
        //ddlProcedureName.Enabled = false;
        //gvProcedureDetails.Visible = true;
        //BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        //billingBL.GetProcedureFeesDetails(VisitID, ProcedureID, OrgID, out lstProcedureFeesDetails, "Y");
        //gvProcedureDetails.DataSource = lstProcedureFeesDetails;
        //gvProcedureDetails.DataBind();

        foreach (GridViewRow rows in gvProcedureDetails.Rows)
        {
            Label lblID = new Label();
            CheckBox chkSelected = new CheckBox();

            lblID = (Label)rows.FindControl("lblID");
            chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
            foreach (var o in oProcedure)
            {
                if (lblID.Text == o.ProcedureFID.ToString())
                {
                    chkSelected.Checked = true;
                 
                }
            }
        }
    }




    public List<OrderedPhysiotherapy> getPhysioDetails()
    {
        List<OrderedPhysiotherapy> lstPTT = new List<OrderedPhysiotherapy>();

        foreach (GridViewRow rows in gvProcedureDetails.Rows)
        {
            Label lblID = new Label();
            CheckBox chkSelected = new CheckBox();
            TextBox txtQuantity = (TextBox)rows.FindControl("txtQuantity");
            lblID = (Label)rows.FindControl("lblID");
            chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
            if (chkSelected.Checked == true)
            {
                OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();               
                lblID.Text = lblID.Text == "" ? "0" : lblID.Text.Trim();
                ptt.ProcedureID = Convert.ToInt64(lblID.Text);
                ptt.ProcedureName = rows.Cells[1].Text.Trim();
                ptt.OdreredQty = Convert.ToDecimal(txtQuantity.Text.Trim());
                ptt.Status = "Ordered";
                ptt.PaymentStatus = "";
                lstPTT.Add(ptt);
            }
        }
        return lstPTT;
    }
    
}
