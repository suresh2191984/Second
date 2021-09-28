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

public partial class CommonControls_DischargeChkList : BaseControl
{
    long pVisitID = -1;
    long pID = -1;
    long returnCode = -1;
    string destPostDis = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["VID"], out pVisitID);
        Int64.TryParse(Request.QueryString["PID"], out pID);
        if (!IsPostBack)
        {
            GetDischargeDateTime();
            LoadDischargeChkLst();
        }
    }
    private void LoadDischargeChkLst()
    {
        try
        {
            long retCode = -1;
            List<DischargeChkLstMaster> lstDisChkLst = new List<DischargeChkLstMaster>();
            retCode = new IP_BL(base.ContextInfo).GetDischargeChkList(pID, pVisitID, out lstDisChkLst, out destPostDis);

            if (retCode == 0)
            {
                grdDisChkList.DataSource = lstDisChkLst;
                grdDisChkList.DataBind();
            }
            if (destPostDis == "H")
            {
                lblDestPostDis.Text = "Hospital";
            }
            if (destPostDis == "R")
            {
                lblDestPostDis.Text = "Residence";
            }
            if (destPostDis == "OC")
            {
                lblDestPostDis.Text = "Out-of-City";
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
            retCode = new IP_BL(base.ContextInfo).GetDischargeSummaryDetailsForupdate(pVisitID, out lstDischargeSummary,out lstDischargeInvNotes);
            if (lstDischargeSummary.Count > 0)
            {
                lblDisDT.Text = lstDischargeSummary[0].DateOfDischarge.ToString();
                if (lstDischargeSummary[0].TypeOfDischarge == 1)
                {
                    lblTypeofDischarge.Text = "Elective";
                }
                if (lstDischargeSummary[0].TypeOfDischarge == 2)
                {
                    lblTypeofDischarge.Text = "Against Medical Advice";
                }
                if (lstDischargeSummary[0].TypeOfDischarge == 3)
                {
                    lblTypeofDischarge.Text = "At Request";
                }
                if (lstDischargeSummary[0].TypeOfDischarge == 4)
                {
                    lblTypeofDischarge.Text = "Absconding";
                }
                if (lstDischargeSummary[0].TypeOfDischarge == 5)
                {
                    lblTypeofDischarge.Text = "Expired";
                }
                lblConOnDis.Text = lstDischargeSummary[0].ConditionOnDischarge;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetDischargeDateTime", ex);
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
                }
                else
                {
                    CheckBox chkID = (CheckBox)e.Row.FindControl("ChkSel");
                    chkID.Visible = false;
                }
                CheckBox chkbID = (CheckBox)e.Row.FindControl("ChkSel");
                chkbID.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdDisChkList_RowDataBound", ex);
        }
    }
}
