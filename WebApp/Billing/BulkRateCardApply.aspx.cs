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

public partial class Billing_BulkRateCardApply : BasePage
{
    int QClientID = -1;
    int QnRateID = -1;
    string QFromDAte = string.Empty;
    string QToDate = string.Empty;
    int QOldRateID = -1;
    long BulkID = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            if (Request.QueryString["CID"] != null)
            {
                hdnqClientID.Value = Request.QueryString["CID"].ToString();
                QClientID = Convert.ToInt32(hdnqClientID.Value);
            }
            if (Request.QueryString["NRateID"] != null)
            {

                hdnqNewRateID.Value = Request.QueryString["NRateID"].ToString();
                QnRateID = Convert.ToInt32(hdnqNewRateID.Value);
                btnRateCard.Text = "Approve";
            }
            if (Request.QueryString["FDate"] != null)
            {

                hdnqFromDate.Value = Request.QueryString["FDate"].ToString();
                QFromDAte = hdnqFromDate.Value;
            }
            if (Request.QueryString["TDate"] != null)
            {

                hdnqToDate.Value = Request.QueryString["TDate"].ToString();
                QToDate = hdnqToDate.Value;
            }
            AutoCompleteExtender1.ContextKey = "-1";
            hdnOrgID.Value = OrgID.ToString();

            if (Request.QueryString["BID"] != null && Request.QueryString["BID"] != "")
            {

                hdnqBulkID.Value = Request.QueryString["BID"];
                BulkID = Convert.ToInt64(hdnqBulkID.Value);
                BillingEngine BE = new BillingEngine(base.ContextInfo);
                List<BulckRateUpdates> lstRateUpdates = new List<BulckRateUpdates>();
                List<RateMaster> lstClients = new List<RateMaster>();
                List<RateMaster> lstInvoice = new List<RateMaster>();
                List<RateMaster> lstrate = new List<RateMaster>();
                BE.GetRateAppliedRares(BulkID, out lstRateUpdates, out lstClients, out lstInvoice, out lstrate);
                if (lstRateUpdates.Count > 0)
                {

                    txtFrom.Text = QFromDAte;
                    txtTo.Text = QToDate;
                    if (lstClients.Count > 0)
                    {
                        txtClientNameSrch.Text = lstClients[0].RateName;
                    }
                    if (lstInvoice.Count > 0)
                    {
                        chkInvoice.DataSource = lstInvoice;
                        chkInvoice.DataTextField = "RateName";
                        chkInvoice.DataValueField = "DiscountPolicyID";
                        chkInvoice.DataBind();
                        foreach (ListItem item in chkInvoice.Items)
                        {
                            foreach (ListItem items in chkInvoice.Items)
                            {

                                if (item.Value == items.Value)
                                {
                                    items.Selected = true;
                                }
                            }
                        }

                    }
                    if (lstRateUpdates.Count > 0)
                    {
                        trGrdBulkRate.Style.Add("display", "table-row");
                        tdbtnRateCard.Style.Add("display", "table-cell");
                        GrdBulkRate.DataSource = lstRateUpdates;
                        GrdBulkRate.DataBind();
                    }
                    else
                    {
                        trGrdBulkRate.Style.Add("display", "none");
                        tdbtnRateCard.Style.Add("display", "none");
                    }

                    if (lstrate.Count > 0)
                    {
                        ChkRateNameForClient.DataSource = lstrate;
                        ChkRateNameForClient.DataTextField = "RateName";
                        ChkRateNameForClient.DataValueField = "RateId";
                        ChkRateNameForClient.DataBind();
                    }

                    foreach (ListItem item in ChkRateNameForClient.Items)
                    {
                        foreach (ListItem items in ChkRateNameForClient.Items)
                        {

                            if (item.Value == items.Value)
                            {
                                items.Selected = true;
                            }
                        }
                    }

                    //foreach (ListItem item in chkInvoice.Items)
                    //{
                 //       foreach (ListItem items in chkInvoice.Items)
                        //{

                         //   if (item.Value == items.Value)
                          //  {
                           //     items.Selected = true;
                           // }
                       // }
                  //  }

                }

                if (BulkID > 0)
                {
                    List<RateMaster> lstRateMaster = new List<RateMaster>();
                    List<RateMaster> AllRateMaster = new List<RateMaster>();
                    List<RateMaster> lstInvoice1 = new List<RateMaster>();
                    List<RateMaster> lstselratename = new List<RateMaster>();
                    long ReturnCode = -1;
                    string FromDate = string.Empty;
                    string TODate = string.Empty;
                    BillingEngine BEl = new BillingEngine(base.ContextInfo);
                    long InvoiceID = -1;
                    ReturnCode = BEl.GetRateNameForClients(OrgID, FromDate, TODate, Convert.ToInt64(hdnqClientID.Value), InvoiceID, out lstRateMaster, out AllRateMaster, out lstInvoice, out lstselratename);
                    if (AllRateMaster.Count > 0)
                    {
                        ddlratecardname.DataSource = AllRateMaster;
                        ddlratecardname.DataTextField = "RateName";
                        ddlratecardname.DataValueField = "RateId";
                        ddlratecardname.DataBind();
                        ddlratecardname.Items.Insert(0, "------SELECT------");
                        ddlratecardname.Items[0].Value = "-1";
                        ddlratecardname.SelectedValue = hdnqNewRateID.Value;
                    }
                    else
                    {
                        ddlratecardname.Items.Insert(0, "------SELECT------");
                        ddlratecardname.Items[0].Value = "-1";
                    }

                }


            }

        }


    }
    protected void btnsearch_Click(object sender, EventArgs e)
    {
        LoadRateNameList();
    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        GridBind();
    }
    protected void btnApply_Click(object sender, EventArgs e)
    {
        btnOk.Text = "Apply";
        GridBind();
        btnOk.Text = "Go";
    }
    public void LoadRateNameList()
    {
        try
        {

            trGrdBulkRate.Style.Add("display", "none");
            tdbtnRateCard.Style.Add("display", "none");
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            List<RateMaster> AllRateMaster = new List<RateMaster>();
            List<RateMaster> lstInvoice = new List<RateMaster>();
            List<RateMaster> lstselratename = new List<RateMaster>();
            string FromDate = string.Empty;
            string TODate = string.Empty;
            long ClientID = -1;
            int RateMappedAmt = 1;
            if (txtFrom.Text != null)
            {
                FromDate = txtFrom.Text.ToString();
            }
            else
            {

            }
            if (txtTo.Text != null)
            {
                TODate = txtTo.Text.ToString();
            }
            else
            {

            }
            long ReturnCode = -1;
            if (hdnClientID.Value != null && txtClientNameSrch.Text != null)
            {
                ClientID = Convert.ToInt64(hdnClientID.Value);
            }
            long InvoiceID = -1;
            BillingEngine BE = new BillingEngine(base.ContextInfo);
            ReturnCode = BE.GetRateNameForClients(OrgID, FromDate, TODate, ClientID,InvoiceID, out lstRateMaster, out AllRateMaster, out lstInvoice, out lstselratename);
            if (lstRateMaster.Count > 0)
            {
                ChkRateNameForClient.DataSource = lstRateMaster;
                ChkRateNameForClient.DataTextField = "RateName";
                ChkRateNameForClient.DataValueField = "RateId";
                ChkRateNameForClient.DataBind();
                trrateCard.Style.Add("display", "table-row");
                //btnsearch.Style.Add("display", "none");
                panelDispatchType.Style.Add("display", "block");
            }
            else
            {
                trrateCard.Style.Add("display", "none");
                btnsearch.Style.Add("display", "block");
                panelDispatchType.Style.Add("display", "none");
            }
            if (AllRateMaster.Count > 0)
            {
                ddlratecardname.DataSource = AllRateMaster;
                ddlratecardname.DataTextField = "RateName";
                ddlratecardname.DataValueField = "RateId";
                ddlratecardname.DataBind();
                ddlratecardname.Items.Insert(0, "------SELECT------");
                ddlratecardname.Items[0].Value = "-1";
            }
            else
            {
                ddlratecardname.Items.Insert(0, "------SELECT------");
                ddlratecardname.Items[0].Value = "-1";
                trrateCard.Style.Add("display", "none");
            }

            if (lstInvoice.Count > 0)
            {
                panelDispatchType.Style.Add("display", "block");
                chkInvoice.DataSource = lstInvoice;
                chkInvoice.DataTextField = "RateName";
                chkInvoice.DataValueField = "DiscountPolicyID";
                chkInvoice.DataBind();

            }
            foreach (ListItem item in ChkRateNameForClient.Items)
            {
                foreach (ListItem items in ChkRateNameForClient.Items)
                {

                    if (item.Value == items.Value)
                    {
                        items.Selected = true;
                    }
                }
            }

            //foreach (ListItem item in chkInvoice.Items)
           // {
                //foreach (ListItem items in chkInvoice.Items)
               // {

                 //   if (item.Value == items.Value)
                  //  {
                   //     items.Selected = true;
                  //  }
               // }
           // }
            //GridBind();
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Binding RateCardsFor Client", ex);
        }


    }
    public void GridBind()
    {
        try
        {
            int ClientID = -1;
            string FromDate = string.Empty;
            string TODate = string.Empty;
            int NewRateCardID = 0;
            int OldRateCardID = 0;
            int RateCardWithAmt = 0;
            List<BulckRateUpdates> lstBillings = new List<BulckRateUpdates>();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            if (txtFrom.Text != null)
            {
                FromDate = txtFrom.Text.ToString();
            }
            else
            {

            }
            if (txtTo.Text != null)
            {
                TODate = txtTo.Text.ToString();
            }
            else
            {

            }
            if (hdnClientID.Value != null && txtClientNameSrch.Text != null)
            {
                ClientID = Convert.ToInt32(hdnClientID.Value);
            }

            else
            {
                OldRateCardID = -1;
            }
            if (btnOk.Text == "Go")
            {
                RateCardWithAmt = 1;
                NewRateCardID = 0;
                foreach (ListItem oItem in ChkRateNameForClient.Items)
                {
                    if (oItem.Selected) // if you want only selected
                    {
                        OldRateCardID = Convert.ToInt32(oItem.Value);
                    }
                    else
                    {
                        OldRateCardID = -1;
                    }

                }

            }
            else
            {
                OldRateCardID = Convert.ToInt32(ChkRateNameForClient.SelectedItem.Value);

                RateCardWithAmt = 0;
                if (ddlratecardname.SelectedItem.Value != "-1")
                {
                    NewRateCardID = Convert.ToInt32(ddlratecardname.SelectedItem.Value);
                }
            }
            List<Invoice> lstInvoice = new List<Invoice>();

            for (int i = 0; i < chkInvoice.Items.Count; i++)
            {
                Invoice inv = new Invoice();
                if (chkInvoice.Items[i].Selected == true)
                {
                    inv.InvoiceID = Convert.ToInt64(chkInvoice.Items[i].Value);
                    lstInvoice.Add(inv);

                }
            }


            List<RateMaster> lstRateMaster = new List<RateMaster>();
            for (int i = 0; i < ChkRateNameForClient.Items.Count; i++)
            {
                RateMaster Rm = new RateMaster();
                if (ChkRateNameForClient.Items[i].Selected == true)
                {
                    Rm.RateId = Convert.ToInt32(ChkRateNameForClient.Items[i].Value);
                    lstRateMaster.Add(Rm);

                }
            }

            //billingEngineBL.GetRateDetailForBulckRateChanges(OrgID, ClientId, FDate, ToDate, OldRateid, NewRateid, out lstBillings);
            billingEngineBL.GetRateDetailForBulckRateChanges(OrgID, ClientID, FromDate, TODate, NewRateCardID, lstInvoice, lstRateMaster, out lstBillings);
            if (lstBillings.Count > 0)
            {
                GrdBulkRate.DataSource = lstBillings;
                GrdBulkRate.DataBind();
                trGrdBulkRate.Style.Add("display", "table-row");
                tdbtnRateCard.Style.Add("display", "table-cell");
            }
            else
            {
                tdbtnRateCard.Style.Add("display", "none");
                trGrdBulkRate.Style.Add("display", "none");
            }
        }



        catch (Exception ex)
        {

        }

    }

    protected void btnRateCard_Click(object sender, EventArgs e)
    {
        try
        {
            long taskID = 0;
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            if (btnRateCard.Text == "Approve")
            {
                List<Invoice> lstInvoice = new List<Invoice>();

                for (int i = 0; i < chkInvoice.Items.Count; i++)
                {
                    Invoice inv = new Invoice();
                    if (chkInvoice.Items[i].Selected == true)
                    {
                        inv.InvoiceID = Convert.ToInt64(chkInvoice.Items[i].Value);
                        lstInvoice.Add(inv);

                    }
                }


                List<RateMaster> lstRateMaster = new List<RateMaster>();
                for (int i = 0; i < ChkRateNameForClient.Items.Count; i++)
                {
                    RateMaster Rm = new RateMaster();
                    if (ChkRateNameForClient.Items[i].Selected == true)
                    {
                        Rm.RateId = Convert.ToInt32(ChkRateNameForClient.Items[i].Value);
                        lstRateMaster.Add(Rm);

                    }
                }
                billingEngineBL.InsertInvoiceRatediff(OrgID, Convert.ToInt32(hdnqClientID.Value), hdnqFromDate.Value, hdnqToDate.Value,
                    lstInvoice, lstRateMaster, Convert.ToInt32(hdnqNewRateID.Value), LID, Convert.ToInt64(hdnqBulkID.Value));
                if (Request.QueryString["tid"] != null)
                {
                    Int64.TryParse(Request.QueryString["tid"], out taskID);
                    new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
                    Response.Redirect("~/Reception/LabReceptionHome.aspx?IsPopup=Y&Appalert=true");
                }
            }
            else
            {

                long BulkID = 0;
                string FromDate = string.Empty;
                string ToDate = string.Empty;
                int ClientID = -1;
                long OldRateID = -1;
                long NewRateID = -1;

                List<BulckRateUpdates> lstBulckRateUpdates1 = new List<BulckRateUpdates>();
                foreach (GridViewRow item in GrdBulkRate.Rows)
                {
                    BulckRateUpdates lstBulckRateUpdates = new BulckRateUpdates();
                    if (txtFrom.Text != null)
                    {
                        FromDate = txtFrom.Text;
                    }
                    else
                    {
                        FromDate = OrgTimeZone;
                    }
                    if (txtTo.Text != null)
                    {
                        ToDate = txtTo.Text;
                    }
                    else
                    {
                        ToDate = OrgTimeZone;
                    }
                    HiddenField hdnbulkrateID = (HiddenField)item.FindControl("hdnbulkrateID");
                    HiddenField hdnVisitNumber = (HiddenField)item.FindControl("hdnVisitNumber");
                    HiddenField hdnOldAmount = (HiddenField)item.FindControl("hdnOldAmount");
                    HiddenField hdnNewAmount = (HiddenField)item.FindControl("hdnNewAmount");
                    HiddenField hdnnbillno = (HiddenField)item.FindControl("hdnnbillno");
                    HiddenField hdnFinalBillID = (HiddenField)item.FindControl("hdnFinalBillID");
                    HiddenField hdnInvoiceID = (HiddenField)item.FindControl("hdnInvoiceID");
                    HiddenField hdntotbillamount = (HiddenField)item.FindControl("hdntotbillamount");
                    if (hdnClientID.Value != null)
                    {
                        ClientID = Convert.ToInt32(hdnClientID.Value);

                    }
                    lstBulckRateUpdates.InvoiceID = Convert.ToInt64(hdnInvoiceID.Value);
                    OldRateID = Convert.ToInt64(ChkRateNameForClient.SelectedItem.Value);
                    NewRateID = Convert.ToInt64(ddlratecardname.SelectedItem.Value);
                    //lstBulckRateDiffMaster.BulckID =Convert.ToInt64(hdnbulkrateID.Value);
                    if (hdnFinalBillID.Value != null)
                    {
                        lstBulckRateUpdates.FinalbillID = Convert.ToInt64(hdnFinalBillID.Value);
                    }
                    lstBulckRateUpdates.ClientID = ClientID;
                    lstBulckRateUpdates.OldRateID = OldRateID;
                    lstBulckRateUpdates.NewRateID = NewRateID;
                    lstBulckRateUpdates.NewAmount = Convert.ToDecimal(hdnNewAmount.Value);
                    lstBulckRateUpdates.OldAmount = Convert.ToDecimal(hdnOldAmount.Value);
                    lstBulckRateUpdates.BillFromDate = Convert.ToDateTime(FromDate);
                    lstBulckRateUpdates.BillToDate = Convert.ToDateTime(ToDate);
                    lstBulckRateUpdates.TotBillAmt = Convert.ToDecimal(hdntotbillamount.Value);
                    lstBulckRateUpdates1.Add(lstBulckRateUpdates);
                }
                billingEngineBL.InsertBulkRateApply(OrgID, lstBulckRateUpdates1, out BulkID);
                CreateTask(BulkID);
                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alrUpdateSucess", "alert('Task Created');", true);
                Response.Redirect("~/Reception/LabReceptionHome.aspx?IsPopup=Y&showalert=true");
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Saving Data", ex);
        }

    }

    protected void CreateTask(long BulkID)
    {
        try
        {
            long AssingTo = -1;
            long taskID;
            long returnCode = 0;

            Tasks task = new Tasks();
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long TaskActionID = -1;
            long ClientID = 0;
            string ClientName = string.Empty;
            if (txtClientNameSrch.Text != null && hdnClientID.Value != "")
            {
                ClientName = hdnclientName.Value;
                ClientID = Convert.ToInt64(hdnClientID.Value);
            }

            TaskActionID = Convert.ToInt64(TaskHelper.TaskAction.BulckRateChanges);
            returnCode = Utilities.GetHashTableForBulckRates(TaskActionID, ClientID, ClientName, out dText, out urlVal);
            task.TaskActionID = Convert.ToInt32(TaskActionID);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            urlVal.Add("BulkID", BulkID);
            urlVal.Add("FDate", txtFrom.Text);
            urlVal.Add("TDate", txtTo.Text);
            urlVal.Add("OldRateID", ChkRateNameForClient.SelectedItem.Value);
            urlVal.Add("NewRateID", ddlratecardname.SelectedItem.Value);
            AssingTo = 2354;
            task.RoleID = AssingTo;
            task.OrgID = OrgID;

            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            Tasks_BL taskBL = new Tasks_BL();
            returnCode = taskBL.CreateTask(task, out taskID);
        }
        catch (Exception ex)
        {

        }


    }
    protected virtual void DisplayAlert(string message)
    {
        ClientScript.RegisterStartupScript(
          this.GetType(),
          Guid.NewGuid().ToString(),
          string.Format("alert('{0}');window.location.href = '~/Reception/LabReceptionHome.aspx?IsPopup=Y'",
            message.Replace("'", @"\'").Replace("\n", "\\n").Replace("\r", "\\r")),
            true);

    }
    protected void chkInvoice_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            long ReturnCode = -1;
            BillingEngine BE = new BillingEngine(base.ContextInfo);
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            List<RateMaster> AllRateMaster = new List<RateMaster>();
            List<RateMaster> lstInvoice = new List<RateMaster>();
            List<RateMaster> lstrateforselinvoice = new List<RateMaster>();
            string FromDate = string.Empty;
            string TODate = string.Empty;
            long ClientID = -1;
            FromDate = txtFrom.Text;
            TODate = txtTo.Text;
            if (txtClientNameSrch.Text != null && hdnClientID.Value != "-1")
            {
                ClientID = Convert.ToInt64(hdnClientID.Value);
            }
            long InvoiceID = -1;
            foreach (ListItem item in chkInvoice.Items)
            {
                if (item.Selected)
                {
                    InvoiceID = Convert.ToInt64(item.Value);
                }
            }
            ReturnCode = BE.GetRateNameForClients(OrgID, FromDate, TODate, ClientID, InvoiceID, out lstRateMaster, out AllRateMaster, out lstInvoice, out lstrateforselinvoice);
            if (lstrateforselinvoice.Count > 0)
            {
                ChkRateNameForClient.DataSource = lstrateforselinvoice;
                ChkRateNameForClient.DataTextField = "RateName";
                ChkRateNameForClient.DataValueField = "RateId";
                ChkRateNameForClient.DataBind();
            }
            foreach (ListItem item in ChkRateNameForClient.Items)
            {
                foreach (ListItem items in ChkRateNameForClient.Items)
                {

                    if (item.Value == items.Value)
                    {
                        items.Selected = true;
                    }
                }
            }
            trGrdBulkRate.Style.Add("display", "none");
            tdbtnRateCard.Style.Add("display", "none");
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while LLoading RateName in chkInvoice_SelectedIndexChanged", ex);
        }
    }
}
