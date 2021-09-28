using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Web.Script.Serialization;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.CentralPurchasing.BL;
using Attune.Kernel.PlatForm.Base;
using System.IO;
using Attune.Kernel.PerformingNextAction;
using Attune.Kernel.PlatForm.Common;
using System.Text;




public partial class CentralPurchasing_CentralPurchaseOrder : Attune_BasePage
{
    public CentralPurchasing_CentralPurchaseOrder()
        : base("CentralPurchasing_CentralPurchaseOrder_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<PurchaseOrderMappingLocation> lstPurchaseOrder = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMap = new List<PurchaseOrderMappingLocation>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<InventoryItemsBasket> lstOrder = new List<InventoryItemsBasket>();
    List<InventoryOrdersMaster> lstOrders = new List<InventoryOrdersMaster>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryOrdersMaster> lstpurOrders = new List<InventoryOrdersMaster>();
    List<Suppliers> lstSup = new List<Suppliers>();
    InventoryCommon_BL inventoryBL;
    List<Organization> lstorgn = new List<Organization>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Locations> lstloc = new List<Locations>();
    List<StockStatus> lstStockStatus = new List<StockStatus>();
    List<StockStatus> lstStockStatus1 = new List<StockStatus>();
    List<StockType> lstStockType = new List<StockType>();
    //List<Locations> lstLocation;
    long POID = -1;
    //   long returnCode = -1;
    // long porderID, podetailsid, productid;
    //int Sid;

    long TaskID = 0;
    long CurrentTaskID = 0;
    int StockTypeID = 0;
    int StatusID = 0;
    string ApprovelConfigValue = string.Empty;
    long ID = 0;
    string PONo = string.Empty;
    int ActionID = 0;
    int SeqNo = 0;
    string SupplierName = string.Empty;
    int SupplierID = 0;
    int Lid = 0;
    string Comments = string.Empty;
    bool strTaxType = false;
    int locid = 0;
    bool IsRate = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        // txtPurchaseOrderDate.Attributes.Add("onchange", "ExcedDate('" + txtPurchaseOrderDate.ClientID.ToString() + "','',0,1); ExcedDate('" + txtPurchaseOrderDate.ClientID.ToString() + "','txtPurchaseOrderDate',1,1);");
        //Comment By Gurunath S 
        //txtPurchaseOrderDate.Text = DateTime.Today.ToShortDateString(); //Comment By Gurunath S 
        txtFDate.Attributes.Add("onchange", "ExcedDate('" + txtFDate.ClientID.ToString() + "','',0,1); ExcedDate('" + txtFDate.ClientID.ToString() + "','txtFDate',1,1);");

        //txtFDate.Text = DateTime.Today.ToShortDateString(); //Comment By Gurunat S 
        hdnDeliverydate.Value = DateTime.Today.ToShortDateString();

        if (!IsPostBack)
        {
            txtFDate.Text = DateTimeNow.ToExternalDate();
            txtPurchaseOrderDate.Text = DateTimeNow.ToExternalDate();
            LoadOrgan();
            LoadSupplierList();
            PurchaseOrderDetails();
            //LoadUnit();

            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_PO_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    ApprovelConfigValue = "Y";
                    // status = "Approved";
                }
                else
                {
                    ApprovelConfigValue = "N";
                    // status = "Pending";
                }
            }
           ListItem ddSelect=GetMetaData("Select","0");
            if(ddSelect == null)
            {
                ddSelect = new ListItem() { Text = "Select", Value = "0" };
            }
            drpLocation.Items.Insert(0,ddSelect);
            hdnInventoryLocationID.Value = InventoryLocationID.ToString();

            hdnPageID.Value = Convert.ToString(PageID);
            hdnLoginLocationID.Value = Convert.ToString(ILocationID);
            hdnOrgId.Value = Convert.ToString(OrgID);
            hdnLoginID.Value = Convert.ToString(LID);


            //if (RoleHelper.Admin == RoleName )
            //{
            //    btnApprove.Visible = true;
            //    btninsert.Visible = false;
            //}
            //btnApprove.Visible = false;

/*****************  commented by jayamoorthi ***************************************************************
             if (Request.QueryString["ID"] != null)
            {
                long poid = Convert.ToInt64(Request.QueryString["ID"]);
                ID = Convert.ToInt64(Request.QueryString["ID"]);

                purchaseordersdetails(poid);//--> To Get the supplier Details, PODate,Comments
                GetMappingLocation(poid, lstSup[0].SupplierID);
                AutoCompleteProduct.ContextKey = poid.ToString() + '~' + lstSup[0].SupplierID.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "SetAttr1ib", "UpdateProductDetail()", true);
                btnApprove.Visible = true;
                btninsert.Visible = false;
                btnCnl.Visible = false;
                btnback.Visible = true;
                btnCancelPO.Visible = true;
            }
            if (Request.QueryString["tid"] != null)
            {
                CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
            }
            chkSupplier.Checked = true;
            DropSupplierName.SelectedIndex = 0;
            lblprd.Style.Add("display", "none");
            txtProductName.Style.Add("display", "none");
            tbllist.Style.Add("display", "none");
            supnames.Style.Add("display", "none");
            hdunits.Style.Add("display", "none");
            hdquantity.Style.Add("display", "none");
            hdtotalQty.Style.Add("display", "none");
            hdInverseQty.Style.Add("display", "none");
            secrow.Style.Add("display", "none");
            tdlblsuppliername.Style.Add("display", "block");
            tdtxtsuppliername.Style.Add("display", "block");
        }
        AutoTrustOrg.ContextKey = "";
        AutoLocationOrg.ContextKey = "";
 ***************************************************************************************************************/

            if (Request.QueryString["ID"] != null)
            {
                long poid = Convert.ToInt64(Request.QueryString["ID"]);
                ID = Convert.ToInt64(Request.QueryString["ID"]);
                chkBasedonQuantity.Enabled = false;
                chkSupplier.Enabled = false;
                chkPO_Rate.Enabled = false;
                ddl_PO_QuantitySupplier.Enabled = false;

                purchaseordersdetails(poid);//--> To Get the supplier Details, PODate,Comments
                if (Request.QueryString["tid"] != null)
                {
                    CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
                }
                if (chkBasedonQuantity.Checked)
                {
                    chkBasedonQuantity.Checked = true;
                    chkPO_Rate.Checked = false;
                    chkSupplier.Checked = false;
                    divPORateDetails.Style.Add("display", "none");
                    ProductData.Attributes.Add("class", "hide");
                    divBasedOnRate.Attributes.Add("class", "hide");
                    divPOQuantity.Attributes.Add("class", "show");
                    divPO_Details.Attributes.Add("class", "show");
                    tblPO_Quantity_Productlist.Attributes.Add("class", "displaytb w-100p gridView");
                    LoadPO_QuantityDetails(poid, chkBasedonQuantity.Checked);


                }
                else
                {
                    if (lstSup[0].SupplierID > 0 && lstSup[0].SupplierID != null)
                    {
                        GetMappingLocation(poid, lstSup[0].SupplierID);
                        AutoCompleteProduct.ContextKey = poid.ToString() + '~' + lstSup[0].SupplierID.ToString();
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetAttr1ib", "UpdateProductDetail();", true);
                    }
                    chkSupplier.Checked = true;
                    DropSupplierName.SelectedIndex = 0;
                    lblprd.Style.Add("display", "none");
                    txtProductName.Style.Add("display", "none");
                    tbllist.Style.Add("display", "none");
                    supnames.Style.Add("display", "none");
                    hdunits.Style.Add("display", "none");
                    hdquantity.Style.Add("display", "none");
                    hdtotalQty.Style.Add("display", "none");
                    hdInverseQty.Style.Add("display", "none");
                    secrow.Style.Add("display", "none");
                    tdlblsuppliername.Attributes.Add("class", "displaytd");
                    tdtxtsuppliername.Attributes.Add("class", "displaytd");
                    btnApprove.Visible = true;
                    btninsert.Visible = false;
                    btnCnl.Visible = false;
                    btnback.Visible = true;
                    btnCancelPO.Visible = true;
                    divBasedOnRate.Style.Add("display", "none");
                    spanBySupplier.Style.Add("visibility", "Visible");
                 
                }

            }
            else
            {
                chkSupplier.Checked = true;
                chkPO_Rate.Checked = true;    
                DropSupplierName.SelectedIndex = 0;
                lblprd.Style.Add("display", "none");
                txtProductName.Style.Add("display", "none");
                tbllist.Style.Add("display", "none");
                supnames.Style.Add("display", "none");
                hdunits.Style.Add("display", "none");
                hdquantity.Style.Add("display", "none");
                hdtotalQty.Style.Add("display", "none");
                hdInverseQty.Style.Add("display", "none");
                secrow.Style.Add("display", "none");
                tdlblsuppliername.Attributes.Add("class", "displaytd");
                tdtxtsuppliername.Attributes.Add("class", "displaytd");
                btnApprove.Visible = false;
                btninsert.Visible = true;
                btnCnl.Visible = false;
                btnback.Visible = true;
                btnCancelPO.Visible = true;
                divBasedOnRate.Style.Add("display", "block");
                spanBySupplier.Style.Add("visibility", "Visible");
            }


            lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ValidateQutationDiscountInPO", OrgID, ILocationID, out lstInventoryConfig);
            hdn_ValidateQutationDiscountInPOconfig.Value = lstInventoryConfig.Count > 0 ? lstInventoryConfig[0].ConfigValue : "N";         
     
        }
        AutoTrustOrg.ContextKey = "";
        AutoLocationOrg.ContextKey = "";

        #region Set Default as Based On Qty (used old config itself)
        List<InventoryConfig> lstGetInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedTo_Show_All_VAT_Percentage", OrgID, ILocationID, out lstGetInventoryConfig);
        if (lstGetInventoryConfig != null && lstGetInventoryConfig.Count > 0)
        {
            if (lstGetInventoryConfig[0].ConfigValue == "Y")
            {
                chkBasedonQuantity.Checked = true;
                hdnFlag.Value = "1";
            }
        }
        #endregion

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        List<InventoryItemsBasket> lBasket = new List<InventoryItemsBasket>();
        string Status = "Pending";
        List<InventoryItemsBasket> iib = new List<InventoryItemsBasket>();
        InventoryItemsBasket obj;
        var sup = hdnProductsupplier.Value.Split('^');
        for (int i = 0; i < sup.Length; i++)
        {
            obj = new InventoryItemsBasket();
            if (sup[i] != "")
            {
                var ps = sup[i].Split('~');
                obj.ID = Convert.ToInt32(ps[6]);
                obj.ProductID = Convert.ToInt32(ps[7]);
                //Assumption of expiry date is act as purchase order date..
                
                obj.Manufacture = DateTimeNow;
                //end
                obj.ExpiryDate = ps[3].ToInternalDate();
                obj.Quantity = Convert.ToInt32(ps[4]);
                obj.Unit = ps[5];
                obj.Providedby = Convert.ToInt64(ps[9]);
                obj.ParentProductID = Convert.ToInt64(ps[10]);
                /* Code Added By: Gurunath S 
                 * Code Added At: 24-Oct-2013
                 * Fix Details: Pass Purchase order date instead of updating Getdate() at DB */
                string mDate = txtPurchaseOrderDate.Text + " " + DateTimeNow.ToExternalTime();
                obj.Manufacture = mDate.ToInternalDateTime();
                //end
                /* Code End */
                obj.ComplimentQTY = 0;
                //obj.ComplimentQTY = Convert.ToDecimal(ps[12]);
                if (ps[13] != null)
                {
                    obj.Remarks = ps[13];
                }
                obj.Description = ps[14];
                iib.Add(obj);
            }
        }
        int OrgAddid = ILocationID;
        Lid = Convert.ToInt16(Session["InventoryLocationID"].ToString());
        locid = Convert.ToInt32(InventoryLocationID.ToString());
      
        if (chkCForm.Checked)
        {
            strTaxType = true;
        }
        if (chkBasedonQuantity.Checked)
        {
            StockReceived objStockReceived = new StockReceived();
            objStockReceived.PackingSale = 0;
            objStockReceived.ExciseDuty = 0;
            objStockReceived.EduCess = 0;
            objStockReceived.SecCess = 0;
            objStockReceived.CST = 0;
            List<InventoryItemsBasket> lstPODetails = new List<InventoryItemsBasket>();
            lstPODetails = getPOdetails();
            SupplierID = Convert.ToInt16(ddl_PO_QuantitySupplier.SelectedItem.Value);
            SupplierName = ddl_PO_QuantitySupplier.SelectedItem.Text;
            Comments = txt_PO_Quantity_Comment.Text.Trim();
            StockTypeID = (int)StockTypeName.PurchaseOrder;
            StatusID = 0;
            GetStatusID(StockTypeID, Status, out StatusID);
            new CentralPurchasing_BL(base.ContextInfo).POSavePurchaseOrder(OrgID, ILocationID, Lid, SupplierID, ID, lstPODetails, 0, 0,1, 0, Comments, Status, out POID, 0, 0, objStockReceived,
            StatusID, strTaxType, false, locid, StockTypeID, out  TaskID, PONo, CurrentTaskID, out  ActionID, out  SeqNo, SupplierName);
            if (POID > 0)
            {
                RemoveDrafts();
                Response.Redirect(@"../CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + POID + "&Ismail=Y&IsBasedOnQty=Y", true);

                 
            }
        }
        else
        {
            if (chkPO_Rate.Checked )
            {
                IsRate = true;
            }
            inventoryBL.SaveSupplierProductPurchaseOrder(OrgID, OrgAddid, Lid, Status, iib, locid, strTaxType,IsRate, out lstOrders);
            if (lstOrders.Count > 0)
            {
                PurchaseOrderDetails();
                  if (lstOrders[0].OrderID != null && lstOrders[0].OrderID >0)
                  {
                      long PurchaseOrderId = lstOrders[0].OrderID;
                      hdnorderid.Value = lstOrders[0].OrderID.ToString();
                      hdnsuppid.Value = lstOrders[0].SupplierID.ToString();
                      purchaseordersdetails(PurchaseOrderId);
                      ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:UpdateProductDetail();", true);
                      AutoCompleteProduct.ContextKey = hdnorderid.Value + '~' + hdnsuppid.Value;

                  }
            }
        }
        hdnProductsupplier.Value = "";


    }
    private void RemoveDrafts()
    {
        InventoryCommon_BL objDraft = new InventoryCommon_BL();

        string DraftValue = ddl_PO_QuantitySupplier.SelectedItem.Value;
        objDraft.DeleteDraft(OrgID, InventoryLocationID, Convert.ToInt32(PageID), LID, "CentralPurchaseOrder", DraftValue);

    }

    protected void btnpoApprove_Click(object sender, EventArgs e)
    {
        if (chkCForm.Checked)
        {
            strTaxType = true;
        }
        string Status = "Approved";
        StockReceived objStockReceived = new StockReceived();
        objStockReceived.PackingSale = 0;
        objStockReceived.ExciseDuty = 0;
        objStockReceived.EduCess = 0;
        objStockReceived.SecCess = 0;
        objStockReceived.CST = 0;
        List<InventoryItemsBasket> lstPODetails = new List<InventoryItemsBasket>();
        lstPODetails = getPOdetails();
        SupplierID = Convert.ToInt16(ddl_PO_QuantitySupplier.SelectedItem.Value);
        SupplierName = ddl_PO_QuantitySupplier.SelectedItem.Text;
        Comments = txt_PO_Quantity_Comment.Text.Trim();
        StockTypeID = (int)StockTypeName.PurchaseOrder;
        StatusID = 0;
        GetStatusID(StockTypeID, Status, out StatusID);
        PONo = hdnPONo.Value;
        Lid = Convert.ToInt16(Session["InventoryLocationID"].ToString());
        locid = Convert.ToInt32(InventoryLocationID.ToString());
      
        if (Request.QueryString["ID"] != null)
        {
            ID = Int64.Parse(Request.QueryString["ID"]);
        }
        if (hdnPOID.Value != "")
        {
            ID = Int64.Parse(hdnPOID.Value);
        }
        if (Request.QueryString["tid"] != null)
        {
            CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
        }
        long returncode = -1;
        if (ID > 0)
        {
          returncode = new CentralPurchasing_BL(base.ContextInfo).POSavePurchaseOrder(OrgID, ILocationID, Lid, SupplierID, ID, lstPODetails, 0, 0, 1, 0, Comments, Status, out POID, 0, 0, objStockReceived,
            StatusID, strTaxType, false, locid, StockTypeID, out  TaskID, PONo, CurrentTaskID, out  ActionID, out  SeqNo, SupplierName);
        }
        if (returncode >= 0)
        {
            if (CurrentTaskID > 0)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["tid"]), TaskHelper.TaskStatus.Completed, UID);
            }
        }
        if (POID > 0)
        {
            Response.Redirect(@"../CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + POID + "&Ismail=Y&IsBasedOnQty=Y", true);
        }

        hdnProductsupplier.Value = "";
        hdnLoadProductsupplier.Value = "";
    }

    protected void btnPOCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID = 0;
            if (Request.QueryString["ID"] != null)
            {
                orderID = Int64.Parse(Request.QueryString["ID"]);
            }
            if (hdnPOID.Value != "")
            {
                orderID = Int64.Parse(hdnPOID.Value);
            }
            string status = StockOutFlowStatus.Cancelled;
            if (orderID > 0)
            {
                returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID, ILocationID);
          
                if (Request.QueryString["tid"] != null)
                {
                    CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
                }
                if (CurrentTaskID > 0)
                {
                    new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["tid"]), TaskHelper.TaskStatus.Deleted, UID);
                }

                Response.Redirect(@"../CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + orderID + "&Ismail=Y", true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            int rowIndex = -1;
            rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow grow = grdResult.Rows[rowIndex];
            hdnorderid.Value = grdResult.DataKeys[rowIndex][0].ToString();
            hdnPurchaseOrderID.Value = grdResult.DataKeys[rowIndex][0].ToString();
            hdnsuppid.Value = grdResult.DataKeys[rowIndex][1].ToString();
            hdnIsRate.Value  = grdResult.DataKeys[rowIndex][2].ToString();
            long pod = Convert.ToInt64(hdnorderid.Value);
            int sid = Convert.ToInt32(hdnsuppid.Value);
            bool IsRate = Convert.ToBoolean(hdnIsRate.Value);
            if (IsRate == false)
            {
                string fn = "ShowBaseOnQuantity(" + chkBasedonQuantity.ClientID + ");";
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "ShowBaseOnQuantity(chkBasedonQuantity);", true);
                chkBasedonQuantity.Checked = true;
                chkPO_Rate.Checked = false;
                chkSupplier.Checked = false;
                divPORateDetails.Style.Add("display", "none");
                ProductData.Attributes.Add("class", "hide");
                divBasedOnRate.Style.Add("display", "none");
                divPOQuantity.Style.Add("display", "block");
                divPO_Details.Style.Add("display", "block");
                //tblPO_Quantity_Productlist.Style.Add("display", "table");
                tblPO_Quantity_Productlist.Attributes.Add("class", "displaytb w-100p gridView");
                LoadPO_QuantityDetails(pod, IsRate);
                //btsave.Style.Add("display", "block");
                //tdApprove.Style.Add("display", "block");
               
             }
            else
            {
                btsave.Attributes.Add("class", "displaytd");
                tdApprove.Style.Add("display", "none");
                chkPO_Rate.Checked = true;
                chkSupplier.Checked = true;
                chkBasedonQuantity.Checked = false;
                divPOQuantity.Style.Add("display", "none");
                divPO_Details.Style.Add("display", "none");
                //divPORateDetails.Style.Add("display", "block");
                //ProductData.Style.Add("display", "block");
                //divBasedOnRate.Style.Add("display", "block");
                purchaseordersdetails(pod);
                GetMappingLocation(pod, sid);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:UpdateProductDetail();", true);
                AutoCompleteProduct.ContextKey = hdnorderid.Value + '~' + hdnsuppid.Value;
                btninsert.Visible = true;
                btnback.Visible = true;
                btnCancelPO.Visible = true;
               
            }


        }
    }
	  protected void grdResult_PageIndexChanging(Object sender, GridViewPageEventArgs e)
    {
        grdResult.PageIndex = e.NewPageIndex;
        PurchaseOrderDetails();
    }
    private void LoadOrgan()
    {
        new TrustedOrg_BL(ContextInfo).GetSharingOrgList(OrgID, out lstorgn, out lstloc);
        ddlTrustedOrg.DataSource = lstorgn;
        ddlTrustedOrg.DataTextField = "Name";
        ddlTrustedOrg.DataValueField = "OrgID";
        ddlTrustedOrg.DataBind();
        
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlTrustedOrg.Items.Insert(0, ddlselect);
       // ddlTrustedOrg.Items.Insert(0, GetMetaData("Select", "0"));
        //end
        ddlTrustedOrg.Items[0].Value = "0";
        foreach (var item in lstloc)
        {
            hdnlocation.Value += item.OrgID + "~" + item.LocationID + "~" + item.LocationName + "^";

        }

    }
    protected void btninsert_Click(object sender, EventArgs e)
    {
        string status = "Pending";
        //List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Required_PO_Approval", OrgID, ILocationID, out lstInventoryConfig);
        //if (lstInventoryConfig.Count > 0)
        //{
        //    if (lstInventoryConfig[0].ConfigValue == "Y")
        //    {
        //        status = "Approved";
        //    }
        //    else
        //    {
        //        status = "Pending";
        //    }
        //}
        insertmappinglocation(status);
    }

    public void insertmappinglocation(string status)
    {
        long returncode = -1;
        PurchaseOrderMappingLocation obj;
        List<PurchaseOrderMappingLocation> poml = new List<PurchaseOrderMappingLocation>();
        List<PurchaseOrderMappingLocation> Data = new List<PurchaseOrderMappingLocation>();
        decimal Freightcharges = 0;
        decimal PoDiscount = 0;
        decimal GrossAmount = 0;
        decimal NetAmount = 0;
        decimal ProdiscountAmount = 0;
        decimal ProVatAmount = 0;
        var prod = hdnproductlocmap.Value.Split('^');


        for (int i = 0; i < prod.Length; i++)
        {
            obj = new PurchaseOrderMappingLocation();
            if (prod[i] != "")
            {
                var s = prod[i].Split('#');
                var p = s[0].Split('~');
                obj.ProductID = Convert.ToInt64(p[8]);
                obj.SupplierId = Convert.ToInt64(p[7]);
                obj.Quantity = Convert.ToDecimal(p[4]);
                obj.Units = p[5].ToString();
                obj.DeliveryDate = p[3].ToInternalDate();
                obj.LocationId = InventoryLocationID;
                obj.POID = Convert.ToInt64(p[15]);
                obj.PODetailsID = Convert.ToInt64(p[16]);
                obj.TrustedOrgID = Convert.ToInt32(p[18]);
                obj.ToLocationID = Convert.ToInt32(p[17]);
                obj.CompQty = Convert.ToDecimal(p[9]);
                obj.Discount = Convert.ToDecimal(p[10]);
                obj.Vat = Convert.ToDecimal(p[11]);
                obj.Amount = Convert.ToDecimal(p[12]);
                obj.POMappingID = Convert.ToInt64(p[22]);
                obj.Rate = Convert.ToDecimal(p[13]);
                obj.SellingPrice = Convert.ToDecimal(p[19]);
                ID = Convert.ToInt64(p[15]);
                obj.ProductDescription = p[23];
                poml.Add(obj);
            }
        }
        Freightcharges = Convert.ToDecimal(txtCharges.Text);
        PoDiscount = Convert.ToDecimal(txtTotalDiscount.Text);
        GrossAmount = Convert.ToDecimal(txtGrandTotal.Text);
        NetAmount = Convert.ToDecimal(txtNetTotal.Text);
        ProdiscountAmount = Convert.ToDecimal(txtProductdiscount.Text);
        ProVatAmount = Convert.ToDecimal(txtProductVat.Text);
        Comments = txtComment.Text;
        int k = Convert.ToInt32(Session["InventoryLocationID"].ToString());
        
        // Tax Type - Starts
        StockReceived objStockReceived = new StockReceived();
        if (!string.IsNullOrEmpty(txtPackingSale.Text.Trim()))
        {
            objStockReceived.PackingSale = Convert.ToDecimal(txtPackingSale.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtExciseDuty.Text.Trim()))
        {
            objStockReceived.ExciseDuty = Convert.ToDecimal(txtExciseDuty.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtEduCess.Text.Trim()))
        {
            objStockReceived.EduCess = Convert.ToDecimal(txtEduCess.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtSecCess.Text.Trim()))
        {
            objStockReceived.SecCess = Convert.ToDecimal(txtSecCess.Text.Trim());
        }
        if (!string.IsNullOrEmpty(txtCST.Text.Trim()))
        {
            objStockReceived.CST = Convert.ToDecimal(txtCST.Text.Trim());
        }
       
        if (!string.IsNullOrEmpty(txtTotal.Text.Trim()))
        {
            objStockReceived.Total = Convert.ToDecimal(txtTotal.Text.Trim());
        }
        
        StockTypeID = (int)StockTypeName.PurchaseOrder;
        StatusID = 0;
        GetStatusID(StockTypeID, status, out StatusID);
        PONo = hdnPONo.Value;
        SupplierName = hdnSupplierName.Value;
        if (Request.QueryString["tid"] != null)
        {
            CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
        }

        returncode = new CentralPurchasing_BL(base.ContextInfo).savePurcharOrderMappingLocation(OrgID, k, poml, PoDiscount, GrossAmount, NetAmount, Freightcharges, Comments, status, ProdiscountAmount, ProVatAmount, objStockReceived, out  POID, StockTypeID, StatusID, ID, out TaskID, PONo, CurrentTaskID, out ActionID, out SeqNo, SupplierName);
        hdnproductlocmap.Value = "";
        hdnPONo.Value = "";
        hdnSupplierName.Value = "";
        if (returncode >= 0)
        {
            if (CurrentTaskID > 0)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["tid"]), TaskHelper.TaskStatus.Completed, UID);
            }
            SendMail();
            Response.Redirect(@"../CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + POID + "&Ismail=Y", true);
            // ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Success Data", "alert('Records are  saved successfully.');", true);
        }
        else
        {
            string Message = Resources.CentralPurchasing_AppMsg.CentralPurchasing_CentralPurchaseOrder_aspx_21;
            if (Message == null)
            {
                Message = "There is a problem saving the data";
            }
            string Error = Resources.CentralPurchasing_AppMsg.CentralPurchasing_Error;
            if (Error == null)
            {
                
                Error = "Alert";
                //end
            }
            ScriptManager.RegisterClientScriptBlock(Page, this.GetType(), "Failed Data", "javascript:ValidationWindow('" + Message + "','" + Error + "');", true);
        }
        txtCharges.Text = "0.00";
        txtTotalDiscount.Text = "0.00";
        txtGrandTotal.Text = "0.00";
        txtNetTotal.Text = "0.00";
        PurchaseOrderDetails();
    }
    private void SendMail()
    {
        try
        {

            string EmailTo = String.Empty;
            EmailTo = "sample@gmail.com";// txtMailAddress.Text;
            
            string displayTool = Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_CentralPurchaseOrder_aspx_30;
            displayTool = displayTool == null ? "Purchase Order" : displayTool;

            string str = displayTool;
            //end
            //string FromDate = txtFrom.Text;
            //string ToDate = txtTo.Text;
            string prefix = string.Empty;
            prefix = str + "_";
            string rptDate = prefix;
            rptDate = "<div style='font-family:Verdana;font-size:12;'><div><strong><br>" + rptDate + "<br/>" + "</strong></div></div><br>";
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = "btninsert";
            PC.ButtonValue = "Save";
            PC.Description = "txtMailAddress.Text";
            PC.PatientID = 0;
            PC.AccessionNo = "0";
            PC.LabNo = 0;
            PC.FinalBillID = 0;
            PC.RegPatientID = 0;
            PC.RateType = "0";
            PC.FeeID = "0";
            PC.RefundNo = "0";
            PC.BillNumber = "0";
            PC.PhoneNo = "";
            PC.ReceiptNo = "";
            var mailbuilder = new StringBuilder();
            string mailContent = mailbuilder.ToString();
            PC.MessageTemplate = mailContent.ToString();
            PC.IndentNo = Convert.ToInt64(Request.QueryString["intID"]);
            lstpagecontextkeys.Add(PC);
            long res = -1;
            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                {
                    StringReader sr = new StringReader(sw.ToString());
                    res = AM.PerformingNextStepNotification(PC, sw.ToString(), rptDate + "~" + EmailTo);
                }
            }

            if (res >= 0)
            {
                string Message = Resources.CentralPurchasing_AppMsg.CentralPurchasing_CentralPurchaseOrder_aspx_20;
                if (Message == null)
                {
                    Message = "Email Sent Successfully";
                }
                string Error = Resources.CentralPurchasing_AppMsg.CentralPurchasing_Error;
                if (Error == null)
                {
                    
                    Error = "Alert";
                    //end
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + Message + "','" + Error + "');", true);
            }
            //divPrint1.Attributes.Add("Style", "display:none");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Send SendMail", ex);
        }
    }
    public void PurchaseOrderDetails()
    {
        locid = Convert.ToInt32(InventoryLocationID.ToString());
        new CentralPurchasing_BL(base.ContextInfo).GetPurchaseOrdersDetails(OrgID, locid, out lstOrders);
        if (lstOrders.Count > 0)
        {
            ProductData.Attributes.Add("class", "displaytr  show");
            //ProductData.Style.Add("display", "table-row");
            grdResult.DataSource = lstOrders;
            grdResult.DataBind();
        }

    }

    protected void gvPurOrderDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InventoryItemsBasket inv = (InventoryItemsBasket)e.Row.DataItem;
            e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
            e.Row.Attributes.Add("onclick", "javascript:UpdatePurchaseDetail('" +
                inv.ParentProductID.ToString() + "~" + inv.POUnit + "~" +
                inv.SupplierId + "~" + inv.ProductID + "~" + inv.Quantity + "~" + inv.ProductName + "~" + inv.OrderedQty + "~" + inv.ID + "~" +
                inv.Unit + "~" + "###" + inv.Description + "')");
        }
    }

    protected void grdResult_RowDataCommand(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
            e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
            e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
        }
    }
    public void GetMappingLocation(long pod, int supplierid)
    {
        long returncode = 0;

        decimal discount = 0;
        decimal fcharges = 0;
        string comment = string.Empty;
        List<StockReceived> lstTaxType = new List<StockReceived>();
        returncode = new CentralPurchasing_BL(base.ContextInfo).pgetpurchaseordermapping(pod, supplierid, OrgID, out lstInventoryItemsBasket, out discount, out fcharges, out comment, out lstTaxType);
        if (lstInventoryItemsBasket.Count > 0)
        {
            hdnproductlocmap.Value = "";
            foreach (InventoryItemsBasket item in lstInventoryItemsBasket)
            {
                if (item.Description != "")
                {
                    hdnproductlocmap.Value += item.Description + "^";
                }
            }
            txtTotalDiscount.Text = discount.ToString();
            txtCharges.Text = fcharges.ToString();
            txtComment.Text = comment.ToString();
            if (lstTaxType != null && lstTaxType.Count > 0)
            {
                SetTaxType(lstTaxType);
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadpurchaseorder", "Tblist();", true);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadpurchaseorderaa", "checkAddToTotal();", true);
        }
    }

    protected void SetTaxType(List<StockReceived> lstTaxType)
    {
        if (!string.IsNullOrEmpty(lstTaxType[0].PackingSale.ToString()))
        {
            txtPackingSale.Text = lstTaxType[0].PackingSale.ToString();
        }
        if (!string.IsNullOrEmpty(lstTaxType[0].ExciseDuty.ToString()))
        {
            txtExciseDuty.Text = lstTaxType[0].ExciseDuty.ToString();
        }
        if (!string.IsNullOrEmpty(lstTaxType[0].EduCess.ToString()))
        {
            txtEduCess.Text = lstTaxType[0].EduCess.ToString();
        }
        if (!string.IsNullOrEmpty(lstTaxType[0].SecCess.ToString()))
        {
            txtSecCess.Text = lstTaxType[0].SecCess.ToString();
        }
        if (!string.IsNullOrEmpty(lstTaxType[0].CST.ToString()))
        {
            txtCST.Text = lstTaxType[0].CST.ToString();
        }
        if (!string.IsNullOrEmpty(lstTaxType[0].Total .ToString()))
        {

               txtTotal.Text = lstTaxType[0].Total.ToString();
        }

     

    }

    //followings are purchase order mappings....     
    protected void btnprupdate_Click(object sender, EventArgs e)
    {
        long returncode = 0;
        var data = hdnpodetails.Value.Split('~');
        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetAttr1ib", "UpdateProductDetail()", true);
        returncode = new CentralPurchasing_BL(base.ContextInfo).UpdatePurchaseOrders(Convert.ToInt64(data[0]), Convert.ToInt64(data[1]), Convert.ToInt32(data[2]),
                                                       OrgID, Convert.ToInt64(data[3]), Convert.ToDecimal(data[5]), data[4], Convert.ToInt64(data[6]), LID);

        long purchaseorderid = Convert.ToInt64(data[0]);
        if (returncode > 0)
        {
            //If Changes in purchase order detail to show the right hand side grid view 
            purchaseordersdetails(purchaseorderid);
        }
        //After Updated data will be changed in total qty and purchase order qty thats y we call following method
        GetMappingLocation(purchaseorderid, Convert.ToInt32(data[2]));

    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        string status = "Approved";
        insertmappinglocation(status);
    }

    public void LoadPO_QuantityDetails(long poid, bool S)
    {
        hdnProductsupplier.Value = "";
        hdnLoadProductsupplier.Value = "";
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        List<InventoryItemsBasket> lstPODetails = new List<InventoryItemsBasket>();
        try
        {
           // inventoryBL.GetPurchaseOrderDetail(OrgID, poid, out lstOrder, out lstSup, out lstTaxmaster, out lstPODetails);
            new CentralPurchasing_BL(base.ContextInfo).GetPurchaseOrderDetail_QuantityBased(OrgID, poid, out lstOrder, out lstSup, out lstTaxmaster, out lstPODetails);
            if (lstTaxmaster != null && lstTaxmaster.Count > 0)
            {
                BindTaxTypes(lstTaxmaster);
            }
            if (lstOrder.Count > 0)
            {
                Supplierinfos.Text = lstSup[0].Address1 + " " + lstSup[0].Address2 + " " + lstSup[0].City;
                lblContact.Text = lstSup[0].Mobile;
               // hdnorderid.Value = lstPODetails[0].ID.ToString();
                hdnPOID.Value = lstPODetails[0].ID.ToString();
                hdnSupliersID.Value = lstSup[0].SupplierID.ToString();
                ddl_PO_QuantitySupplier.SelectedValue = lstSup[0].SupplierID.ToString();
                hdnPOStatus.Value = lstPODetails[0].ID.ToString();
                txtorderdate.Text = lstSup[0].FaxNumber;
                txt_PO_Quantity_Comment.Text= lstSup[0].Phone;
                PONo = lstOrder[0].POUnit;
                hdnPONo.Value = PONo;
                hdnSupplierName.Value = lstSup[0].SupplierName;

                btnpoApprove.Visible = true;
                btnPOCancel.Visible = true;
                btsave.Attributes.Add("class", "hide");
                if (lstPODetails.Count > 0)
                {
                    int i = 1;
                    foreach (InventoryItemsBasket inv in lstPODetails)
                    {
                        if (inv.Description != "")
                        {
                            hdnProductsupplier.Value += inv.Description+"~";
                            hdnProductsupplier.Value += inv.OrderedUnitValues + "^";
                            hdnLoadProductsupplier.Value +=  inv.Description + "^";
                            i++;
                        }
                    }
                    if (string.IsNullOrEmpty(Request.QueryString["ID"]))
                    {
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadPOQuantityDetails", "POTableList();", true);
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadPOQuantityDetails", "POTableList_Quantity();", true);
                    }
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While to show Purchase Order Details Products.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }



    }

    public void purchase(long poid)
    {
          List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        List<InventoryItemsBasket> lstPODetails = new List<InventoryItemsBasket>();
        try
        {
            new CentralPurchasing_BL(base.ContextInfo).GetPurchaseOrderDetail(OrgID, poid, out lstOrder, out lstSup, out lstTaxmaster, out lstPODetails);
            if (lstTaxmaster != null && lstTaxmaster.Count > 0)
            {
                BindTaxTypes(lstTaxmaster);
            }
            if (lstOrder.Count > 0)
            {
                IsRate = lstSup[0].IsRate;

                if (IsRate == true)
                {
                    chkSupplier.Checked = true;
                    chkPO_Rate.Checked = true;
                    chkBasedonQuantity.Checked = false;
                }
                else
                {
                    chkSupplier.Checked = false;
                    chkPO_Rate.Checked = false;
                    chkBasedonQuantity.Checked = true;

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While to show Purchase Order Details Products.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

        
    }

    //To Get the supplier Details, PODate,Comments
    public void purchaseordersdetails(long poid)
    {
        hdnproductlocmap.Value = "";
        SupName.Text = "";
        txtorderdate.Text = "";
        //txtComments.Text = "";
        hdnallproducts.Value = "";
        //hdnGetTaxList
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        List<InventoryItemsBasket> lstPODetails = new List<InventoryItemsBasket>();
        try
        {
            new CentralPurchasing_BL(base.ContextInfo).GetPurchaseOrderDetail(OrgID, poid, out lstOrder, out lstSup, out lstTaxmaster,out lstPODetails);
            if (lstTaxmaster != null && lstTaxmaster.Count > 0)
            {
                BindTaxTypes(lstTaxmaster);
            }
            if (lstOrder.Count > 0)
            {
                gvPurOrderDetails.DataSource = lstOrder;
                gvPurOrderDetails.DataBind();
                SupName.Text = lstSup[0].SupplierName;
                Supplierinfos.Text = lstSup[0].Address1 + " " + lstSup[0].Address2 + " " + lstSup[0].City;

                lblContact.Text = lstSup[0].Mobile;
                hdnSupliersID.Value = lstSup[0].SupplierID.ToString();
                txtorderdate.Text = lstSup[0].FaxNumber;
                //txtComments.Text = lstSup[0].Phone;
                PONo = lstOrder[0].POUnit;
                hdnPONo.Value = PONo;
                hdnSupplierName.Value = lstSup[0].SupplierName;
                IsRate = lstSup[0].IsRate;

                if (IsRate == true)
                {
                    chkPO_Rate.Checked = true;
                    chkSupplier.Checked = true;
                    chkBasedonQuantity.Checked = false;

                    if (lstOrder.Count > 0)
                    {
                        foreach (InventoryItemsBasket inv in lstOrder)
                        {
                            hdnallproducts.Value += inv.ParentProductID.ToString() + "~" + inv.POUnit + "~" +
                                                   inv.SupplierId + "~" + inv.ProductID + "~" + inv.Quantity + "~" + inv.ProductName + "~" + inv.OrderedQty + "~" + inv.ID + "~" +
                                                   inv.Unit + "^";

                            if (inv.Description != "")
                            {
                                hdnproductlocmap.Value += System.Web.HttpUtility.HtmlDecode(inv.Description) + "^";
                            }

                        }
                        if (hdnproductlocmap.Value != "")
                        {
                            string Location = OrgName;
                            string Department = DepartmentName;
                            string TOrgid = OrgID.ToString();
                            string LocationId = InventoryLocationID.ToString();
                            string ReDeptName = hdnproductlocmap.Value.Replace("LocaltionName", Department);
                            string ReOrgName = ReDeptName.Replace("OrgName", Location);
                            string ReLocationId = ReOrgName.Replace("LID", LocationId);
                            string ReOrgId = ReLocationId.Replace("TOrgID", TOrgid);
                            hdnproductlocmap.Value = ReOrgId;
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadpurchaseorder", "Tblist();", true);
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadpurchaseorderaa", "checkAddToTotal();", true);
                        }
                    }
                }
                else
                {
                    chkBasedonQuantity.Checked = true;
                    chkPO_Rate.Checked = false;
                    chkSupplier.Checked = false;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While to show Purchase Order Details Products.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }

    }
    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("../CentralPurchasing/CentralPurchaseOrder.aspx", true);
    }

    public void LoadSupplierList()
    {
        try
        {
            long returnCode = -1;
            InventoryCommon_BL InventoryBL = new InventoryCommon_BL(base.ContextInfo);
            List<Suppliers> lstSuppliers = new List<Suppliers>();
            returnCode = InventoryBL.GetSupplierList(OrgID, InventoryLocationID, out lstSuppliers);
            DropSupplierName.DataSource = lstSuppliers;
            DropSupplierName.DataTextField = "SupplierName";
            DropSupplierName.DataValueField = "SupplierID";
            DropSupplierName.DataBind();
            
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            DropSupplierName.Items.Insert(0, ddlselect);
            //DropSupplierName.Items.Insert(0, GetMetaData("Select", "0"));
            //end
            DropSupplierName.Items[0].Selected = true;

            ddl_PO_QuantitySupplier.DataSource = lstSuppliers;
            ddl_PO_QuantitySupplier.DataTextField = "SupplierName";
            ddl_PO_QuantitySupplier.DataValueField = "SupplierID";
            ddl_PO_QuantitySupplier.DataBind();
            
           
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddl_PO_QuantitySupplier.Items.Insert(0, ddlselect);
           // ddl_PO_QuantitySupplier.Items.Insert(0, GetMetaData("Select", "0"));
            //end
            ddl_PO_QuantitySupplier.Items[0].Selected = true; 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GetSupplierList", ex);
        }
    }

    protected void BindTaxTypes(List<Taxmaster> lstTaxmaster)
    {
        foreach (Taxmaster Tax in lstTaxmaster)
        {
            switch (Tax.TaxName)
            {
                case "PackingSale":
                    trPackingSale.Style.Add("display", "table-row");
                    lblPackingSale.Text = "Packing Sale(" + Tax.TaxPercent + "%" + ")";
                    txtPackingSale.Attributes.Add("Tax", Tax.TaxPercent.ToString());
                    break;

                case "ExciseDuty":
                    trExciseDuty.Style.Add("display", "table-row");
                    lblExciseDuty.Text = "Excise Duty(" + Tax.TaxPercent + "%" + ")";
                    txtExciseDuty.Attributes.Add("Tax", Tax.TaxPercent.ToString());
                    break;

                case "EduCess":
                    trEduCess.Style.Add("display", "table-row");
                    lblEduCess.Text = "Edu Cess(" + Tax.TaxPercent + "%" + ")";
                    txtEduCess.Attributes.Add("Tax", Tax.TaxPercent.ToString());
                    break;

                case "SecCess":
                    trSecCess.Style.Add("display", "table-row");
                    lblSecCess.Text = "Sec Cess(" + Tax.TaxPercent + "%" + ")";
                    txtSecCess.Attributes.Add("Tax", Tax.TaxPercent.ToString());
                    break;

                case "CST":
                    trCST.Style.Add("display", "table-row");
                    lblCST.Text = "CST(" + Tax.TaxPercent + "%" + ")";
                    txtCST.Attributes.Add("Tax", Tax.TaxPercent.ToString());
                    break;

                default:
                    break;
            }
        }
        trTotal.Style.Add("display", "table-row");
    }


    public void GetStatusID(int StockTypeID, string Status, out int StatusID)
    {
        long returnCode = -1;
        StatusID = 0;
        try
        {
            inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            returnCode = inventoryBL.GetStockStatus(OrgID, LanguageCode, out lstStockStatus, out lstStockType);

            lstStockStatus1 = lstStockStatus.FindAll(P => (P.StockTypeID == StockTypeID) && (P.StockStatusName == Status));
            if (lstStockStatus1.Count == 1)
            {
                StatusID = lstStockStatus1[0].StockStatusID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in GetStatusID", ex);
        }
    }

    protected void btnCancelPO_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID = 0;
            if (Request.QueryString["ID"] != null)
            {
                orderID = Int64.Parse(Request.QueryString["ID"]);
            }
            else {
                orderID = Int64.Parse(hdnPurchaseOrderID.Value);                
            }

            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID, ILocationID);
            if (Request.QueryString["tid"] != null)
            {
                CurrentTaskID = Convert.ToInt64(Request.QueryString["tid"]);
            }
            if (CurrentTaskID > 0)
            {
                new Tasks_BL(base.ContextInfo).UpdateTask(Convert.ToInt64(Request.QueryString["tid"]), TaskHelper.TaskStatus.Deleted, UID);
            }

            //if (Request.QueryString["ACN"] != null)
            //{
            //    string strACN = Request.QueryString["ACN"];
            //    Response.Redirect(@"../Inventory/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSupliersID.Value) + "&ID=" + orderID + "&ACN=" + strACN, true);

            //}
            Response.Redirect(@"../CentralPurchasing/ViewPurchaseOrderMedal.aspx?POID=" + orderID + "&Ismail=Y", true);
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    public void LoadUnit()
    {
        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
        ddlPOUnits.DataSource = lstInventoryUOM;
        ddlPOUnits.DataTextField = "UOMCode";
        ddlPOUnits.DataValueField = "UOMCode";
        ddlPOUnits.DataBind();
        
        ListItem ddlselect = GetMetaData("Select", "0");
        if (ddlselect == null)
        {
            ddlselect = new ListItem() { Text = "Select", Value = "0" };
        }
        ddlPOUnits.Items.Insert(0, ddlselect);
       // ddlPOUnits.Items.Insert(0, GetMetaData("Select", "0"));
        //end
        ddlPOUnits.Items[0].Value = "0";

    }

    public List<InventoryItemsBasket> getPOdetails()
    {

        List<InventoryItemsBasket> iib = new List<InventoryItemsBasket>();
        InventoryItemsBasket obj;
        var sup = hdnProductsupplier.Value.Split('^');
        for (int i = 0; i < sup.Length; i++)
        {
            obj = new InventoryItemsBasket();
            if (sup[i] != "")
            {
                var ps = sup[i].Split('~');
                obj.ID = 0;
                obj.ProductID = Convert.ToInt32(ps[7]);
                //Assumption of expiry date is act as purchase order date..
                obj.CategoryID = Convert.ToInt32(ps[6]); //supplierID
               
                obj.Manufacture = DateTimeNow;
                //end
                obj.ExpiryDate = DateTimeNow; // ps[3].ToInternalDate();
                obj.Quantity = Convert.ToDecimal(ps[4]);
                obj.POUnit = ps[5];
                obj.Providedby = Convert.ToInt64(ps[9]);
                obj.ParentProductID = Convert.ToInt64(ps[10]);
                
                
                obj.Manufacture = Convert.ToDateTime(txtPurchaseOrderDate.Text.ToInternalDate());
                //end
                /* Code End */
                obj.InvoiceQty  = Convert.ToDecimal(ps[12]);
                if (ps[13] != null)
                {
                    obj.Remarks = ps[13];
                }
                obj.Description = ps[14];
                
                obj.InvoiceDate = DateTimeNow;
                //end
                obj.ReceivedOrgID = OrgID;
                obj.ReceivedOrgAddID = InventoryLocationID;
                obj.UnitSellingPrice = 0;
                obj.Tax = 0;
                obj.Discount = 0;
                obj.Rate = 0;
                iib.Add(obj);
            }
        }
        return iib;
    }

}
