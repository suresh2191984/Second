using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
public partial class Billing_BillSettlement : BasePage
{
    public Billing_BillSettlement()
        : base("Reception_BillSettlementIndividual_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    int flag = 0;
    List<ReceivedAmount> lstSplitDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstAmountReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstAmountRefundDetails = new List<ReceivedAmount>();
    List<Users> lstUsers = new List<Users>();
    List<AmountClosureDetails> lstAmountClosure = new List<AmountClosureDetails>();
    List<ReceivedAmount> lstPaymentDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstINDAmtReceivedDetails = new List<ReceivedAmount>();
    List<ReceivedAmount> lstINDIPAmtReceivedDetails = new List<ReceivedAmount>();
    List<CurrencyOrgMapping> lstCurrencyInHand = new List<CurrencyOrgMapping>();
    List<CashClosureDenomination> lstCCDeno = new List<CashClosureDenomination>();

    DateTime pFDT, pTDT;
    #region pageLoad

    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (OrgID != 11)
        {
            Panel1.Visible = false;
            Panel2.Visible = false;
        }
        if (!Page.IsPostBack)
        {
            LoadLocation();
            LoadUserList();
            LoadRoles();

             pFDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
             pTDT = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            txtFromDate.Text = pFDT.ToString("dd/MM/yyyy");
            txtToDate.Text = pTDT.ToString("dd/MM/yyyy");
            UserDefinedClosure();
        }
    }
    #endregion

    #region Custom Functions
    protected void UserDefinedClosure()
    {
        BillingEngine objBillingEngine = new BillingEngine(base.ContextInfo);


        #region cashclosure Description Print Config

        List<Config> lstconfig = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("CashClosureDescription", OrgID, out lstconfig);
        if (lstconfig.Count > 0 && lstconfig[0].ConfigValue == "N")
            hdnNeedDescription.Value = "N";


        #endregion

        decimal totalAmount = 0;
        decimal TotalIncAmount = 0;
        decimal refundAmount = 0; decimal cancellationAmount = 0;
        decimal drAmount;
        decimal othersAmount = 0;
        string sstatus = string.Empty;
        long retval = -1;
        string sAllAmtReceivedID = string.Empty;

        string sRcvdFromtime = string.Empty;
        string sRcvdTotime = string.Empty;
        string sRefundFromtime = string.Empty;
        string sRefundTotime = string.Empty;
        string sMinStartTime = string.Empty;
        string sMaxEndTime = string.Empty;

       

        pFDT = Convert.ToDateTime(txtFromDate.Text);
        pTDT = Convert.ToDateTime(txtToDate.Text);
        totalAmount = 0;
        refundAmount = 0;
        drAmount = 0;
        gvBillDetails.Visible = true;

        long lUserID = LID;
        int locationid =Convert.ToInt32( ddlLocation.SelectedValue);
        List<AmountReceivedDetails> lstreceivedTypes = new List<AmountReceivedDetails>();
        List<AmountReceivedDetails> lstIncSourcePaidDetails = new List<AmountReceivedDetails>();
        decimal TotalPendingSettledAmount = 0;
        retval = objBillingEngine.GetAmountReceivedDetails(lUserID, OrgID, pFDT, pTDT,locationid,
                    out lstAmountReceivedDetails,
                    out lstAmountRefundDetails,
                    out lstPaymentDetails,
                    out totalAmount,
                    out refundAmount, out cancellationAmount, out sRcvdFromtime,
                    out sRcvdTotime, out sRefundFromtime,
                    out sRefundTotime, out sMinStartTime,
                    out sMaxEndTime, out drAmount,
                    out othersAmount,
                    out  TotalIncAmount,
                    out lstINDAmtReceivedDetails,
                    out lstINDIPAmtReceivedDetails,
                    out lstreceivedTypes, out lstSplitDetails,
                    out lstIncSourcePaidDetails,
                    out lstCurrencyInHand,
                    out lstCCDeno,
                    out TotalPendingSettledAmount);

        string ToMsg  = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_02 == null ? " To " : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_02;
        
        if (retval == 0)
        {
            if (sRcvdFromtime != null && sRcvdFromtime != "")
            {
                lblReceivedTime.Visible = true;
                string ReceiveMsg = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_01 == null ? "Received time from : " : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_01;
                
                lblReceivedTime.Text = ReceiveMsg + " " + sRcvdFromtime + " " + ToMsg + " " + sRcvdTotime;
            }
            else
            {
                lblReceivedTime.Visible = false;
            }

            if (sRefundFromtime != "" && sRefundFromtime != null)
            {
                lblRefundTime.Visible = true;
                string ReceiveMsg = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_03 == null ? "Refunded time from :" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_03;
                
                lblRefundTime.Text = ReceiveMsg + " " + sRefundFromtime + " " + ToMsg + " " + sRefundTotime;
            }
            else
            {
                lblRefundTime.Visible = false;
            }
            gvAmountBreakup.DataSource = lstreceivedTypes;
            gvAmountBreakup.DataBind();

            gvBillDetails.Visible = true;
            gvRefundDetails.Visible = true;
            gvPaymentDetails.Visible = true;
            gvCashIncomeDetails.Visible = false;

            if (lstAmountReceivedDetails.Count > 0)
            {
                gvBillDetails.DataSource = lstAmountReceivedDetails;
                gvBillDetails.DataBind();
                lblgvBillDetails.Visible = false;
            }
            else
            {
                lblgvBillDetails.Visible = true;
                gvBillDetails.Visible = false;
                string NoAmountPat = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_04 == null ? "No Amount Received From patient's" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_04;
                lblgvBillDetails.Text = NoAmountPat;
            }
            if (lstIncSourcePaidDetails.Count > 0)
            {
                gvCashIncomeDetails.Visible = true;
                gvCashIncomeDetails.DataSource = lstIncSourcePaidDetails;
                gvCashIncomeDetails.DataBind();
            }
            else
            {
                gvCashIncomeDetails.Visible = false;
                lblgvCashIncomeDetails.Visible = true;
                string NoAmountRec = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_05 == null ? "No Amount Received" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_05;
                lblgvCashIncomeDetails.Text = NoAmountRec;
            }
            if (lstAmountRefundDetails.Count > 0)
            {

                gvRefundDetails.DataSource = lstAmountRefundDetails;
                gvRefundDetails.DataBind();
            }
            else
            {
                lblgvRefundDetails.Visible = true;
                gvRefundDetails.Visible = false;
                string NoRefunds = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_06 == null ? "No Refunds Made" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_06;
                lblgvRefundDetails.Text = NoRefunds;
            }
            if (lstPaymentDetails.Count > 0)
            {
                gvPaymentDetails.DataSource = lstPaymentDetails;
                gvPaymentDetails.DataBind();
            }
            else
            {
                lblgvPaymentDetails.Visible = true;
                gvPaymentDetails.Visible = false;
                string NoPayments = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_07 == null ? "No Payments Made" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_07;
                lblgvPaymentDetails.Text = NoPayments;
            }
            if (lstINDAmtReceivedDetails.Count > 0)
            {
                gvINDAmtReceivedDetails.Visible = true;
             //   Panel1.Visible = true;
                Panel1.Visible = false;
                gvINDAmtReceivedDetails.DataSource = lstINDAmtReceivedDetails;
                gvINDAmtReceivedDetails.DataBind();

            }
            else
            {
                gvINDAmtReceivedDetails.Visible = false;
                Panel1.Visible = false;
            }
            if (lstINDIPAmtReceivedDetails.Count > 0)
            {
                gvIndIPAMountReceived.Visible = true;
                Panel2.Visible = true;
                gvIndIPAMountReceived.DataSource = lstINDIPAmtReceivedDetails;
                gvIndIPAMountReceived.DataBind();
            }
            else
            {
                gvIndIPAMountReceived.Visible = false;
                Panel2.Visible = false;
            }
        }
        else
        {
            divtimeDisplay.Visible = false;
            lblReceivedTime.Text = "";
            lblRefundTime.Text = "";
            gvBillDetails.Visible = false;
            gvRefundDetails.Visible = false;
            gvCashIncomeDetails.Visible = false;
        }
        if (TotalIncAmount > 0)
        {
            lblTotalIncAmount.Text = TotalIncAmount.ToString();
        }
        else
        {
            lblTotalIncAmount.Text = "0.00";
        }
        if (totalAmount > 0)
        {
            lblTotal.Text = totalAmount.ToString("#.00");
        }
        else
        {
            lblTotal.Text = "0.00";
        }
        if (refundAmount > 0)
        {
            lblRefund.Text = refundAmount.ToString();

        }
        else
        {
            lblRefund.Text = "0.00";
        }
        if (cancellationAmount > 0)
        {
            lblCancelledAmount.Text = cancellationAmount.ToString();
        }
        else
        {
            lblCancelledAmount.Text = "0.00";
        }
        if (drAmount > 0)
        {
            lblPhyAmount.Text = drAmount.ToString();
        }
        else
        {
            lblPhyAmount.Text = "0.00";
        }
        if (othersAmount > 0)
        {
            lblOthersAmount.Text = othersAmount.ToString();
        }
        else
        {
            lblOthersAmount.Text = "0.00";
        }
        if (TotalPendingSettledAmount > 0)
        {
            lblTotalPendingSettledAmt.Text = TotalPendingSettledAmount.ToString("#.00");
        }
        else
        {
            lblTotalPendingSettledAmt.Text = "0.00";
        }
        refundAmount = (refundAmount == -1 ? 0 : refundAmount);
        totalAmount = (totalAmount == -1 ? 0 : totalAmount);
        cancellationAmount = (cancellationAmount == -1 ? 0 : cancellationAmount);
        lblClosingBalance.Text = ((totalAmount + TotalIncAmount + TotalPendingSettledAmount) - refundAmount - cancellationAmount - drAmount - othersAmount).ToString("#.00");
        lblCashInHand.Text = lblClosingBalance.Text;

        string cashInHand = string.Empty;
        foreach (CurrencyOrgMapping objCIH in lstCurrencyInHand)
        {
            cashInHand += objCIH.CurrencyName + " - ";
            if (objCIH.IsBaseCurrency == "Y")
            {
                cashInHand += (Convert.ToDecimal(objCIH.ConversionRate) - Convert.ToDecimal(((Convert.ToDecimal(totalAmount) + Convert.ToDecimal(TotalIncAmount) + Convert.ToDecimal(TotalPendingSettledAmount)) - Convert.ToDecimal(lblClosingBalance.Text)))).ToString();
                cashInHand += "<br>";
            }
            else
            {
                cashInHand += objCIH.ConversionRate.ToString();
                cashInHand += "<br>";
            }
        }
        lblClosingCashInHand.Text = cashInHand;
        if (lstCurrencyInHand.Count > 1)
        {
            trCashInHand.Style.Add("display", "block");
        }
        else
        {
            trCashInHand.Style.Add("display", "none");
        }
        string Received_By_cs = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_08 == null ? "Received By : " : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_08;
        #region user detail

        SharedInventory_BL ibl = new SharedInventory_BL(base.ContextInfo);
        List<Users> lstUserDetails = new List<Users>();
        ibl.GetUserDetail(LID, out lstUserDetails);
        if (lstUserDetails.Count > 0)
            lblUserName.Text = Received_By_cs+" " + lstUserDetails[0].Name;

        #endregion
    }

    private void GetCollectionWiseDetails(string sStartTime, string sEndTime)
    {
        long returnCode = -1;
        decimal totalAdditions = 0;
        decimal totalDeduction = 0;
        BillingEngine be = new BillingEngine(base.ContextInfo);
        List<ServiceQtyAmount> lstInflowDtls = new List<ServiceQtyAmount>();
        List<ServiceQtyAmount> lstOutflowDtls = new List<ServiceQtyAmount>();

        try
        {
            if (sStartTime != "" && sEndTime != "")
            {
                returnCode = be.GetCollectionDetails(LID, sStartTime, sEndTime, OrgID, out totalAdditions, out totalDeduction, out lstInflowDtls, out lstOutflowDtls);
            }
            StringBuilder sb = be.BuildCollectionDetailTbl(lstInflowDtls, lstOutflowDtls, totalAdditions, totalDeduction);
            lblConsReport.Text = sb.ToString();

        }
        catch (Exception e1)
        {
            CLogger.LogError("Error retrieving collection details ", e1);
        }
    }

    #endregion

    public void billprint()
    {

    }
    protected override void Render(HtmlTextWriter writer)
    {
        for (int i = 0; i < this.gvBillDetails.Rows.Count; i++)
        {
            this.Page.ClientScript.RegisterForEventValidation(this.gvBillDetails.UniqueID, "Select$" + i);
        }

        base.Render(writer);
    }
    protected void gvBillDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        long returnCode = -1;
        string strBillNo = "";
        string pagename = "";
        strBillNo = gvBillDetails.DataKeys[Convert.ToInt32(e.CommandArgument)][0].ToString();
        List<Attune.Podium.BusinessEntities.BillSearch> bSearch = new List<Attune.Podium.BusinessEntities.BillSearch>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);

        try
        {
            if (e.CommandName == "Select")
            {
                int totalRows = 0;
                returnCode = patientBL.SearchBillOptionDetails(strBillNo, "", "", "", -1, OrgID, "", "","","","", out bSearch, -1, -1, out totalRows,0);
            }

            if (returnCode == 0 && bSearch.Count > 0)
            {
                foreach (Attune.Podium.BusinessEntities.BillSearch items in bSearch)
                {
                    pagename = "?vid=" + items.PatientVisitId + "&pagetype=BP&bid=" + items.BillID + "";
                }
                string skey = "../Reception/ViewPrintPage.aspx"
                            + pagename
                            + "&IsPopup=" + "Y"
                            + "&CCPage=Y"
                            + "";

                this.Page.RegisterStartupScript("sky",
                  "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');</script>");

            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void gvBillDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
          //  e.Row.Cells[5].Visible = false;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //Label lnkReceiptNO = (Label)e.Row.FindControl("lnkReceiptNO");
                //if (lnkReceiptNO.Text == "0")
                //{
                //    lnkReceiptNO.Text = "--";
                //}

                ReceivedAmount lstRcvd = (ReceivedAmount)e.Row.DataItem;
                List<ReceivedAmount> childItems = (from child in lstSplitDetails
                                                   where child.FinalBillID == lstRcvd.FinalBillID && child.ReceiptNO == lstRcvd.ReceiptNO
                                                   select child).ToList();
                string sFeetype = "CON";
                string pagename = "";
                if (childItems.FindAll(P => P.FeeType == "PRM" && P.VisitType != 1 && P.VisitType != 0).Count > 0)
                {
                    sFeetype = "PRM";
                    pagename = "?vid=" + -1 + "&pagetype=BP&bid=" + lstRcvd.FinalBillID + "";
                }
                else
                {
                    sFeetype = "PRM";
                    pagename = "?vid=" + lstRcvd.VisitID + "&pagetype=BP&bid=" + lstRcvd.FinalBillID + "";
                }
                if (childItems.FindAll(P => P.FeeType == "DEP").Count > 0)
                {
                    sFeetype = "DEP";
                    pagename = "?Amount=" + lstRcvd.AmtReceived + "&dDate=" + lstRcvd.CreatedAt + "&rcptno=" + lstRcvd.ReceiptNO + "&RNAME=" + lstRcvd.PatientName + "";
                }
                if (sFeetype != "PRM" && sFeetype != "DEP")
                {
                    pagename = "?vid=" + lstRcvd.VisitID + "&pagetype=BP&bid=" + lstRcvd.FinalBillID + "";
                }
                if (hdnNeedDescription.Value != "N")
                {

                    GridView childGrid = (GridView)e.Row.FindControl("gvChildDetails");
                    childGrid.DataSource = childItems;
                    childGrid.DataBind();
                }

                Label lnkBillNumber = (Label)e.Row.FindControl("lnkBillNumber");
                if (lnkBillNumber.Text == "")
                {
                    e.Row.BackColor = System.Drawing.Color.LightPink;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Cash Closure Details.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }
    protected void gvPaymentDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            e.Row.Cells[3].Visible = false;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Cash Closure Details.", ex);
          //  ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }
    protected void gvRefundDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvRefundDetails, "Select$" + e.Row.RowIndex));
        e.Row.Cells[3].Visible = false;
        string Reception_BillSettlementIndividual_aspx_09 = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_09 == null ? "This bill has been cancelled" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_09;
        string Reception_BillSettlementIndividual_aspx_10 = Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_10 == null ? "This bill has been Refunded" : Resources.Reception_ClientDisplay.Reception_BillSettlementIndividual_aspx_10;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ReceivedAmount ARD = (ReceivedAmount)e.Row.DataItem;
            if (ARD.BillStatus == "CANCELLED")
            {
                e.Row.BackColor = System.Drawing.Color.LimeGreen;
                e.Row.Cells[0].ToolTip = Reception_BillSettlementIndividual_aspx_09;
                e.Row.Cells[1].ToolTip = Reception_BillSettlementIndividual_aspx_09;
                e.Row.Cells[2].ToolTip = Reception_BillSettlementIndividual_aspx_09;
            }
            else if (ARD.BillStatus == "REFUND")
            {
                e.Row.Cells[0].ToolTip = Reception_BillSettlementIndividual_aspx_10;
                e.Row.Cells[1].ToolTip = Reception_BillSettlementIndividual_aspx_10;
                e.Row.Cells[2].ToolTip = Reception_BillSettlementIndividual_aspx_10;
            }
            Label lnkBillNumber = (Label)e.Row.FindControl("lnkBillNumber");
            if (lnkBillNumber.Text == "")
            {
                e.Row.BackColor = System.Drawing.Color.LightPink;
            }
        }
    }
    protected void gvINDAmtReceivedDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ReceivedAmount ra = (ReceivedAmount)e.Row.DataItem;
            flag = flag + ra.Qty;
            if (ra.Descriptions == "Outstanding Amount" || ra.Descriptions == "Discount Amount" || ra.Descriptions == "Refund Amount" || ra.Descriptions == "Other Payments" || ra.Descriptions == "Cancelled Bill Amount")
            {
                e.Row.Style.Add("color", "#ff6600");
                e.Row.Font.Size = 10;
            }
            if (ra.Descriptions == "Previous Due Received")
            {
                e.Row.Style.Add("color", "Blue");
                e.Row.Font.Size = 10;
            }
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.ApplicationPath + "/Reception/Home.aspx", true);
    }
    protected void gvCashIncomeDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Style.Add("display", "none");
    }
    string strSelect = Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20 == null ? "--Select--" : Resources.Reception_ClientDisplay.Reception_VisitDetails_aspx_20;
    public void LoadLocation()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlLocation.DataSource = LoginLoc;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
            else
            {
                ddlLocation.DataSource = lstOrganizationAddress;
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataBind();
            }
        }
        ddlLocation.Items.Insert(0, strSelect.Trim());
        //ddlLocation.Items[0].Text = LocationName;
        ddlLocation.SelectedValue = ddlLocation.Items.FindByText(LocationName).Value; 
    }
    public void LoadUserList()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<Attune.Podium.BusinessEntities.Login> getUsersList = new List<Attune.Podium.BusinessEntities.Login>();
            retCode = patBL.LoadUserList(OrgID, out getUsersList);
            ddlUsers.DataSource = getUsersList;
            ddlUsers.DataTextField = "LoginName";
            ddlUsers.DataValueField = "LoginID";
            ddlUsers.DataBind();
            ddlUsers.Items.Insert(0, "All");
            Label myLabel = this.FindControl("lblUserName") as Label;
            string s = Attuneheader.UserName.Replace("Mr.","").ToString().Trim();
            ddlUsers.SelectedValue = ddlUsers.Items.FindByText(s).Value;

            ddlUsername2.DataSource = getUsersList;
            ddlUsername2.DataTextField = "LoginName";
            ddlUsername2.DataValueField = "LoginID";
            ddlUsername2.DataBind();
            ddlUsername2.SelectedValue = ddlUsers.Items.FindByText(s).Value;
            
           
        }
        catch (Exception EX)
        {
            CLogger.LogError("Error while load User details in daily bill report", EX);
        }
    }
    protected void btnSearch_click(object sender,EventArgs e)
    {
        UserDefinedClosure();
    }

    private void LoadRoles()
    {
        string strSelectRole = Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01 == null ? "----Select Role----" : Resources.Admin_ClientDisplay.Admin_MenuMapper_aspx_01;

        try
        {
            
            List<Role> lstRole = new List<Role>();
            new Role_BL(base.ContextInfo).GetRoleNameForMenuMapper(OrgID, out lstRole);
            if (lstRole.Count > 0)
            {
                ddlRolename.Items.Clear();
                ddlRolename.DataSource = lstRole;
                ddlRolename.DataTextField = "RoleName";
                ddlRolename.DataValueField = "RoleID";
                ddlRolename.DataBind();

              
                //ddlControl.Items.Insert(0, "----Select Role----");
                ddlRolename.Items.Insert(0, strSelectRole);
                ddlRolename.SelectedValue = "----Select Role----";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}