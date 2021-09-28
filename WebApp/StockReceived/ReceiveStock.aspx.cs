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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using AjaxControlToolkit;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.StockReceive.BL;
using Attune.Kernel.InventoryCommon;
using System.Web.Script.Serialization;

public partial class StockReceived_ReceiveStock : Attune_BasePage
{
    public StockReceived_ReceiveStock()
        : base("StockReceived_ReceiveStock_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<ProductCategories> lstProductCategories;
    string IsEditTaxRate = string.Empty;
    string hideTax;
    List<Organization> lstSOrganizationAdd = null;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule_ProductType", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsSellingPriceTypeRuleApply.Value = lstInventoryConfig[0].ConfigValue;

                    if (hdnIsSellingPriceTypeRuleApply.Value == "N")
                    {
                        txtTotaltax.Attributes.Add("onKeyDown", "return validatenumber(event);");
                        txtTotalDiscount.Attributes.Add("onKeyDown", "return validatenumber(event);");
                        txtUseCreditAmount.Attributes.Add("onKeyDown", "return validatenumber(event);");
                    }
                    else
                    {
                        txtTotaltax.Attributes.Add("readonly", "readonly");
                        txtTotaltax.Attributes.Add("onKeyDown", "return false");
                        txtTotalDiscount.Attributes.Add("readonly", "readonly");
                        txtTotalDiscount.Attributes.Add("onKeyDown", "return false");
                        txtUseCreditAmount.Attributes.Add("readonly", "readonly");
                        txtUseCreditAmount.Attributes.Add("onKeyDown", "return false");
                    }

                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("IsTaxPerc_Selling", OrgID, ILocationID, out lstInventoryConfig);

                    if (lstInventoryConfig.Count > 0)
                    {
                        hdnIsTaxPerc.Value = lstInventoryConfig[0].ConfigValue;
                    }
                    else
                    {
                        hdnIsTaxPerc.Value = "0";
                    }
                }
                else
                {
                    txtTotaltax.Attributes.Add("onKeyDown", "return validatenumber(event);");
                    txtTotalDiscount.Attributes.Add("onKeyDown", "return validatenumber(event);");
                }


                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("invMFDMandatoryRemove", OrgID, ILocationID, out lstInventoryConfig);
                hdnMFDMandatoryRemove.Value = lstInventoryConfig.Count > 0 ? lstInventoryConfig[0].ConfigValue : "N";
                lbtnAttribute.Attributes.Add("class", "hide");
                txtReceivedDate.Text =DateTimeNow.ToExternalDate();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Cla", "$('#txtReceivedDate').val('" + DateTimeUtility.GetServerDate().ToString("dd/MM/yyyy") + "')", true);
                //txtEXPDate.Attributes.Add("OnChange", "ExcedDate('" + txtEXPDate.ClientID.ToString() + "','',0,1);");
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                lstProductCategories = new List<ProductCategories>();
                inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
                hdnOrgId.Value = OrgID.ToString();
                hdnOrgLocId.Value = ILocationID.ToString();
                loadCategory();
                LoadPurchaseOrderedDetails();
                GetUnites();

               // ACX2OPPmt.Style.Add("display", "none");
               // ACX2minusOPPmt.Style.Add("display", "block");
               // ACX2responsesOPPmt.Style.Add("display", "table-row");
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("SupplierMand", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    hdnSuppliereMand.Value = lstInventoryConfig[0].ConfigValue;
                    if (hdnSuppliereMand.Value == "Y")
                    {
                        string Tax = Resources.StockReceived_ClientDisplay.StockReceived_ReceiveStock_aspx_02;
                        if (Tax == null)
                        {
                            Tax = "VAT(%)";
                        }
                        lblTax.Text = Tax;
                    }
                }
                //List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
                }

                //IsNeed Complimentary Quantity Required withOut ReceivedQty
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyWithoutReceivedQty", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {

                    hdnCompQty.Value = lstInventoryConfig[0].ConfigValue;
                }

                //Selling price Rule 
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsSellingPriceRuleApply.Value = lstInventoryConfig[0].ConfigValue;
                }
                LoadSellingPriceRule();

                if (lstInventoryItemsBasket.Count > 0)
                {
                    stockReceivedTab.Attributes.Add("class", "displaytb");
                }
                else
                {
                    stockReceivedTab.Attributes.Add("class", "hide");
                }


                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {

                    hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
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
            //config by sathish-start
            #region Hidetaxforvasan
            hideTax = GetConfigValue("IsMiddleEast", OrgID);
            hdnTax.Value = hideTax;
            if (hideTax == "Y")
            {
                if (RoleName == "Administrator")
                {
                    grdResult.Columns[4].Visible = true;
                }
                else
                {
                    grdResult.Columns[6].Visible = false;
                }
                txtTax.Attributes.Add("class", "hide");
                lblTax.Attributes.Add("class", "hide");
                lblTaxPercen.Attributes.Add("class", "hide");
                lblSupplierSerTax.Attributes.Add("class", "hide");
                tdlblPurchaseTax.Style.Add("class", "hide");
                tdPurchaseTax.Style.Add("class", "hide");
            }


            #endregion
            //config by sathish-end
            #region Change Label Name DC number as Inv Ref.No
            string IsMiddleEast = GetConfigValue("IsMiddleEast", OrgID);
            if (IsMiddleEast == "Y")
            {
                lblDCNumber1.Attributes.Add("class", "show");
                hdnDCNo.Value = "Y";
            }
            else
            {
                lblDCNumber.Attributes.Add("class", "show");
                hdnDCNo.Value="N";
            }
            #endregion

            string NeedTcsTax = GetConfigValue("IsNeedTcsTax", OrgID);
            if (NeedTcsTax == "Y")              
            {
                string TcsTaxPer = GetConfigValue("TCSTaxPercentage", OrgID);
                  hdnTcsTaxPer.Value=TcsTaxPer;
                  hdnNeedTcsTax.Value = NeedTcsTax;
 
            }

            // config stamp Fee & Delivery Charges 

            string hideStampFee = GetConfigValue("StampFeeDeliveryChargesApplicable", OrgID);
            if (hideStampFee == "Y")
            {

            }
            else
            {
                trStampFee.Attributes.Add("class", "hide");
                trDeliveryCharges.Attributes.Add("class", "hide");            
            }


            


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - ReceiveStock.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void GetUnites()
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
        ddlSelling.DataSource = lstInventoryUOM;
        ddlSelling.DataTextField = "UOMCode";
        ddlSelling.DataValueField = "UOMCode";
        ddlSelling.DataBind();
        ddlSelling.Items.Insert(0, GetMetaData("Select", "0"));
    }

    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType != DataControlRowType.Pager && e.Row.RowType != DataControlRowType.EmptyDataRow)
            {
                if (lstInventoryConfig.Count == 0)
                {
                    new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Stock_Receive_Action", OrgID, ILocationID, out lstInventoryConfig);
                }
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "N")
                    {
                        e.Row.Cells[6].Visible = false;
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryOrdersMaster IOM = (InventoryOrdersMaster)e.Row.DataItem;
                string strScript = "INVRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + IOM.OrderID + "','" + IOM.SupplierID + "','" + IOM.OrderNo + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.class='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                Button btn = (Button)e.Row.FindControl("btnReceivedPO");
                btn.CommandArgument = IOM.OrderID.ToString();
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading Purchase Order Details.", Ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";

        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            LoadPurchaseOrderedDetails();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
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
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../Admin/Home.aspx", true); }
        else
        {
            Response.Redirect("~/StockReceived/ReceiveStock.aspx");
        }
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Cla", "  fnClear();", true);
            try
            {
                grdResult.Visible = false;
                int supplierID = -1;
                long returnCode = -1;
                string purchaseOrderNo = poNoid.Value;
                supplierID = 0;
                //ErrorDisplay1.ShowError = false;
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                List<Suppliers> lstSuppliers =null;
                List<InventoryItemsBasket> lstTempSrd = null;
                List<SupplierCreditorDebitNote> lstSCDN = null;
                List<Suppliers> lstSuppliersDetails = null;
                hdnProductList.Value = "";
                hdnLanguageProductList.Value = "";
                returnCode = inventoryBL.GetStockReceivedPODetails(OrgID, ILocationID, InventoryLocationID, purchaseOrderNo, supplierID, out lstSuppliers, out lstInventoryItemsBasket, out lstTempSrd, out lstSCDN, out lstSuppliersDetails);
                if (returnCode == 0)
                {

                    if (lstInventoryItemsBasket!=null && lstInventoryItemsBasket.Count > 0)
                    {
                        AutoCompleteProduct.ContextKey = purchaseOrderNo;
                        //ACX2OPPmt.Style.Add("display", "block");
                       // ACX2minusOPPmt.Style.Add("display", "none");
                       // ACX2responsesOPPmt.Style.Add("display", "none");
                        tabRecd.Attributes.Add("class", "displaytb w-100p");

                        txtPurchaseOrderNo.Text = HdnPOno.Value;
                        txtPurchaseOrderNo.ReadOnly = true;
                        hdnProductList.Value = "";
                        if (lstSuppliers.Count != 0)
                        {

                            txtSupplierName.Text = lstSuppliers[0].SupplierName;
                            hdnSupplierID.Value = lstSuppliers[0].SupplierID.ToString();
                        }
                        else
                        {
                            if (SupID.Value == "-1")
                            {
                                txtSupplierName.Visible = false;
                                ddlSupplier.Visible = true;
                                divsup1.Attributes.Add("class", "show");
                                inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
                                ddlSupplier.DataSource = lstSuppliers;
                                ddlSupplier.DataTextField = "SupplierName";
                                ddlSupplier.DataValueField = "SupplierID";
                                ddlSupplier.DataBind();
                                ddlSupplier.Items.Insert(0, GetMetaData("Any", "0"));
                                ddlSupplier.Items[0].Value = "0";
                            }
                        }
                        if (lstSCDN!=null && lstSCDN.Count != 0)
                        {
                            hdnAvailableCreditAmount.Value = Convert.ToString(lstSCDN[0].CreditAmount - lstSCDN[0].UsedAmount);
                        }
                        stockReceivedTab.Attributes.Add("class", "displaytb");
                        hdnTotalPodetails.Value = "";
                        gvReceivedDetails.DataSource = lstInventoryItemsBasket;
                        gvReceivedDetails.DataBind();
                        gvReceivedDetails.Visible = true;
                        TableProductDetails.Attributes.Add("class", "displaytb searchPanel lh25");
                        if (lstTempSrd!=null && lstTempSrd.Count > 0)
                        {
                            foreach (InventoryItemsBasket item in lstTempSrd)
                            {
                                //hdnProductList.Value += item.Description + "^";
                                hdnLanguageProductList.Value += item.Description + "^";
                            }
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "languageconversion", "  conversionval();", true);
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "  Tblist();", true);
                        }

                    }
                    if (lstSuppliersDetails != null && lstSuppliersDetails.Count > 0)
                    {
                        hdnIsTCSSupplier.Value = lstSuppliersDetails[0].IsTCS;
                        long LStateID =StateID;
                        string NeedOrgLocationBasedGST = GetConfigValue("NeedOrgLocationBasedGST", OrgID);

                        if (NeedOrgLocationBasedGST == "Y")
                        {
                            Organization_BL objOrganization_BL = new Organization_BL();
                            objOrganization_BL.getOrganizationAddress(OrgID, ILocationID, out lstSOrganizationAdd);

                            LStateID = lstSOrganizationAdd[0].StateID;
                        }
              

                        if (LStateID == lstSuppliersDetails[0].StateId)
                        {
                            CheckState.Value = "Y";
                        }
                        else 
                        {
                            CheckState.Value = "N";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Loading Purchase Order Details.", ex);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        
    }

    protected void gvReceivedDetails_PageIndexChanging(Object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvReceivedDetails.PageIndex = e.NewPageIndex;
            btnGo_Click(sender, e);
        }
    }

    protected void gvReceivedDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
                Button btnAction = (Button)e.Row.FindControl("btnAction");
                if (inv.RECQuantity == inv.POQuantity)
                {
                    btnAction.Enabled = false;
                    btnAction.BackColor = System.Drawing.Color.Gray;
                    btnAction.Attributes.Add("class","field");
                    btnAction.ToolTip = "Already Received";
                }
                if (inv.Description == null || inv.Description == "")
                {
                    inv.Description = " | | |0|0|0|0|0|0|0| |0|";
                }

                /*  string str = inv.ProductID.ToString() + "~" +
                                     inv.ProductName + "~" +
                                     inv.CategoryID.ToString() + "~" +
                                     inv.POQuantity.ToString() + "~" +
                                     inv.Unit.ToString() + "~" +
                                     inv.RECQuantity.ToString() + "~" +
                                     inv.Attributes + "~" +
                                     inv.HasExpiryDate + "~" +
                                     inv.HasBatchNo + "~" +
                                     inv.Description + "~" +
                                     inv.HasUsage + "~" +
                                     inv.UsageCount.ToString() + '~' +
                                     inv.Discount + '~' + 
                                     inv.Tax + '~' +
                                     inv.PurchaseTax + "~" +
                                     inv.Amount + "~" +
                                     inv.LSUnit.ToString() + "#";
                
                 //  -\" Used to Avoid Jquery Function issue while productname having Appostrophies
                btnAction.Attributes.Add("onclick", "javascript:if(!AddProductDetails(\"" +
                                     inv.ProductID.ToString() + "~" +
                                     inv.ProductName + "~" +
                                     inv.CategoryID.ToString() + "~" +
                                     inv.POQuantity.ToString() + "~" +
                                     inv.Unit.ToString() + "~" +
                                     inv.RECQuantity.ToString() + "~" +
                                     inv.Attributes + "~" +
                                     inv.HasExpiryDate + "~" +
                                     inv.HasBatchNo + "~" +
                                     inv.Description + "~" +
                                     inv.HasUsage + "~" +
                                     inv.UsageCount.ToString() + '~' +
                                     inv.Discount + '~'+ 
                                     inv.Tax + '~' +
                                     inv.Amount + '~' + 
                                     inv.ComplimentQTY + '~' +
                                     inv.PurchaseTax + '~' +
                                     inv.LSUnit.ToString() +
                                     "\")) return false;"); */
                btnAction.Attributes.Add("onclick", "javascript:if(!AddProductDetails(\'"+new JavaScriptSerializer().Serialize(inv) + "\')) return false;");

            }
            if (hideTax=="Y")
            {
                gvReceivedDetails.Columns[4].Visible = false;
                gvReceivedDetails.Columns[5].Visible = false;    
            }
            else
            {
                gvReceivedDetails.Columns[4].Visible = true;
                gvReceivedDetails.Columns[5].Visible = true;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("", Ex);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long StockReceivedID = -1;
        try
        {
            long returnCode = -1;
            string poNO = txtPurchaseOrderNo.Text;
            StockReceived objStockReceived = new StockReceived();
            objStockReceived.PurchaseOrderNo = poNO;
            objStockReceived.StockReceivedDate = txtReceivedDate.Text.ToInternalDate();
            objStockReceived.SupplierID = Convert.ToInt32(hdnSupplierID.Value);
            objStockReceived.Comments = txtComments.Text.Trim();
            objStockReceived.OrgID = OrgID;
            objStockReceived.OrgAddressID = ILocationID;
            objStockReceived.ToLocationID = InventoryLocationID;
            objStockReceived.FromLocationID = InventoryLocationID;
            objStockReceived.CreatedBy = LID;
            objStockReceived.InvoiceNo = txtInvoiceNo.Text.Trim();
            objStockReceived.DCNumber = txtDCNumber.Text.Trim();
            objStockReceived.PurchaseOrderID = Convert.ToInt64(poNoid.Value);

           // objStockReceived.Tax = Convert.ToDecimal(txtTotaltax.Text);
            objStockReceived.Tax = Convert.ToDecimal(hdnTotalTax.Value);
            objStockReceived.StockReceivedTypeID = (int)StockReceivedTypes.FromSupplier;
           // objStockReceived.Discount = Convert.ToDecimal(txtTotalDiscount.Text);
            objStockReceived.Discount = Convert.ToDecimal(hdnTotalDiscount.Value);
            objStockReceived.GrandTotal = Convert.ToDecimal(hdnGrandTotal.Value);
            objStockReceived.Status = StockOutFlowStatus.Pending;
            objStockReceived.UsedCreditAmount = Convert.ToDecimal(txtUseCreditAmount.Text);
            objStockReceived.RoundOfValue = Convert.ToDecimal(txtRoundOffValue.Text);
            objStockReceived.RoundOfType = hdnRoundofType.Value;

            if (!string.IsNullOrEmpty(txtInvoiceDate.Text))
            {
                objStockReceived.InvoiceDate = txtInvoiceDate.Text.ToInternalDate();
            }
            else
            {
                objStockReceived.InvoiceDate = DateTime.MaxValue;
            }
			objStockReceived.SupServiceTax =Decimal.Parse(txtTotaltax.Text);//Supplier Service Tax Percentage
            objStockReceived.PODiscountAmount=Convert.ToDecimal(txtTotalDiscount.Text);//PODiscountamount
            objStockReceived.SupServiceTaxAmount = Convert.ToDecimal(hdnsupplierServiceTaxAmount.Value);//Supplier Service Tax amount
            objStockReceived.PODiscountPer = 0;
            objStockReceived.StampFee = Convert.ToDecimal(txtStampFee.Text);
            objStockReceived.DeliveryCharges = Convert.ToDecimal(txtDeliveryCharges.Text);
            objStockReceived.TCSValue = Convert.ToDecimal(txtTCSTax.Text);
            objStockReceived.TCSPercentage = Convert.ToDecimal(hdnTcsTaxPer.Value);

            // List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            lstInventoryItemsBasket = GetReceivedItems();
            //inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            StockReceived_BL stockBL = new StockReceived_BL(base.ContextInfo);
            returnCode = stockBL.SaveStockReceivedDetails(objStockReceived, lstInventoryItemsBasket, out StockReceivedID);
            if (StockReceivedID > 0)
            {
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Receive_Approval", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "Y")
                    {
                        Response.Redirect("UpdateStockReceived.aspx?ID=" + StockReceivedID, true);
                    }

                }
                Response.Redirect("ViewStockReceived.aspx?ID=" + StockReceivedID, true);
            }
            else
            {
                lblTableT.Text = hdnTempTable.Value;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Received Details.", ex);
        }
    }
    protected void tmrPostback_Tick(object sender, EventArgs e)
    {
        SaveTempStockReceived();
        if (hdnAttributes.Value == "N")
        {
            lbtnAttribute.Attributes.Add("class", "hide");
        }
    }

    private void SaveTempStockReceived()
    {
        try
        {
            lstInventoryItemsBasket = GetReceivedItems();
            if (lstInventoryItemsBasket.Count > 0)
            {
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                inventoryBL.SaveTempStockReceived(Int64.Parse(poNoid.Value), OrgID,
                           ILocationID, "Open", LID, lstInventoryItemsBasket, InventoryLocationID);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "Tblist();", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadRoundOffvalue", " Roundvalue();", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
    }

    # region USER FUNCTION

    public List<InventoryItemsBasket> GetReceivedItems()
    {
        //BacthNo '*' is No Bacth
        //ExpiryDate '**' is No ExpiryDate
        //Manufacture '**' is No Manufacture
        List<InventoryItemsBasket> lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
            var ListTempQuick = new JavaScriptSerializer().Deserialize<List<TempSR>>(hdnProductList.Value);
            lstReceivedItemsBasket = (from c in ListTempQuick
                                      select new InventoryItemsBasket
                                      {

                                          ProductID = c.ProductID,
                                          ProductName = c.ProductName,
                                          CategoryID=c.CategoryID,
                                          CategoryName = c.CategoryName,
                                          BatchNo = c.BatchNo,
                                          Manufacture = string.IsNullOrEmpty(c.Manufacture) ? DateTime.Parse("01/01/1753") : DateTime.Parse(c.Manufacture),
                                          ExpiryDate = string.IsNullOrEmpty(c.ExpiryDate) ? DateTime.Parse("01/01/1753") : DateTime.Parse(c.ExpiryDate),
                                          POQuantity=c.POQuantity,
                                          POUnit = c.POUnit,
                                          RECQuantity = c.RECQuantity,
                                          RECUnit = c.RECUnit,
                                          InvoiceQty = c.InvoiceQty,
                                          SellingUnit = c.SellingUnit,
                                          RcvdLSUQty = c.RcvdLSUQty,
                                          ComplimentQTY = c.ComplimentQTY,
                                          UnitPrice = c.UnitCostPrice,
                                          Amount = c.TotalCost,   
                                          Type=Convert.ToString(c.TotalQty),
                                          Discount = c.Discount,
                                          Tax = c.Tax,
                                          Rate = c.UnitSellingPrice,
                                          UnitCostPrice = c.UnitPrice,
                                          UnitSellingPrice = c.SellingPrice,                                         
                                          AttributeDetail=c.AttributeDetail,
                                          HasBatchNo = c.HasBatchNo,
                                          HasExpiryDate = c.HasExpiryDate,                                                                              
                                          RakNo = c.RakNo,
                                          MRP = c.MRP,                                        
                                          ActualAmount = c.Nominal,                                         
                                          PurchaseTax = c.PurchaseTax
                                      }).ToList();
        }
       /* foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[0]);
                newBasket.CategoryID = int.Parse(listChild[3]);
                newBasket.BatchNo = listChild[4];
                if (listChild[5] == "**")
                {
                    newBasket.Manufacture = DateTime.Parse("01/01/1753");
                }
                else
                {
                    newBasket.Manufacture = DateTime.Parse(listChild[5]);
                }

                if (listChild[6] == "**")
                {
                    newBasket.ExpiryDate = DateTime.Parse("01/01/1753");
                }
                else
                {
                    newBasket.ExpiryDate = DateTime.Parse(listChild[6]);
                }
                newBasket.POQuantity = Convert.ToDecimal(listChild[7]);
                newBasket.POUnit = listChild[8];
                newBasket.RECQuantity = Convert.ToDecimal(listChild[9]);
                newBasket.RECUnit = listChild[10];
                if (listChild[11] != "")
                {
                    newBasket.ComplimentQTY = Convert.ToDecimal(listChild[11]);
                }
                newBasket.UnitPrice = Convert.ToDecimal(listChild[21]);

                if (listChild[13] != "")
                {
                    newBasket.Discount = Convert.ToDecimal(listChild[13]);
                }
                if (listChild[14] != "")
                {
                    newBasket.Tax = Convert.ToDecimal(listChild[14]);
                }
                newBasket.Amount = Convert.ToDecimal(listChild[15]);
                newBasket.Type = listChild[16];
                newBasket.Rate = Convert.ToDecimal(listChild[22]);
                newBasket.SellingUnit = listChild[18];
                newBasket.InvoiceQty = Convert.ToDecimal(listChild[19]);
                newBasket.RcvdLSUQty = Convert.ToDecimal(listChild[20]);
                newBasket.AttributeDetail = listChild[24];
                //Substuting UnitCostPrice and UnitSellingPrice at DB
                newBasket.UnitCostPrice = Convert.ToDecimal(listChild[12]);
                newBasket.UnitSellingPrice = Convert.ToDecimal(listChild[17]);
                newBasket.RakNo = listChild[28];
                newBasket.MRP = Convert.ToDecimal(listChild[29]);
                string ProductKey = string.Empty;
                string CurrentCulture = string.Empty;
                CurrentCulture = CultureInfo.CurrentCulture.Name;
                if (CurrentCulture != "en-GB")
                {

                    Attune_InventoryProductKey.GenerateProductKey(newBasket.ProductID, newBasket.BatchNo, newBasket.ExpiryDate, newBasket.UnitPrice, newBasket.Rate, newBasket.SellingUnit, CurrentCulture, out ProductKey);
                    if (ProductKey != "")
                    {
                        newBasket.ProductKey = ProductKey;
                    }
                }
                else
                {
                    newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                                   + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.SellingUnit;
                }
                decimal Nominal = decimal.MinValue;
                if (!string.IsNullOrEmpty(listChild[30].Trim()))
                {
                    newBasket.ActualAmount = Convert.ToDecimal(listChild[30].Trim() == "" ? "0" : listChild[30].Trim());
                    Nominal = Convert.ToDecimal(listChild[30].Trim());
                }
                if (!string.IsNullOrEmpty(listChild[31].Trim()))
                {
                    newBasket.PurchaseTax = Convert.ToDecimal(listChild[31].Trim() == "" ? "0" : listChild[31].Trim());
                }
                lstReceivedItemsBasket.Add(newBasket);
            }
        } */
        return lstReceivedItemsBasket;
    }

    private void LoadPurchaseOrderedDetails()
    {
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        try
        {
            string pType = "N";
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("POs_Display_In_Child", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    pType = "Y";
                    hdnIsPODisplay.Value = "Y";
                }
            }

            long returnCode = -1;
            returnCode = new InventoryCommon_BL(base.ContextInfo).GetStockPurchaseOrderDetails(OrgID, ILocationID, pType, InventoryLocationID, out lstOrders);
            if (lstOrders.Count == 0)
            {
                btnGo.Visible = false;
            }
            grdResult.DataSource = lstOrders;
            grdResult.DataBind();
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While Loading Purchase Order Details.", Ex);
        }
    }

    public void loadCategory()
    {
        try
        {

            ddlCategory.DataSource = lstProductCategories;
            ddlCategory.DataTextField = "CategoryName";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, GetMetaData("Select", "0"));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Product Categories.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    # endregion

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        long returnCode = -1;
        long orderID = 0;
        if (e.CommandArgument != "0")
        {
            try
            {
                orderID = Int64.Parse(e.CommandArgument.ToString());
                string status = StockOutFlowStatus.Cancelled;
                inventoryBL = new InventoryCommon_BL(base.ContextInfo);
                returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID, ILocationID);
                LoadPurchaseOrderedDetails();
            }
            catch (System.Threading.ThreadAbortException tex)
            {
                string te = tex.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while Updating Approval details in ReceiveStock.aspx", ex);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }
    }

    protected void lbtnAttribute_Click(object sender, EventArgs e)
    {
        if (hdnAdd.Value == "Add")
        {
            INVAttributes1.BindProductAttributes(hdnAttributes.Value, hdnproductId.Value + "~" + (decimal.Parse(txtRcvdLSUQty.Text) + decimal.Parse(txtCompQuantity.Text)).ToString() + "~" + "N", hdnAdd.Value);
        }
        else if (hdnAdd.Value == "Update")
        {
            INVAttributes1.BindProductAttributes(hdnAttributes.Value, hdnproductId.Value + "~" + (decimal.Parse(txtRcvdLSUQty.Text) + decimal.Parse(txtCompQuantity.Text)).ToString() + "~" + hdnAttributeDetail.Value, hdnAdd.Value);
        }
    }

    //protected void add_Click(object sender, EventArgs e)
    //{


    //}

    protected void LoadSellingPriceRule()
    {
        long returnCode = -1;
        List<SellingPriceRuleMaster> lstSellingPriceRuleMaster = new List<SellingPriceRuleMaster>();
        List<SellingPriceRuleLocationMapping> lstSellingPriceRuleLocationMapping = new List<SellingPriceRuleLocationMapping>();
        returnCode = inventoryBL.getSellingPriceRuleMaster(OrgID, ILocationID, InventoryLocationID, out lstSellingPriceRuleMaster, out lstSellingPriceRuleLocationMapping);


        if (lstSellingPriceRuleMaster.Count > 0)
        {

            foreach (var Item in lstSellingPriceRuleMaster)
            {
                hdnSellingPrieRuleList.Value += Item.Description + "^";
            }

        }

    }
    public class TempSR
    {
        public long ProductID
        {
            get;
            set;
        }
        public string ProductName
        {
            get;
            set;
        }
        public int CategoryID
        {
            get;
            set;
        }
        public string CategoryName
        {
            get;
            set;
        }
        public string BatchNo
        {
            get;
            set;
        }
        public string Manufacture
        {
            get;
            set;
        }
        public string ExpiryDate
        {
            get;
            set;
        }
        public decimal POQuantity
        {
            get;
            set;
        }
        public string POUnit
        {
            get;
            set;
        }
        

        public decimal RECQuantity
        {
            get;
            set;
        }
        public string RECUnit
        {
            get;
            set;
        }
        public decimal ComplimentQTY
        {
            get;
            set;
        }
        public decimal UnitPrice
        {
            get;
            set;
        }
       
        public decimal Discount
        {
            get;
            set;
        }
        public decimal Tax
        {
            get;
            set;
        }
        public decimal TotalCost
        {
            get;
            set;
        }
        public decimal TotalQty
        {
            get;
            set;
        }
        public decimal SellingPrice
        {
            get;
            set;
        }
        public string SellingUnit
        {
            get;
            set;
        }
        public decimal InvoiceQty
        {
            get;
            set;
        }      
        public decimal RcvdLSUQty
        {
            get;
            set;
        }      
        public decimal UnitCostPrice
        {
            get;
            set;
        }
        public decimal UnitSellingPrice
        {
            get;
            set;
        }

        public string Attributes
        {
            get;
            set;
        }

        public string AttributeDetail
        {
            get;
            set;
        }

        public string HasBatchNo
        {
            get;
            set;
        }
        public string HasExpiryDate
        {
            get;
            set;
        }
      
        public string RakNo
        {
            get;
            set;
        }
        public decimal MRP
        {
            get;
            set;
        }
        public decimal Nominal
        {
            get;
            set;
        }
        public decimal PurchaseTax
        {
            get;
            set;
        }     
       
     
    }
}
