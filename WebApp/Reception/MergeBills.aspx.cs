﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using Attune.Podium.BillingEngine;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Web.Script.Serialization;

public partial class Reception_MergeBills : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long VisitID = -1, PatientID = -1;
            Int64.TryParse(Request.QueryString["VID"], out VisitID);
            Int64.TryParse(Request.QueryString["PID"], out PatientID);
            LoadPatientVisitDetails(VisitID, PatientID);
        }
    }
    public void LoadPatientVisitDetails(long VisitID, long PatientID)
    {
        try
        {
            long returnCode = -1;
            List<DayWiseCollectionReport> lstVisitWiseBillDetails = new List<DayWiseCollectionReport>();
            if (VisitID > 0 && PatientID > 0)
            {
                returnCode = new Patient_BL(base.ContextInfo).GetVisitWiseBillDetails(VisitID, PatientID, "", out lstVisitWiseBillDetails);
                if (lstVisitWiseBillDetails.Count > 0)
                {
                    grdConvertToIP.DataSource = lstVisitWiseBillDetails;
                    grdConvertToIP.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, GetType(), "alt", "javascript:alert('No bills for this Visit');", true);
                    btnConvert.Enabled = false;
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "alt", "javascript:alert('Cannot get the details');", true);
                btnConvert.Enabled = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Visit Wise Bill Details in Reception/MergeBill.aspx", ex);
        }

    }
    protected void grdConvertToIP_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DayWiseCollectionReport RValue = (DayWiseCollectionReport)e.Row.DataItem;
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                if (RValue.IsRefunded == "Y")
                {
                    chkSelect.Enabled = false;
                    chkSelect.Checked = false;
                    e.Row.ToolTip = "This Bill cannot be converted, This Bill Item(s) refunded";
                }
                else
                {
                    chkSelect.Checked = true;
                }
                if (RValue.IsCreditBill == "Y")
                {
                    e.Row.CssClass = "grdrows";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Merge Bills Row Data Bound in Reception/MergeBill.aspx.cs", ex);
        }
    }
    protected void btnConvert_Click(object sender, EventArgs e)
    {
        try
        {
            btnConvert.Enabled = false;
            long returnCode = -1, PatientID = -1;
            Int64.TryParse(Request.QueryString["PID"], out PatientID);
            List<SaveBillingDetails> lstBillIDs = new List<SaveBillingDetails>();
            SaveBillingDetails objSaveBillingDetails = new SaveBillingDetails(); ;
            foreach (GridViewRow item in grdConvertToIP.Rows)
            {
                if (((CheckBox)item.FindControl("chkSelect")).Checked == true)
                {
                    HiddenField hdnFinalBillID = (HiddenField)item.FindControl("hdnFinalBillID");
                    objSaveBillingDetails = new SaveBillingDetails();
                    objSaveBillingDetails.ID = Convert.ToInt64(hdnFinalBillID.Value);
                }
                lstBillIDs.Add(objSaveBillingDetails);
            }
            returnCode = new Patient_BL(base.ContextInfo).ConvertOPtoIPBill(PatientID, lstBillIDs, "");
            if (returnCode >= 0)
            {
                ScriptManager.RegisterStartupScript(Page, GetType(), "saveAlt", "javascript:alert('Merged Success Fully');", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving convert op to ip bill in Reception/MergeBills.aspx", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

    }
}
