using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;

public partial class InventorySales_CustomerStockReturn :Attune_BasePage
{
    long returnCode = -1;
    InventorySales_BL inventorySalesBL;
    InventorySales_BL inventoryBL;
    List<Locations> lstLocationName = new List<Locations>();
    List<Locations> lsttempLocationName = new List<Locations>();
    List<StockOutFlowTypes> lstStockOutFlowTypes = new List<StockOutFlowTypes>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        inventoryBL = new InventorySales_BL(base.ContextInfo);
        txtStockReturnDate.Focus();
        if (!IsPostBack)
        {
            try
            {

                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                txtStockReturnDate.Text = DateTimeUtility.GetServerDate().ToExternalDate();
                //LoadSuppliers();

                BindInventoryLocation();

                lblmsg.Text = "Search the Product List";
                //listProducts.Visible = false;
                LoaStockOutFlowType();
                GetCustomers();



            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockReturn.aspx", ex);
                //ErrorDisplay1.ShowError = true;
                //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            }
        }
        if (Request["__EVENTARGUMENT"] != null && Request["__EVENTARGUMENT"] == "Change")
        {
            txtQuantity.Text = "";
            txtUnit.Text = "";
            //if (listProducts.SelectedValue != "")
            //{
            //    LoadProductsBatchNo(Int64.Parse(listProducts.SelectedValue));
            //    divProductDetails.Style.Add("di/splay", "block");
            //    hdnProductId.Value = listProducts.SelectedValue;
            //    lblProductName.Text = "Product Name: " + listProducts.SelectedItem.Text;
            //    lblProductName.Visible = true;
            //    lblProductName.Font.Bold = true;
            //    lblTable.Text = tempTable.Value;
            //}
        }
        



    }
    public void GetCustomers()
    {
        try
        {
            long returnCode = -1;
            List<Customers> lstcust = new List<Customers>();
            List<CustomerLocations> lstCustomeLocation = new List<CustomerLocations>();
            returnCode = inventorySalesBL.GetCustomersList(OrgID, InventoryLocationID, out lstcust, out lstCustomeLocation);

            drpCustomerName.DataSource = lstcust;
            drpCustomerName.DataTextField = "CustomerName";
            drpCustomerName.DataValueField = "CustomerID";
            drpCustomerName.DataBind();
            drpCustomerName.Items.Insert(0, GetMetaData("Select","0"));
            drpCustomerName.Items[0].Selected = true;
            ddlCustomerLocation.Items.Insert(0, GetMetaData("Select", "0"));
            ddlCustomerLocation.Items[0].Selected = true; 
            foreach (var item in lstCustomeLocation)
            {
                hdnCustomerLocation.Value += item.CustomerID + "~" + item.LocationID + "~" + item.LocationName + "^"; 
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Customers list", ex);
        }

    }
    public Hashtable GetStockOutFlowTyprBind(Type StockOutFlowType)
    {

        string[] reason1 = Enum.GetNames(StockOutFlowType);
        Array values = Enum.GetValues(StockOutFlowType);
        Hashtable ht1 = new Hashtable();

        for (int i = 0; i <= reason1.Length; i++)
        {
            StockOutFlowTypes SOFT = new StockOutFlowTypes();

            if (i == 0)
            {
                ListItem li = GetMetaData("Select", "0");

                ht1.Add(0, li);
                SOFT.StockOutFlowTypeId = i;
                SOFT.StockOutFlowType = li.Text;
            }
            else
            {

                ht1.Add(Convert.ToInt32(values.GetValue(i - 1)).ToString(), reason1[i - 1]);
                SOFT.StockOutFlowTypeId = i;
                SOFT.StockOutFlowType = reason1[i - 1].ToString();

            }
            lstStockOutFlowTypes.Add(SOFT);

        }

        return ht1;
    }




    private void LoaStockOutFlowType()
    {

        Hashtable ht1 = GetStockOutFlowTyprBind(typeof(StockOutFlowType));
        lstStockOutFlowTypes.FindAll(P => (P.StockOutFlowTypeId == 3));
        ddlStockReturnType.DataSource = lstStockOutFlowTypes;
        ddlStockReturnType.DataTextField = "StockOutFlowType";
        ddlStockReturnType.DataValueField = "StockOutFlowTypeId";
        //ddlStockReturnType.DataTextField = "value";
        //ddlStockReturnType.DataValueField = "key";
        ddlStockReturnType.DataBind();
        //ddlStockReturnType.Items.Remove(ddlStockReturnType.Items.FindByText("StockUsage"));
        //ddlStockReturnType.Items.Remove(ddlStockReturnType.Items.FindByText("Adhoc"));
        //ddlStockReturnType.Items.Remove(ddlStockReturnType.Items.FindByText("Adjustment"));
        //ddlStockReturnType.Items.Remove(ddlStockReturnType.Items.FindByText("NonMovement")); 
        //  ddlStockReturnType.Items.Insert(0, new ListItem("--Select--", "0"));
    }

    private void BindInventoryLocation()
    {
        try
        {
            long iOrgID = Int64.Parse(OrgID.ToString());
            long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            //int OrgAddid = ILocationID;
            //new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        OrgAddid = 0;
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}
            //returnCode = inventoryBL.GetInvLocationDetail(OrgID, OrgAddid, out lstLocationName);
            //lsttempLocationName.Add((lstLocationName.Find(P => P.LocationTypeCode == "CS" || P.LocationTypeCode == "CS-POS")));
            //ddlLocation.DataSource = lsttempLocationName;
            //ddlLocation.DataTextField = "LocationName";
            //ddlLocation.DataValueField = "LocationID";
            //ddlLocation.DataBind();
            //ddlLocation.SelectedValue = lstLocationName.Find(P => P.LocationTypeCode != "CS" || P.LocationTypeCode != "CS-POS").LocationID.ToString();
            //lstLocationName.Remove(lstLocationName.Find(P => P.LocationID != InventoryLocationID));
            //switch (lstLocationName[0].LocationTypeCode)
            //{
            //    case "POS":
            //    case "POD":
            //        ////ddlLocation.SelectedValue = lstLocationName[0].LocationID.ToString();
            //        divLocation.Style.Add("display", "block");
            //        divSuppliers.Attributes.Add("class", "hide");
            //        hdnIsSupplier.Value = "N";

            //        break;
            //    case "CS":
            //    case "CS-POS":
            //        divLocation.Attributes.Add("class", "hide");
            //        break;
            //}



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
        new InventoryCommon_BL(base.ContextInfo).GetAllProductList(OrgID, ILocationID, out lstProducts);
        if (lstProducts.Count > 0)
        {
            //listProducts.Visible = true;
            lblMsgpro.Text = "Product List (Double click the below list to select the Bacth No.)";
            //listProducts.DataSource = lstProducts;
            //listProducts.DataTextField = "ProductName";
            //listProducts.DataValueField = "ProductID";
            //listProducts.DataBind();
        }
        else
        {
            lblMsgpro.Text = "No matching Product found";
            //listProducts.Visible = false;
        }
    }

    //private void LoadSuppliers()
    //{
    //    List<Suppliers> lstSuppliers = new List<Suppliers>();
    //    inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
    //    List<Customers> lstcust = new List<Customers>();
    //    List<CustomerLocations> lstCustomeLocation = new List<CustomerLocations>();
    //    returnCode = inventorySalesBL.GetCustomersList(OrgID, InventoryLocationID, out lstcust, out lstCustomeLocation);

    //    ddlSupplierList.DataSource = lstcust;
    //    ddlSupplierList.DataTextField = "CustomerName";
    //    ddlSupplierList.DataValueField = "CustomerID";
    //    ddlSupplierList.DataBind();
    //    ddlSupplierList.Items.Insert(0, "--Select--");
    //    ddlSupplierList.Items[0].Value = "0";

        
        
    //    //ddlSupplierList.DataSource = lstSuppliers;
    //    //ddlSupplierList.DataTextField = "SupplierName";
    //    //ddlSupplierList.DataValueField = "SupplierID";
    //    //ddlSupplierList.DataBind();
    //    //ddlSupplierList.Items.Insert(0, "--Select--");
    //    //ddlSupplierList.Items[0].Value = "0";
             

    //}

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
            //inventoryBL.GetProductsBatchNo(OrgID, ILocationID, iProductId, out lstInventoryItemsBasket, 0);
            new InventoryCommon_BL(base.ContextInfo).GetProductsBatchNo(OrgID, ILocationID, InventoryLocationID, iProductId, out lstInventoryItemsBasket, 0);

            //ddlBatchNo.DataSource = lstInventoryItemsBasket;
            //ddlBatchNo.DataTextField = "BatchNo";
            // ddlBatchNo.DataValueField = "description";
            //ddlBatchNo.DataBind();
            //ddlBatchNo.Items.Insert(0, "--Select--");
            // ddlBatchNo.Items[0].Value = "0";
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
        string Status = "";
        try
        {
            StockOutFlow objStockOutFlow = new StockOutFlow();
            StockOutFlowDetails objStockOutFlowDetails = new StockOutFlowDetails();
            List<SalesItemBasket> lstInventoryItemsBasket = new List<SalesItemBasket>();
            InventorySales_BL invsales = new InventorySales_BL(base.ContextInfo);
            int StockOutFlowTypeID = Convert.ToInt32(ddlStockReturnType.SelectedValue); //(int)StockOutFlowType.StockReturn; 
            
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();


            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Stock_Return_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    Status = StockOutFlowStatus.Approved;
                }
            }

            else
            {
                Status = StockOutFlowStatus.Approved;
            } 
           
            int CustomerID = Convert.ToInt32(drpCustomerName.SelectedValue);
            int CustomerLocID = Convert.ToInt32(hdnLocation.Value) > 0 ? Convert.ToInt32(hdnLocation.Value) : 0;
            string Comments = txtComments.Text;
            lstInventoryItemsBasket = GetCollectedItems();
            //returnCode = inventoryBL.getSellingPriceDetails(ref lstInventoryItemsBasket, OrgID, ILocationID, InventoryLocationID);
            //if (lstInventoryItemsBasket.Count == 0)
            //{
            //    //ErrorDisplay1.ShowError = true;
            //    //ErrorDisplay1.Status = "Please Check Items Added/Quantity entered properly.";
            //    return;
            //}

            returnCode = invsales.SaveSalesReturn(StockOutFlowTypeID,OrgID, ILocationID, InventoryLocationID, CustomerID, CustomerLocID, LID, Status,
                                                        Comments, lstInventoryItemsBasket, out pSDNo);
             

            if (returnCode >= 0)
            { 
                Response.Redirect(@"../InventorySales/ViewSalesReturn.aspx?ID=" + pSDNo + "&PageName=StockReturn", true); 
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

    public List<SalesItemBasket> GetCollectedItems()
    {

        List<SalesItemBasket> lstInventoryItemsBasket = new List<SalesItemBasket>();
        decimal Amount = 0;
        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                SalesItemBasket newBasket = new SalesItemBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[0]);
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.UnitPrice = Convert.ToDecimal(listChild[7]);
                newBasket.Rate = Convert.ToDecimal(listChild[13]);
                newBasket.SellingPrice = Convert.ToDecimal(listChild[13]);
                //newBasket.Providedby = long.Parse(listChild[8]);
                newBasket.Amount = Convert.ToDecimal(Convert.ToDecimal(Amount) + (Convert.ToDecimal(listChild[13]) * Convert.ToDecimal(listChild[3])));
                Amount = Convert.ToDecimal(Convert.ToDecimal(Amount) + (Convert.ToDecimal(listChild[13]) * Convert.ToDecimal(listChild[3])));
                newBasket.ExpiryDate = listChild[12].ToInternalDate();
                newBasket.Manufacture = DateTimeUtility.GetServerDate();
                newBasket.Tax = Convert.ToDecimal(0);
                newBasket.ProductKey = listChild[14];
                newBasket.parentProductID =Convert.ToInt64( listChild[15]);
                newBasket.StockOutFlowID = Convert.ToInt64(listChild[16]);
                newBasket.Type = ddlStockReturnType.SelectedItem.Text;
                newBasket.InvoiceNo = listChild[10];
                newBasket.DCNo = listChild[17];

                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        lstInventoryItemsBasket[0].Amount = Convert.ToDecimal(Amount);
        return lstInventoryItemsBasket;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Products> lstProducts = new List<Products>();

        try
        {
            //inventoryBL.GetSearchProductList(OrgID, ILocationID, InventoryLocationID, txtProduct.Text.Trim(), out lstProducts, int.Parse(ddlSupplierList.SelectedValue));
            if (lstProducts.Count > 0)
            {

                lblProductName.Text = "";
                //listProducts.Visible = true;
                divProductDetails.Attributes.Add("class", "hide");
                lblMsgpro.Text = "Product List (Double click the below list to select the Bacth No.)";
                //listProducts.DataSource = lstProducts;
                //listProducts.DataTextField = "ProductName";
                //listProducts.DataValueField = "ProductID";
                //listProducts.DataBind();
            }
            else
            {
                lblMsgpro.Text = "No matching Product found";
                //listProducts.Visible = false;
                lblProductName.Text = "";
            }


        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Product  Details", Ex);
        }


    }


    //public void GetCustomers()
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        List<Customers> lstcust = new List<Customers>();
    //        List<CustomerLocations> lstCustomeLocation = new List<CustomerLocations>();
    //        returnCode = inventorySalesBL.GetCustomersList(OrgID, InventoryLocationID, out lstcust, out lstCustomeLocation);

    //        //drpCustomerName.DataSource = lstcust;
    //        //drpCustomerName.DataTextField = "CustomerName";
    //        //drpCustomerName.DataValueField = "CustomerID";
    //        //drpCustomerName.DataBind();
    //        //drpCustomerName.Items.Insert(0, new ListItem("----Select----", "0"));
    //        //drpCustomerName.Items[0].Selected = true;

    //        //ddlCustomerLocation.Items.Insert(0, new ListItem("----Select----", "0"));
    //        //ddlCustomerLocation.Items[0].Selected = true;

    //        //foreach (var item in lstCustomeLocation)
    //        //{
    //        //    hdnCustomerLocation.Value += item.CustomerID + "~" + item.LocationID + "~" + item.LocationName + "^";

    //        //}

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Get Customers list", ex);
    //    }

    //}
}


