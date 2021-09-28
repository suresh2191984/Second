using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;

public partial class Billing_PatientDueDetails : BasePage
{
    long returnCode = -1;
    public Billing_PatientDueDetails()
        : base("Billing_PatientDueDetails_aspx")
    {
    }

    DateTime dtFrom, dtTo;

    #region "Initial"
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadlocations(RoleID, OrgID, LocationName);
        }
    }
    
    #endregion

    #region "Events"
    protected void btnSearch_Click(object sender, EventArgs e)
    {

        dtFrom = Convert.ToDateTime(OrgDateTimeZone);
        dtTo = Convert.ToDateTime(OrgDateTimeZone);
        BillingEngine BE = new BillingEngine(base.ContextInfo);
        List<PatientDueDetails> dueDetails = new List<PatientDueDetails>();

        string PatientNo = txtPatientNo.Text.Trim() == "" ? "0" : Convert.ToString(txtPatientNo.Text);
        string BillNo = txtBillNo.Text.Trim() == "" ? "0" : Convert.ToString(txtBillNo.Text);
        string PatientName = txtPatientName.Text == "" ? "" : txtPatientName.Text;
        String pLocation = Convert.ToString(ddlLocation.SelectedItem);
        string pVisitNumber = txtVisitNumber.Text == "" ? "" : txtVisitNumber.Text;
        dtFrom = ucDateCtrl.GetFromDate();
        dtTo = ucDateCtrl.GetToDate();
        if (pLocation == "------SELECT------")
        {
            pLocation = "0";
        }
        BE.getpatientduedetails(PatientNo, BillNo, PatientName, OrgID, 0, dtFrom, dtTo,pVisitNumber,pLocation, out dueDetails);
        //gvDueDetails.DataSource = from due in dueDetails
        //                         // group x by new { x.Column1, x.Column2 } 
        //                          group due by new { due.PatientName, due.PatientNumber, due.PatientID } into g
        //                          select new PatientDueDetails{
        //                              PatientID=g.Key.PatientID,
        //                              PatientNumber=g.Key.PatientNumber,
        //                              PatientName=g.Key.PatientName,
        //                              DueAmount = g.Sum(t => t.DueAmount),
        //                              DuePaidAmt = g.Sum(t => t.DuePaidAmt),
        //                            };

        if (dueDetails.Count > 0)
        {
            gvDueDetails.DataSource = dueDetails.GroupBy(due => new { due.PatientName, due.PatientNumber, due.PatientID, due.VersionNo, due.Status, due.CreatedAt, due.NetValue, due.BillNo, due.UserName,due.WriteOffAmt},
                                       (key, group) => new PatientDueDetails { PatientID = key.PatientID, UserName = key.UserName, VersionNo = key.VersionNo, PatientName = key.PatientName, BillNo = key.BillNo, PatientNumber = key.PatientNumber, CreatedAt = key.CreatedAt, NetValue = key.NetValue, DueAmount = group.Sum(t => t.DueAmount), DuePaidAmt = group.Sum(t => t.DuePaidAmt), Status = key.Status, WriteOffAmt = key.WriteOffAmt}).ToList<PatientDueDetails>();

            gvDueDetails.DataBind();
        }
        else
        {
            gvDueDetails.DataSource = null;
            gvDueDetails.DataBind();

            string sPath = "Billing\\\\PatientDueDetails.aspx_3";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('No Matching Records Found');", true);
        }
        btnCollectDueAmt.Visible = dueDetails.Count == 0 ? false : true;
    }


    protected void gvDueDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientDueDetails p = (PatientDueDetails)e.Row.DataItem;
            string strScript = "SelectSingleRow('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoSelect")).ClientID + "','" + p.PatientDueID + "','" + p.PatientNumber + "','" + p.BillNo + "','" + p.PatientName.Replace("'", "") + "','" + p.PatientID + "','" + p.Status + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdoSelect")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdoSelect")).Attributes.Add("onclick", strScript);



        }

    }
    protected void btnCollectDueAmt_Click(object sender, EventArgs e)
    {
        dtFrom = Convert.ToDateTime(OrgDateTimeZone);
        dtTo = Convert.ToDateTime(OrgDateTimeZone);
        string PatientNum = hdnPNo.Value.Trim();
        string BillNo = hdnBillNo.Value;
        string PName = hdnPatientname.Value;
        string PatientID = hdnPatientId.Value.Trim();
        dtFrom = ucDateCtrl.GetFromDate();
        dtTo = ucDateCtrl.GetToDate();
        Response.Redirect("CollectDueAmount.aspx?PID=" + PatientID + "&Bno=" + BillNo + "&PName=" + PName + "&PatNum=" + PatientNum + "&FDate=" + dtFrom + "&TDate=" + dtTo);
    }
    protected void gvDueDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvDueDetails.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    #endregion

    #region "Method"
    string strSelect = Resources.Billing_ClientDisplay.Billing_PatientDueDetails_aspx_01 == null ? "------SELECT------" : Resources.Billing_ClientDisplay.Billing_PatientDueDetails_aspx_01;
protected void loadlocations(long uroleID, int intOrgID, string LocationName)
    {
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(intOrgID, LID, uroleID, out lstLocation);
        ddlLocation.DataSource = lstLocation;
        ddlLocation.DataTextField = "Location";
        ddlLocation.DataValueField = "AddressID";
        ddlLocation.DataBind();

        if (lstLocation.Count == 1)
        {
            ddlLocation.Items.Insert(0, strSelect);
            ddlLocation.Items[0].Value = "0";
            ddlLocation.Items[0].Selected = true;
        }
        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            
            ddlLocation.DataTextField = LocationName;
            ddlLocation.Items.Insert(0, ddlLocation.DataTextField);
            ddlLocation.Items.Insert(1, strSelect);
        }
    }
    #endregion
}
