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

public partial class Billing_BillSettlement :BasePage
{
    #region VariableDecleration

    List<ReceivedAmount> lstAmountReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstAmountRefundDetails = new List<ReceivedAmount>();
    List<AmountClosureDetails> lstAmountClosure = new List<AmountClosureDetails>();
    List<ReceivedAmount> lstINDAmtReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstINDIPAmtReceivedDetails = new List<ReceivedAmount>();
    List<DayWiseCollectionReport> lstDayWise = new List<DayWiseCollectionReport>();
    List<ReceivedAmount> lstRcvdUserSplitup = new List<ReceivedAmount>();
    List<ReceivedAmount> lstCollections = new List<ReceivedAmount>();
    decimal totalAmount = 0;
    decimal refundAmount = 0; decimal cancellationAmount = 0;
    decimal drAmount = 0;
    decimal othersAmount = 0;
    decimal TotalPendingDue = 0;
    string sstatus = string.Empty;
    string userID = string.Empty;
    long lUserID = 0;
    long retval = -1;
    string sAllAmtReceivedID = string.Empty;
    int flag = 0;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    int showPaidCurrency = 0;
    int showPaidCurrency1 = 0;
    decimal pPaidCurrencyTotal = -1;
    string pPaidCurrencyCode = string.Empty;
    List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
    SharedInventory_BL inventoryBL;
    List<Organization> lstorgn = new List<Organization>();
    List<Locations> lstloc = new List<Locations>();
    decimal TotalIncAmount = 0;
    string allobj = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_04 == null ? "-----All-----" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_04;
    string all = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_05 == null ? "All" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_05;
    string date = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_06 == null ? "Date:" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_06;
    string report = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_07 == null ? "Report From :" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_07;
    string to = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_08 == null ? "  To  " : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_08;
    string amount = Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_09 == null ? "No amount received" : Resources.Admin_ClientDisplay.Admin_DaywiseCollection_aspx_09;
    #endregion
    public Billing_BillSettlement() : base("Billing_BillSettlement_aspx") { }

    #region pageLoad


    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new SharedInventory_BL(base.ContextInfo);

        txtFromDate.Attributes.Add("onchange", "ExcedDate('" + txtFromDate.ClientID.ToString() + "','',0,0);");
        txtToDate.Attributes.Add("onchange", "ExcedDate('" + txtToDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtToDate.ClientID.ToString() + "','txtFromDate',1,1);");
        if (!IsPostBack)
        {
            LoadOrgan();
            BindListofUsers();
            btnPrint.Visible = false;
            txtFromDate.Text = OrgTimeZone;
            txtToDate.Text = OrgTimeZone;
            BindCurrencyMaster();
            tralldetails.Style.Add("display", "none");
            trbeakupdetails.Style.Add("display", "none");
            LoadLocation();
            ddlLocation.SelectedValue = ILocationID.ToString();
        }
        divname.Style.Add("display", "none");
        List<Config> lstConfig = new List<Config>();
        new GateWay(base.ContextInfo).GetBillConfigDetails(3, "Header Content", OrgID, ILocationID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            lblHospitalName.InnerHtml = lstConfig[0].ConfigValue.Trim();
        }

        lblcurrentdate.Text = "Report Generated Date: "+ OrgTimeZone;
        lblfromtodate.Text=report+ txtFromDate.Text + to + txtToDate.Text;

    }


    #endregion

    #region Custom Functions
    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                ddlTrustedOrg.DataSource = lstOrgList;
                ddlTrustedOrg.DataTextField = "Name";
                ddlTrustedOrg.DataValueField = "OrgID";
                ddlTrustedOrg.DataBind();
                ddlTrustedOrg.SelectedValue = lstOrgList.Find(p => p.OrgID == OrgID).ToString();
                ddlTrustedOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }
  
    protected void BindCurrencyMaster()
    {
        List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
        new Master_BL(base.ContextInfo).GetOrgMappedCurrencies(OrgID, out lstCurrOrgMapp);
        if (lstCurrOrgMapp.Count > 0)
        {
            ddlCurrency.DataSource = lstCurrOrgMapp;
            ddlCurrency.DataTextField = "CurrencyName";
            ddlCurrency.DataValueField = "CurrencyID";
            ddlCurrency.DataBind();
            //ddlCurrency.Items.Insert(0, "-----All-----");
            ddlCurrency.Items.Insert(0, allobj);
            ddlCurrency.Items[0].Value = "0";
            //ddlCurrency.SelectedValue = BaseCurrencyID.ToString();

        }
    }


    protected void BindListofUsers()
    {
       // chklstusers.Items.Clear();
       // List<Users> lstUserIDs = new List<Users>();
       // if (ddlTrustedOrg.Items.Count > 0)
       // {
       //     OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            
       // }

       // long iOrgID = Int64.Parse(OrgID.ToString());
       //// retval = new BillingEngine(base.ContextInfo).GetListOfUsers(OrgID, out lstUsers);
       // retval = new BillingEngine(base.ContextInfo).GetUserIDs(iOrgID, out lstUserIDs);
       // if (lstUserIDs.Count > 0)
       // {
       //     string config = GetConfigValue("SelectedUser", OrgID);
       //     if (RoleName != "Administrator" && config == "Y")
       //     {
       //         var list = lstUserIDs.FindAll(p => p.UserID == LID);
       //         chklstusers.DataSource = list.ToList();
       //         chklstusers.DataTextField = "Name";
       //         chklstusers.DataValueField = "UserID";
       //         chklstusers.DataBind();
              
       //         for (int i = 0; i < chklstusers.Items.Count; i++)
       //         {
       //             chklstusers.Items[i].Selected = true;
                   
       //         }

       //         if (list.Count > 0)
       //         {
       //             lblUName.Text = list[0].Name;

       //         }
       //         else
       //         {
       //             lblUName.Text = "";
       //         }

       //         tdimg.Style.Add("display", "none");
       //     }
       //     else
       //     {
       //         for (int i = 0; i < chklstusers.Items.Count; i++)
       //         {
       //             chklstusers.Items[i].Selected = false;
       //         }
       //         chklstusers.DataSource = lstUserIDs;
       //         chklstusers.DataTextField = "Name";
       //         chklstusers.DataValueField = "UserID";
       //         chklstusers.DataBind();
                
       //     }
       // }
        //ddlUser.Items.Clear();

        //if (retval == 0)
        //{
        //    ddlUser.DataSource = lstUsers;

        //    ddlUser.DataTextField = "NAME";
        //    ddlUser.DataValueField = "UserID";

        //    ddlUser.DataBind();
        //}
        //ddlUser.Items.Insert(0, new ListItem("--All--", "0"));
        int LocationId = 0;
        AmountReceived_BL AmountReceivedBL = new AmountReceived_BL(base.ContextInfo);
        List<AmountReceivedDetails> lstAmtRecDetails = new List<AmountReceivedDetails>();
        if (ddlTrustedOrg.Items.Count > 0)
            OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
        if (ddlLocation.Items.Count > 0)
            LocationId = Convert.ToInt32(ddlLocation.SelectedValue);
        AmountReceivedBL.GetRecievedUser(OrgID, LocationId, out lstAmtRecDetails);
        if (lstAmtRecDetails.Count > 0)
        {
            chklstusers.DataSource = lstAmtRecDetails;
            chklstusers.DataTextField = "Receiver_Name";
            chklstusers.DataValueField = "ReceivedBy";
            chklstusers.DataBind();
            Chkboxusers.Style.Add("display", "block");
            tdimg.Style.Add("display", "block");
        }

    }
    #endregion


    private void LoadLocation()
    {
        long returnCode = -1;
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        // Below Current Org Location
        //returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        // Below is Trusted Org Location

        returnCode = patientBL.GetLocation(OrgID, LID, RoleID, out lstLocation);
        //  returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lstLocation);

        if (lstLocation.Count > 0)
        {


            ddlLocation.DataSource = lstLocation;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "AddressID";
            ddlLocation.DataBind();


            if (lstLocation.Count == 1)
            {
               // ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items.Insert(0, all);
                ddlLocation.Items[0].Value = "-1";
            }
            else if (lstLocation.Count == 0 || lstLocation.Count > 1)
            {
                ddlLocation.Items.Insert(0, all);
                //ddlLocation.Items.Insert(0, "All");
                ddlLocation.Items[0].Value = "-1";
            }
            //ddlLocation.SelectedValue = ILocationID.ToString();



        }
    }
    protected void ddlUser_SelectedIndexChanged(object sender, EventArgs e)
    {
        //try
        //{
        //    pPaidCurrencyTotal = 0;
        //    showPaidCurrency = 0;
        //    showPaidCurrency1 = 0;
        //    pPaidCurrencyCode = string.Empty;
        //    int currencyID = 0;

        //    totalAmount = 0;
        //    refundAmount = 0;
        //    drAmount = 0;


        //    DataTable dtUser = new DataTable();
        //    DataColumn dbCol1 = new DataColumn("LoginID");
        //    dtUser.Columns.Add(dbCol1);
        //    DataRow dr;

        //    foreach (ListItem chkitem in chklstusers.Items)
        //    {

        //        if (chkitem.Selected == true)
        //        {
        //            string chkValue = chkitem.Value.ToString();
        //            dr = dtUser.NewRow();
        //            dr["LoginID"] = Convert.ToInt64(chkValue);
        //            dtUser.Rows.Add(dr);

        //        }
        //    }
        //    DateTime pFDT;
        //    DateTime.TryParse(txtFromDate.Text.Trim(), out pFDT);
        //    DateTime pTDT;
        //    DateTime.TryParse(txtToDate.Text.Trim(), out pTDT);

        //    long lUserID = Int64.Parse(ddlUser.SelectedValue);
        //    long lUserID = 0;
        //    long retval1 = 0;
        //    List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
        //    currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);

        //    retval = new BillingEngine(base.ContextInfo).GetAmountReceivedDetailsForDaily(lUserID, OrgID, pFDT, pTDT, currencyID,
        //                    out lstAmountReceivedDetails,
        //                    out lstAmountRefundDetails,
        //                    out lstPaymentDetails,
        //                    out totalAmount,
        //                    out refundAmount, out cancellationAmount,
        //                    out drAmount,
        //                    out othersAmount,
        //                    out lstINDAmtReceivedDetails,
        //                    out lstINDIPAmtReceivedDetails,
        //                    out lstDayWise,
        //                    out lstRcvdUserSplitup,
        //                    dtUser);

        //    divAllUsers.Style.Add("display", "none");
        //    divSingleUser.Style.Add("display", "none");
        //    tralldetails.Style.Add("display", "block");
        //    trbeakupdetails.Style.Add("display", "block");


        //    if (lUserID == 0)
        //        if (dtUser.Columns.Count == 0)
        //        {
        //            divAllUsers.Style.Add("display", "block");


        //            gvAllUsers.DataSource = lstAmountReceivedDetails;
        //            gvAllUsers.DataBind();
        //            gvAllUsersRefund.DataSource = lstAmountRefundDetails;
        //            gvAllUsersRefund.DataBind();
        //            gvAllUsersPayments.DataSource = lstPaymentDetails;
        //            gvAllUsersPayments.DataBind();
        //        }
        //        else
        //        {
        //            divSingleUser.Style.Add("display", "block");


        //            gvRefundDetailssplitup.DataSource = lstINDAmtReceivedDetails;
        //            gvRefundDetailssplitup.DataBind();


        //            gvBillDetails.DataSource = lstAmountReceivedDetails;
        //            gvBillDetails.DataBind();

        //            gvPaymentDetails.DataSource = lstPaymentDetails;
        //            gvPaymentDetails.DataBind();

        //            gvRefundDetails.DataSource = lstAmountRefundDetails;
        //            gvRefundDetails.DataBind();


        //        }
        //    lblTotal.Text = totalAmount.ToString();

        //    lblRefund.Text = refundAmount.ToString();


        //    lblCancelledAmount.Text = cancellationAmount.ToString();



        //    lblOthersAmount.Text = othersAmount.ToString();


        //    refundAmount = (refundAmount == -1 ? 0 : refundAmount);
        //    totalAmount = (totalAmount == -1 ? 0 : totalAmount);
        //    cancellationAmount = (cancellationAmount == -1 ? 0 : cancellationAmount);
        //    lblClosingBalance.Text = (totalAmount - (refundAmount + cancellationAmount + drAmount + othersAmount)).ToString();




        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error occured converting to Excel", ex);
        //}
    }


    protected void gvAllUsers_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UserLink")
        {
            userID = e.CommandArgument.ToString();
            hdnLID.Value = userID;
           // ViewState["LoginID"] = userID;
            //ddlUser.SelectedIndex = ddlUser.Items.IndexOf(ddlUser.Items.FindByValue(userID));

            //ddlUser_SelectedIndexChanged(sender, e);
            bindindividualuser(userID);
          // Bindusersdata(sender, e);

            //ddlUser.Items.FindByValue(userID).Selected = true;
        }
    }


    protected void btnViewDetails_Click(object sender, EventArgs e)
    {
        //ddlUser_SelectedIndexChanged(sender, e);
        btnPrint.Visible = true;
        Bindusersdata(sender,e);
    }


    protected void gvAllUsersPayments_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UserPaidLink")
        {
           userID = e.CommandArgument.ToString();
          
            //ddlUser.SelectedIndex = ddlUser.Items.IndexOf(ddlUser.Items.FindByValue(userID));
            //ddlUser_SelectedIndexChanged(sender, e);
           // bindindividualuser(userID);
            Bindusersdata(sender, e);
        }
    }

    protected void gvBillDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //int BillStatus=0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ReceivedAmount RMaster = (ReceivedAmount)e.Row.DataItem;
            try
            {
                string BookingID = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BookingID"));                                
                if (BookingID == "0")
                {
                    e.Row.Cells[15].Text ="";                   
                }

                string BookedDate = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "BookedDate"));
                if (BookedDate == "01/01/0001 00:00:00")
                {
                    e.Row.Cells[13].Text = "";
                }

                string CollectedDateTime = Convert.ToString(DataBinder.Eval(e.Row.DataItem, "CollectedDateTime"));
                if (CollectedDateTime == "01/01/0001 00:00:00")
                {
                    e.Row.Cells[16].Text = "";
                }


                string pagename;
                
                ReceivedAmount lstRcvd = (ReceivedAmount)e.Row.DataItem;
                string sFeetype = string.Empty;
                if (lstRcvd.FeeType != "" && lstRcvd.FeeType != null)
                {
                    sFeetype = lstRcvd.FeeType.Trim();
                }
                string billtype = "Bill";
                billtype = lstRcvd.ReceiptNO != "0" ? "Rec" : billtype;
                pagename = "?vid=" + lstRcvd.VisitID + "&pagetype=BP&bid=" + lstRcvd.FinalBillID + "&rcptno=" + lstRcvd.ReceiptNO + "&pdid=" + lstRcvd.DetailsID + "&PID=" + lstRcvd.ModifiedBy + "&dDate=" + lstRcvd.CreatedAt + "&PNAME=" + lstRcvd.Name + "&Amount=" + lstRcvd.AmtReceived + "";

                if(lstRcvd.ClosureStatus!="")
                {
                    e.Row.Cells[1].Attributes.Add("onclick", "openViewBill('" + pagename + "','" + sFeetype + "','" + lstRcvd.BillStatus + "','" + billtype + "','" + lstRcvd.ClosureStatus + "' )");
                }
                //if (lstRcvd.ClosureStatus == "Y")
                //{
                //    e.Row.ToolTip = "Final Bill Settlement";
                //}
                
                if (lstRcvd.Name.Trim() == "Total")
                {
                    BindTotal(e.Row);
                    e.Row.Cells[0].Text = "";
                    e.Row.Cells[1].Text = "";
                    e.Row.Cells[2].Text = "";
                   // e.Row.Cells[11].Text = "";
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error occured in DaywiseCollection.aspx.cs gvBillDetails_RowDataBound", ex);
            }
        }
    }

    void BindTotal(GridViewRow e)
    {
        e.BackColor = System.Drawing.Color.Gray;
        e.Font.Bold = true;
        e.Font.Size = 11;
    }
    
    protected void gvRefundDetailssplitup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ReceivedAmount ARD = (ReceivedAmount)e.Row.DataItem;


            if (ARD.Descriptions.Trim() == "Total")
            {
                BindTotal(e.Row);
                e.Row.Cells[0].Text = "";
            }

        }
    }


    protected void gvRefundDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ReceivedAmount ARD = (ReceivedAmount)e.Row.DataItem;

            if (ARD.BillStatus == "CANCELLED")
            {
                e.Row.BackColor = System.Drawing.Color.LimeGreen;
                e.Row.Cells[0].ToolTip = "This bill has been cancelled";
                e.Row.Cells[1].ToolTip = "This bill has been cancelled";
                e.Row.Cells[2].ToolTip = "This bill has been cancelled";
            }
            else if (ARD.BillStatus == "REFUND")
            {
                e.Row.Cells[0].ToolTip = "This bill has been Refunded";
                e.Row.Cells[1].ToolTip = "This bill has been Refunded";
                e.Row.Cells[2].ToolTip = "This bill has been Refunded";
            }
            if (ARD.Name.Trim() == "Total")
            {
                BindTotal(e.Row);
                e.Row.Cells[0].Text = "";
                e.Row.Cells[1].Text = "";
                e.Row.Cells[2].Text = "";

            }

        }
    }


    //newly addded 


    public void Bindusersdata(object sender, EventArgs e)
    {
        try
        {
            hdnLID.Value = "0";
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            long lUserID =0;
            totalAmount = 0;
            refundAmount = 0;
            drAmount = 0;
            TotalIncAmount = 0;
            DataTable dtUser = new DataTable();
            DataColumn dbCol1 = new DataColumn("LoginID");
            dtUser.Columns.Add(dbCol1);
            DataRow dr;
                        DateTime pFDT;
            DateTime.TryParse(txtFromDate.Text.Trim(), out pFDT);
            DateTime pTDT;
            DateTime.TryParse(txtToDate.Text.Trim(), out pTDT);

            string chkValue = string.Empty;
            int selectedUserCount = 0;
            int locationId = 0;
            if (ddlLocation.Items.Count > 0)
            {
                locationId = Convert.ToInt32(ddlLocation.SelectedValue);
            }
            foreach (ListItem chkitem in chklstusers.Items)
            {

                if (chkitem.Selected == true)
                {
                   chkValue = chkitem.Value.ToString();
                    selectedUserCount++;
                    dr = dtUser.NewRow();
                    dr["LoginID"] = Convert.ToInt64(chkValue);
                    dtUser.Rows.Add(dr);

                }
               
            }

            if (selectedUserCount <1)
            {
                lUserID = Convert.ToInt64(chkValue);
            }
            else
            {
                lUserID = 0;
            }

            List<AmountReceivedDetails> lstIncSourcePaidDetails = new List<AmountReceivedDetails>();
                List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
                currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
                btnPrint.Visible = true;
                if (ddlTrustedOrg.Items.Count > 0)
                    OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);

                retval = new BillingEngine(base.ContextInfo).GetAmountReceivedDetailsForDaily(lUserID, OrgID, pFDT, pTDT, currencyID,locationId,
                                out lstAmountReceivedDetails,
                                out lstAmountRefundDetails,
                                out lstPaymentDetails,
                                out totalAmount,
                                out refundAmount, out cancellationAmount,
                                out drAmount,
                                out othersAmount,
                                out TotalPendingDue,
                                out lstINDAmtReceivedDetails,
                                out lstINDIPAmtReceivedDetails,
                                out lstDayWise,
                                out lstRcvdUserSplitup,
                                dtUser, out lstCollections, out lstIncSourcePaidDetails, out TotalIncAmount);

                divAllUsers.Style.Add("display", "none");
               
            divSingleUser.Style.Add("display", "none");
           // divSingleUser.Style.Add("display", "block");

                tralldetails.Style.Add("display", "table-row");
                trbeakupdetails.Style.Add("display", "table-row");


                if (lUserID == 0)
                //if (dtUser.Rows.Count == 0)
                {
                    divPrint.Style.Add("display", "block");
                    divAllUsers.Style.Add("display", "block");


                    gvAllUsers.DataSource = lstAmountReceivedDetails;
                    gvAllUsers.DataBind();
                    gvAllUsersRefund.DataSource = lstAmountRefundDetails;
                    gvAllUsersRefund.DataBind();
                    gvAllUsersPayments.DataSource = lstPaymentDetails;
                    gvAllUsersPayments.DataBind();
                    gvPayDetails.DataSource = lstCollections;
                    gvPayDetails.DataBind();
                    #region selected User
                    lblSelectedUserCollAmt.Text = lstAmountReceivedDetails.Sum(p => p.AmtReceived).ToString("0.00");
                    lblCreditAmt.Text = drAmount.ToString("0.00");
                    lblSelectedUserRefAmt.Text = lstAmountRefundDetails.Sum(p => p.AmtReceived).ToString("0.00");
                    lblSelectedUserMisAmt.Text = lstPaymentDetails.Sum(p => p.AmtReceived).ToString("0.00");
                    lblSelectedUserCloseAmt.Text = (Convert.ToDecimal(lblSelectedUserCollAmt.Text) + Convert.ToDecimal(lblCreditAmt.Text) - (Convert.ToDecimal(lblSelectedUserRefAmt.Text) + Convert.ToDecimal(lblSelectedUserMisAmt.Text))).ToString("0.00");
                    #endregion
                }
                else
                {
                    divSingleUser.Style.Add("display", "block");
                    divPrint.Style.Add("display", "block");

                    gvRefundDetailssplitup.DataSource = lstINDAmtReceivedDetails;
                    gvRefundDetailssplitup.DataBind();


                    gvBillDetails.DataSource = lstAmountReceivedDetails;
                    gvBillDetails.DataBind();

                    string UserWiseReportHide = GetConfigValue("UserWiseReportHide", OrgID);

                if (UserWiseReportHide == "Y")
                {
                    this.gvBillDetails.Columns[7].Visible = false;
                    this.gvBillDetails.Columns[8].Visible = false;
                    this.gvBillDetails.Columns[9].Visible = false;
                    this.gvBillDetails.Columns[13].Visible = true;
                    this.gvBillDetails.Columns[14].Visible = true;
                    this.gvBillDetails.Columns[15].Visible = true;
                    this.gvBillDetails.Columns[16].Visible = true;
                    this.gvBillDetails.Columns[17].Visible = true;

                }
                else
                {
                    this.gvBillDetails.Columns[7].Visible = true;
                    this.gvBillDetails.Columns[8].Visible = true;
                    this.gvBillDetails.Columns[9].Visible = true;
                    this.gvBillDetails.Columns[13].Visible = false;
                    this.gvBillDetails.Columns[14].Visible = false;
                    this.gvBillDetails.Columns[15].Visible = false;
                    this.gvBillDetails.Columns[16].Visible = false;
                    this.gvBillDetails.Columns[17].Visible = false;
                }

                    gvPaymentDetails.DataSource = lstPaymentDetails;
                    gvPaymentDetails.DataBind();

                    gvRefundDetails.DataSource = lstAmountRefundDetails;
                    gvRefundDetails.DataBind();

                    #region selected User
                    lblCreditAmt.Text = drAmount.ToString("0.00");
                    lblSelectedUserCollAmt.Text = lstAmountReceivedDetails.Where(p => p.Name.ToString().ToLower().Trim() != "total").Sum(p => p.AmtReceived).ToString("0.00");
                    lblSelectedUserRefAmt.Text = lstAmountRefundDetails.Where(p => p.Name.ToString().ToLower().Trim() != "Total").Sum(p => p.AmtReceived).ToString("0.00");
                    lblSelectedUserMisAmt.Text = lstPaymentDetails.Where(p => p.Name.ToString().ToLower().Trim() != "Total").Sum(p => p.AmtReceived).ToString("0.00");
                   // lblSelectedUserCloseAmt.Text = (Convert.ToDecimal(lblSelectedUserCollAmt.Text) - (Convert.ToDecimal(lblSelectedUserRefAmt.Text) + Convert.ToDecimal(lblSelectedUserMisAmt.Text))).ToString("0.00");
                    lblSelectedUserCloseAmt.Text = (Convert.ToDecimal(lblSelectedUserCollAmt.Text) + Convert.ToDecimal(lblCreditAmt.Text) - (Convert.ToDecimal(lblSelectedUserRefAmt.Text) + Convert.ToDecimal(lblSelectedUserMisAmt.Text))).ToString("0.00");
                    #endregion


                }
                if (lstIncSourcePaidDetails.Count > 0)
                {
                    gvCashIncomeDetails.DataSource = lstIncSourcePaidDetails;
                    gvCashIncomeDetails.DataBind();
                    gvCashIncomeDetails.Visible = true;
                    lblgvCashIncomeDetails.Visible = false;
                }
                else
                {
                    lblgvCashIncomeDetails.Visible = true;
                    lblgvCashIncomeDetails.Text =amount;
                    gvCashIncomeDetails.Visible = false;
                }
                lblTotal.Text = totalAmount.ToString();
                lblRefund.Text = refundAmount.ToString();
                lblPendingAmt.Text = TotalPendingDue.ToString();
                lblCancelledAmount.Text = cancellationAmount.ToString();
                lblOthersAmount.Text = othersAmount.ToString();
                lblTotalIncAmount.Text = TotalIncAmount.ToString();
                lbltotalcredit.Text = drAmount.ToString();
                
                refundAmount = (refundAmount == -1 ? 0 : refundAmount);
                totalAmount = (totalAmount == -1 ? 0 : totalAmount);
                cancellationAmount = (cancellationAmount == -1 ? 0 : cancellationAmount);
                lblClosingBalance.Text = ((totalAmount + TotalIncAmount + drAmount) - (refundAmount + cancellationAmount + othersAmount)).ToString("0.00");
        }


        
        catch (Exception ex)
        {
            CLogger.LogError("Error occured converting to Excel", ex);
        }
    }


    public void bindindividualuser(string  loginid)
    {
        try
        {
            pPaidCurrencyTotal = 0;
            showPaidCurrency = 0;
            showPaidCurrency1 = 0;
            pPaidCurrencyCode = string.Empty;
            int currencyID = 0;
            long  lUserID = Convert.ToInt64(loginid);
            totalAmount = 0;
            refundAmount = 0;
            drAmount = 0;
            TotalIncAmount = 0;
            DataTable dtUser = new DataTable();
            DataColumn dbCol1 = new DataColumn("loginid");
            dtUser.Columns.Add(dbCol1);
            DataRow dr;
            DateTime pFDT;
            DateTime.TryParse(txtFromDate.Text.Trim(), out pFDT);
            DateTime pTDT;
            DateTime.TryParse(txtToDate.Text.Trim(), out pTDT);
            lUserID = Convert.ToInt64(loginid);
            List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
            currencyID = Convert.ToInt32(ddlCurrency.SelectedValue);
            List<Users> lstUserIDs = new List<Users>();
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            long iOrgID = Int64.Parse(OrgID.ToString());

            retval = new BillingEngine(base.ContextInfo).GetUserIDs(iOrgID, out lstUserIDs);
            divname.Style.Add("display", "block");
            if (lstUserIDs.Count > 0)
            {
                for (int i = 0; i <= lstUserIDs.Count; i++)
                {
                    if (lstUserIDs[i].UserID == lUserID)
                    {
                        lblName.Text = lstUserIDs[i].Name;
                        break;
                    }
                }
            }
            int locationId = 0;
            if (ddlLocation.Items.Count > 0)
            {
                locationId = Convert.ToInt32(ddlLocation.SelectedValue);
            }
            lblReportDate.Text = txtFromDate.Text + "  TO  " + txtToDate.Text;
            if (ddlTrustedOrg.Items.Count > 0)
                OrgID = Convert.ToInt32(ddlTrustedOrg.SelectedValue);
            List<AmountReceivedDetails> lstIncSourcePaidDetails = new List<AmountReceivedDetails>();
            retval = new BillingEngine(base.ContextInfo).GetAmountReceivedDetailsForDaily(lUserID, OrgID, pFDT, pTDT, currencyID,locationId,
                            out lstAmountReceivedDetails,
                            out lstAmountRefundDetails,
                            out lstPaymentDetails,
                            out totalAmount,
                            out refundAmount, out cancellationAmount,
                            out drAmount,
                            out othersAmount,
                            out TotalPendingDue,
                            out lstINDAmtReceivedDetails,
                            out lstINDIPAmtReceivedDetails,
                            out lstDayWise,
                            out lstRcvdUserSplitup,
                            dtUser, out lstCollections, out lstIncSourcePaidDetails, out TotalIncAmount);

            divAllUsers.Style.Add("display", "none");

            // divSingleUser.Style.Add("display", "none");
            divSingleUser.Style.Add("display", "block");

            tralldetails.Style.Add("display", "table-row");
            trbeakupdetails.Style.Add("display", "table-row");
            
            if (lUserID == 0)
            //if (dtUser.Rows.Count == 0)
            {
                btnPrint.Visible = true;
                divAllUsers.Style.Add("display", "block");
                divPrint.Style.Add("display", "block");

                gvAllUsers.DataSource = lstAmountReceivedDetails;
                gvAllUsers.DataBind();
                gvAllUsersRefund.DataSource = lstAmountRefundDetails;
                gvAllUsersRefund.DataBind();
                gvAllUsersPayments.DataSource = lstPaymentDetails;
                gvAllUsersPayments.DataBind();
                gvPayDetails.DataSource = lstCollections;
                gvPayDetails.DataBind();
            }
            else
            {
                divPrint.Style.Add("display", "block");
                divSingleUser.Style.Add("display", "block");
                tblSelectedUser.Style.Add("display", "none");

                gvRefundDetailssplitup.DataSource = lstINDAmtReceivedDetails;
                gvRefundDetailssplitup.DataBind();


                gvBillDetails.DataSource = lstAmountReceivedDetails;
                gvBillDetails.DataBind();

                string UserWiseReportHide = GetConfigValue("UserWiseReportHide", OrgID);

                if (UserWiseReportHide == "Y")
                {
                    this.gvBillDetails.Columns[7].Visible = false;
                    this.gvBillDetails.Columns[8].Visible = false;
                    this.gvBillDetails.Columns[9].Visible = false;
                    this.gvBillDetails.Columns[13].Visible = true;
                    this.gvBillDetails.Columns[14].Visible = true;
                    this.gvBillDetails.Columns[15].Visible = true;
                    this.gvBillDetails.Columns[16].Visible = true;
                    this.gvBillDetails.Columns[17].Visible = true;

                }
                else
                {
                    this.gvBillDetails.Columns[7].Visible = true;
                    this.gvBillDetails.Columns[8].Visible = true;
                    this.gvBillDetails.Columns[9].Visible = true;
                    this.gvBillDetails.Columns[13].Visible = false;
                    this.gvBillDetails.Columns[14].Visible = false;
                    this.gvBillDetails.Columns[15].Visible = false;
                    this.gvBillDetails.Columns[16].Visible = false;
                    this.gvBillDetails.Columns[17].Visible = false;
                }

                gvPaymentDetails.DataSource = lstPaymentDetails;
                gvPaymentDetails.DataBind();

                gvRefundDetails.DataSource = lstAmountRefundDetails;
                //gvRefundDetails.DataSource = lstAmountRefundDetails;
                gvRefundDetails.DataBind();


            }
            if (lstIncSourcePaidDetails.Count > 0)
            {
                gvCashIncomeDetails.DataSource = lstIncSourcePaidDetails;
                gvCashIncomeDetails.DataBind();
                gvCashIncomeDetails.Visible = true;
            }
            else
            {
                lblgvCashIncomeDetails.Visible = true;
                lblgvCashIncomeDetails.Text =amount;
                gvCashIncomeDetails.Visible = false;
            }
            lblTotal.Text = totalAmount.ToString();
           
            lblRefund.Text = refundAmount.ToString();

            lblPendingAmt.Text = TotalPendingDue.ToString();


            lblCancelledAmount.Text = cancellationAmount.ToString();
            lbltotalcredit.Text = drAmount.ToString();



            lblOthersAmount.Text = othersAmount.ToString();
            lblTotalIncAmount.Text = TotalIncAmount.ToString();

            refundAmount = (refundAmount == -1 ? 0 : refundAmount);
            totalAmount = (totalAmount == -1 ? 0 : totalAmount);
            cancellationAmount = (cancellationAmount == -1 ? 0 : cancellationAmount);
            lblClosingBalance.Text = ((totalAmount + TotalIncAmount + drAmount) - (refundAmount + cancellationAmount + othersAmount)).ToString();

        }



        catch (Exception ex)
        {
            CLogger.LogError("Error occured converting to Excel", ex);
        }
    }



    protected void lnkBack_Click(object sender, EventArgs e)
    {

        Response.Redirect(Request.ApplicationPath + "/Reports/ViewReportList.aspx");
    }

    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        ExportToExcel(tralldetails);
        ExportToExcel(trbeakupdetails);
     
    }
    public void ExportToExcel(Control ctr)
    {
        try
        {

            string prefix = string.Empty;
            prefix = "User Wise Collection Reports_";
            string rptDate = prefix + OrgTimeZone;
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            oHtmlTextWriter.WriteLine("<span style='font-size:14.0pt; color:#538ED5;font-weight:700;'>User Wise Collection Report </span>");
            tralldetails.RenderControl(oHtmlTextWriter);
            trbeakupdetails.RenderControl(oHtmlTextWriter);
            //ctr.RenderControl(oHtmlTextWriter);
            HttpContext.Current.Response.Write(oStringWriter);
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.End();

        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void gvPayDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UserLink")
        {
            string strDesc=string.Empty;
            strDesc = e.CommandArgument.ToString();
            BindDetails(strDesc);
        }
    }
    protected void BindDetails(string strDes)
    {
        string s = strDes;
        Chkboxusers.Style.Add("display", "none");
        List<ReceivedAmount> lstBillingDetails = new List<ReceivedAmount>();
        DataTable dtUser = new DataTable();
        DataColumn dbCol1 = new DataColumn("LoginID");
        dtUser.Columns.Add(dbCol1);
        DataRow dr;
        DateTime pFDT;
        DateTime.TryParse(txtFromDate.Text.Trim(), out pFDT);
        DateTime pTDT;
        DateTime.TryParse(txtToDate.Text.Trim(), out pTDT);
        string chkValue = string.Empty;
        int selectedUserCount = 0;
        hdnUserID.Value = "";
        foreach (ListItem chkitem in chklstusers.Items)
        {
            if (chkitem.Selected == true)
            {
                hdnUserID.Value += chkitem.Value.ToString() + "~";
                chkValue = chkitem.Value.ToString();
                selectedUserCount++;
                dr = dtUser.NewRow();
                dr["LoginID"] = Convert.ToInt64(chkValue);
                dtUser.Rows.Add(dr);
            }
        }
        PostBackOptions ss = new PostBackOptions((Control)hdnUserID, hdnUserID.Value.ToString());
        string skey = "../Admin/CollectionReport.aspx?"
                            + "IsPopup=" + "Y"
                            + "&FromDate=" + pFDT 
                            + "&ToDate=" + pTDT
                            +"&SType=" + strDes 
                            + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');</script>");
    }
    protected void ddlTrustedOrg_SelectedIndexChanged(object sender, EventArgs e)
    {
        //printCashClosure.Style.Add("display", "none");
        BindListofUsers();
        gvAllUsers.DataSource = "";
        gvAllUsers.DataBind();
        gvAllUsersRefund.DataSource = "";
        gvAllUsersRefund.DataBind();
        gvAllUsersPayments.DataSource = "";
        gvAllUsersPayments.DataBind();
        gvPayDetails.DataSource = "";
        gvPayDetails.DataBind();
    }
    protected void gvCashIncomeDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (Convert.ToInt64(hdnLID.Value) > 0)
        {
            e.Row.Cells[0].Style.Add("display", "none");
        }
        else
        {
            //e.Row.Cells[1].Style.Add("display", "none");
            e.Row.Cells[0].Style.Add("display", "none");
        }
    }
}
