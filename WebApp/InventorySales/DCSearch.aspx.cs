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

public partial class InventorySales_DCSearch : Attune_BasePage 
{
    public InventorySales_DCSearch()
        : base("InventorySales_InventorySales_DCSearch_aspx")
    {
    }
    InventorySales_BL inventorySalesBL;
    long returnCode = 0;
    //string InvoiceNo = "";
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<SalesItemBasket> lstSalesItemsBasket = new List<SalesItemBasket>();
    List<SalesOrderOutFlowDetails> lstSalesOrderOutFlow = new List<SalesOrderOutFlowDetails>();
    protected void Page_Load(object sender, EventArgs e)
    {
        inventorySalesBL = new InventorySales_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            txtFrom.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            txtTo.Text = DateTimeUtility.GetServerDate().ToExternalDate();
            txtFrom.Focus();
            LoadSupplier(); 
            GetCustomers();
            loadActionValue();
            LoadStockTypes();
            loadStatus();
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
            ddlSupplierList.Items.Insert(0,GetMetaData("-----Select-----","0"));
            ddlSupplierList.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Supplier Details.", ex);
        }
    }
    private void LoadStockTypes()
    {
        try
        {
            //returnCode = inventoryBL.GetStockStatus(out lstStockStatus, out lstStockType);
            //if (returnCode == 0)
            //{
            //    collectStatus(lstStockStatus);
            //    ddlSearchType.DataSource = lstStockType;
            //    ddlSearchType.DataTextField = "StockTypeName";
            //    ddlSearchType.DataValueField = "StockTypeValues";
            //    ddlSearchType.DataBind();
            //}
            //ddlSearchType.Items.Insert(0, "--Select One--");
            //ddlSearchType.Items[0].Value = "0";


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Stock Types.", ex);
        }
    }
    private void collectStatus(List<StockStatus> lstStatus)
    {
        foreach (StockStatus item in lstStatus)
        {
            hdnStatusCollection.Value += item.StockStatusID.ToString() + "~" + item.StockStatusName + "~" + item.StockTypeID.ToString() + "^";
        }
    }
    private void loadStatus()
    {

        try
        {
            returnCode = new InventoryCommon_BL(base.ContextInfo).GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);
            var templist = from s in lstStockStatus
                           //where s.StockTypeID == int.Parse(ddlSearchType.SelectedValue.Split('~')[0])
                           orderby s.StockStatusName
                           select s;
            ddlStatus.DataSource = templist;
            ddlStatus.DataTextField = "StockStatusName";
            ddlStatus.DataValueField = "StockStatusID";
            ddlStatus.DataBind();
            ddlStatus.Items.Insert(0,GetMetaData("--Select One--","0"));
            ddlStatus.Items[0].Value = "0";
            hdnStatusId.Value = ddlStatus.SelectedValue;

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
            ddlCustomerName.Items.Insert(0, GetMetaData("----Select----", "0"));
            ddlCustomerName.Items[0].Selected = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get loadStatus list", ex);
        } 
    }

    protected void loadActionValue()
    {
        try
        {
            returnCode = new ActionManager_BL(base.ContextInfo).GetActions(RoleID, Convert.ToInt16(TaskHelper.SearchType.DCSearch), out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
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
 
    private void GetinventoryDetails()
    {
        long returnCode = -1;
        int CustomerID = -1;
        string orderNumber = string.Empty;
        string DCNumber = string.Empty;
        string status = string.Empty;
        int supplierID = 0;
        string Type = string.Empty;

        DateTime sfromdate = DateTime.MinValue;
        if (!String.IsNullOrEmpty(txtFrom.Text.Trim()))
        {
            sfromdate=txtFrom.Text.Trim().ToInternalDate();
        }
        DateTime sTodate = DateTime.MinValue;
        if (!String.IsNullOrEmpty(txtTo.Text.Trim()))
        {
            sTodate=txtTo.Text.Trim().ToInternalDate();
        }
        String SuppliersName = string.Empty;
        CustomerID = Convert.ToInt32(ddlCustomerName.SelectedValue);

        if (txtNumber.Text != "")
        {
            orderNumber = txtNumber.Text;
        }
        else
        {
            orderNumber = "0";
        }
        if (ddlSupplierList.SelectedValue != "0")
        {
            supplierID = Convert.ToInt32(ddlSupplierList.SelectedValue) > 0 ? Convert.ToInt32(ddlSupplierList.SelectedValue) : 0;
        }
        else
        {
            supplierID = 0;
        }
        if (txtDcNo.Text.Trim() != "")
        {
            DCNumber = txtDcNo.Text.Trim();
        }
        else
        {
            DCNumber = "0";
        }
        status = hdnStatusId.Value == "" ? "0" : hdnStatusId.Value;
        status = "";
        
        List<InventoryConfig> sellingUnit = new List<InventoryConfig>();
        try
        {
            returnCode = inventorySalesBL.GetSalesDCSearch(sfromdate, sTodate, CustomerID, supplierID, orderNumber, DCNumber, status, OrgID, ILocationID, InventoryLocationID, out lstSalesOrderOutFlow, out lstSalesItemsBasket);
        }
        catch
        {
        }
        if (returnCode == 0 && lstSalesItemsBasket.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstSalesItemsBasket;
            grdResult.DataBind();
        }
        else
        {
            string Msg = Resources.InventorySales_AppMsg.InventorySales_DCSearch_aspx_08 != null ? Resources.InventorySales_AppMsg.InventorySales_DCSearch_aspx_08 : "No Matching Records Found!";
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = Msg;
        }
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            string Invoiceno=GenerateInvoice();
            string queryString = string.Empty;
            string strActions = "";
            string id = string.Empty;
            string SupplierID = hdnSupplierID.Value.Split('~')[0];
            string[] listValue = dList.SelectedValue.Split('~');
            strActions = "&ACN=" + TaskHelper.SearchType.SalesOrder + "~" + hdnStatusId.Value + "~" + txtNumber.Text + "~" +
                ddlSupplierList.SelectedValue + "~" + ddlCustomerName.SelectedValue + "~" + grdResult.PageIndex;

            if (dList.SelectedItem.Text != null)
            {
                switch (dList.SelectedItem.Text)
                {
                    case "Approve Order":
                        queryString += listValue[0] + "?Approve=1&SID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SupplierID=" + SupplierID;
                        break;
                    case "Copy PO":
                        queryString += listValue[0] + "?copo=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Generate Invoice":
                        queryString += listValue[0] + "?InvoiceNo=" + Invoiceno.ToString();
                        break;

                    case "Cancel Order":
                        queryString += listValue[0] + "?can=1&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Edit Approved Order":
                        if (Bid.Value == ((int)StockReceivedTypes.QuickStockRecd).ToString())
                        {
                            queryString += listValue[0] + "?sType=Qui&ed=2&SID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        else
                        {
                            queryString += listValue[0] + "?ed=2&SID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        break;
                    default:
                        queryString += listValue[0] + "?SID=" + pid.Value + "&InvoiceNo=" + Invoiceno.ToString() + "&GVPI=" + grdResult.PageIndex.ToString(); ;
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


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetinventoryDetails();
        //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "ReBindOldValue", "  javascript:doBindStockStatus();", true);
        loadActionValue();
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            //if (e.Row.RowType == DataControlRowType.Header)
            //{
            //    CheckBox ChkObj = ((CheckBox)e.Row.Cells[0].FindControl("chkBox1"));
            //    Boolean value = false;
            //    if (ChkObj.Checked == true)
            //    {
            //        value = true;
            //    }
            //    string strScrpt = "SelectAll('document.form1.grdResult.chkAll','" + value + "');";
            //    ChkObj.Attributes.Add("onclick", strScrpt);
            //} 
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<SalesItemBasket> lstSalesItems = new List<SalesItemBasket>();
                SalesItemBasket lstsales = (SalesItemBasket)e.Row.DataItem;
                string strScript = "SelectINVRowCommon('" + ((CheckBox)e.Row.Cells[1].FindControl("chkBox")).ClientID + "','" +
                                                            lstsales.DCNo + "','" + lstsales.SalesOrderID + "','" +lstsales.StockOutFlowID  + "','"+lstsales.ProductName+"');"; 
                ((CheckBox)e.Row.Cells[0].FindControl("chkBox")).Attributes.Add("onclick", strScript); 
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in to select Delivery Chellan ", ex);
        }
    }
    private string GetToolTip(List<SalesItemBasket> tempList)
    {
        string TableHead = "";
        string TableDate = "";
        string sProductName = Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_09 != null ? Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_09 : "Product Name";
        string sQuantity = Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_10 != null ? Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_10 : "Quantity";
        string sUnit = Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_11 != null ? Resources.InventorySales_ClientDisplay.InventorySales_DCSearch_aspx_cs_11 : "Unit";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr style=\"font-weight: bold;\"><td>" + sProductName + "</td><td>" + sQuantity + "</td><td>"+sUnit+"</td></tr>";
        foreach (SalesItemBasket item in tempList)
        {
            TableDate += "<tr>  <td>" + item.Description + "</td><td>" + item.Quantity.ToString() + "</td><td>" + item.Unit + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }
    public string  GenerateInvoice()
    {
        string InvoiceNo = "";
        try
        {
            List<SalesItemBasket> lstSalesItems = new List<SalesItemBasket>();
            var sales = hdntemp.Value.Split('^');
            SalesItemBasket obj;
            for (int i = 0; i < sales.Length; i++)
            {
                obj = new SalesItemBasket();
                if (sales[i] != "")
                {
                    var ps = sales[i].Split('~');
                    obj.Manufacture = DateTimeUtility.GetServerDate();
                    obj.ExpiryDate = DateTimeUtility.GetServerDate();
                    obj.DCNo = ps[0];
                    obj.SalesOrderID = Convert.ToInt64(ps[1]);
                    obj.StockOutFlowID = Convert.ToInt64(ps[2]);
                    lstSalesItems.Add(obj);
                }
            }
            returnCode = inventorySalesBL.GenerateInvoice(OrgID, ILocationID, InventoryLocationID, lstSalesItems,out InvoiceNo);  
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get GenerateInvoice list", ex);
        }
        return InvoiceNo;
    }

  
    protected void btnCancel_Click1(object sender, EventArgs e)
    {
        txtFrom.Text = DateTime.Now.ToExternalDate();
        txtTo.Text = DateTime.Now.ToExternalDate();
        ddlStatus.SelectedIndex = -1;
        ddlCustomerName.SelectedIndex = -1;
        txtDcNo.Text = "";
        txtNumber.Text = "";
        grdResult.DataSource = null;
        grdResult.DataBind();
         
    }
}
