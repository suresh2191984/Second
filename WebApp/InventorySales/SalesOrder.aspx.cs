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
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections.Generic;
using System.Linq;

public partial class InventorySales_SalesOrder : Attune_BasePage
{
    long SalesOrderID = -1;
    InventorySales_BL inventorySalesBL;
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            GetCustomers();
            if (Request.QueryString["SID"] != "0" && Request.QueryString["SID"] != null)
            {
                hdnsalesorderid.Value = Request.QueryString["SID"].ToString();
                drpCustomerName.Enabled = false;
                txtDeliveryDate.Enabled = false;
                ddlCustomerLocation.Enabled = false;
      
                //txtInvoiceNo.Enabled = false;
                //txtDcNo.Enabled = false;
                GetSalesDetailsData();
            }
            txtDeliveryDate.Text = DateTime.Now.ToExternalDate();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Sales_Order_Booking_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    btnApprove_Click(sender, e);
                }
            }
        }
        txtDeliveryDate.Attributes.Add("onchange", "ExcedDate('" + txtDeliveryDate.ClientID.ToString() + "','',0,0);");
    }
    public void GetSalesDetailsData()
    {
        try
        {
            hdnsalesorder.Value="";
       
            long returnCode = -1;
            long salesorderid=Convert.ToInt64(Request.QueryString["SID"]);
            List<SalesOrders> lstsalesorders = new List<SalesOrders>();
            List<SalesOrderDetails> lstsalesdetails=new List<SalesOrderDetails>();
            List<LoginName> lstUser = new List<LoginName>();
            returnCode = inventorySalesBL.Getsalesorderdata(OrgID, ILocationID, InventoryLocationID, salesorderid, out lstsalesorders,out lstsalesdetails);
            if (lstsalesdetails.Count > 0)
            {
                btnApprove.Visible = true;
                foreach (SalesOrderDetails det in lstsalesdetails)
                {
                    hdnsalesorder.Value += det.Description + "^";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadsalesdetorder", "Tblist();", true);
            }
            if (lstsalesorders.Count > 0)
            {
                drpCustomerName.SelectedValue = lstsalesorders[0].CustomerID.ToString();
                ScriptManager.RegisterStartupScript(Page, GetType(), "loadcustomerLocation", "GetCustomerLocationlist();", true);
               
                ScriptManager.RegisterStartupScript(Page, GetType(), "customerLocation", "setCustomerLocation('"+lstsalesorders[0].CLocationID+"');", true);
                //ddlCustomerLocation.SelectedValue = lstsalesorders[0].CLocationID.ToString();
                txtTermscond.Text = lstsalesorders[0].Termsconditions;
                //txtInvoiceNo.Text = lstsalesorders[0].InvoiceNo;
                txtComments.Text = lstsalesorders[0].Comments;
                txtDeliveryDate.Text = lstsalesorders[0].DeliveryDate.ToExternalDate();
                

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while get sales order data", ex); 
        }
    }
    public void GetCustomers()
    {
        try
        {
            long returnCode = -1;
            ListItem ddlSelect = GetMetaData("Select", "0");
            if (ddlSelect == null)
                ddlSelect = new ListItem() { Text = "Select", Value = "0" };
            List<Customers> lstcust = new List<Customers>();
            List<CustomerLocations> lstCustomeLocation = new List<CustomerLocations>();
            returnCode = inventorySalesBL.GetCustomersList(OrgID, InventoryLocationID, out lstcust, out lstCustomeLocation);

            drpCustomerName.DataSource = lstcust;
            drpCustomerName.DataTextField = "CustomerName";
            drpCustomerName.DataValueField = "CustomerID";
            drpCustomerName.DataBind();
            drpCustomerName.Items.Insert(0, ddlSelect);
            drpCustomerName.Items[0].Selected = true;

            ddlCustomerLocation.Items.Insert(0, ddlSelect);
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
    public void ListProducts(string status,long orderid)
    {

        long returnCode = -1;
        InventorySales_BL InventoryBL = new InventorySales_BL(base.ContextInfo);
        List<SalesItemBasket> lstItemBasket = new List<SalesItemBasket>();
        string deliverydate = txtDeliveryDate.Text.ToInternalDate().ToString();
        try
        {
            foreach (string listParent in hdnsalesorder.Value.Split('^'))
            {
                if (listParent != "")
                {
                    SalesItemBasket ItemBasket = new SalesItemBasket();
                    string[] listChild = listParent.Split('~');

                    ItemBasket.ID = 0;
                    if (listChild[8].ToString() != "0")
                    {
                        ItemBasket.ID = Convert.ToInt64(listChild[8]);
                    }
                    ItemBasket.ProductName = listChild[0].ToString();
                    ItemBasket.Unit = listChild[1].ToString();
                    ItemBasket.Quantity = Convert.ToDecimal(listChild[2]);
                    ItemBasket.Rate = Convert.ToDecimal(listChild[3]);
                    ItemBasket.Amount = Convert.ToDecimal(listChild[4]);
                    ItemBasket.ParentProductID = Convert.ToInt64(listChild[5]);
                    ItemBasket.ProductID = Convert.ToInt64(listChild[6]);
                    ItemBasket.Manufacture = DateTimeUtility.GetServerDate();
                    ItemBasket.ExpiryDate = DateTimeUtility.GetServerDate();
                    ItemBasket.SalesOrderID = Convert.ToInt64(listChild[7]);
                    ItemBasket.CustomerLocationID = Convert.ToInt32(hdnLocation.Value) > 0 ? Convert.ToInt32(hdnLocation.Value) : 0;
                    lstItemBasket.Add(ItemBasket);
                }
            }
            int custid = Convert.ToInt32(drpCustomerName.SelectedValue);
            returnCode = inventorySalesBL.SaveSalesOrder(OrgID, ILocationID, InventoryLocationID, lstItemBasket, deliverydate, LID, status,
                                                            custid, txtComments.Text, txtTermscond.Text, "", "",
                                                            Convert.ToDecimal(txtgrdtotal.Text), out SalesOrderID);
            if (returnCode > 0 && SalesOrderID > 0)
            {
                Response.Redirect(@"..\InventorySales\SalesOrderPrint.aspx?SID=" + SalesOrderID + "&OrgID=" + OrgID, true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSorder", "alert('Record Inserted Successfully');", true);
                drpCustomerName.SelectedItem.Value = "0";
                txtDeliveryDate.Text = "";
                txtComments.Text = "";
                txtTermscond.Text = "";
                hdnsalesorder.Value = "";


            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Sales Order list", ex);
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        #region comments
        //long returnCode = -1;
        //Inventory_BL InventoryBL = new Inventory_BL(base.ContextInfo);
        //List<SalesItemBasket> lstItemBasket = new List<SalesItemBasket>();
        //string deliverydate = txtDeliveryDate.Text;
        //string status="Pending";
        //try
        //{
        //    foreach (string listParent in hdnsalesorder.Value.Split('^'))
        //    {
        //        if (listParent != "")
        //        { 
        //            SalesItemBasket ItemBasket = new SalesItemBasket();
        //            string[] listChild = listParent.Split('~');
        //            ItemBasket.ID = 0;
        //            ItemBasket.ProductName = listChild[0].ToString();
        //            ItemBasket.Unit = listChild[1].ToString();
        //            ItemBasket.Quantity = Convert.ToDecimal(listChild[2]);
        //            ItemBasket.Rate = Convert.ToDecimal(listChild[3]);
        //            ItemBasket.Amount = Convert.ToDecimal(listChild[4]);
        //            ItemBasket.parentProductID = Convert.ToInt64(listChild[5]);
        //            ItemBasket.ProductID = Convert.ToInt64(listChild[6]);
        //            ItemBasket.Manufacture = DateTimeUtility.GetServerDate();
        //            ItemBasket.ExpiryDate = DateTimeUtility.GetServerDate();
        //            ItemBasket.SalesOrderID = 0;
        //            //lstItemBasket.Add(ItemBasket);
        //        }
        //    }
        //    int custid = Convert.ToInt32(drpCustomerName.SelectedValue);
        //    returnCode = inventorySalesBL.SaveSalesOrder(OrgID, ILocationID, InventoryLocationID, lstItemBasket, deliverydate, LID, status, custid, txtComments.Text, txtTermscond.Text, txtInvoiceNo.Text.Trim(),txtDcNo.Text.Trim(), out SalesOrderID);
        //    if (returnCode > 0 && SalesOrderID >0)
        //   {
        //       Response.Redirect(@"..\InventorySales\SalesOrderPrint.aspx?SID=" + SalesOrderID + "&OrgID=" + OrgID, true);
        //       //ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSorder", "alert('Record Inserted Successfully');", true);
        //       drpCustomerName.SelectedItem.Value = "0";
        //       txtDeliveryDate.Text = "";
        //       txtComments.Text = "";
        //       txtTermscond.Text = "";
        //       hdnsalesorder.Value = "";

        //   }
            
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error while Sales Order list", ex);
        //}
        #endregion
        string status = "Booking";
        long orderid = Convert.ToInt64(hdnsalesorderid.Value);
        ListProducts(status,orderid);
    } 
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        string status = "Approved";
        long orderid = Convert.ToInt64(hdnsalesorderid.Value);
        ListProducts(status, orderid);
    }
}
