using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.IO;
using System.Linq;

public partial class Reception_CreditDebitSummary : BasePage
{
    public Reception_CreditDebitSummary() : base("Reception_CreditDebitSummary_aspx") { }

    int currentPageNo = 1;
    int PageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    long patientID = -1;
    DateTime dtFrom;
    DateTime dtTo;
    protected void Page_Load(object sender, EventArgs e)
    {
        //AutoCompleteProduct.ContextKey = "1";

        AutoCompleteExtender1.ContextKey = "-1";
        dtFrom = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        dtTo = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        if (!IsPostBack)
        {
            //txtFrom.Text = System.DateTime.Today.ToString("dd/MM/yyyy");
            //txtTo.Text = System.DateTime.Today.ToString("dd/MM/yyyy");

            //AutoCompleteExtender1.ContextKey = OrgID.ToString();
            //AutoCompleteExtender2.ContextKey = OrgID.ToString();
            AutoAuthorizer.ContextKey = OrgID.ToString();
            DropDownlistBind();
            hdnCurrent.Value = "1";
            //loadgrid();
            LoadMetaData(); 
        }
        
    }
    public void DropDownlistBind()
    {
        string all = Resources.Reception_ClientDisplay.Reception_CreditDebitSummary_aspx_13 == null ? "All" : Resources.Reception_ClientDisplay.Reception_CreditDebitSummary_aspx_13;
        long returnCode = -1;
        List<ReasonMaster> lstReasonMaster = new List<ReasonMaster>();
        returnCode = new Master_BL(base.ContextInfo).GetReasonMasterCrDr(OrgID, out lstReasonMaster);

        ddlreason.DataSource = lstReasonMaster;
        ddlreason.DataTextField = "Reason";
        ddlreason.DataValueField = "ReasonID";
        ddlreason.DataBind();
        //ddlInvestigationStatus.Items.Insert(0, "------SELECT------");
        //ddlInvestigationStatus.Items[0].Value = "-1";

        //ddlInvestigationStatus.Items.Insert(lstInvestigationStatus., "aa");

       // ddlreason.Items.Insert(0, "------ALL------");
        ddlreason.Items.Insert(0, all);


    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strAlert = Resources.Reception_AppMsg.Reception_CreditDebitSummary_aspx_Alert == null ? "Alert" : Resources.Reception_AppMsg.Reception_CreditDebitSummary_aspx_Alert;
        try
        {
            long returnCode = -1;
            long returncode = -1;
            List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
            List<CreditDebitSummary> lstCreditInsert = new List<CreditDebitSummary>();
            List<CreditDebitSummary> lstCreditInsertPrint = new List<CreditDebitSummary>();
            CreditDebitSummary CrDr = new CreditDebitSummary();
            //CrDr.ReceiptNo = Convert.ToInt32(txtClientNameSrch.Text);
            CrDr.ItemType = hdnSetCreditDebit.Value;
            CrDr.ClientType = hdnddltypeCredit.Value;
            string clienti = hdnClientID.Value;
            long Client = Convert.ToInt32(hdnClientID.Value);
            string hdnreferenceno = TxtRefTypeNo.Text;
            hdnReferenceID.Value = hdnreferenceno;
            CrDr.ClientId = Client;
            long ReceiptNo = 0;
            int Orgid = OrgID;
            string ddlcredit1 = ddlcredit.Value;
            long RID = -1;
            Int64.TryParse(hdnReferenceNumber.Value, out RID);
            CrDr.ReferenceID = RID;
            if (ddlreason.SelectedItem.Value == "0")
            {
                CrDr.Reasonid = 0;
            }
            else
            {
                CrDr.Reasonid = Convert.ToInt64(ddlreason.SelectedValue);
                hdnreasoncredit.Value = ddlreason.SelectedItem.Text;
            }
            CrDr.Remarks = TxtRemarks.Text;
            if (ddltype.Text == "0")
            {
                CrDr.ReferenceType = string.Empty;
            }
            else
            {
                CrDr.ReferenceType = selectvalue.Value;
            }
            if (txtAuthorised.Text != string.Empty)
            {
                CrDr.Authorizedby = Convert.ToInt64(hdnAuthorised.Value);
            }
            else
            {
                CrDr.Authorizedby = 0;
            }
            CrDr.Amount = Convert.ToDecimal(TxtAmount.Text);
            lstCreditInsert.Add(CrDr);
            Master_BL MBL = new Master_BL(base.ContextInfo);

            returnCode = MBL.InsertCreditDebitSummary(lstCreditInsert, OrgID, out ReceiptNo);
            long Receipt = ReceiptNo;
            long Clientid = CrDr.ClientId;
            long AuthorizedId = CrDr.Authorizedby;
            int orgidprint = CrDr.OrgID;
            returnCode = new Master_BL(base.ContextInfo).GetCreditDebitSummaryforprint(Receipt, AuthorizedId, orgidprint, out lstCreditInsertPrint);

            if (ChkPrint.Checked == true)
            {
                this.Page.RegisterStartupScript("strKyAdvancePaidDetails", "<script type='text/javascript'> PopUpPage(); </script>");
            }

            hdnDatecredit.Value = OrgDateTimeZone;
            //hdnDatecredit.Value = Convert.ToString(lstCreditInsertPrint[0].CrDrDate);
            hdnIdCredit.Value = Convert.ToString(lstCreditInsertPrint[0].ReferenceID);
            hdnloginname.Value = LoginName;
            //hdnCrDrType.Value = CrDr.CrDrType;
            hdnClientType.Value = CrDr.ItemType;
            hdnIdCredit.Value = Convert.ToString(CrDr.ReferenceID);
            hdnReason.Value = CrDr.ReferenceType;
            hdnAuthorised.Value = Convert.ToString(lstCreditInsertPrint[0].AuthorizerName);
            hdnAmountCredit.Value = Convert.ToString(CrDr.Amount);
            hdnReceiptNoCredit.Value = Convert.ToString(ReceiptNo);
            hdnddltypeCredit.Value = CrDr.ClientType;
            hdnAddress.Value = lstCreditInsertPrint[0].Crdrtype;
            //hdnreasoncredit.Value = lstCreditInsertPrint[0].Reason;

            hdnremarks.Value = CrDr.Remarks;

            clear();
            if (returnCode > -1)
            {
                string AlertMesg = " Saved Successfully ";
                string PageUrl = Request.ApplicationPath + @"/Reception/CreditDebitSummary.aspx?IsPopup=Y";
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "javascript:ValidationWindow('" + AlertMesg + "','" + strAlert + "');window.location ='" + PageUrl + "';", true);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Erroer while Save ", ex);
        }

    }
    //protected void loadgrid()
    //{
    //    long returnCode = -1;
    //    List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
    //    CreditDebitSummary CrDr = new CreditDebitSummary();
    //    Master_BL MBL = new Master_BL(base.ContextInfo);
    //    returnCode = MBL.GetCreditDebitSummary(out lstCreditDebit);

    //    //if (lstCreditDebit.Count > 0)
    //    //{
    //    //    tblData.Style.Add("display", "block");
    //    //    datagrid.Style.Add("display", "block");
    //    //    gvCollectDeposit.DataSource = lstCreditDebit;
    //    //    gvCollectDeposit.DataBind();

    //    //}
    //}
    protected void gvCollectDeposit_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strUpdate = Resources.Reception_ClientDisplay.Reception_CreditDebitSummary_aspx_01 == null ? "Update" : Resources.Reception_ClientDisplay.Reception_CreditDebitSummary_aspx_01;
        try
        {
            if (e.CommandName == "Edit")
            {
                Int32 RowIndex = Convert.ToInt32(e.CommandArgument);
                string ClientId = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][0]);
                string ClientName = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][1]);
                string ClientType = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][2]);
                string ReferenceType = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][3]);
                string AuthorizerName = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][4]);
                string ItemType = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][5]);
                string Reason = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][6]);
                string ID = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][7]);
                string ReceiptNo = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][8]);
                string ReferenceID = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][9]);
                string Authorizedby = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][10]);
                string Remarks = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][11]);
                string Amount = Convert.ToString(gvCollectDeposit.DataKeys[RowIndex][12]);
                txtClientNameSrch.Text = ClientName;
                //ddlcredit.ToString = ClientType;
                txtAuthorised.Text = AuthorizerName;
                TxtRemarks.Text = Remarks;
                ddlreason.SelectedItem.Text = Reason;
                TxtAmount.Text = Amount;
                ddltype.Text = ReferenceType;
                if (ItemType == "Credit")
                {
                    rdoPS.Checked = true;
                    rdoTS.Checked = false;
                }
                else if (ItemType == "Debit")
                {
                    rdoTS.Checked = true;
                    rdoPS.Checked = false;
                }
                //txtAuthorised.Text = AuthorizedBy;
                //ddlcredit.SelectedItem.Text = CrDrType;
                //ddltype.SelectedItem.Text = CrDrType;
               
                
                //btnSave.Text = "Update";
                btnSave.Text = strUpdate;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Erroer while Get Details ", ex);
        }

    }
    protected void gvCollectDeposit_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }

    private void clear()
    {
        txtAuthorised.Text = string.Empty;
        txtClientNameSrch.Text = string.Empty;
        TxtRemarks.Text = string.Empty;
        TxtRefTypeNo.Text = string.Empty;
        txtClientNameSrch.Text = string.Empty;
        TxtAmount.Text = string.Empty;
        //ddlcredit.SelectedItem.Text = "---Select---";
        //ddltype.SelectedItem.Text = "---Select---";
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        try
        {
            hdnCurrent.Value = "";
            currentPageNo = 1;
            long returnCode = -1;
            int ClientID;
            dtFrom = ucDateCtrl.GetFromDate();
            dtTo = ucDateCtrl.GetToDate();
            string FrmDate = Convert.ToString(dtFrom);
            string ToDate = Convert.ToString(dtTo);
            //string FrmDate = txtFrom.Text != "" ? txtFrom.Text : string.Empty;
            //string ToDate = txtTo.Text != "" ? txtTo.Text : string.Empty;        
            if (txtClientNameSearch.Text == string.Empty)
            {
                ClientID = 0;
            }
            else
            {
                ClientID = Convert.ToInt32(hdnClientID1.Value);
            }

            int OrgId = Convert.ToInt32(ddlcreditsearch.Value);
            List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
            CreditDebitSummary CrDr = new CreditDebitSummary();
            Master_BL MBL = new Master_BL(base.ContextInfo);
            returnCode = MBL.GetCreditDebitSummary(ClientID, FrmDate, ToDate, OrgId, PageSize, currentPageNo, out totalRows, out lstCreditDebit);

            if (lstCreditDebit.Count > 0)
            {
                tblData.Style.Add("display", "table");
                datagrid.Style.Add("display", "block");
                gvCollectDeposit.DataSource = lstCreditDebit;
                gvCollectDeposit.DataBind();
            }
            else
            {
                tblData.Style.Add("display", "none");
                datagrid.Style.Add("display", "none");
            }
            if (lstCreditDebit.Count > 0)
            {
                GrdFooter.Style.Add("display", "block");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Erroer while Get Details ", ex);
        }

    }
    protected void btnPrevious_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnNext_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
            Btn_Search(currentPageNo, PageSize);
        }
        txtpageNo.Text = "";
    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = (int)Math.Ceiling(totalRows / PageSize);
        return totalPages;
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        Btn_Search(Convert.ToInt32(txtpageNo.Text), PageSize);
    }
    protected void gvCollectDepositDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                CreditDebitSummary D = (CreditDebitSummary)e.Row.DataItem;
                string strScript = "CallPrintReceipt('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoID")).ClientID + "','" + D.CrDrDate + "','" + D.ClientId + "','" + D.ClientName + "','" + D.AuthorizerName + "','" + D.ReferenceType + "','" + D.Crdrtype + "','" + D.BillNumber + "','" + D.ReferenceID + "','" + D.ReceiptNo + "', '" + D.ClientType + "' , '" + D.Amount + "' , '" + D.Remarks + "' ,'" + D.Reason + "','" + D.Crdrtype + "','" + D.ItemType + "');"; 
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdoID")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollectDepositDetails_RowDataBound", ex);
        }
    }

    private void Btn_Search(int currentPageNo, int PageSize)
    {
        try
        {
            long returnCode = -1;
            int ClientID;
            dtFrom = ucDateCtrl.GetFromDate();
            dtTo = ucDateCtrl.GetToDate();
            string FrmDate = Convert.ToString(dtFrom);
            string ToDate = Convert.ToString(dtTo);
            //string FrmDate = txtFrom.Text != "" ? txtFrom.Text : string.Empty;
            //string ToDate = txtTo.Text != "" ? txtTo.Text : string.Empty;
            if (txtClientNameSearch.Text == string.Empty)
            {
                ClientID = 0;
            }
            else
            {
                ClientID = Convert.ToInt32(hdnClientID1.Value);
            }
            int OrgId = OrgID;
            List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();
            CreditDebitSummary CrDr = new CreditDebitSummary();
            Master_BL MBL = new Master_BL(base.ContextInfo);
            returnCode = MBL.GetCreditDebitSummary(ClientID, FrmDate, ToDate, OrgId, PageSize, currentPageNo, out totalRows, out lstCreditDebit);

            if (lstCreditDebit.Count > 0)
            {
                tblData.Style.Add("display", "block");
                datagrid.Style.Add("display", "block");
                gvCollectDeposit.DataSource = lstCreditDebit;
                gvCollectDeposit.DataBind();
            }
            else
            {
                tblData.Style.Add("display", "none");
                datagrid.Style.Add("display", "none");
            }
            if (lstCreditDebit.Count > 0)
            {
                GrdFooter.Style.Add("display", "block");
                totalpage = totalRows;
                lblTotal.Text = CalculateTotalPages(totalRows).ToString();
                if (hdnCurrent.Value == "")
                {
                    lblCurrent.Text = currentPageNo.ToString();
                }
                else
                {
                    lblCurrent.Text = hdnCurrent.Value;
                    currentPageNo = Convert.ToInt32(hdnCurrent.Value);
                }
                if (currentPageNo == 1)
                {
                    btnPrevious.Enabled = false;
                    if (Int32.Parse(lblTotal.Text) > 1)
                    {
                        btnNext.Enabled = true;
                    }
                    else
                        btnNext.Enabled = false;
                }
                else
                {
                    btnPrevious.Enabled = true;
                    if (currentPageNo == Int32.Parse(lblTotal.Text))
                        btnNext.Enabled = false;
                    else btnNext.Enabled = true;
                }
            }
            else
                GrdFooter.Style.Add("display", "none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in gvCollectDepositDetails_RowDataBound", ex);
        }

    }
    // andrews
    public void LoadMetaData()
    {
        try
        {
            long returncode = 0;
            string domains = "TypeClient,credit";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            string select = Resources.Reception_ClientDisplay.Reception_Collections_aspx_03 == null ? "---Select---" : Resources.Reception_ClientDisplay.Reception_Collections_aspx_03;
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            { 
            
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "TypeClient"
                                 select child;
                ddltype.DataSource = childItems;
                ddltype.DataTextField = "DisplayText";
                ddltype.DataValueField = "Code";
                ddltype.DataBind();

                ddltype.Items.Insert(0, select);
                ddltype.Items.Insert(0, select);

                var childItems1 = from child in lstmetadataOutput
                                 where child.Domain == "credit"
                                 select child;
                ddlcreditsearch.DataSource = childItems1;
                ddlcreditsearch.DataTextField = "DisplayText";
                ddlcreditsearch.DataValueField = "Code";
                ddlcreditsearch.DataBind();
                ddlcreditsearch.Items.Insert(0, select);

                ddlcredit.DataSource = childItems1;
                ddlcredit.DataTextField = "DisplayText";
                ddlcredit.DataValueField = "Code";
                ddlcredit.DataBind();
                ddlcredit.Items.Insert(0, select);

                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
        }
    }
    // andrews

}
