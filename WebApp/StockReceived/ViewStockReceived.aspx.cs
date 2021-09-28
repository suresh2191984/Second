using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;
using System.IO;
using System.Text;
using Attune.Kernel.StockReceive.BL;

public partial class StockReceived_ViewStockReceived : Attune_BasePage
{
    public StockReceived_ViewStockReceived()
        : base("StockReceived_ViewStockReceived_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;

    decimal TotalAmtBeforeTax = decimal.Zero;
    decimal TotalAmtAfterTax = decimal.Zero;
    decimal SchemeAmt = decimal.Zero;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockReceived> lstStockReceived = new List<StockReceived>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

    List<Users> lstUsers = new List<Users>();
    List<BarcodeMappingList> lstBarcode = new List<BarcodeMappingList>();
    InventoryCommon_BL inventoryBL;
    decimal CGSTAmount = 0;
    decimal SGSTAmount = 0;
    decimal IGSTAmount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            //IsNeed Calculation Of Complimentary Quantity Required 
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                
                hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("View_MatchingInvoice_Button", OrgID, ILocationID, out lstInventoryConfig);

              //  if (lstInventoryConfig.Count > 0)
              //  {
              //      btnInvoice.Visible = Convert.ToBoolean(lstInventoryConfig[0].ConfigValue);

              //  }
              //  else
              //  {
                    btnInvoice.Visible = false;
              //  }
                LoadDetails();
				string hideTax=GetConfigValue("IsMiddleEast",OrgID);
           		 if (hideTax=="Y")
           		 {
                lblSupplierSerTax.Attributes.Add("class", "hide");
                totalTaxAmt.Attributes.Add("class", "hide");
                    grdResult.Columns[9].Visible = false;
                    grdResult.Columns[10].Visible = false;
					                    grdResult.Columns[11].Visible = false;
                }



                 string hideStampFee = GetConfigValue("StampFeeDeliveryChargesApplicable", OrgID);
                 if (hideStampFee != "Y")
                 {
                     trStampFee.Attributes.Add("class", "hide");
                     trDeliveryCharges.Attributes.Add("class", "hide");
                 }



				LoadBarCode(lstBarcode);
           		grdViewBarCode.Attributes.Add("class", "hide");
            	divViewBarCode.Attributes.Add("class", "hide");
           		overlaydiv.Attributes.Add("class", "hide");
                Notification();
                string IsMiddleEast = GetConfigValue("IsMiddleEast", OrgID);
                if (IsMiddleEast == "Y")
                    lblDCNumber.Attributes.Add("class", "show");
                else
                    Label1.Attributes.Add("class", "show");
            GetInvConfigDtls();
            }

            string SchemeDiscConfigValue = GetConfigValue("IsNeedSchemeDiscount", OrgID);
            hdnIsSchemeDiscount.Value = string.IsNullOrEmpty(SchemeDiscConfigValue) == true ? "N" : SchemeDiscConfigValue;
        

    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    private void Notification()
    {

        PageContextDetails.ButtonName = "btnFinish";
        PageContextDetails.ButtonValue = "Finish";

        var mailbuilder = new StringBuilder();
        divReceived.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));

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
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["ID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }
    public void LoadDetails()
    {
        DateTime pDate = DateTime.Now;
        DateTime.TryParse("01/07/2017", out pDate);
        bool isGSTDate = false;

        long poNO = 0;
        string approval = string.Empty;
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        if (Request.QueryString["ID"] != null)
        {
            poNO = long.Parse(Request.QueryString["ID"]);
        }
        approval = Request.QueryString["Approve"];
        // hypLnkPrint.NavigateUrl = "PrintStockReceived.aspx?poNO=" + poNO + "";
        try
        {
            List<StockReceivedBarcodeMapping> lstBarCodeMapping = new List<StockReceivedBarcodeMapping>();
            inventoryBL.GetStockReceivedDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket,out lstBarCodeMapping);
            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {

                lblOrgName.Text = lstOrganization[0].Name;
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                    lblOrgTinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                    lblorgDlno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (lstSuppliers.Count > 0)
                {                 
                    lblVendorName.Text = lstSuppliers[0].SupplierName;
                    lblVendorTinno.Text = lstSuppliers[0].TinNo;
                    lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                    lblVendorCity.Text = lstSuppliers[0].City;
                    lblVendorPhone.Text = lstSuppliers[0].Phone;
                    lblgstinno.Text = lstSuppliers[0].GSTIN;
                }
                if (DateTime.MaxValue.ToString() == lstStockReceived[0].StockReceivedDate.ToString() && lstStockReceived[0].StockReceivedDate.ToString() != null)
                {
                    lblSRDate.Text = "----";
                }
                else
                {
                    lblSRDate.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
                    isGSTDate = lstStockReceived[0].StockReceivedDate >= pDate ? true : false;
                }
                lblPOID.Text = lstStockReceived[0].PurchaseOrderNo;
                if (lstStockReceived[0].InvoiceNo != "" && lstStockReceived[0].InvoiceNo != null)
                {
                    lblInvoiceNo.Text = lstStockReceived[0].InvoiceNo;
                }
                else
                {
                    lblInvoiceNo.Text = "----";
                }
                if (lstStockReceived[0].DCNumber != "" && lstStockReceived[0].DCNumber != null)
                {
                    lblDCNo.Text = lstStockReceived[0].DCNumber;
                }
                else
                {
                    lblDCNo.Text = "----";
                }
                //lblDCNo.Text = lstStockReceived[0].DCNumber;
                if (lstStockReceived != null && lstStockReceived.Count > 0)
                {
                    lblTotaltax.Text = String.Format("{0:N}", lstStockReceived[0].Tax);
                }
                if (lstStockReceived[0].ExciseTaxAmount <= 0)
                {
                    lbltotalExe.Attributes.Add("class", "hide");
                    trCess2.Attributes.Add("class", "hide");
                    trEdCess1.Attributes.Add("class", "hide");
                    lblcst5.Attributes.Add("class", "hide");
                }

                hdnApproveStockReceived.Value = lstStockReceived[0].StockReceivedID.ToString();
                lblReceivedID.Text = lstStockReceived[0].StockReceivedNo.ToString();
                lblTax.Text = String.Format("{0:0.00}", lstStockReceived[0].Tax);
                decimal TotalCost = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.RECQuantity * o.UnitCostPrice);
                lblTotalSales.Text = String.Format("{0:0.00}", TotalCost);
                lblDiscount.Text = String.Format("{0:N}", lstStockReceived[0].Discount);
                lblamountused.Text = String.Format("{0:0.00}", lstStockReceived[0].UsedCreditAmount);
                lblGrountTotal.Text = String.Format("{0:N}", lstStockReceived[0].GrandTotal);
                lblTotalExcise.Text = String.Format("{0:0.00}", (lstStockReceived[0].ExciseTaxAmount - lstStockReceived[0].UsedCreditAmount));
                lblCessOnExcise.Text = String.Format("{0:0.00}", lstStockReceived[0].CessOnExciseTax);
                lblHighterEdCess.Text = String.Format("{0:0.00}", lstStockReceived[0].HighterEdCessTaxAmount);
                lblStampFeeused.Text = String.Format("{0:0.00}", lstStockReceived[0].StampFee);
                lblDeliveryChargesUsed.Text = String.Format("{0:0.00}", lstStockReceived[0].DeliveryCharges);

                string IsNeedTcsTax = GetConfigValue("IsNeedTcsTax", OrgID);

                if (lstSuppliers[0].IsTCS == "Y" && IsNeedTcsTax=="Y")
                {
                    TrTCS.Attributes.Add("class", "displaytr");
                    lblTCSValue.Text = String.Format("{0:0.00}", lstStockReceived[0].TCSValue);
                }

                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("RecuiredCessAmountDispay", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue.ToUpper() == "N")
                    {
                        trCess2.Attributes.Add("class", "hide");
                        trEdCess1.Attributes.Add("class", "hide");
                    }
                    else
                    {
                        trCess2.Attributes.Add("class", "show");
                        trEdCess1.Attributes.Add("class", "show");

                    }

                }
                lblCST.Text = String.Format("{0:0.00}", lstStockReceived[0].CSTAmount);
                lblRoundOffValue.Text = string.Format("{0:0.00}", lstStockReceived[0].RoundOfValue);
                lblGrandwithRoundof.Text = string.Format("{0:N}", lstStockReceived[0].GrandTotalRF);
				lblDiscount.Text = string.Format("{0:0.00}", lstStockReceived[0].PODiscountAmount);
                lblTax.Text = string.Format("{0:0.00}", lstStockReceived[0].SupServiceTax);
                if (lstStockReceived[0].Comments != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Comments: " + lstStockReceived[0].Comments;
                }
                if (lstStockReceived[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    approvedDateTD.InnerText = lstStockReceived[0].ApprovedAt.ToExternalDate();
                }
                hdnStatus.Value = lstStockReceived[0].Status;
                lblStatus.Text = lstStockReceived[0].Status;
                if(lstStockReceived[0].InvoiceDate.ToExternalDate() !="")
                {
                    lblInvoiceDate.Text=lstStockReceived[0].InvoiceDate.ToExternalDate();
                }
               /* else{
                    lblInvoiceDate.Text="----";
                }*/

               else if (lstStockReceived[0].PurchaseOrderDate.ToExternalDate() != "" && lstStockReceived[0].PurchaseOrderDate.ToExternalDate() !=null)
                {
                    lblInvoiceDate.Text = lstStockReceived[0].PurchaseOrderDate.ToExternalDate();
                }
                else
                {
                    lblInvoiceDate.Text = "----";
                }

                hdnTaxcalcType.Value = lstStockReceived[0].NetCalcTax;
                if (lstStockReceived[0].ApprovedBy != 0)
                {
                    returnCode = new GateWay(this.ContextInfo).GetUserDetail(lstStockReceived[0].ApprovedBy, out lstUsers);
                    if (lstUsers != null && lstUsers.Count > 0)
                    {
                    approvedByTD.Attributes.Add("class", "displaytd");
                    approvedByTD.InnerText = lstUsers[0].Name;
                    }
                }

                //arya
                lblPreparedbyVal.Attributes.Add("class", "displaytd");
                returnCode = new GateWay(this.ContextInfo).GetUserDetail(lstStockReceived[0].CreatedBy, out lstUsers);
                if (lstUsers != null && lstUsers.Count > 0)
                {
                    lblPreparedbyVal.InnerText = lstUsers[0].Name;//lstStockReceived[0].CreatedBy.ToString();
                }
                lblauthorizedVal.Attributes.Add("class", "displaytd");
                returnCode = new GateWay(this.ContextInfo).GetUserDetail(lstStockReceived[0].ModifiedBy, out lstUsers);
				if (lstUsers != null && lstUsers.Count > 0)
                {
                lblauthorizedVal.InnerText = lstUsers[0].Name;//lstStockReceived[0].ModifiedBy.ToString();
				}
                // lblapprovedVal.Text = lstStockReceived[0].ApprovedBy.ToString();

                if (hdnStatus.Value == StockOutFlowStatus.Approved && approval == "1")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    trApproveBlock.Attributes.Add("class", "displaytr");
                }
                if (hdnStatus.Value == StockOutFlowStatus.Pending && approval == "1")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    trApproveBlock.Attributes.Add("class", "displaytr");
                }
                if (lstStockReceived[0].StockReceivedTypeID == 5)
                {
                    tblAmountDetails.Attributes.Add("class", "hide");
                    grdResult.Columns[13].Visible = false;
                }
                if (lstInventoryItemsBasket.Count > 0)
                {
                    foreach (InventoryItemsBasket lstitem in lstInventoryItemsBasket)
                    {
                        CGSTAmount = CGSTAmount + lstitem.CGSTRate;
                        SGSTAmount = SGSTAmount + lstitem.SGSTRate;
                        IGSTAmount = IGSTAmount + lstitem.IGSTRate;
                    }
                }


                lbltotcgstamt.Text = Convert.ToString(CGSTAmount);
                lbltotsgstamt.Text = Convert.ToString(SGSTAmount);
                lbltotigstamt.Text = Convert.ToString(IGSTAmount);
                LoadStockReceivedItems(lstInventoryItemsBasket);
            }
            else
            {
                string Message = Resources.StockReceived_ClientDisplay.StockReceived_ViewStockReceived_aspx_01;
                if (Message == null)
                {
                    Message= "No Matching Records Found!";
                }
                lblMessage.Text = Message;
            }
            
            string isVATReq = GetConfigValue("IsVATNotApplicable", OrgID);
            if (isVATReq.Trim() == "Y")
            {
                isGSTDate = false;
            }
            
            if (isGSTDate == true)
            {
                grdResult.Style.Add("display", "none");
                grdstock.Style.Add("display", "table");
                grdGstTax.Style.Add("display", "table");
                lblTotalTaxAmount.Text = "Total GST Amount";
                lblSupplierSerTax.Attributes.Add("class", "hide");
                trgstinno.Style.Add("display", "table-row");
                trtinno.Style.Add("display", "none");
            }
            else
            {
                grdResult.Style.Add("display", "table");
                grdstock.Style.Add("display", "none");
                grdGstTax.Style.Add("display", "none");
                trcgst.Attributes.Add("class", "hide");
                trsgst.Attributes.Add("class", "hide");
                trigst.Attributes.Add("class", "hide");
                trgstinno.Style.Add("display", "none");
                trtinno.Style.Add("display", "table-row");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReceived.aspx.cs", ex);
        }
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            long orderID = Convert.ToInt64(hdnApproveStockReceived.Value);
            string status = StockOutFlowStatus.Approved;
            lstInventoryItemsBasket = GetReceivedItems();
            returnCode = inventoryBL.UpdateReceivedInventoryApproval("StockReceive", lstInventoryItemsBasket, orderID, status, LID, OrgID, ILocationID);
            if (returnCode == 0)
            {
                LoadDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockReceived.aspx", ex);
        }
    }

    public List<InventoryItemsBasket> GetReceivedItems()
    {
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket newBasket = new InventoryItemsBasket();
            newBasket.ID = Int64.Parse(((HiddenField)row.FindControl("hdnRid")).Value);
            newBasket.ProductID = Convert.ToInt64(((HiddenField)row.FindControl("hdnProductId")).Value);
            newBasket.BatchNo = ((HiddenField)row.FindControl("hdnBatchNo")).Value;
            newBasket.Rate = Convert.ToDecimal(((TextBox)row.FindControl("txtSellingPrice")).Text);
            newBasket.ExpiryDate = DateTimeNow;
            newBasket.Manufacture = DateTimeNow;
            lstInventoryItemsBasket.Add(newBasket);

        }
        return lstInventoryItemsBasket;
    }

    public void LoadStockReceivedItems(List<InventoryItemsBasket> lstIIB)
    {
        grdResult.DataSource = lstIIB;
        grdResult.DataBind();
        grdstock.DataSource = lstIIB;
        grdstock.DataBind();
    
    
              var lstGSTTaxDetails = lstIIB.
            
                   
            GroupBy(s => new { s.Tax, s.CGSTPercent, s.SGSTPercent, s.IGSTPercent })

 

                        .Select(cl => new
                         {
                             Tax = cl.First().Tax,
                             CGSTPercent = cl.First().CGSTPercent,
                             CGSTRate = cl.Sum(c => c.CGSTRate),
                             SGSTPercent = cl.First().SGSTPercent,
                             SGSTRate = cl.Sum(c => c.SGSTRate),
                             IGSTPercent = cl.First().IGSTPercent,
                             IGSTRate = cl.Sum(c => c.IGSTRate),

                             TaxableValue = cl.Sum(c => c.TaxableValue),
                           
                         }) .OrderBy(cl => cl.Tax).ToList();
               

         grdGstTax.DataSource = lstGSTTaxDetails;
        grdGstTax.DataBind();

    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket imm = (InventoryItemsBasket)e.Row.DataItem;
            string approval = string.Empty;
            decimal iTtlDiscount = 0;
            decimal iTtlAmtBeforeTax = 0;
            decimal iTtlAmtAfterTax = 0;
            decimal iSchemeDiscount = 0;            
            decimal iDiscount = 0;
            decimal iTax = 0;
            decimal iGrassTotal = 0;
            decimal iNetTotal = 0;
            decimal iTempNetTotal = 0;
            decimal iTempCompQTYTax = 0;
            decimal iCompQtyTotal = 0;

            decimal iSPTotoal = 0;
            decimal iSPDiscount = 0;
            decimal iSPTempNetTotal = 0; 
            iGrassTotal = ((Convert.ToDecimal(imm.UnitCostPrice) - Convert.ToDecimal(imm.ActualAmount)) * imm.RECQuantity);
            iCompQtyTotal = (Convert.ToDecimal(imm.UnitCostPrice) * imm.ComplimentQTY);
            
            //iDiscount = iGrassTotal * imm.Discount / 100;
            iTtlAmtBeforeTax = (Convert.ToDecimal(imm.UnitCostPrice) * imm.RECQuantity);
            iDiscount = imm.Discount;
            iSchemeDiscount = imm.SchemeDisc;
            iTtlDiscount = imm.Discount + imm.SchemeDisc;
            iTempNetTotal = iGrassTotal - iTtlDiscount;
            if (hdnTaxcalcType.Value == "SP")
            {
	       iSPTotoal = (imm.UnitSellingPrice * imm.RECQuantity * imm.Tax / (100 + imm.Tax));
	       iTax = iSPTotoal * imm.Tax / (100 + imm.Tax);
	       
	        if (hdnREQCalcCompQTY.Value == "Y")
		{
		iTax = iTax+((imm.UnitSellingPrice * imm.ComplimentQTY * imm.Tax )/ (100 + imm.Tax));
                }
                else
                {
                    iTax =iTax+ 0;
                }
            }
            else
            {
                iTax = iTempNetTotal * imm.Tax / 100;
                if (hdnREQCalcCompQTY.Value == "Y")
                {
                    iTax =iTax+ (iCompQtyTotal * imm.Tax / 100);
                }
                else
                {
                    iTax =iTax+ 0;
                }
            }
            //iTax = iTempNetTotal * imm.Tax / 100;
            //iTax = (imm.UnitSellingPrice * imm.RECQuantity * imm.Tax  / (100 + imm.Tax));
            iNetTotal = (iTax) + iTempNetTotal;
            //////////////Changes for nationwide

            //lblTotalSales.Text = String.Format("{0:N}", Decimal.Parse(lblTotalSales.Text) + iGrassTotal);


            SchemeAmt += iSchemeDiscount;
            DiscountAmt += iDiscount;
            lblTotalDiscount.Text = String.Format("{0:N}", DiscountAmt);
            lblTotalSchemeDisc.Text = String.Format("{0:N}", SchemeAmt);
            TaxAmt = TaxAmt + iTax;

            TotalAmtBeforeTax += iTtlAmtBeforeTax;
            
            //lblTotaltax.Text = String.Format("{0:0.00}", TaxAmt);
            string hidePurchTax = GetConfigValue("GunamCommon", OrgID);
            if (hidePurchTax == "Y")
            {
                grdResult.Columns[10].Visible = true;

            }
            e.Row.Cells[6].CssClass = "a-right";
            e.Row.Cells[7].CssClass = "a-right hide"; //Nominal
            e.Row.Cells[8].CssClass = "a-right";
            e.Row.Cells[9].CssClass = "a-right";
            e.Row.Cells[10].CssClass = "a-right";
            e.Row.Cells[11].CssClass = "a-right";
            e.Row.Cells[12].CssClass = "a-right";
            e.Row.Cells[13].CssClass = "a-right";
            e.Row.Cells[14].CssClass = "a-right";
            decimal PurchaseTax=0;
            decimal Unitprice=0;
            decimal Nominal=0;
            decimal RecUnit=0;
            decimal Discount=0;
                RecUnit = Convert.ToDecimal(imm.RECQuantity);//.Convert.ToDecimal(e.Row.Cells[4].Text);
                Unitprice = Convert.ToDecimal(imm.UnitCostPrice);
            if (!string.IsNullOrEmpty(e.Row.Cells[7].Text))
            { 
                Nominal = Convert.ToDecimal(e.Row.Cells[7].Text);
            }
            if (!string.IsNullOrEmpty(e.Row.Cells[8].Text))
            { 
                Discount = Convert.ToDecimal(e.Row.Cells[8].Text);
            }

            if(!string.IsNullOrEmpty(e.Row.Cells[11].Text))
            {
                PurchaseTax = Convert.ToDecimal(e.Row.Cells[11].Text);
                PurchaseTax = (Convert.ToDecimal(lblTotaltax.Text) + ((PurchaseTax / 100) *(( Unitprice - Nominal) * (RecUnit) - ((Discount / 100) * (Unitprice - Nominal) * (RecUnit)))));

                 



                

            }
            //lblGrountTotal.Text = String.Format("{0:N}", (Decimal.Parse(lblGrountTotal.Text) + iGrassTotal) - (DiscountAmt +imm.Discount));
            string HighlightCompQty = GetConfigValue("GunamCommon", OrgID);
            if (HighlightCompQty == "Y")
            {

                if (imm.RECQuantity == 0 && imm.ComplimentQTY > 0)
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }
            }
            lblTotaltax.Text = TaxAmt.ToString("0.00");
            //lblGrandwithRoundof.Text = ((Convert.ToDecimal(lblTotalSales.Text) + Convert.ToDecimal(lblTotaltax.Text)) -(DiscountAmt +imm.Discount)).ToString("0.00") ;
            TotalAmtAfterTax = (TotalAmtBeforeTax - (DiscountAmt + SchemeAmt));
            lblAmtBefTax.Text = String.Format("{0:N}", TotalAmtBeforeTax - (DiscountAmt + SchemeAmt));
            lblAmtAftTax.Text = String.Format("{0:N}", TotalAmtAfterTax + TaxAmt);
        }
    }


    protected static string GetDate(object dataItem)
    {
        if (dataItem.ToString() == "")
            return "";
        DateTime DateM=Convert.ToDateTime(dataItem);
        string DM = DateM.ToExternalMonth();
        return DM;
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
           /* if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx?ACN=" + strACN, true);
            }*/
            Response.Redirect("~/InventoryCommon/InventorySearch.aspx");

        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnInvoice_Click(object sender, EventArgs e)
    {

        string url = Request.ApplicationPath + @"/Inventory/MatchingViewStockReceived.aspx?isPopup=Y&ID=" + hdnApproveStockReceived.Value;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDivs", "javascript:ReportPopUP('" + url + "');", true);
        //btnInvoice.OnClientClick = "ReportPopUP('" + url + "');";        
    }
	public void LoadBarCode(List<BarcodeMappingList> lstBarcode)
    {

        returnCode = new StockReceived_BL(base.ContextInfo).GetBarcodeDetails(lblPOID.Text, out lstBarcode);
        grdViewBarCode.DataSource = lstBarcode;
        grdViewBarCode.DataBind();

        hdnGridcount.Value = grdViewBarCode.Rows.Count > 0?grdViewBarCode.Rows.Count.ToString():"0";       
    }
    protected void GetInvConfigDtls()
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("SR Header", OrgID, ILocationID, out lstInventoryConfig);
            bool _flag = false;
            if (lstInventoryConfig.Count > 0)
            {
                imgBillLogo.ImageUrl = lstInventoryConfig[0].ConfigValue.Trim();
                if (!string.IsNullOrEmpty(lstInventoryConfig[0].ConfigValue.Trim()))
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
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}


