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
using System.Text;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.QuickReceive.BL;
using Attune.Kernel.InventoryCommon;
using Attune.Kernel.PlatForm.Common;
using System.Web.Script.Serialization;

public partial class QuickStockReceived_QuickStockReceived : Attune_BasePage
{
    public QuickStockReceived_QuickStockReceived()
        : base("QuickStockReceived_QuickStockReceived_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
	string IsEditTaxRate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        chkIntax.Checked = true;
        try
        {
            long srdNo = 0;
            if (!IsPostBack)
            {
                 txtComments.Attributes.Add("maxlength", "250");
                
                string IsConsignConfig = string.Empty;
                IsConsignConfig = GetConfigValue("Is Consignment Product", OrgID);
                if (IsConsignConfig == "Y")
                {
                    trConsign.Attributes.Remove("class");
                    trConsign.Attributes.Add("class", "displaytr");
                    tdAddIsConsignment.Attributes.Remove("class");
                    tdAddIsConsignment.Attributes.Add("class", "displaytd");
                }
                hdnPageID.Value = Convert.ToString(PageID);
                hdnLoginLocationID.Value = Convert.ToString(InventoryLocationID);
                hdnOrgId.Value = Convert.ToString(OrgID);
                hdnLoginID.Value = Convert.ToString(LID);

                LoadUnit();
                LoadSuppliers();
                LoadUnits(ddlSelling);
                //LoadUnits(ddlRcvdUnit);
                  ListItem ddlselect = GetMetaData("Select", "0");
                  ddlRcvdUnit.Items.Insert(0, ddlselect);
                BindCategory();
                BindProductType();
                txtPODate.Text = DateTimeNow.ToExternalDate();
                //txtPODate.Focus();
                //CST TAx (Tamira Feature) Code Merging Start
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("CSTValue", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    hdnCSTValue.Value = lstInventoryConfig[0].ConfigValue;
                    lblCST.Text = "CST " + hdnCSTValue.Value + "%:";
                }
                //CST TAx (Tamira Feature) Code Merging End
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);
                LoadGetStockReceivedType();
                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
                }
                //IsNeed Calculation Of Complimentary Quantity Required 
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
                if(lstInventoryConfig.Count > 0)
                {
                    
                    hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
                }
                //IsNeed Complimentary Quantity Required withOut ReceivedQty
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyWithoutReceivedQty", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {

                    hdnCompQty.Value = lstInventoryConfig[0].ConfigValue;
                }

                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Selling_Price_Rule", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsSellingPriceRuleApply.Value = lstInventoryConfig[0].ConfigValue;
                }
                LoadSellingPriceRule();
                lblmsg.Text = "";
                if (Request.QueryString["sID"] != null && Request.QueryString["sID"] != "")
                {
                    Int64.TryParse(Request.QueryString["sID"], out srdNo);
                    LoadStockReceivedDetails(srdNo);
                }
                GetProductsAttributes();
                hdnLocationList.Value = InventoryLocationID.ToString() + "~" + DepartmentName + "~" + "0" + "~" + OrgID.ToString() + "~" + OrgName + "~" + "0" + "^";
            }
            hdnOrgId.Value = OrgID.ToString();
            txtOrgName.Text = OrgName;
            
            AutoOrgName.ContextKey = "Org~" + hdnOrgId.Value;
            AutoCompleteExtenderLocation.ContextKey = "Location~" + hdnOrgId.Value;

            string TAX_EDITABLE = GetConfigValue("TAX_EDITABLE", OrgID);
            if (!string.IsNullOrEmpty(TAX_EDITABLE))
            {
                if (TAX_EDITABLE == "Y")
                {
                    TxtProdTax.Attributes.Add("readonly", "readonly");
                }
            }
            //Dharanesh for Vasan Hide AddnewProducts Button//
            string IsmiddleEast = GetConfigValue("IsMiddleEast", OrgID);
            if (!string.IsNullOrEmpty(IsmiddleEast))
            {
                if (IsmiddleEast == "Y")
                {
                    btnAddNew.Attributes.Add("class", "hide");
                }
                else
                {
                    btnAddNew.Attributes.Add("class", "show");
                }
            }
            //Dharanesh for Vasan Hide AddnewProducts Button//
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
            hdnIsEditTax.Value = IsEditTaxRate;
            //TAX Column Hide
            string HideTax = GetConfigValue("IsMiddleEast", OrgID);
            hdnHideTax.Value = HideTax;
            if (HideTax=="Y")
            {
                Taxper.Attributes.Add("class", "hide");
                TaxProTaxCal.Attributes.Add("class", "hide");
                Td43.Attributes.Add("class", "hide");
                Td44.Attributes.Add("class", "hide");
                Td25.Attributes.Add("class", "hide");
                tdTaxAmt.Attributes.Add("class", "hide");
                tdTotalTax.Attributes.Add("class", "hide");
                //HideSupplierSerTax.Style.Add("display", "none");

                Td24.Attributes.Add("class", "hide");
                trTotalExcise.Attributes.Add("class", "hide");
                trCessEx.Attributes.Add("class", "hide");
                trHighteEdCes.Attributes.Add("class", "hide");
                trCST.Attributes.Add("class", "hide");
                trHideSupplierSerTax.Attributes.Add("class", "hide");
            }


            string hideStampFee = GetConfigValue("StampFeeDeliveryChargesApplicable", OrgID);
            if (hideStampFee == "Y")
            {

            }
            else
            {
                trStampFee.Attributes.Add("class", "hide");
                trDeliveryCharges.Attributes.Add("class", "hide");
            }



            //TAX Column Hide
            #region DC No changed as Ref. Inv No. for Vasan
            string IsMiddleEast = GetConfigValue("IsMiddleEast", OrgID);
            if (IsMiddleEast == "Y")
            {
                lblDCNumber1.Attributes.Add("class", "show");
                lblDCNumber.Attributes.Add("class", "hide");
                hdnDCNumber.Value = "Y";
            }
            else
            {
                lblDCNumber.Attributes.Add("class", "show");
                lblDCNumber1.Attributes.Add("class", "hide");
            }
            #endregion
            string MandFieldRemove = GetConfigValue("IsMandatoryFieldRequired", OrgID);
            if (MandFieldRemove == "Y")
            {
                hdnMandFieldDisable.Value = "N";
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Is Consignment Product", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                hdnisConsignmentStock.Value = lstInventoryConfig[0].ConfigValue;
            }
            //Hari's code starts
             string isVATReq = GetConfigValue("IsVATNotApplicable", OrgID);
            if (isVATReq.Trim() == "Y")
            {
                hdnIsVATNotApplicable.Value= "Y";
            }
            //Hari's code ends

            string SchemeDiscConfigValue = GetConfigValue("IsNeedSchemeDiscount", OrgID);
            hdnIsSchemeDiscount.Value = SchemeDiscConfigValue;
            if (SchemeDiscConfigValue == "N" || SchemeDiscConfigValue == "")
            {
                tdlblSchemetype.Attributes.Add("class", "hide");
                tdddlSchemetype.Attributes.Add("class", "hide");
                tdtxtSchemedisc.Attributes.Add("class", "hide");
                tdlblSchmedisc.Attributes.Add("class", "hide");
            }
			else
				txtTax.Attributes.Add("disabled", "true");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - ReceiveStock.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    private void GetDraftDtls()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();
        List<Drafts> DraftData = new List<Drafts>();
		hdnProductList.Value = "";
        if (ddlSupplier.SelectedValue != "" && Convert.ToInt32(ddlSupplier.SelectedValue) > 0)
        {
            objDraft.GetDraftDetails(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "QuickStockReceived", ddlSupplier.SelectedValue, out DraftData);
            if (DraftData != null && DraftData.Count > 0)
            {
                hdnProductList.Value = DraftData[0].Data;
            }
        }
    }
    public void LoadUnit()
    {
        List<InventoryUOM> invuom = new List<InventoryUOM>();

        InventoryCommon_BL invbl = new InventoryCommon_BL(base.ContextInfo);
        invbl.GetInventoryUOM(out invuom);
        bUnits.DataSource = invuom;
        bUnits.DataTextField = "UOMCode";
        bUnits.DataValueField = "UOMCode";
        bUnits.DataBind();
        bUnits.Items.Insert(0, GetMetaData("Select", "0"));
        bUnits.Items[0].Value = "0";
        bUnits.SelectedItem.Value = "0";



    }

    private void LoadStockReceivedDetails(long srdNo)
    {
        string str = "";
        List<Organization> lstOrganization = new List<Organization>();
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        List<StockReceived> lstStockReceived = new List<StockReceived>();
        lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        List<StockReceivedBarcodeMapping> lstBarCodeMapping = new List<StockReceivedBarcodeMapping>();
        inventoryBL.GetStockReceivedDetails(OrgID, ILocationID, srdNo, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket, out lstBarCodeMapping);
        if (lstInventoryItemsBasket.Count > 0)
        {


            txtPODate.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
            ddlSupplier.SelectedValue = lstStockReceived[0].SupplierID.ToString();
            txtComments.Text = lstStockReceived[0].Comments;
            ILocationID = lstStockReceived[0].OrgAddressID;
            txtInvoiceNo.Text = lstStockReceived[0].InvoiceNo;
            txtDCNumber.Text = lstStockReceived[0].DCNumber;
            //txtTotaltax.Text = lstStockReceived[0].Tax.ToString();
            //set Stock Received Type  
            txtTotalDiscount.Text = lstStockReceived[0].Discount.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            hdnGrandTotal.Value = lstStockReceived[0].GrandTotal.ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            txtRoundOffValue.Text  = (lstStockReceived[0].RoundOfValue).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            lblStampFee.Text  =   (lstStockReceived[0].StampFee).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            lblDeliveryCharges.Text  =   (lstStockReceived[0].DeliveryCharges).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);


            bool istrue = false;
            int i = 1;

            if (lstInventoryItemsBasket.Count > 0)
            {
                var temp = (from c in lstInventoryItemsBasket
                            select new TempQuick
                          {

                              ProductID = c.ProductID,
                              ProductName = c.ProductName,
                              BatchNo = c.BatchNo,
                              Manufacture = c.Manufacture.ToString("MM/yyyy") == "01/1753" ? "" : c.Manufacture.ToString("MM/yyyy"),
                              ExpiryDate = c.ExpiryDate.ToString("MM/yyyy") == "01/1753" ? "" : c.ExpiryDate.ToString("MM/yyyy"),
                              RECQuantity = c.RECQuantity,
                              RECUnit = c.RECUnit,
                              InvoiceQty = c.InvoiceQty,
                              SellingUnit = c.SellingUnit,
                              RcvdLSUQty = c.RcvdLSUQty,
                              ComplimentQTY = c.ComplimentQTY,
                              UnitPrice = decimal.Parse(c.Description),
                              SellingPrice = c.Quantity,
                              Discount = c.Discount,
                              Tax = c.Tax,
                              UnitCostPrice = c.UnitPrice,
                              UnitSellingPrice = c.Rate,
                              HasBatchNo = c.HasBatchNo,
                              HasExpiryDate = c.HasExpiryDate,
                              TotalCost = c.Amount,
                              TotalQty = c.RcvdLSUQty,
                              RakNo = c.RakNo,
                              MRP = c.MRP,
                              ID = c.ID,
                              Nominal = c.ActualAmount,
                              ExciseTax = c.ExciseTax,
                              ParentProductID = c.parentProductID,
                              PurchaseTax = c.PurchaseTax,
                              DiscountType = c.DiscountType,
                              SchemeType = c.SchemeType,
                              SchemeDisc = c.SchemeDisc

                          }).ToList();

                hdnProductList.Value = new JavaScriptSerializer().Serialize(temp);
            }
            /* foreach (InventoryItemsBasket item in lstInventoryItemsBasket)
             {
                 str += i + "~" + item.ProductID + "~" + item.ProductName.Replace("'", "") + "~" + item.BatchNo + "~" +
                                                                    item.Manufacture.ToString("MM/yyyy") + "~" +
                                                                    item.ExpiryDate.ToString("MM/yyyy") + "~" +
                                                                    item.RECQuantity + "~" +
                                                                    item.RECUnit + "~" +
                                                                    item.InvoiceQty + "~" +
                                                                    item.SellingUnit + "~" +
                                                                    item.RcvdLSUQty + "~" +
                                                                    item.ComplimentQTY + "~" +
                                                                    item.Description + "~" +
                                                                    item.Quantity + "~" +
                                                                    item.Discount + "~" +
                                                                    item.Tax + "~" +
                                                                    item.UnitPrice + "~" +
                                                                    item.Rate + "~" +
                                                                    item.HasBatchNo + "~" +
                                                                    item.HasExpiryDate + "~" +
                                                                    item.Amount + "~" +
                                                                    item.RcvdLSUQty + "~" +
                                                                    item.RakNo + "~" +
                                                                    item.MRP + "~" + item.ID + "~" +
                                                                    item.ExciseTax + "~" + item.parentProductID + "~"+item.PurchaseTax+ "^";
                 if (item.InHandQuantity < (item.RcvdLSUQty + item.ComplimentQTY))
                 {
                     string Message = Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_26;
                     if (Message == null)
                     {
                         Message = "Some of the Product(s) already issued.So you can not add/edit the products.";
                     }
                     lblmsg.Text =Message;
                     istrue = true;
                 }
                 i++;
             }
           
             hdnProductList.Value = str;  * */
            if (istrue)
            {
                btnFinish.Visible = false;
            }

            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product1", "javascript:Tblist();", true);

        }
    }

    private void BindProductType()
    {
        List<ProductType> lstProductType = new List<ProductType>();
        new InventoryCommon_BL(ContextInfo).GetProductType(OrgID, out lstProductType);
        ddlType.DataSource = lstProductType.FindAll(P => P.IsActive.ToUpper() == "YES").ToList();
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "TypeID";
        ddlType.DataBind();
        ddlType.Items.Insert(0, GetMetaData("Select", "0"));
        ddlType.Items[0].Value = "0";
    }

    private void LoadGetStockReceivedType()
    {
        long returnCode = -1;
        List<StockReceivedType> lstStockReceivedType = new List<StockReceivedType>();
        returnCode = new QuickReceive_BL(base.ContextInfo).GetStockReceivedType(out lstStockReceivedType);
        ddlStockReceivedType.DataSource = lstStockReceivedType.FindAll(p => p.IsDisplay == "Y").ToList();
        ddlStockReceivedType.DataTextField = "SrockReceivedTypeName";
        ddlStockReceivedType.DataValueField = "StrockReceivedTypeID";
        ddlStockReceivedType.DataBind();
        ddlStockReceivedType.SelectedValue = "1";

    }

    private void LoadSuppliers()
    {
        try
        {
            List<Suppliers> lstSupplier = new List<Suppliers>();
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSupplier);
            ddlSupplier.DataSource = lstSupplier;
            ddlSupplier.DataTextField = "SupplierName";
            ddlSupplier.DataValueField = "SupplierID";
            ddlSupplier.DataBind();
            ddlSupplier.Items.Insert(0, GetMetaData("Select", "0"));
            ddlSupplier.Items[0].Value = "0";
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
        }

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

    private void LoadUnits(DropDownList ddlBoxU)
    {
        try
        {
            List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();

            if (lstInventoryUOM.Count == 0)
            {
                new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);
            }
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMCode";
            ddlBoxU.DataBind();
            ddlBoxU.Items.Insert(0, ddlselect);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While loading Units.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long StockReceivedID = -1;
        string pPurchaseOrderNo = "";
        string SRDNo = string.Empty;
        long PoId = -1;
        try
        {
            long returnCode = -1;

            StockReceived objStockReceived = new StockReceived();
            objStockReceived.PurchaseOrderNo = string.Empty;
            objStockReceived.StockReceivedDate = txtPODate.Text.ToInternalDate();
            objStockReceived.SupplierID = Convert.ToInt32(ddlSupplier.SelectedValue);
            string Consigncheckbox = string.Empty;
            Consigncheckbox = ChkIsConsign.Checked == true ? "Y" : "N";
            if (Consigncheckbox == "Y")
            {
                objStockReceived.IsConsignment = "Y";
            }
            else
            {
                objStockReceived.IsConsignment = "N";
            }

            objStockReceived.Comments = txtComments.Text;
            objStockReceived.OrgID = OrgID;
            objStockReceived.OrgAddressID = ILocationID;
            objStockReceived.ToLocationID = InventoryLocationID;
            objStockReceived.FromLocationID = InventoryLocationID;
            objStockReceived.CreatedBy = LID;
            objStockReceived.InvoiceNo = txtInvoiceNo.Text.Trim();
            objStockReceived.DCNumber = txtDCNumber.Text.Trim();

            if (!string.IsNullOrEmpty(txtInvoiceDate.Text))
            {
                objStockReceived.InvoiceDate = txtInvoiceDate.Text.ToInternalDate();
            }
            else
            {
                objStockReceived.InvoiceDate = DateTime.MaxValue;
            }

           // objStockReceived.Tax = Convert.ToDecimal(txtTotaltax.Text);
            objStockReceived.Tax = Convert.ToDecimal(hdnTotalTax.Value);
            //set Stock Received Type  
            objStockReceived.StockReceivedTypeID = int.Parse(ddlStockReceivedType.SelectedValue) == (int)StockReceivedTypes.FromSupplier ? (int)StockReceivedTypes.QuickStockRecd : (int)StockReceivedTypes.FreeProduct;
            //objStockReceived.Discount = Convert.ToDecimal(txtTotalDiscount.Text);
            objStockReceived.Discount = Convert.ToDecimal(hdnTotalDiscount.Value);
            objStockReceived.GrandTotal = Convert.ToDecimal(hdnGrandTotal.Value);
            objStockReceived.UsedCreditAmount = Convert.ToDecimal(txtUseCreditAmount.Text);
            objStockReceived.Status = StockOutFlowStatus.Pending;
            if (chkExtax.Checked == true)
            {
                objStockReceived.NetCalcTax = "SP";
            }
            else
            {
                objStockReceived.NetCalcTax = "CP";
            }
            if (Convert.ToDecimal(txtCessOnExcise.Text) != 0)
            {
                objStockReceived.CessOnExciseTax = 2;
                objStockReceived.HighterEdCessTax = 2;
                objStockReceived.CSTax = 2;
            }
            objStockReceived.CessOnExciseTaxAmount = Convert.ToDecimal(txtCessOnExcise.Text);
            objStockReceived.HighterEdCessTaxAmount = Convert.ToDecimal(txtHighterEdCess.Text);
            objStockReceived.CSTAmount = Convert.ToDecimal(txtCST.Text);
            objStockReceived.ExciseTaxAmount = Convert.ToDecimal(txtTotalExcise.Text);
            objStockReceived.RoundOfType = hdnRoundofType.Value;
            objStockReceived.RoundOfValue = decimal.Parse(txtRoundOffValue.Text);
			objStockReceived.SupServiceTax = Convert.ToDecimal(txtTotaltax.Text);//Supplier Service Tax Percentage
            objStockReceived.PODiscountAmount = Convert.ToDecimal(txtTotalDiscount.Text);//PODiscountamount
            objStockReceived.SupServiceTaxAmount = Convert.ToDecimal(hdnsupplierServiceTaxAmount.Value);//Supplier Service Tax amount

            objStockReceived.StampFee = Convert.ToDecimal(txtStampFee.Text);
            objStockReceived.DeliveryCharges = Convert.ToDecimal(txtDeliveryCharges.Text);


            objStockReceived.PODiscountPer = 0;
            CLogger.LogInfo("STEP:1");

            string srAutoApprove = "N";
            lstInventoryItemsBasket = GetReceivedItems(" ");
             List<InventoryConfig> lstInventoryConfig = null;
             new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Receive_Approval", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig != null && lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "Y")
                    {
                        srAutoApprove = "Y";
                    }
                }

            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            ContextInfo.AdditionalInfo = ChkIsConsign.Checked == true ? "Y" : "N";
            #region Quickrec
            if (Request.QueryString["sID"] == null)
            {
                returnCode = new InventoryCommon_BL(base.ContextInfo).SaveQuickStockReceivedDetails(objStockReceived, lstInventoryItemsBasket, out StockReceivedID, out pPurchaseOrderNo, out SRDNo);
                RemoveDrafts();
              //  CLogger.LogInfo("STEP:2");
                if (ChkIsConsign.Checked == true)
                {
                     CreateApprovalTaskToAdmin(StockReceivedID, SRDNo);
                }
                /*else if(srAutoApprove == "Y")
                {
                    Response.Redirect(@"../StockReceived/UpdateStockReceived.aspx?ID=" + StockReceivedID, true);
                }*/
                if (returnCode == 0)
                {
                    //RemoveDrafts();
                    Response.Redirect(@"../StockReceived/ViewStockReceived.aspx?ID=" + StockReceivedID + "&ConsignmentStatus=" + (ChkIsConsign.Checked == true ? "Y" : "N"), true);
                }                             
            }
            #endregion
            if (Request.QueryString["sID"] != null && Request.QueryString["sID"] != "")
            {
                UpdateStockReceivedStatus(objStockReceived, out returnCode);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Received Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    private void UpdateStockReceivedStatus(StockReceived objStockReceived, out long returnCode)
    {
        objStockReceived.StockReceivedID = int.Parse(Request.QueryString["sID"]);
        lstInventoryItemsBasket = GetReceivedItems("App");
        returnCode = new QuickReceive_BL(base.ContextInfo).UpdateStockReceivedDetails(lstInventoryItemsBasket, objStockReceived);
    }
    private void RemoveDrafts()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();
        int locationid = Convert.ToInt32(hdnLoginLocationID.Value);
        int intpageID = Convert.ToInt32(hdnPageID.Value);
        string DraftValue = ddlSupplier.SelectedValue;
        objDraft.DeleteDraft(OrgID, locationid, intpageID, LID, "QuickStockReceived", DraftValue);

    }

    public List<InventoryItemsBasket> GetReceivedItems(string pType)
    {
        //BacthNo '*' is No Bacth
        //ExpiryDate '**' is No ExpiryDate
        //Manufacture '**' is No Manufacture
        List<InventoryItemsBasket> lstReceivedItemsBasket = new List<InventoryItemsBasket>();
        //string[] str = hdnProductList.Value.Trim().Split('^');
        //Array.Sort(str);

        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
            var ListTempQuick = new JavaScriptSerializer().Deserialize<List<TempQuick>>(hdnProductList.Value);
            lstReceivedItemsBasket = (from c in ListTempQuick
                                      select new InventoryItemsBasket
                        {

                            ProductID = c.ProductID,
                            ProductName = c.ProductName,
                            BatchNo = c.BatchNo,
                            Manufacture = string.IsNullOrEmpty(c.Manufacture) ? DateTime.Parse("01/01/1753") : DateTime.Parse(c.Manufacture),
                            ExpiryDate = string.IsNullOrEmpty(c.ExpiryDate) ? DateTime.Parse("01/01/1753") : DateTime.Parse(c.ExpiryDate),
                            RECQuantity = c.RECQuantity,
                            RECUnit = c.RECUnit,
                            InvoiceQty = c.InvoiceQty,
                            SellingUnit = c.SellingUnit,
                            RcvdLSUQty = c.RcvdLSUQty,
                            ComplimentQTY = c.ComplimentQTY,
                            Description = Convert.ToString(c.UnitPrice),
                            UnitCostPrice = c.UnitPrice,
                            UnitSellingPrice = c.SellingPrice,
                            Discount = c.Discount,
                            Tax = c.Tax,
                            UnitPrice = c.UnitCostPrice,
                            Rate = c.UnitSellingPrice,
                            HasBatchNo = c.HasBatchNo,
                            HasExpiryDate = c.HasExpiryDate,
                            Amount = c.TotalCost,
                            //TotalQty = c.RcvdLSUQty,
                            RakNo = c.RakNo,
                            MRP = c.MRP,
                            ID = c.ID,
                            ActualAmount = c.Nominal,
                            ExciseTax = c.ExciseTax,
                            parentProductID = c.ParentProductID,
                            PurchaseTax = c.PurchaseTax,
                            DiscountType=c.DiscountType,
                            SchemeType = c.SchemeType,
                            SchemeDisc = c.SchemeDisc

                        }).ToList();
        }
        /*foreach (string listParent in str)
        {
            if (listParent != null && listParent.Trim() != string.Empty)
            {
                InventoryItemsBasket newBasket = new InventoryItemsBasket();

                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[1].Trim() == "" ? "0" : listChild[1].Trim());
                newBasket.BatchNo = listChild[3].Trim();
                if (listChild[4].Trim() == "**")
                {
                    newBasket.Manufacture = DateTime.Parse("01/01/1753");
                }
                else
                {
                    newBasket.Manufacture = DateTime.Parse("01/" + listChild[4].Trim());
                }

                if (listChild[5].Trim() == "**")
                {
                    newBasket.ExpiryDate = DateTime.Parse("01/01/1753");
                }
                else
                {
                    newBasket.ExpiryDate = DateTime.Parse("01/" + listChild[5].Trim());
                }

                newBasket.RECQuantity = Convert.ToDecimal(listChild[6].Trim() == "" ? "0" : listChild[6].Trim());
                newBasket.RECUnit = listChild[7].Trim();

                if (listChild[11].Trim() != "")
                {
                    newBasket.ComplimentQTY = Convert.ToDecimal(listChild[11].Trim() == "" ? "0" : listChild[11].Trim());
                }

                newBasket.Description = listChild[12].Trim() == "" ? "0.00" : listChild[12].Trim();//costprice
                newBasket.UnitCostPrice = Convert.ToDecimal(listChild[12].Trim() == "" ? "0.00" : listChild[12].Trim());//UnitCostPrices

                if (listChild[14].Trim() != "")
                {
                    newBasket.Discount = Convert.ToDecimal(listChild[14].Trim() == "" ? "0" : listChild[14].Trim());
                }

                if (listChild[15].Trim() != "")
                {
                    newBasket.Tax = Convert.ToDecimal(listChild[15].Trim() == "" ? "0" : listChild[15].Trim());
                }

                newBasket.Amount = Convert.ToDecimal(listChild[20].Trim() == "" ? "0" : listChild[20].Trim());//total costprice
                //newBasket.Type = listChild[16].Trim();
                newBasket.Rate = Convert.ToDecimal(listChild[17].Trim() == "" ? "0" : listChild[17].Trim());//M.R.P
                newBasket.UnitSellingPrice = Convert.ToDecimal(listChild[13].Trim() == "" ? "0" : listChild[13].Trim());//UnitSellingPrice
                newBasket.SellingUnit = listChild[9].Trim();
                newBasket.InvoiceQty = Convert.ToDecimal(listChild[8].Trim() == "" ? "0" : listChild[8].Trim());
                newBasket.RcvdLSUQty = Convert.ToDecimal(listChild[10].Trim() == "" ? "0" : listChild[10].Trim());

                //Substuting UnitCostPrice and UnitSellingPrice at DB
                newBasket.UnitPrice = Convert.ToDecimal(listChild[16].Trim() == "" ? "0.00" : listChild[16].Trim());
                if (pType == "App")
                {
                    newBasket.Rate = Convert.ToDecimal(listChild[17].Trim() == "" ? "0" : listChild[17].Trim());
                    newBasket.ID = Convert.ToInt64(listChild[24].Trim() == "" ? "0" : listChild[24].Trim());
                }

                if (listChild[22].Trim() == "--")
                {
                    newBasket.RakNo = "";
                }
                else
                {
                    newBasket.RakNo = listChild[22].Trim();
                }
                if (listChild[25].Trim() == "")
                {
                    newBasket.ExciseTax = 0;
                }
                else
                {
                    newBasket.ExciseTax = Convert.ToDecimal(listChild[25].Trim() == "" ? "0" : listChild[25].Trim());
                }

                newBasket.MRP = Convert.ToDecimal(listChild[23].Trim() == "" ? "0" : listChild[23].Trim());
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
                    newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToExternalMonth()
                                    + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.SellingUnit;
                }
                newBasket.InHandQuantity = 0;
                newBasket.parentProductID = Convert.ToInt64(listChild[26].Trim() == "" ? "0" : listChild[26].Trim());
                newBasket.ParentProductKey = "";
                // Nominal Discount
                decimal Nominal = decimal.MinValue;
                if (!string.IsNullOrEmpty(listChild[27].Trim()))
                {
                    newBasket.ActualAmount = Convert.ToDecimal(listChild[27].Trim() == "" ? "0" : listChild[27].Trim());
                    Nominal = Convert.ToDecimal(listChild[27].Trim());
                }

                if (!string.IsNullOrEmpty(listChild[28].Trim()))
                {
                    newBasket.PurchaseTax = Convert.ToDecimal(listChild[28].Trim() == "" ? "0" : listChild[28].Trim());
                }
                lstReceivedItemsBasket.Add(newBasket);
            }
        }*/
        return lstReceivedItemsBasket;
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
    protected void btnNewProductFinish_Click(object sender, EventArgs e)
    {
        Products objProducts = new Products();
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        long returnCode = -1;
        try
        {

            List<ProductLocationMapping> lstProductsLocationMapping = new List<ProductLocationMapping>();
            ProductLocationMapping objProductsLocationMapping = new ProductLocationMapping();
            lstProductsLocationMapping = GetCollectedItems();

            if (lstProductsLocationMapping.Count == 0)
            {
                lstProductsLocationMapping = GetLocationCollectedItems();
            }
            objProducts.ProductName = txtnewProducts.Text.Trim();
            objProducts.CategoryID = Convert.ToInt32(ddlCategory.SelectedValue);

            objProducts.Attributes = "N";
            objProducts.HasAttributes = "N";
            objProducts.ReOrderLevel = Convert.ToInt64(0);
            objProducts.Description = txtDescription.Text;
            objProducts.OrgID = OrgID;
            objProducts.OrgAddressID = ILocationID;
            objProducts.CreatedBy = LID;
            objProducts.ProductID = Int64.Parse(hdnproId.Value);
            objProducts.TypeID = int.Parse(ddlType.SelectedValue);
            objProducts.LSU = bUnits.SelectedValue;
            if (chkIsScheduleHDrug.Checked == true)
            {
                objProducts.IsScheduleHDrug = "Y";
            }
            else
            {
                objProducts.IsScheduleHDrug = "N";
            }
            if (chkExpDate.Checked == true)
            {
                objProducts.HasExpiryDate = "Y";
            }
            else
            {
                objProducts.HasExpiryDate = "N";
            }
            if (chkBatchNo.Checked == true)
            {
                objProducts.HasBatchNo = "Y";
            }
            else
            {
                objProducts.HasBatchNo = "N";
            }
            if (TxtProdTax.Text.Length > 0)
            {
                objProducts.TaxPercent = Convert.ToDecimal(hdnGetTax.Value);
                //objProducts.TaxPercent = Convert.ToDecimal(TxtTax.Text);
            }
            else
            {
                objProducts.TaxPercent = Convert.ToDecimal("0.00"); ;
            }
            objProducts.HasUsage = "N";
            objProducts.MfgName = txtMfgName.Text.Trim();
            objProducts.MfgCode = txtMfgCode.Text.Trim();
            objProducts.IsDeleted = "N";
            objProducts.IsNorcotic = "N";
            objProducts.TransactionBlock = "N";
            if (txtGenericName.Text.Trim() != "")
            {
                objProducts.ReferenceID = Convert.ToInt16(hdnGenericID.Value);
            }
            else
            {
                objProducts.ReferenceID = 0;
            }
            objProducts.ReferenceType = txtGenericName.Text;
            objProducts.Make = txtMake.Text;
            objProducts.ProductCode = txtProductCode.Text;
            objProducts.IsConsign = chkAddIsConsignment.Checked == true ? "Y" : "N";
            List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
            lstProductsAttributesDetails = GetProductsAttributesDetails();
            List<ProductUOMMapping> lstProductUOM = new List<ProductUOMMapping>();

            returnCode = inventoryBL.SaveProducts(objProducts, InventoryLocationID, lstProductsLocationMapping, lstProductsAttributesDetails, lstInventoryItemsBasket, lstProductUOM);
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product", "javascript:Tblist();recallmonthpicker();", true);
            if (returnCode == 0)
            {
                txtDescription.Text = "";
                txtProductName.Text = "";
                // txtReOrderLevel.Text = "";
                ddlType.SelectedValue = "0";
                ddlCategory.SelectedValue = "0";
                ddlType.SelectedValue = "0";
                chkIsScheduleHDrug.Checked = false;
                chkBatchNo.Checked = false;
                chkExpDate.Checked = false;
                hdnproId.Value = "0";
                hdnStatus.Value = "";
                txtGenericName.Text = "";
                hdnGenericID.Value = "0";
                txtMake.Text = "";
                txtProductCode.Text = "";
                txtMfgCode.Text = "";
                txtMfgName.Text = "";
                txtDescription.Text = "";
                // hdnLocationList.Value = "";
            }
            else
            {
                string Message = Resources.QuickStockReceived_ClientDisplay.QuickStockReceived_QuickStockReceived_aspx_27;
                if (Message == null)
                {
                    Message = "Product Already exist";
                }
                lblnewmsg.Text =Message;
                divNewProduct.Attributes.Add("class", "show");
                divProduct.Attributes.Add("class", "hide");
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:SetDatePickterValue();recallpastdatepicker();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Products - Products.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void BindCategory()
    {
        List<ProductCategories> lstProductCategories = new List<ProductCategories>();
        inventoryBL.GetProductCategories(OrgID, ILocationID, out lstProductCategories);
        ddlCategory.DataSource = lstProductCategories;
        ddlCategory.DataTextField = "CategoryName";
        ddlCategory.DataValueField = "CategoryID";
        ddlCategory.DataBind();
        ddlCategory.Items.Insert(0, GetMetaData("Select", "0"));
        ddlCategory.Items[0].Value = "0";
    }


    protected void ddlSupplier_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int supplierID = -1;
            long returnCode = -1;
            string purchaseOrderNo = "0";
            supplierID = Convert.ToInt32(ddlSupplier.SelectedValue);
            //ErrorDisplay1.ShowError = false;
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            List<Suppliers> lstSuppliers = null;
            List<InventoryItemsBasket> lstTempSrd = null;
            List<SupplierCreditorDebitNote> lstSCDN = null;
            List<Suppliers> lstSuppliersDetails = null;
            List<Organization> lstSOrganizationAdd = null;

            hdnProductList.Value = "";
            returnCode = inventoryBL.GetStockReceivedPODetails(OrgID, ILocationID, InventoryLocationID, purchaseOrderNo, supplierID, out lstSuppliers, out lstInventoryItemsBasket, out lstTempSrd, out lstSCDN, out lstSuppliersDetails);
            if (returnCode == 0 && lstSCDN != null && lstSCDN.Count > 0)
            {
                if (lstSCDN.Count != 0)
                    hdnAvailableCreditAmount.Value = Convert.ToString(lstSCDN[0].CreditAmount - lstSCDN[0].UsedAmount);
                else
                    hdnAvailableCreditAmount.Value = "0.00";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "  Tblist();", true);

            }
            if (lstSuppliersDetails != null && lstSuppliersDetails.Count > 0)
            {
                Session.Add("StateCheck", "N");
                CheckState.Value = "N";
                long LStateID = StateID;

                if (hdnIsVATNotApplicable.Value != "Y")
                {
                    string NeedOrgLocationBasedGST = GetConfigValue("NeedOrgLocationBasedGST", OrgID);

                    if (NeedOrgLocationBasedGST == "Y")
                    {
                        Organization_BL objOrganization_BL = new Organization_BL();
                        objOrganization_BL.getOrganizationAddress(OrgID, ILocationID, out lstSOrganizationAdd);
                        LStateID = lstSOrganizationAdd[0].StateID;
                    }

                    if (LStateID == lstSuppliersDetails[0].StateId)
                    {
                        Session.Add("StateCheck", "Y");
                        CheckState.Value = "Y";
                    }
                }
            }

            /* if (lstTempSrd.Count > 0 && supplierID>0)
             {
                 int i = 1;
                 foreach(InventoryItemsBasket item in lstTempSrd)
                {
                     hdnProductList.Value +=i+"~"+  item.Remarks + "^";

                     i = i + 1;
                 }
             } * */

            GetDraftDtls();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:SetDatePickterValue();LoadDraf();recallpastdatepicker();", true);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Purchase Order Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    public List<ProductLocationMapping> GetCollectedItems()
    {

        List<ProductLocationMapping> lstProductLocationMapping = new List<ProductLocationMapping>();

        string[] Locations = hdnLocationList.Value.Trim().Split('^');
        Array.Sort(Locations);

        foreach (string listParent in Locations)
        {
            if (listParent != null && listParent.Trim() != string.Empty)
            {
                string[] listChild = listParent.Split('~');
                ProductLocationMapping objProductLocationMapping = new ProductLocationMapping();

                objProductLocationMapping.ProductID = Int64.Parse(hdnproId.Value);
                objProductLocationMapping.LocationID = Convert.ToInt32(listChild[0]);
                objProductLocationMapping.ReorderQuantity = Convert.ToInt32(listChild[2]);
                objProductLocationMapping.OrgId = Convert.ToInt32(listChild[3]);
                objProductLocationMapping.MaximumQuantity = Convert.ToInt32(listChild[5]);
                lstProductLocationMapping.Add(objProductLocationMapping);

            }

        }
        return lstProductLocationMapping;
    }

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

    public List<ProductLocationMapping> GetLocationCollectedItems()
    {

        List<ProductLocationMapping> lstProductLocationMapping = new List<ProductLocationMapping>();

        ProductLocationMapping objProductLocationMapping = new ProductLocationMapping();
        objProductLocationMapping.ProductID = 0;
        objProductLocationMapping.LocationID = Convert.ToInt32(InventoryLocationID);
        objProductLocationMapping.ReorderQuantity = 0;
        objProductLocationMapping.OrgId = Convert.ToInt32(OrgID);

        lstProductLocationMapping.Add(objProductLocationMapping);

        return lstProductLocationMapping;
    }


    public void GetProductsAttributes()
    {
        List<ProductsAttributesMaster> lstProductsAttributesMaster = new List<ProductsAttributesMaster>();
        inventoryBL.GetProductsAttributes(out lstProductsAttributesMaster);

        divProductAttributes.InnerHtml = string.Empty;
        StringBuilder sb = new StringBuilder();
        if (lstProductsAttributesMaster.Count > 0)
        {
            sb.Append(StockRow(lstProductsAttributesMaster));
        }

        divProductAttributes.InnerHtml = sb.ToString();
    }
    protected StringBuilder StockRow(List<ProductsAttributesMaster> lstProductsAttributesMaster)
    {
        StringBuilder sbHeadStart = new StringBuilder();
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        if (lstProductsAttributesMaster.Count > 0)
        {
            string getCategories = string.Empty;
            foreach (ProductsAttributesMaster childRow in lstProductsAttributesMaster)
            {
                switch (childRow.ControlName.ToLower())
                {
                    case "textbox":
                        getCategories = GetTextBox(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    case "checkbox":
                        getCategories = GetChktBox(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    case "dropdownlist":
                        getCategories = GetDropDownList(childRow.AttributeID.ToString(), childRow.AttributeName, childRow.DisplayText);
                        sbBody.Append(getCategories);
                        break;

                    default:
                        break;
                }
            }
        }
        sb.Append("<table id='tblSRRow' border='0' cellpadding='4' cellspacing='0'>");
        sb.Append(sbBody);
        sb.Append("</table>");

        return sb;
    }


    protected string GetTextBox(string ID, string AttributeName, string TXTValue)
    {
        return "<TR><td>" + TXTValue + "</td><td> <input style='width:150px;' type='text' id='" + AttributeName + '~' + ID + "'  /></td></TR>";
    }

    protected string GetChktBox(string ID, string AttributeName, string TXTValue)
    {
        return "<TR><td Colspan='2'><input style='width:50px;' type='checkbox' id='" + AttributeName + '~' + ID + "'  />" + TXTValue + "</td></TR>";
    }

    protected string GetDropDownList(string ID, string AttributeName, string TXTValue)
    {
        string strSelect = "";
        ListItem l= GetMetaData("select", "0");
        strSelect = l.Text.ToString();
        string strDDL = string.Empty;
        strDDL += "<TR><td>" + TXTValue + "</td><td> <select style='width:50px;' id='" + AttributeName + '~' + ID + "'>";
        strDDL += "<option value='0'>'" + strSelect + "'</option>";
        strDDL += "</select></td></TR>";
        return strDDL;
    }

    protected List<ProductsAttributesDetails> GetProductsAttributesDetails()
    {
        List<ProductsAttributesDetails> lstProductsAttributesDetails = new List<ProductsAttributesDetails>();
        if (!string.IsNullOrEmpty(hdnProductList.Value))
        {
            ProductsAttributesDetails objInventoryAttributesMaster = new ProductsAttributesDetails();
            string[] MainSplit = hdnProductAttributes.Value.Split('#');


            for (int j = 0; j < MainSplit.Length; j++)
            {
                if (!string.IsNullOrEmpty(MainSplit[j]))
                {
                    objInventoryAttributesMaster = new ProductsAttributesDetails();
                    string[] SubSplit = MainSplit[j].Split('~');
                    objInventoryAttributesMaster.AttributeID = Convert.ToInt32(SubSplit[1]);
                    objInventoryAttributesMaster.AttributesValue = SubSplit[2];
                    objInventoryAttributesMaster.AttributesKey = SubSplit[0];
                    lstProductsAttributesDetails.Add(objInventoryAttributesMaster);
                }
            }
        }
        return lstProductsAttributesDetails;
    } 
    protected void CreateApprovalTaskToAdmin(long StockReceivedID, string SRDNo)
    {
        long returnCode = -1;
        long outtaskID = -1;
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        string feeType = string.Empty;
        task = new Tasks();
        dText = new Hashtable();
        urlVal = new Hashtable();
        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.ConsignmentQuickStockReceiveApproval, StockReceivedID, SRDNo, out dText, out urlVal);
        task.TaskActionID = (int)TaskHelper.TaskAction.ConsignmentQuickStockReceiveApproval;
        task.DispTextFiller = dText;
        task.URLFiller = urlVal;
        task.PatientID = 0;
        task.OrgID = OrgID;
        task.LocationID = InventoryLocationID;
        task.PatientVisitID = StockReceivedID;
        ContextInfo.AdditionalInfo = null;
        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        task.CreatedBy = LID;
        returnCode = taskBL.CreateTask(task, out outtaskID);
    }
    public class TempQuick
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
        public decimal InvoiceQty
        {
            get;
            set;
        }
        public string SellingUnit
        {
            get;
            set;
        }
        public decimal RcvdLSUQty
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
        public decimal SellingPrice
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
        public long ID
        {
            get;
            set;
        }
        public decimal ExciseTax
        {
            get;
            set;
        }
        public long ParentProductID
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
        public decimal CGSTTax
        {
            get;
            set;
        }
        public decimal SGSTTax
        {
            get;
            set;
        }
        public decimal IGSTTax
        {
            get;
            set;
        }
        public string DiscountType
        {
            get;
            set;
        }
        public string SchemeType
        {
            get;
            set;
        }
        public decimal SchemeDisc
        {
            get;
            set;
        }

    }
}



