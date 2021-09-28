using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using AjaxControlToolkit;
using Attune.Kernel.InventoryCommon.BL;

public partial class InventorySales_SalesOrderIssue : Attune_BasePage 
{
    InventorySales_BL inventoryBL;
    InventorySales_BL inventorySalesBL;
    List<SalesItemBasket> lstInventoryItemsBasket = new List<SalesItemBasket>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    long returnCode = -1;
    int Customerid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        try
        {
            long srdNo = 0;
            if (!IsPostBack)
            {
                //LoadSuppliers();
                GetCustomers();
                LoadUnits(ddlSelling);
                txtSalesDate.Text =DateTimeUtility.GetServerDate().ToExternalDate();
                txtSalesDate.Focus();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);
               if (lstInventoryConfig.Count > 0)
                {
                    hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
                }
                
                if (Request.QueryString["SID"] != null && Request.QueryString["SID"] != "")
                {
                    Int64.TryParse(Request.QueryString["SID"], out srdNo);
                    LoadSalesDetails(srdNo);
                }
              
            }
            AutoCompleteProduct.ContextKey = Request.QueryString["SID"] + "~" + "0";
            string sval = Request.QueryString["SID"] + "~" + "0";
            AutoCompleteProduct.ContextKey = sval;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load -SalesOrderIssue.aspx.cs.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    private void LoadSalesDetails(long srdNo)
    {
        string str = "";
        List<Organization> lstOrganization = new List<Organization>();
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        List<Customers> lstcustomers = new List<Customers>();
        List<Customers> lstusers = new List<Customers>();
        List<SalesItemBasket> lstsalesdetail = new List<SalesItemBasket>();
        returnCode = inventorySalesBL.GetSalesDetails(OrgID, ILocationID, srdNo, InventoryLocationID, out lstsalesdetail, out lstcustomers, out lstusers);

       if (lstsalesdetail.Count > 0)
       {

           gvReceivedDetails.DataSource = lstsalesdetail;
           gvReceivedDetails.DataBind();

           if (lstcustomers.Count > 0)
           {
               txtSalesOrderNo.Text = lstsalesdetail[0].PrescriptionNO.ToString();
               ddlCustomer.SelectedValue = lstcustomers[0].CustomerID.ToString();
              // ddlSupplier.SelectedValue = lstsalesdetail[0].CustomerLocationID.ToString();
           }

           
        }
    }

  
    
    private void LoadSuppliers()
    {
        try
        {
            List<Suppliers> lstSupplier = new List<Suppliers>();
            new InventoryCommon_BL(base.ContextInfo).GetSupplierList(OrgID, ILocationID, out lstSupplier);
            ddlSupplier.DataSource = lstSupplier;
            ddlSupplier.DataTextField = "SupplierName";
            ddlSupplier.DataValueField = "SupplierID";
            ddlSupplier.DataBind();
            ddlSupplier.Items.Insert(0, "--Select--");
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
            ddlBoxU.DataSource = lstInventoryUOM;
            ddlBoxU.DataTextField = "UOMCode";
            ddlBoxU.DataValueField = "UOMCode";
            ddlBoxU.DataBind();
            ddlBoxU.Items.Insert(0, new ListItem("--Select--", "0"));

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
        long StockOutFlowID = -1;
        long SalesOrderID=0;

        string DcNo = string.Empty;
        try
        {
            long returnCode = -1;
             SalesOrderID =Convert.ToInt64(Request.QueryString["SID"].ToString());
            StockOutFlow objStockOutflow = new StockOutFlow();
			/*Removed Unwanted Columns in Inventory Related Tables*/
            //objStockOutflow.SalesOrderID =SalesOrderID;
            objStockOutflow.CreatedAt =txtSalesDate.Text.ToInternalDate();
            objStockOutflow.SupplierID = Convert.ToInt32(ddlSupplier.SelectedValue);
            objStockOutflow.Description = txtComments.Text.Trim();
            objStockOutflow.OrgID = OrgID;
            objStockOutflow.OrgAddressID = ILocationID;
            objStockOutflow.ConsumedBy  =ddlCustomer.SelectedValue;
            objStockOutflow.LocationID = InventoryLocationID;
            objStockOutflow.CreatedBy = LID;
            //objStockOutflow.InvoiceNo = txtInvoiceNo.Text.Trim();
            //objStockOutflow.DCNo= txtDCNumber.Text.Trim();
            //objStockOutflow.Tax = Convert.ToDecimal(txtTotalTaxAmt.Text);
            //set StockOutFlowType 
            objStockOutflow.StockOutFlowTypeID = (int)StockOutFlowType.SalesIssued;
            //objStockOutflow.Discount = Convert.ToDecimal(txtTotalDiscountAmt.Text);
            //objStockOutflow.GrandTotal = Convert.ToDecimal(txtGrandTotal.Text);
            objStockOutflow.Status = StockOutFlowStatus.Pending;
            //objStockOutflow.CSTax = Convert.ToDecimal(txtAddCST.Text);
            //objStockOutflow.Surcharge = Convert.ToDecimal(txtSurcharge.Text);
            //objStockOutflow.HighterEdCessTaxAmount = Convert.ToDecimal(txtHighterEdCess.Text);
            //objStockOutflow.ExciseTaxAmount  = Convert.ToDecimal(txtOctroi.Text);
            //objStockOutflow.VAT =0;
            //objStockOutflow.RoundOfType  = hdnRoundofType.Value;
            //objStockOutflow.RoundOfValue = decimal.Parse(txtRoundOffValue.Text);
            //objStockOutflow.RaiseOrgID = OrgID;
            //objStockOutflow.RaiseOrgAddID = ILocationID;
            //objStockOutflow.CLocationID = Convert.ToInt32(ddlSupplier.SelectedValue);//Customer LocationID
            //objStockOutflow.TotalSales = Convert.ToDecimal(txtTotalSales.Text);
            //CLogger.LogInfo("STEP:1");
			/*Removed Unwanted Columns in Inventory Related Tables*/

            lstInventoryItemsBasket = GetReceivedItems();

            InventorySales_BL inventorySalesBL = new InventorySales_BL(base.ContextInfo);
            #region SalesIssue
            if (Request.QueryString["SID"] != null)
            {
                returnCode = inventorySalesBL.SaveSalesOutFlowDetails(objStockOutflow, lstInventoryItemsBasket, out StockOutFlowID, out DcNo);
                CLogger.LogInfo("STEP:2");
                SalesOrderID = returnCode;
                if (returnCode > 0)
                {
                    Response.Redirect("ViewDeliveryChallan.aspx?SID=" + SalesOrderID + "&SOFD=" + StockOutFlowID + "&DcNo=" + DcNo + "&CID=" + ddlCustomer.SelectedValue, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), "Product", "javascript:Tblist();", true);
                    //ErrorDisplay1.ShowError = true;
                    //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                }
            }
            #endregion
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Sales Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public List<SalesItemBasket> GetReceivedItems()
    {
        //BacthNo '*' is No Bacth
        //ExpiryDate '**' is No ExpiryDate
        //Manufacture '**' is No Manufacture
        List<SalesItemBasket> lstReceivedItemsBasket = new List<SalesItemBasket>();
        string[] str = hdnProductList.Value.Trim().Split('^');
        Array.Sort(str);

        foreach (string listParent in str)
        {
            if (listParent != null && listParent.Trim() != string.Empty)
            {

                SalesItemBasket newBasket = new SalesItemBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ProductID = Convert.ToInt64(listChild[1].Trim() == "" ? "0" : listChild[1].Trim());
                newBasket.ProductName = listChild[2].Trim() == "" ? "0" : listChild[2].Trim();
                newBasket.BatchNo = listChild[3].Trim();
                if (listChild[4].Trim() == "**")
                {
                    DateTime tempDate = new DateTime(1753, 1, 1);
                    newBasket.Manufacture = tempDate;
                }
                else
                {
                    newBasket.Manufacture = listChild[4].ToInternalDate();
                }

                if (listChild[5].Trim() == "**")
                {
                    DateTime tempDate = new DateTime(1753, 1, 1);
                    newBasket.ExpiryDate = tempDate;
                }
                else
                {
                    newBasket.ExpiryDate = listChild[5].ToInternalDate();
                }
                newBasket.Description = listChild[6].Trim() == "" ? "" : listChild[6].Trim();
                newBasket.Quantity  = Convert.ToDecimal(listChild[9].Trim() == "" ? "0" : listChild[9].Trim());
                newBasket.Unit  = listChild[10].Trim();
                newBasket.Rate = Convert.ToDecimal(listChild[11].Trim() == "" ? "0" : listChild[11].Trim());//CostPrice
                newBasket.Amount = Convert.ToDecimal(listChild[12].Trim() == "" ? "0" : listChild[12].Trim());
                if (listChild[13].Trim() != "")
                {
                    newBasket.Discount = Convert.ToDecimal(listChild[13].Trim() == "" ? "0" : listChild[13].Trim());
                }
                if (listChild[14].Trim() != "")
                {
                    newBasket.DiscountAmount  = Convert.ToDecimal(listChild[14].Trim() == "" ? "0" : listChild[14].Trim());
                }

                if (listChild[15].Trim() == "")
                {
                    newBasket.ExciseTax = 0;
                }
                else
                {
                    newBasket.ExciseTax = Convert.ToDecimal(listChild[15].Trim() == "" ? "0" : listChild[15].Trim());
                }

                
                if (listChild[16].Trim() != "")
                {
                    newBasket.Tax = Convert.ToDecimal(listChild[16].Trim() == "" ? "0" : listChild[16].Trim());
                }

                if (listChild[17].Trim() != "")
                {
                    newBasket.InvoiceQty = Convert.ToDecimal(listChild[17].Trim() == "" ? "0" : listChild[17].Trim());//taxValues
                }              
                       
                               
                newBasket.UnitPrice = Convert.ToDecimal(listChild[11].Trim() == "" ? "0.00" : listChild[11].Trim());
               // newBasket.TSellingPrice = Convert.ToDecimal(listChild[17].Trim() == "" ? "0.00" : listChild[17].Trim());//discountvalue
               

                newBasket.CstTax  = Convert.ToDecimal(listChild[18].Trim() == "" ? "0.00" : listChild[18].Trim());//CsTax
                newBasket.CsTaxAmount = Convert.ToDecimal(listChild[19].Trim() == "" ? "0.00" : listChild[19].Trim());//CstAmout
               
                
                newBasket.MRP = Convert.ToDecimal(listChild[20].Trim() == "" ? "0" : listChild[20].Trim());                                                         
                newBasket.SellingUnit = listChild[10].Trim();
                newBasket.RcvdLSUQty = Convert.ToDecimal(listChild[22].Trim() == "" ? "0" : listChild[22].Trim());//totalCost
                newBasket.SalesOrderID = Convert.ToInt64(listChild[23].Trim());
                newBasket.ID = Convert.ToInt64(listChild[24].Trim() == "" ? "0" : listChild[24].Trim());
                newBasket.StockInHandID = Convert.ToInt64(listChild[25].Trim());
                newBasket.ParentProductID = Convert.ToInt64(listChild[26].Trim() == "" ? "0" : listChild[26].Trim());
                newBasket.UnitSellingPrice = Convert.ToDecimal(listChild[27].Trim() == "" ? "0" : listChild[27].Trim());//UnitSellingPrice
                newBasket.ProductKey = listChild[28].Trim();
                         
                newBasket.InHandQuantity = 0;
                newBasket.ParentProductKey = "";
                lstReceivedItemsBasket.Add(newBasket);
            }
        }
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
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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


    public void GetCustomers()
    {
        try
        {
            long returnCode = -1;
            List<Customers> lstcust = new List<Customers>();
            List<CustomerLocations> lstCustomeLocation = new List<CustomerLocations>();
            List<CustomerLocations> lstCustomeLocation1= new List<CustomerLocations>();

           if (Request.QueryString["CID"] != null && Request.QueryString["CID"] != "")
            {

                Customerid = Convert.ToInt32(Request.QueryString["CID"]);
            }
            returnCode = inventorySalesBL.GetCustomersList(OrgID, ILocationID , out lstcust, out lstCustomeLocation);

            ddlCustomer.DataSource = lstcust;
            ddlCustomer.DataTextField = "CustomerName";
            ddlCustomer.DataValueField = "CustomerID";
            ddlCustomer.DataBind();
            ddlCustomer.Items.Insert(0, new ListItem("----Select----", "0"));
            ddlCustomer.Items[0].Selected = true;

            lstCustomeLocation1 = lstCustomeLocation.FindAll (P => P.CustomerID == Customerid);
            ddlSupplier.DataSource = lstCustomeLocation1;
            ddlSupplier.DataTextField = "LocationName";
            ddlSupplier.DataValueField = "LocationID";
            ddlSupplier.DataBind();
            ddlSupplier.Items.Insert(0, "--Select--");
            ddlSupplier.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Customers list", ex);
        }

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
            InventorySales_BL inventoryBLs = new InventorySales_BL(base.ContextInfo);
            List<Suppliers> lstSuppliers = new List<Suppliers>();
            List<InventoryItemsBasket> lstTempSrd = new List<InventoryItemsBasket>();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            List<SupplierCreditorDebitNote> lstSCDN = new List<SupplierCreditorDebitNote>();
            //hdnProductList.Value = "";
          //  returnCode = inventoryBLs.GetStockReceivedPODetails(OrgID, ILocationID, InventoryLocationID, purchaseOrderNo, supplierID, out lstSuppliers, out lstInventoryItemsBasket, out lstTempSrd, out lstSCDN);
            if (supplierID > 0)
            {
                //if (lstSCDN.Count != 0)
                //    hdnAvailableCreditAmount.Value = hdnAvailableCreditAmount.Value = Convert.ToString(lstSCDN[0].CreditAmount - lstSCDN[0].UsedAmount);
                //else
                //    hdnAvailableCreditAmount.Value = "0.00";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "  Tblist();", true);

            }
            ddlSupplier.Focus();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Sales Order Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

  

  
}