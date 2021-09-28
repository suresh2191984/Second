using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.StockReturn.BL;

public partial class StockReturn_StockReturnPayment : Attune_BasePage
{
    public StockReturn_StockReturnPayment()
        : base("StockReturn_StockReturnPayment_aspx")
    {
    }
    InventoryCommon_BL inventoryBL;
    List<Locations> lstLocationName = new List<Locations>();
    List<Locations> lsttempLocationName = new List<Locations>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstIIB1 = new List<InventoryItemsBasket>();
    long returnCode = -1;
    string StockReturnNumber = string.Empty;
    string SRDNo = string.Empty;
    string SupplierName = string.Empty;
    string InvoiceOrDCNo = string.Empty;
    long SupplierID = -1;
    DateTime StockReturnDate = Convert.ToDateTime("01/01/1753 00:00:00");
    ListItem ddlselect = new ListItem();
    string ErrorMsg = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            try
            {
                ddlselect = GetMetaData("Select", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "Select", Value = "0" };
                }
                List<ProductCategories> lstProductCategories = new List<ProductCategories>();
                txtStockReturnDate.Text = DateTimeNow.ToString("dd/MM/yyyy");
                txtStockReceivedDate.Text = DateTimeNow.ToString("dd/MM/yyyy");
                LoadSuppliers();
                mpeAttributeLocation.Hide();
                BindInventoryLocation();
                rdoCreditNote.Checked = true;
                //lblmsg.Text = "Search the Product List";
                //listProducts.Visible = false;
                divCreditNote.Attributes.Add("class", "show");
                grdResult.Attributes.Add("class", "show");
                btnCancel.Attributes.Add("class", "hide");
                btnCancelDebit.Attributes.Add("class", "hide");
                btnReturnStock.Attributes.Add("class", "hide");
                btnUpdateDebit.Attributes.Add("class", "hide");
                divDebitNote.Attributes.Add("class", "hide");
                grdDebit.Attributes.Add("class", "show");
                lblResult.Attributes.Add("class", "hide");
                Label1.Attributes.Add("class", "hide");
                ErrorMsg = Resources.StockReturn_AppMsg.StockReturn_Error ?? Resources.StockReturn_AppMsg.StockReturn_Error;

            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockReturn.aspx", ex);

            }
        }

    }

    private void BindInventoryLocation()
    {
        try
        {
            long iOrgID = Int64.Parse(OrgID.ToString());
            long returnCode = -1;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
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
            Master_BL objMasterBL = new Master_BL();
            returnCode = objMasterBL.GetInvLocationDetail(OrgID, OrgAddid, out lstLocationName);
            lsttempLocationName.Add((lstLocationName.Find(P => P.LocationTypeCode == "CS" || P.LocationTypeCode == "CS-POS")));
            //ddlLocation.DataSource = lsttempLocationName;
            //ddlLocation.DataTextField = "LocationName";
            //ddlLocation.DataValueField = "LocationID";
            //ddlLocation.DataBind();
            //ddlLocation.SelectedValue = lstLocationName.Find(P => P.LocationTypeCode != "CS" || P.LocationTypeCode != "CS-POS").LocationID.ToString();
            lstLocationName.Remove(lstLocationName.Find(P => P.LocationID != InventoryLocationID));
            switch (lstLocationName[0].LocationTypeCode)
            {
                case "POS":
                case "POD":
                    ////ddlLocation.SelectedValue = lstLocationName[0].LocationID.ToString();
                    divLocation.Attributes.Add("class", "show");
                    divSuppliers.Attributes.Add("class", "hide");
                    //hdnIsSupplier.Value = "N";

                    break;
                case "CS":
                case "CS-POS":
                    divLocation.Attributes.Add("class", "hide");
                    break;
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - StockIssued.aspx", ex);
        }
    }

    //private void LoadProductList()
    //{
    //    List<Products> lstProducts = new List<Products>();
    //    inventoryBL.GetAllProductList(OrgID, ILocationID, out lstProducts);
    //    if (lstProducts.Count > 0)
    //    {

    //        listProducts.Visible = true;
    //        lblMsgpro.Text = "Product List (Double click the below list to select the Bacth No.)";
    //        listProducts.DataSource = lstProducts;
    //        listProducts.DataTextField = "ProductName";
    //        listProducts.DataValueField = "ProductID";
    //        listProducts.DataBind();
    //    }
    //    else
    //    {
    //        lblMsgpro.Text = "No matching Product found";
    //        listProducts.Visible = false;
    //    }
    //}

    private void LoadSuppliers()
    {
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        ddlSupplierName.DataSource = lstSuppliers;
        ddlSupplierName.DataTextField = "SupplierName";
        ddlSupplierName.DataValueField = "SupplierID";
        ddlSupplierName.DataBind();
        ddlSupplierName.Items.Insert(0, ddlselect);
        ddlSupplierName.Items[0].Value = "0";
        ddlDebitSupplierName.DataSource = lstSuppliers;
        ddlDebitSupplierName.DataTextField = "SupplierName";
        ddlDebitSupplierName.DataValueField = "SupplierID";
        ddlDebitSupplierName.DataBind();
        ddlDebitSupplierName.Items.Insert(0, ddlselect);
        ddlDebitSupplierName.Items[0].Value = "0";
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
    //    LoadProductsBatchNo(Int64.Parse(listProducts.SelectedValue));
    //    TableProductDetails.Attributes.Add("class", "show");
    //    hdnProductId.Value = listProducts.SelectedValue;
    //    lblTable.Text = tempTable.Value;
    //}

    private void LoadProductsBatchNo(long iProductId)
    {
        try
        {
            //List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            //inventoryBL.GetProductsBatchNo(OrgID, ILocationID, iProductId, out lstInventoryItemsBasket, 0);
            inventoryBL.GetProductsBatchNo(OrgID, ILocationID, InventoryLocationID, iProductId, out lstInventoryItemsBasket, 0);
            //ddlBatchNo.DataSource = lstInventoryItemsBasket;
            //ddlBatchNo.DataTextField = "BatchNo";
            //ddlBatchNo.DataValueField = "description";
            //ddlBatchNo.DataBind();
            //ddlBatchNo.Items.Insert(0, "--Select--");
            //ddlBatchNo.Items[0].Value = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load Products Batch No - StockReturn.aspx", ex);
        }

    }

    protected void btnUpdateAmount_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        int count = 0;
        int n = 0;
        string userMsg = string.Empty;
        try
        {
            foreach (GridViewRow gr in grdResult.Rows)
            {
                InventoryItemsBasket objItems = new InventoryItemsBasket();
                CheckBox chk1 = (CheckBox)gr.FindControl("chkBox");
                TextBox txt1 = (TextBox)gr.FindControl("txtApprovedAmount");
                TextBox txt2 = (TextBox)gr.FindControl("txtReferenceNo");
                if (chk1.Checked == true)
                {
                    count = count + 1;
                    if (txt1.Text != "")
                    {
                        if (Convert.ToDecimal(txt1.Text) > Convert.ToDecimal(gr.Cells[3].Text.ToString()))
                        {
                            n = n + 1;
                            txt1.Focus();
                            userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_01 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_01;
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                        }
                        else
                        {
                            objItems.ID = Convert.ToInt32(grdResult.DataKeys[gr.RowIndex].Values[0]);
                            objItems.SupplierId = Convert.ToInt32(grdResult.DataKeys[gr.RowIndex].Values[1]);
                            objItems.Amount = Convert.ToDecimal(txt1.Text.ToString());
                        }
                    }
                    else if (txt1.Text == "")
                    {
                        n = n + 1;
                        txt1.Focus();
                        userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_02 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                    }
                    if (txt2.Text == "")
                    {
                        if (n > 0)
                            txt1.Focus();
                        else
                            txt2.Focus();
                        n = n + 1;
                        userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_03 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_03;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                    }
                    else
                    {
                        objItems.ReferenceNo = txt2.Text.ToString();
                        objItems.Type = "Credit";
                    }
                    lstIIB1.Add(objItems);
                }
            }
            if (count == 0)
            {
                userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_04 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_04;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
            }
            else if (n == 0)
            {
                returnCode = new StockReturn_BL(base.ContextInfo).UpdateStockReturnPayment(lstIIB1);
                //if (returnCode == 0)
                //{
                BindData();
                lblResult.Attributes.Add("class", "show");
                userMsg = Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_09 ?? Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_09;
                lblResult.Text = userMsg;
                //}
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);

        }
    }

    public List<InventoryItemsBasket> GetCollectedItems()
    {

        //List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[0]);
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.ExpiryDate = DateTimeNow;
                newBasket.Manufacture = DateTimeNow;

                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        //int supplieid = 0;
        string userMsg = string.Empty;
        try
        {
            //supplieid = ddlSupplierName.SelectedIndex;
            //if (supplieid == 0)
            //{
                // if (ddlSupplierName.SelectedIndex == 0)
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Select one supplier!');", true);
            //}
			if (ddlSupplierName.SelectedIndex == 0){
                userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_05 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_05;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
            }
            else
            {
                grdResult.PageIndex = 0;
                BindData();
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error in Page Load - loadActionValue", ex);
        }

    }
    protected void btnDebitSearch_Click(object sender, EventArgs e)
    {
        /*int supplierid = 0;
        supplierid = ddlDebitSupplierName.SelectedIndex;
        if (supplierid == 0)
        {
            // if (ddlDebitSupplierName.SelectedIndex == 0)
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Select one supplier!');", true);
        }*/
        string userMsg = string.Empty;
		if (ddlDebitSupplierName.SelectedIndex == 0){
            userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_05 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_05;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
        }
        else
        {
            grdDebit.PageIndex = 0;
            BindDebitData();
        }
    }
    public void BindData()
    {
        GetinventoryDetails();
    }
    public void BindDebitData()
    {
        int debSupplierID = 0;
        string userMsg = string.Empty;
        debSupplierID = Convert.ToInt32(ddlDebitSupplierName.SelectedValue);
        if (txtStockReceivedDate.Text != "")
        {
            StockReturnDate = Convert.ToDateTime(txtStockReceivedDate.Text);
        }
        if (txtInvoiceOrDC.Text != "")
        {
            InvoiceOrDCNo = txtInvoiceOrDC.Text.Trim().ToString();
        }
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        List<InventoryItemsBasket> lstInvent = new List<InventoryItemsBasket>();
        List<InventoryItemsBasket> lstDebitInvent = new List<InventoryItemsBasket>();
        try
        {

            returnCode = new StockReturn_BL(base.ContextInfo).GetStockReceivedToAddDebit(txtDebitSRDNo.Text.Trim().ToString(), StockReturnDate, debSupplierID, InvoiceOrDCNo, OrgID, ILocationID, InventoryLocationID, out lstOrders, out lstDebitInvent);
            var Invent = (from lst in lstDebitInvent
                          select new { lst.SupplierId, lst.ID, lst.Description, lst.Name, lst.Amount, lst.ReferenceNo, lst.TotalCost }).Distinct();
            if (returnCode == 0 && lstOrders.Count() > 0)
            {
                grdDebit.Attributes.Add("class", "show");
                lblResult.Attributes.Add("class", "hide");
                lblResult.Text = "";
                Label1.Attributes.Add("class", "hide");
                grdDebit.DataSource = lstOrders;
                grdDebit.DataBind();
                grdResult.Attributes.Add("class", "hide");
                divCreditNote.Attributes.Add("class", "hide");
                divDebitNote.Attributes.Add("class", "show");
                btnCancelDebit.Attributes.Add("class", "show");
                btnUpdateDebit.Attributes.Add("class", "show");
                btnReturnStock.Attributes.Add("class", "hide");
                btnCancel.Attributes.Add("class", "hide");
            }
            else
            {
                userMsg = Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_10 ?? Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_10;
                Label1.Attributes.Add("class", "show");
                Label1.Text = userMsg;
                grdDebit.Attributes.Add("class", "hide");
                lblResult.Attributes.Add("class", "hide");
                grdResult.Attributes.Add("class", "hide");
                divCreditNote.Attributes.Add("class", "hide");
                divDebitNote.Attributes.Add("class", "show");
                    btnCancelDebit.Attributes.Add("class", "show");
                    btnUpdateDebit.Attributes.Add("class", "show");
                btnReturnStock.Attributes.Add("class", "hide");
                btnCancel.Attributes.Add("class", "hide");
            }
        }
            catch(Exception ex)
            {
                CLogger.LogError("", ex);
            }
    }

    private void GetinventoryDetails()
    {
        string userMsg = string.Empty;
        if (txtStockReturnNo.Text != "")
        {
            StockReturnNumber = txtStockReturnNo.Text.Trim();
        }
        //if (hdnIsSupplier.Value != "")
        //{
        //    SupplierID = Convert.ToInt32(hdnIsSupplier.Value);
        //}
        SupplierID = Convert.ToInt32(ddlSupplierName.SelectedValue);
        if (txtStockReceivedNumber.Text != "")
        {
            SRDNo = txtStockReceivedNumber.Text.Trim();
        }
        if (txtStockReturnDate.Text != "")
        {
            StockReturnDate = Convert.ToDateTime(txtStockReturnDate.Text);
        }
        if (txtInvoiceOrDC.Text != "")
        {
            InvoiceOrDCNo = txtInvoiceOrDC.Text.Trim();
        }
        //status = hdnStatusId.Value == "" ? "0" : hdnStatusId.Value;
        List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
        List<InventoryConfig> sellingUnit = new List<InventoryConfig>();

        List<InventoryItemsBasket> lstInvent = new List<InventoryItemsBasket>();

        try
        {
            returnCode = new StockReturn_BL(base.ContextInfo).GetStockReturnDetails(StockReturnNumber, SRDNo, SupplierID, StockReturnDate, OrgID, ILocationID, InventoryLocationID, InvoiceOrDCNo, out lstIIB1);
            var Invent = (from lst in lstIIB1
                          select new { lst.SupplierId, lst.ID, lst.Description, lst.Name, lst.Amount, lst.ReferenceNo, lst.TotalCost }).Distinct();
            if (returnCode == 0 && Invent.Count() > 0)
            {
                //grdDebit.Visible = false;
                divCreditNote.Attributes.Add("class", "show");
                grdResult.Attributes.Add("class", "show");
                lblResult.Attributes.Add("class", "hide");
                lblResult.Text = "";
                Label1.Attributes.Add("class", "hide");
                grdResult.DataSource = Invent;
                grdResult.DataBind();
                grdDebit.Attributes.Add("class", "hide");
                divCreditNote.Attributes.Add("class", "show");
                divDebitNote.Attributes.Add("class", "hide");
                btnCancelDebit.Attributes.Add("class", "hide");
                btnUpdateDebit.Attributes.Add("class", "hide");
                btnReturnStock.Attributes.Add("class", "show");
                btnCancel.Attributes.Add("class", "show");
            }
            else
            {
                //grdDebit.Visible = false;
                userMsg = Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_10 ?? Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_10;
                Label1.Attributes.Add("class", "hide");
                grdResult.Attributes.Add("class", "hide");
                lblResult.Attributes.Add("class", "show");
                lblResult.Text = userMsg;
                grdDebit.Attributes.Add("class", "hide");
                divCreditNote.Attributes.Add("class", "show");
                divDebitNote.Attributes.Add("class", "hide");
                btnCancelDebit.Attributes.Add("class", "hide");
                btnUpdateDebit.Attributes.Add("class", "hide");
                btnReturnStock.Attributes.Add("class", "show");
                btnCancel.Attributes.Add("class", "show");
            }
        }
        catch
        {
        }

    }

    protected void grdResult_OnRowCreated(object sender, GridViewRowEventArgs e)
    {

    }
    protected void grdDebit_OnRowCreated(object sender, GridViewRowEventArgs e)
    {

    }

    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                CheckBox chk1 = (CheckBox)e.Row.FindControl("chkBox");
                TextBox txt1 = (TextBox)e.Row.FindControl("txtApprovedAmount");
                TextBox txt2 = (TextBox)e.Row.FindControl("txtReferenceNo");
                if (Convert.ToDecimal(txt1.Text) > 0)
                {
                    chk1.Checked = false;
                    chk1.Enabled = false;
                    txt1.Enabled = false;
                    txt2.Enabled = false;
                }
                e.Row.Cells[1].Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Cells[1].Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
                //e.Row.Attributes.Add("onclick", this.Page.ClientScript.RegisterStartupScript("strkey","<script language='javascript'>pageLoad();</script>"));
                e.Row.Cells[1].Attributes.Add("onclick", "launchModal('" + e.Row.RowIndex + "');");
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("", Ex);
        }
    }
    protected void grdDebit_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                CheckBox chk1 = (CheckBox)e.Row.FindControl("chkBox");
                TextBox txt1 = (TextBox)e.Row.FindControl("txtDebitAmount");
                TextBox txt2 = (TextBox)e.Row.FindControl("txtReferenceNo");
                if (Convert.ToDecimal(txt1.Text) > 0)
                {
                    chk1.Checked = false;
                    chk1.Enabled = false;
                    txt1.Enabled = false;
                    txt2.Enabled = false;
                }
                //e.Row.Cells[1].Attributes.Add("onmouseover", "this.className='colornw'");
                //e.Row.Cells[1].Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                //e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
                //e.Row.Attributes.Add("onclick", this.Page.ClientScript.RegisterStartupScript("strkey","<script language='javascript'>pageLoad();</script>"));
                //e.Row.Cells[1].Attributes.Add("onclick", "launchModal('" + e.Row.RowIndex + "');");
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("", Ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            //hdnStatusId.Value = ddlStatus.SelectedValue;

            BindData();
        }
    }

    protected void grdDebit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdDebit.PageIndex = e.NewPageIndex;
            //hdnStatusId.Value = ddlStatus.SelectedValue;

            BindDebitData();
        }
    }
    protected void btnHidden_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtStockReturnNo.Text != "")
            {
                StockReturnNumber = txtStockReturnNo.Text.Trim();
            }
            //if (hdnIsSupplier.Value != "")
            //{
            //    SupplierID = Convert.ToInt32(hdnIsSupplier.Value);
            //}
            SupplierID = Convert.ToInt32(ddlSupplierName.SelectedValue);
            if (txtStockReceivedNumber.Text != "")
            {
                SRDNo = txtStockReceivedNumber.Text.Trim();
            }
            if (txtStockReturnDate.Text != "")
            {
                StockReturnDate = Convert.ToDateTime(txtStockReturnDate.Text);
            }

            returnCode = new StockReturn_BL(base.ContextInfo).GetStockReturnDetails(StockReturnNumber, SRDNo, SupplierID, StockReturnDate, OrgID, ILocationID, InventoryLocationID, InvoiceOrDCNo, out lstIIB1);
            int index = Convert.ToInt32(hdnRowIndex.Value);
            var templist = from s in lstIIB1
                           where s.ID == Convert.ToInt32(grdResult.DataKeys[index].Values[0])
                           select s;
            gvProducts.DataSource = templist;
            gvProducts.DataBind();

            //ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "sKy", "pageLoad();", true);

        }
        catch (Exception ex1)
        {
            CLogger.LogError("Error in Page Load - gridbinding", ex1);
        }
    }
    protected void btnUpdateDebit_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        int count = 0;
        int n = 0;
        string userMsg = string.Empty;
        try
        {
            foreach (GridViewRow gr in grdDebit.Rows)
            {
                InventoryItemsBasket objItems = new InventoryItemsBasket();
                CheckBox chk1 = (CheckBox)gr.FindControl("chkBox");
                TextBox txt1 = (TextBox)gr.FindControl("txtDebitAmount");
                TextBox txt2 = (TextBox)gr.FindControl("txtReferenceNo");
                if (chk1.Checked == true)
                {
                    count = count + 1;
                    if (txt1.Text != "")
                    {
                        objItems.ID = Convert.ToInt32(grdDebit.DataKeys[gr.RowIndex].Values[0]);
                        objItems.SupplierId = Convert.ToInt32(grdDebit.DataKeys[gr.RowIndex].Values[1]);
                        objItems.Amount = Convert.ToDecimal(txt1.Text.ToString());
                        objItems.BatchNo = gr.Cells[1].Text.ToString();
                    }
                    else if (txt1.Text == "")
                    {
                        n = n + 1;
                        txt1.Focus();
                        userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_02 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_02;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                    }
                    if (txt2.Text == "")
                    {
                        if (n > 0)
                            txt1.Focus();
                        else
                            txt2.Focus();
                        n = n + 1;
                        userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_03 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_03;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                    }
                    else
                    {
                        objItems.ReferenceNo = txt2.Text.ToString();
                        objItems.Type = "Debit";
                    }
                    lstIIB1.Add(objItems);
                }
            }
            if (count == 0)
            {
                userMsg = Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_04 ?? Resources.StockReturn_AppMsg.StockReturn_StockReturnPayment_aspx_04;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
            }
            else if (n == 0)
            {
                returnCode = new StockReturn_BL(base.ContextInfo).UpdateStockReturnPayment(lstIIB1);
                //if (returnCode == 0)
                //{
                userMsg = Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_11 ?? Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_11;
                BindDebitData();
                Label1.Attributes.Add("class", "show");
                //Label1.Text = userMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + userMsg + "','" + ErrorMsg + "');", true);
                //}
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Stock Return Details.", ex);

        }
    }
    public void ChkSelectType(object sender, EventArgs e)
    {
        if (rdoDebitNote.Checked)
        {

            divCreditNote.Attributes.Add("class", "hide");
            divDebitNote.Attributes.Add("class", "show");
            btnReturnStock.Attributes.Add("class", "hide");
            btnCancel.Attributes.Add("class", "hide");
            if (grdDebit.Rows.Count > 0)
            {
                btnUpdateDebit.Attributes.Add("class", "show");
                btnCancelDebit.Attributes.Add("class", "show");
            }
            else
            {
                btnUpdateDebit.Attributes.Add("class", "hide");
                btnCancelDebit.Attributes.Add("class", "hide");
            }
            grdDebit.Attributes.Add("class", "show");
            grdResult.Attributes.Add("class", "hide");
            lblResult.Attributes.Add("class", "hide");
            Label1.Attributes.Add("class", "hide");
        }
        if (rdoCreditNote.Checked)
        {
            divDebitNote.Attributes.Add("class", "hide");
            divCreditNote.Attributes.Add("class", "show");
            if (grdResult.Rows.Count > 0)
            {
                btnReturnStock.Attributes.Add("class", "show");
                btnCancel.Attributes.Add("class", "show");
            }
            else
            {
                btnReturnStock.Attributes.Add("class", "hide");
                btnCancel.Attributes.Add("class", "hide");
            }
            btnUpdateDebit.Attributes.Add("class", "hide");
            btnCancelDebit.Attributes.Add("class", "hide");
            grdDebit.Attributes.Add("class", "hide");
            grdResult.Attributes.Add("class", "show");
            lblResult.Attributes.Add("class", "hide");
            Label1.Attributes.Add("class", "hide");
        }

    }

}

