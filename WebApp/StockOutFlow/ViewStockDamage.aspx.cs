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
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;

public partial class StockOutFlow_ViewStockDamage : Attune_BasePage
{
    public StockOutFlow_ViewStockDamage()
        : base("StockOutFlow_ViewStockDamage_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockOutFlow> lstStockDamage = new List<StockOutFlow>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    List<Users> lstUsers = new List<Users>();
    
    List<StockReturnDetails> lstStockReturnDetails = new List<StockReturnDetails>();
    string CommandName = string.Empty;
    long pSDNO = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
        btnApprove.Enabled = true;
        LoadDetails();
        }
        
    }
    public void LoadDetails()
    {
        
        string approval = string.Empty;
        string unapproval = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_02 == null ? "UnApproved" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_02;
        string pending = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_03 == null ? "Pending" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_03;
        string approved = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_04 == null ? "Approved" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_04;
        string Note = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_05 == null ? "Note:" : Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_05;
        pSDNO = Convert.ToInt64(Request.QueryString["ID"]);
        approval = Request.QueryString["Approve"];
       // hypLnkPrint.NavigateUrl = "PrintStockDamage.aspx?pSDNO=" + pSDNO + "";
        try
        {
            //inventoryBL.GetStockDamageDetails(OrgID, pSDNO, out lstOrganization, out lstStockDamage, out lstProductCategories, out lstInventoryItemsBasket);
           inventoryBL.GetStockOutFlowDetails(OrgID, pSDNO,(int)StockOutFlowType.StockDamage, out lstOrganization,out lstSuppliers, out lstStockDamage, out lstProductCategories, out lstInventoryItemsBasket,out lstStockReturnDetails );

            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                //lblVendorName.Text = lstSuppliers[0].SupplierName;
                //lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                //lblVendorCity.Text = lstSuppliers[0].City;
                //lblVendorPhone.Text = lstSuppliers[0].Phone;
                lblSDDate.Text = lstStockDamage[0].CreatedAt.ToExternalDate();
                lblSDID.Text = lstStockDamage[0].StockOutFlowNo;
                hdnApproveStockDamage.Value = lstStockDamage[0].StockOutFlowID.ToString();
                LoadStockDamageItems(lstProductCategories, lstInventoryItemsBasket);
                if (lstStockDamage[0].Description != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Reason For Damage: " + lstStockDamage[0].Description;
                }
                if (lstStockDamage[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Attributes.Add("class", "displaytr");
                    approvedDateTD.InnerText = lstStockDamage[0].ApprovedAt.ToExternalDate();
                }
                GateWay headBL = new GateWay(base.ContextInfo);
                if (lstStockDamage[0].ApprovedBy != 0)
                {
                    returnCode = headBL.GetUserDetail(lstStockDamage[0].ApprovedBy, out lstUsers);
                    if (lstUsers != null && lstUsers.Count > 0)
                    {

                    approvedByTD.Attributes.Add("class", "displaytd");

                    approvedByTD.InnerText = lstUsers[0].Name;
                    }
                }

                if (lstStockDamage[0].Status == StockOutFlowStatus.Created && approval == "1")
                {
                    lblStatus.Text = unapproval;
                    tdApprove.Attributes.Add("class", "displaytd a-right");
                    tdPrint.Attributes.Add("class", "a-left");
                    // trApproveBlock.Style.Add("display", "block");

                }
                else if (lstStockDamage[0].Status == StockOutFlowStatus.Created && approval == null)
                {
                    //lblStatus.Text = "Approved"; 
                    lblStatus.Text = unapproval;
                    tdApprove.Attributes.Add("class", "hide");
                    //trApproveBlock.Style.Add("display", "none");
                }



                else if (lstStockDamage[0].Status == "Pending")
                {
                    if (RoleHelper.Admin == RoleName || RoleHelper.InventoryAdmin==RoleName)
                    {
                        grdResult.Visible = true;
                        GridViewDetail.Visible = false;
                        lblStatus.Text = pending;
                        tdApprove.Attributes.Add("class", "show");
                        //trApproveBlock.Style.Add("display", "block");
                    }
                    else
                    {
                        grdResult.Visible = false;
                        GridViewDetail.Visible = true;
                        lblStatus.Text = pending;
                        tdApprove.Attributes.Add("class", "hide");
 
                    }
                }
                else
                {
                    grdResult.Visible = false;
                    GridViewDetail.Visible = true;
                    lblStatus.Text = approved;
                    tdApprove.Attributes.Add("class", "hide");
                    // trApproveBlock.Style.Add("display", "none");
                }
                if (lstStockDamage[0].Status == "Pending")
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
                string Message = Resources.StockOutFlow_ClientDisplay.StockOutFlow_ViewStockDamage_aspx_01;
                if (Message == null)
                {
                    Message = "No Matching Records Found!";
                }
                lblMessage.Text = Message;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockDamage.aspx.cs", ex);
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
            long orderID = Convert.ToInt64(hdnApproveStockDamage.Value);
            pSDNO = Convert.ToInt64(Request.QueryString["ID"]);
            string status = StockOutFlowStatus.Approved;

            //returnCode = inventoryBL.UpdateStockOutFlowStatus((int)StockOutFlowType.StockDamage, orderID, status, LID, OrgID);
            returnCode = inventoryBL.UpdateStockOutFlowStatus(OrgID, pSDNO, lstInventoryItemsBasket, CommandName);
            //if (returnCode == 0)
            //{
                LoadDetails();
           // }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockDamage.aspx", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["tid"])) { Response.Redirect(@"../Admin/Home.aspx", true); }
        else
        {
            Response.Redirect("~/StockOutFlow/StockDamage.aspx");
        }
    }
    public void LoadStockDamageItems(List<ProductCategories> lstPO, List<InventoryItemsBasket> lstIIB)
    {

     
        //foreach (ProductCategories objPC in lstProductCategories)
        //{
        //    list = from basket in lstInventoryItemsBasket
        //               where basket.CategoryID == objPC.CategoryID
        //               select basket;
        //}
       var list = from basket in lstInventoryItemsBasket
                  select basket;
       if (list.Count() > 0)
       {
           grdResult.DataSource = list;
           grdResult.DataBind();
           GridViewDetail.DataSource = list;
           GridViewDetail.DataBind();
       }

            if (lstStockDamage[0].Status == "Pending")
            {
                

                if (RoleHelper.Admin == RoleName ||RoleHelper.InventoryAdmin==RoleName)
                {
                    GridViewDetail.Visible = false;
                    grdResult.Visible = true;
                   
                }
                else
                {
                    GridViewDetail.Visible = false;
                    grdResult.Visible = true;
                }
            }
            else
            {
                GridViewDetail.Visible = true;
                grdResult.Visible = false;
               
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
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMID";
            ddlBoxU.DataBind();
            ddlBoxU.Items.Insert(0, ddlselect);
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
}
