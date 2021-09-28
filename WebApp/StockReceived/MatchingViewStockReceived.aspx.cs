using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.StockReceive.BL;

public partial class StockReceived_MatchingViewStockReceived : Attune_BasePage
{
    public StockReceived_MatchingViewStockReceived()
        : base("StockReceived_MatchingViewStockReceived_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockReceived> lstStockReceived = new List<StockReceived>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

    List<Users> lstUsers = new List<Users>();
    StockReceived_BL inventoryBL;
#region
    string strNote = Resources.StockReceived_ClientDisplay.StockReceived_MatchingViewStockReceived_aspx_01 == null ? "Note:" : Resources.StockReceived_ClientDisplay.StockReceived_MatchingViewStockReceived_aspx_01;
    string strAlertMsg = Resources.StockReceived_ClientDisplay.StockReceived_MatchingViewStockReceived_aspx_02 == null ? "No Matching Records Found!" : Resources.StockReceived_ClientDisplay.StockReceived_MatchingViewStockReceived_aspx_02;
#endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new StockReceived_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {
                hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
            }
            LoadDetails();
        }

    }
    public void LoadDetails()
    {
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
            inventoryBL.GetMatchingStockReceivedDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket);
            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {

                lblOrgName.Text = lstOrganization[0].Name;
                //InventoryCommon_BL InvBL = new InventoryCommon_BL();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    lblOrgTinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                }
                else
                {
                    lblOrgTinno.Text = "";
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    lblorgDlno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                }
                else
                {
                    lblorgDlno.Text = "";
                }
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
                }
                lblSRDate.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
                lblPOID.Text = lstStockReceived[0].PurchaseOrderNo;
                lblMatchingInvoiceNotxt.Text = lstInventoryItemsBasket[0].ProductKey;
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
                hdnApproveStockReceived.Value = lstStockReceived[0].StockReceivedID.ToString();
                lblReceivedID.Text = lstStockReceived[0].StockReceivedNo.ToString();
                lblTax.Text = String.Format("{0:0.00}", lstStockReceived[0].Tax);
                lblDiscount.Text = String.Format("{0:0.00}", lstStockReceived[0].Discount);
                lblFreightCharges.Text = String.Format("{0:0.00}", lstStockReceived[0].UsedCreditAmount);
                lblGrountTotal.Text = String.Format("{0:0.00}", lstStockReceived[0].GrandTotal);
                lblTotalExcise.Text = String.Format("{0:0.00}", lstStockReceived[0].ExciseTaxAmount);
                lblCessOnExcise.Text = String.Format("{0:0.00}", lstStockReceived[0].CessOnExciseTax);
                lblCST.Text = String.Format("{0:0.00}", lstStockReceived[0].CSTAmount);
                lblHighterEdCess.Text = String.Format("{0:0.00}", lstStockReceived[0].HighterEdCessTaxAmount);
                lblRoundOffValue.Text = string.Format("{0:0.00}", lstStockReceived[0].RoundOfValue);
                lblGrandwithRoundof.Text = string.Format("{0:0.00}", lstStockReceived[0].GrandTotal + lstStockReceived[0].UsedCreditAmount);
                
                if (lstStockReceived[0].Comments != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + strNote + lstStockReceived[0].Comments;
                }
                if (lstStockReceived[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Attributes.Add("class", "show");
                  //  approvedDateTD.InnerText = lstStockReceived[0].ApprovedAt.ToShortDateString();
                }
                hdnStatus.Value = lstStockReceived[0].Status;
                lblStatus.Text = lstStockReceived[0].Status;
                if (lstStockReceived[0].ApprovedBy != 0)
                {
                    returnCode = new GateWay(base.ContextInfo).GetUserDetail(lstStockReceived[0].ApprovedBy, out lstUsers);
                   // approvedByTD.Style.Add("display", "block");
                   // approvedByTD.InnerText = lstUsers[0].Name;
                }
                if (hdnStatus.Value == StockOutFlowStatus.Approved && approval == "1")
                {
                    approvalTR.Attributes.Add("class", "show");
                    //trApproveBlock.Style.Add("display", "block");
                }

                LoadStockReceivedItems(lstInventoryItemsBasket);
            }
            else
            {
                lblMessage.Text = strAlertMsg;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReceived.aspx.cs", ex);
        }
    }
    //protected void btnApprove_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        long orderID = Convert.ToInt64(hdnApproveStockReceived.Value);
    //        string status = StockOutFlowStatus.Approved;
    //        lstInventoryItemsBasket = GetReceivedItems();
    //        returnCode = inventoryBL.UpdateReceivedInventoryApproval("StockReceive", lstInventoryItemsBasket, orderID, status, LID, OrgID, ILocationID);
    //        if (returnCode == 0)
    //        {
    //            LoadDetails();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Updating Approval details in ViewStockReceived.aspx", ex);
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
    //    }
    //}

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

    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket imm = (InventoryItemsBasket)e.Row.DataItem;
            string approval = string.Empty;
            lblTotalSales.Text = (Decimal.Parse(lblTotalSales.Text) + (imm.RECQuantity * Decimal.Parse(imm.Unit))).ToString();
            lblTotalSales.Text = String.Format("{0:0.00}", Decimal.Parse(lblTotalSales.Text));
            DiscountAmt += (imm.Discount / 100) * (Convert.ToDecimal(imm.Unit) * imm.RECQuantity);
            lblTotalDiscount.Text = Convert.ToString(DiscountAmt);
            lblTotalDiscount.Text = string.Format("{0:0.00}", Decimal.Parse(lblTotalDiscount.Text));
            TaxAmt = TaxAmt + (imm.Tax / 100) * ((Convert.ToDecimal(imm.Description) * imm.RECQuantity) - (imm.Discount / 100) * (Convert.ToDecimal(imm.Unit) * imm.RECQuantity));
            lblTotaltax.Text = Convert.ToString(TaxAmt);
            lblTotaltax.Text = string.Format("{0:0.00}", Decimal.Parse(lblTotaltax.Text));
        }
    }


    protected static string GetDate(object dataItem)
    {
        if (dataItem.ToString() == "Jan-1753")
            return "**";

        return dataItem.ToString();
    }
    //protected void btnBack_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (Request.QueryString["ACN"] != null)
    //        {
    //            string strACN = Request.QueryString["ACN"];
    //            Response.Redirect(@"InventorySearch.aspx?ACN=" + strACN, true);
    //        }
    //        Response.Redirect("InventorySearch.aspx");

    //    }
    //    catch (System.Threading.ThreadAbortException tex)
    //    {
    //        string te = tex.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
    //    }
    //}
}
