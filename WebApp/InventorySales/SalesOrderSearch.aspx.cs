using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections;
using Attune.Kernel.InventoryCommon.BL;

public partial class InventorySales_SalesOrderSearch :Attune_BasePage 
{
    InventorySales_BL inventorySalesBL;
    long returnCode = 0;
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<SalesItemBasket> lstSalesItemsBasket = new List<SalesItemBasket>();
    InventorySales_BL inventoryBL;
    ListItem ddlSelect;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        inventoryBL = new InventorySales_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadSupplier();
            LoadStockTypes();
            loadStatus();
            GetCustomers();
            loadActionValue();
            ddlSelect = GetMetaData("Select", "0");
            if (ddlSelect == null)
                ddlSelect = new ListItem() { Text = "Select", Value = "0" };
          
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            grdResult.PageIndex = 0;
            BindData();
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Page Load - loadActionValue", ex);
        }

    }

    public void LoadSupplier()
    {
        try
        {
            returnCode = new InventoryCommon_BL(base.ContextInfo).GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            if (returnCode == 0)
            {
                ddlSupplierList.DataSource = lstSuppliers;
                ddlSupplierList.DataTextField = "SupplierName";
                ddlSupplierList.DataValueField = "SupplierID";
                ddlSupplierList.DataBind();

            }
            ddlSupplierList.Items.Insert(0, "-----Select-----");
            ddlSupplierList.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Supplier Details.", ex);
        }
    }

    private void loadStatus()
    {
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;

        try
        {
            returnCode = new InventoryCommon_BL(base.ContextInfo).GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);
            var templist = from s in lstStockStatus
                           where s.StockTypeID == int.Parse(ddlSearchType.SelectedValue.Split('~')[0])
                           orderby s.StockStatusName
                           select s;
            ddlStatus.DataSource = templist;
            ddlStatus.DataTextField = "StockStatusName";
            ddlStatus.DataValueField = "StockStatusID";
            ddlStatus.DataBind();
            ddlStatus.Items.Insert(0, ddlSelect);
            ddlStatus.Items[0].Value = "0";
            hdnStatusId.Value = ddlStatus.SelectedValue;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  executing loadStatus in SalesOrderSearch", ex);
        }
    }

    private void LoadStockTypes()
    {
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;
        try
        {
            returnCode = new InventoryCommon_BL(base.ContextInfo).GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);
            lstStockType.RemoveAll(p => p.StockTypeID <= 7);
            if (returnCode == 0)
            {
                collectStatus(lstStockStatus);
                ddlSearchType.DataSource = lstStockType;
                ddlSearchType.DataTextField = "StockTypeName";
                ddlSearchType.DataValueField = "StockTypeValues";
                ddlSearchType.DataBind();
            }
            ddlSearchType.Items.Insert(0, ddlSelect);
            ddlSearchType.Items[0].Value = "0";
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Stock Types.", ex);
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

            ddlCustomerName.DataSource = lstcust;
            ddlCustomerName.DataTextField = "CustomerName";
            ddlCustomerName.DataValueField = "CustomerID";
            ddlCustomerName.DataBind();
            ddlCustomerName.Items.Insert(0, new ListItem("----Select----", "0"));
            ddlCustomerName.Items[0].Selected = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Customers list", ex);
        }

    }

    protected void loadActionValue()
    {
        try
        {
            returnCode = new ActionManager_BL(base.ContextInfo).GetActions(RoleID, Convert.ToInt16(ddlSearchType.SelectedValue.Split('~')[1]), out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            dList.Items.Clear();
            foreach (ActionMaster src in lstActionMaster)
            {
                dList.Items.Add(new ListItem(src.ActionName, src.PageURL + "~" + src.ActionID));
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionValue", ex);

        }
    }

    public void BindData()
    {
        GetinventoryDetails();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ReBindOldValuea", "  javascript:doBindStockStatus();", true);
       
        loadActionValue();
    }


    private void GetinventoryDetails()
    {
        long returnCode = -1;
        int flag = -1;
        int CustomerID = -1;
        string orderNumber = string.Empty;
        string status = string.Empty;
        int supplierID = 0;
        string Type =string.Empty;

        flag = Convert.ToInt16(ddlSearchType.SelectedValue.Split('~')[1]);
        
        String SuppliersName = string.Empty;

        DateTime orderDate = new DateTime(1753, 1, 1) ;

        CustomerID = Convert.ToInt32(ddlCustomerName.SelectedValue);

        status = hdnStatusId.Value == "" ? "0" : hdnStatusId.Value;
        //status = Convert.ToInt32(ddlStatus.SelectedValue) > 0 ? ddlStatus.SelectedItem.Text : "0";

        if (txtNumber.Text != "")
        {
            orderNumber = txtNumber.Text;
        }
        else
        {
            orderNumber = "";
        }
        //if (txtDCNumber.Text != "")
        //{
        //    Type = txtDCNumber.Text;
        //}
        //else
        //{
        //    Type = "0";
        //}
        Type = "";
        if (ddlSupplierList.SelectedValue != "0")
        {
            supplierID = Convert.ToInt32(ddlSupplierList.SelectedValue) > 0 ? Convert.ToInt32(ddlSupplierList.SelectedValue) : 0;
        }
        else
        {
            supplierID = 0;
        }
        if (txtOrderDate.Text != "")
        {
            orderDate = txtOrderDate.Text.ToInternalDate();
        }
       

        List<SalesItemBasket> lstOrders = new List<SalesItemBasket>();
        List<InventoryConfig> sellingUnit = new List<InventoryConfig>();
        try
        {
            returnCode = inventorySalesBL.GetSalesOrderSearch(CustomerID, orderNumber, orderDate, supplierID, OrgID, ILocationID, status, InventoryLocationID, Type, flag, out lstOrders, out lstSalesItemsBasket);
        }
        catch
        {
        }
        if (returnCode == 0 && lstOrders.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstOrders;
            grdResult.DataBind();
        }
        else
        {
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No Matching Records Found!";
        }
    }

    protected void grdResult_OnRowCreated(object sender, GridViewRowEventArgs e)
    {
        int selectrole = Convert.ToInt32(ddlSearchType.SelectedValue.Split('~')[0]);

        if (selectrole == 4 || selectrole == 5 || selectrole == 6)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[7].CssClass = "hiddencol";
            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[7].CssClass = "hiddencol";
            }
        }
    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            int flag = Convert.ToInt16(ddlSearchType.SelectedValue.Split('~')[1]);
            int selectrole = Convert.ToInt32(4);
            e.Row.Cells[4].Visible = false;
            if (selectrole == 7)
            {
                e.Row.Cells[8].Visible = false;
            }
            if (flag == 40)
            {
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[9].Visible = false;
            }
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<SalesItemBasket> tempList = new List<SalesItemBasket>();
                SalesItemBasket  IOM = (SalesItemBasket)e.Row.DataItem;
                tempList = lstSalesItemsBasket.FindAll(p => p.ID  == IOM.ID);
                string strScript = "SelectINVRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + IOM.ID + "','" + IOM.RakNo + "','" + 
                                                                IOM.StockInHandID + "','" + IOM.SalesOrderID + "','" + IOM.StockOutFlowID + "','" +
                                                                                        IOM.SupplierId + "','"+IOM.InvoiceNo+"');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
               
                if (flag != 39 && flag !=40)
                {
                    string strtemp = GetToolTip(tempList, "Sales Order");
                    //if ( != "Sales Order")
                    //{
                    e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[2].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                    e.Row.Cells[2].Attributes.Add("class", "cust1blue");
                    //}
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  executing grdResult_RowDataBound in SalesOrderSearch", ex);
        }
    }

    private string GetToolTip(List<SalesItemBasket> tempList, string pType)
    {
        string TableHead = "";
        string TableDate = "";
        switch (pType)
        {
            case "Purchase Order":
            case "Stock Issued":
            case "Stock Damage":
            case "Stock Return":
            case "Quotation":
            case "Sales Order":
            case "Adhoc": TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr style=\"font-weight: bold;\"><td>Product Name</td><td>Quantity</td><td>Unit</td></tr>";
                foreach (SalesItemBasket item in tempList)
                {
                    TableDate += "<tr>  <td>" + item.ProductName + "</td><td>" + item.Quantity.ToString() + "</td><td>" + item.Unit + "</td></tr>";
                }
                break;

            case "Stock Received":
                TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr style=\"font-weight: bold;\"><td>Product Name</td><td>PO Qty</td><td>Rcvd Qty</td></tr>";
                foreach (SalesItemBasket item in tempList)
                {
                    TableDate += "<tr>  <td>" + item.ProductName.Replace("'", "") + "</td><td>" + item.POQuantity.ToString() + "(" + item.POUnit.ToString() + ")</td><td>" + item.RECQuantity + "(" + item.RECUnit.ToString() + ")</td></tr>";
                }
                break;
        }
        return TableHead + TableDate + "</table> ";
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            hdnStatusId.Value = ddlStatus.SelectedValue;

            BindData();
        }
    }
    private void collectStatus(List<StockStatus> lstStatus)
    {
        foreach (StockStatus item in lstStatus)
        {
            hdnStatusCollection.Value += item.StockStatusID.ToString() + "~" + item.StockStatusName + "~" + item.StockTypeID.ToString() + "^";
        }
    }


    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            string queryString = string.Empty;
            string strActions = "";
            string id = string.Empty;
            string SupplierID = hdnSupplierID.Value.Split('~')[0];
            string[] listValue = dList.SelectedValue.Split('~');
            strActions = "&ACN=" + TaskHelper.SearchType.SalesOrder + "~" + hdnStatusId.Value + "~" + txtNumber.Text + "~" +
                ddlSupplierList.SelectedValue + "~" + txtOrderDate.Text.ToInternalDate().ToString() + "~" + grdResult.PageIndex;

            if (dList.SelectedItem.Text != null)
            {
                switch (dList.SelectedItem.Text)
                {
                    case "Approve Order":
                        queryString += listValue[0] + "?Approve=1&SID=" + hdnID.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SupplierID=" + SupplierID;
                        break;
                    case "Copy PO":
                        queryString += listValue[0] + "?copo=" + hdnID.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Cancel Order":
                        queryString += listValue[0] + "?can=1&ID=" + hdnID.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SID=" + hdnSalesOrderID.Value + "&SOFD=" + hdnSOFD.Value + "&CID=" + hdnCID.Value + "&InvoiceNo=" + hdninvoiceno.Value.ToString(); 
                        break;
                    case "View & Print Order":
                        queryString += listValue[0] + "?GVPI=" + grdResult.PageIndex.ToString() + "&SID=" + hdnSalesOrderID.Value + "&SOFD=" + hdnSOFD.Value + "&CID=" + hdnCID.Value + "&InvoiceNo=" + hdninvoiceno.Value.ToString(); 
                        break;
                    case "Edit Approved Order":
                        if (Bid.Value == ((int)StockReceivedTypes.QuickStockRecd).ToString())
                        {
                            queryString += listValue[0] + "?sType=Qui&ed=2&SID=" + hdnID.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        else
                        {
                            queryString += listValue[0] + "?ed=2&SID=" + hdnID.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        break;
                    default:
                        queryString += listValue[0] + "?ID=" + pid.Value +"&SID="+hdnSalesOrderID.Value  + "&SOFD=" + hdnSOFD.Value   +"&CID="+ hdnCID.Value + "&GVPI=" + grdResult.PageIndex.ToString(); ;
                        break;
                }
            }
            Response.Redirect(Request.ApplicationPath  + queryString + strActions, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
         txtOrderDate.Text = DateTime.Now.ToExternalDate();
         ddlSearchType.SelectedIndex = 0;
         ddlCustomerName.SelectedIndex = 0;
         ddlStatus.SelectedIndex = 0; 
         txtNumber.Text = "";
         grdResult.DataSource = null;
         grdResult.DataBind();
    } 
}
