using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
public partial class CommonControls_BillSearch : BaseControl
{
    List<PaymentType> lPaymentType = new List<PaymentType>();
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long returnCode = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoRname.ContextKey = Convert.ToString(OrgID);
        AptName.ContextKey = Convert.ToString(OrgID); 
        if (!IsPostBack)
        {
            txtBillDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        }
        txtPatientName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtDrName.Attributes.Add("onkeydown", "return onKeyPressBlockNumbers(event);");
        txtBillNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string clientID = "";
        string strBillNo = "";
        string strPatientName = "";
        string strBillFromDate;
        string strDrName = "";
        string strBillToDate;
        List<BillSearch> billSearch = new List<BillSearch>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strPatientName = txtPatientName.Text;
        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
        strBillFromDate = txtBillDate.Text;
        strBillToDate = "";
        strBillNo = txtBillNo.Text;
        strDrName = txtDrName.Text;
        string[] ArrayDrName = strDrName.Split('~');
        strDrName = ArrayDrName[0] == "" ? "" : ArrayDrName[0].ToString();
         try
        {
            returnCode = patientBL.SearchBill(strBillNo, strBillFromDate, strBillFromDate, strPatientName, strDrName, "", clientID, OrgID, out billSearch);
        }
        catch
        {
        }
        if (returnCode == 0 && billSearch.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = billSearch;
            grdResult.DataBind();
            
            HasResult = true;
            if (grdResult.Columns.Count > 0)
            {
                if (RoleName == RoleHelper.LabAdmin)
                {
                    grdResult.Columns[2].Visible = true;
                    grdResult.Columns[3].Visible = false;
                }
                else
                {
                    grdResult.Columns[2].Visible = false;
                    grdResult.Columns[3].Visible = true;
                    //((LinkButton)e.Row.Cells[2].FindControl("lnkEdit")).Visible = false;
                    //e.Row.Cells[3].Visible = true;
                }
            }
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
        }
        onSearchComplete(this, e);
    }

    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BillSearch bs = (BillSearch)e.Row.DataItem;
                string strScript = "javascript:SelectBillNo('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + bs.BillID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                
            }
        }
        catch (Exception Ex)
        {
            //report error
        }
    }
    //protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    GridViewRow row = grdResult.SelectedRow;
    //}
    public string GetSelectedBill()
    {
        string BillID = "";
        if (Request.Form["bid"] != null && Request.Form["bid"].ToString() != "")
        {
            BillID = Convert.ToString(Request.Form["bid"]);
        }
        return BillID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }

    //protected void btnCancel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        List<Role> lstUserRole = new List<Role>();
    //        string path = string.Empty;
    //        Role role = new Role();
    //        role.RoleID = RoleID;
    //        lstUserRole.Add(role);
    //        returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
    //        Response.Redirect(Request.ApplicationPath + path, true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //}

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ShowBill")
            {
                long returncode = -1;
                long finalBillID = -1;
                Int64.TryParse(e.CommandArgument.ToString(), out finalBillID);
                List<AmountReceivedDetails> amtDetails = new List<AmountReceivedDetails>();
                returncode = new BillingEngine(base.ContextInfo).GetBillingDetails(finalBillID, OrgID, out amtDetails);
                if (amtDetails.Count > 0)
                {
                    hdnFinalBillID.Value = amtDetails[0].FinalBillID.ToString();
                    hdnAmt.Value = amtDetails.Sum(T => T.AmtReceived).ToString();
                    GridView1.DataSource = amtDetails;
                    GridView1.DataBind();
                    programmaticModalPopup.Show();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvBillDetails_RowCommand event in billsettlment page", ex);
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
//            new BillingEngine(base.ContextInfo).GetPaymentType(OrgID, out lPaymentType);
            AmountReceivedDetails Amount = (AmountReceivedDetails)e.Row.DataItem;
            DropDownList ddl = ((DropDownList)e.Row.FindControl("ddlList"));
            if (lPaymentType.Count > 0)
            {
                ddl.DataSource = lPaymentType;

                ddl.DataTextField = "PaymentName";
                ddl.DataValueField = "PaymentTypeID";
                ddl.DataBind();
                ddl.SelectedValue = Amount.TypeID.ToString();
            }
        }
    }

    protected void Update_Click(object sender, EventArgs e)
    {
        try
        {
            long returCode = -1;
            long finalBillID = -1;
            decimal serviceCharge = 0;
            decimal TotalAmt;
            string bankName = string.Empty;
            //decimal ChequeNo;

            List<AmountReceivedDetails> amtDetails = new List<AmountReceivedDetails>();
            foreach (GridViewRow gRow in GridView1.Rows)
            {
                AmountReceivedDetails eAmt = new AmountReceivedDetails();
                finalBillID = Convert.ToInt64(GridView1.DataKeys[gRow.RowIndex][2]);
                TextBox txtAmt = ((TextBox)gRow.FindControl("txtAmount"));
                decimal.TryParse(txtAmt.Text, out TotalAmt);
                eAmt.AmtReceived = TotalAmt;

                eAmt.AmtReceivedID = Convert.ToInt64(GridView1.DataKeys[gRow.RowIndex][1]);
                DropDownList ddl = (DropDownList)gRow.FindControl("ddlList");
                eAmt.TypeID = Convert.ToInt32(ddl.SelectedItem.Value);

                TextBox txtCheque = (TextBox)gRow.FindControl("txtCheque");
                //decimal.TryParse(txtCheque.Text, out ChequeNo);
                eAmt.ChequeorCardNumber = txtCheque.Text;

                TextBox txtbankName = (TextBox)gRow.FindControl("txtbankName");
                bankName = txtbankName.Text;
                eAmt.BankNameorCardType = bankName;

                eAmt.ModifiedBy = LID;
                amtDetails.Add(eAmt);
            }
            decimal chkAmt = amtDetails.Sum(p => p.AmtReceived);
            DataTable dTable = PaymentTypeDetails1.GetAmountReceivedDetails();
            foreach (DataRow dr in dTable.Rows)
            {
                chkAmt = chkAmt + Convert.ToDecimal(dr["AmtReceived"]);
            }
            if (chkAmt <= Convert.ToDecimal(hdnAmt.Value))
            {
                returCode = new BillingEngine(base.ContextInfo).UpdateAmountReceivedDetails(finalBillID, amtDetails);
                if (returCode != -1)
                {
                    //DataTable dTable = PaymentTypeDetails1.GetAmountReceivedDetails();
                    returCode = new BillingEngine(base.ContextInfo).InsertAmountReceivedDetails(dTable, OrgID, 0, LID, LID, finalBillID, serviceCharge);
                    PaymentTypeDetails1.Refresh = true;
                    Response.Redirect(Request.ApplicationPath + "/Reception/BillSearch.aspx", true);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.Page.GetType(), "scrAlert", "javascript:alert('Amount Entered is greater than bill amount');", true);
                PaymentTypeDetails1.Refresh = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in update amount received details", ex);
        }
    }
}
