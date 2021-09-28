using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Text;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.PlatForm.BL;

public partial class StockIntend_ReceivedIndent : Attune_BasePage
{
    public StockIntend_ReceivedIndent()
        : base("StockIntend_ReceivedIndent_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    Locations objLocation = new Locations();
    IntendDetail objIntendDetail = new IntendDetail();
    List<Locations> lstLocation = new List<Locations>();
    List<Intend> lstIntend = new List<Intend>();
    List<InventoryItemsBasket> lstInventoryItemsBasket;
    List<InventoryItemsBasket> lstIntendDetail = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstIntendKitDetail = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstPrintCount = new List<InventoryItemsBasket>();
    List<Users> lstcUsers = new List<Users>();
    List<Users> lstUsers = new List<Users>();
    string Status = string.Empty;
    int RecOrgID = 0;
    List<Organization> lstOrganization = new List<Organization>();
    string pages = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            if (Request.QueryString["Appr"] != null)
            {
                btnApprove.Visible = true;
                // btnCancelIntend.Visible = true;
            }
            BindHeaderDetails();
            if (Request.QueryString["intID"] != null && Request.QueryString["ID"] != null)
            {
                Status = Request.QueryString["Status"];
                LoadIntendDetailGrid(Convert.ToInt64(Request.QueryString["intID"]), Convert.ToInt64(Request.QueryString["ID"]), Status);
            }
            if (Request.QueryString["IsTransfer"] != null)
            {
                string sRaiseBy = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_01 == null ? "Raise By : " : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_01;
                string sRaisedFrom  = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_02 == null ? "Raised From : " : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_02;
                string sRaisedTo = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_03 == null ? "Raised To : " : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_03;
                string sStockIssueNo = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_05 == null ? "StockIssue No : " : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_04;
                string sStockIssueReceivedNo = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_05 == null ? "StockIssue ReceivedNo : " : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_05;
                lblIndentRaiseBy.Text = sRaiseBy;
                lblIntRaiFrom.Text = sRaisedFrom;
                lblIndRaisedTo.Text = sRaisedTo;
                lblIndent.Text = sStockIssueNo;
                lblIndentRece.Text = sStockIssueReceivedNo;
            }


        }
    }


    private void Notification()
    {

        pages = Request.UrlReferrer.ToString();

        // string sPagePath = System.Web.HttpContext.Current.Request.UrlReferrer.ToString();
        // System.IO.FileInfo oFileInfo = new System.IO.FileInfo(sPagePath);
        // pages = oFileInfo.Name;

        string fileName = System.IO.Path.GetFileName(pages);
        if (fileName.Contains("Intend.aspx"))
        {
            string sGO = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_06 == null ? "GO" : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_06;            
            PageContextDetails.ButtonName = "btnGO";
            PageContextDetails.ButtonValue = sGO;
        }
        else
        {
            string sSubmit = Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_07 == null ? "Submit" : Resources.StockIntend_ClientDisplay.StockIntend_ReceivedIndent_aspx_07;
            PageContextDetails.ButtonName = "btnSubmit";
            PageContextDetails.ButtonValue = sSubmit;
        }

        var mailbuilder = new StringBuilder();
        divProjection.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));

        string mailContent = mailbuilder.ToString();
        #region Notification
        ActionManager am = new ActionManager(base.ContextInfo);
        PageContextDetails.PatientID = 0;
        PageContextDetails.RoleID = RoleID;
        PageContextDetails.AccessionNo = "0";
        PageContextDetails.LabNo = 0;
        PageContextDetails.FinalBillID = 0;
        PageContextDetails.RegPatientID = 0;
        PageContextDetails.RateType = "0";
        PageContextDetails.FeeID = "0";
        PageContextDetails.RefundNo = "0";
        PageContextDetails.BillNumber = "0";
        PageContextDetails.PhoneNo = "";
        PageContextDetails.ReceiptNo = "";
        PageContextDetails.MessageTemplate = mailContent.ToString();
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["intID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }


    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    private void LoadIntendDetailGrid(long pIntendID, long pIntendReceivedID, string Status)
    {
        try
        {
            //objIntendDetail.IntendID = 2;
            objIntendDetail.OrgID = OrgID;
            objIntendDetail.OrgAddressID = ILocationID;
            //objIntendDetail.LocationID = InventoryLocationID;

            if (Status == "" || Status == "Pending")
            {
                inventoryBL.GetIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, out lstIntendDetail, out lstIntend);
            }
            else
            {
                inventoryBL.GetReceivedIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, Status, pIntendReceivedID, out lstIntendDetail, out lstIntend, out lstOrganization, out lstIntendKitDetail, out lstPrintCount);
            }
            //lblOrgName.Text = OrgName;
            GateWay headBL = new GateWay(base.ContextInfo);
            if (lstIntend!=null && lstIntend.Count > 0)
            {
                headBL.GetUserDetail(lstIntend[0].CreatedBy, out lstcUsers);
                lblIntendNo.Text = lstIntend[0].IntendNo;
                if (lstIntendDetail!=null && lstIntendDetail.Count > 0)
                {
                    if (!string.IsNullOrEmpty(lstIntendDetail[0].Name))
                    {
                        lblRaiseBy.Text = lstcUsers[0].Name + " (" + lstIntendDetail[0].Name + ")";
                    }
                    else
                    {
                        lblRaiseBy.Text = lstcUsers[0].Name;
                    }
                }
                else
                {
                    lblRaiseBy.Text = lstcUsers[0].Name;
                }

                lblDate.Text = lstIntend[0].IntendDate.ToExternalDate();
                // lblIndentRaiseTo.Text = lstIntend[0].LocName;
                // lblIndentFrom.Text = lstIntend[0].ToLocName;
                var Transferor = lstIntend[0].LocName.Split('|');
                if (Transferor.Length > 1)
                {
                    // lblTransferorTinNo.Text = Transferor[1];
                }
                if (Transferor.Length > 2)
                {
                    // lblTransferorDLNO.Text = Transferor[2];
                }
                if (Transferor.Length > 0)
                {
                    lblIndentRaiseTo.Text = Transferor[0];
                }

                var Transferree = lstIntend[0].ToLocName.Split('|');
                if (Transferree.Length > 1)
                {
                    // lblTransferreeTinNo.Text = Transferree[1];
                }
                if (Transferree.Length > 2)
                {
                    // lblTransferreeDLNO.Text = Transferree[2];
                }
                if (Transferree.Length > 0)
                {
                    lblIndentFrom.Text = Transferree[0];
                }
                //lblIndentReceivedNo.Text = lstIntend[0].IndentReceivedNo;

                if (lstPrintCount.Count > 0)
                {
                    lblIndentReceivedNo.Text = lstPrintCount[0].ProductName;
                }
                if (lstIntend[0].Status == "Issued")
                {
                    btnApprove.Visible = false;
                    btnCancelIntend.Visible = false;
                }
               
                headBL.GetUserDetail(lstIntend[0].ApprovedBy, out lstUsers);

                if (lstUsers != null && lstUsers.Count > 0)
                {
                    if (lstIntend[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        tdApproved.Visible = true;

                        approvedDateTD.InnerText = lstIntend[0].ApprovedAt.ToShortDateString();
                        approvedByTD.InnerHtml = lstUsers[0].Name;
                    }
                }
                else
                {
                    tdApproved.Visible = false;
                    approvedDateTD.InnerText = "--";
                    approvedByTD.InnerHtml = "--";
                }
                lblStatus.Text = lstIntend[0].Status;
            }

            //if ((lstIntend[0].Status == "Pending"))
            //{
            //    GridViewDetails.DataSource = lstIntendDetail;
            //    GridViewDetails.DataBind();
            //    // gvIntendDetail.DataBind();
            //    gvIntendDetail.Visible = false;
            //    GridViewDetails.Visible = true;
            //    btnSave.Visible = false;

            //}
            //else if ((lstIntend[0].Status == "Issued"))
            //{
            //    GridViewDetails.DataSource = lstIntendDetail;
            //    GridViewDetails.DataBind();
            //    // gvIntendDetail.DataBind();
            //    gvIntendDetail.Visible = true;
            //    GridViewDetails.Visible = false ;
            //    btnSave.Visible = true ;
            //}

            //else
            {
                gvIntendDetail.DataSource = (lstIntendDetail.Where(ID =>ID.Status!="Cancel"));
                gvIntendDetail.DataBind();

                gvIntendCancelDetail.DataSource = (lstIntendDetail.Where(ID => ID.Status == "Cancel"));
                gvIntendCancelDetail.DataBind();


                gvIntendDetail.Visible = true;
                GridViewDetails.Visible = false;
                btnSave.Visible = true;
                btnSave.Enabled = true;
            }

            if (lstIntend.Count > 0)
            {

                if ((lstIntend[0].Status.Contains("Partial")))
                {
                    Notification();

                }
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    protected void btnIntend_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long IndID = -1;
        long pId = -1;
        long intendID = 0;


        try
        {
            Button btn = (Button)sender;

            if (Request.QueryString["intID"] != null)
            {
                Int64.TryParse(Request.QueryString["intID"], out intendID);
                returnCode = inventoryBL.UpdateStockIssue(intendID, btn.CommandArgument, LID, OrgID, InventoryLocationID, pId);

            }
            if (Request.QueryString["ReceivedOrgID"] != null)
            {
                RecOrgID = int.Parse(Request.QueryString["ReceivedOrgID"].ToString());

            }
            if (returnCode == 0)
            {
                if (Request.QueryString["IsTransfer"] != null)
                {
                    Response.Redirect(@"../Inventory/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + intendID + "&ROrgID =" + RecOrgID + "&Status=Received&IsTransfer=Y", true);

                }
                else
                {

                    Response.Redirect(@"../Inventory/ViewIssuedIndentdetails.aspx?ID=" + pId + "&intID=" + intendID + "&ROrgID =" + RecOrgID + "&Status=Received", true);

                }///ViewIntendDetail.aspx?intID=
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }







    protected void btnSave_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        long intendID = 0;
        long pIntendReceivedID = 0;
        long IndentReceivedID = 0;
        long IndID = 0;
        try
        {
            btnSave.Enabled = false;
            btnSave.Visible = false;

            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

            foreach (GridViewRow gR in gvIntendDetail.Rows)
            {
                InventoryItemsBasket objINV = new InventoryItemsBasket();

                TextBox txtquantity = (TextBox)gR.FindControl("txtquantity");
                HiddenField hdnIssuedQuantity = (HiddenField)gR.FindControl("hdnpQuantity");
                HiddenField hdnID = (HiddenField)gR.FindControl("hdnpID");
                HiddenField hdnProductID = (HiddenField)gR.FindControl("hdnpProductID");
                HiddenField hdnBatchNo = (HiddenField)gR.FindControl("hdnpBatchNo");
                HiddenField SellingPrice = (HiddenField)gR.FindControl("hdnSellingPrice");
                HiddenField UnitPrice = (HiddenField)gR.FindControl("hdnUnitPrice");
                HiddenField Tax = (HiddenField)gR.FindControl("hdnTax");
                HiddenField Expirydate = (HiddenField)gR.FindControl("hdnExpirydate");
                HiddenField SellingUnit = (HiddenField)gR.FindControl("hdnSellingUnit");
                HiddenField ConvertUnit = (HiddenField)gR.FindControl("hdnOrderedConvertUnit");
                HiddenField hdnPdtRcvdDetailsID = (HiddenField)gR.FindControl("hdnPdtRcvdDtlsID");
                HiddenField hdnReceivedUniqueNumber = (HiddenField)gR.FindControl("hdnReceivedUniqueNumber");
                //if (Convert.ToDecimal(txtquantity.Text) > 0)
                //{
                long IntendID = Convert.ToInt64(hdnID.Value);
                long ProductID = Convert.ToInt64(hdnProductID.Value);
                string BatchNo = hdnBatchNo.Value.ToString();
                //  decimal Qty = Convert.ToDecimal(hdnIssuedQuantity.Value) - Convert.ToDecimal(txtquantity.Text);
                decimal iQty = txtquantity.Text == "" ? 0 : Convert.ToDecimal(txtquantity.Text);
                objINV.CategoryID = 0;
                objINV.ProductID = ProductID;
                objINV.BatchNo = BatchNo;
                //objINV.Quantity = iQty *(Convert.ToDecimal(ConvertUnit.Value));
                objINV.Quantity = iQty;
                objINV.ID = IntendID;
                objINV.RECQuantity = Convert.ToDecimal(hdnIssuedQuantity.Value);


                ////objINV.CategoryID = int.Parse(hdnFinalBillID.Value);
                ////objINV.RECQuantity = Convert.ToDecimal(txtReturnQuantity.Text);
                objINV.ExpiryDate = Convert.ToDateTime(Expirydate.Value);
                objINV.Manufacture = DateTimeUtility.GetServerDate();
                objINV.UnitPrice = Convert.ToDecimal(UnitPrice.Value);
                objINV.Rate = Convert.ToDecimal(SellingPrice.Value);
                objINV.Tax = Convert.ToDecimal(Tax.Value);
                objINV.SellingUnit = SellingUnit.Value;
                TextBox txtrakno = (TextBox)gR.FindControl("txtrackno");
                objINV.RakNo = txtrakno.Text;
                objINV.ProductReceivedDetailsID = Convert.ToInt64(hdnPdtRcvdDetailsID.Value);
                objINV.ReceivedUniqueNumber = Convert.ToInt64(hdnReceivedUniqueNumber.Value);
                lstInventoryItemsBasket.Add(objINV);


                //}


            }
            if (Request.QueryString["intID"] != null)
            {
                Int64.TryParse(Request.QueryString["intID"], out intendID);
                Int64.TryParse(Request.QueryString["ID"], out pIntendReceivedID);
                int StockReceivedTypeID = (int)StockReceivedTypes.FromStore;
                returnCode = inventoryBL.UpdateIntendDetail(intendID, OrgID, ILocationID, InventoryLocationID, LID, lstInventoryItemsBasket, pIntendReceivedID, StockReceivedTypeID, out IndID, out IndentReceivedID);
                if (Request.QueryString["ReceivedOrgID"] != null)
                {
                    RecOrgID = int.Parse(Request.QueryString["ReceivedOrgID"].ToString());

                }
                if (returnCode > 0)
                {
                    hdnIndentID.Value = intendID.ToString();
                    hdnIntendReceivedID.Value = pIntendReceivedID.ToString();
                    SendSMS();
                    if (Request.QueryString["IsTransfer"] != null)
                    {
                        Response.Redirect(@"../StockIntend/ViewIssuedIndentdetails.aspx?ID=" + Convert.ToInt64(Request.QueryString["ID"]) + "&intID=" + intendID + "&ROrgID=" + RecOrgID + "&Status=Received&IsTransfer=Y", true);

                    }
                    else
                    {
                        Response.Redirect(@"../StockIntend/ViewIssuedIndentdetails.aspx?ID=" + Convert.ToInt64(Request.QueryString["ID"]) + "&intID=" + intendID + "&ROrgID=" + RecOrgID + "&Status=Received", true);
                    }
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Product Updated Successfully');", true);
                    btnSave.Visible = false;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Adding New Product - IndentViewDetail.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../Admin/Home.aspx", true); }
        else
        {
            Response.Redirect("~/StockIntend/Intend.aspx");
        }
    }


    protected void gvIntendDetail_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtquantity = new TextBox();
                HiddenField hdnIssuedQuantity = new HiddenField();
                HiddenField hdnProductID = new HiddenField();
                HiddenField hdnID = new HiddenField();
                HiddenField hdnBatchNo = new HiddenField();
                TextBox txtRefundAmount = new TextBox();

                txtquantity = (TextBox)e.Row.FindControl("txtquantity");
                hdnIssuedQuantity = (HiddenField)e.Row.FindControl("hdnpIssuedQuantity");
                hdnID = (HiddenField)e.Row.FindControl("hdnpID");
                hdnProductID = (HiddenField)e.Row.FindControl("hdnpProductID");
                hdnBatchNo = (HiddenField)e.Row.FindControl("hdnpBatchNo");
                txtRefundAmount.Attributes.Add("readonly", "true");

                string sValidateQty = "ValidateReturnQty('" + hdnIssuedQuantity.ClientID + "','" + txtquantity.ClientID + "');";
                txtquantity.Attributes.Add("onChange", sValidateQty);
                //string sFunQty = "funcChkAmountQty('" + hdnIssuedQuantity.ClientID +
                //                                   "','" + hdnIssuedAmount.ClientID +
                //                                   "','" + txtReturnQuantity.ClientID +
                //                                   "','" + txtRefundAmount.ClientID + "');";
                //string sFun = "funcChkAmount('" + hdnIssuedQuantity.ClientID +
                //                                 "','" + hdnIssuedAmount.ClientID +
                //                                 "','" + txtReturnQuantity.ClientID +
                //                                 "','" + txtRefundAmount.ClientID + "');";
                //txtReturnQuantity.Attributes.Add("onBlur", sFunQty);
                //txtRefundAmount.Attributes.Add("onBlur", sFun);
                //hdnValues.Value += hdnIssuedQuantity.ClientID + "~" + hdnIssuedAmount.ClientID + "~" + txtReturnQuantity.ClientID + "~" + txtRefundAmount.ClientID + "^";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Billing Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }

    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
            Label lblProduct = (Label)e.Row.FindControl("lblProductName");
            e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
            //e.Row.Attributes.Add("onclick", "alert ('hi');");
        }

    }
    protected void grdResult_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }

    public long SendSMS()
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();
        RecOrgID = int.Parse(Request.QueryString["ReceivedOrgID"].ToString());
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.PatientID = RecOrgID;
        PC.OrgID = OrgID;
        PC.ButtonName = btnSave.ID;
        PC.ButtonValue = btnSave.Text;
        PC.ID = Convert.ToInt32(hdnIndentID.Value);
        PC.ContextType = "Receive";

        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
    }
    protected void BindHeaderDetails()
    {

        List<Organization> lstOrganization = new List<Organization>();
        new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out  lstOrganization);
        if (lstOrganization.Count > 0)
        {
            lblOrgName.Text = lstOrganization[0].Name;
            lblstreet.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
        }

        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;

        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        bool _flag = false;
        if (lstConfig.Count > 0)
        {
            imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
            if (!string.IsNullOrEmpty(lstConfig[0].ConfigValue.Trim()))
            {
                imgBillLogo.Visible = true;
            }
            else
            {
                _flag = true;
            }
        }
        else
        {
            _flag = true;
        }
        if (_flag)
        {
            imgBillLogo.Visible = false;
        }
    }
}
