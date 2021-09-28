using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Web.Script.Serialization;
public partial class Admin_DoctorPaySummary : BasePage
{
    long returnCode = 0;
    decimal grandTotal = 0;
    string concatenateDate = string.Empty;
    String PhysicianID = "0";
    String strDrName = string.Empty;
    DateTime strBillFromDate;
    DateTime strBillToDate;
    string FinalbillId = string.Empty;
    string FinalIds = string.Empty;
    List<DoctorPayoutDetails> lstDoctorpayout = new List<DoctorPayoutDetails>();
    protected void Page_Load(object sender, EventArgs e)
    {

        lblGvSummary.Visible = false;
        if (!IsPostBack)
        {
            txtFrom.Text = DateTime.Today.AddDays(-1).ToString("dd/MM/yyyy");
            txtTo.Text = OrgTimeZone;
            AutoCompleteExtenderRefPhy.ContextKey = Convert.ToString(OrgID);
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        strBillFromDate = Convert.ToDateTime(txtFrom.Text + " 00:00:00 ");
        strBillToDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
        strDrName = txtPhysician.Text;
        if (strDrName != "")
        {
            string[] ArrayDrName = strDrName.Split('~');
            strDrName = ArrayDrName[0] == "" ? "" : ArrayDrName[0].ToString();
            if (ArrayDrName.Count() > 1)
            {
                PhysicianID = ArrayDrName[1] == "" ? "" : ArrayDrName[1].ToString();
            }
            else
            {
                PhysicianID = "-1";
            }
        }
        long returnCode = -1;
        byte Mode = 3;
        List<DoctorPayoutDetails> lstDocPayout = new List<DoctorPayoutDetails>();
        List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
        AdminReports_BL AdminBL = new AdminReports_BL(base.ContextInfo);
        try
        {
            returnCode = AdminBL.SearchDoctorPayout(Convert.ToInt32(PhysicianID), strBillFromDate, strBillToDate, Mode, lstFinalbillid, lstDocPayout, out lstDoctorpayout);
            if (lstDoctorpayout.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstDoctorpayout;
                grdResult.DataBind();
                lblGvSummary.Visible = true;
                btnSave.Visible = true;
                lblGvSummary.Text = "Summary Details";
            }
            else
            {
                lblGvSummary.Visible = true;
                lblGvSummary.Text = "No Matching Records Found!";
                grdResult.Visible = false;
                btnSave.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Doctorpayout Details.", ex);

        }

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        strBillFromDate = Convert.ToDateTime((txtFrom.Text + " 00:00:00 "));
        strBillToDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
        strDrName = txtPhysician.Text;
        if (strDrName != "")
        {
            string[] ArrayDrName = strDrName.Split('~');
            strDrName = ArrayDrName[0] == "" ? "" : ArrayDrName[0].ToString();
            PhysicianID = ArrayDrName[1] == "" ? "" : ArrayDrName[1].ToString();
        }
        long returnCode = -1;
        byte Mode = 4;
        List<DoctorPayoutDetails> lstDocPayout = new List<DoctorPayoutDetails>();
        List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
        lstDocPayout = GetDocPayoutDetails();
        lstFinalbillid = GetBlockpayoutdtls();
        AdminReports_BL AdminBL = new AdminReports_BL(base.ContextInfo);
        try
        {
            returnCode = AdminBL.SearchDoctorPayout(Convert.ToInt32(PhysicianID), strBillFromDate, strBillToDate, Mode, lstFinalbillid, lstDocPayout, out lstDoctorpayout);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "alert('Doctor Payout Details Saved Sucessfully');", true);
            grdResult.Visible = false;
            lblGvSummary.Visible = false;
            btnSave.Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Doctorpayout Details.", ex);

        }
    }
    public List<DoctorPayoutDetails> GetBlockpayoutdtls()
    {
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
        string listhdn = "";
        foreach (GridViewRow row in grdResult.Rows)
        {
            //strkwy = strkwy != "" ? strkwy + "," + ((Label)gr.FindControl("lblKeyword")).Text.ToString() : ((Label)gr.FindControl("lblKeyword")).Text.ToString();
            //List<DoctorPayoutDetails> obj = new List<DoctorPayoutDetails>();
            HiddenField hdnRefId = (HiddenField)row.FindControl("hdnRefId");
            HiddenField hdnFbID = (HiddenField)row.FindControl("hdnFinalbillID");
            if (hdnFbID.Value != "")
            {
                listhdn = listhdn != "" ? listhdn + "," + ((HiddenField)row.FindControl("hdnFinalbillID")).Value.ToString() : ((HiddenField)row.FindControl("hdnFinalbillID")).Value.ToString();
            }
            //Deserialize<List<NewWorkList>>(hdnLstGrp.Value);
            //obj = serializer1.Deserialize<List<DoctorPayoutDetails>>(hdnFbID.Value);
            //string[] block=hdnFbID.Value.Split("|");
            //lstFinalbillid.Add(obj.ToList());
        }
        listhdn = listhdn.Replace("],[", ",");
        if (!String.IsNullOrEmpty(listhdn) && listhdn.Length >0)
        {

            lstFinalbillid = serializer1.Deserialize<List<DoctorPayoutDetails>>(listhdn);
        }
        return lstFinalbillid;
    }
    public List<DoctorPayoutDetails> GetDocPayoutDetails()
    {
        List<DoctorPayoutDetails> lstPayoutDetails = new List<DoctorPayoutDetails>();

        foreach (GridViewRow row in grdResult.Rows)
        {
            TextBox txtPaidAmount = new TextBox();
            Label lblDCode = new Label();
            Label lblDName = new Label();
            TextBox lblVisits = new TextBox();
            TextBox lblBamount = new TextBox();
            TextBox lblDiscount = new TextBox();
            TextBox lblNamount = new TextBox();
            TextBox lblPayamount = new TextBox();
            Label lblOstanding = new Label();
            HiddenField hdnRefId = new HiddenField();
            HiddenField hdnFbID = new HiddenField();
            DropDownList ddlStatus = (DropDownList)row.FindControl("drpStatus");
            lblDCode = (Label)row.FindControl("lblDoctorcode");
            lblDName = (Label)row.FindControl("lblDoctorName");
            lblVisits = (TextBox)row.FindControl("txtvisits");
            lblBamount = (TextBox)row.FindControl("txtBillamount");
            lblDiscount = (TextBox)row.FindControl("txtDiscount");
            lblNamount = (TextBox)row.FindControl("txtNetamount");
            lblPayamount = (TextBox)row.FindControl("txtPayableamount");
            lblOstanding = (Label)row.FindControl("lblOutstanding");
            hdnRefId = (HiddenField)row.FindControl("hdnRefId");
            hdnFbID = (HiddenField)row.FindControl("hdnFinalbillID");
            txtPaidAmount = (TextBox)row.FindControl("txtPaidAmount");
            //String Status=(DropDownList)row.FindControl("drpStatus").
            DoctorPayoutDetails DpayoutDetails = new DoctorPayoutDetails();
            DpayoutDetails.ReferingPhysicianID = Convert.ToInt32(hdnRefId.Value);
            DpayoutDetails.PhysicianCode = lblDCode.Text;
            DpayoutDetails.PhysicianName = lblDName.Text;
            DpayoutDetails.BillCount = Convert.ToInt32(lblVisits.Text);
            DpayoutDetails.BillAmount = Convert.ToDecimal(lblBamount.Text);
            DpayoutDetails.DisCount = Convert.ToDecimal(lblDiscount.Text);
            DpayoutDetails.NetAmount = Convert.ToDecimal(lblNamount.Text);
            DpayoutDetails.PayableAmount = Convert.ToDecimal(lblPayamount.Text);
            DpayoutDetails.OutStanding = Convert.ToDecimal(lblOstanding.Text);
            DpayoutDetails.Paidamount = Convert.ToDecimal(txtPaidAmount.Text);
            DpayoutDetails.Status = ddlStatus.SelectedItem.Text;
            lstPayoutDetails.Add(DpayoutDetails);
        }
        return lstPayoutDetails;
    }

    decimal total = 0;
    decimal minusamt = 0;
    JavaScriptSerializer serializer1 = new JavaScriptSerializer();
    List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
    int i = 0;
    protected void gvFianalDtls_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        lstFinalbillid = serializer1.Deserialize<List<DoctorPayoutDetails>>(FinalIds);
        if (lstFinalbillid == null)
        {
            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int ids = Convert.ToInt32(gvFianalDtls.DataKeys[e.Row.RowIndex].Values[1].ToString());
                if(ids==1)
                {
                    ((CheckBox)e.Row.FindControl("chkblock")).Checked = true;
                    ((TextBox)e.Row.FindControl("txtRemarks")).Enabled = true;
                }
                total += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //Label lblpayableamount = (Label)e.Row.FindControl("lblTotNetAmount");
                lblTotNetAmount.Text = total.ToString();
            }
        }
        else
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                int id = Convert.ToInt32(gvFianalDtls.DataKeys[e.Row.RowIndex].Values[0].ToString());
                if (lstFinalbillid[i].Finalbillid == id)
                {
                    ((CheckBox)e.Row.FindControl("chkblock")).Checked = true;
                    ((TextBox)e.Row.FindControl("txtRemarks")).Text = lstFinalbillid[i].Remarks;
                    ((TextBox)e.Row.FindControl("txtRemarks")).Enabled = true;
                    minusamt += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
                    if (i < lstFinalbillid.Count()-1)
                    {
                        i++;
                    }
                   
                }
                total += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "NetAmount"));
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                total = total - minusamt;
                //Label lblpayableamount = (Label)e.Row.FindControl("lblTotNetAmount");
                lblTotNetAmount.Text = total.ToString();
            }
        }
    }
    protected void btnAdd_click(object sender, EventArgs e)
    {
        strBillFromDate = Convert.ToDateTime((txtFrom.Text + " 00:00:00 "));
        strBillToDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
        long returnCode = -1;
        byte Mode = 1;
        string all = "";
        //string strkwy = "";
        int PhysicianID = Convert.ToInt32(hdnPhysicianID.Value);
        List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
        foreach (GridViewRow gr in gvFianalDtls.Rows)
        {
            if (((CheckBox)gr.FindControl("chkblock")).Checked == true)
            {
                FinalbillId = FinalbillId != "" ? FinalbillId + "," + gvFianalDtls.DataKeys[gr.RowIndex].Value.ToString() : gvFianalDtls.DataKeys[gr.RowIndex].Value.ToString();
                ////strkwy = strkwy != "" ? strkwy + "," + ((Label)gr.FindControl("lblKeyword")).Text.ToString() : ((Label)gr.FindControl("lblKeyword")).Text.ToString();
                all = all != "" ? all + "|" + gvFianalDtls.DataKeys[gr.RowIndex].Value.ToString() + "~" + ((TextBox)gr.FindControl("txtRemarks")).Text.ToString()
                   : gvFianalDtls.DataKeys[gr.RowIndex].Value.ToString() + "~" + ((TextBox)gr.FindControl("txtRemarks")).Text.ToString();
                DoctorPayoutDetails blockdetails = new DoctorPayoutDetails();
                blockdetails.ReferingPhysicianID = PhysicianID;
                blockdetails.Finalbillid = Convert.ToUInt32(gvFianalDtls.DataKeys[gr.RowIndex].Value);
                blockdetails.Remarks = ((TextBox)gr.FindControl("txtRemarks")).Text.ToString();
                lstFinalbillid.Add(blockdetails);
            }

        }
        JavaScriptSerializer serializer1 = new JavaScriptSerializer();
        hdnfinallist.Value = serializer1.Serialize(lstFinalbillid);
        List<DoctorPayoutDetails> lstDocPayout = new List<DoctorPayoutDetails>();
        AdminReports_BL AdminBL = new AdminReports_BL(base.ContextInfo);
        try
        {
            returnCode = AdminBL.SearchDoctorPayout(Convert.ToInt32(PhysicianID), strBillFromDate, strBillToDate, Mode, lstFinalbillid, lstDocPayout, out lstDoctorpayout);
            string rno = Convert.ToString(hdnRowIndex.Value);
            int bCount = lstDoctorpayout[0].BillCount;
            decimal bAmount = lstDoctorpayout[0].BillAmount;
            decimal dis = lstDoctorpayout[0].DisCount;
            decimal NAmount = lstDoctorpayout[0].NetAmount;
            decimal OStand = lstDoctorpayout[0].OutStanding;
            decimal PayAmount = lstDoctorpayout[0].PayableAmount;
            decimal PaidAmt = lstDoctorpayout[0].Paidamount;
            //string Fbid = Convert.ToString(hdnRowIndex.Value);
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "Update", "javascript:Updategrid(" + rno + "," + bCount + "," + bAmount + "," + dis + "," + NAmount + "," + OStand + "," + PayAmount + "," + PaidAmt + "," + hdnfinallist.Value + ");", true);
            //grdResult.Visible = true;
            lblGvSummary.Visible = false;
            btnSave.Visible = true;
            MPEDrpayoutdtls.Hide();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Doctorpayout Details.", ex);

        }
    }
    protected void grdResult_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ShowFinalbill")
        {
            //  btnSave.Text = "Delete";
            strBillFromDate = Convert.ToDateTime(txtFrom.Text + " 00:00:00 ");
            strBillToDate = Convert.ToDateTime(txtTo.Text + " 23:59:59");
            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            //TextBox patientid = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtpatientId");
            HiddenField hdnphyid = (HiddenField)grdResult.Rows[rowIndex].FindControl("hdnRefId");
            HiddenField hdnfbids = (HiddenField)grdResult.Rows[rowIndex].FindControl("hdnFinalbillID");
            FinalIds = hdnfbids.Value;
            int PhysicianID = Convert.ToInt32(hdnphyid.Value);
            hdnPhysicianID.Value = hdnphyid.Value;
            hdnRowIndex.Value = Convert.ToString(rowIndex);
            //grdResult.DataKeys[rowIndex]["hdnRefId"] != null ? (int)grdResult.DataKeys[rowIndex]["hdnRefId"] : 0;
            long returnCode = -1;
            byte Mode = 2;
            List<DoctorPayoutDetails> lstDocPayout = new List<DoctorPayoutDetails>();
            List<DoctorPayoutDetails> lstFinalbillid = new List<DoctorPayoutDetails>();
            AdminReports_BL AdminBL = new AdminReports_BL(base.ContextInfo);
            try
            {
                returnCode = AdminBL.SearchDoctorPayout(Convert.ToInt32(PhysicianID), strBillFromDate, strBillToDate, Mode, lstFinalbillid, lstDocPayout, out lstDoctorpayout);
                if (lstDoctorpayout.Count > 0)
                {
                    gvFianalDtls.Visible = true;
                    gvFianalDtls.DataSource = lstDoctorpayout;
                    gvFianalDtls.DataBind();
                }
                else
                {
                    gvFianalDtls.Visible = true;
                    gvFianalDtls.DataSource = lstDoctorpayout;
                    gvFianalDtls.DataBind();
                    gvFianalDtls.EmptyDataText = "No Matching Records Found!";
                }
                MPEDrpayoutdtls.Show();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Loading Doctorpayout Details.", ex);
            }
        }
    }

}