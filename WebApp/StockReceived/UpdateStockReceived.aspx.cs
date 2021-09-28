using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Globalization;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.StockReceive.BL;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon;

public partial class StockReceived_UpdateStockReceived : Attune_BasePage
{
    public StockReceived_UpdateStockReceived()
        : base("StockReceived_UpdateStockReceived_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    List<InventoryItemsBasket> lstInventoryItemsBasket;
    InventoryCommon_BL inventoryBL;
    decimal TotalCostPrice;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    decimal TempTaxAmt = decimal.Zero;
    decimal compQTYTaxAmt = decimal.Zero;
    string iFlag = string.Empty;
    string IsEditTaxRate = string.Empty;
    decimal CGSTAmount = 0;
    decimal SGSTAmount = 0;
    decimal IGSTAmount = 0;
    string NeedTcsTax = "N";
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            List<InventoryConfig> lstInvenConfig = new List<InventoryConfig>();
            //IsNeed Calculation Of Complimentary Quantity Required 
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInvenConfig);
            if (lstInvenConfig.Count > 0)
            {

                hdnREQCalcCompQTY.Value = lstInvenConfig[0].ConfigValue;
            }

            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {
                hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;

            }


            List<InventoryConfig> lstInvProductBarcodeConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedProductBarcode", OrgID, ILocationID, out lstInvProductBarcodeConfig);
            hdnNeedProductBarcode.Value = lstInvProductBarcodeConfig.Count > 0 ? lstInvProductBarcodeConfig[0].ConfigValue : "N";

            NeedTcsTax = GetConfigValue("IsNeedTcsTax", OrgID);
            if (NeedTcsTax == "Y")
            {
                string TcsTaxPer = GetConfigValue("TCSTaxPercentage", OrgID);
                hdnTcsTaxPer.Value = TcsTaxPer;
                hdnNeedTcsTax.Value = NeedTcsTax;

            }

            LoadDetails();
            ACX2OPPmt.Attributes.Add("class", "hide");
            ACX2minusOPPmt.Attributes.Add("class", "show");
            ACX2responsesOPPmt.Attributes.Add("class", "displaytr");
            //List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Receive_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    btnUpdate_Click(sender, e);
                }
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Is_change_or_edit_VAT_Rate_Products", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    IsEditTaxRate = "Y";
                    txtTax.Attributes.Add("disabled", "true");
                }
                else
                {
                    IsEditTaxRate = "N";
                }
            }
            else
            {
                IsEditTaxRate = "N";

            }
            List<InventoryConfig> lstInventoryConfigProductType = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule_ProductType", OrgID, ILocationID, out lstInventoryConfigProductType);
            if (lstInventoryConfigProductType.Count > 0)
            {
                hdnIsSellingPriceTypeRuleApply.Value = lstInventoryConfigProductType[0].ConfigValue;
            }
            if (hdnIsSellingPriceTypeRuleApply.Value == "Y")
            {
                txtTotaltax.Attributes.Add("disabled", "disabled");
                txtTotalDiscount.Attributes.Add("disabled", "disabled");
            }
            string HideTax = GetConfigValue("IsMiddleEast", OrgID);
            if (HideTax == "Y")
            {
                grdResult.Columns[14].Visible = false;
                grdResult.Columns[15].Visible = false;
                lblTaxClc.Attributes.Add("class", "hide");
                txtTaxAmt.Attributes.Add("class", "hide");
                lblSupplierTax.Attributes.Add("class", "hide");
                trTAXamt.Attributes.Add("class", "hide");
            }

            string hideStampFee = GetConfigValue("StampFeeDeliveryChargesApplicable", OrgID);
            if (hideStampFee != "Y")
            {

                trStampFee.Attributes.Add("class", "hide");
                trDeliveryCharges.Attributes.Add("class", "hide");
            }

            string SchemeDiscConfigValue = GetConfigValue("IsNeedSchemeDiscount", OrgID);
            hdnIsSchemeDiscount.Value = string.IsNullOrEmpty(SchemeDiscConfigValue) == true ? "N" : SchemeDiscConfigValue;

            if (hdnIsSchemeDiscount.Value == "N")
            {
                trScheme.Attributes.Add("class", "hide");
            }
        }
    }
    /// <summary>
    /// Fetch the necessary Org Info, Supplier Info and Received Stock
    /// Details for Update Process
    /// </summary>
    public void LoadDetails()
    {
        try
        {
            long poNO = 0;
            string approval = string.Empty;

            if (Request.QueryString["ID"] != null)
            {
                poNO = long.Parse(Request.QueryString["ID"]);
            }


            List<Organization> lstOrganization = new List<Organization>();
            List<Suppliers> lstSuppliers = new List<Suppliers>();
            List<StockReceived> lstStockReceived = new List<StockReceived>();
            if (Request.QueryString["sType"] != null && Request.QueryString["sType"] == "Qui")
            {
                lnkAddMore.Visible = true;
            }

            lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            List<StockReceivedBarcodeMapping> lstBarCodeMapping = new List<StockReceivedBarcodeMapping>();
            inventoryBL.GetStockReceivedDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket, out lstBarCodeMapping);
            if (lstSuppliers!=null && lstSuppliers.Count>0)
            {
                CheckState.Value = lstSuppliers[0].StateCode == "Y" ? "Y" : "N";
            }

            hdnRecdProducts.Value = "N";
            if (lstInventoryItemsBasket.Count == 1)
            {
                hdnRecdProducts.Value = "Y";
            }
            
            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (lstSuppliers.Count > 0)
                {
                    lblVendorName.Text = lstSuppliers[0].SupplierName;
                    lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                    lblVendorCity.Text = lstSuppliers[0].City;
                    lblVendorPhone.Text = lstSuppliers[0].Phone;
                }
                lblSRDate.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
                lblPOID.Text = lstStockReceived[0].PurchaseOrderNo;
                hdnApproveStockReceived.Value = lstStockReceived[0].StockReceivedID.ToString();
                lblReceivedID.Text = lstStockReceived[0].StockReceivedNo.ToString();
                lblConsignMentId.Text = lstStockReceived[0].StockReceivedNo.ToString();


                txtTotaltax.Text = (lstStockReceived[0].SupServiceTax).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtTotaltaxAmt.Text = (lstStockReceived[0].Tax).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtTotalDiscount.Text = (lstStockReceived[0].PODiscountAmount).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtGrandTotal.Text = (lstStockReceived[0].GrandTotal).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                lblGrandTotal.Text = (lstStockReceived[0].GrandTotal).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                hdnGrandPOTotal.Value = (lstStockReceived[0].GrandTotal).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                hdnRoundofType.Value = lstStockReceived[0].RoundOfType;
                txtRoundOffValue.Text = (lstStockReceived[0].RoundOfValue).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtGrandwithRoundof.Text = (lstStockReceived[0].GrandTotalRF).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtCreditAmnt.Text = (lstStockReceived[0].UsedCreditAmount).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);

                txtStampFee.Text = (lstStockReceived[0].StampFee).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                txtDeliveryCharges.Text = (lstStockReceived[0].DeliveryCharges).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);

                if (NeedTcsTax == "Y" && lstSuppliers[0].IsTCS == "Y")
                {
                    hdnIsSupplierTCS.Value = lstSuppliers[0].IsTCS;
                    tr1Tcs.Attributes.Add("class", "displaytr");
                    txtTCS.Text = (lstStockReceived[0].TCSValue).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                }
                if (lstStockReceived[0].Comments != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Comments: " + lstStockReceived[0].Comments;
                }
                hdnStatus.Value = lstStockReceived[0].Status;
                lblStatus.Text = lstStockReceived[0].Status;
                LoadStockReceivedItems(lstInventoryItemsBasket);
                hdnGrandPOTotal.Value = String.Format("{0:0.00}", GetGrandTotal());
            }
            else
            {
                string Message = Resources.StockReceived_ClientDisplay.StockReceived_UpdateStockReceived_aspx_01;
                if (Message == null)
                {
                    Message = "No Matching Records Found!";
                }

                lblMessage.Text = Message;
            }
            if (lstStockReceived[0].IsConsignment != null && lstStockReceived[0].IsConsignment.Trim() == "Y")
            {
                trPoNo.Attributes.Add("class", "hide");
                trRNo.Attributes.Add("class", "hide");
                trConNo.Attributes.Add("class", "displaytr");
                lblStockReceived.Text = "Consignment Stock";
                lblReceivedStockDetails1.Text = "Consignment Stock Details";
            }
            else
            {
                trConNo.Attributes.Add("class", "hide");
            }
            decimal totalSales = decimal.Zero;
            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblUnitPrice = (Label)row.FindControl("lblUnitPrice");
                Label lblRecLSUQty = (Label)row.FindControl("lblRecQty");
                HiddenField hdnTotalCost = (HiddenField)row.FindControl("hdnTotalCost");
                totalSales += decimal.Parse(lblUnitPrice.Text) * decimal.Parse(lblRecLSUQty.Text); //decimal.Parse(hdnTotalCost.Value);
            }
            txtTotalSales.Text = String.Format("{0:0.00}", totalSales);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReceived.aspx.cs", ex);
        }
    }



    protected decimal GetTotalCost(decimal tc)
    {
        TotalCostPrice += tc;
        return tc;
    }

    protected decimal GetGrandTotal()
    {
        return TotalCostPrice;
    }


    public void LoadStockReceivedItems(List<InventoryItemsBasket> lstIIB)
    {
        loadInventoryUOM(ddlSellingUnit, string.Empty);
        grdResult.DataSource = lstIIB;
        grdResult.DataBind();
        //lblGrandTotal.Text = String.Format("{0:0.00}",GetGrandTotal());
        //  txtGrandTotal.Text = lblGrandTotal.Text;

    }
    //bool istrue = false;
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string strDeleteProd = "N";
            string strExpDate = "";
            string strMftDate = "";
            decimal UnitCostprice;
            InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
            Label lblMFT = (Label)e.Row.FindControl("lblMFT");
            Label lblEXP = (Label)e.Row.FindControl("lblEXP");
            Label lblBatchNo = (Label)e.Row.FindControl("lblBatchNo");
            Label lblHSNCode = (Label)e.Row.FindControl("lblHSNCode");
            

            UnitCostprice = Convert.ToDecimal(inv.ActualAmount) > 0 ? Convert.ToDecimal(inv.UnitCostPrice) - Convert.ToDecimal(inv.ActualAmount) : Convert.ToDecimal(inv.UnitCostPrice);
            //DiscountAmt += (inv.Discount / 100) * (Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity);
            DiscountAmt += (inv.Discount + inv.SchemeDisc);
            txtTotaldiscountAmt.Text = Convert.ToString(DiscountAmt);
            txtTotaldiscountAmt.Text = (Decimal.Parse(txtTotaldiscountAmt.Text)).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            // TaxAmt = TaxAmt + (inv.Tax / 100) * ((Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity));
            if (hdnTaxcalcType.Value == "SP ")
            {
                if (inv.PurchaseTax > 0)
                {

                    TaxAmt = ((Convert.ToDecimal(inv.UnitSellingPrice * inv.RECQuantity * inv.PurchaseTax) / (100 + inv.PurchaseTax)));

                    if (hdnREQCalcCompQTY.Value == "Y")
                    {
                        compQTYTaxAmt = (Convert.ToDecimal((inv.UnitSellingPrice * inv.ComplimentQTY) * (inv.PurchaseTax / (inv.PurchaseTax + 100))));
                    }
                    else
                    {
                        compQTYTaxAmt = Convert.ToDecimal(0.00);
                    }
                }
                else
                {
                    TaxAmt = ((Convert.ToDecimal(inv.UnitSellingPrice * inv.RECQuantity * inv.Tax) / (100 + inv.Tax)));

                    if (hdnREQCalcCompQTY.Value == "Y")
                    {
                        compQTYTaxAmt = (Convert.ToDecimal((inv.UnitSellingPrice * inv.ComplimentQTY) * (inv.Tax / (inv.Tax + 100))));
                    }
                    else
                    {
                        compQTYTaxAmt = Convert.ToDecimal(0.00);
                    }
                }
            }
            else
            {
                if (inv.PurchaseTax > 0)
                {
                    TaxAmt = (inv.PurchaseTax / 100) * ((Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity) - ((inv.Discount / 100) * (Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity)));
                }
                else
                {
                    TaxAmt = inv.PurchaseTax;

                }
                //else Commented by prabhu for tax issue fix
                //{
                //    TaxAmt = (inv.Tax / 100) * ((Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity) - ((inv.Discount / 100) * (Convert.ToDecimal(inv.UnitCostPrice) * inv.RECQuantity)));
                //}

                if (hdnREQCalcCompQTY.Value == "Y")
                {
                    compQTYTaxAmt = (inv.PurchaseTax / 100) * ((Convert.ToDecimal(inv.UnitPrice) * inv.ComplimentQTY));
                }
                else
                {
                    compQTYTaxAmt = Convert.ToDecimal(0.00);
                }

            }

            TempTaxAmt = TempTaxAmt + Convert.ToDecimal(TaxAmt + compQTYTaxAmt);
            txtTotaltaxAmt.Text = Convert.ToString(TempTaxAmt);
            txtTotaltaxAmt.Text = (Decimal.Parse(txtTotaltaxAmt.Text)).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            if (inv.ExpiryDate.ToString("dd/MM/yyyy") == "01/01/1753" || inv.ExpiryDate.ToString("yyyy") == "9999" || inv.ExpiryDate.ToString("yyyy") == "1753" || inv.ExpiryDate.ToString("yyyy") == "0001")
            {
                lblEXP.Text = "**";
                strExpDate = "**";
            }
            else
            {
                strExpDate = inv.ExpiryDate.ToString("MMM/yyyy");
            }
            if (inv.Manufacture.ToString("dd/MM/yyyy") == "01/01/1753" || inv.Manufacture.ToString("yyyy") == "9999" || inv.Manufacture.ToString("yyyy") == "1753" || inv.Manufacture.ToString("yyyy") == "0001")
            {
                lblMFT.Text = "**";
                strMftDate = "**";
            }
            else
            {
                strMftDate = inv.Manufacture.ToString("MMM/yyyy");
            }

            if (inv.RECQuantity > 0)
            {
                strDeleteProd = "N";
            }
            else
            {
                strDeleteProd = hdnDeleteprod.Value;
            }

            string s = string.Empty;
            e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
            e.Row.Attributes.Add("onclick", "javascript:UpdateProductDetail('" +
                inv.ProductID.ToString() + "~" + 
                inv.ProductName.Replace("'", "").ToString() + "~" +
                inv.POQuantity.ToString() + "~" +
                inv.BatchNo.ToString() + "~" +
                strMftDate + "~" +
                strExpDate + "~" +
                inv.RECQuantity.ToString() + "~" +
                inv.ComplimentQTY.ToString() + "~" +
                inv.LSUnit.ToString() + "~" +
                inv.UnitPrice.ToString() + "~" +
                inv.Discount.ToString() + "~" +
                inv.Tax.ToString() + "~" +
                inv.TotalCost.ToString() + "~" +
                inv.SellingUnit.ToString() + "~" +
                inv.ID.ToString() + "~" +
                inv.POUnit + "~" +
                inv.RECUnit + "~" +
                inv.InvoiceQty + "~" +
                inv.RcvdLSUQty + "~" +
                inv.Rate + "~" +
                inv.Attributes + "~" +
                inv.AttributeDetail + "~" +
                inv.HasExpiryDate + "~" +
                inv.HasBatchNo + "~" +
                inv.UnitCostPrice + "~" +
                inv.UnitSellingPrice.ToString() + "~" +
                inv.HasUsage + "~" +
                inv.UsageCount.ToString() + "~" + 
                inv.RakNo + "~" + 
                inv.MRP + "~" + 
                inv.ActualAmount + "~" + 
                inv.PurchaseTax + "~" +
                inv.ReceivedUniqueNumber + '~' + 
                lblHSNCode.Text + '~' + 
                inv.SchemeType + '~' +
                inv.SchemeDisc + '~' +
                inv.DiscountType + '~' +
                strDeleteProd +
                "')");

            if (Request.QueryString["sType"] != null && Request.QueryString["sType"] == "Qui")
            {
                if (inv.InHandQuantity < (inv.RcvdLSUQty + inv.ComplimentQTY))
                {
                    //lblMsg.Text = "Some of the Product(s) already issued.So you can not add/edit the products.";
                    btnUpdate.Visible = false;
                    lnkAddMore.Visible = false;
                }
            }
            string HighlightCompQty = GetConfigValue("GunamCommon", OrgID);
            if (HighlightCompQty == "Y")
            {

                if (inv.RECQuantity == 0 && inv.ComplimentQTY > 0)
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;
                }
            }
            decimal GSTTax = decimal.Zero;
            //GSTTax = (((inv.UnitPrice - (inv.UnitPrice * inv.Discount / 100)) * inv.Tax / 100) * inv.RcvdLSUQty);
             GSTTax = (((inv.UnitPrice * inv.RcvdLSUQty) - (inv.Discount + inv.SchemeDisc)) * inv.Tax / 100) ;
            if (CheckState.Value == "Y")
            {
                e.Row.Cells[19].Text = String.Format("{0:0.00}", (inv.Tax / 2)); //16
                e.Row.Cells[20].Text = String.Format("{0:0.00}", (GSTTax / 2));  //17
                e.Row.Cells[21].Text = String.Format("{0:0.00}", (inv.Tax / 2)); //18 
                e.Row.Cells[22].Text = String.Format("{0:0.00}", (GSTTax / 2));  //19
                e.Row.Cells[23].Text = String.Format("{0:0.00}", (0.00));        //20
                e.Row.Cells[24].Text = String.Format("{0:0.00}", (0.00));        //21
                CGSTAmount += GSTTax / 2;
                SGSTAmount += GSTTax / 2;
                lbltotcgstamt.Text = String.Format("{0:0.00}", (CGSTAmount));
                lbltotsgstamt.Text = String.Format("{0:0.00}", (SGSTAmount));
            }
            else
            {
                e.Row.Cells[19].Text = String.Format("{0:0.00}", (0.00));
                e.Row.Cells[20].Text = String.Format("{0:0.00}", (0.00));
                e.Row.Cells[21].Text = String.Format("{0:0.00}", (0.00));
                e.Row.Cells[22].Text = String.Format("{0:0.00}", (0.00));
                e.Row.Cells[23].Text = String.Format("{0:0.00}", (inv.Tax));
                e.Row.Cells[24].Text = String.Format("{0:0.00}", (GSTTax));

                IGSTAmount += GSTTax;
                lbltotigstamt.Text = String.Format("{0:0.00}", (IGSTAmount));

            }
            decimal TotaltaxAmt = (Convert.ToDecimal(lbltotcgstamt.Text) + Convert.ToDecimal(lbltotsgstamt.Text) + Convert.ToDecimal(lbltotigstamt.Text));
            txtTotaltaxAmt.Text = TotaltaxAmt.ToString("0.00");
            #region commented
            //Label lblSellingprice = ((Label)e.Row.FindControl("lblSellingPrice"));

            //Label lblUnitPrice = (Label)e.Row.FindControl("lblUnitPrice");

            //if (hdnIsResdCalc.Value == "SUnit")
            //{

            //    lblSellingprice.Text = String.Format("{0:0.00}", (inv.Rate));

            //    lblUnitPrice.Text = String.Format("{0:0.00}", (((inv.Amount * 100) / (100 + inv.Tax)) + inv.Discount) / inv.RcvdLSUQty);

            //}
            //if (hdnIsResdCalc.Value == "PoUnit")
            //{
            //    lblSellingprice.Text = String.Format("{0:0.00}", (inv.Rate) * inv.InvoiceQty);
            //    lblUnitPrice.Text = String.Format("{0:0.00}", ((((inv.Amount * 100) / (100 + inv.Tax)) + inv.Discount) / inv.RcvdLSUQty) * inv.InvoiceQty);

            //}
            //if (hdnIsResdCalc.Value == "RPoUnit")
            //{
            //    lblSellingprice.Text = String.Format("{0:0.00}", (inv.Rate) * inv.RECQuantity);
            //    lblUnitPrice.Text = String.Format("{0:0.00}", ((((inv.Amount * 100) / (100 + inv.Tax)) + inv.Discount) / inv.RECQuantity) * inv.RECQuantity);

            //}
            //if (hdnIsResdCalc.Value == "RLsuSell")
            //{
            //    lblSellingprice.Text = String.Format("{0:0.00}", (inv.Rate) * inv.RcvdLSUQty);
            //    lblUnitPrice.Text = String.Format("{0:0.00}", (((((inv.Amount * 100) / (100 + inv.Tax)) + inv.Discount) / inv.RcvdLSUQty) * inv.RcvdLSUQty));
            //}




            //txtRecdQty.Attributes.Add("onBlur", "javascript:onGridViewRowSelected('" + txtPOQty.ClientID + "','" + lblPOQtyUnit.ClientID + "','" + lblRecdQtyUnit.ClientID + "','" + txtRecdQty.ClientID + "','" + txtCostPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblProdTotalCost.ClientID + "');");
            //txtRecdQty.Attributes.Add("onChange", "javascript:setRecQuantity('" + txtRecdQty.ClientID + "','" + txtPOQty.ClientID + "');");
            //txtCostPrice.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + txtPOQty.ClientID + "','" + lblPOQtyUnit.ClientID + "','" + lblRecdQtyUnit.ClientID + "','" + txtRecdQty.ClientID + "','" + txtCostPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblProdTotalCost.ClientID + "');");
            //txtDiscount.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + txtPOQty.ClientID + "','" + lblPOQtyUnit.ClientID + "','" + lblRecdQtyUnit.ClientID + "','" + txtRecdQty.ClientID + "','" + txtCostPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblProdTotalCost.ClientID + "');");
            //txtTax.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + txtPOQty.ClientID + "','" + lblPOQtyUnit.ClientID + "','" + lblRecdQtyUnit.ClientID + "','" + txtRecdQty.ClientID + "','" + txtCostPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblProdTotalCost.ClientID + "');");
            /////txtInvQty.Attributes.Add("onBlur", "javascript:calculateLSU('" + txtRecQty.ClientID + "','" + txtInvQty.ClientID + "','" + txtRecLSUQty.ClientID + "');");
            //txtMFT.Attributes.Add("onChange", "javascript:return ValidateDate('" + txtMFT.ClientID + "','" + txtEXP.ClientID + "');");
            //txtEXP.Attributes.Add("onChange", "javascript:return ValidateDate('" + txtMFT.ClientID + "','" + txtEXP.ClientID + "');");
            //txtSellingPrice.Attributes.Add("onChange", "javascript:CheckFields('" + txtSellingPrice.ClientID + "','" + txtCompQty.ClientID + "');");
            //txtCompQty.Attributes.Add("onChange", "javascript:CheckFields('" + txtSellingPrice.ClientID + "','" + txtCompQty.ClientID + "');");



            //DropDownList ddlSellingUnit = (DropDownList)e.Row.FindControl("ddlSellingUnit");
            //HiddenField hdnSellingUnit=(HiddenField)e.Row.FindControl("hdnSellingUnit");
            //HiddenField hdnRecQtyUnit=(HiddenField)e.Row.FindControl("hdnRecQtyUnit");
            //HiddenField hdnPOQty = (HiddenField)e.Row.FindControl("hdnPOQty");
            //HiddenField hdnPOQtyUnit = (HiddenField)e.Row.FindControl("hdnPOQtyUnit");


            //TextBox txtRecQty = (TextBox)e.Row.FindControl("txtRecQty");
            //TextBox txtUnitPrice = (TextBox)e.Row.FindControl("txtUnitPrice");
            //TextBox txtTax = (TextBox)e.Row.FindControl("txtTax");
            //TextBox txtDiscount = (TextBox)e.Row.FindControl("txtDiscount");
            //Label   lblTotalCost=(Label)e.Row.FindControl("lblTotalCost");
            //TextBox txtRecLSUQty = (TextBox)e.Row.FindControl("txtRecLSUQty");
            //TextBox txtInvQty = (TextBox)e.Row.FindControl("txtInvQty");
            //TextBox txtMFT = (TextBox)e.Row.FindControl("txtMFT");
            //TextBox txtEXP = (TextBox)e.Row.FindControl("txtEXP");
            //TextBox txtSellingPrice = (TextBox)e.Row.FindControl("txtSellingPrice");
            //TextBox txtCompQty = (TextBox)e.Row.FindControl("txtCompQty");
            //HiddenField hdnTotalCost = (HiddenField)e.Row.FindControl("hdnTotalCost");


            //txtRecQty.Attributes.Add("onBlur", "javascript:onGridViewRowSelected('" + hdnPOQty.ClientID + "','" + hdnPOQtyUnit.ClientID + "','" + hdnRecQtyUnit.ClientID + "','" + txtRecQty.ClientID + "','" + txtUnitPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblTotalCost.ClientID + "');");
            //txtRecQty.Attributes.Add("onChange", "javascript:setRecQuantity('" + txtRecQty.ClientID + "','" + hdnPOQty.ClientID + "');");
            //txtUnitPrice.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + hdnPOQty.ClientID + "','" + hdnPOQtyUnit.ClientID + "','" + hdnRecQtyUnit.ClientID + "','" + txtRecQty.ClientID + "','" + txtUnitPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblTotalCost.ClientID + "');");
            //txtDiscount.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + hdnPOQty.ClientID + "','" + hdnPOQtyUnit.ClientID + "','" + hdnRecQtyUnit.ClientID + "','" + txtRecQty.ClientID + "','" + txtUnitPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblTotalCost.ClientID + "');");
            //txtTax.Attributes.Add("onChange", "javascript:onGridViewRowSelected('" + hdnPOQty.ClientID + "','" + hdnPOQtyUnit.ClientID + "','" + hdnRecQtyUnit.ClientID + "','" + txtRecQty.ClientID + "','" + txtUnitPrice.ClientID + "','" + txtTax.ClientID + "','" + txtDiscount.ClientID + "','" + lblTotalCost.ClientID + "');");
            //txtInvQty.Attributes.Add("onBlur", "javascript:calculateLSU('" + txtRecQty.ClientID + "','" + txtInvQty.ClientID + "','" + txtRecLSUQty.ClientID + "');");
            //txtMFT.Attributes.Add("onChange", "javascript:return ValidateDate('" + txtMFT.ClientID + "','" + txtEXP.ClientID + "');");
            //txtEXP.Attributes.Add("onChange", "javascript:return ValidateDate('" + txtMFT.ClientID + "','" + txtEXP.ClientID + "');");
            //txtSellingPrice.Attributes.Add("onChange", "javascript:CheckFields('" + txtSellingPrice.ClientID + "','" + txtCompQty.ClientID + "');");
            //txtCompQty.Attributes.Add("onChange", "javascript:CheckFields('" + txtSellingPrice.ClientID + "','" + txtCompQty.ClientID + "');");
            #endregion
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //do something
        }
        /*if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[0].Attributes.Add("rowspan", "3");
            e.Row.Cells[1].Attributes.Add("rowspan", "3");
            e.Row.Cells[2].Attributes.Add("rowspan", "3");
            e.Row.Cells[3].Attributes.Add("rowspan", "3");
            e.Row.Cells[4].Attributes.Add("rowspan", "3");
            e.Row.Cells[5].Attributes.Add("rowspan", "3");
            e.Row.Cells[6].Attributes.Add("rowspan", "3");
            e.Row.Cells[7].Attributes.Add("rowspan", "3");
            e.Row.Cells[8].Attributes.Add("rowspan", "3");
            e.Row.Cells[9].Attributes.Add("rowspan", "3");
            e.Row.Cells[10].Attributes.Add("rowspan", "3");
            e.Row.Cells[11].Attributes.Add("rowspan", "3");
            e.Row.Cells[12].Attributes.Add("rowspan", "3");
            e.Row.Cells[13].Attributes.Add("rowspan", "3");
            e.Row.Cells[14].Attributes.Add("rowspan", "3");
            e.Row.Cells[15].Attributes.Add("rowspan", "3");

            e.Row.Cells[16].Attributes.Add("colspan", "6");

            e.Row.Cells[17].Attributes.Add("rowspan", "3");
            e.Row.Cells[18].Attributes.Add("rowspan", "3");
            e.Row.Cells[19].Attributes.Add("rowspan", "3");
            e.Row.Cells[20].Attributes.Add("rowspan", "3");
            e.Row.Cells[21].Attributes.Add("rowspan", "3");
            e.Row.Cells[22].Attributes.Add("rowspan", "3");
            e.Row.Cells[23].Attributes.Add("rowspan", "3");
            e.Row.Cells[24].Attributes.Add("rowspan", "3");
            e.Row.Cells[25].Attributes.Add("rowspan", "3");
            e.Row.Cells[26].Attributes.Add("rowspan", "3");

            GridView HeaderGrid = (GridView)sender;
            GridViewRow HeaderGridRow = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);
            TableCell HeaderCell = new TableCell();
            HeaderCell.Text = "CGST";
            HeaderCell.ColumnSpan = 2;
            HeaderGridRow.Cells.Add(HeaderCell);

            HeaderCell = new TableCell();
            HeaderCell.Text = "SGST";
            HeaderCell.ColumnSpan = 2;
            HeaderGridRow.Cells.Add(HeaderCell);
            HeaderCell = new TableCell();
            HeaderCell.Text = "IGST";
            HeaderCell.ColumnSpan = 2;
            HeaderGridRow.Cells.Add(HeaderCell);


            grdResult.Controls[0].Controls.AddAt(1, HeaderGridRow);

            GridView HeaderGrid1 = (GridView)sender;
            GridViewRow HeaderGridRow1 = new GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Insert);

            TableCell HeaderCell1 = new TableCell();
            HeaderCell1.Text = "%";
            HeaderGridRow1.Cells.Add(HeaderCell1);

            HeaderCell1 = new TableCell();
            HeaderCell1.Text = "Amt";
            HeaderGridRow1.Cells.Add(HeaderCell1);

            HeaderCell1 = new TableCell();
            HeaderCell1.Text = "%";
            HeaderGridRow1.Cells.Add(HeaderCell1);

            HeaderCell1 = new TableCell();
            HeaderCell1.Text = "Amt";
            HeaderGridRow1.Cells.Add(HeaderCell1);

            HeaderCell1 = new TableCell();
            HeaderCell1.Text = "%";
            HeaderGridRow1.Cells.Add(HeaderCell1);

            HeaderCell1 = new TableCell();
            HeaderCell1.Text = "Amt";
            HeaderGridRow1.Cells.Add(HeaderCell1);
            grdResult.Controls[0].Controls.AddAt(2, HeaderGridRow1);
        }*/
    }



    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }

    private void loadInventoryUOM(DropDownList ddlBoxU, string SelectedText)
    {
        try
        {
            List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
            if (lstInventoryUOM.Count == 0)
            {
                new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);
            }
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMID";
            ddlBoxU.DataBind();
            ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
            ddlBoxU.Items[0].Value = "0";
            if (SelectedText != "")
            {
                ddlBoxU.SelectedItem.Text = SelectedText;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Units.", ex);

        }
    }


    private List<InventoryItemsBasket> GetProductList()
    {
        //string[] strMfg ;
        //string[] strExp;

        List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();
        decimal totalSales = decimal.Zero;
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket item = new InventoryItemsBasket();

            Label lblProductName = (Label)row.FindControl("lblProductName");
            Label lblPOQuantity = (Label)row.FindControl("lblPOQuantity");
            HiddenField hdnProductId = (HiddenField)row.FindControl("hdnProductId");
            HiddenField ID = (HiddenField)row.FindControl("hdnRid");
            Label lblSellingPrice = (Label)row.FindControl("lblSellingPrice");
            Label lblUnitPrice = (Label)row.FindControl("lblUnitPrice");
            Label lblMFT = (Label)row.FindControl("lblMFT");
            Label lblEXP = (Label)row.FindControl("lblEXP");
            Label lblBatchNo = (Label)row.FindControl("lblBatchNo");
            Label lblRecQty = (Label)row.FindControl("lblRecQty");
            Label lblCompQty = (Label)row.FindControl("lblCompQty");
            Label lblSellingUnit = (Label)row.FindControl("lblSellingUnit");
            Label lblTax = (Label)row.FindControl("lblTax");
            Label lblHsncode = (Label)row.FindControl("lblHsncode");
            Label lblRakNo = (Label)row.FindControl("lblRakNo");
            Label lblMRP = (Label)row.FindControl("lblMRP");
            Label lblDiscount = (Label)row.FindControl("lblDiscount");
            Label lblTotalCost = (Label)row.FindControl("lblTotalCost");
            Label lblRecLSUQty = (Label)row.FindControl("lblRecLSUQty");
            Label lblInvQty = (Label)row.FindControl("lblInvQty");
            Label lblpurchasetax = (Label)row.FindControl("lblPurchaseTax");
            Label lblSchemeType = (Label)row.FindControl("lblSchemeType");
            Label lblSchemeDisc = (Label)row.FindControl("lblSchemeDisc");
            Label lblDiscountType = (Label)row.FindControl("lblDiscountType");

            HiddenField hdnRecQtyUnit = (HiddenField)row.FindControl("hdnRecQtyUnit");
            HiddenField hdnUnitPrice = (HiddenField)row.FindControl("hdnUnitPrice");
            HiddenField hdnRate = (HiddenField)row.FindControl("hdnRate");
            HiddenField hdnPOUnit = (HiddenField)row.FindControl("hdnPOUnit");
            HiddenField hdnIsResdCalc = (HiddenField)row.FindControl("hdnIsResdCalc");
            HiddenField hdnProductAttribute = (HiddenField)row.FindControl("hdnProductAttribute");
            HiddenField hdnProductAttributeDetail = (HiddenField)row.FindControl("hdnProductAttributeDetail");
            Label lblNominal = (Label)row.FindControl("lblNominal");
            HiddenField phdnPdtRcvdDtlsID = (HiddenField)row.FindControl("hdnPdtRcvdDtlsID");
            HiddenField hdnRcvdUniqueNo = (HiddenField)row.FindControl("hdnRcvdUniqNo");
            HiddenField hdnTotalCost = (HiddenField)row.FindControl("hdnTotalCost");

            //ScriptManager.RegisterStartupScript(this, this.GetType(), "calcostprice", "calculateCastPerUnit();", true);
            //calculateCastPerUnit(decimal.Parse(lblUnitPrice.Text), decimal.Parse(lblInvQty.Text), decimal.Parse(lblRecQty.Text), decimal.Parse(lblRecLSUQty.Text), decimal.Parse(lblNominal.Text));
            //CalcSellingPrice(decimal.Parse(lblSellingPrice.Text),decimal.Parse(lblInvQty.Text),decimal.Parse(lblRecQty.Text),decimal.Parse(lblRecLSUQty.Text));

            decimal TotalCost = decimal.Parse(String.Format("{0:0.00}", lblRecLSUQty.Text)) * decimal.Parse(String.Format("{0:0.000000}", hdnUnitPrice.Value));

            decimal Total = TotalCost; //TotalCost - (TotalCost * (decimal.Parse(String.Format("{0:0.000000}", lblDiscount.Text))) / 100);
            decimal txtAmt = decimal.Zero;//(Total * decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) / 100);
            totalSales += Total;// decimal.Parse(hdnTotalCost.Value);//totalSales += decimal.Parse(lblUnitPrice.Text) * decimal.Parse(lblRecLSUQty.Text);

            #region CompQtyTaxCalc
            //decimal CompQtyTaxamt = decimal.Zero;

            //if (hdnTaxcalcType.Value == "SP ")
            //{
            //    txtAmt = ((Convert.ToDecimal(decimal.Parse(String.Format("{0:0.00}", lblSellingPrice.Text)) * decimal.Parse(String.Format("{0:0.00}", lblRecQty.Text)) * decimal.Parse(String.Format("{0:0.00}", lblTax.Text))) / (100 + decimal.Parse(String.Format("{0:0.00}", lblTax.Text)))));
            //    if (hdnREQCalcCompQTY.Value == "Y")
            //    {


            //        CompQtyTaxamt = Convert.ToDecimal((decimal.Parse(String.Format("{0:0.00}", lblSellingPrice.Text))) * (decimal.Parse(String.Format("{0:0.00}", lblCompQty.Text)))) * (decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) / (decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) + 100));
            //    }
            //    else
            //    {
            //        compQTYTaxAmt = Convert.ToDecimal(0.00);
            //    }

            //}
            //else
            //{
            //    txtAmt = (decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) / 100) * ((Convert.ToDecimal(decimal.Parse(String.Format("{0:0.00}", lblUnitPrice.Text))) * decimal.Parse(String.Format("{0:0.00}", lblRecQty.Text))) - ((decimal.Parse(String.Format("{0:0.000000}", lblDiscount.Text)) / 100) * (Convert.ToDecimal(decimal.Parse(String.Format("{0:0.00}", lblUnitPrice.Text))) * decimal.Parse(String.Format("{0:0.00}", lblRecQty.Text)))));
            //    if (hdnREQCalcCompQTY.Value == "Y")
            //    {
            //        compQTYTaxAmt = (decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) / 100) * ((decimal.Parse(String.Format("{0:0.00}", hdnCostValue.Value)) * decimal.Parse(String.Format("{0:0.00}", lblCompQty.Text))));
            //    }
            //    else
            //    {
            //        compQTYTaxAmt = Convert.ToDecimal(0.00);
            //    }

            //}

            //TempTaxAmt = TempTaxAmt + Convert.ToDecimal(txtAmt + compQTYTaxAmt);
            // txtTotaltaxAmt.Text = Convert.ToString(TempTaxAmt);

            #endregion

            item.Amount = Convert.ToDecimal(decimal.Parse(String.Format("{0:0.00}", lblTotalCost.Text)));//decimal.Parse(String.Format("{0:0.000000}", lblTotalCost));
            item.ProductID = Int64.Parse(hdnProductId.Value);
            item.ProductName = lblProductName.Text;
            item.ID = Int64.Parse(ID.Value);
            item.BatchNo = lblBatchNo.Text;
            item.RakNo = lblRakNo.Text;
            item.PurchaseTax = Convert.ToDecimal(decimal.Parse(String.Format("{0:0.00}", lblpurchasetax.Text)));
            string strExpDate = "";
            string strMftDate = "";

            if (lblMFT.Text == "**")
            {
                strMftDate = "01/01/1753";
            }
            else
            {
                strMftDate = lblMFT.Text;
            }

            if (lblEXP.Text == "**")
            {
                strExpDate = "01/01/1753";
            }
            else
            {
                strExpDate = lblEXP.Text;
            }

            item.ExpiryDate = DateTime.Parse(strExpDate);
            item.Manufacture = DateTime.Parse(strMftDate);
            item.RECQuantity = decimal.Parse(lblRecQty.Text);
            item.RECUnit = hdnRecQtyUnit.Value;
            item.InvoiceQty = decimal.Parse(lblInvQty.Text);
            item.RcvdLSUQty = decimal.Parse(lblRecLSUQty.Text);
            item.SellingUnit = lblSellingUnit.Text;
            item.UnitPrice = decimal.Parse(hdnUnitPrice.Value);
            item.Rate = decimal.Parse(hdnRate.Value);
            item.ComplimentQTY = decimal.Parse(lblCompQty.Text);
            item.Tax = decimal.Parse(lblTax.Text);
            item.POQuantity = decimal.Parse(lblPOQuantity.Text);
            item.POUnit = hdnPOUnit.Value;
            item.TotalCost = decimal.Parse(lblTotalCost.Text);
            item.Attributes = hdnProductAttribute.Value;
            item.AttributeDetail = hdnProductAttributeDetail.Value;
            item.UnitCostPrice = decimal.Parse(lblUnitPrice.Text);//UnitCostPrice
            item.UnitSellingPrice = decimal.Parse(lblSellingPrice.Text);//UnitSellingPrice
            item.MRP = decimal.Parse(lblMRP.Text);
            item.Remarks = lblHsncode.Text;

            item.DiscountType = lblDiscountType.Text;
            item.Discount = decimal.Parse(lblDiscount.Text);
            item.SchemeType = lblSchemeType.Text;
            item.SchemeDisc = decimal.Parse(lblSchemeDisc.Text);

            //Nominal Discount calculation
            if (!string.IsNullOrEmpty(lblNominal.Text.Trim()))
            {
                item.ActualAmount = decimal.Parse(lblNominal.Text.Trim());//Nominal
            }
            string ProductKey = string.Empty;
            string CurrentCulture = string.Empty;
            CurrentCulture = CultureInfo.CurrentCulture.Name;
            //if (CurrentCulture != "en-GB")
            //{

            //    Attune_InventoryProductKey.GenerateProductKey(item.ProductID, item.BatchNo, item.ExpiryDate, item.UnitPrice, item.Rate, item.SellingUnit, CurrentCulture, out ProductKey);
            //    if (ProductKey != "")
            //    {
            //        item.ProductKey = ProductKey;
            //    }
            //}
            //else
            //{
            //    item.ProductKey = item.ProductID + "@#$" + item.BatchNo + "@#$" + item.ExpiryDate.ToString("MMM/yyyy")
            //                       + "@#$" + String.Format("{0:0.000000}", item.UnitPrice) + "@#$" + String.Format("{0:0.000000}", item.Rate) + "@#$" + item.SellingUnit;
            //}
            item.ProductReceivedDetailsID = Convert.ToInt64(phdnPdtRcvdDtlsID.Value);
            item.ReceivedUniqueNumber = Convert.ToInt64(hdnRcvdUniqueNo.Value);
            item.Type = lblRecLSUQty.Text == "0.00" ? "Y" : "N";
            lstInventory.Add(item);
        }
        txtTotalSales.Text = String.Format("{0:0.00}", totalSales);
        return lstInventory;
    }


    void calculateCastPerUnit(decimal CostPrice, decimal InverseQty, decimal RecdQty, decimal RecLusQty, decimal Nominal)
    {
        if (hdnIsResdCalc.Value == "SUnit")
        {
            hdnCostValue.Value = String.Format("{0:0.000000}", decimal.Round(CostPrice, 6));
        }
        if (hdnIsResdCalc.Value == "PoUnit")
        {
            //Nominal Discount calculation
            hdnCostValue.Value = Nominal > 0 ? String.Format("{0:0.000000}", (decimal.Round((CostPrice - Nominal) / InverseQty, 6))) : String.Format("{0:0.000000}", (decimal.Round(CostPrice / InverseQty, 6)));
            //hdnCostValue.Value = String.Format("{0:0.000000}", (decimal.Round(CostPrice/ InverseQty, 6)));
        }

        if (hdnIsResdCalc.Value == "RPoUnit")
        {

            decimal perUnit = decimal.Round(CostPrice / RecdQty, 6);
            hdnCostValue.Value = String.Format("{0:0.000000}", decimal.Round(perUnit / InverseQty, 6));
        }
        if (hdnIsResdCalc.Value == "RLsuSell")
        {

            decimal perUnitlsu = (CostPrice / RecLusQty);
            hdnCostValue.Value = String.Format("{0:0.000000}", decimal.Round(perUnitlsu, 6));
        }
    }

    void CalcSellingPrice(decimal Selling, decimal InverseQty, decimal RecdQty, decimal RecLusQty)
    {
        if (hdnIsResdCalc.Value == "SUnit")
        {
            hdnsellingValue.Value = String.Format("{0:0.000000}", decimal.Round(Selling, 6));
        }
        if (hdnIsResdCalc.Value == "PoUnit")
        {
            hdnsellingValue.Value = String.Format("{0:0.000000}", decimal.Round(Selling / InverseQty, 6));
        }

        if (hdnIsResdCalc.Value == "RPoUnit")
        {
            decimal perUnit = decimal.Round(Selling / RecdQty, 6);
            hdnsellingValue.Value = String.Format("{0:0.000000}", decimal.Round(perUnit / InverseQty, 6));
        }
        if (hdnIsResdCalc.Value == "RLsuSell")
        {
            decimal perUnitlsu = decimal.Round(Selling / RecLusQty, 6);
            hdnsellingValue.Value = String.Format("{0:0.000000}", perUnitlsu);
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        long srdID = 0;
        long taskID = -1;
        string strACN = string.Empty;
        if (Request.QueryString["ACN"] != null)
        {
            strACN = Request.QueryString["ACN"];
        }
        Int64.TryParse(Request.QueryString["ID"], out srdID);
        List<InventoryItemsBasket> lstInvUpdate = GetProductList();
        StockReceived objsrd = new StockReceived();
        objsrd.OrgAddressID = ILocationID;
        objsrd.StockReceivedID = srdID;
        objsrd.CreatedBy = LID;
        objsrd.OrgID = OrgID;
        objsrd.Status = StockOutFlowStatus.Approved;
        objsrd.ToLocationID = InventoryLocationID;
        objsrd.SupServiceTax = decimal.Parse(txtTotaltax.Text); //suppliertax
        objsrd.Tax = decimal.Parse(txtTotaltaxAmt.Text);
        objsrd.Discount = decimal.Parse(txtTotalDiscount.Text); //podiscount
        objsrd.GrandTotal = decimal.Parse(txtGrandTotal.Text);
        objsrd.RoundOfType = hdnRoundofType.Value;
        objsrd.RoundOfValue = decimal.Parse(txtRoundOffValue.Text);
        objsrd.StampFee = decimal.Parse(txtStampFee.Text);
        objsrd.DeliveryCharges = decimal.Parse(txtDeliveryCharges.Text);

        objsrd.TCSPercentage = hdnTcsTaxPer.Value == "" ? Convert.ToDecimal(0.00) : decimal.Parse(hdnTcsTaxPer.Value);
        objsrd.TCSValue = txtTCS.Text == "" || txtTCS.Text == null ? Convert.ToDecimal(0.00) : decimal.Parse(txtTCS.Text);

        InventoryCommon_BL stockReceivedBL = new InventoryCommon_BL(base.ContextInfo);
        returnCode = stockReceivedBL.UpdateStockReceived(lstInvUpdate, objsrd);
        if (returnCode == 0)
        {
            if (Request.QueryString["tid"] != null)
            {
                Int64.TryParse(Request.QueryString["tid"].ToString(), out taskID);
                if (taskID > 0)
                {
                    new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, UID, "CPD");
                    Response.Redirect("ViewStockReceived.aspx?ID=" + srdID + "&ACN=" + strACN + "&tid=" + taskID, true);
                }
            }
            else
            {
                Response.Redirect("ViewStockReceived.aspx?ID=" + srdID + "&ACN=" + strACN, true);
            }
        }
        else
        {

            btnUpdate.Attributes.Add("class", "show");
            btnCancelPO.Attributes.Add("class", "show");

        }

    }

    protected void grdResult_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            InventoryItemsBasket invItem = new InventoryItemsBasket();
            string[] listChild = hdnProductsList.Value.Split('~');

            invItem.ProductID = Int64.Parse(listChild[0]);
            invItem.ProductName = listChild[1];
            invItem.POQuantity = decimal.Parse(listChild[2]);
            invItem.BatchNo = listChild[3];
            if (listChild[4] == "**")
            {
                invItem.Manufacture = DateTime.Parse("01/01/1753");
            }
            else
            {
                invItem.Manufacture = DateTime.Parse(listChild[4]);
            }

            if (listChild[5] == "**")
            {
                invItem.ExpiryDate = DateTime.Parse("01/01/1753");
            }
            else
            {
                invItem.ExpiryDate = DateTime.Parse(listChild[5]);
            }
            invItem.RECQuantity = decimal.Parse(listChild[6]);
            invItem.ComplimentQTY = decimal.Parse(listChild[7]);
            invItem.UnitPrice = decimal.Parse(listChild[22]);
            invItem.Discount = decimal.Parse(listChild[10]);
            invItem.Tax = decimal.Parse(listChild[11]);
            invItem.Amount = decimal.Parse(listChild[12]);
            invItem.SellingUnit = listChild[13];
            invItem.ID = Int64.Parse(listChild[14]);
            invItem.POUnit = listChild[15];
            invItem.RECUnit = listChild[16];
            invItem.InvoiceQty = decimal.Parse(listChild[17]);
            invItem.RcvdLSUQty = decimal.Parse(listChild[18]);
            invItem.Rate = decimal.Parse(listChild[23]);
            invItem.Attributes = listChild[20];
            invItem.AttributeDetail = listChild[21];
            invItem.UnitCostPrice = decimal.Parse(listChild[9]);
            invItem.UnitSellingPrice = decimal.Parse(listChild[19]);
            invItem.RakNo = listChild[24];
            invItem.MRP = decimal.Parse(listChild[25]);
            invItem.ActualAmount = decimal.Parse(listChild[26]);
            invItem.TotalCost = decimal.Parse(listChild[12]);
            invItem.PurchaseTax = decimal.Parse(listChild[27]);
            invItem.ReceivedUniqueNumber = Int64.Parse(listChild[28]);
            invItem.Remarks = listChild[29];
            invItem.SchemeType = listChild[30];
            invItem.SchemeDisc = decimal.Parse(listChild[31]);
            invItem.DiscountType = listChild[32];
            invItem.Type = listChild[33]; // value of Delete Product (CheckBox)

            List<InventoryItemsBasket> lstInvItems = GetProductList();

            lstInvItems.Remove(lstInvItems.Find(P => P.ID == invItem.ID));
            lstInvItems.Add(invItem);
            
            grdResult.DataSource = lstInvItems;
            DataBind();
            hdnGrandPOTotal.Value = String.Format("{0:0.00}", GetGrandTotal());
            decimal totalSales = decimal.Zero;
            foreach (GridViewRow row in grdResult.Rows)
            {
                Label lblRecLSUQty = (Label)row.FindControl("lblRecLSUQty");
                Label lblTax = (Label)row.FindControl("lblTax");
                HiddenField hdnUnitPrice = (HiddenField)row.FindControl("hdnUnitPrice");
                Label lblDiscount = (Label)row.FindControl("lblDiscount");
                Label lblSchemeDisc = (Label)row.FindControl("lblSchemeDisc");
                decimal TotalCost = decimal.Parse(String.Format("{0:0.00}", lblRecLSUQty.Text)) * decimal.Parse(String.Format("{0:0.000000}", hdnUnitPrice.Value));
                decimal discount = decimal.Parse(String.Format("{0:0.000000}", lblDiscount.Text));
                decimal schemediscount = decimal.Parse(String.Format("{0:0.000000}", lblSchemeDisc.Text));
                decimal Total = TotalCost - (discount + schemediscount);
                decimal txtAmt = (Total * decimal.Parse(String.Format("{0:0.00}", lblTax.Text)) / 100);
                totalSales += TotalCost;
            }
            txtTotalSales.Text = String.Format("{0:0.00}", totalSales);
            //txtGrandTotal.Text = lblGrandTotal.Text;
            //lblGrandTotal.Text = hdnGrandPOTotal.Value;
            ACX2OPPmt.Attributes.Add("class", "hide");
            ACX2minusOPPmt.Attributes.Add("class", "show");
            ACX2responsesOPPmt.Attributes.Add("class", "displaytr");
            divProductEdit.Attributes.Add("class", "hide");
            ScriptManager.RegisterStartupScript(this, this.GetType(), "calGrandTotal", "checkAddToTotal()", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Adding Product Detail.", ex);

        }
    }

    protected void btnAttribute_Click(object sender, EventArgs e)
    {
        try
        {
            //hardcode
            INVAttributes1.BindProductAttributes(hdnAttributes.Value, hdnproductId.Value + "~" + (decimal.Parse(txtRecLSUQty.Text) + decimal.Parse(txtCompQty.Text)).ToString() + "~" + hdnAttributeDetail.Value + "~" + hdnUsageLimit.Value, "Update");
            ACX2OPPmt.Attributes.Add("class", "show");
            ACX2minusOPPmt.Attributes.Add("class", "hide");
            ACX2responsesOPPmt.Attributes.Add("class", "hide");
            divProductEdit.Attributes.Add("class", "show");
            if (hdnAttributes.Value != "N")
            {
                tdAttrip.Attributes.Add("class", "show");
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetAttr1ib", "UpdateProductDetail('" + hdnProductsList.Value + "')", true);
            }
            ReAssignValues();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Adding Product Attribute.", ex);

        }
    }

    protected void ReAssignValues()
    {

        string[] product = hdnProductsList.Value.Split('~');
        //showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0);
        divProductEdit.Attributes.Add("class", "show");
        hdnproductId.Value = product[0];
        txtProduct.Text = product[1];
        txtProduct.Enabled = false;
        txtPOQty.Text = product[2];
        txtPOQty.Enabled = false;
        txtBatchNo.Text = product[3];//
        txtMFT.Text = product[4];
        txtEXP.Text = product[5];
        txtRecdQty.Text = product[6];
        txtCompQty.Text = product[7];
        txtCostPrice.Text = String.Format("{0:0.00}", product[9]);
        txtDiscount.Text = product[10];
        txtTax.Text = product[11];

        txtProdTotalCost.Text = product[12];
        txtProdTotalCost.Enabled = false;
        hdnSellingUnit.Value = product[13];
        ddlSellingUnit.SelectedItem.Text = product[13];
        hdnRidItem.Value = product[14];
        txtPOQtyUnit.Text = product[15];
        txtPOQtyUnit.Enabled = false;
        txtRecdQtyUnit.Text = product[16];
        txtRecdQtyUnit.Enabled = false;
        txtInvQty.Text = product[17];
        txtRecLSUQty.Text = product[18]; //

        txtRecLSUQty.Enabled = false;
        txtSellingPrice.Text = String.Format("{0:0.00}", product[19]);
        // hdnAttributes .Value = product[20];
        // hdnAttributeDetail .Value = product[21];
        if (product[20] != "N")
        {
            tdAttrip.Attributes.Add("class", "show");
        }
        if (product[20] == "N")
        {
            tdAttrip.Attributes.Add("class", "hide");
        }
        ddlSchemetype.SelectedItem.Value = product[30];
        txtSchemeDisc.Text = product[31];
        ddlDisctype.SelectedItem.Value = product[32];
        hdnDeleteprod.Value = product[33];
    }

    protected static string GetDate(object dataItem)
    {
        if (dataItem.ToString() == "Jan-1753")
        {
            return "**";
        }
        return dataItem.ToString();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx?ACN=" + strACN, true);
            }
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
    protected void lnkAddMore_click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["sType"] != null && Request.QueryString["sType"] == "Qui")
            {
                if (Request.QueryString["ID"] != null)
                {
                    string strACN = Request.QueryString["ID"];
                    Response.Redirect(@"QuickStockReceived.aspx?sID=" + strACN, true);
                }
            }
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

    protected void btnCancelPO_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID = 0;
            if (Request.QueryString["ID"] != null)
            {

                orderID = Int64.Parse(Request.QueryString["ID"]);
            }
            string status = StockOutFlowStatus.Cancelled;
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.UpdateInventoryApproval("Cancelled", orderID, status, LID, OrgID, ILocationID);
            Response.Redirect("ViewStockReceived.aspx?ID=" + orderID, true);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in StockReceived.aspx", ex);

        }

    }
}

