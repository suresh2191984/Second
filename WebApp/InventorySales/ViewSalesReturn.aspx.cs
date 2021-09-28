using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections;
using Attune.Kernel.InventoryCommon.BL;

public partial class InventorySales_ViewSalesReturn:Attune_BasePage
{

    public InventorySales_ViewSalesReturn():base("PlatForm_CommonControls_InPatientSearch_ascx"){}
   
    string UserMsg= string.Empty;
    long returnCode = -1;
    List<Organization> lstOrganization = new List<Organization>();
    List<Customers> lstCustomers = new List<Customers>();
    List<SalesReturn> lstStockOutFlow = new List<SalesReturn>();
    List<SalesItemBasket> lstInventoryItemsBasket = new List<SalesItemBasket>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();

    InventorySales_BL inventorysalesBL;
    List<Users> lstUsers = new List<Users>();
    List<SalesReturnDetails> lstStockReturnDetails = new List<SalesReturnDetails>();
    long pSRNO = -1;
    string CommandName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorysalesBL = new InventorySales_BL(base.ContextInfo);
        pSRNO = Convert.ToInt64(Request.QueryString["ID"]);
        if (!IsPostBack)
        {
            btnApprove.Enabled = true;
            btnUpdate.Visible = false;
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



        // hypLnkPrint.NavigateUrl = "PrintStockReturn.aspx?pSRNO=" + pSRNO + "";
        try
        {
            // inventoryBL.GetStockReturnDetails(OrgID, pSRNO, out lstOrganization, out lstSuppliers, out lstStockReturn, out lstProductCategories, out lstInventoryItemsBasket);

            inventorysalesBL.GetSalesReturnDetails(OrgID, pSRNO, (int)StockOutFlowType.StockReturn, out lstOrganization, out lstCustomers, out lstStockOutFlow, out lstProductCategories, out lstInventoryItemsBasket, out lstStockReturnDetails);

            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (lstCustomers.Count > 0)
                {
                    lblTo.Visible = true;
                    lblVendorName.Text = lstCustomers[0].CustomerName;
                    lblVendorAddress.Text = lstCustomers[0].Address1 + ", " + lstCustomers[0].Address2;
                    lblVendorCity.Text = lstCustomers[0].City;
                    lblVendorPhone.Text = lstCustomers[0].Phone;
                }
                lblSRDate.Text = lstStockOutFlow[0].CreatedAt.ToExternalDate();
                lblSRID.Text = lstStockOutFlow[0].SaleReturnNo;
                hdnApproveStockReturn.Value = lstStockOutFlow[0].SaleReturnID.ToString();//lstStockDamage[0].StockOutFlowID.ToString();
                LoadStockReturnItems(lstProductCategories, lstInventoryItemsBasket);
                //if (lstStockOutFlow[0].Description != "")
                //{
                //    commentsTD.InnerHtml = "<hr/>" + "Note: " + lstStockOutFlow[0].Description;
                //}
                if (lstStockOutFlow[0].ApprovedAt.ToExternalDate() != DateTime.MinValue.ToExternalDate())
                {
                    approvalTR.Attributes.Add("class", "show");
                    approvedDateTD.Text = lstStockOutFlow[0].ApprovedAt.ToExternalDate();
                }

                if (lstStockOutFlow[0].ApprovedBy != 0)
                {
                    //returnCode = inventoryBL.GetUserDetail(lstStockOutFlow[0].ApprovedBy, out lstUsers);
                    //approvedByTD.Attributes.Add("class", "show");
                    //approvedByTD.Text = lstUsers[0].Name;
                }
                //if (lstStockOutFlow[0].Status == StockOutFlowStatus.Created && approval == "1")
                //{
                //    lblStatus.Text = "UnApproved";
                //    btnApprove.Attributes.Add("class", "show");
                //    //trApproveBlock.Attributes.Add("class", "show");

                //}
                //else if (lstStockOutFlow[0].Status == StockOutFlowStatus.Created && approval == null)
                //{
                //    lblStatus.Text = "Approved"; lblStatus.Text = "UnApproved";
                //    btnApprove.Attributes.Add("class", "hide");
                //    //trApproveBlock.Attributes.Add("class", "hide");
                //}
                //else if (lstStockOutFlow[0].Status == "Pending")
                //{
                //    if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin == RoleName)
                //    {
                //        grdResult.Visible = true;
                //        GridViewDetail.Visible = false;
                //        lblStatus.Text = "Pending";
                //        btnApprove.Attributes.Add("class", "show");
                //        //trApproveBlock.Attributes.Add("class", "show");
                //    }
                //    else
                //    {
                //        grdResult.Visible = false;
                //        GridViewDetail.Visible = true;
                //        lblStatus.Text = "Pending";
                //        btnApprove.Attributes.Add("class", "hide");
                //    }
                //}
                //else
                //{
                //    grdResult.Visible = false;
                //    GridViewDetail.Visible = true;
                //    lblStatus.Text = "Approved";
                //    btnApprove.Attributes.Add("class", "hide");
                //    // trApproveBlock.Attributes.Add("class", "hide");
                //}
                grdResult.Visible = false;
                GridViewDetail.Visible = true;
                if (lstStockReturnDetails.Count > 0 && pageName == "StockReturn")
                {
                    string s = lstStockReturnDetails[0].SellingPrice.ToString("{0:0.00}");
                    lblReturnamount.Text = lstStockReturnDetails[0].SellingPrice.ToString("0.00");//String.Format("{0:0.00}", s);
                    UserMsg=Resources.InventorySales_ClientDisplay.InventorySales_ViewSalesReturn_aspx_01!=null?Resources.InventorySales_ClientDisplay.InventorySales_ViewSalesReturn_aspx_01:"Total Return Amount:  ";
                    ReturnamountTD.InnerText = UserMsg+ lstStockReturnDetails[0].SellingPrice.ToString();
                }
                if (lstStockOutFlow[0].Status == "Pending")
                {
                    approvalTR.Attributes.Add("class", "hide");
                }


            }
            else
            {
                UserMsg = Resources.InventorySales_AppMsg.InventorySales_ViewSalesReturn_aspx_02 != null ? Resources.InventorySales_AppMsg.InventorySales_ViewSalesReturn_aspx_02: "No Matching Records Found!";
                lblMessage.Text = UserMsg;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReturn.aspx.cs", ex);
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
                SalesItemBasket objIIB = new SalesItemBasket();
                objIIB.ExpiryDate = new DateTime(1753,1,1);
                objIIB.Manufacture = new DateTime(1753, 1, 1);
                objIIB.ProductKey = grdResult.DataKeys[gvr.RowIndex].Values[0].ToString();
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
            //returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSRNO, lstInventoryItemsBasket, CommandName);
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
                SalesItemBasket objIIB = new SalesItemBasket();
                objIIB.ExpiryDate = new DateTime(1753, 1, 1);
                objIIB.Manufacture = new DateTime(1753, 1, 1);
                objIIB.ProductKey = grdResult.DataKeys[gvr.RowIndex].Values[0].ToString();
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
            //returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSRNO, lstInventoryItemsBasket, CommandName);
            //if (returnCode == 0)
            //{
            LoadDetails();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('Updated Successfully');", true);
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
            //InventoryItemsBasket inv = new InventoryItemsBasket();
            //inv = (InventoryItemsBasket)e.Row.DataItem;
            //DropDownList ddlUnit = (DropDownList)e.Row.FindControl("ddlUnit");
            //HiddenField hdnUnit = (HiddenField)e.Row.FindControl("hdnUnit");

            txtquantity = (TextBox)e.Row.FindControl("txtQuantity");
            hdnAvilableQuantity = (HiddenField)e.Row.FindControl("hdnpInHandQuantity");
            string sValidateQty = "ValidateReturnQty('" + hdnAvilableQuantity.ClientID + "','" + txtquantity.ClientID + "');";
            txtquantity.Attributes.Add("onBlur", sValidateQty);
            //loadInventoryUOM(ddlUnit, hdnUnit.Value);

        }
    }

    public void LoadStockReturnItems(List<ProductCategories> lstPO, List<SalesItemBasket> lstIIB)
    {
        var list = (from basket in lstInventoryItemsBasket
                    select new
                    {
                        basket.ProductName,
                        basket.ProductKey,
                        //Description = basket.Description.Split('~')[1],
                        basket.Quantity,
                        basket.InHandQuantity,
                        basket.Unit,
                        basket.DCNo,
                        basket.InvoiceNo,
                        basket.Amount,
                        //basket.LSUnit,
                        basket.BatchNo,
                        basket.ProductID,
                        //basket.parentProductID
                    }).ToList();


        if (list.Count() > 0)
        {
            //grdResult.DataSource = list;
            //grdResult.DataBind();
            GridViewDetail.DataSource = list;
            GridViewDetail.DataBind();
        }

        //if (lstStockOutFlow[0].Status == "Pending")
        //{
        //    if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin == RoleName)
        //    {
        //        GridViewDetail.Visible = false;
        //        grdResult.Visible = true;

        //    }
        //    else
        //    {
        //        GridViewDetail.Visible = false;
        //        grdResult.Visible = true;
        //    }
        //}
        //else
        //{

        //    GridViewDetail.Visible = true;
        //    grdResult.Visible = false;


        //}


    }
    private void loadInventoryUOM(DropDownList ddlBoxU, string SelectedText)
    {
        try
        {
            ListItem ddlSelect = GetMetaData("Select", "0");
            if (ddlSelect == null)
                ddlSelect = new ListItem() { Text = "Select", Value = "0" };

            List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
            if (lstInventoryUOM.Count == 0)
            {
                new InventoryCommon_BL(base.ContextInfo).GetInventoryUOM(out lstInventoryUOM);
            }
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMID";
            ddlBoxU.DataBind();
            //ddlBoxU.Items.Insert(0, "--Select--");
            ddlBoxU.Items.Insert(0, ddlSelect);
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
}
