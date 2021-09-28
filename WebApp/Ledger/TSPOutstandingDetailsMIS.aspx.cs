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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Podium.BillingEngine;

public partial class Ledger_TSPOutstandingDetailsMIS : BasePage
{
    public DateTime from, to;
    protected void Page_Load(object sender, EventArgs e)
    {
        //CID = 29;
        if (!IsPostBack)
        {
            
            DateTime firstDayOfTheMonth = new DateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year, Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month, 1);
            txtFrom.Text = Convert.ToString(firstDayOfTheMonth.AddDays(1).AddMonths(-1).AddDays(-1).ToString("MMMM yyyy"));
            txtTo.Text = Convert.ToString(firstDayOfTheMonth.ToString("MMMM yyyy"));
            if (CID > 0)
            {
                TSPClientDetails();
                
                getMonthClosing();
            }
        }
        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1; 
    }
    
    private void TSPClientDetails()
    {
        ClientLedger_BL ObjTSPClientDetails = new ClientLedger_BL(base.ContextInfo);
        List<TSPClientDetails> lstTSPClientDetails = new List<TSPClientDetails>();
        long clientID = 0;
        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        string pType = string.Empty;
        string ClientCode = string.Empty;
        long refhospid = -1;
        if (CID > 0)
        {
            
            pType = "CLP";
            refhospid = CID;
            lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
            txtClientName.Visible = false;
            lblClientName.Visible = false;
            imgMandatory.Visible = false;
            
            if (lstClientNames.Count > 0)
            {
                string[] ClientValues = lstClientNames[0].Value.Split('^');
                clientID = Convert.ToInt64(ClientValues[5].ToString());
                ClientCode = ClientValues[3].ToString();
                hdnClientDet.Value = ClientCode;
                string a = (ClientValues[2] + '(' + ClientValues[3].ToString() + ')').ToString();
                txtClientName.Text = a;
                txtClientName.Enabled = true;
            }
        }
        else
        {
            txtClientName.Visible = true;
            lblClientName.Visible = true;
            imgMandatory.Visible = true;
            ClientCode = hdnClientID.Value.ToString();
            clientID = Convert.ToInt64(hdnClientValue.Value.ToString());
        }
        ObjTSPClientDetails.GetTSPClientAddress(OrgID, clientID, out lstTSPClientDetails);
        try
        {
            if (lstTSPClientDetails.Count > 0)
            {
                lblrstEMD.Text = lstTSPClientDetails[0].EMD;
                lblrstAddress.Text = lstTSPClientDetails[0].Add1;
                lblrstPinCode.Text = Convert.ToString(lstTSPClientDetails[0].PostalCode);
                lblrstContactNo.Text = Convert.ToString(lstTSPClientDetails[0].MobileNumber);
                lblrstPanNo.Text = Convert.ToString(lstTSPClientDetails[0].PanNo);
                divClientName.Style.Add("display", "");
                lnkXL.Visible = true;
                imgBtnXL.Visible = true;
     
            }
            else
            {

                lblrstEMD.Text = string.Empty;
                lblrstAddress.Text = string.Empty;
                lblhdrPincode.Text = string.Empty;
                lblrstContactNo.Text = string.Empty;
                lblrstPanNo.Text = string.Empty;
                divClientName.Style.Add("display","none");
                lnkXL.Visible = false;
                imgBtnXL.Visible = false;
            }

        }
        catch (Exception er)
        {
            CLogger.LogError("", er);
        }


    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        TSPClientDetails();
        getMonthClosing();
    }
    private void getMonthClosing()
    {
       
        ClientLedger_BL ObjClientClosingMonth = new ClientLedger_BL(base.ContextInfo);
        List<ClientOutStanding> lstClientClosingMonth = new List<ClientOutStanding>();
        //lblErrMsg.Text = string.Empty;
         int datedifference;
    
        string tFrom = Convert.ToDateTime("01 " + (txtFrom.Text)).ToString("dd/MM/yyyy");
        from = Convert.ToDateTime(tFrom);
        string tTo = Convert.ToDateTime("01 " + (txtTo.Text)).ToString("dd/MM/yyyy");
        to = Convert.ToDateTime(tTo);
        datedifference = Convert.ToInt32((to-from).TotalDays.ToString());
        
        if (datedifference < 0)
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('From Month should less than To Month..!');", true);
            grdMonthClosing.Visible =false;
            lblTotBills.Text = "0.00";
            lblTotClosingBalance.Text = "0.00";
            lblTotCredit.Text = "0.00";
            lblTotDebit.Text = "0.00";
            lblTotReceipt.Text = "0.00";
            lblTotOpningBalance.Text = "0.00";
        }
        else
        {
           
            if (datedifference <= 190)
            {
                if (CID > 0)
                {
                    hdnClientID.Value = hdnClientDet.Value;
                }
                ObjClientClosingMonth.GetClientClosingMonth(OrgID, hdnClientID.Value, from, to, out lstClientClosingMonth);
                try
                {
                    decimal TotReceipt, TotBill, TotCredit, TotDebit, TotOpeningBalance, TotClosingBalance;
                    TotReceipt = 0;
                    TotCredit = 0;
                    TotDebit = 0;
                    TotBill = 0;
                    TotOpeningBalance = 0;
                    TotClosingBalance = 0;
                    if (lstClientClosingMonth.Count > 0)
                    {
                        int count = Convert.ToInt32(lstClientClosingMonth.Count);
                        TotClosingBalance = Convert.ToDecimal(lstClientClosingMonth[count - 1].OutStanding);
                        TotOpeningBalance = Convert.ToDecimal(lstClientClosingMonth[0].OpeningBalance);
                        grdMonthClosing.DataSource = lstClientClosingMonth;
                        grdMonthClosing.DataBind();
                        for (int i = 0; i < lstClientClosingMonth.Count; ++i)
                        {
                            TotReceipt = TotReceipt + Convert.ToDecimal(lstClientClosingMonth[i].Receipt);
                            TotBill = TotBill + Convert.ToDecimal(lstClientClosingMonth[i].Bill);
                            TotCredit = TotCredit + Convert.ToDecimal(lstClientClosingMonth[i].Credit);
                            TotDebit = TotDebit + Convert.ToDecimal(lstClientClosingMonth[i].Debit);
                        }
                        lblTotBills.Text = Convert.ToString(TotBill);
                        lblTotCredit.Text = Convert.ToString(TotCredit);
                        lblTotDebit.Text = Convert.ToString(TotDebit);
                        lblTotReceipt.Text = Convert.ToString(TotReceipt);
                        lblDispFromdate.Text = "01 " + (txtFrom.Text);
                        lblDispTodate.Text = "01 " + (txtTo.Text);
                        lblTotOpningBalance.Text = Convert.ToString(TotOpeningBalance);
                        lblTotClosingBalance.Text = Convert.ToString(TotClosingBalance);
                        grdMonthClosing.Visible = true;
                        divGridHeaderFooter.Style.Add("display", "");
                        divMessage.Attributes.Add("class", "hide");
                        lblErrMsg.Text = string.Empty;
                        lblErrMsg.Visible = false;
                    }
                    else
                    {
                        grdMonthClosing.DataSource = null;
                        grdMonthClosing.Visible = false;
                        lblTotBills.Text = "0.00";
                        lblTotClosingBalance.Text = "0.00";
                        lblTotCredit.Text = "0.00";
                        lblTotDebit.Text = "0.00";
                        lblTotReceipt.Text = "0.00";
                        lblTotOpningBalance.Text = "0.00";
                        divGridHeaderFooter.Style.Add("display", "none");
                        divMessage.Attributes.Add("class", "ui-widget message-container marginT20");
                        lblErrMsg.Text = "  No Matching Records Found!";
                        lblErrMsg.Visible = true;
                    }
                }
                catch (Exception er)
                {
                    CLogger.LogError("Error while Executing grdOutstandingList ClientOutstanding.aspx  ", er);
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('No of months should be in between 6 Months..!');", true);
            }
        }
        
        
    }
    protected void grdMonthClosing_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdMonthClosing.PageIndex = e.NewPageIndex;
            }
            getMonthClosing();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading lstNarrationList page ClientCreditApproval.aspx ", ex);
        }
    }
    public void ExportToExcel()
    {
        try
        {
            string attachment = "attachment; filename=CreditDebitStatus_" + OrgTimeZone + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdMonthClosing.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.End();
        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    protected void imgBtnXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel();
    }
    protected void lnkXL_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }


    protected void btnReset_Click(object sender, EventArgs e)
    {
        
        //txtClientName.Text = string.Empty;

        //DateTime firstDayOfTheMonth = new DateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).Year, Convert.ToDateTime(new BasePage().OrgDateTimeZone).Month, 1);
        //txtFrom.Text = Convert.ToString(firstDayOfTheMonth.AddDays(1).AddMonths(-1).AddDays(-1).ToString("MMMM yyyy"));
        //txtTo.Text = Convert.ToString(firstDayOfTheMonth.ToString("MMMM yyyy"));
        Response.Redirect("TSPOutstandingDetailsMIS.aspx");
    }
}
