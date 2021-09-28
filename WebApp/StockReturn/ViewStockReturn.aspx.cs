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
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Common;

public partial class StockReturn_ViewStockReturn : Attune_BasePage
{
    
    public StockReturn_ViewStockReturn()
        : base("StockReturn_ViewStockReturn_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockOutFlow> lstStockOutFlow = new List<StockOutFlow>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    List<Users> lstUsers = new List<Users>();
    List<StockReturnDetails> lstStockReturnDetails = new List<StockReturnDetails>();
    long pSRNO = -1;
    string CommandName = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        pSRNO = Convert.ToInt64(Request.QueryString["ID"]);
        hdnNoGSTforExpiredProducts.Value = GetConfigValue("NoGSTforExpiredProducts", OrgID);
        if (hdnNoGSTforExpiredProducts.Value == "")
            hdnNoGSTforExpiredProducts.Value = "N";

        hdnIsSchemeDisc.Value = GetConfigValue("IsNeedSchemeDiscount", OrgID);
        if (hdnIsSchemeDisc.Value == "" || hdnIsSchemeDisc.Value == "N")
        { 
            hdnIsSchemeDisc.Value = "N"; 
        }

        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("IsCostPriceForQtyAndCompQty", OrgID, ILocationID, out lstInventoryConfig);

        hdnIsCostPriceChange.Value = "N";
        if (lstInventoryConfig.Count > 0)
        {
            hdnIsCostPriceChange.Value = String.IsNullOrEmpty(lstInventoryConfig[0].ConfigValue) == true ? "N" : lstInventoryConfig[0].ConfigValue;
        }
        

        if (!IsPostBack)
        {
            btnApprove.Enabled = false;
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            LoadDetails();
        }

    }
    public void LoadDetails()
    {

        string approval = string.Empty;
        string pageName = string.Empty;

        approval = Request.QueryString["Approve"];
        pageName = Request.QueryString["PageName"];
        lblTo.Visible = false;
        string sUnApproved = Resources.StockReturn_ClientDisplay.StockReturn_ViewStockReturn_aspx_01;
        if (sUnApproved == null)
        {
            sUnApproved = "UnApproved";
        }

        string sApproved = Resources.StockReturn_ClientDisplay.StockReturn_ViewStockReturn_aspx_02;
        if (sApproved == null)
        {
            sApproved = "Approved";
        }

        string sPending = Resources.StockReturn_ClientDisplay.StockReturn_ViewStockReturn_aspx_03;
        if (sPending == null)
        {
            sPending = "Pending";
        }

        string sCancelled = string.Empty;
        if (sCancelled == null)
        {
            sCancelled = "Cancelled";
        }

        try
        {
            // inventoryBL.GetStockReturnDetails(OrgID, pSRNO, out lstOrganization, out lstSuppliers, out lstStockReturn, out lstProductCategories, out lstInventoryItemsBasket);
            inventoryBL.GetStockOutFlowDetails(OrgID, pSRNO, (int)StockOutFlowType.StockReturn, out lstOrganization, out lstSuppliers, out lstStockOutFlow, out lstProductCategories, out lstInventoryItemsBasket, out lstStockReturnDetails);

            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (lstSuppliers.Count > 0)
                {
                    lblTo.Visible = true;
                    lblVendorName.Text = lstSuppliers[0].SupplierName;
                    lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                    lblVendorCity.Text = lstSuppliers[0].City;
                    lblVendorPhone.Text = lstSuppliers[0].Phone;
                }
                lblSRDate.Text = lstStockOutFlow[0].CreatedAt.ToExternalDate();
                lblSRID.Text = lstStockOutFlow[0].StockOutFlowNo;
                hdnApproveStockReturn.Value = lstStockOutFlow[0].StockOutFlowID.ToString();
                lblReasontxt.Text = lstInventoryItemsBasket[0].Remarks;
                LoadStockReturnItems(lstProductCategories, lstInventoryItemsBasket);
                decimal TotalCost = lstInventoryItemsBasket.Sum(o => o.Quantity * o.UnitPrice);
                
                decimal TotalGST = 0;
                if (lstInventoryItemsBasket[0].IGSTRate == 0)
                {
                    TotalGST = lstInventoryItemsBasket.Sum(o => o.CGSTRate + o.SGSTRate);
                }
                else
                {
                    TotalGST = lstInventoryItemsBasket.Sum(o => o.IGSTRate);
                }
                if (lstStockOutFlow[0].Description != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Note: " + lstStockOutFlow[0].Description;
                }
                if (lstStockOutFlow[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    approvedDateTD.Text = lstStockOutFlow[0].ApprovedAt.ToExternalDate();
                }

                GateWay headBL = new GateWay(base.ContextInfo);
                if (lstStockOutFlow[0].ApprovedBy != 0 && lstStockOutFlow[0].Status == StockOutFlowStatus.Approved)
                {
                    returnCode = headBL.GetUserDetail(lstStockOutFlow[0].ApprovedBy, out lstUsers);
                    if (lstUsers != null && lstUsers.Count > 0)
                    {
                        //approvedByTD.Attributes.Add("class", "show");
                        //approvedByTD.Text = lstUsers[0].Name;
                        lblApprovedbyVal.Text = lstUsers[0].Name;
                    }
                }

                if (lstStockOutFlow[0].CreatedBy != 0)
                {
                    returnCode = headBL.GetUserDetail(lstStockOutFlow[0].CreatedBy, out lstUsers);
                    if (lstUsers != null && lstUsers.Count > 0)
                    {
                       lblPreparedbyVal.InnerText = lstUsers[0].Name;
                    }
                }
                
                if (lstStockOutFlow[0].Status == StockOutFlowStatus.Created && approval == "1")
                {
                   
                    lblStatus.Text = sUnApproved;
                    btnApprove.Attributes.Add("class", "hide");
                    btnCancel.Attributes.Add("class", "hide");
                    //trApproveBlock.Style.Add("display", "block");

                }
                else if (lstStockOutFlow[0].Status == StockOutFlowStatus.Created && approval == null)
                {
                    lblStatus.Text = sApproved; lblStatus.Text = sUnApproved;
                    btnApprove.Attributes.Add("class", "hide");
                    btnCancel.Attributes.Add("class", "hide");
                    //trApproveBlock.Style.Add("display", "none");
                }
                else if (lstStockOutFlow[0].Status == StockOutFlowStatus.Pending)
                {
                    if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin == RoleName)
                    {
                        grdResult.Visible = false;
                        grdStockReturn.Visible = true;
                        lblStatus.Text = sPending;
                        btnApprove.Visible = true;
                        btnApprove.Enabled = true;
                        btnCancel.Visible = true;
                    }
                    else
                    {
                        grdResult.Visible = false;
                        grdStockReturn.Visible = true;
                        lblStatus.Text = sPending;
                        btnApprove.Visible = false;
                        btnCancel.Visible = false;
                    }

                    var lstGSTTaxDetails = lstInventoryItemsBasket.
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

                              }).OrderBy(cl => cl.Tax).ToList();

                    grdGstTax.DataSource = lstGSTTaxDetails;
                    grdGstTax.DataBind();
                }
                else
                {
                    grdResult.Visible = false;
                    grdStockReturn.Visible = true;
                    lblStatus.Text = lstStockOutFlow[0].Status == "Cancelled" ? lstStockOutFlow[0].Status : sApproved;
                    btnApprove.Visible = false;
                    btnCancel.Visible = false;

                    var lstGSTTaxDetails = lstInventoryItemsBasket.
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

                              }).OrderBy(cl => cl.Tax).ToList();

                    grdGstTax.DataSource = lstGSTTaxDetails;
                    grdGstTax.DataBind();
                }
                
                if (lstStockReturnDetails.Count > 0) //&& pageName=="StockReturn"
                {
                    decimal TotalValues = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.Quantity * o.UnitPrice);
                    lblTotalValue.Text = String.Format("{0:0.00}", TotalValues);
                    decimal TotalSchemeDisc = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.TotalSchemeDisc);
                    lblTotalSchemeAmt.Text = String.Format("{0:0.00}", TotalSchemeDisc);
                    decimal TotalNormalDisc = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.TotalNormalDisc);
                    lblTotalDiscountAmt.Text = String.Format("{0:0.00}", TotalNormalDisc);
                    decimal TotalAmtBefTax = (TotalValues - (TotalSchemeDisc + TotalNormalDisc));
                    //lblAmtBefTax.Text = String.Format("{0:0.00}", TotalAmtBefTax);
                    decimal TotalCGST = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.CGSTRate);
                    //lbltotcgstamt.Text = String.Format("{0:0.00}", TotalCGST);
                    decimal TotalSGST = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.SGSTRate);
                    //lbltotsgstamt.Text = String.Format("{0:0.00}", TotalSGST);
                    decimal TotalIGST = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.IGSTRate);
                    //lbltotigstamt.Text = String.Format("{0:0.00}", TotalIGST);
                    decimal TotalGSTAmt = lstInventoryItemsBasket.AsEnumerable().Sum(o => o.CGSTRate + o.SGSTRate + o.IGSTRate);
                    lblTotaltax.Text = String.Format("{0:0.00}", TotalGSTAmt);
                    //lblAmtAftTax.Text = String.Format("{0:0.00}", TotalAmtBefTax + TotalGSTAmt);
                    //lblGrountTotal.Text = String.Format("{0:0.00}", TotalAmtBefTax + TotalGSTAmt);
                    lblGrandwithRoundof.Text = String.Format("{0:0.00}", TotalAmtBefTax + TotalGSTAmt); 
                }
                
                if (lstStockOutFlow[0].Status == "Pending")
                {
                    approvalTR.Attributes.Add("class", "hide");
                }

                List<Config> lstConfig = new List<Config>();
                int iBillGroupID = 0;
                iBillGroupID = (int)ReportType.OPBill;
                new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
                    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
                    if (lstConfig[0].ConfigValue.Trim() != "")
                    {
                        imgBillLogo.Attributes.Add("class", "a-center");
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

            }
            else
            {
                string sPath = Resources.StockReturn_ClientDisplay.StockReturn_ViewStockReturn_aspx_04;
                if(sPath==null)
                {
                    sPath="No Matching Records Found!";
                }
                lblMessage.Text = sPath;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReturn.aspx.cs", ex);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../Admin/Home.aspx", true); }
        else
        {
            Response.Redirect("~/StockReturn/StockReturn.aspx");
        }
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {

        try
        {
            btnApprove.Enabled = false;
            CommandName = "Approve";
            foreach (GridViewRow gvr in grdResult.Rows)
            {
                InventoryItemsBasket objIIB = new InventoryItemsBasket();
                objIIB.ExpiryDate = Convert.ToDateTime("01/01/1753");
                objIIB.Manufacture = Convert.ToDateTime("01/01/1753");
                objIIB.Quantity = Convert.ToDecimal(((TextBox)gvr.FindControl("txtQuantity")).Text);


                HiddenField ProductID = (HiddenField)gvr.FindControl("hdnProductID");
                HiddenField ParentProductID = (HiddenField)gvr.FindControl("hdnpParentProductID");
                HiddenField BatchNo = (HiddenField)gvr.FindControl("hdnBatchNo");
                HiddenField InHandQuantity = (HiddenField)gvr.FindControl("hdnpInHandQuantity");
                HiddenField Units = (HiddenField)gvr.FindControl("hdnpUnits");
                HiddenField ComplQty = (HiddenField)gvr.FindControl("hdnComplimentQTY");
                HiddenField ProductReceivedDetailsID = (HiddenField)gvr.FindControl("hdnProductRecdDetailsID");
                HiddenField ReceivedUniqueNumber = (HiddenField)gvr.FindControl("hdnReceivedUniqueNumber");
                objIIB.Unit = Units.Value;

                objIIB.ProductID = Convert.ToInt64(ProductID.Value);
                objIIB.parentProductID = Convert.ToInt64(ParentProductID.Value);
                objIIB.BatchNo = BatchNo.Value;
                objIIB.InHandQuantity = Convert.ToDecimal(InHandQuantity.Value);
                objIIB.ComplimentQTY = Convert.ToDecimal(ComplQty.Value);
                objIIB.ProductReceivedDetailsID = Convert.ToInt64(ProductReceivedDetailsID.Value);
                objIIB.ReceivedUniqueNumber = Convert.ToInt64(ReceivedUniqueNumber.Value);
                lstInventoryItemsBasket.Add(objIIB);
            }
            returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSRNO, lstInventoryItemsBasket, CommandName);
            //if (returnCode == 0)
            //{
            LoadDetails();
            //}
            // Response.Redirect("InventorySearch.aspx",true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockReturn.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        btnUpdate.Enabled = false;
        try
        {
            CommandName = "Update";
            foreach (GridViewRow gvr in grdResult.Rows)
            {
                InventoryItemsBasket objIIB = new InventoryItemsBasket();
                objIIB.ExpiryDate = Convert.ToDateTime("01/01/1753");
                objIIB.Manufacture = Convert.ToDateTime("01/01/1753");
                objIIB.Quantity = Convert.ToDecimal(((TextBox)gvr.FindControl("txtQuantity")).Text);

                HiddenField ProductID = (HiddenField)gvr.FindControl("hdnProductID");
                HiddenField ParentProductID = (HiddenField)gvr.FindControl("hdnpParentProductID");
                HiddenField BatchNo = (HiddenField)gvr.FindControl("hdnBatchNo");
                HiddenField InHandQuantity = (HiddenField)gvr.FindControl("hdnpInHandQuantity");
                HiddenField Units = (HiddenField)gvr.FindControl("hdnpUnits");
                objIIB.Unit = Units.Value;

                objIIB.ProductID = Convert.ToInt64(ProductID.Value);
                objIIB.parentProductID = Convert.ToInt64(ParentProductID.Value);
                objIIB.BatchNo = BatchNo.Value;
                objIIB.InHandQuantity = Convert.ToDecimal(InHandQuantity.Value);
                lstInventoryItemsBasket.Add(objIIB);
            }
            returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSRNO, lstInventoryItemsBasket, CommandName);
            //if (returnCode == 0)
            //{
            LoadDetails();
            string Save = Resources.StockReturn_AppMsg.StockReturn_ViewStockReturn_aspx_02;
            string Error = Resources.StockReturn_AppMsg.StockReturn_Error;
            if (Save == null)
            {
                Save = "Changes have  Updated Successfully";
            }
            if (Error == null)
            {
                Error = "Error";
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + Save + "','" + Error +"');", true);
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockReturn.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtquantity = new TextBox();
            HiddenField hdnAvilableQuantity = new HiddenField();
          
            txtquantity = (TextBox)e.Row.FindControl("txtQuantity");
            hdnAvilableQuantity = (HiddenField)e.Row.FindControl("hdnpInHandQuantity");
            string sValidateQty = "ValidateReturnQty('" + hdnAvilableQuantity.ClientID + "','" + txtquantity.ClientID + "');";
            txtquantity.Attributes.Add("onBlur", sValidateQty);
            //loadInventoryUOM(ddlUnit, hdnUnit.Value);

        }
    }

    protected void GridViewDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Double UnitPrice = 0.00;
            Double Qty = 0.00;
            Double Amt = 0.00;
            Double Tax = 0.00;
            Double CGST = 0.00;
            Double SGST = 0.00;
            Double IGST = 0.00;
            HiddenField hdnUnitPrice = (HiddenField)e.Row.FindControl("hdnUnitPrice");
            HiddenField hdnQty = (HiddenField)e.Row.FindControl("hdnQty");
            Label lblCGST = (Label)e.Row.FindControl("lblCGST");
            Label lblIGST = (Label)e.Row.FindControl("lblIGST");
           // Label lbltotAmt = (Label)e.Row.FindControl("lbltotAmt");

            UnitPrice = Convert.ToDouble(hdnUnitPrice.Value);
            Qty = Convert.ToDouble(hdnQty.Value);
           
            //Tax = Convert.ToDouble(lblTax.Text);
            Amt = (UnitPrice * Qty); 
            Amt = Amt + (Amt)/100*Tax;
           // lbltotAmt.Text = Amt.ToString();
        }
    }
    public void LoadStockReturnItems(List<ProductCategories> lstPO, List<InventoryItemsBasket> lstIIB)
    {
        var list = (from basket in lstInventoryItemsBasket
                    select new
                    {
                        basket.ProductName,
                        Description =basket.Description.Split('~').Length>1? basket.Description.Split('~')[1]:"",
                        basket.Quantity,
                        basket.InHandQuantity,
                        basket.Unit,
                        basket.LSUnit,
                        basket.BatchNo,
                        basket.ProductID,
                        basket.parentProductID,
                        basket.UnitPrice,
                        basket.ProductCode,
                        basket.CGSTPercent,
                        basket.CGSTRate,
                        basket.SGSTPercent,
                        basket.SGSTRate,
                        basket.IGSTPercent,
                        basket.IGSTRate,
                        basket.TotalQty,
					    basket.Remarks,
                        //basket.Tax
                        basket.SchemeType,
                        basket.TotalSchemeDisc,
                        basket.DiscountType,
                        basket.TotalNormalDisc,
                        basket.SellingPrice,
                        basket.TotalCost,
                        basket.ComplimentQTY,
                        basket.HSNCode,
                        basket.ExpiryDate,
                        basket.ReceivedUniqueNumber,
                        basket.ProductReceivedDetailsID,
                        basket.PrepareCharges
                    }).ToList();


        if (list.Count() > 0)
        {
            grdResult.DataSource = list;
            grdResult.DataBind();
            grdStockReturn.DataSource = list;
            grdStockReturn.DataBind();
        }

        if (lstStockOutFlow[0].Status == "Pending")
        {
            if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin == RoleName)
            {
                grdStockReturn.Visible = false;
                grdResult.Visible = true;

            }
            else
            {
                grdStockReturn.Visible = false;
                grdResult.Visible = true;
            }
        }
        else
        {
            grdStockReturn.Visible = true;
            grdResult.Visible = false;
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
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            CommandName = "Cancelled";

            foreach (GridViewRow gvr in grdResult.Rows)
            {
                InventoryItemsBasket objIIB = new InventoryItemsBasket();
                objIIB.Quantity = Convert.ToDecimal(((TextBox)gvr.FindControl("txtQuantity")).Text);

                HiddenField ProductID = (HiddenField)gvr.FindControl("hdnProductID");
                HiddenField ParentProductID = (HiddenField)gvr.FindControl("hdnpParentProductID");
                HiddenField BatchNo = (HiddenField)gvr.FindControl("hdnBatchNo");
                HiddenField InHandQuantity = (HiddenField)gvr.FindControl("hdnpInHandQuantity");
                HiddenField Units = (HiddenField)gvr.FindControl("hdnpUnits");
                HiddenField ComplQty = (HiddenField)gvr.FindControl("hdnComplimentQTY");
                HiddenField ProductReceivedDetailsID = (HiddenField)gvr.FindControl("hdnProductRecdDetailsID");
                HiddenField ReceivedUniqueNumber = (HiddenField)gvr.FindControl("hdnReceivedUniqueNumber");
                objIIB.Unit = Units.Value;

                objIIB.ProductID = Convert.ToInt64(ProductID.Value);
                objIIB.parentProductID = Convert.ToInt64(ParentProductID.Value);
                objIIB.BatchNo = BatchNo.Value;
                objIIB.InHandQuantity = Convert.ToDecimal(InHandQuantity.Value);
                objIIB.ComplimentQTY = Convert.ToDecimal(ComplQty.Value);
                objIIB.ProductReceivedDetailsID = Convert.ToInt64(ProductReceivedDetailsID.Value);
                objIIB.ReceivedUniqueNumber = Convert.ToInt64(ReceivedUniqueNumber.Value);
                lstInventoryItemsBasket.Add(objIIB);
            }
            returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSRNO, lstInventoryItemsBasket, CommandName);

            LoadDetails();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Cancel details in ViewStockReturn.aspx", ex);
        }
    }
}
