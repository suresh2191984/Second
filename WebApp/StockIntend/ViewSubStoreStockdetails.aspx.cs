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
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;

public partial class StockIntend_ViewSubStoreStockdetails : Attune_BasePage
{
    public StockIntend_ViewSubStoreStockdetails()
        : base("StockIntend_ViewIssuedIndentdetails.aspx")
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
    string IndentType = string.Empty;
    string SearchType = string.Empty;
    List<Organization> lstOrganization = new List<Organization>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string packingConfig = "N";
    string S = string.Empty;
    string pages = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            if (Request.QueryString["IsTransfer"] != null)
            {
                string displayTool = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_01;
                displayTool = displayTool == null ? "StockIssue ReceivedNo :" : displayTool;
                LabelIndentReceivedNo.Text = displayTool;
            }

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Indent_Packing_Slip_Barcode", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                packingConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
            }


            if (packingConfig == "Y")
            {
                if (Request.QueryString["intID"] != null && Request.QueryString["ID"] != null)
                {
                    if (Request.QueryString["Status"] != null)
                    {
                        Status = Request.QueryString["Status"];
                    }
                    // E:\testweb\Development\Solution\WebApp\Inventory\ViewPackingSlipDetails.aspx
                    Response.Redirect("~/Inventory/ViewPackingSlipDetails.aspx?ID=" + Request.QueryString["ID"] + "&intID=" + Request.QueryString["intID"] + "&Appr=Y&Status=" + Status);
                    btnApprove.Visible = true;
                    // btnCancelIntend.Visible = true;
                }
            }
            else
            {
                if (Request.QueryString["intID"] != null && Request.QueryString["ID"] != null)
                {
                    Status = Request.QueryString["Status"];
                    IndentType = Request.QueryString["IndentType"];
                    SearchType = Request.QueryString["SearchType"];
                    LoadIntendDetailGrid(Convert.ToInt64(Request.QueryString["intID"]), Convert.ToInt64(Request.QueryString["ID"]), Status);
                }
            }
            BindHeaderDetails();

            string rval = GetConfigValue("VIEW_DL_NO", OrgID);
            if (!string.IsNullOrEmpty(rval))
            {
                if (rval == "Y")
                {
                    trTransferorNo.Attributes.Add("class", "displaytr");
                    trDLNo.Attributes.Add("class", "displaytr");
                    // trRaiseFrom.Style.Add("display", "none");
                  //  trRaiseComment.Style.Add("display", "none");
                    trRaiseBy.Attributes.Add("class", "hide");
                }
                else
                {
                    trTransferorNo.Attributes.Add("class", "hide");
                    trDLNo.Attributes.Add("class", "hide");
                    // trRaiseFrom.Style.Add("display", "table-row");
                  //  trRaiseComment.Style.Add("display", "table-row");
                    trRaiseBy.Attributes.Add("class", "displaytr");
                }
            }
            else
            {
                trTransferorNo.Attributes.Add("class", "hide");
                trDLNo.Attributes.Add("class", "hide");
                // trRaiseFrom.Style.Add("display", "table-row");
                trRaiseComment.Attributes.Add("class", "displaytr");
                trRaiseBy.Attributes.Add("class", "displaytr");
            }

        }

    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/StockIntend/SubStoreSearch.aspx");
    }
    private void Notification()
    {

        pages = Request.UrlReferrer.ToString();

        // string sPagePath = System.Web.HttpContext.Current.Request.UrlReferrer.ToString();
        // System.IO.FileInfo oFileInfo = new System.IO.FileInfo(sPagePath);
        // pages = oFileInfo.Name;

        string fileName = System.IO.Path.GetFileName(pages);
        if (fileName.Contains("IssueStock.aspx"))
        {
            //    PageContextDetails.ButtonName = "btnGO";
            //    PageContextDetails.ButtonValue = "GO";
            //}
            //else
            //{
            PageContextDetails.ButtonName = "btnSubmit";
            PageContextDetails.ButtonValue = "Submit";
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



    private void LoadIntendDetailGrid(long pIntendID, long pIntendReceivedID, string Status)
    {
        try
        {
            //objIntendDetail.IntendID = 2;
            objIntendDetail.OrgID = OrgID;
            objIntendDetail.OrgAddressID = ILocationID;
           // objIntendDetail.LocationID = InventoryLocationID;
            inventoryBL.GetReceivedIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, Status, pIntendReceivedID, out lstIntendDetail, out lstIntend, out lstOrganization, out lstIntendKitDetail, out lstPrintCount);

            lblOrgName.Text = OrgName;

            if (lstIntend!=null && lstIntend.Count > 0)
            {
                new GateWay(this.ContextInfo).GetUserDetail(lstIntend[0].CreatedBy, out lstcUsers);

                string displayreturn = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_02;
                displayreturn = displayreturn == null ? "Sub-Store StockReturnNo :" : displayreturn;

                string displayreturnby = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_03;
                displayreturnby = displayreturnby == null ? "Returned By :" : displayreturnby;

                string displayreturnfrom = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_04;
                displayreturnfrom = displayreturnfrom == null ? "Raise From :" : displayreturnfrom;

                string displayraise = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_05;
                displayraise = displayraise == null ? "Raised To" : displayraise;

                string displayno = Resources.StockIntend_ClientDisplay.StockIntend_ViewSubStoreStockdetails_aspx_06;
                displayno = displayno == null ? "NO." : displayno;
                if (lstIntend[0].IntendNo.StartsWith("S") == true)
                {
                    LabelIndentNo.Text = displayreturn;
                    LabelIndentRaiseBy.Text = displayreturnby;
                    LabelIndentRaisedFrom.Text = displayreturnfrom;
                    LabelIndentFrom.Text = displayraise;
                }

                if (Request.QueryString["IsTransfer"] != null)
                {
                    LabelIndentNo.Text = displayno;
                }


                lblIntendNo.Text = lstIntend[0].IntendNo;
                if (lstIntendDetail.Count > 0 && lstcUsers != null && lstcUsers.Count>0)
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

                var Transferor = lstIntend[0].LocName.Split('|');
                if (Transferor.Length > 1)
                {
                    if (Transferor[1] == "0")
                    {
                        Label3.Attributes.Add("class", "hide");
                        lblTransferorTinNo.Attributes.Add("class", "hide");
                    }
                    else { lblTransferorTinNo.Text = Transferor[1]; }
                }
                if (Transferor.Length > 2)
                {
                    if (Transferor[2] == "0")
                    {
                        Label7.Attributes.Add("class", "hide");
                        lblTransferorDLNO.Attributes.Add("class", "hide");
                    }
                    else { lblTransferorDLNO.Text = Transferor[2]; }
                }
                if (Transferor.Length > 0)
                {
                    lblIndentRaiseTo.Text = Transferor[0];
                }

                var Transferree = lstIntend[0].ToLocName.Split('|');
                if (Transferree.Length > 1)
                {
                    if (Transferree[1] == "0")
                    {
                        Label1.Attributes.Add("class", "hide");
                        lblTransferreeTinNo.Attributes.Add("class", "hide");
                    }
                    else { lblTransferreeTinNo.Text = Transferree[1]; }
                }
                if (Transferree.Length > 2)
                {
                    if (Transferree[2] == "0")
                    {
                        Label5.Attributes.Add("class", "hide");
                        lblTransferreeDLNO.Attributes.Add("class", "hide");
                    }
                    else { lblTransferreeDLNO.Text = Transferree[2]; }
                }
                if (Transferree.Length > 0)
                {
                    lblIndentFrom.Text = Transferree[0];
                }

                lblComments.Text = lstIntend[0].Comments;
                lblIndentReceivedNo.Text = lstIntend[0].IndentReceivedNo;
                if (lstIntend[0].Status == "Issued")
                {
                    btnApprove.Visible = false;
                    btnCancelIntend.Visible = false;
                }


                new GateWay(this.ContextInfo).GetUserDetail(lstIntend[0].ApprovedBy, out lstUsers);

                if (lstUsers!=null && lstUsers.Count > 0)
                {
                    if (lstIntend[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        tdApproved.Visible = true;

                        approvedDateTD.InnerText = lstIntend[0].ApprovedAt.ToExternalDate();
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
                //Arun
                //string displaynoo = Resources.Inventory_ClientDisplay.Inventory_ViewSubStoreStockdetails_aspx_07;
                //displaynoo = displaynoo == null ? "Date  :" : displaynoo;
                //lblissueddatetitle.Text = lblStatus.Text + " " + displayno;
                //lblIssuedDate.Text = lstIntend[0].IntendIssuedDate.ToString("dd MMMM yy");
                //end
            }

            //if (string.IsNullOrEmpty(IndentType) && string.IsNullOrEmpty(SearchType))
            //{
            //    lblIndentReceivedNo.Text = lstIntend[0].IndentReceivedNo.ToString();
            //}
            //else
            //{
            //if (IndentType.Equals("Raised Indent") && SearchType.Equals("View Intend"))
            //{
            if (lstPrintCount.Count > 0)
            {
                lblIndentReceivedNo.Text = lstPrintCount[0].ProductName != null ? lstPrintCount[0].ProductName : lblIndentReceivedNo.Text;;
            }
            //}
            //else
            //{
            //    lblIndentReceivedNo.Text = lstIntend[0].IndentReceivedNo.ToString();
            //}
            //   }


            Viewvalues();


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
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    private void Viewvalues()
    {

        if ((lstIntend[0].Status == "Pending") || (lstIntend[0].Status == "Approved"))
        {
            GridViewDetails.DataSource = lstIntendDetail;
            GridViewDetails.DataBind();

            // gvIntendDetail.DataBind();
            gvIntendDetail.Visible = false;
            GridViewDetails.Visible = true;
            GridViewDetails.FooterRow.Visible = true;
            btnSave.Visible = false;

        }
        else if ((lstIntend[0].Status == "Issued"))
        {
            GridViewDetails.DataSource = lstIntendDetail;
            GridViewDetails.DataBind();
            gvIntendDetail.Visible = false;
            GridViewDetails.Visible = true;

            btnSave.Visible = false;
        }

        else if ((lstIntend[0].Status == "Received"))
        {
            GridViewDetails.DataSource = lstIntendDetail;
            GridViewDetails.DataBind();
            GridViewDetails.Visible = true;
            GridViewDetails.FooterRow.Visible = true;
            btnSave.Visible = false;
        }

        else
        {


            GridViewDetails.DataSource = lstIntendDetail;
            GridViewDetails.DataBind();
            GridViewDetails.Visible = true;
            btnSave.Visible = false;
        }

    }

    protected void btnIntend_Click(object sender, EventArgs e)
    {
        //long returnCode = -1;
        //long IndID = -1;
        //long pId = -1;
        //long intendID = 0;

        //try
        //{
        //    Button btn = (Button)sender;

        //    if (Request.QueryString["intID"] != null)
        //    {
        //        Int64.TryParse(Request.QueryString["intID"], out intendID);
        //        returnCode = inventoryBL.UpdateStockIssue(intendID, btn.CommandArgument, LID, OrgID);

        //    }


        //    if (returnCode == 0)
        //    {
        //        Response.Redirect(@"../Inventory/ViewIntendDetail.aspx?ID=" + pId + "&intID=" + intendID, true);
        //        ///ViewIntendDetail.aspx?intID=61
        //    }
        //}
        //catch (System.Threading.ThreadAbortException tae)
        //{
        //    string exp = tae.ToString();
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error While Saving Stock Return Details.", ex);
        //    ErrorDisplay1.ShowError = true;
        //    ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        //}
    }

    private List<InventoryItemsBasket> GetBasketIntendDetail()
    {
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (GridViewRow row in gvIntendDetail.Rows)
        {
            InventoryItemsBasket newBasket = new InventoryItemsBasket();
            newBasket.BatchNo = ((HiddenField)row.FindControl("hdnpBatchNo")).Value;
            newBasket.Quantity = Convert.ToDecimal(((HiddenField)row.FindControl("hdnpQuantity")).Value);
            newBasket.ID = Convert.ToInt64(((HiddenField)row.FindControl("hdnID")).Value);
            newBasket.ProductID = Convert.ToInt64(((HiddenField)row.FindControl("hdnpProductID")).Value);
            //newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
            //newBasket.Rate = Convert.ToDecimal(listChild[7]);
            //newBasket.Tax = Convert.ToDecimal(listChild[8]);
            //newBasket.ExpiryDate = DateTime.Parse(listChild[9]);
            //newBasket.Manufacture = DateTime.Now;
            //newBasket.AttributeDetail = "N";
            lstInventoryItemsBasket.Add(newBasket);
        }
        return lstInventoryItemsBasket;
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        //long returnCode = -1;
        //long intendID = 0;
        //try
        //{

        //    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        //    foreach (GridViewRow gR in gvIntendDetail.Rows)
        //    {
        //        InventoryItemsBasket objINV = new InventoryItemsBasket();
        //        //if (lblStatus.Text == "Pending")
        //        //{
        //        //gR.FindControl("txtquantity").Visible = false;
        //        //}
        //        //else
        //        {

        //        }

        //        TextBox txtquantity = (TextBox)gR.FindControl("txtquantity");
        //        HiddenField hdnIssuedQuantity = (HiddenField)gR.FindControl("hdnpQuantity");
        //        HiddenField hdnID = (HiddenField)gR.FindControl("hdnpID");
        //        HiddenField hdnProductID = (HiddenField)gR.FindControl("hdnpProductID");
        //        HiddenField hdnBatchNo = (HiddenField)gR.FindControl("hdnpBatchNo");
        //        if (Convert.ToDecimal(txtquantity.Text) > 0)
        //        {
        //            long IntendID = Convert.ToInt64(hdnID.Value);
        //            long ProductID = Convert.ToInt64(hdnProductID.Value);
        //            string BatchNo = hdnBatchNo.Value.ToString();
        //            decimal Qty = Convert.ToDecimal(hdnIssuedQuantity.Value) - Convert.ToDecimal(txtquantity.Text);
        //            decimal iQty = txtquantity.Text == "" ? 0 : Convert.ToDecimal(txtquantity.Text);
        //            objINV.ProductID = ProductID;
        //            objINV.BatchNo = BatchNo;
        //            objINV.Quantity = iQty;
        //            objINV.ID = IntendID;
        //            objINV.RECQuantity = Convert.ToDecimal(hdnIssuedQuantity.Value);


        //            ////objINV.CategoryID = int.Parse(hdnFinalBillID.Value);
        //            ////objINV.RECQuantity = Convert.ToDecimal(txtReturnQuantity.Text);
        //            objINV.ExpiryDate = DateTime.Now;
        //            objINV.Manufacture = DateTime.Now;
        //            lstInventoryItemsBasket.Add(objINV);


        //        }


        //    }
        //    if (Request.QueryString["intID"] != null)
        //    {
        //        Int64.TryParse(Request.QueryString["intID"], out intendID);
        //        returnCode = inventoryBL.UpdateIntendDetail(intendID, OrgID, ILocationID, InventoryLocationID, LID, lstInventoryItemsBasket);

        //        if (returnCode > 0)
        //        {
        //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Product Updated Successfully');", true);

        //        }

        //    }




        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error while Adding New Product - IndentViewDetail.aspx", ex);
        //    ErrorDisplay1.ShowError = true;
        //    ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        //}

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
                hdnIssuedQuantity = (HiddenField)e.Row.FindControl("hdnpQuantity");
                hdnID = (HiddenField)e.Row.FindControl("hdnpID");
                hdnProductID = (HiddenField)e.Row.FindControl("hdnpProductID");
                hdnBatchNo = (HiddenField)e.Row.FindControl("hdnpBatchNo");
                txtRefundAmount.Attributes.Add("readonly", "true");

                string sValidateQty = "ValidateReturnQty('" + hdnIssuedQuantity.ClientID + "','" + txtquantity.ClientID + "');";
                txtquantity.Attributes.Add("onBlur", sValidateQty);
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

    List<long> lstProducts = new List<long>();
    protected void GridViewDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            string st = string.Empty;
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IOM = (InventoryItemsBasket)e.Row.DataItem;

                if (lstProducts.Exists(p => p.Equals(IOM.ProductID) && p.Equals(IOM.ExpiryDate)))
                {
                    e.Row.Cells[5].Text = "--";
                }
                else
                {
                    lstProducts.Add(IOM.ProductID);
                    lblTotalQty.Text = String.Format("{0:0.00}", (IOM.Quantity + decimal.Parse(lblTotalQty.Text)));
                }
                if (IOM.Remarks == "Y")
                {
                    Label lblTSellingPrice1 = (Label)e.Row.FindControl("lblTSellingPrice");
                    lblTSellingPrice1.Text = String.Format("{0:0.00}", IOM.TotalCost);
                }
                Label lblSellingPrice = (Label)e.Row.FindControl("lblSellingPrice");
                Label lblQuantity = (Label)e.Row.FindControl("lblQuantity");
                Label lbltotAmt = (Label)e.Row.FindControl("lbltotAmt");
                lbltotAmt.Text = String.Format("{0:0.00}", (decimal.Parse(lblSellingPrice.Text) * decimal.Parse(lblQuantity.Text)));

                lblUnitCostPrice.Text = String.Format("{0:0.00}", (IOM.TotalCost + decimal.Parse(lblUnitCostPrice.Text)));
                lblTSellingPrice.Text = String.Format("{0:0.00}", (IOM.TSellingPrice + decimal.Parse(lblTSellingPrice.Text)));
                lblTotalUnitSellingPrice.Text = String.Format("{0:0.00}", (IOM.SellingPrice + decimal.Parse(lblTotalUnitSellingPrice.Text)));



            }
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading GridViewDetails Details.", ex);
            //ErrorDisplay1.ShowError = true;

        }
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

    protected string GetRowTotal(object Quantity, object CostPrice, object TotalCost, object Remarks)
    {
        GetTotal(Quantity, CostPrice, TotalCost, Remarks);
        decimal c = 0;
        try
        {
            string lRemarks = (string)Remarks;
            if (lRemarks == "Y")
            {
                c = (decimal)TotalCost;

            }
            else
            {
                c = ((decimal)Quantity * (decimal)CostPrice);
            }
            lblTotalPrice.Text = String.Format("{0:0.00}", ((c) + decimal.Parse(lblTotalPrice.Text)));//To Print Row vise Total
            return c.ToString("0.00");
        }
        catch (Exception)
        {
            return "0.00";
        }
    }


    protected void GetTotal(object Quantity, object CostPrice, object TotalCost, object Remarks)
    {
        decimal c = 0;
        try
        {
            string lRemarks = (string)Remarks;
            if (lRemarks == "Y")
            {

                c += (decimal)TotalCost;
            }
            else
            {
                c += ((decimal)Quantity * (decimal)CostPrice);
            }
            lblTotal.Text = c.ToString("0.00");
        }
        catch (Exception)
        {
            lblTotal.Text = "0.00";
        }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }


    public void ExportToExcel()
    {
        try
        {
            List<Config> lstConfig = new List<Config>();
            String imagepath = "";
            String HospitalName = "";
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.IPBill;

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                imagepath = "<img src='" + lstConfig[0].ConfigValue.Trim().Replace("..", System.Configuration.ConfigurationManager.AppSettings["ApplicationName"].ToString()) + "'/>";
            }

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                HospitalName = lstConfig[0].ConfigValue.Trim().Replace("Rincian Pembayaran", "");
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=IndentDetails_" + lblIntendNo.Text + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Output.Write("\n<html>\n<body>");
            Response.Output.Write("<table>");
            Response.Output.Write("<tr> <td class='v-bottom'><div class='a-center'>" + imagepath + "</div> </td> <td colspan='3'><H3>" + HospitalName + "</H3></td>  </tr>");
            Response.Output.Write("<tr> <td></td></tr>");
            //Response.Output.Write("<tr> <td colspan='5' style='text-align:center'>" + "<B>" + hdnPageName.Value + "&nbsp;" + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString() + "</B></td></tr>");
            //Response.Output.Write("<tr> <td colspan='5' style='text-align:center'>" + "<B>Pengguna Wise Laporan Collection " + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString() + "</B></td></tr>");
            Response.Output.Write("</table>");


            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            tblIndentInfo.RenderControl(oHtmlTextWriter);

            GridViewDetails.RenderControl(oHtmlTextWriter);
            //            trbeakupdetails.RenderControl(oHtmlTextWriter);
            // ctr.RenderControl(oHtmlTextWriter);
            Response.Output.Write(oStringWriter.ToString());
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.Output.Write("\n</body>\n</html>");
            Response.Flush();
            Response.End();


        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }

}



