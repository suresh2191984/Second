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

public partial class InPatient_DischargeChkList : BasePage
{
    public InPatient_DischargeChkList()
        : base("InPatient\\DischargeChkList.aspx")
    {
    }
    long pVisitID = -1;
    long pID = -1;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["VID"], out pVisitID);
        Int64.TryParse(Request.QueryString["PID"], out pID);
        if (!IsPostBack)
        {
            btnSubmit.Enabled = true;
            LoadDischargeType();
            LoadDischargeChkLst();
            GetDischargeDateTime();
        }
    }
    private void LoadDischargeType()
    {
        try
        {
            long retCode = -1;
            IP_BL oIP_BL = new IP_BL(base.ContextInfo);
            List<InPatientDischargeType> oDischargeType = new List<InPatientDischargeType>();
            //retCode = oIP_BL.LoadDischargeType(OrgID, out oDischargeType);
           
            retCode = oIP_BL.LoadDischargeType(OrgID, pVisitID, out oDischargeType);

            if (retCode == 0)
            {
                ddlTypeofDis.DataSource = oDischargeType;
                ddlTypeofDis.DataTextField = "DischargeTypeName";
                ddlTypeofDis.DataValueField = "DischargeTypeID";
                ddlTypeofDis.DataBind();

                ddlTypeofDis.Items.Insert(0, "--Select--");
                ddlTypeofDis.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadDischargeType", ex);
        }
    }
    private void LoadDischargeChkLst()
    {
        try
        {
            string desctpostdis = string.Empty;
            long retCode = -1;
            List<DischargeChkLstMaster> lstDisChkLst = new List<DischargeChkLstMaster>();
            retCode = new IP_BL(base.ContextInfo).GetDischargeChkList(pID, pVisitID, out lstDisChkLst, out desctpostdis);

            if (retCode == 0)
            {
                grdDisChkList.DataSource = lstDisChkLst;
                grdDisChkList.DataBind();

                if (desctpostdis != "")
                {
                    ddlDestPostDis.SelectedValue = desctpostdis;
                    ddlDestPostDis.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadDischargeChkLst", ex);
        }
    }
    private void GetDischargeDateTime()
    {
        try
        {
            long retCode = -1;
            List<DischargeSummary> lstDischargeSummary = new List<DischargeSummary>();
            List<DischargeInvNotes> lstDischargeInvNotes = new List<DischargeInvNotes>();
            retCode = new IP_BL(base.ContextInfo).GetDischargeSummaryDetailsForupdate(pVisitID, out lstDischargeSummary, out lstDischargeInvNotes);
            if (lstDischargeSummary.Count > 0)
            {
                txtDTDis.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
                txtDTDis.Enabled = false;
                ddlTypeofDis.SelectedValue = lstDischargeSummary[0].TypeOfDischarge.ToString();
                ddlTypeofDis.Enabled = false;
                txtCndOnDis.Text = lstDischargeSummary[0].ConditionOnDischarge;
                txtCndOnDis.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetDischargeDateTime", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        long retCode = -1;
        btnSubmit.Enabled = false;
        List<PatientDisChkLstDtl> lstPDCL = new List<PatientDisChkLstDtl>();

        try
        {
            foreach (GridViewRow gR in grdDisChkList.Rows)
            {
                if (((CheckBox)gR.FindControl("ChkSel")).Checked == true)
                {
                    PatientDisChkLstDtl dcl = new PatientDisChkLstDtl();

                    Label lbChkLstID = (Label)gR.FindControl("lblChkLstID");
                    TextBox txReason = (TextBox)gR.FindControl("txtReason");

                    dcl.ChkLstID = Convert.ToInt32(lbChkLstID.Text);
                    dcl.Comments = txReason.Text;
                    lstPDCL.Add(dcl);
                }
            }
            DateTime disDT = Convert.ToDateTime(txtDTDis.Text);
            int typeofDischarge = Convert.ToInt32(ddlTypeofDis.SelectedValue);

            returnCode = new IP_BL(base.ContextInfo).InsertPatDisChkList(pID, pVisitID, LID, disDT, typeofDischarge, txtCndOnDis.Text, ddlDestPostDis.SelectedValue, lstPDCL, out retCode);
            if (retCode == 0)
            {
                Response.Redirect(@"../InPatient/PrintDischargeChkList.aspx?VID=" + pVisitID + "&PID=" + pID, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string ta = tae.ToString();
            btnSubmit.Enabled = true;
        }
        catch (Exception ex)
        {
            btnSubmit.Enabled = true;
            CLogger.LogError("Error in btnSubmit_Click", ex);
        }
    }
    protected void grdDisChkList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (((DischargeChkLstMaster)e.Row.DataItem).IsChecked == "Y")
                {
                    CheckBox chkID = (CheckBox)e.Row.FindControl("ChkSel");
                    chkID.Checked = true;
                    chkID.Enabled = false;
                    TextBox txtDescr = (TextBox)e.Row.FindControl("txtReason");
                    txtDescr.Enabled = false;
                }
                else
                {
                    //CheckBox chkID = (CheckBox)e.Row.FindControl("ChkSel");
                    //chkID.Visible = false;
                }
                //CheckBox chkbID = (CheckBox)e.Row.FindControl("ChkSel");
                //chkbID.Enabled = false;
                TextBox txtDesc = (TextBox)e.Row.FindControl("txtReason");
                txtDesc.Text = ((DischargeChkLstMaster)e.Row.DataItem).Comments;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdDisChkList_RowDataBound", ex);
        }
    }
}
