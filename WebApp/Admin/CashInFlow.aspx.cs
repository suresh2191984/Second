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
public partial class Admin_CashInFlow : BasePage
{
    public Admin_CashInFlow()
        : base("Admin\\CashInFlow.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        long returnCode = -1;
        if (!IsPostBack)
        {
            List<IncomeSourceMaster> incSrcmaster = new List<IncomeSourceMaster>();
            returnCode = new Master_BL(base.ContextInfo).GetIncomeSourceMaster(OrgID, out incSrcmaster);
            if (incSrcmaster.Count > 0)
            {
                dPurpose.DataSource = incSrcmaster;
                dPurpose.DataTextField = "SourceName";
                dPurpose.DataValueField = "Code";
                dPurpose.DataBind();
                dPurpose.Items.Insert(0, new ListItem("--Select--", "0"));
            }
           // LoadInsertedData();
        }
            
        
    }
    private void LoadInsertedData()
    {
        //long returnCode = -1;
        //List<IncSourcePaidDetails> LstSource = new List<IncSourcePaidDetails>();
        //returnCode = new BillingEngine(base.ContextInfo).GetSourcePaidDetails(OrgID, 0, out LstSource);
        //if (LstSource.Count > 0)
        //{
        //    grdCashFlowdetails.DataSource = LstSource;
        //    grdCashFlowdetails.DataBind();
        //}
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
        //    long returnCode = -1;
        //    string ReferenceID = txtRefNo.Text;
        //    decimal AmtReceived;
        //    int recCurID;
        //    decimal recCurValues = 0;
        //    int paymentTypeID;
        //    string paymentType = ddlPaymentMode.SelectedItem.Text;
        //    string chequeNo = txtCheque.Text;
        //    string BankName = txtBankName.Text;
        //    string description = txtDescription.Text;
        //    int baseCurrencyID = 0;
        //    decimal.TryParse(txtAmoutn.Text, out AmtReceived);
        //    long SourceTypeID = -1;
        //    Int64.TryParse(dPurpose.SelectedItem.Value, out SourceTypeID);
        //    int.TryParse(ddlCurList.SelectedItem.Value, out recCurID);
        //    int.TryParse(ddlPaymentMode.SelectedItem.Value, out paymentTypeID);
        //    if (txtAmoutn.Text != string.Empty)
        //    {
        //        returnCode = new BillingEngine(base.ContextInfo).InsertCashInFlow(SourceTypeID, ReferenceID, AmtReceived, recCurID, recCurValues, paymentTypeID, paymentType, chequeNo, BankName, description, baseCurrencyID, LID, OrgID);
        //        if (returnCode != -1)
        //        {
        //            lblStatus.Text = "Data Saved Sucessfully";
        //            ClearData();
        //            LoadInsertedData();
        //        }
        //    }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  cash flow save", ex);
        }
    }
    private void ClearData()
    {
        dPurpose.SelectedValue = "0";
        txtRemarks.Text = string.Empty;
        txtPayableAmount.Text = "0.00";
        //txtBankName.Text = string.Empty;
        //txtCheque.Text = string.Empty;
        //txtDescription.Text = string.Empty;
        //txtRefNo.Text = string.Empty;
    }
    protected void grdCashFlowdetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //string s = e.CommandArgument.ToString();
        try
        {
            if (e.CommandName == "Select")
            {
                //int rowIndex = -1;
                //rowIndex = Convert.ToInt32(e.CommandArgument);
                //GridViewRow grow = grdCashFlowdetails.Rows[rowIndex];
                //hdnPaidDetailsID.Value = grdCashFlowdetails.DataKeys[rowIndex][0].ToString();
                //dPurpose.SelectedValue = grdCashFlowdetails.DataKeys[rowIndex][1].ToString();
                //ddlCurList.SelectedValue = grdCashFlowdetails.DataKeys[rowIndex][2].ToString();
                //ddlPaymentMode.SelectedValue = grdCashFlowdetails.DataKeys[rowIndex][3].ToString();
                //txtRefNo.Text = grow.Cells[3].Text == "--" ? "" : grow.Cells[3].Text;
                //txtBankName.Text = grow.Cells[6].Text == "--" ? "" : grow.Cells[6].Text;
                //txtCheque.Text = grow.Cells[7].Text == "--" ? "" : grow.Cells[7].Text;
                //txtDescription.Text = grow.Cells[8].Text == "--" ? "" : grow.Cells[8].Text;

                //txtAmoutn.Text = grow.Cells[1].Text;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ShowDeatails();", true);
                //btnUpdate.Visible = true;
                //btnSave.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdCashFlowdetails_RowCommand in cash inflow.aspx", ex);
        }
    }
    protected void grdCashFlowdetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
           // e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdCashFlowdetails, "Select$" + e.Row.RowIndex));
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            //long returnCode = -1;
            //string ReferenceID = txtRefNo.Text;
            //decimal AmtReceived;
            //int recCurID;
            //decimal recCurValues = 0;
            //int paymentTypeID;
            //string paymentType = ddlPaymentMode.SelectedItem.Text;
            //string chequeNo = txtCheque.Text;
            //string BankName = txtBankName.Text;
            //string description = txtDescription.Text;
            //int baseCurrencyID = 0;
            //decimal.TryParse(txtAmoutn.Text, out AmtReceived);
            //long SourceTypeID = -1;
            //Int64.TryParse(dPurpose.SelectedItem.Value, out SourceTypeID);
            //int.TryParse(ddlCurList.SelectedItem.Value, out recCurID);
            //int.TryParse(ddlPaymentMode.SelectedItem.Value, out paymentTypeID);
            //long PaidDetID = Convert.ToInt64(hdnPaidDetailsID.Value);
            //returnCode = new BillingEngine(base.ContextInfo).UpdateSourcePaidDetails(PaidDetID, SourceTypeID, ReferenceID, AmtReceived, recCurID, recCurValues, paymentTypeID, paymentType, chequeNo, BankName, description, baseCurrencyID, LID, OrgID);
            //if (returnCode != -1)
            //{
            //    lblStatus.Text = "Data Updated Sucessfully";
            //    ClearData();
            //    btnSave.Visible = true;
            //    btnUpdate.Visible = false;
            //    hdnPaidDetailsID.Value = string.Empty;
            //    LoadInsertedData();
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Update statement in CashInflow.aspx", ex);  
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long returncode = -1;
        List<Role> lstUserRole = new List<Role>();
        string path = string.Empty;
        Role role = new Role();
        role.RoleID = RoleID;
        lstUserRole.Add(role);
        returncode = new Navigation().GetLandingPage(lstUserRole, out path);
        Helper.PageRedirect(Page, Request.ApplicationPath + path); 
    }

    protected void grdCashFlowdetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            //grdCashFlowdetails.PageIndex = e.NewPageIndex;
            LoadInsertedData();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error gridview paging in cash in flow", ex);
        }
    }
    protected void bsave_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string ReceiptNo = string.Empty;
            string ReferenceID = txtVoucherNo.Text;
            string remarks = txtRemarks.Text;
            string SourceTypeCode = string.Empty;
            SourceTypeCode = dPurpose.SelectedItem.Value;
            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            dtAmountReceived = PaymentTypeDetails.GetAmountReceivedDetails();
            if (txtPayableAmount.Text != string.Empty)
            {
                returnCode = new BillingEngine(base.ContextInfo).InsertCashInFlow(SourceTypeCode, ReferenceID, dtAmountReceived, remarks, LID, OrgID, out ReceiptNo);
                if (returnCode != -1)
                {
                    ScriptManager.RegisterStartupScript(this.Page, GetType(), "clear", "javascript:ClearPaymentControlEvents();", true);
                    ClearData();
                    string VNO = string.Empty;
                    string OutFlowID = string.Empty;
                    string strReceiptNo = string.Empty;
                    strReceiptNo = ReceiptNo != null ? ReceiptNo : "";
                    string skey = "PrintVoucherPage.aspx?OID=" + OutFlowID + "&VONO=" + VNO + "&IFVNO=" + strReceiptNo;
                    this.Page.RegisterStartupScript("sky","<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while save cash Inflow details", ex);
        }
    }
}