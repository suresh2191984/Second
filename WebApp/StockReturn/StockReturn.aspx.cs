using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Globalization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.StockReturn.BL;
using System.Web.Script.Serialization;
using Attune.Kernel.InventoryMaster.BL;


public partial class StockReturn_StockReturn : Attune_BasePage
{
    public StockReturn_StockReturn()
        : base("StockReturn_StockReturn_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    
    InventoryCommon_BL inventoryBL;
    List<Suppliers> lstSuppliers;
    List<Locations> lstLocationName = new List<Locations>();
    List<Locations> lsttempLocationName = new List<Locations>();
    List<StockOutFlowTypes> lstStockOutFlowTypes = new List<StockOutFlowTypes>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        txtStockReturnDate.Focus();
        if (!IsPostBack)
        {
            try
            {

                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                txtStockReturnDate.Text = DateTimeNow.ToExternalDate();
            //   LoadSuppliers();

                BindInventoryLocation();

                string Message = Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_08;
                if (Message == null)
                {
                    Message = "Search the Product List";
                }

                lblmsg.Text = Message;
                LoaStockOutFlowType();
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                

                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                    {
                        string ExpiryDateLevel = lstInventoryConfig[0].ConfigValue;
                        hdnExpiryDateLevel.Value = ExpiryDateLevel;
                    }
                }
                //Tax Hide for Vasan
                hdnNoGSTforExpiredProducts.Value = GetConfigValue("NoGSTforExpiredProducts", OrgID);
                if (hdnNoGSTforExpiredProducts.Value == "")
                    hdnNoGSTforExpiredProducts.Value = "N";
                string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
                if (HideTaxOpbilling == "Y")
                {                    
                    tdTax.Attributes.Add("class","hide");
                    tdTaxAmt.Attributes.Add("class","hide");                   
                }
                //Tax Hide for Vasan

                string IsWithoutGST = GetConfigValue("IsWithoutGST", OrgID);
                hdnWithoutGST.Value = IsWithoutGST;
                if (IsWithoutGST == "" || IsWithoutGST =="N")
                {
                    tdWithoutGST.Attributes.Add("class", "hide");
                    hdnWithoutGST.Value = "N";
                }

                string SchemeDiscConfigValue = GetConfigValue("IsNeedSchemeDiscount", OrgID);
                hdnIsSchemeDisc.Value = SchemeDiscConfigValue;
                if (SchemeDiscConfigValue =="" || SchemeDiscConfigValue =="N")
                {
                    tdlblSchemeDisc.Attributes.Add("class", "hide");
                    tdtxtScheme.Attributes.Add("class", "hide");
                    hdnIsSchemeDisc.Value = "N";
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockReturn.aspx", ex);
            }
        }
        if (Request["__EVENTARGUMENT"] != null && Request["__EVENTARGUMENT"] == "Change")
        {
            txtQuantity.Text = "";
            txtUnit.Text = "";
        }
    }


    private void LoaStockOutFlowType()
    {
        List<StockOutFlowTypes> lstOutStockOutFlowTypes = new List<StockOutFlowTypes>();
        new InventoryMaster_BL(base.ContextInfo).GetStockOutFlowTypes(out lstStockOutFlowTypes);
        lstOutStockOutFlowTypes = lstStockOutFlowTypes.FindAll(P => (P.IsSupplierStockReturn == "Y"));
        ddlStockReturnType.DataSource = lstOutStockOutFlowTypes;
        ddlStockReturnType.DataTextField = "StockOutFlowType";
        ddlStockReturnType.DataValueField = "StockOutFlowTypeId";
        ddlStockReturnType.DataBind();
        ddlStockReturnType.Items.Insert(0, GetMetaData("Select", "0"));
        ddlStockReturnType.Items[0].Value = "0";
    }

    private void BindInventoryLocation()
    {
        try
        {
            long iOrgID = Int64.Parse(OrgID.ToString());
            long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            
            returnCode = new Master_BL(ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocationName);
            lsttempLocationName.Add((lstLocationName.Find(P => P.LocationTypeCode == "CS" || P.LocationTypeCode == "CS-POS")));
            if (lsttempLocationName != null && lsttempLocationName.Count() > 0)
            {
                ddlLocation.DataSource = lsttempLocationName;
                ddlLocation.DataTextField = "LocationName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
            }
            //ddlLocation.SelectedValue = lstLocationName.Find(P => P.LocationTypeCode != "CS" || P.LocationTypeCode != "CS-POS").LocationID.ToString();
            lstLocationName.RemoveAll(P => P.LocationID != InventoryLocationID);
            switch (lstLocationName[0].LocationTypeCode)
            {
                case "POS":
                case "POD":
                    ////ddlLocation.SelectedValue = lstLocationName[0].LocationID.ToString();
                    divLocation.Attributes.Add("class", "hide");
                    divSuppliers.Attributes.Add("class", "hide");
                    hdnIsSupplier.Value = "N";

                    break;
                case "CS":
                case "CS-POS":
                    divLocation.Attributes.Add("class", "hide");
                    divSuppliers.Attributes.Add("class", "show");
                    break;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - StockIssued.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void LoadProductList()
    {
        List<Products> lstProducts = new List<Products>();
        inventoryBL.GetAllProductList(OrgID, ILocationID, out lstProducts);
        if (lstProducts.Count > 0)
        {
            //listProducts.Visible = true;
            string sPath = Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_09;
            if (sPath == null)
            {
                sPath="Product List (Double click the below list to select the Bacth No.)";
            }
            lblMsgpro.Text = sPath;
           
        }
        else
        {
            string sMessage = Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_09;
            if (sMessage == null)
            {
                sMessage = "No matching Product found";
            }
            lblMsgpro.Text = sMessage;
            //listProducts.Visible = false;
        }
    }

    private void LoadSuppliers()
    {
       // List<Suppliers> 
        lstSuppliers = new List<Suppliers>();
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        ddlSupplierList.DataSource = lstSuppliers;
        ddlSupplierList.DataTextField = "SupplierName";
        ddlSupplierList.DataValueField = "SupplierID";
        ddlSupplierList.DataBind();
        //arya
       ddlSupplierList.Items.Clear();
        ddlSupplierList.Items.Insert(0, GetMetaData("Select", "0"));
        ddlSupplierList.Items[0].Value = "0";

        //ddlBatchNo.Items.Insert(0, "--Select--");
        //ddlBatchNo.Items[0].Value = "0";

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

    //protected void listProducts_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtQuantity.Text = "";
    //    txtUnit.Text = "";
    //    //LoadProductsBatchNo(Int64.Parse(listProducts.SelectedValue));
    //    TableProductDetails.Style.Add("display", "block");
    //    //hdnProductId.Value = listProducts.SelectedValue;
    //    lblTable.Text = tempTable.Value;
    //}

    private void LoadProductsBatchNo(long iProductId)
    {
        try
        {
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            inventoryBL.GetProductsBatchNo(OrgID, ILocationID, InventoryLocationID, iProductId, out lstInventoryItemsBasket, 0);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load Products Batch No - StockReturn.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }

    protected void btnReturnStock_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        long pSDNo = -1;
        try
        {
            StockOutFlow objStockOutFlow = new StockOutFlow();
            StockOutFlowDetails objStockOutFlowDetails = new StockOutFlowDetails();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            objStockOutFlow.CreatedBy = LID;
            objStockOutFlow.Description = txtComments.Text.Trim();
            objStockOutFlow.StockOutFlowTypeID = Convert.ToInt32(ddlStockReturnType.SelectedItem.Value);
            if (ChkIsInternal.Checked){
                objStockOutFlow.IsInternal = "Y";
            }

            objStockOutFlow.ReferenceType = hdnChkbIsGST.Value; // IsGST flag purpose

            objStockOutFlow.LocationID = InventoryLocationID; ;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Return_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    objStockOutFlow.Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    objStockOutFlow.Status = StockOutFlowStatus.Approved;
                }
            }

            else
            {
                objStockOutFlow.Status = StockOutFlowStatus.Approved;
            }

            objStockOutFlow.OrgAddressID = ILocationID;
            objStockOutFlow.OrgID = OrgID;
            lstInventoryItemsBasket = GetCollectedItems();
            objStockOutFlow.SupplierID = Convert.ToInt32(hdnSupplier.Value);
            if (hdnIsSupplier.Value == "Y")
            {
                returnCode = inventoryBL.SaveStockOutFlow(objStockOutFlow, lstInventoryItemsBasket, out pSDNo);
            }
            StockReturn_BL stockBL = new StockReturn_BL(base.ContextInfo);
            if (hdnIsSupplier.Value == "N")
            {
                returnCode = stockBL.SaveLoactionStockStockReturn(objStockOutFlow, lstInventoryItemsBasket, out pSDNo, int.Parse(ddlLocation.SelectedValue));
            }

            if (returnCode == 0)
            {
                Response.Redirect(@"../StockReturn/ViewStockReturn.aspx?ID=" + pSDNo + "&PageName=StockReturn", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        var ListItemBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnProductList.Value);
        lstInventoryItemsBasket = (from c in ListItemBasket
                                   select new InventoryItemsBasket
                                   {
                                       ID = c.ProductReceivedDetailsID,
                                       ProductID = c.ProductID,
                                       ProductName = c.ProductName,
                                       BatchNo = c.BatchNo,
                                       Quantity = c.Quantity,
                                       Unit = c.Unit,
                                       InHandQuantity = c.InHandQuantity,
                                       //Amount = (c.Quantity * c.UnitPrice) + ((c.Quantity * c.UnitPrice)/100) * c.Tax,
                                       Amount = c.Amount,
                                       Rate = c.Rate,
                                       SellingPrice = c.Rate,
                                       Tax = c.Tax,
                                       ExpiryDate = c.ExpiryDate,
                                       Manufacture = DateTimeUtility.GetServerDate(),
                                       UnitPrice = c.UnitPrice,
                                       ParentProductID = c.ParentProductID,
                                       Providedby = c.Providedby,
                                       MRP = c.MRP,
                                       Type = ddlStockReturnType.SelectedItem.Text,
                                       ProductReceivedDetailsID = c.ProductReceivedDetailsID,
                                       ReceivedUniqueNumber = c.ReceivedUniqueNumber,
                                       StockReceivedBarcodeDetailsID=c.StockReceivedBarcodeDetailsID,
                                       BarcodeNo=c.BarcodeNo,
                                       SupplierId = c.SupplierId,
                                       SchemeDisc = c.SchemeDisc,
                                       Discount = c.Discount,
                                       TotalSchemeDisc = c.TotalSchemeDisc, 
                                       TotalNormalDisc = c.TotalNormalDisc,
                                       ComplimentQTY = c.ComplimentQTY,
                                       SubstoreReturnqty = c.SubstoreReturnqty
                                   }).ToList();
        return lstInventoryItemsBasket;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Products> lstProducts = new List<Products>();

        try
        {
            inventoryBL.GetSearchProductList(OrgID, ILocationID, InventoryLocationID, txtProduct.Text.Trim(), out lstProducts, int.Parse(ddlSupplierList.SelectedValue));
            if (lstProducts.Count > 0)
            {

                lblProductName.Text = "";
                //listProducts.Visible = true;
                divProductDetails.Attributes.Add("class", "hide");
                string sPath = Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_09;
                if (sPath == null)
                {
                    sPath = "Product List (Double click the below list to select the Bacth No.)";
                }
                lblMsgpro.Text = sPath;
                
            }
            else
            {
                string sMessage = Resources.StockReturn_ClientDisplay.StockReturn_StockReturn_aspx_09;
                if (sMessage == null)
                {
                    sMessage = "No matching Product found";
                }
                lblMsgpro.Text = sMessage; 
                //listProducts.Visible = false;
                lblProductName.Text = "";
            }


        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Product  Details", Ex);
        }


    }
}

