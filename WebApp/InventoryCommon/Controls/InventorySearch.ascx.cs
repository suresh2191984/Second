using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Utility;
//using Attune.Kernel.Shared.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;

public partial class InventoryCommon_Controls_InventorySearch : Attune_BaseControl
{
    public InventoryCommon_Controls_InventorySearch()

        : base("InventoryCommon_Controls_InventorySearch_ascx")
    { }
    //private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    long returnCode = 0;
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    InventoryCommon_BL inventoryBL;
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadSupplier();
            LoadStockTypes();
            loadStatus();
            loadActionValue();
            txtOrderDate.Text = DateTimeNow.ToExternalDate();
            txtOrdertodate.Text = DateTimeNow.ToExternalDate();
            BindDefaultdetails();
            chkSetDefault.Checked = true;
            //if (Request.QueryString["ACN"] != null)
            //{
            //    string[] strACN = Request.QueryString["ACN"].Split('~');
            //    if (strACN.Length == 7)
            //    {
            //        ddlSearchType.SelectedValue = strACN[0] + "~" + strACN[1];

            //        hdnStatusId.Value = strACN[2];

            //        ddlStatus.SelectedValue = strACN[2];
            //        txtNumber.Text = strACN[3];
            //        ddlSupplierList.SelectedValue = strACN[4];
            //        if (strACN[5] != "")
            //        {
            //            txtOrderDate.Text = Convert.ToDateTime(strACN[5]).ToString("dd/MM/yyyy");
            //        }

            //        //if (strACN[2] != "")
            //        //{
            //        //    ddlStatus.SelectedValue = strACN[2].ToString();
            //        //}

            //        if (strACN[6] != "")
            //        {
            //            grdResult.PageIndex = int.Parse(strACN[6]);

            //        } 
            //        BindData(); 
            //    }
            //}
        }
        AutoCompleteSearchNo.ContextKey = ddlSearchType.SelectedValue.ToString();
    }
    public void LoadSupplier()
    {
        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
            if (returnCode == 0)
            {
                ddlSupplierList.DataSource = lstSuppliers;
                ddlSupplierList.DataTextField = "SupplierName";
                ddlSupplierList.DataValueField = "SupplierID";
                ddlSupplierList.DataBind();

            }
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSupplierList.Items.Insert(0, ddlselect);
           // ddlSupplierList.Items.Insert(0, GetMetaData("Select", "0"));
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
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);
            if (returnCode == 0)
            {
                collectStatus(lstStockStatus);
                ddlSearchType.DataSource = lstStockType;
                ddlSearchType.DataTextField = "StockTypeName";
                ddlSearchType.DataValueField = "StockTypeValues";
                ddlSearchType.DataBind();
            }
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSearchType.Items.Insert(0, ddlselect);
           // ddlSearchType.Items.Insert(0, GetMetaData("Select", "0"));
            ddlSearchType.Items[0].Value = "0";


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Stock Types.", ex);
        }
    }
    private void loadStatus()
    {

        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);
            var templist = from s in lstStockStatus
                           where s.StockTypeID == int.Parse(ddlSearchType.SelectedValue.Split('~')[0])
                           orderby s.StockStatusName
                           select s;
            ddlStatus.DataSource = templist;
            ddlStatus.DataTextField = "StockStatusName";
            ddlStatus.DataValueField = "StockStatusID";
            ddlStatus.DataBind();
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlStatus.Items.Insert(0, ddlselect);
          //  ddlStatus.Items.Insert(0, GetMetaData("Select", "0"));
            ddlStatus.Items[0].Value = "0";
            hdnStatusId.Value = ddlStatus.SelectedValue;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadStatus", ex);
        }
    }
    protected void loadActionValue()
    {
        try
        {
            int _searchType = 0;
            var searchType = ddlSearchType.SelectedValue.Split('~');
            if (searchType != null && searchType.Length > 1)
            {
                int.TryParse(searchType[1].ToString(), out _searchType);
            }
            returnCode = new ActionManager_BL(base.ContextInfo).GetActions(RoleID, _searchType, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            dList.Items.Clear();
            foreach (ActionMaster src in lstActionMaster)
            {
                dList.Items.Add(new ListItem(src.ActionName, src.PageURL + "~" + src.ActionID));
                if (isCorporateOrg == "Y")
                {
                    if ((searchType[1].ToString() == "15") && (hdnStatusId.Value == "9"))
                    {
                        dList.Items.Remove(dList.Items.FindByText("Return Stock"));
                    }
                }
               
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - loadActionValue", ex);
        }
    }

    private void collectStatus(List<StockStatus> lstStatus)
    {
        foreach (StockStatus item in lstStatus)
        {
            hdnStatusCollection.Value += item.StockStatusID.ToString() + "~" + item.StockStatusName + "~" + item.StockTypeID.ToString() + "^";
        }
    }

    //protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    loadStatus();
    //} 

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            grdResult.PageIndex = 0;
            SaveSetDefault();
            BindData();
            
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Page Load - loadActionValue", ex);
        }

    }

    public void BindData()
    {
        GetinventoryDetails();
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ReBindOldValue", "  javascript:doBindStockStatus();", true);
        loadActionValue();
    }

    private void GetinventoryDetails()
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        long returnCode = -1;
        int flag = -1;
        string orderNumber = string.Empty;
        string status = string.Empty;
        int supplierID = 0;
        String SuppliersName = string.Empty;

        DateTime orderDate = Convert.ToDateTime("01/01/1753 00:00:00");
        DateTime ordertoDate = Convert.ToDateTime("01/01/1753 00:00:00");
        flag = Convert.ToInt32(ddlSearchType.SelectedValue.Split('~')[0]);

        if (txtNumber.Text != "")
        {
            orderNumber = txtNumber.Text;
        }
        if (ddlSupplierList.SelectedValue != "0")
        {
            supplierID = Convert.ToInt32(ddlSupplierList.SelectedValue);
        }
        if (txtOrderDate.Text != "")
        {
            orderDate = txtOrderDate.Text.ToInternalDate();
        }
        if (txtOrdertodate.Text != "")
        {
            ordertoDate = txtOrdertodate.Text.ToInternalDate();
        }
        status = hdnStatusId.Value == "" ? "0" : hdnStatusId.Value;

        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        List<InventoryConfig> sellingUnit = new List<InventoryConfig>();
        try
        {
            returnCode = inventoryBL.GetInventoryDetails(flag, orderNumber, orderDate, supplierID, OrgID, ILocationID, InventoryLocationID, status, LanguageCode, out lstOrders, out lstInventoryItemsBasket, ordertoDate);
            //returnCode = inventoryBL.GetInventoryDetails(flag, orderNumber, orderDate, supplierID, OrgID, ILocationID, InventoryLocationID, status, LanguageCode, out lstOrders, out lstInventoryItemsBasket);
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
            string Message = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_10;
            if (Message == null)
            {
                Message="No Matching Records Found!";
            }
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = Message;
        }
    }
    //To Remove/Hide Column in the Gried View
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
            int selectrole = Convert.ToInt32(ddlSearchType.SelectedValue.Split('~')[0]);
           
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                List<InventoryItemsBasket> tempList = new List<InventoryItemsBasket>();
                InventoryOrdersMaster IOM = (InventoryOrdersMaster)e.Row.DataItem;
                tempList = lstInventoryItemsBasket.FindAll(p => p.ID == IOM.OrderID);
                string strScript = "SelectINVRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + IOM.OrderID + "','" + IOM.Status + "','" + IOM.BranchID + "','" + IOM.ReferenceNo + "','" + IOM.StatusID + "','" + IOM.OrderNo + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.className='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                string strtemp = GetToolTip(tempList, ddlSearchType.SelectedItem.Text);
                if (ddlSearchType.SelectedItem.Text != "Quotation")
                {
                    e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[2].Attributes.Add("onmouseout", "this.className='black';hideTooltip();");
                    e.Row.Cells[2].Attributes.Add("class", "bluecolor");
                e.Row.Cells[4].Visible = false;
                if (selectrole == 7)
                {
                    e.Row.Cells[8].Visible = false;
                }
            }
        }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error in Page Load - grdResult_RowDataBound", Ex);
        }
    }


    private string GetToolTip(List<InventoryItemsBasket> tempList, string pType)
    {
        string TableHead = "";
        string TableDate = "";
        switch (pType)
        {
            case "Purchase Order":
            case "Stock Issued":
            case "Stock Damage":
            case "Stock Return":
            case "Stock Usage":
            case "Quotation":
            case "Adhoc": TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr class=\"bold\"><td> " + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_11 + " </td><td>" + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_12 + "</td><td>" + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_13 + "</td></tr>";
                foreach (InventoryItemsBasket item in tempList)
                {
                    TableDate += "<tr>  <td>" + item.ProductName + "</td><td>" + item.Quantity.ToString() + "</td><td>" + item.Unit + "</td></tr>";
                }
                break;

            case "Stock Received":
                TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr class=\"bold\"><td>" + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_11 + "</td><td>" + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_14 + "</td><td>" + Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_InventorySearch_ascx_15 + "</td></tr>";
                foreach (InventoryItemsBasket item in tempList)
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
           // hdnStatusId.Value = ddlStatus.SelectedValue;

            BindData();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            ddlSearchType.ClearSelection();
            ddlStatus.ClearSelection();
            ddlSupplierList.ClearSelection();
            txtOrderDate.Text = "";
            txtOrdertodate.Text = "";
            txtNumber.Text = "";
            chkSetDefault.Checked = true;
            btnSearch_Click(sender, e);
            chkSetDefault.Checked = false;
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "recalldatepicker();", true);
    }



    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            string queryString = string.Empty;
            string strActions = "";
            string id = string.Empty;
            string SupplierID = hdnSupplierID.Value.Split('~')[0];
            string QuotationID = hdnSupplierID.Value.Split('~')[1];
            string[] listValue = dList.SelectedValue.Split('~');
            strActions = "&ACN=" + ddlSearchType.SelectedValue + "~" + hdnStatusId.Value + "~" + txtNumber.Text + "~" +
                ddlSupplierList.SelectedValue + "~" + txtOrderDate.Text + "~" + grdResult.PageIndex;
            int StatusID = !string.IsNullOrEmpty(statusID.Value) ? Convert.ToInt32(statusID.Value) : 0;
            if (dList.SelectedItem.Text != null)
            {
                switch (dList.SelectedItem.Text)
                {
                    case "Central Approve PO":
                        queryString += listValue[0] + "?Approve=1&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SupplierID=" + SupplierID + "&QuotationID=" + QuotationID;
                        break;
                    case "Approve Order":
                        queryString += listValue[0] + "?Approve=1&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SupplierID=" + SupplierID + "&QuotationID=" + QuotationID;
                        break;
				    case "BarcodeMapping":
                        queryString += listValue[0] + "?Approve=1&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString() + "&SupplierID=" + SupplierID + "&QuotationID=" + QuotationID;
                        break;
                    case "Copy PO":
                        queryString += listValue[0] + "?copo=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Cancel Order":
                        queryString += listValue[0] + "?can=1&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Edit Approved Order":
                        if (Bid.Value == ((int)StockReceivedTypes.QuickStockRecd).ToString())
                        {
                            queryString += listValue[0] + "?sType=Qui&ed=2&sID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        else
                        {
                            queryString += listValue[0] + "?ed=2&ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        }
                        break;
                    case "View Quotation":
                        queryString += listValue[0] + "?QID=" + QuotationID + "&SID=" + SupplierID + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Approve Quotation":
                        //Here PurchaseorderNO.Value==Quotation No
                        queryString += listValue[0] + "?QID=" + QuotationID + "&SID=" + SupplierID + "&QNO=" + PurchaseorderNO.Value + "&GVPI=" + grdResult.PageIndex.ToString();
                        break;
                    case "Product BarCode":
                        //Here PurchaseorderNO.Value==Quotation No
                        queryString += listValue[0] + "?ID=" + pid.Value;
                        break;

                    default:
                        if (StatusID > 0 && listValue[0] != "/StockReceived/ViewStockReceived.aspx" && listValue[0] != "/CentralReceiving/ViewStockReceivedByCategory.aspx")
                        {
                            string redirectPage = "/CentralPurchasing/ViewPurchaseOrderMedal.aspx";
                            queryString += redirectPage + "?ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();

                        }
                        else
                        {
                            queryString += listValue[0] + "?ID=" + pid.Value + "&GVPI=" + grdResult.PageIndex.ToString();

                        }
                        break;
                }
            }
            Response.Redirect(Request.ApplicationPath + queryString + strActions, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    public void BindDefaultdetails()
    {
        long returncode = -1;
        List<InventoryProfile> lstprofile = new List<InventoryProfile>();
        returncode = new InventoryCommon_BL(base.ContextInfo).GetInventoryDefaultFilter(LID, RoleID, OrgID, "InventorySearch", out lstprofile);
        if (lstprofile.Count > 0)
        {
            txtOrderDate.Text = lstprofile[0].FromDate;
            txtOrdertodate.Text = lstprofile[0].ToDate;
            txtNumber.Text = lstprofile[0].SearchNumber;
            ddlSearchType.SelectedIndex = ddlSearchType.Items.IndexOf(ddlSearchType.Items.FindByValue(lstprofile[0].SearchType.ToString()));
            loadStatus();
            ddlStatus.SelectedIndex = ddlStatus.Items.IndexOf(ddlStatus.Items.FindByValue(lstprofile[0].Status.ToString()));
            hdnStatusId.Value = lstprofile[0].Status.ToString();
            ddlSupplierList.SelectedIndex = ddlSupplierList.Items.IndexOf(ddlSupplierList.Items.FindByValue(lstprofile[0].SupplierID.ToString()));
            grdResult.PageIndex = 0;
            BindData();
        }
    }

    protected void SaveSetDefault()
    {

        InventoryCommon_BL taskBL = new InventoryCommon_BL();
        long retval = -1;
        InventoryProfile taskprofile = new InventoryProfile();
        try
        {

            taskprofile.LoginID = LID;
            taskprofile.RoleID = Convert.ToInt64(RoleID);
            taskprofile.OrgID =   OrgID  ;
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.Type = "InventorySearch";
            taskprofile.Location = 0;
            taskprofile.FromDate = txtOrderDate.Text;
            taskprofile.ToDate = txtOrdertodate.Text;
            taskprofile.IndentType = 0;
            taskprofile.OrgAddressID = ILocationID;
            taskprofile.SearchNumber = txtNumber.Text;
            taskprofile.Status = Convert.ToInt32(hdnStatusId.Value);//ddlStatus.SelectedItem.Value);
            taskprofile.SupplierID = Convert.ToInt32(ddlSupplierList.SelectedItem.Value); ;
            taskprofile.SearchType =  ddlSearchType.SelectedItem.Value;
            if (chkSetDefault.Checked)
            {
                retval = taskBL.InsertInventorySetDefault(taskprofile.LoginID, taskprofile.RoleID, taskprofile.OrgID, taskprofile.OrgAddressID, taskprofile.FromDate, taskprofile.ToDate, taskprofile.Location, taskprofile.Status, taskprofile.SearchType, taskprofile.IndentType, taskprofile.SearchNumber, taskprofile.SupplierID, taskprofile.Type);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving inventory search details.", ex); ;

        }
    }
}
