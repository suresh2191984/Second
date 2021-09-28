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

public partial class CommonControls_ProceduresBill : BaseControl
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
        if (!IsPostBack)
        {
            GetProcedureNameByProcedure();
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


        //long ProcedureID = Convert.ToInt64(ddlProcedureName.SelectedValue.ToString());
        long ProcedureID = 0;
        BillingEngine billingBL = new BillingEngine(base.ContextInfo);
        
            billingBL.GetProcedureFeeDetailsWithClientID(VisitID, ProcedureID, OrgID, out lstProcedureFeesDetails, "Y", pClientID);
         

        var lstphyAnd = (from lstsp in lstProcedureFeesDetails
                         select new { lstsp.ProcedureID, lstsp.ProcedureName}).Distinct();
        var tempSpec = (from lst in lstphyAnd
                        select lst).Distinct();

        ddlProcedureName.DataSource = tempSpec;
        ddlProcedureName.DataTextField = "ProcedureName";
        ddlProcedureName.DataValueField = "ProcedureID";
        ddlProcedureName.DataBind();
        ddlProcedureName.Items.Insert(0, "-----Select-----");

        var lstphy = (from lstsp in lstProcedureFeesDetails
                      //where lstsp.SpecialityID == Convert.ToInt32(ddlProcedureName.SelectedValue)
                      select new { lstsp.ID, lstsp.Descrip }).Distinct();

        var tempphy = (from lst in lstphy
                       select lst).Distinct();

        ddlTempProcName.DataSource = tempphy;
        ddlTempProcName.DataTextField = "Descrip";
        ddlTempProcName.DataValueField = "ID";
        ddlTempProcName.DataBind();

        var lstphynSpec = (from lstsp in lstProcedureFeesDetails
                           //where lstsp.SpecialityID == Convert.ToInt32(ddlProcedureName.SelectedValue)
                           select new { lstsp.ID, lstsp.ProcedureID }).Distinct();

        var tempphynSpec = (from lst in lstphynSpec
                            select lst).Distinct();

        ddlTempProcAndSpec.DataSource = tempphynSpec;
        ddlTempProcAndSpec.DataTextField = "ProcedureID";
        ddlTempProcAndSpec.DataValueField = "ID";
        ddlTempProcAndSpec.DataBind();

    }
    protected void ddlProcedureName_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetProcedureNameByProcedure();
    }
  
    //public List<PatientDueChart> getInPatientProcedureDetails()
    //{
    //    List<PatientDueChart> lstBillingDetails = new List<PatientDueChart>();
        

    //    foreach (GridViewRow rows in gvProcedureDetails.Rows)
    //    {
    //        Label lblID = new Label();
    //        CheckBox chkSelected = new CheckBox();

    //        lblID = (Label)rows.FindControl("lblID");
    //        chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
    //        if (chkSelected.Checked == true)
    //        {
    //            TextBox txtAmt = (TextBox) rows.FindControl("txtAmount");

    //            PatientDueChart objBilling = new PatientDueChart();
    //            lblID.Text = lblID.Text == "" ? "0" : lblID.Text.Trim();
    //            objBilling.FeeID = Convert.ToInt64(lblID.Text);
    //            objBilling.FeeType = "PRO";
    //            objBilling.Description = rows.Cells[1].Text.Trim();
    //            objBilling.Comments = "";
    //            objBilling.Status = Status;
    //            objBilling.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //            objBilling.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    //            objBilling.Unit = 1;
    //            objBilling.Amount = Convert.ToDecimal(txtAmt.Text);

    //            lstBillingDetails.Add(objBilling);
    //        }
    //    }
    //    return lstBillingDetails;
    //}
    //public List<PatientTreatmentProcedure> getPTT(long visitID, long proID)
    //{
    //    List<PatientTreatmentProcedure> lstPTT = new List<PatientTreatmentProcedure>();

    //    foreach (GridViewRow rows in gvProcedureDetails.Rows)
    //    {
    //        Label lblID = new Label();
    //        CheckBox chkSelected = new CheckBox();

    //        lblID = (Label)rows.FindControl("lblID");
    //        chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
    //        if (chkSelected.Checked == true)
    //        {
    //            PatientTreatmentProcedure ptt = new PatientTreatmentProcedure();
    //            ptt.PatientVisitID = visitID;
    //            ptt.ProcedureID = proID;
    //            lblID.Text = lblID.Text == "" ? "0" : lblID.Text.Trim();
    //            ptt.ProcedureFID = Convert.ToInt64(lblID.Text);
    //            ptt.ProcedureDesc = rows.Cells[1].Text.Trim();
    //            ptt.CreatedBy = LID;
    //            lstPTT.Add(ptt);
    //        }
    //    }
    //    return lstPTT;
    //}
    //protected void gvProcedureDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //            //d & p refers to OP Dialysis, Physiotheraphy
    //            if ((Request.QueryString["type"] == "d") || (Request.QueryString["type"] == "p"))
    //            {
    //                gvProcedureDetails.Columns[2].Visible = true;
    //            }
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in InPatientProceduresBill, gvProcedureDetails_RowDataBound", ex);
    //    }
    //}
    //public void SetProcedure(List<PatientTreatmentProcedure> oProcedure)
    //{
         

    //    foreach (GridViewRow rows in gvProcedureDetails.Rows)
    //    {
    //        Label lblID = new Label();
    //        CheckBox chkSelected = new CheckBox();

    //        lblID = (Label)rows.FindControl("lblID");
    //        chkSelected = (CheckBox)rows.FindControl("chkIDSelected");
    //        foreach (var o in oProcedure)
    //        {
    //            if (lblID.Text == o.ProcedureFID.ToString())
    //            {
    //                chkSelected.Checked = true;
                 
    //            }
    //        }
    //    }
    //}
    
}
