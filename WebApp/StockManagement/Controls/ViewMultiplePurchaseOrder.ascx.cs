
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Attune.Kernel.BusinessEntities;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.CentralPurchasing.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using System.Web.UI.WebControls;
using Attune.Kernel.PerformingNextAction;
public partial class StockManagement_Controls_ViewMultiplePurchaseOrder : Attune_BaseControl
{
    public StockManagement_Controls_ViewMultiplePurchaseOrder()
        : base("StockManagement_Controls_ViewMultiplePurchaseOrder_ascx")
    {
    }
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<PurchaseOrderMappingLocation> lstPurchaseOrderRaise = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMap = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMapToLoc = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstPOQuantityDetails = new List<PurchaseOrderMappingLocation>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
    CentralPurchasing_BL inventoryBL;
    long returnCode = -1;
    long poID = 0;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    string POBasedonQty = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void PrintDetails(long poID)
    {

        List<StockReceived> lstTaxType = new List<StockReceived>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();

        returnCode = new InventoryCommon_BL(base.ContextInfo).GetPurchaseOrderProductDetailsPrint(poID, OrgID, out lstOrganization, out lstSuppliers, out lstPurchaseOrders
            , out  lstPurchaseOrderRaise, out lstProductsMap, out lstQuotationMaster
            , out lstTaxType, out lstTaxmaster, out lstPOQuantityDetails);
        if (lstTaxType != null && lstTaxType.Count > 0)
        {
            SetTaxType(lstTaxType);
        }
        if (lstTaxmaster != null && lstTaxmaster.Count > 0)
        {
            JavaScriptSerializer objJSS = new JavaScriptSerializer();
            hdnGetTaxList.Value = objJSS.Serialize(lstTaxmaster);
        }
        if (lstOrganization.Count > 0)
        {
            string displayMS = Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_07;
            displayMS = displayMS == null ? "M/S" : displayMS;
            lblOrgName.Text = displayMS + "  " + lstOrganization[0].Name;
            lblstreet.Text = lstOrganization[0].Address; //+ "," + lstOrganization[0].City;
            lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
            lblStreetAddress.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            lblPhone.Text = lstOrganization[0].PhoneNumber;
            lblEmail.Text = lstOrganization[0].Email;
            lblHeaderorg.Text = lstOrganization[0].Name;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue != "")
                    tdlblOrgTIN.Attributes.Add("class", "displaytd");
                lblOrgTINNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue != "")
                    tdlblOrgDL.Attributes.Add("class", "displaytd");
                lblOrgDLNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            lblNotes.Text = lstSuppliers[0].Termsconditions;
            lblVendorName.Text = "M/S " + lstSuppliers[0].SupplierName;
            if (lstSuppliers[0].Address1 != "")
                lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
            lblVendorCity.Text = lstSuppliers[0].City;
            lblVendorPhone.Text = lstSuppliers[0].Phone;
            lblVendorEmail.Text = lstSuppliers[0].EmailID;
            if (lstSuppliers[0].SupplierCode != "")
            {
                tdsuppliervedorcode.Attributes.Add("class", "displaytd");
                lblVendorTINNo.Text = lstSuppliers[0].SupplierCode;
            }
            if (lstSuppliers[0].TinNo != "")
            {
                tdsupplierTinNo.Attributes.Add("class", "displaytd");
                lblsupplierTinno.Text = lstSuppliers[0].TinNo;
            }
            if (lstSuppliers[0].DrugLicenceNo != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo;
            }
            else if (lstSuppliers[0].DrugLicenceNo1 != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo1;
            }
            else if (lstSuppliers[0].DrugLicenceNo2 != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo2;
            }
            if (lstSuppliers[0].PanNo != "")
            {
                tdventorpanno.Attributes.Add("class", "displaytd");
                lblPanNotxt.Text = lstSuppliers[0].PanNo;
            }

            lblPODate.Text = lstPurchaseOrders[0].PurchaseOrderDate.ToExternalDateTime();
            lblPOID.Text = lstPurchaseOrders[0].PurchaseOrderNo.ToString();
            DivPurchaseOrder.ID = "DivPurchaseOrder" + lstPurchaseOrders[0].PurchaseOrderNo.ToString();

            var hdnfield = this.Page.FindControl("hdnPOIDS") as HiddenField;

            if (hdnfield != null)
            {
                hdnfield.Value = hdnfield.Value + "~" + lstPurchaseOrders[0].PurchaseOrderNo.ToString();

            }

            lblStatus.Text = lstPurchaseOrders[0].Status;
            if (!string.IsNullOrEmpty(lstPurchaseOrders[0].Status) && lstPurchaseOrders[0].Status.Equals("Approved")
                && !string.IsNullOrEmpty(lstPurchaseOrders[0].ReceivableLocation))
            {
                litApprovedBy.Text = lstPurchaseOrders[0].ReceivableLocation;
            }
            else
            {
                litApprovedBy.Text = string.Empty;
            }
            if (!string.IsNullOrEmpty(lstPurchaseOrders[0].Status) && lstPurchaseOrders[0].Status.Equals("Pending")
                && !string.IsNullOrEmpty(lstPurchaseOrders[0].LocationName))
            {
                litPrepared.Text = lstPurchaseOrders[0].LocationName;
            }
            else
            {
                litPrepared.Text = string.Empty;
            }

            if (lstQuotationMaster.Count > 0)
            {
                Quotationref.Attributes.Add("class", "displaytr");
                QuotationDate.Attributes.Add("class", "displaytr");
                lblQuotationNo.Text = lstQuotationMaster[0].QuotationNo;

                string displayToo = Resources.StockManagement_ClientDisplay.StockManagement_Controls_ViewMultiplePurchaseOrder_ascx_08; 
                displayToo = displayToo == null ? "To" : displayToo;
                lblVlaidDate.Text = lstQuotationMaster[0].ValidFrom.ToExternalDate() + " <strong>" + displayToo + "</strong> " + lstQuotationMaster[0].ValidTo.ToExternalDate();

            }

            if (lstPurchaseOrders[0].Comments == "")
            {
                tdcomments.Attributes.Add("class", "hide");
                lblComments.Text = "--";
            }
            else
            {
                lblComments.Text = lstPurchaseOrders[0].Comments;
            }
            if (lstPurchaseOrders[0].FreightCharges.ToString() == "" || lstPurchaseOrders[0].FreightCharges == null)
            {
                lblFreightCouriercharges.Text = "--";
            }
            else
            {
                lblFreightCouriercharges.Text = lstPurchaseOrders[0].FreightCharges.ToString();
            }

        }
        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;

        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        if (lstConfig.Count > 0)
        {
            imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
            if (lstConfig[0].ConfigValue.Trim() != "")
            {
                imgBillLogo.Attributes.Add("class", "show");
            }
            else
            {
                imgBillLogo.Attributes.Add("class", "hide");
            }
        }
        else
        {
            imgBillLogo.Attributes.Add("class", "hide");
        }


        //if (lstProductsMap.Count > 0 && lstPurchaseOrders[0].IsRate == true)
        if (lstProductsMap.Count > 0)
        {


            grdResult.DataSource = lstProductsMap;
            grdResult.DataBind();

            grdPOQuantityResult.Visible = true;
        }
        else
        {
            tdcalculation.Attributes.Add("class", "hide");
            if (lstPOQuantityDetails.Count > 0)
            {
                grdPOQuantityResult.Attributes.Add("class", "show");
                grdPOQuantityResult.DataSource = lstPOQuantityDetails;
                grdPOQuantityResult.DataBind();
            }
        }
        /// ----   Item level Discount Calculation-----------------
        decimal GetDiscount = Convert.ToDecimal(lblTotalDiscount.Text);
        decimal GetVat = Convert.ToDecimal(lblTotaltax.Text);
        decimal PoDiscount = 0;
        decimal PoDiscountAmount = 0;
        ///------------------End----------------------------

        if (lstPurchaseOrders.Count > 0)
        {
            PoDiscount = Convert.ToDecimal(lstPurchaseOrders[0].PoDiscount);
            PoDiscountAmount = (lstPurchaseOrders[0].GrossAmount * PoDiscount) / 100;
            lblGrossAmt.Text = lstPurchaseOrders[0].GrossAmount.ToString();
            lblPODisc.Text = lstPurchaseOrders[0].PoDiscount.ToString();
            lblTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) + PoDiscountAmount).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture); ;

            lblNetAmt.Text = (lstPurchaseOrders[0].NetAmount).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);


        }


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

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PurchaseOrderMappingLocation imm = (PurchaseOrderMappingLocation)e.Row.DataItem;
            string approval = string.Empty;

            decimal iDiscount = 0;
            decimal iTax = 0;
            decimal iGrassTotal = 0;
            decimal iNetTotal = 0;
            decimal iTempNetTotal = 0;

            iGrassTotal = (Convert.ToDecimal(imm.Rate) * imm.Quantity);
            iDiscount = iGrassTotal * imm.Discount / 100;
            iTempNetTotal = iGrassTotal - iDiscount;
            iTax = iTempNetTotal * imm.Vat / 100;
            iNetTotal = iTax + iTempNetTotal;

            DiscountAmt += iDiscount;
            lblTotalDiscount.Text = (DiscountAmt).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);

            TaxAmt = TaxAmt + iTax;
            lblTotaltax.Text = (TaxAmt).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
        }
    }


    protected void SetTaxType(List<StockReceived> lstTaxType)
    {
        if (!string.IsNullOrEmpty(lstTaxType[0].PackingSale.ToString()))
        {
            lbltxtPackingSale.Text = lstTaxType[0].PackingSale.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].ExciseDuty.ToString()))
        {
            lbltxtExciseDuty.Text = lstTaxType[0].ExciseDuty.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].EduCess.ToString()))
        {
            lbltxtEduCess.Text = lstTaxType[0].EduCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].SecCess.ToString()))
        {
            lbltxtSecCess.Text = lstTaxType[0].SecCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].CST.ToString()))
        {
            lbltxtCST.Text = lstTaxType[0].CST.ToString();
        }
    }

    protected void grdPOQuantityResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PurchaseOrderMappingLocation imm = (PurchaseOrderMappingLocation)e.Row.DataItem;
            string approval = string.Empty;

            decimal iDiscount = 0;
            decimal iTax = 0;
            decimal iGrassTotal = 0;
            decimal iNetTotal = 0;
            decimal iTempNetTotal = 0;

            iGrassTotal = (Convert.ToDecimal(imm.Rate) * imm.Quantity);
            iDiscount = iGrassTotal * imm.Discount / 100;
            iTempNetTotal = iGrassTotal - iDiscount;
            iTax = iTempNetTotal * imm.Vat / 100;
            iNetTotal = iTax + iTempNetTotal;

            DiscountAmt += iDiscount;
            lblTotalDiscount.Text = (DiscountAmt).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
            TaxAmt = TaxAmt + iTax;
            lblTotaltax.Text = (TaxAmt).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
        }
    }

}